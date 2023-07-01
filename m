Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E1D744A30
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jul 2023 16:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjGAO7c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jul 2023 10:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGAO7c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Jul 2023 10:59:32 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2CC35B3
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jul 2023 07:59:27 -0700 (PDT)
Date:   Sat, 01 Jul 2023 14:59:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1688223562; x=1688482762;
        bh=1LlTO3OePDclHeNmSxMp6aNfOUxtz6gjxr563v2TRMM=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=lPBtOf9xeb4Jr/gfnGYjqi5s3udeaI1q7C7mAPInSID3diwO5FeVDt+bWLLkZ6zfO
         AwnUBXWS6t6jn9ZYulrGzKWhgSjdJMbJn1t+PqwYS1cGbVX2/J7mIq2T+tgYbFkaZs
         sVfhGeQEDHAyQjDusL702BQVcHKDJVyWS+1FgYfNpfipMlIYbTaMu1Ae0ANceoPW/L
         rAn9tMPOSdoJzklK1jp8Uvx8vlDNY6aQgWfzz+FtiKcNuOfFxTaTxNFIYZRgAepBGR
         UKkMyELNd+IR9GPthmy9qZ0//4tKARYz4ITv2VUwJMu3ujyiR6mffmn2osBP8/sRBQ
         m3gYZQmDR6CfQ==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   yeslow <yeslow@proton.me>
Subject: Can't mount RAID-0 btrfs volume
Message-ID: <XbRHcnOusT9SgtIvEblFkrC43giGNCYfguS2_xjdCfx_NpoVzC4tHpV1hm-PF9_oxpVtM2j2imSl_1sEm3eYQRMFZy5ovi--vMQNkrab65o=@proton.me>
Feedback-ID: 79066612:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I have a dual boot system with Windows 10 Pro and Linux Kubuntu 22.04.

I have created a btrfs raid-0 volume in my Linux system with 2 SSD drives t=
o store not very important files, where the speed is most important. I then=
 use winbtrfs in the Windows 10 system to be able to access the btrfs volum=
e, when using Windows 10.

Everything worked fine for several months until recently. I deleted some fi=
les on the btrfs volume in Windows 10, which always worked fine, but this t=
ime I noticed that after the file deletion the volume in Linux was not show=
ing the expected free space. When trying to have this fixed, I decided to g=
ive it a try by using the command: btrfs check --clear-space-cache v2

Wrong decision, because after that I got a warning message (don't remember =
which), and the next time I booted my computer the volume was not possible =
to mount.

Now, when I run the command: sudo btrfs check --readonly /dev/sda1

I get the following:
Opening filesystem to check...
checksum verify failed on 18266193920 wanted 0x34bed84997ecd963 found 0x9ee=
6d0c7b17903ec
checksum verify failed on 18266193920 wanted 0x0000000000000000 found 0x3e7=
6427c81028f58
checksum verify failed on 18266193920 wanted 0x34bed84997ecd963 found 0x9ee=
6d0c7b17903ec
bad tree block 18266193920, bytenr mismatch, want=3D18266193920, have=3D623=
7172951202995731
ERROR: cannot read chunk root
ERROR: cannot open file system

I have tried googling these error messages and found this mailing list. I h=
ave tried some suggestions found here:

1)
sudo mount -t btrfs -o rescue=3Dall,ro /dev/sda1 /z1
result:
mount: /z1: can't read superblock on /dev/sda1

dmesg:
[23664.424317] BTRFS info (device sda1): using xxhash64 (xxhash64-generic) =
checksum algorithm
[23664.424349] BTRFS info (device sda1): enabling all of the rescue options
[23664.424355] BTRFS info (device sda1): ignoring data csums
[23664.424360] BTRFS info (device sda1): ignoring bad roots
[23664.424364] BTRFS info (device sda1): disabling log replay at mount time
[23664.424370] BTRFS info (device sda1): disk space caching is enabled
[23664.425981] BTRFS error (device sda1): bad tree block start, mirror 1 wa=
nt 18266193920 have 6237172951202995731
[23664.426101] BTRFS error (device sda1): bad tree block start, mirror 2 wa=
nt 18266193920 have 0
[23664.426127] BTRFS error (device sda1): failed to read chunk root
[23664.427009] BTRFS error (device sda1): open_ctree failed

2) sudo btrfs rescue super-recover -v /dev/sda1
result:
All Devices:
        Device: id =3D 2, name =3D /dev/sde1
        Device: id =3D 1, name =3D /dev/sda1

Before Recovering:
        [All good supers]:
                device name =3D /dev/sde1
                superblock bytenr =3D 65536

                device name =3D /dev/sde1
                superblock bytenr =3D 67108864

                device name =3D /dev/sde1
                superblock bytenr =3D 274877906944

                device name =3D /dev/sda1
                superblock bytenr =3D 65536

                device name =3D /dev/sda1
                superblock bytenr =3D 67108864

                device name =3D /dev/sda1
                superblock bytenr =3D 274877906944

        [All bad supers]:

All supers are valid, no need to recover

---

This volume has some files that I would like to recover. Is there any possi=
bility of fixing this, just to allow me to copy the files that I need? Or i=
s the volume completely broken and all data lost, and then I should simply =
create a new volume again?

My apologies if this is not the right place for asking this, but the only p=
lace where google search showed meaningful answers was here.

My thanks in anticipation.

