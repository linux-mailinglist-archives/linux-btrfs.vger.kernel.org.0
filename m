Return-Path: <linux-btrfs+bounces-21341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGpbILp/gmnAVQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21341-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 00:07:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E649DDF8C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 00:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88305304650A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 23:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3E7310620;
	Tue,  3 Feb 2026 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQKLiluY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6932DB783
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160049; cv=none; b=cM+S6QUrGYR0u0SkmtuOP+9Y51YaTtne1CVM5xCotdjZXG1IkWpNbxvIIOKunDPatu0OQq2PGoyK52kQJL+C8oVMZhuold9eUtGoCUMOhzsYDUVdYm5n8WwfuinVgH4nFh6SkQptjAfB2d+9OBiKdo8Sc+I3oMRL5Rm/1ZFiReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160049; c=relaxed/simple;
	bh=5tfXeoXsp4vcnzPVq9VXbKxfHZZbSqqJcQchhwa1l1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9XOfe7NV/9Kl8J2/siVjxAbZb6Su8Vbqzw83bMHzy0hOzxShbeXqr7RlWZ60I/eVkNc7nWhwf7PRbaJHmah44RgLDrf/7ME3054eARl1tRB/2L0bLKi+H1TFfg1YbXRjVeCPnm7SmNX91qIv9E8szcrrv2RbVSRydYAmuaX7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQKLiluY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C17C116D0
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 23:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770160049;
	bh=5tfXeoXsp4vcnzPVq9VXbKxfHZZbSqqJcQchhwa1l1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DQKLiluYicQ1ubX+6mqyzo6aftGjVG/LcEcErT16N6uwjj+wTi46bjmGFqLHrnHpR
	 pz80nO04tCgzh556g8YSDvbAGL6QCQ7Ll0nuxZT9ZcRV6TDcqnvX+3jemTePyOrlay
	 FY3YdqMXSb21Cj+YeS4XBTPH2MwLHarad3puAEbuNUiW5UblSUcsfaa2mTHAJ+YZyU
	 FIDA7jVZf8voTpkU4j5eF4/2JwrpAZNvrpSRIvJO8R1Emp7it/sZRuWalp2HmDHEJz
	 NHtEmJjoSK3+0ja4UEK9kzhl8641p6WmW/g5Qr0A5qOJ3m3wUBMqGNYDLaCbfu16x6
	 68tP4z6vHX0yw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8e9f89a8e3so46198966b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 15:07:29 -0800 (PST)
X-Gm-Message-State: AOJu0YwR55zjqT9IacWmTlxqZkpwKScjnS+5powNaBHolZNh4LwEa8EU
	rTaK9DbcFEpn6QM1tbsxgVauguhTrJXBXo71m+LiCMIu+LgiAdEy5zcrxfQ0aC+IagGD/jvS3Xh
	fZuC0KYT5s2DnigoUH0I4SNWdd0E3+yE=
X-Received: by 2002:a17:907:c12:b0:b73:398c:c5a7 with SMTP id
 a640c23a62f3a-b8e9f2bb5c8mr67734066b.41.1770160047944; Tue, 03 Feb 2026
 15:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770123544.git.fdmanana@suse.com> <213736b4ab22e6ecdd6a10513eaed5d85b4053bc.1770123545.git.fdmanana@suse.com>
 <a3b63027-9e17-41b3-bc7f-477d1e59381a@suse.com> <CAL3q7H5_Q=na-W+uPm88yWAtPxYFd_t3kP1WK-9YhnFMr8uoZA@mail.gmail.com>
 <395eab87-29b9-4a70-82a4-2bf3dd8f3078@suse.com> <CAL3q7H61vZ3_+eqJ1A9po2WcgNJJjUu9MJQoYB2oDSAAecHaug@mail.gmail.com>
