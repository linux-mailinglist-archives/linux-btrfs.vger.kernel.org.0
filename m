Return-Path: <linux-btrfs+bounces-1672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512FD83A056
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 05:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEAB28A398
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 04:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A8BA5D;
	Wed, 24 Jan 2024 04:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fwE3r5/X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A86FBB
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706069012; cv=none; b=Z5HmVyWk3RbpxPVJ/j3FOIQNmiofpR4EhniPWemO7VwW/VaQiSRDKmXkby55CzTvlRImYZqbBxdvV+3f8eZvuXrP7y+Dhc50UW0eCeJbPDebiw76RiDeIPJMHrSY729H6a3Jndi8vvgdqsRHY/Ign6LngCiv8sJc54AdnCiJLvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706069012; c=relaxed/simple;
	bh=lnyMcFIgzZBO2OttWUZ8z4X9Pw479+KUAKNCTnZl9pM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CITdYSValxAepYtRGVqbVLy5/0Gk4hKopUggWX7fi8XgPiwr9roEyfNURPom+C4iEPFRC1viR/MF5rCmItlGMEkdp5qjcN1EfIQZjwnvljRjy6B67lLrJrmr/8L0gKfiqs73DCQvl9NhGNA4E6A4aMCMotWPI/zjS7+9EN1Jb9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fwE3r5/X; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf16f2445bso13326331fa.2
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 20:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706069007; x=1706673807; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:references:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnyMcFIgzZBO2OttWUZ8z4X9Pw479+KUAKNCTnZl9pM=;
        b=fwE3r5/XGjc9JxXXfQ00DIopZ0SY+4WwKHartBWuWpBwfteirMwKr/I+ENJlPuSkAE
         CxA1HiLRODjBs3GlIuEPmNeiBrFHYBmLofFMJPn+Fk9ev6Ht1i4M/QaWYvpBza0jHS0E
         pdOZZLgSY25Yc49/LPR7Wsf7PVwZj47pA83yaDagxHnnAUFCThIl6lZplYv8LdwJhUIO
         7kGWElUHyol8ug1cqn8hkdXYFGDWYZgPe0TQDk5Q5I6DEUOQANQNd+5EkJc5n9kpTIy1
         CzTi2gsVn8vA+rGwJQtqIK3RzJoyGN23K3R3drnjMKZUKePN1KK/qKCwr1a+HPMZl0ST
         ghgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706069007; x=1706673807;
        h=in-reply-to:autocrypt:content-language:references:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lnyMcFIgzZBO2OttWUZ8z4X9Pw479+KUAKNCTnZl9pM=;
        b=aFUaZBo7uD40TThmsKRR2WqjGpwLi1I9z8hyRNvPq5r+tMrkIXD4kkvHye2eJJNYF0
         8gfeKBVTKT7sB9lFK+s1V03HOenn/fpSdQ1E3i6HHimGb2ko6EsNArW1Ed43mKMoc1iM
         aUB7xgg26mBIBNgZtu2vC0AqEq07w4lX5f7zxxkNwENL9118qYJMwRSjH7HDOuG1yUlj
         ZBQ47eEQnohKOE7svxTm5cSHHs1dKrnjDit0oXeeU2lc7zasXu5osk8b7z2jZxGUDYCH
         vX5rKhNVOluz36kCZQh2AxNgH8OHtDZasj4QkhYFX0aRdFlQsY9lkbiweHljE4VkddT5
         SsQA==
X-Gm-Message-State: AOJu0YzciESDSBQQroS1RZ2w9LIlMYAs7HRPXn9mBf0fGHCAGHnAkHWa
	yh9NfXGA7ZMVs/6fLuIla3Pl0+/Gq2s30TD59MjnW/9R3IY0+y2c+y9QWZZmzuYyjtrvrz/dZYf
	9
X-Google-Smtp-Source: AGHT+IEJ9w6jmIIBQGrRqyIrS48PfmFpUR6bJ/qvwu48eqazI98iF9IHmHa3cYOPajq+ZRgKDUQ7lw==
X-Received: by 2002:a2e:a482:0:b0:2cc:9b9f:a97d with SMTP id h2-20020a2ea482000000b002cc9b9fa97dmr387288lji.102.1706069007507;
        Tue, 23 Jan 2024 20:03:27 -0800 (PST)
