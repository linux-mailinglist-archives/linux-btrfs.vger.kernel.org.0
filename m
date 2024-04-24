Return-Path: <linux-btrfs+bounces-4536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C88C8B117C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C021F254C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8D416D4FA;
	Wed, 24 Apr 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ujOMGgXV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0vUsqL3a";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ujOMGgXV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0vUsqL3a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F116D4F0
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981208; cv=none; b=Tjve8fN7J+cGK2k1DsTzjZNdv8Dm6z42DWmpEScNEY2OzhbDO7Q26ea2GdIg3xukDTLy3e46GwwSROIvVi9f6y8f93jEFaEEte+bhvWvbB58+ik2QaigXPYAdrhbyFG06kS7JESejbVg00hblobkLcz90CSQLuQAblcVRJnElTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981208; c=relaxed/simple;
	bh=Ta0ZfDW1sol8TLZFhun7ds3NBicjxsq7viIuQ4zbNj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWgAT/16pr8+UZCHllTr9+qJWQ0CPsvIssMax2xpmsNFssEFqO4xqeP3dUJa9myGXkdn8F4ckamudAZVnyOq1ZHcxd69/79EBJibKH0OBsKWp4RWtl/KcAS+XcEiH83ZN0H02ozgqcxPesGlrGI4hf3Hp0wd81Af0g/PJBtvyok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ujOMGgXV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0vUsqL3a; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ujOMGgXV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0vUsqL3a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03F151FB9E;
	Wed, 24 Apr 2024 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713981205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5SFh8K6Txux8f65bKQm5I1NW2mzJHzs0J8NKVaQv+Vs=;
	b=ujOMGgXVxUQkB8C0fUfV/hYjH7cT3fPEiT2HfLIZ6AcSYD7Ymw8nNDkrbusjJCXxZmfEQ0
	k8lINiWwWt5Riz05NS+huAQeosnsnA7BYmPabJvD8kT/5c9Pfb6NvPBPX+7FEs3rmpTcZo
	6oLX/+mI6yXvJSnxQ07f7mY/Z26x5v0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713981205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5SFh8K6Txux8f65bKQm5I1NW2mzJHzs0J8NKVaQv+Vs=;
	b=0vUsqL3a/9q/iN9eIh5iVt85EIPTmeLNc1P3YT9qzzIYjEFVXvZy2VvgAHWiXiHkgKu8Pu
	rn85Xp6hjfgdiSDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713981205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5SFh8K6Txux8f65bKQm5I1NW2mzJHzs0J8NKVaQv+Vs=;
	b=ujOMGgXVxUQkB8C0fUfV/hYjH7cT3fPEiT2HfLIZ6AcSYD7Ymw8nNDkrbusjJCXxZmfEQ0
	k8lINiWwWt5Riz05NS+huAQeosnsnA7BYmPabJvD8kT/5c9Pfb6NvPBPX+7FEs3rmpTcZo
	6oLX/+mI6yXvJSnxQ07f7mY/Z26x5v0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713981205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5SFh8K6Txux8f65bKQm5I1NW2mzJHzs0J8NKVaQv+Vs=;
	b=0vUsqL3a/9q/iN9eIh5iVt85EIPTmeLNc1P3YT9qzzIYjEFVXvZy2VvgAHWiXiHkgKu8Pu
	rn85Xp6hjfgdiSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E86BF13690;
	Wed, 24 Apr 2024 17:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U4xTOBRHKWbjTwAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 24 Apr 2024 17:53:24 +0000
Date: Wed, 24 Apr 2024 12:53:20 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 07/17] btrfs: push extent lock into run_delalloc_nocow
Message-ID: <us75piztgsahzcmyo2ku4z4yh3pxb7zawhnxi6y5szjud3zs47@zsnytkzalj4z>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <60f8e6362e50086d796d8cdd44031d9496398b08.1713363472.git.josef@toxicpanda.com>
 <2dqiyvawsd6g3zxtfhgcmyv7i257l2hhgrd2zcpl3yumugbcnz@twvnaux5ahe6>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dqiyvawsd6g3zxtfhgcmyv7i257l2hhgrd2zcpl3yumugbcnz@twvnaux5ahe6>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,toxicpanda.com:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On  6:33 23/04, Goldwyn Rodrigues wrote:
> On 10:35 17/04, Josef Bacik wrote:
> > run_delalloc_nocow is a bit special as it walks through the file extents
> > for the inode and determines what it can nocow and what it can't.  This
> > is the more complicated area for extent locking, so start with this
> > function.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> 
> > ---
> >  fs/btrfs/inode.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 2083005f2828..f14b3cecce47 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -1977,6 +1977,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
> >  	 */
> >  	ASSERT(!btrfs_is_zoned(fs_info) || btrfs_is_data_reloc_root(root));
> >  
> > +	lock_extent(&inode->io_tree, start, end, NULL);
> > +
> >  	path = btrfs_alloc_path();
> >  	if (!path) {
> >  		ret = -ENOMEM;
> > @@ -2249,11 +2251,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
> >  	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
> >  	int ret;
> >  
> > -	/*
> > -	 * We're unlocked by the different fill functions below.
> > -	 */
> > -	lock_extent(&inode->io_tree, start, end, NULL);
> > -
> 
> So, you are adding this hunk in the previous patch and (re)moving it here.
> Do you think it would be better to merge this with the previous patch?

Ignore this comment. This patch series is doing just that and I should
have commented after looking at the series as a whole.

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>


