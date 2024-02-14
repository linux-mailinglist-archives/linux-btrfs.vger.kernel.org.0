Return-Path: <linux-btrfs+bounces-2371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A6985434E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 08:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3D11C2629E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 07:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE1111BE;
	Wed, 14 Feb 2024 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OGiNwWAE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="02g7CQPN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M1ZgYCLz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C6mBbjNV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40910A25
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894799; cv=none; b=WuGu8UI8U+HhaYLZIJ+WFekoEQPYqmTSXbQQV1j2FWj2ZwLrqmqeM8WYGOjdV2bKZISVg9iRRKAnMGD0bEU8CLFhQm8jeGDDpMOzc5Blyc02J63CH5nN/YgBhwRRGnX1ljCgjrYjUYyWr5dn2P7Mr3ofGP3IYMH8wywI08fEcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894799; c=relaxed/simple;
	bh=5MBHOS29eFBtFIP2D7gMQIdC3v6mGLrFdc8/xgEeQ14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN4YOVZ5zmnNFsUccw/i4qfupIFpe+u71QVDUj8bHyhPNUkuujlv6vxYItRsa00NnWD5amwwvvroVezXNTwSFYQ4eCeRKhM+dOdzpblHmuLcyLWjTEdmTm5hrenrM/JUpvjmF8xwE7fGchhhEHtHeQWTQpFopE9MHK5v34sxKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OGiNwWAE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=02g7CQPN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M1ZgYCLz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C6mBbjNV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3DF9B22023;
	Wed, 14 Feb 2024 07:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707894795;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdsk1eLztYpyBtwKH+G0xBYgaGNf97rV5vjWGQlGgQQ=;
	b=OGiNwWAEI37Sz4VF7DjG9jYBCEmUZgd5xb3dUIH4YltnN9EOig0WCwscQKmG8oGbth6CTF
	SCAze2DogHGHkBxSm4rUvhq6gOw8G6gUTOrvYLPI1UMNwEm0osTaZQzi3ZMHGII+EYCOSc
	im9RJutU0YOt+H/WgFz9mM9iOg48DeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707894795;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdsk1eLztYpyBtwKH+G0xBYgaGNf97rV5vjWGQlGgQQ=;
	b=02g7CQPNrpkTW1JWeJqYtivPGdn52lnr2YHAG/mWZTPYCkto0z/cluNOyMG/E+6TD/vXWW
	yEqQFJ/RmnZZklAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707894794;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdsk1eLztYpyBtwKH+G0xBYgaGNf97rV5vjWGQlGgQQ=;
	b=M1ZgYCLzxialTw2xIU3ElFI27Qj4KZQbeBHYmq1UgDYZNYEud5bNCJuEsQrhpw0mXAH6Sw
	ensrphrtjcNxNAX2WfBOXRLXvNwzx1KzLSNV0b0to80UbLyFMaGdvz58k0Raeex5xdN4au
	M8KE3VSZ/CX7JanZOAgGSoT/1ZqHXYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707894794;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdsk1eLztYpyBtwKH+G0xBYgaGNf97rV5vjWGQlGgQQ=;
	b=C6mBbjNVphDL6Ruae61ly4MlytPS/plFwnfeuTR12ZhWsil9cddlMHdladVmOUgoejXbRS
	cU7x1m/3WkvyIvAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 29ED713A1A;
	Wed, 14 Feb 2024 07:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id DAC9CQpozGVSKwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 14 Feb 2024 07:13:14 +0000
Date: Wed, 14 Feb 2024 08:12:40 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move all btree initialization into
 btrfs_init_btree_inode
Message-ID: <20240214071240.GK355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230219181022.3499088-1-hch@lst.de>
 <7fbe36d5-3ebb-4daa-9c92-0761ba49686b@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fbe36d5-3ebb-4daa-9c92-0761ba49686b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.65 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,lst.de:email];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.85)[94.10%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.65

On Wed, Feb 14, 2024 at 04:58:55PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2023/2/20 04:40, Christoph Hellwig 写道:
> > Move the remaining code that deals with initializing the btree
> > inode into btrfs_init_btree_inode instead of splitting it between
> > that helpers and its only caller.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Just one small nitpick.

The patch is almost one year old, it does not make much sense to send
reviews, if there's something to be fixed please send a new patch.

