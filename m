Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2FC7CB18E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 19:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjJPRs3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 13:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjJPRs1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 13:48:27 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062099F;
        Mon, 16 Oct 2023 10:48:26 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9a7a3e17d1so5600259276.2;
        Mon, 16 Oct 2023 10:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697478505; x=1698083305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Gni6mzvaBaFKxuMxn9hZgE2UC6/dQHw9AadxVgtVNo=;
        b=hrNRjp3Y8049a1H5L///I9LZfu0qTi+gWkje9FexowkWG2OadlQHJoBSUB5+RyAcHR
         tABGr97G0FYH6oYe/B0u1wgMc+gW16JOvhvk62PUIXkvGiYDljewxwrN7PqFb0e/XMGg
         ijWpx0SYdRk68w1sPBG6H7fD4BK48LJdV5SNJw8gbKj9u5+yhqOS1mEBzZhl8CAZD2NN
         CbFVEUE1q8fsgUHHhVTUQAVee/RBgfyvdLUjBb8qqJ3nH8WMZ+Y69R0+yrLK0vWhlwVS
         BU/8bjRUHmMJ2SF2+sAfHzkuprXvPnSZv10lGllwNcLMtWzovJGhSRk/fwGdzy1I+C/x
         EjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697478505; x=1698083305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Gni6mzvaBaFKxuMxn9hZgE2UC6/dQHw9AadxVgtVNo=;
        b=k/iMZGgIYr0oRy/BuAYRdz8RqbSEgxCbW6P7dM9g7dUcZu7u+iiT0InZgS+jhkGgyz
         zjYYKQfpmEdBnNi7i8bIIQjG9bnNdLy1RB4K4PB2XDn1URyaiQSUD5fvTjqjQ9BYkWHY
         nzRUg01Y0uK4o68mMRejhEVekUu2/4/UVyT2jOtAZcvd8Wk+zCB671vAWuBxNqSCzCqc
         YcfKc2rgQeLUISgwUHh+vj2DG2X+bWGqP1zchGlOFTfiaslilW8mgsd/Fy9xrxbJoreA
         0yWYplHtBCTMJXH3bzPTsiZ1eE8wMrAKWbATHUbF586AmtRx5XoEDqFX6x2DACKci3oh
         934Q==
X-Gm-Message-State: AOJu0YyR935g6RMJ3bseCFJCQuIi9vnC1+OfRh+BooZSVgVRk7bVoLqM
        O3mnbg1hFlHj1BZarT0BfF8=
X-Google-Smtp-Source: AGHT+IFxhp5Fg6dD0ShGrsQoX3lKB8P2VZfUuC29sX4UXOWErGVDVNAevi+hJU45YX1WEraFAAwehQ==
X-Received: by 2002:a25:3742:0:b0:d9a:4a5f:415d with SMTP id e63-20020a253742000000b00d9a4a5f415dmr18010718yba.0.1697478505154;
        Mon, 16 Oct 2023 10:48:25 -0700 (PDT)
Received: from localhost ([2607:fb90:be80:2b9:64a5:5a0e:5435:bd4])
        by smtp.gmail.com with ESMTPSA id q17-20020a25f911000000b00d20d4ffbbdbsm2775571ybe.0.2023.10.16.10.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:48:24 -0700 (PDT)
Date:   Mon, 16 Oct 2023 10:48:23 -0700
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
Subject: Re: [PATCH v2 09/13] bitmap: make bitmap_{get,set}_value8() use
 bitmap_{read,write}()
Message-ID: <ZS13Z8Ls69lEBYib@yury-ThinkPad>
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
 <20231016165247.14212-10-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016165247.14212-10-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 16, 2023 at 06:52:43PM +0200, Alexander Lobakin wrote:
> Now that we have generic bitmap_read() and bitmap_write(), which are
> inline and try to take care of non-bound-crossing and aligned cases
> to keep them optimized, collapse bitmap_{get,set}_value8() into
> simple wrappers around the former ones.
> bloat-o-meter shows no difference in vmlinux and -2 bytes for
> gpio-pca953x.ko, which says the code doesn't get optimized worse.

That's just amazing!

bloat-o-meter itself doesn't say on optimization, but in this case
I think that BITS_PER_BYTE passed at compile time allows to generate
just as good code with the generic bitmap_write/read().

Acked-by: Yury Norov <yury.norov@gmail.com>

> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/linux/bitmap.h | 38 +++++---------------------------------
>  1 file changed, 5 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 2020cb534ed7..c2680f67bc4e 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -572,39 +572,6 @@ static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
>  	bitmap_from_arr64(dst, &mask, 64);
>  }
>  
> -/**
> - * bitmap_get_value8 - get an 8-bit value within a memory region
> - * @map: address to the bitmap memory region
> - * @start: bit offset of the 8-bit value; must be a multiple of 8
> - *
> - * Returns the 8-bit value located at the @start bit offset within the @src
> - * memory region.
> - */
> -static inline unsigned long bitmap_get_value8(const unsigned long *map,
> -					      unsigned long start)
> -{
> -	const size_t index = BIT_WORD(start);
> -	const unsigned long offset = start % BITS_PER_LONG;
> -
> -	return (map[index] >> offset) & 0xFF;
> -}
> -
> -/**
> - * bitmap_set_value8 - set an 8-bit value within a memory region
> - * @map: address to the bitmap memory region
> - * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
> - * @start: bit offset of the 8-bit value; must be a multiple of 8
> - */
> -static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
> -				     unsigned long start)
> -{
> -	const size_t index = BIT_WORD(start);
> -	const unsigned long offset = start % BITS_PER_LONG;
> -
> -	map[index] &= ~(0xFFUL << offset);
> -	map[index] |= value << offset;
> -}
> -
>  /**
>   * bitmap_read - read a value of n-bits from the memory region
>   * @map: address to the bitmap memory region
> @@ -676,6 +643,11 @@ static inline void bitmap_write(unsigned long *map,
>  	map[index + 1] |= (value >> space);
>  }
>  
> +#define bitmap_get_value8(map, start)			\
> +	bitmap_read(map, start, BITS_PER_BYTE)
> +#define bitmap_set_value8(map, value, start)		\
> +	bitmap_write(map, value, start, BITS_PER_BYTE)
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* __LINUX_BITMAP_H */
> -- 
> 2.41.0
