Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7200338803
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 12:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfFGKd7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jun 2019 06:33:59 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39223 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfFGKd6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jun 2019 06:33:58 -0400
Received: by mail-vs1-f66.google.com with SMTP id n2so852067vso.6;
        Fri, 07 Jun 2019 03:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=hyTwiK8Lt8BitFEdu+VruB62gkLElbQTumBeMSuP6Yc=;
        b=KiKbC8/vEq/i/fEcQZvxPeSK2VgJ511Qfg9QP6RJRxwMcr5XwOusolelMV8a+0Hhrb
         gVSdBthS4p/iaCX69+7FNtXsK+yF6n1cdEHC4jC4ufUqqeSHuZ6N4lu8JUoA6+gbjj9y
         ToRg1x1hYfc8Ij5w13dKxKYiEgFc90gxtFhuJVoOBhpbW3lYqA/FetjGpz3B4KUB53nL
         qJ2rwxMOmWPeZrCy4uuNsBkM4Z69ZNcq0NuDzrwYEM7C2//m1RkqZGil49pqlzAtWl5M
         PljXwRo9advL5Jr0ZwJ2MX0YVT/MUzh1tIWH52iMzJNgPijX8Q0bfXyh6+h/2dol30fH
         RjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=hyTwiK8Lt8BitFEdu+VruB62gkLElbQTumBeMSuP6Yc=;
        b=e1pT4y7fG/MQl1CrwzqOuhEl331WR6hlueMpBlJlO/NdnuwuIdo3b4wVrByFqkVfv5
         hPPIZjv9Pmv2qlidtheLiVzVwbsK9dkcHE5AV9wZ0bLu31DZW1ct7zT5aduO4mALBfgb
         EW79B+D5BLrRN2cJGPyUwcQ4LFFdHdsn3Xu2kBAR42SAh48BbKxEPNUl/wVfNRz+mMKW
         Q6GmzEXUwf+GIsn8SJTmPVc3kf0bYW/lc6zHSglsfSSbREKvZhsrq8/Q4G+tlRtsOcLZ
         DtYpHNY6SOjvdsi5D76T0ETLg9496Roe3VZFVtUXz0hk8v/6quDvaYX+lS9HtfUjzd5g
         pbZg==
X-Gm-Message-State: APjAAAXTnogvNDU2gR2Jd+BjoJvrV666oUXLEg1Jf9nt+ULYYyDuVB22
        Ge1hSFypnlRZRzuG+zee0g8oHBHcyI7kMvF3xS6usg==
X-Google-Smtp-Source: APXvYqxUHB2xrC5Ts5W52tT3TJQfiuYamSvLSxElekHFK3sfR0DAuk7ZmyS+NcmOxMEKPRYugBulUBhTJ9tWa5QLSJk=
X-Received: by 2002:a67:8b44:: with SMTP id n65mr23921781vsd.99.1559903637689;
 Fri, 07 Jun 2019 03:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190607053910.2127-1-naohiro.aota@wdc.com>
In-Reply-To: <20190607053910.2127-1-naohiro.aota@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 7 Jun 2019 11:33:46 +0100
Message-ID: <CAL3q7H4fvY0rSiOQvbLemX4SOFk4fXgVowKZ62C+yB41QMswwg@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/163: make readahead run on the seed device
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 7, 2019 at 6:39 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> There is a long lived bug that btrfs wait for readahead to finish
> indefinitely when readahead zone is inserted into seed devices.
>
> Current write size to the file "foobar" is too small to run readahead
> before the replacing on seed device. So, increase the write size to
> reproduce the issue.
>
> Following patch fixes it:
>
>         "btrfs: start readahead also in seed devices"
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks!

> ---
> changelog:
> v2:
> - Update the expected output as well.
> ---
>  tests/btrfs/163     | 2 +-
>  tests/btrfs/163.out | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/btrfs/163 b/tests/btrfs/163
> index 8c93e83b970a..24c725afb6b9 100755
> --- a/tests/btrfs/163
> +++ b/tests/btrfs/163
> @@ -50,7 +50,7 @@ create_seed()
>  {
>         _mkfs_dev $dev_seed
>         run_check _mount $dev_seed $SCRATCH_MNT
> -       $XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 256K" $SCRATCH_MNT/foobar=
 >\
> +       $XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 4M" $SCRATCH_MNT/foobar >=
\
>                 /dev/null
>         echo -- gloden --
>         od -x $SCRATCH_MNT/foobar
> diff --git a/tests/btrfs/163.out b/tests/btrfs/163.out
> index 50f46da6df86..91f6f5b6f48a 100644
> --- a/tests/btrfs/163.out
> +++ b/tests/btrfs/163.out
> @@ -2,8 +2,8 @@ QA output created by 163
>  -- gloden --
>  0000000 abab abab abab abab abab abab abab abab
>  *
> -1000000
> +20000000
>  -- sprout --
>  0000000 abab abab abab abab abab abab abab abab
>  *
> -1000000
> +20000000
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
