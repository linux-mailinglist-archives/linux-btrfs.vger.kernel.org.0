Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC357BE669
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 18:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377182AbjJIQbU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 12:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377196AbjJIQbT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 12:31:19 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2BDAF;
        Mon,  9 Oct 2023 09:31:18 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59f6e6b7600so56280237b3.3;
        Mon, 09 Oct 2023 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696869077; x=1697473877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwJG0ZcdADOiEPsRD1fp8I+0b5ih4BdS68Cgas4xJ7g=;
        b=EqxmU5teWNdEaPpgJA2o0T/ghM9GXOlFNUNJfBtVW+EkVpiHlbHLrk6DA+G34wrXgb
         S0Ya1gnzffYaUlgmMmISDNE4Y94p6um02EvxSCH0ehuoXbzOd3+AGMHvXPgBsAQ9Z/16
         VfBiLvyUlLSEJPTAV4+g8ZkBVv4Z1j/W+5rexg6e0bwrwLT+dEjMlkzJr/2oS2Hx445S
         SUOE90cx3RpyFEtw4on25mInxVgQWqBmLRg6j0JXpeu5mJcCV1XxdLBcFnZzrbSMUxuj
         HPsgLK1VsS1Agh4j1ZI2Qw0cEgN7mZC1IZdxz8KAstenN9zaVRofYkie8UAq+7kKdSs6
         9f5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869077; x=1697473877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwJG0ZcdADOiEPsRD1fp8I+0b5ih4BdS68Cgas4xJ7g=;
        b=ODW7BE7YRdT1e0HRXZHKIJqVyCPP5zMcpm/h+iiYkt7KdQ50NKoRhX1VbASH44bZiK
         esBfrVSi6dEPT7/G4BVPcTSOGyV/eTae9QR0qV1AlPTAwBTOfWfmf2wegUDJs9yGGRHI
         T8egPnFN8F70irQBMjW4Y++lmOFGvOzDZ1YGUEig/u4qMEYGvgpHfVadISyIifGwgRSK
         NyEbL6X7s9ETfsvHjpDHZeLLLB2gZRW9woJ/6HkQRTERQiEnzLzfWRI+0Yk1va63gY4T
         tFwy4y9eEYRNOVL3HAURDPzslImf+pjzGBy1eOHN9wweyNzWsgdxyUTsLu7SqbgcPQCT
         N3zw==
X-Gm-Message-State: AOJu0YxPyAyU5I4liXL3Op0egXAb/m86haIYzV8gUPUySuCo0QEGgGBF
        kfNBJ37CeDgn8Da0EzvEilnp3+DMTa4WIg==
X-Google-Smtp-Source: AGHT+IEXYlVGR26h67lZ0CQFtDdopC6qPtwRiCX8u/eS0Le2sSi4IxhnE11TM3OyRpNoFH8rv8Esgw==
X-Received: by 2002:a81:7b8a:0:b0:59b:c805:de60 with SMTP id w132-20020a817b8a000000b0059bc805de60mr15386292ywc.45.1696869076997;
        Mon, 09 Oct 2023 09:31:16 -0700 (PDT)
Received: from localhost ([2607:fb90:be22:da0:a050:8c3a:c782:514b])
        by smtp.gmail.com with ESMTPSA id g139-20020a0ddd91000000b00589a999038asm3797246ywe.77.2023.10.09.09.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:31:16 -0700 (PDT)
Date:   Mon, 9 Oct 2023 09:31:15 -0700
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
Subject: Re: [PATCH 09/14] bitmap: extend bitmap_{get,set}_value8() to
 bitmap_{get,set}_bits()
Message-ID: <ZSQq02A9mTireK71@yury-ThinkPad>
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
 <20231009151026.66145-10-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009151026.66145-10-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

+ Alexander Potapenko <glider@google.com>

On Mon, Oct 09, 2023 at 05:10:21PM +0200, Alexander Lobakin wrote:
> Sometimes there's need to get a 8/16/...-bit piece of a bitmap at a
> particular offset. Currently, there are only bitmap_{get,set}_value8()
> to do that for 8 bits and that's it.

And also a series from Alexander Potapenko, which I really hope will
get into the -next really soon. It introduces bitmap_read/write which
can set up to BITS_PER_LONG at once, with no limitations on alignment
of position and length:

