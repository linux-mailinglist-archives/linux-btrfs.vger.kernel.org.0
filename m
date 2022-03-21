Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD864E31B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Mar 2022 21:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346176AbiCUU1r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Mar 2022 16:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbiCUU1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Mar 2022 16:27:46 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC07165A86
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 13:26:20 -0700 (PDT)
Date:   Mon, 21 Mar 2022 20:26:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1647894376;
        bh=Q+xYQSP9Fe16mDsHGuRFU4MkrdidY0C/Z4hsCxkeDmk=;
        h=Date:To:From:Reply-To:Subject:Message-ID:From:To:Cc:Date:Subject:
         Reply-To:Feedback-ID:Message-ID;
        b=gBxdPlrvd9JHs8R/uxmzupo4tBcf0UujXQ57//czbdMIk9OrJVDOtfBOmTp/Sk5Y9
         IVGRx5dZ9nTHGjzG91XCeU8YjFSlQoWJNN6LOb4nmMLZt4RIDTmO5m7BXrv4Xuv6no
         1mw400ouSx7VPnFk0oZATgXqRRo7y1KEYkuzskV+P5gcF6hMyu1KA8oFqsLxwmhIFC
         FtIW4Bg7KRaV10unhrsapXwDzMxBYyeB6jo1FYZ8DlmOvv/zvaySi0RD2ZLyhcH3m/
         x0asp1LAPHRcIexgm8ECculu2UI4cGqdd8ypFtY2PFcXx6hMi4pf9c7ZPjlDQlj+0i
         XJgqm0RoGf6mQ==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   felipecastrotc@protonmail.com
Reply-To: felipecastrotc@protonmail.com
Subject: Bad tree block after hibernation and reboot
Message-ID: <dWRELj6T5paHnz-hagwgT6ciYcUwi9XIYx-QS5YsUJiMMYPtUTJnkmwTb8L1apmxYGBTmMYHtPDWdINlSysqgOrL1w3Jk9N5FlQsrHGKRhU=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everyone.

After starting up from a hibernate state and a reboot, my btrfs partition s=
eems to be corrupted. I spent the last few days reading the documentation a=
nd trying different repair methods, first on an image of the partition and =
then directly on the partition. In both cases, I was unsuccessful, and the =
output messages were all the same. The repair method does not seem to advan=
ce and halts with similar messages, except the `btrfs rescue super-recover`=
  and `btrfs rescue super`, which return that the supers are ok.

I am sending this message hoping that you can at least explain what the iss=
ue is.

The disk was running with Linux 5.16.14 at the moment of the crash. When I =
booted sytem from the hibernate state, the filesystem was mounted as read-o=
nly access. Then, when I restarted it again, I was unable to boot. I have b=
een using a recovery environment with a Linux 5.16.11 with btrfs-progs v5.1=
6.2. Also, some possible relevant information:

  ~ # btrfs fi show

    Label: 'ROOT'  uuid: 77307dfc-2951-4453-b789-49cc2924077a
    Total devices 1 FS bytes used 301.63GiB
    devid    1 size 700.00GiB used 369.02GiB path /dev/nvme0n1p2

Here are some steps that I tried and their output:

* Simply mounting the partition

  ~ # mount /dev/block/nvme0n1p2 /mnt

    mount: /mnt: wrong fs type, bad option, bad superblock on /dev/nvme0n1p=
2, missing codepage or helper program, or other error.

* Then, I looked at the dmesg output

    [   51.002678] BTRFS error (device nvme0n1p2): bad tree block start, wa=
nt 164689903616 have 0
    [   51.002708] BTRFS error (device nvme0n1p2): failed to read block gro=
ups: -5
    [   51.003142] BTRFS error (device nvme0n1p2): open_ctree failed

* I tried to mount with the option `usebackuproot`

  ~ # mount -t btrfs -o ro,rescue=3Dusebackuproot /dev/nvme0n1p2 /mnt

    mount: /mnt: wrong fs type, bad option, bad superblock on /dev/nvme0n1p=
2, missing codepage or helper program, or other error.

* And the dmesg output were

    [ 7338.494567] BTRFS info (device nvme0n1p2): flagging fs with big meta=
