Return-Path: <linux-btrfs+bounces-5939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E35915506
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 19:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B9A2812B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA08219EEB7;
	Mon, 24 Jun 2024 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p97Lue+4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dd/c5YUb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p97Lue+4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dd/c5YUb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514BD19EEA2
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248839; cv=none; b=XFth9J+ESLaLSmUhvoQlnbLQ+2gzT/Sa1xV+3E2brd6ItUNMBVDYFnBtp9MK/RQc2Dt6KngacqcpC64Ip3gSWcfKp5ywSsGv9aOAr+tuiggEM8I3a7+jdZAlxQIwOQUNE/2D8USaS7IsctXSrcWSgXsz8Bz+I+YD/sHS5/f2JGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248839; c=relaxed/simple;
	bh=veEmsf6H9YNhlrlzXxpbxFk/WnrpCyj3KwMm1FpR9kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoQ0C+Ifds+Al1sv9N43nFpBCSth8Xxkde7nt4np8jM30oAje0UcFYd1acoRxPR7mt3twats4CsTfWkkF5FRlZCvktF09XYLzGujeKV16i05M6wex0rO8C79GjubFfRHz1c2PVXMafkLjv8crgxCba/FZIScyybkgWNS9Yw04eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p97Lue+4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dd/c5YUb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p97Lue+4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dd/c5YUb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78FB01F829;
	Mon, 24 Jun 2024 17:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248836;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpA0IkzQ7ls8LEOpBp/cP5X8oYZIQzL41Qpu++IInwo=;
	b=p97Lue+4qnospgGfSlKNu5RcosCW5F69N1pfxT17fQJOGwQl6OYtULr/pjxy54jQ3I+2Bv
	k3J7/ez8QOn7mb5D/A6urOeITIVq86qD2jT5FuT3/GWsjIDJXbvQ0Y4IfLD+vSOdIVWS3/
	YqXLvp55wCtCiwbBjl2iFpOYFtuD2gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248836;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpA0IkzQ7ls8LEOpBp/cP5X8oYZIQzL41Qpu++IInwo=;
	b=Dd/c5YUbvZRBD+nTXSapvtWoPH5vqc0Wm9GtU1Xcr03uFajNs5/S2wAfaNI2ZPFr8JSbXI
	34cVUMgcCLsjubDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248836;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpA0IkzQ7ls8LEOpBp/cP5X8oYZIQzL41Qpu++IInwo=;
	b=p97Lue+4qnospgGfSlKNu5RcosCW5F69N1pfxT17fQJOGwQl6OYtULr/pjxy54jQ3I+2Bv
	k3J7/ez8QOn7mb5D/A6urOeITIVq86qD2jT5FuT3/GWsjIDJXbvQ0Y4IfLD+vSOdIVWS3/
	YqXLvp55wCtCiwbBjl2iFpOYFtuD2gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248836;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpA0IkzQ7ls8LEOpBp/cP5X8oYZIQzL41Qpu++IInwo=;
	b=Dd/c5YUbvZRBD+nTXSapvtWoPH5vqc0Wm9GtU1Xcr03uFajNs5/S2wAfaNI2ZPFr8JSbXI
	34cVUMgcCLsjubDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5ABF713AA4;
	Mon, 24 Jun 2024 17:07:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id llj4FcSneWZTOgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Jun 2024 17:07:16 +0000
Date: Mon, 24 Jun 2024 19:07:15 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs-progs: remove raid stripe encoding
Message-ID: <20240624170715.GS25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240620075455.20074-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240620075455.20074-1-jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]

On Thu, Jun 20, 2024 at 09:54:55AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Remove the not needed encoding and reserved fields in struct
> raid_stripe_extent.
> 
> This saves 8 bytes per stripe extent.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  kernel-shared/accessors.h       |  3 ---
>  kernel-shared/print-tree.c      | 33 +--------------------------------
>  kernel-shared/uapi/btrfs_tree.h | 14 +-------------
>  3 files changed, 2 insertions(+), 48 deletions(-)

This fails to compiler because the tree-checker.c code still references
the removed functions:

kernel-shared/tree-checker.c: In function ‘check_raid_stripe_extent’:
kernel-shared/tree-checker.c:1740:17: warning: implicit declaration of function ‘btrfs_stripe_extent_encoding’; did you mean ‘btrfs_file_extent_end’? [-Wimplicit-function-declaration]
 1740 |         switch (btrfs_stripe_extent_encoding(leaf, stripe_extent)) {
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

