Return-Path: <linux-btrfs+bounces-5423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B11D8D8ACC
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 22:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCEC1C21FA2
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 20:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA26513B2B6;
	Mon,  3 Jun 2024 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SbIHeNAh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nLNzheB4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SbIHeNAh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nLNzheB4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E150134409
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445699; cv=none; b=sngfzTw+cPDHXrT4zZVxcGCh6yspu4v5m84skRSz/KGsku32WDUvofE9ZTYkk3P/WQUD3HnF7ZhgHMANC0ScH7IlxkBKvtpNTEe7cfpfPDxDZFM4Q0BpX/XzEiqX2FU6KI50I3NOuvxPdRJKzt4Pkh1pgDA0llDVv2owyV65mzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445699; c=relaxed/simple;
	bh=QbDpCmbf+3mZsPjO93fRxMzhHs1yrrul6sRH1ydpqe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhROptMJPL6N9ziafEIgdjPwPLZm2TevrNOuBGBzD+QXDf39CT15Z6VpP2q8NbFxHVO3Th89kI0Z+6nmNvuN9uLICwkozmgAfsiiKfih7LPDJjo45/SbsFQNvsbtQdn8IAVfCokZhgVC9IvEZQOInQCUq5HmpAIPrZrgBFtJ/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SbIHeNAh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nLNzheB4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SbIHeNAh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nLNzheB4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62F04219DA;
	Mon,  3 Jun 2024 20:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717445695;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xOq3EMXV5u9eDV9Xjf0xN69i+IB2nXOChup3gaX0HpU=;
	b=SbIHeNAhmPJN0vT5y4wxkPJ3Y2ZRzr2c4uk9j06KJhKtUU5AfSVCnX9vaTanP3/ShmYJtd
	RhVrz6Fy6mHHO4XAnywS2k2iAdIiXL6KlcqkyIpaDvwqHn6DMyBbF0z3AJXY9mZtN0YgxV
	eDAuz3bTcsjeFa9iletRup2l76cRXNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717445695;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xOq3EMXV5u9eDV9Xjf0xN69i+IB2nXOChup3gaX0HpU=;
	b=nLNzheB4P7/QTTVrs1szeApntw0n39IthONxn6PEicq0Y9ikCFgbMgzyGf+nDdxGa1rpEd
	28TqDnsOXdlsUCDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717445695;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xOq3EMXV5u9eDV9Xjf0xN69i+IB2nXOChup3gaX0HpU=;
	b=SbIHeNAhmPJN0vT5y4wxkPJ3Y2ZRzr2c4uk9j06KJhKtUU5AfSVCnX9vaTanP3/ShmYJtd
	RhVrz6Fy6mHHO4XAnywS2k2iAdIiXL6KlcqkyIpaDvwqHn6DMyBbF0z3AJXY9mZtN0YgxV
	eDAuz3bTcsjeFa9iletRup2l76cRXNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717445695;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xOq3EMXV5u9eDV9Xjf0xN69i+IB2nXOChup3gaX0HpU=;
	b=nLNzheB4P7/QTTVrs1szeApntw0n39IthONxn6PEicq0Y9ikCFgbMgzyGf+nDdxGa1rpEd
	28TqDnsOXdlsUCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D668139CB;
	Mon,  3 Jun 2024 20:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j7a9Ej8kXmbzTgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 03 Jun 2024 20:14:55 +0000
Date: Mon, 3 Jun 2024 22:14:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: convert: proper ext4 unwritten extents
 handling
Message-ID: <20240603201450.GD12376@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715051693.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715051693.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, May 07, 2024 at 12:52:52PM +0930, Qu Wenruo wrote:
> [REPO]
> https://github.com/adam900710/btrfs-progs/tree/unwritten_extent
> 
> There is a bug report that ext4 unwritten extents (extent with
> EXT2_EXTENT_FLAGS_UNINIT, acts the same as BTRFS_FILE_EXTENT_PREALLOC)
> would result a regular btrfs file extent.
> 
> Instead of filling the range with zero, converted btrfs would read
> whatever from the disk, causing corruption.
> 
> Although there are some attempts trying to fix the problem, the resulted
> patches are not meeting our standard, so I have to come up a fix by
> myself.
> 
> The root cause is that, ext2fs_block_iterate2() won't report any extent
> info, thus it's more or less only useful for ext2 filesystems.
> For ext4 filesystems, inodes can have a feature called EXT4_EXTENTS_FL,
> allowing a proper extent based iteratioin.
> 
> So this patch would keep the old ext2fs_block_iterate2() as fallback (as
> for older ext2 fses, they do not support fallocate anyway), while for
> newer ext4 fses, go with ect2fs_extent_*() APIs to iterate the file
> extents.
> 
> The new APIs provides the extra extent.e_flags to indicate whether the
> extent is unwritten or not.
> For unwritten extents, we just puch it as a hole for now, since even if
> we create a correct preallocated file extent, the space can not be
> utlized as it's shared between the file extent and ext2 image.
> 
> So just punching a hole would be the simplest workaround for now.
> 
> Qu Wenruo (3):
>   Revert "btrfs-progs: convert: add raid-stripe-tree to allowed
>     features"
>   btrfs-progs: convert: rework file extent iteration to handle unwritten
>     extents
>   btrfs-progs: tests/convert: add test case for ext4 unwritten extents

Added to devel, thanks.

