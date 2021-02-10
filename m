Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A9C315C6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 02:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhBJBlR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 20:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbhBJBjH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Feb 2021 20:39:07 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2056C061574
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Feb 2021 17:38:26 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id y123so285502vsy.13
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Feb 2021 17:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZZh6gb1Ee874ljOPGZBKxBIuVNS6CsTS7WFWSbpIlE=;
        b=IjlSE9P6+wnourXdUNhtL2E8dqamYOTk8pw5DiLRpL5yJe4sU7av16PXPDG6nRDnWh
         coqy3im2VvhKTxUyDbXKeKssYiAo7PMu4rQPWCXsSHdwAyxi9X0ENUY56YzpJOO4FmU4
         w45wVxHNC3K0ys1T27ybbg050v8n36b0flL6afK/U/P7UvLN6kOoljqiBdCRgxYSQf4/
         oHggtwEwxH9bVwnJP9zyvxOps8bjezUk8LaEgSOC2qogBiZ6stfAw/M+f/pPfnxJBz4x
         4F3a8D2B4Uwy6CHSUfJOPmpeGQ92O4reg+7tOZNOPzIL8uyrQBGWlO5Gm6fy5SAc3Xr1
         8BLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZZh6gb1Ee874ljOPGZBKxBIuVNS6CsTS7WFWSbpIlE=;
        b=Uf+xEvmYjwDceIWMwbvixhn9sIcAvR2e4kh7m2ThBhexHD0JqRNtSit4S+siUNVZYd
         yRdB9WZVG8xzJvzCaivudXNRdFdq30GAZl6r6t0RjYMhhqIJQAWtcg5Xegh8IfHnctwv
         KTE8NCyFzuhf9fWMkOET5f72CZ4/jVSrrRu5EeR2Ud9BtkmHdo7+HOqiK4LboV3q+gOu
         usX8/vNpP/k1jdyW3SFIbzPqFoZuVroZw7I5C1NRLKgjpIwcgKoAwFtTs5kIKHYKUvbX
         7Q5WV0jh+cqTO8xY0XR0IwpQldA9T9ksr9e1qdYNsO9k/tUpRwzF21+SoSD3pwfvLZOb
         JB9Q==
X-Gm-Message-State: AOAM532V0xvERHfcwnA47cJ5piQqx2vJIxDXFz8BI2xV3My6Te4ViZsX
        E7dYVhfEdTpo2QriQseAHsLyi9MpS4W1poE3OpU=
X-Google-Smtp-Source: ABdhPJz6CrPos8e6P+Ys9bHUA9O3/DuygEIBQoUr6aBM/p2ySaEHi1742ChJyiEmszWlN0yejNrHLB0B6EL5mOqq4xc=
X-Received: by 2002:a67:fb12:: with SMTP id d18mr580703vsr.28.1612921105870;
 Tue, 09 Feb 2021 17:38:25 -0800 (PST)
MIME-Version: 1.0
References: <e35e5d556cd5964a4ab80bdd997856ee5be8b888.1612870936.git.fdmanana@suse.com>
In-Reply-To: <e35e5d556cd5964a4ab80bdd997856ee5be8b888.1612870936.git.fdmanana@suse.com>
From:   Su Yue <damenly.su@gmail.com>
Date:   Wed, 10 Feb 2021 09:38:14 +0800
Message-ID: <CABnRu56HucfTFrBzbbnjJetzOtrvnJNBq8523uV8XeM84hBapQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: remove workaround for setting capabilities
 in the receive command
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 9, 2021 at 7:53 PM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> We had a few bugs on the kernel side of send/receive where capabilities
> ended up being lost after receiving a send stream. They all stem from the
> fact that the kernel used to send all xattrs before issuing the chown
> command, and the later clears any existing capabilities in a file or
> directory.
>
> Initially a workaround was added to btrfs-progs' receive command, in commit
> 123a2a085027e ("btrfs-progs: receive: restore capabilities after chown"),
> and that fixed some instances of the problem. More recently, other instances
> of the problem were found, a proper fix for the kernel was made, which fixes
> the root problem by making send always emit the sexattr command for setting
> capabilities after issuing a chown command. This was done in kernel commit
> 89efda52e6b693 ("btrfs: send: emit file capabilities after chown"), which
> landed in kernel 5.8.
>
> However, the workaround on the receive command now causes us to incorrectly
> set a capability on a file that should not have it, because it assumes all
> setxattr commands for a file always comes before a chown.
>
> Example reproducer:
>
>   $ cat send-caps.sh
>   #!/bin/bash
>
>   DEV1=/dev/sdh
>   DEV2=/dev/sdi
>
>   MNT1=/mnt/sdh
>   MNT2=/mnt/sdi
>
>   mkfs.btrfs -f $DEV1 > /dev/null
>   mkfs.btrfs -f $DEV2 > /dev/null
>
>   mount $DEV1 $MNT1
>   mount $DEV2 $MNT2
>
>   touch $MNT1/foo
>   touch $MNT1/bar
>   setcap cap_net_raw=p $MNT1/foo
>
>   btrfs subvolume snapshot -r $MNT1 $MNT1/snap1
>
>   btrfs send $MNT1/snap1 | btrfs receive $MNT2
>
>   echo
>   echo "capabilities on destination filesystem:"
>   echo
>   getcap $MNT2/snap1/foo
>   getcap $MNT2/snap1/bar
>
>   umount $MNT1
>   umount $MNT2
>
> When running the test script, we can see that both files foo and bar get
> the capability set, when only file foo should have it:
>
>   $ ./send-caps.sh
>   Create a readonly snapshot of '/mnt/sdh' in '/mnt/sdh/snap1'
>   At subvol /mnt/sdh/snap1
>   At subvol snap1
>
>   capabilities on destination filesystem:
>
>   /mnt/sdi/snap1/foo cap_net_raw=p
>   /mnt/sdi/snap1/bar cap_net_raw=p
>
> Since the kernel fix was backported to all currently supported stable
> releases (5.10.x, 5.4.x, 4.19.x, 4.14.x, 4.9.x and 4.4.x), remove the
> workaround from receive. Having such a workaround relying on the order
> of commands in a send stream is always troublesome and doomed to break
> one day.
>
Since the kernel fix was backported properly. It looks good to me now.

