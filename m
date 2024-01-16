Return-Path: <linux-btrfs+bounces-1492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C9D82FC0F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 23:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD24E1C27792
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 22:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5F21A03;
	Tue, 16 Jan 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X9eBD+dG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DAB1D553
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705436421; cv=none; b=QBUViPoUZIAIpsGoVCjBKU01kiZoovvN4FOI9+uv8SPlLlKYHeKuzz/r3r6SNccTNHHoPunX5g4nqsakRxRSjQBJIzd2dmAqwog/Od8B8BSsitpmG6M/KVYjBW2xfzI4/Mx6fuWX+3JijAketVxVGsW/QTmnzJYUXUMbPXYPDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705436421; c=relaxed/simple;
	bh=URPgJj7yeghZQDBY4erCWfKFq7Qlp1wMWLP3OuGND94=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type; b=P5dG/1X+YUNiv4cDbwTM21Nr5WHsqzZWu07LHCHdfwA6NLsPHqRKPZRSdxzpnJhYVtC7tVHA0ctdMcke3m+O6NjHK6KwEfb6xyZxxta+ub3sAsQ615EDMOvMX1thEnnlZkAoXbuARccrgFhY5MXSERO1fS+9UD3rG7Xdxcxbqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X9eBD+dG; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd2f472665so108745141fa.2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 12:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705436417; x=1706041217; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=URPgJj7yeghZQDBY4erCWfKFq7Qlp1wMWLP3OuGND94=;
        b=X9eBD+dGCZ/f6ZGKQFqBCDJLwL+igx/Yy+FekJrtFbcQ3UC0ERnn5ihoPV5/YNvkuR
         G2c9XUFlPL9V/s+AAd+KymTTRxnY7F0UwzFrPXMdJXRuFs3TO7SiQoycq73C6UCamLmj
         9zksLJqRbHMhBxabj3e8AUi/QdOjdLMgCF4TZfl6EPp2y7k/d6S9RQ3eN8hjzTDEqnVG
         PgQeKAap+avHdAlc/S+MVq4Xa71duYlxWD5AYn3WuTQcm4Ek+jKU4AxpdHBuRLAoDdwI
         GJgPxiWhla+jB8ZLQedYEgY4kGrNq4Am87VPMlYqoTKYnSuzvPKBa3oVnx+XXEXKnBmb
         9l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705436417; x=1706041217;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=URPgJj7yeghZQDBY4erCWfKFq7Qlp1wMWLP3OuGND94=;
        b=OQC9SBVokF1a0bEX+s51JBDiu4aRIfpoLXopCIRvsBLI66XPTfE/ScVMkNJYe9s3e0
         w1nnB2WZIJC7CugiLGDyIIJ7YJYIq8LJ9qxETmXumZq21hZIMXP8MTmkMbDgoTblM+Wu
         bIJsoMfymqPdqVQh+oqhy9jhH0gFWOLefhUX6OGfva2m14Sc8yxfIBluV3UiK+WpVsN5
         kbLQaHenM4sUXA/1V70jproFoDiR1YUki/kbk9eXFA/Kofre9YEW6FqqyaL62NzGHjZx
         gwqJDsShcoPaV8IN7w4qhPebzgacYT8rsxhW7/lvPzfWxhlyB878zNQjLryj/uHgSO2u
         U8yg==
X-Gm-Message-State: AOJu0YwMaKEjUoH5l+HD0hcwOcmQWP5NKvCcG1ZMJxe/ZTi4kmUaS7lx
	TtAisw/aD/l0kv45hJMLdaInU5+tnxxssQ==
X-Google-Smtp-Source: AGHT+IFWQ5M3wuzugHZzBDK/5KPaABYVw8NX3Fx0xCFIOedH9PIOf3XVprvhcLTNykoJ7tlEQ9OfDQ==
X-Received: by 2002:a2e:a0c3:0:b0:2cc:fc52:df9e with SMTP id f3-20020a2ea0c3000000b002ccfc52df9emr3505291ljm.12.1705436416870;
        Tue, 16 Jan 2024 12:20:16 -0800 (PST)
Received: from ?IPV6:2403:580d:bef6::959? (2403-580d-bef6--959.ip6.aussiebb.net. [2403:580d:bef6::959])
        by smtp.gmail.com with ESMTPSA id r22-20020a170902be1600b001d596965f02sm9020170pls.191.2024.01.16.12.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 12:20:16 -0800 (PST)
Message-ID: <8d987075-18be-4866-80da-03415b6da7ff@suse.com>
Date: Wed, 17 Jan 2024 06:50:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs-progs: convert/ext2: new debug environment
 variable to finetune transaction size
Content-Language: en-US
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1705135055.git.wqu@suse.com>
 <4c2f12dc417a192f4acfd804831401aadeeb9c42.1705135055.git.wqu@suse.com>
 <20240116183152.GC31555@twin.jikos.cz>
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
In-Reply-To: <20240116183152.GC31555@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QtkwwNIWw0may3uf0PBxh4VS"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------QtkwwNIWw0may3uf0PBxh4VS
Content-Type: multipart/mixed; boundary="------------Njt8N3SNhYoBZDFzhGXGDI1i";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Message-ID: <8d987075-18be-4866-80da-03415b6da7ff@suse.com>
Subject: Re: [PATCH 1/3] btrfs-progs: convert/ext2: new debug environment
 variable to finetune transaction size
