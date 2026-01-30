Return-Path: <linux-btrfs+bounces-21240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C6WDD58fGkONgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21240-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 10:39:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE13BB8FB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 10:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72F643010170
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FBB1E1024;
	Fri, 30 Jan 2026 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJSezL5N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0F32D7FB
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769765845; cv=none; b=m0kGtJaDZpsbG9WMm+7rEEswKV6F7q3s0zuGdwIe6FiNnt4LCs/mrr2fUWun7pplXJ3CJeQ6PxwQAazKqziy9cAO8TPMg+QaF35fPcfefxTI715+bom14Iq0W40Aoi1c3oOoJjyNckXJfnz63b+1AVVCxoivMNY5GVbMKSC8a5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769765845; c=relaxed/simple;
	bh=PbMkLXLHvgdeOm2rjpkuX5Mfq0HIJKkfKBlS9zFkrms=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iBpblbPkNHi2fiOd/DCHceRQDx8s0qV5q2+sK0eIx8VQwMfxdLjrfQVNKnzt2sj8nQ4IX2AsTeLXnUWzCvYeqrqkICNJxnuUqC5V87BoHlBeTlclQzJA1WVHh1JFPH6Cm0qoUkU0EJhBBIShopzrvN/rHd8IRfpc+Ue6/yP1dBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJSezL5N; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a08cb5e30eso493985ad.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 01:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769765842; x=1770370642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HN5PItkEo7YDhL4OlC3nfk0M2II9uOFf6rC3W/MOovY=;
        b=cJSezL5Ns6ZbOOkp/yW7EunK91YjyXQvXQADGcw3et3mPBkS+MSCV9SnGfT36gl4b3
         Bjo/h5PKvaSTBXtU4KN7/t344CTtYbzCrSb/Pe4FC3GerTC1AbBKuX03SP+QJiXwORHu
         ho5GugwykmyqDY7DbHIa4Z8f8n8AjblMwAnt5IV9k3wLS6x8XduxSi32/DH7+Bw0aTnJ
         OKpK/zSNFDrU7WNq2gra5UeUYqCbVJkqnDuk6mngsVbek9kN8gX6zwbTzYT86eE8pU+o
         exWpZAWCObnBYpSC9rDg5z/BoxOLxVTycc09TrR4HUPJ4aaZwjPam9YsMFQPFYf/upL+
         9QEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769765842; x=1770370642;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HN5PItkEo7YDhL4OlC3nfk0M2II9uOFf6rC3W/MOovY=;
        b=kN7XP1UHACR6KNoAgAsYRyYCYupgavbQyjttKfmiKeUxHhJuXXDRmnify1Bd11BRj4
         i2NH2M+VTDn4P2ua+9aPmffS3wjjRv1QN3T+xmGE5TBPh0H//7NAxkIV4wYF/BMQaUgf
         KGPiMYh9zj8uXuliHRKu7CDzv9sQC2aHmuf0M6DicFPZGqS1PaKi7VJeOMMZavkgtb9P
         YYo4jiNt48aLBnqWHWvujQsEre0Tq55WhogCAx+qfHF0a3kcOdE3xp6s+rxTs2QI7sLT
         xOMlsN64QaEs4mtUIWL6SLGU7KqtgsuG+r83q3CTBG/NHM/HuaWu45oTJwbQ3+74p34M
         zKGA==
X-Gm-Message-State: AOJu0Yxzjm/1v8Yx2C23Of3OliFlom4bHZZ4QM71GamOGQsExOwFYOEG
	NuXrprTz/+V7YA5P0LCmuu+f48QtEAagtChkERyiNTpuKjQzMyi+mPpeJd3cPUtpnLjt+ZjW
X-Gm-Gg: AZuq6aIJL0PKuMOj0eyjcsBm/z45Pfen0hQ6qwBAOthfAq1m5E/0+J6Qtue6tntbSny
	iTGndBW4z0j8l/VSWr/XmUGIrMzmvwm1LBDHlwy7wDAL9+WfhFy5F0UXBZQkQ+VW20crABiXXBS
	Z4TX7Wi0yxKcjhPPrJt4XSw/DjL0qKdssvNvMbgaYCIQXoLLU9UNwW0oTtD/jtMBtn32CS4E10f
	fPH3nQHen6HABCrq1aJ7DjgJqwIenLjw+GyBmGcKCsyTneM5a6H3fl/LfChAkl3xS/CgLX1AwsY
	K/++2DDzb6ZflQz1PKcbkr0ShVxTnPw7KlOhmf/Idu9aNwMpnCt6VP6NW2zJG7QJ0YTIUq5rNhe
	n3h949Hj1qupTyupeq5BjrWkJFsljcivX0/TSARXlH2GI8krpidrUtp7gUQ2/M4jytF0qwjSyIu
	f7rhe0S9psF/iD34FBh8ylDTJXiaMmHLP+C/MwP88kOyBybMEEJ5JfiYgMlCV0A3BAXg==
X-Received: by 2002:a17:902:d50e:b0:29d:779c:c0cb with SMTP id d9443c01a7336-2a8d96a0659mr17935915ad.2.1769765841989;
        Fri, 30 Jan 2026 01:37:21 -0800 (PST)
