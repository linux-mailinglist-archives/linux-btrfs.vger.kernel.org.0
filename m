Return-Path: <linux-btrfs+bounces-10588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4233B9F6EDD
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 21:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DAD16B649
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 20:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D5E1FC10E;
	Wed, 18 Dec 2024 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qgCPe89n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wY90Y1BX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qgCPe89n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wY90Y1BX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60FF1448F2
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734553443; cv=none; b=Xqj53/pfiNQBSdWBGEKStSQbUGtoEDbsRtxFwE39fRzxzQ2zgtpWczvGsm+4PYdImX7u/aJjZ+We2t/7kyVcawUaxBX4vrZ6RJbceMljzuSKpN+FXH18GckEol2cpC5pxxMtdkwBuC1EIsiQ8zPovzttD4txIOnS4m7L/ShSZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734553443; c=relaxed/simple;
	bh=ObQXroaKqNv9vLmLY19t/g/XyewwslyHhnMypE1s1L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0GuNYfdFQIp0VtB/LmOxib3/xJrcjVBHXmmgL7YtRVdmVgQB6kJrr6V4OVF2g1cBQx2UaD8XAGhpLiqpLs7Zm1Adx43dZMcY5yAMHm/nE9VNw9h0QrxbeRDOuuILutvM8Tb2M56ty3iP+w6Zh6Yxr5tO+bM2VdqIfhu0Sb4fug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qgCPe89n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wY90Y1BX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qgCPe89n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wY90Y1BX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B93B21120;
	Wed, 18 Dec 2024 20:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734553439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xh0liozp5zPiztpU2lGKcXaj0NwG5VKiwuyFTEEGZBg=;
	b=qgCPe89nnvfQ7tByySat1oEelJr6TJTXkbX18ibanaDLAct6J7sfNMkJXCoUjWaiV8wxuj
	Zyt9mB4OjtQJJVYSq0YyPwYH8Q1OBamSo+qO2ShEQ7LhmyQHDX0jP/XZlzbiAa713oe1In
	OtD1+9yfYmgUHqVF061O2dql1XjKdMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734553439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xh0liozp5zPiztpU2lGKcXaj0NwG5VKiwuyFTEEGZBg=;
	b=wY90Y1BX1OQPJD3dZU8WqcaH1EaZX36T1BJIIkn6RfXEBSlDw+MHwh8EMkIJLL3W3Y1bEp
	1AjbYEApgu+QFyCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qgCPe89n;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wY90Y1BX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734553439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xh0liozp5zPiztpU2lGKcXaj0NwG5VKiwuyFTEEGZBg=;
	b=qgCPe89nnvfQ7tByySat1oEelJr6TJTXkbX18ibanaDLAct6J7sfNMkJXCoUjWaiV8wxuj
	Zyt9mB4OjtQJJVYSq0YyPwYH8Q1OBamSo+qO2ShEQ7LhmyQHDX0jP/XZlzbiAa713oe1In
	OtD1+9yfYmgUHqVF061O2dql1XjKdMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734553439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xh0liozp5zPiztpU2lGKcXaj0NwG5VKiwuyFTEEGZBg=;
	b=wY90Y1BX1OQPJD3dZU8WqcaH1EaZX36T1BJIIkn6RfXEBSlDw+MHwh8EMkIJLL3W3Y1bEp
	1AjbYEApgu+QFyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 838AA137CF;
	Wed, 18 Dec 2024 20:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id osvqH18vY2dsDQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 18 Dec 2024 20:23:59 +0000
Date: Wed, 18 Dec 2024 21:23:58 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9] btrfs: some header cleanups and move things around
Message-ID: <20241218202358.GH31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1734368270.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1734368270.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 9B93B21120
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Mon, Dec 16, 2024 at 05:17:15PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Move some misplaced prototypes, macros and functions around and some
> header cleanups. Trivial changes, details in the change logs.
> 
> Filipe Manana (9):
>   btrfs: move abort_should_print_stack() to transaction.h
>   btrfs: move csum related functions from ctree.c into fs.c
>   btrfs: move the exclusive operation functions into fs.c
>   btrfs: move btrfs_is_empty_uuid() from ioctl.c into fs.c
>   btrfs: move the folio ordered helpers from ctree.h into fs.h
>   btrfs: move BTRFS_BYTES_TO_BLKS() into fs.h
>   btrfs: move btrfs_alloc_write_mask() into fs.h
>   btrfs: move extent-tree function declarations out of ctree.h
>   btrfs: remove pointless comment from ctree.h

Reviewed-by: David Sterba <dsterba@suse.com>

With the comment to consider creating a file for checksum helpers
(checksum.c/.h).

