Return-Path: <linux-btrfs+bounces-1832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B610483E418
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 22:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1162876A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 21:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3853F2556C;
	Fri, 26 Jan 2024 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SeCaOxF9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7D2555E
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305191; cv=none; b=TEA450t+b5Sk46Mb6kTgCIJsI+hdfA0aVLKzRewzaOSA5mbtZ/duaKQce3rjW+rmGa04ETqsTBsqGV4hE8iDtwJCuPubjVrtYpqFZ7IxJ7ZViy+husmhshNILiJMDnCIl0QZ3fTJMV1hlPo2HiAQI17a5Z8WCLK4socnNzCsMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305191; c=relaxed/simple;
	bh=yIshLPTzFibkERW5+wm6G4F6fiwivNSQ2X7APHpQQJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TcpQPZng80C4o63b9wj1yr8/dxYGZ127f6xSXx7QNW/xpasY6tZGhq90eYSdCrGdgSZBJBzi+JXBE5TZvqBXg2Xxc+H6WZZJ9QGn3uaC4SXvL2qE+04g3CwfEQu4j7SYS3ea1sRPHSyKab4YbwwKPLQc5SY2LubyWvT4yDbRx58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SeCaOxF9; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf161b5eadso8647661fa.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 13:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706305186; x=1706909986; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yIshLPTzFibkERW5+wm6G4F6fiwivNSQ2X7APHpQQJY=;
        b=SeCaOxF9LAq4Nb4jFxncNBTh3eLlgcCh8ETRUkRC8z8nxB1Sa7EKITz9B58vwOUj8/
         jYXgsiQTx1sKZzBcdl/N5yDt4sB6jBZBV/j/+2sQxzcRoGWjt+AnNHT+nuywcAaJvWlg
         Zd0UosrvRrVnEOhOvVKXufrkS/FhSoOFu+JgnHzIK2VtEOVKRfPnWw9sPfbgdqbJChAB
         QXyJxY5OLNngG1FqNtglomNPf4lOsmDeXL77LWG/vwGFMHfiPVRWiSex2Gw1OWmh0IPJ
         q+uECHiDHW3Uc3N3qd5sgtDC3jyARqDr1GMt4iJ28ipQDx6ApqWyVeNroNZCDSBq6Mr/
         MRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305186; x=1706909986;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yIshLPTzFibkERW5+wm6G4F6fiwivNSQ2X7APHpQQJY=;
        b=AVXzfOp0eRC7E82m7JBGRJJMqn1QTSFw/5XuwL5vjcGHMhQOtycyrTpRTcqYb4CRQX
         WcChLAKAWGnV6bqxgp38M0Bn9c+DJD2KyJ0d6LCUDPvsXBj2MNCqOxtCn6hXFfxy3FDo
         qUgqODsKPTLhDJFVHkVgvgUW4qTkqLAcF/HzkicR6rKkBqC495+6BhuU0Eqfwa84Kbhz
         BVO1JfmLbuUZTt4DA9yddo4mYy0XrSPRCCKtxohQwAHi1dJexAejEiroWHYa5HtN96ap
         r/fxhEDssocXdP2/p727eM0E2dQZ8dgTqLEZ0b2x+AXhgjJ44upgcyHCw2XLXpUflrQI
         ypuw==
X-Gm-Message-State: AOJu0Yz3x5tiHEaXLm2yxqRo94g7w7GkiDQlM/Qi5vx4eMQTikchV8H/
	8h1LAAm5PxGy2Owh2CdTKCLtQ9shH9/feIeL0bB/Au0cR5KIjS4um9rHRKxBKvc=
X-Google-Smtp-Source: AGHT+IHKrX6kaGymEk3l5chLhE0QFbp/Aja/samJ3nJmS/VtspQzCIIyAH+A8hdqlJA3GwTLhZOh9g==
X-Received: by 2002:a05:651c:4ca:b0:2cf:124b:8a26 with SMTP id e10-20020a05651c04ca00b002cf124b8a26mr590571lji.42.1706305186029;
        Fri, 26 Jan 2024 13:39:46 -0800 (PST)
