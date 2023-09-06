Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6210F7933E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 04:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbjIFCv4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 22:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjIFCv4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 22:51:56 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99711E42;
        Tue,  5 Sep 2023 19:51:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VrRzBg5_1693968670;
Received: from 30.97.49.39(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrRzBg5_1693968670)
          by smtp.aliyun-inc.com;
          Wed, 06 Sep 2023 10:51:12 +0800
Message-ID: <bc05ff13-97a0-f101-6aad-d9d217648e20@linux.alibaba.com>
Date:   Wed, 6 Sep 2023 10:51:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] crypto: qat - Remove zlib-deflate
To:     dsterba@suse.cz, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Yang Shen <shenyang39@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ardb@kernel.org, kees@kernel.org, linux-kernel@vger.kernel.org,
        enlin.mu@unisoc.com, ebiggers@google.com, gpiccoli@igalia.com,
        willy@infradead.org, yunlong.xing@unisoc.com,
        yuxiaozhang@google.com, qat-linux@intel.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Weigang Li <weigang.li@intel.com>, Chris Mason <clm@meta.com>,
        Brian Will <brian.will@intel.com>, linux-btrfs@vger.kernel.org
References: <ZO8ULhlJSrJ0Mcsx@gondor.apana.org.au>
 <E1qbI7x-009Bvo-IM@formenos.hmeau.com>
 <ZPcqALQ0Ck/3lF0U@gcabiddu-mobl1.ger.corp.intel.com>
 <20230905162302.GD14420@twin.jikos.cz>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230905162302.GD14420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/6 00:23, David Sterba wrote:
> On Tue, Sep 05, 2023 at 02:15:44PM +0100, Giovanni Cabiddu wrote:
>> Hi Herbert,
>>
>> On Wed, Aug 30, 2023 at 06:08:47PM +0800, Herbert Xu wrote:
>>> Remove the implementation of zlib-deflate because it is completely
>>> unused in the kernel.
>> We are working at a new revision of [1] which enables BTRFS to use acomp
>> for offloading zlib-deflate. We see that there is value in using QAT for
>> such use case in terms of throughput / CPU utilization / compression ratio
>> compared to software.
>> Zlib-deflate is preferred to deflate since BTRFS already uses that
>> format.
>>
>> We expect to send this patch for 6.7.
>> Can we keep zlib-deflate in the kernel?
>>
>> Thanks,
>>
>> [1] https://patchwork.kernel.org/project/linux-btrfs/patch/1467083180-111750-1-git-send-email-weigang.li@intel.com/
> 
> The patch is from 2016 and zlib though still supported has been
> superseded by zstd that is from 2017. It would be good to see numbers
> comparing zlib (cpu), zlib (qat) against relevant zstd levels. The
> offloading might be an improvement and worth adding the support
> otherwise I don't see much reason to add it unless there are users.
> 
> I can see there's QAT support for zstd too,
> https://github.com/intel/QAT-ZSTD-Plugin, can't find one for lzo but in
> case ther's QAT for all 3 algorithms used by btrfs I wouldn't mind
> keeping the QAT support for zlib for parity.

Just my personal side note: from my own point of view, QAT actually only
has DEFLATE and LZ4 format hardware end-to-end (de)compression support [1]
(IAA actually has DEFLATE-family format only [2]).

They partially support compressing Zstd format with their internal
hardware lz4s + postprocessing pipeline (mostly a LZ77 matchfinder) by
using hardware (with hw_buffer_sz less than 128KiB. [3][4]) and Zstd
hardware decompression is currently not supported since there is no
such hardware format support.

I'm not saying new Zstd algorithm is not amazing.  Yet from the hardware
perspective, I guess that due to gzip, the original zip, png, pdf, docx,
https, even pppoe all based on DEFLATE (you could see a lot other OSes
support DEFLATE-family format), so it's reasonble to resolve such
de-facto standard with limited hardware first to boost up data center
use cases.  If they have abundant hardware chip room, I guess they will
consider Zstd as well.

As for zlib container format, I don't see zlib Adler-32 checksum is
useful since almost all hardware accelerator supports raw DEFLATE but
Adler-32 checksum is uncommon.  If we consider better integrating
support, we should consider a more common hash (instead Adler-32
checksum) of or by using merkle tree to build the trust chain.

Actually we're working on EROFS raw deflate to enable IAA accelerator
support so we also hope IAA patchset could be landed upstream [5] so
I could upstream my work then.  Therefore, I hope "hisilicon ZIP
driver" could support raw deflate too (after a quick search, their
decompression spend is 1530 MB/s compared with the original zlib
219 MB/s on their platform [6])

[1] https://github.com/intel/QATzip
[2] https://cdrdv2.intel.com/v1/dl/getContent/721858
[3] https://github.com/facebook/zstd/issues/455#issuecomment-1397204587
[4] https://github.com/intel/QATzip/blob/master/utils/qzstd.c#L211
[5] https://lore.kernel.org/r/20230807203726.1682123-1-tom.zanussi@linux.intel.com
[6] https://compare-intel-kunpeng.readthedocs.io/zh_CN/latest/accelerator.html

Thanks,
Gao Xiang
