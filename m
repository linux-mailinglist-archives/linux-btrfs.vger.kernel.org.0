Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C788D78795C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 22:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbjHXUdJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 16:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbjHXUdI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 16:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEB7E5E
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 13:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28FF462A03
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 20:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ED2C433C8
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 20:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692909185;
        bh=RGamYdlUWtoUadJqxdUe0+yQkT6abcYMDq7vvMHCJ1A=;
        h=Subject:From:To:Date:From;
        b=VRzRktJVPXuxAN4UnvMcjHyAEhZKd29AqRAyszssgfhgjbnpuwVFA/pJBPjQIt8rW
         /u1220ioXdtJXaEszdhFTdJKptkznsNqwnduwVAlweMzUfvs3+TCrCiwUb6dwpah3s
         LLLTWocR4p9Wx/ndgSvUOwTbeh5V5FtutJE006blU9Ba2tYpadzE9hL16DgbSEJD2t
         3T24+XQRKtOU6Fd5ystDTAlvjW+82ZDgtzxxjVndLiHncNaQe8dx4FcPw7j1I0eP3C
         rrSHKM7MV54dXdbyiRVD9X5+dPlfF9Mg7vBA/b+08NtQmydz89hci+mlJy/sMF746D
         UXr+JuXpvtAfg==
Message-ID: <dca245d8861cfa6ba65a4ca4b74ff8adaba9bfc0.camel@kernel.org>
Subject: btrfs blocks root from writing even when there is plenty of
 statfs->f_bfree
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Thu, 24 Aug 2023 16:33:04 -0400
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've been doing some testing with btrfs exported via nfsd and hit this
bug. root is unable to write to the filesystem, even though statfs
reports that there should be 400k+ blocks available.

The reproducer is pretty simple. First I fill up the filesystem as an
unprivileged user (let this run until I hit ENOSPC):

[vagrant@kdevops-nfs-default btrfs]$ dd if=3D/dev/urandom of=3D/media/btrfs=
/bigfile bs=3D1M

...and then try to write to a file on the fs as root:

[root@kdevops-nfs-default btrfs]# strace -f -e statfs df .
statfs(".", {f_type=3DBTRFS_SUPER_MAGIC, f_bsize=3D4096, f_blocks=3D2621440=
0, f_bfree=3D452204, f_bavail=3D0, f_files=3D0, f_ffree=3D0, f_fsid=3D{val=
=3D[0xa9d43863, 0xb08b34cc]}, f_namelen=3D255, f_frsize=3D4096, f_flags=3DS=
T_VALID|ST_RELATIME}) =3D 0
Filesystem     1K-blocks      Used Available Use% Mounted on
/dev/nvme2n1   104857600 103048784         0 100% /media/btrfs
+++ exited with 0 +++
[root@kdevops-nfs-default btrfs]# xfs_io -f -c "pwrite -b 4096 4096 4096" .=
/file1
pwrite: No space left on device

This works on ext4 and xfs. The kernel is Linus' master branch as of a
couple of days ago:

    6.5.0-rc7-g081b0d4bef5d

Let me know if you need more info.
--=20
Jeff Layton <jlayton@kernel.org>
