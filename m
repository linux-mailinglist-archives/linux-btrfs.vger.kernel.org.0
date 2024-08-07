Return-Path: <linux-btrfs+bounces-7038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A1894B39B
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 01:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CBCB21D87
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 23:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C090F155A5B;
	Wed,  7 Aug 2024 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a86cuTkh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F05rZSGY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a86cuTkh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F05rZSGY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D26143726
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2024 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072965; cv=none; b=Tc1grBOOorCyMq8tEmXCuXkY7n9N38VC/4lFff280Lbc4A7tTN1rHbR/l5CgG1oQGk39sMg3YMMGkOtqGK5FZMuIpQX83VSX/ErirBm+xcahmBBWdD/U/ld2Emw6MI7qYaMb3auFkRjM14PNjv5OeDnXh8sbOv2r9IvbHkWgRFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072965; c=relaxed/simple;
	bh=BU1e1mX/onAsD7zBfLp+gq4TYs0uAEhh84olzDBlLOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itiZxmsE/J61FhapRS2nEPaIXAYBSGA7CGl0W1976PrVJAUVqrHNc7Bs4s0J88j7NojkERJ2zMOjF+finL6GnmoB5KVq0aqN1f4QpamV5YoH9uBjQ1E22LYltODylk08b/ZGBlh64ouJ63CEyN9Eu5d3eKKm6aw3uEptCsDYQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a86cuTkh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F05rZSGY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a86cuTkh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F05rZSGY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AFB021BB5;
	Wed,  7 Aug 2024 23:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723072962;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLhvfNmV3DTiDk3vThI2adIFt6QUmh3YhRklkPzTVvs=;
	b=a86cuTkhV5eb1ZWJhRA286xzmi52O7uVV2cu1AcbCkCMFy1K8H/9Qi8ZbkPrB7ecDOlo3/
	JT0DKG6gOv5EPesEvxpd4Fsl/cAMNzl7I/gIkpxMEIP9yhz5RG4bfhrqkn0Y3+f3iWOVeF
	yt2hXIiwsKiFCcUPBVV1YZrWFJf/xZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723072962;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLhvfNmV3DTiDk3vThI2adIFt6QUmh3YhRklkPzTVvs=;
	b=F05rZSGYZDSSWUojJrBfGU5/iPhDCIWh0xDyxkLeN9xJ1AlnmSYJ5xn7DFc6heBJCC+z3Y
	W85S/XpZDEaQUXBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723072962;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLhvfNmV3DTiDk3vThI2adIFt6QUmh3YhRklkPzTVvs=;
	b=a86cuTkhV5eb1ZWJhRA286xzmi52O7uVV2cu1AcbCkCMFy1K8H/9Qi8ZbkPrB7ecDOlo3/
	JT0DKG6gOv5EPesEvxpd4Fsl/cAMNzl7I/gIkpxMEIP9yhz5RG4bfhrqkn0Y3+f3iWOVeF
	yt2hXIiwsKiFCcUPBVV1YZrWFJf/xZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723072962;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLhvfNmV3DTiDk3vThI2adIFt6QUmh3YhRklkPzTVvs=;
	b=F05rZSGYZDSSWUojJrBfGU5/iPhDCIWh0xDyxkLeN9xJ1AlnmSYJ5xn7DFc6heBJCC+z3Y
	W85S/XpZDEaQUXBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34C7913297;
	Wed,  7 Aug 2024 23:22:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OhSwDMIBtGZWAQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 Aug 2024 23:22:42 +0000
Date: Thu, 8 Aug 2024 01:22:36 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: refactor __extent_writepage_io() to do
 sector-by-sector submission
Message-ID: <20240807232236.GA29853@suse.cz>
Reply-To: dsterba@suse.cz
References: <9102c028537fbc1d94c4b092dd4a9940661bc58b.1723020573.git.wqu@suse.com>
 <20240807162716.GD17473@twin.jikos.cz>
 <222e8428-4847-4b93-90a9-69b5594756d2@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <222e8428-4847-4b93-90a9-69b5594756d2@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmx.com]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Aug 08, 2024 at 07:35:40AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/8/8 01:57, David Sterba 写道:
> > On Wed, Aug 07, 2024 at 06:21:00PM +0930, Qu Wenruo wrote:
> [...]
> >
> >> +
> >> +	block_start = extent_map_block_start(em);
> >> +	disk_bytenr = extent_map_block_start(em) + extent_offset;
> >> +
> >> +	ASSERT(!extent_map_is_compressed(em));
> >> +	ASSERT(block_start != EXTENT_MAP_HOLE);
> >> +	ASSERT(block_start != EXTENT_MAP_INLINE);
> >> +
> >> +	free_extent_map(em);
> >> +	em = NULL;
> >> +
> >> +	btrfs_set_range_writeback(inode, filepos, filepos + sectorsize - 1);
> >> +	if (!folio_test_writeback(folio)) {
> >> +		btrfs_err(fs_info,
> >> +			  "folio %lu not writeback, cur %llu end %llu",
> >> +			  folio->index, filepos, filepos + sectorsize);
> >
> > This is copied from the original code but I wonder if this should be a
> > hard error or more visible as it looks like bad page state tracking.
> >
> 
> I believe this can be removed completely, or converted into ASSERT().
> 
> For subpage case, page writeback is set if any subpage sector has
> writeback flag set.
> 
> For regular case, it's setting the whole page writeback.
> 
> As long as the folio is already locked, the folio should always be
> marked writeback.
> 
> So I prefer to go the ASSERT() path.

Agreed, ASSERT makes sense.

