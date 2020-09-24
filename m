Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1052766BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 05:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgIXDGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 23:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgIXDGI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 23:06:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4829C0613CE;
        Wed, 23 Sep 2020 20:06:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so2077226wrn.10;
        Wed, 23 Sep 2020 20:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+AMXhkc8gQOOArFCuMtLDRMg0ycafzPZM+2quzOAFg=;
        b=KS+yIFZUeS/PUDTUKGGTQsqHupnyMwA3s1N/ks81eixFP5uVUzK0y/63T5cNr327Xx
         6LoIbWbD/nyUdI0AvFgGz4uRQKOIfztyhwGOK6Ay2O+VA4d5ihkNjpm6Uv3OoSQdf0KF
         K9b40mOtqTjqllMcCikNhed+QaCG7keqm67Bzd5+uZZq4zbv6+USoQ2ysqGaRFOev7wk
         dk7ARQDWHpeumc9maX1arMdJDZx9hflMaO/lygxJz6cMjctMMqLj5Nn/leFYnL2sYmrY
         2nrnP911NBgl9V4aPQQKn7ZCQpcKXoqGBZbdbA2Qz9I+K8qMyWgYmwONaWvXck28s0g2
         6TGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+AMXhkc8gQOOArFCuMtLDRMg0ycafzPZM+2quzOAFg=;
        b=hiZU9BM7MBFrrJaaJ+Pi5f6adjtqyaUhCqMRbeCPvne64o3cZvddBNkRlJQXV/JP9z
         XShUI4Mi32PsWHC2JHN+qMD0E2wyJzjPr7fRMIlA2j7t1zbusf2J/giapwenAgbuUsTN
         brmMagxLHFqSYtacqYq9kSUFfDAM/PMp8LncmP3s8f+5a3zdQjSM02uHxk9qE8Ov3ASj
         ZZ7gmFiTG9yQ3zLh3tWuqA9TKTry5LSJb8imbwp5Uh0O7XKgYq/gulCLqFAQMnTb47Lp
         XFXeHbGcIeP3sCOnvcmwdORQylUYJ9spda4GH573pcCePEVU3XuZCQik0Z+Ft/xtRpF/
         /OcQ==
X-Gm-Message-State: AOAM5332U8RnI48VUinN8AUzikLNXi1A8lcc3YeUN+7v7vcyqe1HVqDE
        lQkLnmyltxRCsZkeyyI6tSveRfHPnC8tAMY3GDzYmEnK
X-Google-Smtp-Source: ABdhPJzvlLf/ESS96Z0UOO6R+IKLhoTuNhlPNNMBLXe0ODwve4RRV/DbrSW1+Y9zuttOdAXJF44gEkp5NmSJlJxn2/o=
X-Received: by 2002:adf:80e4:: with SMTP id 91mr2546542wrl.223.1600916766170;
 Wed, 23 Sep 2020 20:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200923224206.68968-4-nickrterrell@gmail.com> <202009241007.ZmzDeiuB%lkp@intel.com>
