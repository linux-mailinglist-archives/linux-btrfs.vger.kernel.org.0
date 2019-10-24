Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCAFE27D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 03:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407792AbfJXBsg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 21:48:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:54381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfJXBsg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 21:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571881710;
        bh=kXHtzlQpiaP2hDC12b44bb5MLAqbyCbG4+lI4k/+X9g=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bIYy6p+HpoXJPCdQ9IrWvkUieTt8yL9gYrYlyjQSkfXL4RmdhiBQpNxFzJfnjIpee
         pQd8sOvQAJOCgApKVpq+uI5TNDXD1Ktcb6qfjfTsjLVD8FK1CHqRlnEH+Aa0WKU3M0
         eYFX/ZKHhy7DYL2VleQmR6I+ucAGbaZjbQvncvLw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBUqL-1iIHA22rIF-00D3YS; Thu, 24
 Oct 2019 03:48:30 +0200
Subject: Re: [PATCH 0/6] Block group structure cleanups
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1571848791.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <6750cb9a-257b-a1ac-324a-bcfb0824967a@gmx.com>
Date:   Thu, 24 Oct 2019 09:48:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cover.1571848791.git.dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="G05CqWapIbd7DMkYxPhQsFzAPjeR0iiHb"
X-Provags-ID: V03:K1:juhUvxNN21GwJFb5SFbuiiOE5Gp4QNK55AXxQg5rKRneeINky+n
 EMBhBjs6RXtz/72ufzJX9MgLM52Qi/bXHvaeOgXgiV2Vaur1rOrBx+fH75xrDSj15opG6iI
 idMfBKYlb37qPt2A1JI+2tSH/YSgTBga0gJoBYVxu4VK+ycgRIeD3tZIB/1VnRpaGy7B3bX
 1/Ho0FA5skaWuO0wl4Wog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BQkHGYpRRIg=:5LjUIJwolEnB4/18yk+V+S
 1j0cMDJajFBZhMpanO5nNhq9HI/3eVVzlUabeeUTszYlwzNeN3vBC/mwPqy6oWfebxxbO4+PF
 uzcFf+7xuprCyBlQctdkjd7wqcG9th7ZIoZ6v+pOKB2Kz35UZyTvhMMrlQ11tS9RHsPmOvs62
 wAOWgeV70qJcZz9MegUPl3QFm5UKKRoBHOl/m09jahIZpCu1oQ5aEduRgmC1bKFP1yo3+jLOl
 im+qbUb/yV13gV16c01gQwfME2Vb/T+G6D3JXQTFUu6zkgCMz/25trVdFcRR3bin8Azdk47P4
 Fmyq/4TrXPhLZXK+IjNgLKFEXF9HGhgUCR12fllRdquRspPh09cdSCW1ztuT2I4L5kSHRWeXB
 4D3Fe50iqzchcLmKCKKRTB3LDxBKGACm+qML0fXwfCyy0Ne2zqoeF7Hj+Jdw29gj762jyjweQ
 uSuKGZZrb6ARTFNbAc9I7Gv0EiqFKHKG5P0oUPz/15CmCiNBEifOnKprTGJYXCkxQT61reDPz
 5SRP/PTpC0TgfS3Rtua5ouULc7f590Bgu58XDlEQgtL/GXles5zkAOda+N+92QAn1nnGz2TfM
 jjBW6bGn0gmUdp4ydfeRyDjqFTRsyxqxzvVtyNkFSFI99XqIoEzJbjh2/jjhpVHU2pSQ2nCVI
 SujxGxdwHWk0ijP5iSqpHfDJ3/GJI2uIXdT0GOm1hj1Xn6yC6uUwdpl4vXLqm5fyZJfxgYyKv
 YXRC3DLH48ZGEB7C5dbu0SY0m2nWhzuaisj6ALvif00ch6ntzQfVqqmdPpNbmIniOQjvx6cD/
 i1u91lXan80SliuJ6yZp9enJbTR9tcOMGsxpE1f48Est9wPa9bMCe/bmAa20Z+bxuCmZknfcy
 U7kYjuSPG3+v3PqmDVKckw4TuUQd1O0VoUAJ49u82pVCA8UXGS+8TTEyy+SqJDA8ZIbT0hKvm
 tnu+WmlfxEs6+GOhLk5bSIrdG2JfKdr90H61Ob4Kq+uZedERCzq4kKgGkbpsSe0ntWNddYjBE
 7BkV7pfbBf54XNKIHMhbpsPA98as97Ft3Ovbw7XIy5zMy+nL7OKpxZqvv6/pHbKY5pXd15FY5
 sO6uDKBOgLDZDZilirwmfPPkK82VW60csZmo3UY3RpDfvjbEknUTRmewNsiOubQWBWMJ7ocYx
 yokJ0a1rR8TECxNdevY78fhu1iBKuRbJBsSWErB6xTpPRE7YgN/IlYnAx3EgiYF9QoXwnrXTl
 /4bVsPU0Ejt5RBpo5qXe8j57hNUMUyF12u3jnpo20rsK+raIP+P756AB1jLU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G05CqWapIbd7DMkYxPhQsFzAPjeR0iiHb
