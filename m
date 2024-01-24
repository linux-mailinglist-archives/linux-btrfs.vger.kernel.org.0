Return-Path: <linux-btrfs+bounces-1676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B1483A188
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 06:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3D7289477
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 05:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBBBE56D;
	Wed, 24 Jan 2024 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KLrXHgLA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F14DC123
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 05:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075427; cv=none; b=oyDXclNSHSNTvWjOhfNBzdL63VkQ7NrUlxf8XlGioBR1ssNC2swIXynw42wKBWmjYt8waPYIpwsP1caX5Hf/cFg74kird30BgAUDkd32merLlS0h4lNZWAEFohUqwctRbZrEKU4INDII0hm1XPqE+569so4/8DI3t6SvwtBjLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075427; c=relaxed/simple;
	bh=uFTA8SoO2ZRNKaP7MNpaYJZ7ZF88Emu5zXDAldsftp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClzcdZ4c2V7sy70LN4evwd1hPY9FyWInqsVdLdq++M9GmPYqGlS28gTNJbsPJZmAphBPdtCaUiA95cKSSOptrSoa5l9VCzGm9f3yBdL0zhnt0mJanZ7+lHNeUMbML/PttZSNRQzJrWXQEeB+ytas7Pdw0CwinaT9KsW1PVxOcWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KLrXHgLA; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf108f6a2dso16952471fa.3
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 21:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706075422; x=1706680222; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uFTA8SoO2ZRNKaP7MNpaYJZ7ZF88Emu5zXDAldsftp0=;
        b=KLrXHgLAp0c3I9ZZZrFnD5jqxmGE4T7tsTNHlRHgDqnjEqH1I1LsXwjvQuL9mu8O2g
         tOhaeeJT6lLZ59Yyt7ZZ7ej/UXfTtKJ1BemuVPGQNZQAtOP06DRxHw5r7Up2CclnHukt
         mkM74w3N5xgKyUz+whU88iNg0wHQ8lnDUABI4PtDbOzKw7oRZOaANhxJ49ngiUCUmYbj
         CpLM7hn8EJ+G2jTtcT3bx5pJZHyC3QiK+WuQpuzl+NdtmESegM7DgNYVS2tdVE3P5Yfb
         lsc6VAiHAVReaZukP1fwrGkHOiNTLyVGyNKVfA+vQEqOBthKUE/7OxFbtdlSdu2dvhP8
         Maxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706075422; x=1706680222;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFTA8SoO2ZRNKaP7MNpaYJZ7ZF88Emu5zXDAldsftp0=;
        b=PDKM1YPEC3BTX7mmkQWFfVLoS1QLGLXX95xVEssbC4G3Xbal1PD7XvYtrjb7TSIZrO
         ktumQJ4MsymBYCY+W7fbk1FCXZQ+0Q8DN5YoCIdakhkvAEcjRtBFujvnGrrDXIhcjgXV
         DjhaAz67esDdNb3DqfBAMnpIzP7P2vNsahRsAeTQy1erW+p81grcr8TSXva9njcheqwb
         s7tOHQ9Z5JYUN8dZg/nNV7sVHAoPZ36gxQ5JzM2Jf+SYGXrCyz3zQmVbzloLMEjjevbB
         8vsTReu8xWdpzHLdygxI/quQf8JyIEIIFeJMfSnfilHS8/h88fmr2siluSOWSHEIHEkU
         Z/lg==
X-Gm-Message-State: AOJu0YwAet/flrZcvlp2j5pnLt0uKPQpk1DSAGyWZn0jHlejmj9jkv8O
	hfy6/zJHlPzlx8w+MhZdXGDbHgkCZ5JYT8bErSApup1/CQLJGa51tReUfIKZXPjgUcdWoFT3S7w
	P
