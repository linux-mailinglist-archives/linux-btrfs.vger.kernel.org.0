Return-Path: <linux-btrfs+bounces-2952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA40F86D448
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 21:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7CC289E37
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 20:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848C144030;
	Thu, 29 Feb 2024 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b="ib1zD5ea";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="EEMhhKLM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from a4-1.smtp-out.eu-west-1.amazonses.com (a4-1.smtp-out.eu-west-1.amazonses.com [54.240.4.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4AA7BAEB
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238836; cv=none; b=Jhlg8lSZS0+hYRQV5bTsnhyL6eZ4YKC8feLuOkIoto4aA4WXc1/+1vYWpvVLlqV4q5KdDkkBm6a+mTBQQm2EFBIirjGMg8MUNWTJkZ44IyJY+DE36CVnrR2YlFA2eaPhWKi7dEs0N9WbGoT8qlxIGEwIKIyfmpVyvv0ZLurpPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238836; c=relaxed/simple;
	bh=eZkRqXT7PAJ/Wn9W9YeiN26ECIXAH8YQGCG0nIXoIpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bAVEuRzYoNRHfvskow4wXaAbTKCT9KBWqLox6tbMSU385fb0JgDwpCE/Gvckpq99fyO4WQCW3wJbQDTFr6Kr9GP3D7MhlKZ32XXVOpVlKcuYgSJ4NmXtzLQj2ZKhgo/3KXjXC7tUt+Fg0kbnV61QoANMMw6NdCBCrr8gMDAScf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org; spf=pass smtp.mailfrom=bounce.urbackup.org; dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b=ib1zD5ea; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=EEMhhKLM; arc=none smtp.client-ip=54.240.4.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.urbackup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=pqvuhxtqt36lwjpmqkszlz7wxaih4qwj; d=urbackup.org; t=1709238832;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=eZkRqXT7PAJ/Wn9W9YeiN26ECIXAH8YQGCG0nIXoIpI=;
	b=ib1zD5eaqPNhQRGMcQ0kg0yEsblQDck332fMf3YJo2S092futDeuT2XbDz22OTCO
	xEfIoiwlxPoUSfd27LKnhCeHixHdRmdt4EG1Pl2QK2Kz8lRL9uFBCCMG+phWU4YjOzP
	pVodOvOFfxKBzACtjO7O+EFCW4qYKr1TGrAZSHYg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1709238832;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=eZkRqXT7PAJ/Wn9W9YeiN26ECIXAH8YQGCG0nIXoIpI=;
	b=EEMhhKLMjynhfXNNIybWCYRn8QD3Ox3mxiQJq+w4cLzyT7zF3Ejtps3xCFELhNMp
	8iwzrnVDP09iLH4xhqK7kzEAqfOzuTv3WZIW7em5XykcMlMNRZgIO1KHwrTkgytqMds
	JacMhzUmSj5kFvGu4xsfSvLzzvHOgqmVOjc4xLVk=
Message-ID: <0102018df692cd2a-d4b9b332-cd3e-4cf1-b1e3-469381c2dd5f-000000@eu-west-1.amazonses.com>
Date: Thu, 29 Feb 2024 20:33:52 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zero sized file that should have 512KB size with 6.6
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102018df1b2a3a2-9359bfe7-9155-4af6-a0d1-7cee1faf77e4-000000@eu-west-1.amazonses.com>
 <103dacd5-d97c-42e2-8a13-39d1800a85bf@gmx.com>
From: Martin Raiber <martin@urbackup.org>
In-Reply-To: <103dacd5-d97c-42e2-8a13-39d1800a85bf@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2024.02.29-54.240.4.1

On 29.02.2024 04:02 Qu Wenruo wrote:
>
>
> 在 2024/2/29 08:20, Martin Raiber 写道:
>> Hi,
>>
>> when upgrading to kernel 6.6 I have a zero sized file after a few days
>> of running. I'm pretty sure the app has written 512KB into this file
>> (using normal write()). Yet stat etc. return zero. But fiemap has some
>> extents!
>
> Have you found a reliable way to reproduce such files manually?
> Or that application is required to create such files?

Thanks. No, I'll try to think of a way to make this more reproducable. I 
think as a next step I'll disable compression.

One unusal thing might be that shortly after creating the file with a 
few pwrite() calls it writes into the file using io_uring splice. But 
idk from logs if it then had size zero afterwards or if that came later.

