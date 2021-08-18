Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDA63EFA54
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 07:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbhHRFqd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 01:46:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:44149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237588AbhHRFqd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 01:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629265552;
        bh=SHWGHwkpF7nBzloiYtdhV+Ng9rFY934QL1dlnrsyiXs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AKuUnkOYWcJNYt6yxpEzWBRPIZXt2oBIQrDa53ab5Xcnr5PNazYfz79GSTd0oRKVO
         mhYxHgAtuIg/O2tEbEa/xJSzq+KlPNWhLsqTg86VbxWWfQzHgb7ILxpqa41o4zFxLn
         c+YAxxb3EMZusvm0pBOTArPk1jFgo4v88qpsBMnE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MaJ81-1mbUJm3vRV-00WBDF; Wed, 18
 Aug 2021 07:45:52 +0200
Subject: Re: [PATCH 0/3] btrfs-progs: make check handle invalid bg items
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629261403.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a521379e-f584-b84d-5763-5420fbe4bdb2@gmx.com>
Date:   Wed, 18 Aug 2021 13:45:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover.1629261403.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kuvkyOJJ1a5qPe7jM0b92s0b/HG/SKr3jdtM6Dj9ZR0IO1NnJHe
 8hv10VVV7lYzork3LIWikvijdcCyKebMBQ8B5IeM+c4KKzWG8c8QH/9waI+tEjPons3Dola
 ari3B2fzlzbkFVQzOoDE8Gt2rErnbKWYq81WyaSqCJIE0szYrx0QtcWqDmsxyZLw6U6+9G2
 8hPFJAXHiRHxsWCDDw+dw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d7XLhdAowaM=:kRCEuH3AroFs+qXIAp02Fy
 bI5M4Na/IF1UAii0UxIOEaOocir8UYTcfR+0LQKSXPM2TJDQK37l9aT93lsdcHSD+iwCvZwX2
 mvAcVH/KF9TQdSHIA0zsKo1XN0NUy3yrqklUkNgTTMtXlSE6LKAZiRNyiM/pOxHRPaahjCLwS
 vnY94VMVkShbrX9NWrRPYOMISOp6Q25C5Kl8Jjx2NEkUrXb0lttwzKEpJqbgAJxoEcakWEdNe
 QxWudeGOZFNZjXuSQC3zxL6gQLV0FxTEywhFrmIogc5W0vFtfzY9OwXAK9ULn7V0mQJiDbRgx
 IeRgy8Ls09Mxmn+xZ/ZTqDw6eZws57mnknShg+xZkEvQrU2ZM1IhMe6jpiKEibYCwgp6t42xB
 1BKuiRAFOGhJHqghMIt2r2in4WN+i26+Ave+5x430vSC+3PLktyeGgjxlsdYfIkDhVkjx+35E
 iTBb5dTEeKwxOKesuEbs1sTpna4c69pIq5JrGYhrunEqHPBugOv0QG6S0EAdRBBkA6JtdDGh2
 SVsFeYT+8ATy4U1/nknpuwRtBitDA6iRKYFFHL8hHyaTNrTHGY/xyHqx2DxbmytAJyyH/0RI3
 3Mv1PtOAK7pp+UXmT+eeQyer20PX8rBMUhf13rqiREMq8qHsqu/xKAKBr73iGoBPoBQegRGqp
 NanjFEjLDA2Hmlt4qZz0HPcNyLd5u7Kp03OAOVJpBlOgj1OUzXNcqKRqHiUE4sbHGNA7jF8bu
 Pu4ycZp/zVED3Ps41hRAk2Sn5AZtXxiyrOz1QNr+498eZDtuhIflVNFiEvb8tJdnmWwDOfEcQ
 9pYxMeB4bji+gIB/H7iZfcGDbeE+VokH47jsRYx/MknrupFXytULgZ9W3DQYiyVPS3sTO6gkh
 kC6lzMAPCjzp00VLX+6eRoTa5+ZnRQ8H4vqkKxcekmxPLv62JLSUvEwh2HmH5zolO9tkKuUFv
 DVsNyPzo3JVuOT7jQQtNljavNIBoBT92q4r1kEu+DUZlzBHmGQuMiKR2hQLau7Oa192qNqtZx
 RfDLxx1HC/4xJOHMm0eCB5rqrHdTCeoPe3BQzZhk78uJCNeRo3aEmWMmK1cRz2faHkbt10Bd8
 QcpWLAn5NQpULDswEQvTdrkoPhp32idEFtDlwJ3qV7dBJzYUKiBeFZgMA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/18 =E4=B8=8B=E5=8D=8812:39, Josef Bacik wrote:
> Hello,
>
> While writing code for extent tree v2

Any doc on the extent tree v2?

Maybe it's a good chance for me to prompt my previous skinny block group
tree?

As that would greatly reduce mount time, and since it will introduce
incompat flags anyway, it may be a good time to pack those two features
together?

> I noticed that I was generating a fs with
> an invalid block group ->used value.  However fsck wasn't catching this,=
 because
> we don't actuall check the used value of the block group items in normal=
 mode.
> lowmem mode does this properly thankfully, so this only needs to be adde=
d to the
> normal fsck mode.

Lowmem mode has a lot of hidden extra checks waiting to be found. :)

>
> I've added code to btrfs-corrupt-block to generate the corrupt image I n=
eed for
> the test case.  Then of course the actual patch to detect and fix the pr=
oblem.
> Thanks,
>
> Josef
>

For the whole series:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> Josef Bacik (3):
>    btrfs-progs: add the ability to corrupt block group items
>    btrfs-progs: make check detect and fix invalid used for block groups
>    btrfs-progs: add a test image with a corrupt block group item
>
>   btrfs-corrupt-block.c                         | 108 +++++++++++++++++-
>   check/common.h                                |   5 +
>   check/main.c                                  |  89 ++++++++++++++-
>   .../default.img.xz                            | Bin 0 -> 1036 bytes
>   4 files changed, 197 insertions(+), 5 deletions(-)
>   create mode 100644 tests/fsck-tests/050-invalid-block-group-used/defau=
lt.img.xz
>
