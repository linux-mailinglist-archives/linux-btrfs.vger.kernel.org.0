Return-Path: <linux-btrfs+bounces-16307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E2FB32282
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 20:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADD05653D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D49C2C158F;
	Fri, 22 Aug 2025 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ilCwU178";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OTyH5+F1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GH66rmLv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uUXJRvfN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E0B2C08D9
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889035; cv=none; b=o4X849fuAsaW7OK7Ybj20IBLQJpyS/ZdJiMRDubyepSCNPaiyTsYh9v2ZLJRnb11ER33ywATJ0Tew/n7c8wkHqM9FRigT5T7X8DVfCpUDrqMPIyaSjipMXk7nvjgVNl03q+cWI90T5soo8AbTuRsk2m+xqMHx1VqFC7qWjsRCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889035; c=relaxed/simple;
	bh=giCDMKL30qx4q34dX7Ti3B3plQfg8pbwQSppFciOMIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXnj6cdTgVuzefs5zFkoqU43UsHbJrxRvwHumvujZf4A/fs+VLQU7tTWzNRvJBwAq2DgKiIKR0FiBtfCDtGgUq/8C6OpcSWQgWA196xpEE8pWZiqiYZbaMuQUyLHJmY2/6h8cG+Q8MI+BZwIp8rCkPjZcflJ2ZvmBh+3wbEwNds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ilCwU178; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OTyH5+F1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GH66rmLv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uUXJRvfN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 86FA31F385;
	Fri, 22 Aug 2025 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755889031;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4uodZWsRYCDKGfrW7HeEdKVmutQppzEqk1lt9/yb2w=;
	b=ilCwU178QTXZH2gkJCGDoeRvDP+tzuHiEOpzic4l79wxbK9zXorfvHK5RWxNUO15LFdDoj
	JiP6M0XfxR99bSbb0vx2HtxdVZDOk40BCNwmT2uT0OEfau3Ix1qfMxXB1VXyQ20HjL/qcK
	Z7zNM9ic9sgLg4oC++P1Fr28RFFSQJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755889031;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4uodZWsRYCDKGfrW7HeEdKVmutQppzEqk1lt9/yb2w=;
	b=OTyH5+F1aIfOjSRlGdAfFtd4es4heFne9ESVY4byu/N3NbMw7ExCWUeN50RY2PBBkzGWI9
	vGh4RygISsepJtAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GH66rmLv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uUXJRvfN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755889030;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4uodZWsRYCDKGfrW7HeEdKVmutQppzEqk1lt9/yb2w=;
	b=GH66rmLvSXKI2WtmIE8s4kJDJrlH6xVlj5+gH3/VFXOOjyDaNhX+NV3dGCVhjArSYwZoMC
	Bq7IyD3dgMPOFojC+1qJEXNo2m4BolJT3yB/+8vbDA5k6IbhoQx02/5+OZ116QO0gBjvc/
	ERijMiObVW9QJnSr8IUvHpW6jqDcFQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755889030;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4uodZWsRYCDKGfrW7HeEdKVmutQppzEqk1lt9/yb2w=;
	b=uUXJRvfNSi+5hDgDoJdIhVR5SU+/q//jCZzbVSByylOvb159LZm5EDWP5uAMDsKaxA9S5p
	uIBM4fsaYSRMqIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D32E13931;
	Fri, 22 Aug 2025 18:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cYqWFoa9qGgeVQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 22 Aug 2025 18:57:10 +0000
Date: Fri, 22 Aug 2025 20:57:09 +0200
From: David Sterba <dsterba@suse.cz>
To: Calvin Owens <calvin@wbinvd.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Sun YangKai <sunk67188@gmail.com>,
	clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	neelx@suse.com
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
Message-ID: <20250822185709.GY22430@suse.cz>
Reply-To: dsterba@suse.cz
References: <2022221.PYKUYFuaPT@saltykitkat>
 <810d2b19-47ed-4902-bd8d-eb69bacbf0c6@gmx.com>
 <aKiSpTytAOXgHan5@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKiSpTytAOXgHan5@mozart.vkv.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 86FA31F385
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,gmail.com,fb.com,suse.com,toxicpanda.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wbinvd.org:email,suse.cz:dkim,suse.cz:mid,suse.cz:replyto]
X-Spam-Score: -4.21

On Fri, Aug 22, 2025 at 08:54:13AM -0700, Calvin Owens wrote:
> On Friday 08/22 at 19:53 +0930, Qu Wenruo wrote:
> > 在 2025/8/22 19:50, Sun YangKai 写道:
> > > > The compression level is meaningless for lzo, but before commit
> > > > 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> > > > it was silently ignored if passed.
> > > > 
> > > > After that commit, passing a level with lzo fails to mount:
> > > >      BTRFS error: unrecognized compression value lzo:1
> > > > 
> > > > Restore the old behavior, in case any users were relying on it.
> > > > 
> > > > Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
> > > > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > > > ---
> > > > 
> > > >   fs/btrfs/super.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > > > index a262b494a89f..7ee35038c7fb 100644
> > > > --- a/fs/btrfs/super.c
> > > > +++ b/fs/btrfs/super.c
> > > > @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context
> > > > *ctx,>
> > > >   		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > > >   		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> > > >   		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > > > 
> > > > -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
> > > > +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
> > > > 
> > > >   		ctx->compress_type = BTRFS_COMPRESS_LZO;
> > > >   		ctx->compress_level = 0;
> > > >   		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > > > 
> > > > --
> > > > 2.47.2
> > > 
> > > A possible improvement would be to emit a warning in
> > > btrfs_match_compress_type() when @may_have_level is false but a
> > > level is still provided. And the warning message can be something like
> > > "Providing a compression level for {compression_type} is not supported, the
> > > level is ignored."
> > > 
> > > This way:
> > > 1. users receive a clearer hint about what happened,
> > 
> > I'm fine with the extra warning, but I do not believe those kind of users
> > who provides incorrect mount option will really read the dmesg.
> > 
> > > 2. existing setups relying on this behavior continue to work,
> > 
> > Or let them fix the damn incorrect mount option.
> 
> You're acting like I'm asking for "compress=lzo:iamafancyboy" to keep
> working here. I think what I proposed is a lot more reasonable than
> that, I'm *really* surprised you feel so strongly about this.
> 
> In my case it was actually little ARM boards with an /etc/fstab
> generated by templating code that didn't understand lzo is special.
> 
> I'm not debating that it's incorrect (I've already fixed it). But given
> that passing the level has worked forever,

Which is the reason to restore accepting the level, it's observable
behaviour and it also has impact on functionality when the mount fails.

