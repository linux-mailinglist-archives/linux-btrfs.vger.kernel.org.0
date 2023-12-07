Return-Path: <linux-btrfs+bounces-732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E88807E84
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 03:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CB028261F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 02:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B00525C;
	Thu,  7 Dec 2023 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AyadYj32"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8423AD4B
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 18:31:57 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9f099cf3aso2737361fa.1
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Dec 2023 18:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1701916316; x=1702521116; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBh9VE9MP3haXt2HDLSKGx38Mdnac1DipTkPhJkdM9k=;
        b=AyadYj32RbtgrFYtfZVub0qunkTPzXBYdcjspNqHhjUN6kxLtvnS0YHOf8mhi/QcyE
         SWO0HCdX4MNRRKiBiM5J4+WxfiaA42l1IElicC7HNw5N77iitJznJ8w6prJBol4CGL70
         47J4Ql7RHjFZ27PIqDZFDC92C0GnYYsAT1WDaR32BuW7tUPGEvUJ/4YJJ2cOq/WzqVcq
         xNc0w+T9p2cvVbDzuhEInpID1LdYGFPILvJ+1pwYiEs0Y8QdbsWxwty3xdhnAU4nC0Ne
         Owq/AXKAUIYgq7OtamhesQ9yqf+jOykaE0/S1IbAE6gsQ8Lwiu4U6GFIDdhTHK8ErNCk
         0OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701916316; x=1702521116;
        h=in-reply-to:autocrypt:from:references:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nBh9VE9MP3haXt2HDLSKGx38Mdnac1DipTkPhJkdM9k=;
        b=YWZ+r6WsArxdWYzSuxPfJ3zvhDOORgzN92AxQCBYMYNnlDaFplNrSOpihIN97o8Kpr
         iKdb028JpNLCLHn90xV9BnCTooP1vyJUuObiYmrYCV0iKP5e6SBRbGZ631bpgV2zfI7g
         W/OG10r9ywqTTljbdkw9oQbw8MvAXB8+0Hz9bPwC4zJWs8i3/eQTfmbWJPLA+Q87EwZU
         vr3Icn7KZDfC+4uZwBIh6Vs3EWYYBT3dlYcGujU+cb0W6fzrf2V6KgmKs4RdzoW3c47O
         9tYBZdmLl53xQ5bxzHdCe6XDS/RnTzhdr08/S980KEZdedacTGj78FtMoI2jAXsS36EM
         vNsQ==
X-Gm-Message-State: AOJu0YwNBeEnDFwlpg3dvPsDNvEC8lUxwQixbSe/BMWtF1cResIq1YSn
	zuCMQaS/ZNsCPXTcBBC42e5ceQ==
X-Google-Smtp-Source: AGHT+IHhF1syb7EUNrHEh2NZXbXqAd67Rhmgup/yHiKzyQcJE2oRhZHwLAAxlh3jnFmtrSdC26LLtg==
X-Received: by 2002:a2e:88cb:0:b0:2ca:1990:2578 with SMTP id a11-20020a2e88cb000000b002ca19902578mr1080677ljk.103.1701916315712;
        Wed, 06 Dec 2023 18:31:55 -0800 (PST)
Received: from [172.16.0.153] (122-151-37-21.sta.wbroadband.net.au. [122.151.37.21])
        by smtp.gmail.com with ESMTPSA id jd3-20020a170903260300b001d06b63bb98sm153538plb.71.2023.12.06.18.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 18:31:55 -0800 (PST)
Message-ID: <19fc847b-7df6-41fc-ad52-f4e7f6d13201@suse.com>
Date: Thu, 7 Dec 2023 13:01:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: drop unused memparse() parameter
Content-Language: en-US
To: David Disseldorp <ddiss@suse.de>, linux-btrfs@vger.kernel.org
References: <20231205111329.6652-1-ddiss@suse.de>
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
In-Reply-To: <20231205111329.6652-1-ddiss@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------R9zwSvb00trOPqarF0M0SrIh"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------R9zwSvb00trOPqarF0M0SrIh
Content-Type: multipart/mixed; boundary="------------peccza4mqkJkYP7T00Ylm1zl";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: David Disseldorp <ddiss@suse.de>, linux-btrfs@vger.kernel.org
Message-ID: <19fc847b-7df6-41fc-ad52-f4e7f6d13201@suse.com>
Subject: Re: [PATCH] btrfs: drop unused memparse() parameter
References: <20231205111329.6652-1-ddiss@suse.de>
In-Reply-To: <20231205111329.6652-1-ddiss@suse.de>

--------------peccza4mqkJkYP7T00Ylm1zl
Content-Type: multipart/mixed; boundary="------------cum7loiUqG4bA0HlmRWPtKxu"

