Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CCC65E92C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 11:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjAEKno (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 05:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjAEKnc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 05:43:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E36395E2
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 02:43:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5220B81986
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 10:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8681BC433D2
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 10:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672915408;
        bh=C7ENrYSPAmQBZjmXS+0r2wzAvXFDZdYRCwIKqyYiUJ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GUK+3AirY173M3Uj1JlDOHCcXWN0MNCEkgg1aJHoIrgSXOXc9MfB1Zs/N4LwexjXO
         UDX+GpmRHZgLGPa/+0DzVwrpYSQoMc/v+VfBx7vi2EcF7gkJDi1IL3AzZXCXs5MdZL
         wVTFpYPhl9MQsLbFPS6I5ODdZmGkIGExQUD4J35B04isVVhXASCNA9dpe0b8VRCapA
         rkfrcVi5uu2iV2yaSN52rcsYz3uln23gAn9iXZoviwCIngoue0cOz0AykyzeAqZ5sE
         cheX0RteSrgaPQk1IKXsdUvCg63waZRX3J3eI6vQD37y/sJnsfMXqWJ3bNi5/nhGDQ
         /ckpzNEL+jeeA==
Received: by mail-oi1-f178.google.com with SMTP id e205so31644090oif.11
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jan 2023 02:43:28 -0800 (PST)
X-Gm-Message-State: AFqh2koTaXq1yfDmgPqVfPXfymZ41ZuNNN4/AHUbM5JwB+KTaCcHdEjK
        2wI6/k4aj88jS+R3lFtVQGFPYX7sJ+iaIl106yo=
X-Google-Smtp-Source: AMrXdXsd8P6qAzzEpqJ6npenY/pGGWzRfW1kep1HT2LVLFy2V0Im/6VL1ZMzqJZiSvUTi3iXQyMPtVzvi3Qx92EZqQ0=
X-Received: by 2002:a05:6808:1402:b0:35e:ac60:2452 with SMTP id
 w2-20020a056808140200b0035eac602452mr2127460oiv.92.1672915407602; Thu, 05 Jan
 2023 02:43:27 -0800 (PST)
MIME-Version: 1.0
References: <b732e1e7-7b3a-cfa7-1345-d39feaa6a7a8@posteo.de>
 <CAL3q7H72Z7v038psf9rPSjfWn96WDbxpbRx_73HAPvzzV4SB8g@mail.gmail.com> <0ee56d23-9a3d-08ea-a303-e995c99d3f43@posteo.de>
In-Reply-To: <0ee56d23-9a3d-08ea-a303-e995c99d3f43@posteo.de>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 5 Jan 2023 10:42:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4+A1mW5+hrVj-OZT8bGnaOQWCzwWJESquS0-aEu7teKg@mail.gmail.com>
Message-ID: <CAL3q7H4+A1mW5+hrVj-OZT8bGnaOQWCzwWJESquS0-aEu7teKg@mail.gmail.com>
Subject: Re: btrfs send and receive showing errors
To:     =?UTF-8?Q?Randy_N=C3=BCrnberger?= <ranuberger@posteo.de>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 5, 2023 at 10:10 AM Randy N=C3=BCrnberger <ranuberger@posteo.de=
> wrote:
>
> On Wed, Jan 4, 2023 at 14:41, Filipe Manana wrote:
> > On Wed, Jan 4, 2023 at 1:05 PM Randy N=C3=BCrnberger <ranuberger@posteo=
.de> wrote:
> >> Hello,
> >>
> >> I=E2=80=99m in the process of copying a btrfs filesystem (a couple yea=
rs old)
> >> from one disk to another by using btrfs send and receive on all
> >> snapshots. The snapshots were created by a tool every hour on the hour
> >> as one backup measure and automatically removed as they became older.
> >>
> >> I got errors like the following and when I compare the copied snapshot=
s
> >> with the originals, some files are missing:
> >>
> >> ERROR: unlink =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88 failed: No=
 such file or directory
> >> ERROR: link =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88 -> =E2=96=88=
=E2=96=88=E2=96=88=E2=96=88=E2=96=88 failed: No such file or directory
> >> ERROR: utimes =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88 failed: No=
 such file or directory
> >> ERROR: rmdir =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88 failed: No =
such file or directory
> >>
> >> Is this a known bug and how can I help diagnosing and fixing this?
> > So this is a problem caused by the sender issuing commands with outdate=
d paths.
> >
> > First, try doing the send operation again with a 6.1 kernel - there
> > was at least one fix here that may be relevant.
>
> I tried again with the following kernel version and still got the same
> errors:
> Linux arktos 6.1.0-0-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.2-1~exp1
> (2023-01-01) x86_64 GNU/Linux
>
> >
> > To actual debug things, in case it's not working with 6.1:
> >
> > 1) Show how you invoked send and receive. I.e. the full command lines
> > for 'btrfs send ...' and 'btrfs receive ...'
>
> Those are my full command lines:
>
> btrfs send -p /mnt/randy/randy-snapshots/2022-01-29--07-00
> /mnt/randy/randy-snapshots/2022-02-27--10-00 | btrfs receive -vvv
> /mnt/intern/randy-snapshots/ 2>receive-1.txt
>
> btrfs send -p /mnt/randy/randy-snapshots/2022-02-27--10-00
> /mnt/randy/randy-snapshots/2022-03-26--07-00 | btrfs receive -vvv
> /mnt/intern/randy-snapshots/ 2>receive-2.txt
>
> >
> > 2) Provide the whole output of 'btrfs receive' with the -vvv command
> > line option.
> >      This will reveal all path names, but it's necessary to debug thing=
s.
> >      You've hidden path names above, so I suppose that's not acceptable=
 for you.
