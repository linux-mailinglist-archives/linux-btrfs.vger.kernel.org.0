Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5859D674F8B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 09:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjATIgl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 03:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATIgi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 03:36:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4BF3A861
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 00:36:37 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTAFb-1p8ahQ3ITv-00UZIK; Fri, 20
 Jan 2023 09:36:28 +0100
Message-ID: <a1f0cca0-b7f5-74dc-d7e1-c066ff387703@gmx.com>
Date:   Fri, 20 Jan 2023 16:36:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] btrfs: the raid56 code does not need irqsafe locking
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20230120074657.1095829-1-hch@lst.de>
 <b6561756-40f9-67a3-49e6-d11cf5605fe5@gmx.com>
 <20230120081342.GA27851@lst.de> <20230120081509.GA27910@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230120081509.GA27910@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:u5B4i6kk0yRTihIaLso/JxboJxCW7Wx7v6qkMWirdTd9AsctID6
 6feEj2HES9yhLr4ut1i7CqVg4mO2P/L2zLjCQQJoLX60ZCNVk648BUWOcJe2qM1ewFgyNXY
 z5f76OzIvZVDAl18IcyL/eKVG1fDrq67vz59+1w2mM+ckj240reXtcBgC2VY48rPTU9O9vj
 /VlFsWMCdr6HymPOfO4Bw==
UI-OutboundReport: notjunk:1;M01:P0:zPiMSwHFe8g=;VWGiQymBAogCZ7UNGYUJFS8rFZG
 xg6qbZcc+zQ6UyWP0XPatljFADZUlWPwHpxVvKiCzap9ID5BQOrUBv9nHjzOepzXa4hwq0iXF
 K9tssGd587fd0dEeY46HDgrbaJIPRsG95YQm/+agKT4YOxQsYfI2q4ujgMqgkPReTR4App2H2
 dTvqfKslfXm7C+8Vx+rdLy+/bX2xGLDf9l/rnMSZLpFYYJM/dCG156xgi1fkeuq7qW2HQEZ5z
 knmcMV0O+wSYwVNDH98Wc9QHuSQM2VLhVcXy5kD02zCExZJmzL7U3w5QQ92K7NbnmE+fKmMJs
 +LZOQxRRXGdsqTe5EcUuYtxvhrcqTCSrDgSQ07HtKNVKzpQFDEgO8C7XcWpY0YXgXtDVf02TU
 P6JOjbycj3ZhrdcQSihzei5/GQlV1FXT7jA6jesVgWxQ4K+nalqA/op5O3xuOhb49ZANHoJC7
 dw0aWH7Iifyp+Y/6W4uRkhnMONIkaswjtB8oXrr+fv30ZD0vUL6zT+H/LxNVOG5hlcetSo1KG
 dfY4gscbSYcNznYu3DsQtRyjFLxESZYLts0HnW2OWdETdXPMwft35mpnU4FcZ5LjYsH+rKxBr
 IhMfJ4/UwIRComfrYhZqu9mtEurk+5LNePQ6LEJkpc9GNlpKiemQFCqBRzMje+sJe87nBzcXI
 E+itvXYn6yVV/dnpzTMdshMEG3ZJSWE6iGHlnsaoCIAWzJa49N7s9MsKED17RI/YYfdr+A3jH
 hI1V0yAaihoWReJTjbH4eDqmZYbL24qdDwWM+OId8OSW+pZF3T+l5E9uDKKhjYWNV9E+M36Pe
 u7aX40eCtsPEj615sNywInIw+NmCzdQcpE/Loeeuf50bfObdvaETjfdhJiOJZ/mqEre6GClgN
 yhTsImv40FS/b0Ca+IWsZRhZZyJY6LxNk0RnIt4VY9lkz0bBT9ABCF8Zy7sm4zeI0KdGvCibG
 pSGP0/n23FAsWqGizDSqqO7c4RI=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/20 16:15, Christoph Hellwig wrote:
> On Fri, Jan 20, 2023 at 09:13:42AM +0100, Christoph Hellwig wrote:
>> On Fri, Jan 20, 2023 at 04:05:07PM +0800, Qu Wenruo wrote:
>>> And thanks to the patch, I exposed that for read/write endio, we lacks
>>> spinlocks for bitmap operations.
>>>
>>> As we still have chances to have multiple bios for the same stripe, and
>>> bitmap operations themselves are not atomic.
>>
>> So, bitmap_set is indeed not atomic.  But if you switch to the
>> set_bit that should be enough here.
> 
> ... but might actually be less efficient than the bitmap.

Yep, thus a small spin_lock_irqsave() in rbio_update_error_bitmap() 
would be more appropriate.

Thanks,
Qu
