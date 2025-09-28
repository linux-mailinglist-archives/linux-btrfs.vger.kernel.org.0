Return-Path: <linux-btrfs+bounces-17230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01270BA6642
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 04:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C832E3A786C
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 02:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D76D24467E;
	Sun, 28 Sep 2025 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qst8xH+F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3616DEB1
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Sep 2025 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759025723; cv=none; b=dZEaMwqPQlVONdVqirufzxiFP2dMvPplTIylEN8/6LHefeD+4frGmI/HZpefYj2pY/MJ9/N7C9XQqD0msxB4LdOZyfWqk6/JnM2pttdzPaEiLuA0BX39DCNI2e7Bj/AWTZDxDtLwGzfGjrRI0u9MPLnCS53VeaO0q5pFK0x+TUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759025723; c=relaxed/simple;
	bh=8yYtLnIxQGxoyWrusR+VVn8uKayY4/ZByOWTdcI1Seg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDpQvMKkuOcXldG5KYRJxZg54TJ2bJWWGKz6ohnDK+aa2Iy2/GNMjV2eggeOitVnhXU6jbIcnWjqeT3d89iwWrZ1dgj2dqS16KUsmBP6Nr68UlekUjfsR3jrUVoBmIOYcpbmWY0U2eKBLIe732zXt6GWTFcUrD/0xzIKOMa37WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qst8xH+F; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bda4b547-4dea-4c05-8679-1cf021bbe340@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759025718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8QPEqanYvGseHMXBit3z9fL9W36Ukzni1BsxcDGJHk=;
	b=Qst8xH+FLpIjym6iJDgo4g/zbMYMXXqFbnHQQyHyx/oiq6pKnPIPcbyphysLR51R6BMkLt
	ss4Xf2FoKeRlMXA9pk+g9L1gZsJJ4g4TM1arn/AI/a9nEvY5hiN59ZbUk8B/EvIJqR61Nq
	gNp+ks2gINSwLlStfhQzUpLzdl4e/RI=
Date: Sun, 28 Sep 2025 10:14:29 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: Add the nlink annotation in btrfs_inode_item
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250926074543.585249-1-youling.tang@linux.dev>
 <adda6065-26a2-4d31-b4f0-ccb20e0fadeb@gmx.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <adda6065-26a2-4d31-b4f0-ccb20e0fadeb@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Wenruo

On 9/26/25 16:34, Qu Wenruo wrote:
>
>
> 在 2025/9/26 17:15, Youling Tang 写道:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> When I created a directory, I found that its hard link count was
>> 1 (unlike other file system phenomena, including the "." directory,
>> which defaults to an initial count of 2).
>>
>> By analyzing the code, it is found that the nlink of the directory
>> in btrfs has always been kept at 1, which is a deliberate design.
>>
>> Adding its comments can prevent it from being mistakenly regarded
>> as a BUG.
>>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>> ---
>>   include/uapi/linux/btrfs_tree.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/linux/btrfs_tree.h 
>> b/include/uapi/linux/btrfs_tree.h
>> index fc29d273845d..b4f7da90fd0e 100644
>> --- a/include/uapi/linux/btrfs_tree.h
>> +++ b/include/uapi/linux/btrfs_tree.h
>> @@ -876,6 +876,7 @@ struct btrfs_inode_item {
>>       __le64 size;
>>       __le64 nbytes;
>>       __le64 block_group;
>> +    /* nlink in directories is fixed at 1 */
>
> nlink of what?
>
> Shouldn't be "nlink of directories" or "nlink of directory inodes"?
>
>
> There are better location like 
> btrfs-progs/Documentation/dev/On-disk-format.rst for this.
>
> And you're only adding one single comment for a single member?
> Even this is a different behavior compared to other fses, why not 
> explain what the impact of the change?
>
>
> If you really want to add proper comments, spend more time and effort 
> like commit 9c6b1c4de1c6 ("btrfs: document device locking") to do it 
> correctly.

My understanding of nlink is as follows, please correct me if I'm wrong,

/*
  * nlink represents the hard link count (corresponds to inode->i_nlink 
value).
  * For directories, this value is always 1, which differs from other 
filesystems
  * where a newly created directory has an inode->i_nlink value of 2 
(including
  * the "." entry pointing to itself).
  *
  * BTRFS maintains parent-child relationships through explicit back 
references
  * (BTRFS_INODE_REF_KEY items) rather than link count accounting.
  *
  * This design simplifies metadata management in the copy-on-write 
environment
  * and enables more reliable consistency checking. Directory link count
  * verification is performed during tree checking in 
check_inode_item(), where
  * values greater than 1 are treated as corruption.
  *
  * For regular files, nlink behaves traditionally and represents the actual
  * hard link count of the file.
  */

Thanks,
Youling.
>
> Thanks,
> Qu
>
>>       __le32 nlink;
>>       __le32 uid;
>>       __le32 gid;
>

