Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6E8276B81
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 10:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgIXIMY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 04:12:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:22501 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbgIXIMX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 04:12:23 -0400
IronPort-SDR: K9+fLubVdWcQxyqCclXGH0y9Im/vVqzOXyOGK6ljuGVlYhYOdsfQp7Hmrf+gv8AELtURTzIngb
 Un18KYA8HT+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="148788393"
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="148788393"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 01:12:19 -0700
IronPort-SDR: BtwXldKVE7FWHcMuvMuakmnXOuV12N8g1pU9clav6f9fP5xx1yxoT61v16dd0q5EH/jHe2z0Db
 eHSu5KC11YzA==
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="335847157"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 01:12:16 -0700
Subject: Re: [PATCH v3 3/9] lib: zstd: Upgrade to latest upstream zstd version
 1.4.6
To:     Nick Terrell <nickrterrell@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, kbuild-all@lists.01.org,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Petr Malat <oss@malat.biz>
References: <20200923224206.68968-4-nickrterrell@gmail.com>
 <202009241007.ZmzDeiuB%lkp@intel.com>
 <CANr2Dbd1DXb66_Gf9aAB7PCn6=yz_Or5_JWZtm_cHndYrO+28A@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <270836be-7c35-f204-39d9-ab095af66d1a@intel.com>
Date:   Thu, 24 Sep 2020 16:11:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANr2Dbd1DXb66_Gf9aAB7PCn6=yz_Or5_JWZtm_cHndYrO+28A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nick,

Thanks for the feedback, we'll take a look at these errors that maybe 
false positives.

Best Regards,
Rong Chen

