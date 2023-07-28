Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF7076739E
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 19:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjG1RlU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 13:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjG1RlS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 13:41:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D01C3A8C
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 10:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C93A5621BE
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 17:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9A7C433C9
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690566076;
        bh=HZ6+fpNYeruB12GHNWzL+8wyNB6KBAhjxkMWKcOtBU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K6eTDom9JaFJE0EHQFJs/VfK00v3jeo8GRZjUVa0HobfNyvIHZhDait1sRas0qN2u
         wJiQBpnntTl1xtkX9vNInTcgUzvGAWAj8Mx72d/ZRkUOn2Nx925sD2QuVznbZnMXLA
         Jta96AgWGSxlciAfo8IT3HRznfVYze5iVZkP8XwxSvuLV2sgK2y/B95W+ZVPVvRJ/N
         /I5bKAIQVxMHku4t3FT5nMyIgOEqNOCwWv8juH+6Y6DTC6nTlQED8oDgYg5YjCcg3z
         TiQGDUvuJJ9aaUa5Zr8hGn9mGZx6chKZDZ0ZAZRe8UJDmELRLZF2S2+DMyM2GI0iwR
         mtJA+gP7j88dg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1bb75afeee3so1868472fac.0
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 10:41:16 -0700 (PDT)
X-Gm-Message-State: ABy/qLarGINJ6F3L9JadOCvJOngFyrlAu2YiHddYFrbQZnhEXkGHwRLN
        Sa1ALHNthKu/Rt4cQy8eHrPhbocL/5SKIi1Q3Sk=
X-Google-Smtp-Source: APBJJlEH42NX/vL19OfaNbVDzxHOGK7NWULyDhLfNSHvhirJ3vNtuBq8laSKuoO9ibRyFPbtB9aVmSd1jITdxxyOu9I=
X-Received: by 2002:a05:6870:d20c:b0:1bb:c0ee:5536 with SMTP id
 g12-20020a056870d20c00b001bbc0ee5536mr4228438oac.47.1690566075327; Fri, 28
 Jul 2023 10:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690541079.git.anand.jain@oracle.com> <ae10e7c26537465368445d379c660fc8be62ad8b.1690541079.git.anand.jain@oracle.com>
In-Reply-To: <ae10e7c26537465368445d379c660fc8be62ad8b.1690541079.git.anand.jain@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 28 Jul 2023 18:40:39 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6nGQWdvpNr6GUC_4eGpveH5ttdqn78XXFw0Ux-A+7MLg@mail.gmail.com>
Message-ID: <CAL3q7H6nGQWdvpNr6GUC_4eGpveH5ttdqn78XXFw0Ux-A+7MLg@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: simplify memcpy for either metadata_uuid or fsid.
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
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

On Fri, Jul 28, 2023 at 5:43=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> This change makes the code more readable.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 5678ca9b6281..4ce6c63ab868 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -833,14 +833,10 @@ static noinline struct btrfs_device *device_list_ad=
d(const char *path,
>                     found_transid > fs_devices->latest_generation) {
>                         memcpy(fs_devices->fsid, disk_super->fsid,
>                                         BTRFS_FSID_SIZE);
> -
> -                       if (has_metadata_uuid)
> -                               memcpy(fs_devices->metadata_uuid,
> -                                      disk_super->metadata_uuid,
> -                                      BTRFS_FSID_SIZE);
> -                       else
> -                               memcpy(fs_devices->metadata_uuid,
> -                                      disk_super->fsid, BTRFS_FSID_SIZE)=
;
> +                       memcpy(fs_devices->metadata_uuid,
> +                              has_metadata_uuid ?
> +                               disk_super->metadata_uuid : disk_super->f=
sid,
> +                              BTRFS_FSID_SIZE);

While there's less lines of code, I don't find having a long ternary
operation in the middle of a function call, split in two lines, more
readable than the existing if-else statement, quite the contrary.

Maybe I'm just being picky...

Thanks.

>
>                         fs_devices->fsid_change =3D false;
>                 }
> --
> 2.38.1
>
