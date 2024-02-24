Return-Path: <linux-btrfs+bounces-2700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF42F862218
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 02:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1441C241F0
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 01:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33163D530;
	Sat, 24 Feb 2024 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="bAlG5yKR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out3.mxs.au (h1.out3.mxs.au [110.232.143.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584D3C39
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Feb 2024 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708739514; cv=none; b=sY8IVnOJKyP73nneyNskb8J0RGG5f8ImUWb0rR9+oNDlTs+uySMYU8HjLpYvuxrbAIPV9eodCWQKhVog54vYoYuvRQADNavs8rTw5aiRC6+SdE8tTyS6WiBJxcfKhs91PpDo4BDVl0eb0MOBFBjg5quBL65BB4Yl5YTLnr90Vec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708739514; c=relaxed/simple;
	bh=aR9yBSbX2s4nIKmAv0RdmEwe42qQjEdoCkIi5b2i1K4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=H9BF37nRIWIKe3s/4apbW9oAZ27ERpNcTT1gCsUNdUG++c6vCv+qMF8A89ln9gOZhTaJOjX3W88Ead0ryW39xeMI+j6aXg9suJ0rb2R3US0BjB1M6SNoNR/Esjt02TlQ8qC2hJjUNUZrnn/JWQLqrBonrNMQhZGTqBVSfW7+VHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=bAlG5yKR; arc=none smtp.client-ip=110.232.143.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out3.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id 42a1c7b0-d2b7-11ee-990e-00163c573069
	for <linux-btrfs@vger.kernel.org>;
	Sat, 24 Feb 2024 12:51:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s4QFFOZST38Wk+h+exdswrsRbbDW7tcM1mrFboNEcxg=; b=bAlG5yKRN1yqCQ4GwTb/tOThSk
	Z7kol9fbRUGWd7R9nculD6wb9YGr9lOCFmgFcst2JKm+gbQg9mRZSu6+afqhsQld+GvRUEjW32tYO
	vFo6KuojmGSw5NPJ/bnvn603kAXOiRbHpB4cV1W2uZRkyjIBTg4f9sGBdUwk77vgXLVCDuxF9yHoR
	zPIRl0iShWVordU8Eso3CnCi3bJEKF0jAsE8FFGNgiTA7Zk3eGdEDCqZinlrXJ1ae+Ny02bf3oHqf
	hmMaJV2WsDCLU0UThmsTcMKYByLcrkDc4W2w9THP4nkH4Yx5bvKapj0IuQuT71Uvjcjsrum027Xf0
	HVlY1+qQ==;
Received: from [159.196.20.165] (port=49478 helo=[192.168.2.2])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <default@edcint.co.nz>)
	id 1rdhCZ-002YeJ-0s;
	Sat, 24 Feb 2024 12:51:43 +1100
Message-ID: <2b2d37d2-d618-44eb-97f8-549b99b7b4d1@edcint.co.nz>
Date: Sat, 24 Feb 2024 12:51:42 +1100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
Content-Language: en-US
From: Matthew Jurgens <default@edcint.co.nz>
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
 <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
 <be5917ba-4940-4800-9fbf-c1a24f4d82be@edcint.co.nz>
 <7382a5c8-726f-41b3-9cbf-b2c67f0a5419@suse.com>
 <0dd56988-e191-45c7-a3d7-60f43fc4b7fd@edcint.co.nz>
In-Reply-To: <0dd56988-e191-45c7-a3d7-60f43fc4b7fd@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s02bd.syd2.hostingplatform.net.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - edcint.co.nz
X-Get-Message-Sender-Via: s02bd.syd2.hostingplatform.net.au: authenticated_id: default@edcint.co.nz
X-Authenticated-Sender: s02bd.syd2.hostingplatform.net.au: default@edcint.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 


On 24/02/2024 12:22 pm, Matthew Jurgens wrote:
> As I understand rescue=all, I don't need it for allowing me to mount 
> (since I can already mount the file system) but it will allow me to 
> copy damaged files out of the file system. However, I don't know what 
> is damaged. I do have backups.
>
> Commands like  btrfs inspect-internal logical-resolve 20647087898624  
> /export/shared
>
> just return
> ERROR: logical ino ioctl: No such file or directory
>
Having said this, I think I can find which files are damaged by trying 
to read every single file on the file system.

I was just doing some space calculations using du and it started 
throwing errors like:

du: cannot access '/export/shared/backups/xyz': Input/output error

which also resulted in entries in the messages file like:

kernel: BTRFS warning (device sdg): checksum verify failed on logical 
20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0

where 20647087931392 is a number that appears in other messages eg dmesg

I figure I can then just run a du on the whole file system and any files 
it complains about are probably problematic.

If it turns out that I can do without the files, can I fix the problem 
just by deleting them or is there something else I must do?

> On 24/02/2024 9:12 am, Qu Wenruo wrote:
>>
>>
>> 在 2024/2/24 08:11, Matthew Jurgens 写道:
>>>
>>> On 24/02/2024 6:55 am, Qu Wenruo wrote:
>>>>
>>>>
>>>> 在 2024/2/23 21:39, Matthew Jurgens 写道:
>>>>> If I can't run --repair, then how do I repair my file system?
>>>>>
>>>>> I ran a scrub which reported 8 errors that could not be fixed.
>>>>
>>>> The scrub report and corresponding dmesg please.
>>>>
>>> The latest scrub report is
>>>
>>> UUID:             021756e1-c9b4-41e7-bfd3-bc4e930eae46
>>> Scrub started:    Fri Feb 23 21:42:13 2024
>>> Status:           finished
>>> Duration:         5:52:50
>>> Total to scrub:   9.00TiB
>>> Rate:             447.36MiB/s
>>> Error summary:    verify=8
>>>    Corrected:      0
>>>    Uncorrectable:  8
>>>    Unverified:     0
>>>
>>>
>>> Probably the most relevant dmesg lines:
>> [...]
>>> [10226.535987] BTRFS warning (device sdg): tree block 20647087931392 
>>> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
>>> [10226.615321] BTRFS warning (device sdg): tree block 20647087931392 
>>> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
>>> [10226.615524] BTRFS warning (device sdg): tree block 20647087931392 
>>> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
>>> [10226.615731] BTRFS warning (device sdg): tree block 20647087931392 
>>> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
>>
>> This is not good, this means both tree block copies are having csum 
>> mismatch.
>>
>> Since both metadata copies are corrupted, it's not some on-disk data 
>> corruption, but more likely some runtime corruption leads to bad csum 
>> (like runtime memory corruption).
>>
>> Since the unmounted fsck still gave tons of error on fs tree, I'd say 
>> at least some of the corrupted tree blocks are in subvolume trees.
>> (aka, affecting data salvage)
>>
>> The first thing I'd recommend is to do a full memory tests (if it's 
>> not ECC memory), to make sure the hardware is not the cause. Or it 
>> would just show up again no matter whatever filesystem you're using 
>> in the next try.
>>
>> Anyway, since the fs is really corrupted, data salvage is recommended 
>> before doing any writes into the fs.
>> You can salvage the data by "-o ro,rescue=all" mount option.
>>
>> I won't recommend any further rescue/writes until you have verified 
>> the hardware memory and rescued whatever you need.
>>
>> Thanks,
>> Qu
>>

