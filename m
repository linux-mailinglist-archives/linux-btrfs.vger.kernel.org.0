Return-Path: <linux-btrfs+bounces-20102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1EBCF46F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 16:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC15313A1B9
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ED228B40E;
	Mon,  5 Jan 2026 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcVlMpQh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666B20B22
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626813; cv=none; b=IeS07jkJYKVTq9SU372iSuiQemBrLH4mffSRvlXRP0Sb7A76OQ8NBKuGQaHOA9I47e4R483USm4Y63iC0YSkeZJgYjF+a+8RIvBZBQGMdAgUF2hfNBTMh4UM241LqM0z3RtNBVb1c2qKRrFJoS2apotMQdUjmyC3ksRwhpc2s2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626813; c=relaxed/simple;
	bh=WpGH5kiba0nK0mgu4aVzVcKlKhBsod+2O6pbxxs/81I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smyy7ZVBctdTtqwXueJvFf+ECqwgzsgviDECUTqL6hXB64AWooEeF3cfYEkNtWolAt9lmKY3U3vOwlJK6SgZ4nMIAfkIQsxR3JcsUhkBu/LoW4avv7mRTFy3CDC/GBxqt4Gf8pcGzmY2oA6yEAyUwsPUym0e2oGFb+MxcfBV2y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcVlMpQh; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-802e9abb429so9050b3a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jan 2026 07:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767626811; x=1768231611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jdSXuZtLy67fI5Up8sDw8f5DiDoBSccfwOgmW71mIo=;
        b=KcVlMpQhneGYkI3kfB+aHKky4lNeewLqIlz9RU6r6JR1tC47yQAA514aY+gEBJpwvT
         BYg602j4zhJceD9viPZG9q+DsvBtOd4P/o2YHRE1ysasUMt3aVkQvr1qj5WisiHhr0Rh
         PG1byz8FnzJEaItx08MirG1Z2SrjsN/AlvnKpWE11gUwmGGN3L6zZ1EVQXv4/rCqpqOB
         UAnZvx1hiiye552ArDTowGVEQ7mGwbp0DMig4JIqrVWDgIa20nH7Bkac+weqpKhymHSL
         2QyXswVPWqAe5eGB2NauS2MkiCDSlfttzh8gkwMuJ5TBNuVlup55y+3g7KMnuJhJMpSS
         aJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767626811; x=1768231611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jdSXuZtLy67fI5Up8sDw8f5DiDoBSccfwOgmW71mIo=;
        b=dnfDgYMQp/UN22nzGggL+K6ImK8+jlI1km8COZkwLzTRdfT1GxmuIf/4lslzXGaJow
         AYZ4dxOs9L80XrwSyii5e4iBfNnW5SMtUmf5Mo13Q9/nDg0t5eVFvzdBavcXvKqmPzUh
         Y2aKktIpSEzQlemK3HOaUJJnVksTO0DiUxFlg0yd+8bs36UB6EQf7MP/xH7RbZBib8PH
         omWnxuA0bdg7omVXFWA08UWDXjVLnKBoJkBsDtJwUhXJwKDTMNAo2yKLy2qiJpH9YslR
         PwApdbxxn01efGAd4sckyzM44zNZ4g99JY2RpF5VdBXVZ3mPrO5cLiFq+lRsio3E94Ik
         MOwA==
X-Gm-Message-State: AOJu0YzgoDSYI+HgdoXjIZG2wXV9skMCDDD3E6ETJseeyr5C6wpfH0N6
	5D4C02oSzCH4c01aptpIb2A/BmhcYgDf6oIc7/ilFt5NcCWK8hHKn60QH66KGU37lW6Sow==
X-Gm-Gg: AY/fxX6isM8sPhMJiypl149UrYfXCcOXfZN9GAdr9+ZGVMRo5peRjMBZA2zMaeLT1Q1
	poxXhaT2C4P1OOsrf78StVdnD1TmQ/HepgmmAi+WtFIhA7gJB6LCoY+DRpOcarn/QgNK21CatUZ
	0AtwA5qENcFMw6TSiqrG1wG6EkxEo8h4r+FTieiJzdPQyJ9vMVV4BB7yrIBwROwOJPzytyUI54+
	YEH7dJOvBYFsZrcWwTDJpcs7EhqQd6kxg6PytiR/kGLLss6bfmW1VVqQXEIG6xBm3Kf8XsTFsd3
	IEB8Vhog1L2tS/KsDFSwBDNgae19Aa0qEPLa+ZaEIdR94r16j8Q89xFChMJv64yzF7bDU8AOFDd
	lr+Utm/3Xz5p+vKG/eSdL5bA6OtacN1wnUmvxXi5zPDv+DzI+eHP4G/xPGA7n0YxYT+2OJJIHna
	Xl4Egc9eaHrJKwt2lkrkd1pabs
