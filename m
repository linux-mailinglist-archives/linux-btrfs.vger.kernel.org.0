Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D64E788446
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 12:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjHYKHF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 06:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjHYKGe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 06:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A32106
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 03:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4525762FB9
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 10:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61590C433C7;
        Fri, 25 Aug 2023 10:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692957991;
        bh=spjNavDxVkOgczkMOddSkUptD98eGtpSnNMxTKv6hpM=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Ln5m0U/w+x+s2RBXkxrIE1amOZpHW4EBlsbk11kCtETkBywZAKc8CbS+qbHhgtWJ6
         BZj91PElCGcjqZ10T2btFQWQkju7SX3J1rvCGUXiFZ9Jhtu5Hj/uf6xHeAzWyL4TX7
         x8RsYQrlMpQyd3QTHu9Stq5TLOd/m+drOn7RVyIJZYKcmts5Znbg11sihtVkXNVDlz
         Y4fDwPpSAee4EL/cb7hg75KkZjYYh7FMvHi0AtmNJgliDuK/CgwSjDddYLegHjDjfE
         ffuy5fGC/3wx4d7ReLfUa+NmuL0bm1lKG/eoPycqJXpm4h7qsOG03FcmRmVfIdJB6z
         PCkGEve4NMNJA==
Message-ID: <2c789ca858b0c2c52a5e90aba403144fbff3f941.camel@kernel.org>
Subject: Re: btrfs blocks root from writing even when there is plenty of
 statfs->f_bfree
From:   Jeff Layton <jlayton@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Fri, 25 Aug 2023 06:06:30 -0400
In-Reply-To: <32999248-c1e9-4601-9a1e-b236a7fa8638@gmx.com>
References: <dca245d8861cfa6ba65a4ca4b74ff8adaba9bfc0.camel@kernel.org>
         <c3792425-efcf-40d4-a3fb-e7f8b38dc666@gmx.com>
         <32999248-c1e9-4601-9a1e-b236a7fa8638@gmx.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2023-08-25 at 10:12 +0800, Qu Wenruo wrote:
>=20
> On 2023/8/25 09:23, Qu Wenruo wrote:
> >=20
> >=20
> > On 2023/8/25 04:33, Jeff Layton wrote:
> > > I've been doing some testing with btrfs exported via nfsd and hit thi=
s
> > > bug. root is unable to write to the filesystem, even though statfs
> > > reports that there should be 400k+ blocks available.
> > >=20
> > > The reproducer is pretty simple. First I fill up the filesystem as an
> > > unprivileged user (let this run until I hit ENOSPC):
> > >=20
> > > [vagrant@kdevops-nfs-default btrfs]$ dd if=3D/dev/urandom
> > > of=3D/media/btrfs/bigfile bs=3D1M
> > >=20
> > > ...and then try to write to a file on the fs as root:
> > >=20
> > > [root@kdevops-nfs-default btrfs]# strace -f -e statfs df .
> > > statfs(".", {f_type=3DBTRFS_SUPER_MAGIC, f_bsize=3D4096,
> > > f_blocks=3D26214400, f_bfree=3D452204, f_bavail=3D0, f_files=3D0, f_f=
free=3D0,
> > > f_fsid=3D{val=3D[0xa9d43863, 0xb08b34cc]}, f_namelen=3D255, f_frsize=
=3D4096,
> > > f_flags=3DST_VALID|ST_RELATIME}) =3D 0
> >=20
> > Note that, unlike XFS/EXT4, btrfs goes strict limits between data and
> > metadata.
> >=20
> > Metadata space can only be used to store tree blocks, never data.
> > And both metadata and data space are allocated dynamically, thus we hav=
e
> > have problems when the workload is unbalanced.
> > (This is a little like the inodes limits on XFS/EXT4, but more dynamic)
> >=20
> > In your particular case, the data space is all used up, but metadata
> > space still has some free space.
> >=20
> > And f_btree returned by btrfs is including the metadata space, as
> > although that's inaccurate, it's the best what we can do to report.
> >=20
> >=20
> > > Filesystem=A0=A0=A0=A0 1K-blocks=A0=A0=A0=A0=A0 Used Available Use% M=
ounted on
> > > /dev/nvme2n1=A0=A0 104857600 103048784=A0=A0=A0=A0=A0=A0=A0=A0 0 100%=
 /media/btrfs
> > > +++ exited with 0 +++
> > > [root@kdevops-nfs-default btrfs]# xfs_io -f -c "pwrite -b 4096 4096
> > > 4096" ./file1
> > > pwrite: No space left on device
> > >=20
> > > This works on ext4 and xfs. The kernel is Linus' master branch as of =
a
> > > couple of days ago:
> > >=20
> > > =A0=A0=A0=A0 6.5.0-rc7-g081b0d4bef5d
> > >=20
> > > Let me know if you need more info.
> >=20
> > That's why for btrfs we recommend to go "btrfs fi usage" to get a more
> > comprehensive understand on the space usage.
> >=20
> > In your case, Data usage should be 100%, without any spare ones.
>=20
> Another thing is, btrfs doesn't have any extra data space reserved for
> root user, instead btrfs has extra space reserved for metadata, as
> metadata COW will cost extra space, even doing things like unlinking a fi=
le.
>=20
> Thus this would be a behavior difference here.
>=20


Got it, thanks for the explanation.

FWIW, I noticed this because generic/186 and generic/187 were failing on
NFS exported btrfs, but was passing with XFS, they get _notrun:

    generic/186       [not run] Can't fragment free space on btrfs.
    generic/187       [not run] Can't fragment free space on btrfs.

I'll probably just skip this test on NFS since it only reliably passes
on certain exported filesystems.

Thanks again!
--=20
Jeff Layton <jlayton@kernel.org>