--------------cum7loiUqG4bA0HlmRWPtKxu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjMvMTIvNSAyMTo0MywgRGF2aWQgRGlzc2VsZG9ycCB3cm90ZToNCj4gVGhl
IEByZXRwdHIgcGFyYW1ldGVyIGZvciBtZW1wYXJzZSgpIGlzIG9wdGlvbmFsLg0KPiBidHJm
c19kZXZpbmZvX3NjcnViX3NwZWVkX21heF9zdG9yZSgpIGRvZXNuJ3QgdXNlIGl0IGZvciBh
bnkgaW5wdXQNCj4gdmFsaWRhdGlvbiwgc28gdGhlIHBhcmFtZXRlciBjYW4gYmUgZHJvcHBl
ZC4NCg0KVG8gbWUsIEkgYmVsaWV2ZSBpdCdzIGJldHRlciB0byBjb21wbGV0ZWx5IGdldCBy
aWQgb2YgbWVtcGFyc2UoKS4NCg0KQXMgeW91IGFscmVhZHkgZm91bmQgb3V0LCBzb21lIHN1
ZmZpeCwgZXNwZWNpYWxseSAiZXxFIiBjYW4gc2NyZXcgdXAgdGhlIA0KcmVzdWx0Lg0KRS5n
LiAiMjVlIiB3b3VsZCBiZSBpbnRlcnByZXRlZCBhcyAyNSB3aXRoICJlIiBhcyBzdWZmaXgs
IHdoaWNoIGlzIGZpbmUgDQphY2NvcmRpbmcgdG8gdGhlIHJ1bGUuICh3aXRob3V0IHByZWZp
eCwgdGhlIGJhc2UgaXMgMTAsIHNvIG9ubHkgIjI1IiBpcyANCnZhbGlkLiBUaGVuIHRoZSBy
ZW1haW5pbmcgcGFydCBpcyBpbnRlcnByZXRlZCBhcyBzdWZmaXgpLg0KDQpBbmQgc2luY2Ug
YnRyZnMgaXMgbm90IGdvaW5nIHRvIGRvIHByZXR0eSBzaXplIG91dHB1dCBmb3Igc3lzZnMg
KGFzIG1vc3QgDQpzeXNmcyBpcyBub3QgZGlyZWN0bHkgZm9yIGVuZCB1c2VycywgYW5kIHdl
IG5lZWQgYWNjdXJhdGUgb3V0cHV0KSwgdG8gYmUgDQpjb25zaXN0ZW50IHRoZXJlIGlzbid0
IG11Y2ggbmVlZCBmb3Igc3VmZml4IGhhbmRsaW5nIGVpdGhlci4NCg0KU28gY2FuJ3Qgd2Ug
anVzdCByZXBsYWNlIG1lbXBhcnNlKCkgd2l0aCBrc3RydG91bGwoKT8NCg0KVGhhbmtzLA0K
UXUNCg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBEaXNzZWxkb3JwIDxkZGlzc0Bz
dXNlLmRlPg0KPiAtLS0NCj4gICBmcy9idHJmcy9zeXNmcy5jIHwgMyArLS0NCj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZnMvYnRyZnMvc3lzZnMuYyBiL2ZzL2J0cmZzL3N5c2ZzLmMNCj4gaW5kZXgg
ZTZiNTFmYjNkZGMxZS4uNzVmM2I3NzRhNGQ4MyAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMv
c3lzZnMuYw0KPiArKysgYi9mcy9idHJmcy9zeXNmcy5jDQo+IEBAIC0xNzc5LDEwICsxNzc5
LDkgQEAgc3RhdGljIHNzaXplX3QgYnRyZnNfZGV2aW5mb19zY3J1Yl9zcGVlZF9tYXhfc3Rv
cmUoc3RydWN0IGtvYmplY3QgKmtvYmosDQo+ICAgew0KPiAgIAlzdHJ1Y3QgYnRyZnNfZGV2
aWNlICpkZXZpY2UgPSBjb250YWluZXJfb2Yoa29iaiwgc3RydWN0IGJ0cmZzX2RldmljZSwN
Cj4gICAJCQkJCQkgICBkZXZpZF9rb2JqKTsNCj4gLQljaGFyICplbmRwdHI7DQo+ICAgCXVu
c2lnbmVkIGxvbmcgbG9uZyBsaW1pdDsNCj4gICANCj4gLQlsaW1pdCA9IG1lbXBhcnNlKGJ1
ZiwgJmVuZHB0cik7DQo+ICsJbGltaXQgPSBtZW1wYXJzZShidWYsIE5VTEwpOw0KPiAgIAlX
UklURV9PTkNFKGRldmljZS0+c2NydWJfc3BlZWRfbWF4LCBsaW1pdCk7DQo+ICAgCXJldHVy
biBsZW47DQo+ICAgfQ0K
--------------cum7loiUqG4bA0HlmRWPtKxu
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------cum7loiUqG4bA0HlmRWPtKxu--

--------------peccza4mqkJkYP7T00Ylm1zl--

--------------R9zwSvb00trOPqarF0M0SrIh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmVxLpYFAwAAAAAACgkQwj2R86El/qjQ
eQf9FbfOfB/VS1bpQgzhCBM28IoP+E1yDfQ681NCrEdWNkvEjKdYNaldu284K6/6/jn4RSB5LmMk
5HumKj64PM6ttGib1GcmuCeGGguyPb955TTxCEKWPC6z1niWD5iymlvl4/XxpiG4MWR8SRwsPl8N
u7uGjc1rqgQ93G+Fw3Yg/ODPkr/TKWI0iki+OSy+6MFs+BjD7MU6npDJENtrgWHw31oqlG3/crob
+a+trGiucCmEDivvhhnwP3rW36hQu84GlAhqZe0uCgf46HHFfLZm75n9znswyKrm/0nKcxWL3U8h
K47JAMxaoVxRxZF44MRbAC/uHAkifTK3YfmBo7sMcA==
=Bqme
-----END PGP SIGNATURE-----

--------------R9zwSvb00trOPqarF0M0SrIh--

