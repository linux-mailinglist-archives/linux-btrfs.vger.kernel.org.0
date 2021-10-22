Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DA843792A
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 16:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhJVOpe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhJVOpd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 10:45:33 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97CEC061764
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Oct 2021 07:43:15 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a13so4692173qkg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Oct 2021 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XcGboyM56x61JohqlRg1HiFCkTEJRyG2MEagnMKzXmQ=;
        b=h5mIbW2313j2o+n80qRKEDRNNs65HYzMqU4fFdnz+kErhtlz1G8nuwNk+SDXix0WVH
         kDTdyePHNxkDMgYQ9UX//8AyZD+0OsXju+QjBmKSX6tqvQRrgTFhmjdpcq4BYxM9b2na
         Rm5FdNfvyC+X8kjmpFuUpa1Rdeuqtp2TsFSpa/9NlQ8i2/uDfnsnIZ2ZnqfZcFbed9PS
         9SlXO4bMsBViJuLYJsyqMsbKz+Cttdbg029LdMyCW9IXYAWvLieHNtFgf2GPvoaXpyz+
         F2mZ1247prtE2Wu/h5FW81VjvOJLVd3Wb/G2itF3fmFL6PbtcgB+3cf9A+zaO1i7jd13
         APqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=XcGboyM56x61JohqlRg1HiFCkTEJRyG2MEagnMKzXmQ=;
        b=kVgLsQSM5w2jKG42N+O/69r4I4v3OJAHklf22ZXHPFpNr6I4AC6U2xgiqFa6p3trGz
         L580w1GgGo2GV2MbFsHC2xZBITY5K55LqMxLRXCL/nfEIVWURBcdTosep6lCJMh20Zdl
         miccNwKIU3FPuan9TdRdsPwuesBjgz4PRpi27X7Fq+j2niwzdC5CZGWFH/HmSuUUtUo0
         yoZ5iWOjqBD9OghSzSmuxvra+PLQQBy/qr9Ifbsk/3sP1Ws2B8srrVG/mnkDPlfJZcOV
         diLkpgwwT7rzWYziXLrBCuZnsc3YhppyxeHvPPiYazkCmavDXThmSGRaRRAB5mYGyyAH
         hgcA==
X-Gm-Message-State: AOAM533E2csRvAV73EwWKbe08aQF6VbAzBL1b2bSZMi+S15dci56Q1ei
        APLJ/5IEZwFuxDIzYhw6EoJ/ZC+mRM3gtASL2cQ=
X-Google-Smtp-Source: ABdhPJwn20qeCDwIe0L3WkAhfwt5N1ZZM61PMiHqaPwyCY1GgQ6ouaNcj7pUoWex0FnexIX5ExqrznioHt7FFYbSrZE=
X-Received: by 2002:a37:458:: with SMTP id 85mr375867qke.39.1634913794456;
 Fri, 22 Oct 2021 07:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211022130742.7119.409509F4@e16-tech.com> <20211022082637.50880-1-wangyugui@e16-tech.com>
In-Reply-To: <20211022082637.50880-1-wangyugui@e16-tech.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 22 Oct 2021 15:42:38 +0100
Message-ID: <CAL3q7H6dcHrAX4nfxk5Kvv3QLP=vEa0OkUknwKTO9gfo6C8yAg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix CHECK_INTEGRITY warning when !QUEUE_FLAG_WC
To:     wangyugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, l@damenly.su
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 22, 2021 at 9:29 AM wangyugui <wangyugui@e16-tech.com> wrote:
>
> xfstest/btrfs/220 tigger a check-integrity warning when
> 1) CONFIG_BTRFS_FS_CHECK_INTEGRITY=3Dy
> 2) xfstest/btrfs/220 run on a disk with WCE=3D1
>
> In write_dev_flush(), submit_bio(REQ_SYNC | REQ_PREFLUSH) can be skipped =
when
> !QUEUE_FLAG_WC. but btrfsic_submit_bio() !=3D submit_bio() when CONFIG_BT=
RFS_FS_CHECK_INTEGRITY

The change log is a bit confusing, something more detailed like this
would be better:

When a disk has write caching disabled, we skip submission of a bio
with flush and sync requests before
writing the superblock, since it's not needed. However when the
integrity checker is enabled, this results in
reports that there are metadata blocks referred by a superblock that
were not properly flushed. So don't
skip the bio submission only when the integrity checker is enabled for
the sake of simplicity, since this is
a debug tool and not meant for use in non-debug builds.

Btw, the line length of a changelog should not exceed 75 characters.

For reference, you could also paste the warning you got in the change
log, it makes it easier
to grep for fixes for example.

>
> Signed-off-by: wangyugui <wangyugui@e16-tech.com>
> ---
>  fs/btrfs/disk-io.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 355ea88..7b17357 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3971,8 +3971,14 @@ static void write_dev_flush(struct btrfs_device *d=
evice)
>         struct request_queue *q =3D bdev_get_queue(device->bdev);
>         struct bio *bio =3D device->flush_bio;
>
> +       #ifndef CONFIG_BTRFS_FS_CHECK_INTEGRITY
> +       /*
> +       * submit_bio(REQ_SYNC | REQ_PREFLUSH) can be skipped when !QUEUE_=
FLAG_WC.
> +       * but btrfsic_submit_bio() !=3D submit_bio() when CONFIG_BTRFS_FS=
_CHECK_INTEGRITY
> +       */

The comment could use the same type of improvement as well.

>         if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
>                 return;
> +       #endif

As for the code itself, it looks good.

Thanks.

>
>         bio_reset(bio);
>         bio->bi_end_io =3D btrfs_end_empty_barrier;
> --
> 2.32.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
