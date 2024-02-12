Return-Path: <linux-btrfs+bounces-2336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C5E8521CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 23:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE92281735
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 22:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6FC4F5FA;
	Mon, 12 Feb 2024 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SSlHG+p0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480550A6F
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778464; cv=none; b=FCaIJ3U+C8rqUnTnjPYieRr2zp4hc2jHjWB4Og5fB0XgDO9IsTemSGci6g3g1Z4EAbWj3q7qcmmoVHs4OgmDkDGg2CaCe6zOECMQCsHcI5yRMWn9C6B96fbJHQ0jW/0lVFcH+wRScM7V2rR01+rW/BMSqCoWkrLjaby0T2w/WQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778464; c=relaxed/simple;
	bh=TNKU6Yguh4mHQCpXStoPOvzpmKdGXAKlRkbtBt6TtMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiFssc+osbWCUoJ+w9Y+BcX6rJ8Oyvy4X1Bnf31ZFT+bmLRE3pFBxEbqdIFi0gYOcPCZaOgiD4M7m1kZ36fIvbibUhipsFG+axkKf9KX2P//qyThF+TQWP/0hmn/qHYBPPOKQMpyrrPtPxti+iBrak1gbxCDZjIgQybHYUrZ+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SSlHG+p0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51167e470f7so4534024e87.2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 14:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707778459; x=1708383259; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TNKU6Yguh4mHQCpXStoPOvzpmKdGXAKlRkbtBt6TtMs=;
        b=SSlHG+p0fO2D4CtPFe//Ayhl9H1tn7i2ZpQa9c/NJJhWVcBZAQbns7zwwqoYgZgrgC
         r6jc8FKAH6PN4D4RlWftEDRjDaqRbdLSJAX7Jp0qmmFmnaSPXl/S/uDailZqHaHRGxeQ
         FjkZa7MZoBH7MO+2Tlcf+e2PwRMQHIYRi8fuDq9OeWMXVyaN7j9np4a/6tnn/6WsjuDs
         uz7OVRArBYWhzWABDiGIvQdjQwzMypCLoZTx7eMWWH52vx+qvunRL06wCle2VZwOFdAs
         79Xmxor+f1eMPDcaRsnhvMagirTajYgWZ1uWHrAg30v+mYKMEMgJcak5pOoKhTkw7Yzi
         SRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707778459; x=1708383259;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNKU6Yguh4mHQCpXStoPOvzpmKdGXAKlRkbtBt6TtMs=;
        b=C7wiTu+lVXNLtU2kjNPb1QcHQreMyKwZ9qu1oxpp5ghcobYUgUBvSivdI1h/xEJB2Z
         094+l+xnUFjMNlrIwdcBiQ0DK7mBUVmjoPzXQnZkwei+FT44Sq2I5ZMk/kTgaYFZ0vFn
         BhWdIWnGZ7B84SZUbYZVCN/7XS/pU8u13naCGa+8qC97tZgDC/bk7xsuipLXAS5M33z0
         v2a26qrFpThquotF/OqzceHkiF+jl7pTeIZNfQh6A5pHfGO6WStlB9L0L1iKjP4HWyfD
         pkh9Z93IGSriV3BKRTV1xTOMC+BPw9ZztT93w2taa12ddDHebFf1TlJ6fqB11THFlITa
         ai9g==
X-Gm-Message-State: AOJu0Yx/mMlL48wfgXbGlc/KDb4xJ6zIfcKw52FuPSxTdxzMzmwKPzgZ
	a/ZgXEX75ucPxowoV9pe7XjEx165ISb9osSFBXTI6et1+o2bVoUzGRODLhLUCSc=
X-Google-Smtp-Source: AGHT+IEDHLro+mVy5rakKZk6cdTtY1SIgxEcZBAymXGItB5yun24DtN2Lyt2UnXcIe7waMo6kFniQg==
X-Received: by 2002:a2e:780b:0:b0:2d0:a755:b1fc with SMTP id t11-20020a2e780b000000b002d0a755b1fcmr4923195ljc.27.1707778459110;
        Mon, 12 Feb 2024 14:54:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrHIpqnOnXoMvqG3o5e0vNRE2FkHVc8AHAyL96XPpNkkfjdtbn01te9ix1zkwZMiDp1nTthby5EMQB12bT+y8I5HH+iMLv2N7m2NAOcQpO1zcaAG4=
Received: from ?IPV6:2403:580d:fda1::d81? (2403-580d-fda1--d81.ip6.aussiebb.net. [2403:580d:fda1::d81])
        by smtp.gmail.com with ESMTPSA id o20-20020a170902e29400b001d9b749d281sm223545plc.53.2024.02.12.14.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 14:54:18 -0800 (PST)
Message-ID: <e30938f6-824e-43df-b3ee-425b794a59ca@suse.com>
Date: Tue, 13 Feb 2024 09:24:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reject zoned RW mount if sectorsize is smaller
 than page size
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, HAN Yuwei <hrx@bupt.moe>,
 stable@vger.kernel.org
References: <2a19a500ccb297397018dac23d30106977153d62.1707714970.git.wqu@suse.com>
 <20240212111450.GZ355@twin.jikos.cz>
