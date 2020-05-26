Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2C1E2FD9
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 May 2020 22:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391076AbgEZUTj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 May 2020 16:19:39 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:40935 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389537AbgEZUTi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 May 2020 16:19:38 -0400
Received: from venice.bhome ([94.37.169.164])
        by smtp-34.iol.local with ESMTPA
        id dg2xjVmPntrlwdg2xjDwxJ; Tue, 26 May 2020 22:19:35 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590524375; bh=8VttBaIgctq1P8fLHMolFDhUjETiW3Up2h/u5pUJo8I=;
        h=From;
        b=Y7zhhs1ha+BZdZsFPEMHhoDpKew5r7Q2pZM8mC6ItqETMF0N+abJV+XXub7iBiWjZ
         2+ZJDJSAGiaTC8DcmIHRdClI/SyY+8HuQ4wUuSqr5SX8qTBkX4CN24IjrSHAvJlZJS
         0F0t6lMRfgKcgu0an3f8FLCJFsOCKlT0XpzFSqDGEQjHBYPOid1lRKC/OXShu3l1QS
         wFJMUy6/8ZxhhP76ea5rBgO+pXYpGVYEnzZISxhSS/jKtBpwVb0hlMXbSBn24n42kR
         RRim/eAMMk3tK0EVzV4BxYY89ZYD+KTzfVJOCc6LkxB9GLV7ZsLz7gjTK0+2k0H1ZQ
         DKBNmvBMxV1ng==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=ZMZ8MMmEMFyyBR6AU47QNg==:117 a=ZMZ8MMmEMFyyBR6AU47QNg==:17
 a=IkcTkHD0fZMA:10 a=n75F_AFEsqV11BPemJEA:9 a=nDcDieP0-5LvN2hk:21
 a=rWRUrJYYkTKWHDiG:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH rfc v3] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20200319203913.3103-1-kreijack@libero.it>
 <20200319203913.3103-2-kreijack@libero.it>
 <20200525171430.GX18421@twin.jikos.cz>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <f1a34303-3b1a-dcda-8e67-458b3522e863@libero.it>
Date:   Tue, 26 May 2020 22:19:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525171430.GX18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJ/KCVaeoeE23QxsK7Rn8GttqlxZ4YsKiV5QMAWZVkuLz8totCfeYa4d1RfidQ80Vf3KvnzxjK84Y2NvH6MWkWl8IZklTOjRZf2VA30uARq3x8KsTJjr
 8pp+MT2Bp67KZtzJ3hJ5mZTi/zRbALlDYK+HhlpLVwGMTfyaEe1CPBy+lmgP2KhaZNJkZBIgXCmy3dRijjl+C0sImd1QviICnztEMiCupaSuav2ko+oGjWce
 zcLnx0uXRNhWCLqHmYLcpsgf8grVH9nMv1hy2BwteEQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/25/20 7:14 PM, David Sterba wrote:
> I'll start with the data structures
> 
> On Thu, Mar 19, 2020 at 09:39:13PM +0100, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>> +struct btrfs_chunk_info_stripe {
>> +	__u64 devid;
>> +	__u64 offset;
>> +	__u8 dev_uuid[BTRFS_UUID_SIZE];
>> +};
>> +
>> +struct btrfs_chunk_info {
>> +	/* logical start of this chunk */
>> +	__u64 offset;
>> +	/* size of this chunk in bytes */
>> +	__u64 length;
>> +
>> +	__u64 stripe_len;
>> +	__u64 type;
>> +
>> +	/* 2^16 stripes is quite a lot, a second limit is the size of a single
>> +	 * item in the btree
>> +	 */
>> +	__u16 num_stripes;
>> +
>> +	/* sub stripes only matter for raid10 */
>> +	__u16 sub_stripes;
>> +
>> +	struct btrfs_chunk_info_stripe stripes[1];
>> +	/* additional stripes go here */
>> +};
> 
> This looks like a copy of btrfs_chunk and stripe, only removing items
> not needed for the chunk information. Rather than copying the
> unnecessary fileds like dev_uuid in stripe, this should be designed for
> data exchange with the usecase in mind.

There are two clients for this api:
- btrfs fi us
- btrfs dev us

We can get rid of:
	- "offset" fields (2x)
	- "uuid" fields

However the "offset" fields can be used to understand where a logical map
is on the physical disks. I am thinking about a graphical tool to show this
mapping, which doesn't exits yet -).
The offset field may be used as key to get further information (like the chunk
usage, see below)

Regarding the UUID field, I agree it can be removed because it is redundant (there
is already the devid)


> 
> The format does not need follow the exact layout that kernel uses, ie.
> chunk info with one embedded stripe and then followed by variable length
> array of further stripes. This is convenient in one way but not in
> another one. Alternatively each chunk can be emitted as a single entry,
> duplicating part of the common fields and adding the stripe-specific
> ones. This is for consideration.
> 
> I've looked at my old code doing the chunk dump based on the search
> ioctl and found that it also allows to read the chunk usage, with one
> extra search to the block group item where the usage is stored. As this
> is can be slow, it should be optional. Ie. the main ioctl structure
> needs flags where this can be requested.

This info could be very useful. I think to something like a balance of
chunks which are near filled (or near empty). The question is if we
should have a different ioctl.
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
