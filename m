Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6FE7BE6F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377308AbjJIQuV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377138AbjJIQuT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 12:50:19 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B0A6;
        Mon,  9 Oct 2023 09:50:18 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7ad24b3aaso5227237b3.2;
        Mon, 09 Oct 2023 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696870217; x=1697475017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhm7YrqXofK0AegCXETsHz1KMPta2LD8FhGIuFko2pY=;
        b=LK6ANqyjW2cUasb27hpvpemq1Gv7wXnbzzUJ24o2aFLFv1qVG3/kdsO4p2cQ+duVDM
         2carBMbaZqP2CBYcC4f+D4JVqpVTOSVUgdaYVAMwbeHkJOZv3fcyimk9sKVjzmTFo7N6
         tFHONhsepDXlf2Ji8bzfZ7SMUxj/ptKkk2tXsNIQSV0OTV4F7Y9FxkBnlvlSBQ38TYrD
         x/FDR5AQzlo9yCwg4li7uZZOnBiUqtlpNnefqrX2tKer3L7+1kp5CfA8RPcGO31DKvmB
         St+Ej46A10/HMKx5tvUNC8UlZmQqdYdHWF7xx2p2g73Yao86wYomsti4EWO5eZEJgpAx
         gmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870217; x=1697475017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhm7YrqXofK0AegCXETsHz1KMPta2LD8FhGIuFko2pY=;
        b=cTU3QqdsoJMYCPoMxLyKgAkqU1xJU+KYsGyO6Og9KBYbTFJEqfUAeUCHHQ8FS9+SBD
         4F93Cbe12Ki6xqdG1kuEt9CvZ+C2GmTsFrCOpV3Heco5FRA/lZwGxcS16V0/hkUW8s24
         pS9XNOMdqvLwK7YaDgSat+4zHRJV8l03y8h2xk3cPhdbrciII1xP+JCB3kUf5ssZrVPE
         TSzDso+zdZ8QSkm/ZESn7FzU10M6c2iTjgTZ+XEEp+nmTddt71bR5OxqIEz7cRw1aYuI
         +5A3wQ+f10xHDOkZaOjhjQjkLYZlSv+SOcey+sNZrSWID/Qvc7uABa13DyaqDPWH/Re5
         Ze4A==
X-Gm-Message-State: AOJu0Ywp6vz5rKI+gWnxagT6uIl3PAH8KkgRJbjPl1MpAcgJFT/7SxlS
        QxF0Wo7FwwohFX6VRiCFmro=
X-Google-Smtp-Source: AGHT+IGDGieAvy8YgNDMEl5ERI+L5dnLHTLO6C63fhmPXvU26M+Gw4A6t2G+i0jttc7QnLS2senhew==
X-Received: by 2002:a0d:c207:0:b0:59a:f131:50fa with SMTP id e7-20020a0dc207000000b0059af13150famr16404483ywd.47.1696870217228;
        Mon, 09 Oct 2023 09:50:17 -0700 (PDT)
Received: from localhost ([2607:fb90:be22:da0:a050:8c3a:c782:514b])
        by smtp.gmail.com with ESMTPSA id p6-20020a0dff06000000b0059c8387f673sm3823742ywf.51.2023.10.09.09.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:50:16 -0700 (PDT)
Date:   Mon, 9 Oct 2023 09:50:15 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/14] fs/ntfs3: rename bitmap_size() ->
 ntfs3_bitmap_size()
Message-ID: <ZSQvR+bQ8PS9/CEa@yury-ThinkPad>
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
 <20231009151026.66145-7-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009151026.66145-7-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 09, 2023 at 05:10:18PM +0200, Alexander Lobakin wrote:
