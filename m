Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC5540AAE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 11:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhINJcP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 05:32:15 -0400
Received: from mout.gmx.net ([212.227.17.21]:42165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhINJcP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 05:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631611854;
        bh=guOKjNHlZ3gIq2NvW3cTBo4xSs1Nq3Zu28/JX+DTLVA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WGj7QqYbXKsRhcvQwTZvrXoTweYqdvjjYjcQ3vbxYM+ppEBCFeFPEtdGlj4ydSIgD
         o+QYlG5B34vlsMC1b7ID/VpJ8PAMrskLMpdnPo7DJzOHVdxWyNFdl54xayeSJu6NSa
         RaIeP4DfhWKNuPHPoT0I7mdl1jvM2vl5fhePTIl4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5eX-1m9moN0WaD-00J1hi; Tue, 14
 Sep 2021 11:30:54 +0200
Subject: Re: [PATCH v2 0/8] Implement progs support for removing received uuid
 on RW vols
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210914090558.79411-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f75b31ce-9f33-4706-e187-dd0911d22f7d@gmx.com>
Date:   Tue, 14 Sep 2021 17:30:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914090558.79411-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oB6VAQ5q4RZLwfL0TghrmQ8UYll8mI9amy0vd30msYBlOnMNqDI
 vXEWPbx1yhZRbdAsfnQTPbf3ERmRCV1xeYDgC/dkezj3no0S6mcuhWjJ7YYDgfVo3W+f9zs
 a1bOnE1zudS0snf5Nv9m9M98aTMjcqLjEmUtIscjood3YmzjiL0GctSWvqKyGnjbPImvWjB
 nr64trMOs8dKvNg3Xes1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pylrD+nW3XM=:Vzq2hy1DW4sZFllQO/ZpGq
 MVYclluBp2el9XtnxVbWfrmFJsToSdLd/4HAdBBFgDnFx6ydsXKdRrYc7F/qWZJ1yXXdIVRTJ
 PLynL2UtpxfxNsKEx2uomdLuBtZAT2kBXJzb9fVF27WNwsSlVKyivINVYdsTevbm4F6A4Z/jB
 Qxs4bXtHJoz9Y8h+Hgu6UgHDDd+MYtdr/6W12r2jnTaP3LjhirwQ5hYL/el76X90+e0XSKv6r
 LViRNcjUosAnjjTmUlaeFQJSDzd9l49lcQhOjaDmvt55BC40SSwcjnEhwOeZv9ouQMYSmCE1B
 Dr/+ZayHsEUiXFLpOFcMJp8Lppi4jrZSbxdMZeGQasWNAsWxGwnDrKvM2gXMKn2JUjlYyhen9
 VtCw49YRAZa6XNuvPmTpJeqSuMNUELVBZu00ZWfkV0G6lK46Ruw4Vx2piXmhIIQ/DshbbR+RC
 E9juKhEczcJ3YvFE1yTbi3qnPRVdk/MPFc35fdjsmwAQdTnlFm+WtUEixNX9jqzmEQ+EOtMiZ
 udtkX7UknbS4zSuvIUOEy2k7gA3foYPaslAvusFxPOdexQeVpZs8SbW9OKzcT0R68Kz+Yxt6F
 2mdwlKTBzTdCRg+Yox7tRRSZtOiCIv4722+lQzqUbWmVCXxXkQJBl8BaCbxUMtoX2HlCwv8h/
 UiGqan5+ZtC8namBIsmELvbaCfEDnwgVIG8nK1cqe0W9oNJSw+86GWcopPyG2nu43PPBuYdh2
 cURkPFewrVLdI2WnJCTrm9x0xXo3sADKSukZ3MwfQ7izKoiqmN9lb7DmCNpvb+frSuqSM8lup
 9pGSGuSTQufvGCsRAWd+0eohl76tY5peXUXpvymWJxD6/eSjI0zAcHaMrivwP0RZkdylssxzU
 tCQvfBICyF518I1XX6Y+P78HBq4aNNWYlmyn5re7C71dqRo6ySbzCSS8OL1l/3cm88qeJFFG3
 tVa5qdXfd4LaOkygiStKas686m7PbgxqqppxI47mZT3DnV5mkXdXBcTtMM8VgCbZTP6jHgoZw
 j5qy5HYVn3xr2Z5EyH816ZD6HtPWfW0YLOfugimkZrEyQicvYH2xmA6JSlofk3aOcYSDfOhP4
 Ijhr7bvAQEIox0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/14 =E4=B8=8B=E5=8D=885:05, Nikolay Borisov wrote:
> Here's V2 which takes into account Qu's suggestions, namely:
>
> - Add a helper which contains the common code to clear receive-related d=
ata
> - Now there is a single patch which impements the check/clear for both o=
rig and
> lowmem modes
> - Added Reviewed-by from Qu.
>
>
> Nikolay Borisov (8):
>    btrfs-progs: Add btrfs_is_empty_uuid
>    btrfs-progs: Remove root argument from btrfs_fixup_low_keys
>    btrfs-progs: Remove fs_info argument from leaf_data_end
>    btrfs-progs: Remove root argument from btrfs_truncate_item
>    btrfs-progs: Add btrfs_uuid_tree_remove
>    btrfs-progs: Implement helper to remove received information of RW
>      subvol
>    btrfs-progs: check: Implement removing received data for RW subvols
>    btrfs-progs: tests: Add test for received information removal
>
>   check/main.c                                  |  21 +++-
>   check/mode-common.c                           |  40 ++++++++
>   check/mode-common.h                           |   1 +
>   check/mode-lowmem.c                           |  11 ++-
>   kernel-shared/ctree.c                         |  62 +++++-------
>   kernel-shared/ctree.h                         |  12 ++-
>   kernel-shared/dir-item.c                      |   2 +-
>   kernel-shared/extent-tree.c                   |   2 +-
>   kernel-shared/file-item.c                     |   4 +-
>   kernel-shared/inode-item.c                    |   4 +-
>   kernel-shared/uuid-tree.c                     |  93 ++++++++++++++++++
>   .../050-subvol-recv-clear/test.raw.xz         | Bin 0 -> 493524 bytes

The image looks a little large than expected, so that the mailing list
is rejected the armored patch.

Can we use btrfs-image? As there is no need for special layout which
can't be dumped by btrfs-image.
Thus using btrfs-image -c9 would save quite some space.

Thanks,
Qu

>   12 files changed, 202 insertions(+), 50 deletions(-)
>   create mode 100644 tests/fsck-tests/050-subvol-recv-clear/test.raw.xz
>
> --
> 2.17.1
>
