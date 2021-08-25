Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0823F7391
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 12:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbhHYKoC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 06:44:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:37263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239099AbhHYKn4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 06:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629888185;
        bh=RcaZxe+VU4YZjkgCpNsfIVhiQe/R7E7o4wPaL7XJdso=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=huPGfBWPoOyNPvgSLbvyV44iFE2wyQuRE4xyxwSY4UBXvqwRLJ3JH+ceIKTFv04dL
         JJDSdVTvbG6ZvyfcCXgWeiOChujTVPW+AaqSLNZOzR4ZyUWfJ9SE1y8msUwHYNAedw
         iYbxBcdh7CkSQn4tjkGQpXRDY1gUSrk0bjOgnFR8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N63Ra-1n7eeu3OFE-016PoF; Wed, 25
 Aug 2021 12:43:05 +0200
Subject: Re: [bug report] btrfs: subpage: only call btrfs_alloc_subpage() when
 sectorsize is smaller than PAGE_SIZE
To:     Dan Carpenter <dan.carpenter@oracle.com>, wqu@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20210825102124.GA1822@kili>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1fb45f48-33b1-b053-8f2a-755671804c23@gmx.com>
Date:   Wed, 25 Aug 2021 18:43:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825102124.GA1822@kili>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AkuCa1tgF0+w9P02FnPM1ntXzleSp4craaIoD4fn6nreZdjA81I
 MCQLBpz73ilKA2SfP6DUppo4ysfgBlpkDhDYv/qgmQDvBwOFXokIZEC0OEF8DvyTyxxK7FA
 V8zhGGMdAEhQ42oJZwOqlei+Z1e0+hwzO8UBhvUoK/bki1dE9clUP6715QDFSfltbzKTfTX
 eW+PkMZg8CeiWrFwDQwbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PRQCJL3z/WA=:k3oKoQ3Fre36iyCppBkpfb
 JPF+zcLp2rTi93L3V/Y4S5UeGhmqzP8VeWPOz+I9sqhe8hd8O1h/d2CjBegZ0u6am9snz80qt
 /velao/ajNIVYGXY6MYdFQjuKs0mSk5eLlY3rBL6akcFpdcZ3UXeITpM1vwrnW2HBH8ejiW6L
 A3xeHTc7Um996Xib9TWBkgXgo13BSw6MaARcdDEnUUGQJWj9DVIxs8kEV+sI2O4v+yJOMjwq9
 e0NFPrLtCTYdimkzj4Xv5nhxBrwV0msr3K3E1vB/Ul1ucegvk3qLrHcSd13ayam2cNoWSpJiy
 JIEOqQRhVm8HYsERKDeOjH5jksAfbJxZIELa4GEgizHJT9zHgpKGWFc9R09awPP95ueGHs8yy
 uOezOTKBk9Cm1rnIFwx2BoqHX7s4hj8XTramFoKhmF+rl5aNv1S0Icrf5cS40KdPPVGva3325
 1nwkQpeYThPaxfClmrfmbLFO4B+aCpJdcZo3MDVLIY7rErJLzLzGQLo2GwCMuvOlbDdOtMSXg
 J1KxWcwb4eXi67D6GoS+6QuaiQ0w405hfbePj11Yp03aQgHgLaFS3qVPdcS0HYwYFqpsTuRXr
 KNLsakPdAhBVyd7YNer8GyQjAynHyh4epYZ3HIuhRrHZIzpRB5XVZ8i064SJV1OcPJiIgteS7
 pSEvKzMPOPSWv9C0vJkh4iTZyVSxIcW6LzvcLt8CcxA8QSL1wSThhN0MdEJtDSReJhugRGkQd
 9zfdS6E12HsFNDfkhdZ+6Ts3h4Itnsp1epNDfkSv3vb6uBvSgdipeLQDXO6fqc6NTtnOzPE1E
 ws4Wfz8fHgxug6aXKd62HclQRGBHCze6bu8OiwTGIPm627wV5O6/sU5Z29OcH2aHZIFImgbOv
 NgpZh5k671wiNdvdjQDe09l8QCjXxnuEyfz7jlgysti53qL5aU363XUFVDieXNIHtFcAzjSET
 zMazK5/ZVrDbvEPD4gjXxUNgnHoNAEfmsEHHlP2rKjHHogC7Y9tlAnSjh+Rf2vHqMbyh30Dxv
 AqjGiWw94S4GoJa+T6f3cNxJy/VuURPDF2wBjDG2P2/LA/XO/D0N51DLPdTYsthocml9MzIRU
 cIqkiDUgo94+le/ZUNH1bSDkh06vnmWW8jgONPq/Kcg7Nf5+pyY44TMyA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/25 =E4=B8=8B=E5=8D=886:21, Dan Carpenter wrote:
