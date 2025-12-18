Return-Path: <linux-btrfs+bounces-19865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D88CCD84E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 21:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3CF63033DE6
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 20:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621212C08C0;
	Thu, 18 Dec 2025 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KBhlDxzL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XQaWXPQs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uo0wjWSd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1UgZ37kL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30821C17D
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766089536; cv=none; b=qayA5sklp0/oqQXTxk+WyqsXEK2D6VgGTJNHrqGtm+OEJV174TK0ndsOLdt2qQB2NxQjipaj/dgahh5CTWmkQPR721aExuspwzT94WBJ7szSW6IogC7vMis5sCRek1M80JPU2oH3BKefsa+POaT64taWv6HEtG31f/b+HUeYbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766089536; c=relaxed/simple;
	bh=N0Zrcmk5zQGGLXHckSQNDX0i3/XudPEuxgT0G8vD8AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jczup+G1liD3HviOQX7OzO9e9ybk2Ra7iuJoT6qqsUqlCwkYpwxaThWfq62l/x8utk849Bi8klmJtmFoiNsdC5kbTBRxMjHz9eFCfEFS/zSxRYk5PVUzUujSCNS9S1DufNaLWdpL0sj2Cau3NdOnkW26quuwLCJ1zZEHNiKvw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KBhlDxzL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XQaWXPQs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uo0wjWSd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1UgZ37kL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 104543369C;
	Thu, 18 Dec 2025 20:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766089532;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ffMv1OI4nEpvyN+nf6YBwAqrBkXIjA5M22PCtdKxGs=;
	b=KBhlDxzLbVdgx7ZdSNiY4LwfbLxtqzzAH9P2gxGX805xWujSQGnK+OlnQyq2GBIUfxf25e
	keB2STtEAlbEVEI2Kn7fwj79uFXs5fRkDlDw5ghYmqfY1AEhsji+ChOauY/rNlDB5NNHnS
	dswnAbD4jnwMRwCGIqkaA1yWVKj3rfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766089532;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ffMv1OI4nEpvyN+nf6YBwAqrBkXIjA5M22PCtdKxGs=;
	b=XQaWXPQsnMJDb9gBvrEQhPKEsZFOrtjTjhKqad6sohfmO43OdtBLk1u75mZ98h3HZCeVEp
	gGSNaPqCKTPZKpBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uo0wjWSd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1UgZ37kL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766089531;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ffMv1OI4nEpvyN+nf6YBwAqrBkXIjA5M22PCtdKxGs=;
	b=uo0wjWSdJNQzoQbowzWm/T32IQ2Fu8rCjiHX6/7/KLbx7AebTfoLBL2c3DLjiFHIH64oa8
	dyIFZm4sghd3kfKPo4ZxZ507nJKkktdsU/PJGodOBzYbya7mgdKavimcMfPe6YLjhoFqRc
	bcbiFJzuxNlf83DkuAZwplgVkawF3vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766089531;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ffMv1OI4nEpvyN+nf6YBwAqrBkXIjA5M22PCtdKxGs=;
	b=1UgZ37kLenzXqa4XsSe9bFG+uD6wwdF0VJfXFOIHnpe8F7u/xmLMnjBH8p9yEiIIrnBNo0
	oClx0IxtfST1DlAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA48A3EA63;
	Thu, 18 Dec 2025 20:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kQEGOTpjRGkaWgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 18 Dec 2025 20:25:30 +0000
Date: Thu, 18 Dec 2025 21:25:25 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v5 2/4] btrfs: zoned: show statistics about zoned
 filesystems in mountstats
Message-ID: <20251218202525.GR3195@twin.jikos.cz>
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
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 104543369C
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,wdc.com:email];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

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

Please don't use single letter variables (other than i for indexing).

