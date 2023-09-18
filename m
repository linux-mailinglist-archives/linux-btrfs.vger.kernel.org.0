Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949237A4BF2
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbjIRPXv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 18 Sep 2023 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbjIRPXq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 11:23:46 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01E9E46;
        Mon, 18 Sep 2023 08:19:50 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-274e392a5c1so1236660a91.0;
        Mon, 18 Sep 2023 08:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050371; x=1695655171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/mKGTUlAngbWqVQW8HQgc5DCyPZMwyYYwQ45BPoCOU=;
        b=B/psuPlihCzFDvK9koiiItKUG9AS9YFLM7FNUTVspdusonUufHXnDM57w50uNChrvl
         NwYFSMBw2YMlkOXn6M806jmuOprZpHDa/j9VdS0cPaUaGtco4H/+1sUUayPQfmHScUo4
         av8zuZ0+RZt9kpkUfFqOzfnkigwmPsv0HhmLqu1uHTcpiU1Lo+2Wwjz2eMbDcrJAbuHU
         cD21ax3jEmPRBsG0CvC6PM3KDw6j2OTw2+EM1JdKMyPMu51sSRqQQ5xCVoirzKbqymp8
         RJXkq1XELIogmvzCx+U7P+CTtsec5Cy29/jEP60+QnDgHDGl6lCRG97j4al2Db3rzl2k
         RE8w==
X-Gm-Message-State: AOJu0YxJQZnWgjvGAFHU6nX8FmrsAPMJFMoH0cGbm9s8z562F4f5oqCD
        3fN3mu3ZCqynW2OdA3pKbJoAZcV2klNpMw==
X-Google-Smtp-Source: AGHT+IE0fOlMzc43BYopSendIeKtgKVxQwStxJi3iYLxzmYJoK32kF8fO65W7avmxGTqjyoZ1CXfQQ==
X-Received: by 2002:a25:4096:0:b0:d7a:d307:dd61 with SMTP id n144-20020a254096000000b00d7ad307dd61mr7614792yba.47.1695046745591;
        Mon, 18 Sep 2023 07:19:05 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id e202-20020a25e7d3000000b00d7b9fab78bfsm2322158ybh.7.2023.09.18.07.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 07:19:05 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59be9a09c23so45110407b3.1;
        Mon, 18 Sep 2023 07:19:05 -0700 (PDT)
X-Received: by 2002:a0d:c543:0:b0:592:1bab:52bd with SMTP id
 h64-20020a0dc543000000b005921bab52bdmr9048947ywd.39.1695046745247; Mon, 18
 Sep 2023 07:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com> <20230918-rst-updates-v1-1-17686dc06859@wdc.com>
In-Reply-To: <20230918-rst-updates-v1-1-17686dc06859@wdc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 16:18:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWM3_cj4Nb96pZQfErx7n+0Cd7RUQZV+bpvr1Tz5T3sgw@mail.gmail.com>
Message-ID: <CAMuHMdWM3_cj4Nb96pZQfErx7n+0Cd7RUQZV+bpvr1Tz5T3sgw@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: fix 64bit division in btrfs_insert_striped_mirrored_raid_extents
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Johannes,

On Mon, Sep 18, 2023 at 4:14 PM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
> Fix modpost error due to 64bit division on 32bit systems in
> btrfs_insert_striped_mirrored_raid_extents.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Thanks for your patch!

> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -148,10 +148,10 @@ static int btrfs_insert_striped_mirrored_raid_extents(
>  {
>         struct btrfs_io_context *bioc;
>         struct btrfs_io_context *rbioc;
> -       const int nstripes = list_count_nodes(&ordered->bioc_list);
> -       const int index = btrfs_bg_flags_to_raid_index(map_type);
> -       const int substripes = btrfs_raid_array[index].sub_stripes;
> -       const int max_stripes = trans->fs_info->fs_devices->rw_devices / substripes;
> +       const size_t nstripes = list_count_nodes(&ordered->bioc_list);
> +       const enum btrfs_raid_types index = btrfs_bg_flags_to_raid_index(map_type);
> +       const u8 substripes = btrfs_raid_array[index].sub_stripes;
> +       const int max_stripes = div_u64(trans->fs_info->fs_devices->rw_devices, substripes);

What if the quotient does not fit in a signed 32-bit value?

>         int left = nstripes;
>         int i;
>         int ret = 0;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
