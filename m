Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1675B56174A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 12:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiF3KHo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 06:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiF3KHD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 06:07:03 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E78C4550B
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 03:06:46 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t189so746103oie.8
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8pqWGqhVSTyO+c06A/bQvR/DDZgQMwn4y9YfEG92Ro=;
        b=eM8w+A7lkkJ8DifuWcwsOyVlev56tH1FXe5QwRJ6ZkTQ6UmeyR9Z9tNE7FN4HXbdMw
         PNmJwsxO2cUzw1RlZMgJ64V8W5zK1c066lch2vvC8HMRqVj2+HUmoKsSMpaudNyUECqn
         I17DtADw1CL73goryaQSgm/RraoZh8QfnLlFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8pqWGqhVSTyO+c06A/bQvR/DDZgQMwn4y9YfEG92Ro=;
        b=lLc34PeOOvuitJ5GY8v1IB1bWjv+DyGbHigvT2ScInGhr3PkoHziSRKmzUuUSRToVX
         G+lHq4FwSDrEZpLc2ovh0hopTqwzL0JxqONGHHDba0UaZkM68eEPXHfz8thzJ7kVeunw
         ecSRuneRgAoU+Uhj2RX32RSPlHM4chVHKYi2ik6rH70C+c+aBQ23roRjWgqi+t2hZQep
         E5ygMP1ezP0nek7zaA72BvJT5LOfkIA2XajuqSqY/vKSIu35diUHRNYZMZVKHxcS9sxs
         Dn++fNdW2sMClzS9u3IzFMvLPfI/K5dx9SijCU09QfvthBPS4+Xv/yg482M/UG2vQ+ZF
         AhcQ==
X-Gm-Message-State: AJIora+Qv3DzPovz1TKsWiRIbd4XOyjYx5Aq8vBw2VwDbiWE2VxbJ5bc
        6TjMfQrroVAPxTZ1/Q9A1t45geBw2O+p+odAGMec1g==
X-Google-Smtp-Source: AGRyM1unGJmin2EBpwJfMHodCEGvOafCOX7hWEyyUOUw3lRCT55Pgc4ai5auQ6F8gdIQ9XQOpyqnC/T+9rwPSX4uOJw=
X-Received: by 2002:a05:6808:189b:b0:335:caca:ca0b with SMTP id
 bi27-20020a056808189b00b00335cacaca0bmr620705oib.170.1656583605473; Thu, 30
 Jun 2022 03:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656401086.git.wqu@suse.com> <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656401086.git.wqu@suse.com>
In-Reply-To: <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656401086.git.wqu@suse.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Thu, 30 Jun 2022 04:06:27 -0600
Message-ID: <CAPnjgZ1JLqXa6fexJFkh8aaj7h4OocBBOWat-fsp_x-zNrYO9g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/8] fs: fat: unexport file_fat_read_at()
To:     Qu Wenruo <wqu@suse.com>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        linux-btrfs@vger.kernel.org, jnhuang95@gmail.com,
        linux-erofs@lists.ozlabs.org, Tom Rini <trini@konsulko.com>,
        Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 28 Jun 2022 at 01:28, Qu Wenruo <wqu@suse.com> wrote:
>
> That function is only utilized inside fat driver, unexport it.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/fat/fat.c  | 4 ++--
>  include/fat.h | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> index df9ea2c028fc..dcceccbcee0a 100644
> --- a/fs/fat/fat.c
> +++ b/fs/fat/fat.c
> @@ -1243,8 +1243,8 @@ out_free_itr:
>         return ret;
>  }
>
> -int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
> -                    loff_t maxsize, loff_t *actread)
> +static int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
> +                           loff_t maxsize, loff_t *actread)
>  {
>         fsdata fsdata;
>         fat_itr *itr;
> diff --git a/include/fat.h b/include/fat.h
> index bd8e450b33a3..a9756fb4cd1b 100644
> --- a/include/fat.h
> +++ b/include/fat.h
> @@ -200,8 +200,6 @@ static inline u32 sect_to_clust(fsdata *fsdata, int sect)
>  int file_fat_detectfs(void);
>  int fat_exists(const char *filename);
>  int fat_size(const char *filename, loff_t *size);
> -int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
> -                    loff_t maxsize, loff_t *actread);
>  int file_fat_read(const char *filename, void *buffer, int maxsize);
>  int fat_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info);
>  int fat_register_device(struct blk_desc *dev_desc, int part_no);
> --
> 2.36.1
>
