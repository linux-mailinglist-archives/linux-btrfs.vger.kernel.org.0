Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33D65764B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Dec 2022 13:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiL1MF3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 28 Dec 2022 07:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiL1MFY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Dec 2022 07:05:24 -0500
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3487CEB
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 04:05:23 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id g16so6212905plq.12
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 04:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5y0OHT7ESV5TEzPB7U6j3ppz3zUbCEDRbHaNKA9cFUU=;
        b=O15ETtLKIkVX0iGj1hPuBSVw+bv49CGf44oA5a+miiQBf+5o/pZlRavXHlN+HUUa9t
         DT70jRe6himey6NBRLPfx96EmNJOcGbIAlDxWmxblHfsblEdu4S/3gcXHtUASwQ2yc53
         8kjaRW4kU2DmLP7wM+OOpoirLy3ws1Uwkc132DPE6DvBfresvtIbrYuiiX5lCpW2Eurf
         MGNURG6rmALzeYQB5jBLxuI9eF5Q+0czltxs80F/GL/qxKFuJMT87DOeNkyFpmsSkKUB
         G1WKxz0Y6aRJLR1OKLxCpa5/2Xc5Rvzd5nzjVC2/hWOWUnUz2vbfSpCz8SH+88pArFd6
         m+pQ==
X-Gm-Message-State: AFqh2kr3NVW0xDfq/b6584liQ2hR+hKkRkrUO+ixjUITEiVnjTknxVo1
        Zi6uk99+7+RefRv0XsR8kIGTLAc7B5Y=
X-Google-Smtp-Source: AMrXdXtOiV+cgdRLtjq2De4E9Ap0vdaFnDX3LaS2c9WpElpgZAnz7zZf5nY25TEv9QNVmDUfEMtplw==
X-Received: by 2002:a17:903:40c8:b0:189:ab82:53f5 with SMTP id t8-20020a17090340c800b00189ab8253f5mr20116959pld.40.1672229122880;
        Wed, 28 Dec 2022 04:05:22 -0800 (PST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com. [209.85.210.182])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ec8500b0017854cee6ebsm10925099plg.72.2022.12.28.04.05.21
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 04:05:21 -0800 (PST)
Received: by mail-pf1-f182.google.com with SMTP id x26so4357498pfq.10
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 04:05:21 -0800 (PST)
X-Received: by 2002:a63:5f57:0:b0:461:4039:88d1 with SMTP id
 t84-20020a635f57000000b00461403988d1mr1779478pgb.568.1672229121417; Wed, 28
 Dec 2022 04:05:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1672120480.git.wqu@suse.com> <fd138f8678808717635a145832c1b13320ce6cd2.1672120480.git.wqu@suse.com>
In-Reply-To: <fd138f8678808717635a145832c1b13320ce6cd2.1672120480.git.wqu@suse.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Wed, 28 Dec 2022 07:04:45 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8MQ39PmDB7rueJa5MeDuZtiX4BMDfDNgP0G5z37EHcXA@mail.gmail.com>
Message-ID: <CAEg-Je8MQ39PmDB7rueJa5MeDuZtiX4BMDfDNgP0G5z37EHcXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: fix the wrong timestamp and UUID check
 for root items
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 27, 2022 at 1:10 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Since commit d729048be6ef ("btrfs-progs: stop using
> btrfs_root_item_v0"), "btrfs subvolume list" not longer correctly report
> UUID nor timestamp, while older (btrfs-progs v6.0.2) still works
> correct:
>
>  v6.0.2:
>  # btrfs subv list -u  /mnt/btrfs/
>  ID 256 gen 12 top level 5 uuid ed4af580-d512-2644-b392-2a71aaeeb99e path subv1
>  ID 257 gen 13 top level 5 uuid a22ccba7-0a0a-a94f-af4b-5116ab58bb61 path subv2
>
>  v6.1:
>  # ./btrfs subv list -u /mnt/btrfs/
>  ID 256 gen 12 top level 5 uuid -                                    path subv1
>  ID 257 gen 13 top level 5 uuid -                                    path subv2
>
> [CAUSE]
> Commit d729048be6ef ("btrfs-progs: stop using btrfs_root_item_v0")
> removed old btrfs_root_item_v0, but incorrectly changed the check for
> v0 root item.
>
> Now we will treat v0 root items as latest root items, causing possible
> out-of-bound access. while treat current root items as older v0 root
> items, ignoring the UUID nor timestamp.
>
> [FIX]
> Fix the bug by using correct checks, and add extra comments on the
> branches.
>
> Issue: #562
> Fixes: d729048be6ef ("btrfs-progs: stop using btrfs_root_item_v0")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  cmds/subvolume-list.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
> index 6d5ef509ae67..7cdb0402b8e5 100644
> --- a/cmds/subvolume-list.c
> +++ b/cmds/subvolume-list.c
> @@ -870,14 +870,21 @@ static int list_subvol_search(int fd, struct rb_root *root_lookup)
>                                 ri = (struct btrfs_root_item *)(args.buf + off);
>                                 gen = btrfs_root_generation(ri);
>                                 flags = btrfs_root_flags(ri);
> -                               if(sh.len <
> -                                  sizeof(struct btrfs_root_item)) {
> +                               if(sh.len >= sizeof(struct btrfs_root_item)) {
> +                                       /*
> +                                        * The new full btrfs_root_item with
> +                                        * timestamp and UUID.
> +                                        */
>                                         otime = btrfs_stack_timespec_sec(&ri->otime);
>                                         ogen = btrfs_root_otransid(ri);
>                                         memcpy(uuid, ri->uuid, BTRFS_UUID_SIZE);
>                                         memcpy(puuid, ri->parent_uuid, BTRFS_UUID_SIZE);
>                                         memcpy(ruuid, ri->received_uuid, BTRFS_UUID_SIZE);
>                                 } else {
> +                                       /*
> +                                        * The old v0 root item, which doesn't
> +                                        * has timestamp nor UUID.
> +                                        */
>                                         otime = 0;
>                                         ogen = 0;
>                                         memset(uuid, 0, BTRFS_UUID_SIZE);
> --
> 2.39.0
>

Resolves: rhbz#2156710

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