X-Google-Smtp-Source: AGHT+IG/gLUSzLXsbnFDML1oO/AmGLPNeUx0CrtPb0gayj0AV1jQ5gIEjdnTBPIDNc5aprO9u4nI1g==
X-Received: by 2002:a05:6a20:9f07:b0:341:f2ca:bd73 with SMTP id adf61e73a8af0-376a4e6645dmr33365841637.0.1767626811121;
        Mon, 05 Jan 2026 07:26:51 -0800 (PST)
Received: from [192.168.1.13] ([45.144.167.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-818775e464dsm143390b3a.22.2026.01.05.07.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 07:26:50 -0800 (PST)
Message-ID: <4b2a2735-2af2-419d-9cde-758538cfe6aa@gmail.com>
Date: Mon, 5 Jan 2026 23:26:46 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] btrfs: reorder btrfs_block_group members to reduce
 struct size
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <20260103122504.10924-2-sunk67188@gmail.com>
 <20260103122504.10924-7-sunk67188@gmail.com>
 <CAL3q7H5C78nTgQucPdFi1bLTPA9Z0QmBjgFMT4HXH6z7OSnE3g@mail.gmail.com>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <CAL3q7H5C78nTgQucPdFi1bLTPA9Z0QmBjgFMT4HXH6z7OSnE3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/1/5 23:07, Filipe Manana 写道:
> On Sat, Jan 3, 2026 at 1:06 PM Sun YangKai <sunk67188@gmail.com> wrote:
>>
>> Reorder struct btrfs_block_group fields to improve packing and reduce
>> memory footprint from 624 to 600 bytes (24 bytes saved per instance).
> 
> The memory footprint is not reduced.
> 
> The structure's size is reduced, yes, but we are allocating block
> groups using kzalloc, so we end up still using the kmalloc-1k slab.
> Unless we could reduce the structure's size to 512 bytes, and
> therefore use the kmalloc-512 slab, we are not saving any memory.

Thank you for your review opinions.

Currently we have a size at ~600 bytes either with or without this patch and I'm
wondering if we can use kmem_cache for btrfs_block_group. I'm not sure but it
should also make it easier to trace the allocation.

> The number of cache lines also remains the same, so no improvements there.
> Changing the order of the fields could also have an impact in the
> caching (either for the best or the worst), but I don't think it will
> be significantly visible for any realistic workload.

I didn't take this into consideration because the fields of btrfs_block_group
seems not optimized for caching but thanks a lot for telling me this :)

Thanks.

