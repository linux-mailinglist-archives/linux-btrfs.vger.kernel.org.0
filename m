Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 615CB128233
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 19:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLTS2t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 13:28:49 -0500
Received: from mail-yw1-f45.google.com ([209.85.161.45]:46776 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTS2t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 13:28:49 -0500
Received: by mail-yw1-f45.google.com with SMTP id u139so3878949ywf.13
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 10:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Adw4QW3UPys5D0kUylU67HGmujijTlNQsruMELkhTIY=;
        b=DMo+6AF2hq0tNcoarunmcyc9HWgWsaZe3cTr5DSfrJRX78C0fpJ7+OQn/WcoRhZ2PK
         deVGGAvZxyP7B4x86OH2QYuJHm/mOHmuEMpJhe7gmuJJB4vMEuQjEpLOmsYbhJmCdmyD
         HKXZFieORaIBlmVR5MhNMmbkbVr1zf6SCYhfPWQt3fOTOM1XO3GSEXDB6CLZ5bejTkV/
         i6vegdzKcoDWW+DiciRE0WNgSLbmfL8XmZWutMOWdnD0LO4fE9Z0e8KjULmBW1SbKvmx
         CLuPrY9NLavnsX7xkChPMnbFOTaIkaRBnO28dIwIe3ffCrXlaT0QwDyGKcU92ZJXjujT
         uKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Adw4QW3UPys5D0kUylU67HGmujijTlNQsruMELkhTIY=;
        b=uUtponNwc5DMDWBbCqTKen3kFV/hxSGaGw2iz0BlPW3Vscp8YslpBL0qS/6XhdI1IH
         sP705zdtzXuFY99pbQa3GKt/10fugKcnEorxtnjNa/LVSFlH0hk134wy6SbbCuD8cE1d
         v0SmxFShF76ipj23rFJYV/30JN/2WvoZ0MVgiwqsjVoALsymC6D4Rhpc0opnH0bFsXeA
         5eRM6wJ/hRCWnlvTZkgVYkYcutjp/MxuQ0XF1DjSHKNUXJ37Jwn7LEfqsZx86lErBMgx
         yUyorZ5NlnM0vs3p6mRRloYk2ifJyIfnRy03JddptHeb0Rc79WeqUtrBahh7pUV0aJnG
         1Oww==
X-Gm-Message-State: APjAAAVflk5mgC6n3C9HuvZhfMfTeXMfAkieo7mzZJv9IKMbufY3vaYT
        OMHMPpCXb1nvRZuN+56+qzTzE7nqEeT2793bOD2rnQ==
X-Google-Smtp-Source: APXvYqz3xuXBt9aUUHyBSViokLGLvZ8FBItGl7CVbskBqu2PfLNMsPxRaj0IiehKcFtjjm3EfVncV1Z1dy3fONNYNw0=
X-Received: by 2002:a0d:d2c5:: with SMTP id u188mr11360278ywd.296.1576866527617;
 Fri, 20 Dec 2019 10:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20191220040536.GA1682@schmorp.de> <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de> <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de> <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
 <20191220165008.GA1603@schmorp.de> <45b11982-0847-8e2c-b40f-0c22ed21de2b@georgianit.com>
 <20191220180018.GA6802@schmorp.de>
In-Reply-To: <20191220180018.GA6802@schmorp.de>
From:   Eli V <eliventer@gmail.com>
Date:   Fri, 20 Dec 2019 13:28:36 -0500
Message-ID: <CAJtFHUTgnyd6OSAu3OPmhudLOtZ33ugacJD_478U3FVh7yMtqQ@mail.gmail.com>
Subject: Re: btrfs dev del not transaction protected?
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     Remi Gauvin <remi@georgianit.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In general df will only ever be an approximation on btrfs filesystems
since the different profiles use different amounts of space, and it
does have bugs from time to time. If you untar a mail spool on the
filesystem the metadata usage may shoot way up when only a small
amount of additional data is needed. So on btrfs filesystems I really
just ignore df, and use btrfs filesystem usage -T almost exclusively.
The table format of -T does make it much more readable for an admin.

On Fri, Dec 20, 2019 at 1:02 PM Marc Lehmann <schmorp@schmorp.de> wrote:
>
> On Fri, Dec 20, 2019 at 12:24:05PM -0500, Remi Gauvin <remi@georgianit.com> wrote:
> > You don't need hints, the problem is right here.
> > Your Metadata is Raid 1, (which requires minimum of 2 devices,) Your
>
> Guess I found another bug - three disks with >>3tb free space, but df
> still shows 0 available bytes. Sure I can probably work around it somehow,
> but no, I refuse to accept that this is supposedly a user problem - surely
> btrfs could create more raid1 metadata with _three disks with lots of free
> space_.
>
> doom ~# df /cold1
> Filesystem               Size  Used Avail Use% Mounted on
> /dev/mapper/xmnt-cold15   43T   23T     0 100% /cold1
> doom ~# btrfs dev us /cold1
> /dev/mapper/xmnt-cold15, ID: 1
>    Device size:             9.09TiB
>    Device slack:              0.00B
>    Data,single:             9.07TiB
>    Metadata,RAID1:         25.46GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             1.00MiB
>
> /dev/mapper/xmnt-cold12, ID: 2
>    Device size:             7.28TiB
>    Device slack:              0.00B
>    Data,single:             7.25TiB
>    Metadata,RAID1:         24.46GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             1.00MiB
>
> /dev/mapper/xmnt-cold13, ID: 3
>    Device size:             7.28TiB
>    Device slack:              0.00B
>    Data,single:             4.03TiB
>    Metadata,RAID1:          5.92GiB
>    Unallocated:             3.24TiB
>
> /dev/mapper/xmnt-cold14, ID: 4
>    Device size:             7.28TiB
>    Device slack:              0.00B
>    Unallocated:             7.28TiB
>
> /dev/mapper/xmnt-cold11, ID: 5
>    Device size:             7.28TiB
>    Device slack:              0.00B
>    Unallocated:             7.28TiB
>
> --
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
