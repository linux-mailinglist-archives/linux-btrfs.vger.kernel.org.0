Return-Path: <linux-btrfs+bounces-1200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9441F822A62
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jan 2024 10:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABC5284715
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jan 2024 09:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647018634;
	Wed,  3 Jan 2024 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RSMs1Wg3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382B418623
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jan 2024 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-50e835800adso6301024e87.0
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jan 2024 01:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704275134; x=1704879934; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MqeQRKRlwwgm5o3Y76bkQI6Z/0LZSifghsGkYglixzI=;
        b=RSMs1Wg3e9YQDXnIA1DLcA/9kwLXnuqDpQot4sYzLAgcnjqQ7Z0qc4z4W+HCvikIuj
         rcHDxDGjbyac3ITGBVblody7QuhMXAyjRVI3vJ2tk4qbZWMqwCQw347nugYHCo6CIXMA
         WQCUnn9rLf2ZuiYWaylL+y5qP1rZGp5AuGZRNKYY/lDJblTpoX2DEduot7XrHIe/S+wx
         s7q5UcqQDw4NhSJ2Cif4MGHGZrfIyD5PS9OQIpg59WFVRorEWSk4EuorCxO6Fh1sl6Vd
         N9eF1DBDfYQBN2eg5pi5ql2EkBqFEEvMFpdgbVKDmvq7NGHVqX+dkYCT2o6q10jGiWTX
         e3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275134; x=1704879934;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqeQRKRlwwgm5o3Y76bkQI6Z/0LZSifghsGkYglixzI=;
        b=B2kNCLykTdSdgk6MQ7klfP8CuKuhOoEFZ3IWkouw0Uz1Yz7kLbcz3Y6FhU8XFlwaI1
         qFcBwE5p7lIFcwN5D0YpTGqMsj/9mH7RX6xsqIATnDLnQmJS62ZwLEnDnoEbm8fV5Jn9
         7VLbJfT7EsrKSbmqsdOjvBZ9Lav58I6fkdKPiB5xqxrqpU1mvTK76WYueM+K/ZD3F5zI
         uNjN1O1v1qoapS6DZHqLFj/T7JkiW2MUmR3kawBj4QDWC+wC+CM3Q+4yddJFUfiztvRq
         g3tgwbxZSOdkkhgmj2idiwVRf00qP8n5B7B3uA1ZannV2gjrtyYgXxuwaYb1v95QZ+u8
         nYug==
X-Gm-Message-State: AOJu0Yy+f6zXt0Sf8MaKjBqk8vKiM7jYHnM6nDXsKw/NXc9IDyuUjmoM
	9vM3ZMB5ghaUt+b6T316aJ32Teiu9G9uVw==
X-Google-Smtp-Source: AGHT+IHHJ4CQAdT4dls/HB8dpcXPGR5k/bFLRVhcmN2Gg2Gv3ASZiWo3Nd+yLQiitEG8hs9olU3DBw==
X-Received: by 2002:a05:6512:b9d:b0:50e:7e18:9932 with SMTP id b29-20020a0565120b9d00b0050e7e189932mr4618573lfv.2.1704275134142;
        Wed, 03 Jan 2024 01:45:34 -0800 (PST)
Received: from ?IPV6:2001:4479:aa02:8c00::959? ([2001:4479:aa02:8c00::959])
        by smtp.gmail.com with ESMTPSA id io17-20020a17090312d100b001d4c316e3e0sm3390759plb.113.2024.01.03.01.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 01:45:33 -0800 (PST)
