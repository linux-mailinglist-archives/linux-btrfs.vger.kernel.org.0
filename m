Return-Path: <linux-btrfs+bounces-270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEE97F37DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 22:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610B81C20E0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 21:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03C154666;
	Tue, 21 Nov 2023 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RAz38oaQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e1DCWCvz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD1219E
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:10:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 56B81218B8;
	Tue, 21 Nov 2023 21:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700601058;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhHC58l8yW7/xxNMU6Av2czXsy3OOGSANJR0Yc7Mxy0=;
	b=RAz38oaQIwQarhkdh4CWuEEYsxIsbwb2wPQYamGkPhQY8M6tbNwNOlHJjQJZwkiyiFGCBL
	Ff9Pvxs7ZM7xFMcrmNfM2BXJfm9gC0oyhBIGOop4WPCdyrJJY0je/+8XgCmAZ1Ma9aNBS8
	0HrE1xEaQ5ZxybycH1fFDrABiJpP35s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700601058;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhHC58l8yW7/xxNMU6Av2czXsy3OOGSANJR0Yc7Mxy0=;
	b=e1DCWCvzLRGivbMZkEL0BHuZD9qSKsixmzjrznJvlFMC+YL0Gb7ifmxMqlJfyAK2eGUOPp
	VY2xxbwsPHvB4qDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34392138E3;
	Tue, 21 Nov 2023 21:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mX/rC+IcXWUVHAAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 21 Nov 2023 21:10:58 +0000
Date: Tue, 21 Nov 2023 22:03:48 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs: add a btrfs_chunk_map structure and
 preparatory cleanups
Message-ID: <20231121210348.GW11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1700573313.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700573313.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.94
X-Spamd-Result: default: False [-3.94 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.94)[99.75%]

On Tue, Nov 21, 2023 at 01:38:31PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following are some cleanups and introducing a dedicated data structure
> for representing chunk maps, in order to make code simpler and use less
> memory - this is achieved in patch 7/8. This patchset is also preparatory
> work for some upcoming changes to extent maps.
> 
> Filipe Manana (8):
>   btrfs: fix off-by-one when checking chunk map includes logical address
>   btrfs: make error messages more clear when getting a chunk map
>   btrfs: mark sanity checks when getting chunk map as unlikely
>   btrfs: split assert into two different asserts when removing block group
>   btrfs: unexport extent_map_block_end()
>   btrfs: use btrfs_next_item() at scrub.c:find_first_extent_item()
>   btrfs: use a dedicated data structure for chunk maps
>   btrfs: remove stripe size local variable from insert_dev_extents()

I have applied this to misc-next, withot the reordering in 7/8. This can
be done later eventually.

