Return-Path: <linux-btrfs+bounces-259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2FB7F3435
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 17:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E88B1C21CE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 16:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1056E495F5;
	Tue, 21 Nov 2023 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THUtheoD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BB3EA6E
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 16:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA960C433CD
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 16:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700585445;
	bh=5QIsfU5Q0SrLQOWeOqqYvim79Sugzncr9sGvwaQlrkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=THUtheoDqzU1MIzuyU5OlinQesf2MzPK39LAgDze62ca3CsqArZoazkiS+LTCQp7J
	 ge33M9yxU2lPq41486xSRpyYY7rr6slQ1kMSlhjySKxOMF24oZOlsXAZ9z9uApfeBJ
	 OghA8KPKFcOQQiLC+BhkUEv5bfLbQT/vdNCuIT4VzCMeTAm36k2P3RcX/9p/Bfakwn
	 geaqwzXWXuY68+2RruBzSmG6o2jgk3vBF0WHYtcDm1HvusCo5v9J+psXR0nUtY0FHK
	 74rziymcrTbnftx8TO/2E2D0N/q+yVC+XssZ6Dvv446dHMB8wzFWWVwhKvZqJQOsNl
	 6AcP0CqzBaLcg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a02d91ab199so82285066b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 08:50:45 -0800 (PST)
X-Gm-Message-State: AOJu0YwSjjIDga6oTFDGSEXRqjpzVUWxFBoKxPAgK1czfpt0KcbFFPXk
	S6XWvj85/EfrCttu3zUQeeUqDBb1swoQL42ft/g=
X-Google-Smtp-Source: AGHT+IFXKxdfVQ/PPa51iUBPwsTBaQpEnJm8ovTrDg38Qw7WJ2Y5O+n7PTarX9aNvC4MkahDslG4lWCoCpLiiGM/+vw=
X-Received: by 2002:a17:906:d7:b0:9c4:54c6:8030 with SMTP id
 23-20020a17090600d700b009c454c68030mr9364724eji.6.1700585444156; Tue, 21 Nov
 2023 08:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700573313.git.fdmanana@suse.com> <777320fd09dfc68a89180723bf5d7368dab06299.1700573314.git.fdmanana@suse.com>
 <20231121151933.GR11264@twin.jikos.cz>