Message-ID: <a13d0f90-58bd-45cb-bf4e-880880f54a32@suse.com>
Date: Wed, 3 Jan 2024 20:15:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] kstrtox: add unit tests for memparse_safe()
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@aculab.com, ddiss@suse.de
References: <cover.1704168510.git.wqu@suse.com>
 <a56def269d7885840a19a57aca0169891f5f0f32.1704168510.git.wqu@suse.com>
 <CAMuHMdWXRid2hyvMLcQ6f+M1fxBZUPdeSN=3e=-xXNSce4gsJg@mail.gmail.com>
 <756ac3e8-3d68-40fe-a7d4-1cf6ac77185e@gmx.com>
 <CAMuHMdVNZPm0jdqD0EdahiTc8PJYQ+OVvBxKagQx_je-GTmJ2w@mail.gmail.com>
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <CAMuHMdVNZPm0jdqD0EdahiTc8PJYQ+OVvBxKagQx_je-GTmJ2w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IDusIzsvrb2PFt3KoZZWlWAs"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------IDusIzsvrb2PFt3KoZZWlWAs
Content-Type: multipart/mixed; boundary="------------4A7HHPjVmEdIqMakiD2CSxsO";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@aculab.com, ddiss@suse.de
Message-ID: <a13d0f90-58bd-45cb-bf4e-880880f54a32@suse.com>
Subject: Re: [PATCH v2 3/4] kstrtox: add unit tests for memparse_safe()
References: <cover.1704168510.git.wqu@suse.com>
 <a56def269d7885840a19a57aca0169891f5f0f32.1704168510.git.wqu@suse.com>
 <CAMuHMdWXRid2hyvMLcQ6f+M1fxBZUPdeSN=3e=-xXNSce4gsJg@mail.gmail.com>
 <756ac3e8-3d68-40fe-a7d4-1cf6ac77185e@gmx.com>
 <CAMuHMdVNZPm0jdqD0EdahiTc8PJYQ+OVvBxKagQx_je-GTmJ2w@mail.gmail.com>
In-Reply-To: <CAMuHMdVNZPm0jdqD0EdahiTc8PJYQ+OVvBxKagQx_je-GTmJ2w@mail.gmail.com>

--------------4A7HHPjVmEdIqMakiD2CSxsO
Content-Type: multipart/mixed; boundary="------------k3yOmo0ZdnmNUVbv51Jl4rcU"

