Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF1241C8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 16:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgHKOif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 10:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgHKOif (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 10:38:35 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0EDC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 07:38:35 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id x142so2684170vke.0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=VKK2vcjbNsKA6deS2EKMvdfcl2jDQZDbBY8oVn0JJm0=;
        b=BFPxfyhxthxRXON4GTkhB8/ZLULkxxuRhATE1kp9EUKNunVIM3QeV3vNgeflxc1S8d
         dutO0UKMghv75dvJM+tTDj96HGgKlIMnzA7hy23BtpeY/WFt64iob2Hog4xouxDnA4rZ
         l9zhLW/EpYhjQ0vn9W1y8yzu9j/3n7Wms3Q8PJEYhUSToOzZ1XsN1b0swgKUzSOAwxWz
         /Aumj03Cw0+O7QZb7oQ4opxIjGCL5Tvq2+e9bEMVb+8y0BrHMD2yzuqQgIrw01taNv7c
         talKa5BIlb3A6e04YhqmC7MUb1hReSfBVtosvIyApyJRV8ZynEZjtlnDAlb5qc+k9YEU
         DONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=VKK2vcjbNsKA6deS2EKMvdfcl2jDQZDbBY8oVn0JJm0=;
        b=uoTt1B9Rz+R4xyYV1ymq2e9kzNYCVVfyjhVoAVAz8fFug1JygJajQlMD7v29IHonZB
         5q+Rf4DkC9FWLhMeiGADPhv9jzFLry5/efykzRG+d4esP1nX2KTDIoHwsanXchXywCn6
         5xmtNKG/KtHsJZgEZw3piqnrLxy2XKx7Y3T+voS/l/5qWK4QQAqGV8YUn8Iw5z3N8P2I
         7PyqCz+cOBF/wq2i50YGGjwOhAIWr43rE+ACxJF0bxujF0sNOKEidjhOq+iH7PgMM4pN
         lw3OgRlGmtoUyAkeUxE6yEjbAexMwBT8PKFzLoR422adAvGGvU4Brsatpae2XXI5yAWf
         6CcQ==
X-Gm-Message-State: AOAM5327Db5g/ohgFuAGwws7RMOzDB60ha9gBm3A8eBp7vmmAZEYLJKi
        0AFgozTDsXttPdLXy9ZbrBS9K6qC9FgHqcRKZAZ4dj1l
X-Google-Smtp-Source: ABdhPJzZ9ZZ8fBfW7WSI8yrOMBKl7Rs1qSTzqWXHYgumkGKKiaZqrllyiWY6B9aNWLG1Uu8VLdH8Olgp4vrXO/FEN3g=
X-Received: by 2002:a1f:2dd7:: with SMTP id t206mr24500760vkt.13.1597156714026;
 Tue, 11 Aug 2020 07:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200810213116.795789-1-josef@toxicpanda.com> <CAL3q7H4T-orhnnJrNxNqTXOXHm8c0jnqRf3GX3LuOV+9ZXjD4w@mail.gmail.com>
 <dad7d1e7-0e1a-412f-9ec1-7ab188ea38aa@toxicpanda.com>
In-Reply-To: <dad7d1e7-0e1a-412f-9ec1-7ab188ea38aa@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 11 Aug 2020 15:38:22 +0100
Message-ID: <CAL3q7H6BGhA1XjodNKZdVZ_dtZt0g91eB3dVEdxdkzsUxG2LMw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: check the right variable in btrfs_del_dir_entries_in_log
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 11, 2020 at 3:27 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 8/11/20 6:14 AM, Filipe Manana wrote:
> > On Mon, Aug 10, 2020 at 10:32 PM Josef Bacik <josef@toxicpanda.com> wro=
te:
> >>
> >> With my new locking code dbench is so much faster that I tripped over =
a
> >> transaction abort from ENOSPC.  This turned out to be because
> >> btrfs_del_dir_entries_in_log was checking for ret =3D=3D -ENOSPC, but =
this
> >> function sets err on error, and returns err.  So instead of properly
> >> marking the inode as needing a full commit, we were returning -ENOSPC
> >> and aborting in __btrfs_unlink_inode.  Fix this by checking the proper
> >> variable so that we return the correct thing in the case of ENOSPC.
> >>
> >> Fixes: 4a500fd178c8 ("Btrfs: Metadata ENOSPC handling for tree log")
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> ---
> >>   fs/btrfs/tree-log.c | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> >> index e0ab3c906119..bc9ed31502ec 100644
> >> --- a/fs/btrfs/tree-log.c
> >> +++ b/fs/btrfs/tree-log.c
> >> @@ -3449,11 +3449,11 @@ int btrfs_del_dir_entries_in_log(struct btrfs_=
trans_handle *trans,
> >>          btrfs_free_path(path);
> >>   out_unlock:
> >>          mutex_unlock(&dir->log_mutex);
> >> -       if (ret =3D=3D -ENOSPC) {
> >> +       if (err =3D=3D -ENOSPC) {
> >>                  btrfs_set_log_full_commit(trans);
> >> -               ret =3D 0;
> >> -       } else if (ret < 0)
> >> -               btrfs_abort_transaction(trans, ret);
> >> +               err =3D 0;
> >> +       } else if (err < 0 && err !=3D -ENOENT)
> >
> > Why the check for ENOENT?
> > If any of the directory index items doesn't exist, the respective
> > functions return a NULL btrfs_dir_item pointer and we do nothing and
> > return 0.
> > I'm not seeing anything else that could return ENOENT either.
> >
> > Other than that it looks good.
>
> I missed this too until I tested it and things went wrong.  It's because
> btrfs_lookup_dir_item() can return -ENOENT if the dir item isn't in the t=
ree log
> (which would happen if we hadn't fsync'ed this guy).

Hum, looking again I think you meant btrfs_lookup_dir_index_item() and
not btrfs_lookup_dir_item().

The log could have mentioned why we started to check ENOENT, since it
only mentions the bug where we check the wrong variable.

Now it makes sense.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.



> We actually handle that
> case in __btrfs_unlink_inode, so it's an expected error to get back.  Tha=
nks,
>
> Josef



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
