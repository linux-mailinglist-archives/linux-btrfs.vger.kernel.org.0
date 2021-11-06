Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB77446BAD
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 01:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhKFA6T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 20:58:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:50197 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhKFA6M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 20:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636160125;
        bh=eGCHjYoLvNAPTtDoSco/R7taXwk5n7a+30fsWVX5l8I=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=VivQNKrUB/cAzAgmu4laXo8ytCie5Ni8qsMoVGiSsLAfnuVGcvO8oLHCVXNY05Vu6
         IS5Jpj8PFgopYkADv7yXh+KnCnU6UDUNbipmWJP8WcKLUcp5+SWNALDXyZrzhUdulV
         hDZ0rKnohPLiq/cYCbsl/jaInZqQQO+0yKhTQEK8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5GDv-1mYorh1bDp-0118IS; Sat, 06
 Nov 2021 01:55:25 +0100
Message-ID: <80f4c9f3-91dd-5afe-efd7-d60c5d4bcdcf@gmx.com>
Date:   Sat, 6 Nov 2021 08:55:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 00/20] btrfs-progs: extent tree v2 global root support
 prep work
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hos9XyY4YHs5B32n9SSGL0N5m1sMAelApjfokH4LvDulJBPt4/I
 BAAqIoqwnaUw9GdxceNPTilyPtK8hOQpAry5WqwZ4AvfX7yVSHLTeewvdXlV4c82cRHJ1BH
 IyrWm64/Sg6aDWX42/EbePZLa/ez4XUOZtwMLjOnIo+h5Z6xI+wvNsdegy8Ogci1RjyRrbi
 Piok9KqNukm2ziiH/4k+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sTR8mcPkTVs=:exloU2LBe7E2vf+P3irZD1
 5G5WVY6obBla2a3PT6sddqpFMRP4Rl23JG1JOmKLTNHx7o5tLHXspm6BCh/0wfSs+1f+C+fKO
 0ZxR8dT/yhc6DwIty/EVSfC2Vhm5P47unCXpZH2nldSrfKcefdTvSTK8Z10JT55KVf3mwhU2f
 tJ7g8c7dIOjPnuNAQ6v+yocNIADE/i78jKSz9oenUtNC5Wg5cIMkvk5JTCx/zIoxC+CQEN8qh
 J+Oh8lufIaQS4Bc8Rgj7H3btFl1TTj5mxeUD4rpbzT2cRwfp5Vjdl7Hl4XedGgELM//mSIexk
 pA43t5Us2SgKR79WXSHY1QIMDVmbL1Eyrx3opPcLDpJiUcCnAyVqD/PARC7pBNV8hD2S9Mo3Y
 CphKtKlB0mM3i9IvYIKC06Bm0L0lFLz59/D49gLHgNOhuxkexr8nFPtmP9HRQs2VrFQKH1iC5
 c09SlL6TmJfPPEqM2n9+05/9iH52rCjq4aDrrQ8oYUiTmP2U9z0vM+powapn6PcOVoQEbY/Fc
 r34gn2dKbIlkFlaJaB9R6FYmcc/u+ER7yTRtO5cndw4kDO8vNm4OWEYs39WmqMlfN7klNhmSl
 ALoyokmX4GbNwjX8INqpAlgrNt46I0V4Q8H+65yZzOJXofKZSq2KBk1Iuz8+o5ISm9LxxbEQE
 /zFIQZhV4scqgf3ETqQxWauNwqtPvHmCs/tdncsQGeij0Y8VO1MyOGz6S4ncDfECiZihdGAVq
 alUxhxco8GtUW11Yf6U3UnE9HgN1c87H3h0HG+WGm028mCnpzECL4NVAsmamJy2lWVaWhb10x
 PnZjP8tENd1d9MuHDkErx3O3edu06quMr6bZESMR42Iomwz7rG34z6m2iS8/5A9ag15/DMcfR
 erw4QblAE6ZixenWY449ydIbhWhjM/iV/TMi08izx2vVPIaSaPCt9UvXnHsqHnOW1fD9DtHPu
 3enBIK2dxIssNLI6WPgs+Xp8QvScK+VLSSarMj/TffKTmoNKr2tVToJGt9qIcsgOSyzDhnpdj
 W2TmkrlEVYFyltEdMQzIACCXgrxq3seC0qON2eN4L/Ts0XYZH8R0XVohm5XjlwRdZ8vN6TyN1
 5IedCMpo6Y0T7w=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:28, Josef Bacik wrote:
> Hello,
>
> This is a series of patches to do all the prep work needed to support ex=
tent
> tree v2.  These patches are independent of the actual extent tree v2 sup=
port,
> some of them are fixes,

First half are mostly good, as they are really fixes and independent
refactors.

> some of them are purely to pave the way for the global
> root support.  These patches are mostly around stopping direct access of
> ->extent_root/->csum_root/->free_space_root, putting these roots into a =
rb_tree,
> and changing the code to look up the roots in the rb_tree instead of acc=
essing
> them directly.  There are a variety of fixes to help make this easier, m=
ostly
> removing access to these roots that are strictly necessary.  Thanks,

But the later part for indirect access to previously global trees are
somewhat questionable.

The idea of rb-tree caching these trees are no problem, but the callers
are still passing place holder values to these helpers.

For current extent-tree, we can pass whatever values and get the root we
want, but that also means, we need another round of patches to fix all
the place holders to make them really extent-tree-v2 compatible.

Thus I'd prefer to see these helpers are called in a proper way in one
go, which is not really feasible to test in current preparation form.

Maybe it would be better to put these patches with the real
extent-tree-v2 code?

Thanks,
Qu

>
> Josef
>
> Josef Bacik (20):
>    btrfs-progs: simplify btrfs_make_block_group
>    btrfs-progs: check: don't walk down non fs-trees for qgroup check
>    btrfs-progs: filesystem-show: close ctree once we're done
>    btrfs-progs: add a helper for setting up a root node
>    btrfs-progs: btrfs-shared: stop passing root to csum related function=
s
>    btrfs-progs: check: stop passing csum root around
>    btrfs-progs: stop accessing ->csum_root directly
>    btrfs-progs: image: keep track of seen blocks when walking trees
>    btrfs-progs: common: move btrfs_fix_block_accounting to repair.c
>    btrfs-progs: check: abstract out the used marking helpers
>    btrfs-progs: check: move btrfs_mark_used_tree_blocks to common
>    btrfs-progs: mark reloc roots as used
>    btrfs-progs: stop accessing ->extent_root directly
>    btrfs-progs: stop accessing ->free_space_root directly
>    btrfs-progs: track csum, extent, and free space trees in a rb tree
>    btrfs-progs: check: make reinit work per found root item
>    btrfs-progs: check: check the global roots for uptodate root nodes
>    btrfs-progs: check: check all of the csum roots
>    btrfs-progs: check: fill csum root from all extent roots
>    btrfs-progs: common: search all extent roots for marking used space
>
>   btrfs-corrupt-block.c           |  15 +-
>   btrfs-map-logical.c             |   9 +-
>   btrfstune.c                     |   2 +-
>   check/main.c                    | 223 ++++++++++++++------
>   check/mode-common.c             | 132 +-----------
>   check/mode-lowmem.c             |  72 ++++---
>   check/qgroup-verify.c           |   6 +-
>   cmds/filesystem.c               |  19 +-
>   cmds/rescue-chunk-recover.c     |  35 ++--
>   common/repair.c                 | 230 +++++++++++++++++++++
>   common/repair.h                 |   5 +
>   convert/main.c                  |   5 +-
>   image/main.c                    |  14 +-
>   kernel-shared/backref.c         |  10 +-
>   kernel-shared/ctree.h           |  10 +-
>   kernel-shared/disk-io.c         | 356 +++++++++++++++++++++++---------
>   kernel-shared/disk-io.h         |   8 +-
>   kernel-shared/extent-tree.c     | 159 ++++----------
>   kernel-shared/file-item.c       |   6 +-
>   kernel-shared/free-space-tree.c |  54 +++--
>   kernel-shared/volumes.c         |   3 +-
>   kernel-shared/zoned.c           |   2 +-
>   mkfs/main.c                     |  29 ++-
>   mkfs/rootdir.c                  |   2 +-
>   24 files changed, 892 insertions(+), 514 deletions(-)
>