Reviewed-by: Su Yue <l@damenly.su>

> A test case for fstests will come soon.
>
> Reported-by: Richard Brown <rbrown@suse.de>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  cmds/receive.c | 49 -------------------------------------------------
>  1 file changed, 49 deletions(-)
>
> diff --git a/cmds/receive.c b/cmds/receive.c
> index 2aaba3ff..b4099bc4 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -77,14 +77,6 @@ struct btrfs_receive
>         struct subvol_uuid_search sus;
>
>         int honor_end_cmd;
> -
> -       /*
> -        * Buffer to store capabilities from security.capabilities xattr,
> -        * usually 20 bytes, but make same room for potentially larger
> -        * encodings. Must be set only once per file, denoted by length > 0.
> -        */
> -       char cached_capabilities[64];
> -       int cached_capabilities_len;
>  };
>
>  static int finish_subvol(struct btrfs_receive *rctx)
> @@ -825,22 +817,6 @@ static int process_set_xattr(const char *path, const char *name,
>                 goto out;
>         }
>
> -       if (strcmp("security.capability", name) == 0) {
> -               if (bconf.verbose >= 4)
> -                       fprintf(stderr, "set_xattr: cache capabilities\n");
> -               if (rctx->cached_capabilities_len)
> -                       warning("capabilities set multiple times per file: %s",
> -                               full_path);
> -               if (len > sizeof(rctx->cached_capabilities)) {
> -                       error("capabilities encoded to %d bytes, buffer too small",
> -                               len);
> -                       ret = -E2BIG;
> -                       goto out;
> -               }
> -               rctx->cached_capabilities_len = len;
> -               memcpy(rctx->cached_capabilities, data, len);
> -       }
> -
>         if (bconf.verbose >= 3) {
>                 fprintf(stderr, "set_xattr %s - name=%s data_len=%d "
>                                 "data=%.*s\n", path, name, len,
> @@ -961,23 +937,6 @@ static int process_chown(const char *path, u64 uid, u64 gid, void *user)
>                 error("chown %s failed: %m", path);
>                 goto out;
>         }
> -
> -       if (rctx->cached_capabilities_len) {
> -               if (bconf.verbose >= 3)
> -                       fprintf(stderr, "chown: restore capabilities\n");
> -               ret = lsetxattr(full_path, "security.capability",
> -                               rctx->cached_capabilities,
> -                               rctx->cached_capabilities_len, 0);
> -               memset(rctx->cached_capabilities, 0,
> -                               sizeof(rctx->cached_capabilities));
> -               rctx->cached_capabilities_len = 0;
> -               if (ret < 0) {
> -                       ret = -errno;
> -                       error("restoring capabilities %s: %m", path);
> -                       goto out;
> -               }
> -       }
> -
>  out:
>         return ret;
>  }
> @@ -1155,14 +1114,6 @@ static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
>                 goto out;
>
>         while (!end) {
> -               if (rctx->cached_capabilities_len) {
> -                       if (bconf.verbose >= 4)
> -                               fprintf(stderr, "clear cached capabilities\n");
> -                       memset(rctx->cached_capabilities, 0,
> -                                       sizeof(rctx->cached_capabilities));
> -                       rctx->cached_capabilities_len = 0;
> -               }
> -
>                 ret = btrfs_read_and_process_send_stream(r_fd, &send_ops,
>                                                          rctx,
>                                                          rctx->honor_end_cmd,
> --
> 2.28.0
>
