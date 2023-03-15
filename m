Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2882A6BB9BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 17:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjCOQfJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 12:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCOQfI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 12:35:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6956A1C1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 09:35:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bh21-20020a05600c3d1500b003ed1ff06fb0so1676721wmb.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678898104;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdIeFJX1bdLxABKFqr+wfjowGqTM2FvzPXrfdfmU6sM=;
        b=JdZf9V1AvoUf2gLwAKBJptk1LJ91ZLdVxC75az/OHNLzMZ2ufJhtCoxF1POHzkLHNN
         /m3zGcy8+akdUnBsD9NTxhF7ga7qD3r76fIFruEfsHxZsC5W0EcUp7ybA+7fw/sf6ByV
         ng3HbwHVvR9A+AT8p2hrJZZeJXNVJbyjfOGgumvt4LDbZ9WmgUJzf2Rhx15d6fG/S8Yx
         KvwWdsJavkbdO1dFe/6HKk6l5zRm3qtg8JklViWWY1XkEiWL/6KmJE9BZPs/kwYrVjOy
         pBLVnXvCI5xikXYcBnAqCikMkGrtxFoVn0m31PIKGoaLK2BcumrwUFbI/XLwLMLu4sVy
         bKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678898104;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdIeFJX1bdLxABKFqr+wfjowGqTM2FvzPXrfdfmU6sM=;
        b=VUDzfXq3x6X7BX/5+oWbkIB4rJXA9BDwQpJtWF9+gMrp4Oa5hGng8KKH1P2aMMhnmN
         ZCWmy9RVVz06+bCN6tYsxOKUarVb4Wv6UW1eziHOKF5twrmMUsLfvFNGm0pQoXa2rFuK
         hzeBJemobArDnyCExGDXf6mPwemVBqfaC34PINzWJrdTLU8N3AC0qGnJ4eoUuq38I151
         URK3wEjyaMLvZas0V6gw6SZO7VhchQARbAZVptZo70zHfWX+gkq+IkpKOOBi8ZKXWVjK
         hPlQzhiT4j1NzLDHMuNky+WfTNgXZjqUU++RnpkE3qrubna2sIzb0Gp/3Y2gabT+TWa8
         3BPw==
X-Gm-Message-State: AO0yUKX5zMP0KifOnFF1E9gc3jrSgIJgyBh/mIfT8cpO0mXhg+ekTpjj
        sLff95XCTk7/AzMrhdHbNEY=
X-Google-Smtp-Source: AK7set8qkYaQ6+sCzE7QHIqRgeS7RfkrGhV7pNFMYnOc3DIeZgfP69iMHpvlKJtKvX8J5Ekq9krdMQ==
X-Received: by 2002:a05:600c:3c83:b0:3dc:4fd7:31e9 with SMTP id bg3-20020a05600c3c8300b003dc4fd731e9mr20291702wmb.7.1678898104536;
        Wed, 15 Mar 2023 09:35:04 -0700 (PDT)
Received: from nz (host81-147-8-96.range81-147.btcentralplus.com. [81.147.8.96])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003e22508a343sm2347667wma.12.2023.03.15.09.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:35:03 -0700 (PDT)
Date:   Wed, 15 Mar 2023 16:34:57 +0000
From:   Sergei Trofimovich <slyich@gmail.com>
To:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Message-ID: <20230315163457.35bb3b75@nz>
In-Reply-To: <5f0b44bb-e06e-bc47-b688-d9cfb5b490d3@leemhuis.info>
References: <Y/+n1wS/4XAH7X1p@nz>
        <94cf49d0-fa2d-cc2c-240e-222706d69eb3@oracle.com>
        <20230302105406.2cd367f7@nz>
        <5f0b44bb-e06e-bc47-b688-d9cfb5b490d3@leemhuis.info>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZO_LZian6.nAemDGIeLbb5N";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/ZO_LZian6.nAemDGIeLbb5N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Mar 2023 12:44:34 +0100
"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>=
 wrote:

> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
>=20
> I added this to the tracking, but it seems nothing happened for nearly
> two weeks.
>=20
> Sergei, did you find a workaround that works for you? Or is this
> something that other people might run into as well and thus better
> should be fixed?

I used the workaround of cranking up IOPS of discard from 10 to 1000:

    # echo 1000 > /sys//fs/btrfs/<UUID>/discard/iops_limit

But I am not sure if it's a safe or a reasonable fix. I would prefer someon=
e from
btrfs to comment if it's an expected kernel's behaviour.

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>=20
> #regzbot poke
>=20
> On 02.03.23 11:54, Sergei Trofimovich wrote:
> > On Thu, 2 Mar 2023 17:12:27 +0800
> > Anand Jain <anand.jain@oracle.com> wrote:
> >  =20
> >> On 3/2/23 03:30, Sergei Trofimovich wrote: =20
> >>> Hi btrfs maintainers!
> >>>
> >>> Tl;DR:
> >>>
> >>>    After 63a7cb13071842 "btrfs: auto enable discard=3Dasync when poss=
ible" I
> >>>    see constant DISCARD storm towards my NVME device be it idle or no=
t.
> >>>
> >>>    No storm: v6.1 and older
> >>>    Has storm: v6.2 and newer
> >>>
> >>> More words:
> >>>
> >>> After upgrade from 6.1 to 6.2 I noticed that Disk led on my desktop
> >>> started flashing incessantly regardless of present or absent workload.
> >>>
> >>> I think I confirmed the storm with `perf`: led flashes align with out=
put
> >>> of:
> >>>
> >>>      # perf ftrace -a -T 'nvme_setup*' | cat
> >>>
> >>>      kworker/6:1H-298     [006]   2569.645201: nvme_setup_cmd <-nvme_=
queue_rq
> >>>      kworker/6:1H-298     [006]   2569.645205: nvme_setup_discard <-n=
vme_setup_cmd
> >>>      kworker/6:1H-298     [006]   2569.749198: nvme_setup_cmd <-nvme_=
queue_rq
> >>>      kworker/6:1H-298     [006]   2569.749202: nvme_setup_discard <-n=
vme_setup_cmd
> >>>      kworker/6:1H-298     [006]   2569.853204: nvme_setup_cmd <-nvme_=
queue_rq
> >>>      kworker/6:1H-298     [006]   2569.853209: nvme_setup_discard <-n=
vme_setup_cmd
> >>>      kworker/6:1H-298     [006]   2569.958198: nvme_setup_cmd <-nvme_=
queue_rq
> >>>      kworker/6:1H-298     [006]   2569.958202: nvme_setup_discard <-n=
vme_setup_cmd
> >>>
> >>> `iotop` shows no read/write IO at all (expected).
> >>>
> >>> I was able to bisect it down to this commit:
> >>>
> >>>    $ git bisect good
> >>>    63a7cb13071842966c1ce931edacbc23573aada5 is the first bad commit
> >>>    commit 63a7cb13071842966c1ce931edacbc23573aada5
> >>>    Author: David Sterba <dsterba@suse.com>
> >>>    Date:   Tue Jul 26 20:54:10 2022 +0200
> >>>
> >>>      btrfs: auto enable discard=3Dasync when possible
> >>>
> >>>      There's a request to automatically enable async discard for capa=
ble
> >>>      devices. We can do that, the async mode is designed to wait for =
larger
> >>>      freed extents and is not intrusive, with limits to iops, kbps or=
 latency.