In-Reply-To: <CAL3q7H61vZ3_+eqJ1A9po2WcgNJJjUu9MJQoYB2oDSAAecHaug@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 3 Feb 2026 23:06:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4=g63O0y_pK=ExFQPvp2eZ3ijVR5yUiSxnHE=A7u2ZQQ@mail.gmail.com>
X-Gm-Features: AZwV_QjdVHgYYS7QnWE-_D_MEvIHcAPr7kTbnuSu1RBkQpClpJEuwEV1LquqAFI
Message-ID: <CAL3q7H4=g63O0y_pK=ExFQPvp2eZ3ijVR5yUiSxnHE=A7u2ZQQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: be less agressive with metadata overcommit
 when we can do full flushing
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21341-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E649DDF8C2
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 10:55=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Tue, Feb 3, 2026 at 9:59=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> >
> >
> >
> > =E5=9C=A8 2026/2/4 08:16, Filipe Manana =E5=86=99=E9=81=93:
> > [...]
> > >
> > > We can allocate when we attempt to allocate a metadata extent.
> > > However here it fails because we really have no space:
> > >
> > > at calc_available_free_space() we subtract the data chunk size, and
> > > that leaves us at around 300M, which is not enough to allocate a
> > > metadata chunk in DUP profile (256M * 2 =3D 512M).
> > >
> >
> > For 1GB sized fs, 300MiB is enough for us to allocate a new metadata bg=
.
> > As the chunk size will be no larger than 10% of the fs.
> >
> > In fact I just tried to for a 1GB btrfs to create a metadata bg by
> > filling up the initial 51MiB metadata bg.
> >
> > The resulted bg chunk size is 112MiB:
> >
> >         item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
> >                 devid 1 total_bytes 1073741824 bytes_used 367394816
> >                                      ^^^ 1GiB
> >
> >         item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16105=
 itemsize 80