>
> At least I=E2=80=99m not comfortable sharing the file names on this publi=
c
> mailing list. I carefully tried to extract and redact what may be the
> relevant parts.
>
> The second command line above is the first one that fails with the
> following error: =E2=80=9CERROR: unlink Hase/Fuchs/2022-02-23 Reh.odt fai=
led: No
> such file or directory=E2=80=9D.
>
> This is the directory listing for the snapshot before said file was
> created (this snapshot can be copied without errors):
>
> root@arktos /m/r/randy-snapshots# ls -alh 2022-01-29--07-00/Hase/Fuchs/
> insgesamt 2,6M
> drwxrws--- 1 randy randy  136 19. Dez 2021   ./
> drwxrws--- 1 randy randy  134 24. Nov 2021   ../
> -rw-rw---- 1 randy randy  38K  5. Mai 2021  '2021-05-01 Igel.odt'
> -rw-rw---- 1 randy randy  16K 30. Sep 2021  '2021-09-30 Wolf.odt'
> -rw-rw---- 1 randy randy 2,6M 19. Dez 2021  '2021-12-19 Wildschwein.pdf'
>
> This is the directory listing for the snapshot after the file has been
> created (this snapshot can be copied without errors):
>
> root@arktos /m/r/randy-snapshots# ls -alh 2022-02-27--10-00/Hase/Fuchs/
> insgesamt 2,7M
> drwxrws---  1 randy randy  178 27. Feb 2022   ./
> drwxrws---  1 randy randy  134 24. Nov 2021   ../
> -rw-rw----  1 randy randy  38K  5. Mai 2021  '2021-05-01 Igel.odt'
> -rw-rw----  1 randy randy  16K 30. Sep 2021  '2021-09-30 Wolf.odt'
> -rw-rw----  1 randy randy 2,6M 19. Dez 2021  '2021-12-19 Wildschwein.pdf'
> -rw-rwx---+ 1 randy randy  42K 26. Feb 2022  '2022-02-23 Reh.odt'*
>
> This is the directory listing for the snapshot after the file has been
> edited in LibreOffice and *renamed* (trying to copy this one fails):
>
> root@arktos /m/r/randy-snapshots# ls -alh 2022-03-26--07-00/Hase/Fuchs/
> insgesamt 2,6M
> drwxrws--- 1 randy randy  178  5. M=C3=A4r 2022   ./
> drwxrws--- 1 randy randy  134 24. Nov 2021   ../
> -rw-rw---- 1 randy randy  38K  5. Mai 2021  '2021-05-01 Igel.odt'
> -rw-rw---- 1 randy randy  16K 30. Sep 2021  '2021-09-30 Wolf.odt'
> -rw-rw---- 1 randy randy 2,6M 19. Dez 2021  '2021-12-19 Wildschwein.pdf'
> -rw-rw---- 1 randy randy  18K  4. M=C3=A4r 2022  '2022-03-03 Reh.odt'
>
> I=E2=80=99ve attached the outputs of the commands above. Apparently =E2=
=80=98btrfs send=E2=80=99
> instructs =E2=80=98btrfs receive=E2=80=99 to unlink the file =E2=80=98Has=
e/Fuchs/2022-02-23
> Reh.odt=E2=80=99 which *does* exist in the copied snapshot =E2=80=982022-=
02-27--10-00=E2=80=99
> and this fails for whatever reason.

