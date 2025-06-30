Return-Path: <linux-btrfs+bounces-15115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C353AAEE451
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 18:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD73E162DEC
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE48628DEFB;
	Mon, 30 Jun 2025 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xEtimHtl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6JJkci/i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xEtimHtl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6JJkci/i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA61DFF7
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300497; cv=none; b=YHd0w5FGLMAZfTs9NJlbIbfnRSHPDijxdTrmv1gXcmtwgWdgb87vNSO1/1XroYYDAqriKT0+O0dMYF4HiL/ql3fRZOj+aM9FFMY1nWAm8rVZ/LSGZjArJPULHX1s0ke6HptKuHlCnXXrSzRb6kuXlru80z68GpFCrq5FVFqFRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300497; c=relaxed/simple;
	bh=RqeFtQJdXisvoWj7MUkp1naRa8pNik1ehRic4+r2Zmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVsaiL3vG9u71Y3SP3IPHNHpNPvWg/xL6duOor8JvV1db31SnXMm0PG4BWjIe0tfPdENvhcLpzdgzNj10BCNvcxi3/mhiWcgwWtxUNhtbBnVibN4rfcRaEVN2oNenmFfumC3aWrw9vzuBPvLJIeTuL0/vdAv/TDJaqRt55Ph4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xEtimHtl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6JJkci/i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xEtimHtl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6JJkci/i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ADBD01F393;
	Mon, 30 Jun 2025 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751300491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce0HVruMi7PwsR9AjVpWwOix5Avmrt8s10uTflZzGQY=;
	b=xEtimHtlYVZ/FDxraAodPnJlTAkvfyo8Oank/PuRaoOBaFPOIT6K7y4rrcheX8C9eVjLt4
	QXdATctwUCShUf3gu80fQEBT69eSMvA5P6t4Wwa0JquXK8bLQ2jnPPSdWMjv29Z/e8Zo43
	MrZXJV1cxmJf3IadyCAfcYjFndP6MyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751300491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce0HVruMi7PwsR9AjVpWwOix5Avmrt8s10uTflZzGQY=;
	b=6JJkci/iGSfnNAWn72huny48glXiCdcF0LAx+Typl4sxFVd++UFtULKyki9BaiqWql8MXf
	DvEoLJZtRdtuOgCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xEtimHtl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="6JJkci/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751300491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce0HVruMi7PwsR9AjVpWwOix5Avmrt8s10uTflZzGQY=;
	b=xEtimHtlYVZ/FDxraAodPnJlTAkvfyo8Oank/PuRaoOBaFPOIT6K7y4rrcheX8C9eVjLt4
	QXdATctwUCShUf3gu80fQEBT69eSMvA5P6t4Wwa0JquXK8bLQ2jnPPSdWMjv29Z/e8Zo43
	MrZXJV1cxmJf3IadyCAfcYjFndP6MyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751300491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce0HVruMi7PwsR9AjVpWwOix5Avmrt8s10uTflZzGQY=;
	b=6JJkci/iGSfnNAWn72huny48glXiCdcF0LAx+Typl4sxFVd++UFtULKyki9BaiqWql8MXf
	DvEoLJZtRdtuOgCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93F5A13983;
	Mon, 30 Jun 2025 16:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v9fjI4u5YmgbFwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 30 Jun 2025 16:21:31 +0000
Date: Mon, 30 Jun 2025 18:21:30 +0200
From: David Sterba <dsterba@suse.cz>
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: open code RCU for device name
Message-ID: <20250630162130.GK31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1750858539.git.dsterba@suse.com>
 <1e539dfd73debc86ddc7c1b1716f86ace14d51aa.1750858539.git.dsterba@suse.com>
 <20250630102457.BFB9.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630102457.BFB9.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: ADBD01F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Mon, Jun 30, 2025 at 10:24:57AM +0800, Wang Yugui wrote:
> Hi,
> 
> > The RCU protected string is only used for a device name, and RCU is used
> > so we can print the name and eventually synchronize against the rare
> > device rename in device_list_add().
> > 
> > We don't need the whole API just for that. Open code all the helpers and
> > access to the string itself.
> > 
> > Notable change is in device_list_add() when the device name is changed,
> > which is the only place that can actually happen at the same time as
> > message prints using the device name under RCU read lock.
> > 
> > Previously there was kfree_rcu() which used the embedded rcu_head to
> > delay freeing the object depending on the RCU mechanism. Now there's
> > kfree_rcu_mightsleep() which does not need the rcu_head and waits for
> > the grace period.
> > 
> > Sleeping is safe in this context and as this is a rare event it won't
> > interfere with the rest as it's holding the device_list_mutex.
> > 
> > Straightforward changes:
> > 
> > - rcu_string_strdup -> kstrdup
> > - rcu_str_deref -> rcu_dereference
> > - drop ->str from safe contexts
> > 
> > Historical notes:
> > 
> > Introduced in 606686eeac45 ("Btrfs: use rcu to protect device->name")
> > with a vague reference of the potential problem described in
> > https://lore.kernel.org/all/20120531155304.GF11775@ZenIV.linux.org.uk/ .
> > 
> > The RCU protection looks like the easiest and most lightweight way of
> > protecting the rare event of device rename racing device_list_add()
> > with a random printk() that uses the device name.
> > 
> > Alternatives: a spin lock would require to protect the printk
> > anyway, a fixed buffer for the name would be eventually wrong in case
> > the new name is overwritten when being printed, an array switching
> > pointers and cleaning them up eventually resembles RCU too much.
> > 
> > The cleanups up to this patch should hide special case of RCU to the
> > minimum that only the name needs rcu_dereference(), which can be further
> > cleaned up to use btrfs_dev_name().
> > 
> 
> There is still rcu warning when 'make  W=1 C=1'
> 
> /usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21: warning: incorrect type in argument 1 (different address spaces)
> /usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21:    expected void const *objp
> /usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21:    got char const [noderef] __rcu *name
> 
> static void btrfs_free_device(struct btrfs_device *device)
> {
>     WARN_ON(!list_empty(&device->post_commit_list));
>     /* No need to call kfree_rcu(), nothing is reading the device name. */
> L405:    kfree(device->name);
> 
> do we need rcu_dereference here?
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -402,7 +402,7 @@ static void btrfs_free_device(struct btrfs_device *device)
>  {
>         WARN_ON(!list_empty(&device->post_commit_list));
>         /* No need to call kfree_rcu(), nothing is reading the device name. */
> -       kfree(device->name);
> +       kfree(rcu_dereference(device->name));

I got notified by the build bots (not CCed to the mailinglis) about
this. The dereference is not needed, the comment says why. The checkers
do not distinguish the context, some of them are safe like when the
device is being set up and not yet accessible by other processes, and at
deletion time, like here.

As we want to keep the __rcu annotation the rcu dereference is the
easiest workaround.

