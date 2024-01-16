Return-Path: <linux-btrfs+bounces-1484-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2918482F43B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 19:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B5BFB221B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 18:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD51CD38;
	Tue, 16 Jan 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="laI5xhDU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8ju/tDGt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="laI5xhDU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8ju/tDGt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263931CABD
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429715; cv=none; b=pynqo716wdEAt+MH7T/z+58kbMW7d9QWMEbYO/fWQ17jL2xxAYnEBnmSxKwrWbcwhfaiM6dQ8pKA0T5Le9zeB00QbR1MZO8R9Ne50qezxJDrTAExPJTT1MtUn7740elzyA7xd4aX30YqXTxhS8Q18sgEt1hU9snoKtaJSlfpmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429715; c=relaxed/simple;
	bh=jNT2SwPPUf95+6PQHrXxD3No/2TrVXobyqjxZ7xuZaY=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spam-Level:
	 X-Spam-Score:X-Spamd-Result:X-Spam-Flag; b=VvBSWwCTm178QYeMqEiXLCfL/Zo9h/K1u/n49pwr9mU5tC6krDRLI8TvCaQd3WAx5YAr/4xlb+L+Pl+xqwBwvrHsw+IZrd/ZDee2TakuqNoKPkZS6wr0tRIOaCMt+aaw+7/rv93bMfD777IZPWDo3UOM/o3KrW3VBKgn7W+dusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=laI5xhDU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8ju/tDGt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=laI5xhDU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8ju/tDGt; arc=none smtp.client-ip=195.135.223.131
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 198AD1F889;
	Tue, 16 Jan 2024 18:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705429706;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mm6kGojZ9IvADQZHVkwvrKZtjhqYQXq717JBJyO8hpQ=;
	b=laI5xhDUTqbDSxiuvMHW8ilz9oQI0/yiMtuezWZQFnHo/zEEgc1dE225bdu+sAQyjv/p3C
	RmtrayhshTrvI26bzzlh3EAgODtXFpTE3kewAJi3Vo9zo+lui+9xZoge8Ya239wjI4XAma
	JI7h5tFKhmnIWqVoi2Nqn56w2kIaDDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705429706;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mm6kGojZ9IvADQZHVkwvrKZtjhqYQXq717JBJyO8hpQ=;
	b=8ju/tDGtdri0rLNGgJbyva1nhijTFM7LXGiKoZvgkYSbWnaNWlxwu9f5uRoj2IEgMJSifr
	rmbg4C3cwQgNZlCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705429706;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mm6kGojZ9IvADQZHVkwvrKZtjhqYQXq717JBJyO8hpQ=;
	b=laI5xhDUTqbDSxiuvMHW8ilz9oQI0/yiMtuezWZQFnHo/zEEgc1dE225bdu+sAQyjv/p3C
	RmtrayhshTrvI26bzzlh3EAgODtXFpTE3kewAJi3Vo9zo+lui+9xZoge8Ya239wjI4XAma
	JI7h5tFKhmnIWqVoi2Nqn56w2kIaDDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705429706;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mm6kGojZ9IvADQZHVkwvrKZtjhqYQXq717JBJyO8hpQ=;
	b=8ju/tDGtdri0rLNGgJbyva1nhijTFM7LXGiKoZvgkYSbWnaNWlxwu9f5uRoj2IEgMJSifr
	rmbg4C3cwQgNZlCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E905B133CF;
	Tue, 16 Jan 2024 18:28:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qaMxOMnKpmU9OQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 16 Jan 2024 18:28:25 +0000
Date: Tue, 16 Jan 2024 19:28:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Rongrong <i@rong.moe>
Subject: Re: [PATCH] btrfs: scrub: avoid use-after-free when chunk end is not
 64K aligned
Message-ID: <20240116182807.GB31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8531c41848973ac60ca4e23e2c7a2a47c4b94881.1705313879.git.wqu@suse.com>
 <12744dd0-a56e-487e-b27d-4ad66498d7e5@wdc.com>
 <de82a8aa-7b51-4aa1-9cd6-a2f749a6e941@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de82a8aa-7b51-4aa1-9cd6-a2f749a6e941@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.04
X-Spamd-Result: default: False [-1.04 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.962];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.05)[60.13%]
X-Spam-Flag: NO

On Tue, Jan 16, 2024 at 09:20:58AM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/15 22:39, Johannes Thumshirn wrote:
> [...]
> >
> >> - Make sure scrub_submit_initial_read() only to read the chunk range
> >>     This is done by calculating the real number of sectors we need to
> >>     read, and add sector-by-sector to the bio.
> >
> > Why can't you do it the same way the RST version does it by checking the
> > extent_sector_bitmap and then add sector-by-sector from it?
> 
> Sure, we can, although the whole new scrub code is before RST, and at
> that time, the whole 64K read behavior is considered as a better option,
> as it reduces the IOPS for a fragmented stripe.

I'd like to keep the scrub fix separte from the RST code, even if
there's a chance for some code sharing or reuse. The scrub fix needs to
be backported so it's better to keep it independent.

The change itself looks as an enhancement of the existing code so it's
"obvious" and does not need any preparatory patches.

