Return-Path: <linux-btrfs+bounces-21231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mESYF00wfGlVLQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21231-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 05:15:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BBBB7095
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 05:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B468301326C
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 04:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4D7366567;
	Fri, 30 Jan 2026 04:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bidml+NR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61130BF55
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 04:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769746495; cv=none; b=uRn6YoqDUBcUTAZpjdUwaerVstXPn0byRqfrkjxw2HOAq/v8SjDuyJedAP2LLPhQqz1NeL5Idv5Z+z+d4AziubGJrS03+ZTsUd037iIeKpcvNtSJBE0BO30Zjz+UWolftvTK+bL+VbiCrgQUfC5lSb9MzLkFMpQxgC8llgPbSpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769746495; c=relaxed/simple;
	bh=nhGlaC+Isdu38qVfloCQDa8Wyb3Qv5CGPwXjDCzNmaA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y3rw/uCoo5jmIZEEaae9qVFS07rz6sydQcuBnCSpcOaEB9qHtnLkmVaPCNBiuoJWSXTSyeD3lETCJlISnI3SsYB2zsfHK4VNKr6kTJFJP8rAUSsrILA2KGy5VIVjcY8B05fwRmrE604wjyzsbzjb6uU3ZsjXq2qQc6t60ry35o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bidml+NR; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a7a9b06eabso985815ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 20:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769746492; x=1770351292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ybQWZZY+KItIzdX2BH7f94tYEkY5d8mf5MNG5oegI3Q=;
        b=bidml+NRCnyQCnxthOzrGQDwqZuR/TxUMicMet0vcmuACC0TtgvTCGG+tKM8iyUjav
         6FxsXNEoylhUStTCcYx/xAiGfGmlQmC08Ab2TgiQpRSlEu/jVhMHUlLvGWeFOmgvzNQ5
         /1xZbIhGV3zRIEPccRAPHDwzB4coIlmKNnOzx8zWpfAace2woobhaEdMZhtVWSCx5tz8
         c9ezQ6W7hebMi9C+AHvod8iFWjJD3QAVYAkQDafh/T6oRyOOZ0fgkrX6FwdJaBE9lLwY
         2ZlLDeQFtNV2CJ1sv/9qqcdxtGTCtvG6+3vvLIY5gQAUZflod6atHyylkP/K9GRQjWSw
         hKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769746492; x=1770351292;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybQWZZY+KItIzdX2BH7f94tYEkY5d8mf5MNG5oegI3Q=;
        b=a9ny9iqKWUKd7ZYWK7iq7lEmkkX6+BwpRu1Ck9YTAdWYVxSdCjehN5NFudZV7+5bBB
         EzwFISOXhNlOrBigPwqw3diJKZodvqR2zDYEBU2gyGo4UandHEgOEwZ9+EHyADkI+iWl
         42s4U6hWyDL+IMPzWuye2NyKyot7QC7mnUvO19YHJLCABj6waJSkQoJCjR8G9e6CZFpO
         102zd/jcu1TPehONH3J0Lw0eVJFJy9Z9yZMSY6RFx+g1hyrmm1FQ1muFRD56W6LXWIBV
         IExP27JtY8AyD/yWgDAxaZjX8DJNv/9qyNkfvHJ8YW6enoZYknG3acEWU1I5DNaAhF+X
         Cp/A==
X-Gm-Message-State: AOJu0Yyp05vKC3VRpdqPfEkF3+5E7phg8+6wCpAneOKvu9clr9oy071H
	BxvePoRzKHzwYYKaccCWhbG8zgGcJQ/3UpozFJ5u7rhIsC0lp6H3fwoF
X-Gm-Gg: AZuq6aJgQ9oWAFKtconjI8BvhxCBFv7HQXeBa+jlV5EqdRcyQJDczIPI2LjKy+RE3ND
	o3d5Kq1FamAGg9bYNmFjPGiCu8pfULCwwxoNaQBMjUejw9H+hKIu3GeP2ExPklg8VgRiAhGxO37
	vSRrzzOp/9KDmL3T9kc78fK4nhzltnA22dXPdxQxXLhLuCus0tUZaojjNX1RtsH35ZsW2sSMDGX
	Q+ZLXdUAKXjQZy13/j7WDIAsfAz+lA41UNVrira/Pbj2szclp8patBKjsfqobAll8/r3h1LEed3
	li3XY/PqE9xoAf+hb/TY7v11UsdZhnut3E1iSmhh5GCcp9Ilnm4bjXEOI7pd9Qyw6TdrXkLOgA3
	SN9HWCWMhcNZjx1e63HzhRFI4MPPawrjimT1A+CYKKWC0+oo8dFn89yz7KVEh7HV1Kqfzz+gi5e
	aKmP5VbqGzgzf5RE0kX8pweNDyL2sHXhY27/61h6Lyv0MCEJDEXazkIuWDpdY0+QF8H2gCBXgtK
	5R3
X-Received: by 2002:a17:903:124f:b0:2a7:cbe3:a6e3 with SMTP id d9443c01a7336-2a8d958bbd9mr11783695ad.2.1769746491667;
        Thu, 29 Jan 2026 20:14:51 -0800 (PST)
