Return-Path: <linux-btrfs+bounces-1346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA45E829276
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 03:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E61F1C24240
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 02:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E15A23DB;
	Wed, 10 Jan 2024 02:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C2YvSDL7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A747F9
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ccec119587so42450541fa.0
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Jan 2024 18:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704854053; x=1705458853; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1OUNDdyGhpE/W8xySdiZk68cZqIZX+1r4TAxCQFkvQ0=;
        b=C2YvSDL7wKGt9NOdDIEB5wZWhH4CnI/4uWYUPuJCFs2anujYVnygJz2h/uhXo2dIiN
         4lNqW+xieU4r2c0Y8swl/YqZ1tLfAg9RFMr9TpNqebmC3pSXkMh6qCiZmo+kuvnc8e0O
         DXoS4UTvnDGcIVGtqnoTmhxV3QnReJUIUUMPdKprWks8G6ppSkdfNOlcpmanIg2nC/XJ
         frADBjSTIYhkC7tb9mkTBGI+zciD97TzlTcAR91T1CKF5b5+qcgfk6NDkrOZW28KNwLS
         GkU2MKlnhGHT2djQstSXWWvfNtgLlW2NFeXf51Ehx99oR7Pnj620l+YLyYdNVW0mz5gK
         otWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704854053; x=1705458853;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1OUNDdyGhpE/W8xySdiZk68cZqIZX+1r4TAxCQFkvQ0=;
        b=ovf0iks6tdTJayD5IJMxHyeQG+OXS2Y48Hns/bb2GmSsEQw7UVU2B9ryN2sH2190jr
         fcEudyp7rI0JFQa3tGfXJBzDs6JSvH1SsHQI3yJPWvGCbb9pIRsNAl6kf7VcA33p20B6
         7vuG8AENt78yCFVVVAO69hukRD5i8976F085ppJMDfxe1Nr3i3ePY7Mt1YIJ/zzdv4Cx
         ImDDnCyiO3TCCs2yPCRMELnWtNsyrjtiRUPlV4a+SZrEa3xtalIk0b0jHq1LA/Ny7OvH
         8ylBX//VsVWvz/0JdI7/AhzXRc7LPI7Uqedi6CyGC2hYaBA+SykDH4btg0n9rhT1TAuw
         4paw==
X-Gm-Message-State: AOJu0Ywao5MjHzCYcPrj+Zfsi69qtDCFw9/wqGmmbwQn4oUdFTtP6szD
	5M3jP27xqi3YjzN6qw4XBvYbemWjipvi2g==
X-Google-Smtp-Source: AGHT+IHI1+k073q7Y7gVbo+fegQC/n1MjUcePYftyREZCkEo39iVSZln9Q2ZrQHI8TKsobggb4M1MA==
X-Received: by 2002:a2e:7804:0:b0:2cd:5a63:81a7 with SMTP id t4-20020a2e7804000000b002cd5a6381a7mr155806ljc.1.1704854052714;
        Tue, 09 Jan 2024 18:34:12 -0800 (PST)
Received: from ?IPV6:2001:4479:a607:b900::959? ([2001:4479:a607:b900::959])
        by smtp.gmail.com with ESMTPSA id gv9-20020a17090b11c900b0028ceafb9124sm208131pjb.51.2024.01.09.18.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 18:34:12 -0800 (PST)
Message-ID: <3fdafc03-91e6-4c36-9d10-417c07222d0b@suse.com>
Date: Wed, 10 Jan 2024 13:04:06 +1030
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
To: dsterba@suse.cz
Cc: kernel test robot <lkp@intel.com>, linux-btrfs@vger.kernel.org,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
References: <29b7793e53e1cdd559ad212ee69cec211a3b4db2.1704704328.git.wqu@suse.com>
 <202401091012.pLm6PcKG-lkp@intel.com> <20240110015800.GP28693@twin.jikos.cz>
 <e3c5ace5-4266-4a6a-9836-f58f5fff66fe@suse.com>
 <20240110022643.GQ28693@twin.jikos.cz>
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
In-Reply-To: <20240110022643.GQ28693@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gm62RtnEHBXEDXpY8GST5tyo"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gm62RtnEHBXEDXpY8GST5tyo
Content-Type: multipart/mixed; boundary="------------vT9vVjaOBvAzku0ip00N1fYC";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: dsterba@suse.cz
Cc: kernel test robot <lkp@intel.com>, linux-btrfs@vger.kernel.org,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Message-ID: <3fdafc03-91e6-4c36-9d10-417c07222d0b@suse.com>
Subject: Re: [PATCH 1/3] btrfs: zlib: fix and simplify the inline extent
 decompression
