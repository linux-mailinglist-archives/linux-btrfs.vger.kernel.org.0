Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2885034B1C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 23:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhCZWCo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 18:02:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:42897 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhCZWC2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 18:02:28 -0400
IronPort-SDR: 39BTti3l25Fj/vbFH/I5NmbYQyBKK4NMdk9C8BapQLosrmoTBbYyJezNXMgUkOCmXTc/LnSFqi
 fok9bqRRLI1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="252577517"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="gz'50?scan'50,208,50";a="252577517"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:02:27 -0700
IronPort-SDR: 0/IqmycPoHJQCGePh/HIkhaXxMIZatnXZMHSg6flDibU+Ep89pkwbDgYdm1n1Si/PEAZzERj78
 WNlZq7+a2n0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="gz'50?scan'50,208,50";a="414689872"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Mar 2021 15:02:23 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPuX9-00033D-8x; Fri, 26 Mar 2021 22:02:23 +0000
Date:   Sat, 27 Mar 2021 06:02:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild-all@lists.01.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Petr Malat <oss@malat.biz>
Subject: Re: [PATCH v8 3/3] lib: zstd: Upgrade to latest upstream zstd
 version 1.4.10
Message-ID: <202103270534.OKizLwFF-lkp@intel.com>
References: <20210326191859.1542272-4-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20210326191859.1542272-4-nickrterrell@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nick,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on cryptodev/master]
[also build test WARNING on kdave/for-next f2fs/dev-test linus/master v5.12-rc4 next-20210326]
[cannot apply to crypto/master kees/for-next/pstore squashfs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nick-Terrell/Update-to-zstd-1-4-10/20210327-031827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: um-allmodconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/ebbff13fa6a537fb8b3dc6b42c3093f9ce4358f8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nick-Terrell/Update-to-zstd-1-4-10/20210327-031827
        git checkout ebbff13fa6a537fb8b3dc6b42c3093f9ce4358f8
        # save the attached .config to linux build tree
        make W=1 ARCH=um 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/zstd/compress/zstd_compress_sequences.c:17: warning: Cannot understand  * -log2(x / 256) lookup table for x in [0, 256).
    on line 17 - I thought it was a doc line
   lib/zstd/compress/zstd_compress_sequences.c:58: warning: Function parameter or member 'nbSeq' not described in 'ZSTD_useLowProbCount'
>> lib/zstd/compress/zstd_compress_sequences.c:58: warning: expecting prototype for 1 else we should(). Prototype was for ZSTD_useLowProbCount() instead
>> lib/zstd/compress/zstd_compress_sequences.c:67: warning: wrong kernel-doc identifier on line:
    * Returns the cost in bytes of encoding the normalized count header.
   lib/zstd/compress/zstd_compress_sequences.c:85: warning: Function parameter or member 'count' not described in 'ZSTD_entropyCost'
   lib/zstd/compress/zstd_compress_sequences.c:85: warning: Function parameter or member 'max' not described in 'ZSTD_entropyCost'
   lib/zstd/compress/zstd_compress_sequences.c:85: warning: Function parameter or member 'total' not described in 'ZSTD_entropyCost'
>> lib/zstd/compress/zstd_compress_sequences.c:85: warning: expecting prototype for Returns the cost in bits of encoding the distribution described by count(). Prototype was for ZSTD_entropyCost() instead
   lib/zstd/compress/zstd_compress_sequences.c:99: warning: wrong kernel-doc identifier on line:
    * Returns the cost in bits of encoding the distribution in count using ctable.
   lib/zstd/compress/zstd_compress_sequences.c:139: warning: Function parameter or member 'norm' not described in 'ZSTD_crossEntropyCost'
   lib/zstd/compress/zstd_compress_sequences.c:139: warning: Function parameter or member 'accuracyLog' not described in 'ZSTD_crossEntropyCost'
   lib/zstd/compress/zstd_compress_sequences.c:139: warning: Function parameter or member 'count' not described in 'ZSTD_crossEntropyCost'
   lib/zstd/compress/zstd_compress_sequences.c:139: warning: Function parameter or member 'max' not described in 'ZSTD_crossEntropyCost'
>> lib/zstd/compress/zstd_compress_sequences.c:139: warning: expecting prototype for Returns the cost in bits of encoding the distribution in count using the(). Prototype was for ZSTD_crossEntropyCost() instead
--
   lib/zstd/compress/zstd_ldm.c:584: warning: Function parameter or member 'rawSeqStore' not described in 'maybeSplitSequence'
   lib/zstd/compress/zstd_ldm.c:584: warning: Function parameter or member 'remaining' not described in 'maybeSplitSequence'
   lib/zstd/compress/zstd_ldm.c:584: warning: Function parameter or member 'minMatch' not described in 'maybeSplitSequence'
>> lib/zstd/compress/zstd_ldm.c:584: warning: expecting prototype for If the sequence length is longer than remaining then the sequence is split(). Prototype was for maybeSplitSequence() instead
--
>> lib/zstd/decompress/zstd_decompress.c:992: warning: wrong kernel-doc identifier on line:
    * Similar to ZSTD_nextSrcSizeToDecompress(), but when when a block input can be streamed,
--
   lib/zstd/decompress/huf_decompress.c:122: warning: Function parameter or member 'symbol' not described in 'HUF_DEltX1_set4'
   lib/zstd/decompress/huf_decompress.c:122: warning: Function parameter or member 'nbBits' not described in 'HUF_DEltX1_set4'
>> lib/zstd/decompress/huf_decompress.c:122: warning: expecting prototype for This is used to lay down 4 entries at(). Prototype was for HUF_DEltX1_set4() instead
--
>> lib/zstd/compress/zstd_compress.c:128: warning: wrong kernel-doc identifier on line:
    * Clears and frees all of the dictionaries in the CCtx.
   lib/zstd/compress/zstd_compress.c:265: warning: wrong kernel-doc identifier on line:
    * Initializes the cctxParams from params and compressionLevel.
   lib/zstd/compress/zstd_compress.c:289: warning: wrong kernel-doc identifier on line:
    * Sets cctxParams' cParams and fParams from params, but otherwise leaves them alone.
   lib/zstd/compress/zstd_compress.c:910: warning: wrong kernel-doc identifier on line:
    * Initializes the local dict using the requested parameters.
   lib/zstd/compress/zstd_compress.c:1457: warning: wrong kernel-doc identifier on line:
    * Controls, for this matchState reset, whether the tables need to be cleared /
   lib/zstd/compress/zstd_compress.c:1473: warning: cannot understand function prototype: 'typedef enum '
   lib/zstd/compress/zstd_compress.c:5008: warning: Function parameter or member 'cParams' not described in 'ZSTD_dedicatedDictSearch_revertCParams'
>> lib/zstd/compress/zstd_compress.c:5008: warning: expecting prototype for Reverses the adjustment applied to cparams when enabling dedicated dict(). Prototype was for ZSTD_dedicatedDictSearch_revertCParams() instead


vim +58 lib/zstd/compress/zstd_compress_sequences.c

    52	
    53	/**
    54	 * Returns true if we should use ncount=-1 else we should
    55	 * use ncount=1 for low probability symbols instead.
    56	 */
    57	static unsigned ZSTD_useLowProbCount(size_t const nbSeq)
  > 58	{
    59	    /* Heuristic: This should cover most blocks <= 16K and
    60	     * start to fade out after 16K to about 32K depending on
    61	     * comprssibility.
    62	     */
    63	    return nbSeq >= 2048;
    64	}
    65	
    66	/**
  > 67	 * Returns the cost in bytes of encoding the normalized count header.
    68	 * Returns an error if any of the helper functions return an error.
    69	 */
    70	static size_t ZSTD_NCountCost(unsigned const* count, unsigned const max,
    71	                              size_t const nbSeq, unsigned const FSELog)
    72	{
    73	    BYTE wksp[FSE_NCOUNTBOUND];
    74	    S16 norm[MaxSeq + 1];
    75	    const U32 tableLog = FSE_optimalTableLog(FSELog, nbSeq, max);
    76	    FORWARD_IF_ERROR(FSE_normalizeCount(norm, tableLog, count, nbSeq, max, ZSTD_useLowProbCount(nbSeq)), "");
    77	    return FSE_writeNCount(wksp, sizeof(wksp), norm, max, tableLog);
    78	}
    79	
    80	/**
    81	 * Returns the cost in bits of encoding the distribution described by count
    82	 * using the entropy bound.
    83	 */
    84	static size_t ZSTD_entropyCost(unsigned const* count, unsigned const max, size_t const total)
  > 85	{
    86	    unsigned cost = 0;
    87	    unsigned s;
    88	    for (s = 0; s <= max; ++s) {
    89	        unsigned norm = (unsigned)((256 * count[s]) / total);
    90	        if (count[s] != 0 && norm == 0)
    91	            norm = 1;
    92	        assert(count[s] < total);
    93	        cost += count[s] * kInverseProbabilityLog256[norm];
    94	    }
    95	    return cost >> 8;
    96	}
    97	
    98	/**
    99	 * Returns the cost in bits of encoding the distribution in count using ctable.
   100	 * Returns an error if ctable cannot represent all the symbols in count.
   101	 */
   102	size_t ZSTD_fseBitCost(
   103	    FSE_CTable const* ctable,
   104	    unsigned const* count,
   105	    unsigned const max)
   106	{
   107	    unsigned const kAccuracyLog = 8;
   108	    size_t cost = 0;
   109	    unsigned s;
   110	    FSE_CState_t cstate;
   111	    FSE_initCState(&cstate, ctable);
   112	    if (ZSTD_getFSEMaxSymbolValue(ctable) < max) {
   113	        DEBUGLOG(5, "Repeat FSE_CTable has maxSymbolValue %u < %u",
   114	                    ZSTD_getFSEMaxSymbolValue(ctable), max);
   115	        return ERROR(GENERIC);
   116	    }
   117	    for (s = 0; s <= max; ++s) {
   118	        unsigned const tableLog = cstate.stateLog;
   119	        unsigned const badCost = (tableLog + 1) << kAccuracyLog;
   120	        unsigned const bitCost = FSE_bitCost(cstate.symbolTT, tableLog, s, kAccuracyLog);
   121	        if (count[s] == 0)
   122	            continue;
   123	        if (bitCost >= badCost) {
   124	            DEBUGLOG(5, "Repeat FSE_CTable has Prob[%u] == 0", s);
   125	            return ERROR(GENERIC);
   126	        }
   127	        cost += (size_t)count[s] * bitCost;
   128	    }
   129	    return cost >> kAccuracyLog;
   130	}
   131	
   132	/**
   133	 * Returns the cost in bits of encoding the distribution in count using the
   134	 * table described by norm. The max symbol support by norm is assumed >= max.
   135	 * norm must be valid for every symbol with non-zero probability in count.
   136	 */
   137	size_t ZSTD_crossEntropyCost(short const* norm, unsigned accuracyLog,
   138	                             unsigned const* count, unsigned const max)
 > 139	{
   140	    unsigned const shift = 8 - accuracyLog;
   141	    size_t cost = 0;
   142	    unsigned s;
   143	    assert(accuracyLog <= 8);
   144	    for (s = 0; s <= max; ++s) {
   145	        unsigned const normAcc = (norm[s] != -1) ? (unsigned)norm[s] : 1;
   146	        unsigned const norm256 = normAcc << shift;
   147	        assert(norm256 > 0);
   148	        assert(norm256 < 256);
   149	        cost += count[s] * kInverseProbabilityLog256[norm256];
   150	    }
   151	    return cost >> 8;
   152	}
   153	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--gBBFr7Ir9EOA20Yy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
f/e42StCdwEA

--gBBFr7Ir9EOA20Yy--
