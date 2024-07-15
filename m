Return-Path: <linux-btrfs+bounces-6449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C15930D64
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 07:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A1B1F2144B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 05:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363EB13A3F7;
	Mon, 15 Jul 2024 05:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KqpALsJY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3528E211C
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721019616; cv=none; b=f7ehtYllWNF+0wYqn6q0qVkiH1YwVhkpoLB1m5vgYrhlfWiY57yYFcEXSdEgPNVNIisymxx1x56YdQ3jBTQ0yyrf+Q2PnDkxkrjiQ2GzGn2ZLtPQau2bsvwhLc0/WVhKsabg36h1ZTAAd0psUf6omIdR+VJrsQT7Dke2i7UG2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721019616; c=relaxed/simple;
	bh=FucaTR0q5Qj7tYeM5faCFU7D3DD50pf6kGXUHlYUbWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhHV0lxYGcVyjbheWs0YqbP975kIXSM0vIV/WrFq8oRawEZucVWsdYRJ4FUVgeq4303Hi0BcS4aqlC7KtEGHCPjQT72i28CHqNyE/v1N/xKZxsmxHGzwog9NB9nu5S5aUDhL41qmUkzIXvKpQGSVan2ksaLcug0IvFmeucH7mS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KqpALsJY; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so43884391fa.1
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 22:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721019611; x=1721624411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDf2e/Sss0ALk0/mWOxmEPFBiBVjFKP+L94PQcz3psE=;
        b=KqpALsJYpJQb44oGXXWCODBhsJesOgFmxty+mL87KyNr3MNefCmRszbG5WuS43bJKl
         c7cLIKC4EwFXwuHxldBkgT/a+whUPaVd007rLlSfoyzvWqQn92dqA+aKRI+C1tHJEohb
         kaGllReekDE67YMjvGY/aFBh1Btmza1No3YsuarOzKBLtnb5RQ5mjlYjobXKGopLdmYr
         eOYvtE9Kt6w8+cgRtTs4RBDny1QNOeI8v0CC1oyc6y+LJzqRWZr/dw6thyM8kMM9FUtD
         xAWCVD8jgASxCAYAAGzcKePJAt4vAjV/L7XrayNlXrZThf/CjK5qhY6RDeOe+/D3WFM1
         kZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721019611; x=1721624411;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDf2e/Sss0ALk0/mWOxmEPFBiBVjFKP+L94PQcz3psE=;
        b=V6jdUw9+bggcIkNONITSaU9mwNNuVVE1f957U+zGqZImiD2lyJyoHaD9xjMXhyXNnK
         jpCOat9m8VrhZMPDSnw+q+X+yw4iv+N9MssQkgYFpPiDF2T5QRj24TXwdzrh21H5Zm3H
         47okii5+l708lWap6F1V+2+jlz6XKIm/Z5LDnrOrgrE0uer7IE0Mj+IjFSFBpEjNF4qz
         hA/5p1C9nQDlXKIXnSM7/XMuqdTPnrrv1Ky3ZBOent+iyu4CzADq3pLdsoUyP+hN0T8T
         cJ37luEKhhThq5zbMXrT9fKiEYOzG0K5TxObPvQ2uqrwr7qPPr8Ijb/RckRvYlTpvLVn
         iTYQ==
X-Gm-Message-State: AOJu0Yziimi/NB5hyZ7PtcVbYDqyLahNPbvSmajoCfLymdeGGOTBMY3k
	+JSgkN0bZ0w5IIYyPJI8mSQbODrUfrWbo9PAaU46zlAx3P64ei53t6QrZnaBgQn8+TmVuELb1rq
	M
X-Google-Smtp-Source: AGHT+IGhDBRgHtPDvhhDdE7yuXfQIrSvgvxx1Ca6o8Wt39GsWmRHm0QS8SBACS+Vmu+icBEixGzroQ==
X-Received: by 2002:a05:651c:97:b0:2ee:8aed:ddcd with SMTP id 38308e7fff4ca-2eeb30ba01bmr114145041fa.2.1721019610904;
        Sun, 14 Jul 2024 22:00:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc27264sm31124715ad.165.2024.07.14.22.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 22:00:10 -0700 (PDT)