> Thanks.
> 
> 
>>
>> Here's pahole output after this change:
>>
>> struct btrfs_block_group {
>>         struct btrfs_fs_info *     fs_info;              /*     0     8 */
>>         struct btrfs_inode *       inode;                /*     8     8 */
>>         u64                        start;                /*    16     8 */
>>         u64                        length;               /*    24     8 */
>>         u64                        pinned;               /*    32     8 */
>>         u64                        reserved;             /*    40     8 */
>>         u64                        used;                 /*    48     8 */
>>         u64                        delalloc_bytes;       /*    56     8 */
>>         /* --- cacheline 1 boundary (64 bytes) --- */
>>         u64                        bytes_super;          /*    64     8 */
>>         u64                        flags;                /*    72     8 */
>>         u64                        cache_generation;     /*    80     8 */
>>         u64                        global_root_id;       /*    88     8 */
>>         u64                        commit_used;          /*    96     8 */
>>         u32                        bitmap_high_thresh;   /*   104     4 */
>>         u32                        bitmap_low_thresh;    /*   108     4 */
>>         struct rw_semaphore        data_rwsem;           /*   112    40 */
>>         /* --- cacheline 2 boundary (128 bytes) was 24 bytes ago --- */
>>         unsigned long              full_stripe_len;      /*   152     8 */
>>         unsigned long              runtime_flags;        /*   160     8 */
>>         spinlock_t                 lock;                 /*   168     4 */
>>         unsigned int               ro;                   /*   172     4 */
>>         enum btrfs_disk_cache_state disk_cache_state;    /*   176     4 */
>>         enum btrfs_caching_type    cached;               /*   180     4 */
>>         struct btrfs_caching_control * caching_ctl;      /*   184     8 */
>>         /* --- cacheline 3 boundary (192 bytes) --- */
>>         struct btrfs_space_info *  space_info;           /*   192     8 */
>>         struct btrfs_free_space_ctl * free_space_ctl;    /*   200     8 */
>>         struct rb_node             cache_node;           /*   208    24 */
>>         struct list_head           list;                 /*   232    16 */
>>         struct list_head           cluster_list;         /*   248    16 */
>>         /* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
>>         struct list_head           bg_list;              /*   264    16 */
>>         struct list_head           ro_list;              /*   280    16 */
>>         refcount_t                 refs;                 /*   296     4 */
>>         atomic_t                   frozen;               /*   300     4 */
>>         struct list_head           discard_list;         /*   304    16 */
>>         /* --- cacheline 5 boundary (320 bytes) --- */
>>         enum btrfs_discard_state   discard_state;        /*   320     4 */
>>         int                        discard_index;        /*   324     4 */
>>         u64                        discard_eligible_time; /*   328     8 */
>>         u64                        discard_cursor;       /*   336     8 */
>>         struct list_head           dirty_list;           /*   344    16 */
>>         struct list_head           io_list;              /*   360    16 */
>>         struct btrfs_io_ctl        io_ctl;               /*   376    72 */
>>         /* --- cacheline 7 boundary (448 bytes) --- */
>>         atomic_t                   reservations;         /*   448     4 */
>>         atomic_t                   nocow_writers;        /*   452     4 */
>>         struct mutex               free_space_lock;      /*   456    32 */
>>         bool                       using_free_space_bitmaps; /*   488     1 */
>>         bool                       using_free_space_bitmaps_cached; /*   489     1 */
>>         bool                       reclaim_mark;         /*   490     1 */
>>
>>         /* XXX 1 byte hole, try to pack */
>>
>>         int                        swap_extents;         /*   492     4 */
>>         u64                        alloc_offset;         /*   496     8 */
>>         u64                        zone_unusable;        /*   504     8 */
>>         /* --- cacheline 8 boundary (512 bytes) --- */
>>         u64                        zone_capacity;        /*   512     8 */
>>         u64                        meta_write_pointer;   /*   520     8 */
>>         struct btrfs_chunk_map *   physical_map;         /*   528     8 */
>>         struct list_head           active_bg_list;       /*   536    16 */
>>         struct work_struct         zone_finish_work;     /*   552    32 */
>>         /* --- cacheline 9 boundary (576 bytes) was 8 bytes ago --- */
>>         struct extent_buffer *     last_eb;              /*   584     8 */
>>         enum btrfs_block_group_size_class size_class;    /*   592     4 */
>>
>>         /* size: 600, cachelines: 10, members: 56 */
>>         /* sum members: 595, holes: 1, sum holes: 1 */
>>         /* padding: 4 */
>>         /* last cacheline: 24 bytes */
>> };
>>
>> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
>> ---
>>  fs/btrfs/block-group.h | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
>> index 3b3c61b3af2c..88c2e3a0a5a0 100644
>> --- a/fs/btrfs/block-group.h
>> +++ b/fs/btrfs/block-group.h
>> @@ -118,7 +118,6 @@ struct btrfs_caching_control {
>>  struct btrfs_block_group {
>>         struct btrfs_fs_info *fs_info;
>>         struct btrfs_inode *inode;
>> -       spinlock_t lock;
>>         u64 start;
>>         u64 length;
>>         u64 pinned;
>> @@ -159,6 +158,8 @@ struct btrfs_block_group {
>>         unsigned long full_stripe_len;
>>         unsigned long runtime_flags;
>>
>> +       spinlock_t lock;
>> +
>>         unsigned int ro;
>>
>>         int disk_cache_state;
>> @@ -178,8 +179,6 @@ struct btrfs_block_group {
>>         /* For block groups in the same raid type */
>>         struct list_head list;
>>
>> -       refcount_t refs;
>> -
>>         /*
>>          * List of struct btrfs_free_clusters for this block group.
>>          * Today it will only have one thing on it, but that may change
>> @@ -199,6 +198,8 @@ struct btrfs_block_group {
>>         /* For read-only block groups */
>>         struct list_head ro_list;
>>
>> +       refcount_t refs;
>> +
>>         /*
>>          * When non-zero it means the block group's logical address and its
>>          * device extents can not be reused for future block group allocations
>> @@ -211,10 +212,10 @@ struct btrfs_block_group {
>>
>>         /* For discard operations */
>>         struct list_head discard_list;
>> +       enum btrfs_discard_state discard_state;
>>         int discard_index;
>>         u64 discard_eligible_time;
>>         u64 discard_cursor;
>> -       enum btrfs_discard_state discard_state;
>>
>>         /* For dirty block groups */
>>         struct list_head dirty_list;
>> --
>> 2.51.2
>>
>>


