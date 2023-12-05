Return-Path: <linux-btrfs+bounces-647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DD2805978
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798E7B21158
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8908D63DCE;
	Tue,  5 Dec 2023 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RC6CWcXp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aWbW+cqe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F84C0
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 08:05:25 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C10361FB9B;
	Tue,  5 Dec 2023 16:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701792323;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SpF1biVbbMPTkFLIac86hK1eVB+hA/8/Kat7e1+0r0g=;
	b=RC6CWcXphi+wB99LhwID4oLNv/FmOEC89WFLKlCwu1TbZY7p/UMYZdfshAt/EeMn1TXN4k
	MRZBt4aNbV6inFC+YRACROSajIWySuoyTtttwL1gU3IAnPMQnfD1oIFhLd9zfOhkRgMK8q
	2zhxOJErv82e4hrBI6lUMN4Qa5WYE0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701792323;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SpF1biVbbMPTkFLIac86hK1eVB+hA/8/Kat7e1+0r0g=;
	b=aWbW+cqeI32p8YXTlZLH1QxrKwN2Vibp7F13DgZqO1tgLCfoErsE9fFPho806nclY6Yzly
	Lg6Vn/I7ruH1J1Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 932DC13924;
	Tue,  5 Dec 2023 16:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id A8E0IkNKb2XqJwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 16:05:23 +0000
Date: Tue, 5 Dec 2023 16:58:33 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/11] btrfs: some cleanups and optimizations for extent
 maps
Message-ID: <20231205155833.GJ2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701706418.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701706418.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.00
X-Spamd-Result: default: False [0.00 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-0.985];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[36.01%]

On Mon, Dec 04, 2023 at 04:20:22PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> These do some cleanups around extent maps and their tests, as well as
> some optimizations. These are part of a larger work around extent maps,
> but as they are fairly independent and the remainder will take a longer
> while, sending these out separately. More details on the change logs.
> 
> Filipe Manana (11):
>   btrfs: assert extent map is not in a list when setting it up
>   btrfs: tests: fix error messages for test case 4 of extent map tests
>   btrfs: tests: do not ignore NULL extent maps for extent maps tests
>   btrfs: tests: print all values as decimal in messages for extent map tests
>   btrfs: unexport add_extent_mapping()
>   btrfs: remove redundant value assignment at btrfs_add_extent_mapping()
>   btrfs: log messages at unpin_extent_range() during unexpected cases
>   btrfs: avoid useless rbtree iterations when attempting to merge extent map
>   btrfs: make extent_map_end() argument const
>   btrfs: refactor mergable_maps() for more readability
>   btrfs: use the flags of an extent map to identify the compression type

Added to misc-next, thanks.

