Return-Path: <linux-btrfs+bounces-3910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD618984ED
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 12:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13FA1F258C0
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 10:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A818E76044;
	Thu,  4 Apr 2024 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GLfmANDK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B2C59B7F
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226186; cv=none; b=FoozxMjfLoNonD9+Qt+XnjpzsYKTsgRka/5kWOg8XCnmsiIR2iBg4Fc3QjgsUlNf715adKUkGoYlH7PTuqBajEN3cv21k/dGqS8XBWh+SbvkDyirTwWOA9/pCqJ5Ue2nkpAdyijoMbslXFbzmQjbJPWY9b5oauU17MDfgdILnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226186; c=relaxed/simple;
	bh=R4h9sjotaytWSGngoPvUTHnT7lHylMgjpdmfHaQolfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gnc5xLltlMcmbBOg0slueFwZv8kW0Ku9fTcHevwWw6a6eTFYKNvkVX/YqJ98jwH5iiK1NEDnpcqgDSlFVMSOS0can1W2dV01WYCbRbFv56QzDZbru44TDK6eep3zH4TGueba9q7d6rSnyvwvmgWSfWTGVBs/KOyaMBf+KGSQWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GLfmANDK; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso9146381fa.3
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Apr 2024 03:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712226182; x=1712830982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dGBltXGpmNQSVgrktlzuMz6D1dm0Lbh8dO9r7WpB0JY=;
        b=GLfmANDK0mT565ogukhA8EgDeZVHjEqoVstFB6QkJmPoqYUDAvMM33HtAK68yg6ad7
         lzvlOga8tcGn+E2JT3mgdXYJ1+kvYxerIv76R5DhEw0G0apbM8z4k6Bh9TRcWirRR70H
         hBthw438HTHWULmECqMA3JWa5tFJ/UQI2TJMWgFSQam3fmsfasa+ELBNymboPrI84xYy
         wASHEK7DGWx5toINXoZQaHSHQI53B+0hNwLkyI+yIdCA9OjChwNd9djwlbRv+49hr/cV
         uC/UHIvMOm5p9L6zdmo0Ypx7+Slou0Xh1vhK0qAZLj4JtjgoczAVaiQwvWRKSqd1o4Gy
         Pqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712226182; x=1712830982;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGBltXGpmNQSVgrktlzuMz6D1dm0Lbh8dO9r7WpB0JY=;
        b=Wp1qED9vaelJ7Dhb3T72D8zTQ0WBZcY961OZHm9hl4mxdN1YrDa3DTaYwJZZiyGLuV
         b+VKBD+A9/ID+Jpxvft10v9OPPnSgA1M7tGMg0xwIq7C72kiN2uVOAxZ17/IxsTVzEbZ
         eoYFZpHx2xWdT7NuT6WakDsXjE1PCc0VEsF7fwjE42XwK/fQ6xl7nqqcTIY7bJRiZwV1
         m1XEMZgHwGY9KbGGe0wZFyR896FaP38cavJzMdExCOoIt5II6w/oa7HCUBfftC8FYGaX
         ZDYbHIe20RGoh3j4TbhjCzXnqWbD5huP2aj/vPIny8eTjc3tqF8OVAeQOUoVTvWT4KpD
         bXZw==
X-Gm-Message-State: AOJu0YyGdE5zykA6lY5nautzsK/1rLuMSiNCsYz66uWIm48phODZ4amS
	Aww3QKZurMnAgAUe356RzBO4xNVnaiLg8rYOQduqDmwgeGW5tB6CghBZx+JrbIBx6flWGsbHVfj
	x
X-Google-Smtp-Source: AGHT+IFWuBwl13v467im1WMw3BykiO4hdg8kBJVspRhoeAdVf4ZHI0H9hHjbt1LFpVRqcNd1NeXSpw==
X-Received: by 2002:a2e:864c:0:b0:2d6:8cba:c90b with SMTP id i12-20020a2e864c000000b002d68cbac90bmr1575246ljj.52.1712226182522;
        Thu, 04 Apr 2024 03:23:02 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id ju10-20020a170903428a00b001e2bdd8e071sm167329plb.75.2024.04.04.03.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 03:23:01 -0700 (PDT)
Message-ID: <6c326f9c-2a6f-475a-8329-2d6840be1ba6@suse.com>
Date: Thu, 4 Apr 2024 20:52:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] btrfs: remove not needed mod_start and mod_len
 from struct extent_map
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
 David Sterba <dsterba@suse.com>
