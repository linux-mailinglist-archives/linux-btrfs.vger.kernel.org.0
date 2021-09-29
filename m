Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC1E41C199
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 11:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbhI2J3l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhI2J3k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 05:29:40 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5FFC06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 02:28:00 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 138so1624909qko.10
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 02:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=H4Hg3+X4WIj8SrcGXM88OK80TNy4VcQw4T25k8sZWeE=;
        b=AXvKKdyo1E81jCPULT7wLBuuyf3xz6zRoP9C/lQuhRIgqQNbaLqNVHGZVNXJ4UCboS
         crDrZ/wWru3+favXMqY+tPy1vRdJ2iKfS3mLYBBPUX8FJwGVmPIn3vtYSLOkCTloybeX
         Mo+8BqLEWPSOo1NitDF5ZwVfvPk+JT35mNurpLFaazez7iUZja91vZa2m6n1yojCbtrX
         wytzCOiBlNbnOyRwaELxw2yFdKc0fiqNIKmG22mc+iSeSWmbYkgE+yp+RLVvJJdZ9oj6
         ppDRDvW3UCenGmA/DRyP8B3LmkGh+oo+ySe/gWkIk/D137AN2txBd/MlTX3uN1YOZ8YI
         P6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=H4Hg3+X4WIj8SrcGXM88OK80TNy4VcQw4T25k8sZWeE=;
        b=TmLLzrCETVtUGlqpWKh1fPwZSOPGROtcQAwoyrB6RocvOlhxyaFuwePZ+z1596I2AZ
         5GR3JPkSDAgt5aiDgFRqHCp5ncEFmeWPleaprqewz7MInm1/CzJLSA4gaWvhHmsNobOG
         L1ZfpJXq4egDauil0M88Bii7KRpNIY7R/rFzB1T39QhrXn6kliGaCzvBRU5+l01IK6/n
         oGMdpY7N5nfdcZFChsaEXgN/lauQPkZd/xJtYq4S5wbji3WiOOJRZIfVHvGtyt9sgo6d
         YAorjJNmDZ2h6LLM8mTmlXqjtfbBqT9vAyiIIRM4dHSt8yWeEqoTzguTjZ50zJxKW/Zv
         0lQw==
X-Gm-Message-State: AOAM533GWMjSMGx5t5AT4iHIScznEJTmuJ9AmquGqyUQLHv3V4JBCKxr
        L3b+c3zf7J74cK6+2YYUm+6qC1O/oBaCA+FWCcm/t3+3
X-Google-Smtp-Source: ABdhPJzqQ6FLciPRzunXFGYmPYZjcz861rrSjFUSIYarf6wloF8+/BOrPJOZdFTFIjgqXsH31O+F6IWLob58cdNMz6M=
X-Received: by 2002:a05:620a:2844:: with SMTP id h4mr4401761qkp.388.1632907679155;
 Wed, 29 Sep 2021 02:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210928235159.9440-1-wqu@suse.com>
