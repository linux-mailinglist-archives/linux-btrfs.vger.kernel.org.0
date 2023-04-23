Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D37E6EBE42
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Apr 2023 11:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDWJXI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Apr 2023 05:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDWJXH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Apr 2023 05:23:07 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE51736;
        Sun, 23 Apr 2023 02:23:06 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 3f1490d57ef6-b8ed0d0a33dso4832409276.1;
        Sun, 23 Apr 2023 02:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682241786; x=1684833786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4p45Ei1h+d04FWK39Ceoy+p6mxdk7RgkQcNsvmtw7k=;
        b=mHWOGx7br5znrdiC3j0EV4ywsfZCd1sUgDdvus8FJ0KPyOfxBhKIK8pdSjknbAhsuN
         cb/CI2cm1jt7cjVD14r05GyD3jtGy1wN7dmHwN50K+wAIyAFC/pu8jnCcEZnESs6rtE5
         UvtwfsQ+HWRTyO9qBz8+lmKpCvGJqIPZoMExyyHe81oFiyH3dM8MZybUZYEQh2K/gkrC
         esH8Aeq8am6KuX+qtODkgirSj1jtLxxAad42/ig7LAVgGzMgHTbremkGWhxRYt938bmg
         OVmWkSlQxDzC2sLSGTATL2/PJUWDL0Ut6VscYQkg1/k9vMMxwFGZJKDzJY32c7bV2PBY
         wmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682241786; x=1684833786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4p45Ei1h+d04FWK39Ceoy+p6mxdk7RgkQcNsvmtw7k=;
        b=Bc0WIS60P3yltu1zww4wYmbXB4Nj0ps/JpD1WGIWZ/SeNtdJv6MC9IJW2w8JSxGYij
         xvjt9PEIBI0k4hqvfrWbh+psTeLydVwIjshIZWy1TMDurGEUFU0lTUns9hsIJuljFk22
         2zwnttJreHEWJUuyVqwwu658xt6lN7C543MeyXW72Wb9nlaQsYe8o/SK07Nx5zNVLRPP
         XAVn7n94sVPOJ0oc39IPFXHTWM4MFuaNGDEZGmT1q+I7CeBmgWbtjkeAItjTdpgLWB8D
         de+2O8p0qJZbx+CNeCUFoJpE6o/Fyb9+ycdFrnrPI9p1XzGfXtp/FMOQP9hBZJ/A5Vwh
         hXCQ==
X-Gm-Message-State: AAQBX9fm82I0Nk1nqZppmUxn4w35f1fJdXfhYeEnU3sW+c0abreYTlcm
        47zKNcgZz/WgrkaGNf00z6Dd+BML9TqRKfJWH+c=
X-Google-Smtp-Source: AKy350aGid2DLoaauz/3Wi+NjfOXdn7cI4Q3XMeZJq7cq/dTu7adV8qrQjl3j3q5XUlvEZCDBoH8psBwL1rk4szq4TI=
X-Received: by 2002:a25:ce47:0:b0:b99:75f:8f1d with SMTP id
 x68-20020a25ce47000000b00b99075f8f1dmr7226471ybe.37.1682241785557; Sun, 23
 Apr 2023 02:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230324020838.67149-1-zhanggenjian@kylinos.cn> <20230406191204.GZ19619@twin.jikos.cz>
In-Reply-To: <20230406191204.GZ19619@twin.jikos.cz>
From:   genjian zhang <zhanggenjian123@gmail.com>
Date:   Sun, 23 Apr 2023 17:21:53 +0800
Message-ID: <CAOd03yRsQATvvnV=U-RZvuKXrio-Wb-+nFZiYN45CgeEYOgWgw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix uninitialized variable warning
To:     dsterba@suse.cz
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 7, 2023 at 3:12=E2=80=AFAM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Fri, Mar 24, 2023 at 10:08:38AM +0800, Genjian wrote:
> > From: Genjian Zhang <zhanggenjian@kylinos.cn>
> >
> > compiler warning:
> >
> > ../fs/btrfs/volumes.c: In function =E2=80=98btrfs_init_new_device=E2=80=
=99:
> > ../fs/btrfs/volumes.c:2703:3: error: =E2=80=98seed_devices=E2=80=99 may=
 be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >  2703 |   btrfs_setup_sprout(fs_info, seed_devices);
> >       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > ../fs/btrfs/send.c: In function =E2=80=98get_cur_inode_state=E2=80=99:
> > ../include/linux/compiler.h:70:32: error: =E2=80=98right_gen=E2=80=99 m=
ay be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >    70 |   (__if_trace.miss_hit[1]++,1) :  \
> >       |                                ^
> > ../fs/btrfs/send.c:1878:6: note: =E2=80=98right_gen=E2=80=99 was declar=
ed here
> >  1878 |  u64 right_gen;
> >       |      ^~~~~~~~~
> >
> > Initialize the uninitialized variables.
> >
> > Reported-by: k2ci <kernel-bot@kylinos.cn>
> > Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
>
> The warnings are still reported by other build reports so I'll apply
> this patch. If you have found more please send a patch or I can update
> this one once applied. Thanks.

Sorry for the late reply.
At present, only this one has been found.
Thanks.
