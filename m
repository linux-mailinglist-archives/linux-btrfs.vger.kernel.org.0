Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996A47BE752
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 19:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377771AbjJIREX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 13:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377770AbjJIREV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 13:04:21 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E2AE0;
        Mon,  9 Oct 2023 10:04:19 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a200028437so59285467b3.1;
        Mon, 09 Oct 2023 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696871059; x=1697475859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GrtA6lKuYWUe++j58BXstURMH0ObpUyX8a0STO/sotc=;
        b=K6jLv5cdIQU+SaHszFfqY1VFnxkSC3nwghT0YoNrHAE0NRDR7mpix5d+HXaQU17Lk0
         06BDVP47MPdCpLivJciHNdpJKrJU+3UgNY+ZaFDYEsX7t0S/lHAgmAJbjzVYdxPosgdc
         jDXGgrtorFpN8Xuft8/7ZFP0PRqXhmCSWw35z60A+BB6l+zfr2iUjQIOxNfsGLFMv6Dl
         bE2czH9gv2BbpuB/2tQCH1UyxC9BhVA+XVM0dcRiIY8NZtK3MepgiTQO8Bm5divKxVbT
         UgMtWE4PnqoKIyh45djGZ2OsvPavSS9u3eP6lW6HMoz8y3xpiurw4S76YKuhmcxr4AsR
         BIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696871059; x=1697475859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrtA6lKuYWUe++j58BXstURMH0ObpUyX8a0STO/sotc=;
        b=vDEYQ7xDJksEXZmSEP2IsSjXR68hzcNxTEt305bPOCqk83aCsLmvP+PHcsWaOY0Gys
         M3XIFBY6lgcSAjQawBpEEDZxlJNejE2Mpv10V3BU/rsXpo6Af9pVe3/m+ukX77xfpqL1
         yDsz0koSygjyC7EzU/qXNak5CqXXBf0IB3OfKMGUwaZaXl2/1izw+0tPEUmixOmopPOB
         XL/ZGZSEBaemI8RDgLfZxYrLU8YTqv5LpZidh88gWPozD15wfFqF/gdveOhdkzeOKWsL
         yZAvH/JFJ9mEu4KmnD4l4r1cmzjRpnYGdFkjd6g9Ch7WYwfwTH7xa1r9cK0fm1xHLvN4
         E6hg==
X-Gm-Message-State: AOJu0Yyzb0HR1tIwalnFmUcTKyipL53GOgHOkSXjx7Nu309gaxcj+EOF
        Y4v8MOuwqpDI+WpakKn4iOk=
X-Google-Smtp-Source: AGHT+IFCaKLUIQtaVFO6RZQ7mzNkB38jHP0WXbG7WaO+K53JI2BYGR30cn9swjnv1mxH93LfVRqHVw==
X-Received: by 2002:a0d:f542:0:b0:59f:5361:d18c with SMTP id e63-20020a0df542000000b0059f5361d18cmr15848023ywf.41.1696871058634;
        Mon, 09 Oct 2023 10:04:18 -0700 (PDT)
Received: from localhost ([2607:fb90:be22:da0:a050:8c3a:c782:514b])
        by smtp.gmail.com with ESMTPSA id g192-20020a0dddc9000000b0054bfc94a10dsm3799789ywe.47.2023.10.09.10.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:04:18 -0700 (PDT)
Date:   Mon, 9 Oct 2023 10:04:16 -0700
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
Subject: Re: [PATCH 08/14] bitmap: introduce generic optimized bitmap_size()
Message-ID: <ZSQykJtkemZTiYHP@yury-ThinkPad>
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
 <20231009151026.66145-9-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009151026.66145-9-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 09, 2023 at 05:10:20PM +0200, Alexander Lobakin wrote:
> The number of times yet another open coded
> `BITS_TO_LONGS(nbits) * sizeof(long)` can be spotted is huge.
> Some generic helper is long overdue.

OK, I see your point. Indeed, opencoding this again and again may be
annoying. 

Acked-by: Yury Norov <yury.norov@gmail.com>
 
