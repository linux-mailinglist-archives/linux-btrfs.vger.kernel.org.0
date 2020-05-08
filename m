Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0012D1CAA5D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 14:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgEHMMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 08:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726627AbgEHMMu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 May 2020 08:12:50 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10027C05BD43
        for <linux-btrfs@vger.kernel.org>; Fri,  8 May 2020 05:12:49 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y185so892986vsy.8
        for <linux-btrfs@vger.kernel.org>; Fri, 08 May 2020 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=aPlIZ0R8LOZrC8Y0uKRSktauzC0rp/zItPKmHA+5GpA=;
        b=c357CVZ2XL5h/+F7ir3avnKZWfrxb7oevyJSCylUN5KOZes5jW1XoALdLA2bah0c3S
         Hj8QgPuob+YW/EEc64Bwi6UJA6mluvetTIeymedbo5JTGn0K1Wq8Z7q4gMWT6RxfZHyX
         mOfmDnq+oPwQwizN28hza6p6wG5UtfV5wlzwBExAOQ6LlJNmzbMhDA9KUSZDh/yoIfpN
         Rig1oeZT/N8SYG4/BA61vxuuKi88XC2xl+WmUYpXb7NwkKLMMm1oOSXDgVyLLr9hO1qp
         WkRKE54v2LU21uHhBg8SirRTdhp5OHZTG2XVcLoWJgQkTV7huRGadx9Z2mg8Tz9dc3Np
         SAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=aPlIZ0R8LOZrC8Y0uKRSktauzC0rp/zItPKmHA+5GpA=;
        b=CCVZlh6Va/u3TfYDf8aYAlMJ7j4Y1DALZm+PWh8X2QJ3CRDno4z5BrsX1kRb/uLY0h
         /x5JWRQyTcIRSEvs9SM6wfTEG42skpHlkhAHNvNpQa03D0+Vx9FPYyCpyB6Oj5Bt656k
         iCd17EQgrGuMPluEZ8/vFZ6mgBnrZu3DxbSF2pVOoY/c0W94KlzoVUfYkS8b2o/KL7zG
         mnqz967Dx38Aqk7DYYzjKAiztf9VO3SfEYauPtRuJY0FGUvBLLSnFMkMUWU+hvlJMfgC
         sc38of88g+VeQLc+lsr3elX7dsCY//jmi/Quq2rj4KMMm1rPsNWkpiCm9Hmc1vCjNCQG
         YkCw==
X-Gm-Message-State: AGi0PubvHHoJ92+0iv4Mn5hXhQus6JqnKYuWIcnIMjNOh74HaJ0BdWGH
        e3Aq3VkHsedOdjqWsrHnNgMoil1H0g3mnAyl5l8=
X-Google-Smtp-Source: APiQypI5nTxNCG0yhiDKXMVG+si3eI35f3MWPurD7GYjXGBXjw4iCduJil/Yr/mjGXphTrdMuP1IH+3gcRLNjAhPgMc=
X-Received: by 2002:a67:d789:: with SMTP id q9mr1560325vsj.206.1588939968087;
 Fri, 08 May 2020 05:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200507201804.1623-1-marcos@mpdesouza.com>
In-Reply-To: <20200507201804.1623-1-marcos@mpdesouza.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 8 May 2020 13:12:37 +0100
Message-ID: <CAL3q7H5PgpmGxPV8MdF_Z_HcxKfqrRYHF_6WtXp+HimipTx8=g@mail.gmail.com>
Subject: Re: [PATCH v1] btrfs: send: Emit file capabilities after chown
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>,
        Filipe David Borba Manana <fdmanana@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 7, 2020 at 9:16 PM Marcos Paulo de Souza
<marcos@mpdesouza.com> wrote:
>
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>
> [PROBLEM]
> Whenever a chown is executed, all capabilities of the file being touched =
are
> lost.  When doing incremental send with a file with capabilities, there i=
s a
> situation where the capability can be lost in the receiving side. The
> sequence of actions bellow shows the problem:
>
> $ mount /dev/sda fs1
> $ mount /dev/sdb fs2
>
> $ touch fs1/foo.bar
> $ setcap cap_sys_nice+ep fs1/foo.bar
> $ btrfs subvol snap -r fs1 fs1/snap_init
> $ btrfs send fs1/snap_init | btrfs receive fs2
>
> $ chgrp adm fs1/foo.bar
> $ setcap cap_sys_nice+ep fs1/foo.bar
>
> $ btrfs subvol snap -r fs1 fs1/snap_complete
> $ btrfs subvol snap -r fs1 fs1/snap_incremental
>
> $ btrfs send fs1/snap_complete | btrfs receive fs2
> $ btrfs send -p fs1/snap_init fs1/snap_incremental | btrfs receive fs2
>
> At this point, only a chown was emitted by "btrfs send" since only the gr=
oup
> was changed. This makes the cap_sys_nice capability to be dropped from
> fs2/snap_incremental/foo.bar
>
> [FIX]
> Only emit capabilities after chown is emitted. The current code
> first checks for xattrs that are new/changed, emits them, and later emit
> the chown. Now, __process_new_xattr skips capabilities, letting only
> finish_inode_if_needed to emit them, if they exist, for the inode being
> processed.
>
> Also, this patch also fixes a longstanding problem that was issuing an xa=
ttr
> _before_ chown. This behavior was being worked around in "btrfs receive"
> side by caching the capability and only applying it after chown. Now,
> xattrs are only emmited _after_ chown, making that hack not needed
> anymore.
>
> Link: https://github.com/kdave/btrfs-progs/issues/202
> Suggested-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  The first version of the patch was an RFC
>
>  Changes from RFC:
>  * Explained about chown + drop capabilities problem in the commit messag=
e (suggested
>    by Filipe and David)
>  * Changed the commit message to show describe the fix (suggested by Fili=
pe)
>  * Skip the xattr in __process_new_xattr if it's a capability, since it'l=
l be
>    handled in finish_inode_if_needed now (suggested by Filipe).
>  * Created function send_capabilities to query if the inode has caps, and=
 if
