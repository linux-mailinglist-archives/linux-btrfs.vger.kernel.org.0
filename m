Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC424096B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 17:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346907AbhIMPHZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 11:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346473AbhIMPHW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 11:07:22 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19816C00F7A1;
        Mon, 13 Sep 2021 06:41:22 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id cf2so5460088qvb.10;
        Mon, 13 Sep 2021 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TQ/ua6a6n6ROb5TUoje1TeI9WAWedeILqs0fpPcCf4g=;
        b=q0OMdJTfkNDbi6R0nBQJNEaBecIQAcBgwpE7gjLKtGpM2kIp3eyG4R/iTi1bbx61UJ
         yxsB4HVT6zwVX9gpGhZNS3SCA2ixA7EWYlsxSH9Ogpq8h4ThdC3V1aJ+pEchdhu/HXPa
         p5Hrs+wuP/yfV4azGSdrgN84/j3jhaUZOFlExpfjTcox4xaWF2v1+64VNR9SojIe0jEp
         Zo4yBnj1dJBvXbqss5TV858CRdYVcKtxcBqwnCC+PDg4eSepFfB/F3bdx0CqENXuh4Or
         c6m1p//aPhNM3EydMfherhENvMBCce2OoBZb8fEh0f2qUCOvMGG33X3w6i7txcFgrKq7
         tYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TQ/ua6a6n6ROb5TUoje1TeI9WAWedeILqs0fpPcCf4g=;
        b=QnTq6VrHcaERC2FOsw4OkCTFgEWozFDAhbXyhDW3b85G/ie3t9H35Ed+L+odwZ+sP4
         W0heLGHIiJavNGWwCO8oXCenYGCrMJMNocb6BQAfUjftsORkOemcjydbpukwZbPl4AUh
         /kCqEFU3ovIQkHroOMt+74QncLmcEvzoYX9/q/BihNnjrPn9dDOoEeysLDIztBHbet8c
         jM5K+QrC3mE7PsEu8dkja1V4sYYfavVPg3qg7fkWEyIy0FlBuJuyveLmKcqsRhrWBxa4
         BwaFIsIevVgWNLFlyNUObfAPDOEAOPiF08Fw89i4mlibAHNVo6WeglkjwhHDFm8eN9MJ
         uHZQ==
X-Gm-Message-State: AOAM530y8oOLYr3g7ZjeGSVCA3OZLTl8/CWwdqDHmoSdzEU8DocnY4Dv
        FgN3Ar4LztMTMLV2YDTtmgVOjrJa7QmiKa/sy/1lY+2p8e4=
X-Google-Smtp-Source: ABdhPJyZpv2+49V3GAAovpfO4wJ+RWL2au3jZvQG2ubwwY61O8yWW82RWx0SGI38N2N7MS1XXn63GEfO7x+FD03qq2Y=
X-Received: by 2002:a0c:fb4f:: with SMTP id b15mr10606659qvq.20.1631540481309;
 Mon, 13 Sep 2021 06:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210913133226.39007-1-nborisov@suse.com>
In-Reply-To: <20210913133226.39007-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 13 Sep 2021 14:40:45 +0100
Message-ID: <CAL3q7H6rkvgboQKvcGiZgG-qzejg+vBiTK+xBejXkuQojpRVQw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Make 233 be part of subvol group
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 13, 2021 at 2:35 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
> All but this test use 'subvol' to designate they relate to btrfs
> subvolume functionality. For the sake of consistency make btrfs/233
> also be part of 'subvol' rather than 'subvolume'. This brings no
> functional changes.

There's already a pending patch for this, which also fixes the same
inconsistency for btrfs/245:

https://patchwork.kernel.org/project/fstests/patch/163062676513.1579659.125=
16104685003091290.stgit@magnolia/

Thanks.

>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  tests/btrfs/233 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/233 b/tests/btrfs/233
> index f3e3762c6951..6a4144433073 100755
> --- a/tests/btrfs/233
> +++ b/tests/btrfs/233
> @@ -9,7 +9,7 @@
>  # performed.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick subvolume
> +_begin_fstest auto quick subvol
>
>  # Override the default cleanup function.
>  _cleanup()
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