> >                 length 8388608 owner 2 stripe_len 65536 type DATA|singl=
e
> >         item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15993
> > itemsize 112
> >                 length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
> >         item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15881
> > itemsize 112
> >                 length 53673984 owner 2 stripe_len 65536 type METADATA|=
DUP
> >                         ^^^ The one from mkfs
> >         item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 84082688) itemoff 15769
> > itemsize 112
> >                 length 117440512 owner 2 stripe_len 65536 type METADATA=
|DUP
> >                         ^^^ The new one, 112MiB.
> >
> > Mind to explain where the 256MiB requirement comes from?
>
> So I was looking at an old trace before.
>
> We fail to allocate a chunk because there's effectively no unallocated
> space at some point.
>
> We have a bunch of data chunks allocated by dbench++ and we reach a
> point where a metadata chunk allocation fails.
> During the first metadata chunk allocation attempt,
> gather_device_info() finds no available space due to a bunch of
> pending chunks for data block groups (each with a size of 117440512
> bytes, except for the last two).
>
> The tracing:
>
>            mount-1793735 [011] ...1. 28877.261096:
> btrfs_add_bg_to_space_info: added bg offset 13631488 length 8388608
> flags 1 to space_info->flags 1 total_bytes 8388608 bytes_used 0
> bytes_may_use 0
>            mount-1793735 [011] ...1. 28877.261098:
> btrfs_add_bg_to_space_info: added bg offset 22020096 length 8388608
> flags 34 to space_info->flags 2 total_bytes 8388608 bytes_used 16384
> bytes_may_use 0
>            mount-1793735 [011] ...1. 28877.261100:
> btrfs_add_bg_to_space_info: added bg offset 30408704 length 53673984
> flags 36 to space_info->flags 4 total_bytes 53673984 bytes_used 131072
> bytes_may_use 0
>
> These are from loading the block groups created by mkfs during mount.
>
> Then when bonnie++ starts doing its thing:
>
>    kworker/u48:5-1792004 [011] ..... 28886.122050: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824
>    kworker/u48:5-1792004 [011] ..... 28886.122053: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824 max_avail 927596544
>    kworker/u48:5-1792004 [011] ..... 28886.122055:
> btrfs_make_block_group: make bg offset 84082688 size 117440512 type 1
>    kworker/u48:5-1792004 [011] ...1. 28886.122064:
> btrfs_add_bg_to_space_info: added bg offset 84082688 length 117440512
> flags 1 to space_info->flags 1 total_bytes 125829120 bytes_used 0
> bytes_may_use 5251072
>
> First allocation of a data block group of 112M.
>
>    kworker/u48:5-1792004 [011] ..... 28886.192408: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824
>    kworker/u48:5-1792004 [011] ..... 28886.192413: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824 max_avail 810156032
>    kworker/u48:5-1792004 [011] ..... 28886.192415:
> btrfs_make_block_group: make bg offset 201523200 size 117440512 type 1
>    kworker/u48:5-1792004 [011] ...1. 28886.192425:
> btrfs_add_bg_to_space_info: added bg offset 201523200 length 117440512
> flags 1 to space_info->flags 1 total_bytes 243269632 bytes_used 0
> bytes_may_use 122691584
>
> Another 112M data block group allocated.
>
>    kworker/u48:5-1792004 [011] ..... 28886.260935: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824
>    kworker/u48:5-1792004 [011] ..... 28886.260941: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824 max_avail 692715520
>    kworker/u48:5-1792004 [011] ..... 28886.260943:
> btrfs_make_block_group: make bg offset 318963712 size 117440512 type 1
>    kworker/u48:5-1792004 [011] ...1. 28886.260954:
> btrfs_add_bg_to_space_info: added bg offset 318963712 length 117440512
> flags 1 to space_info->flags 1 total_bytes 360710144 bytes_used 0
> bytes_may_use 240132096
>
> Yet another one.
>
>         bonnie++-1793755 [010] ..... 28886.280407: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824
>         bonnie++-1793755 [010] ..... 28886.280412: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824 max_avail 575275008
>         bonnie++-1793755 [010] ..... 28886.280414:
> btrfs_make_block_group: make bg offset 436404224 size 117440512 type 1
>         bonnie++-1793755 [010] ...1. 28886.280419:
> btrfs_add_bg_to_space_info: added bg offset 436404224 length 117440512
> flags 1 to space_info->flags 1 total_bytes 478150656 bytes_used 0
> bytes_may_use 268435456
>
> One more.
>
>    kworker/u48:5-1792004 [011] ..... 28886.566233: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824
>    kworker/u48:5-1792004 [011] ..... 28886.566238: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824 max_avail 457834496
>    kworker/u48:5-1792004 [011] ..... 28886.566241:
> btrfs_make_block_group: make bg offset 553844736 size 117440512 type 1
>    kworker/u48:5-1792004 [011] ...1. 28886.566250:
> btrfs_add_bg_to_space_info: added bg offset 553844736 length 117440512
> flags 1 to space_info->flags 1 total_bytes 595591168 bytes_used
> 268435456 bytes_may_use 2
> 09723392
>
> Another one.
>
>         bonnie++-1793755 [009] ..... 28886.613446: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824
>         bonnie++-1793755 [009] ..... 28886.613451: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824 max_avail 340393984
>         bonnie++-1793755 [009] ..... 28886.613453:
> btrfs_make_block_group: make bg offset 671285248 size 117440512 type 1
>         bonnie++-1793755 [009] ...1. 28886.613458:
> btrfs_add_bg_to_space_info: added bg offset 671285248 length 117440512
> flags 1 to space_info->flags 1 total_bytes 713031680 bytes_used
> 268435456 bytes_may_use 2
> 68435456
>
> Another one.
>
>         bonnie++-1793755 [009] ..... 28886.674953: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824
>         bonnie++-1793755 [009] ..... 28886.674957: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824 max_avail 222953472
>         bonnie++-1793755 [009] ..... 28886.674959:
> btrfs_make_block_group: make bg offset 788725760 size 117440512 type 1
>         bonnie++-1793755 [009] ...1. 28886.674963:
> btrfs_add_bg_to_space_info: added bg offset 788725760 length 117440512
> flags 1 to space_info->flags 1 total_bytes 830472192 bytes_used
> 268435456 bytes_may_use 1
> 34217728
>
> Another one.
>
>         bonnie++-1793755 [009] ..... 28886.674981: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824
>         bonnie++-1793755 [009] ..... 28886.674982: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824 max_avail 105512960
>         bonnie++-1793755 [009] ..... 28886.674983:
> btrfs_make_block_group: make bg offset 906166272 size 105512960 type 1
>         bonnie++-1793755 [009] ...1. 28886.674984:
> btrfs_add_bg_to_space_info: added bg offset 906166272 length 105512960
> flags 1 to space_info->flags 1 total_bytes 935985152 bytes_used
> 268435456 bytes_may_use 67108864
>
> Another one, this time a bit smaller, ~100.6M, since we now have less spa=
ce.
>
>         bonnie++-1793758 [009] ..... 28891.962096: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824
>         bonnie++-1793758 [009] ..... 28891.962103: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min =3D 65536 dev_extent_want
> 1073741824 max_avail 12582912
>         bonnie++-1793758 [009] ..... 28891.962105:
> btrfs_make_block_group: make bg offset 1011679232 size 12582912 type 1
>         bonnie++-1793758 [009] ...1. 28891.962114:
> btrfs_add_bg_to_space_info: added bg offset 1011679232 length 12582912
> flags 1 to space_info->flags 1 total_bytes 948568064 bytes_used
> 268435456 bytes_may_use 8192
>
> Another one, this one even smaller, 12M.
>
>    kworker/u48:5-1792004 [011] ..... 28892.112802: btrfs_chunk_alloc:
> enter metadata chunk alloc
>    kworker/u48:5-1792004 [011] ..... 28892.112805: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min =3D 131072 dev_extent_want
> 536870912
>    kworker/u48:5-1792004 [011] ..... 28892.112806: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min =3D 131072 dev_extent_want
> 536870912 max_avail 0
>
> 536870912 is 512M, the 256M * 2 (DUP) thing.
> max_avail is what find_free_dev_extent() returns to us in gather_device_i=
nfo().
>
> As a result it sets ctl->ndevs to 0, making decide_stripe_size() fail
> with -ENOSPC, and therefore metadata chunk allocation fails.
>
>    kworker/u48:5-1792004 [011] ..... 28892.112807: btrfs_create_chunk:
> decide_stripe_size fail -ENOSPC
>
>
> Yes, what dmesg shows after the transaction abort does not include all
> those allocations.
> My guess on that is that after the transaction aborts, pending block
> groups are gone and it's influencing the dump. But that's another
> thing to investigate.

