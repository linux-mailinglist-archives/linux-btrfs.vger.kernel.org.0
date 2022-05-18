Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E252C328
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 21:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239736AbiERTSJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 15:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiERTSI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 15:18:08 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821FB12B037
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 12:18:07 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e3so3388252ios.6
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYK3KT+TIOeDVO8e9db0qpr35bMImWN0ulhtX1HyGQ0=;
        b=UrT/2hFOpvNWTCzp2+B901dhdfZPmsD38AHWW7jSxaVV+m7NBE2qr3+1L1YN/sE/z2
         PSo7/EWkAEHoWjyBVdFTnf1w5Jog8BR3sSGH5Kf67kCM582mdiB/rx553A/9s14lXslR
         NazpxYrnMOhHGm0pPkkL68GpIGzlnDT6iAAUDzXdaTEVQJyUNHvgFOhIh315PPkEDq2a
         JIJpp+SKf/4nR6RNCZ0wcS0/gVIUgNQeW4277T5F8t5Ru3lslvWt0YdHPZyv90AERxL4
         F0CWQtQI0QjGan8j2WOVq8MVFcQE0tI+XWhDl/Ro1ID0J8zVa4YQzCce3eVOCHsJDZoV
         /PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYK3KT+TIOeDVO8e9db0qpr35bMImWN0ulhtX1HyGQ0=;
        b=dXM+mBC0N67FyWXtoZW7DT/eC5FaZ4VqXbxNPCrnLV804BjExt46yqBnrrmyBKR3Hz
         zmMnKK+8uk2H0N03qUgOUXjeD4IOOukrMXs0GbpXvNIGBeZ7bYz53ZfowFY+kQZdaHY+
         I1n5wvrExqh67gFhaR4i3W1MLZIC53rt8JhA9ad0xUIx3Sq53dhOHQqXV/doBvFhXKiI
         E7Q4cCSKxio98MxVopcwxBeS/cZdKCXV0tI0/aPYHxcs8oDmwPEAJuxZ675noweK1Oez
         n65fhBoJXDBM8KjozfCh9XYadR1+1teRiz3sLyy2+AUcWd0PX3wOzynbzHJenTGOSni6
         jgMg==
X-Gm-Message-State: AOAM533M4EkTESXhgpKE0Yv6wL7Djp2/9wfxiYDFyXlx8nq6KH9te3P4
        qU1ePmuatzJHHjiMwGDBhahrDoiK8gyCn7j3+1ReT6JlHfI=
X-Google-Smtp-Source: ABdhPJwgXy9RJ//GNg9SL/jGBZcOC9lT5L2mbwDr3hwY9lfpSTX6hm8yA/osR0SSiIKIBm6tlFTNjHgHK+pGN6qZNSc=
X-Received: by 2002:a02:a609:0:b0:32e:7865:17f4 with SMTP id
 c9-20020a02a609000000b0032e786517f4mr581559jam.313.1652901486793; Wed, 18 May
 2022 12:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfMbB-sGLZUjGHjxHt1Gga+uULGkoZTqjXHwKnzsjP5aA@mail.gmail.com>
 <20220516151653.GF13006@merlins.org> <20220516153651.GG13006@merlins.org>
 <20220516165327.GD8056@merlins.org> <CAEzrpqfShQhaCVv1GY=JTTCO_T44ggidHFtbSABrcPCSNzY9hA@mail.gmail.com>
 <CAEzrpqdsi63zgudjzbSa3QyMLuE5nD3+t9nOuzXEdWZGCbTcNA@mail.gmail.com>
 <20220517202756.GK8056@merlins.org> <CAEzrpqdgKtSDJj2QekYuS+M77wYrp6bvXv2Ue3xQ8Vm2bGGYAg@mail.gmail.com>
 <20220517212223.GL8056@merlins.org> <CAEzrpqcX3XEQGjoJCV1wARu=Od7vAypmzO4dCFgQ+_UBBuJdMA@mail.gmail.com>
 <20220518191241.GI13006@merlins.org>
In-Reply-To: <20220518191241.GI13006@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 18 May 2022 15:17:55 -0400
Message-ID: <CAEzrpqfPEU9Vt86ykVyxwvDXrihKfGc180oT7SUcQdwtYysquw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 18, 2022 at 3:12 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, May 18, 2022 at 02:26:36PM -0400, Josef Bacik wrote:
> > Hrm crud, I've fixed this, but you may have to re-run the init's.  Start with
> >
> > btrfs check --repair <device>
> >
> > and then see if it works.  If not do
>
> Block group[15360476577792, 1073741824] (flags = 1) didn't find the relative chunk.
> Block group[15361550319616, 1073741824] (flags = 1) didn't find the relative chunk.
> Block group[15362624061440, 1073741824] (flags = 1) didn't find the relative chunk.
> Block group[15363697803264, 1073741824] (flags = 1) didn't find the relative chunk.
> Block group[15364771545088, 1073741824] (flags = 1) didn't find the relative chunk.
> Block group[15365845286912, 1073741824] (flags = 1) didn't find the relative chunk.
> Block group[15366919028736, 1073741824] (flags = 1) didn't find the relative chunk.
> failed to repair damaged filesystem, aborting
>
> Starting repair.
> Opening filesystem to check...
> JOSEF: root 9
> Checking filesystem on /dev/mapper/dshelf1
> UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
>
> > btrfs rescue init-extent-tree <device>
>
> Whatever we did may have caused a bunch of new files to be invalid and have to be deleted.
>
> searching 159785 for bad extents
> processed 11304960 of 108429312 possible bytes, 10%
> Found an extent we don't have a block group for in the file
> file
> Deleting [11142, 108, 1020231680] root 6781246029824 path top 6781246029824 top slot 2 leaf 3861741830144 slot 109
>
> searching 159785 for bad extents
> processed 11304960 of 108429312 possible bytes, 10%
> Found an extent we don't have a block group for in the file
> file
> Deleting [11142, 108, 1020280832] root 6781246046208 path top 6781246046208 top slot 2 leaf 3861741846528 slot 109
>
> searching 159785 for bad extents
> processed 11304960 of 108429312 possible bytes, 10%
> Found an extent we don't have a block group for in the file
> file
> Deleting [11142, 108, 1154498560] root 6781246029824 path top 6781246029824 top slot 2 leaf 3861741830144 slot 109
>
> searching 159785 for bad extents
> processed 11304960 of 108429312 possible bytes, 10%
> Found an extent we don't have a block group for in the file
> file
> Deleting [11142, 108, 1288716288] root 6781246046208 path top 6781246046208 top slot 2 leaf 3861741846528 slot 10
>
> Mmmh, it's deleted 2500 files already, I just stopped it
> gargamel:~# grep -c Deleting /mnt/btrfs_space/ri1
> 2507
>
> Safe to continue?

Yes sorry I meant to say that.  Because we have these dangling block
groups we'll suddenly have a bunch of files that no longer are
mappable and we'll need to delete them.  Looks to be about 7gib of
block groups so you're going to lose that stuff, it's going to be a
while but it's expected.  Thanks,

Josef
