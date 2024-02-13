Return-Path: <linux-btrfs+bounces-2358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99AF853A82
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 20:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5801C252CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206121CD00;
	Tue, 13 Feb 2024 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yJkhtECq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z51cGC6U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yJkhtECq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z51cGC6U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB81CA92
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851154; cv=none; b=G+uH74Ffm1PXVLMTWFgVmKgGCKD+Q4Xgp7Z0Ew1TGQIUwo359y6D5b2KtIq4rER3ZzREEFvdtlUMIrBUWvqZudZLZNMXd9Z9IK33aXdOYlc01igbyLIZQGDd0g/J7I+RFpBn4z9gOoAhDwgAq1NbJA3k7fCaGh+15/XI0jXo7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851154; c=relaxed/simple;
	bh=fbKRumwUE0OxUJuLphlkAhlsY/1y7wdAI0aqNvHF2ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1iBUW6E90vy/xkm/wMiTPA/SGoYPRnTmobKON1WIXCHmUNFV5pqutW6q9VEpEWPfEV6EjXI2PcuoV+njY1DIKssbxhEurHpGeJKHVnCI69cTNLdQPIiux9d/ZPglNVIv0UhEPOheGuHR25fnmF4ArbpRgSYKEt3QnRgnnangRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yJkhtECq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z51cGC6U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yJkhtECq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z51cGC6U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8179D1FCEE;
	Tue, 13 Feb 2024 19:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707851149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k47mQyVCmpmg4QEghtnvJaeHm0bpnmB4Bg002r37XtM=;
	b=yJkhtECqcAQBK+IbCxi4mmNDQg74XnuBjNM9K3xILybhWFPBkSD1q1eLi9LXS9Jt/gwIFw
	SNzSjD9Vz3ug85WANLNe0ufA5TczmfuSKevOMxJkmPNJSVi4+QQoqXqAIY4HAQEs94wnel
	WPiXwTnG8ez+KkLQKMb4fysiaL7vxdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707851149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k47mQyVCmpmg4QEghtnvJaeHm0bpnmB4Bg002r37XtM=;
	b=Z51cGC6UKIF9TJnDtgOmI1KwTBqAtHzLzNdIj+MmLFVBT92+7XzwNfIrLDTLNGBnno1QPr
	ROFcdC54v86YCRAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707851149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k47mQyVCmpmg4QEghtnvJaeHm0bpnmB4Bg002r37XtM=;
	b=yJkhtECqcAQBK+IbCxi4mmNDQg74XnuBjNM9K3xILybhWFPBkSD1q1eLi9LXS9Jt/gwIFw
	SNzSjD9Vz3ug85WANLNe0ufA5TczmfuSKevOMxJkmPNJSVi4+QQoqXqAIY4HAQEs94wnel
	WPiXwTnG8ez+KkLQKMb4fysiaL7vxdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707851149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k47mQyVCmpmg4QEghtnvJaeHm0bpnmB4Bg002r37XtM=;
	b=Z51cGC6UKIF9TJnDtgOmI1KwTBqAtHzLzNdIj+MmLFVBT92+7XzwNfIrLDTLNGBnno1QPr
	ROFcdC54v86YCRAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E4D513583;
	Tue, 13 Feb 2024 19:05:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id r4RkGo29y2ViLAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 13 Feb 2024 19:05:49 +0000
Date: Tue, 13 Feb 2024 20:05:16 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/14] More error handling and BUG_ON cleanups
Message-ID: <20240213190516.GF355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1707382595.git.dsterba@suse.com>
 <80792cd4-d06e-4cb4-8db0-c40d2b551aa3@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80792cd4-d06e-4cb4-8db0-c40d2b551aa3@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.18
X-Spamd-Result: default: False [-2.18 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.994];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.18)[88.99%]
X-Spam-Flag: NO

On Thu, Feb 08, 2024 at 08:20:55PM +1030, Qu Wenruo wrote:
> On 2024/2/8 19:29, David Sterba wrote:
> > Continuation of https://lore.kernel.org/linux-btrfs/cover.1706130791.git.dsterba@suse.com/
> >    btrfs: handle unexpected parent block offset in
> >      btrfs_alloc_tree_block()
> 
> For this one, I'd prefer one error message or at least something noisy
> enough (aka, ASSERT()), just to make life a little easier when we
> screwed up in our development environment.

I'll drop this patch for now and will add it to another series dealing
with the error handling and adding the tree-checker and/or verbose
messages.

