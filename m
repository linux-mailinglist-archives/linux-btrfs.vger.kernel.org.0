Return-Path: <linux-btrfs+bounces-777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB33380B600
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 20:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72524280FE9
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 19:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287B71A29A;
	Sat,  9 Dec 2023 19:16:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E217A95;
	Sat,  9 Dec 2023 11:16:34 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ca02def690so38675061fa.3;
        Sat, 09 Dec 2023 11:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702149393; x=1702754193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvIAlV8cR7DKjpVwhZEvex6k5cOHUw6zvJ4KqiQQ7J4=;
        b=Afqy9cfNXfyam3zY5QBzyBw8JQLYL/l55eW01qRamui4B/GfSEgIHn4gy/s0KRk6ug
         CekzBhMOqz6rzE8IvmfOH+NYywICh8oiGtkCPAA7uJE05UuGmDLHOJRwGnBcXoKtb0vm
         pqilQgz2qbXufcLIbDNfmrKl+4Qb0MT+xoaAIm7bk/um4lnkWutUVBV3y/9tcofCq40e
         93tq2BKiT+2cWLF+wQeAxuxEUCYQZhKN+JufW7n/a9bjLL4ytHvThVbsUkvRMlrVt2x9
         BPoqsTW3RDrRMDjOKEFOqQtVK75FlltQwm711BScNFPgUvsP/cXP5YYSfqk8fT/v0MfF
         exHA==
X-Gm-Message-State: AOJu0YzjHxei+rX9NEqS4j3uj6ZfyVL1VfibgzmlBSFedTQUBrBC/RT1
	HQfNAUSV2aiORjQt7Bd44FDIFJFVmchCpA==
X-Google-Smtp-Source: AGHT+IGN0IV821CdXlu7CZ4P485FGl0zRIG8tNc78XYVzaDuaYLBZfHR92pXSu5JbAoB5xdF4JjjoQ==
X-Received: by 2002:a2e:8619:0:b0:2ca:365b:8585 with SMTP id a25-20020a2e8619000000b002ca365b8585mr685177lji.106.1702149392466;
        Sat, 09 Dec 2023 11:16:32 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id th19-20020a1709078e1300b00a1bda8db043sm2496840ejc.120.2023.12.09.11.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 11:16:32 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c317723a8so22972775e9.3;
        Sat, 09 Dec 2023 11:16:32 -0800 (PST)
X-Received: by 2002:a05:600c:2b10:b0:40c:16ee:321e with SMTP id
 y16-20020a05600c2b1000b0040c16ee321emr955135wme.62.1702149391793; Sat, 09 Dec
 2023 11:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
 <CAL3q7H7pMjbc1-xZ1xDSMRBM2C-FiTi=sx=mQNBqH4MbXQ_WLA@mail.gmail.com>
 <0e13042e-1322-4baf-8ffd-4cd9415acac0@oracle.com> <ea5e3a98-b5ec-46c8-bf0d-e8fbd88cf4eb@wdc.com>
In-Reply-To: <ea5e3a98-b5ec-46c8-bf0d-e8fbd88cf4eb@wdc.com>
From: Neal Gompa <neal@gompa.dev>
Date: Sat, 9 Dec 2023 14:15:54 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_B87HAvFVhm-_1Q4NDuhyELVrDxvebzrDfNzUL4yi+ww@mail.gmail.com>
Message-ID: <CAEg-Je_B87HAvFVhm-_1Q4NDuhyELVrDxvebzrDfNzUL4yi+ww@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] fstests: add tests for btrfs' raid-stripe-tree feature
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Anand Jain <anand.jain@oracle.com>, Filipe Manana <fdmanana@kernel.org>, 
	Zorro Lang <zlang@redhat.com>, Filipe Manana <fdmanana@suse.com>, 
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 4:19=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 08.12.23 02:19, Anand Jain wrote:
> >
> >
> > On 12/7/23 17:41, Filipe Manana wrote:
> >> On Thu, Dec 7, 2023 at 9:03=E2=80=AFAM Johannes Thumshirn
> >> <johannes.thumshirn@wdc.com> wrote:
> >>>
> >>> Add tests for btrfs' raid-stripe-tree feature. All of these test work=
 by
