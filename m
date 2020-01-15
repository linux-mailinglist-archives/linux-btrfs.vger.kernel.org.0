Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E7E13CA24
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 18:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAORB1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 12:01:27 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43403 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAORB1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 12:01:27 -0500
Received: by mail-vs1-f68.google.com with SMTP id s16so10854381vsc.10
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 09:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=slODBRlVfK2Z4uQHP8SfrZFkX9wcoV/8WzMzDwD2sPE=;
        b=nAU5EyCPTSyUpwxtCX/o+XosLKOZ+NZ4vyiX0cDl1pfI19xp5+HmHQyyIlGdTm5Waz
         va/tEAfyT7/flXUdhu2bZ16MhN8Yhya0M80yVBw31QdF2ulKPf0Zkyh44xxYsDuQE1/B
         mQIkHb0BUeWMDYY+mRcyMHbNHoHrcVZuotDO3ZqZQavmq1wX3l1w5b81UwwBauFtMSp0
         +UGqqYtodFDfx6gX+rQi2rkTWxWhHD8zbxDIA4dSA1LlJD25V3zP9t3tq1/l81cFq5/F
         Xn0ggC8knEWNNAS0XWv+1xyXUVq1DfXASAlVbeSp7LbYCFGKTzj0tW+Pj1ArqSh0LFAp
         rOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=slODBRlVfK2Z4uQHP8SfrZFkX9wcoV/8WzMzDwD2sPE=;
        b=CQNdM2FzslvmWeza557G3jpoS/8T5Je8s+dt8iYamg1Fhn4eSkcVsLBF4WjIzybv3e
         J9Fp7OWvhOw0QBtDRUefNDg/A7lVBjAXqFkKq9tYJwNt+xJ+4IB8gKVnZhshxc7LIAIh
         d98QHZ22aHnaxmDQJyJMRbqqfL12kqRUxQM8EsaX+mLyx97XyDfYmpDVr2ZyEMGXwbwB
         xrSXSiE1/ahHvHIBIP7jIMwlBpzFnWba7PWqphvad5eK2kbiu4NvkBQ4fDMDaia6W6JA
         /n0ciO12jkk6nVthvlaOYRLUQfzA4bUwlkEndtMWCrypWmr1ScJTA01Vl1BUOIxCYACa
         aeWg==
X-Gm-Message-State: APjAAAWiJrDSiIJIFq7joroywJwGzPVrY5EEHR5Y+Ldy38Ga5tZdse2P
        rmgt3fRP/E44im0XeWWw9wS8Q7w99wg/2pJz9eA=
X-Google-Smtp-Source: APXvYqx9og0mj9OttxTFudAuyqxvzbmIni1PXfKC7zpStBNsQz1uabdqOM26khupU7Ia6vpjJDAIY+W4K9j7ptE7lLU=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr4835737vsq.206.1579107686125;
 Wed, 15 Jan 2020 09:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20200107194237.145694-1-josef@toxicpanda.com> <20200107194237.145694-2-josef@toxicpanda.com>
In-Reply-To: <20200107194237.145694-2-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 15 Jan 2020 17:01:15 +0000
Message-ID: <CAL3q7H6V8VVKY=LSQeV5xj2T=8eMqfS373JUEdFRyPesKZee6Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] btrfs: use btrfs_ordered_update_i_size in clone_finish_inode_update
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 7, 2020 at 7:43 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We were using btrfs_i_size_write(), which unconditionally jacks up
> inode->disk_i_size.  However since clone can operate on ranges we could
> have pending ordered extents for a range prior to the start of our clone
> operation and thus increase disk_i_size too far and have a hole with no
> file extent.
>
> Fix this by using the btrfs_ordered_update_i_size helper which will do
> the right thing in the face of pending ordered extents outside of our
> clone range.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ioctl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 8ec61f3f0291..291dda3b6547 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3332,8 +3332,10 @@ static int clone_finish_inode_update(struct btrfs_=
trans_handle *trans,
>          */
>         if (endoff > destoff + olen)
>                 endoff =3D destoff + olen;
> -       if (endoff > inode->i_size)
> -               btrfs_i_size_write(BTRFS_I(inode), endoff);
> +       if (endoff > inode->i_size) {
> +               i_size_write(inode, endoff);
> +               btrfs_ordered_update_i_size(inode, endoff, NULL);
> +       }
>
>         ret =3D btrfs_update_inode(trans, root, inode);
>         if (ret) {
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
