Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2854A56B09A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 04:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbiGHCWv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 22:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbiGHCWu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 22:22:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234887393A
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 19:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657246953;
        bh=O1XO4sBWcix25zpBd3NNhyHJZwt0kfwNRuG0mjfDEJ8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QkzqO03lHZNG9nPiHYx7Zc6oHmw7UmyjmkB+J7cda18v1aCvrgMRKIsB6SLw89O4j
         yBv4ddemWkoy+w7k+fB9OmvLwHJJ+thocg4cIzhC3dnpn2WoW4kN/Dtn+UDx+Ez/u3
         xOu88HoPvbAnP8lnYpIItQ7IQisRFX9P4exG4RpQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzfl-1o7G6L49lJ-00XH04; Fri, 08
 Jul 2022 04:22:33 +0200
Message-ID: <5d95e738-2e80-ee5f-58fd-1ebb45cd5ae2@gmx.com>
Date:   Fri, 8 Jul 2022 10:22:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 06/12] btrfs: write-intent: introduce an internal helper
 to set bits for a range.
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org
References: <1574950e8caee003d1682ca6a9c6c85142cef5bd.1657171615.git.wqu@suse.com>
 <202207080925.VUcOcv89-lkp@intel.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <202207080925.VUcOcv89-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QwJ0ceWMRDRUWYHtd0khGDuHHCDpkNPcIdcOV2CUV+akjthZTxN
 GX++yc1fd6dqV6PmsNNq1z9Q6ZjFGSOwMO84LhRmh6IBn0REAbp74PNE20lJxkbEC2aZC3L
 HFpLYZRzPfahl4WxR9gDrPnSLizxz3sdWQVnxamOa6/qFEm49HLP2zL5ZGh96ufEZp+4VhF
 ZYdtj8o5RSU5H4MVl68hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OcDr0aUMoyk=:Xkx/+4kNIcROBkIqfFYQJv
 0NwamN5Fv0S4hg2r5MwP8fHKljl3G3PADvkAy9yr8dpzXfGjMOirGeYu5Alsd1bMBijpjLolh
 9JdB+yf75VEFIVJh+RV0EiAU804bFoyntkZ0H5jqjmfW8H0bfkiD9AK/mTvvbIWSwYiAYeFp8
 ckT7Mhn0NRFGnxu4K60XToXUmo+brDv+qcTNQSNUpNY1rUSwH2TQAXHyy5fVwJJZENcT+K/xW
 jtAtjBenlvfYDTtqTJz8bNOw6LgnTL47KVd36cXrd/xtDo6UhHftWXc+3OW75lmysvw30beeP
 m56kaQBzwAYDd7CtObvBNoFwHwz5Wvu657SKwSOPNUXWTIYmMlgCoE+S+65ET7vK3ycH1gnOJ
 cpS7SUM/8/i2fiwsQrtrK4AnZvyRfRSSeol+xObAjuVL82QpRvOs5glzquYlmR3hF73yGlfps
 JQEOttvVS+4V4HALJffkWLQYEOv3nJz11+eh7R0EGY8n2/u9yki1WNsmX9hsxbijuXeIWlDzk
 lq8S+wew0qzC5jHqk0kUl+sqGTUdQ2nQxTpDC5LcpDfETFdFVCiMFK+xmBXtDXr2fe2mFWwFM
 nByRYbSi4lZ3BThZevkGVdnFlfj+7lPJm1fyhuvS6d+23KS62WCjbAp48NgPqN/K8anzyW/rI
 ufWWQaERSg/n2zxJZXh3oqHNSYimCTSL+t9dncGf74/DMxf1MhiNexfWDH6ZCQKLiYNl2++ar
 bb6Hj/6alR/0qEEAVlx2DNDRXx3CCmfg4n/TyWNd7haR6nz3ZYlfnrlZY4cjXjH7Z+a6jpCQ9
 SQtbm3JhS8+HWFPHrGzpgNEAm4WuMPNF4gQI3v6BPZ6pVUJp5Q6h2Hu24llND8ATA1aCWxWNi
 eebX+qA72lANecQtyD5LQLLl5OZrKRro2D6lDlGrYjUZfVpfjfrzsNyr57yjttmEFZpBca3IO
 r30PnS0RBajIEnu9fGTy1iKQmNMq+fWzKgDPrK0lHIFQg2z8qGNOsRET0Zmpb2TlKqDyf0r0A
 feQrIwpk8J7cq47mu07vY0ZjZRd9XGokNik9d8hOyrsQ+U5CuBZilfz01zzTDWz3ySTkf3qyN
 cvzOC+K8/qpoOlai/bCp/6GM5oOYTUfD785ZUMTeFFxhkqZ+7Lt/OE1qQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/8 09:55, kernel test robot wrote:
> Hi Qu,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on kdave/for-next]
> [also build test ERROR on next-20220707]
> [cannot apply to linus/master v5.19-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-i=
ntroduce-write-intent-bitmaps-for-RAID56/20220707-133435
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git =
for-next
> config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220=
708/202207080925.VUcOcv89-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=3D1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/2b051857a66f031=
0589455c06f962908016b5f9b
>          git remote add linux-review https://github.com/intel-lab-lkp/li=
nux
>          git fetch --no-tags linux-review Qu-Wenruo/btrfs-introduce-writ=
e-intent-bitmaps-for-RAID56/20220707-133435
>          git checkout 2b051857a66f0310589455c06f962908016b5f9b
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.3.0 make.c=
ross W=3D1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     arch/mips/kernel/head.o: in function `kernel_entry':
>     (.ref.text+0xac): relocation truncated to fit: R_MIPS_26 against `st=
art_kernel'
>     init/main.o: in function `set_reset_devices':
>     main.c:(.init.text+0x20): relocation truncated to fit: R_MIPS_26 aga=
inst `_mcount'
>     main.c:(.init.text+0x30): relocation truncated to fit: R_MIPS_26 aga=
inst `__sanitizer_cov_trace_pc'
>     init/main.o: in function `debug_kernel':
>     main.c:(.init.text+0xa4): relocation truncated to fit: R_MIPS_26 aga=
inst `_mcount'
>     main.c:(.init.text+0xb4): relocation truncated to fit: R_MIPS_26 aga=
inst `__sanitizer_cov_trace_pc'
>     init/main.o: in function `quiet_kernel':
>     main.c:(.init.text+0x128): relocation truncated to fit: R_MIPS_26 ag=
ainst `_mcount'
>     main.c:(.init.text+0x138): relocation truncated to fit: R_MIPS_26 ag=
ainst `__sanitizer_cov_trace_pc'
>     init/main.o: in function `warn_bootconfig':
>     main.c:(.init.text+0x1ac): relocation truncated to fit: R_MIPS_26 ag=
ainst `_mcount'
>     main.c:(.init.text+0x1bc): relocation truncated to fit: R_MIPS_26 ag=
ainst `__sanitizer_cov_trace_pc'
>     init/main.o: in function `init_setup':
>     main.c:(.init.text+0x238): relocation truncated to fit: R_MIPS_26 ag=
ainst `_mcount'
>     main.c:(.init.text+0x258): additional relocation overflows omitted f=
rom the output
>     mips-linux-ld: fs/btrfs/write-intent.o: in function `set_bits_in_one=
_entry':
>>> write-intent.c:(.text.set_bits_in_one_entry+0x1ec): undefined referenc=
e to `__udivdi3'
>>> mips-linux-ld: write-intent.c:(.text.set_bits_in_one_entry+0x2b0): und=
efined reference to `__udivdi3'
>     mips-linux-ld: fs/btrfs/write-intent.o: in function `insert_new_entr=
ies':

Thanks for the report, it looks like there are still u64/u32 cases used
in bitmap_clear()/bitmap_set().

In fact, that two locations can go with u32 for the dividend.

Anyway, I'd go the regular blocksize_bits way instead in the next update.

THanks,
Qu

>>> write-intent.c:(.text.insert_new_entries+0x294): undefined reference t=
o `__udivdi3'
>
