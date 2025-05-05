Return-Path: <linux-btrfs+bounces-13654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0A1AA9433
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 15:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A30B7A9F28
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 13:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1553A2580E4;
	Mon,  5 May 2025 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kiY0GLEl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eDYGLPtR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kiY0GLEl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eDYGLPtR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2702AF1B
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450979; cv=none; b=e6TEN8ieex/SfHG+JnoYzvTi/SSVyoWDAHB4duPr19fTCNG9LD7qPirxe2fLTHaIphUiduyuVugxGBC4BB64Ohyl0MICSXl+eZVspC3QtK9YNfhLVyDtaHpORwpdqg9I5lcKnQTi61zg2gjlODY3N9cobI3wU6A9ZzY9xZGl+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450979; c=relaxed/simple;
	bh=H0SUBqQ4clR9T1oAHRiPuASoP4eYR/U9O3D4BWTuZ8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx51NfMgJGwVQsghrR/Dh7iyWWpKu9kmYfMa/vIhc5daed+EQNQG8xYTEsNTj2ZUV92YLhFRMa/5BzewuolQ6ffCxFlnlMlVaLbygyx0/VJ0LhFr+4ADWF9NeUuvdCAD/PGar50/xZAYp7HUc24KSbkY5pxJ/BRnuOpjrHsv5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kiY0GLEl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eDYGLPtR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kiY0GLEl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eDYGLPtR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B4CD1F791;
	Mon,  5 May 2025 13:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746450975;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTP0KeDTW0PTKzMWtzqurajvI4KA0LygA9yjVvBPtWw=;
	b=kiY0GLElZgn9klvbse1GbY5Ayvr+ViC3vsy3W9OPQx7Y1K/K8K7QNAugvwrPBwyvP5kL/o
	Ns08M+2UdG5etPx5CItv6gQZwhihYoyvxU7YAlmcNNR7P+SXF+YJ5RDuB2r8tTF8GGcLSZ
	IKUj07dciaeJPG6dd2zKCIZ9unfJ5J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746450975;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTP0KeDTW0PTKzMWtzqurajvI4KA0LygA9yjVvBPtWw=;
	b=eDYGLPtR42Vn0rWkUF5wY1Uv8rci3x49Tfd6FkyeFvffAHS66e5PYDsDmpwknkA79I/36D
	p2nOXpxIzGqZpQBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746450975;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTP0KeDTW0PTKzMWtzqurajvI4KA0LygA9yjVvBPtWw=;
	b=kiY0GLElZgn9klvbse1GbY5Ayvr+ViC3vsy3W9OPQx7Y1K/K8K7QNAugvwrPBwyvP5kL/o
	Ns08M+2UdG5etPx5CItv6gQZwhihYoyvxU7YAlmcNNR7P+SXF+YJ5RDuB2r8tTF8GGcLSZ
	IKUj07dciaeJPG6dd2zKCIZ9unfJ5J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746450975;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTP0KeDTW0PTKzMWtzqurajvI4KA0LygA9yjVvBPtWw=;
	b=eDYGLPtR42Vn0rWkUF5wY1Uv8rci3x49Tfd6FkyeFvffAHS66e5PYDsDmpwknkA79I/36D
	p2nOXpxIzGqZpQBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 170651372E;
	Mon,  5 May 2025 13:16:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /ttrBR+6GGhdMAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 May 2025 13:16:15 +0000
Date: Mon, 5 May 2025 15:16:13 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: move error reporting members to stack
Message-ID: <20250505131613.GV9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <142a1de91d82b12c583f3d18efcdd92529a1d664.1746144642.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <142a1de91d82b12c583f3d18efcdd92529a1d664.1746144642.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, May 02, 2025 at 09:41:07AM +0930, Qu Wenruo wrote:
> +/* Various members that are only for error reporting. */
> +struct scrub_error_records {
> +	/*
> +	 * Bitmap recording which blocks hit errors (IO/csum/...) during
> +	 * the initial read.
> +	 */
> +	unsigned long init_error_bitmap;
> +
> +	/* How many errors hit for each type (IO, csum, metadata). */
> +	unsigned int init_nr_io_errors;
> +	unsigned int init_nr_csum_errors;
> +	unsigned int init_nr_meta_errors;
> +	unsigned int init_nr_meta_gen_errors;
> +};

> @@ -1039,17 +1042,17 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
>  	wait_scrub_stripe_io(stripe);
>  	scrub_verify_one_stripe(stripe, stripe->extent_sector_bitmap);
>  	/* Save the initial failed bitmap for later repair and report usage. */
> -	stripe->init_error_bitmap = stripe->error_bitmap;
> -	stripe->init_nr_io_errors = bitmap_weight(&stripe->io_error_bitmap,
> -						  stripe->nr_sectors);
> -	stripe->init_nr_csum_errors = bitmap_weight(&stripe->csum_error_bitmap,
> -						    stripe->nr_sectors);
> -	stripe->init_nr_meta_errors = bitmap_weight(&stripe->meta_error_bitmap,
> -						    stripe->nr_sectors);
> -	stripe->init_nr_meta_gen_errors = bitmap_weight(&stripe->meta_gen_error_bitmap,
> -							stripe->nr_sectors);
> +	errors.init_error_bitmap = stripe->error_bitmap;
> +	errors.init_nr_io_errors = bitmap_weight(&stripe->io_error_bitmap,
> +						 stripe->nr_sectors);
> +	errors.init_nr_csum_errors = bitmap_weight(&stripe->csum_error_bitmap,
> +						   stripe->nr_sectors);
> +	errors.init_nr_meta_errors = bitmap_weight(&stripe->meta_error_bitmap,
> +						   stripe->nr_sectors);
> +	errors.init_nr_meta_errors = bitmap_weight(&stripe->meta_gen_error_bitmap,
> +						   stripe->nr_sectors);

This looks like a copy&paste typo, errors.init_nr_meta_errors is
initialized twice, should be errors.init_nr_meta_gen_errors