> >>>
> >>>      The status and tunables will be exported in /sys/fs/btrfs/FSID/d=
iscard .
> >>>
> >>>      The automatic selection is done if there's at least one discard =
capable
> >>>      device in the filesystem (not capable devices are skipped). Moun=
ting
> >>>      with any other discard option will honor that option, notably mo=
unting
> >>>      with nodiscard will keep it disabled.
> >>>
> >>>      Link: https://lore.kernel.org/linux-btrfs/CAEg-Je_b1YtdsCR0zS5XZ=
_SbvJgN70ezwvRwLiCZgDGLbeMB=3Dw@mail.gmail.com/
> >>>      Reviewed-by: Boris Burkov <boris@bur.io>
> >>>      Signed-off-by: David Sterba <dsterba@suse.com>
> >>>
> >>>     fs/btrfs/ctree.h   |  1 +
> >>>     fs/btrfs/disk-io.c | 14 ++++++++++++++
> >>>     fs/btrfs/super.c   |  2 ++
> >>>     fs/btrfs/volumes.c |  3 +++
> >>>     fs/btrfs/volumes.h |  2 ++
> >>>     5 files changed, 22 insertions(+)
> >>>
> >>> Is this storm a known issue? I did not dig too much into the patch. B=
ut
> >>> glancing at it this bit looks slightly off:
> >>>
> >>>      +       if (bdev_max_discard_sectors(bdev))
> >>>      +               fs_devices->discardable =3D true;
> >>>
> >>> Is it expected that there is no `=3D false` assignment?
> >>>
> >>> This is the list of `btrfs` filesystems I have:
> >>>
> >>>    $ cat /proc/mounts | fgrep btrfs
> >>>    /dev/nvme0n1p3 / btrfs rw,noatime,compress=3Dzstd:3,ssd,space_cach=
e,subvolid=3D848,subvol=3D/nixos 0 0
> >>>    /dev/sda3 /mnt/archive btrfs rw,noatime,compress=3Dzstd:3,space_ca=
che,subvolid=3D5,subvol=3D/ 0 0
> >>>    # skipped bind mounts
> >>>    =20
> >>
> >>
> >> =20
> >>> The device is:
> >>>
> >>>    $ lspci | fgrep -i Solid
> >>>    01:00.0 Non-Volatile memory controller: ADATA Technology Co., Ltd.=
 XPG SX8200 Pro PCIe Gen3x4 M.2 2280 Solid State Drive (rev 03)   =20
> >>
> >>
> >>   It is a SSD device with NVME interface, that needs regular discard.
> >>   Why not try tune io intensity using
> >>
> >>   /sys/fs/btrfs/<uuid>/discard
> >>
> >>   options?
> >>
> >>   Maybe not all discardable sectors are not issued at once. It is a go=
od
> >>   idea to try with a fresh mkfs (which runs discard at mkfs) to see if
> >>   discard is being issued even if there are no fs activities. =20
> >=20
> > Ah, thank you Anand! I poked a bit more in `perf ftrace` and I think I
> > see a "slow" pass through the discard backlog:
> >=20
> >     /sys/fs/btrfs/<UUID>/discard$  cat iops_limit
> >     10
> >=20
> > Twice a minute I get a short burst of file creates/deletes that produces
> > a bit of free space in many block groups. That enqueues hundreds of work
> > items.
> >=20
> >     $ sudo perf ftrace -a -T 'btrfs_discard_workfn' -T 'btrfs_issue_dis=
card' -T 'btrfs_discard_queue_work'
> >      btrfs-transacti-407     [011]  42800.424027: btrfs_discard_queue_w=
ork <-__btrfs_add_free_space
> >      btrfs-transacti-407     [011]  42800.424070: btrfs_discard_queue_w=
ork <-__btrfs_add_free_space
> >      ...
> >      btrfs-transacti-407     [011]  42800.425053: btrfs_discard_queue_w=
ork <-__btrfs_add_free_space
> >      btrfs-transacti-407     [011]  42800.425055: btrfs_discard_queue_w=
ork <-__btrfs_add_free_space
> >=20
> > 193 entries of btrfs_discard_queue_work.
> > It took 1ms to enqueue all of the work into the workqueue.
> >    =20
> >      kworker/u64:1-2379115 [000]  42800.487010: btrfs_discard_workfn <-=
process_one_work
> >      kworker/u64:1-2379115 [000]  42800.487028: btrfs_issue_discard <-b=
trfs_discard_extent
> >      kworker/u64:1-2379115 [005]  42800.594010: btrfs_discard_workfn <-=
process_one_work
> >      kworker/u64:1-2379115 [005]  42800.594031: btrfs_issue_discard <-b=
trfs_discard_extent
> >      ...
> >      kworker/u64:15-2396822 [007]  42830.441487: btrfs_discard_workfn <=
-process_one_work
> >      kworker/u64:15-2396822 [007]  42830.441502: btrfs_issue_discard <-=
btrfs_discard_extent
> >      kworker/u64:15-2396822 [000]  42830.546497: btrfs_discard_workfn <=
-process_one_work
> >      kworker/u64:15-2396822 [000]  42830.546524: btrfs_issue_discard <-=
btrfs_discard_extent
> >=20
> > 286 pairs of btrfs_discard_workfn / btrfs_issue_discard.
> > Each pair takes 10ms to process, which seems to match iops_limit=3D10.
> > That means I can get about 300 discards per second max.
> >=20
> >      btrfs-transacti-407     [002]  42830.634216: btrfs_discard_queue_w=
ork <-__btrfs_add_free_space
> >      btrfs-transacti-407     [002]  42830.634228: btrfs_discard_queue_w=
ork <-__btrfs_add_free_space
> >      ...
> >=20
> > Next transaction started 30 seconds later, which is a default commit
> > interval.
> >=20
> > My file system is of 512GB size. My guess I get about one discard entry
> > per block group on each=20
> >=20
> > Does my system keeps up with scheduled discard backlog? Can I peek at
> > workqueue size?
> >=20
> > Is iops_limit=3D10 a reasonable default for discard=3Dasync? It feels l=
ike
> > for larger file systems it will not be enough even for this idle state.
> >  =20


