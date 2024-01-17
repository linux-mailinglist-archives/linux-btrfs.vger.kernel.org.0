Return-Path: <linux-btrfs+bounces-1510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDCC8300E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 08:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825B12889C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C9FC2E6;
	Wed, 17 Jan 2024 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N50vpLcI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B094BE76
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478255; cv=none; b=GMaA5labzTAt3j8habvN0lxbHTCZaxNqXrM2oMpJD/7hcDcm3YARwndOqWkJyw7spVHNwVnm0cJ5BEOt6lPBz32LDXroyKKGZE2Zk8p+va6hOPS63feSDH25EzX4NOR4moI9nkq5HSo/ftah/UEDAyiU7sB3zaXCB3dIr2/61pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478255; c=relaxed/simple;
	bh=s5F7rqK26hzcBG1wbBU4kboJZ8nQZgGMfvojRlVZsS0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:References:From:Autocrypt:In-Reply-To:Content-Type; b=TKVLp1pFGZsoD+65pYj0q0y8plgVzNJDXcSNNShpuoHUGb0BEhfL/uaRCRPtqpFBUHFit/1AycefYgHv6F77MnlG1S2WhrqAK6qL9tfO8z2wMHGqEWt9rwq6OWkjGFOgBgrdmtDiY/ztidLlba2HO/bHyX1vYsIKbk1DWe2y9Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N50vpLcI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e835800adso12043995e87.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 23:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705478250; x=1706083050; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5F7rqK26hzcBG1wbBU4kboJZ8nQZgGMfvojRlVZsS0=;
        b=N50vpLcIt47IbKBhEtH6J6FQJFnkkwg5Ga/6+oGsj+KrVm4wPjWty0qhohna/yCY1D
         eKoddjgumyEligou5cnPoaAV9oKHhsjD8MjuIKe/I8Z6CkRKQKQc+YtuCDr3JUgXeAaR
         yRQVmKxtZRTL8wAB/NHQCxYrgS+OsVhGnWvbQLrd2dZtklf9ekfjwx5rZ9+J8uClMJ8J
         5gNUpWj+DCvDk8Rho4yywt5ZxpiSn+TFa1EsRDqoorOk7A0enq+TNxnxmAu/iF/fYTpW
         3MHs1gSwc/cmOE08SzsjMwlhAUOFY5nrfnN93mSW0fvYkjwT8hWq2BIhTnNbT1GvTf72
         eZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705478250; x=1706083050;
        h=in-reply-to:autocrypt:from:references:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s5F7rqK26hzcBG1wbBU4kboJZ8nQZgGMfvojRlVZsS0=;
        b=HXAc9Y3PfJLQSIPTYt2LMD13yZCweMUZJh3A/hCviqpYvOojixwJd/VoXiMoI82eGg
         AFIvX1wm2qpodRPJbUiPQquk6Qs7eN+Mfs9H1XPIRWrh704YIIwBXoArnCDn6LVB1eYb
         ZXVK3dNjP8n9jCg3tSyeGdCv+sU95cKaL1bcrHKmd6/j6n0QvxiKk6UoJS/5Wq1NR5vH
         R24NIlnWRE3ihQuWFdDYwUYlN41McjHFM0Qt6rIxUv2rBeOuB7sKe0ddaVvZKh9FDncV
         OatlAVePX2IjuvhzNiTBmZN5POgeAFxTwze5/vA8W6Qtv1EZoNb0oniTtMyJxg6QysUE
         Vm/w==
X-Gm-Message-State: AOJu0YzpY76c1KjVddb0CAp8dJEeGLR7JQ+CQTkEtXOEBKUtHJPIFn6y
	OwJOHCuRt+MzWJgksm5Vt2rfjbyAXmLLf/1JuMdKKrYrpMM=
X-Google-Smtp-Source: AGHT+IEesO5JaZ+o875bQcYQttKLamYcB2KNeRV4enWZ0W/EtJFOJyvnvliegHVtPDYZnZgvwRs+PQ==
X-Received: by 2002:a05:6512:1591:b0:50e:9e97:ce6b with SMTP id bp17-20020a056512159100b0050e9e97ce6bmr2965543lfb.42.1705478250549;
        Tue, 16 Jan 2024 23:57:30 -0800 (PST)
Received: from ?IPV6:2403:580d:bef6::959? (2403-580d-bef6--959.ip6.aussiebb.net. [2403:580d:bef6::959])
        by smtp.gmail.com with ESMTPSA id ka7-20020a056a00938700b006db0907e696sm790638pfb.6.2024.01.16.23.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 23:57:30 -0800 (PST)
