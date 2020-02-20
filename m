Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88AA9166225
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 17:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBTQSu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 11:18:50 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35404 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgBTQSu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 11:18:50 -0500
Received: by mail-vs1-f68.google.com with SMTP id x123so3031591vsc.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 08:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=RDrQ8iLElvI/5Bz19PfyRbEj8FPZcADNKNGxEAo2CUQ=;
        b=MwVqhXRtyCTIvw5RuS7ZPaeXoyZoZ3ev4XPF92AWBZ1znItyNbj7izD3C5K5YvFXXX
         16/osCBD+CtnYHpmTXsulwDhLKdx8kEx4SYCAUCh/HPSiw0Wl2nfpY8IV/8MzCp7N91w
         BZ+6aUrjx7petm5SGjoHfyCh0B2ZFSRJOsYM0D4iDTWU/losA0Dw9lQoWeLfGHmbvLzA
         RHOB9koYhX91L1BKG91ivQ4jMNdrSRB+6Cvp9hx7gU9jHQsiRnM1AcW+rp2BlcdViPZp
         ecDile314DWXOWRzHxcY1X5AKRz6zH+5Ev9+DO9MXZ8Y1btUeVgDAEFBTQoyDd8LXmkY
         3qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=RDrQ8iLElvI/5Bz19PfyRbEj8FPZcADNKNGxEAo2CUQ=;
        b=YhjO2i8+xtnJ7wPpwhd5kG1PbUtfzvnit17SiKFYTzpAdhu9ngGD9M9Jguhb8+TX4W
         FeiS5tfGQHQFg7cpKfbw4qs+qR6wOCdBmIvSUn/KViDVapapwXDJgNMIt488uJVS9Opm
         zn255YZD60gVRqmnTXPcODB7twiyLJVgvdDmMdIH1j5qqDQEO45hUGMXflKCFDJnNOGX
         DswaFdUOEwephcbxjTbMC+qE06YfDZbKZvF5Ybg/m1vYjH9lwcOQO5xGCHbDM8yHLdKa
         23giMHldrnnkeT498l5F/N+jiyM2niGXwuItbcckDxr0ARS+AesdrsDWgDm64kkVnQ/U
         3kKQ==
X-Gm-Message-State: APjAAAVNNU73aJXzWmlZCInQGfdm37ZxidSTd2yCzyCf3WO0xsMubNp7
        Gk9MKDjQpbqInmXE+icZaAnBmGgm7bLV/PUPedM=
X-Google-Smtp-Source: APXvYqwNcSf8xW3FR60W70BfOwKo9BdUDsJLNrMefQQOGvCMjCbzp9EVuUf8HUOa1Ou/LSmjJh1yLhhCHFu+4qTw5vk=
X-Received: by 2002:a05:6102:535:: with SMTP id m21mr16470189vsa.95.1582215528289;
 Thu, 20 Feb 2020 08:18:48 -0800 (PST)
MIME-Version: 1.0
References: <20200220142947.3880392-1-josef@toxicpanda.com>
In-Reply-To: <20200220142947.3880392-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 20 Feb 2020 16:18:37 +0000
Message-ID: <CAL3q7H6u2TG-AEdkmer=rZDHKVnsF1=cRsUZx4tu+J0RLpsK-Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: clear file extent mapping for punch past i_size
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 20, 2020 at 2:30 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> In my stress testing we were still seeing some hole's with my patches to
> fix missing hole extents.  Turns out we do not fill in holes during hole
> punch if the punch is past i_size.  I incorrectly assumed this was fine,
> because anybody extending would use btrfs_cont_expand, however there is
> a corner that still can give us trouble.  Start with an empty file and
>
> fallocate KEEP_SIZE 1m-2m
>
> We now have a 0 length file, and a hole file extent from 0-1m, and a
> prealloc extent from 1m-2m.  Now
>
> punch 1m-1.5m
>
> Because this is past i_size we have
>
> [HOLE EXTENT][ NOTHING ][PREALLOC]
> [0        1m][1m   1.5m][1.5m  2m]
>
> with an i_size of 0.  Now if we pwrite 0-1.5m we'll increas our i_size
> to 1.5m, but our disk_i_size is still 0 until the ordered extent
> completes.
>
> However if we now immediately truncate 2m on the file we'll just call
> btrfs_cont_expand(inode, 1.5m, 2m), since our old i_size is 1.5m.  If we
> commit the transaction here and crash we'll expose the gap.
>
> To fix this we need to clear the file extent mapping for the range that
> we punched but didn't insert a corresponding file extent for.  This will
> mean the truncate will only get an disk_i_size set to 1m if we crash
> before the finish ordered io happens.
>
> I've written an xfstest to reproduce the problem and validate this fix.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I hit another case, besides the one I reported last week, in my
automated tests during one of these evenings.
This is probably it, but I haven't tried to debug it yet - reusing the
same fsstress seed didn't trigger it, as the test used 20 fsstress
processes (with dm log writes).

Looks good,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
> - Dave, this needs to be folded into "btrfs: use the file extent tree
>   infrastructure" and the changelog needs to be adjusted since I incorrec=
tly
>   point out that we don't need to clear for hole punch.  We definitely ne=
ed to
>   clear for the case that we're punching past i_size as we aren't inserti=
ng hole
>   file extents.
>
>  fs/btrfs/file.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 5cdcdbdd908b..6f6f1805e6fd 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2597,6 +2597,24 @@ int btrfs_punch_hole_range(struct inode *inode, st=
ruct btrfs_path *path,
>                                 btrfs_abort_transaction(trans, ret);
>                                 break;
>                         }
> +               } else if (!clone_info && cur_offset < drop_end) {
> +                       /*
> +                        * We are past the i_size here, but since we didn=
't
> +                        * insert holes we need to clear the mapped area =
so we
> +                        * know to not set disk_i_size in this area until=
 a new
> +                        * file extent is inserted here.
> +                        */
> +                       ret =3D btrfs_inode_clear_file_extent_range(BTRFS=
_I(inode),
> +                                       cur_offset, drop_end - cur_offset=
);
> +                       if (ret) {
> +                               /*
> +                                * We couldn't clear our area, so we coul=
d
> +                                * presumably adjust up and corrupt the f=
s, so
> +                                * we need to abort.
> +                                */
> +                               btrfs_abort_transaction(trans, ret);
> +                               break;
> +                       }
>                 }
>
>                 if (clone_info && drop_end > clone_info->file_offset) {
> @@ -2687,6 +2705,15 @@ int btrfs_punch_hole_range(struct inode *inode, st=
ruct btrfs_path *path,
>                         btrfs_abort_transaction(trans, ret);
>                         goto out_trans;
>                 }
> +       } else if (!clone_info && cur_offset < drop_end) {
> +               /* See the comment in the loop above for the reasoning he=
re. */
> +               ret =3D btrfs_inode_clear_file_extent_range(BTRFS_I(inode=
),
> +                                       cur_offset, drop_end - cur_offset=
);
> +               if (ret) {
> +                       btrfs_abort_transaction(trans, ret);
> +                       goto out_trans;
> +               }
> +
>         }
>         if (clone_info) {
>                 ret =3D btrfs_insert_clone_extent(trans, inode, path, clo=
ne_info,
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
