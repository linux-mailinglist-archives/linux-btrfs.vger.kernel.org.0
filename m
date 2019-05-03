Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C615E1311C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 17:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfECPZ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 11:25:27 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33902 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfECPZ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 May 2019 11:25:27 -0400
Received: by mail-vs1-f67.google.com with SMTP id b23so3846793vso.1
        for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2019 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=crCY0IG33K0YzdJoljasD4u8NX5zRD3dCR4VUkad/nU=;
        b=JJfAoNzLdTOkvn/3mNEmFhOlpsl1gfZvQDB8tBuzSWg3EG37D8EyM/VB7EiFIO8XUa
         MyyXIY4tZh9zd2RFuFaxL7nSfHI+f9ZxyepIHaB5Ov4FB+s/f8rrG1McYnJNJVvGOVfm
         9hvwArVI5/eVDtVDQTlUrX5y/BwWtJor5o5/ntaCyVX0ylSCvbrbKvMPzXfaNfKE86qQ
         X/+1RLsHPdPv9YMLIdPGTpzULwMoIzuo5XezaQi0N9GEg5inUUum+U9CHFDA5nZSD1Nz
         Kb01gCQzr7tblZr3Vri3NgY6UnJkyU6/L191Z7OunXOSRHykCI+J/a7ItKAT9eB6/xH5
         7jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=crCY0IG33K0YzdJoljasD4u8NX5zRD3dCR4VUkad/nU=;
        b=PPZuvQ8WQAG1+DtkvPX4uBihkc4hd9NmcjwXEhDUdAbS5lm2dNOQA4+Otx12qF3Mnp
         TVU6uvLiXl6jWpyn6AZZQVmQnEnumB2al04smF1YyTUYcGB0XBMrfYCQHxAfgOAOI6zV
         1Os44CsR0FK+N2g+IQNrpmILwE+Tj3Q+5KqpfF1TrO7KK/K2RmRp9EgOihlc97Zoh970
         h3f4uXm5rM8V4mKpqsCaFEW+Vk9shRb0vrMF4lRdLPuFEI1qew8OrennsHbQK6UeL68G
         ttiud4VIf+mHCh1ITZRJ37d2yyCw+RaPrSZx+oFyrPA8fQ/D+dS/qqZoUfpltLz9TXQ6
         e5wA==
X-Gm-Message-State: APjAAAWDIEHYVmkRH6HIxKwOLAaD6jQhv/zQ1ykyr//VsROPHavzLYbZ
        LAezHLA9D3gGYA4uUNGja/FgdkMoN4hkzt1EvhQ=
X-Google-Smtp-Source: APXvYqyPM4hC5up+AFvXjcLvQS6LL8xAtwX2q7x7lUoBewlSvR3/JxyZEg7LLsmKFLp9rMJMUQGnV4AlWYt8yhLowCA=
X-Received: by 2002:a67:6847:: with SMTP id d68mr5954396vsc.90.1556897126317;
 Fri, 03 May 2019 08:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190503151007.75525-1-josef@toxicpanda.com>
In-Reply-To: <20190503151007.75525-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 3 May 2019 16:25:14 +0100
Message-ID: <CAL3q7H6aoGNzYoXM7R5T4DsxYtOGZi0iaBEOiKB5GJrsXksaEA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: don't double unlock on error in btrfs_punch_hole
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 3, 2019 at 4:21 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> If we have an error writing out a delalloc range in
> btrfs_punch_hole_lock_range we'll unlock the inode and then goto
> out_only_mutex, where we will again unlock the inode.  This is bad,
> don't do this.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, I introduced the double unlock accidentally.

> ---
>  fs/btrfs/file.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 7f7833149cb7..d23ea0b388e0 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2554,10 +2554,8 @@ static int btrfs_punch_hole(struct inode *inode, l=
off_t offset, loff_t len)
>
>         ret =3D btrfs_punch_hole_lock_range(inode, lockstart, lockend,
>                                           &cached_state);
> -       if (ret) {
> -               inode_unlock(inode);
> +       if (ret)
>                 goto out_only_mutex;
> -       }
>
>         path =3D btrfs_alloc_path();
>         if (!path) {
> --
> 2.13.5
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