In-Reply-To: <202009241007.ZmzDeiuB%lkp@intel.com>
From:   Nick Terrell <nickrterrell@gmail.com>
Date:   Wed, 23 Sep 2020 20:05:55 -0700
Message-ID: <CANr2Dbd1DXb66_Gf9aAB7PCn6=yz_Or5_JWZtm_cHndYrO+28A@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] lib: zstd: Upgrade to latest upstream zstd version 1.4.6
To:     kernel test robot <lkp@intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, kbuild-all@lists.01.org,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Petr Malat <oss@malat.biz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 23, 2020 at 7:28 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Nick,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on kdave/for-next]
> [also build test ERROR on f2fs/dev-test linus/master v5.9-rc6 next-20200923]
> [cannot apply to cryptodev/master crypto/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Nick-Terrell/Update-to-zstd-1-4-6/20200924-064102
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> config: h8300-randconfig-p002-20200923 (attached as .config)
> compiler: h8300-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=h8300
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    h8300-linux-ld: lib/zstd/common/entropy_common.o: in function `MEM_swap32':
> >> lib/zstd/common/mem.h:179: undefined reference to `__bswapsi2'
> >> h8300-linux-ld: lib/zstd/common/mem.h:179: undefined reference to `__bswapsi2'
> >> h8300-linux-ld: lib/zstd/common/mem.h:179: undefined reference to `__bswapsi2'
> >> h8300-linux-ld: lib/zstd/common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/common/fse_decompress.o: in function `MEM_swap32':
> >> lib/zstd/common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/common/fse_decompress.o:lib/zstd/common/mem.h:179: more undefined references to `__bswapsi2' follow
>    h8300-linux-ld: lib/zstd/compress/zstd_compress.o: in function `MEM_swap64':
> >> lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>    h8300-linux-ld: lib/zstd/compress/zstd_compress.o: in function `MEM_swap32':
> >> lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
> >> h8300-linux-ld: lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
> >> h8300-linux-ld: lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
> >> h8300-linux-ld: lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
> >> h8300-linux-ld: lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/compress/zstd_compress.o:lib/zstd/compress/../common/mem.h:179: more undefined references to `__bswapsi2' follow
>    h8300-linux-ld: lib/zstd/compress/zstd_double_fast.o: in function `MEM_swap64':
> >> lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
> >> h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
> >> h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
> >> h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
> >> h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>    h8300-linux-ld: lib/zstd/compress/zstd_double_fast.o:lib/zstd/compress/../common/mem.h:192: more undefined references to `__bswapdi2' follow
>    h8300-linux-ld: lib/zstd/compress/zstd_opt.o: in function `MEM_swap32':
> >> lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
> >> h8300-linux-ld: lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/compress/zstd_opt.o: in function `MEM_swap64':
> >> lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
> >> h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>    h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>    h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>    h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>    h8300-linux-ld: lib/zstd/compress/zstd_opt.o:lib/zstd/compress/../common/mem.h:192: more undefined references to `__bswapdi2' follow
>    h8300-linux-ld: lib/zstd/decompress/huf_decompress.o: in function `MEM_swap32':
>    lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/huf_decompress.o:lib/zstd/decompress/../common/mem.h:179: more undefined references to `__bswapsi2' follow
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap64':
>    lib/zstd/decompress/../common/mem.h:192: undefined reference to `__bswapdi2'
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap32':
>    lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o:lib/zstd/decompress/../common/mem.h:179: more undefined references to `__bswapsi2' follow
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap64':
>    lib/zstd/decompress/../common/mem.h:192: undefined reference to `__bswapdi2'
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap32':
>    lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap64':
>    lib/zstd/decompress/../common/mem.h:192: undefined reference to `__bswapdi2'
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap32':
>    lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap64':
>    lib/zstd/decompress/../common/mem.h:192: undefined reference to `__bswapdi2'
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap32':
>    lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap64':
>    lib/zstd/decompress/../common/mem.h:192: undefined reference to `__bswapdi2'
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap32':
>    lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o:lib/zstd/decompress/../common/mem.h:179: more undefined references to `__bswapsi2' follow
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap64':
>    lib/zstd/decompress/../common/mem.h:192: undefined reference to `__bswapdi2'
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap32':
>    lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress_block.o: in function `MEM_swap32':
>    lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>    h8300-linux-ld: lib/zstd/decompress/zstd_decompress_block.o:lib/zstd/decompress/../common/mem.h:179: more undefined references to `__bswapsi2' follow

Looks like I need to fix these. It looks like I should use the swab*()
functions from include/linux/swab.h. I'll put up a v4 shortly.

> cppcheck warnings: (new ones prefixed by >>)
>
> >> lib/zstd/decompress/zstd_ddict.c:147:32: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
>        if (!customMem.customAlloc ^ !customMem.customFree) return NULL;
>                                   ^

This one is a bit silly, but I will fix it.

> >> lib/zstd/common/zstd_deps.h:131:0: warning: syntax error [syntaxError]
>
>    ^
> >> lib/zstd/compress/zstd_ldm.c:571:0: warning: Array 'rep[3]' accessed at index 3, which is out of bounds. [arrayIndexOutOfBounds]
>        ZSTD_blockCompressor const blockCompressor =
>    ^

This seems like a false positive.

> >> lib/zstd/common/zstd_deps.h:131:0: warning: syntax error [syntaxError]
>
>    ^
> >> lib/zstd/decompress/zstd_decompress.c:133:32: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
>        if (!customMem.customAlloc ^ !customMem.customFree) return NULL;
>                                   ^
> >> lib/zstd/decompress/zstd_decompress.c:1751:28: warning: Variable 'zds->inPos' is reassigned a value before the old one has been used. [redundantAssignment]
>                    zds->inPos = 0;   /* input is consumed */
>                               ^
>    lib/zstd/decompress/zstd_decompress.c:1747:28: note: Variable 'zds->inPos' is reassigned a value before the old one has been used.
>                    zds->inPos += loadedSize;
>                               ^
>    lib/zstd/decompress/zstd_decompress.c:1751:28: note: Variable 'zds->inPos' is reassigned a value before the old one has been used.
>                    zds->inPos = 0;   /* input is consumed */
>                               ^

This is a false positive. It is incorrectly analyzing the control flow.

> >> lib/zstd/common/zstd_deps.h:131:0: warning: syntax error [syntaxError]
>
>    ^
> >> lib/zstd/compress/zstd_compress.c:84:32: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
>        if (!customMem.customAlloc ^ !customMem.customFree) return NULL;
>                                   ^
>    lib/zstd/compress/zstd_compress.c:200:32: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
>        if (!customMem.customAlloc ^ !customMem.customFree) return NULL;
>                                   ^
>    lib/zstd/compress/zstd_compress.c:3345:32: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
>        if (!customMem.customAlloc ^ !customMem.customFree) return NULL;
>                                   ^
> >> lib/zstd/common/zstd_internal.h:401:27: warning: Array 'DeBruijnClz[32]' accessed at index 509099, which is out of bounds. [arrayIndexOutOfBounds]
>            return DeBruijnClz[(v * 0x07C4ACDDU) >> 27];
>                              ^

This is a false positive. v is a 32-bit integer, so the index must be
less than 2^(32-27) = 32, which is the size of the array.

>    lib/zstd/compress/zstd_compress.c:3494:40: note: Assignment 'limitedSrcSize=(uint32_t)(pledgedSrcSize<524288U?pledgedSrcSize:524288U)', assigned value is 524288
>                U32 const limitedSrcSize = (U32)MIN(pledgedSrcSize, 1U << 19);
>                                           ^
>    lib/zstd/compress/zstd_compress.c:3495:90: note: Calling function 'ZSTD_highbit32', 1st argument 'limitedSrcSize-1' value is 524287
>                U32 const limitedSrcLog = limitedSrcSize > 1 ? ZSTD_highbit32(limitedSrcSize - 1) + 1 : 1;
>                                                                                             ^
>    lib/zstd/common/zstd_internal.h:395:17: note: Assignment 'v=val', assigned value is 524287
>            U32 v = val;
>                    ^
>    lib/zstd/common/zstd_internal.h:396:0: note: Assignment 'v=v|(v>>1)', assigned value is 524287
>            v |= v >> 1;
>    ^
>    lib/zstd/common/zstd_internal.h:397:0: note: Assignment 'v=v|(v>>2)', assigned value is 524287
>            v |= v >> 2;
>    ^
>    lib/zstd/common/zstd_internal.h:398:0: note: Assignment 'v=v|(v>>4)', assigned value is 524287
>            v |= v >> 4;
>    ^
>    lib/zstd/common/zstd_internal.h:399:0: note: Assignment 'v=v|(v>>8)', assigned value is 524287
>            v |= v >> 8;
>    ^
>    lib/zstd/common/zstd_internal.h:400:0: note: Assignment 'v=v|(v>>16)', assigned value is 524287
>            v |= v >> 16;
>    ^
>    lib/zstd/common/zstd_internal.h:401:27: note: Array index out of bounds
>            return DeBruijnClz[(v * 0x07C4ACDDU) >> 27];
>                              ^
> >> lib/zstd/common/zstd_deps.h:131:0: warning: syntax error [syntaxError]
>
>    ^
> >> lib/zstd/compress/zstd_lazy.c:663:74: warning: Overflow in pointer arithmetic, NULL pointer is subtracted. [nullPointerArithmetic]
>        const U32 dictAndPrefixLength = (U32)((ip - prefixLowest) + (dictEnd - dictLowest));
>                                                                             ^
>    lib/zstd/compress/zstd_lazy.c:658:70: note: Assignment 'dictEnd=dictMode==ZSTD_dictMatchState?dms->window.nextSrc:NULL', assigned value is 0
>        const BYTE* const dictEnd      = dictMode == ZSTD_dictMatchState ?
>                                                                         ^
>    lib/zstd/compress/zstd_lazy.c:663:74: note: Null pointer subtraction
>        const U32 dictAndPrefixLength = (U32)((ip - prefixLowest) + (dictEnd - dictLowest));
>                                                                             ^
> >> lib/zstd/common/zstd_deps.h:131:0: warning: syntax error [syntaxError]
>
>    ^
> >> lib/zstd/compress/zstd_double_fast.c:97:75: warning: Overflow in pointer arithmetic, NULL pointer is subtracted. [nullPointerArithmetic]
>        const U32 dictAndPrefixLength  = (U32)((ip - prefixLowest) + (dictEnd - dictStart));
>                                                                              ^
>    lib/zstd/compress/zstd_double_fast.c:88:70: note: Assignment 'dictEnd=dictMode==ZSTD_dictMatchState?dms->window.nextSrc:NULL', assigned value is 0
>        const BYTE* const dictEnd      = dictMode == ZSTD_dictMatchState ?
>                                                                         ^
>    lib/zstd/compress/zstd_double_fast.c:97:75: note: Null pointer subtraction
>        const U32 dictAndPrefixLength  = (U32)((ip - prefixLowest) + (dictEnd - dictStart));
>                                                                              ^

Seems like another false positive.

> >> lib/zstd/common/zstd_deps.h:131:0: warning: syntax error [syntaxError]
>
>    ^
>
> # https://github.com/0day-ci/linux/commit/400786d3b08436113bcb3c9c16a97eefc31317c1
> git remote add linux-review https://github.com/0day-ci/linux
> git fetch --no-tags linux-review Nick-Terrell/Update-to-zstd-1-4-6/20200924-064102
> git checkout 400786d3b08436113bcb3c9c16a97eefc31317c1
> vim +179 lib/zstd/common/mem.h
>
>    173
>    174
>    175  MEM_STATIC U32 MEM_swap32(U32 in)
>    176  {
>    177  #if (defined (__GNUC__) && (__GNUC__ * 100 + __GNUC_MINOR__ >= 403)) \
>    178    || (defined(__clang__) && __has_builtin(__builtin_bswap32))
>  > 179      return __builtin_bswap32(in);
>    180  #else
>    181      return  ((in << 24) & 0xff000000 ) |
>    182              ((in <<  8) & 0x00ff0000 ) |
>    183              ((in >>  8) & 0x0000ff00 ) |
>    184              ((in >> 24) & 0x000000ff );
>    185  #endif
>    186  }
>    187
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
