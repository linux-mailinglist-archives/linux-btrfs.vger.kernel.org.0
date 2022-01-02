Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548214829C6
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 06:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiABF63 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jan 2022 00:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiABF62 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Jan 2022 00:58:28 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760BEC061574
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 21:58:28 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id d189so5476061vkg.3
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Jan 2022 21:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H9g9efcpevzkcnh7j0DXzg1jRNuTeRc+sTlVuDWohBY=;
        b=jlah0OKooD4i9z4Ur0mdHqSS1v380jwBxAD9IJ1Z6qF94dqtOEJnT7asFPryS3lcbv
         eYaewg5RVWRiE2GaXK6wO95RhkO8/EqFxW5kqaV2AkyZfW0WYb2KXRIk3SUe8tnkXDvU
         c7472V73Y8tiKQUuWtPiEKt8eA0um5UQBGrBdEfUjr0CVVAYghvBck2A9Pa2B0tBFXWt
         008Ba1JNgUSxIDM+Lv+nXNRyqbLLhR0+FQS1KbRNpCiZiuT6suTnB9uocCmrwaunXF8s
         qWtXTXbRogwT5FZHZIBqHgIuUz5QyXwhwru3qp7m4LqqZ3pIgZX4x75ijGrAEbOtpSF7
         yP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H9g9efcpevzkcnh7j0DXzg1jRNuTeRc+sTlVuDWohBY=;
        b=FAVy24O0R14QmQJaqZnuybG+3WWIYOSPoKDdOH8SQ3VR+hmPp15R06X+Yv6moh95FR
         1SvD/l57qSY9mcchQ42uyzjVUxe3GaTV5K10J6foHca+JwZHt8XWxVUv4oorvWEr0UfC
         tT/vtKsqZpIWSWAmyEmbdtDoJmMK//zx7kiOM8gfwPoCz7Ool5BUiCey9XQPqLqYRnVT
         me/0dxvGjp9qyx5HAaeT65Yk8uYP8eRv5zbPTdqOndQ9KPBnGgc5JxPkm+gH9Pth8jbd
         Y1RuNQVEmuloJkdKH+qPWiG7/hfOKh95fDuJ63tDw6xNteM9AP5c2j5LQX29fpuNxrUx
         K2Tw==
X-Gm-Message-State: AOAM5314+yGxEG0OWIQ1dQyX0wnscpioPY8pcIzfU4XNN5OvFpZSEowz
        o839Nb7YVKb8mOxmzV94TK+kygyWmUkXq7NuhLDpQgWw9FyTGg==
X-Google-Smtp-Source: ABdhPJzM79UXKoJnupj1w8UD5kH+5HnFwyKbM45Xh0D5z1w7cQWIGnFWpFQdO6QgRrEdPbI6OZX/lWDVR18Uz1G4CV4=
X-Received: by 2002:a05:6122:8ca:: with SMTP id 10mr9061265vkg.32.1641103107395;
 Sat, 01 Jan 2022 21:58:27 -0800 (PST)
MIME-Version: 1.0
References: <1443641013-26765-1-git-send-email-rruede+git@gmail.com>
In-Reply-To: <1443641013-26765-1-git-send-email-rruede+git@gmail.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Sun, 2 Jan 2022 07:58:16 +0200
Message-ID: <CAOE4rSwjOuNx-Ou=G0tER4nAtKROx9SeqKqxYuE7MDgPsZKQSw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix resending received snapshot with parent
To:     Robin Ruede <r.ruede@gmail.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>,
        Robin Ruede <rruede+git@gmail.com>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

tre=C5=A1d., 2015. g. 30. sept., plkst. 22:25 =E2=80=94 lietot=C4=81js Robi=
n Ruede
(<r.ruede@gmail.com>) rakst=C4=ABja:
>
> This fixes a regression introduced by 37b8d27d between v4.1 and v4.2.
>
> When a snapshot is received, its received_uuid is set to the original
> uuid of the subvolume. When that snapshot is then resent to a third
> filesystem, it's received_uuid is set to the second uuid
> instead of the original one. The same was true for the parent_uuid.
> This behaviour was partially changed in 37b8d27d, but in that patch
> only the parent_uuid was taken from the real original,
> not the uuid itself, causing the search for the parent to fail in
> the case below.
>
> This happens for example when trying to send a series of linked
> snapshots (e.g. created by snapper) from the backup file system back to t=
he original one.
>
> The following commands reproduce the issue in v4.2.1
> (no error in 4.1.6)
>
>     # setup three test file systems
>     for i in 1 2 3; do
>             truncate -s 50M fs$i
>             mkfs.btrfs fs$i
>             mkdir $i
>             mount fs$i $i
>     done
>     echo "content" > 1/testfile
>     btrfs su snapshot -r 1/ 1/snap1
>     echo "changed content" > 1/testfile
>     btrfs su snapshot -r 1/ 1/snap2
>
>     # works fine:
>     btrfs send 1/snap1 | btrfs receive 2/
>     btrfs send -p 1/snap1 1/snap2 | btrfs receive 2/
>
>     # ERROR: could not find parent subvolume
>     btrfs send 2/snap1 | btrfs receive 3/
>     btrfs send -p 2/snap1 2/snap2 | btrfs receive 3/
>
> Signed-off-by: Robin Ruede <rruede+git@gmail.com>
> ---
>  fs/btrfs/send.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index aa72bfd..890933b 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -2351,8 +2351,14 @@ static int send_subvol_begin(struct send_ctx *sctx=
)
>         }
>
>         TLV_PUT_STRING(sctx, BTRFS_SEND_A_PATH, name, namelen);
> -       TLV_PUT_UUID(sctx, BTRFS_SEND_A_UUID,
> -                       sctx->send_root->root_item.uuid);
> +
> +       if (!btrfs_is_empty_uuid(sctx->send_root->root_item.received_uuid=
))
> +               TLV_PUT_UUID(sctx, BTRFS_SEND_A_UUID,
> +                           sctx->send_root->root_item.received_uuid);
> +       else
> +               TLV_PUT_UUID(sctx, BTRFS_SEND_A_UUID,
> +                           sctx->send_root->root_item.uuid);
> +
>         TLV_PUT_U64(sctx, BTRFS_SEND_A_CTRANSID,
>                     le64_to_cpu(sctx->send_root->root_item.ctransid));
>         if (parent_root) {
> --
> 2.6.0
>
> --

Hi,

This breaks use case when snapshot is sent from one system to another
where it's set to read-write, modified, set back to read-only to send
to 3rd system.
This will cause received_uuid to be present but it won't match
original first snapshot anymore so 2nd system's UUID should be used
instead of first.
Only very recently (Oct 2021) "btrfs property set" was changed to
clear received_uuid when switching ro -> rw thus it means there could
be a lot of rw filesystems with it set. And it can cause strange send
failure, see my email titled "btrfs send picks wrong subvolume UUID".
Also I'm not only one who encountered such issue [1].
Workaround is to clear received_uuid, but that might not be obvious or
not even possible for filesystems mounted as read-only (or corrupted
ones that can't be remounted rw).

[1] "Wrong received UUIDs after backup restore and onward" -
https://www.spinics.net/lists/linux-btrfs/msg65142.html

Best regards,
D=C4=81vis
