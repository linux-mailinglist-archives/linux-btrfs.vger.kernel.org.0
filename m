Return-Path: <linux-btrfs+bounces-20790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMCHNbpMcGnXXAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20790-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 04:49:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C6250948
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 04:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24464888B2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 03:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838152D8792;
	Wed, 21 Jan 2026 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0I9nno1E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f4pLPMmD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0I9nno1E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f4pLPMmD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE83254A3
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 03:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768967257; cv=none; b=MGiv97xbWSe3IJ+TmZKaB9AE9CKI5w0glP0s1eck0RUaggfqKh9HzYCYwjqyWu+0/znvowD8LKzsPFNF4Ij9+AUi//azp1Fr9p+581tCiOxn9duOivWB259nnJA+84Y/IyPGbPbQxb5j/EFqiz4w8WXIaUuU79hbypqRxHHwMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768967257; c=relaxed/simple;
	bh=TRyz/8UamGXuahtHRyOUUDHJ4YBOFwtBGuVFKy2YsaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2HQN9AasWKqcSaPEW+8ceJ8FMDd25n6snGRTKzp+bx+k32VofFpVAd53FH7HrZqAA1QXITRkOPsxjxdFdGdtPtJ9xvWypG5zOq4jgpfqpJCsWVs5DFsNlhBwSnidw7u0Q9YevLa2GnzLPhQyaMQu2JT6NtEKB+7e+NRm2wTurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0I9nno1E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f4pLPMmD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0I9nno1E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f4pLPMmD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EC1A33684;
	Wed, 21 Jan 2026 03:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768967251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IyiNcT2sazAPcDMGPNbZAD8YARe3k5+xT3THwS+gc4=;
	b=0I9nno1EklAwMmyzf4CtI/d7Fo0A/xIzAnwZWDbgC+Q6HYOwEDm31zfQh0/QiHgZNePdwk
	SVBYbE5Uh3kaqIVz3Lxfhz5ZA2yycBDD1Msk4VGYoP2PDD5MIVfoEpMCRP3F9VL+wezbzD
	YROHtmZas1ZV/PZ8uK/WpHPNRYJLpgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768967251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IyiNcT2sazAPcDMGPNbZAD8YARe3k5+xT3THwS+gc4=;
	b=f4pLPMmDzEQ/H4yt5EvgPVt9AUELOhbrdXIs+qFeNjU6du8p41Kym1YJGtm785BowAPm7+
	2YMjmtNBEjixQtAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768967251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IyiNcT2sazAPcDMGPNbZAD8YARe3k5+xT3THwS+gc4=;
	b=0I9nno1EklAwMmyzf4CtI/d7Fo0A/xIzAnwZWDbgC+Q6HYOwEDm31zfQh0/QiHgZNePdwk
	SVBYbE5Uh3kaqIVz3Lxfhz5ZA2yycBDD1Msk4VGYoP2PDD5MIVfoEpMCRP3F9VL+wezbzD
	YROHtmZas1ZV/PZ8uK/WpHPNRYJLpgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768967251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IyiNcT2sazAPcDMGPNbZAD8YARe3k5+xT3THwS+gc4=;
	b=f4pLPMmDzEQ/H4yt5EvgPVt9AUELOhbrdXIs+qFeNjU6du8p41Kym1YJGtm785BowAPm7+
	2YMjmtNBEjixQtAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D8963EA63;
	Wed, 21 Jan 2026 03:47:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9DhxIlNMcGmhcgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 21 Jan 2026 03:47:31 +0000
Date: Wed, 21 Jan 2026 04:47:30 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: get rid of
 compressed_bio::compressed_folios[] part 1
Message-ID: <20260121034730.GL26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1768866942.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768866942.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20790-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.com:email]
X-Rspamd-Queue-Id: 82C6250948
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 10:30:07AM +1030, Qu Wenruo wrote:
> Currently we have compressed_bio::compressed_folios[] allowing us to do
> random access to any compressed folio, then we queue all folios in that
> array into a real btrfs_bio, and submit that btrfs_bio for read/write.
> 
> However there is not really any need to do random access of that array.
> 
> All compression/decompression is doing sequential folio access.
> 
> The part 1 is some easy and safe conversion on decompression path.
> 
> The part 2 will handle the compression part, but unfortunately that will
> require some changes all compression path, thus will need some extra
> work.
> 
> And only after compression paths also got converted, we still need
> that compressed_folios[] array for now.
> 
> Qu Wenruo (3):
>   btrfs: use folio_iter to handle lzo_decompress_bio()
>   btrfs: use folio_iter to handle zlib_decompress_bio()
>   btrfs: use folio_iter to handle zstd_decompress_bio()

Reviewed-by: David Sterba <dsterba@suse.com>