References: <29b7793e53e1cdd559ad212ee69cec211a3b4db2.1704704328.git.wqu@suse.com>
 <202401091012.pLm6PcKG-lkp@intel.com> <20240110015800.GP28693@twin.jikos.cz>
 <e3c5ace5-4266-4a6a-9836-f58f5fff66fe@suse.com>
 <20240110022643.GQ28693@twin.jikos.cz>
In-Reply-To: <20240110022643.GQ28693@twin.jikos.cz>

--------------vT9vVjaOBvAzku0ip00N1fYC
Content-Type: multipart/mixed; boundary="------------moB1ghXtwQlAlfxYwJii2QtU"

--------------moB1ghXtwQlAlfxYwJii2QtU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjQvMS8xMCAxMjo1NiwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPiBPbiBXZWQs
IEphbiAxMCwgMjAyNCBhdCAxMjozMzoxN1BNICsxMDMwLCBRdSBXZW5ydW8gd3JvdGU6DQo+
Pg0KPj4NCj4+IE9uIDIwMjQvMS8xMCAxMjoyOSwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPj4+
IE9uIFR1ZSwgSmFuIDA5LCAyMDI0IGF0IDExOjAyOjU0QU0gKzA4MDAsIGtlcm5lbCB0ZXN0
IHJvYm90IHdyb3RlOg0KPj4+PiBIaSBRdSwNCj4+Pj4NCj4+Pj4ga2VybmVsIHRlc3Qgcm9i
b3Qgbm90aWNlZCB0aGUgZm9sbG93aW5nIGJ1aWxkIHdhcm5pbmdzOg0KPj4+Pg0KPj4+PiBb
YXV0byBidWlsZCB0ZXN0IFdBUk5JTkcgb24ga2RhdmUvZm9yLW5leHRdDQo+Pj4+IFthbHNv
IGJ1aWxkIHRlc3QgV0FSTklORyBvbiBuZXh0LTIwMjQwMTA4XQ0KPj4+PiBbY2Fubm90IGFw
cGx5IHRvIGxpbnVzL21hc3RlciB2Ni43XQ0KPj4+PiBbSWYgeW91ciBwYXRjaCBpcyBhcHBs
aWVkIHRvIHRoZSB3cm9uZyBnaXQgdHJlZSwga2luZGx5IGRyb3AgdXMgYSBub3RlLg0KPj4+
PiBBbmQgd2hlbiBzdWJtaXR0aW5nIHBhdGNoLCB3ZSBzdWdnZXN0IHRvIHVzZSAnLS1iYXNl
JyBhcyBkb2N1bWVudGVkIGluDQo+Pj4+IGh0dHBzOi8vZ2l0LXNjbS5jb20vZG9jcy9naXQt
Zm9ybWF0LXBhdGNoI19iYXNlX3RyZWVfaW5mb3JtYXRpb25dDQo+Pj4+DQo+Pj4+IHVybDog
ICAgaHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1sa3AvbGludXgvY29tbWl0cy9RdS1X
ZW5ydW8vYnRyZnMtemxpYi1maXgtYW5kLXNpbXBsaWZ5LXRoZS1pbmxpbmUtZXh0ZW50LWRl
Y29tcHJlc3Npb24vMjAyNDAxMDgtMTcxMjA2DQo+Pj4+IGJhc2U6ICAgaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQva2RhdmUvbGludXguZ2l0IGZv
ci1uZXh0DQo+Pj4+IHBhdGNoIGxpbms6ICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MjliNzc5M2U1M2UxY2RkNTU5YWQyMTJlZTY5Y2VjMjExYTNiNGRiMi4xNzA0NzA0MzI4Lmdp
dC53cXUlNDBzdXNlLmNvbQ0KPj4+PiBwYXRjaCBzdWJqZWN0OiBbUEFUQ0ggMS8zXSBidHJm
czogemxpYjogZml4IGFuZCBzaW1wbGlmeSB0aGUgaW5saW5lIGV4dGVudCBkZWNvbXByZXNz
aW9uDQo+Pj4+IGNvbmZpZzogaTM4Ni1hbGxtb2Rjb25maWcgKGh0dHBzOi8vZG93bmxvYWQu
MDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDI0MDEwOS8yMDI0MDEwOTEwMTIucExtNlBjS0ct
bGtwQGludGVsLmNvbS9jb25maWcpDQo+Pj4+IGNvbXBpbGVyOiBDbGFuZ0J1aWx0TGludXgg
Y2xhbmcgdmVyc2lvbiAxNy4wLjYgKGh0dHBzOi8vZ2l0aHViLmNvbS9sbHZtL2xsdm0tcHJv
amVjdCA2MDA5NzA4YjQzNjcxNzFjY2RiZjRiNTkwNWNiNmE4MDM3NTNmZTE4KQ0KPj4+PiBy
ZXByb2R1Y2UgKHRoaXMgaXMgYSBXPTEgYnVpbGQpOiAoaHR0cHM6Ly9kb3dubG9hZC4wMS5v
cmcvMGRheS1jaS9hcmNoaXZlLzIwMjQwMTA5LzIwMjQwMTA5MTAxMi5wTG02UGNLRy1sa3BA
aW50ZWwuY29tL3JlcHJvZHVjZSkNCj4+Pj4NCj4+Pj4gSWYgeW91IGZpeCB0aGUgaXNzdWUg
aW4gYSBzZXBhcmF0ZSBwYXRjaC9jb21taXQgKGkuZS4gbm90IGp1c3QgYSBuZXcgdmVyc2lv
biBvZg0KPj4+PiB0aGUgc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRkIGZvbGxvd2lu
ZyB0YWdzDQo+Pj4+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPg0KPj4+PiB8IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1
aWxkLWFsbC8yMDI0MDEwOTEwMTIucExtNlBjS0ctbGtwQGludGVsLmNvbS8NCj4+Pj4NCj4+
Pj4gQWxsIHdhcm5pbmdzIChuZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6DQo+Pj4+DQo+Pj4+
Pj4gZnMvYnRyZnMvemxpYi5jOjQwMjoxNTogd2FybmluZzogZm9ybWF0IHNwZWNpZmllcyB0
eXBlICd1bnNpZ25lZCBsb25nJyBidXQgdGhlIGFyZ3VtZW50IGhhcyB0eXBlICdzaXplX3Qn
IChha2EgJ3Vuc2lnbmVkIGludCcpIFstV2Zvcm1hdF0NCj4+Pj4gICAgICAgIDQwMSB8ICAg
ICAgICAgICAgICAgICBwcl93YXJuX3JhdGVsaW1pdGVkKCJCVFJGUzogaW5mYWx0ZSBmYWls
ZWQsIGRlY29tcHJlc3NlZD0lbHUgZXhwZWN0ZWQ9JWx1XG4iLA0KPj4+PiAgICAgICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn4NCj4+Pj4gICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJXp1DQo+Pj4+ICAgICAgICA0
MDIgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdG9fY29weSwg
ZGVzdGxlbik7DQo+Pj4+ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fg0KPj4+DQo+Pj4gVmFsaWQgcmVwb3J0
IGJ1dCBJIGNhbid0IHJlcHJvZHVjZSBpdC4gQnVpbHQgd2l0aCBjbGFuZyAxNyBhbmQNCj4+
PiBleHBsaWNpdGx5IGVuYWJsZWQgLVdmb3JtYXQuIFdlIGhhdmUgYWRkaXRpb25hbCB3YXJu
aW5ncyBlbmFibGVkIHBlcg0KPj4+IGRpcmVjdG9yeSBmcy9idHJmcy8gc28gd2UgY2FuIGFk
ZCAtV2Zvcm1hdCwgSSdkIGxpa2UgdG8ga25vdyB3aGF0IEknbQ0KPj4+IG1pc3NpbmcsIHdl
J3ZlIGhhZCBmaXh1cHMgZm9yIHRoZSBzaXplX3QgcHJpbnRrIGZvcm1hdCBzbyBpdCB3b3Vs
ZCBtYWtlDQo+Pj4gc2Vuc2UgdG8gY2F0Y2ggaXQgZWFybHkuDQo+Pg0KPj4gSSBndWVzcyBp
dCdzIGR1ZSB0byB0aGUgcGxhdGZvcm0/IChUaGUgcmVwb3J0IGlzIGZyb20gMzJiaXQgc3lz
dGVtKS4NCj4gDQo+IEFoIEkgc2VlLCBJIGJ1aWxkIG9uIDY0Yml0IHBsYXRmb3JtIGJ1dCBz
aG91bGQgdGhlIFdmb3JtYXQgd2FybmluZyBhbHNvDQo+IHBvaW50IG91dCBtaXNtYXRjaCB0
aGVyZT8gVGhlIHNpemVfdCB0eXBlIGlzIGFuIGFsaWFzIG9mIHVuc2lnbmVkIGxvbmcNCj4g
c28gaXQgaXMgbm90IGFuIGVycm9yIGJ1dCB3aGVuIHNpemVfdCBhbmQgJXp1IGRvbid0IG1h
dGNoIGNvdWxkIGJlIGENCj4gcGxhdGZvcm0taW5kZXBlbmRlbnQgZXJyb3IsIG5vPyBUaGlz
IHdvdWxkIHNhdmUgdXMgcmVwb3J0cyBhbmQgZm9sbG93dXANCj4gZml4dXBzIHJvdW5kdHJp
cHMuDQoNCnNpemVfdCBpcyBkZWZpbmVkIGRpZmZlcmVudGx5LCBpbiBpbmNsdWRlL3VhcGkv
YXNtLWdlbmVyaWMvcG9zaXhfdHlwZXMuaDoNCg0KLyoNCiAgKiBNb3N0IDMyIGJpdCBhcmNo
aXRlY3R1cmVzIHVzZSAidW5zaWduZWQgaW50IiBzaXplX3QsDQogICogYW5kIGFsbCA2NCBi
aXQgYXJjaGl0ZWN0dXJlcyB1c2UgInVuc2lnbmVkIGxvbmciIHNpemVfdC4NCiAgKi8NCiNp
Zm5kZWYgX19rZXJuZWxfc2l6ZV90DQojaWYgX19CSVRTX1BFUl9MT05HICE9IDY0DQp0eXBl
ZGVmIHVuc2lnbmVkIGludCAgICBfX2tlcm5lbF9zaXplX3Q7DQp0eXBlZGVmIGludCAgICAg
ICAgICAgICBfX2tlcm5lbF9zc2l6ZV90Ow0KdHlwZWRlZiBpbnQgICAgICAgICAgICAgX19r
ZXJuZWxfcHRyZGlmZl90Ow0KI2Vsc2UNCnR5cGVkZWYgX19rZXJuZWxfdWxvbmdfdCBfX2tl
cm5lbF9zaXplX3Q7DQp0eXBlZGVmIF9fa2VybmVsX2xvbmdfdCBfX2tlcm5lbF9zc2l6ZV90
Ow0KdHlwZWRlZiBfX2tlcm5lbF9sb25nX3QgX19rZXJuZWxfcHRyZGlmZl90Ow0KI2VuZGlm
DQojZW5kaWYNCg0KVGh1cyB0aGlzIGlzIHRoZSByZWFzb24gd2h5IHdlIG5lZWQgQHp1IGZv
ciBzaXplX3QgdG8gaGFuZGxlIHRoZSANCmRpZmZlcmVuY2UsIGFuZCBzaW5jZSBmb3IgNjRi
aXQgaXQncyBqdXN0IHVuc2lnbmVkIGxvbmcsIHRodXMgY29tcGlsZXIgDQp3b24ndCBnaXZl
IGFueSB3YXJuaW5nLg0KDQooVGhhdCdzIGFsc28gd2h5IEkgdGVuZCB0byBub3QgdXNlIHNp
emVfdCBhdCBhbGwsIGFuZCB3aHkgSSBsaWtlIHJ1c3QncyANCmV4cGxpY2l0IHNpemVkIHR5
cGUsIGFuZCB3ZSBtYXkgd2FudCB0byBnbyB0aGF0IHBhdGggdG8gcHJlZmVyIA0KdTgvdTE2
L3UzMi91NjQgd2hlbiBwb3NzaWJsZSkNCg0KVGhhbmtzLA0KUXUNCj4gDQo+PiBPdGhlcndp
c2UgaXQncyBpbmRlZWQgbXkgYmFkLCBmb3Igbm93IEkgZG9uJ3QgZXZlbiBoYXZlIGEgMzJi
aXQgVk0gdG8NCj4+IHZlcmlmeSwgdGh1cyBteSBMU1AgZG9lc24ndCB3YXJuIG1lIGFib3V0
IHRoZSBmb3JtYXQuDQo+IA0KPiBZZWFoLCBpdCBjb3VsZC9zaG91bGQgdGhvdWdoLg0K
--------------moB1ghXtwQlAlfxYwJii2QtU
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------moB1ghXtwQlAlfxYwJii2QtU--

--------------vT9vVjaOBvAzku0ip00N1fYC--

--------------gm62RtnEHBXEDXpY8GST5tyo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmWeAh4FAwAAAAAACgkQwj2R86El/qj8
/Af9HwERwzY6+/CFoMasesCkVvoFkX/6S5Qk5d+itMfCBTvmPOnAnUVToZeWsrlGfAl2KESiQeJF
/E+V024PkV5JfPHljs4McCUPE4u8m1NdRBplV+gdlgXtf58xeRIC78eVC0fAFW05/u9nE61DwLBR
py8K1OHHm8/ITKCnPlTdiEdNHHft/fqGFPZw8mtRzNJP0hevFgIu1h+MPYjclR9oO3VkHE0y4NqB
dk+MdGCuJn9mKzeRjl/swhr14Q8lvjN2MKAMAGwXgvqTbgXta03PgqS48KkHr+ff58SUcYhRKqgd
jucLfdWxsogzriBCcIxQD5jP9CFjKfjq4Is6souEOw==
=75IG
-----END PGP SIGNATURE-----

--------------gm62RtnEHBXEDXpY8GST5tyo--