The reason is very likely because the file was renamed, but the unlink
operation is using the old name (pre-rename name), instead of the new
name.

For the second receive, there should be other operations affecting the
file path Hase/Fuchs/2022-02-23 Reh.odt:

utimes Hase/Fuchs
[=E2=80=A6]
unlink Hase/Fuchs/2022-02-23 Reh.odt
ERROR: unlink Hase/Fuchs/2022-02-23 Reh.odt failed: No such file or directo=
ry

Somewhere in the [...] there must be at least one rename of
Hase/Fuchs/2022-02-23 Reh.odt into something else.
It would be interesting to see more of the receive log to determine if
and why that rename happened.

If this is blocking you right now, you can do a full send of the
snapshot at /mnt/randy/randy-snapshots/2022-03-26--07-00.
That will, almost certainly, succeed. Though it will be slower.

Thanks.


>
> # sha256sum
> /mnt/randy/randy-snapshots/2022-02-27--10-00/Hase/Fuchs/2022-02-23\ Reh.o=
dt
> 09ab560f8e2d79e61d253550eda5f388aceddb1b51792e01e589e86a53cdd226
>
> # sha256sum
> /mnt/intern/randy-snapshots/2022-02-27--10-00/Hase/Fuchs/2022-02-23\
> Reh.odt
> 09ab560f8e2d79e61d253550eda5f388aceddb1b51792e01e589e86a53cdd226
>
> >
> > Thanks.
> >
> >>
> >> # uname -a  # this is the kernel on which this originally happend
> >> Linux arktos 5.10.0-20-amd64 #1 SMP Debian 5.10.158-2 (2022-12-13)
> >> x86_64 GNU/Linux
> >>
> >>
> >> # uname -a  # I already retried everything on the latest Debian
> >> backports kernel with the same results
> >> Linux arktos 6.0.0-0.deb11.6-amd64 #1 SMP PREEMPT_DYNAMIC Debian
> >> 6.0.12-1~bpo11+1 (2022-12-19) x86_64 GNU/Linux
> >>
> >> # btrfs --version
> >> btrfs-progs v5.10.1
> >>
> >> # btrfs fi sh /mnt/randy  # this is the source
> >> Label: none  uuid: 84bba855-578d-48db-80eb-49f1029c7543
> >>           Total devices 2 FS bytes used 2.04TiB
> >>           devid    1 size 4.00TiB used 2.05TiB path /dev/mapper/randy_=
1_crypt
> >>           devid    2 size 4.00TiB used 2.05TiB path /dev/mapper/randy_=
2_crypt
> >>
> >> # btrfs fi df /mnt/randy
> >> Data, RAID1: total=3D2.02TiB, used=3D2.02TiB
> >> System, RAID1: total=3D8.00MiB, used=3D320.00KiB
> >> Metadata, RAID1: total=3D25.00GiB, used=3D22.99GiB
> >> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> >>
> >>
> >> # btrfs fi sh /mnt/intern  # this is the target
> >> Label: none  uuid: ebb94498-644c-42cd-892f-37886173523c
> >>           Total devices 2 FS bytes used 1.91TiB
> >>           devid    1 size 8.00TiB used 1.91TiB path
> >> /dev/mapper/vg_arktos_hdd_b-lv_randy_1
> >>           devid    2 size 8.00TiB used 1.91TiB path
> >> /dev/mapper/vg_arktos_hdd_b-lv_randy_2
> >>
> >> # btrfs fi df /mnt/intern
> >> Data, RAID1: total=3D1.89TiB, used=3D1.89TiB
> >> System, RAID1: total=3D8.00MiB, used=3D288.00KiB
> >> Metadata, RAID1: total=3D21.00GiB, used=3D20.76GiB
> >> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
