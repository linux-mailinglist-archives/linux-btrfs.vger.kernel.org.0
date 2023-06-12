Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B11D72C9E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 17:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjFLPZi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 11:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240636AbjFLPZ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 11:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B7810FC
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 08:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8534362ABC
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 15:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD12C433D2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686583524;
        bh=JqYRC1KNdOLwb+9QyQfoe+xsMbxTNCSO6c915FukS98=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jUBDjc0hTq+SRfS3HW6+MQg8sarwT5JYAHvlxX+QLQnTkhVlMNdHwWS4mRggBnXE2
         QVQy21MQ7z/SIW2lQxJDpd2lhJVEq3MccJi+lx6oPShq9L2p7FcPmzSSmF+3l+++Hi
         j0Y0psCj/uguiMPCHmulr91XQl/j9DgS5n/gdAGixvmVgNNhxKYDWwTkk8oOcqQt8l
         yTfqjhteP5CgCkSgyV1XzUBmRdeTwSatUSfelmIm/8v++Yij+GgicqwUVHUSxPADC6
         wv7kd2TvsmINOV3+uoaTYksHdWO7PPDu9gYJSmesp3veMv7pyLCfl6IfirCm870xMA
         fd54IZKwlupBQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-55ab0f777acso2514913eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 08:25:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDyZn5LxnwKou3lTpyEIQBFs9epWjaUKXTjy9i+3UAT0UN7r0yj2
        KcX5P3grssG5dXJHlZ+Z9o/8tmTGiBVHN1pb7O4=
X-Google-Smtp-Source: ACHHUZ7CBxIafmRDmqZRtzWqL8Aw/sBPGPA2NZpxxED+Dekoo8rQz/DEx28nIT9cWMp42MFat9cwOiPRqaQixdq+FKo=
X-Received: by 2002:a05:6820:13c:b0:558:b550:e81 with SMTP id
 i28-20020a056820013c00b00558b5500e81mr5240465ood.2.1686583524055; Mon, 12 Jun
 2023 08:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230609175341.1618652-1-clm@fb.com>
In-Reply-To: <20230609175341.1618652-1-clm@fb.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 12 Jun 2023 16:24:48 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7FFz_1_fqRthYVKRVfZGF_KzRJn=92eR0NDZMbaf0LCw@mail.gmail.com>
Message-ID: <CAL3q7H7FFz_1_fqRthYVKRVfZGF_KzRJn=92eR0NDZMbaf0LCw@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: can_nocow_file_extent should pass down
 args->strict from callers
To:     Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 9, 2023 at 7:17=E2=80=AFPM Chris Mason <clm@fb.com> wrote:
>
> 619104ba453ad0 changed our call to btrfs_cross_ref_exist() to always
> pass false for the 'strict' parameter.  We're passing this down through
> the stack so that we can do a full check for cross references during
> swapfile activation.
>
> With strict always false, this test fails:
>
> btrfs subvol create swappy
> chattr +C swappy
> fallocate -l1G swappy/swapfile
> chmod 600 swappy/swapfile
> mkswap swappy/swapfile
>
> btrfs subvol snap swappy swapsnap
> btrfs subvol del -C swapsnap
>
> btrfs fi sync /
> sync;sync;sync
>
> swapon swappy/swapfile
>
> The fix is to just use args->strict, and everyone except swapfile
> activation is passing false.
>
> Fixes: 619104ba453ad0 ("btrfs: move common NOCOW checks against a file ex=
tent into a helper")
> Signed-off-by: Chris Mason <clm@fb.com>

Looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 19c707bc8801..e57d9969bd71 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1864,7 +1864,7 @@ static int can_nocow_file_extent(struct btrfs_path =
*path,
>
>         ret =3D btrfs_cross_ref_exist(root, btrfs_ino(inode),
>                                     key->offset - args->extent_offset,
> -                                   args->disk_bytenr, false, path);
> +                                   args->disk_bytenr, args->strict, path=
);
>         WARN_ON_ONCE(ret > 0 && is_freespace_inode);
>         if (ret !=3D 0)
>                 goto out;
> --
> 2.34.1
>
