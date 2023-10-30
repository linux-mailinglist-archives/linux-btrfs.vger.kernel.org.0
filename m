Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360387DBDAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 17:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjJ3QVv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 12:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjJ3QVt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 12:21:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D6183
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 09:21:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37E7C433CC;
        Mon, 30 Oct 2023 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698682906;
        bh=jorEVQNmviCRK1NUvp49LAdwzoiZs0R8xP/O417ddxM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n9O8sR5bzGh3bhsqVQICSCat3metYeeniR8SA1q7oyDHr+f4OUV0Bw0Rn2Bsj2YzQ
         4P/zwJBQUEoRsd72ikzc5drGh5NJlfubutERhfqeSKbNBL/6kF7lUvHWPaDlkCcmuw
         M1vA/e0Pn7bbYN4violbYpf8zSJZTXCIa3o/QQnyYBCDQrckGLd8944L7T2ODX0Orh
         NDEZiQbzGtV1fUbBk2XFL0CCIrQnmj0peJ5DdobKI34yE2D3R9+mIBQZg7v5lRciIU
         q1HYJD6hCof4z9T/ZU+S9TzyQ5FNk9AP/DEe8LxZ5lwj6Xc6ufnsvTBZbpYfuP4f6d
         NHeyqGOncWayw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99de884ad25so719329166b.3;
        Mon, 30 Oct 2023 09:21:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YwTWoKVyRrA9dpmAyaXCSV35nXIICDksHRcou9Osah4ysciaEnK
        rl8bTIM9RhpHuyNOyhwx7fTG55UN53nCMtpJpjc=
X-Google-Smtp-Source: AGHT+IHgGOHZYCEeqdRj08UHwIGEcNFMP/ZCDAksvXdqmrF/eX+DFN3/An+xZ7km+t1CDKNGsEcY8RNCqAeQ9hdYWrE=
X-Received: by 2002:a17:907:1c9f:b0:9bd:e3ae:ef57 with SMTP id
 nb31-20020a1709071c9f00b009bde3aeef57mr9531962ejc.60.1698682905378; Mon, 30
 Oct 2023 09:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698674332.git.anand.jain@oracle.com> <1f320bb0c1e11dbe441dd44eac006873de5f267c.1698674332.git.anand.jain@oracle.com>
In-Reply-To: <1f320bb0c1e11dbe441dd44eac006873de5f267c.1698674332.git.anand.jain@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 30 Oct 2023 16:21:08 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7P+U0a2a4SeeQKXm3-jDZcnoXhrM_4mMHdTiM_iG7dvQ@mail.gmail.com>
Message-ID: <CAL3q7H7P+U0a2a4SeeQKXm3-jDZcnoXhrM_4mMHdTiM_iG7dvQ@mail.gmail.com>
Subject: Re: [PATCH 2/6 v3] common/rc: _destroy_loop_device confirm arg1 is set
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 30, 2023 at 2:15=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Check if the dev arg1 is set before calling losetup -d on it.

Why?

Do we have any callers that call the function without an argument?
More comments below.

>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/rc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/common/rc b/common/rc
> index 18d2ddcf8e35..e7d6801b20e8 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4150,7 +4150,10 @@ _create_loop_device()
>  _destroy_loop_device()
>  {
>         local dev=3D$1
> -       losetup -d $dev || _fail "Cannot destroy loop device $dev"
> +
> +       if [ ! -z $dev ]; then
> +               losetup -d $dev || _fail "Cannot destroy loop device $dev=
"
> +       fi

So this is just ignoring if no argument is given and the function does noth=
ing.
This is quite the opposite of everywhere else, where we error out if a
necessary argument is missing.

btrfs/219 never calls this function without the argument, both before
and after this patchset, so I don't see why this patch is needed.
If we have any callers not passing the argument, I'd rather fix them
and make the function error out if no argument is given.

Thanks.

>  }
>
>  _scale_fsstress_args()
> --
> 2.39.3
>