In-Reply-To: <20231121151933.GR11264@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 21 Nov 2023 16:50:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6sb+N86AFiSuK1+qJU0LGBSGRM0LXHmdPGW_Ff5AMUyg@mail.gmail.com>
Message-ID: <CAL3q7H6sb+N86AFiSuK1+qJU0LGBSGRM0LXHmdPGW_Ff5AMUyg@mail.gmail.com>
Subject: Re: [PATCH 7/8] btrfs: use a dedicated data structure for chunk maps
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 3:26=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Tue, Nov 21, 2023 at 01:38:38PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently we abuse the extent_map structure for two purposes:
> >
> > 1) To actually represent extents for inodes;
> > 2) To represent chunk mappings.
> >
> > This is odd and has several disadvantages:
> >
> > 1) To create a chunk map, we need to do two memory allocations: one for
> >    an extent_map structure and another one for a map_lookup structure, =
so
> >    more potential for an allocation failure and more complicated code t=
o
> >    manage and link two structures;
> >
> > 2) For a chunk map we actually only use 3 fields (24 bytes) of the
> >    respective extent map structure: the 'start' field to have the logic=
al
> >    start address of the chunk, the 'len' field to have the chunk's size=
,
> >    and the 'orig_block_len' field to contain the chunk's stripe size.
> >
> >    Besides wasting a memory, it's also odd and not intuitive at all to
> >    have the stripe size in a field named 'orig_block_len'.
> >
> >    We are also using 'block_len' of the extent_map structure to contain
> >    the chunk size, so we have 2 fields for the same value, 'len' and
> >    'block_len', which is pointless;
> >
> > 3) When an extent map is associated to a chunk mapping, we set the bit
> >    EXTENT_FLAG_FS_MAPPING on its flags and then make its member named
> >    'map_lookup' point to the associated map_lookup structure. This mean=
s
> >    that for an extent map associated to an inode extent, we are not usi=
ng
> >    this 'map_lookup' pointer, so wasting 8 bytes (on a 64 bits platform=
);
> >
> > 4) Extent maps associated to a chunk mapping are never merged or split =
so
> >    it's pointless to use the existing extent map infrastructure.
> >
> > So add a dedicated data structure named 'btrfs_chunk_map' to represent
> > chunk mappings, this is basically the existing map_lookup structure wit=
h
> > some extra fields:
> >
> > 1) 'start' to contain the chunk logical address;
> > 2) 'chunk_len' to contain the chunk's length;
> > 3) 'stripe_size' for the stripe size;
> > 4) 'rb_node' for insertion into a rb tree;
> > 5) 'refs' for reference counting.
> >
> > This way we do a single memory allocation for chunk mappings and we don=
't
> > waste memory for them with unused/unnecessary fields from an extent_map=
.
> >
> > We also save 8 bytes from the extent_map structure by removing the
> > 'map_lookup' pointer, so the size of struct extent_map is reduced from
> > 144 bytes down to 136 bytes, and we can now have 30 extents map per 4K
> > page instead of 28.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/block-group.c            | 165 ++++-----
> >  fs/btrfs/block-group.h            |   6 +-
> >  fs/btrfs/dev-replace.c            |  28 +-
> >  fs/btrfs/disk-io.c                |   7 +-
> >  fs/btrfs/extent_map.c             |  46 ---
> >  fs/btrfs/extent_map.h             |   4 -
> >  fs/btrfs/fs.h                     |   3 +-
> >  fs/btrfs/inode.c                  |  25 +-
> >  fs/btrfs/raid56.h                 |   2 +-
> >  fs/btrfs/scrub.c                  |  39 +--
> >  fs/btrfs/tests/btrfs-tests.c      |   3 +-
> >  fs/btrfs/tests/btrfs-tests.h      |   1 +
> >  fs/btrfs/tests/extent-map-tests.c |  40 +--
> >  fs/btrfs/volumes.c                | 540 ++++++++++++++++++------------
> >  fs/btrfs/volumes.h                |  45 ++-
> >  fs/btrfs/zoned.c                  |  24 +-
>
> I see a lot of errors when compiling zoned.c, there are still map_lookup
> structures. Do you have the zoned mode config option enabled?

It misses this hunk:   https://pastebin.com/raw/mr1KMZ8N

Do you want me to send a v2, or do you prefer to fix it up?

Thanks.

>
>   CC [M]  fs/btrfs/zoned.o
> fs/btrfs/zoned.c:1293:40: warning: =E2=80=98struct map_lookup=E2=80=99 de=
clared inside parameter list will not be visible outside of this definition=
 or declaration
>  1293 |                                 struct map_lookup *map)
>       |                                        ^~~~~~~~~~
> fs/btrfs/zoned.c: In function =E2=80=98btrfs_load_zone_info=E2=80=99:
> fs/btrfs/zoned.c:1296:42: error: invalid use of undefined type =E2=80=98s=
truct map_lookup=E2=80=99
>  1296 |         struct btrfs_device *device =3D map->stripes[zone_idx].de=
v;
>       |                                          ^~
> fs/btrfs/zoned.c:1302:29: error: invalid use of undefined type =E2=80=98s=
truct map_lookup=E2=80=99
>  1302 |         info->physical =3D map->stripes[zone_idx].physical;
>       |                             ^~
> fs/btrfs/zoned.c: At top level:
> fs/btrfs/zoned.c:1396:46: warning: =E2=80=98struct map_lookup=E2=80=99 de=
clared inside parameter list will not be visible outside of this definition=
 or declaration
>  1396 |                                       struct map_lookup *map,
>       |                                              ^~~~~~~~~~
> fs/btrfs/zoned.c: In function =E2=80=98btrfs_load_block_group_dup=E2=80=
=99:
> fs/btrfs/zoned.c:1402:17: error: invalid use of undefined type =E2=80=98s=
truct map_lookup=E2=80=99
>  1402 |         if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->str=
ipe_root) {
>       |                 ^~
> ...