X-Google-Smtp-Source: AGHT+IE2XNRrsD/vBrOHngVuxc78Ouqkx2avlAhUO/fYzK6mjIlVCFofHm1dkfbV9IvCqatQ6EExDQ==
X-Received: by 2002:a2e:2245:0:b0:2ce:dfc:db78 with SMTP id i66-20020a2e2245000000b002ce0dfcdb78mr460803lji.29.1706075422487;
        Tue, 23 Jan 2024 21:50:22 -0800 (PST)
Received: from ?IPV6:2403:580d:bef6::b19? (2403-580d-bef6--b19.ip6.aussiebb.net. [2403:580d:bef6::b19])
        by smtp.gmail.com with ESMTPSA id sw15-20020a17090b2c8f00b0028c1a5aafe5sm12795804pjb.14.2024.01.23.21.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 21:50:21 -0800 (PST)
Message-ID: <a0779a67-6f9b-45e2-b07d-42cd133a5795@suse.com>
Date: Wed, 24 Jan 2024 16:20:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] btrfs: defrag: further preparation for multi-page
 sector size
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>
References: <cover.1706068026.git.wqu@suse.com>
 <b521e943-ae86-4a6c-a470-072268b254a0@suse.com>
 <ZbCWi98hWKnIW1zq@casper.infradead.org>
 <45066165-3d2d-4026-87d3-2cfe3369a86b@gmx.com>
 <ZbCjkrOwaMyvhRD8@casper.infradead.org>
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
In-Reply-To: <ZbCjkrOwaMyvhRD8@casper.infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZEt0FRiZ0fjgR8igZK0UO2r3"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZEt0FRiZ0fjgR8igZK0UO2r3
Content-Type: multipart/mixed; boundary="------------ngV5QV0BBNHgRigevcdJYDBH";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: Matthew Wilcox <willy@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>
Message-ID: <a0779a67-6f9b-45e2-b07d-42cd133a5795@suse.com>
Subject: Re: [PATCH RFC 0/2] btrfs: defrag: further preparation for multi-page
 sector size
References: <cover.1706068026.git.wqu@suse.com>
 <b521e943-ae86-4a6c-a470-072268b254a0@suse.com>
 <ZbCWi98hWKnIW1zq@casper.infradead.org>
 <45066165-3d2d-4026-87d3-2cfe3369a86b@gmx.com>
 <ZbCjkrOwaMyvhRD8@casper.infradead.org>
In-Reply-To: <ZbCjkrOwaMyvhRD8@casper.infradead.org>

--------------ngV5QV0BBNHgRigevcdJYDBH
Content-Type: multipart/mixed; boundary="------------els09m6CkOK2Wmy8r0EGGHrp"