--------------k3yOmo0ZdnmNUVbv51Jl4rcU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjQvMS8zIDE5OjU3LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+IEhp
IFF1LA0KPiANCj4gT24gVHVlLCBKYW4gMiwgMjAyNCBhdCA5OjU24oCvUE0gUXUgV2VucnVv
IDxxdXdlbnJ1by5idHJmc0BnbXguY29tPiB3cm90ZToNCj4+IE9uIDIwMjQvMS8yIDIzOjUz
LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+Pj4gT24gVHVlLCBKYW4gMiwgMjAyNCBh
dCA1OjEz4oCvQU0gUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+IHdyb3RlOg0KPj4+PiBUaGUg
bmV3IHRlc3RzIGNhc2VzIGZvciBtZW1wYXJzZV9zYWZlKCkgaW5jbHVkZToNCj4+Pj4NCj4+
Pj4gLSBUaGUgZXhpc3RpbmcgdGVzdCBjYXNlcyBmb3Iga3N0cnRvdWxsKCkNCj4+Pj4gICAg
IEluY2x1ZGluZyBhbGwgdGhlIDMgYmFzZXMgKDgsIDEwLCAxNiksIGFuZCBhbGwgdGhlIG9r
IGFuZCBmYWlsdXJlDQo+Pj4+ICAgICBjYXNlcy4NCj4+Pj4gICAgIEFsdGhvdWdoIHRoZXJl
IGFyZSBzb21ldGhpbmcgd2UgbmVlZCB0byB2ZXJpZnkgc3BlY2lmaWMgZm9yDQo+Pj4+ICAg
ICBtZW1wYXJzZV9zYWZlKCk6DQo+Pj4+DQo+Pj4+ICAgICAqIEByZXRwdHIgYW5kIEB2YWx1
ZSBhcmUgbm90IG1vZGlmaWVkIGZvciBmYWlsdXJlIGNhc2VzDQo+Pj4+DQo+Pj4+ICAgICAq
IHJldHVybiB2YWx1ZSBhcmUgY29ycmVjdCBmb3IgZmFpbHVyZSBjYXNlcw0KPj4+Pg0KPj4+
PiAgICAgKiBAcmV0cHRyIGlzIGNvcnJlY3QgZm9yIHRoZSBnb29kIGNhc2VzDQo+Pj4+DQo+
Pj4+IC0gTmV3IHRlc3QgY2FzZXMNCj4+Pj4gICAgIE5vdCBvbmx5IHRlc3RpbmcgdGhlIHJl
c3VsdCB2YWx1ZSwgYnV0IGFsc28gdGhlIEByZXRwdHIsIGluY2x1ZGluZzoNCj4+Pj4NCj4+
Pj4gICAgICogZ29vZCBjYXNlcyB3aXRoIGV4dHJhIHRhaWxpbmcgY2hhcnMsIGJ1dCB3aXRo
b3V0IHZhbGlkIHByZWZpeA0KPj4+PiAgICAgICBUaGUgQHJldHB0ciBzaG91bGQgcG9pbnQg
dG8gdGhlIGZpcnN0IGNoYXIgYWZ0ZXIgYSB2YWxpZCBzdHJpbmcuDQo+Pj4+ICAgICAgIDMg
Y2FzZXMgZm9yIGFsbCB0aGUgMyBiYXNlcy4NCj4+Pj4NCj4+Pj4gICAgICogZ29vZCBjYXNl
cyB3aXRoIGV4dHJhIHRhaWxpbmcgY2hhcnMsIHdpdGggdmFsaWQgcHJlZml4DQo+Pj4+ICAg
ICAgIDUgY2FzZXMgZm9yIGFsbCB0aGUgc3VmZml4ZXMuDQo+Pj4+DQo+Pj4+ICAgICAqIGJh
ZCBjYXNlcyB3aXRob3V0IGFueSBudW1iZXIgYnV0IHN0cmF5IHN1ZmZpeA0KPj4+PiAgICAg
ICBTaG91bGQgYmUgcmVqZWN0ZWQgd2l0aCAtRUlOVkFMDQo+Pj4+DQo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0KPj4+DQo+Pj4gVGhhbmtzIGZvciB5
b3VyIHBhdGNoIQ0KPj4+DQo+Pj4+IC0tLSBhL2xpYi90ZXN0LWtzdHJ0b3guYw0KPj4+PiAr
KysgYi9saWIvdGVzdC1rc3RydG94LmMNCj4+Pj4gQEAgLTI2OCw2ICsyNjgsMjM3IEBAIHN0
YXRpYyB2b2lkIF9faW5pdCB0ZXN0X2tzdHJ0b2xsX29rKHZvaWQpDQo+Pj4+ICAgICAgICAg
ICBURVNUX09LKGtzdHJ0b2xsLCBsb25nIGxvbmcsICIlbGxkIiwgdGVzdF9sbF9vayk7DQo+
Pj4+ICAgIH0NCj4+Pj4NCj4+Pj4gKy8qDQo+Pj4+ICsgKiBUaGUgc3BlY2lhbCBwYXR0ZXJu
IHRvIG1ha2Ugc3VyZSB0aGUgcmVzdWx0IGlzIG5vdCBtb2RpZmllZCBmb3IgZXJyb3IgY2Fz
ZXMuDQo+Pj4+ICsgKi8NCj4+Pj4gKyNkZWZpbmUgVUxMX1BBVFRFUk4gICAgICAgICAgICAo
MHhlZmVmZWZlZjdhN2E3YTdhVUxMKQ0KPj4+PiArI2lmIEJJVFNfUEVSX0xPTkcgPT0gMzIN
Cj4+Pj4gKyNkZWZpbmUgUE9JTlRFUl9QQVRURVJOICAgICAgICAgICAgICAgICgweGVmZWY3
YTdhN2FVTCkNCj4+Pg0KPj4+IFRoaXMgcGF0dGVybiBuZWVkcyA0MCBiaXRzIHRvIGZpdCwg
c28gaXQgZG9lc24ndCBmaXQgaW4gYSAzMi1iaXQNCj4+PiB1bnNpZ25lZCBsb25nIG9yIHBv
aW50ZXIuICBQcm9iYWJseSB5b3Ugd2FudGVkIHRvIHVzZSAweGVmN2E3YTdhVUwNCj4+PiBp
bnN0ZWFkPw0KPj4NCj4+IE15IGJhZCwgb25lIGV4dHJhIGJ5dGUuLi4NCj4gDQo+IFNvIGRp
ZCB0aGF0IGZpeCB0aGUgc3BhcnNlIHdhcm5pbmc/IDstKQ0KDQpJbnRlbCBndXlzIGhhdmUg
YWxyZWFkeSBtYXNrZWQgdGhpcyBwYXJ0aWN1bGFyIHdhcm5pbmcuDQoNCkJ1dCB5b3VyIG5l
d2VyIHN1Z2dlc3Rpb24gaXMgbXVjaCBiZXR0ZXIuDQoNCj4gDQo+Pj4+ICsjZWxzZQ0KPj4+
PiArI2RlZmluZSBQT0lOVEVSX1BBVFRFUk4gICAgICAgICAgICAgICAgKFVMTF9QQVRURVJO
KQ0KPj4+PiArI2VuZGlmDQo+Pj4NCj4+PiBTaG91bGRuJ3QgYSBzaW1wbGUgY2FzdCB0byB1
aW50cHRyX3Qgd29yayBmaW5lIGZvciBib3RoIDMyLWJpdCBhbmQNCj4+PiA2NC1iaXQgc3lz
dGVtczoNCj4+Pg0KPj4+ICAgICAgICNkZWZpbmUgUE9JTlRFUl9QQVRURVJOICAoKHVpbnRw
dHJfdClVTExfUEFUVEVSTikNCj4+Pg0KPj4+IE9yIGV2ZW4gYmV0dGVyLCBpbmNvcnBvcmF0
ZSB0aGUgY2FzdCB0byBhIHBvaW50ZXI6DQo+Pj4NCj4+PiAgICAgICAjZGVmaW5lIFBPSU5U
RVJfUEFUVEVSTiAgKCh2b2lkICopKHVpbnRwdHJfdClVTExfUEFUVEVSTikNCj4+DQo+PiBU
aGUgcHJvYmxlbSBpcyByZXBvcnRlZCBieSBzcGFyc2UsIHdoaWNoIHdhcm5zIGFib3V0IHRo
YXQgVUxMX1BBVFRFUk4NCj4+IGNvbnZlcnRlZCB0byBhIHBvaW50ZXIgd291bGQgbG9zZSBp
dHMgd2lkdGg6DQo+Pg0KPj4gbGliL3Rlc3Qta3N0cnRveC5jOjMzOTo0MDogc3BhcnNlOiBz
cGFyc2U6IGNhc3QgdHJ1bmNhdGVzIGJpdHMgZnJvbQ0KPj4gY29uc3RhbnQgdmFsdWUgKGVm
ZWZlZmVmN2E3YTdhN2EgYmVjb21lcyA3YTdhN2E3YSkNCj4gDQo+IEFoIHllcywgc3BhcnNl
IGNhbiBiZSBhbm5veWluZy4NCj4gSSdtIHN0aWxsIGxvb2tpbmcgZm9yIGEgY2xlYW4gYW5k
IGNvbmNpc2Ugd2F5IHRvIHNodXQgdXAgWzFdLg0KPiANCj4+IEknbSBub3Qgc3VyZSBpZiB1
c2luZyB1aWludHB0cl90IHdvdWxkIHNvbHZlIGl0LCB0aHVzIEkgZ28gdGhlIG1hY3JvIHRv
DQo+PiBzd2l0Y2ggdGhlIHZhbHVlIHRvIGF2b2lkIHRoZSBzdGF0aWMgY2hlY2tlcidzIHdh
cm5pbmcuDQo+Pg0KPj4gSSB0cmllZCB0byBjaGVjayBob3cgb3RoZXIgbG9jYXRpb25zIGhh
bmRsZXMgcGF0dGVybmVkIHBvaW50ZXIgdmFsdWUsDQo+PiBsaWtlIENPTkZJR19JTklUX1NU
QUNLX0FMTF9QQVRURVJOLCBidXQgdGhleSdyZSBlaXRoZXIgcmVseWluZyBvbiB0aGUNCj4+
IGNvbXBpbGVyIG9yIGp1c3QgbWVtc2V0KCkuDQo+Pg0KPj4gQW55IGJldHRlciBpZGVhIHRv
IHNvbHZlIHRoZSBwcm9ibGVtIGluIGEgYmV0dGVyIHdheT8NCj4gDQo+IE1hc2tpbmcgb2Zm
IHRoZSBleHRyYSBiaXRzLCBsaWtlIGxvd2VyXzMyX2JpdHMoKVsyXSBkb2VzPw0KPiANCj4g
ICAgICAjZGVmaW5lIFBPSU5URVJfUEFUVEVSTiAgKCh2b2lkICopKHVpbnRwdHJfdCkoKFVM
TF9QQVRURVJOKSAmIFVJTlRQVFJfTUFYKSkNCg0KVGhpcyBzb3VuZHMgbXVjaCBiZXR0ZXIg
dG8gbWUuDQoNCkkgd291bGQgZ28gdGhpcyBwYXRoIGluc3RlYWQsIGFuZCBmaW5hbGx5IG5v
IG5lZWQgdG8gbWFudWFsbHkgY291bnQgaG93IA0KbWFueSBieXRlcyAod2hpY2ggSSBhbHJl
YWR5IGZhaWxlZCBvbmNlKS4NCg0KVGhhbmtzLA0KUXUNCg0KPiANCj4gWzFdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyMzEyMTgxNjQ5LnU2azZoTEltLWxr
cEBpbnRlbC5jb20vDQo+IFsyXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9s
YXRlc3Qvc291cmNlL2luY2x1ZGUvbGludXgva2VybmVsLmgjTDgyDQo+IA0KPiBHcntvZXRq
ZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiAN
Cg==
--------------k3yOmo0ZdnmNUVbv51Jl4rcU
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------k3yOmo0ZdnmNUVbv51Jl4rcU--

--------------4A7HHPjVmEdIqMakiD2CSxsO--

--------------IDusIzsvrb2PFt3KoZZWlWAs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmWVLLcFAwAAAAAACgkQwj2R86El/qgY
vwgAiTPlE5N8oW89lBm/asyXmQgdxA3u48o7H08bXxrkxs0LlZpHFbVjessHzl1rnuAH9+GZwa3O
5eeErsHz2IRqIyrABaZS+yTmHktwCJTPVlwPCBu/PI4V4KNz4oFAKOC2HywBOo0kETXkwTZrvyPK
IfAJ99vdxFH0UEUSakQx3f0F+jEN/wo/GcnFxl4Lemm1POmr9NzgyXf9cqv8fVrGFkxQ3SBzR0P0
ow5LutoCM1G0JxKkAFmxaOtQ5rXoq5EnKc5aNlFPW2Ei6J2Couke8GJ80HGR+Bu6HLVjFm/tef+o
zafWjBxiL3U5g7b5sII7g1WxcauR2eCOnNagaJR/RQ==
=51aD
-----END PGP SIGNATURE-----

--------------IDusIzsvrb2PFt3KoZZWlWAs--