Message-ID: <7fec99a2-1eae-403e-a95a-32314f46b8dd@suse.com>
Date: Wed, 17 Jan 2024 18:27:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] btrfs: scrub avoid use-after-free when chunk
 length is not 64K aligned
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1705449249.git.wqu@suse.com>
 <7810799d-23c3-4a43-905b-e5112cd7d6e9@wdc.com>
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
In-Reply-To: <7810799d-23c3-4a43-905b-e5112cd7d6e9@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------upwVGwothA841zz0bf4K0KxY"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------upwVGwothA841zz0bf4K0KxY
Content-Type: multipart/mixed; boundary="------------ExrWoET5FQ5m9o36RfLy0ICP";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <7fec99a2-1eae-403e-a95a-32314f46b8dd@suse.com>
Subject: Re: [PATCH v2 0/2] btrfs: scrub avoid use-after-free when chunk
 length is not 64K aligned
References: <cover.1705449249.git.wqu@suse.com>
 <7810799d-23c3-4a43-905b-e5112cd7d6e9@wdc.com>
In-Reply-To: <7810799d-23c3-4a43-905b-e5112cd7d6e9@wdc.com>

--------------ExrWoET5FQ5m9o36RfLy0ICP
Content-Type: multipart/mixed; boundary="------------lO3t0wWK7XMImEf9DiWAf6Ns"

