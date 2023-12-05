Return-Path: <linux-btrfs+bounces-644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56E480582F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 16:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8128F281BD4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91767E89;
	Tue,  5 Dec 2023 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mwf0krrJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/1eT5vhF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDE0A9
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 07:07:46 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A16C821A76;
	Tue,  5 Dec 2023 15:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701788864;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLlmyZ8SYI36NOuKpMYFojxD7XRTz+I3/WY+y/c40oc=;
	b=Mwf0krrJJwuoyL0mgQX9tguLNDejfS3Q5mpmPWzdd8Lm7fEjGEfVNupkGqkOCZDDgwnL22
	hIy4FLd1JjbWhiTVu9+cipP9cFIAAJ+QVgNTdD+HbEUJoOCNZPliQ6V7pvoPyOO7sySf1A
	HO37BOfOMH4rVOHQ0m6ArIIjnzfRCDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701788864;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLlmyZ8SYI36NOuKpMYFojxD7XRTz+I3/WY+y/c40oc=;
	b=/1eT5vhFUzkGMxGIgMV762sjL0qoPylmadTYkPwrblVviJyIUCMBAQDHejXd4hXYgJxvCn
	BDDA/vI8/oxsmtBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 67287138FF;
	Tue,  5 Dec 2023 15:07:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4mXrFsA8b2UBFQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 15:07:44 +0000
Date: Tue, 5 Dec 2023 16:00:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 11/11] btrfs: use the flags of an extent map to identify
 the compression type
Message-ID: <20231205150054.GG2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701706418.git.fdmanana@suse.com>
 <64a0b8f04f170d4e1f0219bd975a6246e7b61b35.1701706418.git.fdmanana@suse.com>
 <20231205144351.GF2751@twin.jikos.cz>
 <CAL3q7H62x2pxoQUWHTsaaEs-YvN8OGRE5aY6M7pGr5QjfpiBnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H62x2pxoQUWHTsaaEs-YvN8OGRE5aY6M7pGr5QjfpiBnA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.931];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.46%]
X-Spam-Score: 0.01
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 

On Tue, Dec 05, 2023 at 03:01:28PM +0000, Filipe Manana wrote:
> On Tue, Dec 5, 2023 at 2:50 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Mon, Dec 04, 2023 at 04:20:33PM +0000, fdmanana@kernel.org wrote:
> > > +     else if (type == BTRFS_COMPRESS_LZO)
> > > +             em->flags |= EXTENT_FLAG_COMPRESS_LZO;
> > > +     else if (type == BTRFS_COMPRESS_ZSTD)
> > > +             em->flags |= EXTENT_FLAG_COMPRESS_ZSTD;
> > > +}
> > > +
> > > +static inline enum btrfs_compression_type extent_map_compression(const struct extent_map *em)
> > > +{
> > > +     if (em->flags & EXTENT_FLAG_COMPRESS_ZLIB)
> > > +             return BTRFS_COMPRESS_ZLIB;
> > > +
> > > +     if (em->flags & EXTENT_FLAG_COMPRESS_LZO)
> > > +             return BTRFS_COMPRESS_LZO;
> > > +
> > > +     if (em->flags & EXTENT_FLAG_COMPRESS_ZSTD)
> > > +             return BTRFS_COMPRESS_ZSTD;
> > > +
> > > +     return BTRFS_COMPRESS_NONE;
> > > +}
> > > +
> > > +/*
> > > + * More efficient way to determine if extent is compressed, instead of using
> > > + * 'extent_map_compression() != BTRFS_COMPRESS_NONE'.
> > > + */
> > > +static inline bool extent_map_is_compressed(const struct extent_map *em)
> > > +{
> > > +     return (em->flags & (EXTENT_FLAG_COMPRESS_ZLIB |
> > > +                          EXTENT_FLAG_COMPRESS_LZO |
> > > +                          EXTENT_FLAG_COMPRESS_ZSTD)) != 0;
> >
> > As a minor optimizations, you could add another bit flag when any of the
> > zlib/lzo/std is set and test just that.
> 
> How is that an optimization? The compiler ORs those compression flags
> at compile time, it would be equivalent.

Right, it's not the separate test_bit() anymore that would require the
'lock' prefix, it's indeed one constant in one instruction.

