Return-Path: <linux-btrfs+bounces-13793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AFEAAE68A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 18:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E6B1BC3A4D
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 16:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E66828BAA1;
	Wed,  7 May 2025 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E4BjTOKv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nBfUjKKq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0yyr9CzI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n3e9wKzd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2784B28B7FB
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634577; cv=none; b=FEwF9e64AWBI1g/so7TySCFoJVTkM/QssmybJEMfAgChs31lde0yZW+IftoBxv03MzUbCIXdE/12x7GrnQD2mtY9L8s09vmtwFsQrOrVh7vhSOqhI+rzrIYnDZy4Hnpf+vkoLtBlJ7m5miF9oIMW+S8Aob8YWQSmBXjVD3Hp97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634577; c=relaxed/simple;
	bh=vA8EI8vPmjsHqOIAyzv85ygxpZc4SHYY4XgzhHwzOe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpoGPQg+UVDrRYBU2GXgT4CABkRRov3lQVnbQnaJQn5TDU3qL/q5apnK1zRDMYr8G7y4yCV0JRJr2zN3iiIClXwCL0GXM/8VAez7++sAySjHWhIUto4cluyUC6zJ+pqY2j7372KOFlkLISUnq4I5oDuRODrj9R2DfF1zykD6UBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E4BjTOKv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nBfUjKKq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0yyr9CzI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n3e9wKzd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC9A31F395;
	Wed,  7 May 2025 16:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746634573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UGHxHJj4PdhzbCLkWehmHAznj6CGqw8Of5OA5F5nREI=;
	b=E4BjTOKv5fNtKWBrmrot8nndOq5o0E72X96YVHX2tJYKFTP5FFxOULARJOD7dxTFf0BumP
	9btdIuZfwpWLxZGbPYy21I7eF+JjRDEuxDCdP5HV/60KfaXCphdmDKgiJ87+vRuIQ1GClj
	q10S3YA0IlqD/5YuFkAZYr1qbqekY3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746634573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UGHxHJj4PdhzbCLkWehmHAznj6CGqw8Of5OA5F5nREI=;
	b=nBfUjKKqSMhaOOzCuObD6N0kWOzZeX4SU34bauSPBGIVzKJ6KKRI0WQo2bRy+Tr0oy4uzW
	/NVV04RFYt47dEDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0yyr9CzI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=n3e9wKzd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746634572;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UGHxHJj4PdhzbCLkWehmHAznj6CGqw8Of5OA5F5nREI=;
	b=0yyr9CzIudauhRU+QsPS0u+VbAAP38hmaQkE2ZpirBl1o0FjMZAuuuM8qENisrxYzHdXfM
	XIG7Q/u5M0tQH+r2aKkrbjwBgIGY269BHw0i6ftvbRso/CwIOV1saudJILaA54qLc2EmqI
	xDRgjgcSC0jKAAYkPJzOW9ENcH3uwvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746634572;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UGHxHJj4PdhzbCLkWehmHAznj6CGqw8Of5OA5F5nREI=;
	b=n3e9wKzdfqiK+aNDvuc+c+281/GwR3ZWXi7eydEG+VWUmy5ufm8Mw0IeaLvWVbPl1tuQc/
	4ojMcUo02XXEliBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7CA7139D9;
	Wed,  7 May 2025 16:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8fOCMEyHG2jCdQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 May 2025 16:16:12 +0000
Date: Wed, 7 May 2025 18:16:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: reduce memory usage of
 scrub_sector_verification
Message-ID: <20250507161611.GH9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b4e4f39ce79e08f41410ec45653d028db63e468b.1746594262.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4e4f39ce79e08f41410ec45653d028db63e468b.1746594262.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DC9A31F395
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action

On Wed, May 07, 2025 at 02:34:39PM +0930, Qu Wenruo wrote:
> That structure records needed info for block verification (either data
> checksum pointer, or expected tree block generation).
> 
> But there is also a boolean to tell if this block belongs to a metadata
> or not, as the data checksum pointer and expected tree block generation
> is already a union, we need a dedicated bit to tell if this block is a
> metadata or not.
> 
> However such layout means we're wasting 63 bits for x86_64, which is a
> huge memory waste.
> 
> Thanks to the recent bitmap aggregation, we can easily move this
> single-bit-per-block member to a new sub-bitmap.
> And since we already have six 16 bits long bitmaps, adding another
> bitmap won't even increase any memory usage for x86_64, as we need two
> 64 bits long anyway.
> 
> This will reduce the following memory usages:
> 
> - sizeof(struct scrub_sector_verification)
>   From 16 bytes to 8 bytes on x86_64.
> 
> - scrub_stripe::sectors
>   From 16 * 16 to 16 * 8 bytes.
> 
> - Per-device scrub_ctx memory usage
>   From 128 * (16 * 16) to 128 * (16 * 8), which saves 16KiB memory.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Nice, the conversion to bitmaps seems quite useful. Also it's future
proof if we increase the size of strip.

Reviewed-by: David Sterba <dsterba@suse.com>

