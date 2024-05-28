Return-Path: <linux-btrfs+bounces-5333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D808D27FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 00:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63342B22039
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 22:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869E113E8B8;
	Tue, 28 May 2024 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HpZa3XTx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1SVFrL6G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L4fd7sLx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l73W0QGh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E313E029
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934977; cv=none; b=WXBMnk7KcrksGcygiooLXDqzgJ0TuPPi3sIaLHOdvdTDHTrdFtJhncKx/SmGx1F+r3qh7T5hwYVjuczRf5bMjdfNZdw2zr1dKGPMhSy3w288c1XvIopLs/cDWYYMfTEZbusX1gBwYTkavQkAr/zzivfIhUkiktdRmKgavakX0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934977; c=relaxed/simple;
	bh=tsq6vYSRFQPMlGTggrtGpdES4OjVm7Ow+zDdp+i4s28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVgjfXhmKMavGiBznVDlJuLSj07MG9NyxEukK1d48pNw772S+NWKIyC2XC8I30U1veiY5K/hkBadvqq8x1Y9l1zgZbXMRLaG7dXV9NdWtgbZNDeXGArKxEXYM7pTcj1Em4Do3BJxWVgYpbzN0pB/LrIieiKv60ZnGuke4lQGZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HpZa3XTx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1SVFrL6G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L4fd7sLx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l73W0QGh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D8B3F22BB7;
	Tue, 28 May 2024 22:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716934974;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4hdSZfk9q5KtuAodn+pAS03mykcq1tkaDi730Ke67A=;
	b=HpZa3XTxLUMTpiCip18t2Pgw5qBHeV+v3o0uT3jBjzbtw4sZ0OaH9JVGd1sKT33QSfmuXM
	PiiD8E2rqU6sQdJtvB1OGYBb/KiXZJrorf4ZKyklfY/yWZ76aIfVzs5MhUsIUknysnpnJX
	jufLBPX2I0JHpOlVRAgEyQo4togncOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716934974;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4hdSZfk9q5KtuAodn+pAS03mykcq1tkaDi730Ke67A=;
	b=1SVFrL6GXK43CSAhPoNEs8LQ8zRfYUWziAIBaCJlSNtfHsvApDTxAOd1RJarq5gqH+kD4f
	cdtq/lx27S7bZKDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716934973;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4hdSZfk9q5KtuAodn+pAS03mykcq1tkaDi730Ke67A=;
	b=L4fd7sLx47nMcbTTe05D6WPGPs16fNf/Ie6ff/mYjYA6oKDFnWckPEkrleSUA+s4pEzkox
	sblbrBBsvsTWF8I75A+vcWuxwFw3rXT4/xqh9VgrZkm8UBb9pgewTsMot1to3ihR4peCyx
	QiDcbHSvt462Vv7tAHPG0pbDXNEkNRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716934973;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4hdSZfk9q5KtuAodn+pAS03mykcq1tkaDi730Ke67A=;
	b=l73W0QGh3snGInLrwmzzRHz82ZHqPFSgdtTNOCAaWdWjYkhK8SJI2b1KgxcRWKgnPPRn3k
	WvOd4QGtis6yk3BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0E2513A6B;
	Tue, 28 May 2024 22:22:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VNHvLj1ZVmbGdAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 28 May 2024 22:22:53 +0000
Date: Wed, 29 May 2024 00:22:52 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: reduce ordered_extent_lock section at
 btrfs_split_ordered_extent()
Message-ID: <20240528222252.GJ8631@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <719ec85c5bda1d711067e5b1c20a2de336240140.1715688262.git.fdmanana@suse.com>
 <6bd1663678f119791c1e2b6071f4973f35dcf049.1715708811.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bd1663678f119791c1e2b6071f4973f35dcf049.1715708811.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Tue, May 14, 2024 at 06:54:18PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no need to hold the root's ordered_extent_lock for so long at
> btrfs_split_ordered_extent(). We don't need to hold it in order to modify
> the inode's rb tree of ordered extents, to modify the trimmed ordered
> extent and move checksums between the trimmed and the new ordered extent.
> That's only increasing contention of the root's ordered_extent_lock for
> other writes that are starting or completing.
> 
> So lock the root's ordered_extent_lock only before we add the new ordered
> extent to the root's ordered list and increment the root's counter for the
> number of ordered extents.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

