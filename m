Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5667E6D1454
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 02:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCaAsy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 20:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCaAsu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 20:48:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5CF113D3
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 17:48:48 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDXp-1qaPRx3DmH-00uZyK; Fri, 31
 Mar 2023 02:48:37 +0200
Message-ID: <e7fe346d-ccce-8172-f389-8377144b4c23@gmx.com>
Date:   Fri, 31 Mar 2023 08:48:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <cover.1680047473.git.wqu@suse.com>
 <72f4fa26c35f2e649bc562a80a40955d745f1118.1680047473.git.wqu@suse.com>
 <ZCTK34vrpfGiCu1B@infradead.org>
 <b38a9aa2-9869-2f95-59a0-d2fe20f4e1d6@gmx.com>
 <ZCYJn6ygcvtX+ZEh@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v7 04/13] btrfs: introduce a new helper to submit write
 bio for scrub
In-Reply-To: <ZCYJn6ygcvtX+ZEh@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Tq6Fo3RI+KdBHEIdV4SHOh3Xmq/0Z1Yu2BckZ1/DusXf7uARNO0
 s3sYjCvpt6GWYCRNiRNCzi7P+Cx+q0TvqnUnPazDSkNH4YQUINdopJyzE8xdUgrGOvukYoM
 KupW/z727SSBxygT/DII2qXGJCRxT1eI+Pn8u2KQ+bDaUU5uMNdJhzYWJnaTocfFiVEZjCg
 6z3LzDNCZFi7yyS2/uYRQ==
UI-OutboundReport: notjunk:1;M01:P0:mNMFX9MFJow=;I/D3G07v3BcakWdG72/gxReFHAU
 jmolKW9a326ZdyK+cFcA4BI5JvzZ0RjASfvHFeEW/40kaiJ0V3o7Ps9APq1BKrxsQq6UIZH0Q
 femXFOm+czeCWzbicrQSIevH8jm278hI4OcaGBW05/Uvi4ruxS0q0gx/GFc0MQbASnvOmHAko
 At1d1kGk1lIETZRrJUlP8cMi0TXbMeZUWUepOEaBmFVxS5ARfF/cfi4ZGz09QvxfIAuzqYV/L
 cLzLi9yiRLrfczSH7aizH19fsgfOm3u51nvIXJnYCL0W1UQDVq3AjxVajftBGjQrCHy5S7jNo
 Ar2F8Tjpu+kUh30wNxm55nnJxy67gONXWjWqFYW7Ntujo47rjirMfpfHpFsR7y16tKFv1zGeR
 mZpPhorHm0KRAzscg3Mr4S1FklLmQcVO6o1J+RhXqXW62yh8+XcrXfPDwZ0gQQ/FKNk9sEdqC
 UwIyhCjUzx+m4vkI4pagd4lp1ZjtsHZOGHNvIhXcT0WxTtUsNsuEeLuqiiUmGv3r0Q+Z9M7/a
 hP+fyLtLc1GjyylQR4Rs7HoF2k+mD1UFuacXR7BA8xeE2oD3l8tmsC7RDzJ75CyFnkHAg1c4v
 DGo5uLCJ5785goUMLx6i+3W67Bj+WwZeUiUeuDpVksPy6/NKavOwNPiU2ZIQNGGtIXzVoxT22
 hfbzfXGA2Ud3TdawypBRx43dQjsGk67slCN2yDRX2gYTHh2iIM1C7pvkS6G8SHN6U2z50N2Tw
 UfwtNrTpEjsvP6EoOfaHUMBh5AVX/I4TzoW3BqSBmqoyZRW3/CInxdnmSJvy7zc6ogE6YjiuP
 qOjAH++o6tRikkWaDdgh2u4joC/x7QLdbFvF26m8y/Yd4Mb39g+W7VhnyVh+e6l7eUWhm0hWJ
 djIssVMbK0qM5ZUGLLWadYaHKvkeLZdKoUaKJYDfb10Z5nlcCs4xg0zYWPLjhQW6sw2h09ez1
 47o7ultNBa6z97cf2TSfVAp8Aio=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/31 06:13, Christoph Hellwig wrote:
> On Thu, Mar 30, 2023 at 02:47:08PM +0800, Qu Wenruo wrote:
>> Due to the interface differences (read-repair goes plain bio and
>> submit_bio_wait(), while scrub goes btrfs_bio), I can't find a perfect
>> single interface for both usage.
> 
>> Thus I go a common helper, map_repair_smap(), to grab the device with its
>> physical, and use it to implement the old btrfs_repair_io_failure() and the
>> new btrfs_submit_repair_write() interface.
> 
> I think this map helper approach looks very nice.
> 
> A bunch of comments, though:
> 
>   - map_repair_smap doesn't deal with bios at all, so I think it should
>     go into volumes.c instead and be renamed to something like
>     btrfs_map_repair_block
>   - it really needs a better comment describing what is can be used
>     for for and what the assumptions are
>   - The smap.dev ASSERT in both callers of map_repair_smap is odd,
>     I'd expect a valid dev to just be part of the contract fo that
>     helper.
>   - shouldn't the ASSERT check that map_length is >= length, as a shorter
>     map is the real problem here?  A larger one doesn't seem problematic.
>     Instead of just an assert I'd probably do an actual error check with
>     a WARN_ON_ONCE.

Larger mapped length is problematic (but not crash level) for the 
following reasons:

- We can only map the first part
   Since we only have @smap.
   Thus the remaining part won't be repaired.

   If caller is aware of this, and handle the remaining part, it would be
   completely fine, but that's not the case.

- The only two callers are all handling the stripe boundary correctly
   Read-repair only submit sector sized write, while new scrub is fully
   stripe based.

   If we hit a stripe larger than what we expect, it must be some wrong
   in the callers.

But overall, this case should not happen, and even if it happens it 
should happen in a dev environment first.

Thus I just put an ASSERT() there, not to bother the end users but us 
developers.

>   - I'd factor the raid56 branch into a separate helper
>   - the non-raid56 case should probably call set_io_stripe, to make
>     Johannes' life with the raid stripe tree easier
> 
>   - all new code in bio.c should stay below btrfs_submit_bio to keep
>     the main I/O path together
>   - typo: "No csum geneartion" should be: "No csum generation"
>   - why can btrfs_submit_repair_write skip the
>     BTRFS_DEV_STATE_WRITEABLE check from btrfs_repair_io_failure?
>     Shouldn't that and the ->bdev check be lifted into map_repair_smap?

The missing device check is skipped because btrfs_submit_dev_bio() would 
handle it, thus we can avoid duplicated checks.

While btrfs_repair_io_failure() doesn't use bbio, it has to do the 
checks all by itself.

Other commends would be reflected in the next update.

Thanks,
Qu

> 
>>
>> The whole series has been tested without problem for non-zoned device.
>>
>> Thanks,
>> Qu
> ---end quoted text---
