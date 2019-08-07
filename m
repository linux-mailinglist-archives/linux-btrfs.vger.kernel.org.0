Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D37847D3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 10:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbfHGIop (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 04:44:45 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34283 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387641AbfHGIop (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Aug 2019 04:44:45 -0400
Received: by mail-ua1-f68.google.com with SMTP id c4so7916559uad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2019 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=blaTqv8ekJWAknF8JxXYVcD0nfITfucImd2gFN+IhHM=;
        b=kWmBJujYvAsy2p9Hu5YiRG5/5xWZA+HilyXVbHirM4fYXCNcZC19jgxYOstw1hS5Ef
         l3VJzmn5WZU6gwMLlI18MwmkhvPw/Ixz+diDzBavze/M/Dj8LZq1METmLoD28LbpdX0Q
         nVr2IcZMrC9X7kskxOVl6mZBA8Qq62ur6w776cwcWyj5cKDmGL1g8Ri+4oLBpl8eG0f1
         l1e74MlINdvEmAq4HTaA3XkVSQf7HE56te+/R/KtraU19xu4fowPnImmMpJ/9/R7tIyH
         EMoEWbQ08LaQ3BMp5Un17rOXf/+Tl9ewnB2ldDcrBcGRjUQyCECfnfgCQRcRX1nvuM1+
         DRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=blaTqv8ekJWAknF8JxXYVcD0nfITfucImd2gFN+IhHM=;
        b=hCfiqm5g/G7XPz9cNtKmrKzfFBJa7V1i++9ceUv2FkygdJQTMsU/rqu+q9p9aFqZI0
         QEehH1Hm5oYZE4nFFXQF/mdZY4Wtn42lGJS3K8jXFMOAciustO05fEHkR4g8pw90kopI
         zWEJcmiVgTBSYUxWc3uz68KZj/GR7Io22TsrIh6MXodqErX1xT+YZ+usMZqRWP6KpW6S
         xCwbBWNIq4r3pP9sPcOP4bOyo4HOFF4ocprSp8dd6PddqIBxsQgrM5evlq/NhLdYoFBD
         i4xXwqtPkEia3ttTHf7rWMCfmBxQCVB1G/mfL4V8eux4O2cWFWXw55mfS+07yIiAmUgT
         OGkg==
X-Gm-Message-State: APjAAAVlj/lAeelEaVnUSg114c3yZmG4/AM55P7a2d1ZHT2gf6dHTTiP
        XFSR1Vo02Wcpp9hHFtOCWNtjGovbR9I4j1OA4SE2fA==
X-Google-Smtp-Source: APXvYqyzJz5dH7vsbnlNLxNM8HskIsqLanZ7BXIv0RSm8XLq5IdANA7E+w9CEBlH4Ob2wbbbxHODYNalkvKbaQ8LuvU=
X-Received: by 2002:ab0:4a6:: with SMTP id 35mr5092488uaw.123.1565167484541;
 Wed, 07 Aug 2019 01:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190807082054.1922-1-anand.jain@oracle.com>
In-Reply-To: <20190807082054.1922-1-anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 7 Aug 2019 09:44:33 +0100
Message-ID: <CAL3q7H7WRPuFNh3+534kF7SgLe0NmQAwCejfW9DJgasXfkQ1qQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: trim: fix range start validity check
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 7, 2019 at 9:35 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> Commit 6ba9fc8e628b (btrfs: Ensure btrfs_trim_fs can trim the whole
> filesystem) makes sure we always trim starting from the first block group=
.
> However it also removed the range.start validity check which is set in th=
e
> context of the user, where its range is from 0 to maximum of filesystem
> totalbytes and so we have to check its validity in the kernel.
>
> Also as in the fstrim(8) [1] the kernel layers may modify the trim range.
>
> [1]
> Further, the kernel block layer reserves the right to adjust the discard
> ranges to fit raid stripe geometry, non-trim capable devices in a LVM
> setup, etc. These reductions would not be reflected in fstrim_range.len
> (the --length option).
>
> This patch undos the deleted range::start validity check.
>
> Fixes: 6ba9fc8e628b (btrfs: Ensure btrfs_trim_fs can trim the whole files=
ystem)
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   With this patch fstests generic/260 is successful now.
>
>  fs/btrfs/ioctl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index b431f7877e88..9345fcdf80c7 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -521,6 +521,8 @@ static noinline int btrfs_ioctl_fitrim(struct file *f=
ile, void __user *arg)
>                 return -EOPNOTSUPP;
>         if (copy_from_user(&range, arg, sizeof(range)))
>                 return -EFAULT;
> +       if (range.start > btrfs_super_total_bytes(fs_info->super_copy))
> +               return -EINVAL;

This makes it impossible to trim block groups that start at an offset
greater then the super_total_bytes values. In fact, in extreme cases
it's possible all block groups start at offsets larger then
super_total_bytes.
Have you considered that, or am I missing something?

The change log is also vague to me, doesn't explain why you are
re-adding that check.

Thanks.

>
>         /*
>          * NOTE: Don't truncate the range using super->total_bytes.  Byte=
nr of
> --
> 2.21.0 (Apple Git-120)
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
