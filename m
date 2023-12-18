Return-Path: <linux-btrfs+bounces-1041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E1A817B93
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 21:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C8BB23101
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB787204D;
	Mon, 18 Dec 2023 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="TWZWFdT/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF66FB6
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id FJrHrxbObtNr4FJrHrlkRI; Mon, 18 Dec 2023 21:04:59 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1702929899; bh=cCjACCR40KwnYw5sxzN14v7Q1G2Dv3sHh1xvCmVwJzA=;
	h=From;
	b=TWZWFdT/NIkoXfCPa4VbW5+4u0TgnUoua1tdtT1nWKxn+bxu9otOiBtHeN3PKgCdb
	 PdZp6pbGeeb2XAPjb5eSxWLIJ5OWpdxlsZzSt2hUvOMpfph0siJX8EnT8gCoF3gs5E
	 uCIUcCDehLmegMEVGk3f/omqwjW3MMRBwMnyP8nTtdEoR6tVaPa8xgKvo1DgDoCuxU
	 Ps9i4CReByVyHheuX8QoIG1LOwSYASBCkooLdGhq1vvw/PmT75fb/yj9g6yTOTB9Zy
	 L4M1XmVMMNpOmYWulL8tApOw1bE5J3Y3DdIjEvaKJLI8nxQpqCQau6gj5wU1XTZN9q
	 QE8Xa14bqIM1Q==
X-CNFS-Analysis: v=2.4 cv=Y44+8DSN c=1 sm=1 tr=0 ts=6580a5eb cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=DZp_LHW8HzMn4gUu:21 a=IkcTkHD0fZMA:10 a=rvfp5NhzCNV-azkXjUUA:9
 a=QEXdDO2ut3YA:10
Message-ID: <3f3162e9-9d3d-437d-83b5-adb9cac59830@libero.it>
Date: Mon, 18 Dec 2023 21:04:59 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
In-Reply-To: <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEuf3yYoXVL1sQidwY2fuo6L2phI/2AvQR4eSQ5ifdqR/yZDNY80izb6Nz+C7bL9L5UaQtjlRf8/o7KDscCl//xDfHCMGZ7Foj5uW6GJq2aRv00yvBLf
 Ii7H+Nf/dB71q/5pU7x+SfU4hWh8BEeYHF0A/ihNLHwnyezDlJ2N8zl3u8oUHiWPX+3mptpb43o7DZUMSOlWd2mm2RnzoOV9E2dmz6HxD06+XJe7m5gHwwb4
 R58332Z9b90oQAE0CuN1VWyw0l4MGrBQfaJ39NyH8uo=

On 18/12/2023 20.18, Goffredo Baroncelli wrote:
> On 18/12/2023 17.24, Christoph Anton Mitterer wrote:
>> Hey again.
>>
>> Seems that even the manual defrag doesn't help at all:
>>
>> After:
>> btrfs filesystem defragment -v -r -t 100000M
>
> Being only 309 files, I suggest to find one file as test case and start to inspect what is happening

I don't know if this would help, however I tried to reproduce this situation and what I found is

$ python3 mktestfile.py

$ sudo /usr/sbin/compsize test.bin
Processed 1 file, 3 regular extents (3 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      3.0M         3.0M         2.0M
none       100%      3.0M         3.0M         2.0M

$ btrfs fi defra -v test.bin

test.bin

$ sudo /usr/sbin/compsize test.bin
Processed 1 file, 3 regular extents (3 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      3.0M         3.0M         2.0M <------------- 3M
none       100%      3.0M         3.0M         2.0M

$ sync

$ sudo /usr/sbin/compsize test.bin
Processed 1 file, 2 regular extents (2 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      2.0M         2.0M         2.0M <------------- 2M after a sync
none       100%      2.0M         2.0M         2.0M


So until a sync, the file are not updated.


#------------------------------------------

$ cat mktestfile.py

import os

f = open("test.bin", "w")
p = 0
s = 1024 * 1024
for i in range(3):
         f.write("x" * s)
         p += s

         os.fsync(f)

         p -= s/2
         f.seek(p, 0)

os.fsync(f)
f.close()

#------------------------------------------


>>
>> there's still:
>> # compsize .
>> Processed 309 files, 324 regular extents (324 refs), 146 inline.
>> Type       Perc     Disk Usage   Uncompressed Referenced
>> TOTAL      100%       22G          22G          13G
>> none       100%       22G          22G          13G
>>
>>
>> Any other ideas how this could be solved?
>>
>> Cheers,
>> Chris.
>>
>

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


