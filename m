Return-Path: <linux-btrfs+bounces-21243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOTYFrbTfGlbOwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21243-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 16:52:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F80BC3E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 16:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34C333027B79
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 15:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2E8342CBB;
	Fri, 30 Jan 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjyIWNtR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067D340A79
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788247; cv=none; b=mtMuOvp4jfCb5092TiI/ld+18zNObLJbjRPkA7kkz6UddeC2vF11Wsq57SHyTAH3ozsNGmIswzPun8JcVUY5I7HPdglVCMu4xIBdZTlLIlQhccME01lROKjDBEjDvmtkHM73XasZYu+JfPFonDEKj83KOgTawul2NLBYLKu0qRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788247; c=relaxed/simple;
	bh=52IiIpAT1iK8bMmlCn0Oovvir+iGTwlD+JuHOhsSZGM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I45n5Dzgy2nbSizxBniN/qZZcPeIxzs/+FuBtamRp80Pu8+uYph975W5QHIiqx29qgk/KI7GyPZoQBPq2poME2xSl5d4DGU9N7wSXstepl6qORRy/ZzWvjybR/t7V0ubo8ROXOr4km9eqwMI86OE9KDYEa9TS9UrTGn1xsxz0xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjyIWNtR; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7940d54c124so518227b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 07:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769788244; x=1770393044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ad4CzRgpnX6I6nP1bKRuc989t+Be+qHECDMhveg9vgM=;
        b=WjyIWNtRNSPb4FkvSiC7aZkANJpj7WxKlsVWYSNXbYVJTH9Q9Lt4We0TN31opXlaBM
         ++6DjgkTfkWLpjZRgZpjdzMLrbIaZXfoxswsQPBxsv0KtblD+mRjAN5vgpQ92DmkF7FD
         W9ypU8luwa46SS8Ca32DRxfMuL5yfe/EOls8JGagzQbUMpqv45LhHjYkR/K3189yVAk1
         8wncm3WgIkkpMnx8Hir+kTQZvq9kRcppfp4cihMANA7KD8IF9Ns96Rw9rf5b7P2v1aqc
         YVBUulPxQjIqtAx8/j7i7PH2ycpm7a9CbL3yHA0mUZ2rVa4D/gH5GMV31lMopRYZsfZs
         mr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788244; x=1770393044;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad4CzRgpnX6I6nP1bKRuc989t+Be+qHECDMhveg9vgM=;
        b=M1qMjpjkPsZrgiQNhiHVU4UIzqUWo+4ZmgKwZ9WEXz5kufLEj37TqNI6zu+kbdBNHI
         buv33TkN2unOLoNV6z/4jO7P4FXn1s84wsxrm6UA3VmwA/m1pNKJnrddZXL0Zesaq7D2
         wbaykLyU/ccfvRUJfEI/JYBuFHihzvjyQAa4XuT1y5kdQiZTu2xSREwWaUBhIjO9uapB
         Od9JLvpk8UGnRGN9riFtII5hX/3OtofQJVyYEq2vpgBoW8lzNugCaM6IUsjbAcKVN6z2
         eGUwFySh99wYVKbejUm+qJ6ID7+hIhdERMegMpQvPrytQHOuM3CUK5R7dsz+qQ2I2plE
         /6qg==
X-Gm-Message-State: AOJu0YxjI5QYc2TNkMlsVBDqNN8KF8/Vm/M0HsRH6cc1b+YMEWBfOvC1
	KrcYPTrpZLCF3kjLZ2d8x9liqcbNDRXHwjOHoC73Sc6oMyZWOeW6p1S0
X-Gm-Gg: AZuq6aJEEqlTRSFLl1H/KQHqQe+Nbje7PkbWvOqEbPrgKM0PevFHsGN9TwsN9iZsVsh
	7ImAG/Ng5E4bgXEsN5JNeiBLhZ3PHV+E1xJBifAfxuW2VFARIYJvDLX8yT2zLC7pF5di4k1F0Kq
	M+nJhoOeJWCkECtddqPy6xrnJmfN64CJd8YfhTklWkHbO24sZXMNRSw8LvVTm5vLrPT5fxYCrES
	HJe1l3btcSGslDOPkSgsE9vJgaA75+pfVC6kWqdxNnWA/HO3co9Q2UALB9XI0DKuNX/ThGfk5Yd
	iAv4pHJKWcG9iNQ3xZi7iWaZsW267XxcTpWp60dJGFAmite6pBRJ9Y4e4PDocH3+Kt4HkC0TG30
	7z8Vjj/Jn4wNpTmubyEzkwSaI5TOKkZjhXbobl6i6+qd/AZGgr91TT2++ofz19SoDZIZyo8jZt2
	sRMF3C4vGNlN+eeTOR+1yV8Y/a8sBYalX/jIGUKLhi/TMVzFL6WzlzAGUzUandPAsP
