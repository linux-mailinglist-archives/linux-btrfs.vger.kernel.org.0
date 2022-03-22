Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5214E3EF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 13:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiCVM7j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 08:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiCVM7j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 08:59:39 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Mar 2022 05:58:10 PDT
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BC753A6D
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.com;
        s=dbd5af2cbaf7; t=1647953890;
        bh=Q4BbwUT9T6nnfkEeyqTbwV43Cmfitcc1d4aXsuxC2Cs=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=j6k9xIu1mWoyCax6WPSxcfi0+u691vmydKxmBqVUgPC2AqhreO58J58jN+D1SpOOY
         nwXWmM+nIdeXjvywpn83A4e15i+qwQCR4Id84XImGDngtb9ZAtmqhihAntwq+T2T1R
         4kzFleOhsglE5v749KtXdKV9wdH43TUTL7Qz9Cwg=
X-UI-Sender-Class: 214d933f-fd2f-45c7-a636-f5d79ae31a79
Received: from [88.156.136.188] ([88.156.136.188]) by web-mail.mail.com
 (3c-app-mailcom-lxa08.server.lan [10.76.45.9]) (via HTTP); Tue, 22 Mar 2022
 13:53:08 +0100
MIME-Version: 1.0
Message-ID: <trinity-58cb51fa-9b3e-4fd0-9ff7-29da0dd13e14-1647953588232@3c-app-mailcom-lxa08>
From:   Joseph Spagnol <joseph.spagnol@programmer.net>
To:     linux-btrfs@vger.kernel.org
Subject: failed to read block groups: Input/output error; bad tree block -
 bytenr mismatch;
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Mar 2022 13:53:08 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:/frdk3GLU5hpYEvNbEUXJKHF0Y6w1xj20aKgtJUFd/hkWLDGSQwwyufrQAX1ZUdtOM+rd
 Oyd2emrr/xwh+6kYnXRE3P1SGWzt2LCbbun7++ylBnw4WWpezmLGYsMuO6QINkWefNu+NdTYdCm+
 TLnARlfULB7+CHl2BgJIV+CCMP9/STn5oDJVAyq/iuPYC+JMqOfyu5Lkp5Z/ovFqj2s1hXsyY6Ao
 RAL7QrnTcJbFOsLKEoZL7HRFmMSVl23vcCT13ZHnt6Dmm5I12+uJlEwo5rv+24NywMQv5Uvgo/pi
 SQ=
X-UI-Out-Filterresults: notjunk:1;V03:K0:ospIt2eIAlk=:b8SjS5Hr1z97P/8Z1A8L6q
 RKaOxNvwlTxWypMZQ6Fw2SIH3cQ6yJuItrJ3CztU1tfO+aCqIwY5XPnb90bYwbJizg9Lp2v1Z
 kknfh4Eh3f1M1V0AUxZgewtor5jZxT4TR/nIyk60fQvfvuLlIMH2mm1FNtGKQqYiDiY8lKL71
 hj9EIkNqxr44dco2equ4Ibb1ogptPJpZmQAAxH+yNXZh80TINF7StP2Sqv+oLiLnTw7/nL/GG
 Lr+VpdCN+USMTFkSUi7VJtQ0KatSZ3qV3LhTTND7fi8pU/Iy3OLlQVMvvObGRdOiHbMjK9GRu
 obL6kIjF71pAYdMwDR6RIKxno56XvvDf5bzL4cdh3XgXS4xn9bkyDN79wuOUVr5ARyIO6H/GT
 aBvDLGIGIoazunr7kx4KgeXRpc20sxINIOjN6toKhdSnjjATh8DVvKepoyMRxaMMea+gLHrSy
 /6eKsrGOm++7j2tOydmX/9BYFFEZtGue+h3He/vh9nJo4/PDwT3JEf/zi5NEV3XXvhfl1Q8c2
 o7azXtwjgKNMlw0C2oBNFUDYKWbjVcRgeK7v5nAz5hwjU1Wi7CmJVqSNiE1rkele5O9A33NMw
 dk22rCp6KuGRDlCHbUo4zudwFerRHVKFYcvvEQnsY8akyKJrJKeHnP09Y9SuFJASFF8acCO28
 a/3/ViPseoPGge7LELpeivQHPlhgj8RK7ZBRG8xYHEZLUpALgJu4NdoQJ5H4THYhN5vlcnsEp
 kG7ozltCnSZvqGG48qxhdoFUuSYh184j3m0SoFIOQi2w40BPJQhKDckZ+uDsLp/eSegHGqP6C
 UW58TWLoTmzZtoRfRpt1CiU8kwH3w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, recently one of my btrfs partitions has become unavailable and am not able to mount it.