Received: from ?IPV6:2403:580d:bef6::959? (2403-580d-bef6--959.ip6.aussiebb.net. [2403:580d:bef6::959])
        by smtp.gmail.com with ESMTPSA id j8-20020a056a00234800b006d6b91c6eb6sm1599091pfj.13.2024.01.26.13.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:39:45 -0800 (PST)
Message-ID: <8b2c6d1f-2e14-43a0-b48a-512a3d4a811d@suse.com>
Date: Sat, 27 Jan 2024 08:09:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
Content-Language: en-US
To: dsterba@suse.cz, Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1705946889.git.dsterba@suse.com>
 <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
 <20240126200008.GT31555@twin.jikos.cz>
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
In-Reply-To: <20240126200008.GT31555@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yR74XjTc2jHXFkrfuIZ2bRkm"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yR74XjTc2jHXFkrfuIZ2bRkm
Content-Type: multipart/mixed; boundary="------------vGm8OBupbJpZepUnMffk10XI";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: dsterba@suse.cz, Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <8b2c6d1f-2e14-43a0-b48a-512a3d4a811d@suse.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
References: <cover.1705946889.git.dsterba@suse.com>
 <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
 <20240126200008.GT31555@twin.jikos.cz>
In-Reply-To: <20240126200008.GT31555@twin.jikos.cz>

--------------vGm8OBupbJpZepUnMffk10XI
Content-Type: multipart/mixed; boundary="------------jo3wCQWDJmFRbkftPh5ZBfYf"

