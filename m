Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 333951882AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 12:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgCQL6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 07:58:03 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37200 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQL6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 07:58:02 -0400
Received: by mail-ua1-f65.google.com with SMTP id h32so7855994uah.4
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 04:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=OJjLNEYi0N54CCkywjNS+vTvrVGdsQBEPrK74YzmTbs=;
        b=NhZnNQVYgATkXDKjBemP/2lV6exeobgm9AgW0KMQnXqlSBXZELgBhXNPmcnoa5ETn9
         y6aIfSfbwesWOu7zXI4cgBH5KaYV3lkFQiZjuLJpFzZq3K5+CaTrogfsj7Om2KAtWy0N
         3xUkdf5UfMdpb6gAlHInX0G0csoDsMzsLoK442nNpMFpELr3Pvj+HMoK59ZMY9BF3Bbw
         BSrW/aoEemD6HwYqBN2vhm3nY3JOgrHO40AQBhYuQvlST6O8DAG4C4AjsCrWjDJYaiMy
         8u6jq+6qEZjSBZffADzDtbbSJiXqrLchr4ojuIsjfImABXAD6/ZaEdgU1/4Lg7MWC9we
         fX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=OJjLNEYi0N54CCkywjNS+vTvrVGdsQBEPrK74YzmTbs=;
        b=e1KU6tdV3Z6NaXZsbQ6R6zApcN6mEYDywLEJcwJjAVBPE/SUQVL8DndyJCCLqnNcf5
         H1hXpUX4GDZniEkl6QMfWoSXEusaznWysPUx0vFYzOX+2zrP0hAeHNEUDbhiisvKsf44
         UfiYMn2IiB+UFJv/2ZiuKdyW+zu794/gN1uWfTLpn6t1i1/7vbPoYhQAav83vESvg0PC
         ylVKyBOipukTRiz9JopSCJbe6yYLSZsXtDJALJex6ywa94aXQ+ppsltBLoX56Fvtaspy
         GV74OCuIdL68TwfxRxlZkCqbJP4O0sELi3Tu7LCXHqomw15SWgMvrUGTniWrl9GaYSbt
         w3gQ==
X-Gm-Message-State: ANhLgQ1gYBdUnc1n98zDWUxB4lCTrkh8oCAaTEkk38WmsEU96gCZ5JOD
        buIH6hIh0gwNihS9gK+d0SkO/WdPnzjR/0JwUllqRw==
X-Google-Smtp-Source: ADFU+vtFC7L7M84opPSJd8BO51sQmVe5zYqvszmyNYe5FHeatIzcUf+Ml4fORl5iXwZ4Zi2o0hwAczW0OUVPu1zAlCI=
X-Received: by 2002:ab0:2917:: with SMTP id v23mr487730uap.83.1584446281993;
 Tue, 17 Mar 2020 04:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200317063102.8869-1-robbieko@synology.com>
In-Reply-To: <20200317063102.8869-1-robbieko@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 17 Mar 2020 11:57:51 +0000
Message-ID: <CAL3q7H7w-6PRzVnpnggHJexumLWaLekxJO-WquaNVedH8FxhTw@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix missing semaphore unlock
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 17, 2020 at 6:41 AM robbieko <robbieko@synology.com> wrote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> Fixes: aab15e8ec2576 ("Btrfs: fix rare chances for data loss when doing a=
 fast fsync")
> Signed-off-by: Robbie Ko <robbieko@synology.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index a16da274c9aa..ae903da21588 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2124,6 +2124,7 @@ int btrfs_sync_file(struct file *file, loff_t start=
, loff_t end, int datasync)
>          */
>         ret =3D start_ordered_ops(inode, start, end);
>         if (ret) {
> +               up_write(&BTRFS_I(inode)->dio_sem);
>                 inode_unlock(inode);
>                 goto out;
>         }
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
