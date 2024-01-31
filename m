Return-Path: <linux-btrfs+bounces-1979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF0844B27
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 23:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD48E1C227FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 22:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E73A8D5;
	Wed, 31 Jan 2024 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XBPxGrB5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E839FEB
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740721; cv=none; b=tlYq6IaC3rM2DJUg5/SF+kMUovYnMXEP5+Se7vyWsOAQWsXqfjjLMK6Jghr7XHzNgryJbPm1Hq02KHYUxkxgg40OQ3SoX0XMb3+KkfdQKkAxyB37ZS7+TJIA+sfzYSY4YZU/XmeThXceZwDcn4futf1WkywnYrEtbrLCZLGOpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740721; c=relaxed/simple;
	bh=Bi4l4ckyLQAwQ6zZOy7/wGPKy22Q/jJVFeGE0FdzpTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfxX9f1itaIzIEE509CQhzO12U1cuhcavq+++PE4QQ+q3opSxIXEfZ3ZDZ10K4q68VxQXk5iREmT+CIyEQmFT/2jc/gyLRMbQnx841PHbC6FZKA3JbahMNuUvN+ZRZ2tLd8PSXFB1MU95aCjvPCIXMgRe2fnX8+fdTXLWA2TfsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XBPxGrB5; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf3a095ba6so4281421fa.2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 14:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706740716; x=1707345516; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bi4l4ckyLQAwQ6zZOy7/wGPKy22Q/jJVFeGE0FdzpTI=;
        b=XBPxGrB5zNqIxX3aw4t1xlv22NslK4FuA5q2552NScOcBy9rpUOh2ORh8totojGJHf
         mi9zXwM3U5ZU+sgl5ZfAlRCzFTE8RIf4fGw9qh9H1OFvuCQjDgvSzBunnhfT3S4DVoT1
         IYlKsNMUoFahjGS/FRyK/874S9ZS2QGTj0F+Rok3YuNlnQwp1bPxo2rNMAfrQtrC5mOY
         vG4byajGDWxgP1hQGIQRTEfbr2bLvT21IYTzYuMIguRbhq7tMFx+JanEjGM4Pf71AcKS
         sQvSGpghkrp+yWQe9c2Z5gidhNyQ4yUZCcwbxUYm+BdawO5sMxv0K1KD7Aeb6LCvewtR
         G7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740716; x=1707345516;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bi4l4ckyLQAwQ6zZOy7/wGPKy22Q/jJVFeGE0FdzpTI=;
        b=mz9jJ49hcpjc8iW1WA/pWX2PHA+slwidBvhoumbQMhMgC1vmTCSpFy8XJ37wg6pAr4
         6DWH8eEJe35P4bzieBfDJQ8u3BDSsYNyhdscAJmIF7CDCOMBUvDx4YXU2a894eliNVhF
         iKRD/yYF/oL/hs/lDSAT6I76MFAa7uTv3ZlDdZ4ShHGlSoYTy3G2wDRnE6+nalSG7h/m
         QDkFkjBZThFg6nYl+tDeSjJKh/JQTDlbm1ML3+AIwC9F61XqQtggWhOJMY7OUG98BAMr
         HUjVbloBR2GND8gEVruP12o7fszrWtOoKQxY7JZNG7ug+AbHfSfkOqdIk3RbdGE92GEA
         YoMw==
X-Gm-Message-State: AOJu0Yyo1mYOHpU4S1Z3K17LMtb2FfWYjRMRT9QZ9AbSd2tYzcEsQlwa
	dmui8pjY8dJFDPBaGH0jOCN7D2cBQdsmspjKywIeqxBrPeJxsl8nlpCoNu1PfPcXONYlSK1A59k
	v
X-Google-Smtp-Source: AGHT+IG9zDoEVYLLp2SGKqgPfpwFNIMjTVbQ4j0ALZr9CnuzRV+rfSCDGQ/HYDUr1wbA+wYVaam+uw==
X-Received: by 2002:a2e:8283:0:b0:2cc:e976:5915 with SMTP id y3-20020a2e8283000000b002cce9765915mr2024933ljg.49.1706740716139;
        Wed, 31 Jan 2024 14:38:36 -0800 (PST)
