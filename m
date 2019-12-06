Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1D91153CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 16:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfLFPEB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 10:04:01 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46868 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfLFPEB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 10:04:01 -0500
Received: by mail-ua1-f67.google.com with SMTP id i31so2924676uae.13
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 07:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=0Ltn+VEuaFuv09rzRejR1tnityZb3efGzsGBv4kY/wY=;
        b=SoS22U1DxQC4CXQJrW+mknFmS7+QI3cplRNZx3SWkE8vKPZIFpUe09QfgwcRB56u2d
         oUXUnCGvf3/DKj0jwT4XMHHLYGmAs1sX1HgBpXGYJtizLHbClA/N6/BpFHJuaOEjeSvD
         3R22fyJmEg0NCu9SxOpKIDr4Ck95JClwCVYgkscC9jWxxgTtnGUkX1Xh0uhYrKNRY+mF
         Uvuhd9QPBO4ukA4ZYgH2tYGmxcZNV9GvVbdLmCW3JC5nz63N/Ur/d+9rAuyLDGWqVvle
         ePVo6tSgRzbtzQtTEMo60yUnBaRKUX3tyUAow+t4BOGMjhCPL2Tp9Y0ZGoeMsCIpGxjT
         UAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=0Ltn+VEuaFuv09rzRejR1tnityZb3efGzsGBv4kY/wY=;
        b=tBY/OxGNuN3wjyK/wc9MjhY/CuzAKz86l65p14Urdbp5VubyWvkmQuj2oef+Nf0ckr
         eTZljtGjUkud7x9q6Re7k9TU2qBgoio3irifyJ/pDU4pQ1jfb0DVRGJH3nj3iqg7MKKx
         7+AKvj5SLRc57jTT/egJqdAw4UzJ/sX7aGvaOAHE6/EK9FbJ8pZWED7lcd+yOq7GDT2a
         ZXNWdLAbnyq5dfmLBhHa84TZtAxdBw/JvN/LhVgTRDp/8y9VAiyn5bXxof2EEb7WKEXs
         G/wtms8F5JKy1AVrYPTt1k4+K2nVX+5VQXfOM7Y8wI3Jn2LK0NbukU2QqUz0KA+yMYGg
         RfHQ==
X-Gm-Message-State: APjAAAVDwdXex397o+ADSLF25X7LkLP7v5Fn2F9SO6J464xuEG4zej0O
        Ghl0cYm/VPOpRvmqymljbfO9jloYYf1Cp6XuLDo=
X-Google-Smtp-Source: APXvYqyBsiWLjL2mgHhys0egkReKcA06iVHmOOuw7Rs/D8vB0zni7wfyEeLmxhYJFnPwNZm58S8/arTZLPKVXW7Iad4=
X-Received: by 2002:a9f:3e84:: with SMTP id x4mr12552140uai.83.1575644640325;
 Fri, 06 Dec 2019 07:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20191206143718.167998-1-josef@toxicpanda.com> <20191206143718.167998-3-josef@toxicpanda.com>
In-Reply-To: <20191206143718.167998-3-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Dec 2019 15:03:49 +0000
Message-ID: <CAL3q7H7inXKi1=Epq2iH_TYVFzVX3=kWg526beXzb_0-S0hAMw@mail.gmail.com>
Subject: Re: [PATCH 2/5] btrfs: don't BUG_ON in create_subvol
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
> We can just abort the transaction here, and in fact do that for every
> other failure in this function except these two cases.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ioctl.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a1ee0b775e65..375befdecc19 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -704,11 +704,17 @@ static noinline int create_subvol(struct inode *dir=
,
>
>         btrfs_i_size_write(BTRFS_I(dir), dir->i_size + namelen * 2);
>         ret =3D btrfs_update_inode(trans, root, dir);
> -       BUG_ON(ret);
> +       if (ret) {
> +               btrfs_abort_transaction(trans, ret);
> +               goto fail;
> +       }
>
>         ret =3D btrfs_add_root_ref(trans, objectid, root->root_key.object=
id,
>                                  btrfs_ino(BTRFS_I(dir)), index, name, na=
melen);
> -       BUG_ON(ret);
> +       if (ret) {
> +               btrfs_abort_transaction(trans, ret);
> +               goto fail;
> +       }
>
>         ret =3D btrfs_uuid_tree_add(trans, root_item->uuid,
>                                   BTRFS_UUID_KEY_SUBVOL, objectid);
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
