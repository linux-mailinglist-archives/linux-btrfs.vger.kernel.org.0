Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FE58FF14
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 11:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfHPJd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 05:33:27 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39858 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfHPJd0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 05:33:26 -0400
Received: by mail-vs1-f66.google.com with SMTP id u3so3315028vsh.6
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 02:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=pvOgSCEGBu7BW9MurmGXSHcedRMSGRPU6MTqks84iHY=;
        b=TavLli682I+JrnlUBsDmAFsT+X5W8hLZ9qpRCn/vW0nR+KV080bMcaxcETmQ1Qzi2Y
         a9MqDUcygnbwPfgeJTh+xu/9Uk/ii4MlAmMPWi7liZDCr7c0TuYlEm09887WWiqU3S2w
         llE3aatwm0gZom/E66DSMTLeMOAm99/BOQuk65mYZNzt/QQmqR8YW1QsF9eNwLVZpy1q
         JlLRUtsLpKry0RUyvrvycO7KTYwE/kBEfiCoGqtcU/BodYinD6USdPIRjaFcfuamMlcW
         cexjYvHsaf6RO+SdPOce8tRb8cg17yA4q5FIaneZB8VFaJ9iUdp/2IMQiEkji51Lb+9c
         imUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=pvOgSCEGBu7BW9MurmGXSHcedRMSGRPU6MTqks84iHY=;
        b=ta+h+b1XFnBSkZrHay4dCxRcXv2DpXTC0ky+l+gpw8dbrNfzaMAnABzYoIxxKXwi1u
         DD408ty8Pi7FSeUhWZlSjQlCidYohpLm0QuxMpJWbcmXk4gIRK9kuZeLC1x9Hx2uyBnl
         CBbBsRuiZiZNx24E5+XcTu7Nusi/55UEthKp97OipXcSvmSIBIiLfZ5PUYWtCpSaGW/k
         fW/OhxC+NVRvT0C/HQoLiHfZQegRs9YXfhnL2Jhfu10m3HzrjZHEcSbMsV7VP3osW3MD
         pFYD9yvS6jwSfOFFfOvAruv9ksDKQ5LqfNkpDx6RjrnoM9QCCTTlNW3J6VComzA35EnI
         yynw==
X-Gm-Message-State: APjAAAW18t7HrNSsqz74KHl9kGw2MT5Ah4CxYFOPNoQhUpHHUD0tSEEY
        WxOUZEU3MTuMxILBSuVsmRg5NyeWJsV7BU7CjaZwDxPp
X-Google-Smtp-Source: APXvYqxeiejtx2hR6o7f99kZYypmPdT2u4zMxLhoBYtMgBJHGVP72lTMM090S5p+mjdIUcxl4qDiQSdaaGtNgbSnaNQ=
X-Received: by 2002:a67:f3d6:: with SMTP id j22mr5348612vsn.95.1565948005953;
 Fri, 16 Aug 2019 02:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190815080404.20600-1-wqu@suse.com>
In-Reply-To: <20190815080404.20600-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 16 Aug 2019 10:33:15 +0100
Message-ID: <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: transaction: Commit transaction more frequently
 for BPF
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 15, 2019 at 9:36 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Btrfs has btrfs_end_transaction_throttle() which could try to commit
> transaction when needed.
>
> However under most cases btrfs_end_transaction_throttle() won't really
> commit transaction, due to the hard timing requirement.
>
> Now introduce a new error injection point, btrfs_need_trans_pressure(),
> to allow btrfs_should_end_transaction() to return 1 and
> btrfs_end_transaction_throttle() to fallback to
> btrfs_commit_transaction().
>
> With such more aggressive transaction commit, we can dig deeper into
> cases like snapshot drop.
> Now each reference drop of btrfs_drop_snapshot() will lead to a
> transaction commit, allowing dm-logwrites to catch more details, other
> than one big transaction dropping everything.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add comment to explain why this function is needed
> ---
>  fs/btrfs/transaction.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 3f6811cdf803..8c5471b01d03 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -10,6 +10,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/blkdev.h>
>  #include <linux/uuid.h>
> +#include <linux/error-injection.h>
>  #include "ctree.h"
>  #include "disk-io.h"
>  #include "transaction.h"
> @@ -749,10 +750,25 @@ void btrfs_throttle(struct btrfs_fs_info *fs_info)
>         wait_current_trans(fs_info);
>  }
>
> +/*
> + * This function is to allow BPF to override the return value so that we=
 can
> + * make btrfs to commit transaction more aggressively.
> + *
> + * It's a debug only feature, mainly used with dm-log-writes to catch mo=
re details
> + * of transient operations like balance and subvolume drop.

Transient? I think you mean long running operations that can span
multiple transactions.

> + */
> +static noinline bool btrfs_need_trans_pressure(struct btrfs_trans_handle=
 *trans)
> +{
> +       return false;
> +}
> +ALLOW_ERROR_INJECTION(btrfs_need_trans_pressure, TRUE);

So, I'm not sure if it's really a good idea to have such specific
things like this.
Has this proven useful already? I.e., have you already found any bug using =
this?

I often add such similar things myself for testing and debugging, but
because they are so specific, or ugly or verbose, I keep them to
myself.

Allowing the return value of should_end_transaction() to be
overridden, using the same approach, would be more generic for
example.

Thanks.

> +
>  static int should_end_transaction(struct btrfs_trans_handle *trans)
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>
> +       if (btrfs_need_trans_pressure(trans))
> +               return 1;
>         if (btrfs_check_space_for_delayed_refs(fs_info))
>                 return 1;
>
> @@ -813,6 +829,8 @@ static int __btrfs_end_transaction(struct btrfs_trans=
_handle *trans,
>
>         btrfs_trans_release_chunk_metadata(trans);
>
> +       if (throttle && btrfs_need_trans_pressure(trans))
> +               return btrfs_commit_transaction(trans);
>         if (lock && READ_ONCE(cur_trans->state) =3D=3D TRANS_STATE_BLOCKE=
D) {
>                 if (throttle)
>                         return btrfs_commit_transaction(trans);
> --
> 2.22.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