Received: from ?IPV6:2408:8239:502:5512:daed:b15:c399:847e? ([175.143.94.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4153e4sm74117545ad.39.2026.01.30.01.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 01:37:21 -0800 (PST)
Message-ID: <e5eee424-303d-423b-aead-2eccbf63b8ec@gmail.com>
Date: Fri, 30 Jan 2026 17:37:15 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sun YangKai <sunk67188@gmail.com>
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
To: Leo Martins <loemra.dev@gmail.com>, Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20260130001254.83750-1-loemra.dev@gmail.com>
 <df47b1c0-c25e-4501-aaa0-bc73ce1fdc00@gmail.com>
Content-Language: en-US
In-Reply-To: <df47b1c0-c25e-4501-aaa0-bc73ce1fdc00@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21240-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE13BB8FB7
X-Rspamd-Action: no action



On 2026/1/30 12:14, Sun YangKai wrote:
> On 2026/1/30 08:12, Leo Martins wrote:
>> On Thu, 29 Jan 2026 11:52:07 +0000 Filipe Manana<fdmanana@kernel.org> 
>> wrote:
>>> On Tue, Jan 27, 2026 at 8:43 PM Leo Martins<loemra.dev@gmail.com> wrote:
>>>> I've been investigating enospcs at Meta and have observed a strange
>>>> pattern where filesystems are enospcing with lots of unallocated space
>>>> (> 100G). Sample dmesg dump at bottom of message.
>>>>
>>>> btrfs_insert_delayed_dir_index is attempting to migrate some 
>>>> reservation
>>>> from the transaction block reserve and finding it exhausted leading 
>>>> to a
>>>> warning and enospc. This is a bug as the reservations are meant to be
>>>> worst case. It should be impossible to exhaust the transaction block
>>>> reserve.
>>>>
>>>> Some tracing of affected hosts revealed that there were single
>>>> btrfs_search_slot calls that were COWing 100s of times. I was able to
>>>> reproduce this behavior locally by creating a very constrained cgroup
>>>> and producing a lot of concurrent filesystem operations. Here's the
>>>> pattern:
>>>>
>>>>   1. btrfs_search_slot() begins tree traversal with cow=1
>>>>   2. Node at level N needs COW (old generation or WRITTEN flag set)
>>>>   3. btrfs_cow_block() allocates new node, updates parent pointer
>>>>   4. Traversal continues, but hits a condition requiring restart 
>>>> (e.g., node
>>>>      not cached, lock contention, need higher write_lock_level)
>>>>   5. btrfs_release_path() releases all locks and references
>>>>   6. Memory pressure triggers writeback on the COW'd node
>>>>   7. lock_extent_buffer_for_io() clears EXTENT_BUFFER_DIRTY and sets
>>>>      BTRFS_HEADER_FLAG_WRITTEN
>>>>   8. goto again - traversal restarts from root
>>>>   9. Traversal reaches the freshly COW'd node
>>>>   10. should_cow_block() sees WRITTEN flag set, returns true
>>>>   11. btrfs_cow_block() allocates another new node - same logical 
>>>> position,
>>>>       new physical location, new reservation consumed
>>>>   12. Steps 4-11 repeat indefinitely under sustained memory pressure
>>>>
>>>> Note this behavior should be much harder to trigger since Boris's
>>>> AS_KERNEL_FILE changes that make it so that extent_buffer pages aren't
>>>> accounted for in user cgroups. However, I believe it
>>>> would still be an issue under global memory pressure.
>>>> Link:https://lore.kernel.org/linux-btrfs/ 
>>>> cover.1755812945.git.boris@bur.io/
>>>>
>>>> This COW amplification breaks the idea that transaction reservations 
>>>> are
>>>> worst case as any search slot call could find itself in this COW 
>>>> loop and
>>>> exhaust its reservation.
>>>>
>>>> My proposed solution is to temporarily pin extent buffers for the
>>>> lifetime of btrfs_search_slot. This prevents the massive COW
>>>> amplification that can be seen during high memory pressure.
>>>>
>>>> The implementation uses a local xarray to track COW'd buffers for the
>>>> duration of the search. The xarray stores extent_buffer pointers 
>>>> without
>>>> taking additional references; this is safe because tracked buffers 
>>>> remain
>>>> dirty (writeback_blockers prevents the dirty bit from being cleared) 
>>>> and
>>>> dirty buffers cannot be reclaimed by memory pressure.
>>>>
>>>> Synchronization is provided by eb->lock: increments in
>>>> btrfs_search_slot_track_cow() occur while holding the write lock, and
>>>> the check in lock_extent_buffer_for_io() also holds the write lock via
>>>> btrfs_tree_lock(). Decrements don't require eb->lock because
>>>> writeback_blockers is atomic and merely indicates "don't write yet".
>>>> Once we decrement, we're done and don't care if writeback proceeds
>>>> immediately.
>>> This seems too complex to me.
>>>
>>> So this problem is very similar to some idea I had a few years ago but
>>> never managed to implement.
>>> It was about avoiding unnecessary COW, not for this space reservation
>>> exhaustion due to sustained memory pressure, but it would solve it
>>> too.
>>>
>>> The idea was that we do unnecessary COW in cases like this:
>>>
>>> 1) We COW a path in some tree and we are at transaction N;
>>>
>>> 2) Writeback happened for the extent buffers in that path while we are
>>> in the same transaction, because we reached the 32M limit and some
>>> task called btrfs_btree_balance_dirty() or something else triggered
>>> writeback of the btree inode;
>>>
>>> 3) While still at transaction N, we visit the same path to add an item
>>> to a leaf, or modify an item, whatever. Because the extent buffers
>>> have BTRFS_HEADER_FLAG_WRITTEN, we COW them again (should_cow_block()
>>> returns true).
>>>
>>> So during the lifetime of a transaction we can have a lot of
>>> unnecessary COW - we spend more time allocating extents, allocating
>>> memory, copying extent buffer data, use more space per transaction,
>>> etc.
>>>
>>> The idea was to not COW when an extent buffer has
>>> BTRFS_HEADER_FLAG_WRITTEN set, but only if its generation
>>> (btrfs_header_generation(eb)) matches the current transaction.
>>> That is safe because there's no committed tree that points to an
>>> extent buffer created in the current transaction.
>>>
>>> Any further modification to the extent buffer must be sure that the
>>> EXTENT_BUFFER_DIRTY flag is set, that the eb range is still in the
>>> transaction's dirty_pages io tree, etc, so that we don't miss writing
>>> the extent buffer to the same location again before the transaction
>>> commits the superblocks.
>>>
>>> Have you considered an approach like this?
>> I had not considered this, but it is a great idea.
>>
>> My first thought is that implementing this could be as simple
>> as removing the BTRFS_HEADER_FLAG_WRITTEN check. However, this
>> would mess with the assumptions around the log tree. From
>> btrfs_sync_log():
> After a fast glance and some tests, I found things might not be that 
> easy. The problem is not only the log tree.
>> /*
>>   * IO has been started, blocks of the log tree have WRITTEN flag set
>>   * in their headers. new modifications of the log will be written to
>>   * new positions. so it's safe to allow log writers to go in.
>>   */
>>
>> ^ Assumes that WRITTEN blocks will be COW'd.
>>
>> The issue looks like:
>>
>>   1. fsync A COWs eb
>>   2. fsync A lock_extent_buffer_for_io(); sets WRITTEN, unlocks tree
>>   3. fsync B does __not__ COW eb and modifies it
>>   4. fsync A writes modified eb to disk
>>   5. CRASH; the log tree is corrupted
>>
>> One way to avoid that is to keep the current behavior for the log
>> tree, but that leaves the potential for COW amplification...
> I tested with a patch like this:
> @@ -624,14 +624,18 @@ static inline bool should_cow_block(const struct 
> btrfs_trans_handle *trans,
>          if (btrfs_header_generation(buf) != trans->transid)
>                  return true;
> 
> -       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
> -               return true;
> -
>          /* Ensure we can see the FORCE_COW bit. */
>          smp_mb__before_atomic();
>          if (test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
>                  return true;
> 
> +       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> +               if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID)
> +                       return true;
> +               btrfs_mark_buffer_dirty(trans, buf);
> +               return false;
> +       }
> +
>          if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
> 
>                  return false;
> 
> And get some errors like this:
> 
> 
> [  +0.090163] [ T2589] run fstests btrfs/004 at 2026-01-30 11:53:37
> [  +0.432352] [T11685] BTRFS: device fsid 1fb397fc-97a7-44dd-9602- 
> dd38b74bc391 devid 1 transid 8 /dev/loop1 (7:1) scanned by mount (11685)
> [  +0.000351] [T11685] BTRFS info (device loop1): first mount of 
> filesystem 1fb397fc-97a7-44dd-9602-dd38b74bc391
> [  +0.000014] [T11685] BTRFS info (device loop1): using crc32c (crc32c- 
> lib) checksum algorithm
> [  +0.001298] [T11685] BTRFS info (device loop1): checking UUID tree
> [  +0.000039] [T11685] BTRFS info (device loop1): enabling ssd 
> optimizations
> [  +0.000003] [T11685] BTRFS info (device loop1): turning on async discard
> [  +0.000002] [T11685] BTRFS info (device loop1): enabling free space tree
> [  +1.051781] [T11703] page: refcount:2 mapcount:0 
> mapping:00000000eb6d7caa index:0x2348 pfn:0x1caebf
> [  +0.000008] [T11703] memcg:ffff9b3300263cc0
> [  +0.000003] [T11703] aops:0xffffffffc0354040 ino:1
> [  +0.000024] [T11703] flags: 0x4e0000000000423e(referenced|uptodate| 
> dirty|lru|workingset|private|writeback|zone=1)
> [  +0.000007] [T11703] raw: 4e0000000000423e fffff74a872bb908 
> fffff74a84206a88 ffff9b33c6706880
> [  +0.000004] [T11703] raw: 0000000000002348 ffff9b334be522d0 
> 00000002ffffffff ffff9b3300263cc0
> [  +0.000002] [T11703] page dumped because: eb page dump
> [  +0.000003] [T11703] BTRFS critical (device loop1): corrupt leaf: 
> root=5 block=36995072 slot=118 ino=406 file_offset=94208, invalid 
> ram_bytes for file extent, have 8660273067269322872, should be aligned 
> to 4096
> [  +0.000013] [T11703] BTRFS info (device loop1): leaf 36995072 gen 33 
> total ptrs 128 free space 2857 owner 5
> [  +0.000006] [T11703]     item 0 key (386 DIR_ITEM 238230307) itemoff 
> 16249 itemsize 34
> [  +0.000004] [T11703]         location key (462 1 0) type 2
> [  +0.000003] [T11703]         transid 33 data_len 0 name_len 4
> [  +0.000003] [T11703]     item 1 key (386 DIR_ITEM 1473745676) itemoff 
> 16216 itemsize 33
> [  +0.000004] [T11703]         location key (376 1 0) type 3
> [  +0.000002] [T11703]         transid 30 data_len 0 name_len 3
> [  +0.000003] [T11703]     item 2 key (386 DIR_ITEM 2243137595) itemoff 
> 16182 itemsize 34
> [  +0.000004] [T11703]         location key (413 1 0) type 1
> [  +0.000002] [T11703]         transid 32 data_len 0 name_len 4
> ...
> [  +0.000001] [T11703]     item 127 key (405 DIR_ITEM 828387202) itemoff 
> 6057 itemsize 34
> [  +0.000002] [T11703]         location key (479 1 0) type 3
> [  +0.000001] [T11703]         transid 33 data_len 0 name_len 4
> [  +0.000002] [T11703] BTRFS error (device loop1): block=36995072 write 
> time tree block corruption detected
> [  +0.003429] [T11703] BTRFS: error (device loop1) in 
> btrfs_commit_transaction:2555: errno=-5 IO failure (Error while writing 
> out transaction)
> [  +0.000007] [T11703] BTRFS info (device loop1 state E): forced readonly
> [  +0.000002] [T11703] BTRFS warning (device loop1 state E): Skipping 
> commit of aborted transaction.
> [  +0.000002] [T11703] BTRFS error (device loop1 state EA): Transaction 
> aborted (error -5)
> [  +0.000003] [T11703] BTRFS: error (device loop1 state EA) in 
> cleanup_transaction:2037: errno=-5 IO failure
> 
> The reported 406 inode is even not in the printed leaf. It seems like a 
> data race maybe caused by:
> 
> We unlock the eb after setting the WRITTEN flag during write back, and 
> the eb should not get modified since then because all future writes will 
> use the cowed eb. However, with the WRITTEN flag check removed in 
> should_cow_block, we might write to the eb with WRITTEN flag set which 
> might be under io.

