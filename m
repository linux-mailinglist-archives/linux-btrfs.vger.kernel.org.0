Return-Path: <linux-btrfs+bounces-16779-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDE3B514C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 13:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEA35461D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6348F316911;
	Wed, 10 Sep 2025 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg6Y1PKS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE97316900
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502346; cv=none; b=HNh1CiD8Od5HSECtn1pZI/Q6pugk1nDVV38x6LzTuPbB6CWlfwWalGt+9Wi8rleJtbijx9ZEljyAe0QICEkDiSyA6T6dokHHDepLJriWCd/P0DlDXpb/4n1DsYq7+t+15euCNFhJ2mUenaIy0ytXk8SnJGVUEjvkvg4FCkEf5AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502346; c=relaxed/simple;
	bh=C2K6xS8dfCic18xOR7emY5dQiu050CnoW0V9JBlscsU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=PwYlLFHKymQxMJB7LR1pl2Gx2XkG/3PIBog5AzBZ7hnlBKUnHr/157A5A6Wy27sUn4N46Iy5OtEY8Lpp32jZ1l8gBOp7prBLQ9LzRpp8uxckziGN1U2nSji4cXiDXW77e854bhU+O5YPPJQqiOeGJ3igQnMvz065Q8FFHpZBERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zg6Y1PKS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dde353b47so19979795e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 04:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757502343; x=1758107143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2K6xS8dfCic18xOR7emY5dQiu050CnoW0V9JBlscsU=;
        b=Zg6Y1PKSMUtws1sVNqHJBZBQxcFOpu26QbROXwKiqdceb1KgGZFXIPZJnugpGq1vGU
         6yzR9J6DW7+Xz5kQDZdt5HEwFGffSgpjUee79Y71v49rY+8BS1ckikR1z2xHe4jTeewa
         T/h7MOYUzEtYhWc31lWQglVtJKBdC30qJmDZ4lvgD6x/W2FdY8ay9iGSp5GrO5srBTgB
         MeEqWyWF1RZDVBOHwPAtD06yp9oC5bE4RnW2RinCjZ9JDNF8KFQ8C6n5a5YSi8JlSYZG
         /sT0B/hSridqKiVqAbYQI8W5LlcYSHrzg5bdOfsqdvakLLDCGiK4GgsA4OhogZQJERcX
         kYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757502343; x=1758107143;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2K6xS8dfCic18xOR7emY5dQiu050CnoW0V9JBlscsU=;
        b=jdVsY1oCNFhJYwSxVpkW5Jaf8W4+hrNG2Z6hJPbQsjQ4ceXO9zztLcGd0EDjYCGLho
         /w60eEQ0wtavD6uJpasMi9RT4uWjbRweujdMlTFtAgMLw6NMnLgecFm+eLRJZPsKMyI/
         hXZf91GTbl/g71xFNulQkw1GueU+WxXMWyIxbEv26+A00M2x7VY0kmKqFP8MUjMWmsyY
         UxfoV5eAPoVT8Jcl1gqIW1EBYIE8IJ4oWn3bBajBV6ADFKyujkFu67170cGiMBo5Cz55
         15TuHh6lwP6KevOVuOHmWlh+VC7+/DaOiMVJJtLRexWtPHAHJLctfSPJtRlfTLRqOAJs
         IUQA==
X-Gm-Message-State: AOJu0YzZBEzMvB7A3/4dRVNRj7CtTr14cp/1gVMV0qrXEaVeKaoPzZOS
	3FSk6FI5Cn7Ntv7Lyvz/WOz1EYOkauWIbCMiEEDbG81Pdq0/qeGoiQomARU+uMw=
X-Gm-Gg: ASbGncu65AVCTs1/7fbPJ/I3wIYLkdaSdfA1s7QzM7YGESubp1CXLAqKbcyRn5SajXb
	x+WzIC1MkKil404PWxmo2/tyNA4OxKvjPY3ya67rex5iy/9kzKQk121JhYb/1AnaUoFGSQHRP9z
	nGntLDt7v1pKZB1J/+ioIrwV7f7D1P39Aukt+eoQsB/r47I2BpnoqZNeqQkEZyyaXRJta4aGsm2
	imk59KhRvktA+PwwjVtkGFfoBDKfcfUVnGYN0dLraOQSQjrAzgvrojhkScXBfQIwYy3BDLv5gHK
	e0+YfaPbL429QImk8yVLR2XihYYX5ZAjC8IjxBkB+823XJuL5hWsVb1hotneQTUIOWNhoHtYxO5
	cr1Fz4qdy7FmxNIho1spPCu36Lgk5mE23d4FviQNHNsKkDhTUcDSCoQOeTVpTW7EyM6NFCg==
X-Google-Smtp-Source: AGHT+IGMt6EaiPAheg73zcURqJjLOoFd9zzzlE6T/M33iI9RlFcYN0J6h3nYF3Nh6vn09kEDrPleug==
X-Received: by 2002:a05:600c:c177:b0:45b:71ac:b45a with SMTP id 5b1f17b1804b1-45ddde92f00mr144521005e9.11.1757502343286;
        Wed, 10 Sep 2025 04:05:43 -0700 (PDT)
