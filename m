Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92BB302F5D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 23:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbhAYWs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 17:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732530AbhAYWsP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 17:48:15 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED792C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 14:47:34 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c12so14607380wrc.7
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 14:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pXFXlU7e9FNZWc314CzDD4oC3eLzXznJmc7MwxnCyN0=;
        b=iqoFBqFXMSf8+u17+/ShN8xG0rcNmmFThpTvjeCzDvkKBaC/s/rM+W/4+xzoGNcQbv
         KeHclEMwXVJxRCTx0+KIfk5C5HWmKUgvnc8pjMmx6MJseR107kOan4UXg3+gHlWcphXu
         VmA4NLnwlULvG+vtWxGmDRsc1C7oMOxoc8VgvWhvxz1co9y6Dk0XedRR8aoS1IXHgiT1
         YnUEi34ytJCNG0GXuJGy0wo7hTcDCMGd6k7yD6RINkQd2Bm9IoB+oB4Ez6c7OOTVbfut
         E3vDuGA66NLugOj8N+A6w8zwxFEHgxl9pv6B23AlgXPKkQaBETXgoVEbPip0SmIPZvsn
         DKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pXFXlU7e9FNZWc314CzDD4oC3eLzXznJmc7MwxnCyN0=;
        b=NUgPaqnPcMSeCbCtAfDXWfeehDfjoPw6As8+xBPuJKXj7CcSLZMD5pQsv6DSjPxPho
         aGbi6b8gPxXLaNZT+dCRa+PmdyOURbaWbHAXZsctSLaS5aNV5UeE1KHpyppaQe+WbNET
         /eHMt3Ut3t+Lcqtw+gXen3pD25pkzHZSU0iHPk4+G7E2DW63o0nayDrhCSZmJ6tBH09P
         ZooLeo6E9qLFmURNIRMDiP6sGeIx1khEZIDNUxLLqqjf0OzrfoUe18eRdXnhqjdDX8Uz
         tmwEDwiwyPYu2kwjKBb/hWsL4mYUb0Ffo1oVPAadb5CuSr+u/nolQqW4s3evYxW7IdUK
         KB0w==
X-Gm-Message-State: AOAM532Ffs/HGkYGsqj7Ao3aPNGftA9nGnlAIB1MF+JAQY7agsfBMgeK
        QG0EB7iKGyK2iEiSQ6CdIsgOYvkehNE0yGALclT7Gg==
X-Google-Smtp-Source: ABdhPJw3VfO4ip7PsgTDtnX2ak+eKFFaztRB+iibAr9ypgOhkAWbw5veGtJX7qW2uDCNifwAWh3s2O9GMH84L4Nsgg8=
X-Received: by 2002:a5d:414f:: with SMTP id c15mr3214914wrq.42.1611614853718;
 Mon, 25 Jan 2021 14:47:33 -0800 (PST)
MIME-Version: 1.0
References: <b693c33d-ed2e-3749-a8ac-b162e9523abb@gmail.com>
In-Reply-To: <b693c33d-ed2e-3749-a8ac-b162e9523abb@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 25 Jan 2021 15:47:17 -0700
Message-ID: <CAJCQCtSwC--k1agUzBcGgdCZZu426fVoUw-V3m8C4XjeN7yQaA@mail.gmail.com>
Subject: Re: Only one subvolume can be mounted after replace/balance
To:     =?UTF-8?Q?Jakob_Sch=C3=B6ttl?= <jschoett@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 23, 2021 at 7:50 AM Jakob Sch=C3=B6ttl <jschoett@gmail.com> wro=
te:
>
> Hi,
>
> In short:
> When mounting a second subvolume from a pool, I get this error:
> "mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda,
> missing code page or helper program, or other."
> dmesg | grep BTRFS only shows this error:
> info (device sda): disk space caching is enabled
> error (device sda): Remounting read-write after error is not allowed

It went read-only before this because it's confused. You need to
unmount it before it can be mounted rw. In some cases a reboot is
needed.

>
> What happened:
>
> In my RAID1 pool with two disk, I successfully replaced one disk with
>
> btrfs replace start 2 /dev/sdx
>
> After that, I mounted the pool and did

I don't understand this sequence. In order to do a replace, the file
system is already mounted.

>
> btrfs fi show /mnt
>
> which showed WARNINGs about
> "filesystems with multiple block group profiles detected"
> (don't remember exactly)
>
> I thought it is a good idea to do
>
> btrfs balance start /mnt
>
> which finished without errors.

Balance alone does not convert block groups to a new profile. You have
to explicitly select a conversion filter, e.g.

btrfs balance start -dconvert=3Draid1,soft -mconvert=3Draid1,soft /mnt

> Now, I can only mount one (sub)volume of the pool at a time. Others can
> only be mounted read-only. See error messages at top of this mail.
>
> Do you have any idea what happened or how to fix it?
>
> I already tried rescue zero-log and super-recovery which was successful
> but didn't help.

I advise anticipating the confusion will get worse, and take the
opportunity to refresh the backups. That's the top priority, not
fixing the file system.

Next let us know the following:

kernel version
btrfs-progs version
Output from commands:
btrfs fi us /mnt
btrfs check --readonly


--=20
Chris Murphy
