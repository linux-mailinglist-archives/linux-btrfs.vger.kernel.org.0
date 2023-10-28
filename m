Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FE87DA6A6
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Oct 2023 13:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjJ1LKC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Oct 2023 07:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJ1LKB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Oct 2023 07:10:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5AAB4
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Oct 2023 04:09:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98870C433C7;
        Sat, 28 Oct 2023 11:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698491399;
        bh=fsZh7F34DWdcWjhD/YNCEhJ1lZ/E1/1pAk3CZbPpY3Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PvZ8iDdTveDRVgVlTU8azVWRCzbgcEzP5S1tFB01DXdwCnphcJeu2dvQJHDLOKh2/
         AqKAgijSHTHe4XZ4Dfa9rgWXepZwmzg55+2DMAutBvNXLCHQDMmzTV0BUglDczl3+z
         2L/JIBqNl+6MXagZzSEWESapuPfWv9gYMB49swwtsyKR7YU+IRMfe3VdJyN+w+7rmM
         14Pcty6e1aQnQQAHnjf5aJx6b/3285RLhYZ2N4p0EIz9dN3h9j0cMNiJeMDtnIP5ds
         8Tllj8bUdyYwH0UXV0c54aWAW1T2QZ1X+fcHY6Bp351/ekm60LIlcfXR+AxngH6a/a
         r62phSKkb+Yfg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9c41e95efcbso404009266b.3;
        Sat, 28 Oct 2023 04:09:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YyPNzc5W0I0nbLjnWd5urzVgoRI1jdjkNCSzisaGt01a1B8YZ6f
        cYxJKpbStsfu24aeJddxAZ9K7BIHNlzI9E71Ghs=
X-Google-Smtp-Source: AGHT+IFXmNsQ6cyP4vV49wGU6OTN8gk0VvJAb6uxlUmvCGPsAo4rnUI1UQR6UCEXfXVP/27+agwtlj13dSk5FRdXbZg=
X-Received: by 2002:a17:906:db09:b0:9ad:f7e5:67d9 with SMTP id
 xj9-20020a170906db0900b009adf7e567d9mr4152778ejb.4.1698491398051; Sat, 28 Oct
 2023 04:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698418886.git.anand.jain@oracle.com> <678808b10d005e976f5e299816b63c8e6fa44c4a.1698418886.git.anand.jain@oracle.com>
In-Reply-To: <678808b10d005e976f5e299816b63c8e6fa44c4a.1698418886.git.anand.jain@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Sat, 28 Oct 2023 12:09:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7O2U-Gc7t9EHv0aJSBA5MDouK02b=6RNtgyfg3_crhqA@mail.gmail.com>
Message-ID: <CAL3q7H7O2U-Gc7t9EHv0aJSBA5MDouK02b=6RNtgyfg3_crhqA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] common/rc: _fs_sysfs_dname fetch fsid using btrfs tool
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 27, 2023 at 4:14=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Currently _fs_sysfs_dname gets fsid from the findmnt command however
> this command provides the metadata_uuid in the context device is
> mounted with temp-fsid. So instead, use btrfs filesystem show command to
> know the temp-fsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: new.
>
>  common/rc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/common/rc b/common/rc
> index 259a1ffb09b9..deeffe4228d4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4728,7 +4728,9 @@ _fs_sysfs_dname()
>
>         case "$FSTYP" in
>         btrfs)
> -               findmnt -n -o UUID ${dev} ;;
> +               fsid=3D$($BTRFS_UTIL_PROG filesystem show ${dev} | grep u=
uid: | \
> +                                                       awk '{print $NF}'=
)

Please make the variable local.

Thanks.

> +               echo $fsid ;;
>         *)
>                 _short_dev $dev ;;
>         esac
> --
> 2.39.3
>
