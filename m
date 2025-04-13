Return-Path: <linux-btrfs+bounces-12969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3431A87101
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Apr 2025 10:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89EE03AFEB5
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Apr 2025 08:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248D17A30A;
	Sun, 13 Apr 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=olstad.com header.i=@olstad.com header.b="XnmPB9wu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72AAD58
	for <linux-btrfs@vger.kernel.org>; Sun, 13 Apr 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744532056; cv=none; b=oHrbG1EfZmWrmtZhsLeZekB3nVEXsSxbnhBnCzx51oOB+XQZJx7fVTmoVYAvxF9B6bR5I42skOeJ/YdSGzO3B+XOI159JRLfAMBVcUWHNJiX2imaBdF+y6Lt3vnl9y/SPdFt8aBXS8E2dBL+kYr4JyR6/v1RymJf34hsnCUYFqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744532056; c=relaxed/simple;
	bh=IRZJ7DoTan6izBghMCmOl4/u4Q2LbDJh4hTz4oSUoVg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=k90SGk2ySJStK42dn80MrV/Omx6h3M5KrlzbT2Yo8woOuRNDBD2v46kXMZr1oNTMPWlj9D5M9c2uGx39a4Wds8U//280OtJ3yf2sj7liWbRMpgUtDpE3NSTGQJRIFJNmHHDE2mHc8vssc45vIPLkRgwM5qqdy4qyFOp8TawAXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=olstad.com; spf=pass smtp.mailfrom=olstad.com; dkim=pass (2048-bit key) header.d=olstad.com header.i=@olstad.com header.b=XnmPB9wu; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=olstad.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=olstad.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=olstad.com;
	s=ds202407; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:From:Sender:Reply-To:Subject
	:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pckJfOes1PKvprQ+1qhMJP7IosaeO/2Tl5bIWKlKZ1k=; b=XnmPB9wuiLnyns+E0ej+powqex
	Ln78P21QhZSa3Slpg/hdnD9lKvithy2YCUP28NI7+wnqtKyf8z7VNn6/UDOonbZKKjm9HHqsL2Zj5
	Uskdk8LohNBzVMtlvA64hN1vJXIgnTy2S87V/sqCB+Etppxwy9i+FAMbYVN9VvRYgirIBUYQwpFvL
	U2RmPqqvJWRK1YODwcHdK8qazLyUdetrm+57+sWUyMNgVld1EeLDM3po/leFRGZtQ2dqUzJ4PZAiD
	+RmOapIaOz26eBUkKWSUP0+phHDb23lcoOsjj8qiX1XsluQixk1Z56eCZIrXCsHH4pAN4OhIKx05i
	NVn4VvOw==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1u3sTe-0016oJ-2r;
	Sun, 13 Apr 2025 10:14:06 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 13 Apr 2025 10:14:03 +0200
From: Kai Stian Olstad <btrfs+list@olstad.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: How to fix "BTRFS error (device dm-3): error writing primary
 super block to device 1"?
In-Reply-To: <c15e6edd-0bbb-4670-a4de-db500080601e@gmx.com>
References: <n2evrtemnyldsra4jh3442h36v2tgi4pem5p7ramknkkabkooe@fre6ayihkaie>
 <084ef89e-7988-4d0a-9d63-cf0a5e0ef2af@suse.com>
 <8783cfb2978ada01ae68d7ae4f9f7c06@olstad.com>
 <3d2074dc-a36b-4fc2-8e20-52cf40584b38@gmx.com>
 <b669450cfb7690e99cc4d9c63daa0680@olstad.com>
 <c15e6edd-0bbb-4670-a4de-db500080601e@gmx.com>