> Hello Qu Wenruo,
>
> The patch 4c1e934ee490: "btrfs: subpage: only call
> btrfs_alloc_subpage() when sectorsize is smaller than PAGE_SIZE" from
> Aug 17, 2021, leads to the following
> Smatch static checker warning:
>
> 	fs/btrfs/subpage.c:110 btrfs_attach_subpage()
> 	warn: sleeping in atomic context

This looks like a false alert.

>
> fs/btrfs/subpage.c
>      94 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
>      95                          struct page *page, enum btrfs_subpage_t=
ype type)
>      96 {
>      97         struct btrfs_subpage *subpage;
>      98
>      99         /*
>      100          * We have cases like a dummy extent buffer page, which=
 is not mappped
>      101          * and doesn't need to be locked.
>      102          */
>      103         if (page->mapping)
>      104                 ASSERT(PageLocked(page));
>      105
>      106         /* Either not subpage, or the page already has private =
attached */
>      107         if (fs_info->sectorsize =3D=3D PAGE_SIZE || PagePrivate=
(page))
>      108                 return 0;
>      109
> --> 110         subpage =3D btrfs_alloc_subpage(fs_info, type);

Here we only alloc when sectorsize < PAGE_SIZE and the page has no private=
.

>      111         if (IS_ERR(subpage))
>      112                 return  PTR_ERR(subpage);
>      113
>      114         attach_page_private(page, subpage);
>      115         return 0;
>      116 }
>
> The call tree is:
>
> alloc_extent_buffer() <- disables preempt
> -> attach_extent_buffer_page()
>     -> btrfs_attach_subpage()
>
> fs/btrfs/extent_io.c
>    6132          for (i =3D 0; i < num_pages; i++, index++) {
>    6133                  struct btrfs_subpage *prealloc =3D NULL;
>    6134
>    6135                  p =3D find_or_create_page(mapping, index, GFP_N=
OFS|__GFP_NOFAIL);
>    6136                  if (!p) {
>    6137                          exists =3D ERR_PTR(-ENOMEM);
>    6138                          goto free_eb;
>    6139                  }
>    6140
>    6141                  /*
>    6142                   * Preallocate page->private for subpage case, =
so that we won't
>    6143                   * allocate memory with private_lock hold.  The=
 memory will be
>    6144                   * freed by attach_extent_buffer_page() or free=
d manually if
>    6145                   * we exit earlier.
>    6146                   *
>    6147                   * Although we have ensured one subpage eb can =
only have one
>    6148                   * page, but it may change in the future for 16=
K page size
>    6149                   * support, so we still preallocate the memory =
in the loop.
>    6150                   */
>    6151                  if (fs_info->sectorsize < PAGE_SIZE) {
>
> The patch adds this check which means we only preallocate it when it's
> small.
>
>    6152                          prealloc =3D btrfs_alloc_subpage(fs_inf=
o, BTRFS_SUBPAGE_METADATA);
>    6153                          if (IS_ERR(prealloc)) {
>    6154                                  ret =3D PTR_ERR(prealloc);
>    6155                                  unlock_page(p);
>    6156                                  put_page(p);
>    6157                                  exists =3D ERR_PTR(ret);
>    6158                                  goto free_eb;
>    6159                          }
>    6160                  }
>    6161
>    6162                  spin_lock(&mapping->private_lock);
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Take a spinlock.
>
>    6163                  exists =3D grab_extent_buffer(fs_info, p);
>    6164                  if (exists) {
>    6165                          spin_unlock(&mapping->private_lock);
>    6166                          unlock_page(p);
>    6167                          put_page(p);
>    6168                          mark_extent_buffer_accessed(exists, p);
>    6169                          btrfs_free_subpage(prealloc);
>    6170                          goto free_eb;
>    6171                  }
>    6172                  /* Should not fail, as we have preallocated the=
 memory */
>                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^
> This comment is out of date.

The comment is still correct.

>
>
>    6173                  ret =3D attach_extent_buffer_page(eb, p, preall=
oc);
>                                                                 ^^^^^^^^
> If we don't preallocate it, then it leads to a sleeping while holding
> a spinlock bug.

If we don't preallocate it, we won't allocate it neither inside in
btrfs_attach_subpage().

Thanks,
Qu
>
>    6174                  ASSERT(!ret);
>    6175                  /*
>    6176                   * To inform we have extra eb under allocation,=
 so that
>
> regards,
> dan carpenter
>
