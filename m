Return-Path: <linux-btrfs+bounces-8549-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305A2990075
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 12:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 547B3B25769
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA35614BF97;
	Fri,  4 Oct 2024 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="QECiQV/n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6613CF74
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036211; cv=none; b=StRoFdyjxDXMtf6+SI/1IdyuBCq2o8neuXcG3nHvmK1Bu2V7PBmi2sueMTLK2XZDiXSWMIpfCgGaAlVTSEZ2+C6UBvlWODYhAIP2a2sAk7AjNq+fGDyk5QqmaA5oq+HqNTevKTercH/GP9nsynvhzNwYmbA/ks5dN4XQutsLyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036211; c=relaxed/simple;
	bh=ztCHNXsZSiK1rpR2XJUKN2zQLa4ZLb3mzo+R8MzLUL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r4e3ahDJ5gGEInuKLh+yt5vuNGdkVeWmpTAUHDN+A+WjI79cZv3glqY8tSSxtRBnEhi/Dvpm6b/Z4XfamMImn8YXTFmb8JLgb46rVP1NvF7oDQiEr+xS9/bAg+98VAXoGn81/dYU2uhRRAP6xDWa4X+8M6gyeZJQmisRXIlVsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=QECiQV/n; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1728036189;
	bh=wWNLSMK2I2HSfBha8rAn086lZyjzC57tm7RJzvtgbLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=QECiQV/n43WxE6GyDAbsEeQPT4ZP4B3S8agOwGLuktcVY5FtyBCeGPdmntAlJyxaC
	 ru5pTGlm5bVQd8xjY2JKwsRutpxc8hKYsHV5wh15ybermNiohcj8GfgQZDhZwTa7Wc
	 98xEwpINESWh8r0irurMkjbmOaNs+0Zqhfr8CODo=