Received: from [192.168.2.5] (ppp046176100065.access.hol.gr. [46.176.100.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223898csm6800092f8f.39.2025.09.10.04.05.42
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:05:42 -0700 (PDT)
Message-ID: <c7807695-6e0c-4c97-ba1c-447c6d117a4a@gmail.com>
Date: Wed, 10 Sep 2025 06:04:03 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: improvements and safety on btrfs repairs
From: Elias Tsolis <estatisticseu@gmail.com>
To: linux-btrfs@vger.kernel.org
References: <CAN7+exx=v9mkCGiA5xyrLP8DbCsZb39SDa4XcXx0nxfYtLxa5w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAN7+exx=v9mkCGiA5xyrLP8DbCsZb39SDa4XcXx0nxfYtLxa5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

U29ycnkgaWYgeW91IGhhdmUgcmVjZWl2ZWQgbXVsdGlwbGUgZW1haWxzLiBOZXdiaWUgaGVy
ZS4NCj4gSGkgQnRyZnMgZGV2ZWxvcGVycywNCj4gSeKAmWQgbGlrZSB0byBwcm9wb3NlIGEg
bmV3IHRvb2wgZm9yIG9mZmxpbmUsIG5vbi1kZXN0cnVjdGl2ZSBtZXRhZGF0YSByZXBhaXIu
DQo+DQo+IFByb2JsZW06DQo+IEN1cnJlbnRseSwgYnRyZnMgY2hlY2sgLS1yZXBhaXIgbW9k
aWZpZXMgbWV0YWRhdGEgaW4gcGxhY2UsIHdoaWNoIGNhbg0KPiBpcnJldmVyc2libHkgZGVz
dHJveSBkYXRhIGlmIHJlcGFpcnMgYXJlIGluY29ycmVjdC4gVGhlcmUgaXMgbm8gbmF0aXZl
DQo+IHdheSB0byBzaW11bGF0ZSByZXBhaXJzIHNhZmVseS4NCj4NCj4gUHJvcG9zZWQgc29s
dXRpb246DQo+IEV4dHJhY3QgYWxsIG1ldGFkYXRhIChyb290IHRyZWUsIGlub2RlIHRyZWUs
IGV4dGVudCB0cmVlKSB0byBtZW1vcnkgb3INCj4gYSBzZXBhcmF0ZSBmaWxlL2ltYWdlIC0g
T05MWSBUSEUgTUVUQURBVEEuDQo+IFBlcmZvcm0gcmVwYWlycyBvZmZsaW5lLCByZWNhbGN1
bGF0aW5nIGNoZWNrc3VtcyBhbmQgcmVidWlsZGluZyB0cmVlcw0KPiBpbiBtZW1vcnkgb3Ig
aW4gdGhlIHNhdmVkIHNlcGFyYXRlIG1ldGFkYXRhIGZpbGUuDQo+IFByb3ZpZGUgYSBzaW11
bGF0ZWQgbW91bnQgZm9yIHZlcmlmaWNhdGlvbiBiZWZvcmUgY29tbWl0dGluZyB0byB0aGUN
Cj4gYWN0dWFsIGZpbGVzeXN0ZW0uDQo+IE9ubHkgYWZ0ZXIgdmFsaWRhdGlvbiwgY29tbWl0
IHRoZSByZXBhaXJlZCBtZXRhZGF0YSBzYWZlbHkgdG8gZGlzay4NCj4NCj4gQmVuZWZpdHM6
DQo+IFplcm8gcmlzayB0byBvcmlnaW5hbCBkYXRhIHVudGlsIHJlcGFpciBpcyB2ZXJpZmll
ZC4NCj4gU2FmZXIgcmVjb3Zlcnkgd29ya2Zsb3cgZm9yIGRhbWFnZWQgZmlsZXN5c3RlbXMu
DQo+IEVhc2llciB0ZXN0aW5nIGFuZCB2YWxpZGF0aW9uIGZvciBwcm9mZXNzaW9uYWxzLg0K
Pg0KPiBUaGlzIGFwcHJvYWNoIHdvdWxkIGJyaW5nIEJ0cmZzIHJlY292ZXJ5IGNsb3NlciB0
byBhIHNhZmUsDQo+IGVudGVycHJpc2UtZ3JhZGUgd29ya2Zsb3cgc2ltaWxhciB0byBaRlMg
b2ZmbGluZSByZXBhaXIuDQo+DQo+IHByYWN0aWNhbCBleGFtcGxlOg0KPiBidHJmcyBzeXN0
ZW0gZXhpc3RzIGluIC9kZXYvc2RhDQo+IGNwIGJ0cmZzX21ldGFkYXRhIChvZiAvZGV2L3Nk
YSkgdG8gL21udC9mb2xkZXJBL2J0cmZzX21ldGFkYXRhLmluZm8NCj4gcmVwYWlyIGJ0cmZz
X21ldGFkYXRhIG9mIC9tbnQvZm9sZGVyQS9idHJmc19tZXRhZGF0YS5pbmZvID4NCj4gL21u
dC9mb2xkZXJBL2J0cmZzX21ldGFkYXRhLnJlcGFpcmVkDQo+IG1vdW50ICAvZGV2L3NkYSB3
aXRoIGJ0cmZzX21ldGFkYXRhLnJlcGFpcmVkIGluIHJlYWQtb25seSBtb2RlLg0KPiBVU0VS
IGNoZWNrIGRhdGEgaWYgdGhleSBsb29rcyBsaWtlLCB0aGVuDQo+IGNwIGJ0cmZzX21ldGFk
YXRhLnJlcGFpcmVkIHRvIC9kZXYvc2RhKHVubW91bnRlZCkNCj4NCj4NCj4gYXBwcmVjaWF0
ZWQgYWRkb24gLSBhIHRvb2wgZm9yIGFnZ3Jlc3NpdmVseSByZWFkaW5nIGJhZCBzZWN0b3Jz
IG9mDQo+IGRhdGEgaW4gb3JkZXIgdG8gcmVzdG9yZSBkYXRhLg0KPg0KPiBUaGFua3MgZm9y
IGNvbnNpZGVyaW5nLA0KPiBFbGlhcw0K

