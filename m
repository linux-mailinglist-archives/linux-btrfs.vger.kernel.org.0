Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DDA7BE623
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 18:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377180AbjJIQSq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 12:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377094AbjJIQSp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 12:18:45 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963B591;
        Mon,  9 Oct 2023 09:18:43 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7a7e9357eso6060957b3.0;
        Mon, 09 Oct 2023 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696868323; x=1697473123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+v0P6uduPxkDwct3qYcLQFv77ucBxF1TcIWjbvekveU=;
        b=akPGM8NDYbCRwDeHYF47JZtV2PpaiTkmkLAameY0wCR0u4DUzupPSCBFavie+Jazio
         5q/TkbW29t5AoJV8RSmyWs1vlT9oD7I4Hdp/i1tbF2hbkeDtNR0yaQy0lvQG8PrRnr+r
         GNvhnOUWYdlRvMO8VpKujQkhY2t4u61CNk/TwWxxRKDJGtBypRpXR6987Teo81YK3dk2
         ZXRoWrRyNJb1M3egQ6baGUmKLNf8oucXskbtN7uWSGNacSlLi8RsUDAg19+R1jN/YU0B
         UkzfMnkwuWgfwYYnOjiOfwbuM583GRMg/Nrh2Xg3H3fKGZF0Wpw9G6FA5fIfkbAkMV3f
         9v6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696868323; x=1697473123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v0P6uduPxkDwct3qYcLQFv77ucBxF1TcIWjbvekveU=;
        b=A5YbxHMXtV+VcYgTJ7AqZBur/CwNGdjB16GKVU9b170SYMv+GOSH8Hl9W5145r8+7Z
         XEKv3NEraZlVxwtKf2PWScznMLG79YxPbPDSF5ltZr6KmMSRMOJiDUKrsiMKd/B9Rc/F
         4ky/+0qZiJVUn0srf88CxZDceV1/WTXllbxC4ohqxEY8pJttOyrdPEh30MNkosKAMN3M
         Gq6fvwNWCtwd2VZHfQdldk9IXeT/oFrSwb12Lm8THn4+U73quPNqPwL/kJRu5cJ4zyT4
         bLGtTJvGy35gYeZDWgXuvKDbQ5xtfa3ncZsMZ21h4f38sJG5DcLZyrcDYulYiuPUD5sx
         m5gw==
X-Gm-Message-State: AOJu0YwLOX5e8pyjsXR5M5yd2CAAgwkpt/HgQmUr0s9WBx/voce21+sa
        D8imrk+qthVv6s8NR7tG3Ak=
X-Google-Smtp-Source: AGHT+IHB8jMCMIkYIOrWoj2aAnwZpAx6vHscHjQQzqKGazLmHofK5EelcUbictbWaOs9tL3UCKSfcQ==
X-Received: by 2002:a81:6e41:0:b0:598:bad6:8e67 with SMTP id j62-20020a816e41000000b00598bad68e67mr16343283ywc.30.1696868322609;
        Mon, 09 Oct 2023 09:18:42 -0700 (PDT)
Received: from localhost ([2607:fb90:be22:da0:a050:8c3a:c782:514b])
        by smtp.gmail.com with ESMTPSA id u206-20020a8147d7000000b0059b4e981fe6sm3728032ywa.102.2023.10.09.09.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:18:42 -0700 (PDT)
Date:   Mon, 9 Oct 2023 09:18:40 -0700
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
Subject: Re: [PATCH 03/14] bitops: let the compiler optimize __assign_bit()
Message-ID: <ZSQn4Mppz9aJgFib@yury-ThinkPad>
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
 <20231009151026.66145-4-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009151026.66145-4-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 09, 2023 at 05:10:15PM +0200, Alexander Lobakin wrote:
> Since commit b03fc1173c0c ("bitops: let optimize out non-atomic bitops
> on compile-time constants"), the compilers are able to expand inline
> bitmap operations to compile-time initializers when possible.
> However, during the round of replacement if-__set-else-__clear with
> __assign_bit() as per Andy's advice, bloat-o-meter showed +1024 bytes
> difference in object code size for one module (even one function),
> where the pattern:
> 
> 	DECLARE_BITMAP(foo) = { }; // on the stack, zeroed
> 
> 	if (a)
> 		__set_bit(const_bit_num, foo);
> 	if (b)
> 		__set_bit(another_const_bit_num, foo);
> 	...
> 
> is heavily used, although there should be no difference: the bitmap is
> zeroed, so the second half of __assign_bit() should be compiled-out as
> a no-op.
> I either missed the fact that __assign_bit() has bitmap pointer marked
> as `volatile` (as we usually do for bitmaps) or was hoping that the

No, we usually don't. Atomic ops on individual bits is a notable exception
for bitmaps, as the comment for generic_test_bit() says, for example:
         /*
          * Unlike the bitops with the '__' prefix above, this one *is* atomic,
          * so `volatile` must always stay here with no cast-aways. See
          * `Documentation/atomic_bitops.txt` for the details.
          */

For non-atomic single-bit operations and all multi-bit ops, volatile is
useless, and generic___test_and_set_bit() in the same file casts the 
*addr to a plain 'unsigned long *'.

> compilers would at least try to look past the `volatile` for
> __always_inline functions. Anyhow, due to that attribute, the compilers
> were always compiling the whole expression and no mentioned compile-time
> optimizations were working.
> 
> Convert __assign_bit() to a macro since it's a very simple if-else and
> all of the checks are performed inside __set_bit() and __clear_bit(),
> thus that wrapper has to be as transparent as possible. After that
> change, despite it showing only -20 bytes change for vmlinux (due to
> that it's still relatively unpopular), no drastic code size changes
> happen when replacing if-set-else-clear for onstack bitmaps with
> __assign_bit(), meaning the compiler now expands them to the actual
> operations will all the expected optimizations.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/linux/bitops.h | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index e0cd09eb91cd..f98f4fd1047f 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -284,14 +284,8 @@ static __always_inline void assign_bit(long nr, volatile unsigned long *addr,
>  		clear_bit(nr, addr);
>  }
>  
> -static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
> -					 bool value)
> -{
> -	if (value)
> -		__set_bit(nr, addr);
> -	else
> -		__clear_bit(nr, addr);
> -}
> +#define __assign_bit(nr, addr, value)				\
> +	((value) ? __set_bit(nr, addr) : __clear_bit(nr, addr))

Can you protect nr and addr with braces just as well?
Can you convert the atomic version too, to keep them synchronized ?

>  
>  /**
>   * __ptr_set_bit - Set bit in a pointer's value
> -- 
> 2.41.0
