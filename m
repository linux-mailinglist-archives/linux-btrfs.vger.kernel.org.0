Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8943B66B8A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2019 13:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfGLLYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jul 2019 07:24:50 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44623 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfGLLYu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jul 2019 07:24:50 -0400
Received: by mail-ua1-f67.google.com with SMTP id 8so3850094uaz.11
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jul 2019 04:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=k1KtQT15Ho3wXzMcUSafod6ENz6sZuqwVNENbO1Cx0Q=;
        b=eXd2BKu1I79+LiVJSmso4ZdqYRIUlWiWIlPDBRDvmaikVf8o2nrsagSEg4KpeO1uI0
         CJ2GD9lCpMfYRVoW8D2nzOaGYbwKZ5M0NhZ7TrGS5j/ECM1QW2A/HrD0jYXo7FJKpM5/
         /LCAaa/LNsQyLKH5OkVsKEQRAiI383R5ZT3yI9pIwInRVyuquvcV81LPvNJPZOW5tJaZ
         nu9Lcx7P7hBeF4W7EEg3y11G16uTYxnPHzIHMbMavN6e8FXUwJMTB/SWCcdFB/bk89Bj
         UgZxgmwcFMVyNbZ4atQJZDClTJok4eZFJgRN8fJti0t2CLPryY2LZgZjQrYWpX7YFBNX
         HR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=k1KtQT15Ho3wXzMcUSafod6ENz6sZuqwVNENbO1Cx0Q=;
        b=ReeWipvDHDdU+OqZqlK4p6lTaCftLhd+q64tofa+eQWa47e5pFrPLXtCfTs876N84L
         F8RXSbyDDZ4mHWHipI4w+wPfYxNICm+wr3MhMzmSvqmV0gt8t5P1wgm5JD1tL42zWpYR
         k00EmAwcIwq5iUGoN3xYU7a/k8a8J7C8HbRwex9Hh9UZM3s9/T6gZfU+VYc1jJtQ+OUA
         zrpFgTYnINFFED/cVuhWr+yh81bq05XlZaAO2p42kxAEnjSVzKeOwgStN5l0wBv8M3Ck
         WOPwHVRMf0t8A5Hiq9lct0NOCPEqJ+1CXZxzPmN7Sb5wWIrT3Hgb83q0SSnkUgmMFtXB
         Ky+g==
X-Gm-Message-State: APjAAAUHjNFB/l1GekjZAwO+Z7pNmzG6dCuSfM6xHWNui5nfG92+ZI2U
        Cx8MCuSUh/CLGQbwzl0JFDprswRKp98uso0yAb6Lmg==
X-Google-Smtp-Source: APXvYqyc8Y/HfFbKOabzqyFuie+Y58Q19ZNnoDjpJQ/Dt2GRbwLuRd7OmCubkrBoQ4jRhFqRjBkddSJnNp69MVn2cmE=
X-Received: by 2002:ab0:2a49:: with SMTP id p9mr8392430uar.0.1562930688967;
 Fri, 12 Jul 2019 04:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190523115126.10532-1-nborisov@suse.com>
In-Reply-To: <20190523115126.10532-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 12 Jul 2019 12:24:38 +0100
Message-ID: <CAL3q7H6tfGOLXty-zTRvztMfkQmxHeWA7vrGQzFFieh02PCCBg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Remove unnecessary check from join_running_log_trans
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 23, 2019 at 12:53 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
> join_running_log_trans checks btrfs_root::log_root outside of
> btrfs_root::log_mutex to avoid contention on the mutex. Turns out this
> check is not necessary because the two callers of join_running_log_trans
> (both of which deal with removing entries from the tree-log during
> unlink) explicitly check whether the respective inode has been logged in
> the current transaction. If it hasn't then it won't have any items in
> the tree-log and call path will return before calling
> join_running_log_trans. If the check passes, however, then it's
> guaranteed that btrfs_root::log_root is set because the inode is logged.
>
> Those guarantees allows us to remove the speculative as well as the
> implicity and tricky memory barrier. No functionl changes.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>
> I have evaluated if there is any performance impact (there isn't one). He=
re's
> the script used:
>
> for i in {1..10}; do
>         echo "Testun run : $i"
>         time ./ltp/fsstress -d /media/scratch/ -p5 -n 100000 -z -fcreat=
=3D100 -f write=3D100 -f fsync=3D70 -f unlink=3D80
>         rm -rf /media/scratch/*
>         echo "Executions of join_running_trans : $(trace-cmd show | wc -l=
)"
>         trace-cmd clear
> done
>
> And the result :
>
>                         Unpatched (Sys)  Unpatched (Real)  Unpatched (JRT=
 exec)    Patched (Sys)  Patched(Real)  Patched (JRT exec)
>                         161              387               153215        =
          183                   393             149153
>                         165              392               158490        =
          159                   404             158118
>                         140              381               147707        =
          145                   373             145676
>                         143              394               147129        =
          148                   383             131029
>                         206              410               157987        =
          152                   383             136134
>                         152              376               157771        =
          143                   387             131048
>                         140              371               153929        =
          146                   376             149885
>                         149              376               152723        =
          207                   407             147477
>                         164              396               157385        =
          160                   393             155272
>                         146              373               147937        =
          148                   384             152828
>
> stddev     19.75             12.44             4525                    20=
.5                  11.06           9722
> mean       156.6             385.6             153427.3                15=
9.1                 388.3           145662
> median     150.5             384               153572                  15=
0                   385.5           148315
>
>
> JRT exec means executions of join_running_transaction during that iterati=
on of
> the test case.
>
>  fs/btrfs/tree-log.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 6c47f6ed3e94..6c8aff105b0c 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -188,10 +188,6 @@ static int join_running_log_trans(struct btrfs_root =
*root)
>  {
>         int ret =3D -ENOENT;
>
> -       smp_mb();
> -       if (!root->log_root)
> -               return -ENOENT;
> -
>         mutex_lock(&root->log_mutex);
>         if (root->log_root) {
>                 ret =3D 0;
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
