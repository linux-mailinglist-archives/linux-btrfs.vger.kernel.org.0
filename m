Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8A66CB347
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 03:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjC1BnI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 21:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjC1BnF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 21:43:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A742270F
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 18:42:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so43518379ede.8
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 18:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679967758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ooe0XLRPTLyh4SqVpcn1G/4ACIwJ7LV3u1Qzjtf/81I=;
        b=byKFggjdvn7MiA5kOCvE0vnGFa2SEa/IRzF5fqkWvyNT4ojeG2RxGceS8bVv5cR7QO
         viXrD1IXGa5p/SRVNslTLnhH0zICnvadS61brHZugThn2N5GsmtL6/TroeCNCZStgeYC
         posbQYNANSmWDj0aymOuWSZN+DUz5KNiesGhbhxjBgcf3Y8hlqtcQ2zbim6fXDCNECo+
         lmMvDmy6T/JOJ+zyABclWZJHb3TAFy6EcgBhewC0Bt6uVLP56v1uH47BDKHGmdityT2D
         TsSaQG6ULFhZOtpB8POH6TJpcx8Y7i/CvV4MyxMkxw4fho9vSthfnHJV0qNvX14mJ26L
         vdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679967758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ooe0XLRPTLyh4SqVpcn1G/4ACIwJ7LV3u1Qzjtf/81I=;
        b=Cm4wR0bFLZxyPyDL7+u9iuTDDSiwY0MLMkoHP06vpu8Q/HDHjzNAPTFbH8K+/PzDpV
         BjFvlcLjhtj6M9bshvfMSqtw4oTn38niTU1xKhjrXh4ah2JWzti4V6hUlb3MIG/+drh7
         Ya9dWTrx5W7ARJlTJqX8q6+JiPDoxpM9+81lifarA4+YdmxchEkoIItp6XfZnHivkrkM
         VfIITLwGbXhV4LwSbsVjyhvGCFBvShaqhfUM83KFJUYewFGJUuZr3oZ1zySj5qv0UIjc
         14Tv20mywwWbMspZsmIPbS7YY8K49J/V++Vq+uaLUqN8FLCIBGEo99PMOZEyf6c41cLt
         WT9g==
X-Gm-Message-State: AAQBX9cXE6lWsIDOa3xqgYCPVuroIuLnpklxakVahz2GyQtf84znX4Gq
        u7IMmQvO190MxyCBKgXqx3mpmglcJ7feCfotb/Y=
X-Google-Smtp-Source: AKy350YMjv25jKWsyWzedXr6xFbnHXtfKT+kCIhU7kZ3Z0dqAeTbjFJhAktYbAKGqanE0+tQXTLDK+cNaASch9Lyar8=
X-Received: by 2002:a50:9f09:0:b0:501:d3a2:b4ae with SMTP id
 b9-20020a509f09000000b00501d3a2b4aemr6824356edf.7.1679967757682; Mon, 27 Mar
 2023 18:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLfK3WuXuVKxH4dsXGGynwkMAM7Gd14mmxiT2CFYEOFbVuCQw@mail.gmail.com>
 <ffca26e0-88e8-1dc7-ce67-6235a94159e1@gmail.com> <CAOLfK3UZDNO_jSOOHtnA+-Hh-V6_cjsL36iZU0a+V=k80KDenQ@mail.gmail.com>
 <CA+H1V9zb8aO_Y37vdwbubqHZds__=hLe06zx1Zz6zdsDLUkqeQ@mail.gmail.com> <CAOLfK3Uokj64QcBypkfr7X79qQ9235o=bv87RJtRSKjupKUQLw@mail.gmail.com>
In-Reply-To: <CAOLfK3Uokj64QcBypkfr7X79qQ9235o=bv87RJtRSKjupKUQLw@mail.gmail.com>
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Mon, 27 Mar 2023 21:42:26 -0400
Message-ID: <CA+H1V9zmpna9Ncov-15einQ0pLevy-1zF-nSvJrzgz7Mp_TrHw@mail.gmail.com>
Subject: Re: subvolumes as partitions and mount options
To:     Matt Zagrabelny <mzagrabe@d.umn.edu>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It looks like you already have it mostly set up correctly. You will
want to mount your filesystem somewhere without specifying a
subvolume. Then you can put all the subvolumes you want "hidden" in
there. This should be as simple as unomunting /subv_mnt, moving
subv_content to the btrfs root subvolume, and then re-mounting it with
the new position. This is what it looks like for me when I run the
subvolume list command.

sudo btrfs sub list / -a
ID 258 gen 680918 top level 5 path <FS_TREE>/@arch
ID 259 gen 680918 top level 5 path <FS_TREE>/@home
ID 260 gen 680915 top level 5 path <FS_TREE>/@snapshots
ID 726 gen 658581 top level 260 path <FS_TREE>/@snapshots/ROOT.20230320T010=
0
ID 727 gen 658582 top level 260 path <FS_TREE>/@snapshots/home.20230320T010=
0
... trimmed...
ID 740 gen 678482 top level 260 path <FS_TREE>/@snapshots/ROOT.20230327T010=
0
ID 741 gen 678483 top level 260 path <FS_TREE>/@snapshots/home.20230327T010=
0

And this is what the root of my btrfs file system looks like with ls

ls
'@arch'/  '@home'/  '@snapshots'/

Matthew Warren

On Mon, Mar 27, 2023 at 5:06=E2=80=AFPM Matt Zagrabelny <mzagrabe@d.umn.edu=
> wrote:
>
> Hi Matthew,
>
> On Mon, Mar 27, 2023 at 3:32=E2=80=AFPM Matthew Warren
> <matthewwarren101010@gmail.com> wrote:
> >
> > If you want something like this, you will want to have those
> > subvolumes outside of the root subvolume. For instance, My BTRFS
> > subvolumes look like this
> > / root subvol - The subvolume which is created on mkfs
> > /@arch - The subvolume I have mounted as /
> > /@home - The subvolume I have mounted as /home
> >
> > If you do something like that, then you prevent access by having it
> > hidden in the root subvolume.
>
> Do you know if I can retrofit my current btrfs install to implement
> the structure you've suggested?
>
> To my knowledge I've got my root filesystem mounted on the "parent" subvo=
lume:
>
> root@ziti:~# btrfs subvolume list / -a
> ID 256 gen 606645 top level 5 path <FS_TREE>/@rootfs
> ID 257 gen 606389 top level 256 path @rootfs/subv_content
>
> root@ziti:~# mount | grep btrfs
> /dev/nvme0n1p2 on / type btrfs
> (rw,relatime,ssd,space_cache=3Dv2,subvolid=3D256,subvol=3D/@rootfs)
> /dev/nvme0n1p2 on /subv_mnt type btrfs
> (rw,nosuid,nodev,noexec,relatime,ssd,space_cache=3Dv2,subvolid=3D257,subv=
ol=3D/@rootfs/subv_content)
>
> The subv_content subvolume is just for testing and can be deleted.
>
> Thanks for any pointers!
>
> -m