> bitmap_size() is a pretty generic name and one may want to use it for
> a generic bitmap API function. At the same time, its logic is
> NTFS-specific, as it aligns to the sizeof(u64), not the sizeof(long)
> (although it uses ideologically right ALIGN() instead of division).
> Add the prefix 'ntfs3_' used for that FS (not just 'ntfs_' to not mix
> it with the legacy module).
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  fs/ntfs3/bitmap.c  |  4 ++--
>  fs/ntfs3/fsntfs.c  |  2 +-
>  fs/ntfs3/index.c   | 11 ++++++-----
>  fs/ntfs3/ntfs_fs.h |  2 +-
>  fs/ntfs3/super.c   |  2 +-
>  5 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
> index 107e808e06ea..a2e18f13e93a 100644
> --- a/fs/ntfs3/bitmap.c
> +++ b/fs/ntfs3/bitmap.c
> @@ -653,7 +653,7 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
>  	wnd->total_zeroes = nbits;
>  	wnd->extent_max = MINUS_ONE_T;
>  	wnd->zone_bit = wnd->zone_end = 0;
> -	wnd->nwnd = bytes_to_block(sb, bitmap_size(nbits));
> +	wnd->nwnd = bytes_to_block(sb, ntfs3_bitmap_size(nbits));
>  	wnd->bits_last = nbits & (wbits - 1);
>  	if (!wnd->bits_last)
>  		wnd->bits_last = wbits;
> @@ -1345,7 +1345,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
>  		return -EINVAL;
>  
>  	/* Align to 8 byte boundary. */
> -	new_wnd = bytes_to_block(sb, bitmap_size(new_bits));
> +	new_wnd = bytes_to_block(sb, ntfs3_bitmap_size(new_bits));
>  	new_last = new_bits & (wbits - 1);
>  	if (!new_last)
>  		new_last = wbits;
> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> index 33afee0f5559..7a14d2347f27 100644
> --- a/fs/ntfs3/fsntfs.c
> +++ b/fs/ntfs3/fsntfs.c
> @@ -522,7 +522,7 @@ static int ntfs_extend_mft(struct ntfs_sb_info *sbi)
>  	ni->mi.dirty = true;
>  
>  	/* Step 2: Resize $MFT::BITMAP. */
> -	new_bitmap_bytes = bitmap_size(new_mft_total);
> +	new_bitmap_bytes = ntfs3_bitmap_size(new_mft_total);
>  
>  	err = attr_set_size(ni, ATTR_BITMAP, NULL, 0, &sbi->mft.bitmap.run,
>  			    new_bitmap_bytes, &new_bitmap_bytes, true, NULL);
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 124c6e822623..ab53a4b6ddf8 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -1453,8 +1453,8 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
>  
>  	alloc->nres.valid_size = alloc->nres.data_size = cpu_to_le64(data_size);
>  
> -	err = ni_insert_resident(ni, bitmap_size(1), ATTR_BITMAP, in->name,
> -				 in->name_len, &bitmap, NULL, NULL);
> +	err = ni_insert_resident(ni, ntfs3_bitmap_size(1), ATTR_BITMAP,
> +				 in->name, in->name_len, &bitmap, NULL, NULL);
>  	if (err)
>  		goto out2;
>  
> @@ -1515,8 +1515,9 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
>  	if (bmp) {
>  		/* Increase bitmap. */
>  		err = attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
> -				    &indx->bitmap_run, bitmap_size(bit + 1),
> -				    NULL, true, NULL);
> +				    &indx->bitmap_run,
> +				    ntfs3_bitmap_size(bit + 1), NULL, true,
> +				    NULL);
>  		if (err)
>  			goto out1;
>  	}
> @@ -2089,7 +2090,7 @@ static int indx_shrink(struct ntfs_index *indx, struct ntfs_inode *ni,
>  	if (in->name == I30_NAME)
>  		ni->vfs_inode.i_size = new_data;
>  
> -	bpb = bitmap_size(bit);
> +	bpb = ntfs3_bitmap_size(bit);
>  	if (bpb * 8 == nbits)
>  		return 0;
>  
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 629403ede6e5..93333156aac6 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -961,7 +961,7 @@ static inline bool run_is_empty(struct runs_tree *run)
>  }
>  
>  /* NTFS uses quad aligned bitmaps. */
> -static inline size_t bitmap_size(size_t bits)
> +static inline size_t ntfs3_bitmap_size(size_t bits)
>  {
>  	return ALIGN((bits + 7) >> 3, 8);
>  }

This looks like duplicating BITS_TO_U64(). If so, why not just switch
to using the macro while you're here?

> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index cfec5e0c7f66..b1fb6efe7084 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -1285,7 +1285,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	/* Check bitmap boundary. */
>  	tt = sbi->used.bitmap.nbits;
> -	if (inode->i_size < bitmap_size(tt)) {
> +	if (inode->i_size < ntfs3_bitmap_size(tt)) {
>  		ntfs_err(sb, "$Bitmap is corrupted.");
>  		err = -EINVAL;
>  		goto put_inode_out;
> -- 
> 2.41.0
