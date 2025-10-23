Return-Path: <linux-btrfs+bounces-18228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A47FC03695
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 22:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC0EC504FE5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 20:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE17244698;
	Thu, 23 Oct 2025 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz7YYkvR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31D91DE3C7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252133; cv=none; b=h8nr2VSbrhpKaeo54kEnTdeaPe793eEL3FfTkqAdhJdIDCgaJ6mpb80P/yJjID/kDIDOgL3Hfie0R7w054rO1nXwgpsLNp1Nwxhz0rXAPivykF0c9P69BgYua8T8duehSpiBs8mB9CDo4xCvaezgiAc1zYZEYFRYObpQ7Enuvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252133; c=relaxed/simple;
	bh=PDOk5q4ikNsoJ7LaEKqMOSHmjcL2HrrBiXoNtKrmcuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnPg5vdncUIlNt1r2yAm0qzWJUoFXzVq9bl4ltm8aWWVaF2Zy2y2NPltmdxVmckpJsBYYoj4Jce3JWwC1s0aWsVVXg2JxfPXsccc19Zk5NFgZJlJWOOMTfYnaHw2ioPxalGTGhirwrC7ZRwseqvw1i3/HSJgjUz8aV4jh0xYH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz7YYkvR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47117e75258so9980465e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761252129; x=1761856929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zH23/gL2/USZLjj/JPdi7ffud5niCkNtnKaJxQ+IhR4=;
        b=Nz7YYkvRfAPWuBQiozd2EoqtjCYhMKY1dzhlJQNeryYt2f9leHj/UhBjlrC2RmuOYf
         gzKUb/dWuNSaTvxZQC/BWnWGG9nyAkH1CsipyuCT7ah/gpVqqeb0ZDwCElJilz1neUBi
         pfHn3MvsPbX/1KnqEvtrrwWsB0dUzTlKavo0NQWRXRBf1OFKYCTdQJbFTMINehKqrIv/
         WIxgqSZNofWjjzSITfOSqjKiPVTITDXBctcJQflCV4d4d4F00O2zxuV7WNhMH1GlrpDW
         gPmyETMU1QZ7lfLjlqtk9kVmt3jN05MJGbCbaHchmEWNYX/lLHOVmyCwkq9nVcnP95/Q
         9kgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252129; x=1761856929;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zH23/gL2/USZLjj/JPdi7ffud5niCkNtnKaJxQ+IhR4=;
        b=C2/dm7Q20dx/u0kWWV+DBPCingGQ9Gk8XAG+kkQfOM6Fn1l82r3U0VXAhP6xLfgOqI
         z1Qu93GpBQ3Tw437CQ+2qcOmQ08iJQSscRiFOOn2i+LVDsOojsZIhAqWXG4vms7O56gm
         xgIuuzHaE6Sh5li/V80gvfihDYvbFlrW5zf3YyE+aUoTvSF43Q3GxO04KdC1yljxeNGg
         TCe/+HZo1xMHAgddbgZ0D9oplwmU3mSIk0buLbByb8V2tr3qcpTC9ZKaS/1nNha4FeFF
         zXwPRQm1t+XQ3N8VuWm/ye1lpyESSojuxNF2PuxqXC/PonZ/gC+npUcWXy+338C8+LVM
         bcDA==
X-Forwarded-Encrypted: i=1; AJvYcCX5S/oI9wrVWYS7uXCdode745CQmPafSatVrkdDuz4RB/VgBj0hZ+GzjA1Bl5gcZOyaebk7EXSB668qsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaoKgaHWE4FouJHojYjhostrTH8AC2Nrx5mgtF+qon1ySVdSVN
	hEPoM+MWz6Zhd0p6UplKdSUdq85TQYzkNuxjrbdyDPrl1AIBw0AMZbFS
