Return-Path: <linux-btrfs+bounces-14157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BC9ABECE0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 09:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528831BA5523
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 07:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34D2356A9;
	Wed, 21 May 2025 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W76pryMp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2TB2Jlms";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W76pryMp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2TB2Jlms"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4C123536B
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811754; cv=none; b=cBG5KN//48Ez+d1wbRdS9YgQowxS2J5P6cvOb3jIT+rBCytaHYtnK6dlMWtLgG6Qrs91tSjN5pIWM/+Z/ENlvIRT2TRlVrdkuY2iodK9WLX08KHb3/PbUIVKa8FoHh0BFGdA+yuY+XdtqO4hg4cUCueS5UEMnLpvwTSq+iMJto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811754; c=relaxed/simple;
	bh=AGKr+mGezUGt/p2GgP9EyN/QHwnCtUpcpBV0Eud4wJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjwjuNue8mAgQ3dlTBLf64ileiI6KWkpMkzBStngdbrksZY6lkAAbdgryK+m7IvIlIJe3zc2hn5DW21sUe5Lbctxn/FL8Q4F3UeUQQ6KPgacnKACqluBomAhTOdCFv0UCArQS7DEYz2tUJdXvHunW8Dhk/PT5+1Y+j2RpM404x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W76pryMp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2TB2Jlms; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W76pryMp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2TB2Jlms; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C93D522CDC;
	Wed, 21 May 2025 07:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747811750;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+KLk1TtXYYtuTrTsrVWvukK0xOwIuukydiiBE6m4xTE=;
	b=W76pryMpm0rpwG7iSPqjhFjmPr4FG/gJ1W6TrgZYdYFVH+BGwsYuNo4Fd8KFYimNMPoSKS
	WmyTt4+GJNMbsEwHSe21hGkeALCY8LFROLfzpZIYjx2ysqJRZg2XJX3i/QmEq6FoLD9szk
	qIYzfudLcf2XnXuTJcApTUT0/X764zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747811750;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+KLk1TtXYYtuTrTsrVWvukK0xOwIuukydiiBE6m4xTE=;
	b=2TB2JlmsQ4b+e3lAVCBXzrRxcwB2Er76sSDNSU8mcdeGtOSpxDMYNVaH8Z+eieKy5rPIgW
	qhTJoq0In/fP7LBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747811750;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+KLk1TtXYYtuTrTsrVWvukK0xOwIuukydiiBE6m4xTE=;
	b=W76pryMpm0rpwG7iSPqjhFjmPr4FG/gJ1W6TrgZYdYFVH+BGwsYuNo4Fd8KFYimNMPoSKS
	WmyTt4+GJNMbsEwHSe21hGkeALCY8LFROLfzpZIYjx2ysqJRZg2XJX3i/QmEq6FoLD9szk
	qIYzfudLcf2XnXuTJcApTUT0/X764zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747811750;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+KLk1TtXYYtuTrTsrVWvukK0xOwIuukydiiBE6m4xTE=;
	b=2TB2JlmsQ4b+e3lAVCBXzrRxcwB2Er76sSDNSU8mcdeGtOSpxDMYNVaH8Z+eieKy5rPIgW
	qhTJoq0In/fP7LBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFC0D13888;
	Wed, 21 May 2025 07:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qbJpKqZ9LWgIGgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 21 May 2025 07:15:50 +0000
Date: Wed, 21 May 2025 09:15:49 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't drop a reference if
 btrfs_check_write_meta_pointer fails
Message-ID: <20250521071549.GB3687@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b964b92f482453cbd122743995ff23aa7158b2cb.1747677774.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b964b92f482453cbd122743995ff23aa7158b2cb.1747677774.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Mon, May 19, 2025 at 02:03:01PM -0400, Josef Bacik wrote:
> I made a mistake in converting us to using the extent buffer xarray for
> zoned, I'm dropping a reference for the eb and continuing, but the
> references get dropped by releasing the batch.  This should fix
> Johannes's problem and the testbot report from this morning.  I'll fold
> this into the patch later today.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I've forked the branch for 6.16 without this fixup and don't want to
rebase it as I intend to send early pull request today, so this fixup
will be in 2nd pull request.

