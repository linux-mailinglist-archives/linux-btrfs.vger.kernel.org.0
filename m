Return-Path: <linux-btrfs+bounces-3642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6632988D247
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 23:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36761F38985
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BE013E04A;
	Tue, 26 Mar 2024 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NLbNj619";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cATrzRrj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NLbNj619";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cATrzRrj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B68813DDA4
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493544; cv=none; b=AT8gofLFItic36Pk4ma5nKVr3mYi6thQGGGlx+Qx0ZTT4by1e0ic5sM8Nc+UhJrjpROFnNPGa8hI3aC9xm0gQsl1FWLVebCsW5sRPwM1dNaWs6lv/JsSYULGPgTq4RiRGjuCePfoygd+uvcZZl/A4e3JihYXt5As7R9AJfh3P+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493544; c=relaxed/simple;
	bh=El7QSknkfDHoJKCivz+dWmR8zZLxQEEqjjv6jVir5U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOXtnbGjWSHIsBhaHP2FuxEmZWlK1aAer4bvoOQ2DaNGRSF8JJmzku6HUoWOcnhLpZ2pFSvI+eJ6Xiha2CZEDTL49RM63UX2IaNfxWbkHhTMpRfl00/zHp3T/d1EcaDyjCSWhzn/rytrRYGs45ZSwX7QhOeDO6lUfhTZSpTi9ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NLbNj619; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cATrzRrj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NLbNj619; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cATrzRrj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04ACB3815A;
	Tue, 26 Mar 2024 22:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711493533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPNgtwtFXu50Zx4A2uvT4XoUG7OqYW5ZjUFSPqfIbSE=;
	b=NLbNj619UU2K9q6f3SGty7pzOOkOWEFtY1zkm/dWZZ4pj/1oJ4+Gh9S3k46+UrdFvg49IL
	ENruk62ts8Aj8EAJRv8zp+MohLSJbNgr5oKIPfSwEX9mydDnZwYtuLZx2tgDmJE4WGzdBr
	bnGR6rKeRPqik0xePXM0vXozSuB6wXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711493533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPNgtwtFXu50Zx4A2uvT4XoUG7OqYW5ZjUFSPqfIbSE=;
	b=cATrzRrjS9uX4PDmHz+A97StTH9rnlyj8WP36HUe9X49r4kqRlphIjbAHKMC14+J0nc2s/
	5TTX3dTKKnKeHsDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711493533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPNgtwtFXu50Zx4A2uvT4XoUG7OqYW5ZjUFSPqfIbSE=;
	b=NLbNj619UU2K9q6f3SGty7pzOOkOWEFtY1zkm/dWZZ4pj/1oJ4+Gh9S3k46+UrdFvg49IL
	ENruk62ts8Aj8EAJRv8zp+MohLSJbNgr5oKIPfSwEX9mydDnZwYtuLZx2tgDmJE4WGzdBr
	bnGR6rKeRPqik0xePXM0vXozSuB6wXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711493533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPNgtwtFXu50Zx4A2uvT4XoUG7OqYW5ZjUFSPqfIbSE=;
	b=cATrzRrjS9uX4PDmHz+A97StTH9rnlyj8WP36HUe9X49r4kqRlphIjbAHKMC14+J0nc2s/
	5TTX3dTKKnKeHsDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E5B1A13215;
	Tue, 26 Mar 2024 22:52:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id XRLsN5xRA2bzFQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 26 Mar 2024 22:52:12 +0000
Date: Tue, 26 Mar 2024 23:44:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: subvolume: output the prompt line only when
 the ioctl succeeded
Message-ID: <20240326224454.GU14596@suse.cz>
Reply-To: dsterba@suse.cz
References: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
 <20240301125631.GK2604@twin.jikos.cz>
 <20240326202349.GA1575630@zen.localdomain>
 <bafb239d-5c78-451d-b981-8d79aa3c1200@suse.com>
 <32c3c2fc-3f76-40e2-b876-36370f4aed85@suse.com>
 <20240326203443.GA3206298@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326203443.GA3206298@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NLbNj619;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cATrzRrj
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 04ACB3815A
X-Spam-Flag: NO

On Tue, Mar 26, 2024 at 01:34:43PM -0700, Boris Burkov wrote:
> On Wed, Mar 27, 2024 at 07:00:29AM +1030, Qu Wenruo wrote:
> > 
> > 
> > 在 2024/3/27 06:57, Qu Wenruo 写道:
> > > 
> > > 
> > > 在 2024/3/27 06:53, Boris Burkov 写道:
> > > > On Fri, Mar 01, 2024 at 01:56:31PM +0100, David Sterba wrote:
> > > > > On Tue, Feb 27, 2024 at 02:41:16PM +1030, Qu Wenruo wrote:
> > > > > > [BUG]
> > > > > > With the latest kernel patch to reject invalid qgroupids in
> > > > > > btrfs_qgroup_inherit structure, "btrfs subvolume create" or "btrfs
> > > > > > subvolume snapshot" can lead to the following output:
> > > > > > 
> > > > > >   # mkfs.btrfs -O quota -f $dev
> > > > > >   # mount $dev $mnt
> > > > > >   # btrfs subvolume create -i 2/0 $mnt/subv1
> > > > > >   Create subvolume '/mnt/btrfs/subv1'
> > > > > >   ERROR: cannot create subvolume: No such file or directory
> > > > > > 
> > > > > > The "btrfs subvolume" command output the first line, seemingly to
> > > > > > indicate a successful subvolume creation, then followed by an error
> > > > > > message.
> > > > > > 
> > > > > > This can be a little confusing on whether if the subvolume
> > > > > > is created or
> > > > > > not.
> > > > > > 
> > > > > > [FIX]
> > > > > > Fix the output by only outputting the regular line if the ioctl
> > > > > > succeeded.
> > > > > > 
> > > > > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > > > 
> > > > > Added to devel, thanks.
> > > > 
> > > > This patch breaks every test that creates snapshots or subvolumes and
> > > > expects the output in the outfile.
> > > > 
> > > > That's because it did:
> > > > s/Create a snapshot/Create snapshot/
> > > > 
> > > > Please run the tests when making changes! This failed on btrfs/001, so
> > > > it would have taken 1 second to see.
> > > 
> > > Wrong patch to blame?
> > > 
> > > The message is kept the same in the patch:
> > > 
> > > -        pr_verbose(LOG_DEFAULT,
> > > -               "Create a readonly snapshot of '%s' in '%s/%s'\n",
> > > -               subvol, dstdir, newname);
> > > -        pr_verbose(LOG_DEFAULT,
> > > -               "Create a snapshot of '%s' in '%s/%s'\n",
> > > -               subvol, dstdir, newname);
> > > 
> > > +        pr_verbose(LOG_DEFAULT,
> > > +               "Create a readonly snapshot of '%s' in '%s/%s'\n",
> > > +               subvol, dstdir, newname);
> > > +        pr_verbose(LOG_DEFAULT,
> > > +               "Create a snapshot of '%s' in '%s/%s'\n",
> > > +               subvol, dstdir, newname);
> > > 
> > > Thanks,
> > > Qu
> > 
> > OK, David seems to changed the output line when merging the patch...
> > 
> > That's something out of my reach.
> 
> Agreed. Sorry about the test rant.

I changed it so the message is unified with others, Anand promised to
add/fix the fstests filter. What fstests does is fragile and this is
unfortunatelly not the last time this happens.

