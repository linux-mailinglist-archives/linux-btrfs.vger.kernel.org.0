Return-Path: <linux-btrfs+bounces-20794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNHYI7pTcGlvXQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20794-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 05:19:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3254350EF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 05:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52E134E6042
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 04:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9804D313E34;
	Wed, 21 Jan 2026 04:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mvVmBtUr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eDkB8am9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M9Ghv2Vc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uK1CNmHa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957DD2EC08C
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768969135; cv=none; b=UaR/GR10+o7erVAJUiENWTc+MwDc3icYc5KknMEg1SrMp7fT04njg4LEXcwbeoTTq+ws9pjbGehJMCrJYCvkDyKwqB6js+z+uwL8xksA6CUMucLTbhNHOdRFPm+WUoPt8krmYKIvYA6osnK7+LwPH7DS0GAbZl7ZTD4Fw9bCM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768969135; c=relaxed/simple;
	bh=wXQGPexqmf32eyqoEpdRwF96QJd+R5e51BZ4Dlgn4XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avS7B7Iu6TV/Mf75nD+Dn874Q2Y/B15kqlMKgQudPCgDFHDKDC4kM/gbj0xDrbA5oG8oorvyb/veYNjVCl2uy60xAN1ezlmnBnkAjp98pugtj/Cb7W+NtMe53ZMDZmVORVw0/fdHuqO0lPrBaW7Y6RX8RMVv7/7+D6tMU7ihbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mvVmBtUr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eDkB8am9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M9Ghv2Vc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uK1CNmHa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA15A33689;
	Wed, 21 Jan 2026 04:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768969123;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnMSKTRP5hp7ApUb5es5Ej74DfVgPTC8vFjSpNKU0fI=;
	b=mvVmBtUrzGOGWYQhzO9PGhOyHPPblqHqPLo85GDY0zhAfkcmR4BFhFLO6eIW29fmEUGNeh
	46or06ng3icXTeiFWIDwRDhgQO6ZkSB9JGJSi4GRGR339iCIbz6HCnqw9h+C5TPxwbuwzJ
	xGFB3ZbSMx/4JWje18WJbmIQ9JvFh9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768969123;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnMSKTRP5hp7ApUb5es5Ej74DfVgPTC8vFjSpNKU0fI=;
	b=eDkB8am9AasOV2Hgqifx6PmotBJAFu61SZzyHgosqiCCxCemHs7kZnpmKkFpbq1AlnnfVG
	/RPTgT0VBzGP+nBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M9Ghv2Vc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uK1CNmHa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768969122;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnMSKTRP5hp7ApUb5es5Ej74DfVgPTC8vFjSpNKU0fI=;
	b=M9Ghv2VcTH9w4px9na0ulbP6iEtlX3UTcPBjwDNENkxo3RPpnvQgvicANE0pl8cGGt7EH2
	0i04NBWpcYe1/UeJL8xo0zGU1VRoZs4+BcaIlPwaokR/nVeBb88CvYW0iFPXO0zC7ASvgv
	tOZ/dC/0dFcgQ4hJgJ2bf06n3JxcjGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768969122;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnMSKTRP5hp7ApUb5es5Ej74DfVgPTC8vFjSpNKU0fI=;
	b=uK1CNmHaKl8go6asbwuujdEZ8tlKLIhD7/DWKWzipJBEG50YQTSf06kfTRBJI8vr6me0aB
	ecorQlYicTkcyXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3D4B3EA63;
	Wed, 21 Jan 2026 04:18:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bzoXL6JTcGmMEAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 21 Jan 2026 04:18:42 +0000
Date: Wed, 21 Jan 2026 05:18:41 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: assert block group is locked in
 btrfs_use_block_group_size_class()
Message-ID: <20260121041841.GN26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1768911827.git.fdmanana@suse.com>
 <529715e8be7197b1a2e0b3940c2af811503f1521.1768911827.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529715e8be7197b1a2e0b3940c2af811503f1521.1768911827.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[suse.cz];
	TAGGED_FROM(0.00)[bounces-20794-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.com:email,suse.cz:replyto,suse.cz:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3254350EF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 12:25:54PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's supposed to be called with the block group locked, in order to read
> and set its size_class member, so assert it's locked.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/block-group.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 82c488a4b54c..2efeb5daf45c 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -4749,6 +4749,7 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
>  				     enum btrfs_block_group_size_class size_class,
>  				     bool force_wrong_size_class)
>  {
> +	lockdep_assert_held(bg->lock);

	lockdep_assert_held(&bg->lock);

