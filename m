Return-Path: <linux-btrfs+bounces-6625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F3C937E41
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2024 01:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7ED01F245DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 23:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99853149DF4;
	Fri, 19 Jul 2024 23:53:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C80A149C7B
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433215; cv=none; b=a2A5AnwYabkdHeVKvaaGp+H/D6laOwKEEpaSKyNmJh8IE2YyJsYv84OTmjsbM8p2fT2/fhtDwSnFFfF0Uo68Y5rkN5vo7fl70OTqsSaXV+rOsoaJtl8pxv/oLZoVR3SzQ3JsjnT5Vj/0aeGmlVC6DmVNg1sQENx4oGTMZQi2GuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433215; c=relaxed/simple;
	bh=Whcj7/8MuJ/jwD+dciGlxBdAgSMuIawcUJCCFYy9E0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPvO1Lg6s0h4tMp2r8LInCoE/AFdv2MbrMVd9pE1W84oB6ZleBjD5JFKFuWkTFnIdAdypb8VgVIMx0TdS+7FWuE6JFs0rhr9Iu4Gw4ulCQOv3iHLGiRHHvAf6vfEBRM4Amr3U3ftNzg7Nu6WyRJA30Ejrll7I4igOecxUNWwkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A310A21B43;
	Fri, 19 Jul 2024 23:53:30 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BBEC13808;
	Fri, 19 Jul 2024 23:53:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ympIXr8mmZceQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Jul 2024 23:53:30 +0000
Date: Sat, 20 Jul 2024 01:53:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH] btrfs: avoid using fixed char array size for tree names
Message-ID: <20240719235328.GB23446@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <09fa6dc7de3c7033d92ec7d320a75038f8a94c89.1721364593.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09fa6dc7de3c7033d92ec7d320a75038f8a94c89.1721364593.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Queue-Id: A310A21B43
X-Spam-Flag: NO

On Fri, Jul 19, 2024 at 02:20:39PM +0930, Qu Wenruo wrote:
> [BUG]
> There is a bug report that using the latest trunk GCC, btrfs would cause
> unterminated-string-initialization warning:
> 
>   linux-6.6/fs/btrfs/print-tree.c:29:49: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
>    29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP_TREE"      },
>       |
>       ^~~~~~~~~~~~~~~~~~
> 
> [CAUSE]
> To print tree names we have an array of root_name_map structure, which
> uses "char name[16];" to store the name string of a tree.
> 
> But the following trees have names exactly at 16 chars length:
> - "BLOCK_GROUP_TREE"
> - "RAID_STRIPE_TREE"
> 
> This means we will have no space for the terminating '\0', and can lead
> to unexpected access when printing the name.
> 
> [FIX]
> Instead of "char name[16];" use "const char *" instead.

Please use a fixed size string, this avoids the indirection of one
pointer and the actual strings. For static tables like this is a compact
way to store it. As the alignment is mandated by u64 the sizes would be
best in multipes of 8, so 'char name[24]'.

