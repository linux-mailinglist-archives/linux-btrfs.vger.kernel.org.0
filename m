Return-Path: <linux-btrfs+bounces-1343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDF4829249
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 03:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E5F2B219FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 02:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D123FE4;
	Wed, 10 Jan 2024 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GOpFcTmF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7C3C35
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ccae380df2so38936061fa.1
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Jan 2024 18:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704852203; x=1705457003; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=02FMGT5TMLSNtbG7uY2JFd3BfDdJ+QADxrTioo4cyc8=;
        b=GOpFcTmFHmK5FkZW0Tl7rzfi3AU/IZkl6c9eeffExMylTbsXMhUyYtDMs9VMEeNJac
         MxQGTf6K85KODkTIFeGNmwHFk7LKlhQaE9WRGy0YdagoPh0ze4SsW2Cfp6JlCNZ8Ziee
         fX2D4AJez45eLdW+5pHmi6ZZjKw5c/MSrFqMKavQ7A2OeJg6ck2+6BIEBrm3CxnuI0t8
         34OSufiC6YzClxidyb6gnbAAX9dPh0X1kcOSuJMTNFpzKH8qNyQYDhLZW5+vmn/5IYLf
         kfmvPsSl+24AF4/UN71AaJaA3Mteywxnk3VYxdFc7aU+fYKD+aZQdTxwQ1jj7Bh8Nq9n
         c61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704852203; x=1705457003;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02FMGT5TMLSNtbG7uY2JFd3BfDdJ+QADxrTioo4cyc8=;
        b=pcI2loa9q2uTizyArVvdNXbHaTecA8Gpj5V8J4zx7O4FJwaRD9h2HxKXqGev+iGyhG
         e9GyyaQ6Udu0bdh3iJD4N0JZMLXU3gJOXco59/WxY+R+D9v8SMGQgDuq19D4pA+tOl/1
         KxOoyTZOzMIuu1EB3NnPu8be+FGI/RsvbGnS0e2Vs8281WJkYPhaSpIsWg3MglSLns0s
         FMvpUd9Hh89HyG2SNYIebLqWMhworNRrekgUQwId3CQEnxuQ7MGkpeDje0tTBCZqlTwT
         lAZR33eiT23QC/WmKcIyyQYsJaCVG9QyY7y77MqxWsZcYUbovTTsvEOfS/ypDH7oNlVb
         zlKw==
X-Gm-Message-State: AOJu0YxKiOKRnwuvx+SQX12p2bzfabIQQ2OFh/wStv3elY6vsT6vm2pB
	C/im8B50oFD6BSB0Ogmp5qYEWf4O+9Zy2A==
X-Google-Smtp-Source: AGHT+IHdfCNHZT+5EGBrm1abmZIS+0n+miEqahbRrdWpPOREcvNX253I0N9IOL9Sa3y7pSWsveOz+Q==
X-Received: by 2002:a2e:8551:0:b0:2cc:e91f:424f with SMTP id u17-20020a2e8551000000b002cce91f424fmr125397ljj.60.1704852203388;
        Tue, 09 Jan 2024 18:03:23 -0800 (PST)
Received: from ?IPV6:2001:4479:a607:b900::959? ([2001:4479:a607:b900::959])
        by smtp.gmail.com with ESMTPSA id n7-20020a1709026a8700b001cfc3f73920sm2408786plk.227.2024.01.09.18.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 18:03:22 -0800 (PST)
Message-ID: <e3c5ace5-4266-4a6a-9836-f58f5fff66fe@suse.com>
Date: Wed, 10 Jan 2024 12:33:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: zlib: fix and simplify the inline extent
 decompression
Content-Language: en-US
To: dsterba@suse.cz, kernel test robot <lkp@intel.com>
Cc: linux-btrfs@vger.kernel.org, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev
References: <29b7793e53e1cdd559ad212ee69cec211a3b4db2.1704704328.git.wqu@suse.com>
 <202401091012.pLm6PcKG-lkp@intel.com> <20240110015800.GP28693@twin.jikos.cz>
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
In-Reply-To: <20240110015800.GP28693@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xPaAAv7KcjA4Qo4UpYKRZMwK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xPaAAv7KcjA4Qo4UpYKRZMwK
Content-Type: multipart/mixed; boundary="------------IGGBYokLycadbAygE1Qwf6eL";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: dsterba@suse.cz, kernel test robot <lkp@intel.com>
Cc: linux-btrfs@vger.kernel.org, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev
Message-ID: <e3c5ace5-4266-4a6a-9836-f58f5fff66fe@suse.com>
Subject: Re: [PATCH 1/3] btrfs: zlib: fix and simplify the inline extent
 decompression
