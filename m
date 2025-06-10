Return-Path: <linux-btrfs+bounces-14588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 472C1AD35F0
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 14:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA48A188926F
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 12:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38A128FAAA;
	Tue, 10 Jun 2025 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z3oxugXR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KYIrFThp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jhyTtsqb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KQD6V69d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0128FAA6
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558028; cv=none; b=PCUmQte0nVNSdxh/A2FaFWME6GMSOkZ9tQK3bKixI9XRnF/fbFP5HKCUYMvYNkz4cxpPEGtInwT3680nUon6L59vpAL6oCs0oAmQ2J6tDrB7m9nVJmFh3KliqKhLuHOjK9DMdjqM0q6PbY/0kXJyP7wogPB9FN73mRUG4dRcRmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558028; c=relaxed/simple;
	bh=f7yD9ZGIhlp3wMt87NudjlLxPD8nm+2ppHsZrg6F2ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=melFQlPJyzCvU2Ai8XbSTD+SB2ulHUuClhuxFT/aO2RhJPB/FsDk0VOvl+dctAhFDaSJ8/LwmaxVYxAA29TYW0u3s8VoGx6gGvrXoZFapEmPTyaB1WMxlyCj7bC8rf4/IjIvUXCfEEW/Bq2maVDrruOobBjnbSOtcuxLtYEgK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z3oxugXR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KYIrFThp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jhyTtsqb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KQD6V69d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 43EFD1F7BF;
	Tue, 10 Jun 2025 12:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749558024;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhmeiPUjgaYX7zCsgw8wK/pQGG2YZ13Iv4uu655+FMg=;
	b=Z3oxugXRn5K0RhfxquMLXuaJBGZDAgYvxm9F5yfgle5+8AWRPznw3FgMSize1mRrfya+5b
	gBRTWtP36/SnohLCUvn2a043WvyLiKOUzn9S5LjMr8tIu/8cZxUF1NfNd9luaO1mseBTFz
	LzGVPnGpT3iJzW2KVN6yvYVeg3fy2jQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749558024;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhmeiPUjgaYX7zCsgw8wK/pQGG2YZ13Iv4uu655+FMg=;
	b=KYIrFThpRoOvKvtjYfx2JJrQEZI9jZuk8ZRZIvXmhwVH10ZZLuZJnWKoI25958FDgbu3+l
	bGfLAVrbtuuk8XAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jhyTtsqb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KQD6V69d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749558023;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhmeiPUjgaYX7zCsgw8wK/pQGG2YZ13Iv4uu655+FMg=;
	b=jhyTtsqbuRTkuwjcCm1AYtxCvTL2+L7cbKVzgDfuDC5v4bX6V0oLu0NUyyI6Jfw5VNmfH/
	G1CFulqJ275d+Nkq6h9G6m/Rvs0QHiUjbWQqgWP4S9FcXDPOVdzGIBx/F4D5x3X+v8FiAu
	QveEhJwkhi1twKDOHceoNK7J4CSl2Dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749558023;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhmeiPUjgaYX7zCsgw8wK/pQGG2YZ13Iv4uu655+FMg=;
	b=KQD6V69dq0jQ7y27xyYQLknz/hhcbr5biPoJzwYlGJfqPGiGqzRqBnlVM6E6ew13tORNKm
	0/DawP26xus6V7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26A40139E2;
	Tue, 10 Jun 2025 12:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E6V+CAcjSGhPdAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 10 Jun 2025 12:20:23 +0000
Date: Tue, 10 Jun 2025 14:20:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Zhiyu Zhang <zhiyuzhang999@gmail.com>,
	Longxing Li <coregee2000@gmail.com>
Subject: Re: [PATCH] btrfs: handle csum tree error with rescue=ibadroots
 correctly