https://lore.kernel.org/linux-arm-kernel/ZRXbOoKHHafCWQCW@yury-ThinkPad/T/#mc311037494229647088b3a84b9f0d9b50bf227cb

Can you consider building your series on top of it?

> Instead of introducing a separate pair for u16 and so on, which doesn't
> scale well, extend the existing functions to be able to pass the wanted
> value width. Make both offset and width arbitrary, but in order to not
> over complicate the current logic and keep the helpers as optimized as
> the current ones, require the width to be a pow-2 value and the offset
> to be a multiple of the width, while the target piece should not cross
> a %BITS_PER_LONG boundary and stay within one long.
> Avoid adjusting all the already existing callsites by defining oneliner
> wrapper macros named after the former functions. bloat-o-meter shows
> almost no difference (+1-2 bytes in a couple of places), meaning the
> new helpers get optimized just nicely.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/linux/bitmap.h | 51 ++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 63e422f8ba3d..9c010a7fa331 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -6,8 +6,10 @@
>  
>  #include <linux/align.h>
>  #include <linux/bitops.h>
> +#include <linux/bug.h>
>  #include <linux/find.h>
>  #include <linux/limits.h>
> +#include <linux/log2.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
>  
> @@ -569,38 +571,59 @@ static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
>  }
>  
>  /**
> - * bitmap_get_value8 - get an 8-bit value within a memory region
> + * bitmap_get_bits - get a 8/16/32/64-bit value within a memory region
>   * @map: address to the bitmap memory region
> - * @start: bit offset of the 8-bit value; must be a multiple of 8
> + * @start: bit offset of the value; must be a multiple of @len
> + * @len: bit width of the value; must be a power of two
>   *
> - * Returns the 8-bit value located at the @start bit offset within the @src
> - * memory region.
> + * Return: the 8/16/32/64-bit value located at the @start bit offset within
> + * the @src memory region. Its position (@start + @len) can't cross
> + * a ``BITS_PER_LONG`` boundary.
>   */
> -static inline unsigned long bitmap_get_value8(const unsigned long *map,
> -					      unsigned long start)
> +static inline unsigned long bitmap_get_bits(const unsigned long *map,
> +					    unsigned long start, size_t len)
>  {
>  	const size_t index = BIT_WORD(start);
>  	const unsigned long offset = start % BITS_PER_LONG;
>  
> -	return (map[index] >> offset) & 0xFF;
> +	if (WARN_ON_ONCE(!is_power_of_2(len) || offset % len ||
> +			 offset + len > BITS_PER_LONG))
> +		return 0;
> +
> +	return (map[index] >> offset) & GENMASK(len - 1, 0);
>  }
>  
>  /**
> - * bitmap_set_value8 - set an 8-bit value within a memory region
> + * bitmap_set_bits - set a 8/16/32/64-bit value within a memory region
>   * @map: address to the bitmap memory region
> - * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
> - * @start: bit offset of the 8-bit value; must be a multiple of 8
> + * @start: bit offset of the value; must be a multiple of @len
> + * @value: new value to set
> + * @len: bit width of the value; must be a power of two
> + *
> + * Replaces the 8/16/32/64-bit value located at the @start bit offset within
> + * the @src memory region with the new @value. Its position (@start + @len)
> + * can't cross a ``BITS_PER_LONG`` boundary.
>   */
> -static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
> -				     unsigned long start)
> +static inline void bitmap_set_bits(unsigned long *map, unsigned long start,
> +				   unsigned long value, size_t len)
>  {
>  	const size_t index = BIT_WORD(start);
>  	const unsigned long offset = start % BITS_PER_LONG;
> +	unsigned long mask = GENMASK(len - 1, 0);
>  
> -	map[index] &= ~(0xFFUL << offset);
> -	map[index] |= value << offset;
> +	if (WARN_ON_ONCE(!is_power_of_2(len) || offset % len ||
> +			 offset + len > BITS_PER_LONG))
> +		return;
> +
> +	map[index] &= ~(mask << offset);
> +	map[index] |= (value & mask) << offset;
>  }
>  
> +#define bitmap_get_value8(map, start)				\
> +	bitmap_get_bits(map, start, BITS_PER_BYTE)
> +#define bitmap_set_value8(map, value, start)			\
> +	bitmap_set_bits(map, start, value, BITS_PER_BYTE)
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* __LINUX_BITMAP_H */
> -- 
> 2.41.0
