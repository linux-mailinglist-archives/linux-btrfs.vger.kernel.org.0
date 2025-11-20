Return-Path: <linux-btrfs+bounces-19215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A519AC73CD1
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 12:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 261A24EBA3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF7C32D0F5;
	Thu, 20 Nov 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IJhOSsjv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gE1YsOM1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IJhOSsjv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gE1YsOM1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F999221FCD
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639058; cv=none; b=NUl2XqJAdKYtGuw/hDifSLGGF0wadTuX//ApNQ0Z7TxvbH9+Iob0rxwrfO/RFHMWhZ7Q3jYOVZrKjcJApky9lmm6HmqkGJCPCMWmg+oGauwPv1sWoB9QMsfYl/LxBDamVKh7yrfgIP2qGVdnF1sW8fCKkLghjVBnDPfaQxaNFsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639058; c=relaxed/simple;
	bh=VMtQhORw+lgUiUP+yq1bF5hlqBdxZztzd4Lg1r+VOkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6hZ/ADWjQtizB/wagFaK9+p87FH6zdESooO9txQTF6vcT/xfgzwp5902sYOnWXfcAUWRnmuaNMW40ukvWjAWmFqgcC7kDvjv0KKgIFAfnY05pivy77AtfsrrWb0FDsYgGgQIOHMtBXOJfyn1Tx3rQb9zdhGQB9ESaITR3EZkXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IJhOSsjv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gE1YsOM1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IJhOSsjv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gE1YsOM1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9816B216E0;
	Thu, 20 Nov 2025 11:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763639053;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVr4rs2zYozf0uvTHybhID5SDoNDQjII6fqIc8z3yhI=;
	b=IJhOSsjveEEcdksr7jMX6R0LpuuYe2aal1d/1myro+gRxGGjjIW996Kuh+CNYefo0ZbV7P
	8Km1zi0RGi/gMlt5smsjpHAybct9Hs7EAW9D3REzIN8o1mOPfP96P8Ot25wbZDLIo0eHr2
	psLzhszLjwTiVvtbA1ymhp1roWrrPY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763639053;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVr4rs2zYozf0uvTHybhID5SDoNDQjII6fqIc8z3yhI=;
	b=gE1YsOM1NkoPt0LL7u5n8u6vS3mrL201bFf5mPWLe/lxBfjDIHXS3VB+xnXAMC5P8IdA02
	QHZuaNYKfLQwkvAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763639053;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVr4rs2zYozf0uvTHybhID5SDoNDQjII6fqIc8z3yhI=;
	b=IJhOSsjveEEcdksr7jMX6R0LpuuYe2aal1d/1myro+gRxGGjjIW996Kuh+CNYefo0ZbV7P
	8Km1zi0RGi/gMlt5smsjpHAybct9Hs7EAW9D3REzIN8o1mOPfP96P8Ot25wbZDLIo0eHr2
	psLzhszLjwTiVvtbA1ymhp1roWrrPY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763639053;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVr4rs2zYozf0uvTHybhID5SDoNDQjII6fqIc8z3yhI=;
	b=gE1YsOM1NkoPt0LL7u5n8u6vS3mrL201bFf5mPWLe/lxBfjDIHXS3VB+xnXAMC5P8IdA02
	QHZuaNYKfLQwkvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 883863EA61;
	Thu, 20 Nov 2025 11:44:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qUuuIA3/HmkfJgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 20 Nov 2025 11:44:13 +0000
Date: Thu, 20 Nov 2025 12:44:12 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: cleanups for a couple log tree functions
Message-ID: <20251120114412.GK13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1763557872.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763557872.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.947];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.99

On Wed, Nov 19, 2025 at 01:19:06PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A couple of trivial cleanups for the argument list of two log tree
> functions.
> 
> Filipe Manana (2):
>   btrfs: remove root argument from btrfs_del_dir_entries_in_log()
>   btrfs: reduce arguments to btrfs_del_inode_ref_in_log()

Reviewed-by: David Sterba <dsterba@suse.com>