References: <cover.1705135055.git.wqu@suse.com>
 <4c2f12dc417a192f4acfd804831401aadeeb9c42.1705135055.git.wqu@suse.com>
 <20240116183152.GC31555@twin.jikos.cz>
In-Reply-To: <20240116183152.GC31555@twin.jikos.cz>

--------------Njt8N3SNhYoBZDFzhGXGDI1i
Content-Type: multipart/mixed; boundary="------------2fIsvZb8lmQMlo1qe1mEsC2X"

--------------2fIsvZb8lmQMlo1qe1mEsC2X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjQvMS8xNyAwNTowMSwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPiBPbiBTYXQs
IEphbiAxMywgMjAyNCBhdCAwNzoxNToyOVBNICsxMDMwLCBRdSBXZW5ydW8gd3JvdGU6DQo+
PiBTaW5jZSB3ZSBnb3QgYSByZWNlbnQgYnVnIHJlcG9ydCBhYm91dCB0cmVlLWNoZWNrZXIg
dHJpZ2dlcmVkIGZvciBsYXJnZQ0KPj4gZnMgY29udmVyc2lvbiwgd2UgbmVlZCBhIHByb3Bl
cmx5IHdheSB0byB0cmlnZ2VyIHRoZSBwcm9ibGVtIGZvciB0ZXN0DQo+PiBjYXNlIHB1cnBv
c2UuDQo+Pg0KPj4gVG8gdHJpZ2dlciB0aGF0IGJ1Zywgd2UgbmVlZCB0byBtZWV0IHNldmVy
YWwgY29uZGl0aW9uczoNCj4+DQo+PiAtIFdlIG5lZWQgdG8gcmVhZCBzb21lIHRyZWUgYmxv
Y2tzIHdoaWNoIGhhcyBoYWxmLWJhY2tlZCBpbm9kZXMNCj4+IC0gV2UgbmVlZCBhIGxhcmdl
IGVub3VnaCBlbm91Z2ggZnMgdG8gZ2VuZXJhdGUgbW9yZSB0cmVlIGJsb2NrcyB0aGFuDQo+
PiAgICBvdXIgY2FjaGUuDQo+Pg0KPj4gICAgRm9yIG91ciBleGlzdGluZyB0ZXN0IGNhc2Vz
LCBmaXJzdGx5IHRoZSBmcyBpcyBub3QgdGhhdCBsYXJnZSwgdGh1cw0KPj4gICAgd2UgbWF5
IGV2ZW4gZ28ganVzdCBvbmUgdHJhbnNhY3Rpb24gdG8gZ2VuZXJhdGUgYWxsIHRoZSBpbm9k
ZXMuDQo+Pg0KPj4gICAgU2Vjb25kbHkgd2UgaGF2ZSBhIGdsb2JhbCBjYWNoZSBmb3IgdHJl
ZSBibG9ja3MsIHdoaWNoIG1lYW5zIGEgbG90IG9mDQo+PiAgICB3cml0dGVuIHRyZWUgYmxv
Y2tzIGFyZSBzdGlsbCBpbiB0aGUgY2FjaGUsIHRodXMgd29uJ3QgdHJpZ2dlcg0KPj4gICAg
dHJlZS1jaGVja2VyLg0KPj4NCj4+IFRvIG1ha2UgdGhlIHByb2JsZW0gbXVjaCBlYXNpZXIg
Zm9yIG91ciBleGlzdGluZyB0ZXN0IGNhc2UgdG8gZXhwb3NlLA0KPj4gdGhpcyBwYXRjaCB3
b3VsZCBpbnRyb2R1Y2UgYSBkZWJ1ZyBlbnZpcm9ubWVudCB2YXJpYWJsZToNCj4+IEJUUkZT
X1BST0dTX0RFQlVHX0JMT0NLU19VU0VEX1RIUkVTSE9MRC4NCj4+DQo+PiBUaGlzIHdvdWxk
IGFmZmVjdHMgdGhlIHRocmVzaG9sZCBmb3IgdGhlIHRyYW5zYWN0aW9uIHNpemUsIHNldHRp
bmcgaXQgdG8NCj4+IGEgbXVjaCBzbWFsbGVyIHZhbHVlIHdvdWxkIG1ha2UgdGhlIGJ1ZyBt
dWNoIGVhc2llciB0byB0cmlnZ2VyLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFF1IFdlbnJ1
byA8d3F1QHN1c2UuY29tPg0KPj4gLS0tDQo+PiAgIGNvbW1vbi91dGlscy5jICAgICAgICB8
IDYyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAg
Y29tbW9uL3V0aWxzLmggICAgICAgIHwgIDEgKw0KPj4gICBjb252ZXJ0L3NvdXJjZS1leHQy
LmMgfCAgOSArKysrKystDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9jb21tb24vdXRpbHMuYyBi
L2NvbW1vbi91dGlscy5jDQo+PiBpbmRleCA2MmYwZTNmNDhiMzkuLmU2MDcwNzkxZjVjYyAx
MDA2NDQNCj4+IC0tLSBhL2NvbW1vbi91dGlscy5jDQo+PiArKysgYi9jb21tb24vdXRpbHMu
Yw0KPj4gQEAgLTk1Niw2ICs5NTYsNjggQEAgdTggcmFuZF91OCh2b2lkKQ0KPj4gICAJcmV0
dXJuICh1OCkocmFuZF91MzIoKSk7DQo+PiAgIH0NCj4+ICAgDQo+PiArLyoNCj4+ICsgKiBQ
YXJzZSBhIHU2NCB2YWx1ZSBmcm9tIGFuIGVudmlyb25tZW50IHZhcmlhYmxlLg0KPj4gKyAq
DQo+PiArICogU3VwcG9ydHMgdW5pdCBzdWZmaXhlcyAiS01HVFAiLCB0aGUgc3VmZml4IGlz
IGFsd2F5cyAyICoqIDEwIGJhc2VkLg0KPj4gKyAqIFdpdGggcHJvcGVyIG92ZXJmbG93IGRl
dGVjdGlvbi4NCj4+ICsgKg0KPj4gKyAqIFRoZSBzdHJpbmcgbXVzdCBlbmQgd2l0aCAnXDAn
LCBhbnl0aGluZyB1bmV4cGVjdGVkIG5vbi1zdWZmaXggc3RyaW5nLA0KPj4gKyAqIGluY2x1
ZGluZyBzcGFjZSwgd291bGQgbGVhZCB0byAtRUlOVkFMIGFuZCBubyB2YWx1ZSB1cGRhdGVk
Lg0KPj4gKyAqLw0KPj4gK2ludCBnZXRfZW52X3U2NChjb25zdCBjaGFyICplbnZfbmFtZSwg
dTY0ICp2YWx1ZV9yZXQpDQo+IA0KPiBUaGVyZSBhbHJlYWR5IGlzIGEgZnVuY3Rpb24gZm9y
IHBhcnNpbmcgc2l6ZXMgcGFyc2Vfc2l6ZV9mcm9tX3N0cmluZygpDQo+IGluIGNvbW1vbi9w
YXJzZS11dGlscy5jLg0KDQpVbmZvcnR1bmF0ZWx5IHRoYXQncyBub3Qgc3VpdGFibGUuDQoN
CldlIGRvbid0IHdhbnQgYSBpbnZhbGlkIHN0cmluZyB0byBmdWxseSBibG93IHVwIHRoZSBw
cm9ncmFtLCBhcyB0aGUgDQpleGlzdGluZyBwYXJzZXIgd291bGQgY2FsbCBleGl0KDEpLCBl
c3BlY2lhbGx5IHdlIG9ubHkgbmVlZCBpdCBmb3IgYSANCmRlYnVnIGVudmlyb25tZW50YWwg
dmFyaWFibGUuDQoNClNob3VsZCBJIGNoYW5nZSB0aGUgZXhpc3Rpbmcgb25lIHRvIHByb3Zp
ZGUgYmV0dGVyIGVycm9yIGhhbmRsaW5nPw0KKFdoaWNoIG1lYW5zIGFyb3VuZCAxNiBjYWxs
IHNpdGVzIHVwZGF0ZSksIG9yIGlzIHRoZXJlIHNvbWUgYmV0dGVyIHNvbHV0aW9uPw0KDQpU
aGFua3MsDQpRdQ0K
--------------2fIsvZb8lmQMlo1qe1mEsC2X
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------2fIsvZb8lmQMlo1qe1mEsC2X--

--------------Njt8N3SNhYoBZDFzhGXGDI1i--

--------------QtkwwNIWw0may3uf0PBxh4VS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmWm5PsFAwAAAAAACgkQwj2R86El/qj0
0Qf8DA2aDRxXWAy4efXCgU6d1Pc71rzgFi+m/xCJ236cXFNaAtiKTLFfShNVMzccliWW8CZiWoyn
2kAavaqemB48cMS6JztFXsRP1JruVqnqpSLCqSatwoJttlkZzmftYH8oq3POsfTqyR123pPZakn+
YXmLRynDlSSMoMbC0AOtgtmS3we+dALy6M69lRN7H/qCQP9LxkYHueSMyxTnct3bozHDtTU3UChg
DjkH4387ii3uFXfB18PCMlnaDBkw12B82dDoj2TfVarkPOvQcG/+zUjJ33z2c84aIRuBjSEcSYji
DEfvZAhrhxIJQaTKazXXDI0hb4k27pmuwGpM7OgjbA==
=5VDi
-----END PGP SIGNATURE-----

--------------QtkwwNIWw0may3uf0PBxh4VS--

