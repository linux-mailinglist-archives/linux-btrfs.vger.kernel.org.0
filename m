Return-Path: <linux-btrfs+bounces-16126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6952AB2AC6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 17:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C86519660C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A1E253F2B;
	Mon, 18 Aug 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T5/y76Dd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LVNU5VpJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T5/y76Dd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LVNU5VpJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567325179A
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530047; cv=none; b=ixgSNqX3x031ppo0q9c+lltCb2YACrSF/8hw1kS3m7RkzFdPV8lerOfFP2HlxM/r6qZFJVluYDH9QyNdnBb1QYlneVoHwObvbZbgwvwseCoyvBc54dNg5FqqhSWvjmgIGtioATKdzfbtB3jw3OEst4aLD6AWr7QF449Vx+deePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530047; c=relaxed/simple;
	bh=3vhUBXlr1JuYhRFs7CVzRkZIeJrPA65XTsmhz8u57T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0pZoNyYMKLmE0oErQgvyrZfx8l6P6OjZZimt+zdCvUgq1rHX5TlBSGOSG4gBzwpvlm6Kfse/gLXNMzXcG1raQ7nM79doJPEbCXqIOriokH+AAiREwQ2nN6WdQm7Vz/kiCyQVZlbtUncLrrhRLjhsRkyGfeW7W0TcyAXIYvyrmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T5/y76Dd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LVNU5VpJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T5/y76Dd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LVNU5VpJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8CE31F387;
	Mon, 18 Aug 2025 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755530043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eocFT39ojHvnwobSpEKfgknbn9087ISiRs/wKyjTfgU=;
	b=T5/y76Ddf70CNLqZuDo71GCIiJ1Pfv7582r4/EbudHu0nViJqUBxBmUtemPmzQnQ1E/mXy
	Uss+ZDBQ8t441NQc3TVVLIjIxRaqWz8bIbbyUsTspEzlVa/bgzcP14tvqzXdmV+PKXBiLe
	GnatIT7PoMr9L110dQq3NJTgHgHJ4l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755530043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eocFT39ojHvnwobSpEKfgknbn9087ISiRs/wKyjTfgU=;
	b=LVNU5VpJio9YRSFJB8NWvgv38+c6/gOkoT73K8uXye6EXc5NVfPc64FG7eZ6zW30ZGeUYB
	d/JQ6N3fvFqX9ECg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755530043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eocFT39ojHvnwobSpEKfgknbn9087ISiRs/wKyjTfgU=;
	b=T5/y76Ddf70CNLqZuDo71GCIiJ1Pfv7582r4/EbudHu0nViJqUBxBmUtemPmzQnQ1E/mXy
	Uss+ZDBQ8t441NQc3TVVLIjIxRaqWz8bIbbyUsTspEzlVa/bgzcP14tvqzXdmV+PKXBiLe
	GnatIT7PoMr9L110dQq3NJTgHgHJ4l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755530043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eocFT39ojHvnwobSpEKfgknbn9087ISiRs/wKyjTfgU=;
	b=LVNU5VpJio9YRSFJB8NWvgv38+c6/gOkoT73K8uXye6EXc5NVfPc64FG7eZ6zW30ZGeUYB
	d/JQ6N3fvFqX9ECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9719A13686;
	Mon, 18 Aug 2025 15:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HPnAJDtDo2hPLQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Aug 2025 15:14:03 +0000
Date: Mon, 18 Aug 2025 17:13:58 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs: per-fs compression workspace manager
Message-ID: <20250818151358.GN22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1755148754.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755148754.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Aug 14, 2025 at 03:03:19PM +0930, Qu Wenruo wrote:
> Currently btrfs utilizes the following components at a per-module basis:
> 
> - Folios pool
>   A per-module pool for compressed data.
>   All folios in the pool are page sized.
> 
> - Workspace
>   A workspace is a compression algorithm specific structure, providing
>   things like extra memory buffer and compression level handling.
> 
> - Workspace manager
>   The workspace manager is managing the above workspaces for each
>   algorithm.
> 
> All the folio pool/workspaces are using the fixed PAGE_SIZE buffer size,
> this is fine for now as even for block size (bs) < page size (ps) cases,
> a larger buffer size won't cause huge problems except wasting memories.
> 
> However if we're going to support bs > ps, this fixed PAGE_SIZE buffer
> and per-module shared folios pool/workspaces will not work at all.
> 
> To address this problem, this series will move the workspace and
> workspace manager into a per-fs basis, so that different fses (with
> different block size) can have their own workspaces.
> 
> This brings a small memory usage reduce for bs < ps cases.
> Now zlib/lzo/zstd will only allocate buffer using block size.
> 
> This is especially useful for lzo compression algorithm, as lzo is an
> one-short compression algorithm, it doesn't support multi-shot (aka,
> swapping input/output buffer halfway) compress/decompress.
> 
> Thus btrfs goes per-block compression for LZO, and compressed result
> will never go larger than a block (or btrfs will just give up).
> In that case, a 64K page sized buffer will waste 7/8th of the buffer.
> 
> This is part 1 of the preparation for btrfs bs > ps support.
> 
> Qu Wenruo (7):
>   btrfs: add an fs_info parameter for compression workspace manager
>   btrfs: add workspace manager initialization for zstd
>   btrfs: add generic workspace manager initialization
>   btrfs: migrate to use per-fs workspace manager
>   btrfs: cleanup the per-module workspace managers
>   btrfs: rename btrfs_compress_op to btrfs_compress_levels
>   btrfs: reduce workspace buffer space to block size

Reviewed-by: David Sterba <dsterba@suse.com>