# mount -t btrfs /dev/sda4 /mnt/
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda4, missing codepage or helper program, or other error.

# btrfs-find-root /dev/sda4
Couldn't read tree root
Superblock thinks the generation is 432440
Superblock thinks the level is 1
Well block 23235313664(gen: 432440 level: 0) seems good, but generation/level doesn't match, want gen: 432440 level: 1
Well block 23231447040(gen: 432439 level: 1) seems good, but generation/level doesn't match, want gen: 432440 level: 1
Well block 23229202432(gen: 432438 level: 0) seems good, but generation/level doesn't match, want gen: 432440 level: 1
Well block 23192911872(gen: 432431 level: 1) seems good, but generation/level doesn't match, want gen: 432440 level: 1
Well block 23177084928(gen: 432430 level: 1) seems good, but generation/level doesn't match, want gen: 432440 level: 1
Well block 23149035520(gen: 432429 level: 1) seems good, but generation/level doesn't match, want gen: 432440 level: 1
Well block 23124443136(gen: 432427 level: 1) seems good, but generation/level doesn't match, want gen: 432440 level: 1
Well block 23113547776(gen: 432426 level: 1) seems good, but generation/level doesn't match, want gen: 432440 level: 1
Well block 23080730624(gen: 432425 level: 1) seems good, but generation/level doesn't match, want gen: 432440 level: 1
Well block 23048241152(gen: 432424 level: 1) seems good, but generation/level doesn't match, want gen: 432440 level: 1
Well block 23013031936(gen: 432422 level: 1) seems good, but generation/level doesn't match, want gen: 432440 level: 1
.......

# btrfsck -b -p /dev/sda4
Opening filesystem to check...
checksum verify failed on 23234035712 wanted 0x00000000 found 0x0810faf8
checksum verify failed on 23234035712 wanted 0x00000000 found 0x0810faf8
bad tree block 23234035712, bytenr mismatch, want=23234035712, have=0
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system

Here are some more details;
# uname -a
Linux msi-b17-manjaro 5.4.184-1-MANJARO #1 SMP PREEMPT Fri Mar 11 13:59:07 UTC 2022 x86_64 GNU/Linux
# btrfs --version
btrfs-progs v5.16.2
# btrfs fi show
Label: 'OLDDATA'  uuid: 9bc104b4-c889-477f-aae1-4d865cdc0372
        Total devices 1 FS bytes used 34.20GiB
        devid    1 size 50.00GiB used 37.52GiB path /dev/sda3
Label: 'OPENSUSE'  uuid: c3632d30-a117-43ef-8993-88f1933f6676
        Total devices 1 FS bytes used 24.60GiB
        devid    1 size 150.00GiB used 31.05GiB path /dev/nvme0n1p4
Label: 'DATA'  uuid: 4ce61b29-8c8d-4c04-b715-96f0dda809a4
        Total devices 1 FS bytes used 118.67GiB
        devid    1 size 200.00GiB used 122.02GiB path /dev/sda4
# btrfs fi df /dev/sda4
ERROR: not a directory: /dev/sda4
# btrfs fi df /data/
ERROR: not a btrfs filesystem: /data/
## dmesg.log ##
[65500.890756] BTRFS info (device sda4): flagging fs with big metadata feature
[65500.890766] BTRFS warning (device sda4): 'recovery' is deprecated, use 'usebackuproot' instead
[65500.890768] BTRFS info (device sda4): trying to use backup root at mount time
[65500.890771] BTRFS info (device sda4): disabling disk space caching
[65500.890773] BTRFS info (device sda4): force clearing of disk cache
[65500.890775] BTRFS info (device sda4): has skinny extents
[65500.893556] BTRFS error (device sda4): bad tree block start, want 23235280896 have 0
[65500.893593] BTRFS warning (device sda4): failed to read tree root
[65500.893852] BTRFS error (device sda4): bad tree block start, want 23235280896 have 0
[65500.893856] BTRFS warning (device sda4): failed to read tree root
[65500.908097] BTRFS error (device sda4): bad tree block start, want 23234035712 have 0
[65500.908111] BTRFS error (device sda4): failed to read block groups: -5
[65500.963167] BTRFS error (device sda4): open_ctree failed

P.S. I must say that I get the same results when I try to mount the partition from another linux system OpenSuse tumbleweed

Is there any way I could rebuild the tree?

Thanks in advance
Joseph


