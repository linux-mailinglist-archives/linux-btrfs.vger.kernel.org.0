Return-Path: <linux-btrfs+bounces-1038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC0F817ADB
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 20:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C2A285E9E
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 19:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37517144F;
	Mon, 18 Dec 2023 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="r9V/+Unn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424001DDFC
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id FJ8FrxKurtNr4FJ8FrlWx1; Mon, 18 Dec 2023 20:18:27 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1702927107; bh=b+dOq7yCfbwVMqsYYBuOi27lUJlHltt4nmUzQw3XsvU=;
	h=From;
	b=r9V/+Unn3lfh0BI1JV/eBTzGfAevrqBZHdBxch5loVkXlVv+gBi/mOlZCwWmTs639
	 vEKwiYmRelmDqsj99l2DTG4CEWwCmqiBjUNrGsW66rH/KLGuOTaBecSbLpYiKTQEyF
	 jmu8ffHyesYcxUd/pQ86jlA/RYGhpYaHrS0hZ26VQAddOMJUPVNw8kwmiR503twvLk
	 pzStfFW3OhCQHGfMGCzx80eRAb3yCXWWakCaftYBPG0ZoqVxRkIDmsBdOfNUgndWj6
	 kGZy6K9y5bHMbUbSOtSdqH4voWtEtCm87FMI/SWTyLQugvao2CP5557LH3BYwcYZ2q
	 wuuMJHp/Y2z7Q==
X-CNFS-Analysis: v=2.4 cv=Y44+8DSN c=1 sm=1 tr=0 ts=65809b03 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=DZp_LHW8HzMn4gUu:21 a=IkcTkHD0fZMA:10 a=t0idf5vbE2PYs_KIaFsA:9
 a=QEXdDO2ut3YA:10
Message-ID: <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
Date: Mon, 18 Dec 2023 20:18:27 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
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
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGH0DgyWjUU/VAlt2jJg+UV9evk98DnGDHIHzjGk25eDN6x45D8nw7KbZ9ysO7zyBnLg1amZffyza4MOSZw94hiL1vtmoGEQUVxPZZdjBUngz7K9F6rL
 6d1QB6HZyNGF4G7YjU3NnkPHcKvs0oh7OCRRswgNv7RIQVMbRhQPdKxS5Sl3fPndRjw6aVYsn1w58bRsRxhngXUSWxdZO+1YJO+Kdq3owTo8Smvz0FZXwf1K
 1c+eBfmF399+dRxghTJ4gxMPidfE7Uq9EuixneagkYY=

On 18/12/2023 17.24, Christoph Anton Mitterer wrote:
> Hey again.
>
> Seems that even the manual defrag doesn't help at all:
>
> After:
> btrfs filesystem defragment -v -r -t 100000M

Being only 309 files, I suggest to find one file as test case and start to inspect what is happening.

>
> there's still:
> # compsize .
> Processed 309 files, 324 regular extents (324 refs), 146 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%       22G          22G          13G
> none       100%       22G          22G          13G
>
>
> Any other ideas how this could be solved?
>
> Cheers,
> Chris.
>

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