>    yes, emit them.
>  * Call send_capabilities in finish_inode_if_needed _after_ the needs_cho=
wn
>    check. (suggested by Filipe)
>
>  fs/btrfs/send.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 6b86841315be..4f19965bdd82 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -23,6 +23,7 @@
>  #include "btrfs_inode.h"
>  #include "transaction.h"
>  #include "compression.h"
> +#include "xattr.h"
>
>  /*
>   * Maximum number of references an extent can have in order for us to at=
tempt to
> @@ -4545,6 +4546,10 @@ static int __process_new_xattr(int num, struct btr=
fs_key *di_key,
>         struct fs_path *p;
>         struct posix_acl_xattr_header dummy_acl;
>
> +       /* capabilities are emitted by finish_inode_if_needed */
> +       if (!strncmp(name, XATTR_NAME_CAPS, name_len))
> +               return 0;
> +
>         p =3D fs_path_alloc();
>         if (!p)
>                 return -ENOMEM;
> @@ -5107,6 +5112,66 @@ static int send_extent_data(struct send_ctx *sctx,
>         return 0;
>  }
>
> +/*
> + * Search for a capability xattr related to sctx->cur_ino. If the capabi=
lity if
> + * found, call send_set_xattr function to emit it.
> + *
> + * Return %0 if there isn't a capability, or when the capability was emi=
tted
> + * successfully, or < %0 if an error occurred.
> + */
> +static int send_capabilities(struct send_ctx *sctx)
> +{
> +       struct fs_path *fspath =3D NULL;
> +       struct btrfs_path *path;
> +       struct btrfs_dir_item *di;
> +       struct extent_buffer *leaf;
> +       unsigned long data_ptr;
> +       char *name =3D XATTR_NAME_CAPS;
> +       char *buf =3D NULL;
> +       int buf_len;
> +       int ret =3D 0;
> +
> +       path =3D btrfs_alloc_path();

So, I forgot this: use alloc_path_for_send() instead, we want a path
that uses the commit root. Path allocations in send should always use
that helper.

Thanks.

> +       if (!path)
> +               return -ENOMEM;
> +
> +       di =3D btrfs_lookup_xattr(NULL, sctx->send_root, path, sctx->cur_=
ino,
> +                               name, strlen(name), 0);
> +       if (!di) {
> +               /* there is no xattr for this inode */
> +               goto out;
> +       } else if (IS_ERR(di)) {
> +               ret =3D PTR_ERR(di);
> +               goto out;
> +       }
> +
> +       leaf =3D path->nodes[0];
> +       buf_len =3D btrfs_dir_data_len(leaf, di);
> +
> +       fspath =3D fs_path_alloc();
> +       buf =3D kmalloc(buf_len, GFP_KERNEL);
> +       if (!fspath || !buf) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       ret =3D get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fs=
path);
> +       if (ret < 0)
> +               goto out;
> +
> +       data_ptr =3D (unsigned long)((char *)(di + 1) +
> +                                  btrfs_dir_name_len(leaf, di));
> +       read_extent_buffer(leaf, buf, data_ptr,
> +                          btrfs_dir_data_len(leaf, di));
> +
> +       ret =3D send_set_xattr(sctx, fspath, name, strlen(name), buf, buf=
_len);
> +out:
> +       kfree(buf);
> +       fs_path_free(fspath);
> +       btrfs_free_path(path);
> +       return ret;
> +}
> +
>  static int clone_range(struct send_ctx *sctx,
>                        struct clone_root *clone_root,
>                        const u64 disk_byte,
> @@ -6010,6 +6075,10 @@ static int finish_inode_if_needed(struct send_ctx =
*sctx, int at_end)
>                         goto out;
>         }
>
> +       ret =3D send_capabilities(sctx);
> +       if (ret < 0)
> +               goto out;
> +
>         /*
>          * If other directory inodes depended on our current directory
>          * inode's move/rename, now do their move/rename operations.
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