Received: from ?IPV6:2403:580d:bef6::b19? (2403-580d-bef6--b19.ip6.aussiebb.net. [2403:580d:bef6::b19])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f2d300b001d5f1005096sm9603577plc.55.2024.01.23.20.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 20:03:26 -0800 (PST)
Message-ID: <b521e943-ae86-4a6c-a470-072268b254a0@suse.com>
Date: Wed, 24 Jan 2024 14:33:22 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] btrfs: defrag: further preparation for multi-page
 sector size
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>
References: <cover.1706068026.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <cover.1706068026.git.wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fGOcLI9A0v9k0RSsASfHuR40"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fGOcLI9A0v9k0RSsASfHuR40
Content-Type: multipart/mixed; boundary="------------sIAiQMNCfy0yicCMo9tTlZS0";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>
Message-ID: <b521e943-ae86-4a6c-a470-072268b254a0@suse.com>
Subject: Re: [PATCH RFC 0/2] btrfs: defrag: further preparation for multi-page
 sector size
References: <cover.1706068026.git.wqu@suse.com>
In-Reply-To: <cover.1706068026.git.wqu@suse.com>

--------------sIAiQMNCfy0yicCMo9tTlZS0
Content-Type: multipart/mixed; boundary="------------qcfnikUxnoS2IOBeDyyVTs8c"

--------------qcfnikUxnoS2IOBeDyyVTs8c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QWRkaW5nIE1NIGxpc3QgdG8gdGhpcyBjb3ZlciBsZXR0ZXIuDQoNCk9uIDIwMjQvMS8yNCAx
NDoyOSwgUXUgV2VucnVvIHdyb3RlOg0KPiBXaXRoIHRoZSBmb2xpbyBpbnRlcmZhY2UsIGl0
J3MgbXVjaCBlYXNpZXIgdG8gc3VwcG9ydCBtdWx0aS1wYWdlIHNlY3Rvcg0KPiBzaXplIChh
a2EsIHNlY3Rvci9ibG9jayBzaXplID4gUEFHRV9TSVpFLCB3aGljaCBpcyByYXJlIGJldHdl
ZW4gbWFqb3INCj4gdXBzdHJlYW0gZmlsZXN5c3RlbXMpLg0KPiANCj4gVGhlIGJhc2ljIGlk
ZWEgaXMsIGlmIHdlIGZpcnN0bHkgY29udmVydCB0byBmdWxsIGZvbGlvIGludGVyZmFjZSwg
YW5kDQo+IGFsbG93IGFuIGFkZHJlc3Mgc3BhY2UgdG8gb25seSBhbGxvY2F0ZSBmb2xpbyB3
aGljaCBpcyBleGFjdGx5DQo+IGJsb2NrL3NlY3RvciBzaXplLCB0aGUgc3VwcG9ydCBmb3Ig
bXVsdGktcGFnZSB3b3VsZCBiZSBtb3N0bHkgZG9uZS4NCj4gDQo+IEJ1dCBiZWZvcmUgdGhh
dCBzdXBwb3J0LCB0aGVyZSBhcmUgc3RpbGwgcXVpdGUgc29tZSBjb252ZXJzaW9uIGxlZnQg
Zm9yDQo+IGJ0cmZzLg0KPiANCj4gRnVydGhlcm1vcmUsIHdpdGggYm90aCBzdWJwYWdlIGFu
ZCBtdWx0aXBhZ2Ugc2VjdG9yIHNpemUsIHdlIG5lZWQgdG8NCj4gaGFuZGxlIGZvbGlvIGRp
ZmZlcmVudDoNCj4gDQo+IC0gRm9yIHN1YnBhZ2UNCj4gICAgVGhlIGZvbGlvIHdvdWxkIGFs
d2F5cyBiZSBwYWdlIHNpemVkLg0KPiANCj4gLSBGb3IgbXVsdGlwYWdlIChhbmQgcmVndWxh
ciBzZWN0b3JzaXplID09IFBBR0VfU0laRSkNCj4gICAgVGhlIGZvbGlvIHdvdWxkIGJlIHNl
Y3RvciBzaXplZC4NCj4gDQo+IEZ1cnRoZXJtb3JlLCB0aGUgZmlsZW1hcCBpbnRlcmZhY2Ug
d291bGQgbWFrZSB2YXJpb3VzIHNoaWZ0cyBtb3JlDQo+IGNvbXBsZXguDQo+IEFzIGZpbGVt
YXBfKigpIGludGVyZmFjZXMgdXNlIGluZGV4IHdoaWNoIGlzIFBBR0VfU0hJRlQgYmFzZWQs
DQo+IG1lYW53aGlsZSB3aXRoIHBvdGVudGlhbCBsYXJnZXIgZm9saW8sIHRoZSBmb2xpbyBz
aGlmdCBjYW4gYmUgbGFyZ2VyDQo+IHRoYW4gUEFHRV9TSElGVC4NCg0KQXMgSSByZWFsbHkg
d2FudCBzb21lIGZlZWRiYWNrIG9uIHRoaXMgcGFydC4NCg0KSSdtIHByZXR0eSBzdXJlIHdl
IHdvdWxkIGhhdmUgc29tZSBmaWxlc3lzdGVtcyBnbyB1dGlsaXppbmcgbGFyZ2VyIA0KZm9s
aW9zIHRvIGltcGxlbWVudCB0aGVpciBtdWx0aS1wYWdlIGJsb2NrIHNpemUgc3VwcG9ydC4N
Cg0KVGh1cyBpbiB0aGF0IGNhc2UsIGNhbiB3ZSBoYXZlIGFuIGludGVyZmFjZSBjaGFuZ2Ug
dG8gbWFrZSBhbGwgZm9saW8gDQp2ZXJzaW9ucyBvZiBmaWxlbWFwXyooKSB0byBhY2NlcHQg
YSBmaWxlIG9mZnNldCBpbnN0ZWFkIG9mIHBhZ2UgaW5kZXg/DQoNClRoYW5rcywNClF1DQo=

