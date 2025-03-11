Return-Path: <linux-btrfs+bounces-12202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D2A5CEA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 20:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14AE17A9DB0
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A45263F3D;
	Tue, 11 Mar 2025 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SbfVZmPr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nvi8dtiF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SbfVZmPr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nvi8dtiF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E2C2641E7
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719738; cv=none; b=oJyI4Tw1IJUmsCQO64OG83aHm7Pon/Yn2uHDmPGl12NAXF8mttpiT7iNeav5rohjfj4E+jSiW2vCu+dLV7CsOerOEtlocau8R2jVTSqRphYydjnTANIxltZvWCb9crujai8pyg1zqgbFG7GCH5LdfHzNW9/cYpE/3Y+HSG9UQzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719738; c=relaxed/simple;
	bh=tu8ubZ1H8xqm80Zh8q73cogQv4F7oXrOKcpHhMWSddE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esv5YfPbfyFsDDUxImyPx1acF0xhTQrkePE3IsFX/xpb1lZFwGSmeCUui1dFbqcPQZETbfpnV+ZXF2a5h8tZiKCi9abqiSZ48sW02Dj1wom9jDEjrjZm4Mm0V4n5Vr2FFqafVkJrFwz5L9AOjnADl8pOgnq/y6v8/le9pMqgUVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SbfVZmPr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nvi8dtiF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SbfVZmPr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nvi8dtiF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 128C41F394;
	Tue, 11 Mar 2025 19:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741719735;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ig5sIhezrD/Xge2P5AlgUAGpd+lNgIcSBX/bZ3tbJJQ=;
	b=SbfVZmPrjgyc3o6IyO3Q/gN001dY5ObKDDa6yRXsAIbztzQ65qCtitIPtyXSGhk8PfY5Qk
	98qMyp0lsLci1aIKMO786N84yq+FjxsAO30UBhdVazkCMo4EzHPPyM/IGGTZcPijwQksKj
	IuUtmZ/9FTU2yE23OBIY/meIIiz8F/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741719735;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ig5sIhezrD/Xge2P5AlgUAGpd+lNgIcSBX/bZ3tbJJQ=;
	b=nvi8dtiFXRNtNIh05q3SiLAItHVxkQqpi5bv0mbTOxmrlA2mXRImNIpo+ipFM9x09PL39E
	2VB7iVbUex5IxuCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SbfVZmPr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nvi8dtiF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741719735;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ig5sIhezrD/Xge2P5AlgUAGpd+lNgIcSBX/bZ3tbJJQ=;
	b=SbfVZmPrjgyc3o6IyO3Q/gN001dY5ObKDDa6yRXsAIbztzQ65qCtitIPtyXSGhk8PfY5Qk
	98qMyp0lsLci1aIKMO786N84yq+FjxsAO30UBhdVazkCMo4EzHPPyM/IGGTZcPijwQksKj
	IuUtmZ/9FTU2yE23OBIY/meIIiz8F/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741719735;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ig5sIhezrD/Xge2P5AlgUAGpd+lNgIcSBX/bZ3tbJJQ=;
	b=nvi8dtiFXRNtNIh05q3SiLAItHVxkQqpi5bv0mbTOxmrlA2mXRImNIpo+ipFM9x09PL39E
	2VB7iVbUex5IxuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8ABC132CB;
	Tue, 11 Mar 2025 19:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LQKTOLaI0GdyLgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 11 Mar 2025 19:02:14 +0000
Date: Tue, 11 Mar 2025 20:02:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/5] btrfs: fix bg refcount race in
 btrfs_create_pending_block_groups
Message-ID: <20250311190205.GI32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1741636986.git.boris@bur.io>
 <498b58b794722c70eca58bf3fe46003c43e60aff.1741636986.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <498b58b794722c70eca58bf3fe46003c43e60aff.1741636986.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 128C41F394
X-Spam-Score: -4.21
X-Rspamd-Action: no action
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Mar 10, 2025 at 01:07:01PM -0700, Boris Burkov wrote:
> Block group creation is done in two phases, which results in a slightly
> unintiuitive property: a block group can be allocated/deallocated from
> after btrfs_make_block_group adds it to the space_info with
> btrfs_add_bg_to_space_info, but before creation is completely completed

Please write function references with the (), this makes it clear when
there are other identifiers like struct names or variables.

> in btrfs_create_pending_block_groups. As a result, it is possible for a
> block group to go unused and have 'btrfs_mark_bg_unused' called on it
> concurrently with 'btrfs_create_pending_block_groups'. This causes a
> number of issues, which were fixed with the block group flag
> 'BLOCK_GROUP_FLAG_NEW'.
> 
> However, this fix is not quite complete. Since it does not use the
> unused_bg_lock, it is possible for the following race to occur:
> 
> btrfs_create_pending_block_groups            btrfs_mark_bg_unused
>                                            if list_empty // false
>         list_del_init
>         clear_bit
>                                            else if (test_bit) // true
>                                                 list_move_tail
> 
> And we get into the exact same broken ref count and invalid new_bgs
> state for transaction cleanup that BLOCK_GROUP_FLAG_NEW was designed to
> prevent.
> 
> The broken refcount aspect will result in a warning like:
> [ 1272.943113] ------------[ cut here ]------------
> [ 1272.943527] refcount_t: underflow; use-after-free.
> [ 1272.943967] WARNING: CPU: 1 PID: 61 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
> [ 1272.944731] Modules linked in: btrfs virtio_net xor zstd_compress raid6_pq null_blk [last unloaded: btrfs]
> [ 1272.945550] CPU: 1 UID: 0 PID: 61 Comm: kworker/u32:1 Kdump: loaded Tainted: G        W          6.14.0-rc5+ #108
> [ 1272.946368] Tainted: [W]=WARN
> [ 1272.946585] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> [ 1272.947273] Workqueue: btrfs_discard btrfs_discard_workfn [btrfs]
> [ 1272.947788] RIP: 0010:refcount_warn_saturate+0xba/0x110
> [ 1272.948180] Code: 01 01 e8 e9 c7 a9 ff 0f 0b c3 cc cc cc cc 80 3d 3f 4a de 01 00 75 85 48 c7 c7 00 9b 9f 8f c6 05 2f 4a de 01 01 e8 c6 c7 a9 ff <0f> 0b c3 cc cc cc cc 80 3d 1d 4a de 01 00 0f 85 5e ff ff ff 48 c7

Please remove the Code: line unless it's really needed for the fix.

I've fixed it for-next.

