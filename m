Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9799B09BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 09:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfILHxk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 03:53:40 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33281 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfILHxk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 03:53:40 -0400
Received: by mail-ua1-f67.google.com with SMTP id f20so172968uaq.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 00:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vVhihHG/YejH3LweucJHKAM9JgsiBpB1y+jeE5HwLJ0=;
        b=T4nIPYhhtWR870DHBK/MPKkCdSdQx8TVYG6Tb/69IGflsWqQKVpDQI+qSlgW6VTjKe
         3PPtZgk1rh77J1UY9oxvNV8C1zACkdS9IipCZ86xd6jmi30ph4v9ez4BdlJc/l/cFaGa
         YNh0vtd6u7R33kbuiX8kIlM742Ohk/2d0uqLHItOmSvyRf6cKGm/hl1LIihE7Nd0nO5g
         Q5xxtThFkk/KSGcj7MJFxeEcNAxtUGo0UJdu23TZ3X+kfGnLh4nj3EK5LnlAiZlmRInl
         hnq6W9+zk5gsil7JdIBZ/g2y7dZzo2dF681kzhnYqZkmxylISqIy3cb2Zh4+nbfUtDP0
         gxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vVhihHG/YejH3LweucJHKAM9JgsiBpB1y+jeE5HwLJ0=;
        b=APDtJjdPowQGAqN0P873Rt2o8t73L6Kh7qjQRBOSrdlDaj234OiNAwqrw74RhwB3Qs
         KxJVVe6OsV8f6D58v8FEPBFpCio54zEytYgjYPyQFRYEsvt7g+Ty5+QT50meB/6WjsYt
         zPjeC/N3IclpF1I91C3CEWHGLt350XwW1P486jrXazuoqDj40rgwpaqfAMM19tCU9zpj
         e/2qZ517EtVDxfdvkY7tprMPvNevUISklaTFu3xZSK0beiQUch3NhiF1K49n5w447XTY
         XTdFrAykcygLKN9+NA2YmmIECPFhKbYf8Li2HXVUzMU3L638/kmfJP/dkCNNTxH24DEG
         xDTw==
X-Gm-Message-State: APjAAAUjgrsekCTqBQlRrmY/RfCSSEp8RdMAWtjFpToGibvHaUqR768z
        M60YXIoOc0UMpyC4unpmQ+iUltUF07Qwczsuup8=
X-Google-Smtp-Source: APXvYqxG7kojFXoxrvwgFJWF26TGzCj59QN4BaMvb9/n7O8ZNYHD1ePS7gf6uVzu2qrL6P5f6entl9tfF+fgW8wteW0=
X-Received: by 2002:ab0:6550:: with SMTP id x16mr19395636uap.27.1568274817314;
 Thu, 12 Sep 2019 00:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190912011306.14858-1-wqu@suse.com>
In-Reply-To: <20190912011306.14858-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 12 Sep 2019 08:53:26 +0100
Message-ID: <CAL3q7H7aycs+JooiFhGec38UK4coVbpjB491vdEGqwHhP_n5bg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: Fix the wrong io_tree when freeing
 reserved data space
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 2:31 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Commit bc42bda22345 ("btrfs: qgroup: Fix qgroup reserved space underflow =
by
> only freeing reserved ranges") is freeing wrong range in
> BTRFS_I()->io_failure_tree, which should be BTRFS_I()->io_tree.

I think you meant wrong tree and not wrong range, since the code
doesn't change the range, only the target tree.

Also, for the sake of completeness, and no matter how obvious you
think it is, can you explicitly mention what's the consequence? I
presume it's a qgroup reserved space leak or underflow.

Thanks.

>
> Just fix it.
>
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: bc42bda22345 ("btrfs: qgroup: Fix qgroup reserved space underflow =
by only freeing reserved ranges")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/qgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 2891b57b9e1e..64bdc3e3652d 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3492,7 +3492,7 @@ static int qgroup_free_reserved_data(struct inode *=
inode,
>                  * EXTENT_QGROUP_RESERVED, we won't double free.
>                  * So not need to rush.
>                  */
> -               ret =3D clear_record_extent_bits(&BTRFS_I(inode)->io_fail=
ure_tree,
> +               ret =3D clear_record_extent_bits(&BTRFS_I(inode)->io_tree=
,
>                                 free_start, free_start + free_len - 1,
>                                 EXTENT_QGROUP_RESERVED, &changeset);
>                 if (ret < 0)
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
