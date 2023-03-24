Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5451C6C7780
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 06:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjCXFsb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 01:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCXFsa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 01:48:30 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D9EDBE8;
        Thu, 23 Mar 2023 22:48:29 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-544b959a971so15382787b3.3;
        Thu, 23 Mar 2023 22:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679636908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FN9tLpIuOCCBozESwxpB9zM1g+LcsWUHGjvYlgSKPXc=;
        b=N77NjhqjlQNmIepa3dMY6R0HcoGbaHf7vgpCxAgThWN2wOCQBR6OsHyDtF29Ha29n6
         E4js894OS9vcZLAkbl4cxlXtMkIgr3qqVstDgRW14YdKlXuoVeUa97yiomTuLPGJiL9t
         qoYNCFkFkp6K3G6LB4nOBN9mFpMENKpQgjw3VXU/fsFWgtNoG6L2rGPbNM2EBkBIn481
         iekazKTh+ER0dh/wHnRqS5KjEmqVS5Gfz0RWpKkBNYMSRmONy+l2RlCm5HFIyl7GhQnX
         XYozLQJ8Sq1IuVaZ48AzOQpHpajd7Z4Nx2Srziv28zo58vMDTQ5bATZXf1TQNeQfYLgN
         btjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679636908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FN9tLpIuOCCBozESwxpB9zM1g+LcsWUHGjvYlgSKPXc=;
        b=Yx/z6gPlczpqeLdNc90k/fCo2jj8JKOCA7EPDbkZoFfjCM9CWwVurr+1SSrq95gYJX
         qE12IITYoRJXvRIY/jW6TqslU4TizXznUsG9c8nQwwoysg29dxaeOgbCnMho4WyKyKZt
         CSSX9v4Ab6b1wxdv0LSw1BFHU7q153/JqoZI3NU2fQXviPSXBzEYz1IqCFu5rdhXCCNZ
         jFpCrOGuDEPu64+4YxApTE43xkgPyspWYyVv6Cvf0QGEWUzGDRDAOSpVoB7mp8WIOvBE
         EraDpD3CfAJbpAodc8vJxtx2WMvkVj3o0psMwcqJ2Epyp2ZGeh794t/TvlautJcciy44
         uVRg==
X-Gm-Message-State: AAQBX9fGGWRrD7Y/uV2j1AKFK+F2BH8N9mhMahd5wkyJBbzzock0AP6n
        Tv+Iae/ZOKy92dFU55Sn7MI1mM9329XgJ3KvT9g=
X-Google-Smtp-Source: AKy350Y3jnm/kC+YgzT8Mr2+ZBxZ7fiveRb1fqyqQQEenqI7nxGIohdyXRv5uTsxuJQBE1w0Vk4w3k4pIt7esaojqWw=
X-Received: by 2002:a81:4428:0:b0:52f:184a:da09 with SMTP id
 r40-20020a814428000000b0052f184ada09mr748859ywa.2.1679636908333; Thu, 23 Mar
 2023 22:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230324020838.67149-1-zhanggenjian@kylinos.cn>
 <78422b96-52ed-b48a-27d0-1cfaa89a6608@gmx.com> <20230324022904.GD10580@twin.jikos.cz>
 <CAOd03yQUD1ehcfApW++7buVDOiWzggnvjTzsgiWGqf+pdrL9sA@mail.gmail.com> <fd8bf37e-3481-3607-834b-28805f0b7dc6@suse.com>
In-Reply-To: <fd8bf37e-3481-3607-834b-28805f0b7dc6@suse.com>
From:   genjian zhang <zhanggenjian123@gmail.com>
Date:   Fri, 24 Mar 2023 13:47:19 +0800
Message-ID: <CAOd03ySZ3pX68PTz4b8qufPw7SbxZ-0j4pJXiJft=MLXGggHXA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix uninitialized variable warning
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
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

On Fri, Mar 24, 2023 at 12:24=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2023/3/24 11:05, genjian zhang wrote:
> > On Fri, Mar 24, 2023 at 10:35=E2=80=AFAM David Sterba <dsterba@suse.cz>=
 wrote:
> >>
> >> On Fri, Mar 24, 2023 at 10:24:55AM +0800, Qu Wenruo wrote:
> >>> On 2023/3/24 10:08, Genjian wrote:
> >>>> From: Genjian Zhang <zhanggenjian@kylinos.cn>
> >>>>
> >>>> compiler warning:
> >>>
> >>> Compiler version please.
> >>>
> >>>>
> >>>> ../fs/btrfs/volumes.c: In function =E2=80=98btrfs_init_new_device=E2=
=80=99:
> >>>> ../fs/btrfs/volumes.c:2703:3: error: =E2=80=98seed_devices=E2=80=99 =
may be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >>>>    2703 |   btrfs_setup_sprout(fs_info, seed_devices);
> >>>>         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>
> >>>> ../fs/btrfs/send.c: In function =E2=80=98get_cur_inode_state=E2=80=
=99:
> >>>> ../include/linux/compiler.h:70:32: error: =E2=80=98right_gen=E2=80=
=99 may be used uninitialized in this function [-Werror=3Dmaybe-uninitializ=
ed]
> >>>>      70 |   (__if_trace.miss_hit[1]++,1) :  \
> >>>>         |                                ^
> >>>> ../fs/btrfs/send.c:1878:6: note: =E2=80=98right_gen=E2=80=99 was dec=
lared here
> >>>>    1878 |  u64 right_gen;
> >>>>         |      ^~~~~~~~~
> >>>>
> >>>> Initialize the uninitialized variables.
> >>>>
> >>>> Reported-by: k2ci <kernel-bot@kylinos.cn>
> >>>> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
> >>>> ---
> >>>>    fs/btrfs/send.c    | 2 +-
> >>>>    fs/btrfs/volumes.c | 2 +-
> >>>>    2 files changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> >>>> index e5c963bb873d..af2e153543a5 100644
> >>>> --- a/fs/btrfs/send.c
> >>>> +++ b/fs/btrfs/send.c
> >>>> @@ -1875,7 +1875,7 @@ static int get_cur_inode_state(struct send_ctx=
 *sctx, u64 ino, u64 gen,
> >>>>      int left_ret;
> >>>>      int right_ret;
> >>>>      u64 left_gen;
> >>>> -   u64 right_gen;
> >>>> +   u64 right_gen =3D 0;
> >>>
> >>> IIRC this is not my first time explaining why this is a false alert.
> >>>
> >>> Thus please report your compiler version first.
> >>
> >> This is probably because of the -Wmaybe-uninitialized we enabled, on
> >> some combination of architecture and compiler. While I'm also interest=
ed
> >> in the compiler and version we need to fix the warnings before 6.3 fin=
al.
> >> We'd be gettting the warnings and reports/patches, which is wasting
> >> peoples' time, it's not a big deal to initialize the variables. But
> >> still I also want to know which version reports that.
> >
> > aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 and
> > aarch64-linux-gnu-gcc (7.3.0-20190804.h30.ky10.aarch64 )
>
> Latest GCC 10.x is already 10.3, and 7.x is already 7.5.
>
> Either report to your distro and let them update the toolchain, or find
> a way to make your bot shut up on the false alert.
>
> >
> > Thanks,
> >
> > Genjian.

OK, thank you for your suggestion and reply.
