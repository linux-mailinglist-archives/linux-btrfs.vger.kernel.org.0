Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7FC6EE77
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2019 10:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfGTIeh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Jul 2019 04:34:37 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34190 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfGTIeg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Jul 2019 04:34:36 -0400
Received: by mail-yb1-f193.google.com with SMTP id q5so1232793ybp.1
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Jul 2019 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODjdcUGvkirEkZ4KQNw9pquNIysGi09XN8OJItc8I50=;
        b=RpBylq2uWLkbD3ncD4lwd8viVyKpe6zEnHWzfxWy1eN4ulJpAFVhENXtCB8608ZAcO
         Sam3gZnm4w9KLHTkS0ejKBKSyGBOSLEqYec0WeAW/fBfJRL+WPhqooq8kY/w9P75K+2u
         n3Gd3eIwwHWuIbxBR0nDYxwUZdHxgRP2eplXkLz7N8vqbg8mV6RqM9Di8E3Id+vCplyC
         UqZMdqtSXc+xEj5d7kbceINbQNVWECmpjI61v0+dG51Uwdx1o2MvJk8sMwQaGrLGK8ud
         BaaQY9ntdOgCLu7Qzcm9RkCXJy3bbzkjarGttbPUE4Bwho4GZscEogx6hLcHkl+8v/TB
         aRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODjdcUGvkirEkZ4KQNw9pquNIysGi09XN8OJItc8I50=;
        b=NLe7uVpHMzxsqRzNAJa2fXOiHjT6fNBpfujbT2NoPzlt8jqCpRSc6hcyZneBYTjdAd
         LgIjAl11KWUuBK+Gn87b6VbEWAvfzhJ6I5QUGkfRJnZ6M2vd3BukuS5Ilgi1yH1SIyum
         Zfx8wQVMQWOODLZ8CAoXHCnlG6ehOC4pQ3h2lWgpe22MXWVQw8AwFSje0dpVGCbzCCXv
         aJWnU6cGVGFBjqzKNhVEp6vdwPiW5ETWfN7wpYYSaOKPsAlg+llwm328D5iBldI5Kd5o
         TFFa7ZifMaGQxf+qzG6cbjkjRbQRWfcfKl9Z46KjI6Y67qe/5y3LQRHDcxeNvvBSwUue
         bslQ==
X-Gm-Message-State: APjAAAXaCH6zSEMuauJCrwgV8OWV/Jh6OQnYIihR3KKVZT7eUXdj1fTf
        ZQ3es3UothFe2RIL/dO4kYgj+AtlqRyyiarXXkM=
X-Google-Smtp-Source: APXvYqzmyFrDPQOO2JPdOZoOWgNrIfPcs9RW08KfU3ws5wKj2k8Bz5Ig0T06766eQdS6pAOLHjivrvx9o5lpJ2KOpO4=
X-Received: by 2002:a25:5d12:: with SMTP id r18mr36567582ybb.302.1563611676113;
 Sat, 20 Jul 2019 01:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563600688.git.osandov@fb.com> <f0142166d2059ed0bf319778dd3146d1d0b4523d.1563600688.git.osandov@fb.com>
In-Reply-To: <f0142166d2059ed0bf319778dd3146d1d0b4523d.1563600688.git.osandov@fb.com>
From:   Mike Fleetwood <mike.fleetwood@googlemail.com>
Date:   Sat, 20 Jul 2019 09:34:24 +0100
Message-ID: <CAMU1PDhmxhtiUVYX7q-04FamEbOTFz2o7NQoQpWcMv-GsaJLLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: receive: get rid of unnecessary strdup()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 20 Jul 2019 at 06:43, Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> In process_clone(), we're not checking the return value of strdup().
> But, there's no reason to strdup() in the first place: we just pass the
> path into path_cat_out(). Get rid of the strdup().
>
> Fixes: f1c24cd80dfd ("Btrfs-progs: add btrfs send/receive commands")
> Signed-off-by: Omar Sandoval <osandov@osandov.com>
> ---
>  cmds/receive.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/cmds/receive.c b/cmds/receive.c
> index b97850a7..a3e62985 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -739,7 +739,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
>         struct btrfs_ioctl_clone_range_args clone_args;
>         struct subvol_info *si = NULL;
>         char full_path[PATH_MAX];
> -       char *subvol_path = NULL;
> +       char *subvol_path;
I think that should become const char *.

>         char full_clone_path[PATH_MAX];
>         int clone_fd = -1;
>
> @@ -760,7 +760,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
>                 if (memcmp(clone_uuid, rctx->cur_subvol.received_uuid,
>                                 BTRFS_UUID_SIZE) == 0) {
>                         /* TODO check generation of extent */
> -                       subvol_path = strdup(rctx->cur_subvol_path);
> +                       subvol_path = rctx->cur_subvol_path;
>                 } else {
>                         if (!si)
>                                 ret = -ENOENT;
> @@ -794,14 +794,14 @@ static int process_clone(const char *path, u64 offset, u64 len,
>                         if (sub_len > root_len &&
>                             strstr(si->path, rctx->full_root_path) == si->path &&
>                             si->path[root_len] == '/') {
> -                               subvol_path = strdup(si->path + root_len + 1);
> +                               subvol_path = si->path + root_len + 1;
>                         } else {
>                                 error("clone: source subvol path %s unreachable from %s",
>                                         si->path, rctx->full_root_path);
>                                 goto out;
>                         }
>                 } else {
> -                       subvol_path = strdup(si->path);
> +                       subvol_path = si->path;
>                 }
>         }
>
> @@ -839,7 +839,6 @@ out:
>                 free(si->path);
>                 free(si);
>         }
> -       free(subvol_path);
>         if (clone_fd != -1)
>                 close(clone_fd);
>         return ret;
> --
> 2.22.0
>

Mike
