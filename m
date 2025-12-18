Return-Path: <linux-btrfs+bounces-19867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B17CCD869
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 21:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52B05304F670
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2B02D0C64;
	Thu, 18 Dec 2025 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ym9RsSN3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TPWRp8mt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ym9RsSN3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TPWRp8mt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F428641F
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766089615; cv=none; b=HmkW9u3WJKchXPPyKDpsm+SpaBzoxNKTmxNqTRfFYIKBOfQAc5ox+ierv9cvVDnCjSnkLk6tAqc9rLWul48zBGgSXYTLQihtNty+Q5v+pozJiX2wAm2LRLkFWMJVADUPG4zAFIjIY1kXOFdGqwo8Ltdonksva8Cprc4r/qfliTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766089615; c=relaxed/simple;
	bh=eQRjG4EgIjLt5HgTISAppAtfTrfORbVXaUfKpnI7uvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVrm5/6YV1kU6hHPItTEWNc/i5jYkN2jPHYVLxTkddPjRRv2Zjz7+mVGCJjodWGhtLyuIdU78A/i+PcjZ2qmjgtp3iQka2cMNuWm2NLsEP6SLI7zRhaqQR7yfnticzh4VRNzsG9uD54dKsBXK6TbtZhKNi4bgnJtDhip5vr8PwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ym9RsSN3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TPWRp8mt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ym9RsSN3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TPWRp8mt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 219335BCCE;
	Thu, 18 Dec 2025 20:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766089612;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpHhOvw9zXbjvHsNTPGUMRWKE/B/HGyKkrOBy6u/OTE=;
	b=ym9RsSN3c/s4ndzzfxlh7EcJmkAwAWqHzzR674kFg5L0c5cXJLMjLHuJW2zv7hNMjqeIET
	k/SkyxHrwtMsTQ8RtlJRVLYrXweu4pQdd5MJR+sY/K7+cuZuGaidirbOir35tWGhWlxjRZ
	zMi9o9KVQToHZAebGeJQYnKFyrfwIYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766089612;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpHhOvw9zXbjvHsNTPGUMRWKE/B/HGyKkrOBy6u/OTE=;
	b=TPWRp8mtXjm8fqdkuILAJYFNDJViyr2Fr1qQotfaXXtxA7LJnn1+7I1WkPYrDtrI6OM0Br
	EW6WRZc9TkHG5fAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ym9RsSN3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TPWRp8mt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766089612;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpHhOvw9zXbjvHsNTPGUMRWKE/B/HGyKkrOBy6u/OTE=;
	b=ym9RsSN3c/s4ndzzfxlh7EcJmkAwAWqHzzR674kFg5L0c5cXJLMjLHuJW2zv7hNMjqeIET
	k/SkyxHrwtMsTQ8RtlJRVLYrXweu4pQdd5MJR+sY/K7+cuZuGaidirbOir35tWGhWlxjRZ
	zMi9o9KVQToHZAebGeJQYnKFyrfwIYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766089612;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpHhOvw9zXbjvHsNTPGUMRWKE/B/HGyKkrOBy6u/OTE=;
	b=TPWRp8mtXjm8fqdkuILAJYFNDJViyr2Fr1qQotfaXXtxA7LJnn1+7I1WkPYrDtrI6OM0Br
	EW6WRZc9TkHG5fAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 030503EA63;
	Thu, 18 Dec 2025 20:26:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +9eVAIxjRGlYWgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 18 Dec 2025 20:26:52 +0000
Date: Thu, 18 Dec 2025 21:26:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v5 2/4] btrfs: zoned: show statistics about zoned
 filesystems in mountstats
Message-ID: <20251218202650.GS3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251217134139.275174-1-johannes.thumshirn@wdc.com>
 <20251217134139.275174-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217134139.275174-3-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,wdc.com:email,twin.jikos.cz:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,wdc.com:email,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 219335BCCE
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Wed, Dec 17, 2025 at 02:41:37PM +0100, Johannes Thumshirn wrote:
> Add statistics output to /proc/<pid>/mountstats for zoned BTRFS, similar
> to the zoned statistics from XFS in mountstats.
> 
> The output for /proc/<pid>/mountstats on an example filesystem will be as
> follows:
> 
>   device /dev/vda mounted on /mnt with fstype btrfs
>     zoned statistics:
>           active block-groups: 7
>             reclaimable: 0
>             unused: 5
>             need reclaim: false
>           data relocation block-group: 1342177280
>           active zones:
>             start: 1073741824, wp: 268419072 used: 0, reserved: 268419072, unusable: 0
>             start: 1342177280, wp: 0 used: 0, reserved: 0, unusable: 0
>             start: 1610612736, wp: 49152 used: 16384, reserved: 16384, unusable: 16384
>             start: 1879048192, wp: 950272 used: 131072, reserved: 622592, unusable: 196608
>             start: 2147483648, wp: 212238336 used: 0, reserved: 212238336, unusable: 0
>             start: 2415919104, wp: 0 used: 0, reserved: 0, unusable: 0
>             start: 2684354560, wp: 0 used: 0, reserved: 0, unusable: 0
> 
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/super.c | 13 ++++++++++++
>  fs/btrfs/zoned.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h |  8 +++++++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index a37b71091014..e382acec2b1e 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2485,6 +2485,18 @@ static void btrfs_shutdown(struct super_block *sb)
>  }
>  #endif
>  
> +static int btrfs_show_stats(struct seq_file *s, struct dentry *root)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
> +
> +	if (btrfs_is_zoned(fs_info)) {
> +		btrfs_show_zoned_stats(fs_info, s);
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct super_operations btrfs_super_ops = {
>  	.drop_inode	= btrfs_drop_inode,
>  	.evict_inode	= btrfs_evict_inode,
> @@ -2500,6 +2512,7 @@ static const struct super_operations btrfs_super_ops = {
>  	.unfreeze_fs	= btrfs_unfreeze,
>  	.nr_cached_objects = btrfs_nr_cached_objects,
>  	.free_cached_objects = btrfs_free_cached_objects,
> +	.show_stats	= btrfs_show_stats,
>  #ifdef CONFIG_BTRFS_EXPERIMENTAL
>  	.remove_bdev	= btrfs_remove_bdev,
>  	.shutdown	= btrfs_shutdown,
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 359a98e6de85..fa61276058d8 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2984,3 +2984,57 @@ int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num
>  
>  	return 0;
>  }
> +
> +void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
> +{
> +	struct btrfs_block_group *bg;
> +	u64 data_reloc_bg;
> +	u64 treelog_bg;
> +
> +	seq_puts(s, "\n  zoned statistics:\n");

I meant to comment here as in a long function searching for the
identifiers requires adding word boundaries to like \<s\>. Fixed in
for-next.

