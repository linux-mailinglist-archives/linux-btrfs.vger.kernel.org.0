Return-Path: <linux-btrfs+bounces-9949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FB49DB853
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 14:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780B8282172
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4720A1A9B2E;
	Thu, 28 Nov 2024 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fyZI45Sj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WqyrTGkN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fyZI45Sj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WqyrTGkN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F491A9B21
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799423; cv=none; b=eWjG3M4II2o25hu+PEMrMiq+HiOY++c5ZgnYZhPs5Ho61d+Ws/qolhPOzmNbrGwP74xkOkf0PzznFAdZgSMyvQJCKVQyYKrT6tS7S8seDa4H8yYMK6FcQPAcWCGN4v0O4Y9iE+f21chHQHWh20UZ2qrI4jGSlevcFvFQxQjknA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799423; c=relaxed/simple;
	bh=WbuXA1X3NuF4pLAjTbek/O+2a5YoXCZVaFwopFiYD10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNYFX84NzrmYCrFlugLRtjmYsjvvTg3ZOeNT/LHKZIjIqd4avxzVdhtvYX9qps89Uil74T76D+xEZNukBeIVACbcPVnapoqBwqkhsEoCS7r72TY6iWPlo6xKDL8MntPhacbUCpYhYHxHWSxBD99kFoc1RUwHRGY8ThJdl6IRgwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fyZI45Sj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WqyrTGkN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fyZI45Sj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WqyrTGkN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BE421F44F;
	Thu, 28 Nov 2024 13:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732799419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmiE4vTNagaFt1Y5OGvTEi6tUwpvq894u/JpeduNjsg=;
	b=fyZI45SjRte9bDvuABhrgMJmi5Y7osjj09e3Y/F5g6DgLdNUfaFdwH4tVM0sA5tTUNqKL3
	i9JbeyG6CYy11MwyACQ+Rns4zJR9llvBiLDP86S6iwoiBaoA0mSOkIaM8shEJQd9b7pbkG
	Eckbj3rR91IOgUakQkWr88bEj0+7tsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732799419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmiE4vTNagaFt1Y5OGvTEi6tUwpvq894u/JpeduNjsg=;
	b=WqyrTGkNGT8pSZKMwlMmxiTcR4zF400k8irUykUxfLnS6jmqoksIw5LyU1fGiABQLD4RSF
	E3xXVXsslbGWy6Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732799419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmiE4vTNagaFt1Y5OGvTEi6tUwpvq894u/JpeduNjsg=;
	b=fyZI45SjRte9bDvuABhrgMJmi5Y7osjj09e3Y/F5g6DgLdNUfaFdwH4tVM0sA5tTUNqKL3
	i9JbeyG6CYy11MwyACQ+Rns4zJR9llvBiLDP86S6iwoiBaoA0mSOkIaM8shEJQd9b7pbkG
	Eckbj3rR91IOgUakQkWr88bEj0+7tsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732799419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmiE4vTNagaFt1Y5OGvTEi6tUwpvq894u/JpeduNjsg=;
	b=WqyrTGkNGT8pSZKMwlMmxiTcR4zF400k8irUykUxfLnS6jmqoksIw5LyU1fGiABQLD4RSF
	E3xXVXsslbGWy6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5034313690;
	Thu, 28 Nov 2024 13:10:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pSQKE7trSGfadwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 28 Nov 2024 13:10:19 +0000
Date: Thu, 28 Nov 2024 14:10:14 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: extra debug output for sector size < page
 size cases
Message-ID: <20241128131014.GQ31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1732680197.git.wqu@suse.com>
 <20241127153039.GO31418@twin.jikos.cz>
 <09d0450d-1f4c-4d48-ab95-fc7c2b78c0ec@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09d0450d-1f4c-4d48-ab95-fc7c2b78c0ec@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Nov 28, 2024 at 07:00:58AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/11/28 02:00, David Sterba 写道:
> > On Wed, Nov 27, 2024 at 02:36:35PM +1030, Qu Wenruo wrote:
> >> The first patch is the long existing bug that full subpage bitmap dump
> >> is not working for checked bitmap.
> >> Thankfully even myself is not affected by the bug.
> >>
> >> The second one is for a crash I hit where ASSERT() got triggered in
> >> btrfs_folio_set_locked() after a btrfs_run_delalloc_range() failure.
> >>
> >> The last one is for the btrfs_run_delalloc_range() failure, which is
> >> not that rare in my environment, I guess the unsafe cache mode for my
> >> aarch64 VM makes it too easy to hit ENOSPC.
> >>
> >> But ENOSPC from btrfs_run_delalloc_range() itself is already a problem
> >> for our data/metadata space reservation code, thus it should be
> >> outputted even for non-debug build.
> >>
> >> Qu Wenruo (3):
> >>    btrfs: subpage: fix the bitmap dump for the locked flags
> >>    btrfs: subpage: dump the involved bitmap when ASSERT() failed
> >>    btrfs: add extra error messages for extent_writepage() failure
> >
> > Reviewed-by: David Sterba <dsterba@suse.com>
> 
> Thanks for the review.
> 
> Although I'd prefer this series to be merged after the double accounting
> fix (which also affects non-subpage cases)
> 
> The problem is in the 3rd patch, which is touching the code just after
> btrfs_run_delalloc_range() returned.
> 
> That area is also where the double accounting fix is touching.
> 
> To make backport a little easier, I'd prefer make the fix first, then
> the extra debug patches.

Right, no objections here. As you've been finding the problems any
debugging and reporting improvement is good.

