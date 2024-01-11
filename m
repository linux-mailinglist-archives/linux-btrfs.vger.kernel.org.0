Return-Path: <linux-btrfs+bounces-1394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCE282B1D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 16:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8751F22C38
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4345027C;
	Thu, 11 Jan 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="habdudYF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mwcWgu7G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="habdudYF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mwcWgu7G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2550270
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C3D2220FF;
	Thu, 11 Jan 2024 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704986887;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+bwKgndBH7AG/oBVleVnFxqjfe+oHZV1pkkmolIYp34=;
	b=habdudYFKXvfVQJaHxBskQac7W0H1L4P+yplRltDytIvvlvi+f/ZcRk1g3iCdeOlw80IjI
	FdjJon7zWAyz33g2IzJ144L4XVbrdV5SjWKXWjCULvjMnLcM8sIhHoUTi7LARNDdL60Ho7
	HHTJY53lnGORtANDXI1Tp2s/ddZ87nM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704986887;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+bwKgndBH7AG/oBVleVnFxqjfe+oHZV1pkkmolIYp34=;
	b=mwcWgu7GXiVNgyssawwcYYejd6sbjr6yxQddith98fUl5SmNpPFG37OfhjkJ8DlEPY0LzI
	tFfmSdKyX3GmiOBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704986887;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+bwKgndBH7AG/oBVleVnFxqjfe+oHZV1pkkmolIYp34=;
	b=habdudYFKXvfVQJaHxBskQac7W0H1L4P+yplRltDytIvvlvi+f/ZcRk1g3iCdeOlw80IjI
	FdjJon7zWAyz33g2IzJ144L4XVbrdV5SjWKXWjCULvjMnLcM8sIhHoUTi7LARNDdL60Ho7
	HHTJY53lnGORtANDXI1Tp2s/ddZ87nM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704986887;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+bwKgndBH7AG/oBVleVnFxqjfe+oHZV1pkkmolIYp34=;
	b=mwcWgu7GXiVNgyssawwcYYejd6sbjr6yxQddith98fUl5SmNpPFG37OfhjkJ8DlEPY0LzI
	tFfmSdKyX3GmiOBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0639A132FA;
	Thu, 11 Jan 2024 15:28:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id m/msAAcJoGVwdQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jan 2024 15:28:07 +0000
Date: Thu, 11 Jan 2024 16:27:47 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Anand Jain <anand.jain@oracle.com>, Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not restrict writes to devices
Message-ID: <20240111152747.GE31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2fe68e18d89abb7313392c8da61aaa9881bbe945.1704917721.git.josef@toxicpanda.com>
 <2878378f-358c-46ca-bc3b-d819f78658f4@oracle.com>
 <20240111152452.GD31555@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111152452.GD31555@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Thu, Jan 11, 2024 at 04:24:52PM +0100, David Sterba wrote:
> On Thu, Jan 11, 2024 at 04:59:00PM +0800, Anand Jain wrote:
> > On 1/11/24 04:16, Josef Bacik wrote:
> > > This is a version of ead622674df5 ("btrfs: Do not restrict writes to
> > > btrfs devices"), which pushes this restriction closer to where we use
> > > bdev_open_by_path.
> > 
> > 
> > > This was in the mount path, and changed when we
> > > switched to the new mount api,
> > 
> >   New mount api patchset [1]:
> >       [1]  [PATCH v3 00/19] btrfs: convert to the new mount API
> > 
> > Do you have a specific patch here for me to understand the changes 
> > you're talking about?
> > 
> > 
> > > and with that loss we suddenly weren't
> > > able to mount.
> > 
> > With the patchset [1] already in the mainline, I am able to mount.
> > It looks like I'm missing something. What is the failing test case?
> 
> I don't think that mainline fails, I don't know what exactly Josef
> tested though. There's a big merge diff
> affc5af36bbb62073b6aaa4f4459b38937ff5331 and there's a manual resolution
> by Linus moving the BLK_OPEN_RESTRICT_WRITES flags to the device open.

The key part of the diff is this:

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@@ -143,92 -141,487 +141,493 @@@ enum 
++/* No support for restricting writes to btrfs devices yet... */
++static inline blk_mode_t btrfs_open_mode(struct fs_context *fc)
++{
++      return sb_open_mode(fc->sb_flags) & ~BLK_OPEN_RESTRICT_WRITES;
++}
 +
@@@ -2096,6 -1770,309 +1776,309 @@@ static int btrfs_statfs(struct dentry *
 -      blk_mode_t mode = sb_open_mode(fc->sb_flags);
++      blk_mode_t mode = btrfs_open_mode(fc);

the remaining changes are independent.

