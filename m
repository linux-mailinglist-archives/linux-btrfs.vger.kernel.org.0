Return-Path: <linux-btrfs+bounces-12026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77790A50070
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 14:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A26188E9D4
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D90E24886B;
	Wed,  5 Mar 2025 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gzXfL+bB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QTjNadoB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eYlQtNZp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mSCyBltT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3495248866
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180848; cv=none; b=Hoqz+O06QtLfdbKzQQo3yfm/tyIpgjPVGz6vYVKHOBEXcJZmjeRBS9vY1pLWmvhTe07YcoA8zwXCBMIWAHrEhBNr1Q3obePAk9y82lKNiRg/kOZgetx9a7bXGNLgY6m0Z3QxQFXYLtRZ6LUdyPgFEib1rpizknoNDX1oeNRzSXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180848; c=relaxed/simple;
	bh=/M8OSFCrgGYgSJ5QfrxmnsCt5oEvGFWrbySRMPbNkQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OD35F+G2Ul4gyKcwtP1Y9r41a6rlDX/z5jsfatqfGodGh/KMrjHLf1szqvzCeWRImo1oxjIClgfx1l9DZrJzpaQS9VSambv/6mlqcwcN3KUh0DqsGbHjpYNPn+JKwypVCew26LjvYsabB7Pe5FPXCG1u4f2Ij2HP00FE3PiZwGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gzXfL+bB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QTjNadoB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eYlQtNZp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mSCyBltT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFC2321163;
	Wed,  5 Mar 2025 13:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741180845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTWeambnQ2jG4arLdzXuBLMZQWcr2Qu066hNkPyxQvo=;
	b=gzXfL+bB+x6FK26SiuSnG9FKd8kph3mRQB8oK+105Jcpq5V7w51brTOPDLafqcX3WsvWtn
	bxEzi8o/PRKmcqlyIKCd+2I531L4jWNfiUjbUL9hopui/vVgBmYoNnMwACd83Yiz4UuvuQ
	ccMzEClmxyVjE1xcaq8qMJS4L2LlDSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741180845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTWeambnQ2jG4arLdzXuBLMZQWcr2Qu066hNkPyxQvo=;
	b=QTjNadoBIKMOCrU+br7mPFR1K50AiIxVQuSFGVes64myHN/G4xxc8DUDhl1vctWv/Gzflj
	fUV41Z52lkvBf/DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741180844;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTWeambnQ2jG4arLdzXuBLMZQWcr2Qu066hNkPyxQvo=;
	b=eYlQtNZp7xOgu0uIYG8zpNdcWyiHIztz5foUg/uDavICojGd7W29kusTnyLWLdmKur93aG
	FNBGncQcbzRgaY4774PKvGZRLJ681JULKjNxqriGYlv7RrIWJ5FYq4v+jT/fqjOs4gr6i/
	Fe8Y3PK5WhiJ5R+m7SuOLo8/psSL2mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741180844;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTWeambnQ2jG4arLdzXuBLMZQWcr2Qu066hNkPyxQvo=;
	b=mSCyBltThx/0Hq0GObFl6jSFqdecr2DR5J8MPQjKl/H4WTQ6kLS3M0PQwMK5XGx4kg1HNT
	MaZ8Q9VmNgboSjBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6FFB13939;
	Wed,  5 Mar 2025 13:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yw9AKKxPyGcqOwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Mar 2025 13:20:44 +0000
