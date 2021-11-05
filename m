Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B64446283
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 12:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhKELIE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 07:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhKELID (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 07:08:03 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116F9C061714;
        Fri,  5 Nov 2021 04:05:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id l12so6257655qtx.7;
        Fri, 05 Nov 2021 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=WV8rheWEabSaCm58puU3t35PzgJOIPvvOzljGMfrY54=;
        b=cTldtW8h0Sj8dS90VQR8ApRnDiM8ql2D4/NW+u26FGFljqsQw3hcDhOEWYx3VQARPX
         FtFwva0JWXqo6xBXo1fDGdVgxNNzGCPO7iD7ywcicBVBJO/Nmr8u84zugec6psHxTJgr
         egcgdq4HIGxq4rBYK5nzfCyDVQIbbgrWUMT8lT7QL0A0bq+SHY0fn6PyZlw3nRtrvZ96
         t2AO3wrsuDpkROTIFxgFAH5DRtdJGdoW6k3niG9FbpjDJekN/ScxN2HJQOb7LPvBFkjl
         r4IMxdE7B2moDCp1ip5EIL/QnK59sZaoSoBnEme9rx9cBMCUxR2OICc51mUUsspUmvof
         d5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=WV8rheWEabSaCm58puU3t35PzgJOIPvvOzljGMfrY54=;
        b=eR2d87YJlQk9NpO1jLVqyoapA2iBNpH8KMsZobjtDCnGsbOfqwBSX3pQmHj5QW92xz
         FZKVFxnVa2p5g0SBaj2FJFOlbwndE0MiEQLTyMXqFDDSbUzvHncUsimsypVgtelk94NU
         IWrOc3aiwDCTDLFsPgluTTioTrKnzcWqDBLAO1wgdEuARRGVbUQ1MDyrqk4NcOc5Szqf
         JKVAwT+Zy9bsTL2hZdgx7CHxphrKl2liNzLA7jtvBbm7movr8yFdLL2sgetUfCBCEw2Z
         STETE+Le30EqhrrLs5rlqYJ9T3d0ACTVRTtR/p51ZHOrYGZClsQxlRqWthGFlIjQCV84
         i9Hw==
X-Gm-Message-State: AOAM531E4AX7xgPkBdQWtxvoGzI+apUDvCPiDvQGNcX0NpOx1FmPwwn+
        444AxYjxhteiG4AQa3GNVfdFRnMXu8+vxGYBzks=
X-Google-Smtp-Source: ABdhPJy4OSSUp0rh7Qsn74h4/4x5mviYwwv2Keg+POW71IcPbi8oF5rnG2TlIYZZFPMvPuqY7YSi6ipGuPBEzIoBejg=
X-Received: by 2002:ac8:5f14:: with SMTP id x20mr21299621qta.124.1636110323259;
 Fri, 05 Nov 2021 04:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211104203958.2371523-1-mcgrof@kernel.org>
In-Reply-To: <20211104203958.2371523-1-mcgrof@kernel.org>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 5 Nov 2021 11:04:46 +0000
Message-ID: <CAL3q7H7=eKNTqY70cOfurxBqTetWcjkbTVKieBHQm4+RuJ1-hA@mail.gmail.com>
Subject: Re: [PATCH] common/btrfs: source module file
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 4, 2021 at 8:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> btrfs/249 fails with:
>
> QA output created by 249
> ./common/btrfs: line 425: _require_loadable_fs_module: command not found
> ./common/btrfs: line 432: _reload_fs_module: command not found
> ERROR: not a btrfs filesystem: /media/scratch
>
> Fix this by sourcing common/module in the btrfs common file.

I'm not sure why you get such a failure. Without the relevant
btrfs-progs and btrfs kernel patches, I don't get that error:

$ ./check btrfs/249
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian9 5.15.0-rc7-btrfs-next-103 #1 SMP
PREEMPT Tue Nov 2 12:25:45 WET 2021
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1

btrfs/249 [failed, exit status 1]- output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/249.out.bad)
    --- tests/btrfs/249.out 2021-10-26 11:04:03.879678608 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/249.out.bad
2021-11-05 10:51:53.752113924 +0000
    @@ -1,2 +1,5 @@
     QA output created by 249
    -Silence is golden
    +ERROR: unexpected number of devices: 1 >=3D 1
    +ERROR: if seed device is used, try running this command as root
    +FAILED: btrfs filesystem usage, ret 1. Check btrfs.ko and
btrfs-progs version.
    +(see /home/fdmanana/git/hub/xfstests/results//btrfs/249.full for detai=
ls)
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/249.out
/home/fdmanana/git/hub/xfstests/results//btrfs/249.out.bad'  to see
the entire diff)
Ran: btrfs/249
Failures: btrfs/249
Failed 1 of 1 tests

Maybe Anand, who authored the test, may have an idea.
We do have many other tests that call
_require_btrfs_forget_or_module_loadable(), btrfs/124, 125, 163, 164,
etc. Does it happen with those as well?

Also, in the future please CC linux-btrfs for changes related to btrfs test=
s.

Thanks.

>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  common/btrfs | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index 5d938c19..4dc4f75d 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -2,6 +2,8 @@
>  # Common btrfs specific functions
>  #
>
> +source common/module
> +
>  _btrfs_get_subvolid()
>  {
>         mnt=3D$1
> --
> 2.33.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
