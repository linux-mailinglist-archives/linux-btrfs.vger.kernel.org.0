Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645756B38A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 09:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjCJIaZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 03:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCJIaZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 03:30:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBF9A54D8
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 00:30:12 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4Qwg-1qaSOg2vbS-011PQJ; Fri, 10
 Mar 2023 09:30:05 +0100
Message-ID: <4ebfe217-ae51-8c66-ed19-8a0d6146d1a2@gmx.com>
Date:   Fri, 10 Mar 2023 16:30:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 07/20] btrfs: simplify the read_extent_buffer end_io
 handler
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-8-hch@lst.de>
 <dcc3f350-bfee-4813-ff9c-65c835c7af57@gmx.com>
 <20230310081715.GB15515@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230310081715.GB15515@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kg98/A3uYaR8vyAKysfcorsVGwVxm5w8hzppz3bydO8+CHhh4zF
 vd/S41j5v3LdftCNY2i739aQIpMm3KTEroncD3M4rjr1qGhbNuvaEPQsqS5f+Py7WL+Q7lf
 5JdihuxyUjZu/zqSrRbd2fPqV/C1tmLnCkHceYHAXx/E818qEqEGqoGK7DE+YhgvRyg3Sba
 ZLgIaZnKoFAf12cCLKnkA==
UI-OutboundReport: notjunk:1;M01:P0:VzktNMW/S7Y=;1cv8ZS9FbzhOWbmWh/AhIt325yN
 ykZn+/LGZiCZkw/jw9+L7URWmJy6oFFmkJZrcSLB6nXUIgBNZdTiIrmqNK4osvAGe89n+Haw5
 mWdMCmmpU6/X4kIE77P+wHxpRweuV8T9qv9g6xpPLSj5TEAxVSaFuTp6bB3R2yepmrPm9cYX4
 6oP/IbH31RoghwpB/zu82YaiQBx40BmyVvHoP/Y4CB6M6qOz1RszpyRDgMyIzzxZSZrSW75r6
 ZT+KoqLf00SiGortGVgQIHxEAYhad4oj5eiRk5nXwCTNlIOvvtP/d03SgQiNLbILBLnEwrKCJ
 RXLVS2LaPfszKKPZlAzGR4Hwo4VKTH5Inokbs33Wb0Emi0Epu2hdvrIsUWpm2bJW+rur0v6Ta
 ZJofvcXKJvJ/Hj3IVffN8wMmVFoT2xPPu9M355NSlb18LgOQkB0zzs2BetI5B5nJDcrzDC7Oa
 nfgUHsk6b3soCLzd4Y7kiHIYWDS0ieevZRGTfFJQ28qENpLJmUne6Jh8Iit/SV4yuRXmFXOrp
 E6jArDSMjImvx4A/W2ijgwQkuF8qZq4q1pEUNY4fBWJfPVS4LPdcKvh6tnk1A00ywv9VFjVOK
 9hu7hf/I0983nFfyPLAqUQ2b2m2PVKpZ4epmjOo3Kjxv/d0yKMbsi6gwt66dArhc3xBwB2Gig
 9MnK+4K4kNjPGtOYHVH3rukx4qUIyzcizxeRaOq+m1Jni7xHJYGD08PGBAskIYFrO9Uf1ADB5
 D9kJ8qWW4Rwt+xjAKri2ej+SSUazAfUFgOOgvTx95ml49OYK1OtTSdKc3P+oHz4Z71ohQBlQU
 q+dt6udEgi0PKeumA4SyApsCbxAcmJ47KE4K1cbUJ89nLnaqTCHcBZwd1NZoVCggPZk+evgQs
 r/rYN5Sb3CdlLB5yNbVwh3SEgNs527qIuzJIDGXa6+T4m5Vi7AXzgOqdNq9Ao6ILIg/UTvFyr
 4F7jC/2tQ1f3J2GJ/OSfo/g+K8w=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/10 16:17, Christoph Hellwig wrote:
> On Fri, Mar 10, 2023 at 04:14:46PM +0800, Qu Wenruo wrote:
>> Here we call btrfs_validate_extent_buffer() directly.
>>
>> But in the case that a metadata bio is split, the endio function would be
>> called on each split part.
> 
> No.  bbio->end_io is called on the originally submitted bbio after all
> I/O has finished, and is not called multiple times when split.  Without
> that all consumers of btrfs_submit_bio would have to know about splitting
> and need to be able to deal with cloned bios, which is exactly what I
> spent great effort on to avoid (similar to how the block layer works).

Oh, you avoided the endio call for each splited bio but still handle 
interleaved RAID0 corruption cases by going btrfs_check_read_bio(), and 
directly submit repair for the failed sectors.


Then the code is fine, and makes the life of endio much easier.

Reviewed-by: Qu Wenruo <wqu@suse.com>

And finally I'm understanding why you move the data read repair part to 
bio layer.

Thanks,
Qu
