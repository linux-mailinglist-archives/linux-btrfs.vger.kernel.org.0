Return-Path: <linux-btrfs+bounces-3173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AD6877C6F
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 10:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A9228233A
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7381F2261F;
	Mon, 11 Mar 2024 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="VoylY6yu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67733070;
	Mon, 11 Mar 2024 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148538; cv=none; b=JIf6UaIMQZQr3NsL7iZI+B8HEXrsses38xXThxo+gxOuJ9Apgch1/V+NJfkoxeYsZOTjATYM0eL+e9sNGO8Gkq3ofh+omgbUpNeAHY2+eVSV7LWyEXNMJSrLR29ECmfe59nwJY0zUB4i5m4MyUrh6MS6XSeeOlZWNhGRV7WuPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148538; c=relaxed/simple;
	bh=fDcyWtsKLpMUlBDZfvyHMi0/iqNhwLjnewlmBXGhQeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2gOmZSZUmLkBLA4TqOygCzCbZC59DwGNeTZkxzpehrlrjWs5Al1p8wZoMy5GvZSI6JhtrzLe9LtHof0KfD4VnkpAuc+k6WyC0AoFh4a5pOgLztQSLZR/RDPRbQQiU7J1a4eWzKevfJmypP+5oUP2XR/GNflbp/eVYdWlnJIAoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=VoylY6yu; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=rm2u1DC2SQLO/GhCuJ2mUooy8fntRke757nFqBbgD2k=;
	t=1710148535; x=1710580535; b=VoylY6yuRK/0sU0/64QivCQqs7GgA+0GYsaXHS9Y8ujtSUD
	ECdC4j18kyxN08AF6biBu3ezMk89hwF/TYJjXcYBYPWM9zy4BJJ7jheGQiQsUdoLvOfKfJ7Mlytgf
	rSDrEg/4Gas0CZUBVx9GLLj2HxOFZ7dmGyuIw7LdIlWLUXcpgHZNUCXZ8i42bvn750pVPZx+gFEt2
	2O2GmZHc3s73uQB2ovJ9N3LhNqZgBwkIOIFd7QyE4K5tzKlD/rlWaItPU6/ij9kb2FHZfrNktLwvS
	qXgwD83WYQjibFrnB9pM7SxjZ9LpGg+6/SwWwXLe4kU1rSNsYxQe6Um1w5pjsK3g==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rjbkq-0001Hx-Kh; Mon, 11 Mar 2024 10:15:32 +0100
Message-ID: <da17e97b-1880-415d-8cdb-07e79808e702@leemhuis.info>
Date: Mon, 11 Mar 2024 10:15:31 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 6.7 001/162] btrfs: fix deadlock with fiemap and extent
 locking
Content-Language: en-US, de-DE
To: Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Josef Bacik <josef@toxicpanda.com>, Sasha Levin <sashal@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Chris Mason <clm@fb.com>, linux-btrfs <linux-btrfs@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
 <20240304211551.880347593@linuxfoundation.org>
 <CAKisOQGCiJUUc62ptxp08LkR88T5t1swcBPYi84y2fLP6Tag7g@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <CAKisOQGCiJUUc62ptxp08LkR88T5t1swcBPYi84y2fLP6Tag7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710148535;60c88d1c;
X-HE-SMSGID: 1rjbkq-0001Hx-Kh

On 06.03.24 13:39, Filipe Manana wrote:
> On Mon, Mar 4, 2024 at 9:26 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> 6.7-stable review patch.  If anyone has any objections, please let me know.
> 
> It would be better to delay the backport of this patch (and the
> followup fix) to any stable release, because it introduced another
> regression for which there is a reviewed fix but it's not yet in
> Linus' tree:
> 
> https://lore.kernel.org/linux-btrfs/cover.1709202499.git.fdmanana@suse.com/

Those two missed 6.8 afaics. Will those be heading to mainline any time
soon? And how fast afterwards will it be wise to backport them to 6.8?
Will anyone ask Greg for that when the time has come? Same for
backporting "btrfs: fix deadlock with fiemap and extent locking", the
followup fix and the two fixed mentioned above for 6.6 and 6.7?

Cioa, Thorsten

