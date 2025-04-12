Return-Path: <linux-btrfs+bounces-12963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3AAA869F2
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 03:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD114A7C60
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 01:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC5D73477;
	Sat, 12 Apr 2025 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=olstad.com header.i=@olstad.com header.b="ooSd1Xkr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F71D530
	for <linux-btrfs@vger.kernel.org>; Sat, 12 Apr 2025 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744419729; cv=none; b=fmIvxKWIb7QWM/cv/bmIElPGo6pUoo/DoT8pWL7PXUOpKQn01mN9zC+q3Yp0oNvWGVdzZkst1CwdQZwQrXucCAzYvI+8qVz0Lhty4SLi2BUESH00swrC5gxeL7UTM3y7i/HpKPf+A1/kWbBsVoyNLdAZtv3zGcFbqPUC5tanVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744419729; c=relaxed/simple;
	bh=6ycGEbhLhufrGuidskRbF8cA6jCycAOTGVsn8CQgDic=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QL1gt3AXD1XOMEXRSAhjCCJwp6If7OPGNFWTU5fmHq6fYtV/eETbTKkIMdXlKB2DWuTV6qjF4FWqpGF+BpFD498d8/obBUwrrL3wYc+sPJ4xeG20FrfBjX5zpU14O66AiWVPaziB3GmIooVhaMC8W6CT2a0kiRks9HKS7fjq0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=olstad.com; spf=pass smtp.mailfrom=olstad.com; dkim=pass (2048-bit key) header.d=olstad.com header.i=@olstad.com header.b=ooSd1Xkr; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=olstad.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=olstad.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=olstad.com;
	s=ds202407; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:From:Sender:Reply-To:Subject
	:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=64Q1f+9+L1kPUeg8Xm3h+taz3/bZ2vHmf7M7rTyqdw4=; b=ooSd1XkrwaxdIGdPbBjqvn0vbC
	uph9sXMdkuSjfXbFSPldStJ7MHVHtzvRiv5IXe7qgi/803yg4RvxQsCMI+L2QjJwJRdtqpbGxf/mY
	l8q+rAfl9AToMRKaPx2COpDzrOHe704X2r5JsxKaWffaQ1QSJlYtHj4r6tTeoZ1FPaiAmuMKsqdEL
	pVzWEuwuW3HKSxk1cZYr7w0oQqDeK6GPsQOFCHpfMDZyy7zU8JfxBW5N4+GO/3stF/TufzxgDzVWQ
	QvKjLzDBYm/xSV34gey915MiyLq0fjRfMWZaSfmQeYYTl2F0ojvJm/DBj7xS/OpfcRKY1yCVWJxv+
	QIN5eWZg==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1u3PG1-00ClyY-L2;
	Sat, 12 Apr 2025 03:02:05 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 12 Apr 2025 03:02:04 +0200
From: Kai Stian Olstad <btrfs+list@olstad.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: How to fix "BTRFS error (device dm-3): error writing primary
 super block to device 1"?
In-Reply-To: <3d2074dc-a36b-4fc2-8e20-52cf40584b38@gmx.com>
References: <n2evrtemnyldsra4jh3442h36v2tgi4pem5p7ramknkkabkooe@fre6ayihkaie>
 <084ef89e-7988-4d0a-9d63-cf0a5e0ef2af@suse.com>
 <8783cfb2978ada01ae68d7ae4f9f7c06@olstad.com>
 <3d2074dc-a36b-4fc2-8e20-52cf40584b38@gmx.com>
Message-ID: <b669450cfb7690e99cc4d9c63daa0680@olstad.com>
X-Sender: btrfs+list@olstad.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 12.04.2025 02:43, Qu Wenruo wrote:
> 在 2025/4/12 09:59, Kai Stian Olstad 写道:
>> On 12.04.2025 00:10, Qu Wenruo wrote:
>>> 在 2025/4/12 01:18, Kai Stian Olstad 写道:
>>>> Kubuntu 24.04
>>>> Kernel 6.8.0-57-generic
>>>> 
>>>> 2 day ago I got a sector error on one of the BTRFS disk
>>>> 
>>>> $ journalctl -k -S 2025-04-09 | grep -A 20 mpt3sas_cm0
>>>> Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000):
>>>> originator(PL), code(0x08), sub_code(0x0000)
>>>> Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000):
>>>> originator(PL), code(0x08), sub_code(0x0000)
>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 FAILED Result:
>>>> hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=6s
>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Sense Key :
>>>> Illegal Request [current]
>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Add. Sense:
>>>> Logical block address out of range
>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 CDB: Write(16)
>>>> 8a 08 00 00 00 00 00 00 10 80 00 00 00 08 00 00
>>>> Apr 09 03:16:26 cb kernel: critical target error, dev sdd, sector
>>>> 4224 op 0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0
>>> 
>>> This error is completely from the lower layer (the block device).
>>> 
>>> Btrfs nor the LUKS upon the disk can do anything to it.
>> 
>> Thank you for the response.
>> 
>> This disk support scterc
>> 
>> $ sudo smartctl -l scterc /dev/sdd
>> SCT Error Recovery Control:
>>             Read:     70 (7.0 seconds)
>>            Write:     70 (7.0 seconds)
>> 
>> Doesn't that mean that the disk gives up after 7 seconds, and then the
>> sector i mapped to a spare.
>> So if Btrfs does a write to the sector again it will be written to the
>> spare?
>> 
>> I've experienced numerous sector errors throughout the years with 
>> mdadm
>> and they have been fixed with a check.
>> Also a few with Btrfs I think, but they have been fixed automatically.
> 
> Whatever the feature is, it's block device driver's behavior.
> 
> Btrfs only errors out because the disk reported the write failed.
> 
> For the detailed reason you should check these lines:
> 
>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 FAILED Result:
> hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=6s
>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Sense Key :
> Illegal Request [current]
>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Add. Sense:
> Logical block address out of range

I'll check them but this is what I usually sees when a disk have a 
sector error.


>> So why not this time?
>> To me this looks like an ordinary faulty sector that can be "fixed" 
>> with
>> a write?
>> 
> I'm not sure what ever the "SCT Error recovery control" feature is, but
> if it is designed to re-map a write, it should not return -EIO for the
> initial write failure, but OK as long as eventually the write 
> succeeded.
> 
> It should not require any upper layer to do any extra work.
> 
> But since the write eventually failed, there is nothing upper layer can
> do, unless the dm or fs layer has some extra recovery mechanism.

Now I'm confused, I'm running RAID1 an only one disk has/had 1 sector 
failure.
Shouldn't Btrfs manage to to write this data, it should exist on one of 
the other drives because of RAID1?
And shouldn't a scrub fix it?

Since I don't get any other error from the block layer, the sector is 
either fixed/remapped or Btrfs doesn't try to fix the data in scrub?
If it had tried and the sector is still bad I should get sector error 
from the disk multiple time.
But this error is only in the logs that one time.

What is the purpose of Btrfs RAID1 if it doesn't try to fix this, by 
writing the data again from the good copy?

-- 
Kai Stian Olstad

