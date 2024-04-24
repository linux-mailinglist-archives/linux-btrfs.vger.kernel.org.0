Return-Path: <linux-btrfs+bounces-4530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A00028B1157
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A441C250ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1C16D4DF;
	Wed, 24 Apr 2024 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z0QvMM8t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UF19c4kO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z0QvMM8t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UF19c4kO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5497413777A
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980508; cv=none; b=VNZ9EPSxt+n2vSsTb6dzwd6kN221mPvpVTTz/7wAYoItqeHA27bKWtoSoU3NbzQVweY7fyvXXiIdmmrLCC9FEl8g74i6ZSWogiec1NDWF4dn4REqAtCBxgheLrYBHkDqYRbftmaZ8CCn+k6/ehfGVTvA4l8pyadD74BRZevl8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980508; c=relaxed/simple;
	bh=aPvjfvRWrqFgvaS9Gj4NlSrvm8ip952pZHH9f79c56o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnprpD2GvCKUUoOvJQ92aoqVnu38qbelVlmsCeWQsn7UX+G/LIwZSCY8YE/MQBL0/zn1htIlPDPaA5wjff+2xLuqEv1C7n5H0vu2VWADCzlX5VWGqhbGWUDU0e0AqOufP/uFko4LUYz9ZvfOWg753uIz4oQ/ISTx0L2QVRlLa+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z0QvMM8t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UF19c4kO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z0QvMM8t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UF19c4kO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 731DB21AA7;
	Wed, 24 Apr 2024 17:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713980505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=weIqiIq6ZaK1JI36XeJ6Oy7nH+BYGVQrs1cgr3TCM0M=;
	b=z0QvMM8t8+1HRCH9om+mFrWfoYJHDBMpjnz+/daRG6+pvDgf/OXlsrclsLInuYTSMF3u/X
	5q8Oc8t2qSEBlgj5OUbWqxE5PWOAwypxiXNYhcPEOf+9d7xeN3YvZALlML3r2/m3GxZjWu
	US/uJ0IxyAJO+vG0cNftZ8lxt74fJBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713980505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=weIqiIq6ZaK1JI36XeJ6Oy7nH+BYGVQrs1cgr3TCM0M=;
	b=UF19c4kOGGHaO4vbMt7vGsyoZpVGMjXxc/+R31zfIS9GIJjZHHM8ymssD6KoDMiTl5tp5/
	Lwh4Npbgmr60+CAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713980505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=weIqiIq6ZaK1JI36XeJ6Oy7nH+BYGVQrs1cgr3TCM0M=;
	b=z0QvMM8t8+1HRCH9om+mFrWfoYJHDBMpjnz+/daRG6+pvDgf/OXlsrclsLInuYTSMF3u/X
	5q8Oc8t2qSEBlgj5OUbWqxE5PWOAwypxiXNYhcPEOf+9d7xeN3YvZALlML3r2/m3GxZjWu
	US/uJ0IxyAJO+vG0cNftZ8lxt74fJBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713980505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=weIqiIq6ZaK1JI36XeJ6Oy7nH+BYGVQrs1cgr3TCM0M=;
	b=UF19c4kOGGHaO4vbMt7vGsyoZpVGMjXxc/+R31zfIS9GIJjZHHM8ymssD6KoDMiTl5tp5/
	Lwh4Npbgmr60+CAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67AD113690;
	Wed, 24 Apr 2024 17:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3UKyGFlEKWbYTAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 24 Apr 2024 17:41:45 +0000
Date: Wed, 24 Apr 2024 12:41:40 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 09/17] btrfs: push extent lock down in run_delalloc_nocow
Message-ID: <ofpyqnp3vkefu477qx2e6sozi3ehs7e62g6fwdippvd56kogc7@5fzipi5gxu4o>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <be4f89a0ad01fc580a11bfe52300a0c2e7669cc4.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be4f89a0ad01fc580a11bfe52300a0c2e7669cc4.1713363472.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On 10:35 17/04, Josef Bacik wrote:
> run_delalloc_nocow is a little special because we use the file extents
> to see if we can nocow a range.  We don't actually need the protection
> of the extent lock to look at the file extents at this point however.
> We are currently holding the page lock for this range, so we are
> protected from anybody who would simultaneously be modifying the file
> extent items for this range.
> 
> * mmap() - we're holding the page lock.
> * buffered writes - we're holding the page lock.
> * direct writes - we're holding the page lock and direct IO has to flush
>   page cache before it's able to continue.
> * fallocate() - all callers flush the range and wait on ordered extents
>   while holding the inode lock and the mmap lock, so we are again saved
>   by the page lock.
> 
> We want to use the extent lock to protect
> 
> 1) The mapping tree for the given range.
> 2) The ordered extents for the given range.
> 3) The io_tree for the given range.
> 
> Push the extent lock down to cover these operations.  In the
> fallback_to_cow() case we simply lock before doing anything and rely on
> the cow_file_range() helper to handle it's range properly.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>