Content-Type: multipart/mixed; boundary="S925HDnxeC0IWjADk6n8x8KJRlU2tdLKS"

--S925HDnxeC0IWjADk6n8x8KJRlU2tdLKS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/24 =E4=B8=8A=E5=8D=8812:48, David Sterba wrote:
> The block group cache structure has two embedded members that belong to=

> the on-disk format but were used for the in-memory structures. It's bee=
n
> like that forever and I wonder why nobody was bothered by that. Switch
> to normal members and rename a few things on along the way.
>=20
> The size of block_group_cache is down from 528 to 504 so it should not
> fit better to slab pages. Further shrinkage is possible.

Great work!

The patchset doesn't only reduce the memory usage (which is already
awesome for large fs), but also provide more flexibility for later block
group item change.

All previously on-disk format related members are now all refactor,
providing a pretty good basis for later bgi change. Awesome!

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> David Sterba (6):
>   btrfs: move block_group_item::used to block group
>   btrfs: move block_group_item::flags to block group
>   btrfs: remove embedded block_group_cache::item
>   btrfs: rename block_group_item on-stack accessors to follow naming
>   btrfs: rename extent buffer block group item accessors
>   btrfs: add dedicated members for start and length of a block group
>=20
>  fs/btrfs/block-group.c                 | 191 +++++++++++++------------=

>  fs/btrfs/block-group.h                 |   5 +-
>  fs/btrfs/ctree.h                       |  12 +-
>  fs/btrfs/extent-tree.c                 |  31 ++--
>  fs/btrfs/free-space-cache.c            |  39 +++--
>  fs/btrfs/free-space-tree.c             |  83 ++++++-----
>  fs/btrfs/ioctl.c                       |   5 +-
>  fs/btrfs/print-tree.c                  |   6 +-
>  fs/btrfs/reada.c                       |   4 +-
>  fs/btrfs/relocation.c                  |  18 +--
>  fs/btrfs/scrub.c                       |  10 +-
>  fs/btrfs/space-info.c                  |   3 +-
>  fs/btrfs/sysfs.c                       |   4 +-
>  fs/btrfs/tests/btrfs-tests.c           |   5 +-
>  fs/btrfs/tests/free-space-tree-tests.c |  75 +++++-----
>  fs/btrfs/tree-checker.c                |  10 +-
>  fs/btrfs/volumes.c                     |  19 ++-
>  include/trace/events/btrfs.h           |  21 ++-
>  18 files changed, 264 insertions(+), 277 deletions(-)
>=20


--S925HDnxeC0IWjADk6n8x8KJRlU2tdLKS--

--G05CqWapIbd7DMkYxPhQsFzAPjeR0iiHb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2xAugACgkQwj2R86El
/qh07Qf/V4hAKG1r2SRVLJVrunH301yir7T2S5f155F64gVJu663U3rBZ8tJ5NTJ
rNiC6a/q05IXv1tuTb1h0qnFPFrBFSBNPOixE1CbwD5imSVsF0T7IgBxtqSRWirY
BJa0dVvEJsh8ySJsrEm5KxM7QYkEDjZ4zX+rjK+6Kiwgofee2exAYYQKuvVYQcge
E8YCejChpPEg9ftbSiFAXHXZbXPBNMazqqoI06/RIs7Px5W1Yzr5uJxYRS7DICC+
0npO2iaeKL7+un29blQrwPuD7O3kd5C3v6gW4PevmOtaO/AqOiulpgUlvkEOuCBs
GS5rHV+LdU0cc2ZMQlwE3v13GLIFvg==
=Oo4g
-----END PGP SIGNATURE-----

--G05CqWapIbd7DMkYxPhQsFzAPjeR0iiHb--
