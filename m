Return-Path: <linux-btrfs+bounces-767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA2B80AEB3
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 22:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06A41C2089B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 21:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178D557891;
	Fri,  8 Dec 2023 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L1IT6CXC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648C2198A
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 13:14:42 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ca0f21e48cso31707101fa.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Dec 2023 13:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702070080; x=1702674880; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dQ+fGPJx1u+tmmAjjWUkTH9WqPokWan19RJOORs/jkw=;
        b=L1IT6CXCViSfJDnbJCReyHoKqmgaLq8Ejlp2gMEGJXO4C0HvYd/MIEF0Q6pyHDKauv
         3YRbwJ6sbjAhMrYobD/y7iyptQXZXwXNK6twz1DBWIGlR5cxW81VrMYWExzH9dqkK6gc
         YDeiftpGcxXqtb589zRJr/cIH7TDpqofXdW0wtOWpwvz43GnheDMGWQpzAgnunFQayut
         mirvJPajylIP7qt4MHzfLv/4tn65ruRDhUWYYpsxqIxEjajSeuC7Lad3lRlR4eQW/1m5
         oYVipgtdNNwNrOM0kQpyf8j9PaYJv/YRdx0u6y3C9C1avYKoDT8pWvshBmP8611CPgtF
         +lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702070080; x=1702674880;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQ+fGPJx1u+tmmAjjWUkTH9WqPokWan19RJOORs/jkw=;
        b=UlhWqYpxcu36XDyvLZlX/CDfkS2Vmh73Gb7/JEnX3E1So6JOFC1CnE3tESFoKnjJyi
         lFIBZnmwL/0udRPxU+CGueLirpj/O2cOsjqnqBduu5Be4D+T49Xua59Nhn+sKkJfxfOc
         MkAZHyd1/r1AxDWIcbu/rMxyghuf1dZafhKkmdh1lslmp6Zas5vo+7IzNRAQpgjT1isl
         suI7rRcrOdwI4CfyhYDcyVY1e+rAnWQZwzd4LNKejuh90jefJ/QOVTQaTTLe1gU+BA6g
         NHKZ1yo6lJwL3NNn6Uo9p29m1s9EQ3jz3ok0EujYA4q0Tetwq5lGBG0HGAL3n9lFsD3L
         Hmhg==
X-Gm-Message-State: AOJu0YzZ2sgM+f38mIid4f6/EBJnOjYRiqJAaOb2Ey/pQ2o892unhQny
	ABNJWc86qFGabDcoLWVwLhQGzw==
X-Google-Smtp-Source: AGHT+IE5B0k07zzOpb9uCIn7I4+PCoJvclj4m607bZgWn8O7L5egjTZhy4jPkOND8ntxTvQQiwYGlw==
X-Received: by 2002:a2e:80c2:0:b0:2c9:f0a3:d126 with SMTP id r2-20020a2e80c2000000b002c9f0a3d126mr271494ljg.62.1702070080539;
        Fri, 08 Dec 2023 13:14:40 -0800 (PST)
Received: from ?IPV6:2001:4479:a405:fb00::959? ([2001:4479:a405:fb00::959])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001cf7c07be50sm2146102plq.58.2023.12.08.13.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 13:14:39 -0800 (PST)
Message-ID: <226b0c8d-3d6f-46a1-992c-874ed0c667fb@suse.com>
Date: Sat, 9 Dec 2023 07:44:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: Use a folio array throughout the defrag
 process
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20231208192725.1523194-1-willy@infradead.org>
 <20231208192725.1523194-2-willy@infradead.org>
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
In-Reply-To: <20231208192725.1523194-2-willy@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0xNsuE6z2Y5eBRg0nNaIuDUq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0xNsuE6z2Y5eBRg0nNaIuDUq
Content-Type: multipart/mixed; boundary="------------cjKOsEDcG03CgiDCLzaTzN8M";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <226b0c8d-3d6f-46a1-992c-874ed0c667fb@suse.com>
Subject: Re: [PATCH 2/2] btrfs: Use a folio array throughout the defrag
 process
References: <20231208192725.1523194-1-willy@infradead.org>
 <20231208192725.1523194-2-willy@infradead.org>