I tried again with this:

@@ -624,14 +624,20 @@ static inline bool should_cow_block(const struct 
btrfs_trans_handle *trans,
         if (btrfs_header_generation(buf) != trans->transid)
                 return true;

-       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
-               return true;
-
         /* Ensure we can see the FORCE_COW bit. */
         smp_mb__before_atomic();
         if (test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
                 return true;

+       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
+               if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID)
+                       return true;
+               if (test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags))
+                       return true;
+               btrfs_mark_buffer_dirty(trans, buf);
+               return false;
+       }
+
         if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
                 return false;

When WRITEBACK is set, do a normal cow to prevent the data race. This 
seems to fix the previous problem. However, I got this:

[  +0.020843] [T15127] BTRFS error (device loop1): block=30687232 bad 
generation, have 11 expect > 14
[  +0.000009] [T15127] 	item 0 key (256 INODE_ITEM 0) itemoff 16123 
itemsize 160
[  +0.000004] [T15127] 		inode generation 3 transid 11 size 10 nbytes 16384
[  +0.000003] [T15127] 		block group 0 mode 40755 links 1 uid 0 gid 0
[  +0.000002] [T15127] 		rdev 0 sequence 1 flags 0x0
[  +0.000002] [T15127] 		atime 1769760651.0
[  +0.000002] [T15127] 		ctime 1769760652.250234845
[  +0.000002] [T15127] 		mtime 1769760652.250234845
[  +0.000001] [T15127] 		otime 1769760651.0
[  +0.000002] [T15127] 	item 1 key (256 INODE_REF 256) itemoff 16111 
itemsize 12
[  +0.000003] [T15127] 		index 0 name_len 2
[  +0.000002] [T15127] 	item 2 key (256 DIR_ITEM 2030520461) itemoff 
16076 itemsize 35
[  +0.000002] [T15127] 		location key (257 1 0) type 2
[  +0.000002] [T15127] 		transid 11 data_len 0 name_len 5
[  +0.000002] [T15127] 	item 3 key (256 DIR_INDEX 2) itemoff 16041 
itemsize 35
[  +0.000002] [T15127] 		location key (257 1 0) type 2
[  +0.000002] [T15127] 		transid 11 data_len 0 name_len 5
[  +0.000002] [T15127] 	item 4 key (257 INODE_ITEM 0) itemoff 15881 
itemsize 160
[  +0.000002] [T15127] 		inode generation 11 transid 11 size 12 nbytes 0
[  +0.000002] [T15127] 		block group 0 mode 40755 links 1 uid 0 gid 0
[  +0.000002] [T15127] 		rdev 0 sequence 19 flags 0x0
[  +0.000001] [T15127] 		atime 1769760652.250234845
[  +0.000002] [T15127] 		ctime 1769760652.256913323
[  +0.000002] [T15127] 		mtime 1769760652.256913323
[  +0.000001] [T15127] 		otime 1769760652.250234845
[  +0.000002] [T15127] 	item 5 key (257 INODE_REF 256) itemoff 15866 
itemsize 15
[  +0.000002] [T15127] 		index 2 name_len 5
[  +0.000002] [T15127] 	item 6 key (257 DIR_ITEM 247980518) itemoff 
15830 itemsize 36
[  +0.000002] [T15127] 		location key (256 132 18446744073709551615) type 2
[  +0.000002] [T15127] 		transid 11 data_len 0 name_len 6
[  +0.000002] [T15127] 	item 7 key (257 DIR_INDEX 2) itemoff 15794 
itemsize 36
[  +0.000002] [T15127] 		location key (256 132 18446744073709551615) type 2
[  +0.000002] [T15127] 		transid 11 data_len 0 name_len 6
[  +0.000001] [T15127] BTRFS error (device loop1): block=30687232 write 
time tree block corruption detected
[  +0.000017] [T15127] BTRFS error (device loop1): block=30703616 bad 
generation, have 11 expect > 14
[  +0.000004] [T15127] 	item 0 key (13631488 BLOCK_GROUP_ITEM 8388608) 
itemoff 16259 itemsize 24
[  +0.000003] [T15127] 		block group used 0 chunk_objectid 256 flags 1
[  +0.000002] [T15127] 	item 1 key (22020096 BLOCK_GROUP_ITEM 8388608) 
itemoff 16235 itemsize 24
[  +0.000002] [T15127] 		block group used 16384 chunk_objectid 256 flags 34
[  +0.000002] [T15127] 	item 2 key (22036480 METADATA_ITEM 0) itemoff 
16202 itemsize 33
[  +0.000002] [T15127] 		extent refs 1 gen 8 flags 2
[  +0.000002] [T15127] 		ref#0: tree block backref root 3
[  +0.000003] [T15127] 	item 3 key (30408704 BLOCK_GROUP_ITEM 268435456) 
itemoff 16178 itemsize 24
[  +0.000002] [T15127] 		block group used 163840 chunk_objectid 256 flags 36
[  +0.000002] [T15127] 	item 4 key (30490624 METADATA_ITEM 0) itemoff 
16145 itemsize 33
[  +0.000002] [T15127] 		extent refs 1 gen 5 flags 2
[  +0.000002] [T15127] 		ref#0: tree block backref root 7
[  +0.000002] [T15127] 	item 5 key (30523392 METADATA_ITEM 0) itemoff 
16112 itemsize 33
[  +0.000002] [T15127] 		extent refs 1 gen 5 flags 2
[  +0.000002] [T15127] 		ref#0: tree block backref root 18446744073709551607
[  +0.000002] [T15127] 	item 6 key (30605312 METADATA_ITEM 0) itemoff 
16079 itemsize 33
[  +0.000002] [T15127] 		extent refs 1 gen 9 flags 2
[  +0.000002] [T15127] 		ref#0: tree block backref root 4
[  +0.000002] [T15127] 	item 7 key (30687232 METADATA_ITEM 0) itemoff 
16046 itemsize 33
[  +0.000002] [T15127] 		extent refs 1 gen 11 flags 2
[  +0.000002] [T15127] 		ref#0: tree block backref root 5
[  +0.000002] [T15127] 	item 8 key (30703616 METADATA_ITEM 0) itemoff 
16013 itemsize 33
[  +0.000002] [T15127] 		extent refs 1 gen 11 flags 2
[  +0.000002] [T15127] 		ref#0: tree block backref root 2
[  +0.000002] [T15127] 	item 9 key (30720000 METADATA_ITEM 0) itemoff 
15980 itemsize 33
[  +0.000002] [T15127] 		extent refs 1 gen 11 flags 2
[  +0.000002] [T15127] 		ref#0: tree block backref root 10
[  +0.000002] [T15127] 	item 10 key (30736384 METADATA_ITEM 0) itemoff 
15947 itemsize 33
[  +0.000002] [T15127] 		extent refs 1 gen 11 flags 2
[  +0.000002] [T15127] 		ref#0: tree block backref root 8
[  +0.000002] [T15127] 	item 11 key (30752768 METADATA_ITEM 0) itemoff 
15914 itemsize 33
[  +0.000002] [T15127] 		extent refs 1 gen 11 flags 2
[  +0.000002] [T15127] 		ref#0: tree block backref root 256
[  +0.000002] [T15127] 	item 12 key (30769152 METADATA_ITEM 0) itemoff 
15881 itemsize 33
[  +0.000002] [T15127] 		extent refs 1 gen 11 flags 2
[  +0.000002] [T15127] 		ref#0: tree block backref root 1
[  +0.000002] [T15127] 	item 13 key (30785536 METADATA_ITEM 0) itemoff 
15848 itemsize 33
[  +0.000002] [T15127] 		extent refs 1 gen 11 flags 2
[  +0.000002] [T15127] 		ref#0: tree block backref root 9
[  +0.000002] [T15127] BTRFS error (device loop1): block=30703616 write 
time tree block corruption detected
[  +0.000012] [T15127] BTRFS error (device loop1): block=30720000 bad 
generation, have 11 expect > 14
[  +0.000004] [T15127] 	item 0 key (13631488 FREE_SPACE_INFO 8388608) 
itemoff 16275 itemsize 8
[  +0.000002] [T15127] 	item 1 key (13631488 FREE_SPACE_EXTENT 8388608) 
itemoff 16275 itemsize 0
[  +0.000002] [T15127] 	item 2 key (22020096 FREE_SPACE_INFO 8388608) 
itemoff 16267 itemsize 8
[  +0.000002] [T15127] 	item 3 key (22020096 FREE_SPACE_EXTENT 16384) 
itemoff 16267 itemsize 0
[  +0.000003] [T15127] 	item 4 key (22052864 FREE_SPACE_EXTENT 8355840) 
itemoff 16267 itemsize 0
[  +0.000002] [T15127] 	item 5 key (30408704 FREE_SPACE_INFO 268435456) 
itemoff 16259 itemsize 8
[  +0.000002] [T15127] 	item 6 key (30408704 FREE_SPACE_EXTENT 81920) 
itemoff 16259 itemsize 0
[  +0.000002] [T15127] 	item 7 key (30507008 FREE_SPACE_EXTENT 16384) 
itemoff 16259 itemsize 0
[  +0.000002] [T15127] 	item 8 key (30539776 FREE_SPACE_EXTENT 65536) 
itemoff 16259 itemsize 0
[  +0.000002] [T15127] 	item 9 key (30621696 FREE_SPACE_EXTENT 65536) 
itemoff 16259 itemsize 0
[  +0.000003] [T15127] 	item 10 key (30801920 FREE_SPACE_EXTENT 
268042240) itemoff 16259 itemsize 0
[  +0.000002] [T15127] BTRFS error (device loop1): block=30720000 write 
time tree block corruption detected
[  +0.000010] [T15127] BTRFS error (device loop1): block=30736384 bad 
generation, have 11 expect > 14
[  +0.000004] [T15127] 	item 0 key (0 QGROUP_STATUS 0) itemoff 16243 
itemsize 40
[  +0.000003] [T15127] 	item 1 key (0 QGROUP_INFO 5) itemoff 16203 
itemsize 40
[  +0.000002] [T15127] 	item 2 key (0 QGROUP_INFO 256) itemoff 16163 
itemsize 40
[  +0.000002] [T15127] 	item 3 key (0 QGROUP_LIMIT 5) itemoff 16123 
itemsize 40
[  +0.000002] [T15127] 	item 4 key (0 QGROUP_LIMIT 256) itemoff 16083 
itemsize 40
[  +0.000003] [T15127] BTRFS error (device loop1): block=30736384 write 
time tree block corruption detected
[  +0.000014] [T15127] BTRFS error (device loop1): block=30769152 bad 
generation, have 11 expect > 14
[  +0.000004] [T15127] 	item 0 key (2 ROOT_ITEM 0) itemoff 15844 
itemsize 439
[  +0.000002] [T15127] 		root data bytenr 30703616 refs 1
[  +0.000002] [T15127] 	item 1 key (4 ROOT_ITEM 0) itemoff 15405 
itemsize 439
[  +0.000002] [T15127] 		root data bytenr 30605312 refs 1
[  +0.000001] [T15127] 	item 2 key (5 INODE_REF 6) itemoff 15388 itemsize 17
[  +0.000002] [T15127] 		index 0 name_len 7
[  +0.000002] [T15127] 	item 3 key (5 ROOT_ITEM 0) itemoff 14949 
itemsize 439
[  +0.000002] [T15127] 		root data bytenr 30687232 refs 1
[  +0.000002] [T15127] 	item 4 key (5 ROOT_REF 256) itemoff 14925 
itemsize 24
[  +0.000002] [T15127] 	item 5 key (6 INODE_ITEM 0) itemoff 14765 
itemsize 160
[  +0.000002] [T15127] 		inode generation 3 transid 0 size 0 nbytes 16384
[  +0.000002] [T15127] 		block group 0 mode 40755 links 1 uid 0 gid 0
[  +0.000002] [T15127] 		rdev 0 sequence 0 flags 0x0
[  +0.000001] [T15127] 		atime 1769760651.0
[  +0.000002] [T15127] 		ctime 1769760651.0
[  +0.000002] [T15127] 		mtime 1769760651.0
[  +0.000001] [T15127] 		otime 1769760651.0
[  +0.000002] [T15127] 	item 6 key (6 INODE_REF 6) itemoff 14753 itemsize 12
[  +0.000002] [T15127] 		index 0 name_len 2
[  +0.000001] [T15127] 	item 7 key (6 DIR_ITEM 2378154706) itemoff 14716 
itemsize 37
[  +0.000003] [T15127] 		location key (5 132 18446744073709551615) type 2
[  +0.000001] [T15127] 		transid 3 data_len 0 name_len 7
[  +0.000002] [T15127] 	item 8 key (7 ROOT_ITEM 0) itemoff 14277 
itemsize 439
[  +0.000002] [T15127] 		root data bytenr 30490624 refs 1
[  +0.000002] [T15127] 	item 9 key (8 ROOT_ITEM 0) itemoff 13838 
itemsize 439
[  +0.000002] [T15127] 		root data bytenr 30736384 refs 1
[  +0.000001] [T15127] 	item 10 key (9 ROOT_ITEM 0) itemoff 13399 
itemsize 439
[  +0.000002] [T15127] 		root data bytenr 30785536 refs 1
[  +0.000002] [T15127] 	item 11 key (10 ROOT_ITEM 0) itemoff 12960 
itemsize 439
[  +0.000002] [T15127] 		root data bytenr 30720000 refs 1
[  +0.000001] [T15127] 	item 12 key (256 ROOT_ITEM 11) itemoff 12521 
itemsize 439
[  +0.000003] [T15127] 		root data bytenr 30752768 refs 1
[  +0.000001] [T15127] 	item 13 key (256 ROOT_BACKREF 5) itemoff 12497 
itemsize 24
[  +0.000003] [T15127] 	item 14 key (18446744073709551607 ROOT_ITEM 0) 
itemoff 12058 itemsize 439
[  +0.000002] [T15127] 		root data bytenr 30523392 refs 1
[  +0.000001] [T15127] BTRFS error (device loop1): block=30769152 write 
time tree block corruption detected
[  +0.000012] [T15127] BTRFS error (device loop1): block=30801920 bad 
generation, have 12 expect > 14
[  +0.000003] [T15127] 	item 0 key (0 QGROUP_STATUS 0) itemoff 16243 
itemsize 40
[  +0.000003] [T15127] 	item 1 key (0 QGROUP_INFO 5) itemoff 16203 
itemsize 40
[  +0.000002] [T15127] 	item 2 key (0 QGROUP_INFO 256) itemoff 16163 
itemsize 40
[  +0.000002] [T15127] 	item 3 key (0 QGROUP_INFO 257) itemoff 16123 
itemsize 40
[  +0.000002] [T15127] 	item 4 key (0 QGROUP_LIMIT 5) itemoff 16083 
itemsize 40
[  +0.000002] [T15127] 	item 5 key (0 QGROUP_LIMIT 256) itemoff 16043 
itemsize 40
[  +0.000002] [T15127] 	item 6 key (0 QGROUP_LIMIT 257) itemoff 16003 
itemsize 40
[  +0.000002] [T15127] BTRFS error (device loop1): block=30801920 write 
time tree block corruption detected
[  +0.000014] [T15127] BTRFS error (device loop1): block=30818304 bad 
generation, have 12 expect > 14
[  +0.000003] [T15127] 	item 0 key (256 INODE_ITEM 0) itemoff 16123 
itemsize 160
[  +0.000002] [T15127] 		inode generation 3 transid 11 size 10 nbytes 16384
[  +0.000002] [T15127] 		block group 0 mode 40755 links 1 uid 0 gid 0
[  +0.000002] [T15127] 		rdev 0 sequence 1 flags 0x0
[  +0.000002] [T15127] 		atime 1769760651.0
[  +0.000001] [T15127] 		ctime 1769760652.250234845
[  +0.000002] [T15127] 		mtime 1769760652.250234845
[  +0.000001] [T15127] 		otime 1769760651.0
[  +0.000002] [T15127] 	item 1 key (256 INODE_REF 256) itemoff 16111 
itemsize 12
[  +0.000002] [T15127] 		index 0 name_len 2
[  +0.000002] [T15127] 	item 2 key (256 DIR_ITEM 2030520461) itemoff 
16076 itemsize 35
[  +0.000002] [T15127] 		location key (257 1 0) type 2
[  +0.000002] [T15127] 		transid 11 data_len 0 name_len 5
[  +0.000001] [T15127] 	item 3 key (256 DIR_INDEX 2) itemoff 16041 
itemsize 35
[  +0.000002] [T15127] 		location key (257 1 0) type 2
[  +0.000002] [T15127] 		transid 11 data_len 0 name_len 5
[  +0.000002] [T15127] 	item 4 key (257 INODE_ITEM 0) itemoff 15881 
itemsize 160
[  +0.000002] [T15127] 		inode generation 11 transid 12 size 24 nbytes 0
[  +0.000002] [T15127] 		block group 0 mode 40755 links 1 uid 0 gid 0
[  +0.000002] [T15127] 		rdev 0 sequence 19 flags 0x0
[  +0.000001] [T15127] 		atime 1769760652.250234845
[  +0.000002] [T15127] 		ctime 1769760652.267621586
[  +0.000001] [T15127] 		mtime 1769760652.267621586
[  +0.000002] [T15127] 		otime 1769760652.250234845
[  +0.000002] [T15127] 	item 5 key (257 INODE_REF 256) itemoff 15866 
itemsize 15
[  +0.000002] [T15127] 		index 2 name_len 5
[  +0.000001] [T15127] 	item 6 key (257 DIR_ITEM 247980518) itemoff 
15830 itemsize 36
[  +0.000002] [T15127] 		location key (256 132 18446744073709551615) type 2
[  +0.000002] [T15127] 		transid 11 data_len 0 name_len 6
[  +0.000002] [T15127] 	item 7 key (257 DIR_ITEM 496439826) itemoff 
15794 itemsize 36
[  +0.000002] [T15127] 		location key (257 132 18446744073709551615) type 2
[  +0.000002] [T15127] 		transid 12 data_len 0 name_len 6
[  +0.000001] [T15127] 	item 8 key (257 DIR_INDEX 2) itemoff 15758 
itemsize 36
[  +0.000003] [T15127] 		location key (256 132 18446744073709551615) type 2
[  +0.000001] [T15127] 		transid 11 data_len 0 name_len 6
[  +0.000002] [T15127] 	item 9 key (257 DIR_INDEX 3) itemoff 15722 
itemsize 36
[  +0.000002] [T15127] 		location key (257 132 18446744073709551615) type 2
[  +0.000002] [T15127] 		transid 12 data_len 0 name_len 6
[  +0.000001] [T15127] BTRFS error (device loop1): block=30818304 write 
time tree block corruption detected
[  +0.000016] [T15127] BTRFS error (device loop1): block=30851072 bad 
generation, have 12 expect > 14
[  +0.000004] [T15127] 	item 0 key (2 ROOT_ITEM 0) itemoff 15844 
itemsize 439
[  +0.000002] [T15127] 		root data bytenr 30867456 refs 1
[  +0.000001] [T15127] 	item 1 key (4 ROOT_ITEM 0) itemoff 15405 
itemsize 439
[  +0.000002] [T15127] 		root data bytenr 30605312 refs 1
[  +0.000002] [T15127] 	item 2 key (5 INODE_REF 6) itemoff 15388 itemsize 17
[  +0.000002] [T15127] 		index 0 name_len 7
[  +0.000001] [T15127] 	item 3 key (5 ROOT_ITEM 0) itemoff 14949 
itemsize 439
[  +0.000002] [T15127] 		root data bytenr 30818304 refs 1
[  +0.000002] [T15127] 	item 4 key (5 ROOT_REF 256) itemoff 14925 
itemsize 24
[  +0.000002] [T15127] 	item 5 key (5 ROOT_REF 257) itemoff 14901 
itemsize 24
[  +0.000002] [T15127] 	item 6 key (6 INODE_ITEM 0) itemoff 14741 
itemsize 160
[  +0.000002] [T15127] 		inode generation 3 transid 0 size 0 nbytes 16384
[  +0.000002] [T15127] 		block group 0 mode 40755 links 1 uid 0 gid 0
[  +0.000003] [T15127] 		rdev 0 sequence 0 flags 0x0
[  +0.000001] [T15127] 		atime 1769760651.0
[  +0.000002] [T15127] 		ctime 1769760651.0
[  +0.000003] [T15127] 		mtime 1769760651.0
[  +0.000002] [T15127] 		otime 1769760651.0
[  +0.000002] [T15127] 	item 7 key (6 INODE_REF 6) itemoff 14729 itemsize 12
[  +0.000003] [T15127] 		index 0 name_len 2
[  +0.000002] [T15127] 	item 8 key (6 DIR_ITEM 2378154706) itemoff 14692 
itemsize 37
[  +0.000003] [T15127] 		location key (5 132 18446744073709551615) type 2
[  +0.000002] [T15127] 		transid 3 data_len 0 name_len 7
[  +0.000002] [T15127] 	item 9 key (7 ROOT_ITEM 0) itemoff 14253 
itemsize 439
[  +0.000003] [T15127] 		root data bytenr 30490624 refs 1
[  +0.000002] [T15127] 	item 10 key (8 ROOT_ITEM 0) itemoff 13814 
itemsize 439
[  +0.000002] [T15127] 		root data bytenr 30801920 refs 1
[  +0.000003] [T15127] 	item 11 key (9 ROOT_ITEM 0) itemoff 13375 
itemsize 439
[  +0.000002] [T15127] 		root data bytenr 30900224 refs 1
[  +0.000002] [T15127] 	item 12 key (10 ROOT_ITEM 0) itemoff 12936 
itemsize 439
[  +0.000003] [T15127] 		root data bytenr 30883840 refs 1
[  +0.000002] [T15127] 	item 13 key (256 ROOT_ITEM 11) itemoff 12497 
itemsize 439
[  +0.000003] [T15127] 		root data bytenr 30752768 refs 1
[  +0.000002] [T15127] 	item 14 key (256 ROOT_BACKREF 5) itemoff 12473 
itemsize 24
[  +0.000003] [T15127] 	item 15 key (257 ROOT_ITEM 12) itemoff 12034 
itemsize 439
[  +0.000003] [T15127] 		root data bytenr 30834688 refs 1
[  +0.000002] [T15127] 	item 16 key (257 ROOT_BACKREF 5) itemoff 12010 
itemsize 24
[  +0.000003] [T15127] 	item 17 key (18446744073709551607 ROOT_ITEM 0) 
itemoff 11571 itemsize 439
[  +0.000004] [T15127] 		root data bytenr 30523392 refs 1
[  +0.000002] [T15127] BTRFS error (device loop1): block=30851072 write 
time tree block corruption detected

and a lot more lines with the same generation errors for btrfs/122 
btrfs/152 btrfs/210 btrfs/224 btrfs/316 btrfs/320 btrfs/340 fstest cases.

I have no idea why it's trying to write some ebs older than current 
transaction. Seems related with snapshots.

> To fix this, we need to check the DIRTY flag again to prevent writing a 
> eb which has some new data written, and lock the eb before we really 
> doing io related things. I'm not farmilar with io related code so please 
> correct me if I got anything wrong.
> 
> Thanks,
> 
> Sun Yangkai