Message-ID: <0098f9689655ea11f9f0913f2b797201@olstad.com>
X-Sender: btrfs+list@olstad.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 12.04.2025 05:15, Qu Wenruo wrote:
> 在 2025/4/12 10:32, Kai Stian Olstad 写道:
>> On 12.04.2025 02:43, Qu Wenruo wrote:
>>> 在 2025/4/12 09:59, Kai Stian Olstad 写道:
>>>> On 12.04.2025 00:10, Qu Wenruo wrote:
>>>>> 在 2025/4/12 01:18, Kai Stian Olstad 写道:
>>>>>> Kubuntu 24.04
>>>>>> Kernel 6.8.0-57-generic
>>>>>> 
>>>>>> 2 day ago I got a sector error on one of the BTRFS disk
>>>>>> 
>>>>>> $ journalctl -k -S 2025-04-09 | grep -A 20 mpt3sas_cm0
>>>>>> Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000):
>>>>>> originator(PL), code(0x08), sub_code(0x0000)
>>>>>> Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000):
>>>>>> originator(PL), code(0x08), sub_code(0x0000)
>>>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 FAILED 
>>>>>> Result:
>>>>>> hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=6s
>>>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Sense Key :
>>>>>> Illegal Request [current]
>>>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Add. Sense:
>>>>>> Logical block address out of range
>>>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 CDB: 
>>>>>> Write(16)
>>>>>> 8a 08 00 00 00 00 00 00 10 80 00 00 00 08 00 00
>>>>>> Apr 09 03:16:26 cb kernel: critical target error, dev sdd, sector
>>>>>> 4224 op 0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0
>>>>> 
>>>>> This error is completely from the lower layer (the block device).
>>>>> 
>>>>> Btrfs nor the LUKS upon the disk can do anything to it.
>>>> 
>>>> Thank you for the response.
>>>> 
>>>> This disk support scterc
>>>> 
>>>> $ sudo smartctl -l scterc /dev/sdd
>>>> SCT Error Recovery Control:
>>>>             Read:     70 (7.0 seconds)
>>>>            Write:     70 (7.0 seconds)
>>>> 
>>>> Doesn't that mean that the disk gives up after 7 seconds, and then 
>>>> the
>>>> sector i mapped to a spare.
>>>> So if Btrfs does a write to the sector again it will be written to 
>>>> the
>>>> spare?
>>>> 
>>>> I've experienced numerous sector errors throughout the years with 
>>>> mdadm
>>>> and they have been fixed with a check.
>>>> Also a few with Btrfs I think, but they have been fixed 
>>>> automatically.
>>> 
>>> Whatever the feature is, it's block device driver's behavior.
>>> 
>>> Btrfs only errors out because the disk reported the write failed.
>>> 
>>> For the detailed reason you should check these lines:
>>> 
>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 FAILED Result:
>>> hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=6s
>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Sense Key :
>>> Illegal Request [current]
>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Add. Sense:
>>> Logical block address out of range
>> 
>> I'll check them but this is what I usually sees when a disk have a
>> sector error.
>> 
>> 
>>>> So why not this time?
>>>> To me this looks like an ordinary faulty sector that can be "fixed" 
>>>> with
>>>> a write?
>>>> 
>>> I'm not sure what ever the "SCT Error recovery control" feature is, 
>>> but
>>> if it is designed to re-map a write, it should not return -EIO for 
>>> the
>>> initial write failure, but OK as long as eventually the write 
>>> succeeded.
>>> 
>>> It should not require any upper layer to do any extra work.
>>> 
>>> But since the write eventually failed, there is nothing upper layer 
>>> can
>>> do, unless the dm or fs layer has some extra recovery mechanism.
>> 
>> Now I'm confused, I'm running RAID1 an only one disk has/had 1 sector
>> failure.
>> Shouldn't Btrfs manage to to write this data, it should exist on one 
>> of
>> the other drives because of RAID1?
>> And shouldn't a scrub fix it?
> 
> Sorry, I finally got your concern that, it's not about the initial 
> write
> failure, but the future errors messages.
> 
> It turns out to be a bug in the older kernels, that after one super
> block write back error, the folio keeps its error flag without clearing
> it up, thus it always shows an error message.
> 
> And since it's RAID1, btrfs continues the fs (thus your fs is still
> running, not flipping into read-only).
> 
> Scrub won't solve it because there is nothing to resolve, everything is
> fine, except the false warning messages.
> 
> 
> In upstream it's fixed by a rework patch, upstream commit bc00965dbff7
> ("btrfs: count super block write errors in device instead of tracking
> folio error state") fixes the bug by going a completely different path
> counting the super block write back errors.
> 
> Unfortunately that commit is only in v6.10, and since it's not
> explicitly marked as a bug fix (even it indeed fixes a hidden bug), 
> it's
> not backported to any older kernel. (BTW, 6.8 kernel is already EOL)
> 
> Please update to v6.12 or newer LTS kernels.
> 
> Or just unmount and remount the fs and pray no more super block
> writeback errors happen again...

Unfortunately Canonical is shipping 6.8 with there latest LTS release 
and managing backports inhouse i guess.
But they have an option to upgrade to 6.11 with there Hardware 
Enablement (HWE) program.

At least I get that patch upgrading to 6.11.

Thank you for your help Qu.

-- 
Kai Stian Olstad