In-Reply-To: <20231208192725.1523194-2-willy@infradead.org>

--------------cjKOsEDcG03CgiDCLzaTzN8M
Content-Type: multipart/mixed; boundary="------------D3ItRrvglX7ekbLf1I00h0pl"

--------------D3ItRrvglX7ekbLf1I00h0pl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjMvMTIvOSAwNTo1NywgTWF0dGhldyBXaWxjb3ggKE9yYWNsZSkgd3JvdGU6
DQo+IFJlbW92ZSBtb3JlIGhpZGRlbiBjYWxscyB0byBjb21wb3VuZF9oZWFkKCkgYnkgdXNp
bmcgYW4gYXJyYXkgb2YgZm9saW9zDQo+IGluc3RlYWQgb2YgcGFnZXMuICBBbHNvIG5lYXRl
biB0aGUgZXJyb3IgcGF0aCBpbiBkZWZyYWdfb25lX3JhbmdlKCkgYnkNCj4gYWRqdXN0aW5n
IHRoZSBsZW5ndGggb2YgdGhlIGFycmF5IGluc3RlYWQgb2YgY2hlY2tpbmcgZm9yIE5VTEwu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IFdpbGNveCAoT3JhY2xlKSA8d2lsbHlA
aW5mcmFkZWFkLm9yZz4NCg0KTG9va3MgZ29vZCB0byBtZS4NCg0KUmV2aWV3ZWQtYnk6IFF1
IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0KDQpUaGlzIHRpbWUgb25seSBzb21lIHVucmVsYXRl
ZCBxdWVzdGlvbnMgYmVsb3cuDQo+IC0tLQ0KPiAgIGZzL2J0cmZzL2RlZnJhZy5jIHwgNDQg
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZp
bGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZnMvYnRyZnMvZGVmcmFnLmMgYi9mcy9idHJmcy9kZWZyYWcuYw0KPiBp
bmRleCAxN2ExM2QzZWQxMzEuLjRiOTQzNjI3NzlmZSAxMDA2NDQNCj4gLS0tIGEvZnMvYnRy
ZnMvZGVmcmFnLmMNCj4gKysrIGIvZnMvYnRyZnMvZGVmcmFnLmMNCj4gQEAgLTg2MSw3ICs4
NjEsNyBAQCBzdGF0aWMgYm9vbCBkZWZyYWdfY2hlY2tfbmV4dF9leHRlbnQoc3RydWN0IGlu
b2RlICppbm9kZSwgc3RydWN0IGV4dGVudF9tYXAgKmVtLA0KPiAgICAqIE5PVEU6IENhbGxl
ciBzaG91bGQgYWxzbyB3YWl0IGZvciBwYWdlIHdyaXRlYmFjayBhZnRlciB0aGUgY2x1c3Rl
ciBpcw0KPiAgICAqIHByZXBhcmVkLCBoZXJlIHdlIGRvbid0IGRvIHdyaXRlYmFjayB3YWl0
IGZvciBlYWNoIHBhZ2UuDQo+ICAgICovDQo+IC1zdGF0aWMgc3RydWN0IHBhZ2UgKmRlZnJh
Z19wcmVwYXJlX29uZV9wYWdlKHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUsIHBnb2ZmX3Qg
aW5kZXgpDQo+ICtzdGF0aWMgc3RydWN0IGZvbGlvICpkZWZyYWdfcHJlcGFyZV9vbmVfZm9s
aW8oc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwgcGdvZmZfdCBpbmRleCkNCj4gICB7DQo+
ICAgCXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nID0gaW5vZGUtPnZmc19pbm9kZS5p
X21hcHBpbmc7DQo+ICAgCWdmcF90IG1hc2sgPSBidHJmc19hbGxvY193cml0ZV9tYXNrKG1h
cHBpbmcpOw0KPiBAQCAtODc1LDcgKzg3NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqZGVm
cmFnX3ByZXBhcmVfb25lX3BhZ2Uoc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwgcGdvZmZf
dCBpDQo+ICAgCWZvbGlvID0gX19maWxlbWFwX2dldF9mb2xpbyhtYXBwaW5nLCBpbmRleCwN
Cj4gICAJCQlGR1BfTE9DSyB8IEZHUF9BQ0NFU1NFRCB8IEZHUF9DUkVBVCwgbWFzayk7DQo+
ICAgCWlmIChJU19FUlIoZm9saW8pKQ0KPiAtCQlyZXR1cm4gJmZvbGlvLT5wYWdlOw0KDQpX
aGF0J3MgdGhlIHByb3BlciB3YXkgdG8gZ3JhYiB0aGUgZmlyc3QgcGFnZSBvZiBhIGZvbGlv
Pw0KDQpGb3Igbm93LCBJJ20gZ29pbmcgZm9saW9fcGFnZSgpIGFuZCBpdCdzIHRoZSBzYW1l
IHdyYXBwZXIgdXNpbmcgDQpmb2xpby0+cGFnZSwgYnV0IEknbSB3b25kZXJpbmcgd291bGQg
dGhlcmUgYmUgYW55IHJlY29tbWVuZGF0aW9uIGZvciBpdC4NCg0KPiArCQlyZXR1cm4gZm9s
aW87DQo+ICAgDQo+ICAgCS8qDQo+ICAgCSAqIFNpbmNlIHdlIGNhbiBkZWZyYWdtZW50IGZp
bGVzIG9wZW5lZCByZWFkLW9ubHksIHdlIGNhbiBlbmNvdW50ZXINCj4gQEAgLTk0Miw3ICs5
NDIsNyBAQCBzdGF0aWMgc3RydWN0IHBhZ2UgKmRlZnJhZ19wcmVwYXJlX29uZV9wYWdlKHN0
cnVjdCBidHJmc19pbm9kZSAqaW5vZGUsIHBnb2ZmX3QgaQ0KPiAgIAkJCXJldHVybiBFUlJf
UFRSKC1FSU8pOw0KPiAgIAkJfQ0KPiAgIAl9DQo+IC0JcmV0dXJuICZmb2xpby0+cGFnZTsN
Cj4gKwlyZXR1cm4gZm9saW87DQo+ICAgfQ0KPiAgIA0KPiAgIHN0cnVjdCBkZWZyYWdfdGFy
Z2V0X3JhbmdlIHsNCj4gQEAgLTExNjMsNyArMTE2Myw3IEBAIHN0YXRpY19hc3NlcnQoUEFH
RV9BTElHTkVEKENMVVNURVJfU0laRSkpOw0KPiAgICAqLw0KPiAgIHN0YXRpYyBpbnQgZGVm
cmFnX29uZV9sb2NrZWRfdGFyZ2V0KHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUsDQo+ICAg
CQkJCSAgICBzdHJ1Y3QgZGVmcmFnX3RhcmdldF9yYW5nZSAqdGFyZ2V0LA0KPiAtCQkJCSAg
ICBzdHJ1Y3QgcGFnZSAqKnBhZ2VzLCBpbnQgbnJfcGFnZXMsDQo+ICsJCQkJICAgIHN0cnVj
dCBmb2xpbyAqKmZvbGlvcywgaW50IG5yX3BhZ2VzLA0KPiAgIAkJCQkgICAgc3RydWN0IGV4
dGVudF9zdGF0ZSAqKmNhY2hlZF9zdGF0ZSkNCj4gICB7DQo+ICAgCXN0cnVjdCBidHJmc19m
c19pbmZvICpmc19pbmZvID0gaW5vZGUtPnJvb3QtPmZzX2luZm87DQo+IEBAIC0xMTcyLDcg
KzExNzIsNyBAQCBzdGF0aWMgaW50IGRlZnJhZ19vbmVfbG9ja2VkX3RhcmdldChzdHJ1Y3Qg
YnRyZnNfaW5vZGUgKmlub2RlLA0KPiAgIAljb25zdCB1NjQgbGVuID0gdGFyZ2V0LT5sZW47
DQo+ICAgCXVuc2lnbmVkIGxvbmcgbGFzdF9pbmRleCA9IChzdGFydCArIGxlbiAtIDEpID4+
IFBBR0VfU0hJRlQ7DQo+ICAgCXVuc2lnbmVkIGxvbmcgc3RhcnRfaW5kZXggPSBzdGFydCA+
PiBQQUdFX1NISUZUOw0KPiAtCXVuc2lnbmVkIGxvbmcgZmlyc3RfaW5kZXggPSBwYWdlX2lu
ZGV4KHBhZ2VzWzBdKTsNCj4gKwl1bnNpZ25lZCBsb25nIGZpcnN0X2luZGV4ID0gZm9saW9z
WzBdLT5pbmRleDsNCg0KVGhlIHNhbWUgZm9yIGluZGV4LCB0aGVyZSBpcyBhIGZvbGlvX2lu
ZGV4KCkgd3JhcHBlci4NCg0KU28gc2hvdWxkIHdlIGdvIHRoZSB3cmFwcGVyIG9yIHdvdWxk
IHRoZSB3cmFwcGVyIGJlIGdvbmUgaW4gdGhlIGZ1dHVyZT8NCj4gICAJaW50IHJldCA9IDA7
DQo+ICAgCWludCBpOw0KPiAgIA0KPiBAQCAtMTE4OSw4ICsxMTg5LDggQEAgc3RhdGljIGlu
dCBkZWZyYWdfb25lX2xvY2tlZF90YXJnZXQoc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwN
Cj4gICANCj4gICAJLyogVXBkYXRlIHRoZSBwYWdlIHN0YXR1cyAqLw0KPiAgIAlmb3IgKGkg
PSBzdGFydF9pbmRleCAtIGZpcnN0X2luZGV4OyBpIDw9IGxhc3RfaW5kZXggLSBmaXJzdF9p
bmRleDsgaSsrKSB7DQo+IC0JCUNsZWFyUGFnZUNoZWNrZWQocGFnZXNbaV0pOw0KPiAtCQli
dHJmc19wYWdlX2NsYW1wX3NldF9kaXJ0eShmc19pbmZvLCBwYWdlc1tpXSwgc3RhcnQsIGxl
bik7DQo+ICsJCWZvbGlvX2NsZWFyX2NoZWNrZWQoZm9saW9zW2ldKTsNCj4gKwkJYnRyZnNf
cGFnZV9jbGFtcF9zZXRfZGlydHkoZnNfaW5mbywgJmZvbGlvc1tpXS0+cGFnZSwgc3RhcnQs
IGxlbik7DQoNCkFmdGVyIG15IHBhdGNoICIyLzMgYnRyZnM6IG1pZ3JhdGUgc3VicGFnZSBj
b2RlIHRvIGZvbGlvIGludGVyZmFjZXMiLCANCmJ0cmZzX3BhZ2VfKigpIGhlbHBlcnMgYWNj
ZXB0IGZvbGlvIHBhcmFtZXRlciBkaXJlY3RseSwgdGh1cyB0aGlzIG1heSANCmxlYWQgdG8g
YSBjb25mbGljdHMuDQoNClRoYW5rcywNClF1DQo+ICAgCX0NCj4gICAJYnRyZnNfZGVsYWxs
b2NfcmVsZWFzZV9leHRlbnRzKGlub2RlLCBsZW4pOw0KPiAgIAlleHRlbnRfY2hhbmdlc2V0
X2ZyZWUoZGF0YV9yZXNlcnZlZCk7DQo+IEBAIC0xMjA2LDcgKzEyMDYsNyBAQCBzdGF0aWMg
aW50IGRlZnJhZ19vbmVfcmFuZ2Uoc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwgdTY0IHN0
YXJ0LCB1MzIgbGVuLA0KPiAgIAlzdHJ1Y3QgZGVmcmFnX3RhcmdldF9yYW5nZSAqZW50cnk7
DQo+ICAgCXN0cnVjdCBkZWZyYWdfdGFyZ2V0X3JhbmdlICp0bXA7DQo+ICAgCUxJU1RfSEVB
RCh0YXJnZXRfbGlzdCk7DQo+IC0Jc3RydWN0IHBhZ2UgKipwYWdlczsNCj4gKwlzdHJ1Y3Qg
Zm9saW8gKipmb2xpb3M7DQo+ICAgCWNvbnN0IHUzMiBzZWN0b3JzaXplID0gaW5vZGUtPnJv
b3QtPmZzX2luZm8tPnNlY3RvcnNpemU7DQo+ICAgCXU2NCBsYXN0X2luZGV4ID0gKHN0YXJ0
ICsgbGVuIC0gMSkgPj4gUEFHRV9TSElGVDsNCj4gICAJdTY0IHN0YXJ0X2luZGV4ID0gc3Rh
cnQgPj4gUEFHRV9TSElGVDsNCj4gQEAgLTEyMTcsMjEgKzEyMTcsMjEgQEAgc3RhdGljIGlu
dCBkZWZyYWdfb25lX3JhbmdlKHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUsIHU2NCBzdGFy
dCwgdTMyIGxlbiwNCj4gICAJQVNTRVJUKG5yX3BhZ2VzIDw9IENMVVNURVJfU0laRSAvIFBB
R0VfU0laRSk7DQo+ICAgCUFTU0VSVChJU19BTElHTkVEKHN0YXJ0LCBzZWN0b3JzaXplKSAm
JiBJU19BTElHTkVEKGxlbiwgc2VjdG9yc2l6ZSkpOw0KPiAgIA0KPiAtCXBhZ2VzID0ga2Nh
bGxvYyhucl9wYWdlcywgc2l6ZW9mKHN0cnVjdCBwYWdlICopLCBHRlBfTk9GUyk7DQo+IC0J
aWYgKCFwYWdlcykNCj4gKwlmb2xpb3MgPSBrY2FsbG9jKG5yX3BhZ2VzLCBzaXplb2Yoc3Ry
dWN0IGZvbGlvICopLCBHRlBfTk9GUyk7DQo+ICsJaWYgKCFmb2xpb3MpDQo+ICAgCQlyZXR1
cm4gLUVOT01FTTsNCj4gICANCj4gICAJLyogUHJlcGFyZSBhbGwgcGFnZXMgKi8NCj4gICAJ
Zm9yIChpID0gMDsgaSA8IG5yX3BhZ2VzOyBpKyspIHsNCj4gLQkJcGFnZXNbaV0gPSBkZWZy
YWdfcHJlcGFyZV9vbmVfcGFnZShpbm9kZSwgc3RhcnRfaW5kZXggKyBpKTsNCj4gLQkJaWYg
KElTX0VSUihwYWdlc1tpXSkpIHsNCj4gLQkJCXJldCA9IFBUUl9FUlIocGFnZXNbaV0pOw0K
PiAtCQkJcGFnZXNbaV0gPSBOVUxMOw0KPiAtCQkJZ290byBmcmVlX3BhZ2VzOw0KPiArCQlm
b2xpb3NbaV0gPSBkZWZyYWdfcHJlcGFyZV9vbmVfZm9saW8oaW5vZGUsIHN0YXJ0X2luZGV4
ICsgaSk7DQo+ICsJCWlmIChJU19FUlIoZm9saW9zW2ldKSkgew0KPiArCQkJcmV0ID0gUFRS
X0VSUihmb2xpb3NbaV0pOw0KPiArCQkJbnJfcGFnZXMgPSBpOw0KPiArCQkJZ290byBmcmVl
X2ZvbGlvczsNCj4gICAJCX0NCj4gICAJfQ0KPiAgIAlmb3IgKGkgPSAwOyBpIDwgbnJfcGFn
ZXM7IGkrKykNCj4gLQkJd2FpdF9vbl9wYWdlX3dyaXRlYmFjayhwYWdlc1tpXSk7DQo+ICsJ
CWZvbGlvX3dhaXRfd3JpdGViYWNrKGZvbGlvc1tpXSk7DQo+ICAgDQo+ICAgCS8qIExvY2sg
dGhlIHBhZ2VzIHJhbmdlICovDQo+ICAgCWxvY2tfZXh0ZW50KCZpbm9kZS0+aW9fdHJlZSwg
c3RhcnRfaW5kZXggPDwgUEFHRV9TSElGVCwNCj4gQEAgLTEyNTEsNyArMTI1MSw3IEBAIHN0
YXRpYyBpbnQgZGVmcmFnX29uZV9yYW5nZShzdHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlLCB1
NjQgc3RhcnQsIHUzMiBsZW4sDQo+ICAgCQlnb3RvIHVubG9ja19leHRlbnQ7DQo+ICAgDQo+
ICAgCWxpc3RfZm9yX2VhY2hfZW50cnkoZW50cnksICZ0YXJnZXRfbGlzdCwgbGlzdCkgew0K
PiAtCQlyZXQgPSBkZWZyYWdfb25lX2xvY2tlZF90YXJnZXQoaW5vZGUsIGVudHJ5LCBwYWdl
cywgbnJfcGFnZXMsDQo+ICsJCXJldCA9IGRlZnJhZ19vbmVfbG9ja2VkX3RhcmdldChpbm9k
ZSwgZW50cnksIGZvbGlvcywgbnJfcGFnZXMsDQo+ICAgCQkJCQkgICAgICAgJmNhY2hlZF9z
dGF0ZSk7DQo+ICAgCQlpZiAocmV0IDwgMCkNCj4gICAJCQlicmVhazsNCj4gQEAgLTEyNjUs
MTQgKzEyNjUsMTIgQEAgc3RhdGljIGludCBkZWZyYWdfb25lX3JhbmdlKHN0cnVjdCBidHJm
c19pbm9kZSAqaW5vZGUsIHU2NCBzdGFydCwgdTMyIGxlbiwNCj4gICAJdW5sb2NrX2V4dGVu
dCgmaW5vZGUtPmlvX3RyZWUsIHN0YXJ0X2luZGV4IDw8IFBBR0VfU0hJRlQsDQo+ICAgCQkg
ICAgICAobGFzdF9pbmRleCA8PCBQQUdFX1NISUZUKSArIFBBR0VfU0laRSAtIDEsDQo+ICAg
CQkgICAgICAmY2FjaGVkX3N0YXRlKTsNCj4gLWZyZWVfcGFnZXM6DQo+ICtmcmVlX2ZvbGlv
czoNCj4gICAJZm9yIChpID0gMDsgaSA8IG5yX3BhZ2VzOyBpKyspIHsNCj4gLQkJaWYgKHBh
Z2VzW2ldKSB7DQo+IC0JCQl1bmxvY2tfcGFnZShwYWdlc1tpXSk7DQo+IC0JCQlwdXRfcGFn
ZShwYWdlc1tpXSk7DQo+IC0JCX0NCj4gKwkJZm9saW9fdW5sb2NrKGZvbGlvc1tpXSk7DQo+
ICsJCWZvbGlvX3B1dChmb2xpb3NbaV0pOw0KPiAgIAl9DQo+IC0Ja2ZyZWUocGFnZXMpOw0K
PiArCWtmcmVlKGZvbGlvcyk7DQo+ICAgCXJldHVybiByZXQ7DQo+ICAgfQ0KPiAgIA0K
--------------D3ItRrvglX7ekbLf1I00h0pl
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------D3ItRrvglX7ekbLf1I00h0pl--

--------------cjKOsEDcG03CgiDCLzaTzN8M--

--------------0xNsuE6z2Y5eBRg0nNaIuDUq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmVzhzoFAwAAAAAACgkQwj2R86El/qgG
uQf+NyTmvfIiTK8uiqplmrydbQtTM3MfEGNyJRWRr+UrVLUFyH52x47Mh1nScpc6dbeA6838t72A
dcyvqEp58Aq3/w245onR4qpWXCsYn3Mm987j0CkRhpyvuftW60Hcwq3QmNMAesm/phQ0TubyJUo8
4N8/77Ys/dCQ1Pq25eNlUliezrZ2ll54yy4r84LVC89Mgi8DApnXiI/C/gkGo26d2t6hPrabplVK
r0FOroHtc6S31LJb64I1n51Ux1ttzcnS3s297tUdIyrjVztbFShJyY1GfKFanKZwSPqSlnvsmCxn
/fT8qhJ0J1eDNi9hWtxgHh0EurLft6I00uX5WsdL9A==
=C1t2
-----END PGP SIGNATURE-----

--------------0xNsuE6z2Y5eBRg0nNaIuDUq--