Ok, so it's because the cleaner happens to kick in shortly after the
first metadata chunk allocation fails with -ENOSPC and removes the
data block groups that became unused in the meanwhile.
The bytes_may_use of the data space_info started to drop and also, not
shown in the trace, the bytes_readonly started to increase because
empty data block groups were turned to RO for deletion by the cleaner.

And the cleaner then finishes deleting all these data block groups
before the transaction abort dumps the space infos.

>
> But if we add a call to btrfs_dump_space_info_for_trans_abort() to
> decide_stripe_size() when it returns -ENOSPC, before we have a
> transaction abort:
>
> [29972.409295] BTRFS info (device nullb0): dumping space info:
> [29972.409300] BTRFS info (device nullb0): space_info DATA (sub-group
> id 0) has 673341440 free, is not full
> [29972.409303] BTRFS info (device nullb0): space_info total=3D948568064,
> used=3D0, pinned=3D275226624, reserved=3D0, may_use=3D0, readonly=3D0
> zone_unusable=3D0
> [29972.409305] BTRFS info (device nullb0): space_info METADATA
> (sub-group id 0) has 3915776 free, is not full
> [29972.409306] BTRFS info (device nullb0): space_info total=3D53673984,
> used=3D163840, pinned=3D42827776, reserved=3D147456, may_use=3D6553600,
> readonly=3D65536 zone_unusable=3D0
> [29972.409308] BTRFS info (device nullb0): space_info SYSTEM
> (sub-group id 0) has 7979008 free, is not full
> [29972.409310] BTRFS info (device nullb0): space_info total=3D8388608,
> used=3D16384, pinned=3D0, reserved=3D0, may_use=3D393216, readonly=3D0
> zone_unusable=3D0
> [29972.409311] BTRFS info (device nullb0): global_block_rsv: size
> 5767168 reserved 5767168
> [29972.409313] BTRFS info (device nullb0): trans_block_rsv: size 0 reserv=
ed 0
> [29972.409314] BTRFS info (device nullb0): chunk_block_rsv: size
> 393216 reserved 393216
> [29972.409315] BTRFS info (device nullb0): remap_block_rsv: size 0 reserv=
ed 0
> [29972.409316] BTRFS info (device nullb0): delayed_block_rsv: size 0 rese=
rved 0
>
> So here we see there's over 900M of data space.
>
> So lowering the metadata overcommit limit when we can flush, helps
> getting rid of a ton of pinned space.
>
> >
> > Thanks,
> > Qu