X-Gm-Gg: ASbGncvkbZuGq/BDn7EylZ0n51zPh/5OA3vUG+Iel3rpIV3TrLR2obTQbEB/+yQy3F+
	cfWfRb8yyM7/CfHcKnzpndrdEdqZmjNFw58nIRLtLF6uCq7Hmccr5Dy8TQPKwTh+6Momm7M1q2L
	H22beham4zLBSM0c4yfH+wkFGpEz2PfMHEI2xwUtKXXyEDyZHDUrix72cED16g1rYn+Pw17Jyhg
	wRtufCd6GFn+n/mo0Hr9C3QgdqhSeAoMXR+kIOA1pyO6TJvbDZpyfWvU5/4GfyLyCtIPF1ELjll
	FF1niZDaM2B0C4VMrPf0opyK2cEBAZVZUGlHdUz7jZ4kuXzEs94/K+40XecpYPvMRRty692S9eu
	4AhriYX2Eg3GlhPV9/ma0+6CilDrsPofHDY0XrP0o2cWHBJtBmEW/zWrthl8b4NlS6NL4rCPqs+
	5Z1/kgRwrLk77430A/ikw55u+U+g==
X-Google-Smtp-Source: AGHT+IHCVB+Pybief1JnxZp/9KwSmKb9+DyZ4IikoY3sTAsLQTmu8dNdfCeK9ekGtKedPfaO6daR0Q==
X-Received: by 2002:a05:600c:46c5:b0:46e:1cc6:25f7 with SMTP id 5b1f17b1804b1-475cafacc30mr25848925e9.9.1761252129022;
        Thu, 23 Oct 2025 13:42:09 -0700 (PDT)
Received: from [192.168.2.12] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf2f142sm56851425e9.15.2025.10.23.13.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 13:42:08 -0700 (PDT)
Message-ID: <a48a37e3-2c22-44fb-97a4-0e57dc20421a@gmail.com>
Date: Thu, 23 Oct 2025 22:42:07 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dm bug: hibernate to swap located on dm-integrity doesn't work
 (how to get data redundancy for swap?)
To: Askar Safin <safinaskar@gmail.com>, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-lvm@lists.linux.dev,
 lvm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 DellClientKernel <Dell.Client.Kernel@dell.com>, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org
