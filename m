Return-Path: <linux-btrfs+bounces-3736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9139B890A69
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 21:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329831F27D16
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 20:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB9413AD05;
	Thu, 28 Mar 2024 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ntD0YwJX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/SybgqnP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A425F139CF1
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655793; cv=none; b=udEIK5HB5jbFJhi8Hk+dlFNqoV62WQlvb6Q3hxL44TgmeyMGIPQWf1F4LBVQ9KxZhmspdHnOMX3ucySMCgefSaXTqJwra0obb7ncCDadMaSVyIpgj0a6D4p6Ic6b9g06fBTNFZou4sX9Gnc0q4UMXYzmWX63TGRU56qkqDkpUz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655793; c=relaxed/simple;
	bh=V3K9vHLNrIu9s4BZ0MDbI6LJxxsZalU7D31U7DWog4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9yUDPOjYbKW2Aon7+6vQlUm+lebB9ylJzT/Geca/VPH416jbqAU240wHPSVF2cr6/pfHDcCb6cK46Ug28ZYV9VTeSPJ6fMx2qyquUCQx6Am+BLKIc16WdxILAMxSq5LvCDfSUXFqD4oAF9NyowHvsuxyUdbcpO7CB/m3P8USec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ntD0YwJX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/SybgqnP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF22320E3C;
	Thu, 28 Mar 2024 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711655789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IEq2YQ04rPActPWqk7uK0mJ5GQqSfO5opvRcc1k7pww=;
	b=ntD0YwJXmafUp1deYwemTbI9x+oWxo54pJvr48CXmwCvyxZqAVRktYA52+iRkMTR2njUQ5
	VvYhDriD+WUYyWZloB1+An10ZkqaGqtjQnkf0O70EilBXVxJmlLv4RqwbgyL27YNwhqn2s
	F4oDdIfYgVZWdddGoskybF8/7Ow4I8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711655789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IEq2YQ04rPActPWqk7uK0mJ5GQqSfO5opvRcc1k7pww=;
	b=/SybgqnP2PrRjH2+b250C/VYVu9ynmaD5lTO1XuaQVL6kJN14w3GP7LKnwwfEVmgqH2zMF
	GSQpRIOTrDLHJBBw==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AFFAA13A92;
	Thu, 28 Mar 2024 19:56:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uErNKm3LBWaQOAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 28 Mar 2024 19:56:29 +0000
Date: Thu, 28 Mar 2024 20:49:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] btrfs: zoned: fix EXTENT_BUFFER_ZONED_ZEROOUT
 handling
Message-ID: <20240328194907.GB14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1711416290.git.naohiro.aota@wdc.com>
 <7a93db1b-f851-4577-9635-f5c1f61710e2@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a93db1b-f851-4577-9635-f5c1f61710e2@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-1.20 / 50.00];
	BAYES_HAM(-1.20)[89.16%];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[]
X-Spam-Score: -1.20
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, Mar 26, 2024 at 04:50:46PM +0000, Johannes Thumshirn wrote:
> On 26.03.24 06:40, Naohiro Aota wrote:
> > Btrfs clears the content of an extent buffer marked as
> > EXTENT_BUFFER_ZONED_ZEROOUT before the bio submission. This mechanism is
> > introduced to prevent a write hole of an extent buffer, which is once
> > allocated, marked dirty, but turns out unnecessary and cleaned up within
> > one transaction operation.
> > 
> > Currently, btrfs_clear_buffer_dirty() marks the extent buffer as
> > EXTENT_BUFFER_ZONED_ZEROOUT, and skip the enteri function. If this call
                                              ^^^^^^

> One minor nit, codespell flagged a typo, but I'm too blind to find it:

There's the typo.

