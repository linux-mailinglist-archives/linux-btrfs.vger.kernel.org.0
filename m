Return-Path: <linux-btrfs+bounces-940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB33811DBA
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 19:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585E9B212DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 18:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145286470A;
	Wed, 13 Dec 2023 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MfhlQCGV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zr+cwYeA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YHxopBlF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iZDRitE9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1593BD0;
	Wed, 13 Dec 2023 10:59:18 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF39A1F45E;
	Wed, 13 Dec 2023 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702493956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u0h2ZNG6X6V2rHTRwXj9IAT1q7q1TXEd0rgOFUzHYeY=;
	b=MfhlQCGVwnNe56TOW67WFbF+2HU+1C9glnpl2r1vXB8KJ+OLnUo8jyTk0usuSA3W7mWRBg
	hKCVlE853dhVb8IsRNOQhlM6CXTDvPF9AyVLGSUlogwwppnOviptXNn3cuX6ayvNUMjdDj
	kkk+C4TuxsCQUjHfdZDC4yq4B7aez7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702493956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u0h2ZNG6X6V2rHTRwXj9IAT1q7q1TXEd0rgOFUzHYeY=;
	b=Zr+cwYeA+iiBGRJNwiweahOa8+iBthNY3+h2LkPmkHj8032uhYuyi04XGfthRts2exMSQj
	Rzlb6h/0QGFSFbDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702493935;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u0h2ZNG6X6V2rHTRwXj9IAT1q7q1TXEd0rgOFUzHYeY=;
	b=YHxopBlFh3TlniK7EMx1Is3WBXkn9FdKnhT2H4gpQHDUMfpfWXFEo9cKNjKjt3/DKefF1x
	HFVM0ME7e5vXQ2QttZcvIK28U3OtTpycJDiO8R2MBJHd4UqfNEZ3z/+gqlxZvWC3cUPfEV
	av+C4oGeB56u1qQlGzXaziHLkAXUtlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702493935;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u0h2ZNG6X6V2rHTRwXj9IAT1q7q1TXEd0rgOFUzHYeY=;
	b=iZDRitE92MqWAO1DQ1/7z3VfOc91vMBQYVEU3t4nwaaRfX3d4RBl4Tg6k2rQR/KN5qyBtV
	Yt0sY5j518cgu+BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B5B911391D;
	Wed, 13 Dec 2023 18:58:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id upEyK+/+eWWgCwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 13 Dec 2023 18:58:55 +0000
Date: Wed, 13 Dec 2023 19:52:04 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/13] btrfs: clean up RAID I/O geometry calculation
Message-ID: <20231213185204.GE3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.00
X-Spamd-Result: default: False [-3.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, Dec 13, 2023 at 06:42:55AM -0800, Johannes Thumshirn wrote:
> The calculation of the RAID I/O geometry in btrfs_map_block has been a maze of
> if-else statements for a very long time and the advent of the
> raid-stripe-tree made the situation even worse.
> 
> This patchset refactors btrfs_map_block() to untagle the maze and make I/O
> geometry setting easier to follow, but does not introduce any functional
> changes.
> 
> I've also run it through Josef's CI and there have been test failures, but
> none of them introduced by these patches.
> 
> ---
> Changes in v2:
> - add btrfs_map_op into struct btrfs_io_geometry
> - split RAID56 read and write into two different helpers
> - drop redundand 'for' in helper function names
> - kept dev_replace_is_ongoing variable name
> - Link to v1: https://lore.kernel.org/r/20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com
> 
> ---
> Johannes Thumshirn (13):
>       btrfs: factor out helper for single device IO check
>       btrfs: re-introduce struct btrfs_io_geometry
>       btrfs: factor out block-mapping for RAID0
>       btrfs: factor out RAID1 block mapping
>       btrfs: factor out block mapping for DUP profiles
>       btrfs: factor out block mapping for RAID10
>       btrfs: reduce scope of data_stripes in btrfs_map_block
>       btrfs: factor out block mapping for RAID5/6
>       btrfs: factor out block mapping for single profiles
>       btrfs: btrfs: untagle if else maze in btrfs_map_block
>       btrfs: open code set_io_stripe for RAID56
>       btrfs: pass struct btrfs_io_geometry to set_io_stripe
>       btrfs: pass btrfs_io_geometry into btrfs_max_io_len

Added to misc-next with some adjustments, thanks. I've noticed some of
the helpers can take const parameters, some lines that can be joined so
the expression is one one line, but there are calculations like in
"btrfs: open code set_io_stripe for RAID56" where it's up to your
creativity.

