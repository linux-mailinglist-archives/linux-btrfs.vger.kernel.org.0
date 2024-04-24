Return-Path: <linux-btrfs+bounces-4529-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E52368B1100
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C91F1F22BCE
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 17:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43E316D9DA;
	Wed, 24 Apr 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kQqOH67m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kO+uMInv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HZ8mY0Iu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/q2H936y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A20616D9C0
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979616; cv=none; b=HmLuf4anz59NTb+wZO6DMJqd2CUSatnpGRjX1HkyqkOdHEhbjNub0VxVyg4BJmnmosvkj0O7B1MUmrcrarE04fKShSiLop8+GN+JalhmKu0dW8GblOGjdkSICdSN7nEUM6nE0Qxrow11vsVmalevkrlI+h/4bBBnnUQuvPlk1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979616; c=relaxed/simple;
	bh=lc9TY8QwoAowcMMThgkVuxiwuIo7BdznMwawOja6I/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEMMA/VFI+cP2Sa5KQ4Edfol9243R5jiMqxklSfbWJZW04xKUIXVE65u0vmweOuB97mDM7x1QTxIdzb0zTCtWGY59vv0rSiJPy67wFIiy16/15J4QkkoRddVzyWCuApzPlgeYoBHGveYBMD0MTIj7TmnRoqiBcRJ8GTYkGMNtxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kQqOH67m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kO+uMInv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HZ8mY0Iu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/q2H936y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72F3D2190C;
	Wed, 24 Apr 2024 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713979612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvyWnZlmBZrHe8kaBErTyxBfPyxO5YwqccfzErfgr0k=;
	b=kQqOH67mywTH9cUIJP0jwQMOyOi/RpNf0lyJkkRhU+Y6FeIGNZSjqPNETqnVOfU2FfOmFR
	ApqD7W52cPsqPhNuUcfoxzAnZIvGhAr+bS4t3o4vzmdos7XbRy8LvvloT9qWZB2Y+Vg582
	36dNqtF/CwzXudy4ixOf6YkIoKYqxVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713979612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvyWnZlmBZrHe8kaBErTyxBfPyxO5YwqccfzErfgr0k=;
	b=kO+uMInv5U5M5DPTn8HUA/8ESGCuGkcytilnf7mzVpDDj3oFI4Ig82dwPZNeR5rFsz7Vsc
	tKTpobscd+puxRAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713979611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvyWnZlmBZrHe8kaBErTyxBfPyxO5YwqccfzErfgr0k=;
	b=HZ8mY0IuwIK+W2b3AmOXgqT9lLfk5IMVclzv/10T7sG71d6uidCYfi3ky8I3HgL57p6t4O
	ocB9nl/ktRayKja+ZrBsTVmQw1iqwZ9uOkUHqnkLKGTlv7Hf6U0oL2w5Z/o+JtEl8Fcqu6
	sXcaJxsXITGCwBlxXtAfx/J7IeuIUCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713979611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvyWnZlmBZrHe8kaBErTyxBfPyxO5YwqccfzErfgr0k=;
	b=/q2H936yqZVvETRfs8OSC3MYjVmDxAFounj6IBgTmayK8BtNH2m5bnPs117X4gzyUQKS5l
	BcsBOouIBbAfX2Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6259813690;
	Wed, 24 Apr 2024 17:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gPZxF9tAKWb4SAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 24 Apr 2024 17:26:51 +0000
Date: Wed, 24 Apr 2024 12:26:46 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 06/17] btrfs: push the extent lock into
 btrfs_run_delalloc_range
Message-ID: <2jnvvngfbic6o3kwzs5vy6snlwla3gcj6txb57u74rk4xu3viu@53npdwba6etg>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <1d2952b7fccde719e25867471e61a0126e77e3b6.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d2952b7fccde719e25867471e61a0126e77e3b6.1713363472.git.josef@toxicpanda.com>
X-Spam-Flag: NO
X-Spam-Score: -3.08
X-Spam-Level: 
X-Spamd-Result: default: False [-3.08 / 50.00];
	BAYES_HAM(-2.28)[96.62%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On 10:35 17/04, Josef Bacik wrote:
> We want to limit the scope of the extent lock to be around operations
> that can change in flight.  Currently we hold the extent lock through
> the entire writepage operation, which isn't really necessary.
> 
> We want to protect to make sure nobody has updated DELALLOC.  In
> find_lock_delalloc_range we must lock the range in order to validate the
> contents of our io_tree.  However once we've done that we're safe to
> unlock the range and continue, as we have the page lock already held for
> the range.
> 
> We are protected from all operations at this point.
> 
> * mmap() - we're holding the page lock, thus are protected.
> * buffered writes - again, we're protected because we take the page lock
>   for the first and last page in our range for buffered writes so we
>   won't create new delalloc ranges in this area.
> * direct IO - we invalidate pagecache before attempting to write a new
>   area, which requires the page lock, so again are protected once we're
>   holding the page lock on this range.
> 
> Additionally this behavior actually already exists for compressed, we
> unlock the range as soon as we start to process the async extents, and
> re-lock it during compression.  So this is completely safe, and makes
> the locking more consistent.
> 
> Make this simple by just pushing the extent lock into
> btrfs_run_delalloc_range.  From there followup patches will push the
> lock further down into its users.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>