Received: from ?IPV6:2403:580d:bef6::959? (2403-580d-bef6--959.ip6.aussiebb.net. [2403:580d:bef6::959])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ac25800b00295c3c1688dsm2042808pjx.42.2024.01.31.14.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 14:38:35 -0800 (PST)
Message-ID: <6b1001cb-7df0-4ffc-ab15-cd25223da9d6@suse.com>
Date: Thu, 1 Feb 2024 09:08:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: mkfs: use flock() to properly prevent
 race with udev
Content-Language: en-US
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <49bbb80e37990b0614f0929ac302560b27d2d933.1706594470.git.wqu@suse.com>
 <20240131182409.GO31555@twin.jikos.cz>
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
In-Reply-To: <20240131182409.GO31555@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0LLmmkN9TGE8t5g9c02rHA7a"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0LLmmkN9TGE8t5g9c02rHA7a
Content-Type: multipart/mixed; boundary="------------oBlz1wsRZbkpNTNTWIVkUW1N";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Message-ID: <6b1001cb-7df0-4ffc-ab15-cd25223da9d6@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: mkfs: use flock() to properly prevent
 race with udev
References: <49bbb80e37990b0614f0929ac302560b27d2d933.1706594470.git.wqu@suse.com>
 <20240131182409.GO31555@twin.jikos.cz>
In-Reply-To: <20240131182409.GO31555@twin.jikos.cz>

--------------oBlz1wsRZbkpNTNTWIVkUW1N
Content-Type: multipart/mixed; boundary="------------sNcOsCLyI5PYPfxTAE8iatOA"