data feature
    [ 7338.494576] BTRFS info (device nvme0n1p2): trying to use backup root=
 at mount time
    [ 7338.494578] BTRFS info (device nvme0n1p2): disk space caching is ena=
bled
    [ 7338.494579] BTRFS info (device nvme0n1p2): has skinny extents
    [ 7338.499017] BTRFS error (device nvme0n1p2): bad tree block start, wa=
nt 164689903616 have 0
    [ 7338.499047] BTRFS error (device nvme0n1p2): failed to read block gro=
ups: -5
    [ 7338.499403] BTRFS error (device nvme0n1p2): open_ctree failed

* I tried to check the partition

  ~ # btrfs check /dev/nvme0n1p2

    Opening filesystem to check...
    checksum verify failed on 164689903616 wanted 0x00000000 found 0xb6bde3=
e4
    checksum verify failed on 164689903616 wanted 0x00000000 found 0xb6bde3=
e4
    bad tree block 164689903616, bytenr mismatch, want=3D164689903616, have=
=3D0
    ERROR: failed to read block groups: Input/output error
    ERROR: cannot open file system

* The superblocks seems to be ok

  ~ # btrfs rescue super-recover /dev/nvme0n1p2

    All supers are valid, no need to recover

  ~ # btrfs rescue super -v /dev/nvme0n1p2

    All Devices:
    Device: id =3D 1, name =3D /dev/nvme0n1p2

    Before Recovering:
    [All good supers]:
    device name =3D /dev/nvme0n1p2
    superblock bytenr =3D 65536

    device name =3D /dev/nvme0n1p2
    superblock bytenr =3D 67108864

    device name =3D /dev/nvme0n1p2
    superblock bytenr =3D 274877906944

    [All bad supers]:

    All supers are valid, no need to recover

* While the following repair methods, return similar outputs

  ~ # btrfs rescue zero-log /dev/nvme0n1p2

    checksum verify failed on 381634265088 wanted 0x00000000 found 0xb6bde3=
e4
    ERROR: could not open ctree

  ~ # btrfs check --init-csum-tree /dev/nvme0n1p2

    Creating a new CRC tree
    WARNING:

    Do not use --repair unless you are advised to do so by a developer
    or an experienced user, and then only after having accepted that no
    fsck can successfully repair all types of filesystem corruption. Eg.
    some software or hardware bugs can fatally damage a volume.
    The operation will start in 10 seconds.
    Use Ctrl-C to stop it.
    10 9 8 7 6 5 4 3 2 1
    Starting repair.
    Opening filesystem to check...
    checksum verify failed on 164689903616 wanted 0x00000000 found 0xb6bde3=
e4
    checksum verify failed on 164689903616 wanted 0x00000000 found 0xb6bde3=
e4
    bad tree block 164689903616, bytenr mismatch, want=3D164689903616, have=
=3D0
    ERROR: failed to read block groups: Input/output error
    ERROR: cannot open file system

  ~ # btrfs check --init-extent-tree /dev/nvme0n1p2

    WARNING:

    Do not use --repair unless you are advised to do so by a developer
    or an experienced user, and then only after having accepted that no
    fsck can successfully repair all types of filesystem corruption. Eg.
    some software or hardware bugs can fatally damage a volume.
    The operation will start in 10 seconds.
    Use Ctrl-C to stop it.
    10 9 8 7 6 5 4 3 2 1
    Starting repair.
    Opening filesystem to check...
    checksum verify failed on 381634265088 wanted 0x00000000 found 0xb6bde3=
e4
    checksum verify failed on 381634265088 wanted 0x00000000 found 0xb6bde3=
e4
    bad tree block 381634265088, bytenr mismatch, want=3D381634265088, have=
=3D0
    ERROR: cannot open file system

 I tried other commands, including:

* btrfs rescue chunk-recover
* btrfs restore with the tree root found by btrfs-find-root

I am not sure what is the real culprit, and I know that I probably ran some=
 nonsense commands. However, the `bad tree block #### ...` error appears co=
nsistently on them, including on the `btrfs restore` with different root tr=
ees.