Cc: Nhat Pham <nphamcs@gmail.com>, Kairui Song <ryncsn@gmail.com>,
 Pavel Machek <pavel@ucw.cz>, =?UTF-8?B?Um9kb2xmbyBHYXJjw61hIFBlw7FhcyAoa2l4?=
 =?UTF-8?Q?=29?= <kix@kix.es>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Lennart Poettering
 <mzxreary@0pointer.de>, Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20251023112920.133897-1-safinaskar@gmail.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 xsFNBE94p38BEADZRET8y1gVxlfDk44/XwBbFjC7eM6EanyCuivUPMmPwYDo9qRey0JdOGhW
 hAZeutGGxsKliozmeTL25Z6wWICu2oeY+ZfbgJQYHFeQ01NVwoYy57hhytZw/6IMLFRcIaWS
 Hd7oNdneQg6mVJcGdA/BOX68uo3RKSHj6Q8GoQ54F/NpCotzVcP1ORpVJ5ptyG0x6OZm5Esn
 61pKE979wcHsz7EzcDYl+3MS63gZm+O3D1u80bUMmBUlxyEiC5jo5ksTFheA8m/5CAPQtxzY
 vgezYlLLS3nkxaq2ERK5DhvMv0NktXSutfWQsOI5WLjG7UWStwAnO2W+CVZLcnZV0K6OKDaF
 bCj4ovg5HV0FyQZknN2O5QbxesNlNWkMOJAnnX6c/zowO7jq8GCpa3oJl3xxmwFbCZtH4z3f
 EVw0wAFc2JlnufR4dhaax9fhNoUJ4OSVTi9zqstxhEyywkazakEvAYwOlC5+1FKoc9UIvApA
 GvgcTJGTOp7MuHptHGwWvGZEaJqcsqoy7rsYPxtDQ7bJuJJblzGIUxWAl8qsUsF8M4ISxBkf
 fcUYiR0wh1luUhXFo2rRTKT+Ic/nJDE66Ee4Ecn9+BPlNODhlEG1vk62rhiYSnyzy5MAUhUl
 stDxuEjYK+NGd2aYH0VANZalqlUZFTEdOdA6NYROxkYZVsVtXQARAQABzSBNaWxhbiBCcm96
 IDxnbWF6eWxhbmRAZ21haWwuY29tPsLBlQQTAQgAPwIbAwYLCQgHAwIGFQgCCQoLBBYCAwEC
 HgECF4AWIQQqKRgkP95GZI0GhvnZsFd72T6Y/AUCYaUUZgUJJPhv5wAKCRDZsFd72T6Y/D5N
 D/438pkYd5NyycQ2Gu8YAjF57Od2GfeiftCDBOMXzh1XxIx7gLosLHvzCZ0SaRYPVF/Nr/X9
 sreJVrMkwd1ILNdCQB1rLBhhKzwYFztmOYvdCG9LRrBVJPgtaYqO/0493CzXwQ7FfkEc4OVB
 uhBs4YwFu+kmhh0NngcP4jaaaIziHw/rQ9vLiAi28p1WeVTzOjtBt8QisTidS2VkZ+/iAgqB
 9zz2UPkE1UXBAPU4iEsGCVXGWRz99IULsTNjP4K3p8ZpdZ6ovy7X6EN3lYhbpmXYLzZ3RXst
 PEojSvqpkSQsjUksR5VBE0GnaY4B8ZlM3Ng2o7vcxbToQOsOkbVGn+59rpBKgiRadRFuT+2D
 x80VrwWBccaph+VOfll9/4FVv+SBQ1wSPOUHl11TWVpdMFKtQgA5/HHldVqrcEssWJb9/tew
 9pqxTDn6RHV/pfzKCspiiLVkI66BF802cpyboLBBSvcDuLHbOBHrpC+IXCZ7mgkCrgMlZMql
 wFWBjAu8Zlc5tQJPgE9eeQAQrfZRcLgux88PtxhVihA1OsMNoqYapgMzMTubLUMYCCsjrHZe
 nzw5uTcjig0RHz9ilMJlvVbhwVVLmmmf4p/R37QYaqm1RycLpvkUZUzSz2NCyTcZp9nM6ooR
 GhpDQWmUdH1Jz9T6E9//KIhI6xt4//P15ZfiIs7BTQRPeKd/ARAA3oR1fJ/D3GvnoInVqydD
 U9LGnMQaVSwQe+fjBy5/ILwo3pUZSVHdaKeVoa84gLO9g6JLToTo+ooMSBtsCkGHb//oiGTU
 7KdLTLiFh6kmL6my11eiK53o1BI1CVwWMJ8jxbMBPet6exUubBzceBFbmqq3lVz4RZ2D1zKV
 njxB0/KjdbI53anIv7Ko1k+MwaKMTzO/O6vBmI71oGQkKO6WpcyzVjLIip9PEpDUYJRCrhKg
 hBeMPwe+AntP9Om4N/3AWF6icarGImnFvTYswR2Q+C6AoiAbqI4WmXOuzJLKiImwZrSYnSfQ
 7qtdDGXWYr/N1+C+bgI8O6NuAg2cjFHE96xwJVhyaMzyROUZgm4qngaBvBvCQIhKzit61oBe
 I/drZ/d5JolzlKdZZrcmofmiCQRa+57OM3Fbl8ykFazN1ASyCex2UrftX5oHmhaeeRlGVaTV
 iEbAvU4PP4RnNKwaWQivsFhqQrfFFhvFV9CRSvsR6qu5eiFI6c8CjB49gBcKKAJ9a8gkyWs8
 sg4PYY7L15XdRn8kOf/tg98UCM1vSBV2moEJA0f98/Z48LQXNb7dgvVRtH6owARspsV6nJyD
 vktsLTyMW5BW9q4NC1rgQC8GQXjrQ+iyQLNwy5ESe2MzGKkHogxKg4Pvi1wZh9Snr+RyB0Rq
 rIrzbXhyi47+7wcAEQEAAcLBfAQYAQgAJgIbDBYhBCopGCQ/3kZkjQaG+dmwV3vZPpj8BQJh
 pRSXBQkk+HAYAAoJENmwV3vZPpj8BPMP/iZV+XROOhs/MsKd7ngQeFgETkmt8YVhb2Rg3Vgp
 AQe9cn6aw9jk3CnB0ecNBdoyyt33t3vGNau6iCwlRfaTdXg9qtIyctuCQSewY2YMk5AS8Mmb
 XoGvjH1Z/irrVsoSz+N7HFPKIlAy8D/aRwS1CHm9saPQiGoeR/zThciVYncRG/U9J6sV8XH9
 OEPnQQR4w/V1bYI9Sk+suGcSFN7pMRMsSslOma429A3bEbZ7Ikt9WTJnUY9XfL5ZqQnjLeRl
 8243OTfuHSth26upjZIQ2esccZMYpQg0/MOlHvuFuFu6MFL/gZDNzH8jAcBrNd/6ABKsecYT
 nBInKH2TONc0kC65oAhrSSBNLudTuPHce/YBCsUCAEMwgJTybdpMQh9NkS68WxQtXxU6neoQ
 U7kEJGGFsc7/yXiQXuVvJUkK/Xs04X6j0l1f/6KLoNQ9ep/2In596B0BcvvaKv7gdDt1Trgg
 vlB+GpT+iFRLvhCBe5kAERREfRfmWJq1bHod/ulrp/VLGAaZlOBTgsCzufWF5SOLbZkmV2b5
 xy2F/AU3oQUZncCvFMTWpBC+gO/o3kZCyyGCaQdQe4jS/FUJqR1suVwNMzcOJOP/LMQwujE/
 Ch7XLM35VICo9qqhih4OvLHUAWzC5dNSipL+rSGHvWBdfXDhbezJIl6sp7/1rJfS8qPs
