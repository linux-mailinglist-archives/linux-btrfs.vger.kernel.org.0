Return-Path: <linux-btrfs+bounces-14390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF40ACBA4E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 19:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7511E177503
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D9C226D16;
	Mon,  2 Jun 2025 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gN81xpb0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2TjV+jnZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gN81xpb0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2TjV+jnZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2752040B6
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748885357; cv=none; b=o2IkhzPMuN3BWCyas4tHipnDAQVWvN78K/T+hkdu9hS2m1o/rEawDGeoJjMBMmGxP9rXMIgSVjbGGMs+tH9Z7PHY2QT3skebJfxUSxxEvBGUZJCN51XU4CgWr+tHzWH3POAa9/WdkQk9JOKqABMeOUocARXJNDt4qPXFCIA1SHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748885357; c=relaxed/simple;
	bh=FKFlwrJNLYJNbR9xOd+jEN+7mU3uyr96CGqmdMYOkMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0LlUlj25Brix6F1cF6ZCdqN+eaC8uWdINmkHhnJTeba6eaYjFiF45+tGkWedc4/Kqfj5jUv2BmREiqvLI/RhaBtuPd0c48w0Lz/1zAFw5GfrzWiKycD6LBmiKHg2LtZfIXLWL81Jgg+BNF/fs20KahQjCyPH62WBFqeuTmv0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gN81xpb0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2TjV+jnZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gN81xpb0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2TjV+jnZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 369E61F7A1;
	Mon,  2 Jun 2025 17:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748885354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKLnzTdOkhMLFCfT23o9Ej7XsaarRx0KJVjUOcEaxJ8=;
	b=gN81xpb0Hl5fZQja1yGecCabx9lpAzo6VvxKUlm/FD7ND/gLlPCInJEzE/z6iNRBpC5Yik
	PgyPx0t9MbxT48Dnb+iSULU0A8lEehUT5Qf4sgo/y+bfa32xE0iPL/7stvd67wYrDfhP7G
	Btr2igT0RYGHJ6waBrD5nDsJ6w4q/HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748885354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKLnzTdOkhMLFCfT23o9Ej7XsaarRx0KJVjUOcEaxJ8=;
	b=2TjV+jnZr+LAeYFjU28zN6RkWyDxytgCTNI/W/t8pe41IhlSmvyAz8eUPkfAuU2/qwh4ZX
	RLzirUXrUor4EKCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748885354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKLnzTdOkhMLFCfT23o9Ej7XsaarRx0KJVjUOcEaxJ8=;
	b=gN81xpb0Hl5fZQja1yGecCabx9lpAzo6VvxKUlm/FD7ND/gLlPCInJEzE/z6iNRBpC5Yik
	PgyPx0t9MbxT48Dnb+iSULU0A8lEehUT5Qf4sgo/y+bfa32xE0iPL/7stvd67wYrDfhP7G
	Btr2igT0RYGHJ6waBrD5nDsJ6w4q/HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748885354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKLnzTdOkhMLFCfT23o9Ej7XsaarRx0KJVjUOcEaxJ8=;
	b=2TjV+jnZr+LAeYFjU28zN6RkWyDxytgCTNI/W/t8pe41IhlSmvyAz8eUPkfAuU2/qwh4ZX
	RLzirUXrUor4EKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12E4F13A63;
	Mon,  2 Jun 2025 17:29:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LvBpBGrfPWj1JAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Jun 2025 17:29:14 +0000
Date: Mon, 2 Jun 2025 19:29:04 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs: harden parsing of compress mount options
Message-ID: <20250602172904.GE4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250602155320.1854888-1-neelx@suse.com>
 <20250602155320.1854888-3-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602155320.1854888-3-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -8.00
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Mon, Jun 02, 2025 at 05:53:19PM +0200, Daniel Vacek wrote:
> Btrfs happily but incorrectly accepts the `-o compress=zlib+foo` and similar
> options with any random suffix.
> 
> Fix that by explicitly checking the end of the strings.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
> v3 changes: Split into two patches to ease backporting,
>             no functional changes.
> 
>  fs/btrfs/super.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 6291ab45ab2a5..4510c5f7a785e 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -270,9 +270,20 @@ static inline blk_mode_t btrfs_open_mode(struct fs_context *fc)
>  	return sb_open_mode(fc->sb_flags) & ~BLK_OPEN_RESTRICT_WRITES;
>  }
>  
> +static bool btrfs_match_compress_type(char *string, char *type, bool may_have_level)

const also here, string, type

> +{
> +	int len = strlen(type);
> +
> +	return strncmp(string, type, len) == 0 &&
> +		((may_have_level && string[len] == ':') ||
> +				    string[len] == '\0');
> +}
> +
>  static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
>  				struct fs_parameter *param, int opt)
>  {
> +	char *string = param->string;

and here

> +
>  	/*
>  	 * Provide the same semantics as older kernels that don't use fs
>  	 * context, specifying the "compress" option clears

