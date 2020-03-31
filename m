Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E38C4199F63
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 21:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgCaTq1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 15:46:27 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:41599 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgCaTq1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 15:46:27 -0400
Received: by mail-yb1-f177.google.com with SMTP id t10so4301380ybk.8
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Mar 2020 12:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGGQd1OPc/aUE7f1qbTgc+esRBFonqznrvF7/5W5AEM=;
        b=bXkFSg40hwHeXVyDacFyaNNrPVqnnqEcFMIX5O01TcO5a4omlKxMcitRtIw76WbYfL
         17OQZCsvwffWF7kLvoMmnhYy5KT0BZKVlGgqtfGSN7wxKvdEQclKpdJpC/YwBkombazg
         GWNIrndCJoRQANnZ6Nc2tBr1spTQ3ToKuFOEl1mtXegDIutuvmuAH5iXl3q0Z7hOnxgI
         o4DNqPcYwFAqzUzfq+qwEFWJGjn+OxYNVt7vfY0GQDjFNkZThYm/zcCdFcoOaJMEKgSn
         nxzAuuaUN37CWJubXzCf5yawmwhFrql20ZlYcLyAORzoGOnhEF9F2dviqf72ae0QSJpo
         Hj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGGQd1OPc/aUE7f1qbTgc+esRBFonqznrvF7/5W5AEM=;
        b=Z3p2RVUX/pyNDl7WhaDFAxzgtBZAOTHS5TSE85ksQbyIw8KJt850xSoLVnRP4tU7Gl
         pEgVKyOLoLVNgSpanOU2ZymQClAe/HQ37KqOFjgacU28CP6wkQlvpFbl92VV6h09EdkD
         L0zvZ9qwbCguy8VejyYGz8YV6YSBxQg82YJM3mzuTGpRydWWH2kmx/6o1ydjP87PmuUG
         rDwESSd7NtyID7/3m+/6paKaDMhYnr4IvtqPvhDKfMdnGsgBXuGmRMxFU51AiAkTFC+a
         Y5kBHxgHkQq+KOHvpa44cTchxuBndUQFZJXiWWvxAFf6r+5hgsCjy2QnGC+pPetwdbc+
         TPOw==
X-Gm-Message-State: ANhLgQ0KP7QTLzwfsEniI5GMvbtg6aCWM1q6UForDGVHCb8T0LMsnVGv
        eCHKLtB0zZJlFJC5besUmbFCoUM1mSx/7nVXKmY=
X-Google-Smtp-Source: ADFU+vt4Cmc3qdbmM1cTyXIgi84jMisVWdByLNp5vROhZbaqp3uB7KDUYo3z2BSRik6qHM0eWT9x5l/dPdYJTno0DgI=
X-Received: by 2002:a25:4e02:: with SMTP id c2mr30974989ybb.504.1585683984410;
 Tue, 31 Mar 2020 12:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAMnnoULAX9Oc+O3gRbVow54H2p_aAENr8daAtyLR_0wi8Tx7xg@mail.gmail.com>
 <a9b73920-65d5-b973-8578-9659717434b5@gmail.com> <SYBPR01MB38978D6654705941C50AF95E9ECB0@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAJtFHUSjwBKGyjSQfB-aZwsvV=4AcnG+-h5uF_4zmBOESxd=hA@mail.gmail.com>
 <20200331221749.52b10248@natsu> <CAJtFHUQbcVSQw1tQzCKEtHegJT81QzTu9OkCo2bonVpMyryRyQ@mail.gmail.com>
 <20200331224229.1c216ab2@natsu>
In-Reply-To: <20200331224229.1c216ab2@natsu>
From:   Eli V <eliventer@gmail.com>
Date:   Tue, 31 Mar 2020 15:46:13 -0400
Message-ID: <CAJtFHUS8bVgP-bsjsfxBDdY2qdJ+dxschiFicdThGVE1J02J4Q@mail.gmail.com>
Subject: Re: Using Intel Optane to accelerate a BTRFS array? (equivalent of
 ZLOG/SIL for ZFS?)
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Paul Jones <paul@pauljones.id.au>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Victor Hooi <victorhooi@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 31, 2020 at 1:42 PM Roman Mamedov <rm@romanrm.net> wrote:
>
> On Tue, 31 Mar 2020 13:31:19 -0400
> Eli V <eliventer@gmail.com> wrote:
>
> > Yes using lvm cache is an option, and will give you actual caching of
> > the data files as well. However, in my experience it doesn't do much
> > caching of metadata so using it on large filesystems doesn't seem to
> > improve interactive usage much at all, i.e. ls -l, or btrfs filesystem
> > usage etc.
>
> Forgot to mention that in my case (on a large media server) I had great
> results with the described setup, especially noticeable in the mount time.
> Walking large directories in a GUI file manager was more responsive too. Not
> to mention mass deletion of snapshots. LVM cache seemed to know well to avoid
> polluting itself with infrequently accessed sequential-pattern bulk operations
> (i.e. copying or reading back the actual file data) and appeared to cache
> mostly the metadata as it should. For anyone considering this, give it a try,
> and give it at least a few days of normal usage to properly warm up.
>
> --
> With respect,
> Roman

Yes, certainly test it out for yourself. My use case is quite
different, large(>300TB) btrfs filesystems used for rsync & snapshot
backups of proprietary NAS. The coolest thing is, through the wonders
of btrfs and lvm, you can dynamically convert from one configuration
to the other. I don't think even a umount is needed.