X-QQ-mid: bizesmtpip3t1728036187tgw0bfv
X-QQ-Originating-IP: gwiYSYou+kF0wEfcu84sOhY8qP5K0u8u51zjg/13rj0=
Received: from [IPV6:2408:8214:5910:1b0:1e39:e ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Oct 2024 18:03:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2917289487280688700
Message-ID: <CC3E2FAACB1C1BF4+5f15fbff-2363-4a49-a68f-de099e3fb31c@bupt.moe>
Date: Fri, 4 Oct 2024 18:03:05 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix comments in definition of struct
 btrfs_file_extent_item
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Mark Harmstone <maharmstone@fb.com>,
 linux-btrfs@vger.kernel.org
References: <20241002164500.2775775-1-maharmstone@fb.com>
 <d4445e83-c5a0-4add-b266-2d97bd590efc@gmx.com>
Content-Language: en-US
From: Yuwei Han <hrx@bupt.moe>
In-Reply-To: <d4445e83-c5a0-4add-b266-2d97bd590efc@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NN51gi9eLBwa6qTPdwdzh28K7hTAn1r/bHy4ZZJn9c5TOJBxSil9CpGZ
	GY57CF+6nfsYJntONPXUSvPl6IAaskFIxd/dG6CRE0ywtA9lGKrgGfyphCZqTohqUsoQznC
	HdTtE2GKQxnF81bgDvuoh4dkfjZ0ap8YrNmhJRp01SPXji46ZOXiuy/65+jPvhZzDbMABw9
	F76n1usEukj67BqC3+wxO8tFln3EDGT2I6U9J+xcVLlR7KgRgxTG157QGHDM6Fv+wNsYyzw
	+Bo3hufRGUP1+ic0KMHe1QPMAfETllbddx5ULIxx1IvDQGcl9/qOw0vIBcw2VigLoRnFV2h
	nUm8oKVyemG0ynWZEusv3X8nk37MjoQSOiIcUkUTrCyLyb6Y7HTiHCv5HXsX7d08ze63mlj
	APDSLhiksoSO1KiBah5/opcVAdGdAI/N6cNMMeA1avApa3kxjOO7PDi8E0/BR5D88F4Uo8j
	R1sz+h0uvSu9uQWEtJGli9Rwwe37Cf2IXqaXTZe9KJBFRv5UtryYDgE5kHzC8uJ6he1a+tC
	tc+VO7P6XXzGzw8q+UspPXRQd2ehG6emdvnVXSIxxCCRKerAab4TtKlZl4rAS1fH6AZYxP9
	CFtxY6AD9Wxb4bgB1GjE79ngM18ob1hBP7RWhDHpYdMhyMAmYi4HO27yPD4iZgReIBOwYbt
	/1vLnEieMc+wi6zmCZspolcHs5gCwrxWV96kojBmHbGhiXPwZeyXIf5cAH7bMsSZyhjuhWw
	BtwiqWkvegbsiQUE/cVlakOKIKDdNSQwHoSxYhlGuFVE1amChWBvu4N/7vZi2SwduKvFkPz
	bDHkhUiT3dkBzywTCg9jW3TFlcnXRL+RITgUdy9l9fLgkcJlkUk/dYzvhb/aW43+SFKJWKT
	gMWyQCyKVHvqfseYmM5Q2Hlu7WChsRwcw0STkXpiMpyZszQ3KgZm2g==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0



在 2024/10/3 05:21, Qu Wenruo 写道:
> 
> 
> 在 2024/10/3 02:14, Mark Harmstone 写道:
>> The comments in the definition of struct btrfs_file_extent_item were
>> written while the FS was still in flux, and are no longer accurate.
>>
>> The range [disk_bytenr, disk_num_bytes) is the same as the extent in the
>> extent tree. There's no difference here between csummed and non-csummed
>> extents, as the comments were implying. And the fields offset and
>> num_bytes are in bytes, not file blocks.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>>   include/uapi/linux/btrfs_tree.h | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/ 
>> btrfs_tree.h
>> index fc29d273845d..5df54a11c74c 100644
>> --- a/include/uapi/linux/btrfs_tree.h
>> +++ b/include/uapi/linux/btrfs_tree.h
>> @@ -1094,24 +1094,23 @@ struct btrfs_file_extent_item {
>>       __u8 type;
>>
>>       /*
>> -     * disk space consumed by the extent, checksum blocks are included
>> -     * in these numbers
>> +     * The address and size of the referenced extent.  These should 
>> exactly
>> +     * match an entry in the extent tree.
> 
> Recently I'm also helping Han Yuwei to understand all the ondisk format.
> Maybe he can provide a better advice from a new respective.
> 
> And he is definitely not happy with the docs and comments on those
> structures.
>
I didn't read btrfs code in kernel tree, I just read Qu's 
adam900710/btrfs-fuse for reference, so correct me if I am wrong.
If this is EXTENT_DATA(0x6c) in docs, I think the descriptions in btrfs 
doc is almost ok.
>>        *
>>        * At this offset in the structure, the inline extent data start.
>>        */
>>       __le64 disk_bytenr;
>>       __le64 disk_num_bytes;
>>       /*
>> -     * the logical offset in file blocks (no csums)
>> -     * this extent record is for.  This allows a file extent to point
>> -     * into the middle of an existing extent on disk, sharing it
>> -     * between two snapshots (useful if some bytes in the middle of the
>> -     * extent have changed
>> +     * The logical offset in bytes this extent record is for.
>> +     * This allows a file extent to point into the middle of an existing
>> +     * extent on disk, sharing it between two snapshots (useful if some
>> +     * bytes in the middle of the extent have changed)
> 
> Maybe you want to add the offset is for the uncompressed data.
> 
> Another thing is, maybe we want to have a more consistent wording.
> 
> The word "extent record" may be a little confusing, I guess you mean
> "file extent".
> Since the structure is called "btrfs_file_extent_item", we may want to
> unify to "file extent" when referring to the file extent, and "data
> extent" to refer to the data extent.
> 
> Thanks,
> Qu
>>        */
>>       __le64 offset;
>>       /*
>> -     * the logical number of file blocks (no csums included).  This
>> -     * always reflects the size uncompressed and without encoding.
>> +     * The logical number of bytes.  This always reflects the size
>> +     * uncompressed and without encoding.
>>        */
>>       __le64 num_bytes;
>>
My description on these field would be this,
disk_bytenr & disk_num_bytes:
logical address and size of extent on disk. Should exactly match an 
EXTENT_ITEM.
offset & num_bytes:
offset and size of file content within the extent after decoding and 
decompressing. (removed "logical" since we don't need to do logical -> 
physical address translation)
And write an e.g as doc did.
> 
> 