On 9/24/20 11:05 AM, Nick Terrell wrote:
> On Wed, Sep 23, 2020 at 7:28 PM kernel test robot <lkp@intel.com> wrote:
>> Hi Nick,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on kdave/for-next]
>> [also build test ERROR on f2fs/dev-test linus/master v5.9-rc6 next-20200923]
>> [cannot apply to cryptodev/master crypto/master]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Nick-Terrell/Update-to-zstd-1-4-6/20200924-064102
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
>> config: h8300-randconfig-p002-20200923 (attached as .config)
>> compiler: h8300-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=h8300
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     h8300-linux-ld: lib/zstd/common/entropy_common.o: in function `MEM_swap32':
>>>> lib/zstd/common/mem.h:179: undefined reference to `__bswapsi2'
>>>> h8300-linux-ld: lib/zstd/common/mem.h:179: undefined reference to `__bswapsi2'
>>>> h8300-linux-ld: lib/zstd/common/mem.h:179: undefined reference to `__bswapsi2'
>>>> h8300-linux-ld: lib/zstd/common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/common/fse_decompress.o: in function `MEM_swap32':
>>>> lib/zstd/common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/common/fse_decompress.o:lib/zstd/common/mem.h:179: more undefined references to `__bswapsi2' follow
>>     h8300-linux-ld: lib/zstd/compress/zstd_compress.o: in function `MEM_swap64':
>>>> lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>     h8300-linux-ld: lib/zstd/compress/zstd_compress.o: in function `MEM_swap32':
>>>> lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>>> h8300-linux-ld: lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>>> h8300-linux-ld: lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>>> h8300-linux-ld: lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>>> h8300-linux-ld: lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/compress/zstd_compress.o:lib/zstd/compress/../common/mem.h:179: more undefined references to `__bswapsi2' follow
>>     h8300-linux-ld: lib/zstd/compress/zstd_double_fast.o: in function `MEM_swap64':
>>>> lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>>> h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>>> h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>>> h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>>> h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>     h8300-linux-ld: lib/zstd/compress/zstd_double_fast.o:lib/zstd/compress/../common/mem.h:192: more undefined references to `__bswapdi2' follow
>>     h8300-linux-ld: lib/zstd/compress/zstd_opt.o: in function `MEM_swap32':
>>>> lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>>> h8300-linux-ld: lib/zstd/compress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/compress/zstd_opt.o: in function `MEM_swap64':
>>>> lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>>> h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>     h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>     h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>     h8300-linux-ld: lib/zstd/compress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>     h8300-linux-ld: lib/zstd/compress/zstd_opt.o:lib/zstd/compress/../common/mem.h:192: more undefined references to `__bswapdi2' follow
>>     h8300-linux-ld: lib/zstd/decompress/huf_decompress.o: in function `MEM_swap32':
>>     lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/huf_decompress.o:lib/zstd/decompress/../common/mem.h:179: more undefined references to `__bswapsi2' follow
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap64':
>>     lib/zstd/decompress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap32':
>>     lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o:lib/zstd/decompress/../common/mem.h:179: more undefined references to `__bswapsi2' follow
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap64':
>>     lib/zstd/decompress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap32':
>>     lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap64':
>>     lib/zstd/decompress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap32':
>>     lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap64':
>>     lib/zstd/decompress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap32':
>>     lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap64':
>>     lib/zstd/decompress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap32':
>>     lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o:lib/zstd/decompress/../common/mem.h:179: more undefined references to `__bswapsi2' follow
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap64':
>>     lib/zstd/decompress/../common/mem.h:192: undefined reference to `__bswapdi2'
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress.o: in function `MEM_swap32':
>>     lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress_block.o: in function `MEM_swap32':
>>     lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/../common/mem.h:179: undefined reference to `__bswapsi2'
>>     h8300-linux-ld: lib/zstd/decompress/zstd_decompress_block.o:lib/zstd/decompress/../common/mem.h:179: more undefined references to `__bswapsi2' follow
> Looks like I need to fix these. It looks like I should use the swab*()
> functions from include/linux/swab.h. I'll put up a v4 shortly.
>
>> cppcheck warnings: (new ones prefixed by >>)
>>
>>>> lib/zstd/decompress/zstd_ddict.c:147:32: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
>>         if (!customMem.customAlloc ^ !customMem.customFree) return NULL;
>>                                    ^
> This one is a bit silly, but I will fix it.
>
>>>> lib/zstd/common/zstd_deps.h:131:0: warning: syntax error [syntaxError]
>>     ^
>>>> lib/zstd/compress/zstd_ldm.c:571:0: warning: Array 'rep[3]' accessed at index 3, which is out of bounds. [arrayIndexOutOfBounds]
>>         ZSTD_blockCompressor const blockCompressor =
>>     ^
> This seems like a false positive.
>
>>>> lib/zstd/common/zstd_deps.h:131:0: warning: syntax error [syntaxError]
>>     ^
>>>> lib/zstd/decompress/zstd_decompress.c:133:32: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
>>         if (!customMem.customAlloc ^ !customMem.customFree) return NULL;
>>                                    ^
>>>> lib/zstd/decompress/zstd_decompress.c:1751:28: warning: Variable 'zds->inPos' is reassigned a value before the old one has been used. [redundantAssignment]
>>                     zds->inPos = 0;   /* input is consumed */
>>                                ^
>>     lib/zstd/decompress/zstd_decompress.c:1747:28: note: Variable 'zds->inPos' is reassigned a value before the old one has been used.
>>                     zds->inPos += loadedSize;
>>                                ^
>>     lib/zstd/decompress/zstd_decompress.c:1751:28: note: Variable 'zds->inPos' is reassigned a value before the old one has been used.
>>                     zds->inPos = 0;   /* input is consumed */
>>                                ^
> This is a false positive. It is incorrectly analyzing the control flow.
>
>>>> lib/zstd/common/zstd_deps.h:131:0: warning: syntax error [syntaxError]
>>     ^
>>>> lib/zstd/compress/zstd_compress.c:84:32: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
>>         if (!customMem.customAlloc ^ !customMem.customFree) return NULL;
>>                                    ^
>>     lib/zstd/compress/zstd_compress.c:200:32: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
>>         if (!customMem.customAlloc ^ !customMem.customFree) return NULL;
>>                                    ^
>>     lib/zstd/compress/zstd_compress.c:3345:32: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
>>         if (!customMem.customAlloc ^ !customMem.customFree) return NULL;
>>                                    ^
>>>> lib/zstd/common/zstd_internal.h:401:27: warning: Array 'DeBruijnClz[32]' accessed at index 509099, which is out of bounds. [arrayIndexOutOfBounds]
>>             return DeBruijnClz[(v * 0x07C4ACDDU) >> 27];
>>                               ^
> This is a false positive. v is a 32-bit integer, so the index must be
> less than 2^(32-27) = 32, which is the size of the array.
>
>>     lib/zstd/compress/zstd_compress.c:3494:40: note: Assignment 'limitedSrcSize=(uint32_t)(pledgedSrcSize<524288U?pledgedSrcSize:524288U)', assigned value is 524288
>>                 U32 const limitedSrcSize = (U32)MIN(pledgedSrcSize, 1U << 19);
>>                                            ^
>>     lib/zstd/compress/zstd_compress.c:3495:90: note: Calling function 'ZSTD_highbit32', 1st argument 'limitedSrcSize-1' value is 524287
>>                 U32 const limitedSrcLog = limitedSrcSize > 1 ? ZSTD_highbit32(limitedSrcSize - 1) + 1 : 1;
>>                                                                                              ^
>>     lib/zstd/common/zstd_internal.h:395:17: note: Assignment 'v=val', assigned value is 524287
>>             U32 v = val;
>>                     ^
>>     lib/zstd/common/zstd_internal.h:396:0: note: Assignment 'v=v|(v>>1)', assigned value is 524287
>>             v |= v >> 1;
>>     ^
>>     lib/zstd/common/zstd_internal.h:397:0: note: Assignment 'v=v|(v>>2)', assigned value is 524287
>>             v |= v >> 2;
>>     ^
>>     lib/zstd/common/zstd_internal.h:398:0: note: Assignment 'v=v|(v>>4)', assigned value is 524287
>>             v |= v >> 4;
>>     ^
>>     lib/zstd/common/zstd_internal.h:399:0: note: Assignment 'v=v|(v>>8)', assigned value is 524287
>>             v |= v >> 8;
>>     ^
>>     lib/zstd/common/zstd_internal.h:400:0: note: Assignment 'v=v|(v>>16)', assigned value is 524287
>>             v |= v >> 16;
>>     ^
>>     lib/zstd/common/zstd_internal.h:401:27: note: Array index out of bounds
>>             return DeBruijnClz[(v * 0x07C4ACDDU) >> 27];
>>                               ^
>>>> lib/zstd/common/zstd_deps.h:131:0: warning: syntax error [syntaxError]
>>     ^
>>>> lib/zstd/compress/zstd_lazy.c:663:74: warning: Overflow in pointer arithmetic, NULL pointer is subtracted. [nullPointerArithmetic]
>>         const U32 dictAndPrefixLength = (U32)((ip - prefixLowest) + (dictEnd - dictLowest));
>>                                                                              ^
>>     lib/zstd/compress/zstd_lazy.c:658:70: note: Assignment 'dictEnd=dictMode==ZSTD_dictMatchState?dms->window.nextSrc:NULL', assigned value is 0
>>         const BYTE* const dictEnd      = dictMode == ZSTD_dictMatchState ?
>>                                                                          ^
>>     lib/zstd/compress/zstd_lazy.c:663:74: note: Null pointer subtraction
>>         const U32 dictAndPrefixLength = (U32)((ip - prefixLowest) + (dictEnd - dictLowest));
>>                                                                              ^
>>>> lib/zstd/common/zstd_deps.h:131:0: warning: syntax error [syntaxError]
>>     ^
>>>> lib/zstd/compress/zstd_double_fast.c:97:75: warning: Overflow in pointer arithmetic, NULL pointer is subtracted. [nullPointerArithmetic]
>>         const U32 dictAndPrefixLength  = (U32)((ip - prefixLowest) + (dictEnd - dictStart));
>>                                                                               ^
>>     lib/zstd/compress/zstd_double_fast.c:88:70: note: Assignment 'dictEnd=dictMode==ZSTD_dictMatchState?dms->window.nextSrc:NULL', assigned value is 0
>>         const BYTE* const dictEnd      = dictMode == ZSTD_dictMatchState ?
>>                                                                          ^
>>     lib/zstd/compress/zstd_double_fast.c:97:75: note: Null pointer subtraction
>>         const U32 dictAndPrefixLength  = (U32)((ip - prefixLowest) + (dictEnd - dictStart));
>>                                                                               ^
> Seems like another false positive.
>
>>>> lib/zstd/common/zstd_deps.h:131:0: warning: syntax error [syntaxError]
>>     ^
>>
>> # https://github.com/0day-ci/linux/commit/400786d3b08436113bcb3c9c16a97eefc31317c1
>> git remote add linux-review https://github.com/0day-ci/linux
>> git fetch --no-tags linux-review Nick-Terrell/Update-to-zstd-1-4-6/20200924-064102
>> git checkout 400786d3b08436113bcb3c9c16a97eefc31317c1
>> vim +179 lib/zstd/common/mem.h
>>
>>     173
>>     174
>>     175  MEM_STATIC U32 MEM_swap32(U32 in)
>>     176  {
>>     177  #if (defined (__GNUC__) && (__GNUC__ * 100 + __GNUC_MINOR__ >= 403)) \
>>     178    || (defined(__clang__) && __has_builtin(__builtin_bswap32))
>>   > 179      return __builtin_bswap32(in);
>>     180  #else
>>     181      return  ((in << 24) & 0xff000000 ) |
>>     182              ((in <<  8) & 0x00ff0000 ) |
>>     183              ((in >>  8) & 0x0000ff00 ) |
>>     184              ((in >> 24) & 0x000000ff );
>>     185  #endif
>>     186  }
>>     187
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