--------------qcfnikUxnoS2IOBeDyyVTs8c
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEB
yR7fju3o8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1ep
nV55fJCThqij0MRL1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573a
WC5sgP7YsBOLK79H3tmUtz6b9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4
hrwQC8ipjXik6NKR5GDV+hOZkktU81G5gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT
0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEBAAHNIlF1IFdlbnJ1byA8cXV3
ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkIBwIGFQgJCgsCBBYC
AwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToHpgAKCRDC
PZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1
Koyt8gXQXPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF
72Lkz06TmaI0XMyjjgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+
/PLlV4nYs+DtSwPyNjkPX72+LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4Qnu
fARU51zyVjzTXMg5gAttDZwTH+8LbNI4mm2YwsCUBBMBCAA+AhsDBQsJCAcCBhUI
CQoLAgQWAgMBAh4BAheAFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVgp0FCQlm
Am4ACgkQwj2R86El/qgEfAf/eFQLEjcoMdQunYW9btVqdSa/5Xzu0CDiv539TxdF
aWI00NmrvIoX/0QKU52t9bFYwcd485ZqcvpQ6D3V8GyNws8dT8A23YQAI3UW7wZs
DOnFFsqg/s41ZuEUxqxUz4txO/NvGCe9VaXWtqoITmHZwuOcQnI5h4fBcEXi87Fd
gOhbV7L3fO26uiMNmsTh1VGsdhRkm2q3TLB68mtXQtoxdkep9LsWiHNW1hsHmLKt
C17y3L41h/sw4M2AlAdHH2/uiG/4qUgmKd4vAXrzLE7OtjDgZis+7YpemXc9JJKg
3UjTqvC4FhizsFE6gYe9fpajdlwaUw7tXi2WjW8UiIpWlcLAjgQTAQgAOAIbAwUL
CQgHAgYVCAkKCwIEFgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJd
nDWhAAoJEMI9kfOhJf6oJjoIAJ36Za7eiQbBEpeO7pui77tWSoJodN3JfBYVOyv7
/SXLmdR0O1PfIRWCA8ndU/vTCOWvFSM2MVvqIi8ZjGI86uinU0bAZi9CS2BGFoiE
Asbqs+hJICEY2PAZVHDSSbQ+Ug0Pb0FOP+VgST6NUzVgvRAuAATUAjeSuKGD+Wn9
9BPnfAuFHxhkgXwRNdsKVAbW8nRyWU+4QS958rFHKJNKMH4+yjNK9haFew94n4oq
MV6ft5sTmt5BM8XNIdy0J0+ehH/iNI+WdOWcS8t6pwNlO4p9B7WBas9569DOAK2A
EX9aMg54mzjWSWdjMLcPKa5CWYW5uyzSNKEs5bx5I45aEtHCwJQEEwEIAD4CGwMF
CwkIBwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUC
YoQ6bAUJDHEfvQAKCRDCPZHzoSX+qB9PB/9aSOzDs+ZySEXYT55dAqG/Dtz3PeJG
246KsKKrui4rMq1Up4OV+K62H8jkDqYDJzQzFjgRSVi0CCVyWDaVqpNTFQVMbPaO
wOrXpjSOatYX+4AY2DaIxbp0Eas/zl3ciPeSr+rKvXx6WcLlj4kUCwFjOdLYlMDk
gnv6oYOR+MSqRhSSgRCsL3tFixy8FcPWyT8J+ovtYBqXMSOXSndD5okAQL9eaS4Y
6wpaGhLWJIngOjWmV91xeWlPsynphKr5SZ2DJJAXo8dcedrpgJ1pfmHdIL63+4S9
XIsQaO6ACCLef9ixxFmGP6x+vM9yYXXyAymkWgFF5Q+qrlNVLlFrzdCxzRhRdSBX
ZW5ydW8gPHdxdUBzdXNlLmNvbT7CwJQEEwEIAD4CGwMFCwkIBwIGFQgJCgsCBBYC
AwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToHpgAKCRDC
PZHzoSX+qGqRB/96/8XGpTVzL8kTg6Ka5A62jj2wp1CyzzcMKeMCz9P5yl7wJYb0
Ww6csdfh7f94FqfipcPkvcwUHpsbvur+Z1/M58vJe0OpwDOSJ5C2g+1OTi0YCdDt
TDa/1EzgyBFcd7sw9l+jERAjIoEMbvXN1ykhC11Y0yWIEaxKPKNqm+8aCJ5OJpZX
o4tq0a6gYda0tKRHsSJlqYSYvl4Kd3cURh7DRhGyefvcivTXOa+uxGBuG8JvtOsl
U/GkEufGSNtgv1HiaT8HLGK3QAXIrHe3XXY+EEYVojuCMuTExlA+z3XyJEONIkXE
M1RC9QXonT/L/AuC1RppOLw9cBesU40ESn1xwsCUBBMBCAA+AhsDBQsJCAcCBhUI
CQoLAgQWAgMBAh4BAheAFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVgp0FCQlm
Am4ACgkQwj2R86El/qglXwgApyZV9LjpYUnoPof/h43/zZ0qBThtiWITUHNin4Tg
miIEqDt+HFPqodh5pHCBd0WQnHVPZM37vL8rYBsjXbowmoqOmbHrKUmKbPCSd2ME
fDHlrR4ah2nZ2qQl4JHIYbwR3Y0uK+Rw9RhoNYVIdOkuXV4gbiyYUk2YiCPgAW9L
iVrTzCZfwR6cytxwPz2z0rqH+Rrg4xy9f1DJgvTuANlRDRopTDkBbz4oXvwJEmKj
MhMdvcajzKAE7eqIqKGUxeKPEL3XsLIiHT7AVE1L8ol31PLmcGbzc2FskAwJAHHN
KPfN4JP6v2+HUpXlIKmAY0lvrR0u3hBMJY+NVoB+uXcWO8LAjQQTAQgAOAIbAwUL
CQgHAgYVCAkKCwIEFgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJd
nDWhAAoJEMI9kfOhJf6oZgoH90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tE
dVPaKlcnTNAvZKWSit8VuocjrOFbTLwbvZ43n5f/l/1QtwMgQei/RMY2XhW+toti
mzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9NvZAAYVV7GesyyFpZiNm7GLvL
mtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7J9pFgBrCn4hF83tP
H2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/kF2oxqZBE
Qrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx8LAlAQTAQgAPgIbAwUL
CQgHAgYVCAkKCwIEFgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJi
hDpsBQkMcR+9AAoJEMI9kfOhJf6ouo4IAJg2X/tgWBcYo2u8J/kYBkXY/rlsr6l7
LQfzJE6R5StDb30/I8XqHjGcebFXRhfJhU60QPzmY5Tfyy3jgwOfB+IWOjEE+1vO
SU+vJ21JQl3rIAXLCaPDd8RyYjMKi6NI3F0R+a805AvgigcK9QT3u9cszznpsTCg
0HszJR4alwC7IxZ1TXESkfL4pZKxV3o+RvwyrRNUdAUSivQvVnI6pl/uGcBO9hcE
P3fWTM+3L5vSVkrBXte+Nt5DaW5ZOnxuy4z6b3hYntmiGJh0VneB9gPUTWjsgThJ
e22u8vib/bNzwnjwMJ3DobY2S3uWrH9CFOHVLi/ZiRAhkHGCMVBu6i/NF1F1IFdl
bnJ1byA8d3F1QHN1c2UuZGU+wsCUBBMBCAA+AhsDBQsJCAcCBhUICQoLAgQWAgMB
Ah4BAheAFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmNNIlUFCQ06B6YACgkQwj2R
86El/qiCxQf/QeNgOApdVMY22eC5X5ukUqQuVUamvzT1BYQ5iisfLan7NaPJdUIn
Nm/jTsClwbAHG15/5hcu9pkUS16hS8SNgyUGzN0MCHgB+A+0AqPSIrV77T0LPeYB
rbOqn7ZE0nZryCC0w/7QYBrROLZFAOlp76/6kW8y9/kC1QOiD0nqKPw9BJcGgFUu
tI6af/2Lb3ZC7Q4dLAcERjv6QCf96qXVZShXddnqLtEKtKwHok09JB3Z/OhoMqyS
BPJPjdarKAtqKSS0y/Qy5W9/W7h973paa4CfvnrriZGyYb++UGhMXNWctJ+Mumf/
zlSSQlUBCkCYPo1CnsJLpBbNNpLCvqtwY8LAlAQTAQgAPgIbAwULCQgHAgYVCAkK
CwIEFgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJZ1YKdBQkJZgJu
AAoJEMI9kfOhJf6opZoH/3FKvZBUKOe+5LuYHOqxaVYOvLm5QcI2KcI8NG//8aPl
qNcJvkUW1BrPnY0mQKsNdg+Bd69JgUyO2m1AjVgGxZGGUgCBVYtAzJI8qSFUuz0m
hLdOKzPVQU06BPmKlOlhDXiee0dqdvoSNMGawcMTm3bHWjrcVrbKd25oSG3asUiq
7V7kWsMuCp0GHC7hsznHvaJHZWwBNFtyh5tYEKDQHuhV/JwvaqNeJvC6hG04WB/q
o+IgjJTfByH20seBd3u5x2flADFvhP5ZzEZCAfQ3/iclXfzZV8yI2QIIHFrKqceg
+MMgLnsSlpIhkHlHgK1DYoQMF45sqljxpo1ciIfqAujCwI4EEwEIADgCGwMFCwkI
BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1
oQAKCRDCPZHzoSX+qD0FB/9iFOGbSOp6k/yPRoVnMvk/5cRIiyl7PUbx5ETnymJj
lPZGdCv8kw919Fx9YB/5hQtRWOrMlFu1gKtezgOEw7rmoOkLDOezSeSVB7AiVs09
NmUKVjmZQEaJQ1ll1XN/CtBQhCSe9kf94nBfNuXqBG4avrfoLZfc53c5QXXD/fkF
jBMvvQOTOmlMkmkVcOvIoYaLnpAET6IC8VolsbIGB60n/22iBc3CQWIwx4sAIiNr
Um2u6VH+/3SDgb9+1GfKPz3gCB57MdTKfooDDszKzHw3KmPstRQ6kk4w47vc7Iag
SuQrV6bXVQIL4Hk7vhYjAmtUJLfXUEbwqpKuXIX7uG5EwsCUBBMBCAA+AhsDBQsJ
CAcCBhUICQoLAgQWAgMBAh4BAheAFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmKE
OmwFCQxxH70ACgkQwj2R86El/qiDSAgAnJqY47YUAmqmyIIoQMQgiv9fNP2zyh9S
lAKaZhNfYz44SVlm/2oDYcRObQPQC7Sado6rmjDFj74nLEIG4wVjDB+r0dOyBJNb
33aVACYE8G3xBlo6BYGAZGxR+elrpIQKdEU1rdERjnXCFUHin/i0NGotdpmXkBqe
2myqy7FTRAnVP9rji97Fi62AVNqQYFNTC90ziihhW+XOFL3arrlojS94RYS09GXN
NnMqmCacDSt64KmKogASaPFq+RL5nefbgc0C8J6MaOgnsJnjE5Kr7RiwEURaVnOR
EWl9S5sbSHIwMaRPTjYAHjXhDxnlFUJVrBlqsOWBGeZ82yjVfmvpK87ATQRZ1YGv
AQgAqlPrYeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS
49cZcE4KXk/kHw5hieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD
4/yK0VFJGuvDJR8T7RZwB69uVSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1w
NKV6yR9XzRkrEW/qShChyrS9fNN8e9c0MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwn
pdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/o6CAKLLcjU1Iwnkq1HSrYfY3
HZWpvV9g84gPwxwxX0uXquHxLwARAQABwsB8BBgBCAAmAhsMFiEELd9y5aWlW6id
qkLhwj2R86El/qgFAmNNIm4FCQ06B78ACgkQwj2R86El/qiurwf/csmZbEvoo7bL
8GA4xgNloVYTdO12uUgQbxggMnMhhs0jJDiXDrVFH7Q/gA8qy2y7lUn0TdZHu9/F
KI6YcJEhY+LfbHBuQPlPBoDmba5WDrGNvnBt0eb46F1IFzD9+yDX1odCmyaHX9Bu
PMaLnrJ9PHG31HZaYUjF7owgPMuU3Dckbjb9quTYs5fLCoVGc4eAWrHKCgwoQbs5
wbLnAkwBq8D4BuP7peh51hPA4qTCr5FfaG9cSUtluFiUT6ekHVawVifXAnbaUehm
y4kIttrmV6Ej7/9KFKxlPlOV+CL3Z70/vL4j87My+cF7MCWX6n8vLZhzPOcozm1X
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------qcfnikUxnoS2IOBeDyyVTs8c--

--------------sIAiQMNCfy0yicCMo9tTlZS0--

--------------fGOcLI9A0v9k0RSsASfHuR40
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmWwjAoFAwAAAAAACgkQwj2R86El/qjL
Zgf/VzG9A+ZS3IgkztU8AWCht9FRXMO0ZqloAOr/5OaSphC+vGw45hEiJ4y/5Ug4tr5bxAmgsQvR
xS4FmvIYxARvrp0R83UP8HanWxgnx6OlXBFOPwCxgKge3qMUEt+eZ8302/qxcQNXv7Gu8v7U103i
jxM8aC/R/XiASVX1I1ozescm/OkVTwgFxAMiyrMoNX24vKHPgp6oiWbT+LB4izEN5qsZzqj8dPuP
V4Xdyy4Aotcguu05riQzDr/6Ir4ZypVdWI07r3oBIEW5DWaDy6YGeJ4ybVQeBlMIopqyPseXP1tx
UtVXNV6iV/HowxJN2/MSx0DRLw5ZPauvkNo7B+X9dQ==
=KkDp
-----END PGP SIGNATURE-----

--------------fGOcLI9A0v9k0RSsASfHuR40--

