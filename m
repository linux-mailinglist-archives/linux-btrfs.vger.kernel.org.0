Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F7D6C8CBC
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 09:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCYIm7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 04:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYIm5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 04:42:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99AB4EE1
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 01:42:55 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRTNF-1psPhf2rhd-00NS8G; Sat, 25
 Mar 2023 09:42:43 +0100
Message-ID: <80b42725-e3da-05a0-977c-db1f784ab041@gmx.com>
Date:   Sat, 25 Mar 2023 16:42:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@meta.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
References: <20230314165910.373347-4-hch@lst.de>
 <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com> <20230320123059.GB9008@lst.de>
 <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com>
 <20230321125550.GB10470@lst.de>
 <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com>
 <20230322083258.GA23315@lst.de>
 <ff18e85e-061d-084d-d835-aa7b23a54f1a@meta.com>
 <20230324010959.GB12152@lst.de>
 <14e253bb-8530-af11-7395-9e4148249c54@meta.com>
 <20230325081515.GC7353@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
In-Reply-To: <20230325081515.GC7353@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vF4F/2W0S24NYZY+AUJ/fi8YE2eXTSAQHzicTjoLfSwGNJZOxef
 T7gf56OrI9FJWSO7mWF68blxf9r+exRQ7cjppWLdes+OVSlwyWjiFVufwItQBWHaGYEJIkq
 JeUJI++VRmNIg6eNHmA0s/cEP7paowQq34fkAe+J6eZ+4vN1ZlCAOFtC9C4C+OZS/LoZEV1
 h3DTt1vEYyoMsNhsvYGPw==
UI-OutboundReport: notjunk:1;M01:P0:Vkwlnc+pp5U=;WQiPya/HRnDCG80i6i08vNlOvPS
 qPmPahLUhyHVax6Pprs075DLdvXyw3EWDSX77O2EPkSuHigLrVua7gSKKHgGbS2ShD3K82pRc
 svM13Nt8fc/6YBgk9qhCcnJgwvcbiu1IiMrbDEBz+Dsksc/XTE+/3L4D2RRl7QeUwSbanrjYc
 mnGiYEeP4cIEtKUS/xACiG6woxR7XkMD9gNQgbwVo3FvH4vSGmbIgv3YQ1IaAcwOV4yc+qg8R
 e7fd8JewLdVowTQmHeuE55sU6K4XxwhqEh6S/GOplGpeftaxoxCdUAbxqqazQvpO43gjz4JQ6
 bBoYdmm0TOiDXF5Bj5XAZtIpIjOWQ987ld7mxSfe2NV5yzPDkNBDEThf1zOCBnnTEG29zx+ZP
 lH+WzdJnS4792q/o6XUdExOlI80i2XGk/3Kk0+T1xVW0kL9l980VyfVDuzSDZEuiDR+wTQsFu
 T1KMTXFBsSkG8cGeKjHpXrkqdF/c+/RcgBAJMxt7o8aJKhqWlPlgBSr7hXCIIMo5VfTin1ulo
 LdEKPmDAKPWBLuFdQrqKLtQA2qHtvIOTxVnX/qJqbZcsp67TAo6qcPmTYxTtf0DVPplEAXmdX
 dKZPik5zgGKjgFrP+1DYU/VnbqNOBtfczvEIKVKt2k8yWTRn1u3ypNlStAW27KhntIAgmcJaz
 Xo5KG7mnN04atIxpISsOlu2xXgo7n9gMAgquj5YsijkZElFnz+2I2qsUtfX5cweZJDAaVizde
 UQjSu3pSE2Lk6YW0Us3XR+HOX/gjiMyjsPhN4jrhSyNMAgKlpT55Q7k7cQdpKhkRtu6q+FsMy
 BfSkL1Wl6X/Kby9X3rc0kkeYCOzi9Nu7LtkG0C4Y8vHTfQrBb/6mHaw0uUpyUgCAEjxtiV/pI
 IE/CP8C3w+F7NjVFz2abNj1Tq85G1TVeGyF2EwiFCHW/66mXQuJspRrifqh5tSSSrRwJjGIoW
 KyFQdcDg+k6YGzKesD+PBNGDvhQ=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/25 16:15, Christoph Hellwig wrote:
> On Fri, Mar 24, 2023 at 09:25:07AM -0400, Chris Mason wrote:
>> As you mentioned above, we're currently doing synchronous crcs for
>> metadata when BTRFS_FS_CSUM_IMPL_FAST, and for synchronous writes.
>> We've benchmarked this a few times and I think with modern hardware a
>> better default is just always doing synchronous crcs for data too.
>>
>> Qu or David have you looked synchronous data crcs recently?
> 
> As mentioend in the other mail I have a bit.  But only for crc32
> so far, and only on x86, so the matrix might be a little more
> complicated.

Haven't really looked up the async csum part at all.

In fact I'm not even sure what's the point of generating data checksum 
asynchronously...

I didn't see any extra split to get multiple threads to calculate hash 
on different parts.
Furthermore, I'm not sure even if all the supported hash algos 
(CRC32/SHA256/BLAKE2/XXHASH) can support such split and merge 
multi-threading.
(IIRC SHA256 can not?)

Thus I'm not really sure of the benefit of async csum generation anyway.
(Not to mention asynchronous code itself is not straightforward)

Considering at least we used to do data csum verification in endio 
function synchronously, I see no problem to do the generation path 
synchronously, even without hardware accelerated checksum support.

Thanks,
Qu

> 
>> My preference would be:
>>
>> - crcs are always inline if your hardware is fast
>> - Compression, encryption, slow hardware crcs use the thread_pool_size knob
>> - We don't try to limit the other workers
>>
>> The idea behind the knob is just "how much of your CPU should each btrfs
>> mount consume?"  Obviously we'll silently judge anyone that chooses less
>> than 100% but I guess it's good to give people options.
> 
> Ok.  I'll do a series about the nobs ASAP, and then the inline CRCs
> next.
