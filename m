Return-Path: <linux-btrfs+bounces-177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ED27EFE80
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 09:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167311C208C2
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 08:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C2E1078C;
	Sat, 18 Nov 2023 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="gzAGwaEe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699A9D6A
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Nov 2023 00:22:23 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id 4Garr1ATFEwsU4GarrBYDz; Sat, 18 Nov 2023 09:22:21 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1700295741; bh=35zvMxYylvDXY9As0vFYHs4RxKgIgPYeJd3a+pkJjOI=;
	h=From;
	b=gzAGwaEeUxb1W5oar4gG9ymEqlsy4L+99DmUYhLlSWc9wAh41rplGR2ZkIFNjobdE
	 nmfm38HUUrGX/B3M+oxvSu86X8ueSy28vCcOk0CPPmfFYIqE0PYNKO3xffYzK5ejS0
	 0zZ1Z/zKtLptrs1dYZMlNaW/Gzr3uu+S7Bl6B5qX1P5fTcJ7ZFz8oIIkwZO9XxspDh
	 VaFRQsoT/hOp/HvnnnHAu9nvzgmBA05ojOFSSZxj8jqTT5RUZwS6UVGDmYQBqaVHFI
	 fLNOO+LBQama3A24+xnx26eMYIRcPVRoSdkQOCEpIYesFMnc+H3FeOf1cQPgBip7dG
	 NVPW/L05lKXWQ==
X-CNFS-Analysis: v=2.4 cv=N6vvVUxB c=1 sm=1 tr=0 ts=6558743d cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=2HqH-u5jyKpYD4WfckgA:9 a=QEXdDO2ut3YA:10
Message-ID: <95096727-a472-4c0b-a16d-de53b0f66ff6@libero.it>
Date: Sat, 18 Nov 2023 09:22:21 +0100
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
To: Matthew Warren <matthewwarren101010@gmail.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
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
 <CA+H1V9xqZT7L0tj3JTyJscXLKw-tpSE0qNULbg4hn0wYq4fhxw@mail.gmail.com>
 <CA+H1V9xA8_3-BYkhR2ip0v1_-bKxWY1hHW1kRwoxhaCNu88PYQ@mail.gmail.com>
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <CA+H1V9xA8_3-BYkhR2ip0v1_-bKxWY1hHW1kRwoxhaCNu88PYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDf0KWyomJneoIi6Dlgn4Y+CQCDbor1uqjgn0d9xKlF5yqdS+xxmz8ezIQagJHQgZS38OlrN86N5waBGsXg0NvUh7teCMJvWZHOZVb8k8im1HDRG6A4o
 /Z9n7VAlgXMeASZPcTOpj1Twmey48TnLBF18ud7wIn1AnUeVn/ji6z7Jy9MlpGXEuEfmgtP21myKU0ilMQ543VRC/qK0u9TKhCAvLCDybpnXkjR8OF5aQiw4
 snQ4KeTnC4/v+7NxpfjLnw==

On 18/11/2023 09.05, Matthew Warren wrote:
>> I think that we should put everything in the right order:
>>
>> - COW:
>>          preserve data and metadata even after an unclean shutdown
>>
>> - BTRFS with NOCOW:
>>          preserve metadata even after an unclean shutdown
>>          data may be wrong
>>          depending by which disk is read, the data may be different
>>
>> - EXT4 + MD (with a bitmap)
>>          preserve metadata even after an unclean shutdown
>>          data may be wrong
> 
> 
> If you put MD on top of dm-integrity you remove the issue of data
> being wrong since you get checksums for each block of data. Since
> reads of data with mismatching checksums results in an error, MD is
> able to determine a non corrupt copy. There could still be corruption,
> but it is reduced.

dm-integrity+dm-raid is not different from the default BTRFS config
(COW+CSUM). The point is how bad it performs.

It is not a binary evaluation, it is a trade off between reliability
and performance.


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