Message-ID: <20250610122020.GB4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <54f393590b28e5f827f2f195000208845928ea7d.1749253719.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54f393590b28e5f827f2f195000208845928ea7d.1749253719.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 43EFD1F7BF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Sat, Jun 07, 2025 at 09:18:43AM +0930, Qu Wenruo wrote:
> [BUG]
> There is syzbot based reproducer that can crash the kernel, with the
> following call trace: (With some debug output added)
> 
>  DEBUG: rescue=ibadroots parsed
>  BTRFS: device fsid 14d642db-7b15-43e4-81e6-4b8fac6a25f8 devid 1 transid 8 /dev/loop0 (7:0) scanned by repro (1010)
>  BTRFS info (device loop0): first mount of filesystem 14d642db-7b15-43e4-81e6-4b8fac6a25f8
>  BTRFS info (device loop0): using blake2b (blake2b-256-generic) checksum algorithm
>  BTRFS info (device loop0): using free-space-tree
>  BTRFS warning (device loop0): checksum verify failed on logical 5312512 mirror 1 wanted 0xb043382657aede36608fd3386d6b001692ff406164733d94e2d9a180412c6003 found 0x810ceb2bacb7f0f9eb2bf3b2b15c02af867cb35ad450898169f3b1f0bd818651 level 0
>  DEBUG: read tree root path failed for tree csum, ret=-5
>  BTRFS warning (device loop0): checksum verify failed on logical 5328896 mirror 1 wanted 0x51be4e8b303da58e6340226815b70e3a93592dac3f30dd510c7517454de8567a found 0x51be4e8b303da58e634022a315b70e3a93592dac3f30dd510c7517454de8567a level 0
>  BTRFS warning (device loop0): checksum verify failed on logical 5292032 mirror 1 wanted 0x1924ccd683be9efc2fa98582ef58760e3848e9043db8649ee382681e220cdee4 found 0x0cb6184f6e8799d9f8cb335dccd1d1832da1071d12290dab3b85b587ecacca6e level 0
>  process 'repro' launched './file2' with NULL argv: empty string added
>  DEBUG: no csum root, idatacsums=0 ibadroots=134217728
>  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000041: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
>  CPU: 5 UID: 0 PID: 1010 Comm: repro Tainted: G           OE       6.15.0-custom+ #249 PREEMPT(full)
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
>  RIP: 0010:btrfs_lookup_csum+0x93/0x3d0 [btrfs]
>  Call Trace:
>   <TASK>
>   btrfs_lookup_bio_sums+0x47a/0xdf0 [btrfs]
>   btrfs_submit_bbio+0x43e/0x1a80 [btrfs]
>   submit_one_bio+0xde/0x160 [btrfs]
>   btrfs_readahead+0x498/0x6a0 [btrfs]
>   read_pages+0x1c3/0xb20
>   page_cache_ra_order+0x4b5/0xc20
>   filemap_get_pages+0x2d3/0x19e0
>   filemap_read+0x314/0xde0
>   __kernel_read+0x35b/0x900
>   bprm_execve+0x62e/0x1140
>   do_execveat_common.isra.0+0x3fc/0x520
>   __x64_sys_execveat+0xdc/0x130
>   do_syscall_64+0x54/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  ---[ end trace 0000000000000000 ]---
> 
> [CAUSE]
> Firstly the fs has a corrupted csum tree root, thus to mount the fs we
> have to go "ro,rescue=ibadroots" mount option.
> 
> Normally with that mount option, a bad csum tree root should set
> BTRFS_FS_STATE_NO_DATA_CSUMS flag, so that any future data read will
> ignore csum search.
> 
> But in this particular case, we have the following call trace that
> caused NULL csum root, but not setting BTRFS_FS_STATE_NO_DATA_CSUMS:
> 
> load_global_roots_objectid():
> 
> 		ret = btrfs_search_slot();
> 		/* Succeeded */
> 		btrfs_item_key_to_cpu()
> 		found = true;
> 		/* We found the root item for csum tree. */
> 		root = read_tree_root_path();
> 		if (IS_ERR(root)) {
> 			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
> 			/*
> 			 * Since we have rescue=ibadroots mount option,
> 			 * @ret is still 0.
> 			 */
> 			break;
> 	if (!found || ret) {
> 		/* @found is true, @ret is 0, error handling for csum
> 		 * tree is skipped.
> 		 */
> 	}
> 
> This means we completely skipped to set BTRFS_FS_STATE_NO_DATA_CSUMS if
> the csum tree is corrupted, which results unexpected later csum lookup.
> 
> [FIX]
> If read_tree_root_path() failed, always populate @ret to the error
> number.
> 
> As at the end of the function, we need @ret to determine if we need to
> do the extra error handling for csum tree.
> 
> Fixes: abed4aaae4f7 ("btrfs: track the csum, extent, and free space trees in a rb tree")
> Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> Reported-by: Longxing Li <coregee2000@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

