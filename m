Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C978F32E73A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 12:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCEL23 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 06:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhCEL2W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Mar 2021 06:28:22 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C04C061574;
        Fri,  5 Mar 2021 03:28:21 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id a9so1512289qkn.13;
        Fri, 05 Mar 2021 03:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9aYdjFgWqnMMd/pegg29j6uoQFfPwGg5bdGoORGW97k=;
        b=GB8gzeWVGTCxgMSwAIRreiwDrXXiauC4nUTGJm2zsrW++vmdSifqeH6UA3A8sYxw7a
         qwNzgyRKiRnT7CdsjLl1sdhEDbDbsmR45oAc3W3v9bzzGGeS1RoVE1wZTTdgM3x77Rur
         Hn4KfV8Ud/cE/rB7e21Hjzs9eC1xlWAV0mZ/+idwqrO/QboY5aKOOLJbO2OHYWRBRt7g
         oQTotQ6l/CjJzQG6zcjD9YCsU/jdEAXxHokTrRw5x89qX0aVyvwi1WcKNTh57C8Ms3H8
         AznwQje+lwNYAc/O8cx1l6Enl768bqB6dczCL2WWxuWVrMzCgUQGB1m9D+TyjNYFWM1Y
         nC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9aYdjFgWqnMMd/pegg29j6uoQFfPwGg5bdGoORGW97k=;
        b=mpSuH4jwF2AuRzH+sk49+j4nfKC7X+We7I56C1UfqRy+VEGqujdT9yVqmTR+yloQX5
         siUZpFutjXdg6RSES1cEtG8fCpmMC1yGtNEJHsxPLZFRXb4qDM87FGJLOzt8Rf/+OFBr
         ceyPmNWQykfyhPywZsIgVOEtxcNbIvy73exIHHE8ycXhwd6yMwK8fnGR/10qePyUdoLD
         mmtilRGxm/6RHpOnkqVWcOqxt+pWFGnHX7FSRsp3dcNOxORmk9e5cE3N+BFDkNSHe2Fh
         wrSE+qxIBHP/MMqMb4OQweAnUV0mdFdD31vfNNrVd9Jiygd2DdT6Cs47dhOfTmycKpr5
         soVw==
X-Gm-Message-State: AOAM5307iUTNm05pRo+H+XfsPaokotv2/8mUflLMkCpjr5USMt+Rc9I2
        rBTrqNCFxL9F07oRJIsW7K2r7dBgUGIkSaYaMuBaMC4nmjgKAw==
X-Google-Smtp-Source: ABdhPJxQTgXHpK4IuluipdptQkn5JS9gYe5j4hl+eUGYMddrXm+KfLDh1JFV+PJhfe5ALK13m90Do8d4CW0aKMUFBuo=
X-Received: by 2002:a37:ab0f:: with SMTP id u15mr8698366qke.438.1614943701024;
 Fri, 05 Mar 2021 03:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20210305094353.13511-1-baijiaju1990@gmail.com>
In-Reply-To: <20210305094353.13511-1-baijiaju1990@gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 5 Mar 2021 11:28:10 +0000
Message-ID: <CAL3q7H62btgspnDRUvRp7Xv17TPdzUae7JzrHLvaLYpR-N43hA@mail.gmail.com>
Subject: Re: [PATCH] fs: btrfs: fix error return code of btrfs_recover_relocation()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 5, 2021 at 9:46 AM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> When the list of reloc_roots is empty, no error return code of
> btrfs_recover_relocation() is assigned.
> To fix this bug, err is assigned with -ENOENT as error return code.

No, there isn't any such bug.

If there are no reloc roots, it means there's no relocation to resume,
in which case err is already 0 and we therefore return 0.
By setting err to -ENOENT, that will cause a mount failure on any fs
that does not have relocation to resume.

You could have tested this simply by doing:

$ mkfs.btrfs -f /dev/sdc
$ mount /dev/sdc /mnt/sdc
mount: /mnt/sdc: mount(2) system call failed: No such file or directory.

It's always a good idea to test patches, even if we are very
comfortable with the code they are touching...

Thanks.


>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  fs/btrfs/relocation.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 232d5da7b7be..631b672a852f 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3817,8 +3817,10 @@ int btrfs_recover_relocation(struct btrfs_root *ro=
ot)
>         }
>         btrfs_release_path(path);
>
> -       if (list_empty(&reloc_roots))
> +       if (list_empty(&reloc_roots)) {
> +               err =3D -ENOENT;
>                 goto out;
> +       }
>
>         rc =3D alloc_reloc_control(fs_info);
>         if (!rc) {
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