> >>> writing a specific pattern to a newly created filesystem and afterwar=
ds
> >>> using `btrfs inspect-internal -t raid-stripe $SCRATCH_DEV_POOL` to ve=
rify
> >>> the placement and the layout of the metadata.
> >>>
> >>> The md5sum of each file will be compared as well after a re-mount of =
the
> >>> filesystem.
> >>>
> >>> ---
> >>> Changes in v5:
> >>> - add _require_btrfs_free_space_tree helper and use in tests
> >>> - Link to v4: https://lore.kernel.org/r/20231206-btrfs-raid-v4-0-5782=
84dd3a70@wdc.com
> >>>
> >>> Changes in v4:
> >>> - add _require_btrfs_no_compress to all tests
> >>> - add _require_btrfs_no_nodatacow helper and add to btrfs/308
> >>> - add _require_btrfs_feature "free_space_tree" to all tests
> >>> - Link to v3: https://lore.kernel.org/r/20231205-btrfs-raid-v3-0-0e85=
7a5439a2@wdc.com
> >>>
> >>> Changes in v3:
> >>> - added 'raid-stripe-tree' to mkfs options, as only zoned raid gets i=
t
> >>>     automatically
> >>> - Rename test cases as btrfs/302 and btrfs/303 already exist upstream
> >>> - Link to v2: https://lore.kernel.org/r/20231205-btrfs-raid-v2-0-25f8=
0eea345b@wdc.com
> >>>
> >>> Changes in v2:
> >>> - Re-ordered series so the newly introduced group is added before the
> >>>     tests
> >>> - Changes Filipe requested to the tests.
> >>> - Link to v1: https://lore.kernel.org/r/20231204-btrfs-raid-v1-0-b254=
eb1bcff8@wdc.com
> >>>
> >>> ---
> >>> Johannes Thumshirn (9):
> >>>         fstests: doc: add new raid-stripe-tree group
> >>>         common: add filter for btrfs raid-stripe dump
> >>>         common: add _require_btrfs_no_nodatacow helper
> >>>         common: add _require_btrfs_free_space_tree
> >>>         btrfs: add fstest for stripe-tree metadata with 4k write
> >>>         btrfs: add fstest for 8k write spanning two stripes on raid-s=
tripe-tree
> >>>         btrfs: add fstest for writing to a file at an offset with RST
> >>>         btrfs: add fstests to write 128k to a RST filesystem
> >>>         btrfs: add fstest for overwriting a file partially with RST
> >>>
> >>>    common/btrfs        |  17 +++++++++
> >>>    common/filter.btrfs |  14 +++++++
> >>>    doc/group-names.txt |   1 +
> >>>    tests/btrfs/304     |  56 +++++++++++++++++++++++++++
> >>>    tests/btrfs/304.out |  58 ++++++++++++++++++++++++++++
> >>>    tests/btrfs/305     |  61 ++++++++++++++++++++++++++++++
> >>>    tests/btrfs/305.out |  82 ++++++++++++++++++++++++++++++++++++++++
> >>>    tests/btrfs/306     |  59 +++++++++++++++++++++++++++++
> >>>    tests/btrfs/306.out |  75 +++++++++++++++++++++++++++++++++++++
> >>>    tests/btrfs/307     |  56 +++++++++++++++++++++++++++
> >>>    tests/btrfs/307.out |  65 ++++++++++++++++++++++++++++++++
> >>>    tests/btrfs/308     |  60 +++++++++++++++++++++++++++++
> >>>    tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++=
++++++++++++
> >>>    13 files changed, 710 insertions(+)
> >>> ---
> >>> base-commit: baca8a2b5cb6e798ce3a07e79a081031370c6cb8
> >>
> >> Btw this base commit does not exist in the official fstests repo.
> >> That commit is from the staging branch at https://github.com/kdave/xfs=
tests
> >>
> >> A "git am" will fail because the official fstests repo doesn't have
> >> _require_btrfs_no_block_group_tree() at common/btrfs,
> >> so it needs to be manually adjusted when applying the 3rd patch.
> >>
> >> I tried the tests and they look good, so:
> >>
> >> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >>
> >> One question I missed before. Test 304 for example does a 4K write and
> >> expects in the golden output to get a 4K raid stripe item.
> >> What happens on a machine with 64K page size? There the default sector
> >> size is 64K, will the write result in a 64K raid stripe item or will
> >> it be 4K? In the former case, it will make the test fail.
> >>
> >
> > Testing on a 64K pagesize. Will run it. Apologies for intermittent
> > responses; OOO until December 21.
>
> Thanks Anand!
>
> I don't have a 64k page size system to test, but I _think_ Filipe is
> right, that will fail. I think we should skip these tests on non 4k secto=
rs.
>

Once we land the patch to default to 4k sector size[1] regardless of
page size, this should all work across all architectures, no?

[1]: https://lore.kernel.org/linux-btrfs/20231116160235.2708131-2-neal@gomp=
a.dev/



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