Received: from ?IPV6:2408:8239:502:5512:2559:47c:86ee:26cc? ([175.143.94.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b414cc7sm64377665ad.33.2026.01.29.20.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 20:14:51 -0800 (PST)
Message-ID: <df47b1c0-c25e-4501-aaa0-bc73ce1fdc00@gmail.com>
Date: Fri, 30 Jan 2026 12:14:45 +0800
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
Content-Language: en-US
In-Reply-To: <20260130001254.83750-1-loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21231-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 90BBBB7095
X-Rspamd-Action: no action

On 2026/1/30 08:12, Leo Martins wrote:
> On Thu, 29 Jan 2026 11:52:07 +0000 Filipe Manana<fdmanana@kernel.org> wrote:
>> On Tue, Jan 27, 2026 at 8:43 PM Leo Martins<loemra.dev@gmail.com> wrote:
>>> I've been investigating enospcs at Meta and have observed a strange
>>> pattern where filesystems are enospcing with lots of unallocated space
>>> (> 100G). Sample dmesg dump at bottom of message.
>>>
>>> btrfs_insert_delayed_dir_index is attempting to migrate some reservation
>>> from the transaction block reserve and finding it exhausted leading to a
>>> warning and enospc. This is a bug as the reservations are meant to be
>>> worst case. It should be impossible to exhaust the transaction block
>>> reserve.
>>>
>>> Some tracing of affected hosts revealed that there were single
>>> btrfs_search_slot calls that were COWing 100s of times. I was able to
>>> reproduce this behavior locally by creating a very constrained cgroup
>>> and producing a lot of concurrent filesystem operations. Here's the
>>> pattern:
>>>
>>>   1. btrfs_search_slot() begins tree traversal with cow=1
>>>   2. Node at level N needs COW (old generation or WRITTEN flag set)
>>>   3. btrfs_cow_block() allocates new node, updates parent pointer
>>>   4. Traversal continues, but hits a condition requiring restart (e.g., node
>>>      not cached, lock contention, need higher write_lock_level)
>>>   5. btrfs_release_path() releases all locks and references
>>>   6. Memory pressure triggers writeback on the COW'd node
>>>   7. lock_extent_buffer_for_io() clears EXTENT_BUFFER_DIRTY and sets
>>>      BTRFS_HEADER_FLAG_WRITTEN
>>>   8. goto again - traversal restarts from root
>>>   9. Traversal reaches the freshly COW'd node
>>>   10. should_cow_block() sees WRITTEN flag set, returns true
>>>   11. btrfs_cow_block() allocates another new node - same logical position,
>>>       new physical location, new reservation consumed
>>>   12. Steps 4-11 repeat indefinitely under sustained memory pressure
>>>
>>> Note this behavior should be much harder to trigger since Boris's
>>> AS_KERNEL_FILE changes that make it so that extent_buffer pages aren't
>>> accounted for in user cgroups. However, I believe it
>>> would still be an issue under global memory pressure.
>>> Link:https://lore.kernel.org/linux-btrfs/cover.1755812945.git.boris@bur.io/
>>>
>>> This COW amplification breaks the idea that transaction reservations are
>>> worst case as any search slot call could find itself in this COW loop and
>>> exhaust its reservation.
>>>
>>> My proposed solution is to temporarily pin extent buffers for the
>>> lifetime of btrfs_search_slot. This prevents the massive COW
>>> amplification that can be seen during high memory pressure.
>>>
>>> The implementation uses a local xarray to track COW'd buffers for the
>>> duration of the search. The xarray stores extent_buffer pointers without
>>> taking additional references; this is safe because tracked buffers remain
>>> dirty (writeback_blockers prevents the dirty bit from being cleared) and
>>> dirty buffers cannot be reclaimed by memory pressure.
>>>
>>> Synchronization is provided by eb->lock: increments in
>>> btrfs_search_slot_track_cow() occur while holding the write lock, and
>>> the check in lock_extent_buffer_for_io() also holds the write lock via
>>> btrfs_tree_lock(). Decrements don't require eb->lock because
>>> writeback_blockers is atomic and merely indicates "don't write yet".
>>> Once we decrement, we're done and don't care if writeback proceeds
>>> immediately.
>> This seems too complex to me.
>>
>> So this problem is very similar to some idea I had a few years ago but
>> never managed to implement.
>> It was about avoiding unnecessary COW, not for this space reservation
>> exhaustion due to sustained memory pressure, but it would solve it
>> too.
>>
>> The idea was that we do unnecessary COW in cases like this:
>>
>> 1) We COW a path in some tree and we are at transaction N;
>>
>> 2) Writeback happened for the extent buffers in that path while we are
>> in the same transaction, because we reached the 32M limit and some
>> task called btrfs_btree_balance_dirty() or something else triggered
>> writeback of the btree inode;
>>
>> 3) While still at transaction N, we visit the same path to add an item
>> to a leaf, or modify an item, whatever. Because the extent buffers
>> have BTRFS_HEADER_FLAG_WRITTEN, we COW them again (should_cow_block()
>> returns true).
>>
>> So during the lifetime of a transaction we can have a lot of
>> unnecessary COW - we spend more time allocating extents, allocating
>> memory, copying extent buffer data, use more space per transaction,
>> etc.
>>
>> The idea was to not COW when an extent buffer has
>> BTRFS_HEADER_FLAG_WRITTEN set, but only if its generation
>> (btrfs_header_generation(eb)) matches the current transaction.
>> That is safe because there's no committed tree that points to an
>> extent buffer created in the current transaction.
>>
>> Any further modification to the extent buffer must be sure that the
>> EXTENT_BUFFER_DIRTY flag is set, that the eb range is still in the
>> transaction's dirty_pages io tree, etc, so that we don't miss writing
>> the extent buffer to the same location again before the transaction
>> commits the superblocks.
>>
>> Have you considered an approach like this?
> I had not considered this, but it is a great idea.
>
> My first thought is that implementing this could be as simple
> as removing the BTRFS_HEADER_FLAG_WRITTEN check. However, this
> would mess with the assumptions around the log tree. From
> btrfs_sync_log():
After a fast glance and some tests, I found things might not be that 
easy. The problem is not only the log tree.
> /*
>   * IO has been started, blocks of the log tree have WRITTEN flag set
>   * in their headers. new modifications of the log will be written to
>   * new positions. so it's safe to allow log writers to go in.
>   */
>
> ^ Assumes that WRITTEN blocks will be COW'd.
>
> The issue looks like:
>
>   1. fsync A COWs eb
>   2. fsync A lock_extent_buffer_for_io(); sets WRITTEN, unlocks tree
>   3. fsync B does __not__ COW eb and modifies it
>   4. fsync A writes modified eb to disk
>   5. CRASH; the log tree is corrupted
>
> One way to avoid that is to keep the current behavior for the log
> tree, but that leaves the potential for COW amplification...
I tested with a patch like this:
@@ -624,14 +624,18 @@ static inline bool should_cow_block(const struct 
btrfs_trans_handle *trans,
         if (btrfs_header_generation(buf) != trans->transid)
                 return true;

-       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
-               return true;
-
         /* Ensure we can see the FORCE_COW bit. */
         smp_mb__before_atomic();
         if (test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
                 return true;

+       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
+               if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID)
+                       return true;
+               btrfs_mark_buffer_dirty(trans, buf);
+               return false;
+       }
+
         if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)

                 return false;

And get some errors like this:


[  +0.090163] [ T2589] run fstests btrfs/004 at 2026-01-30 11:53:37
[  +0.432352] [T11685] BTRFS: device fsid 
1fb397fc-97a7-44dd-9602-dd38b74bc391 devid 1 transid 8 /dev/loop1 (7:1) 
scanned by mount (11685)
[  +0.000351] [T11685] BTRFS info (device loop1): first mount of 
filesystem 1fb397fc-97a7-44dd-9602-dd38b74bc391
[  +0.000014] [T11685] BTRFS info (device loop1): using crc32c 
(crc32c-lib) checksum algorithm
[  +0.001298] [T11685] BTRFS info (device loop1): checking UUID tree
[  +0.000039] [T11685] BTRFS info (device loop1): enabling ssd optimizations
[  +0.000003] [T11685] BTRFS info (device loop1): turning on async discard
[  +0.000002] [T11685] BTRFS info (device loop1): enabling free space tree
[  +1.051781] [T11703] page: refcount:2 mapcount:0 
mapping:00000000eb6d7caa index:0x2348 pfn:0x1caebf
[  +0.000008] [T11703] memcg:ffff9b3300263cc0
[  +0.000003] [T11703] aops:0xffffffffc0354040 ino:1
[  +0.000024] [T11703] flags: 
0x4e0000000000423e(referenced|uptodate|dirty|lru|workingset|private|writeback|zone=1)
[  +0.000007] [T11703] raw: 4e0000000000423e fffff74a872bb908 
fffff74a84206a88 ffff9b33c6706880
[  +0.000004] [T11703] raw: 0000000000002348 ffff9b334be522d0 
00000002ffffffff ffff9b3300263cc0
[  +0.000002] [T11703] page dumped because: eb page dump
[  +0.000003] [T11703] BTRFS critical (device loop1): corrupt leaf: 
root=5 block=36995072 slot=118 ino=406 file_offset=94208, invalid 
ram_bytes for file extent, have 8660273067269322872, should be aligned 
to 4096
[  +0.000013] [T11703] BTRFS info (device loop1): leaf 36995072 gen 33 
total ptrs 128 free space 2857 owner 5
[  +0.000006] [T11703]     item 0 key (386 DIR_ITEM 238230307) itemoff 
16249 itemsize 34
[  +0.000004] [T11703]         location key (462 1 0) type 2
[  +0.000003] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000003] [T11703]     item 1 key (386 DIR_ITEM 1473745676) itemoff 
16216 itemsize 33
[  +0.000004] [T11703]         location key (376 1 0) type 3
[  +0.000002] [T11703]         transid 30 data_len 0 name_len 3
[  +0.000003] [T11703]     item 2 key (386 DIR_ITEM 2243137595) itemoff 
16182 itemsize 34
[  +0.000004] [T11703]         location key (413 1 0) type 1
[  +0.000002] [T11703]         transid 32 data_len 0 name_len 4
[  +0.000003] [T11703]     item 3 key (386 DIR_ITEM 2980467489) itemoff 
16148 itemsize 34
[  +0.000003] [T11703]         location key (478 1 0) type 1
[  +0.000002] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000003] [T11703]     item 4 key (386 DIR_ITEM 3091124746) itemoff 
16115 itemsize 33
[  +0.000002] [T11703]         location key (474 1 0) type 3
[  +0.000002] [T11703]         transid 33 data_len 0 name_len 3
[  +0.000001] [T11703]     item 5 key (386 DIR_ITEM 4127802504) itemoff 
16082 itemsize 33
[  +0.000003] [T11703]         location key (407 1 0) type 2
[  +0.000001] [T11703]         transid 27 data_len 0 name_len 3
[  +0.000002] [T11703]     item 6 key (386 DIR_INDEX 2) itemoff 16049 
itemsize 33
[  +0.000003] [T11703]         location key (407 1 0) type 2
[  +0.000001] [T11703]         transid 27 data_len 0 name_len 3
[  +0.000002] [T11703]     item 7 key (386 DIR_INDEX 4) itemoff 16016 
itemsize 33
[  +0.000002] [T11703]         location key (376 1 0) type 3
[  +0.000002] [T11703]         transid 30 data_len 0 name_len 3
[  +0.000002] [T11703]     item 8 key (386 DIR_INDEX 5) itemoff 15982 
itemsize 34
[  +0.000002] [T11703]         location key (413 1 0) type 1
[  +0.000002] [T11703]         transid 32 data_len 0 name_len 4
[  +0.000002] [T11703]     item 9 key (386 DIR_INDEX 6) itemoff 15948 
itemsize 34
[  +0.000002] [T11703]         location key (462 1 0) type 2
[  +0.000002] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000001] [T11703]     item 10 key (386 DIR_INDEX 7) itemoff 15915 
itemsize 33
[  +0.000003] [T11703]         location key (474 1 0) type 3
[  +0.000001] [T11703]         transid 33 data_len 0 name_len 3
[  +0.000002] [T11703]     item 11 key (386 DIR_INDEX 8) itemoff 15881 
itemsize 34
[  +0.000002] [T11703]         location key (478 1 0) type 1
[  +0.000002] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000002] [T11703]     item 12 key (387 INODE_ITEM 0) itemoff 15721 
itemsize 160
[  +0.000002] [T11703]         inode generation 25 transid 25 size 0 
nbytes 0
[  +0.000003] [T11703]         block group 0 mode 20444 links 1 uid 0 gid 0
[  +0.000002] [T11703]         rdev 0 sequence 0 flags 0x0
[  +0.000002] [T11703]         atime 1769745218.410248188
[  +0.000002] [T11703]         ctime 1769745218.410248188
[  +0.000002] [T11703]         mtime 1769745218.410248188
[  +0.000002] [T11703]         otime 1769745218.410248188
[  +0.000002] [T11703]     item 13 key (387 INODE_REF 324) itemoff 15708 
itemsize 13
[  +0.000002] [T11703]         index 13 name_len 3
[  +0.000002] [T11703]     item 14 key (389 INODE_ITEM 0) itemoff 15548 
itemsize 160
[  +0.000002] [T11703]         inode generation 25 transid 33 size 
375425 nbytes 8192
[  +0.000003] [T11703]         block group 0 mode 100666 links 1 uid 0 gid 0
[  +0.000002] [T11703]         rdev 0 sequence 4 flags 0x0
[  +0.000001] [T11703]         atime 1769745218.410248188
[  +0.000002] [T11703]         ctime 1769745218.662385845
[  +0.000002] [T11703]         mtime 1769745218.662385845
[  +0.000001] [T11703]         otime 1769745218.410248188
[  +0.000002] [T11703]     item 15 key (389 INODE_REF 334) itemoff 15535 
itemsize 13
[  +0.000002] [T11703]         index 7 name_len 3
[  +0.000002] [T11703]     item 16 key (389 XATTR_ITEM 1939513822) 
itemoff 15435 itemsize 100
[  +0.000003] [T11703]         location key (0 0 0) type 8
[  +0.000002] [T11703]         transid 33 data_len 63 name_len 7
[  +0.000002] [T11703]     item 17 key (389 EXTENT_DATA 368640) itemoff 
15382 itemsize 53
[  +0.000002] [T11703]         generation 31 type 1
[  +0.000002] [T11703]         extent data disk bytenr 17526784 nr 8192
[  +0.000002] [T11703]         extent data offset 0 nr 4096 ram 8192
[  +0.000002] [T11703]         extent compression 0
[  +0.000002] [T11703]     item 18 key (389 EXTENT_DATA 372736) itemoff 
15329 itemsize 53
[  +0.000002] [T11703]         generation 33 type 1
[  +0.000001] [T11703]         extent data disk bytenr 14102528 nr 4096
[  +0.000002] [T11703]         extent data offset 0 nr 4096 ram 4096
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 19 key (389 EXTENT_DATA 1179648) itemoff 
15276 itemsize 53
[  +0.000002] [T11703]         generation 33 type 1
[  +0.000002] [T11703]         extent data disk bytenr 370638848 nr 28672
[  +0.000002] [T11703]         extent data offset 0 nr 28672 ram 28672
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 20 key (390 INODE_ITEM 0) itemoff 15116 
itemsize 160
[  +0.000002] [T11703]         inode generation 25 transid 33 size 0 
nbytes 0
[  +0.000002] [T11703]         block group 0 mode 20444 links 2 uid 0 gid 0
[  +0.000002] [T11703]         rdev 0 sequence 3 flags 0x0
[  +0.000002] [T11703]         atime 1769745218.414620392
[  +0.000002] [T11703]         ctime 1769745218.892384583
[  +0.000001] [T11703]         mtime 1769745218.414620392
[  +0.000002] [T11703]         otime 1769745218.414620392
[  +0.000002] [T11703]     item 21 key (390 INODE_REF 300) itemoff 15103 
itemsize 13
[  +0.000002] [T11703]         index 13 name_len 3
[  +0.000002] [T11703]     item 22 key (390 INODE_REF 327) itemoff 15089 
itemsize 14
[  +0.000002] [T11703]         index 17 name_len 4
[  +0.000001] [T11703]     item 23 key (391 INODE_ITEM 0) itemoff 14929 
itemsize 160
[  +0.000003] [T11703]         inode generation 25 transid 30 size 12 
nbytes 0
[  +0.000002] [T11703]         block group 0 mode 40777 links 1 uid 0 gid 0
[  +0.000002] [T11703]         rdev 0 sequence 3 flags 0x0
[  +0.000001] [T11703]         atime 1769745218.414620392
[  +0.000002] [T11703]         ctime 1769745218.609052805
[  +0.000002] [T11703]         mtime 1769745218.609052805
[  +0.000001] [T11703]         otime 1769745218.414620392
[  +0.000002] [T11703]     item 24 key (391 INODE_REF 369) itemoff 14916 
itemsize 13
[  +0.000002] [T11703]         index 3 name_len 3
[  +0.000002] [T11703]     item 25 key (391 DIR_ITEM 2351632656) itemoff 
14883 itemsize 33
[  +0.000002] [T11703]         location key (430 1 0) type 3
[  +0.000002] [T11703]         transid 30 data_len 0 name_len 3
[  +0.000002] [T11703]     item 26 key (391 DIR_ITEM 3050776180) itemoff 
14850 itemsize 33
[  +0.000002] [T11703]         location key (392 1 0) type 3
[  +0.000002] [T11703]         transid 25 data_len 0 name_len 3
[  +0.000002] [T11703]     item 27 key (391 DIR_INDEX 2) itemoff 14817 
itemsize 33
[  +0.000002] [T11703]         location key (392 1 0) type 3
[  +0.000002] [T11703]         transid 25 data_len 0 name_len 3
[  +0.000002] [T11703]     item 28 key (391 DIR_INDEX 3) itemoff 14784 
itemsize 33
[  +0.000002] [T11703]         location key (430 1 0) type 3
[  +0.000002] [T11703]         transid 30 data_len 0 name_len 3
[  +0.000001] [T11703]     item 29 key (392 INODE_ITEM 0) itemoff 14624 
itemsize 160
[  +0.000003] [T11703]         inode generation 25 transid 25 size 0 
nbytes 0
[  +0.000001] [T11703]         block group 0 mode 20444 links 1 uid 0 gid 0
[  +0.000002] [T11703]         rdev 0 sequence 2 flags 0x0
[  +0.000002] [T11703]         atime 1769745218.425720477
[  +0.000002] [T11703]         ctime 1769745218.429053792
[  +0.000001] [T11703]         mtime 1769745218.425720477
[  +0.000002] [T11703]         otime 1769745218.425720477
[  +0.000002] [T11703]     item 30 key (392 INODE_REF 391) itemoff 14611 
itemsize 13
[  +0.000002] [T11703]         index 2 name_len 3
[  +0.000001] [T11703]     item 31 key (393 INODE_ITEM 0) itemoff 14451 
itemsize 160
[  +0.000003] [T11703]         inode generation 25 transid 25 size 0 
nbytes 0
[  +0.000001] [T11703]         block group 0 mode 20000 links 1 uid 0 gid 0
[  +0.000002] [T11703]         rdev 0 sequence 19 flags 0x0
[  +0.000002] [T11703]         atime 1769745218.429053792
[  +0.000002] [T11703]         ctime 1769745218.429053792
[  +0.000001] [T11703]         mtime 1769745218.429053792
[  +0.000002] [T11703]         otime 1769745218.429053792
[  +0.000002] [T11703]     item 32 key (393 INODE_REF 377) itemoff 14438 
itemsize 13
[  +0.000002] [T11703]         index 4 name_len 3
[  +0.000002] [T11703]     item 33 key (394 INODE_ITEM 0) itemoff 14278 
itemsize 160
[  +0.000023] [T11703]         inode generation 25 transid 29 size 0 
nbytes 0
[  +0.000002] [T11703]         block group 0 mode 20444 links 1 uid 
116392077 gid 49956004
[  +0.000002] [T11703]         rdev 0 sequence 20 flags 0x0
[  +0.000017] [T11703]         atime 1769745218.435720422
[  +0.000005] [T11703]         ctime 1769745218.575719654
[  +0.000002] [T11703]         mtime 1769745218.435720422
[  +0.000002] [T11703]         otime 1769745218.435720422
[  +0.000002] [T11703]     item 34 key (394 INODE_REF 336) itemoff 14265 
itemsize 13
[  +0.000003] [T11703]         index 11 name_len 3
[  +0.000002] [T11703]     item 35 key (395 INODE_ITEM 0) itemoff 14105 
itemsize 160
[  +0.000003] [T11703]         inode generation 25 transid 33 size 14 
nbytes 0
[  +0.000003] [T11703]         block group 0 mode 40777 links 1 uid 0 gid 0
[  +0.000002] [T11703]         rdev 0 sequence 31 flags 0x0
[  +0.000002] [T11703]         atime 1769745218.436974912
[  +0.000002] [T11703]         ctime 1769745218.892384583
[  +0.000002] [T11703]         mtime 1769745218.892384583
[  +0.000001] [T11703]         otime 1769745218.436974912
[  +0.000002] [T11703]     item 36 key (395 INODE_REF 300) itemoff 14092 
itemsize 13
[  +0.000003] [T11703]         index 14 name_len 3
[  +0.000002] [T11703]     item 37 key (395 DIR_ITEM 1909090157) itemoff 
14059 itemsize 33
[  +0.000002] [T11703]         location key (410 1 0) type 1
[  +0.000002] [T11703]         transid 27 data_len 0 name_len 3
[  +0.000002] [T11703]     item 38 key (395 DIR_ITEM 2010649400) itemoff 
14025 itemsize 34
[  +0.000003] [T11703]         location key (448 1 0) type 1
[  +0.000002] [T11703]         transid 32 data_len 0 name_len 4
[  +0.000001] [T11703]     item 39 key (395 DIR_INDEX 3) itemoff 13992 
itemsize 33
[  +0.000003] [T11703]         location key (410 1 0) type 1
[  +0.000001] [T11703]         transid 27 data_len 0 name_len 3
[  +0.000002] [T11703]     item 40 key (395 DIR_INDEX 7) itemoff 13958 
itemsize 34
[  +0.000002] [T11703]         location key (448 1 0) type 1
[  +0.000002] [T11703]         transid 32 data_len 0 name_len 4
[  +0.000002] [T11703]     item 41 key (396 INODE_ITEM 0) itemoff 13798 
itemsize 160
[  +0.000002] [T11703]         inode generation 25 transid 33 size 
4498598 nbytes 368640
[  +0.000003] [T11703]         block group 0 mode 100666 links 1 uid 0 gid 0
[  +0.000002] [T11703]         rdev 0 sequence 43 flags 0x0
[  +0.000001] [T11703]         atime 1769745218.862384748
[  +0.000002] [T11703]         ctime 1769745218.872384693
[  +0.000002] [T11703]         mtime 1769745218.872384693
[  +0.000002] [T11703]         otime 1769745218.436974912
[  +0.000003] [T11703]     item 42 key (396 INODE_REF 334) itemoff 13785 
itemsize 13
[  +0.000003] [T11703]         index 8 name_len 3
[  +0.000002] [T11703]     item 43 key (396 EXTENT_DATA 1015808) itemoff 
13732 itemsize 53
[  +0.000004] [T11703]         generation 26 type 1
[  +0.000002] [T11703]         extent data disk bytenr 20709376 nr 4096
[  +0.000003] [T11703]         extent data offset 0 nr 4096 ram 4096
[  +0.000002] [T11703]         extent compression 0
[  +0.000002] [T11703]     item 44 key (396 EXTENT_DATA 1376256) itemoff 
13679 itemsize 53
[  +0.000003] [T11703]         generation 27 type 1
[  +0.000002] [T11703]         extent data disk bytenr 362196992 nr 131072
[  +0.000003] [T11703]         extent data offset 0 nr 73728 ram 131072
[  +0.000002] [T11703]         extent compression 0
[  +0.000002] [T11703]     item 45 key (396 EXTENT_DATA 1449984) itemoff 
13626 itemsize 53
[  +0.000003] [T11703]         generation 29 type 1
[  +0.000003] [T11703]         extent data disk bytenr 356175872 nr 114688
[  +0.000002] [T11703]         extent data offset 0 nr 114688 ram 114688
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 46 key (396 EXTENT_DATA 1703936) itemoff 
13573 itemsize 53
[  +0.000004] [T11703]         generation 27 type 1
[  +0.000002] [T11703]         extent data disk bytenr 361512960 nr 102400
[  +0.000002] [T11703]         extent data offset 0 nr 102400 ram 102400
[  +0.000002] [T11703]         extent compression 0
[  +0.000002] [T11703]     item 47 key (396 EXTENT_DATA 2301952) itemoff 
13520 itemsize 53
[  +0.000003] [T11703]         generation 31 type 1
[  +0.000002] [T11703]         extent data disk bytenr 15396864 nr 32768
[  +0.000003] [T11703]         extent data offset 0 nr 32768 ram 32768
[  +0.000002] [T11703]         extent compression 0
[  +0.000002] [T11703]     item 48 key (396 EXTENT_DATA 3616768) itemoff 
13467 itemsize 53
[  +0.000002] [T11703]         generation 31 type 1
[  +0.000002] [T11703]         extent data disk bytenr 17121280 nr 49152
[  +0.000001] [T11703]         extent data offset 0 nr 40960 ram 49152
[  +0.000002] [T11703]         extent compression 0
[  +0.000002] [T11703]     item 49 key (396 EXTENT_DATA 4497408) itemoff 
13414 itemsize 53
[  +0.000002] [T11703]         generation 33 type 1
[  +0.000001] [T11703]         extent data disk bytenr 15429632 nr 4096
[  +0.000002] [T11703]         extent data offset 0 nr 4096 ram 4096
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 50 key (396 EXTENT_DATA 4562944) itemoff 
13361 itemsize 53
[  +0.000002] [T11703]         generation 33 type 1
[  +0.000002] [T11703]         extent data disk bytenr 16396288 nr 8192
[  +0.000001] [T11703]         extent data offset 0 nr 8192 ram 8192
[  +0.000002] [T11703]         extent compression 0
[  +0.000002] [T11703]     item 51 key (397 INODE_ITEM 0) itemoff 13201 
itemsize 160
[  +0.000002] [T11703]         inode generation 25 transid 32 size 
3371008 nbytes 757760
[  +0.000002] [T11703]         block group 0 mode 100666 links 1 uid 0 gid 0
[  +0.000002] [T11703]         rdev 0 sequence 40 flags 0x10
[  +0.000002] [T11703]         atime 1769745218.436974912
[  +0.000002] [T11703]         ctime 1769745218.732385461
[  +0.000001] [T11703]         mtime 1769745218.732385461
[  +0.000002] [T11703]         otime 1769745218.436974912
[  +0.000002] [T11703]     item 52 key (397 INODE_REF 344) itemoff 13188 
itemsize 13
[  +0.000002] [T11703]         index 5 name_len 3
[  +0.000002] [T11703]     item 53 key (397 EXTENT_DATA 204800) itemoff 
13135 itemsize 53
[  +0.000002] [T11703]         generation 14 type 2
[  +0.000002] [T11703]         extent data disk bytenr 135266304 nr 954368
[  +0.000001] [T11703]         extent data offset 421888 nr 8192 ram 954368
[  +0.000002] [T11703]         extent compression 0
[  +0.000002] [T11703]     item 54 key (397 EXTENT_DATA 253952) itemoff 
13082 itemsize 53
[  +0.000002] [T11703]         generation 14 type 2
[  +0.000001] [T11703]         extent data disk bytenr 135266304 nr 954368
[  +0.000002] [T11703]         extent data offset 471040 nr 28672 ram 954368
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 55 key (397 EXTENT_DATA 507904) itemoff 
13029 itemsize 53
[  +0.000003] [T11703]         generation 31 type 1
[  +0.000001] [T11703]         extent data disk bytenr 17121280 nr 49152
[  +0.000002] [T11703]         extent data offset 0 nr 40960 ram 49152
[  +0.000001] [T11703]         extent compression 0
[  +0.000002] [T11703]     item 56 key (397 EXTENT_DATA 643072) itemoff 
12976 itemsize 53
[  +0.000002] [T11703]         generation 27 type 1
[  +0.000002] [T11703]         extent data disk bytenr 362475520 nr 77824
[  +0.000001] [T11703]         extent data offset 0 nr 57344 ram 77824
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 57 key (397 EXTENT_DATA 700416) itemoff 
12923 itemsize 53
[  +0.000003] [T11703]         generation 32 type 1
[  +0.000001] [T11703]         extent data disk bytenr 353513472 nr 16384
[  +0.000002] [T11703]         extent data offset 0 nr 16384 ram 16384
[  +0.000001] [T11703]         extent compression 0
[  +0.000002] [T11703]     item 58 key (397 EXTENT_DATA 716800) itemoff 
12870 itemsize 53
[  +0.000002] [T11703]         generation 27 type 1
[  +0.000002] [T11703]         extent data disk bytenr 362475520 nr 77824
[  +0.000001] [T11703]         extent data offset 73728 nr 4096 ram 77824
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 59 key (397 EXTENT_DATA 720896) itemoff 
12817 itemsize 53
[  +0.000003] [T11703]         generation 27 type 1
[  +0.000001] [T11703]         extent data disk bytenr 19050496 nr 4096
[  +0.000002] [T11703]         extent data offset 0 nr 4096 ram 4096
[  +0.000001] [T11703]         extent compression 0
[  +0.000002] [T11703]     item 60 key (397 EXTENT_DATA 901120) itemoff 
12764 itemsize 53
[  +0.000002] [T11703]         generation 30 type 1
[  +0.000001] [T11703]         extent data disk bytenr 364146688 nr 28672
[  +0.000001] [T11703]         extent data offset 0 nr 28672 ram 28672
[  +0.000001] [T11703]         extent compression 0
[  +0.000002] [T11703]     item 61 key (397 EXTENT_DATA 1875968) itemoff 
12711 itemsize 53
[  +0.000001] [T11703]         generation 24 type 1
[  +0.000002] [T11703]         extent data disk bytenr 357761024 nr 73728
[  +0.000001] [T11703]         extent data offset 40960 nr 28672 ram 73728
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 62 key (397 EXTENT_DATA 1904640) itemoff 
12658 itemsize 53
[  +0.000002] [T11703]         generation 27 type 1
[  +0.000001] [T11703]         extent data disk bytenr 355385344 nr 4096
[  +0.000002] [T11703]         extent data offset 0 nr 4096 ram 4096
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 63 key (397 EXTENT_DATA 2244608) itemoff 
12605 itemsize 53
[  +0.000002] [T11703]         generation 33 type 1
[  +0.000001] [T11703]         extent data disk bytenr 366755840 nr 102400
[  +0.000001] [T11703]         extent data offset 0 nr 102400 ram 102400
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 64 key (397 EXTENT_DATA 2990080) itemoff 
12552 itemsize 53
[  +0.000001] [T11703]         generation 32 type 2
[  +0.000001] [T11703]         extent data disk bytenr 153870336 nr 585728
[  +0.000002] [T11703]         extent data offset 16384 nr 172032 ram 585728
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 65 key (397 EXTENT_DATA 3162112) itemoff 
12499 itemsize 53
[  +0.000002] [T11703]         generation 32 type 1
[  +0.000001] [T11703]         extent data disk bytenr 153870336 nr 585728
[  +0.000001] [T11703]         extent data offset 188416 nr 110592 ram 
585728
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 66 key (397 EXTENT_DATA 3272704) itemoff 
12446 itemsize 53
[  +0.000002] [T11703]         generation 33 type 1
[  +0.000001] [T11703]         extent data disk bytenr 369012736 nr 4096
[  +0.000001] [T11703]         extent data offset 0 nr 4096 ram 4096
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 67 key (397 EXTENT_DATA 3276800) itemoff 
12393 itemsize 53
[  +0.000001] [T11703]         generation 33 type 2
[  +0.000001] [T11703]         extent data disk bytenr 161648640 nr 643072
[  +0.000002] [T11703]         extent data offset 0 nr 643072 ram 643072
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 68 key (398 INODE_ITEM 0) itemoff 12233 
itemsize 160
[  +0.000002] [T11703]         inode generation 25 transid 32 size 
1390453 nbytes 172032
[  +0.000001] [T11703]         block group 0 mode 100666 links 1 uid 0 gid 0
[  +0.000002] [T11703]         rdev 0 sequence 30 flags 0x0
[  +0.000001] [T11703]         atime 1769745218.436974912
[  +0.000002] [T11703]         ctime 1769745218.522719547
[  +0.000001] [T11703]         mtime 1769745218.522719547
[  +0.000001] [T11703]         otime 1769745218.436974912
[  +0.000001] [T11703]     item 69 key (398 INODE_REF 369) itemoff 12220 
itemsize 13
[  +0.000002] [T11703]         index 4 name_len 3
[  +0.000001] [T11703]     item 70 key (398 EXTENT_DATA 40960) itemoff 
12167 itemsize 53
[  +0.000002] [T11703]         generation 14 type 2
[  +0.000001] [T11703]         extent data disk bytenr 135266304 nr 954368
[  +0.000001] [T11703]         extent data offset 421888 nr 8192 ram 954368
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 71 key (398 EXTENT_DATA 90112) itemoff 
12114 itemsize 53
[  +0.000002] [T11703]         generation 14 type 2
[  +0.000001] [T11703]         extent data disk bytenr 135266304 nr 954368
[  +0.000001] [T11703]         extent data offset 471040 nr 28672 ram 954368
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 72 key (398 EXTENT_DATA 344064) itemoff 
12061 itemsize 53
[  +0.000002] [T11703]         generation 14 type 2
[  +0.000001] [T11703]         extent data disk bytenr 135266304 nr 954368
[  +0.000001] [T11703]         extent data offset 421888 nr 8192 ram 954368
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 73 key (398 EXTENT_DATA 393216) itemoff 
12008 itemsize 53
[  +0.000002] [T11703]         generation 14 type 2
[  +0.000001] [T11703]         extent data disk bytenr 135266304 nr 954368
[  +0.000001] [T11703]         extent data offset 471040 nr 28672 ram 954368
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 74 key (398 EXTENT_DATA 753664) itemoff 
11955 itemsize 53
[  +0.000002] [T11703]         generation 27 type 1
[  +0.000001] [T11703]         extent data disk bytenr 21372928 nr 16384
[  +0.000001] [T11703]         extent data offset 0 nr 16384 ram 16384
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 75 key (398 EXTENT_DATA 806912) itemoff 
11902 itemsize 53
[  +0.000002] [T11703]         generation 33 type 1
[  +0.000001] [T11703]         extent data disk bytenr 366972928 nr 102400
[  +0.000001] [T11703]         extent data offset 0 nr 102400 ram 102400
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 76 key (398 EXTENT_DATA 962560) itemoff 
11849 itemsize 53
[  +0.000001] [T11703]         generation 31 type 1
[  +0.000001] [T11703]         extent data disk bytenr 17121280 nr 49152
[  +0.000002] [T11703]         extent data offset 0 nr 40960 ram 49152
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 77 key (398 EXTENT_DATA 1343488) itemoff 
11796 itemsize 53
[  +0.000002] [T11703]         generation 31 type 1
[  +0.000001] [T11703]         extent data disk bytenr 17121280 nr 49152
[  +0.000001] [T11703]         extent data offset 8192 nr 32768 ram 49152
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 78 key (398 EXTENT_DATA 1388544) itemoff 
11743 itemsize 53
[  +0.000002] [T11703]         generation 33 type 1
[  +0.000001] [T11703]         extent data disk bytenr 14479360 nr 4096
[  +0.000001] [T11703]         extent data offset 0 nr 4096 ram 4096
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 79 key (399 INODE_ITEM 0) itemoff 11583 
itemsize 160
[  +0.000001] [T11703]         inode generation 25 transid 32 size 
585093 nbytes 339968
[  +0.000002] [T11703]         block group 0 mode 100666 links 1 uid 0 gid 0
[  +0.000001] [T11703]         rdev 0 sequence 31 flags 0x10
[  +0.000001] [T11703]         atime 1769745218.552386449
[  +0.000002] [T11703]         ctime 1769745218.649404376
[  +0.000001] [T11703]         mtime 1769745218.649404376
[  +0.000001] [T11703]         otime 1769745218.438593902
[  +0.000002] [T11703]     item 80 key (399 INODE_REF 297) itemoff 11570 
itemsize 13
[  +0.000001] [T11703]         index 14 name_len 3
[  +0.000002] [T11703]     item 81 key (399 EXTENT_DATA 49152) itemoff 
11517 itemsize 53
[  +0.000001] [T11703]         generation 14 type 2
[  +0.000001] [T11703]         extent data disk bytenr 135266304 nr 954368
[  +0.000002] [T11703]         extent data offset 421888 nr 8192 ram 954368
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 82 key (399 EXTENT_DATA 98304) itemoff 
11464 itemsize 53
[  +0.000002] [T11703]         generation 14 type 2
[  +0.000001] [T11703]         extent data disk bytenr 135266304 nr 954368
[  +0.000001] [T11703]         extent data offset 471040 nr 28672 ram 954368
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 83 key (399 EXTENT_DATA 163840) itemoff 
11411 itemsize 53
[  +0.000002] [T11703]         generation 27 type 1
[  +0.000001] [T11703]         extent data disk bytenr 362151936 nr 45056
[  +0.000001] [T11703]         extent data offset 0 nr 45056 ram 45056
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 84 key (399 EXTENT_DATA 229376) itemoff 
11358 itemsize 53
[  +0.000002] [T11703]         generation 30 type 1
[  +0.000001] [T11703]         extent data disk bytenr 363864064 nr 98304
[  +0.000001] [T11703]         extent data offset 0 nr 98304 ram 98304
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 85 key (399 EXTENT_DATA 335872) itemoff 
11305 itemsize 53
[  +0.000001] [T11703]         generation 25 type 2
[  +0.000001] [T11703]         extent data disk bytenr 359723008 nr 94208
[  +0.000002] [T11703]         extent data offset 0 nr 4096 ram 94208
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 86 key (399 EXTENT_DATA 344064) itemoff 
11252 itemsize 53
[  +0.000002] [T11703]         generation 33 type 1
[  +0.000001] [T11703]         extent data disk bytenr 14061568 nr 4096
[  +0.000001] [T11703]         extent data offset 0 nr 4096 ram 4096
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 87 key (399 EXTENT_DATA 356352) itemoff 
11199 itemsize 53
[  +0.000002] [T11703]         generation 15 type 2
[  +0.000001] [T11703]         extent data disk bytenr 138276864 nr 282624
[  +0.000001] [T11703]         extent data offset 69632 nr 16384 ram 282624
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 88 key (399 EXTENT_DATA 479232) itemoff 
11146 itemsize 53
[  +0.000002] [T11703]         generation 31 type 1
[  +0.000001] [T11703]         extent data disk bytenr 17408000 nr 106496
[  +0.000001] [T11703]         extent data offset 0 nr 102400 ram 106496
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 89 key (399 EXTENT_DATA 581632) itemoff 
11093 itemsize 53
[  +0.000001] [T11703]         generation 33 type 1
[  +0.000002] [T11703]         extent data disk bytenr 13647872 nr 4096
[  +0.000001] [T11703]         extent data offset 0 nr 4096 ram 4096
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 90 key (399 EXTENT_DATA 1445888) itemoff 
11040 itemsize 53
[  +0.000002] [T11703]         generation 33 type 1
[  +0.000001] [T11703]         extent data disk bytenr 21803008 nr 32768
[  +0.000002] [T11703]         extent data offset 0 nr 28672 ram 32768
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 91 key (399 EXTENT_DATA 1474560) itemoff 
10987 itemsize 53
[  +0.000002] [T11703]         generation 33 type 1
[  +0.000001] [T11703]         extent data disk bytenr 13877248 nr 4096
[  +0.000001] [T11703]         extent data offset 0 nr 4096 ram 4096
[  +0.000001] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 92 key (399 EXTENT_DATA 1892352) itemoff 
10934 itemsize 53
[  +0.000002] [T11703]         generation 33 type 1
[  +0.000001] [T11703]         extent data disk bytenr 369930240 nr 65536
[  +0.000001] [T11703]         extent data offset 0 nr 65536 ram 65536
[  +0.000002] [T11703]         extent compression 0
[  +0.000001] [T11703]     item 93 key (400 INODE_ITEM 0) itemoff 10774 
itemsize 160
[  +0.000001] [T11703]         inode generation 25 transid 30 size 0 
nbytes 0
[  +0.000002] [T11703]         block group 0 mode 20444 links 1 uid 0 gid 0
[  +0.000001] [T11703]         rdev 0 sequence 23 flags 0x0
[  +0.000002] [T11703]         atime 1769745218.439782042
[  +0.000001] [T11703]         ctime 1769745218.632386010
[  +0.000001] [T11703]         mtime 1769745218.439782042
[  +0.000001] [T11703]         otime 1769745218.439782042
[  +0.000002] [T11703]     item 94 key (400 INODE_REF 272) itemoff 10761 
itemsize 13
[  +0.000001] [T11703]         index 44 name_len 3
[  +0.000002] [T11703]     item 95 key (401 INODE_ITEM 0) itemoff 10601 
itemsize 160
[  +0.000001] [T11703]         inode generation 25 transid 33 size 14 
nbytes 0
[  +0.000002] [T11703]         block group 0 mode 40777 links 1 uid 0 gid 0
[  +0.000001] [T11703]         rdev 0 sequence 22 flags 0x0
[  +0.000001] [T11703]         atime 1769745218.444837643
[  +0.000002] [T11703]         ctime 1769745218.839051542
[  +0.000001] [T11703]         mtime 1769745218.839051542
[  +0.000001] [T11703]         otime 1769745218.444837643
[  +0.000002] [T11703]     item 96 key (401 INODE_REF 319) itemoff 10588 
itemsize 13
[  +0.000001] [T11703]         index 10 name_len 3
[  +0.000001] [T11703]     item 97 key (401 DIR_ITEM 1191232959) itemoff 
10554 itemsize 34
[  +0.000002] [T11703]         location key (459 1 0) type 3
[  +0.000002] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000001] [T11703]     item 98 key (401 DIR_ITEM 3224377935) itemoff 
10521 itemsize 33
[  +0.000002] [T11703]         location key (429 1 0) type 1
[  +0.000001] [T11703]         transid 30 data_len 0 name_len 3
[  +0.000001] [T11703]     item 99 key (401 DIR_INDEX 2) itemoff 10488 
itemsize 33
[  +0.000002] [T11703]         location key (429 1 0) type 1
[  +0.000001] [T11703]         transid 30 data_len 0 name_len 3
[  +0.000002] [T11703]     item 100 key (401 DIR_INDEX 3) itemoff 10454 
itemsize 34
[  +0.000001] [T11703]         location key (459 1 0) type 3
[  +0.000002] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000001] [T11703]     item 101 key (402 INODE_ITEM 0) itemoff 10294 
itemsize 160
[  +0.000002] [T11703]         inode generation 25 transid 30 size 0 
nbytes 0
[  +0.000001] [T11703]         block group 0 mode 20000 links 1 uid 10 
gid 25
[  +0.000002] [T11703]         rdev 0 sequence 20 flags 0x0
[  +0.000001] [T11703]         atime 1769745218.446861225
[  +0.000001] [T11703]         ctime 1769745218.609052805
[  +0.000002] [T11703]         mtime 1769745218.446861225
[  +0.000001] [T11703]         otime 1769745218.446861225
[  +0.000001] [T11703]     item 102 key (402 INODE_REF 336) itemoff 
10281 itemsize 13
[  +0.000002] [T11703]         index 12 name_len 3
[  +0.000001] [T11703]     item 103 key (403 INODE_ITEM 0) itemoff 10121 
itemsize 160
[  +0.000002] [T11703]         inode generation 25 transid 33 size 48 
nbytes 0
[  +0.000001] [T11703]         block group 0 mode 40777 links 1 uid 0 gid 0
[  +0.000002] [T11703]         rdev 0 sequence 40 flags 0x0
[  +0.000001] [T11703]         atime 1769745218.446861225
[  +0.000001] [T11703]         ctime 1769745218.802385077
[  +0.000001] [T11703]         mtime 1769745218.802385077
[  +0.000002] [T11703]         otime 1769745218.446861225
[  +0.000001] [T11703]     item 104 key (403 INODE_REF 335) itemoff 
10108 itemsize 13
[  +0.000002] [T11703]         index 8 name_len 3
[  +0.000001] [T11703]     item 105 key (403 DIR_ITEM 383218927) itemoff 
10074 itemsize 34
[  +0.000002] [T11703]         location key (299 1 0) type 3
[  +0.000001] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000001] [T11703]     item 106 key (403 DIR_ITEM 445930716) itemoff 
10041 itemsize 33
[  +0.000002] [T11703]         location key (287 1 0) type 3
[  +0.000001] [T11703]         transid 30 data_len 0 name_len 3
[  +0.000002] [T11703]     item 107 key (403 DIR_ITEM 1238590424) 
itemoff 10008 itemsize 33
[  +0.000001] [T11703]         location key (418 1 0) type 2
[  +0.000002] [T11703]         transid 27 data_len 0 name_len 3
[  +0.000001] [T11703]     item 108 key (403 DIR_ITEM 1779809903) 
itemoff 9974 itemsize 34
[  +0.000002] [T11703]         location key (486 1 0) type 2
[  +0.000001] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000001] [T11703]     item 109 key (403 DIR_ITEM 1827976929) 
itemoff 9941 itemsize 33
[  +0.000002] [T11703]         location key (263 1 0) type 3
[  +0.000002] [T11703]         transid 30 data_len 0 name_len 3
[  +0.000001] [T11703]     item 110 key (403 DIR_ITEM 2397436283) 
itemoff 9907 itemsize 34
[  +0.000002] [T11703]         location key (458 1 0) type 7
[  +0.000001] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000001] [T11703]     item 111 key (403 DIR_ITEM 2479530324) 
itemoff 9873 itemsize 34
[  +0.000002] [T11703]         location key (457 1 0) type 3
[  +0.000001] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000001] [T11703]     item 112 key (403 DIR_ITEM 3110495684) 
itemoff 9839 itemsize 34
[  +0.000002] [T11703]         location key (466 1 0) type 3
[  +0.000001] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000002] [T11703]     item 113 key (403 DIR_ITEM 3884400930) 
itemoff 9806 itemsize 33
[  +0.000001] [T11703]         location key (416 1 0) type 1
[  +0.000002] [T11703]         transid 27 data_len 0 name_len 3
[  +0.000001] [T11703]     item 114 key (403 DIR_INDEX 4) itemoff 9773 
itemsize 33
[  +0.000002] [T11703]         location key (416 1 0) type 1
[  +0.000001] [T11703]         transid 27 data_len 0 name_len 3
[  +0.000001] [T11703]     item 115 key (403 DIR_INDEX 5) itemoff 9740 
itemsize 33
[  +0.000002] [T11703]         location key (418 1 0) type 2
[  +0.000001] [T11703]         transid 27 data_len 0 name_len 3
[  +0.000002] [T11703]     item 116 key (403 DIR_INDEX 7) itemoff 9707 
itemsize 33
[  +0.000001] [T11703]         location key (287 1 0) type 3
[  +0.000002] [T11703]         transid 30 data_len 0 name_len 3
[  +0.000001] [T11703]     item 117 key (403 DIR_INDEX 8) itemoff 9674 
itemsize 33
[  +0.000002] [T11703]         location key (263 1 0) type 3
[  +0.000001] [T11703]         transid 30 data_len 0 name_len 3
[  +0.000001] [T11703]     item 118 key (403 DIR_INDEX 10) itemoff 9640 
itemsize 34
[  +0.000002] [T11703]         location key (299 1 0) type 3
[  +0.000001] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000002] [T11703]     item 119 key (403 DIR_INDEX 11) itemoff 9606 
itemsize 34
[  +0.000001] [T11703]         location key (457 1 0) type 3
[  +0.000002] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000001] [T11703]     item 120 key (403 DIR_INDEX 12) itemoff 9572 
itemsize 34
[  +0.000002] [T11703]         location key (458 1 0) type 7
[  +0.000001] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000001] [T11703]     item 121 key (404 INODE_ITEM 0) itemoff 9412 
itemsize 160
[  +0.000002] [T11703]         inode generation 27 transid 32 size 3080 
nbytes 3080
[  +0.000001] [T11703]         block group 0 mode 120777 links 1 uid 0 gid 0
[  +0.000002] [T11703]         rdev 0 sequence 21 flags 0x0
[  +0.000001] [T11703]         atime 1769745218.505720038
[  +0.000001] [T11703]         ctime 1769745218.754448742
[  +0.000002] [T11703]         mtime 1769745218.505720038
[  +0.000001] [T11703]         otime 1769745218.505720038
[  +0.000001] [T11703]     item 122 key (404 INODE_REF 315) itemoff 9399 
itemsize 13
[  +0.000002] [T11703]         index 19 name_len 3
[  +0.000001] [T11703]     item 123 key (404 EXTENT_DATA 0) itemoff 6298 
itemsize 3101
[  +0.000002] [T11703]         generation 27 type 0
[  +0.000001] [T11703]         inline extent data size 3080 ram_bytes 
3080 compression 0
[  +0.000002] [T11703]     item 124 key (405 INODE_ITEM 0) itemoff 6138 
itemsize 160
[  +0.000001] [T11703]         inode generation 27 transid 30 size 20 
nbytes 0
[  +0.000002] [T11703]         block group 0 mode 40777 links 1 uid 31 
gid 901
[  +0.000002] [T11703]         rdev 0 sequence 26 flags 0x0
[  +0.000001] [T11703]         atime 1769745218.505720038
[  +0.000001] [T11703]         ctime 1769745218.662385845
[  +0.000001] [T11703]         mtime 1769745218.662385845
[  +0.000001] [T11703]         otime 1769745218.505720038
[  +0.000002] [T11703]     item 125 key (405 INODE_REF 327) itemoff 6125 
itemsize 13
[  +0.000001] [T11703]         index 12 name_len 3
[  +0.000002] [T11703]     item 126 key (405 DIR_ITEM 695610317) itemoff 
6091 itemsize 34
[  +0.000002] [T11703]         location key (435 1 0) type 2
[  +0.000001] [T11703]         transid 30 data_len 0 name_len 4
[  +0.000001] [T11703]     item 127 key (405 DIR_ITEM 828387202) itemoff 
6057 itemsize 34
[  +0.000002] [T11703]         location key (479 1 0) type 3
[  +0.000001] [T11703]         transid 33 data_len 0 name_len 4
[  +0.000002] [T11703] BTRFS error (device loop1): block=36995072 write 
time tree block corruption detected
[  +0.003429] [T11703] BTRFS: error (device loop1) in 
btrfs_commit_transaction:2555: errno=-5 IO failure (Error while writing 
out transaction)
[  +0.000007] [T11703] BTRFS info (device loop1 state E): forced readonly
[  +0.000002] [T11703] BTRFS warning (device loop1 state E): Skipping 
commit of aborted transaction.
[  +0.000002] [T11703] BTRFS error (device loop1 state EA): Transaction 
aborted (error -5)
[  +0.000003] [T11703] BTRFS: error (device loop1 state EA) in 
cleanup_transaction:2037: errno=-5 IO failure

The reported 406 inode is even not in the printed leaf. It seems like a 
data race maybe caused by:

We unlock the eb after setting the WRITTEN flag during write back, and 
the eb should not get modified since then because all future writes will 
use the cowed eb. However, with the WRITTEN flag check removed in 
should_cow_block, we might write to the eb with WRITTEN flag set which 
might be under io.

To fix this, we need to check the DIRTY flag again to prevent writing a 
eb which has some new data written, and lock the eb before we really 
doing io related things. I'm not farmilar with io related code so please 
correct me if I got anything wrong.

Thanks,

Sun Yangkai