References: <29b7793e53e1cdd559ad212ee69cec211a3b4db2.1704704328.git.wqu@suse.com>
 <202401091012.pLm6PcKG-lkp@intel.com> <20240110015800.GP28693@twin.jikos.cz>
In-Reply-To: <20240110015800.GP28693@twin.jikos.cz>

--------------IGGBYokLycadbAygE1Qwf6eL
Content-Type: multipart/mixed; boundary="------------G7iJnmRvl1gcutR6fhgfoqbe"

--------------G7iJnmRvl1gcutR6fhgfoqbe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjQvMS8xMCAxMjoyOSwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPiBPbiBUdWUs
IEphbiAwOSwgMjAyNCBhdCAxMTowMjo1NEFNICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3
cm90ZToNCj4+IEhpIFF1LA0KPj4NCj4+IGtlcm5lbCB0ZXN0IHJvYm90IG5vdGljZWQgdGhl
IGZvbGxvd2luZyBidWlsZCB3YXJuaW5nczoNCj4+DQo+PiBbYXV0byBidWlsZCB0ZXN0IFdB
Uk5JTkcgb24ga2RhdmUvZm9yLW5leHRdDQo+PiBbYWxzbyBidWlsZCB0ZXN0IFdBUk5JTkcg
b24gbmV4dC0yMDI0MDEwOF0NCj4+IFtjYW5ub3QgYXBwbHkgdG8gbGludXMvbWFzdGVyIHY2
LjddDQo+PiBbSWYgeW91ciBwYXRjaCBpcyBhcHBsaWVkIHRvIHRoZSB3cm9uZyBnaXQgdHJl
ZSwga2luZGx5IGRyb3AgdXMgYSBub3RlLg0KPj4gQW5kIHdoZW4gc3VibWl0dGluZyBwYXRj
aCwgd2Ugc3VnZ2VzdCB0byB1c2UgJy0tYmFzZScgYXMgZG9jdW1lbnRlZCBpbg0KPj4gaHR0
cHM6Ly9naXQtc2NtLmNvbS9kb2NzL2dpdC1mb3JtYXQtcGF0Y2gjX2Jhc2VfdHJlZV9pbmZv
cm1hdGlvbl0NCj4+DQo+PiB1cmw6ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC1sYWIt
bGtwL2xpbnV4L2NvbW1pdHMvUXUtV2VucnVvL2J0cmZzLXpsaWItZml4LWFuZC1zaW1wbGlm
eS10aGUtaW5saW5lLWV4dGVudC1kZWNvbXByZXNzaW9uLzIwMjQwMTA4LTE3MTIwNg0KPj4g
YmFzZTogICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9rZGF2ZS9saW51eC5naXQgZm9yLW5leHQNCj4+IHBhdGNoIGxpbms6ICAgIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3IvMjliNzc5M2U1M2UxY2RkNTU5YWQyMTJlZTY5Y2VjMjExYTNi
NGRiMi4xNzA0NzA0MzI4LmdpdC53cXUlNDBzdXNlLmNvbQ0KPj4gcGF0Y2ggc3ViamVjdDog
W1BBVENIIDEvM10gYnRyZnM6IHpsaWI6IGZpeCBhbmQgc2ltcGxpZnkgdGhlIGlubGluZSBl
eHRlbnQgZGVjb21wcmVzc2lvbg0KPj4gY29uZmlnOiBpMzg2LWFsbG1vZGNvbmZpZyAoaHR0
cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjQwMTA5LzIwMjQwMTA5
MTAxMi5wTG02UGNLRy1sa3BAaW50ZWwuY29tL2NvbmZpZykNCj4+IGNvbXBpbGVyOiBDbGFu
Z0J1aWx0TGludXggY2xhbmcgdmVyc2lvbiAxNy4wLjYgKGh0dHBzOi8vZ2l0aHViLmNvbS9s
bHZtL2xsdm0tcHJvamVjdCA2MDA5NzA4YjQzNjcxNzFjY2RiZjRiNTkwNWNiNmE4MDM3NTNm
ZTE4KQ0KPj4gcmVwcm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKTogKGh0dHBzOi8vZG93
bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDI0MDEwOS8yMDI0MDEwOTEwMTIucExt
NlBjS0ctbGtwQGludGVsLmNvbS9yZXByb2R1Y2UpDQo+Pg0KPj4gSWYgeW91IGZpeCB0aGUg
aXNzdWUgaW4gYSBzZXBhcmF0ZSBwYXRjaC9jb21taXQgKGkuZS4gbm90IGp1c3QgYSBuZXcg
dmVyc2lvbiBvZg0KPj4gdGhlIHNhbWUgcGF0Y2gvY29tbWl0KSwga2luZGx5IGFkZCBmb2xs
b3dpbmcgdGFncw0KPj4gfCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBp
bnRlbC5jb20+DQo+PiB8IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1
aWxkLWFsbC8yMDI0MDEwOTEwMTIucExtNlBjS0ctbGtwQGludGVsLmNvbS8NCj4+DQo+PiBB
bGwgd2FybmluZ3MgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4+DQo+Pj4+IGZzL2J0
cmZzL3psaWIuYzo0MDI6MTU6IHdhcm5pbmc6IGZvcm1hdCBzcGVjaWZpZXMgdHlwZSAndW5z
aWduZWQgbG9uZycgYnV0IHRoZSBhcmd1bWVudCBoYXMgdHlwZSAnc2l6ZV90JyAoYWthICd1
bnNpZ25lZCBpbnQnKSBbLVdmb3JtYXRdDQo+PiAgICAgICA0MDEgfCAgICAgICAgICAgICAg
ICAgcHJfd2Fybl9yYXRlbGltaXRlZCgiQlRSRlM6IGluZmFsdGUgZmFpbGVkLCBkZWNvbXBy
ZXNzZWQ9JWx1IGV4cGVjdGVkPSVsdVxuIiwNCj4+ICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfn5+DQo+PiAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICV6dQ0KPj4gICAgICAgNDAyIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHRvX2NvcHksIGRlc3RsZW4pOw0KPj4gICAgICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF5+fn5+fn4NCj4gDQo+IFZhbGlkIHJlcG9ydCBidXQgSSBjYW4ndCByZXByb2R1Y2UgaXQu
IEJ1aWx0IHdpdGggY2xhbmcgMTcgYW5kDQo+IGV4cGxpY2l0bHkgZW5hYmxlZCAtV2Zvcm1h
dC4gV2UgaGF2ZSBhZGRpdGlvbmFsIHdhcm5pbmdzIGVuYWJsZWQgcGVyDQo+IGRpcmVjdG9y
eSBmcy9idHJmcy8gc28gd2UgY2FuIGFkZCAtV2Zvcm1hdCwgSSdkIGxpa2UgdG8ga25vdyB3
aGF0IEknbQ0KPiBtaXNzaW5nLCB3ZSd2ZSBoYWQgZml4dXBzIGZvciB0aGUgc2l6ZV90IHBy
aW50ayBmb3JtYXQgc28gaXQgd291bGQgbWFrZQ0KPiBzZW5zZSB0byBjYXRjaCBpdCBlYXJs
eS4NCg0KSSBndWVzcyBpdCdzIGR1ZSB0byB0aGUgcGxhdGZvcm0/IChUaGUgcmVwb3J0IGlz
IGZyb20gMzJiaXQgc3lzdGVtKS4NCg0KT3RoZXJ3aXNlIGl0J3MgaW5kZWVkIG15IGJhZCwg
Zm9yIG5vdyBJIGRvbid0IGV2ZW4gaGF2ZSBhIDMyYml0IFZNIHRvIA0KdmVyaWZ5LCB0aHVz
IG15IExTUCBkb2Vzbid0IHdhcm4gbWUgYWJvdXQgdGhlIGZvcm1hdC4NCg0KVGhhbmtzLA0K
UXUNCg==
--------------G7iJnmRvl1gcutR6fhgfoqbe
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------G7iJnmRvl1gcutR6fhgfoqbe--

--------------IGGBYokLycadbAygE1Qwf6eL--

--------------xPaAAv7KcjA4Qo4UpYKRZMwK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmWd+uUFAwAAAAAACgkQwj2R86El/qh4
1AgAmuSIT16Kf1rqpPCSd5qi8rwhKQEJQis1w76bCEdAmHSEA/+qzNTLAWQA3XDeVLEUDlB5ZcrW
ClW4eRO2zx58zj/M2k0XTOjNzOgIMbAz3DkfCW5gPimnF3Zu2CjmKDAMPN9jcRSuZ49T5QIvgTRo
nxAAiUqc5WQr3c3vvIuSgLzJbZt/l9q2yYn7DGYjni4mL573HdigUphVYm3lqww045NCaQHQP61J
azaX22lDq2nOM6sfa4FJj/x88vnw4+FjjL+ktrJ8T2qIqQXVmHghjanuYnBZsGcea7CsEibgSLwR
D5y9AFxYELGCSiKTnT9yY8PymHbvEE5jq65/yf674w==
=UPIO
-----END PGP SIGNATURE-----

--------------xPaAAv7KcjA4Qo4UpYKRZMwK--

