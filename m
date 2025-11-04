Return-Path: <linux-btrfs+bounces-18638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D48C2F62E
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 06:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F140E3B7FBC
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 05:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCB42D0C79;
	Tue,  4 Nov 2025 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lEoy1aYs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gep6Pr7r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lEoy1aYs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gep6Pr7r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DD629C327
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 05:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762234679; cv=none; b=m1vMoioooz0s4xpOQOqUirAfT20kzLBdS8fzr6QheJW6AllK6oIdLqc48x87reUC+gTGqMgoygp64Z8UCRJh7FFT7h7TY+jVgHasYrxZuOrrI/B4OolcNI9RfEMobaIkibkjZUMJ0IR2cNIAEhScjNyjhhPpb9nPrF/mNXsop9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762234679; c=relaxed/simple;
	bh=DvmJcx2HUCeWvXwf1hJ2FXAaLjB6OIZEOuLaaFDqZUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCRRBt8bIsgvNlk8irtiGlFcCFUcqwd88sXQZYoGUpjjjJ92/sGsJAHlbqKNivE6rY6VapJ+azmz0JouO60hbMJvEif5QPiZ059qJKfoO4NGNG1OAV64GWYlVmhb9BXzVXrE2DF+s02RmMVXfZc+dJwV2zI8Sq3Nm93IJm6pfNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lEoy1aYs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gep6Pr7r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lEoy1aYs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gep6Pr7r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A791211B4;
	Tue,  4 Nov 2025 05:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762234675;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TRsbvsbW2e58dRfmrBipc59vkjPstjzQR4cEiqajojQ=;
	b=lEoy1aYsj9qdeA3+2BR6HFWdqoNQOJOP1zWsvhXybbCk0SiwdKpfcMi6NlLlHR/thyOp9/
	EMUtdJPfN+Mg3ejLhLkNcYB5hX0qFGqmrmU+FR67Z4OjUJ+g0ApeuD8AiSljZJuGIMcxx8
	AuS0Lu66RKo/PcRA+WxJ7L1TF+nxd4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762234675;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TRsbvsbW2e58dRfmrBipc59vkjPstjzQR4cEiqajojQ=;
	b=Gep6Pr7ryya+P/lTNm5RvpoZxyzOTenpCHEt3Oqp0EA+dAgnKavSuoK2c3IK922ZMXOgBD
	RztPsHTbc7AH9tDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lEoy1aYs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Gep6Pr7r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762234675;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TRsbvsbW2e58dRfmrBipc59vkjPstjzQR4cEiqajojQ=;
	b=lEoy1aYsj9qdeA3+2BR6HFWdqoNQOJOP1zWsvhXybbCk0SiwdKpfcMi6NlLlHR/thyOp9/
	EMUtdJPfN+Mg3ejLhLkNcYB5hX0qFGqmrmU+FR67Z4OjUJ+g0ApeuD8AiSljZJuGIMcxx8
	AuS0Lu66RKo/PcRA+WxJ7L1TF+nxd4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762234675;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TRsbvsbW2e58dRfmrBipc59vkjPstjzQR4cEiqajojQ=;
	b=Gep6Pr7ryya+P/lTNm5RvpoZxyzOTenpCHEt3Oqp0EA+dAgnKavSuoK2c3IK922ZMXOgBD
	RztPsHTbc7AH9tDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D1EB1388E;
	Tue,  4 Nov 2025 05:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SGqQFjORCWnOOgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 04 Nov 2025 05:37:55 +0000
Date: Tue, 4 Nov 2025 06:37:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/7] btrfs: introduce btrfs_bio::async_csum
Message-ID: <20251104053754.GN13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1761715649.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761715649.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 7A791211B4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Wed, Oct 29, 2025 at 04:04:10PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Fix a race where csum generation can be completely skipped
>   If the lower storage layer advanced the bi_iter before we finished
>   calculating the checksum, bio_one_bio() may skip generating csum
>   completely.
> 
>   Unfortunately to solve this, a new bvec_iter must be introduced and
>   cause the size of btrfs_bio to increase.
> 
> - Remove btrfs_bio::fs_info by always requireing btrfs_bio::inode
>   For scrub, use btree inode instead, and for the only function that
>   requires to be called by scrub, btrfs_submit_repair_write(), use
>   a new member, btrfs_bio::is_scrub, to check the callers.
> 
> - Add a new patch to cleanup the recursive including problems
>   The idea is to keep the btrfs headers inside .h files to minimal,
>   thus lower risk of recursive including.
> 
> - Remove BTRFS_MAX_BIO_SECTORS macro
>   It's the same as BIO_MAX_VECS, and only utilized once.
> 
> The new async_csum feature will allow btrfs to calculate checksum for
> data write bios and submit them in parallel.
> 
> This will reduce latency and improve write throughput when data checksum
> is utilized.
> 
> This will slightly reclaim the performance drop after commit
> 968f19c5b1b7 ("btrfs: always fallback to buffered write if the inode
> requires checksum").
> 
> Patch 1 is a minor cleanup to remove a single-used macro.
> Patch 2 is a preparation to remove btrfs_bio::fs_info, the core
> is to avoid recursive including.
> Patch 3 is to remove btrfs_bio::fs_info, as soon we will
> increase the size of btrfs_bio by 16 bytes.
> 
> Patch 4~6 are preparations to make sure btrfs_bio::end_io() is called in
> task context.
> 
> Patch 7 enables the async checksum generation for data writes, under
> experimental flags.

Ok, I think we can leave it under experimental for just one cycle.

> The series will increase btrfs_bio size by 8 bytes (+16 for the new
> structurs, -8 for the removal of btrfs_bio::fs_info).

The end result is still good, also the fs_info was really redundant.

> Since the new async_csum should be better than the csum offload anyway,
> we may want to deprecate the csum offload feature completely in the
> future.
> Thankfully csum offload feature is still behind the experimental flag,
> thus it should not affect end users.

Yeah we can remove it eventually. The idea was to provide a way to
possibly test different ways how to improve the performance but it's a
bandaid, there should be only one. The logic can decide based on various
factors but the sysfs tunable should not be needed.

> Qu Wenruo (7):
>   btrfs: replace BTRFS_MAX_BIO_SECTORS with BIO_MAX_VECS
>   btrfs: headers cleanup to remove unnecessary local includes
>   btrfs: remove btrfs_bio::fs_info by extracting it from
>     btrfs_bio::inode
>   btrfs: make sure all btrfs_bio::end_io is called in task context
>   btrfs: remove btrfs_fs_info::compressed_write_workers
>   btrfs: relax btrfs_inode::ordered_tree_lock
>   btrfs: introduce btrfs_bio::async_csum

Please add the patches to for-next as you see fit. I'll add them to
linux-next for early testing too.

