Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711934DCCB1
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbiCQRpo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbiCQRpn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:45:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD3CF3F8C
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:44:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t1so7499851edc.3
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thejof-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xy2XnNEEmoGBL07/AfLf+1AzuiJStrrNdEzOwIFCxsY=;
        b=fHkQwQI0iKI4R46zCbt7EzbRcEdSxT6qhE1ynEPOfTX9V3r+uE/CSkSFnQianiVqn9
         SZqcffb2jaVqWleqYjj3e/iJ1djElRGptnDYL4C/zRPYtsdqSwLf417YdlXHr5ml5yC2
         IyxZzUi28E/VJ7MkCkAYiq0OA+dJMvn+mGE4z1Sn7EVe8JsjChJV9GWyoOeDSFq+6KTO
         V0BvX4i2/CMsmJatb094yzjiPL954A8xpNFzgSmSn9TuKMx75LdbUiT2DqhSFBXyAmja
         GsZZRqbYZ/7MPDivGs4aQnbotC5+H2xMu9XP4+KF5NcRRAdAyflJqdR7tVCePUfx+BQd
         Kb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xy2XnNEEmoGBL07/AfLf+1AzuiJStrrNdEzOwIFCxsY=;
        b=u/SF6zIMvcdX5uhxCJyLcR0l8aUqLeAjvc8ZRH1j9ww4n8/jcAuaxMFyK1DB8S/c1G
         zodCWq/5Q62USltJOYINdI527P//JOxvr7N8DFbWivLGn730Uz19RYzUe2zDu5Uy1WQD
         qo1ymN6hSZdqPUkHWHRnkSbwiT1WkX8qWQ+NYUGIs7B+mz7cVeRHXfGTDle4y9ZA3le/
         8X7h+JWVaDTvkEuNG7LpGOyWQVfUgh/uqUyUgus0XvFzKCVWod9JdK4el+d+TuMB8ubS
         p2LdDK+4Sg+NgA/baIy8RQ9uz3fLolQ2zKDg2H/1nHUq4UYrsBWVyn5zjCabdt5oVHCv
         vKzg==
X-Gm-Message-State: AOAM5339zndMUMmLOLr/4+gMehECCf2XP3nYVmGF2/s7IbDN7jjaDAZM
        9ILbNifDxyG/27f8AuX8vYPhec6ngtYJRUI8WdXxTtSarDZgng==
X-Google-Smtp-Source: ABdhPJxFIJ0nBE9TM2DVH8OVwZzj7l3sEIYw0NV0cKnXYvDyVgsi6KqWK6GqKqijzn8NtQm7RcE/nWdoKRHydiRqqls=
X-Received: by 2002:a05:6402:151a:b0:416:187f:bf8d with SMTP id
 f26-20020a056402151a00b00416187fbf8dmr5730282edw.126.1647539064570; Thu, 17
 Mar 2022 10:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <fe7dcb58ac812fb6c37a92a1f74a42890c8c0bc8.1647493897.git.jof@thejof.com>
 <e23301f7-5d5f-0a9c-7ae5-e9b521ef8b2b@suse.com>
In-Reply-To: <e23301f7-5d5f-0a9c-7ae5-e9b521ef8b2b@suse.com>
From:   Jonathan Lassoff <jof@thejof.com>
Date:   Thu, 17 Mar 2022 17:44:13 +0000
Message-ID: <CAHsqw9tO8t7tjpiqrh0+9eC2kLt8AusvJTkw=LGeR6DQq4OyAA@mail.gmail.com>
Subject: Re: [PATCH v0 0/1] Add Btrfs messages to printk index
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Oops -- that was indeed a mistake; CONFIG_PRINTK should have really
been CONFIG_PRINTK_INDEX.

I will follow up with a PATCH v1.

--j

On Thu, 17 Mar 2022 at 07:20, Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 17.03.22 =D0=B3. 7:13 =D1=87., Jonathan Lassoff wrote:
> > In order for end users to quickly react to new issues that come up in
> > production, it is proving useful to leverage this printk indexing syste=
m. This
> > printk index enables kernel developers to use calls to printk() with ch=
angable
> > ad-hoc format strings, while still enabling end users to detect changes=
 and
> > develop a semi-stable interface for detecting and parsing these message=
s.
> >
> > So that detailed Btrfs messages are captured by this printk index, this=
 patch
> > wraps btrfs_printk and btrfs_handle_fs_error with macros.
> >
> > Signed-off-by: Jonathan Lassoff <jof@thejof.com>
> > ---
> >   fs/btrfs/ctree.h | 28 ++++++++++++++++++++++++++--
> >   fs/btrfs/super.c |  6 +++---
> >   2 files changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index ebb2d109e8bb..cc768f71d0a5 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -3344,9 +3344,22 @@ void btrfs_no_printk(const struct btrfs_fs_info =
*fs_info, const char *fmt, ...)
> >   }
> >
> >   #ifdef CONFIG_PRINTK
> > +#define btrfs_printk(fs_info, fmt, args...)                          \
> > +do {                                                                 \
> > +     printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt); =
\
> > +     _btrfs_printk(fs_info, fmt, ##args);                             =
\
> > +} while (0)
> >   __printf(2, 3)
> >   __cold
> > -void btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt=
, ...);
> > +void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fm=
t, ...);
> > +#elif defined(CONFIG_PRINTK)
>
> But you already checked for #idef CONFIG_PRINTK ? In case CONFIG_PRINTK
> is not defined we'll call btrfs_no_printk as btrfs_printk would be
> compiled-out. So what's your intention here?
>
> > +#define btrfs_printk(fs_info, fmt, args...)                          \
> > +do {                                                                 \
> > +     _btrfs_printk(fs_info, fmt, ##args);                             =
\
> > +} while (0)
> > +__printf(2, 3)
> > +__cold
> > +void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fm=
t, ...);
> >   #else
> >   #define btrfs_printk(fs_info, fmt, args...) \
> >       btrfs_no_printk(fs_info, fmt, ##args)
> > @@ -3598,11 +3611,22 @@ do {                                           =
               \
> >                                 __LINE__, (errno));           \
> >   } while (0)
> >
>
>
> <snip>
