Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5FE64BD1F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 20:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbiLMTUb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 14:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbiLMTUL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 14:20:11 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC0B26113
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:20:10 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id g137so2050176vke.10
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZl91/FN6D1YNLkUSrntWBBtWFgTnIy36XY+nqJj6E8=;
        b=ZAZRFWhP2bPo1KGNhwPF+hYc4qTwg3BojQQsyByOEuqUblQnr83u+zfWClcPNP7rYY
         lhJ5daaqKhqAkaLGMiPXHir2q1pe8tS1F0z3edskRMOs0eHvZEuFXPxyKCzheC8AzctO
         9vedZJw7RtMtbFyvXnFRvmCf4hiSTA1m3J68d/hZRI0UT90cXL4xWlfljai4d6e8pCgD
         V/jWUWcI/ZO7VJPzxDMu5t16YV9OjII/CVuOzodvUc2S5W74HFiY1YPwLgR2T3h6Tc0l
         Fck93h99n5FsxCYhuXMvuzb8/2DV0Xv9MQQr/UpY4k0w7mYikGyR2SqYgf/5+vgBq0/5
         wheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZl91/FN6D1YNLkUSrntWBBtWFgTnIy36XY+nqJj6E8=;
        b=sXRgq0MWGec2wfyxDm9tQ8lsntEA8gSZdJU0JV5clyqibl4oNc2I2mRrKsrEa7AWzC
         kvJdTGE2jxfCDpDY9Nmf3TkavQO5Rw5NHGMXLXTuwFP/ZrrgEaJHskeluceiVy2gvyez
         sSSi1/zEiSaw9Zm/o9XbWc71GfV3COZBdSGNMPE+a5+Md2aLM7SRS3eq6LbiMODlrlHX
         nWsiNYcAZinsEZN6NDsf/J85KQbFq8CHUMMpzoNXz1gNsoikUbk/eAQ+0v1TI7CYkJZE
         cL3ie9yWqBaKV6YKYtvrdXg1+oOEr+g+1jbB/ran0j3HbG7suM2pXv9LUdeICRmRsKRk
         vl4A==
X-Gm-Message-State: ANoB5pmjrhj1sDeLSl0EYuYw1pz9Ts+A/gKxIa1Ax7Nk8I9nZ5VaFJvq
        WxphS1VK/YcSSiwyek5K9FVgeyUe3nAGIAoV/d4=
X-Google-Smtp-Source: AA0mqf6YD5zFC5qYcIzI/lhPEJfgk0HwWj3hJyPMmG3N7t/TRdyj50kX8p9CHGd8ptF2yLRzBBZY5Q==
X-Received: by 2002:ac5:c197:0:b0:3bd:a20e:ae2b with SMTP id z23-20020ac5c197000000b003bda20eae2bmr12967436vkb.2.1670959209261;
        Tue, 13 Dec 2022 11:20:09 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a284700b006f9c2be0b4bsm8139623qkp.135.2022.12.13.11.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:20:08 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:20:07 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 16/16] btrfs: btree_writepages lock extents before pages
Message-ID: <Y5jQZybuqR85oZLZ@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <994c7a74720e3c8589263095704dc7f87cfdb3e7.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <994c7a74720e3c8589263095704dc7f87cfdb3e7.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:34PM -0600, Goldwyn Rodrigues wrote:
> Lock extents before pages while performing btree_writepages().
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/disk-io.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 8ac9612f8f27..b7e7c4c9d404 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -858,8 +858,25 @@ static int btree_migrate_folio(struct address_space *mapping,
>  static int btree_writepages(struct address_space *mapping,
>  			    struct writeback_control *wbc)
>  {
> +	u64 start, end;
> +	struct btrfs_inode *inode = BTRFS_I(mapping->host);
> +        struct extent_state *cached = NULL;
>  	struct btrfs_fs_info *fs_info;
>  	int ret;
> +	u64 isize = round_up(i_size_read(&inode->vfs_inode), PAGE_SIZE) - 1;
> +
> +	if (wbc->range_cyclic) {
> +		start = mapping->writeback_index << PAGE_SHIFT;
> +		end = isize;
> +	} else {
> +		start = round_down(wbc->range_start, PAGE_SIZE);
> +		end = round_up(wbc->range_end, PAGE_SIZE) - 1;
> +		end = min(isize, end);
> +	}

Same comment here as the extent_writepages case, we need to handle the
possibility of ->writeback_index changing between now and
btree_write_cache_pages.  Thanks,

Josef
