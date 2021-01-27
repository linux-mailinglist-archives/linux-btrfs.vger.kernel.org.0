Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A571D3054DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 08:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhA0Hlh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 02:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhA0Hi6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 02:38:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E8C0613D6
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 23:38:18 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d16so811299wro.11
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 23:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmrk2afGWNjOZgMgi1+zPmSGV6v8qPOMWXdrmeBuZfc=;
        b=bpXtFs+j7WYTkghQ3zSZivYWD6hvLDq5oG5p3pqwo6INTpnrHDvOBy3rnd479y8AXa
         Qtkt98osgsiy8W0Ht6qkl+JoHAafD45Q31iaWzJYWxeoiNjdc2HKg7CXaA5Hq1pnudbC
         GL4gsJN4mxpKyTUFYehW4uu5cXX3hvvn2gO+LW4edXgyL4R2AurbBgcxXItZ3I1X5H6v
         JKyiJRVPs1lK4dNwmFynH1CTc3Dmpz5k0xHQH5+OF9hS6Nra2oBK0UIe7w5nsbIMQ2gR
         bVNlwfhYwumrBCR8nSksnxJ1/DAAH7eCb7XqHrUWpTKWrDUBRNBlhioZfD1MH4t32wO4
         GyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmrk2afGWNjOZgMgi1+zPmSGV6v8qPOMWXdrmeBuZfc=;
        b=DZOolRK/0OW+TPagU3d7TGa1f+mijVf/BzQGscYlmZBtGwFvoPUNWJ+CcU8uqBPtu0
         wQlmmPQfbzTMIXY5sWcvsoxGr7ft/3NVBnAlop4SiKKlc8wkTP4xseY/+u3ne/LpyEUJ
         01+AkLmYQikjVBHl6vAG/rvMBYLGbUjSp8WP/S9JkNRq2V91+A0bcJxhIepVa66qoFz/
         r6ZijpPDyp3d8vLoGFbktXAQHZS5pZZVj9M8nX+ApG5o5vBtggQRDoipfu6HYcMqT4xH
         X+ytwmxJTErItw5JDg/4UBDLepp15stc3Zks9khSEeyFL0EGX4Kw8j9Lu/iIxpUNZC+F
         hi3A==
X-Gm-Message-State: AOAM533Pz+Bc7qFfY/5ckXMz/6qixBw0SdkFbLajntCXPfraTZ/Dducy
        DnlNwkdsHWKFLgDIqkVVxldKrlCBUSEslfHxcJD6AwbTabAVopM6
X-Google-Smtp-Source: ABdhPJxHkmpeCNwOkTLOxC1yxtcmfVIK9yRUcLu8+n7gZpMx0SLxQRD8p9BvDtEqQpbI4aXIdB7yCloOwSJFdAHKZKQ=
X-Received: by 2002:a5d:5105:: with SMTP id s5mr9880294wrt.252.1611733097038;
 Tue, 26 Jan 2021 23:38:17 -0800 (PST)
MIME-Version: 1.0
References: <cf9189c0-614c-26e8-9d3e-8e18555c064f@rqc.ru>
In-Reply-To: <cf9189c0-614c-26e8-9d3e-8e18555c064f@rqc.ru>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 27 Jan 2021 00:38:00 -0700
Message-ID: <CAJCQCtQFniOd53+3FFoOo4UM8CzY_vranrrHiWH86HugNvaOpw@mail.gmail.com>
Subject: Re: btrfs becomes read-only
To:     Alexey Isaev <a.isaev@rqc.ru>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 12:22 AM Alexey Isaev <a.isaev@rqc.ru> wrote:
>
> Hello!
>
> BTRFS volume becomes read-only with this messages in dmesg.
> What can i do to repair btrfs partition?
>
> [Jan25 08:18] BTRFS error (device sdg): parent transid verify failed on
> 52180048330752 wanted 132477 found 132432
> [  +0.007587] BTRFS error (device sdg): parent transid verify failed on
> 52180048330752 wanted 132477 found 132432
> [  +0.000132] BTRFS error (device sdg): qgroup scan failed with -5
>
> [Jan25 19:52] BTRFS error (device sdg): parent transid verify failed on
> 52180048330752 wanted 132477 found 132432
> [  +0.009783] BTRFS error (device sdg): parent transid verify failed on
> 52180048330752 wanted 132477 found 132432
> [  +0.000132] BTRFS: error (device sdg) in __btrfs_cow_block:1176:
> errno=-5 IO failure
> [  +0.000060] BTRFS info (device sdg): forced readonly
> [  +0.000004] BTRFS info (device sdg): failed to delete reference to
> ftrace.h, inode 2986197 parent 2989315
> [  +0.000002] BTRFS: error (device sdg) in __btrfs_unlink_inode:4220:
> errno=-5 IO failure
> [  +0.006071] BTRFS error (device sdg): pending csums is 430080

What kernel version? What drive make/model?

wanted 132477 found 132432 indicates the drive has lost ~45
transactions, that's not good and also weird. There's no crash or any
other errors? A complete dmesg might be more revealing. And also

smartctl -x /dev/sdg
btrfs check --readonly /dev/sdg

After that I suggest
https://btrfs.wiki.kernel.org/index.php/Restore

And try to get any important data out if it's not backed up. You can
try btrfs-find-root to get a listing of roots, most recent to oldest.
Start at the top, and plug that address in as 'btrfs restore -t' and
see if it'll pull anything out. You likely need -i and -v options as
well.

-- 
Chris Murphy