--=20

  Sergei

--Sig_/ZO_LZian6.nAemDGIeLbb5N
Content-Type: application/pgp-signature
Content-Description: Цифровая подпись OpenPGP

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQKTBAEBCgB9FiEE+g11JqJ4cL44QkmN7V5F4G8qwpMFAmQR87FfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEZB
MEQ3NTI2QTI3ODcwQkUzODQyNDk4REVENUU0NUUwNkYyQUMyOTMACgkQ7V5F4G8q
wpMD7A/8CgNRD4h0SStXmlIfueKrNAvfqjLfe5cNMIjvXaSkx0h6N8DCJO40Lkqr
/Cu5V7NT8q3CeRYWQrbIlshG17dynIw+DNknO+wJtZtFqKVZTz51dk7m5fk92Qoa
K9VpUr8U6s3E4UQrVKUzwmMPJeaD3BAuM7ZWUUyGtCOlmssmhlezhok2j2HLl2mc
G2Z8V+zX4GOrxbZfBqF3koC32/2TSzqrKoaIrcgavvvgk7tQHTY6dp90x8M9BU+s
jmR1WzZ8pxR4azqlC5JRzHv3agrQM4w0z/PVOVXd9bXbEUvwnI3FWlhIowZrw2oV
tuFe1oy+vV5Nqn8hFVUwX5BJlcqfgjY5BtOMl+qMLhpTmkv2ep5qvZbinHJCN/mM
xaArxc678jvMu0BGnFLGanHyxCiN+BsMcBW6NI+gTi9L20jiwgD27EEoGyQYufwZ
Ex18hGU50sbJZFNd54SfgMHpqg9hrVxXBA/rn8kAu7gwg++3bc7lUT/fzlogOVuT
21HcQmkU8u49Bqn7Rm3VQXfId/r+t/7PVgk0+P1x6rNTG5iA6YcqtRexlC2aIUwD
1bWiCNTXDPrua7UJyfwCLmEkEArTECZy8iU94INOcXqm7ZzTxvLgHDvEaepwL4pj
tFXaCgfZD+XJMYzzBEWlXYS4VeMILrCqe42tMM2USUjGCOcoJys=
=LJxr
-----END PGP SIGNATURE-----

--Sig_/ZO_LZian6.nAemDGIeLbb5N--