>> ------------------
>>
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> [ Upstream commit b0ad381fa7690244802aed119b478b4bdafc31dd ]
>>
>> While working on the patchset to remove extent locking I got a lockdep
>> splat with fiemap and pagefaulting with my new extent lock replacement
>> lock.
>>
>> This deadlock exists with our normal code, we just don't have lockdep
>> annotations with the extent locking so we've never noticed it.
>>
>> Since we're copying the fiemap extent to user space on every iteration
>> we have the chance of pagefaulting.  Because we hold the extent lock for
>> the entire range we could mkwrite into a range in the file that we have
>> mmap'ed.  This would deadlock with the following stack trace
>>
>> [<0>] lock_extent+0x28d/0x2f0
>> [<0>] btrfs_page_mkwrite+0x273/0x8a0
>> [<0>] do_page_mkwrite+0x50/0xb0
>> [<0>] do_fault+0xc1/0x7b0
>> [<0>] __handle_mm_fault+0x2fa/0x460
>> [<0>] handle_mm_fault+0xa4/0x330
>> [<0>] do_user_addr_fault+0x1f4/0x800
>> [<0>] exc_page_fault+0x7c/0x1e0
>> [<0>] asm_exc_page_fault+0x26/0x30
>> [<0>] rep_movs_alternative+0x33/0x70
>> [<0>] _copy_to_user+0x49/0x70
>> [<0>] fiemap_fill_next_extent+0xc8/0x120
>> [<0>] emit_fiemap_extent+0x4d/0xa0
>> [<0>] extent_fiemap+0x7f8/0xad0
>> [<0>] btrfs_fiemap+0x49/0x80
>> [<0>] __x64_sys_ioctl+0x3e1/0xb50
>> [<0>] do_syscall_64+0x94/0x1a0
>> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
>>
>> I wrote an fstest to reproduce this deadlock without my replacement lock
>> and verified that the deadlock exists with our existing locking.
>>
>> To fix this simply don't take the extent lock for the entire duration of
>> the fiemap.  This is safe in general because we keep track of where we
>> are when we're searching the tree, so if an ordered extent updates in
>> the middle of our fiemap call we'll still emit the correct extents
>> because we know what offset we were on before.
>>
>> The only place we maintain the lock is searching delalloc.  Since the
>> delalloc stuff can change during writeback we want to lock the extent
>> range so we have a consistent view of delalloc at the time we're
>> checking to see if we need to set the delalloc flag.
>>
>> With this patch applied we no longer deadlock with my testcase.
>>
>> CC: stable@vger.kernel.org # 6.1+
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> Reviewed-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  fs/btrfs/extent_io.c | 62 ++++++++++++++++++++++++++++++++------------
>>  1 file changed, 45 insertions(+), 17 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 8f724c54fc8e9..197b41d02735b 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2645,16 +2645,34 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
>>          * it beyond i_size.
>>          */
>>         while (cur_offset < end && cur_offset < i_size) {
>> +               struct extent_state *cached_state = NULL;
>>                 u64 delalloc_start;
>>                 u64 delalloc_end;
>>                 u64 prealloc_start;
>> +               u64 lockstart;
>> +               u64 lockend;
>>                 u64 prealloc_len = 0;
>>                 bool delalloc;
>>
>> +               lockstart = round_down(cur_offset, inode->root->fs_info->sectorsize);
>> +               lockend = round_up(end, inode->root->fs_info->sectorsize);
>> +
>> +               /*
>> +                * We are only locking for the delalloc range because that's the
>> +                * only thing that can change here.  With fiemap we have a lock
>> +                * on the inode, so no buffered or direct writes can happen.
>> +                *
>> +                * However mmaps and normal page writeback will cause this to
>> +                * change arbitrarily.  We have to lock the extent lock here to
>> +                * make sure that nobody messes with the tree while we're doing
>> +                * btrfs_find_delalloc_in_range.
>> +                */
>> +               lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
>>                 delalloc = btrfs_find_delalloc_in_range(inode, cur_offset, end,
>>                                                         delalloc_cached_state,
>>                                                         &delalloc_start,
>>                                                         &delalloc_end);
>> +               unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
>>                 if (!delalloc)
>>                         break;
>>
>> @@ -2822,15 +2840,15 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>>                   u64 start, u64 len)
>>  {
>>         const u64 ino = btrfs_ino(inode);
>> -       struct extent_state *cached_state = NULL;
>>         struct extent_state *delalloc_cached_state = NULL;
>>         struct btrfs_path *path;
>>         struct fiemap_cache cache = { 0 };
>>         struct btrfs_backref_share_check_ctx *backref_ctx;
>>         u64 last_extent_end;
>>         u64 prev_extent_end;
>> -       u64 lockstart;
>> -       u64 lockend;
>> +       u64 range_start;
>> +       u64 range_end;
>> +       const u64 sectorsize = inode->root->fs_info->sectorsize;
>>         bool stopped = false;
>>         int ret;
>>
>> @@ -2841,12 +2859,11 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>>                 goto out;
>>         }
>>
>> -       lockstart = round_down(start, inode->root->fs_info->sectorsize);
>> -       lockend = round_up(start + len, inode->root->fs_info->sectorsize);
>> -       prev_extent_end = lockstart;
>> +       range_start = round_down(start, sectorsize);
>> +       range_end = round_up(start + len, sectorsize);
>> +       prev_extent_end = range_start;
>>
>>         btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
>> -       lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
>>
>>         ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
>>         if (ret < 0)
>> @@ -2854,7 +2871,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>>         btrfs_release_path(path);
>>
>>         path->reada = READA_FORWARD;
>> -       ret = fiemap_search_slot(inode, path, lockstart);
>> +       ret = fiemap_search_slot(inode, path, range_start);
>>         if (ret < 0) {
>>                 goto out_unlock;
>>         } else if (ret > 0) {
>> @@ -2866,7 +2883,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>>                 goto check_eof_delalloc;
>>         }
>>
>> -       while (prev_extent_end < lockend) {
>> +       while (prev_extent_end < range_end) {
>>                 struct extent_buffer *leaf = path->nodes[0];
>>                 struct btrfs_file_extent_item *ei;
>>                 struct btrfs_key key;
>> @@ -2889,19 +2906,19 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>>                  * The first iteration can leave us at an extent item that ends
>>                  * before our range's start. Move to the next item.
>>                  */
>> -               if (extent_end <= lockstart)
>> +               if (extent_end <= range_start)
>>                         goto next_item;
>>
>>                 backref_ctx->curr_leaf_bytenr = leaf->start;
>>
>>                 /* We have in implicit hole (NO_HOLES feature enabled). */
>>                 if (prev_extent_end < key.offset) {
>> -                       const u64 range_end = min(key.offset, lockend) - 1;
>> +                       const u64 hole_end = min(key.offset, range_end) - 1;
>>
>>                         ret = fiemap_process_hole(inode, fieinfo, &cache,
>>                                                   &delalloc_cached_state,
>>                                                   backref_ctx, 0, 0, 0,
>> -                                                 prev_extent_end, range_end);
>> +                                                 prev_extent_end, hole_end);
>>                         if (ret < 0) {
>>                                 goto out_unlock;
>>                         } else if (ret > 0) {
>> @@ -2911,7 +2928,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>>                         }
>>
>>                         /* We've reached the end of the fiemap range, stop. */
>> -                       if (key.offset >= lockend) {
>> +                       if (key.offset >= range_end) {
>>                                 stopped = true;
>>                                 break;
>>                         }
>> @@ -3005,29 +3022,41 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>>         btrfs_free_path(path);
>>         path = NULL;
>>
>> -       if (!stopped && prev_extent_end < lockend) {
>> +       if (!stopped && prev_extent_end < range_end) {
>>                 ret = fiemap_process_hole(inode, fieinfo, &cache,
>>                                           &delalloc_cached_state, backref_ctx,
>> -                                         0, 0, 0, prev_extent_end, lockend - 1);
>> +                                         0, 0, 0, prev_extent_end, range_end - 1);
>>                 if (ret < 0)
>>                         goto out_unlock;
>> -               prev_extent_end = lockend;
>> +               prev_extent_end = range_end;
>>         }
>>
>>         if (cache.cached && cache.offset + cache.len >= last_extent_end) {
>>                 const u64 i_size = i_size_read(&inode->vfs_inode);
>>
>>                 if (prev_extent_end < i_size) {
>> +                       struct extent_state *cached_state = NULL;
>>                         u64 delalloc_start;
>>                         u64 delalloc_end;
>> +                       u64 lockstart;
>> +                       u64 lockend;
>>                         bool delalloc;
>>
>> +                       lockstart = round_down(prev_extent_end, sectorsize);
>> +                       lockend = round_up(i_size, sectorsize);
>> +
>> +                       /*
>> +                        * See the comment in fiemap_process_hole as to why
>> +                        * we're doing the locking here.
>> +                        */
>> +                       lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
>>                         delalloc = btrfs_find_delalloc_in_range(inode,
>>                                                                 prev_extent_end,
>>                                                                 i_size - 1,
>>                                                                 &delalloc_cached_state,
>>                                                                 &delalloc_start,
>>                                                                 &delalloc_end);
>> +                       unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
>>                         if (!delalloc)
>>                                 cache.flags |= FIEMAP_EXTENT_LAST;
>>                 } else {
>> @@ -3038,7 +3067,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>>         ret = emit_last_fiemap_cache(fieinfo, &cache);
>>
>>  out_unlock:
>> -       unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
>>         btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
>>  out:
>>         free_extent_state(delalloc_cached_state);
>> --
>> 2.43.0
>>
>>
>>