--------------sNcOsCLyI5PYPfxTAE8iatOA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjQvMi8xIDA0OjU0LCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+IE9uIFR1ZSwg
SmFuIDMwLCAyMDI0IGF0IDA0OjMxOjE3UE0gKzEwMzAsIFF1IFdlbnJ1byB3cm90ZToNCj4+
IFtCVUddDQo+PiBFdmVuIGFmdGVyIGNvbW1pdCBiMmExYmU4M2I4NWYgKCJidHJmcy1wcm9n
czogbWtmczoga2VlcCBmaWxlDQo+PiBkZXNjcmlwdG9ycyBvcGVuIGR1cmluZyB3aG9sZSB0
aW1lIiksIHRoZXJlIGlzIHN0aWxsIGEgYnVnIHJlcG9ydCBhYm91dA0KPj4gYmxraWQgZmFp
bGVkIHRvIGdyYWIgdGhlIEZTSUQ6DQo+Pg0KPj4gICBkZXZpY2U9L2Rldi9sb29wMA0KPj4g
ICBmc3R5cGU9YnRyZnMNCj4+DQo+PiAgIHdpcGVmcyAtYSAiJGRldmljZSIqDQo+Pg0KPj4g
ICBwYXJ0ZWQgLXMgIiRkZXZpY2UiIFwNCj4+ICAgICAgIG1rbGFiZWwgZ3B0IFwNCj4+ICAg
ICAgIG1rcGFydCAnIkVGSSBzeXN0ZW0gcGFydGl0aW9uIicgZmF0MzIgMU1pQiA1MTNNaUIg
XA0KPj4gICAgICAgc2V0IDEgZXNwIG9uIFwNCj4+ICAgICAgIG1rcGFydCAnInJvb3QgcGFy
dGl0aW9uIicgIiRmc3R5cGUiIDUxM01pQiAxMDAlDQo+Pg0KPj4gICB1ZGV2YWRtIHNldHRs
ZQ0KPj4gICBwYXJ0aXRpb25zPSgkKGxzYmxrIC1uIC1vIHBhdGggIiRkZXZpY2UiKSkNCj4+
DQo+PiAgIG1rZnMuZmF0IC1GIDMyICR7cGFydGl0aW9uc1sxXX0NCj4+ICAgbWtmcy4iJGZz
dHlwZSIgJHtwYXJ0aXRpb25zWzJdfQ0KPj4gICB1ZGV2YWRtIHNldHRsZQ0KPj4NCj4+IFRo
ZSBhYm92ZSBzY3JpcHQgY2FuIHNvbWV0aW1lcyByZXN1bHQgZW1wdHkgZnNpZDoNCj4+DQo+
PiAgIGxvb3AwDQo+PiAgIHwtbG9vcDBwMSBCREYzLTU1MkINCj4+ICAgYC1sb29wMHAyDQo+
Pg0KPj4gW0NBVVNFXQ0KPj4gQWx0aG91Z2ggY29tbWl0IGIyYTFiZTgzYjg1ZiAoImJ0cmZz
LXByb2dzOiBta2ZzOiBrZWVwIGZpbGUgZGVzY3JpcHRvcnMNCj4+IG9wZW4gZHVyaW5nIHdo
b2xlIHRpbWUiKSBjaGFuZ2VkIHRoZSBsaWZlc3BhbiBvZiB0aGUgZmRzLCBpdCBkb2Vzbid0
DQo+PiBwcm9wZXJseSBpbmZvcm0gdWRldiBhYm91dCBvdXIgY2hhbmdlIHRvIGNlcnRhaW4g
cGFydGl0aW9uLg0KPj4NCj4+IFRodXMgZm9yIGEgbXVsdGktcGFydGl0aW9uIGNhc2UsIHVk
ZXYgY2FuIHN0YXJ0IHNjYW5uaW5nIHRoZSB3aG9sZSBkaXNrLA0KPj4gbWVhbndoaWxlIG91
ciBta2ZzIGlzIHN0aWxsIGhhcHBlbmluZyBoYWxmd2F5Lg0KPj4NCj4+IElmIHRoZSBzY2Fu
IGlzIGRvbmUgYmVmb3JlIG91ciBuZXcgc3VwZXIgYmxvY2tzIHdyaXR0ZW4sIGFuZCBvdXIg
Y2xvc2UoKQ0KPj4gY2FsbHMgaGFwcGVucyBsYXRlciBqdXN0IGJlZm9yZSB0aGUgY3VycmVu
dCBzY2FuIGlzIGZpbmlzaGVkLCB1ZGV2IGNhbg0KPj4gZ290IHRoZSB0ZW1wb3Jhcnkgc3Vw
ZXIgYmxvY2tzICh3aGljaCBpcyBub3QgYSB2YWxpZCBvbmUpLg0KPj4NCj4+IEFuZCBzaW5j
ZSBvdXIgY2xvc2UoKSBjYWxscyBoYXBwZW5zIGR1cmluZyB0aGUgc2NhbiwgdGhlcmUgd291
bGQgYmUgbm8NCj4+IG5ldyBzY2FuLCB0aHVzIGxlYWRpbmcgdG8gdGhlIGJhZCByZXN1bHQu
DQo+Pg0KPj4gW0ZJWF0NCj4+IFRoZSBwcm9wZXIgd2F5IHRvIGF2b2lkIHJhY2Ugd2l0aCB1
ZGV2IGlzIHRvIGZsb2NrKCkgdGhlIHdob2xlIGRpc2sNCj4+IChha2EsIHRoZSBwYXJlbnQg
YmxvY2sgZGV2aWNlLCBub3QgdGhlIHBhcnRpdGlvbiBkaXNrKS4NCj4+DQo+PiBUaHVzIHRo
aXMgcGF0Y2ggd291bGQgaW50cm9kdWNlIHN1Y2ggbWVjaGFuaXNtIGJ5Og0KPj4NCj4+IC0g
YnRyZnNfZmxvY2tfb25lX2RldmljZSgpDQo+PiAgICBUaGlzIHdvdWxkIHJlc29sdmUgdGhl
IHBhdGggdG8gYSB3aG9sZSBkaXNrIHBhdGguDQo+PiAgICBUaGVuIG1ha2Ugc3VyZSB0aGUg
d2hvbGUgZGlzayBpcyBub3QgYWxyZWFkeSBsb2NrZWQgKHRoaXMgY2FuIGhhcHBlbg0KPj4g
ICAgZm9yIGNhc2VzIGxpa2UgIm1rZnMuYnRyZnMgLWYgL2Rldi9zZGFbMTIzXSIpLg0KPj4N
Cj4+ICAgIElmIHRoZSBkZXZpY2UgaXMgbm90IGFscmVhZHkgbG9ja2VkLCB0aGVuIGZsb2Nr
KCkgdGhlIGRldmljZSwgYW5kDQo+PiAgICBpbnNlcnQgYSBuZXcgZW50cnkgaW50byB0aGUg
bGlzdC4NCj4+DQo+PiAtIGJ0cmZzX3VubG9ja19hbGxfZGV2aWNlcygpDQo+PiAgICBXb3Vs
ZCBnbyB1bmxvY2sgYWxsIGRldmljZXMgcmVjb3JkZWQgaW4gbG9ja2VkX2RldmljZXMgbGlz
dCwgYW5kIGZyZWUNCj4+ICAgIHRoZSBtZW1vcnkuDQo+Pg0KPj4gQW5kIG1rZnMuYnRyZnMg
d291bGQgYmUgdGhlIGZpcnN0IG9uZSB0byB1dGlsaXplIHRoZSBuZXcgbWVjaGFuaXNtLCB0
bw0KPj4gcHJldmVudCBzdWNoIHJhY2Ugd2l0aCB1ZGV2Lg0KPiANCj4gVGhlIG90aGVyIHBv
c3NpYmxlIHVzZXIgY291bGQgYmUgYnRyZnMtY29udmVydCBhcyBpdCBhbHNvIHdyaXRlcyBk
YXRhDQo+IGFuZCBjaGFuZ2VzIHRoZSBVVUlELg0KPiANCj4+IElzc3VlOiAjNzM0DQo+PiBT
aWduZWQtb2ZmLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4NCj4gDQo+IEFkZGVkIHRv
IGRldmVsLCB0aGFua3MgZm9yIGZpeGluZyBpdC4NCg0KU29ycnksIHRoaXMgdjIgaXMgc3Rp
bGwgaW5jb3JyZWN0LCBhcyBpdCBkb2Vzbid0IHVzZSB0aGUgY29ycmVjdCBkZXZpY2UgDQpu
dW1iZXIsIHRoZSBwcm9wZXIgZml4IGlzIGluIG15IGZsb2NrIGJyYW5jaC4NCg0KQnV0IEkn
bGwgc2VuZCBvdXQgYSB2MyBqdXN0IGluIGNhc2UuDQoNClRoYW5rcywNClF1DQo=
--------------sNcOsCLyI5PYPfxTAE8iatOA
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------sNcOsCLyI5PYPfxTAE8iatOA--

--------------oBlz1wsRZbkpNTNTWIVkUW1N--

--------------0LLmmkN9TGE8t5g9c02rHA7a
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmW6y+cFAwAAAAAACgkQwj2R86El/qhL
kwgAoeVVBiMMp6Cg8RVht4B8VDAydhtDqPJJ7vQXRdwI+7ZusrGRZkgaZFvdMsLOuWV+blAW8jRl
caanOrHCB00TLZseHApXWRqCKui3lOQt9ZQJcX2f6E/KNzKwwyQTiRbn88MOczaUIgznnAK5hk9w
+qRUgPZLytj2x8Lz6kiINkx5YDq5zbsmxtmSQIlHlmxFtVPC3bPELiTixWHGNqBhRl6O5ikrfBS7
ftvUZmZ/lmagHOfqh5RNpGCrCKcN/s6S5ckcipDIG5GCXJ1NC0FWeOWJ+Mt3lc+9IPiF56y37Xzl
i3WljQUWcA8wQGQtFT89UEGgl5+ZTaovY9+n/Ie2EA==
=zZoD
-----END PGP SIGNATURE-----

--------------0LLmmkN9TGE8t5g9c02rHA7a--

