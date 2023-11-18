Return-Path: <linux-btrfs+bounces-178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876497EFE83
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 09:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0DC1C20953
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E07107A6;
	Sat, 18 Nov 2023 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="wxlqs1fI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF1D6A
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Nov 2023 00:27:31 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id 4Gfpr1D5fEwsU4GfprBaFi; Sat, 18 Nov 2023 09:27:29 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1700296049; bh=R6ZHhhg/zbbqWtnlZXf/ejc/6P86YzDkKOL9firK5Aw=;
	h=From;
	b=wxlqs1fIDqIUGPwfxQLHO0+FgGZeCFXZ56SMWSYH6MZGVQ1LKGlX3rb1CrqhKwdT5
	 /grSWkC+01snbythDFznrCso+0XNBleyGq/3A2Z2Q0zpw5A9i5D6tJpGWaCDCqss2l
	 3ofknT63rZKnq8I/HDZI9NwSvORU/LBWyrv6YU775fpDe34aukUihp/keSoq4kEwrW
	 ZBrEWX9yKlN7JHiu0ItsvtnwX8p8m+X0fFS1IDiSbP/6W+Zz2gfinvgxNJwP21VTzf
	 bETDmkIVzuufxjL9xosxi5ypop84z2eFwZRn1uZzoAl8Asnbdir0GwMeGZCsWjd83r
	 16VQF5LJF8Mag==
X-CNFS-Analysis: v=2.4 cv=N6vvVUxB c=1 sm=1 tr=0 ts=65587571 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=Ax1kiV2oZS2EjBD9PdMA:9 a=QEXdDO2ut3YA:10
Message-ID: <7d574364-0b4b-40e0-a8ac-12fc37b4f336@libero.it>
Date: Sat, 18 Nov 2023 09:27:29 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: checksum errors but files are readable and no disk errors
Content-Language: en-US
To: Remi Gauvin <remi@georgianit.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
 <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
 <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
 <59b6ad3e-c16e-4a29-abd4-4d6f57047155@libero.it>
 <65b3acc5-0aff-a7e8-142b-4ad40c60f3dd@georgianit.com>
 <4bf1d0d4-6fc3-434f-8166-7a628d48d52f@libero.it>
 <9f955c4a-82be-98cc-6f61-ee5469c32ba2@georgianit.com>
 <cecd43db-da2c-4558-b343-4faabacdf0d8@inwind.it>
 <5e4b13ab-2b8b-7115-be9c-c7f332982407@georgianit.com>
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <5e4b13ab-2b8b-7115-be9c-c7f332982407@georgianit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBp1OTp8PJUCSvizaNXx2En4fQpFBP4xQZxi05e6PPY+BMX5kff0e0KIDtzJVorsNvV04vCEizANrCTMwFLYE78KC7M/21Vsb/QTFwsH7sPerhg3VGsS
 tPVYHaDFqwCQYrfERpvoX/Mercso1QEeYpUUIEHbDgxk5X2O6VjGTmk2TIXEAJ3TulobW7jwjFWYFhUYn7S5czjsGEcKVlwKU5vFlMRwkpD4dDpRXs+JlPL2
 0xZXpZNZLqcbc+Qp4Qs3/F6yVRYSqKTEAe2swDT1ZqU=

On 17/11/2023 23.43, Remi Gauvin wrote:
> On 2023-11-17 5:00 p.m., Goffredo Baroncelli wrote:
>> I think that we should put everything in the right order:
>>
>> - COW:
>>      preserve data and metadata even after an unclean shutdown
>>
>> - BTRFS with NOCOW:
>>      preserve metadata even after an unclean shutdown
>>      data may be wrong
>>      depending by which disk is read, the data may be different
> 
>   
> 
> But what happens, for example, in the case of a virtual machine image,
> an automatic filesystem repair on the guest reads data that looks good,
> but a later read runs into corrupt or incomplete data?

As replayed in another thread, it is not a binary evaluation, but it is
a tradeoff between performance and reliability.

> 
> It just seems really bizarre to me to that you
> can have a raid implementation that doesn't keep mirrors synchronized,
> and has no mechanism to synchronize them, (other than user manually
> starting a full balance operation.)
> 
This is an interesting point: extend scrub to support also the NOCSUM
case with multiple copies: if the checksum mismatch, copy from the first
mirror to the others.

  
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


