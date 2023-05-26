Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072A77120E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 09:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbjEZHZn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 03:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbjEZHZm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 03:25:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C3B9B
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 00:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685085931; i=quwenruo.btrfs@gmx.com;
        bh=/s7iv1OxEwFSfUrEsFkjwEh2d2McDSad2wLydmu0n+0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DpLW8VrN0GU1WLqcND/EGWKU9T/wjuK0pJPv202mNUnEs27ozOVm0oqwLi9Pt3uUk
         lShUCLPIfcFm7r924fdbQ+8b3BZW8xc0xe4SORljPbj35SVJyp/HjEvrtQMjJUa0fe
         C2UmZJFSk5owTvBCmmSMSzfiawfr7wuhXFNjKvwV2DUwQqiuE8R3PPP8akjdqnfJWh
         xhu1RalzIl6Ymito4YyIPF6ZBatDkL89Ra69pka7ADTdketwAmJxXOZQUAtWRPp+KI
         z92ZnqrIn0IUvfAcyxeAbxUZMB5vlGzCPmqcU4TCceGDOb1rJbhJ6VrdfyAFXdJFXL
         23nrk2gsI+oJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f5T-1q6Yh33AOl-0049sh; Fri, 26
 May 2023 09:25:31 +0200
Message-ID: <82f06b33-c440-b3d8-13bc-53001b14a898@gmx.com>
Date:   Fri, 26 May 2023 15:25:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 15/21] btrfs: remove the extent_buffer lookup in btree
 block checksumming
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
References: <20230503152441.1141019-1-hch@lst.de>
 <20230503152441.1141019-16-hch@lst.de>
 <1442e52f-9ba1-d9fa-f439-34d31b46800f@gmx.com>
 <20230526064123.GA10378@lst.de>
 <e288cd7d-2f49-f517-a406-b511cae36cb7@gmx.com>
 <20230526070316.GA11445@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230526070316.GA11445@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VFVCwbt4f/HuhQYbfnUPZUTgiLGmIk0FRxge5EVJiUnMslEFgfT
 Rry7siDMaPcvfCcaiTg/ENQgm5VHZFcNLBY9XSKsIeywXXA0kasN3PruiVSKMDbuDpCUEDk
 qQfXuqzneBsp04Ps5pXWdCsUAI/QdHrgVJ+pBLrmRtdTgpL/TUZ/ZTXlqiUbXvqiggsNyDH
 aLt/W7b6yhW/wdU6DEEKg==
UI-OutboundReport: notjunk:1;M01:P0:J2eX5gJkVP0=;Cgkbyo7TFQcaIz1zWA2ZF1hrHQE
 fO2tB0r4gjTZIZLqW3aG0lxb5rEu3uZS8rJE78TlqKr3InciOYujw/ZgVGmXTiGTT8FyzRyxO
 EPuE98wp4dIhbrWojLBXfGHTN36C+o0qNNm66/AFGdUI8kfVi0Yq8gfif++eh0RHnuEPUNltj
 mIZaVd8ocYXGll5e1jpJIa6NLtV5kfuhPim3k5NbIbAFxB1uh+Qxgv413BsCb28AK/yjhUYSL
 Y/L0FWxxAXyCbZtSDC/YsnF7xdALYGTxT+BTdAXXVvMUNwA8543+x8heaAGNmz+JdPiyRY2xp
 szVawnBp2znxfCu6YF+yJrwWYX37sl0vWfL5m/E5JyVMn4wZeerY2pL0Vuky1g74Yew39Sbu6
 NKbs2YLzxyzgZweti89tDhlX59nXwGpq/tcs6xdMTN4CXXbY/lydYFx3ZWKTf5cqONyshtYJF
 iO89UH5tDmcALYokv8GFOywqjlwLdd8ai9eo0b7f2dnlqjDCfkGagHenZtTy7qA9EWIkR7n0R
 16w4vLqPgCoaUyOfWQFlWBirAF8iNmEuWDj6NvISLf6/dfecL3LFQ7i/p6Wjp+qZdYelZjM9U
 Z759jSHs8tnXbhvergY2umfa9/pqrOQ6rD/8eF20o3ze2qZVUmAhJ/t1Z9/25pw7aBs/wPYkY
 ECs7x3iS6NGOObH2Lu8GaLrAweiSoaxmNOHPgrBBjytHO/+0MPT89LTcdToGA/6VF1DgOsN+d
 rNqvaZniFJmN4YVgA59B8dii7XginZXL5SBpIzXb3zGX73juEEFwiY1DjH1zuqhvhqsw/hzKT
 ERttbvdv/Bqa/Fp1xBrU0K0/Rh640LX32On35zX2sceua+EzkoVnZgqLlwlp9eyHVH/owBWPg
 HE7XRw2wsf4k494gvp2vFeADBVXm7kyem3PEce2qC17ljAr8rVlWwGG3qxwFArYRinB1yvW5o
 WsTnr4jWqF9jbGx6lm0M3EF+S00=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/26 15:03, Christoph Hellwig wrote:
> On Fri, May 26, 2023 at 02:43:11PM +0800, Qu Wenruo wrote:
>>>> Thus for any subpage mount, this would lead to transaction abort duri=
ng
>>>> metadata writeback.
>>>>
>>>> We have btrfs_page_clamp_test_uptodate() for this usage.
>>>
>>> True, this should use the sub page helper.  Or maybe just drop
>>> this assert altogether?
>>
>> It may be better to keep it, as there is also another case related to
>> subpage fs got its PageUptodate and bitmaps de-synced.
>>
>> Thus the assert can have a chance to catch such problem.
>
> Ok.  I don't really think we need the clamp version here, though.
> Does this work for you?

Yep, it works.

And you're right, no need for clamp. For subpage the range would be
inside the page anyway, and for regular cases, it's just PageUptodate().

Thanks,
Qu
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c461a46ac6f207..36d6b8d4b2c1fa 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -269,7 +269,8 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bb=
io)
>
>   	if (WARN_ON_ONCE(found_start !=3D eb->start))
>   		return BLK_STS_IOERR;
> -	if (WARN_ON_ONCE(!PageUptodate(eb->pages[0])))
> +	if (WARN_ON(!btrfs_page_test_uptodate(fs_info, eb->pages[0],
> +					      eb->start, eb->len)))
>   		return BLK_STS_IOERR;
>
>   	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
