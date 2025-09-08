import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LineaTiempo } from './linea-tiempo';

describe('LineaTiempo', () => {
  let component: LineaTiempo;
  let fixture: ComponentFixture<LineaTiempo>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [LineaTiempo]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LineaTiempo);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
