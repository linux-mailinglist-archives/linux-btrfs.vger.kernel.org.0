Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615A95FEC89
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 12:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJNKY6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 06:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJNKYy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 06:24:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940D51F637
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 03:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F04361AC0
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 10:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F477C433C1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 10:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665743091;
        bh=JR1P8Ji6W8CuZWOBb8WM9a9zItOXK0YAr10nEx4Tow4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SBy+hN+hThnhhCV2UmS6zBUDrO+/41Pw3DxMl+2w8wzv1E5t8PdSfIH7ddcG+wutw
         7yXUwq+g1leO1mMPHbmZ9FztIx0bGeOGLKbrRLw6sMn4ITDb+ZFoDKuQOLlYHsiovP
         fX7ecvlqyFwdMO8KH2bAV3owO4MA691822oCUTAgLNQ2uHqvodEPt/5ZVPZ0sSy6dy
         fr3joOXodrw9xgd9DiUcCggfFUqjeKa0bzibGKQNiVlWdRfFOGvJwclrPAm3C3sbel
         16uuAhhI9bnePUTVimmsB7f5eI84K1lddw0WTQaVwmOe5eq0NDYyoHnFBej/hCijTR
         bkVurdctoxG0A==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1326637be6eso5286378fac.13
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 03:24:51 -0700 (PDT)
X-Gm-Message-State: ACrzQf3Vf8rutTzR6Oc+stwrn6y2J63rofUqX9Fnwzf8Ca+/3tgmvS5F
        KBVFQcwv4d1k3USHeQr07ybysoc+T+NuuM48w40=
X-Google-Smtp-Source: AMsMyM6bi1PSj6w86ET4p6gG1qXGqLGKP6y8uj8GU7IS7Isva0wtk1IfwHbs0QVbhwAlBI4uEBwoUmm31sT9zZLuLg8=
X-Received: by 2002:a05:6870:2052:b0:132:7b2:2fe6 with SMTP id
 l18-20020a056870205200b0013207b22fe6mr2311729oad.98.1665743090758; Fri, 14
 Oct 2022 03:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1665701210.git.boris@bur.io>
In-Reply-To: <cover.1665701210.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 14 Oct 2022 11:24:14 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6qX=uJdz1ajXWoHQwCqw8wEp-CWaVSL9Te4NyMSymDpA@mail.gmail.com>
Message-ID: <CAL3q7H6qX=uJdz1ajXWoHQwCqw8wEp-CWaVSL9Te4NyMSymDpA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] btrfs: minor reclaim tuning
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 13, 2022 at 11:52 PM Boris Burkov <boris@bur.io> wrote:
>
> Two minor reclaim fixes that reduce relocations when they aren't quite
> necessary. These are a basic first step in a broader effort to reduce
> the alarmingly high rate of relocation we have observed in production
> at Meta.
>
> The first patch skips empty relocation.
>
> The second patch skips relocation that no longer passes the reclaim
> threshold check at reclaim time.
>
> Changes in v2:
> - added the re-check patch
> - improved commit message and comment in the skip-empty patch.
>
> Boris Burkov (2):
>   btrfs: skip reclaim if block_group is empty
>   btrfs: re-check reclaim condition in reclaim worker

Makes sense and both patches look good to me, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
>  fs/btrfs/block-group.c | 83 +++++++++++++++++++++++++++++-------------
>  1 file changed, 58 insertions(+), 25 deletions(-)
>
> --
> 2.38.0
>