> Add one, bitmap_size(), but with one detail.
> BITS_TO_LONGS() uses DIV_ROUND_UP(). The latter works well when both
> divident and divisor are compile-time constants or when the divisor
> is not a pow-of-2. When it is however, the compilers sometimes tend
> to generate suboptimal code (GCC 13):
> 
> 48 83 c0 3f          	add    $0x3f,%rax
> 48 c1 e8 06          	shr    $0x6,%rax
> 48 8d 14 c5 00 00 00 00	lea    0x0(,%rax,8),%rdx
> 
> %BITS_PER_LONG is always a pow-2 (either 32 or 64), but GCC still does
> full division of `nbits + 63` by it and then multiplication by 8.
> Instead of BITS_TO_LONGS(), use ALIGN() and then divide by 8. GCC:
> 
> 8d 50 3f             	lea    0x3f(%rax),%edx
> c1 ea 03             	shr    $0x3,%edx
> 81 e2 f8 ff ff 1f    	and    $0x1ffffff8,%edx
> 
> Now it divides `nbits + 63` by 8 and then masks bits[2:0].
> bloat-o-meter:
> 
> add/remove: 0/0 grow/shrink: 20/133 up/down: 156/-773 (-617)
> 
> Clang does it better and generates the same code before/after starting
> from -O1, except that with the ALIGN() approach it uses %edx and thus
> still saves some bytes:
> 
> add/remove: 0/0 grow/shrink: 9/133 up/down: 18/-538 (-520)
> 
> Note that we can't expand DIV_ROUND_UP() by adding a check and using
> this approach there, as it's used in array declarations where
> expressions are not allowed.
> Add this helper to tools/ as well.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/md/dm-clone-metadata.c | 5 -----
>  include/linux/bitmap.h         | 8 +++++---
>  include/linux/cpumask.h        | 2 +-
>  lib/math/prime_numbers.c       | 2 --
>  tools/include/linux/bitmap.h   | 8 +++++---
>  5 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/md/dm-clone-metadata.c b/drivers/md/dm-clone-metadata.c
> index c43d55672bce..47c1fa7aad8b 100644
> --- a/drivers/md/dm-clone-metadata.c
> +++ b/drivers/md/dm-clone-metadata.c
> @@ -465,11 +465,6 @@ static void __destroy_persistent_data_structures(struct dm_clone_metadata *cmd)
>  
>  /*---------------------------------------------------------------------------*/
>  
> -static size_t bitmap_size(unsigned long nr_bits)
> -{
> -	return BITS_TO_LONGS(nr_bits) * sizeof(long);
> -}
> -
>  static int __dirty_map_init(struct dirty_map *dmap, unsigned long nr_words,
>  			    unsigned long nr_regions)
>  {
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 03644237e1ef..63e422f8ba3d 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -237,9 +237,11 @@ extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
>  #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
>  
> +#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
> +
>  static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
>  {
> -	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> +	unsigned int len = bitmap_size(nbits);
>  
>  	if (small_const_nbits(nbits))
>  		*dst = 0;
> @@ -249,7 +251,7 @@ static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
>  
>  static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
>  {
> -	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> +	unsigned int len = bitmap_size(nbits);
>  
>  	if (small_const_nbits(nbits))
>  		*dst = ~0UL;
> @@ -260,7 +262,7 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
>  static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
>  			unsigned int nbits)
>  {
> -	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> +	unsigned int len = bitmap_size(nbits);
>  
>  	if (small_const_nbits(nbits))
>  		*dst = *src;
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index f10fb87d49db..dbdbf1451cad 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -821,7 +821,7 @@ static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
>   */
>  static inline unsigned int cpumask_size(void)
>  {
> -	return BITS_TO_LONGS(large_cpumask_bits) * sizeof(long);
> +	return bitmap_size(large_cpumask_bits);
>  }
>  
>  /*
> diff --git a/lib/math/prime_numbers.c b/lib/math/prime_numbers.c
> index d42cebf7407f..d3b64b10da1c 100644
> --- a/lib/math/prime_numbers.c
> +++ b/lib/math/prime_numbers.c
> @@ -6,8 +6,6 @@
>  #include <linux/prime_numbers.h>
>  #include <linux/slab.h>
>  
> -#define bitmap_size(nbits) (BITS_TO_LONGS(nbits) * sizeof(unsigned long))
> -
>  struct primes {
>  	struct rcu_head rcu;
>  	unsigned long last, sz;
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index f3566ea0f932..81a2299ace15 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -2,6 +2,7 @@
>  #ifndef _TOOLS_LINUX_BITMAP_H
>  #define _TOOLS_LINUX_BITMAP_H
>  
> +#include <linux/align.h>
>  #include <string.h>
>  #include <linux/bitops.h>
>  #include <linux/find.h>
> @@ -25,13 +26,14 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
>  #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
>  
> +#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
> +
>  static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
>  {
>  	if (small_const_nbits(nbits))
>  		*dst = 0UL;
>  	else {
> -		int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> -		memset(dst, 0, len);
> +		memset(dst, 0, bitmap_size(nbits));
>  	}
>  }
>  
> @@ -83,7 +85,7 @@ static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
>   */
>  static inline unsigned long *bitmap_zalloc(int nbits)
>  {
> -	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
> +	return calloc(1, bitmap_size(nbits));
>  }
>  
>  /*
> -- 
> 2.41.0