--------------lO3t0wWK7XMImEf9DiWAf6Ns
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjQvMS8xNyAxODoyNCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBP
biAxNy4wMS4yNCAwMTozMywgUXUgV2VucnVvIHdyb3RlOg0KPj4gW0NoYW5nZWxvZ10NCj4+
IHYyOg0KPj4gLSBTcGxpdCBvdXQgdGhlIFJTVCBjb2RlIGNoYW5nZQ0KPj4gICAgIFNvIHRo
YXQgYmFja3BvcnQgY2FuIGhhcHBlbiBtb3JlIHNtb290aGx5Lg0KPj4gICAgIEZ1cnRoZXJt
b3JlLCB0aGUgUlNUIHNwZWNpZmljIHBhcnQgaXMgcmVhbGx5IGp1c3QgYSBzbWFsbCBlbmhh
bmNlbWVudC4NCj4+ICAgICBBcyBSU1Qgd291bGQgYWx3YXlzIGRvIHRoZSBidHJmc19tYXBf
YmxvY2soKSwgZXZlbiBpZiB3ZSBoYXZlIGENCj4+ICAgICBjb3JydXB0ZWQgZXh0ZW50IGl0
ZW0gYmV5b25kIGNodW5rLCBpdCB3b3VsZCBiZSBwcm9wZXJseSBjYXVnaHQsDQo+PiAgICAg
dGh1cyBhdCBtb3N0IGZhbHNlIGFsZXJ0cywgbm8gcmVhbCB1c2UtYWZ0ZXItZnJlZSBjYW4g
aGFwcGVuIGFmdGVyDQo+PiAgICAgdGhlIGZpcnN0IHBhdGNoLg0KPj4NCj4+IC0gU2xpZ2h0
IHVwZGF0ZSBvbiB0aGUgY29tbWl0IG1lc3NhZ2Ugb2YgdGhlIGZpcnN0IHBhdGNoDQo+PiAg
ICAgRml4IGEgY29weS1hbmQtcGFzdGUgZXJyb3Igb2YgdGhlIG51bWJlciB1c2VkIHRvIGNh
bGN1bGF0ZSB0aGUgY2h1bmsNCj4+ICAgICBlbmQuDQo+PiAgICAgUmVtb3ZlIHRoZSBSU1Qg
c2NydWIgcGFydCwgYXMgd2Ugd29uJ3QgZG8gYW55IFJTVCBmaXggKGFsdGhvdWdoDQo+PiAg
ICAgaXQgd291bGQgc3RpbGwgc2xpZW50bHkgZml4IFJTVCwgc2luY2UgYm90aCBSU1QgYW5k
IHJlZ3VsYXIgc2NydWINCj4+ICAgICBzaGFyZSB0aGUgc2FtZSBlbmRpbyBmdW5jdGlvbikN
Cj4+DQo+PiBUaGVyZSBpcyBhIGJ1ZyByZXBvcnQgYWJvdXQgdXNlLWFmdGVyLWZyZWUgZHVy
aW5nIHNjcnViIGFuZCBjcmFzaCB0aGUNCj4+IHN5c3RlbS4NCj4+IEl0IHR1cm5zIG91dCB0
byBiZSBhIGNodW5rIHdob3NlIGxlbmdodCBpcyBub3QgNjRLIGFsaWduZWQgY2F1c2luZyB0
aGUNCj4+IHByb2JsZW0uDQo+Pg0KPj4gVGhlIGZpcnN0IHBhdGNoIHdvdWxkIGJlIHRoZSBw
cm9wZXIgZml4LCBuZWVkcyB0byBiZSBiYWNrcG9ydGVkIHRvIGFsbA0KPj4ga2VybmVsIHVz
aW5nIG5ld2VyIHNjcnViIGludGVyZmFjZS4NCj4+DQo+PiBUaGUgMm5kIHBhdGNoIGlzIGEg
c21hbGwgZW5oYW5jZW1lbnQgZm9yIFJTVCBzY3J1YiwgaW5zcGlyZWQgYnkgdGhlDQo+PiBh
Ym92ZSBidWcsIHdoaWNoIGRvZXNuJ3QgcmVhbGx5IG5lZWQgdG8gYmUgYmFja3BvcnRlZC4N
Cj4+DQo+PiBRdSBXZW5ydW8gKDIpOg0KPj4gICAgIGJ0cmZzOiBzY3J1YjogYXZvaWQgdXNl
LWFmdGVyLWZyZWUgd2hlbiBjaHVuayBsZW5ndGggaXMgbm90IDY0Sw0KPj4gICAgICAgYWxp
Z25lZA0KPj4gICAgIGJ0cmZzOiBzY3J1YjogbGltaXQgUlNUIHNjcnViIHRvIGNodW5rIGJv
dW5kYXJ5DQo+Pg0KPj4gICAgZnMvYnRyZnMvc2NydWIuYyB8IDM2ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+Pg0KPiANCj4gRm9yIHRoZSBzZXJpZXMsDQo+
IFJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3
ZGMuY29tPg0KPiANCj4gT25lIG1vcmUgdGhpbmcgSSBwZXJzb25hbGx5IHdvdWxkIGFkZCAo
YXMgYSAzcmQgcGF0Y2ggdGhhdCBkb2Vzbid0IG5lZWQNCj4gdG8gZ2V0IGJhY2twb3J0ZWQg
dG8gc3RhYmxlKSBpcyB0aGlzOg0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3NjcnVi
LmMgYi9mcy9idHJmcy9zY3J1Yi5jDQo+IGluZGV4IDAxMjNkMjcyODkyMy4uMDQ2ZmRmOGY2
NzczIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy9zY3J1Yi5jDQo+ICsrKyBiL2ZzL2J0cmZz
L3NjcnViLmMNCj4gQEAgLTE2NDEsMTQgKzE2NDEsMjMgQEAgc3RhdGljIHZvaWQgc2NydWJf
cmVzZXRfc3RyaXBlKHN0cnVjdA0KPiBzY3J1Yl9zdHJpcGUgKnN0cmlwZSkNCj4gICAgICAg
ICAgIH0NCj4gICAgfQ0KPiANCj4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgc2NydWJfbnJfc3Ry
aXBlX3NlY3RvcnMoc3RydWN0IHNjcnViX3N0cmlwZSAqc3RyaXBlKQ0KPiArew0KPiArICAg
ICAgIHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gc3RyaXBlLT5iZy0+ZnNfaW5m
bzsNCj4gKyAgICAgICBzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJnID0gc3RyaXBlLT5i
ZzsNCj4gKyAgICAgICB1NjQgYmdfZW5kID0gYmctPnN0YXJ0ICsgYmctPmxlbmd0aDsNCj4g
KyAgICAgICB1bnNpZ25lZCBpbnQgbnJfc2VjdG9yczsNCj4gKw0KPiArICAgICAgIG5yX3Nl
Y3RvcnMgPSBtaW4oQlRSRlNfU1RSSVBFX0xFTiwgYmdfZW5kIC0gc3RyaXBlLT5sb2dpY2Fs
KTsNCj4gKyAgICAgICByZXR1cm4gbnJfc2VjdG9ycyA+PiBmc19pbmZvLT5zZWN0b3JzaXpl
X2JpdHM7DQo+ICt9DQo+ICsNCj4gICAgc3RhdGljIHZvaWQgc2NydWJfc3VibWl0X2V4dGVu
dF9zZWN0b3JfcmVhZChzdHJ1Y3Qgc2NydWJfY3R4ICpzY3R4LA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNjcnViX3N0cmlwZSAq
c3RyaXBlKQ0KPiAgICB7DQo+ICAgICAgICAgICBzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNf
aW5mbyA9IHN0cmlwZS0+YmctPmZzX2luZm87DQo+ICAgICAgICAgICBzdHJ1Y3QgYnRyZnNf
YmlvICpiYmlvID0gTlVMTDsNCj4gLSAgICAgICB1bnNpZ25lZCBpbnQgbnJfc2VjdG9ycyA9
IG1pbihCVFJGU19TVFJJUEVfTEVOLCBzdHJpcGUtPmJnLT5zdGFydCArDQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyaXBlLT5iZy0+bGVuZ3RoIC0NCj4g
c3RyaXBlLT5sb2dpY2FsKSA+Pg0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZnNfaW5mby0+c2VjdG9yc2l6ZV9iaXRzOw0KPiArICAgICAgIHVuc2lnbmVkIGludCBu
cl9zZWN0b3JzID0gc2NydWJfbnJfc3RyaXBlX3NlY3RvcnMoc3RyaXBlKTsNCj4gICAgICAg
ICAgIHU2NCBzdHJpcGVfbGVuID0gQlRSRlNfU1RSSVBFX0xFTjsNCj4gICAgICAgICAgIGlu
dCBtaXJyb3IgPSBzdHJpcGUtPm1pcnJvcl9udW07DQo+ICAgICAgICAgICBpbnQgaTsNCj4g
QEAgLTE3MTgsOSArMTcyNyw3IEBAIHN0YXRpYyB2b2lkIHNjcnViX3N1Ym1pdF9pbml0aWFs
X3JlYWQoc3RydWN0DQo+IHNjcnViX2N0eCAqc2N0eCwNCj4gICAgew0KPiAgICAgICAgICAg
c3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8gPSBzY3R4LT5mc19pbmZvOw0KPiAgICAg
ICAgICAgc3RydWN0IGJ0cmZzX2JpbyAqYmJpbzsNCj4gLSAgICAgICB1bnNpZ25lZCBpbnQg
bnJfc2VjdG9ycyA9IG1pbihCVFJGU19TVFJJUEVfTEVOLCBzdHJpcGUtPmJnLT5zdGFydCAr
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyaXBlLT5iZy0+
bGVuZ3RoIC0NCj4gc3RyaXBlLT5sb2dpY2FsKSA+Pg0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZnNfaW5mby0+c2VjdG9yc2l6ZV9iaXRzOw0KPiArICAgICAgIHVu
c2lnbmVkIGludCBucl9zZWN0b3JzID0gc2NydWJfbnJfc3RyaXBlX3NlY3RvcnMoc3RyaXBl
KTsNCj4gICAgICAgICAgIGludCBtaXJyb3IgPSBzdHJpcGUtPm1pcnJvcl9udW07DQo+IA0K
PiAgICAgICAgICAgQVNTRVJUKHN0cmlwZS0+YmcpOw0KPiANCj4gU29ycnkgZm9yIHRoZSBj
b21wbGV0ZSB3aGl0ZXNwYWNlIGRhbWFnZSwgYnV0IEkgdGhpbmsgeW91IGdldCB0aGUgcG9p
bnQuDQoNClRoYXQncyB3aGF0IEkgZGlkIGJlZm9yZSB0aGUgdjEsIGJ1dCBpdCB0dXJucyBv
dXQgdGhhdCBqdXN0IHR3byBjYWxsIA0Kc2l0ZXMsIGFuZCBJIG9wZW4tY29kZWQgdGhlbSBp
biB0aGUgZmluYWwgcGF0Y2guDQoNCkp1c3QgYSBwcmVmZXJlbmNlIHRoaW5nLCBJJ20gZmlu
ZSBlaXRoZXIgd2F5Lg0KDQpUaGFua3MsDQpRdQ0K
--------------lO3t0wWK7XMImEf9DiWAf6Ns
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

--------------lO3t0wWK7XMImEf9DiWAf6Ns--

--------------ExrWoET5FQ5m9o36RfLy0ICP--

--------------upwVGwothA841zz0bf4K0KxY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmWniGUFAwAAAAAACgkQwj2R86El/qh9
Uwf/QyFNjIjYe8e9H0Gjr8PsI5rsS21WUsioIf+2deblcOxTjt8WJ4AK35dbQe8tfirEQ5c+XikL
SswXSKIfXNt2mXBlFlt0kvpS5Mg9uC5DbebBT77ljfTyyel6b7psDcSdZh3TeNMiS09Q8tO1/mNB
uk8oeidVosDWn9ZijUx2oXUAIEUysNLHijl6eg3/CxLeYIVNfoxO5jlHY5+duQsw24Pf6YJbtMxc
ol6SK9fXSyi2iGL7H3pcHjmBUL/l7ni4hCswHuvIrSk5Lb2hJGwnk4Rt7Hxf+M8py7zF3WOEjoUm
hdGsYF23z0XUNaS4UVQ4QALtqXf3u+PoYyUaeLKoLg==
=AWek
-----END PGP SIGNATURE-----

--------------upwVGwothA841zz0bf4K0KxY--

