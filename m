Return-Path: <linux-btrfs+bounces-20954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBf8LmVJc2mHuQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20954-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 11:11:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CC17407D
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 11:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A16AC303D64A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B30F33C1A3;
	Fri, 23 Jan 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRmRdp4z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45A335061
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162708; cv=none; b=GbyyVQKuKiNz8q7lDzHkkJ3Cp/pJGZ1B79dp8PmoOR+9zam1nhQ8KUr5h7cxHKVXNqsTh0cKMVApeMcLcEQSIVzHJwOV5/IeDZgJornt3mZtnzsf9KtYKLAuuy3k2wkbbioWPyP1rW+l/EJy10Nh3maGgzscNjqAo7qAN+qWncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162708; c=relaxed/simple;
	bh=u3kgJcEKEkYdX82XtsluGtmrOUHhpntrLrkUVRon814=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tA/srai2CObeoxd4uGL8iELElNW3mv8dt79ps5RSh+Lpz0MEvrVkXoXVGVGufunCEUOa/ejLk+F5gTV/u3/v+Oqjnt7/91Fxx+5m1hlBllO1aa4v5ItMVAUz/n+S/CtHKel2+BPvZ+TblUpGitpDU76dOsCmjNjVHbq2MOlHjEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRmRdp4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E661CC116D0
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 10:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769162705;
	bh=u3kgJcEKEkYdX82XtsluGtmrOUHhpntrLrkUVRon814=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lRmRdp4z9e7o3FwMWpwwZJmEvPGK28f4da9g31+9EPkJAIy6TvVHSNtOHg/pGXiU9
	 qZh91sxSiahwuFjcGQuE+hG+9s8N1um4bTkGgVDDbvRxNReS92exfkxgLAdfyKLa5b
	 oHymGRBGNNCREy28cVeieIs3rW5u9Qthc1M5FYFy9kMd8u9D0YTKaxNZICqWCi5ztF
	 lDKgofmoBhvc1wKTvo2TAClK584d5FjpLqLlh9Q5YC+rDOKOzYoJrPY7N3floeqQwc
	 w9R2Qhsx3XYSwezehmw1cfjWWzEFXG7Z5+6nyxEvkAe/xqPfYUA6FMzM7JJXFqHYzR
	 dNsQctmNl5xZw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b87003e998bso545861366b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 02:05:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXPssyosvVQq7WDC7/K9W/TcQzpieij/BtdsDxOVAPwOCxEadKHefWblRJ5b66UHarMn+dpQNVy1TmUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyz4u4ylDa7yE1c4EMFT6JrFldfBwkzyLeXQQPVHfiaq0jkrNS
	/Gjt2Xy2RziweLiCVzQnhLqwh+6DYmxPXDtcAzDZIg0srWGJmAihrxyAsHV3LveIr6pabcKftlk
	biUmN9KmLKeiwOqxABXYbDTdZwZMtHEM=
X-Received: by 2002:a17:907:c03:b0:b72:5629:1789 with SMTP id
 a640c23a62f3a-b8831b4088dmr474341166b.13.1769162704434; Fri, 23 Jan 2026
 02:05:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107141015.25819-1-mark@harmstone.com> <20260121221247.GR26902@twin.jikos.cz>
In-Reply-To: <20260121221247.GR26902@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 23 Jan 2026 10:04:27 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Da-MDdODqKvaCXAVN_AGEFUDyxua5ChKL-y5uFP0w8Q@mail.gmail.com>
X-Gm-Features: AZwV_Qher73D4GQi_uuRJ9dfuDw_egIfMbALJ88_8La0fbPfcEY3sVCySN5KOsQ
Message-ID: <CAL3q7H6Da-MDdODqKvaCXAVN_AGEFUDyxua5ChKL-y5uFP0w8Q@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] Remap tree
To: dsterba@suse.cz
Cc: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-20954-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35CC17407D
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 10:24=E2=80=AFPM David Sterba <dsterba@suse.cz> wro=
te:
>
> On Wed, Jan 07, 2026 at 02:09:00PM +0000, Mark Harmstone wrote:
> > This is version 8 of the patch series for the new logical remapping tre=
e
> > feature - see the previous cover letters for more information including
> > the rationale:
> >
> > * RFC: https://lore.kernel.org/all/20250515163641.3449017-1-maharmstone=
@fb.com/
> > * Version 1: https://lore.kernel.org/all/20250605162345.2561026-1-mahar=
mstone@fb.com/
> > * Version 2: https://lore.kernel.org/all/20250813143509.31073-1-mark@ha=
rmstone.com/
> > * Version 3: https://lore.kernel.org/all/20251009112814.13942-1-mark@ha=
rmstone.com/
> > * Version 4: https://lore.kernel.org/all/20251024181227.32228-1-mark@ha=
rmstone.com/
> > * Version 5: https://lore.kernel.org/all/20251110171511.20900-1-mark@ha=
rmstone.com/
> > * Version 6: https://lore.kernel.org/all/20251114184745.9304-1-mark@har=
mstone.com/
> > * Version 7: https://lore.kernel.org/all/20251124185335.16556-1-mark@ha=
rmstone.com/
> >
> > Changes since version 7:
> > * renamed struct btrfs_remap to struct btrfs_remap_item
> > * renamed BTRFS_BLOCK_GROUP_FLAGS_REMAP to BTRFS_BLOCK_GROUP_FLAGS_META=
DATA_REMAP
> > * added unlikelies
> > * renamed new commit_* fields in struct btrfs_block_group to last_*, an=
d added
> >   new patch renaming existing commit_used to last_used to match
> > * merged do_copy() into copy_remapped_data()
> > * initialized on-stack struct btrfs_remap_items
> > * fixed comments
> > * added other minor changes as suggested by David Sterba
> >
> > Mark Harmstone (17):
> >   btrfs: add definitions and constants for remap-tree
> >   btrfs: add METADATA_REMAP chunk type
> >   btrfs: allow remapped chunks to have zero stripes
> >   btrfs: remove remapped block groups from the free-space tree
> >   btrfs: don't add metadata items for the remap tree to the extent tree
> >   btrfs: rename struct btrfs_block_group field commit_used to last_used
> >   btrfs: add extended version of struct block_group_item
> >   btrfs: allow mounting filesystems with remap-tree incompat flag
> >   btrfs: redirect I/O for remapped block groups
> >   btrfs: handle deletions from remapped block group
> >   btrfs: handle setting up relocation of block group with remap-tree
> >   btrfs: move existing remaps before relocating block group
> >   btrfs: replace identity remaps with actual remaps when doing
> >     relocations
> >   btrfs: add do_remap param to btrfs_discard_extent()
> >   btrfs: allow balancing remap tree
> >   btrfs: handle discarding fully-remapped block groups
> >   btrfs: populate fully_remapped_bgs_list on mount
>
> Patches have been added to for-next. There were many coding style issues
> which I've tried to fix. As this is a lot of new code it'll get updated
> anyway, I realized that for this kind of initial batch the coding
> style is quite important as we'd have to stick with until some random
> change touches it. Please have a look for the differences. Thanks.

This is a huge amount of code and quite critical.
Shouldn't we have test cases in fstests to exercise this feature?
I didn't see any test cases submitted.

>

