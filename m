Return-Path: <linux-btrfs+bounces-12148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D43CA5A35A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 19:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD15188A8BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 18:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CDA238140;
	Mon, 10 Mar 2025 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wM1p82A6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jF6e1Miq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ryLPL0lc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CNKxZZZB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3287233731
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632182; cv=none; b=rmbsdQIy2JjafqNmYuRz/aQYLcN/hF6eALOVWe/Xz0VXCbges8Vz42f2aAt/iLJJxEHCYGv1Ypc8DFOXvw2qFLWfCr0Q2OgwY5avym6RJc8uV+v2+4m5kIhLPr2IjflBHhHkLT7xlMTKCsR2cnDA19/CS9xoiEEFtFzF6u1+iR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632182; c=relaxed/simple;
	bh=9AjtX9jSZrpam3G9VvxJtfPP5aPcjUzUH0fq8BXTNKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td5PJU6CKCimCRj3sIgQk+3G3uJk88zABznXsMi3yTwwNFQQjAvXHfDG+5DXNwBJLZE4c17DSiyg/2a9MXbQ68bRo2O71dpWCcvYaao8wWqDXjyexY5eisNZLgwxPOferUCZDH1hQD+W0nCj4ZsnkQTsrpU9ENnxttMDaZwGRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wM1p82A6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jF6e1Miq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ryLPL0lc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CNKxZZZB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC2A01F387;
	Mon, 10 Mar 2025 18:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741632179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmM37eTIDNml/9Ev/dQ8k2AqyIHmdipGgtCzMWusiA4=;
	b=wM1p82A6LEYHWm/F3kyKl0m0x5lap62FxtkdX4HmoofKF0jP7CJKxH3LMVW64AjC4Ou12T
	ESS2o4tXm4G/ZVpIv8ULM0OeFJBM6bygClo+FocYuI8PLFSPv9LsoOveuYbrdClAZPj0th
	Ql7hyXUJ63qFKZ83NP1I5jAUvnlQtts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741632179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmM37eTIDNml/9Ev/dQ8k2AqyIHmdipGgtCzMWusiA4=;
	b=jF6e1MiqBmF14g3jy7uOXCtsi3XJQPilFL7RDhVwQ2Mm4WtZ4D8bsRDK6i89XFXfcvOmnj
	dEs9OZ1EU2DBlTBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ryLPL0lc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CNKxZZZB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741632178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmM37eTIDNml/9Ev/dQ8k2AqyIHmdipGgtCzMWusiA4=;
	b=ryLPL0lc9loxLhyyaPBF5EsQscu8a/wIfovQ39FyzQ+KdrdJN8fKzE82s3TqkIv/nkSFUC
	N80JZgoT8WOwrizrknC9YaIyMGdZ/kGWWN28U3iPlJ5nGLBRxcKyONvSNMXg/LMmI0C1nn
	zIFdvqIjnaHG8P2HjuWab+lk2QRdb48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741632178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmM37eTIDNml/9Ev/dQ8k2AqyIHmdipGgtCzMWusiA4=;
	b=CNKxZZZBZa20gikXCEvXnJTb5GvohSsZygYnbrogF+hhzCIzo06RtKBJt2zTEiIHPveNMd
	QJpOmTQClckc0ZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C32F4139E7;
	Mon, 10 Mar 2025 18:42:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cUtrL7Iyz2caCAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 10 Mar 2025 18:42:58 +0000
Date: Mon, 10 Mar 2025 19:42:53 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs: some trivial cleanups
Message-ID: <20250310184253.GA32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1741354476.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741354476.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: DC2A01F387
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Fri, Mar 07, 2025 at 01:44:17PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A group of trivial cleanups that started with making log tree code
> less verbose while fixing a couple bugs, by removing repeated BTRFS_I()
> calls, and then extended to btrfs_iget() and removing redundant arguments
> from a few functions. Details in the change logs.
> 
> Filipe Manana (8):
>   btrfs: return a btrfs_inode from btrfs_iget_logging()
>   btrfs: return a btrfs_inode from read_one_inode()
>   btrfs: pass a btrfs_inode to fixup_inode_link_count()
>   btrfs: make btrfs_iget() return a btrfs inode instead
>   btrfs: make btrfs_iget_path() return a btrfs inode instead
>   btrfs: remove unnecessary fs_info argument from create_reloc_inode()
>   btrfs: remove unnecessary fs_info argument from delete_block_group_cache()
>   btrfs: remove unnecessary fs_info argument from btrfs_add_block_group_cache()

Reviewed-by: David Sterba <dsterba@suse.com>

