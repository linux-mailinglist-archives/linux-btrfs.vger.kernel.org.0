Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C997C815E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 11:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjJMJI1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 05:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjJMJIX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 05:08:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BDACE
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 02:08:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55196C433C8
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 09:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697188101;
        bh=lXosuJXgf6cdNXbBaoPeFVZM7wnQ4WnHAroaNo3GQpg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cUGfxieAY5wPl+KQrwPDy6a+IOU9JPkZYLP8Xf/SPSc+6Na+vRnCL+4CbDKhcIcS1
         PsjjgbOwmCk54jf1/GEGAmZYyfsQj8ZnIgIcTjh6LdXhgWgG1av0Mr/BHuMkvtRNYx
         ZBk4VEA4jr+/6HL8eOqvxWsT6TztATo5JxBt54gRi0ksEMhJZ+A7mji1WvDptySAGW
         AYQjOgEag7NcCEiWGE0wkEnG05iYvgAh+S0A+pFLauQvPf5ZJV8q0fKNdGYGmhbQa3
         NuhW1EmdX1bHBaq6NCDy1JxzHCnJlDieXxJmZ47VS+UiTx6rPQ8QtnolktPw1veWhR
         ddsQdB6uCDMSw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1e0ee4e777bso1081025fac.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 02:08:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YzkfkSxuNMCWU65GHRFN5gXxRqOs4v1Qt8j1wesoU7e4BokJ4+c
        3VkKTCyVC0tV+bb5bmBraHJ9NvhZnJU/W9yk0ag=
X-Google-Smtp-Source: AGHT+IEpYlZBIOp75KCbVMMc/gfQgarF10OvdqHrL8Gm6fcT7w8yKW/2Jp1K4y2fXU9M4F4lx53OTLTqISTdNHMM1lw=
X-Received: by 2002:a05:6870:4690:b0:1e9:b0fa:de48 with SMTP id
 a16-20020a056870469000b001e9b0fade48mr5264284oap.47.1697188100642; Fri, 13
 Oct 2023 02:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <ce6f4bd6-9453-4ffe-ba00-cee35495e10f@moroto.mountain>
In-Reply-To: <ce6f4bd6-9453-4ffe-ba00-cee35495e10f@moroto.mountain>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 13 Oct 2023 10:07:44 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6JvA5cQ3zxrZewsNJnk3fgpEG4zHbaKGJrtwnqRPgo7w@mail.gmail.com>
Message-ID: <CAL3q7H6JvA5cQ3zxrZewsNJnk3fgpEG4zHbaKGJrtwnqRPgo7w@mail.gmail.com>
Subject: Re: [bug report] btrfs: new ioctl TREE_SEARCH_V2
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     gerhard@heift.name, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 13, 2023 at 8:52=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Gerhard Heift,
>
> The patch cc68a8a5a433: "btrfs: new ioctl TREE_SEARCH_V2" from Jan
> 30, 2014 (linux-next), leads to the following Smatch static checker
> warning:
>
>         fs/btrfs/ioctl.c:1787 btrfs_ioctl_tree_search_v2()
>         warn: not copying enough bytes for '&uarg->buf_size' (8 vs 4 byte=
s)
>
> fs/btrfs/ioctl.c
>     1760 static noinline int btrfs_ioctl_tree_search_v2(struct inode *ino=
de,
>     1761                                                void __user *argp=
)
>     1762 {
>     1763         struct btrfs_ioctl_search_args_v2 __user *uarg =3D argp;
>     1764         struct btrfs_ioctl_search_args_v2 args;
>     1765         int ret;
>     1766         size_t buf_size;
>     1767         const size_t buf_limit =3D SZ_16M;
>     1768
>     1769         if (!capable(CAP_SYS_ADMIN))
>     1770                 return -EPERM;
>     1771
>     1772         /* copy search header and buffer size */
>     1773         if (copy_from_user(&args, uarg, sizeof(args)))
>     1774                 return -EFAULT;
>     1775
>     1776         buf_size =3D args.buf_size;
>     1777
>     1778         /* limit result size to 16MB */
>     1779         if (buf_size > buf_limit)
>     1780                 buf_size =3D buf_limit;
>     1781
>     1782         ret =3D search_ioctl(inode, &args.key, &buf_size,
>     1783                            (char __user *)(&uarg->buf[0]));
>     1784         if (ret =3D=3D 0 && copy_to_user(&uarg->key, &args.key, =
sizeof(args.key)))
>     1785                 ret =3D -EFAULT;
>     1786         else if (ret =3D=3D -EOVERFLOW &&
> --> 1787                 copy_to_user(&uarg->buf_size, &buf_size, sizeof(=
buf_size)))
>
> uarg->buf_size is a u64 but we are copying sizeof(unsigned long) bytes
> so on 32 bit systems that's not enough.  It probably works fine on
> little endian 32 bit systems, but on big endian 32 bit systems it won't.

Thanks for the report. I've just sent a fix for this:

https://lore.kernel.org/linux-btrfs/44cfbc3f3ee2465d776ce6926c6f1cece251132=
5.1697187887.git.fdmanana@suse.com/

>
>     1788                 ret =3D -EFAULT;
>     1789
>     1790         return ret;
>     1791 }
>
> regards,
> dan carpenter