>
> If you have a reproducer that would be a perfect case for us to fix (and
> add a test case for it).
>
>>
>> The machine is not power cycled or restarted between the writing and the
>> zero size issue.
>>
>> Kernel 6.6.17 mounted with
>> rw,noatime,compress=lzo,ssd,discard=async,nospace_cache,skip_balance,metadata_ratio=8,subvolid=5,subvol=/ 
>>
>> Running with ECC RAM (but data=single on one device).
>>
>> $ filefrag -v ./73c0138c00
>> Filesystem type is: 9123683e
>> File size of ./73c0138c00 is 0 (0 blocks of 4096 bytes)
>>   ext:     logical_offset:        physical_offset: length: expected: 
>> flags:
>>     0:       32..      63:  229943374.. 229943405:     32: 32: 
>> encoded,eof
>>     1:       64..      95:  231710261.. 231710292:     32: 229943406:
>> encoded,eof
>>     2:       96..     127:  231741406.. 231741437:     32: 231710293:
>> last,encoded,eof
>> ./73c0138c00: 3 extents found
>>
>> $ stat ./73c0138c00
>>    File: ./73c0138c00
>>    Size: 0               Blocks: 768        IO Block: 4096 regular empty
>> file
>> Device: 34h/52d Inode: 424931256   Links: 1
>> Access: (0750/-rwxr-x---)  Uid: (    0/    root)   Gid: (    0/ root)
>> Access: 2024-02-28 10:52:08.421899782 +0100
>> Modify: 2024-02-28 10:52:10.809908158 +0100
>> Change: 2024-02-28 10:52:10.809908158 +0100
>>   Birth: 2024-02-28 10:52:08.421899782 +0100
>
> Could you please dump the contents of the inode?
>
> # btrfs ins dump-tree -t 5 <device> | grep -A7 'item .* key (424931256 '

$ btrfs ins dump-tree -t 6945 /dev/mapper/dev| grep -A7 'item .* key 
(424931256'
         item 114 key (424931256 INODE_ITEM 0) itemoff 9161 itemsize 160
                 generation 2775889 transid 2775890 size 0 nbytes 393216
                 block group 0 mode 100750 links 1 uid 0 gid 0 rdev 0
                 sequence 36 flags 0x800(COMPRESS)
                 atime 1709113928.421899782 (2024-02-28 10:52:08)
                 ctime 1709113930.809908158 (2024-02-28 10:52:10)
                 mtime 1709113930.809908158 (2024-02-28 10:52:10)
                 otime 1709113928.421899782 (2024-02-28 10:52:08)
         item 115 key (424931256 INODE_REF 480) itemoff 9141 itemsize 20
                 index 1597091 namelen 10 name: 73c0138c00
         item 116 key (424931256 XATTR_ITEM 550297449) itemoff 9091 
itemsize 50
                 location key (0 UNKNOWN.0 0) type XATTR
                 transid 2775889 data_len 3 name_len 17
                 name: btrfs.compression
                 data lzo
         item 117 key (424931256 EXTENT_DATA 131072) itemoff 9038 
itemsize 53
                 generation 2775890 type 1 (regular)
                 extent data disk byte 941848059904 nr 73728
                 extent data offset 0 nr 131072 ram 131072
                 extent compression 2 (lzo)
         item 118 key (424931256 EXTENT_DATA 262144) itemoff 8985 
itemsize 53
                 generation 2775890 type 1 (regular)
                 extent data disk byte 949085229056 nr 81920
                 extent data offset 0 nr 131072 ram 131072
                 extent compression 2 (lzo)
         item 119 key (424931256 EXTENT_DATA 393216) itemoff 8932 
itemsize 53
                 generation 2775890 type 1 (regular)
                 extent data disk byte 949212798976 nr 65536
                 extent data offset 0 nr 131072 ram 131072
                 extent compression 2 (lzo)
         item 120 key (424931257 INODE_ITEM 0) itemoff 8772 itemsize 160
                 generation 2775889 transid 2775890 size 524288 nbytes 
524288
                 block group 0 mode 100750 links 1 uid 0 gid 0 rdev 0

>
> Thanks,
> Qu
>>
>> * Nothing in dmesg
>> * Btrfs scrub has no errors
>> * Rebooting does not fix size
>> * Btrfs check has no errors
>>
>> Let me know if there is anything else I can provide. Will leave this
>> as-is till the end of this week.
>>
>> Regards,
>> Martin Raiber
>>
>>


