Return-Path: <linux-btrfs+bounces-1522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096F830BA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 18:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0241F220BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739C5225AA;
	Wed, 17 Jan 2024 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N1UFZEw0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pxiK21IX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N1UFZEw0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pxiK21IX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B42224D3
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510966; cv=none; b=PmQ9UvNR7SflwZPlcwWKaiBMYXoGaR2MwMRr41UZW0Ewk8BFH0LUt6E8TgTrVRgnHg0vZBFKhhGQwG/hCqRKnVzOsn0A3+SDADw2tcYiRqVeNs53aXmg5QCULxyvKXjmdqSMS1aCaSOe8NZYBW8aUXyaPi/kGw7DPjA6IsDF+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510966; c=relaxed/simple;
	bh=7pAP3Wj1R5KMhOdKIrn9jSNgFLDwPpTR4pGlCLqO9Hc=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 User-Agent:X-Spamd-Result:X-Spam-Level:X-Spam-Flag:X-Spam-Score;
	b=Uxp3x+yvCsK+cVHLPC1OJyFccyBi3QV8ecNfJAJWft/6DAHsLv9o8cfz4xu85qTTZPgHy1X3M5WUxlvvfX9mPLJieefYKm8e9l/rd2pwN0tb/g/8rnCqhZqDtPWD2VAREohkbDYZ/fjYHwkMgqkU0zQtqPd0NFIR7uigrsQDxig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N1UFZEw0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pxiK21IX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N1UFZEw0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pxiK21IX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 375831FCDA;
	Wed, 17 Jan 2024 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705510963;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkMfUI0+iqfQ6kuq5dWvouymQxgOaJj94kN3kcDMiLg=;
	b=N1UFZEw01OXWVYFQ3W31DxCOFMzod9WH6rl04YPd9tDsCbe8lAumLMbHR0rOKVRiy9XmTN
	Ox6tt/AdwqI9rxsyrNdcGuRMcXj4wK6JX73lBZTGqsuj7P9Yim4pR5ago6vapWiUs1Tvln
	PZJvZB9cBoRhKAmEYDprO//27K9c1yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705510963;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkMfUI0+iqfQ6kuq5dWvouymQxgOaJj94kN3kcDMiLg=;
	b=pxiK21IXiEdoE78mfxa9i+7LT+I5AX5vYvEdxYFFcVK0FfLi66MuGsbZRECFAloRr1PLsA
	VX4rgQIXMk2mmSDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705510963;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkMfUI0+iqfQ6kuq5dWvouymQxgOaJj94kN3kcDMiLg=;
	b=N1UFZEw01OXWVYFQ3W31DxCOFMzod9WH6rl04YPd9tDsCbe8lAumLMbHR0rOKVRiy9XmTN
	Ox6tt/AdwqI9rxsyrNdcGuRMcXj4wK6JX73lBZTGqsuj7P9Yim4pR5ago6vapWiUs1Tvln
	PZJvZB9cBoRhKAmEYDprO//27K9c1yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705510963;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkMfUI0+iqfQ6kuq5dWvouymQxgOaJj94kN3kcDMiLg=;
	b=pxiK21IXiEdoE78mfxa9i+7LT+I5AX5vYvEdxYFFcVK0FfLi66MuGsbZRECFAloRr1PLsA
	VX4rgQIXMk2mmSDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 218B213482;
	Wed, 17 Jan 2024 17:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1bGvBzMIqGVtUgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 17 Jan 2024 17:02:43 +0000
Date: Wed, 17 Jan 2024 18:02:24 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Filipe Manana <fdmanana@kernel.org>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove duplicate recording of physical address
Message-ID: <20240117170224.GJ31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <022e1767f333e36d22e0c6f859334ae9433e42a4.1705487315.git.johannes.thumshirn@wdc.com>
 <CAL3q7H7sTX2jsguSZtZ9XwtPEsCyegXO22E3Y6j=qLg=UnoJCg@mail.gmail.com>
 <45173429-2e92-4305-af29-47c63f91317f@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45173429-2e92-4305-af29-47c63f91317f@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[39.29%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20

On Wed, Jan 17, 2024 at 11:42:26AM +0000, Johannes Thumshirn wrote:
> On 17.01.24 12:36, Filipe Manana wrote:
> > On Wed, Jan 17, 2024 at 10:34 AM Johannes Thumshirn
> > <johannes.thumshirn@wdc.com> wrote:
> >>
> >> Remove the duplicate physical recording of the original write physical
> >> address in case of a single device write.
> >>
> >> This duplicated code is most likely present due to a rebase error.
> >>
> >> Fixes: 02c372e1f016e ("btrfs: add support for inserting raid stripe extents")
> > 
> > The Fixes tag is meant to be used for bug fixes or significant
> > performance regressions,
> > but this is just removing a redundant piece of code that doesn't cause
> > any of those problems.
> > With such a tag, an unnecessary stable backport will happen automatically.
> > 
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> > Anyway, apart from the unnecessary tag, it looks good.
> > 
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Ok removed the fixes tag.
> 
> @Dave I'll take this trivial patch as a first example of committing myself.

Sure,

Reviewed-by: David Sterba <dsterba@suse.com>