In-Reply-To: <20251023112920.133897-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am not sure why you cc so many people, most of lists are not relevant here.

Anyway, could you please test one thing below so the problem is better isolated?

On 10/23/25 1:29 PM, Askar Safin wrote:
...
> Also I tried to add "--integrity-no-journal" to "format" and "open".
> It didn't work, either. (I don't remember what exactly didn't work.
> I can do this experiment again, if needed.)

Are you sure you used --integrity-no-journal both in activation before
hibernation and also in resume? If not, please try it.
This flag activates direct mode and and completely avoids dm-integrity journal.
You can verify it with "integritysetup status <device>" - it should say "journal: not active".

And if it does not work, could you try to use -integrity-recovery-mode the same
way (both before hibernation and later in resume)? This will effectively ignore checksums
providing no protection, but keeping dm-integrity device still in place.
You can verify it with "integritysetup status <device>" - it should say "mode: read/write recovery".
Is the problem still in place with this setting?

You can also try to decrease journal commit time with --journal-commit-time option,
but this is not a real solution.

...> 
> Then I tried to do "cryptsetup" instead of "integritysetup". I created
> swap partition so:
> 
> cryptsetup luksFormat --type luks2 /dev/disk/by-partuuid/c4bbc73d-7909-42ea-8d96-eab82512cbe7 /tmp/key
> cryptsetup open --type luks2 --key-file /tmp/key /dev/disk/by-partuuid/c4bbc73d-7909-42ea-8d96-eab82512cbe7 swap
> mkswap /dev/mapper/swap
> swapon /dev/mapper/swap
> 
> And, of course, I did all necessary edits to initramfs.
> 
> And this time everything worked. This proves that I didn't do any mistakes in my setup
> (i. e. I got initramfs right, etc), and this is actual bug in dm-integrity.
> 
> Unfortunately, LUKS created such way doesn't have any redundancy. So this is not solution for me.

Redundancy? You mean data integrity protection? There is no redundancy, only additional authentication tag
(detecting integrity error but not correcting it).

Thanks,
Milan