Content-Language: en-US
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
In-Reply-To: <20240212111450.GZ355@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WhEubv0601yBcSQRW5xBnXdl"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WhEubv0601yBcSQRW5xBnXdl
Content-Type: multipart/mixed; boundary="------------yHQ8Z0mNa4N4FFTX8tJPvizC";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, HAN Yuwei <hrx@bupt.moe>,
 stable@vger.kernel.org
Message-ID: <e30938f6-824e-43df-b3ee-425b794a59ca@suse.com>
Subject: Re: [PATCH] btrfs: reject zoned RW mount if sectorsize is smaller
 than page size
References: <2a19a500ccb297397018dac23d30106977153d62.1707714970.git.wqu@suse.com>
 <20240212111450.GZ355@twin.jikos.cz>
In-Reply-To: <20240212111450.GZ355@twin.jikos.cz>

--------------yHQ8Z0mNa4N4FFTX8tJPvizC
Content-Type: multipart/mixed; boundary="------------hf0CiKw2rZb3g7fVEh4t2GO2"

--------------hf0CiKw2rZb3g7fVEh4t2GO2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjQvMi8xMiAyMTo0NCwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPiBPbiBNb24s
IEZlYiAxMiwgMjAyNCBhdCAwMzo0NjoxNVBNICsxMDMwLCBRdSBXZW5ydW8gd3JvdGU6DQo+
PiBbQlVHXQ0KPj4gVGhlcmUgaXMgYSBidWcgcmVwb3J0IHRoYXQgd2l0aCB6b25lZCBkZXZp
Y2UgYW5kIHNlY3RvcnNpemUgaXMgc21hbGxlcg0KPj4gdGhhbiBwYWdlIHNpemUgKGFrYSwg
c3VicGFnZSksIGJ0cmZzIHdvdWxkIGNyYXNoIHdpdGggYSB2ZXJ5IGJhc2ljDQo+PiB3b3Jr
bG9hZDoNCj4+DQo+PiAgICMgZ2V0Y29uZmlnIFBBR0VTSVpFDQo+PiAgIDE2Mzg0DQo+PiAg
ICMgbWtmcy5idHJmcyAtZiAkZGV2IC1zIDRrDQo+PiAgICMgbW91bnQgJGRldiAkbW50DQo+
PiAgICMgJGZzc3RyZXNzIC13IC1uIDggLXMgMTcwNzgyMDMyNyAtdiAtZCAkbW50DQo+PiAg
ICMgdW1vdW50ICRtbnQNCj4+DQo+PiBUaGUgY3Jhc2ggd291bGQgbG9vayBsaWtlIHRoaXMg
KHdpdGggQ09ORklHX0JUUkZTX0FTU0VSVCBlbmFibGVkKToNCj4+DQo+PiAgIGFzc2VydGlv
biBmYWlsZWQ6IGJsb2NrX3N0YXJ0ICE9IEVYVEVOVF9NQVBfSE9MRSwgaW4gZnMvYnRyZnMv
ZXh0ZW50X2lvLmM6MTM4NA0KPiANCj4gVGhpcyBpcyB0aGUgc2FtZSBhcyB3aGF0IEpvc2Vm
IGZpeGVkIGluDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9idHJmcy9saW51eC9jb21taXQvNDAw
YmIwMTM5MTJkYWM2MzdjN2Q2ODI2NDA3YmU1ODBlYThlZjljYw0KPiAiYnRyZnM6IGRvbid0
IGRyb3AgZXh0ZW50X21hcCBmb3IgZnJlZSBzcGFjZSBpbm9kZSBvbiB3cml0ZSBlcnJvciIN
Cj4gYnV0IG5vdCBvbiB6b25lZCtzdWJwYWdlLCBpcyBpdCByZWFsbHkgYSBkaWZmZXJlbnQg
ZXJyb3IgeW91J3JlIGZpeGluZz8NCg0KWWVzLCBpdCdzIHJlYWxseSBhIGRpZmZlcmVudCBi
dWcuDQoNCkFsdGhvdWdoIHRoZSByb290IGNhdXNlIGlzIGEgbGl0dGxlIG1vcmUgY29tcGxl
eCwgaXQgaGFzIHRvIGJlIGV4cGxhaW5lZCANCnRocm91Z2ggdGhlIHdob2xlIENBVVNFIHNl
Y3Rpb24uDQoNCj4gDQo+IFsuLi5dDQo+PiBbV09SS0FST1VORF0NCj4+IEEgcHJvcGVyIGZp
eCByZXF1aXJlcyBzb21lIGJpZyBjaGFuZ2VzIHRvIGRlbGFsbG9jIHdvcmtsb2FkLCB0byBh
bGxvdw0KPj4gZXh0ZW50X3dyaXRlX2xvY2tlZF9yYW5nZSgpIHRvIGhhbmRsZSBtdWx0aXBs
ZSBkaWZmZXJlbnQgZW50cmllcyB3aXRoDQo+PiB0aGUgc2FtZSBAbG9ja2VkX3BhZ2UuDQo+
Pg0KPj4gU28gZm9yIG5vdywgZGlzYWJsZSByZWFkLXdyaXRlIHN1cHBvcnQgZm9yIHN1YnBh
Z2Ugem9uZWQgYnRyZnMuDQo+Pg0KPj4gVGhlIHByb2JsZW0gY2FuIG9ubHkgYmUgc29sdmVk
IGlmIHN1YnBhZ2UgYnRyZnMgY2FuIGhhbmRsZSBzdWJwYWdlDQo+PiBjb21wcmVzc2lvbiwg
d2hpY2ggbmVlZCBxdWl0ZSBzb21lIHdvcmsgb24gdGhlIGRlbGFsbG9jIHByb2NlZHVyZSBm
b3INCj4+IHRoZSBAbG9ja2VkX3BhZ2UgaGFuZGxpbmcuDQo+IA0KPiBPaywgdGhpcyBvbiBp
dHNlbGYgaXMgYSB2YWxpZCByZWFzb24gdG8gZGlzYWJsZSB0aGUgc3VwcG9ydC4NCg0KQnV0
IHRoaXMgcmVtaW5kcyBtZSB0aGF0LCBJIGhhdmUgdG8gd29yayBvbiB0aGUgcHJvcGVyIGRl
bGFsbG9jIHN1cHBvcnQgDQpmb3Igc3VicGFnZS4NCg0KTXkgY3VycmVudCBwbGFuIGlzOg0K
DQoxLiBJbnRyb2R1Y2Ugc3VicGFnZSBMT0NLIGJpdG1hcA0KICAgIE5vdCBqdXN0IG9ubHkg
YW4gYXRvbWljIGNvdW50ZXIuDQoNCjIuIE1ha2UgZmluZF9sb2NrX2RlbGFsbG9jX3Jhbmdl
KCkgdG8gcG9wdWxhdGUgdGhhdCBsb2NrIGJpdG1hcA0KDQozLiBNYWtlIGZpbmRfbG9ja19k
ZWxhbGxvY19yYW5nZSgpIHRvIGZpbmQgYWxsIGRlbGFsbG9jIHJhbmdlIG9mDQogICAgYSBw
YWdlIGFuZCBwcm9wZXJseSBsb2NrIHRoZW0NCiAgICBUaGlzIHdvdWxkIG5vdCBjaGFuZ2Ug
dGhlIGJlaGF2aW9yIGZvciBwYWdlIHNpemVkIHNlY3RvcnNpemUuDQoNCjQuIE1ha2UgZmlu
ZF9sb2NrX2RlbGFsbG9jX3JhbmdlKCkgdG8gc2tpcCB0aGUgcGFnZSBpZiBpdCdzIGFscmVh
ZHkNCiAgICBiZWluZyBsb2NrZWQgYmVmb3JlLg0KICAgIFRoaXMgaXMgYWxzbyBhIHN1YnBh
Z2Ugc3BlY2lmaWMgYmVoYXZpb3INCg0KV2l0aCBhYm92ZSBwbGFubmVkIHdvcmssIGJ0cmZz
IHNob3VsZCBiZSBhYmxlIHRvIGhhbmRsZSBzdWJwYWdlIHVubG9jaywgDQpzbyB0aGF0IHdl
IHdvbid0IG5lZWQgd2VpcmQgQGxvY2tlZF9wYWdlIGhhbmRsaW5nLg0KDQpIb3BlZnVsbHkg
dGhpcyB3b3VsZCBzb2x2ZSBib3RoIHRoZSBzdWJwYWdlK3pvbmVkIGFuZCBmdWxsIHNlY3Rv
ciANCmFsaWduZWQgc3VicGFnZSBjb21wcmVzc2lvbiBzdXBwb3J0Lg0KDQpUaGFua3MsDQpR
dQ0K
--------------hf0CiKw2rZb3g7fVEh4t2GO2
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------hf0CiKw2rZb3g7fVEh4t2GO2--

--------------yHQ8Z0mNa4N4FFTX8tJPvizC--

--------------WhEubv0601yBcSQRW5xBnXdl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmXKoZQFAwAAAAAACgkQwj2R86El/qh+
RAf9HGspWEDRdYy2b5kKJgXG27oQTZzCJRYd0kg4h6KrnPyJ+AUYFjewV/iAJWIB9P1GB2xyOLyB
SVHM4f0o8g5au9cdYnfVH73MlQLTexw1zuOIgcHp+bplMawHZRIcTYnDrGqHYjVyR9Cp1d7RImKw
FZYi3q9/jbctHf7CA0q6hY2uC0VXlOx2OzPvFw9+KmoGL0gnHvPm4VXBGOo9HbB8XVUhWHWBbYHm
zAbb7cXwIUaw8UWPzAxGbegjun8ZpXMhIAfXJnqGIq5tHYZovzzrjBtXoENLwc685rFnrbIrJK9v
TqPd0L7n43FPbnzVIy4DOJpc/EHz3gIaFXMzksT4sg==
=WAnK
-----END PGP SIGNATURE-----

--------------WhEubv0601yBcSQRW5xBnXdl--

