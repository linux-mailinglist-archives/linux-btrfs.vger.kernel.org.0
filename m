Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8CB20227
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 11:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEPJGl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 05:06:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:41523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfEPJGl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 05:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557997594;
        bh=hgYJEsqWTycaAtYwKA9zp944T5JtDCN2AHKQOj9JplI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jRqKfgJY5ftmI/KrhgZWVpIPQ7qNgkbZKUMZrwg/hIvKhlDLoiOWoUJWUJ5yaPFIl
         +DZO0O5Sn/V6ZMSBjbcHBZY1f7ElFFeC14d5VngSzQCBYvR8fWHLzaaJhRqEuBKIvt
         R19pjZa+LoszHZkUY1a9OcE+cfxeOlBuHtbuMEmo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LgvEY-1gvyfO132s-00oH1D; Thu, 16
 May 2019 11:06:34 +0200
Subject: Re: [PATCH 0/3] Fix "filesystem" command when fs is on file image
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190516084250.19363-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <5b6a1c93-3549-0ae5-cd2e-edd8af0d6c84@gmx.com>
Date:   Thu, 16 May 2019 17:06:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516084250.19363-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TuzQnKToAFW7B0pJuUAZl9Dt7M89gpk+EJYInPJBscOSURSB/v8
 5jbFNQW86m3nHqXRjmEDTs7a0+HeiijNjBGwlREYRRdeAxdJz3VFjcd60spefcG7ycVg6v+
 or+GyrH7++6QG2b6ytsFTqWY0G7FUd4FvQj+R+5eQswgEZezeuTf3iGNNHPDDTpNFPHJLyX
 RYf0VILL6OTxL5undos7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uvksNvEmMeE=:zAQGbwXF6VNmn2PT1e9RU/
 WzRn+U2DXHLwvF5N7IaOhWON2t0iyUTbLZAWH0OeHSXunbqJ48WEGfKsnPXjV10Mf5ti11XnI
 cP1SQ+s2L0iDPISGum0sCsAPFIor4JAonmMhClu3AM8WWGSd0rDkLiqDDZQmInko2SsxuQENC
 kI8uhuDQQVSh35s17YCt+8fhZHzkmTKdJd/yqGp7zpm872mbRe2fj08ozuGM8C5i1vIDdUMQv
 839Mtu5j6X2tlPOeT8DfvSmmZNT6vM8372BBAeDBc8vViSthw/VPwyJdgT4nxXod1GgwVd0Yb
 f8tjftTZxgL5btCetD0e+QUnihy2iL6Qhaqv5MsLu+/ehXe+8SrqDmTxJFK9OS0dq5uBgBUfZ
 m/0Mb2/WtdzQfkwZ5R4JxRP1cb0BuEp8oE7k+Ex6IQxwM4RqAUgNpY5REixM7EY4G6I7u0oGh
 6/Lm5LC30Sv19rayF8mYZlHGnY/73yEkzq/0nl93wqkVyfljLH2TcKSOULGPY9+JVP0tdo514
 77LHNUt/teV3ARK5R9CaOyygphbX5buzV/Xe2F5JTG0ohfH7fFkRCODpa2Psc+0ndtZnfA3qx
 5JQyvZd2tmTocDpfqrThHOXXQHZQDDAsm87Fp2GEhR+QxpM99nOj1j8dRPCGEqEJfU7c6FG1N
 E5Jn8JynP5IoZXWbo6t0D5pZn+2UBFaf9qlCIiFrOiPvLdlIDa2lfV6kQl0BMtFqOs/z1Enc8
 Ttq/BrtM2vhtLHV+Bg6IGPre73FX2bCwFkk+dAUrZGKgf/JZXyKHRCrx/Aj2RzTd5h8y4/5cG
 DsHXe5a8L/+19BymUop2nAFp7X/mduE/5X5VTtaMUPHfE6JG1igJ4TkVypqmXjlJWcbXV1zfR
 oqilmwzHjA9uS+NAqmpR4EN/wgamSxNWSxkmwQ+tEDxED9iloAzCsDIrLxLL1UdyI3th8SQQW
 /gvGR4tYHdw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/5/16 =E4=B8=8B=E5=8D=884:42, Nikolay Borisov wrote:
> This series fixes the following use case:
>
> truncate -s 3g btrfs.img
> mkfs.btrfs btrfs.img
> btrrfs fi show .img
> ERROR: not a valid btrfs filesystem: /root/btrfs.img
>
>
> As evident this currently produces an error due to libblkid not recognis=
ing the
> image file as a filesystem. This stems from the fact progs doesn't force=
 the
> addition of the image file to libblkid's cache. This series rectifies th=
is.

I'm wondering if we could just fall back to open_ctree() and print
needed info using btrfs_fs_info.

open_ctree() will scan the passed device no matter if it's a block
device or a file or whatever, and get the correct result of fsid anyway.
No need to bother blkid cache or whatever.

Thanks,
Qu

>
> Patch 1 extends btrfs_scan_devices to take an optional path argument whi=
ch will
> be added to libblkid's cache.
>
> Patch 2 Makes 'btrfs filesystem' Utilizes this btrfs_scan_devices' new
> interface if it detects we want to query a filesystem placed on an image=
 file.
>
> Patch 3 Adds simple test case to ensure this works as expected and is no=
t
> broken in the future.
>
> Nikolay Borisov (3):
>   btrfs-progs: Make btrfs_scan_devices take a path
>   btrfs-progs: Correctly identify fs on image files in "filesystem"
>     subcommands
>   btrfs-progs: tests: Test fs on image files is correctly recognised
>
>  cmds-device.c                                   |  2 +-
>  cmds-filesystem.c                               |  3 +--
>  disk-io.c                                       |  2 +-
>  tests/cli-tests/010-fi-show-on-new-file/test.sh | 16 ++++++++++++++++
>  utils.c                                         | 18 +++++++++++++++---
>  utils.h                                         |  2 +-
>  6 files changed, 35 insertions(+), 8 deletions(-)
>  create mode 100755 tests/cli-tests/010-fi-show-on-new-file/test.sh
>
