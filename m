Return-Path: <linux-btrfs+bounces-19611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87084CB0E9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 20:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 067FC30BC97E
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 19:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7271C3043D5;
	Tue,  9 Dec 2025 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N05TvfTq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z+TlR7Zr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VXZiVzle";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sKxq46n9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25F1E5205
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765307666; cv=none; b=dKuUOEqxLio1/GsFS9cj/dmGJ0YTuAg73ZqAsG4FPFyv6khSWf1peGM2a0PwtUiISkbnsfL3DQEU89SQy8yWNuFKUtYtk/6CimJ0q5i0rPpOQiTBHwk/FruRLjYJo7WIf55gq8VU8Yl4G2qR8vRTQiNKxtZp/w0SgR2kzztf3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765307666; c=relaxed/simple;
	bh=EsD7Hr6TXnrgsLOaRiU/SQv7YUbE8NMs9eoF4kpwb7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfSaoQyBSHTSRDp+vawxLMw3V2OiGdEjvNSd0udTm4QUimr+107AYsX3kZLZuRDN+4cjOrPBfn4GITBKtl2gdujxWiYDZWzeLJPa7Fik5UqmvTPI+oTcFNzjEFn3Dc8x7ShaZmnczjdrKpJLMqdTzZ73CFvN1wyAP6nkUtjwY98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N05TvfTq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z+TlR7Zr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VXZiVzle; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sKxq46n9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2874337D2;
	Tue,  9 Dec 2025 19:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765307662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VuCBzVFeX5JjrVzBF1s8JZ5tZDIfgbOnJaUzxEZzD2Y=;
	b=N05TvfTqB4U36g7aKOBpMEof8gRb63zKTos60kVZL5eDTcHm/IcJb81F9iqQvS5ONdqto2
	8PcyD+2ZrVTX7hDcaztXuHKL3bGuxJJ7QQhx+ir+B5la3BMCp8lonWiUECWn1bTjK913zg
	1+Es0Xm0nUos3sa1/UuDdzax2qS4vQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765307662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VuCBzVFeX5JjrVzBF1s8JZ5tZDIfgbOnJaUzxEZzD2Y=;
	b=z+TlR7ZryciR7QGWPC8VmXNi4o06IBHRnyRDPCH2pA+0e1SZtNR2frYBsZaGvdZhnAL7st
	jRIlJmER1qLPCXDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VXZiVzle;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sKxq46n9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765307660;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VuCBzVFeX5JjrVzBF1s8JZ5tZDIfgbOnJaUzxEZzD2Y=;
	b=VXZiVzleDKKA21F58sPQwig9Crwv5INs1/Ny9MYGa2vYL96LV/NdyGSUhaWP/vGYkgxeM0
	PtrObrPoQHo/WkoSOsbAiVi9ZetBpRu0H3dNuYxmVpBO51ES1bgFQRFF/ZVohMciRM3IO5
	hjcL9HWWre99wdvHrO88jro6rdgwhZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765307660;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VuCBzVFeX5JjrVzBF1s8JZ5tZDIfgbOnJaUzxEZzD2Y=;
	b=sKxq46n9cOCztDAinFZDzOMqvj4DB7H6/jlkzNW2RkZtkmKc6ajD15T73UHeik/ftigbm8
	u8i0ZQzae++DhDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A13913EA63;
	Tue,  9 Dec 2025 19:14:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l1kzJwx1OGnwWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 09 Dec 2025 19:14:20 +0000
Date: Tue, 9 Dec 2025 20:14:15 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: enable direct IO for bs > ps cases
Message-ID: <20251209191415.GG4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8490cf1099fa677bc3817257663c7abd85d46f2c.1765141954.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8490cf1099fa677bc3817257663c7abd85d46f2c.1765141954.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: C2874337D2
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Mon, Dec 08, 2025 at 07:43:58AM +1030, Qu Wenruo wrote:
> Previously direct IO was disabled if the fs block size is larger than
> the page size, the reasons are:
> 
> - Iomap direct IO can split the range ignoring the fs block alignment
>   Which could trigger the bio size check from btrfs_submit_bio().
> 
> - The buffer is only ensured to be contiguous in user space memory
>   The underlying physical memory is not ensured to be contiguous, and
>   that can cause problems for the checksum generation/verification and
>   RAID56 handling.
> 
> However above problems are solved by the following upstream commits:
> 
> - 001397f5ef49 ("iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag")
>   Which added an extra flag that can be utilized by the fs to ensure
>   the bio submitted by iomap is always aligned to fs block size.
> 
> - ec20799064c8 ("btrfs: enable encoded read/write/send for bs > ps cases")
> - 8870dbeedcf9 ("btrfs: raid56: enable bs > ps support")
>   Which makes btrfs to handle bios that are not backed by large folios
>   but still are aligned to fs block size.
> 
> With above commits already in upstream, we can enable direct IO support
> for bs > ps cases.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This is based on upstream kernel which relies on the commit from iomap
> tree, which is not yet reflected in our for-next tree.

I've rebased it on master so you can now add it, thanks.

