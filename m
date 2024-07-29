Return-Path: <linux-btrfs+bounces-6849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3022693FEA0
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 21:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8096FB21FBB
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 19:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D40B188CA3;
	Mon, 29 Jul 2024 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1KUJL1ri";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H2jQ8KzM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xO/7T6UP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Spw41svV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2767D2E5
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722282934; cv=none; b=AMlfxa6l79DbcIDAbJSQ6Y2LTJ+JIJk/uZD9yRdDIql996HNaun22xXfcq4+BDRdh3bD48/fUmTXnhq74xB6w21M5MvowAyjbAvHZnL5HxqADPi4fhgiyfiL3a9iwtcfNcVvpxc+BDxynooSy7PzDcFPimfcHcw/ma5lPUWJ5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722282934; c=relaxed/simple;
	bh=9Cbngi89Y52EMF9eznAq/nzKMk3lwxDi/laEQOId9TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgbJmw7q6FTNVmScSl+NmN/taTGGRZcQGFmHYbGWsUlt4wnP9U82U1MZ28dmhMlwCy9mR0cQxYEm+rJnSxe8Ns58aljz+pv0ZJCptBRftr2vqIFbAZXIogoiF2hm4wvsC04LhQFI3F60uYm35hK9DjYXcSqAu76ePCt0L+3upQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1KUJL1ri; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H2jQ8KzM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xO/7T6UP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Spw41svV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E449A21BD5;
	Mon, 29 Jul 2024 19:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722282930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oORMTowLjcUMi5KWl5wpjZCrM1ZLa1F6PllI2ePPTBE=;
	b=1KUJL1ri33PjqAVoUIxM/Ej4VTAL4Xr2kK/HkNQ/4pZ3USXbgTtyn23Yw/EdVu/rl9usm9
	FXS+lZmS2iWK/P4AlUe8VpJxFC2t22mkXfCW9W+bO98lPbKpjWCzvmhHhTTyrRK5fvKezu
	CuoiFdq/4Al/tjAAVHgOd3sETLFAd0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722282930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oORMTowLjcUMi5KWl5wpjZCrM1ZLa1F6PllI2ePPTBE=;
	b=H2jQ8KzMGI2Tb419flC24NXY97F+L/FTdduz1CJg4k9HpZG6x1ZZGuB9U1C5FEoAl3JT0A
	luHTi13pnsPr9CDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="xO/7T6UP";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Spw41svV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722282929;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oORMTowLjcUMi5KWl5wpjZCrM1ZLa1F6PllI2ePPTBE=;
	b=xO/7T6UPwefqSkzEOfP2dmsy1EKfm3KeR9C6MDWd6zUrsqFS4yxUUlaRoVPkLXk0u8NIFp
	P+KQCUSwWbC3qrbShNuIqVhadVtfjris5yyEkBnkhcgZ9lbt3B78n2pLDlTiMe4ScJ+Kwu
	URKDLhgNYp23TVcUra5lChx7sqp3Vh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722282929;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oORMTowLjcUMi5KWl5wpjZCrM1ZLa1F6PllI2ePPTBE=;
	b=Spw41svVjvPHeanx7i1jAOGxXwScGHeX+ky7DHpNUEqDopVbLucN0/1jumJCWyAZcYhocU
	yhwsIlx0IQVWjMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2C051368A;
	Mon, 29 Jul 2024 19:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WA8QL7Hzp2bOQgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Jul 2024 19:55:29 +0000
Date: Mon, 29 Jul 2024 21:55:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: emit a warning about space cache v1 being
 deprecated
Message-ID: <20240729195528.GR17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <942fd7466a40978db591c57457616f22fb0640c6.1722271865.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <942fd7466a40978db591c57457616f22fb0640c6.1722271865.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: E449A21BD5

On Mon, Jul 29, 2024 at 12:51:10PM -0400, Josef Bacik wrote:
> We've been wanting to get rid of this for a while, add a message to
> indicate that this feature is going away and when so we can finally have
> a date when we're going to remove it.  The output looks like this
> 
> BTRFS warning (device nvme0n1): space cache v1 is being deprecated and will be removed in a future release
> BTRFS warning (device nvme0n1): please use -o space_cache=v2
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/super.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 0eda8c21d861..1f2e9900e410 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -682,8 +682,12 @@ bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned long *mount_
>  		ret = false;
>  
>  	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
> -		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE))
> +		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE)) {
>  			btrfs_info(info, "disk space caching is enabled");
> +			btrfs_warn(info,
> +		"space cache v1 is being deprecated and will be removed in a future release");
> +			btrfs_warn(info, "please use -o space_cache=v2");

Please don't split the printk message, the recommendation should be on
the same line as printk can insert another line between them.

> +		}
>  		if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
>  			btrfs_info(info, "using free-space-tree");
>  	}
> -- 
> 2.43.0
> 