Date: Wed, 5 Mar 2025 14:20:43 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/12] btrfs-progs: zoned: support zone capacity and
Message-ID: <20250305132043.GF5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1739951758.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739951758.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Feb 19, 2025 at 04:57:44PM +0900, Naohiro Aota wrote:
> Running mkfs.btrfs on a null_blk device with the following setup fails
> as below.
> 
> - zone size: 64MB
> - zone capacity: 64MB
> - number of conventional zones: 6
> - storage size: 2048MB
> 
>     + /home/naota/src/btrfs-progs/mkfs.btrfs -d single -m dup -f /dev/nullb0
>     btrfs-progs v6.10
>     See https://btrfs.readthedocs.io for more information.
> 
>     zoned: /dev/nullb0: host-managed device detected, setting zoned feature
>     Resetting device zones /dev/nullb0 (32 zones) ...
>     NOTE: several default settings have changed in version 5.15, please make sure
>           this does not affect your deployments:
>           - DUP for metadata (-m dup)
>           - enabled no-holes (-O no-holes)
>           - enabled free-space-tree (-R free-space-tree)
> 
>     bad tree block 268435456, bytenr mismatch, want=268435456, have=0
>     kernel-shared/disk-io.c:485: write_tree_block: BUG_ON `1` triggered, value 1
>     /home/naota/src/btrfs-progs/mkfs.btrfs(+0x290ca) [0x55603cf7e0ca]
>     /home/naota/src/btrfs-progs/mkfs.btrfs(write_tree_block+0xa7) [0x55603cf80417]
>     /home/naota/src/btrfs-progs/mkfs.btrfs(__commit_transaction+0xe8) [0x55603cf9b7d8]
>     /home/naota/src/btrfs-progs/mkfs.btrfs(btrfs_commit_transaction+0x176) [0x55603cf9ba66]
>     /home/naota/src/btrfs-progs/mkfs.btrfs(main+0x2831) [0x55603cf67291]
>     /usr/lib64/libc.so.6(+0x271ee) [0x7f5ab706f1ee]
>     /usr/lib64/libc.so.6(__libc_start_main+0x89) [0x7f5ab706f2a9]
>     /home/naota/src/btrfs-progs/mkfs.btrfs(_start+0x25) [0x55603cf6a135]
>     /home/naota/tmp/test-mkfs.sh: line 13: 821886 Aborted                 (core dumped)
> 
> The crash happens because btrfs-progs failed to set proper allocation
> pointer when a DUP block group is created over a conventional zone and a
> sequential write required zone. In that case, the write pointer is
> recovered from the last allocated extent in the block group. That
> functionality is not well implemented in btrfs-progs side.
> 
> Implementing that functionality is relatively trivial because we can
> copy the code from the kernel side. However, the code is quite out of
> sync between the kernel side and user space side. So, this series first
> refactors btrfs_load_block_group_zone_info() to make it easy to
> integrate the code from the kernel side.
> 
> The main part is the last patch, which fixes allocation pointer
> calculation for all the profiles.
> 
> While at it, this series also adds support for zone capacity and zone
> activeness. But, zone activeness support is currently limited. It does
> not attempt to check the zone active limit on the extent allocation,
> because mkfs.btrfs should work without hitting the limit.
> 
> - v2
>     - Temporarily fails some profiles while adding supports in the patch
>       series.
> - v1: https://lore.kernel.org/linux-btrfs/cover.1739756953.git.naohiro.aota@wdc.com/
> 
> Naohiro Aota (12):
>   btrfs-progs: introduce min_not_zero()
>   btrfs-progs: zoned: introduce a zone_info struct in
>     btrfs_load_block_group_zone_info
>   btrfs-progs: zoned: support zone capacity
>   btrfs-progs: zoned: load zone activeness
>   btrfs-progs: zoned: activate block group on loading
>   btrfs-progs: factor out btrfs_load_zone_info()
>   btrfs-progs: zoned: factor out SINGLE zone info loading
>   btrfs-progs: zoned: implement DUP zone info loading
>   btrfs-progs: zoned: implement RAID1 zone info loading
>   btrfs-progs: zoned: implement RAID0 zone info loading
>   btrfs-progs: implement RAID10 zone info loading
>   btrfs-progs: zoned: fix alloc_offset calculation for partly
>     conventional block groups

Added to devel, thanks.

