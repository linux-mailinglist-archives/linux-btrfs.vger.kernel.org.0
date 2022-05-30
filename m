Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6C553875B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 20:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbiE3SdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 May 2022 14:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242865AbiE3SdE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 May 2022 14:33:04 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9116AA7A
        for <linux-btrfs@vger.kernel.org>; Mon, 30 May 2022 11:32:58 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id k20so3816337ljc.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 May 2022 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZzNuGxaPV0ftRvKFIhs7bCDxtUwXngjqzKDl/1efc8k=;
        b=G/x8IS5ZCUE6ADsPlvUPUXAaB04OyIqXMKm+KJSUw5StiEuv4cL1TAstOVlmqy3elm
         5+9MF0hXubRSbX/CG1QqSGW8cFuki2/FPGJAo+jjtMBQfsyBdtVEQ3MaHNxJ4S83iRlb
         zfFb29YmqW/jeQNrIzFUEQ7Nfby/ABolramFIffZ/O9bQAKSGOPNZdiRa3RQxvV9s+H/
         9ZdOEFKXpgbMqpO3RpRdV/+uQ11egmtTr8zb6FCciQxAnQKcTAkHLX9OovDtWQxrV2eR
         TWVSkBI6ePkiHyDRs44E93DbkAs98oWmgFt9mfcYjCrdm/FlazGbqsB0U/UAOgeHqOjc
         nc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ZzNuGxaPV0ftRvKFIhs7bCDxtUwXngjqzKDl/1efc8k=;
        b=CyJAfyOYhKhlZhUAlhdmm3W57KNM3rWacgXv70qN7RcCiflnXLnCjHLRLEDPGX654S
         OfxJlbyDvWrb3Im0lq/XOXspYiF/9o43mIVwwqe7WKStjFniJWTKCxpae4U7faTQzlao
         dy35CbkqlHZ7DbivJwMsSMwt5irDk8z4lyXXJXgguMwBYo37LfZiV3QwE7HVfDm5SMQ4
         /0eX1oA9yRViIpa5aq+HZkUcONIEKp/LN3NU+rUT5Gpoi82QPRQG2I6wX+bHgpEiC7Uu
         I8yxsZ1vNlg0REKaQIK9XTdzrr+ovlFa96sHuuuuZNexmfrZa+HQBYkzSHVpRCK+qeFJ
         gHTw==
X-Gm-Message-State: AOAM533vKZdAmCrPMOkrUvCJmuhlBiZ6IK9SHfrzKmBSp8XRhDbt7dec
        C4ivzZdmxrzi3huolPTZovxkdmp9t30rpyNIzTf1BvEo
X-Google-Smtp-Source: ABdhPJw+O9fZn3lsTfQsUTNd6DOKOx+zAbdO6bVFs153CXHn82RmZiCAFbxPxbBULq9B0u9JuMMKsSofqA3ZjaNfhoM=
X-Received: by 2002:a2e:84c8:0:b0:24b:50bb:de7d with SMTP id
 q8-20020a2e84c8000000b0024b50bbde7dmr32281593ljh.40.1653935577285; Mon, 30
 May 2022 11:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOfGOYy7c0T72AkL01fFDBOgMR2G+rb6doTZzApczR1xJBG+Rg@mail.gmail.com>
In-Reply-To: <CAOfGOYy7c0T72AkL01fFDBOgMR2G+rb6doTZzApczR1xJBG+Rg@mail.gmail.com>
From:   Hannes Schweizer <schweizer.hannes@gmail.com>
Date:   Mon, 30 May 2022 20:32:40 +0200
Message-ID: <CAOfGOYzdbrjfOjCHm62xWJZETym5UJ3iemELoOEpE6+89f5QVw@mail.gmail.com>
Subject: Fwd: filesystem broken due to 'csum exists for <> but there is no
 extent record' errors?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Here's my environment:
Linux diablo 5.17.9-gentoo #2 SMP Sun May 29 00:02:20 CEST 2022 x86_64
Intel(R) Core(TM) i5 CPU 760 @ 2.80GHz GenuineIntel GNU/Linux
btrfs-progs v5.18

Label: 'online'  uuid: 4a7da48d-2957-4ca0-b287-2d4c38bc223e
       Total devices 3 FS bytes used 3.94TiB
       devid    1 size 1.82TiB used 1.63TiB path /dev/mapper/online0
       devid    2 size 1.82TiB used 1.63TiB path /dev/mapper/online1
       devid    3 size 931.50GiB used 742.00GiB path /dev/mapper/online2
Data, single: total=3D3.97TiB, used=3D3.93TiB
System, RAID1: total=3D32.00MiB, used=3D464.00KiB
Metadata, RAID1: total=3D11.00GiB, used=3D8.33GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

After a power outage, I routinely ran a read-only btrfs check in an
initramfs, which produced a lot of the following errors during the
'checking extents' phase:
backref <> parent <> not referenced back <>
incorrect global backref count on <> found <> wanted <>
backpointer mismatch on [<> <>]
owner ref check failed [<> <>]
ref mismatch on [<> <>] extent item <>, found <>

The filesystem still mounted OK though, and a subsequent online scrub
showed no problems. Since everything is backed up, I took the risk and
tried a check --repair run, which fixed the extent errors, but left me
with these errors:
btrfs check -p /dev/mapper/online0
Opening filesystem to check...
Checking filesystem on /dev/mapper/online0
UUID: 4a7da48d-2957=E2=80=944ca0-b287-2d4c38bc223e
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
there are no extents for csum range 6044207878144-6044207882240
csum exists for 6044207878144-6045835227136 but there is no extent record
there are no extents for csum range 7788082724864-7788082745344
csum exists for 7788081930240-7788082745344 but there is no extent record
there are no extents for csum range 7788761333760-7788761374720
csum exists for 7788761333760-7788761645056 but there is no extent record
[5/7] checking csums (without verifying data)
ERROR: errors found in csum tree
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 4360122875904 bytes used, error(s) found
total csum bytes: 4248374108
total tree bytes: 9027862528
total fs tree bytes: 4254793728
total extent tree bytes: 254754816
btree space waste bytes: 1295819354
file data blocks allocated: 9082352828416
 referenced 7722966454272

According to
https://github.com/kdave/btrfs-progs/issues/430
these erros do not indicate any data problems, however according to Qu
Wenruo: "The problem here is, when new data extent is allocated for
that range, and it has csum, it will cause -EEXIST error and cause a
failure."

So I bravely went ahead and started an --init-csum-tree run, which ran
for over 36h, with barely any disc activity after the 24h mark. I
interrupted the process by sysrq syncing and rebooting.
The filesystem still mounts OK, online scrub again shows no errors,
but the above mentioned "csum exists... but there is not extent"
errors still persist.

- Is the filesystem stable long-term even with these problems?
- Should I retry an --init-csum-tree run and wait longer? A progess
inidicator would be nice...

Any hints appreciated...
