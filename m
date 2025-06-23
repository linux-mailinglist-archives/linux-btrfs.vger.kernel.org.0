Return-Path: <linux-btrfs+bounces-14874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 857D4AE481B
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 17:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AF0188D57F
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8171224AF1;
	Mon, 23 Jun 2025 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SgD7LsVa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3B+ynEIe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SgD7LsVa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3B+ynEIe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD070223328
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691433; cv=none; b=jKfNrp9b7BQ+NJWI86HoO7+mfCtm1ct99HR4QI0A346knAxj/YAr3udW2ghCn0Tcu53N7h+V8J+HtRK+Krk8hHwk9k7FoNbGtvaCzhBbSNV6TmLoZ6fmMbFdr6Q7oJzyXur5sfzI+oceL7zp6ZFaenecXlTclq7sDwO2HfDCUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691433; c=relaxed/simple;
	bh=29MiPW8Xz+/wMXE26NXr/g+86uxoslhmJHKUXRCXDro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxtfFpeadmcFY4ks0SYdQNsL4V9FWmgZ4mvtkmeTjjVlPMWdv4J+HIXuFRwA42vNeN393tNToiUWfUoLFW532Lz5AV7lUYungI75i5jJkw+yjl8Mi91wwi0NPXQfF0S9MPwX7QNKwXCLCvKePa5QyZdOBCenmts+e3zlzMnJygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SgD7LsVa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3B+ynEIe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SgD7LsVa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3B+ynEIe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E2A7221171;
	Mon, 23 Jun 2025 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750691429;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPtptZIOqcNhr2YjDibQcImNNkMa6RJVfWNfVApl6mQ=;
	b=SgD7LsVaZLWLsU/8qV1vwr+lQGa7XRxY5RhgtAHcH9pKl6LswwmdS4C0BtvBHaMtM/GUC9
	KSh/5OdTRZsGGn0+HDx+27AJ2jaZB6BMYJ9ZvYeEljRQXADHpBCATFSVDIM+oAFsdRbn7r
	EyJyCKh4ix8baAgqMrY6JDZcvO/pPUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750691429;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPtptZIOqcNhr2YjDibQcImNNkMa6RJVfWNfVApl6mQ=;
	b=3B+ynEIeBWhDpr3PKkmE6OteqkpQNhWPZ+su+qSINbCQjjyBqNXCYnGx3LPg8fXmqa26d7
	74NA6/XS6gG8wpAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750691429;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPtptZIOqcNhr2YjDibQcImNNkMa6RJVfWNfVApl6mQ=;
	b=SgD7LsVaZLWLsU/8qV1vwr+lQGa7XRxY5RhgtAHcH9pKl6LswwmdS4C0BtvBHaMtM/GUC9
	KSh/5OdTRZsGGn0+HDx+27AJ2jaZB6BMYJ9ZvYeEljRQXADHpBCATFSVDIM+oAFsdRbn7r
	EyJyCKh4ix8baAgqMrY6JDZcvO/pPUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750691429;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPtptZIOqcNhr2YjDibQcImNNkMa6RJVfWNfVApl6mQ=;
	b=3B+ynEIeBWhDpr3PKkmE6OteqkpQNhWPZ+su+qSINbCQjjyBqNXCYnGx3LPg8fXmqa26d7
	74NA6/XS6gG8wpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE34513A27;
	Mon, 23 Jun 2025 15:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AQM5LmVuWWifdAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 23 Jun 2025 15:10:29 +0000
Date: Mon, 23 Jun 2025 17:10:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 3/8] btrfs: add comments to make super block creation
 more clear
Message-ID: <20250623151028.GB28944@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1750674924.git.wqu@suse.com>
 <c86ee5c7e8588b9755c66f6827dc5087de2fd910.1750674924.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c86ee5c7e8588b9755c66f6827dc5087de2fd910.1750674924.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -8.00
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Mon, Jun 23, 2025 at 08:16:47PM +0930, Qu Wenruo wrote:
> @@ -1894,6 +1885,20 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>  	set_device_specific_options(fs_info);
>  
>  	if (sb->s_root) {
> +		/*
> +		 * Not the first mount of the fs thus got an existing super block.
> +		 *
> +		 * Will reuse the returned super block, fs_info and fs_devices.
> +		 */
> +		ASSERT(fc->s_fs_info == fs_info);
> +
> +		/*
> +		 * fc->s_fs_info is not touched and will be later freed by
> +		 * put_fs_context() through btrfs_free_fs_context().
> +		 * 

There's a trailing space and this breaks 'git am' checks, and the line
is also in other 2-3 patches. It's a bit annoying to fix manually,
please fix it and resend.

