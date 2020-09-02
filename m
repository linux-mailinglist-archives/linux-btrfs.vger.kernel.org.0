Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C4B25A419
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 05:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIBDmP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 23:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIBDmN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 23:42:13 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CE5C061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 20:42:13 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d190so4350845iof.3
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 20:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MB1kqQXM33UBl50NyqyerSpt1Q7cpZY+sKx92nzCcyU=;
        b=uca1YhjPZezmac+fxBo7xqZwFnfjqZNsK5BMnVKTAl/QuDvY3HSLL8SU1knYFgrTaW
         hTKy4hbtVal3FYOoPjvP6ffhnX9cDg8YqUeeEQ/CfNTmGqQIkUG9K6j0wI1Da5EsFg8M
         IljueL8kCAAoa0eBUuizFEZ2LEN6RVrIp3xwIgHjEiqjc6+9XRLOcavpdK5kXPfsjA+O
         Jj2G5+MGNd7H+wuyhkGQEgsuhxKBCv/usEbO1X0lSduSxoVTRUvw7SZoqNr1OjifcI98
         3nL/t6OYoAAsc4ou9SqM2h3L5fJoseRhETL2r1qnBMt7vc+ZbZ3ZWzvIB0KAM9qqP88V
         XuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MB1kqQXM33UBl50NyqyerSpt1Q7cpZY+sKx92nzCcyU=;
        b=tgFN8ygO95lQIvUjY+V56sVnoxBLDXAnDaHaE2OC/LrkE9OmkxDtSv7zw6Dh8jWPDg
         7Ug1PNzP4Nx975FAxSWHqUI4WHju7Rr/5EC/OylljQH/454WBbM29m1mTOs/6Ywqv/kk
         XjZI7W35K6oyhuZqQSUIL1YnvDOPoNn/2SffLM8jQ7AFAAagbZNWU1F2OqcbgzgwW0Hd
         1WKsuUNJXYR3dvTQa6dEZisfeetL8FXIiu6FBrzKgTcRqRK1BcAT7n/zsPtvgfVX39l8
         QtuqcNr7fqTAN6L8QumoxfMnX7nTZdZUBKtF2ohQJkmQIocds+yVJhkyKt+BzIQ6FH5W
         Sukg==
X-Gm-Message-State: AOAM533OmIni+aGdkwOQb1+XROk0MAZ049/stiJHvobbeO2jWlChopsR
        UI5dGgL7zhDKq7Qv59v4DenJo+ELPmUawf1Xp4sns8O94VQ=
X-Google-Smtp-Source: ABdhPJzLhjCT1kL6683S2CpU7NU2VkhYP5aLizbsA6mcsTZ20F5hJZfHMSF8sDQ/MBLv/XQs0KrlX6BGHdvK3enAsmM=
X-Received: by 2002:a5d:8e14:: with SMTP id e20mr1916265iod.119.1599018132433;
 Tue, 01 Sep 2020 20:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <bf9594ea55ce40af80548888070427ad97daf78a.1598374255.git.josef@toxicpanda.com>
In-Reply-To: <bf9594ea55ce40af80548888070427ad97daf78a.1598374255.git.josef@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 1 Sep 2020 23:41:36 -0400
Message-ID: <CAEg-Je8r_znMC489DQUyJ9sypNSkVezJ48m99RtnHZ1g-VDREA@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: add a warning label for RAID5/6
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 25, 2020 at 12:51 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We all know there's some dark and scary corners with RAID5/6, but users
> may not know.  Add a warning message in mkfs so anybody trying to use
> this will know things can go very wrong.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  mkfs/main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 0a4de617..0db24ad4 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1183,6 +1183,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>         if ((data_profile | metadata_profile) &
>             (BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID6)) {
>                 features |=3D BTRFS_FEATURE_INCOMPAT_RAID56;
> +               warning("RAID5/6 support is still experimental and has kn=
own "
> +                       "issues, do not rely on this for data you care ab=
out.\n");
>         }
>
>         if ((data_profile | metadata_profile) &
> --
> 2.24.1
>

This looks good to me. It's unfortunate that we need this, though...

Reviewed-by: Neal Gompa <ngompa13@gmail.com>

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
