Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E309734B320
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Mar 2021 00:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhCZXr7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 19:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZXrr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 19:47:47 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16C9C0613AA;
        Fri, 26 Mar 2021 16:47:47 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id o66so7472143ybg.10;
        Fri, 26 Mar 2021 16:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5iNzMacML/7mp5cjsJfGS0noN/XHdXxDCnUv2zByK9g=;
        b=kp5A9HUfIWI3yvmUlpaMotw/ACcXQ/KJsJmNKKeFjzjUFlwh9sinu5CRjWD9e4Yo9g
         PAYWdYlJX7WrUAzSfBIIiunroOpl8aqQ4mklfpLdPXNVUwDxMkz3a22ncT71s7uSgcXD
         iURCHGiAnFaoqZ6790pYYD5h2wX3oeF5NI3MKII6z3XPtc9bNdw/e+BbRU58yPBxNhbT
         dqzQpr77oeH997MWfv5uJCcra9KWoAsIGV86oqG2br+GlyBKOtNZnX4EodSWjnb13kAX
         VYUhhYMghUVP9vzsdt6aJOO4cPaEXEsEKOQaqp/TNzizC7LRRmeT8Bw44GDJfimM+UGd
         qKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iNzMacML/7mp5cjsJfGS0noN/XHdXxDCnUv2zByK9g=;
        b=mEXpuc6pw9EbTiKhQV3B4cOSu0CW75MdLOtlQ0uB5DLU4R3KYyeTYfWslvH2l5pcCx
         j79AMQZlVx/7yDPJ6jdnSasl+UsmsCQUW7OOFUGal846WRLs0rnIKr7nmQZZRyqpxOfv
         BgKC139nRTCGvD+vkx8VeXm4pSnigHY0s1nqPZ7UGZW4sCbfK2lPAFweU59ijSNmwiqP
         vuPsdUsNL2xMZlzVtw3sLFrSZWOg3FK2A8K/iHAODi8L45DGzwbP8hfBnpCvbjXWluQ6
         +HuYYFowOhj0e4ygL12+1PxY1eb6hcvGtDlJTxYKVXKB+B2t+5gqTgRk7xi4GT8/3ni7
         ZGkw==
X-Gm-Message-State: AOAM533eccLLbSU1OnmL7uF5qhlpFG7h7mSwWAiLQi8YHMZ2GaB/vLY8
        PBNet0tz0zA59jyEgwW+D/JZxh266ml4XshBXlA=
X-Google-Smtp-Source: ABdhPJw0XA18SIlSYhK/6RXCP/rqME/PbAv7+DjAz5kdsQFSovvJ8uRL9mUiazdpCsepfjqRnmISe3IuHcFsUYMkSM0=
X-Received: by 2002:a25:ef42:: with SMTP id w2mr22500231ybm.34.1616802466491;
 Fri, 26 Mar 2021 16:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210326191859.1542272-4-nickrterrell@gmail.com> <202103270534.OKizLwFF-lkp@intel.com>
In-Reply-To: <202103270534.OKizLwFF-lkp@intel.com>
From:   Nick Terrell <nickrterrell@gmail.com>
Date:   Fri, 26 Mar 2021 16:47:35 -0700
Message-ID: <CANr2DbfJ3Kfuz3XkqTMOO2f91=UnKe_BVqzkYsvY=ndR2Dw0ow@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] lib: zstd: Upgrade to latest upstream zstd version 1.4.10
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

