Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E65FE115420
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 16:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLFPXZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 10:23:25 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45207 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFPXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 10:23:25 -0500
Received: by mail-vk1-f195.google.com with SMTP id g7so2358399vkl.12
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 07:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=R1HnSXwk2pas4vfnQRNcts60NAQ2xFiUGilSxX68JUM=;
        b=fcCrIbT6BQkLFa1oB+j3dYkMdO82HbuYIoEyO/BQSQ2YFcC5RfzNKg2H91HBDCPe6H
         iY7F8BSGHvOZjn6JQJIbI06KpXosJMqAnZ+v0enGj6CoQoCxg6Mk7MahxJVEk3ppqRNl
         5gU0MycYz0v8ijS/80YLF2mmEt2Ozy4w2AGMw5imiCJH/v/lzzcay6yY9lXpKvq757O8
         5YAl5uKhNm0k8v2QAw4g9b3L3EB1bVG6VxmO1YAkXf62isVRWlEXcwKDOA6zCZ80Y5uP
         TL8H+C9Kkb1sjxDIvUxil43Z+VEAkpV6RJj31bSSFJXr22TPH7cevuv9uPaPY5rQpylB
         s1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=R1HnSXwk2pas4vfnQRNcts60NAQ2xFiUGilSxX68JUM=;
        b=ujlZnNizB9VcDyIvu6IdB+aLKKJX3HRaJOpwD4k0HmwuzlD+za8rVdBtPUdRn9OpDX
         YnVIXun+bR2tquOZxwQMQp+IU66WLG+sHzGHoXnVC3GdYJFrT6Zc1/+5lfqqSPUBV6HT
         ShMH7H4/WjRF0oiIbUJTw1yt2N0z4TmcslevFeFa8eh8irAHVe+3uv6B2rXgS85u02O0
         RvSx3wcRmyqDl5OcNP9RcsHxgCAKG0Okse58cCL1JZX0TpYVMn3w6lh6+oId+uDWmH89
         E9OcADNgMdqZARjC7XEtIRDln0ILMIrAQO2C27RBwh/DEepvxEZncIMBi7FACQLO7wo1
         2jLw==
X-Gm-Message-State: APjAAAWQEYUKw2GJaKX2vBGYIBgXTcIyR1k9kR4avNHVD7ShQKECsXa8
        dKX/XNtJ6//EjGJpYZXZnf96+rF6olIhK1begR1tsO1s
X-Google-Smtp-Source: APXvYqz1AKpOT2SWRE9w1DE/q5VrMjga/B8ptSEAe2LuGsNPWU1uBbeZJkclnNjYw0bhAKuKDqdxzS5Sk7+TUJ2HV1U=
X-Received: by 2002:a1f:2753:: with SMTP id n80mr12063386vkn.24.1575645804262;
 Fri, 06 Dec 2019 07:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20191206143718.167998-1-josef@toxicpanda.com> <20191206143718.167998-5-josef@toxicpanda.com>
In-Reply-To: <20191206143718.167998-5-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Dec 2019 15:23:13 +0000
Message-ID: <CAL3q7H6YmmcnP6iSOxM=1WO2EyOiNDqYtLT0mK3WM7OFiu3HcA@mail.gmail.com>
Subject: Re: [PATCH 4/5] btrfs: skip log replay on orphaned roots
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 6, 2019 at 2:38 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> My fsstress modifications coupled with generic/475 uncovered a failure
> to mount and replay the log if we hit a orphaned root.  We do not want
> to replay the log for an orphan root, but it's completely legitimate to
> have an orphaned root with a log attached.  Fix this by simply skipping
> replaying the log.  We still need to pin it's root node so that we do
> not overwrite it while replaying other logs, as we re-read the log root
> at every stage of the replay.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/tree-log.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 6f757361db53..4bbb4fd490b5 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6294,9 +6294,28 @@ int btrfs_recover_log_trees(struct btrfs_root *log=
_root_tree)
>                 wc.replay_dest =3D btrfs_read_fs_root_no_name(fs_info, &t=
mp_key);
>                 if (IS_ERR(wc.replay_dest)) {
>                         ret =3D PTR_ERR(wc.replay_dest);
> +
> +                       /*
> +                        * We didn't find the subvol, likely because it w=
as
> +                        * deleted.  This is ok, simply skip this log and=
 go to
> +                        * the next one.
> +                        *
> +                        * We need to exclude the root because we can't h=
ave
> +                        * other log replays overwriting this log as we'l=
l read
> +                        * it back in a few more times.  This will keep o=
ur
> +                        * block from being modified, and we'll just bail=
 for
> +                        * each subsequent pass.
> +                        */
> +                       if (ret =3D=3D -ENOENT)
> +                               ret =3D btrfs_pin_extent_for_log_replay(f=
s_info,
> +                                                       log->node->start,
> +                                                       log->node->len);
>                         free_extent_buffer(log->node);
>                         free_extent_buffer(log->commit_root);
>                         kfree(log);
> +
> +                       if (!ret)
> +                               goto next;
>                         btrfs_handle_fs_error(fs_info, ret,
>                                 "Couldn't read target root for tree log r=
ecovery.");
>                         goto error;
> @@ -6328,7 +6347,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_=
root_tree)
>                                                   &root->highest_objectid=
);
>                 }
>
> -               key.offset =3D found_key.offset - 1;
>                 wc.replay_dest->log_root =3D NULL;
>                 free_extent_buffer(log->node);
>                 free_extent_buffer(log->commit_root);
> @@ -6336,9 +6354,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log=
_root_tree)
>
>                 if (ret)
>                         goto error;
> -
> +next:
>                 if (found_key.offset =3D=3D 0)
>                         break;
> +               key.offset =3D found_key.offset - 1;
>         }
>         btrfs_release_path(path);
>
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