References: <cover.1712187452.git.wqu@suse.com>
 <03bec7e0f57c902714e2c947fc6720d92c43e995.1712187452.git.wqu@suse.com>
 <CAL3q7H6Do32YN-VV_JQG59vuJL-U-kkYvqLBi86MbYwJr1=iDA@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <CAL3q7H6Do32YN-VV_JQG59vuJL-U-kkYvqLBi86MbYwJr1=iDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/4 20:28, Filipe Manana 写道:
> On Thu, Apr 4, 2024 at 12:46 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> The mod_start and mod_len fields of struct extent_map were introduced by
>> commit 4e2f84e63dc1 ("Btrfs: improve fsync by filtering extents that we
>> want") in order to avoid too low performance when fsyncing a file that
>> keeps getting extent maps merge, because it resulted in each fsync logging
>> again csum ranges that were already merged before.
>>
>> We don't need this anymore as extent maps in the list of modified extents
>> are never merged with other extent maps and once we log an extent map we
>> remove it from the list of modified extent maps, so it's never logged
>> twice.
>>
>> So remove the mod_start and mod_len fields from struct extent_map and use
>> instead the start and len fields when logging checksums in the fast fsync
>> path. This also makes EXTENT_FLAG_FILLING unused so remove it as well.
>>
>> Running the reproducer from the commit mentioned before, with a larger
>> number of extents and against a null block device, so that IO is fast
>> and we can better see any impact from searching checksums items and
>> logging them, gave the following results from dd:
>>
>> Before this change:
>>
>>     409600000 bytes (410 MB, 391 MiB) copied, 22.948 s, 17.8 MB/s
>>
>> After this change:
>>
>>     409600000 bytes (410 MB, 391 MiB) copied, 22.9997 s, 17.8 MB/s
>>
>> So no changes in throughput.
>> The test was done in a release kernel (non-debug, Debian's default kernel
>> config) and its steps are the following:
>>
>>     $ mkfs.btrfs -f /dev/nullb0
>>     $ mount /dev/sdb /mnt
>>     $ dd if=/dev/zero of=/mnt/foobar bs=4k count=100000 oflag=sync
>>     $ umount /mnt
>>
>> This also reduces the size of struct extent_map from 128 bytes down to 112
>> bytes, so now we can have 36 extents maps per 4K page instead of 32.
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
> 
> Why are you resending this?
> This was already in the for-next branch.
> 
> And given the SOB tag from David, your local for-next branch was up to date.

Sorry, I still didn't really get how the whole btrfs/for-next branch 
should work.

Should all our patches based on the latest for-next? Since every member 
has write permission to the branch, and the branch can change in a daily 
base, rebasing it daily doesn't look solid to me.

And I still do not know what's the requirement to push a patch into 
misc-next.
Like just after fstests runs? Reviewed-by tag? or both or something more?

Thanks,
Qu
> 
>> ---
>>   fs/btrfs/extent_map.c        | 18 ------------------
>>   fs/btrfs/extent_map.h        |  4 ----
>>   fs/btrfs/inode.c             |  4 +---
>>   fs/btrfs/tree-log.c          |  4 ++--
>>   include/trace/events/btrfs.h |  3 +--
>>   5 files changed, 4 insertions(+), 29 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
>> index 445f7716f1e2..471654cb65b0 100644
>> --- a/fs/btrfs/extent_map.c
>> +++ b/fs/btrfs/extent_map.c
>> @@ -252,8 +252,6 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
>>                          em->len += merge->len;
>>                          em->block_len += merge->block_len;
>>                          em->block_start = merge->block_start;
>> -                       em->mod_len = (em->mod_len + em->mod_start) - merge->mod_start;
>> -                       em->mod_start = merge->mod_start;
>>                          em->generation = max(em->generation, merge->generation);
>>                          em->flags |= EXTENT_FLAG_MERGED;
>>
>> @@ -271,7 +269,6 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
>>                  em->block_len += merge->block_len;
>>                  rb_erase_cached(&merge->rb_node, &tree->map);
>>                  RB_CLEAR_NODE(&merge->rb_node);
>> -               em->mod_len = (merge->mod_start + merge->mod_len) - em->mod_start;
>>                  em->generation = max(em->generation, merge->generation);
>>                  em->flags |= EXTENT_FLAG_MERGED;
>>                  free_extent_map(merge);
>> @@ -300,7 +297,6 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
>>          struct extent_map_tree *tree = &inode->extent_tree;
>>          int ret = 0;
>>          struct extent_map *em;
>> -       bool prealloc = false;
>>
>>          write_lock(&tree->lock);
>>          em = lookup_extent_mapping(tree, start, len);
>> @@ -325,21 +321,9 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
>>
>>          em->generation = gen;
>>          em->flags &= ~EXTENT_FLAG_PINNED;
>> -       em->mod_start = em->start;
>> -       em->mod_len = em->len;
>> -
>> -       if (em->flags & EXTENT_FLAG_FILLING) {
>> -               prealloc = true;
>> -               em->flags &= ~EXTENT_FLAG_FILLING;
>> -       }
>>
>>          try_merge_map(tree, em);
>>
>> -       if (prealloc) {
>> -               em->mod_start = em->start;
>> -               em->mod_len = em->len;
>> -       }
>> -
>>   out:
>>          write_unlock(&tree->lock);
>>          free_extent_map(em);
>> @@ -361,8 +345,6 @@ static inline void setup_extent_mapping(struct extent_map_tree *tree,
>>                                          int modified)
>>   {
>>          refcount_inc(&em->refs);
>> -       em->mod_start = em->start;
>> -       em->mod_len = em->len;
>>
>>          ASSERT(list_empty(&em->list));
>>
>> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
>> index c5a098c99cc6..10e9491865c9 100644
>> --- a/fs/btrfs/extent_map.h
>> +++ b/fs/btrfs/extent_map.h
>> @@ -30,8 +30,6 @@ enum {
>>          ENUM_BIT(EXTENT_FLAG_PREALLOC),
>>          /* Logging this extent */
>>          ENUM_BIT(EXTENT_FLAG_LOGGING),
>> -       /* Filling in a preallocated extent */
>> -       ENUM_BIT(EXTENT_FLAG_FILLING),
>>          /* This em is merged from two or more physically adjacent ems */
>>          ENUM_BIT(EXTENT_FLAG_MERGED),
>>   };
>> @@ -46,8 +44,6 @@ struct extent_map {
>>          /* all of these are in bytes */
>>          u64 start;
>>          u64 len;
>> -       u64 mod_start;
>> -       u64 mod_len;
>>          u64 orig_start;
>>          u64 orig_block_len;
>>          u64 ram_bytes;
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 3442dedff53d..c6f2b5d1dee1 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -7338,9 +7338,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
>>          em->ram_bytes = ram_bytes;
>>          em->generation = -1;
>>          em->flags |= EXTENT_FLAG_PINNED;
>> -       if (type == BTRFS_ORDERED_PREALLOC)
>> -               em->flags |= EXTENT_FLAG_FILLING;
>> -       else if (type == BTRFS_ORDERED_COMPRESSED)
>> +       if (type == BTRFS_ORDERED_COMPRESSED)
>>                  extent_map_set_compression(em, compress_type);
>>
>>          ret = btrfs_replace_extent_map_range(inode, em, true);
>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
>> index 472918a5bc73..d9777649e170 100644
>> --- a/fs/btrfs/tree-log.c
>> +++ b/fs/btrfs/tree-log.c
>> @@ -4574,8 +4574,8 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
>>          struct btrfs_root *csum_root;
>>          u64 csum_offset;
>>          u64 csum_len;
>> -       u64 mod_start = em->mod_start;
>> -       u64 mod_len = em->mod_len;
>> +       u64 mod_start = em->start;
>> +       u64 mod_len = em->len;
>>          LIST_HEAD(ordered_sums);
>>          int ret = 0;
>>
>> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
>> index 90b0222390e5..766cfd48386c 100644
>> --- a/include/trace/events/btrfs.h
>> +++ b/include/trace/events/btrfs.h
>> @@ -277,8 +277,7 @@ DEFINE_EVENT(btrfs__inode, btrfs_inode_evict,
>>                  { EXTENT_FLAG_COMPRESS_LZO,     "COMPRESS_LZO"  },\
>>                  { EXTENT_FLAG_COMPRESS_ZSTD,    "COMPRESS_ZSTD" },\
>>                  { EXTENT_FLAG_PREALLOC,         "PREALLOC"      },\
>> -               { EXTENT_FLAG_LOGGING,          "LOGGING"       },\
>> -               { EXTENT_FLAG_FILLING,          "FILLING"       })
>> +               { EXTENT_FLAG_LOGGING,          "LOGGING"       })
>>
>>   TRACE_EVENT_CONDITION(btrfs_get_extent,
>>
>> --
>> 2.44.0
>>
>>