On Fri, Mar 26, 2021 at 3:02 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Nick,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on cryptodev/master]
> [also build test WARNING on kdave/for-next f2fs/dev-test linus/master v5.12-rc4 next-20210326]
> [cannot apply to crypto/master kees/for-next/pstore squashfs/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Nick-Terrell/Update-to-zstd-1-4-10/20210327-031827
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
> config: um-allmodconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/ebbff13fa6a537fb8b3dc6b42c3093f9ce4358f8
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Nick-Terrell/Update-to-zstd-1-4-10/20210327-031827
>         git checkout ebbff13fa6a537fb8b3dc6b42c3093f9ce4358f8
>         # save the attached .config to linux build tree
>         make W=1 ARCH=um
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    lib/zstd/compress/zstd_compress_sequences.c:17: warning: Cannot understand  * -log2(x / 256) lookup table for x in [0, 256).
>     on line 17 - I thought it was a doc line
>    lib/zstd/compress/zstd_compress_sequences.c:58: warning: Function parameter or member 'nbSeq' not described in 'ZSTD_useLowProbCount'
> >> lib/zstd/compress/zstd_compress_sequences.c:58: warning: expecting prototype for 1 else we should(). Prototype was for ZSTD_useLowProbCount() instead
> >> lib/zstd/compress/zstd_compress_sequences.c:67: warning: wrong kernel-doc identifier on line:
>     * Returns the cost in bytes of encoding the normalized count header.
>    lib/zstd/compress/zstd_compress_sequences.c:85: warning: Function parameter or member 'count' not described in 'ZSTD_entropyCost'
>    lib/zstd/compress/zstd_compress_sequences.c:85: warning: Function parameter or member 'max' not described in 'ZSTD_entropyCost'
>    lib/zstd/compress/zstd_compress_sequences.c:85: warning: Function parameter or member 'total' not described in 'ZSTD_entropyCost'
> >> lib/zstd/compress/zstd_compress_sequences.c:85: warning: expecting prototype for Returns the cost in bits of encoding the distribution described by count(). Prototype was for ZSTD_entropyCost() instead
>    lib/zstd/compress/zstd_compress_sequences.c:99: warning: wrong kernel-doc identifier on line:
>     * Returns the cost in bits of encoding the distribution in count using ctable.
>    lib/zstd/compress/zstd_compress_sequences.c:139: warning: Function parameter or member 'norm' not described in 'ZSTD_crossEntropyCost'
>    lib/zstd/compress/zstd_compress_sequences.c:139: warning: Function parameter or member 'accuracyLog' not described in 'ZSTD_crossEntropyCost'
>    lib/zstd/compress/zstd_compress_sequences.c:139: warning: Function parameter or member 'count' not described in 'ZSTD_crossEntropyCost'
>    lib/zstd/compress/zstd_compress_sequences.c:139: warning: Function parameter or member 'max' not described in 'ZSTD_crossEntropyCost'
> >> lib/zstd/compress/zstd_compress_sequences.c:139: warning: expecting prototype for Returns the cost in bits of encoding the distribution in count using the(). Prototype was for ZSTD_crossEntropyCost() instead
> --
>    lib/zstd/compress/zstd_ldm.c:584: warning: Function parameter or member 'rawSeqStore' not described in 'maybeSplitSequence'
>    lib/zstd/compress/zstd_ldm.c:584: warning: Function parameter or member 'remaining' not described in 'maybeSplitSequence'
>    lib/zstd/compress/zstd_ldm.c:584: warning: Function parameter or member 'minMatch' not described in 'maybeSplitSequence'
> >> lib/zstd/compress/zstd_ldm.c:584: warning: expecting prototype for If the sequence length is longer than remaining then the sequence is split(). Prototype was for maybeSplitSequence() instead
> --
> >> lib/zstd/decompress/zstd_decompress.c:992: warning: wrong kernel-doc identifier on line:
>     * Similar to ZSTD_nextSrcSizeToDecompress(), but when when a block input can be streamed,
> --
>    lib/zstd/decompress/huf_decompress.c:122: warning: Function parameter or member 'symbol' not described in 'HUF_DEltX1_set4'
>    lib/zstd/decompress/huf_decompress.c:122: warning: Function parameter or member 'nbBits' not described in 'HUF_DEltX1_set4'
> >> lib/zstd/decompress/huf_decompress.c:122: warning: expecting prototype for This is used to lay down 4 entries at(). Prototype was for HUF_DEltX1_set4() instead
> --
> >> lib/zstd/compress/zstd_compress.c:128: warning: wrong kernel-doc identifier on line:
>     * Clears and frees all of the dictionaries in the CCtx.
>    lib/zstd/compress/zstd_compress.c:265: warning: wrong kernel-doc identifier on line:
>     * Initializes the cctxParams from params and compressionLevel.
>    lib/zstd/compress/zstd_compress.c:289: warning: wrong kernel-doc identifier on line:
>     * Sets cctxParams' cParams and fParams from params, but otherwise leaves them alone.
>    lib/zstd/compress/zstd_compress.c:910: warning: wrong kernel-doc identifier on line:
>     * Initializes the local dict using the requested parameters.
>    lib/zstd/compress/zstd_compress.c:1457: warning: wrong kernel-doc identifier on line:
>     * Controls, for this matchState reset, whether the tables need to be cleared /
>    lib/zstd/compress/zstd_compress.c:1473: warning: cannot understand function prototype: 'typedef enum '
>    lib/zstd/compress/zstd_compress.c:5008: warning: Function parameter or member 'cParams' not described in 'ZSTD_dedicatedDictSearch_revertCParams'
> >> lib/zstd/compress/zstd_compress.c:5008: warning: expecting prototype for Reverses the adjustment applied to cparams when enabling dedicated dict(). Prototype was for ZSTD_dedicatedDictSearch_revertCParams() instead
>
>
> vim +58 lib/zstd/compress/zstd_compress_sequences.c
>
>     52
>     53  /**
>     54   * Returns true if we should use ncount=-1 else we should
>     55   * use ncount=1 for low probability symbols instead.
>     56   */
>     57  static unsigned ZSTD_useLowProbCount(size_t const nbSeq)
>   > 58  {
>     59      /* Heuristic: This should cover most blocks <= 16K and
>     60       * start to fade out after 16K to about 32K depending on
>     61       * comprssibility.
>     62       */
>     63      return nbSeq >= 2048;
>     64  }
>     65
>     66  /**
>   > 67   * Returns the cost in bytes of encoding the normalized count header.
>     68   * Returns an error if any of the helper functions return an error.
>     69   */
>     70  static size_t ZSTD_NCountCost(unsigned const* count, unsigned const max,
>     71                                size_t const nbSeq, unsigned const FSELog)
>     72  {
>     73      BYTE wksp[FSE_NCOUNTBOUND];
>     74      S16 norm[MaxSeq + 1];
>     75      const U32 tableLog = FSE_optimalTableLog(FSELog, nbSeq, max);
>     76      FORWARD_IF_ERROR(FSE_normalizeCount(norm, tableLog, count, nbSeq, max, ZSTD_useLowProbCount(nbSeq)), "");
>     77      return FSE_writeNCount(wksp, sizeof(wksp), norm, max, tableLog);
>     78  }
>     79
>     80  /**
>     81   * Returns the cost in bits of encoding the distribution described by count
>     82   * using the entropy bound.
>     83   */
>     84  static size_t ZSTD_entropyCost(unsigned const* count, unsigned const max, size_t const total)
>   > 85  {
>     86      unsigned cost = 0;
>     87      unsigned s;
>     88      for (s = 0; s <= max; ++s) {
>     89          unsigned norm = (unsigned)((256 * count[s]) / total);
>     90          if (count[s] != 0 && norm == 0)
>     91              norm = 1;
>     92          assert(count[s] < total);
>     93          cost += count[s] * kInverseProbabilityLog256[norm];
>     94      }
>     95      return cost >> 8;
>     96  }
>     97
>     98  /**
>     99   * Returns the cost in bits of encoding the distribution in count using ctable.
>    100   * Returns an error if ctable cannot represent all the symbols in count.
>    101   */
>    102  size_t ZSTD_fseBitCost(
>    103      FSE_CTable const* ctable,
>    104      unsigned const* count,
>    105      unsigned const max)
>    106  {
>    107      unsigned const kAccuracyLog = 8;
>    108      size_t cost = 0;
>    109      unsigned s;
>    110      FSE_CState_t cstate;
>    111      FSE_initCState(&cstate, ctable);
>    112      if (ZSTD_getFSEMaxSymbolValue(ctable) < max) {
>    113          DEBUGLOG(5, "Repeat FSE_CTable has maxSymbolValue %u < %u",
>    114                      ZSTD_getFSEMaxSymbolValue(ctable), max);
>    115          return ERROR(GENERIC);
>    116      }
>    117      for (s = 0; s <= max; ++s) {
>    118          unsigned const tableLog = cstate.stateLog;
>    119          unsigned const badCost = (tableLog + 1) << kAccuracyLog;
>    120          unsigned const bitCost = FSE_bitCost(cstate.symbolTT, tableLog, s, kAccuracyLog);
>    121          if (count[s] == 0)
>    122              continue;
>    123          if (bitCost >= badCost) {
>    124              DEBUGLOG(5, "Repeat FSE_CTable has Prob[%u] == 0", s);
>    125              return ERROR(GENERIC);
>    126          }
>    127          cost += (size_t)count[s] * bitCost;
>    128      }
>    129      return cost >> kAccuracyLog;
>    130  }
>    131
>    132  /**
>    133   * Returns the cost in bits of encoding the distribution in count using the
>    134   * table described by norm. The max symbol support by norm is assumed >= max.
>    135   * norm must be valid for every symbol with non-zero probability in count.
>    136   */
>    137  size_t ZSTD_crossEntropyCost(short const* norm, unsigned accuracyLog,
>    138                               unsigned const* count, unsigned const max)
>  > 139  {
>    140      unsigned const shift = 8 - accuracyLog;
>    141      size_t cost = 0;
>    142      unsigned s;
>    143      assert(accuracyLog <= 8);
>    144      for (s = 0; s <= max; ++s) {
>    145          unsigned const normAcc = (norm[s] != -1) ? (unsigned)norm[s] : 1;
>    146          unsigned const norm256 = normAcc << shift;
>    147          assert(norm256 > 0);
>    148          assert(norm256 < 256);
>    149          cost += count[s] * kInverseProbabilityLog256[norm256];
>    150      }
>    151      return cost >> 8;
>    152  }
>    153
>

These all seem to be comment style warnings. Since this is code
imported from an upstream project, it doesn't make sense to adhere to
the kernel comment style. The public header `include/linux/zstd.h`
should adhere to the kernel style guide, but not `lib/zstd`.

-Nick

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