--------------jo3wCQWDJmFRbkftPh5ZBfYf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjQvMS8yNyAwNjozMCwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPiBPbiBGcmks
IEphbiAyNiwgMjAyNCBhdCAxMToyNToxOUFNIC0wODAwLCBMaW51cyBUb3J2YWxkcyB3cm90
ZToNCj4+IE9uIE1vbiwgMjIgSmFuIDIwMjQgYXQgMTA6MzQsIERhdmlkIFN0ZXJiYSA8ZHN0
ZXJiYUBzdXNlLmNvbT4gd3JvdGU6DQo+Pj4NCj4+PiAgICBnaXQ6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQva2RhdmUvbGludXguZ2l0IHRhZ3MvZm9yLTYu
OC1yYzEtdGFnDQo+Pg0KPj4gSSBoYXZlIG5vIGlkZWEgaWYgdGhpcyBpcyByZWxhdGVkIHRv
IHRoZSBuZXcgZml4ZXMsIGJ1dCBJIGhhdmUgbmV2ZXINCj4+IHNlZW4gaXQgYmVmb3JlOg0K
Pj4NCj4+ICAgIEJUUkZTIGNyaXRpY2FsIChkZXZpY2UgZG0tMCk6IGNvcnJ1cHRlZCBub2Rl
LCByb290PTI1Ng0KPj4gYmxvY2s9ODU1MDk1NDQ1NTY4MjQwNTEzOSBvd25lciBtaXNtYXRj
aCwgaGF2ZSAxMTg1ODIwNTU2NzY0MjI5NDM1Ng0KPj4gZXhwZWN0IFsyNTYsIDE4NDQ2NzQ0
MDczNzA5NTUxMzYwXQ0KPiANCj4gV2hpY2sgY2hlY2s6IHRoZSBudW1iZXJzIGRvbid0IG1h
dGNoIGNvbnN0YWludHMsIGJsb2NrcyBtdXN0IGJlIDQwOTYNCj4gYWxpZ25lZA0KPiANCj4g
aGV4KDg1NTA5NTQ0NTU2ODI0MDUxMzkpID0gMHg3NmFiMTdjNWM1N2U1MzEzDQo+ICh3b3Vs
ZCBoYXZlIHRvIGVuZCB3aXRoIDMgemVyb3MpDQoNCk9oLCBJIGZvcmdvdCB0aGUgbW9zdCBv
YnZpb3VzIHByb2JsZW0uDQoNClRoaXMgbWVhbnMgdGhlIGV4dGVudCBidWZmZXIgaXMgZnVs
bCBvZiBnYXJiYWdlLg0KDQpBbmQgdGhpcyBpcyBtZWFucyB0aGUgY29udGVudCBvZiB0aGUg
ZWIgZ290IHNvbWUgc3VkZGVuIGNoYW5nZS4NCkFzIGR1cmluZyBleHRlbnQgYnVmZmVyIHJl
YWQsIHdlIGhhdmUgYSB2ZXJ5IGJhc2ljIGViIGJ5dGVuciBjaGVjayANCmFnYWluc3QgdGhl
IGViIHJlYWQgZnJvbSBkaXNrLg0KDQpTbyBpdCBtZWFucyBhdCB0aGF0IHBvaW50LCBhdCBs
ZWFzdCB3ZSBnb3Qgc29tZXRoaW5nIGNvcnJlY3QsIGFuZCBjYW4gDQpldmVuIHBhc3MgY3N1
bSBjaGVja3MuDQoNCkJ1dCBsYXRlciBvbmUsIHRoZSBwYWdlcyBvZiB0aGUgZWIgZ290IGNv
cnJ1cHRlZCBhbmQgd2UgZ290IGdhcmJhcmdlLg0KDQooQUtBLCBteSBwcmV2aW91cyBhbmFs
eXNlIGlzIHRvdGFsbHkgd3JvbmcsIGJ1dCBpdCBtYXkgc3RpbGwgaW5zcGlyZSBtZSANCnRv
IGFkZCBleHRyYSBjaGVjayBvbiBlYl9vd25lciB0byByZWplY3QgaGlnaGVyIGxldmVsIHFn
cm91cCBzdWJ2b2x1bWVzKQ0KDQoNCldoYXQncyB0aGUgcGFnZSBzaXplIG9mIHRoZSBzeXN0
ZW0/IDRLIG9yIDE2SyBvciA2NEs/DQoNCkZvciB0aGUgZmlyc3QgMiwgdGhlIGViIGhhbmRs
aW5nIHdvdWxkIGdvIHRoZSByZWd1bGFyIHBhdGggYXMgNEsgcGFnZSANCnNpemVkIHN5c3Rl
bXMgKGFzIDE2SyBpcyB0aGUgZGVmYXVsdCBub2Rlc2l6ZSwgbm9kZXNpemUgPj0gUEFHRV9T
SVpFIA0Kd291bGQgc2hhcmUgdGhlIHNhbWUgcGFnZSBiYXNlZCBlYiBoYW5kbGluZykuDQoN
CkZvciA2NEssIGl0IHdvdWxkIGdvIGZ1bGwgc3VicGFnZSwgYnV0IEkgZG91YnQgaXQsIGFz
IHRoZSBBcHBsZSBNIHNlcmllcyANCkNQVXMgZG8gbm90IHNlZW0gdG8gc3VwcG9ydCA2NEsg
cGFnZSBzaXplLg0KDQpUaGFua3MsDQpRdQ0KPiANCj4gYW5kIG93bmVyIGlzIHNlcXVlbnRp
YWxseSBpbmNyZWFzZWQgc3VjaCBhIGhpZ2ggbnVtYmVyIGlzIHVubGlrZWx5IHRvIGJlDQo+
IHJlYWNoZWQgb24gbm93YWRheXMgc3lzdGVtcy4NCj4gDQo+PiAgICBCVFJGUyBjcml0aWNh
bCAoZGV2aWNlIGRtLTApOiBjb3JydXB0ZWQgbm9kZSwgcm9vdD0yNTYNCj4+IGJsb2NrPTg1
NTA5NTQ0NTU2ODI0MDUxMzkgb3duZXIgbWlzbWF0Y2gsIGhhdmUgMTE4NTgyMDU1Njc2NDIy
OTQzNTYNCj4+IGV4cGVjdCBbMjU2LCAxODQ0Njc0NDA3MzcwOTU1MTM2MF0NCj4+ICAgIEJU
UkZTIGNyaXRpY2FsIChkZXZpY2UgZG0tMCk6IGNvcnJ1cHRlZCBub2RlLCByb290PTI1Ng0K
Pj4gYmxvY2s9ODU1MDk1NDQ1NTY4MjQwNTEzOSBvd25lciBtaXNtYXRjaCwgaGF2ZSAxMTg1
ODIwNTU2NzY0MjI5NDM1Ng0KPj4gZXhwZWN0IFsyNTYsIDE4NDQ2NzQ0MDczNzA5NTUxMzYw
XQ0KPj4gICAgU0VMaW51eDogaW5vZGVfZG9pbml0X3VzZV94YXR0cjogIGdldHhhdHRyIHJl
dHVybmVkIDExNyBmb3IgZGV2PWRtLTANCj4+IGlubz01NzM3MjY4DQo+PiAgICBTRUxpbnV4
OiBpbm9kZV9kb2luaXRfdXNlX3hhdHRyOiAgZ2V0eGF0dHIgcmV0dXJuZWQgMTE3IGZvciBk
ZXY9ZG0tMA0KPj4gaW5vPTU3MzcyNjcNCj4+DQo+PiBhbmQgaXQgY2F1c2VkIGFuIGFjdHVh
bCB3YXJuaW5nIHRvIGJlIHByaW50ZWQgZm9yIG15IGtlcm5lbCB0cmVlIGZyb20gJ2dpdCc6
DQo+Pg0KPj4gICAgIGVycm9yOiBmYWlsZWQgdG8gc3RhdCAnc291bmQvcGNpL2ljZTE3MTIv
c2UuYyc6IFN0cnVjdHVyZSBuZWVkcyBjbGVhbmluZw0KPiANCj4gU2l6ZSBvZiBzb3VuZC9w
Y2kvaWNlMTcxMi9zZS5jIGlzIDE5ODc1LCB0aGlzIGRvZXMgbm90IGxvb2sgbGlrZSBpdA0K
PiB3b3VsZCBiZSBjYXVzZWQgYnkgdGhlIHpzdGQgYnVnIGFzIGl0IHdhcyBmb3IgaW5saW5l
ZCBmaWxlcyB3aGVyZSB0aGUNCj4gbGltaXQgaXMgMjA0OCBieXRlcy4NCj4gDQo+PiAoYW5k
IHllcywgMTE3IGlzIEVVQ0xFQU4sIGFrYSAiU3RydWN0dXJlIG5lZWRzIGNsZWFuaW5nIikN
Cj4+DQo+PiBUaGUgcHJvYmxlbSBzZWVtcyB0byBoYXZlIHNlbGYtY29ycmVjdGVkLCBiZWNh
dXNlIGl0IGRpZG4ndCBoYXBwZW4NCj4+IHdoZW4gcmVwZWF0aW5nIHRoZSBjb21tYW5kLCBh
bmQgdGhhdCBmaWxlIHRoYXQgZmFpbGVkIHRvIHN0YXQgbG9va3MNCj4+IHBlcmZlY3RseSBm
aW5lLg0KPj4NCj4+IEJ1dCBpdCBpcyBjbGVhcmx5IHdvcnJpc29tZS4NCj4+DQo+PiBUaGUg
Im93bmVyIG1pc21hdGNoIiBjaGVjayBpc24ndCBuZXcgLSBpdCB3YXMgYWRkZWQgYmFjayBp
biA1LjE5IGluDQo+PiBjb21taXQgODhjNjAyYWI0NDYwICgiYnRyZnM6IHRyZWUtY2hlY2tl
cjogY2hlY2sgZXh0ZW50IGJ1ZmZlciBvd25lcg0KPj4gYWdhaW5zdCBvd25lciByb290aWQi
KS4gU28gc29tZXRoaW5nIGVsc2UgbXVzdCBoYXZlIGNoYW5nZWQgdG8gdHJpZ2dlcg0KPj4g
aXQuDQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgZ2FyYmFnZSBkYXRhIGdvdCByZWFkIGZyb20g
ZGlzaywgeWV0IHN0aWxsIHBhc3NpbmcgdGhlDQo+IGNoZWNrc3VtIHRlc3QgKG90aGVyd2lz
ZSB0aGF0IHdvdWxkIGxlYWQgdG8gYW4gRUlPIGFuZCB3b3VsZCBub3QgZ2V0IHRvDQo+IHRo
ZSB0cmVlLWNoZWNrZXIpLiAgTW9zdCBsaWtlbHkgY2F1c2UgaXMgdGhhdCBkYW1hZ2VkIGRh
dGEgd2VyZSB3cml0dGVuDQo+IHRvIHRoZSBkaXNrIGJlZm9yZS4NCj4gDQo+IFRoZSB0cmVl
LWNoZWNrZXIgYWxzbyB2ZXJpZmllcyBkYXRhIGJlZm9yZSB0aGV5IGdldCB3cml0dGVuLCB0
aGUgc2FtZQ0KPiBib2d1cyB2YWx1ZXMgb2YgYmxvY2svb3duZXIgd291bGQgdHJpZ2dlciBp
dCBzbyB5b3UnZCBzZWUgYSB3YXJuaW5nLg0KPiANCj4gSXQncyBub3QgcG9zc2libGUgdG8g
Z2V0IHRoZSBkYXRhIGRhbWFnZWQgb24gdGhlIHdheSBmcm9tIHRoZSBkZXZpY2UgdG8NCj4g
dGhlIGZpbGVzeXN0ZW0sIHRoYXQgd291bGQgbm90IHBhc3MgdGhlIGNoZWNrc3VtLCBzbyB1
bmxpa2VseSBhDQo+IGRyaXZlci9ibG9jayBsYXllciBidWcuDQo+IA0KPiBXaGF0IHJlbWFp
bnMgdGhhdCB0aGUgZGF0YSB3ZXJlIGNvcnJlY3RseSB3cml0dGVuIGluIHRoZSBwYXN0LCBy
ZWFkDQo+IGNvcnJlY3RseSBwYXNzaW5nIGNoZWNrc3VtIHRlc3QgYnV0IHRoZW4gc29tZWhv
dyBnb3QgZGFtYWdlZCBpbiB0aGUNCj4gbWVtb3J5IGJldHdlZW4gdGhlIGNoZWNrc3VtIGNo
ZWNrIGFuZCB0cmVlLWNoZWNrZXIuIFRoZSB3aW5kb3cgaXMgcXVpdGUNCj4gc2hvcnQ6DQo+
IA0KPiBkaXNrLWlvLmM6YnRyZnNfdmFsaWRhdGVfZXh0ZW50X2J1ZmZlcigpDQo+IA0KPiBi
ZXR3ZWVuIGNzdW1fdHJlZV9ibG9jaygpIChhcm91bmQgbGluZSAzOTcpIGFuZA0KPiAgICAg
ICAgICBidHJmc19jaGVja19ub2RlKCkgKGFyb3VuZCBsaW5lIDQ2NCkNCg==
--------------jo3wCQWDJmFRbkftPh5ZBfYf
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------jo3wCQWDJmFRbkftPh5ZBfYf--

--------------vGm8OBupbJpZepUnMffk10XI--

--------------yR74XjTc2jHXFkrfuIZ2bRkm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmW0JpsFAwAAAAAACgkQwj2R86El/qj2
/Qf+M/tqyU8gnjlEGDYFN/DGP28JTnbjLwvjIBN3hmSTHWTuiKen9yxlOyAkKYxU47xWT02L6Iok
Zf+FHemu4a3hDmzGNFweG50p3Vg//7OvHtQr8L6BuqFDwhPgbF5Zj7KWoLHTgnlI+SY9iM01DEjh
wvb3Pw9KvFEk5vawHE83iVp9w5pPBcUrF3SmGOC2V+yQ+Bj1rYLqIZnrGPDWwnmSJ35izruF2W6p
xlMwHBDe+gt2L41mYjoL0WO7sFHRESa1C0G6qBxEc//86hSIZ7fsffd1acFFS3g5hvW1IaCGrO/G
Dd5kVVfl0B1am2AJZXzLnW4tlL+cjHiFnSmlUQVF4Q==
=MvZe
-----END PGP SIGNATURE-----

--------------yR74XjTc2jHXFkrfuIZ2bRkm--