X-Received: by 2002:a05:690c:10d:b0:794:2fca:81a with SMTP id 00721157ae682-7949e08682bmr24900757b3.8.1769788244020;
        Fri, 30 Jan 2026 07:50:44 -0800 (PST)
Received: from ?IPV6:2408:8239:502:5512:69f7:837c:a720:7578? ([82.26.82.133])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828fa5b3sm36637887b3.50.2026.01.30.07.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 07:50:43 -0800 (PST)
Message-ID: <eb5e71fb-8397-42da-a66a-574b701f80f5@gmail.com>
Date: Fri, 30 Jan 2026 23:50:35 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
From: Sun YangKai <sunk67188@gmail.com>
To: Leo Martins <loemra.dev@gmail.com>, Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20260130001254.83750-1-loemra.dev@gmail.com>
 <df47b1c0-c25e-4501-aaa0-bc73ce1fdc00@gmail.com>
 <e5eee424-303d-423b-aead-2eccbf63b8ec@gmail.com>
Content-Language: en-US
In-Reply-To: <e5eee424-303d-423b-aead-2eccbf63b8ec@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-21243-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bur.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8F80BC3E0
X-Rspamd-Action: no action

On 2026/1/30 17:37, Sun YangKai wrote:
> 
> 
> On 2026/1/30 12:14, Sun YangKai wrote:
>> On 2026/1/30 08:12, Leo Martins wrote:
>>> On Thu, 29 Jan 2026 11:52:07 +0000 Filipe Manana<fdmanana@kernel.org> 
>>> wrote:
>>>> On Tue, Jan 27, 2026 at 8:43 PM Leo Martins<loemra.dev@gmail.com> 
>>>> wrote:
>>>>> I've been investigating enospcs at Meta and have observed a strange
>>>>> pattern where filesystems are enospcing with lots of unallocated space
>>>>> (> 100G). Sample dmesg dump at bottom of message.
>>>>>
>>>>> btrfs_insert_delayed_dir_index is attempting to migrate some 
>>>>> reservation
>>>>> from the transaction block reserve and finding it exhausted leading 
>>>>> to a
>>>>> warning and enospc. This is a bug as the reservations are meant to be
>>>>> worst case. It should be impossible to exhaust the transaction block
>>>>> reserve.
>>>>>
>>>>> Some tracing of affected hosts revealed that there were single
>>>>> btrfs_search_slot calls that were COWing 100s of times. I was able to
>>>>> reproduce this behavior locally by creating a very constrained cgroup
>>>>> and producing a lot of concurrent filesystem operations. Here's the
>>>>> pattern:
>>>>>
>>>>>   1. btrfs_search_slot() begins tree traversal with cow=1
>>>>>   2. Node at level N needs COW (old generation or WRITTEN flag set)
>>>>>   3. btrfs_cow_block() allocates new node, updates parent pointer
>>>>>   4. Traversal continues, but hits a condition requiring restart 
>>>>> (e.g., node
>>>>>      not cached, lock contention, need higher write_lock_level)
>>>>>   5. btrfs_release_path() releases all locks and references
>>>>>   6. Memory pressure triggers writeback on the COW'd node
>>>>>   7. lock_extent_buffer_for_io() clears EXTENT_BUFFER_DIRTY and sets
>>>>>      BTRFS_HEADER_FLAG_WRITTEN
>>>>>   8. goto again - traversal restarts from root
>>>>>   9. Traversal reaches the freshly COW'd node
>>>>>   10. should_cow_block() sees WRITTEN flag set, returns true
>>>>>   11. btrfs_cow_block() allocates another new node - same logical 
>>>>> position,
>>>>>       new physical location, new reservation consumed
>>>>>   12. Steps 4-11 repeat indefinitely under sustained memory pressure
>>>>>
>>>>> Note this behavior should be much harder to trigger since Boris's
>>>>> AS_KERNEL_FILE changes that make it so that extent_buffer pages aren't
>>>>> accounted for in user cgroups. However, I believe it
>>>>> would still be an issue under global memory pressure.
>>>>> Link:https://lore.kernel.org/linux-btrfs/ 
>>>>> cover.1755812945.git.boris@bur.io/
>>>>>
>>>>> This COW amplification breaks the idea that transaction 
>>>>> reservations are
>>>>> worst case as any search slot call could find itself in this COW 
>>>>> loop and
>>>>> exhaust its reservation.
>>>>>
>>>>> My proposed solution is to temporarily pin extent buffers for the
>>>>> lifetime of btrfs_search_slot. This prevents the massive COW
>>>>> amplification that can be seen during high memory pressure.
>>>>>
>>>>> The implementation uses a local xarray to track COW'd buffers for the
>>>>> duration of the search. The xarray stores extent_buffer pointers 
>>>>> without
>>>>> taking additional references; this is safe because tracked buffers 
>>>>> remain
>>>>> dirty (writeback_blockers prevents the dirty bit from being 
>>>>> cleared) and
>>>>> dirty buffers cannot be reclaimed by memory pressure.
>>>>>
>>>>> Synchronization is provided by eb->lock: increments in
>>>>> btrfs_search_slot_track_cow() occur while holding the write lock, and
>>>>> the check in lock_extent_buffer_for_io() also holds the write lock via
>>>>> btrfs_tree_lock(). Decrements don't require eb->lock because
>>>>> writeback_blockers is atomic and merely indicates "don't write yet".
>>>>> Once we decrement, we're done and don't care if writeback proceeds
>>>>> immediately.
>>>> This seems too complex to me.
>>>>
>>>> So this problem is very similar to some idea I had a few years ago but
>>>> never managed to implement.
>>>> It was about avoiding unnecessary COW, not for this space reservation
>>>> exhaustion due to sustained memory pressure, but it would solve it
>>>> too.
>>>>
>>>> The idea was that we do unnecessary COW in cases like this:
>>>>
>>>> 1) We COW a path in some tree and we are at transaction N;
>>>>
>>>> 2) Writeback happened for the extent buffers in that path while we are
>>>> in the same transaction, because we reached the 32M limit and some
>>>> task called btrfs_btree_balance_dirty() or something else triggered
>>>> writeback of the btree inode;
>>>>
>>>> 3) While still at transaction N, we visit the same path to add an item
>>>> to a leaf, or modify an item, whatever. Because the extent buffers
>>>> have BTRFS_HEADER_FLAG_WRITTEN, we COW them again (should_cow_block()
>>>> returns true).
>>>>
>>>> So during the lifetime of a transaction we can have a lot of
>>>> unnecessary COW - we spend more time allocating extents, allocating
>>>> memory, copying extent buffer data, use more space per transaction,
>>>> etc.
>>>>
>>>> The idea was to not COW when an extent buffer has
>>>> BTRFS_HEADER_FLAG_WRITTEN set, but only if its generation
>>>> (btrfs_header_generation(eb)) matches the current transaction.
>>>> That is safe because there's no committed tree that points to an
>>>> extent buffer created in the current transaction.
>>>>
>>>> Any further modification to the extent buffer must be sure that the
>>>> EXTENT_BUFFER_DIRTY flag is set, that the eb range is still in the
>>>> transaction's dirty_pages io tree, etc, so that we don't miss writing
>>>> the extent buffer to the same location again before the transaction
>>>> commits the superblocks.
>>>>
>>>> Have you considered an approach like this?
>>> I had not considered this, but it is a great idea.
>>>
>>> My first thought is that implementing this could be as simple
>>> as removing the BTRFS_HEADER_FLAG_WRITTEN check. However, this
>>> would mess with the assumptions around the log tree. From
>>> btrfs_sync_log():
>> After a fast glance and some tests, I found things might not be that 
>> easy. The problem is not only the log tree.
>>> /*
>>>   * IO has been started, blocks of the log tree have WRITTEN flag set
>>>   * in their headers. new modifications of the log will be written to
>>>   * new positions. so it's safe to allow log writers to go in.
>>>   */
>>>
>>> ^ Assumes that WRITTEN blocks will be COW'd.
>>>
>>> The issue looks like:
>>>
>>>   1. fsync A COWs eb
>>>   2. fsync A lock_extent_buffer_for_io(); sets WRITTEN, unlocks tree
>>>   3. fsync B does __not__ COW eb and modifies it
>>>   4. fsync A writes modified eb to disk
>>>   5. CRASH; the log tree is corrupted
>>>
>>> One way to avoid that is to keep the current behavior for the log
>>> tree, but that leaves the potential for COW amplification...
>> I tested with a patch like this:
>> @@ -624,14 +624,18 @@ static inline bool should_cow_block(const struct 
>> btrfs_trans_handle *trans,
>>          if (btrfs_header_generation(buf) != trans->transid)
>>                  return true;
>>
>> -       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
>> -               return true;
>> -
>>          /* Ensure we can see the FORCE_COW bit. */
>>          smp_mb__before_atomic();
>>          if (test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
>>                  return true;
>>
>> +       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
>> +               if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID)
>> +                       return true;
>> +               btrfs_mark_buffer_dirty(trans, buf);
>> +               return false;
>> +       }
>> +
>>          if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
>>
>>                  return false;
>>
>> And get some errors like this:
>>
>>
>> [  +0.090163] [ T2589] run fstests btrfs/004 at 2026-01-30 11:53:37
>> [  +0.432352] [T11685] BTRFS: device fsid 1fb397fc-97a7-44dd-9602- 
>> dd38b74bc391 devid 1 transid 8 /dev/loop1 (7:1) scanned by mount (11685)
>> [  +0.000351] [T11685] BTRFS info (device loop1): first mount of 
>> filesystem 1fb397fc-97a7-44dd-9602-dd38b74bc391
>> [  +0.000014] [T11685] BTRFS info (device loop1): using crc32c 
>> (crc32c- lib) checksum algorithm
>> [  +0.001298] [T11685] BTRFS info (device loop1): checking UUID tree
>> [  +0.000039] [T11685] BTRFS info (device loop1): enabling ssd 
>> optimizations
>> [  +0.000003] [T11685] BTRFS info (device loop1): turning on async 
>> discard
>> [  +0.000002] [T11685] BTRFS info (device loop1): enabling free space 
>> tree
>> [  +1.051781] [T11703] page: refcount:2 mapcount:0 
>> mapping:00000000eb6d7caa index:0x2348 pfn:0x1caebf
>> [  +0.000008] [T11703] memcg:ffff9b3300263cc0
>> [  +0.000003] [T11703] aops:0xffffffffc0354040 ino:1
>> [  +0.000024] [T11703] flags: 0x4e0000000000423e(referenced|uptodate| 
>> dirty|lru|workingset|private|writeback|zone=1)
>> [  +0.000007] [T11703] raw: 4e0000000000423e fffff74a872bb908 
>> fffff74a84206a88 ffff9b33c6706880
>> [  +0.000004] [T11703] raw: 0000000000002348 ffff9b334be522d0 
>> 00000002ffffffff ffff9b3300263cc0
>> [  +0.000002] [T11703] page dumped because: eb page dump
>> [  +0.000003] [T11703] BTRFS critical (device loop1): corrupt leaf: 
>> root=5 block=36995072 slot=118 ino=406 file_offset=94208, invalid 
>> ram_bytes for file extent, have 8660273067269322872, should be aligned 
>> to 4096
>> [  +0.000013] [T11703] BTRFS info (device loop1): leaf 36995072 gen 33 
>> total ptrs 128 free space 2857 owner 5
>> [  +0.000006] [T11703]     item 0 key (386 DIR_ITEM 238230307) itemoff 
>> 16249 itemsize 34
>> [  +0.000004] [T11703]         location key (462 1 0) type 2
>> [  +0.000003] [T11703]         transid 33 data_len 0 name_len 4
>> [  +0.000003] [T11703]     item 1 key (386 DIR_ITEM 1473745676) 
>> itemoff 16216 itemsize 33
>> [  +0.000004] [T11703]         location key (376 1 0) type 3
>> [  +0.000002] [T11703]         transid 30 data_len 0 name_len 3
>> [  +0.000003] [T11703]     item 2 key (386 DIR_ITEM 2243137595) 
>> itemoff 16182 itemsize 34
>> [  +0.000004] [T11703]         location key (413 1 0) type 1
>> [  +0.000002] [T11703]         transid 32 data_len 0 name_len 4
>> ...
>> [  +0.000001] [T11703]     item 127 key (405 DIR_ITEM 828387202) 
>> itemoff 6057 itemsize 34
>> [  +0.000002] [T11703]         location key (479 1 0) type 3
>> [  +0.000001] [T11703]         transid 33 data_len 0 name_len 4
>> [  +0.000002] [T11703] BTRFS error (device loop1): block=36995072 
>> write time tree block corruption detected
>> [  +0.003429] [T11703] BTRFS: error (device loop1) in 
>> btrfs_commit_transaction:2555: errno=-5 IO failure (Error while 
>> writing out transaction)
>> [  +0.000007] [T11703] BTRFS info (device loop1 state E): forced readonly
>> [  +0.000002] [T11703] BTRFS warning (device loop1 state E): Skipping 
>> commit of aborted transaction.
>> [  +0.000002] [T11703] BTRFS error (device loop1 state EA): 
>> Transaction aborted (error -5)
>> [  +0.000003] [T11703] BTRFS: error (device loop1 state EA) in 
>> cleanup_transaction:2037: errno=-5 IO failure
>>
>> The reported 406 inode is even not in the printed leaf. It seems like 
>> a data race maybe caused by:
>>
>> We unlock the eb after setting the WRITTEN flag during write back, and 
>> the eb should not get modified since then because all future writes 
>> will use the cowed eb. However, with the WRITTEN flag check removed in 
>> should_cow_block, we might write to the eb with WRITTEN flag set which 
>> might be under io.
> 
> I tried again with this:
> 
> @@ -624,14 +624,20 @@ static inline bool should_cow_block(const struct 
> btrfs_trans_handle *trans,
>          if (btrfs_header_generation(buf) != trans->transid)
>                  return true;
> 
> -       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
> -               return true;
> -
>          /* Ensure we can see the FORCE_COW bit. */
>          smp_mb__before_atomic();
>          if (test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
>                  return true;
> 
> +       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> +               if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID)
> +                       return true;
> +               if (test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags))
> +                       return true;
> +               btrfs_mark_buffer_dirty(trans, buf);
> +               return false;
> +       }
> +
>          if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
>                  return false;
> 
> When WRITEBACK is set, do a normal cow to prevent the data race. This 
> seems to fix the previous problem. However, I got this:
> 
> [  +0.020843] [T15127] BTRFS error (device loop1): block=30687232 bad 
> generation, have 11 expect > 14
> [  +0.000009] [T15127]     item 0 key (256 INODE_ITEM 0) itemoff 16123 
> itemsize 160
> [  +0.000004] [T15127]         inode generation 3 transid 11 size 10 
> nbytes 16384
> [  +0.000003] [T15127]         block group 0 mode 40755 links 1 uid 0 gid 0
> [  +0.000002] [T15127]         rdev 0 sequence 1 flags 0x0
> [  +0.000002] [T15127]         atime 1769760651.0
> [  +0.000002] [T15127]         ctime 1769760652.250234845
> [  +0.000002] [T15127]         mtime 1769760652.250234845
> [  +0.000001] [T15127]         otime 1769760651.0
> ...
> [  +0.000004] [T15127]         root data bytenr 30523392 refs 1
> [  +0.000002] [T15127] BTRFS error (device loop1): block=30851072 write 
> time tree block corruption detected
> 
> and a lot more lines with the same generation errors for btrfs/122 
> btrfs/152 btrfs/210 btrfs/224 btrfs/316 btrfs/320 btrfs/340 fstest cases.
> 
> I have no idea why it's trying to write some ebs older than current 
> transaction. Seems related with snapshots.

This happens because after an extent buffer (eb) is written to disk, 
subsequent modifications only set the dirty flag without adding those 
pages to the current transaction's dirty list. Consequently, their 
writeback isn't triggered or awaited during transaction commit.

In contrast, newly allocated or COWed extent buffers are explicitly 
added to the transaction's dirty_pages via btrfs_init_new_buffer, which 
ensures they are properly tracked and written back.

Add the following code could fix this:

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8d683745afd1..3ab89a31f9bb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4450,6 +4450,9 @@ void btrfs_mark_buffer_dirty(struct 
btrfs_trans_handle *trans,
                            buf->start, transid, fs_info->generation);
         }
         set_extent_buffer_dirty(buf);
+       if (btrfs_header_owner(buf) != BTRFS_TREE_LOG_OBJECTID)
+               btrfs_set_extent_bit(&trans->transaction->dirty_pages, 
buf->start,
+                                    buf->start + buf->len - 1, 
EXTENT_DIRTY, NULL);
  }

  static void __btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info,


Thanks,
Sun YangKai