--------------els09m6CkOK2Wmy8r0EGGHrp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjQvMS8yNCAxNjoxMywgTWF0dGhldyBXaWxjb3ggd3JvdGU6DQo+IE9uIFdl
ZCwgSmFuIDI0LCAyMDI0IGF0IDAzOjU3OjM5UE0gKzEwMzAsIFF1IFdlbnJ1byB3cm90ZToN
Cj4+DQo+Pg0KPj4gT24gMjAyNC8xLzI0IDE1OjE4LCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4+PiBPbiBXZWQsIEphbiAyNCwgMjAyNCBhdCAwMjozMzoyMlBNICsxMDMwLCBRdSBXZW5y
dW8gd3JvdGU6DQo+Pj4+IEknbSBwcmV0dHkgc3VyZSB3ZSB3b3VsZCBoYXZlIHNvbWUgZmls
ZXN5c3RlbXMgZ28gdXRpbGl6aW5nIGxhcmdlciBmb2xpb3MgdG8NCj4+Pj4gaW1wbGVtZW50
IHRoZWlyIG11bHRpLXBhZ2UgYmxvY2sgc2l6ZSBzdXBwb3J0Lg0KPj4+Pg0KPj4+PiBUaHVz
IGluIHRoYXQgY2FzZSwgY2FuIHdlIGhhdmUgYW4gaW50ZXJmYWNlIGNoYW5nZSB0byBtYWtl
IGFsbCBmb2xpbw0KPj4+PiB2ZXJzaW9ucyBvZiBmaWxlbWFwXyooKSB0byBhY2NlcHQgYSBm
aWxlIG9mZnNldCBpbnN0ZWFkIG9mIHBhZ2UgaW5kZXg/DQo+Pj4NCj4+PiBZb3UncmUgY29u
ZnVzZWQuICBUaGVyZSdzIG5vIGNoYW5nZSBuZWVkZWQgdG8gdGhlIGZpbGVtYXAgQVBJIHRv
IHN1cHBvcnQNCj4+PiBsYXJnZSBmb2xpb3MgdXNlZCBieSBsYXJnZSBibG9jayBzaXplcy4g
IFF1aXRlIHBvc3NpYmx5IG1vcmUgb2YgYnRyZnMNCj4+PiBpcyBjb25mdXNlZCwgYnV0IGl0
J3MgcmVhbGx5IHZlcnkgc2ltcGxlLiAgaW5kZXggPT0gcG9zIC8gUEFHRV9TSVpFLg0KPj4+
IFRoYXQncyBhbGwuICBFdmVuIGlmIHlvdSBoYXZlIGEgNjRrQiBibG9jayBzaXplIGRldmlj
ZSBvbiBhIDRrQiBQQUdFX1NJWkUNCj4+PiBtYWNoaW5lLg0KPj4NCj4+IFllcywgSSB1bmRl
cnN0YW5kIHRoYXQgZmlsZW1hcCBBUEkgaXMgYWx3YXlzIHdvcmtpbmcgb24gUEFHRV9TSElG
VGVkIGluZGV4Lg0KPiANCj4gT0ssIGdvb2QuDQo+IA0KPj4gVGhlIGNvbmNlcm4gaXMsICho
b3BlZnVsbHkpIHdpdGggbW9yZSBmc2VzIGdvaW5nIHRvIHV0aWxpemVkIGxhcmdlDQo+PiBm
b2xpb3MsIHRoZXJlIHdvdWxkIGJlIHR3byBzaGlmdHMuDQo+Pg0KPj4gT25lIGZvbGlvIHNo
aWZ0IChpbG9nMihibG9ja3NpemUpKSwgb25lIFBBR0VfU0hJRlQgZm9yIGZpbGVtYXAgaW50
ZXJmYWNlcy4NCj4gDQo+IERvbid0IHNoaWZ0IHRoZSBmaWxlIHBvc2l0aW9uIGJ5IHRoZSBm
b2xpb19zaGlmdCgpLiAgWW91IHdhbnQgdG8gc3VwcG9ydA0KPiBsYXJnZShyKSBmb2xpb3Mg
X2FuZF8gbGFyZ2UgYmxvY2tzaXplcyBhdCB0aGUgc2FtZSB0aW1lLiAgaWUgNjRrQiBtaWdo
dA0KPiBiZSB0aGUgYmxvY2sgc2l6ZSwgYnV0IGFsbCB0aGF0IHdvdWxkIG1lYW4gd291bGQg
YmUgdGhhdCBmb2xpb19zaGlmdCgpDQo+IHdvdWxkIGJlIGF0IGxlYXN0IDE2LiAgSXQgbWln
aHQgYmUgMTcsIDE4IG9yIDIxIChmb3IgYSBUSFApLg0KDQpJbmRlZWQsIEkgZm9yZ290IHdl
IGhhdmUgVEhQLg0KDQo+IA0KPiBGaWxlc3lzdGVtcyBhbHJlYWR5IGhhdmUgdG8gZGVhbCB3
aXRoIGRpZmZlcmVudCBQQUdFX1NJWkUsIFNFQ1RPUl9TSVpFLA0KPiBmc2Jsb2NrIHNpemUg
YW5kIExCQSBzaXplLiAgRm9saW9zIGFyZW4ndCBtYWtpbmcgdGhpbmdzIGFueSB3b3JzZSBo
ZXJlDQo+ICh0aGV5J3JlIGFsc28gbm90IG1ha2luZyBhbnl0aGluZyBiZXR0ZXIgaW4gdGhp
cyBhcmVhLCBidXQgSSBuZXZlcg0KPiBjbGFpbWVkIHRoZXkgd291bGQpLg0KDQpPSywgdGhh
dCBtYWtlcyBzZW5zZS4NCg0KU28gYWxsIHRoZSBmb2xpbyBzaGlmdHMgd291bGQgYmUgYW4g
ZnMgaW50ZXJuYWwgZGVhbCwgYW5kIHdlIGhhdmUgdG8gDQpoYW5kbGUgaXQgcHJvcGVybHku
DQoNCj4gDQo+IGJ0cmZzIGlzIHNsaWdodGx5IHVudXN1YWwgaW4gdGhhdCBpdCBkZWZpbmVk
IFBBR0VfU0laRSBhbmQgZnNibG9jayBzaXplDQo+IHRvIGJlIHRoZSBzYW1lIChhbmQgdGhl
biBoYWQgdG8gZGVhbCB3aXRoIHRoZSBjb25zZXF1ZW5jZXMgb2YgYXJtNjQveDg2DQo+IGlu
dGVyb3BlcmFiaWxpdHkgbGF0ZXIpLiAgQnV0IG1vc3QgZmlsZXN5c3RlbXMgaGF2ZSBwcmV0
dHkgZ29vZCBzZXBhcmF0aW9uDQo+IG9mIHRoZSBmb3VyIGNvbmNlcHRzLg0KDQpJbmRlZWQs
IGFsdGhvdWdoIEkgYWxzbyBmb3VuZCBtb3N0IG1ham9yIGZzZXMgZG8gbm90IHN1cHBvcnQg
bGFyZ2VyIA0KYmxvY2sgc2l6ZSAoPiBQQUdFX1NJWkUpIGVpdGhlci4NCg0KSSBndWVzcyBz
dWJwYWdlIGlzIHNpbXBsZXIgaW4gdGhlIHBhc3QsIGFuZCBob3BlZnVsbHkgd2l0aCBsYXJn
ZXIgZm9saW8sIA0Kd2UgY2FuIHNlZSBtb3JlIGZzZXMgc3VwcG9ydCBtdWx0aS1wYWdlIGJs
b2Nrc2l6ZSBzb29uLg0KDQpUaGFua3MsDQpRdQ0K
--------------els09m6CkOK2Wmy8r0EGGHrp
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------els09m6CkOK2Wmy8r0EGGHrp--

--------------ngV5QV0BBNHgRigevcdJYDBH--

--------------ZEt0FRiZ0fjgR8igZK0UO2r3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmWwpRgFAwAAAAAACgkQwj2R86El/qiX
fQgAmCfHapj/K8tR9yLnSoPSLUfq8TIHnML3Fl9I9iLldAHKKe0pY0YC8aANUrwHe5SoTW71gocv
wduIS9+5WlOs5kV07jf98v0/3v6Ooijb70e/h3cn53XC/7XsxBauDtzYS1FZ+LZRzzgr8jz/TVkj
6zxvZa43aOS0LBJBsOIQ/qRBjEfWl2RS+AU1BOmBK1Jw+1VwSHzsGGsXxEYaCeO+oqnaz94KL/ee
CYJL1QRk8jqLuvGLQEWS6zlljVR87L/AJBnIdRE7nDYFpZjWV7LHIZRWgQEXsbEu9fdnARG33tg2
G2fG62ARiV2lPR7WP4Ip23+AbeD88nspASFjZY5UPw==
=/9od
-----END PGP SIGNATURE-----

--------------ZEt0FRiZ0fjgR8igZK0UO2r3--