Message-ID: <d30126ba-a9fc-44ea-bba8-1f42b242ca91@suse.com>
Date: Mon, 15 Jul 2024 14:30:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs crashes during routine btrfs-balance-least-used
To: Kai Krakow <hurikhan77@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, Oliver Wien <ow@netactive.de>
References: <CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=JywF+D1_h+JYxe=WKp-Q@mail.gmail.com>
 <0bedfc5f-4658-4d01-98b3-34bc14f736f3@gmx.com>
 <CAMthOuNk273pZUSU1Npr-Zx7LscBxOsXeyWcQCgbYP=82TfreA@mail.gmail.com>
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
In-Reply-To: <CAMthOuNk273pZUSU1Npr-Zx7LscBxOsXeyWcQCgbYP=82TfreA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/15 13:59, Kai Krakow 写道:
> Hello Qu!
> 
> Thanks for looking into this. We already started the restore, so we no
> longer have any access to the corrupted disk images.
> 
> Am So., 14. Juli 2024 um 23:54 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>
>>
>>
>> 在 2024/7/15 01:43, Kai Krakow 写道:
>>> Hello btrfs list!
>>>
>>> (also reported in irc)
>>>
>>> Our btrfs pool crashed during a routine btrfs-balance-least-used.
>>> Maybe of interest: bees is also running on this filesystem, snapper
>>> takes hourly snapshots with retention policy.
>>>
>>> I'm currently still collecting diagnostics, "btrfs check" log is
>>> already 3 GB and growing.
>>>
>>> The btrfs runs on three devices vd{c,e,f}1 with data=single meta=raid1.
>>>
>>> Here's an excerpt from dmesg (full log https://gist.tnonline.net/TE):
>>
>> Unfortunately the full log is not really full.
>>
>> There should be extent leaf dump, and after that dump, showing the
>> reason why we believe it's a problem.
>>
>> Is there any true full dmesg dump?
> 
> Yes, sorry. The gist has been truncated - mea culpa. I repasted it:
> https://gist.tnonline.net/6Q

Thanks a lot!

That contains (almost) all info we need to know.

The offending bytenr is 402811572224, and in the dump we indeed have the 
item for it:

[1143913.108184] 	item 188 key (402811572224 168 4096) itemoff 14598 
itemsize 79
[1143913.108185] 		extent refs 3 gen 3678544 flags 1
[1143913.108186] 		ref#0: extent data backref root 13835058055282163977 
objectid 281473384125923 offset 81432576 count 1

The last line is the problem.

Firstly we shouldn't even have a root with that high value.
Secondly that root number 13835058055282163977 is a very weird hex value 
too (0xc000000000000109), the '0xc' part means it's definitely not a 
simple bitflip.

Furthermore, the objectid value is also very weird (0xffffa11315e3).
No wonder the extent tree is not going to handle it correctly.

But I have no idea why this happens, it passes csum thus I'm assuming 
it's runtime corruption.

[...]
> 
>> The other thing is, does the server has ECC memory?
>> It's not uncommon to see bitflips causing various problems (almost
>> monthly reports).
> 
> I don't know the exact hosting environment, we are inside of a QEMU
> VM. But I'm pretty sure it is ECC.

And considering it's some virtualization environment, you do not have 
any out-of-tree modules?

> 
> The disk images are hosted on DRBD, with two redundant remote block
> devices on NVMe RAID. Our VM runs on KVM/QEMU. We are not seeing DRBD
> from within the VM. Because the lower storage layer is redundant, we
> are not running a data raid profile in btrfs but we use multiple block
> devices because we are seeing better latency behavior that way.
> 
>> If the machine doesn't have ECC memory, then a memtest would be preferable.
> 
> I'll ask our data center operators about ECC but I'm pretty sure the
> answer will be: yes, it's ECC.
> 
> We have been using their data centers for 20+ years and have never
> seen a bit flip or storage failure.

Yeah, I do not think it's the hardware corruption either now.

> 
> I wonder if parallel use of snapper (hourly, with thinning after 24h),
> bees (we are seeing dedup rates of 2:1 - 3:1 for some datasets in the
> hosting services)

Snapshotting is done in a very special timing (at the end of transaction 
commit), thus it should not be related to balance operations.

> and btrfs-balance-least-used somehow triggered this.
> I remember some old reports where bees could trigger corruption in
> balance or scrub, and evading that by pausing if it detected it. I
> don't know if this is an issue any longer (kernel 6.6.30 LTS).

No recent bugs come up to me immediately, but even if we have, the 
corruption looks too special.
It still matches the item size and ref count, but in the middle the data 
it got corrupted with seemingly garbage.

As the higher bits of u64 is store in higher address in x86_64 memory,
the corruption looks to cover the following bits:

0                       8                       16
|        le64 root      |      le64 objectid    |
|09 01 00 00 00 00 00 0c|e3 15 13 a1 ff ff 00 00|
                       ====================
16                      24          28
|        le64 offset    | le32 refs |
|00 09 da 04 00 00 00 00|01 00 00 00|

So far the corruption looks like starts from byte 7 ends at byte 14.

In theory, if you have kept the image, we can spend enough time to find 
out the correct values, but so far it really looks like some garbage 
filling the range.

For now what I can do is add extra checks (making sure the root number 
seems valid), but it won't really catch all randomly corrupted data.


And as my final struggle, did this VM experienced any migration?
As that's the only thing not btrfs I can think of, that would corrupt 
data at runtime.

Thanks,
Qu
> 
> 
> Thanks,
> Kai
> 

