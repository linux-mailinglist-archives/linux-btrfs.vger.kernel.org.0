Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060F17C60F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 01:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjJKXPh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 11 Oct 2023 19:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjJKXPg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 19:15:36 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE859D
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 16:15:33 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso740651a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 16:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697066132; x=1697670932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GVwmxsd4xm2lXrE5xKxeS6wd019VYCfukOoqrAHRpA=;
        b=KyWWVm9OIPFwtx1dYYpc3/FImfyQ865fDz7twF9HXFEG0OCwYx39svKjQCmZ1PHktP
         n9BAUaDX3+St1sTUqY0DUgT03bZhzoGbfFldLlg9xfWjnvHMzlnk295GBcoWdHX+susb
         W249YXJCcexyTOdiST21XQazVMKiYg1eH3WpcFAy0fhgIZZnRCYNhmLpEkb1WtJwXRwr
         ouDR7HljiuocsaZv2DMQMGCGtvUg5BvpcWQ46vAicWCzN1jT7jtjlznfo8Haf9UGWuTl
         zNg6MQosMkGksswUg7tqjWt3Ja+79LMxFypeWHFluD0VOceQVp8F89vbVa1Cn6nkT3+w
         5yYQ==
X-Gm-Message-State: AOJu0Yy8rwi2wzHol8Ekhx/djze00HqkSM2IT0B4G/q20QRV7E8C/A/N
        pU15wHPRgUCV6cxocN4ofYs3cORfzh7J2w==
X-Google-Smtp-Source: AGHT+IEhHFogvz2BuhzOR0GgGN0B8gTa9YsbwtVXYUeCTVN40aH3uxqGt1gr2hWLMougrmCs0rMrpw==
X-Received: by 2002:aa7:df0e:0:b0:52c:8a13:2126 with SMTP id c14-20020aa7df0e000000b0052c8a132126mr19992517edy.37.1697066131915;
        Wed, 11 Oct 2023 16:15:31 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id cw2-20020a056402228200b0053dea07b669sm1007743edb.87.2023.10.11.16.15.31
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 16:15:31 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso740638a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 16:15:31 -0700 (PDT)
X-Received: by 2002:aa7:c0d8:0:b0:525:469a:fc47 with SMTP id
 j24-20020aa7c0d8000000b00525469afc47mr19218539edp.22.1697066131632; Wed, 11
 Oct 2023 16:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696969632.git.josef@toxicpanda.com> <999dc4783e67f45b00173f1ea869136c52ea598d.1696969632.git.josef@toxicpanda.com>
In-Reply-To: <999dc4783e67f45b00173f1ea869136c52ea598d.1696969632.git.josef@toxicpanda.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Wed, 11 Oct 2023 19:14:54 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-Zn29Up0bEKu8OBAoU3DAD_8r_mtDCd=OHHQRv2CMLLA@mail.gmail.com>
Message-ID: <CAEg-Je-Zn29Up0bEKu8OBAoU3DAD_8r_mtDCd=OHHQRv2CMLLA@mail.gmail.com>
Subject: Re: [PATCH 1/8] btrfs-progs: check: fix max inline extent size
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 10, 2023 at 4:28 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Fscrypt will use our entire inline extent range for symlinks, which
> uncovered a bug in btrfs check where we set the maximum inline extent
> size to
>
> min(sectorsize - 1, BTRFS_MAX_INLINE_DATA_SIZE)
>
> which isn't correct, we have always allowed sectorsize sized inline
> extents, so fix check to use the correct maximum inline extent size.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  check/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/check/main.c b/check/main.c
> index d387eb25..0979a8c6 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -1640,7 +1640,7 @@ static int process_file_extent(struct btrfs_root *root,
>         u64 disk_bytenr = 0;
>         u64 extent_offset = 0;
>         u64 mask = gfs_info->sectorsize - 1;
> -       u32 max_inline_size = min_t(u32, mask,
> +       u32 max_inline_size = min_t(u32, gfs_info->sectorsize,
>                                 BTRFS_MAX_INLINE_DATA_SIZE(gfs_info));
>         u8 compression;
>         int extent_type;
> --
> 2.41.0
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