In-Reply-To: <20210928235159.9440-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 29 Sep 2021 10:27:23 +0100
Message-ID: <CAL3q7H4OqEpAEWhGUH4okvOedhdK0dChYHdJkYrv-1vsAqKAow@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs-progs: receive: fallback to buffered copy if
 clone failed
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 29, 2021 at 12:55 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There are two every basic send streams:
> (a/m/ctime and uuid omitted)
>
>   Stream 1: (Parent subvolume)
>   subvol   ./parent_subv           transid=3D8
>   chown    ./parent_subv/          gid=3D0 uid=3D0
>   chmod    ./parent_subv/          mode=3D755
>   utimes   ./parent_subv/
>   mkfile   ./parent_subv/o257-7-0
>   rename   ./parent_subv/o257-7-0  dest=3D./parent_subv/source
>   utimes   ./parent_subv/
>   write    ./parent_subv/source    offset=3D0 len=3D16384
>   chown    ./parent_subv/source    gid=3D0 uid=3D0
>   chmod    ./parent_subv/source    mode=3D600
>   utimes   ./parent_subv/source
>
>   Stream 2: (snapshot and clone)
>   snapshot ./dest_subv             transid=3D14 parent_transid=3D10
>   utimes   ./dest_subv/
>   mkfile   ./dest_subv/o258-14-0
>   rename   ./dest_subv/o258-14-0   dest=3D./dest_subv/reflink
>   utimes   ./dest_subv/
>   clone    ./dest_subv/reflink     offset=3D0 len=3D16384 from=3D./dest_s=
ubv/source clone_offset=3D0
>   chown    ./dest_subv/reflink     gid=3D0 uid=3D0
>   chmod    ./dest_subv/reflink     mode=3D600
>   utimes   ./dest_subv/reflink
>
> But if we receive the first stream with default mount options, then
> remount to nodatasum, and try to receive the second stream, it will fail:
>
>  # mount /mnt/btrfs
>  # btrfs receive -f ~/parent_stream /mnt/btrfs/
>  At subvol parent_subv
>  # mount -o remount,nodatasum /mnt/btrfs
>  # btrfs receive -f ~/clone_stream /mnt/btrfs/
>  At snapshot dest_subv
>  ERROR: failed to clone extents to reflink: Invalid argument
>  # echo $?
>  1
>
> [CAUSE]
> Btrfs doesn't allow clone source and destination to have different NODATA=
SUM
> flags.
> This is to prevent a data extent to be owned by both NODATASUM inode and
> regular DATASUM inode.
>
> For above receive operations, the clone destination is inheriting the
> NODATASUM flag from mount option, while the clone source has no
> NODATASUM flag, thus preventing us from doing the clone.
>
> [FIX]
> Btrfs send/receive doesn't require the underlying inode has the same
> flags (thus we can send from compressed extent and receive on a
> non-compressed filesystem).
>
> So here we can just fall back to buffered write to copy the data from
> the source file if we got an -EINVAL error.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
>
> Such fallback can lead to hidden bugs not being exposed, thus a new
> warning is added for such fallback case.
>
> Personally I really want to do more comprehensive check in user space to
> ensure it's only mismatching NODATASUM flags causing the problem.
> Then we can completely remove the warning message.
>
> But unfortunately that check can go out-of-sync with kernel and due to
> the lack of NODATASUM flags interface we're not really able to check
> that easily.
>
> So I took the advice from Filipe to just do a simple fall back.
>
> Any feedback on such maybe niche point would help.
> (Really hope it's me being paranoid again)
> ---
>  cmds/receive.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/cmds/receive.c b/cmds/receive.c
> index 48c774cea587..4cb857a13cdf 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -705,6 +705,51 @@ out:
>         return ret;
>  }
>
> +#define BUFFER_SIZE    SZ_32K
> +static int buffered_copy(int src_fd, int dst_fd, u64 src_offset, u64 len=
,

At the very least leave a blank line between the #define and the
function's declaration.

> +                        u64 dest_offset)
> +{
> +       unsigned char *buf;
> +       u64 cur_offset =3D 0;
> +       int ret =3D 0;
> +
> +       buf =3D calloc(BUFFER_SIZE, 1);

It could be simpler:

char buf[SZ_32K];

then use ARRAY_SIZE() below.

> +       if (!buf)
> +               return -ENOMEM;
> +
> +       while (cur_offset < len) {

This is a bit confusing, comparing an offset to a length.
Renaming "cur_offset" to "copied" would be more logical imo.

> +               u32 copy_len =3D min_t(u32, BUFFER_SIZE, len - cur_offset=
);
> +               u32 write_offset =3D 0;
> +               ssize_t read_size;
> +
> +               read_size =3D pread(src_fd, buf, copy_len, src_offset + c=
ur_offset);
> +               if (read_size < 0) {
> +                       ret =3D -errno;
> +                       error("failed to read source file: %m");
> +                       goto out;
> +               }

Normally we should only exit if errno is not EINTR, and retry
(continue) on the EINTR case.

> +
> +               /* Write the buffer to dest file */
> +               while (write_offset < read_size) {

Same here, like "write_offset" to "written".

> +                       ssize_t write_size;
> +
> +                       write_size =3D pwrite(dst_fd, buf + write_offset,
> +                                       read_size - write_offset,
> +                                       dest_offset + cur_offset + write_=
offset);
> +                       if (write_size < 0) {
> +                               ret =3D -errno;
> +                               error("failed to write source file: %m");
> +                               goto out;
> +                       }

Same here regarding dealing with EINTR.

> +                       write_offset +=3D write_size;
> +               }
> +               cur_offset +=3D read_size;
> +       }
> +out:
> +       free(buf);
> +       return ret;
> +}
> +
>  static int process_clone(const char *path, u64 offset, u64 len,
>                          const u8 *clone_uuid, u64 clone_ctransid,
>                          const char *clone_path, u64 clone_offset,
> @@ -788,8 +833,16 @@ static int process_clone(const char *path, u64 offse=
t, u64 len,
>         ret =3D ioctl(rctx->write_fd, BTRFS_IOC_CLONE_RANGE, &clone_args)=
;
>         if (ret < 0) {
>                 ret =3D -errno;
> -               error("failed to clone extents to %s: %m", path);
> -               goto out;
> +               if (ret !=3D -EINVAL) {
> +                       error("failed to clone extents to %s: %m", path);
> +                       goto out;
> +               }
> +
> +               warning(
> +               "failed to clone extents to %s, fallback to buffered writ=
e",
> +                       path);

What if we have thousands of clone operations?
Is there any rate limited print() in progs like there is for kernel?

That's one reason why my proposal had in mind an optional flag to
trigger this behaviour.

Thanks for doing it, I was planning on doing something similar soon.

> +               ret =3D buffered_copy(clone_fd, rctx->write_fd, clone_off=
set,
> +                                   len, offset);
>         }
>
>  out:
> --
> 2.33.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
