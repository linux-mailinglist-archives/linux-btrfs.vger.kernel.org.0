Return-Path: <linux-btrfs+bounces-642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6068057E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 15:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CA5281DA3
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21C165EDB;
	Tue,  5 Dec 2023 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GtQ1oPlS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5isLbH2+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D5196
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 06:50:42 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FCF61FB95;
	Tue,  5 Dec 2023 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701787841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bMofIJVqyJWlRikas5YTXorynAUk04Ilactg8DgXEIM=;
	b=GtQ1oPlSONIZvFHsWHdrfRccvRyUldRGC0JdDlwl0aAYU4AViThbmQDxpBEEpviKaLQnSe
	A8lvPhNAcmTBuY7aAjhSS3sW+5hVjeQw6eb89Hp50sfYacOSDxvzHtM0J6sFU4lIRnJMrs
	az2knf0Z9Nk/LGM1O7WFD+P1c+e9/tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701787841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bMofIJVqyJWlRikas5YTXorynAUk04Ilactg8DgXEIM=;
	b=5isLbH2+7Chsgv52m694awb7+jHBgBuD/YdXZMePlWmcVC6PINpfqyOopjJyZlBD3N+H9S
	IbK1PZJqqy4jklDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 63970138FF;
	Tue,  5 Dec 2023 14:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id M6JNF8E4b2WBDwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 14:50:41 +0000
Date: Tue, 5 Dec 2023 15:43:51 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 11/11] btrfs: use the flags of an extent map to identify
 the compression type
Message-ID: <20231205144351.GF2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701706418.git.fdmanana@suse.com>
 <64a0b8f04f170d4e1f0219bd975a6246e7b61b35.1701706418.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a0b8f04f170d4e1f0219bd975a6246e7b61b35.1701706418.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.02
X-Spamd-Result: default: False [-0.02 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.927];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[57.17%]

On Mon, Dec 04, 2023 at 04:20:33PM +0000, fdmanana@kernel.org wrote:
> +	else if (type == BTRFS_COMPRESS_LZO)
> +		em->flags |= EXTENT_FLAG_COMPRESS_LZO;
> +	else if (type == BTRFS_COMPRESS_ZSTD)
> +		em->flags |= EXTENT_FLAG_COMPRESS_ZSTD;
> +}
> +
> +static inline enum btrfs_compression_type extent_map_compression(const struct extent_map *em)
> +{
> +	if (em->flags & EXTENT_FLAG_COMPRESS_ZLIB)
> +		return BTRFS_COMPRESS_ZLIB;
> +
> +	if (em->flags & EXTENT_FLAG_COMPRESS_LZO)
> +		return BTRFS_COMPRESS_LZO;
> +
> +	if (em->flags & EXTENT_FLAG_COMPRESS_ZSTD)
> +		return BTRFS_COMPRESS_ZSTD;
> +
> +	return BTRFS_COMPRESS_NONE;
> +}
> +
> +/*
> + * More efficient way to determine if extent is compressed, instead of using
> + * 'extent_map_compression() != BTRFS_COMPRESS_NONE'.
> + */
> +static inline bool extent_map_is_compressed(const struct extent_map *em)
> +{
> +	return (em->flags & (EXTENT_FLAG_COMPRESS_ZLIB |
> +			     EXTENT_FLAG_COMPRESS_LZO |
> +			     EXTENT_FLAG_COMPRESS_ZSTD)) != 0;

As a minor optimizations, you could add another bit flag when any of the
zlib/lzo/std is set and test just that.

Otherwise, I like the changes and space savings.

