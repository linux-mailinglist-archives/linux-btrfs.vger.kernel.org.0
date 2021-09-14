Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF3940AAE0
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhINJcH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 05:32:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:60331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhINJcG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 05:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631611847;
        bh=njkLauyyRW/bzzIccJByoTXRovkgZ4pRP/V/tCNaljA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DpJL3VRBJlGuPIj9ttW7ACjLo3V56mVUe0FmI/vyy78PnYVFNnaR85bFcHNzL1G3Z
         KvXJpXE8IkTWFSlcCHTn/IQ5ljXg5+oha4eSPee0aoePz7YE4YnNFPN5eF33SdA5Pp
         u5FHmhF3O2oV13eZnSOQwuk2q2uT1tD/O22IOM4U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdvmO-1n13x22fGI-00b0hn; Tue, 14
 Sep 2021 11:30:47 +0200
Subject: Re: [PATCH v2 0/8] Implement progs support for removing received uuid
 on RW vols
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210914090558.79411-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <120d4021-021c-9a4b-a0cf-7016cf964f96@gmx.com>
Date:   Tue, 14 Sep 2021 17:30:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914090558.79411-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y9jQRIv0HlCph5GX/KNK717Nirb0ZOp1XIP8lSwlHHD5cvrM6Oe
 azkXbI3r8jtnxm5f+gDUDtG8oXq/9SL7hhecVM3nCgI0iI0Ra0C6Y5pco3SY60hCIVhkK2T
 lBCGe9MFG1+hZ0XsmPEKpJfiCNa8ejRopaepX48hbuD9R8I8lMzDw03jzgJ23GpEFcWER+A
 HA8Demfn6UToNNbaV1loQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6vuL+ViAOCs=:SS/9E+q16dQH4d979CB7yY
 HhANLx3k69XUNviAvwPtpO5hJCQI7rOHoM8U34c+Ox/Q/mzPy77NW7TyMsW2/LmRJxxSDU5gw
 2lIJlS7FyVPlIEajHBusWJw8WHzUAOTtp4w0YZDmiYEjWseAFGgTVp/aoCv6J4YriEGRPLNmW
 e3r+NumnwWHT6VJwzePce/Hn5m3yZ7dbkxV7qwa9GizoQqC37B8ulvgake/mmJyTGI3DZIWq0
 7AQvMSuxjujpA3B1g3ACyhj7aBT3+1lOcbzsZz3ZSDB+qkNSlZyUSNelZ9hBTehSQ2ebrHBR2
 OpmsnB7Fv27mBtubzn2/2Fsn8F4DkyJRcZapEe/JkgL39qx0JmZ9J5B4r9AkKo/Sxc50PZJPd
 dKUD5TWw7juj3e1YTMhHgNoPnGkR0LFLUAC6m63z1D718qh+SVb4n1qkP0ZosM4FeBwEIo3/k
 VSs4krYtbodXbtLdZyIUfQxAGiDOH6NRqCJ5AyKUkyNJibGl803ENegSNbl0MWt8IInh/73z1
 4bIsUwwGaKPizL+TMg3WtO4p6u8wdvaLu33Gh/742YYrplkzyGcJUXypMngK7AKYrB9TOz+xd
 tZGPG/9Aca+EnYWZt0gcH2vDLqCuN9zslt9ncm394GraVslBvCqnnUyu/gSQPlhuZ4GtEf4Po
 CeK6IcYqjJ8UaRJsFA58QhZlK6Ud+CoAdZj0vaRlpZ1jmRPZ8rEszActb6iDlJSBspPH1wDLr
 Yig3w2zvBC8s4N0BivfR8Z+s+tfyg/KGC9VssO/+3YFY4NpzXrZBgC2P4cw2MpAWLAFsfF8BL
 4zcE1OvyTinCdWOD688INVNy2dnBfHgwVtRsztueSq/0TdAFg6ApBcqtfogczl/IHCBU9pbm9
 9h+viKhwse6e7+xgt3ArQjWQiY5B1fQp678Mff4FlwifCfK/j8HOVonlJ4pApEEDDi22KZdsE
 1WA1U2BQiH/rufySdCOmKC/Kftdm+I7AIlSqNhd8nO9lwqZhaj+zA3vhv33b0jC5k4BZPD0oD
 te+eShLSZ299xMbpQ4pb7zbhxkJqilK1lXNYrplS//0VoGAPIJ3dTKc6htGZVTGrui6f0ozoX
 4UXdPz9n92ku2M=
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

The images looks a little large than expected, so that the mailing list
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
