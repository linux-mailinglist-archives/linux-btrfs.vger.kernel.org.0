Return-Path: <linux-btrfs+bounces-7570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C280961794
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65AE1F25975
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 19:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C341CFEBF;
	Tue, 27 Aug 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HiiyDNRq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WwRz6dk0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C015E195F04
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785228; cv=none; b=LvnkutbMaAxPbltl5C1Do4TV1+xoPBDz5LQnS6qduPTwYauaYScKj1lAbMwc4Gzv3oj9Sy0f3qdqb3M7ew6fAstSY3j3KWqQHXCftIQWF5qXpH+YSpGbm6yjj2NBAtIWnlR1Q1bBNbO5pU/ZrCzcPQj3RAY1aqftstxLWFoPIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785228; c=relaxed/simple;
	bh=38AKBq9ZbbmtheKwEusXpdD8ZMb34/LX8/YLolo+ksU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUJy/KTMbnqZrZfeL1uF/wg68to2VT+cKQNFXYAIkt0AcmUPW+0R4kpz3AT9/dFWOC0WePhQCO7nDaomeitSB70kjxbIzmFDIxhgK4VDd9kufOVeJOgQwvB6ZEVn0ePAme8RikE3ZHFjxGGPXSmnjk+TmQAuYa+hOeu53htfNzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HiiyDNRq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WwRz6dk0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D579D1FB85;
	Tue, 27 Aug 2024 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724785222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8B8OMf8VZ9XfpnWeu5kcB9KbyTQyZxkBB4vI+1ezILQ=;
	b=HiiyDNRqg3DSlJBGg1GTBKvEazOnxZ/qer29dDusOBtTi00nJCUE4rRgVp0djAJInkck5P
	Dfm0OAL4Y3YKqwUeNGbZk3JOfj9JFyJzx/g5y5bdWH9o7Fq1rCNx+NvBoY1Cg6dLZogaaO
	litWNhGEyK2K3Ol2xfyIwBO7Io5UHns=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724785221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8B8OMf8VZ9XfpnWeu5kcB9KbyTQyZxkBB4vI+1ezILQ=;
	b=WwRz6dk0EghS1TmtrnWpT71ka8yNWVzbbo+fFLWs3XDQkMmWULGYm8kNHdlfQeHJzX2CM3
	wFxO23qyKAxB1V5Al+etqlwvpMON5jusPKr7adQw+ZD5GxQbXY3GziC5oRHoT57LsrQYgw
	A5Mj6i/DDYZSl0BGCnjzHeNWc71vTMo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60B6913724;
	Tue, 27 Aug 2024 19:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q+4mDkUizmabZgAAD6G6ig
	(envelope-from <rgoldwyn@suse.com>); Tue, 27 Aug 2024 19:00:21 +0000
Date: Tue, 27 Aug 2024 15:00:18 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] btrfs: do not hold the extent lock for entire read
Message-ID: <5w4av3ulp3hqcgp6rdtygtstc65qxfzdhbghgfk5kqmbzv7f6l@bd6agxsnba6j>
References: <cover.1724690141.git.josef@toxicpanda.com>
 <3a8713ffde30072690bcc9149ec211abc1aed8ca.1724690141.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a8713ffde30072690bcc9149ec211abc1aed8ca.1724690141.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.981];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On 12:37 26/08, Josef Bacik wrote:
> Historically we've held the extent lock throughout the entire read.
> There's been a few reasons for this, but it's mostly just caused us
> problems.  For example, this prevents us from allowing page faults
> during direct io reads, because we could deadlock.  This has forced us
> to only allow 4k reads at a time for io_uring NOWAIT requests because we
> have no idea if we'll be forced to page fault and thus have to do a
> whole lot of work.
> 
> On the buffered side we are protected by the page lock, as long as we're
> reading things like buffered writes, punch hole, and even direct IO to a
> certain degree will get hung up on the page lock while the page is in
> flight.
> 
> On the direct side we have the dio extent lock, which acts much like the
> way the extent lock worked previously to this patch, however just for
> direct reads.  This protects direct reads from concurrent direct writes,
> while we're protected from buffered writes via the inode lock.
> 
> Now that we're protected in all cases, narrow the extent lock to the
> part where we're getting the extent map to submit the reads, no longer
> holding the extent lock for the entire read operation.  Push the extent
> lock down into do_readpage() so that we're only grabbing it when looking
> up the extent map.  This portion was contributed by Goldwyn.
> 
> Co-developed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good.
Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>


