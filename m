Return-Path: <linux-btrfs+bounces-13656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B9EAA975C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 17:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167867AC9D7
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 15:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8F266B44;
	Mon,  5 May 2025 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c4VYordg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YmRSVowA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c4VYordg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YmRSVowA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104B266581
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458302; cv=none; b=sgsmYQdAtPvxObyeWSjvJVt9ALpWY++ovNHWGyAiq0jlmRn5lMZq8bBbo2EZ+7XYr2ZwXC/9w7RtK9JCTvdO9RgVxkWn/kb5MdCYbaAYC5TZSSsDJQU1tTnr7loFn9jAvLO8tFxo+hGrWaOwZWGFVk4JfpB4BKAa1mAq+Lvwdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458302; c=relaxed/simple;
	bh=YZGZ0YW9fM6fHILrMu4e2orD+V9Em4yca44eP+TkBwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqCGvGH98idXondAC4VgkspUnmBn+u7rYdW7CtcX7PCEy0kKKlG6MWiSnBAfYdM4i3phgOqrc2Q7cYqXiN6aa3/BAOEJno8jhwgAf3X279/rK74ddPpPMEmYbWVDFN2OiijdE7/Rm61FuU01OGR2uZvvzLpuCoeTg8mcAtEtel8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c4VYordg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YmRSVowA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c4VYordg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YmRSVowA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 388D61F791;
	Mon,  5 May 2025 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746458299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp+n/goLbMlcSBtccOSGrBkgipBpWa/7ue1hrzBHpwA=;
	b=c4VYordgC04cChvj9wLEEWdv391me0TkCA6+J2XbeLNBPMs+kHga2o6EVtls9DHmjKjzy/
	sAhs+SRdsGBmuFP9lpSK5x7TSFF5I9VneUuuh/NsIB/grEGiJluVZ2V4x1mXJosn+HrEL9
	Gm86OaIkzNdCC8BZZZUq6ceP1mD4VTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746458299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp+n/goLbMlcSBtccOSGrBkgipBpWa/7ue1hrzBHpwA=;
	b=YmRSVowAqxfYTDtHJC+W6Yk5BTjEMT6FIK1P3bbFK87eK+6ycO+IrBK3c6CuJSze3BPz1r
	g79qS+qq2M5uIuDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746458299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp+n/goLbMlcSBtccOSGrBkgipBpWa/7ue1hrzBHpwA=;
	b=c4VYordgC04cChvj9wLEEWdv391me0TkCA6+J2XbeLNBPMs+kHga2o6EVtls9DHmjKjzy/
	sAhs+SRdsGBmuFP9lpSK5x7TSFF5I9VneUuuh/NsIB/grEGiJluVZ2V4x1mXJosn+HrEL9
	Gm86OaIkzNdCC8BZZZUq6ceP1mD4VTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746458299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp+n/goLbMlcSBtccOSGrBkgipBpWa/7ue1hrzBHpwA=;
	b=YmRSVowAqxfYTDtHJC+W6Yk5BTjEMT6FIK1P3bbFK87eK+6ycO+IrBK3c6CuJSze3BPz1r
	g79qS+qq2M5uIuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F4C71372E;
	Mon,  5 May 2025 15:18:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2N5wB7vWGGgeWgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 May 2025 15:18:19 +0000
Date: Mon, 5 May 2025 17:18:17 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] btrfs: remove extent buffer's redundant `len`
 member field
Message-ID: <20250505151817.GX9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250505115056.1803847-1-neelx@suse.com>
 <20250505115056.1803847-2-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505115056.1803847-2-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, May 05, 2025 at 01:50:54PM +0200, Daniel Vacek wrote:
> Even super block nowadays uses nodesize for eb->len. This is since commits
> 
> 551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_buffer()")
> da17066c4047 ("btrfs: pull node/sector/stripe sizes out of root and into fs_info")
> ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buffer")
> a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_create_tree_block")
> 
> With these the eb->len is not really useful anymore. Let's use the nodesize
> directly where applicable.

You haven't updated the changelog despite we had a discussion about the
potential drawbacks, so this should be here. But I'm not convinced this
is a good change. The eb size does not change so no better packing in
the slab and the caching of length in the same cacheline is lost.

In the assebly it's clear where the pointer dereference is added, using
an example from btrfs_get_token_8():

  mov    0x8(%rbp),%r9d

vs

  mov    0x18(%rbp),%r10
  mov    0xd38(%r10),%r9d

And there's a new register dependency. The eb operations are most of the
time performed on memory structures and not just in connnection with IO,
I think this could be measurable on a fast device with metadata heavy
workload. So I'd rather see some numbers this will not decrease
performance.

