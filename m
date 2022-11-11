Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7865A6259F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 13:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiKKMCH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 07:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiKKMCC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 07:02:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E6F7879E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 04:02:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B79AB825FC
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 12:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C086BC433D6
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 12:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668168118;
        bh=k5GvxY2HyV1kiCM09tIJHBstXtztp2iGcwG5HowkKso=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZIt835v5wD8ledxQ+LU785cJrDL0+ynenRJr6PvVaj2K1M9rBLtAzScSrCcfW+VhH
         ciY0FArV3+HcLO0Qb55SGQRjg8NkCTauKQmjBDLQwWdjTArpitD/YL1Vg88sw4RIXb
         ue52g93dYnTbzL61tP46/ZAjnJBP7xL1l5XhJ+lU+WTlk/cohdEQplqj00d/6vdSWB
         X7jdDVKPttRUxQvt3qke2I2YB4+iisp4y4zDm9SjDiTrgz4sq1zbREThpWn0AlxQ0O
         RhBOm7jv2eA3NKC4IY1inqPY0aZ4C+iae93lvfw1TeWBYD7Z2SWtz3yxDVrBF9muDv
         OD8wEIH9hdXOg==
Received: by mail-oo1-f44.google.com with SMTP id k12-20020a4ab08c000000b0049e2ab19e04so624252oon.6
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 04:01:58 -0800 (PST)
X-Gm-Message-State: ANoB5pk339m81COWmvsw/OZvlK9YNUEUjbCHyMUzfhh7VsK2H9yfeWUs
        pd5MH19oezzsEc0KPRDRnudt/AMX47hyJ1U/nWM=
X-Google-Smtp-Source: AA0mqf4HK88mmOi1KOGaZaCUaG1k417gI2OxSs+86YY47uGFrw1MK6U/XZlf5Z9+3hgAotB74GPLmFu9SC+Y7f4Rtck=
X-Received: by 2002:a4a:e6d1:0:b0:476:88e6:7216 with SMTP id
 v17-20020a4ae6d1000000b0047688e67216mr665980oot.15.1668168117886; Fri, 11 Nov
 2022 04:01:57 -0800 (PST)
MIME-Version: 1.0
References: <CAEmTpZGRKbzc16fWPvxbr6AfFsQoLmz-Lcg-7OgJOZDboJ+SGQ@mail.gmail.com>
 <CAL3q7H7RmDV2Xe2+Fb11Jr=NqPWQtw9V=En6JR1swS6Ocr5Z-w@mail.gmail.com>
In-Reply-To: <CAL3q7H7RmDV2Xe2+Fb11Jr=NqPWQtw9V=En6JR1swS6Ocr5Z-w@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 11 Nov 2022 12:01:21 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4HyaTy802=YffnboKTEN2KdGmLX3z=g=HfABy2rtZLYQ@mail.gmail.com>
Message-ID: <CAL3q7H4HyaTy802=YffnboKTEN2KdGmLX3z=g=HfABy2rtZLYQ@mail.gmail.com>
Subject: Re: Major bug in BTRFS (syncs are ignored with libaio or io_uring)
To:     =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= 
        <socketpair@gmail.com>
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

On Fri, Oct 28, 2022 at 11:23 AM Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Thu, Oct 27, 2022 at 11:08 PM =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=
=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 <socketpair@gmail.com> wrote:
> >
> > How to reproduce (I tested in kernel 6.1):
> >
> > 2.  mkfs.btrfs over a partition.
> > 3.  mount -o lazytime,noatime
> > 4.  touch file.dat
> > 5.  chattr +C file.dat # turns off compression, checksumming and COW
> > 6.  fallocate -l1G file.dat
> > 7.  # prefill the file with random data
> >     fio -ioengine=3Dpsync                      -name=3Dtest -bs=3D1M
> > -rw=3Dwrite                 -filename=3Dfile.dat
> > 8.  fio -ioengine=3Dpsync    -sync=3D1 -direct=3D1 -name=3Dtest -bs=3D4=
k
> > -rw=3Drandwrite -runtime=3D60 -filename=3Dfile.dat  # Will show, say, 2=
K
> > IOPs
> > 9.  fio -ioengine=3Dio_uring -sync=3D1 -direct=3D1 -name=3Dtest -bs=3D4=
k
> > -rw=3Drandwrite -runtime=3D60 -filename=3Dfile.dat  # Will show, say, 3=
2K
> > IOPs
> > 10. fio -ioengine=3Dlibaio   -sync=3D1 -direct=3D1 -name=3Dtest -bs=3D4=
k
> > -rw=3Drandwrite -runtime=3D60 -filename=3Dfile.dat  # Will show, say, 3=
2K
> > IOPs
> >
> > Steps 9 and 10 show implausible IOPs.
> >
> > This does not happen on, say, Ext4 (all the methods give roughly the sa=
me IOPs).
> >
> > Removing -sync=3D1 on all engines on Ext4 gives immediate return (as
> > expected because everything gets merged and finally written very fast)
> >
> > Adding/Removing -sync=3D1 with io_uring or libaio changes nothing on
> > BTRFS (it's definitely a bug)
>
> I confirm that the syncing is not happening often when using aio
> (either old aio or io_uring).
> I understand why it's happening, so I'll work on a fix for that.

Btw, I forgot to follow up, but the fix is already in Linus' tree:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8184620ae21213d51eaf2e0bd4186baacb928172

It was also backported to the 6.0.8 and 5.15.78 stable releases.

Thanks.

>
> Thanks for the report.
>
> >
> >
> > I consider it's a bug in BTRFS. Very important bug because BTRFS
> > becomes default FS in Fedora server/desktop now. This bug may cause
> > data loss. That's why I set this bug as high priority.
> >
> >
> > *****************
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2117971
> > *****************
> >
> >
> > --
> > Segmentation fault
