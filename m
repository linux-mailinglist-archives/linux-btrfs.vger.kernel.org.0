Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0457627A49
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 11:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiKNKRB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 05:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiKNKQl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 05:16:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D83ED65
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 02:16:14 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtwUm-1pFdIS0Ddc-00uLEu; Mon, 14
 Nov 2022 11:16:00 +0100
Message-ID: <9af2fe36-038d-2bb8-7c93-2f6cc4880369@gmx.com>
Date:   Mon, 14 Nov 2022 18:15:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] btrfs: fix missing endianess conversion in
 sb_write_pointer
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, naohiro.aota@wdc.com
Cc:     linux-btrfs@vger.kernel.org
References: <20221114093531.1240849-1-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221114093531.1240849-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FpaJaVvOKqn78u8ulGxg0JXCHeTUJMRgk/dUoiYIh3tUPkBAyZT
 tg1L3/kGjcfYuBjnztGXNmXUIpJW/lU1ImpEQzcYP61CQRLmNg/MIgKE6ylXvFFb2PsH1B6
 8Uf+DweojXhWSqdvws+W8kGcqyhlGMW62RWgHiTAnZNg2UEd/dxxMck1Ma0rA4UwGrPdYO+
 TUR7PSbyKAB+2WIUYib1g==
UI-OutboundReport: notjunk:1;M01:P0:sZrKDR+CBhU=;w7vhuBWDvgiPtO+0HXzYpR3c9GC
 wo3fFZD+0sexOAH6qaw3WRKh6MiZHvmDcK2c20AYK6IgcdQdP8ZZto2VZ7KsF5uYbsw3HQfw0
 7/vgrfX3svEZklLSOLN7zJt5jMAR4VKQnm3yMDXjGd/GucafKDA3iCaHx6L+zvR6lgchdwGy/
 ClSk/AgpEAZ76/oIWgzbAd3mlYVfYKzNxLkqbl8MiFSMTJ0jzgbBGYkI50W5XeehtBSGRywpv
 5iMolw0p/OXk6KXd45+3iPq6YlnMKKt0mSvYbCoEkCwCfni3ynu24QoeHWdV6BU/zKHOM1P8i
 rLkf2vYKq644XOfiOlGKat+wonYEl17mQKWKZ85S2zcJcRWwJEx2eqCpKqPmjztTCwMRfoQIw
 35sLP+Clned/kdKGqXKJjbcfTJ2yzI/D5d81oLadrH3BrmTI0j3leANtJUq5WemJ8D90hl4KM
 IjFH4kbeOg2vYGcP3YRp5DwXb3vVFk2jf4lqxUC4O8/RYwV+4vLIpmMvvDBd9lO/ULbYDgHNH
 1lVA4XnZs9jP8pOfOsa/T/gud3XMfPz0sQ2l2KWXd/wx+7SYUe8ipbXWHVbQQ8JdEH1/xSMVr
 iMeystHAD8CAoh0JVTe2idWyU7+tAza0mcNRbqFXhf6ndU+3YPZmOPxkedOj/CCkSoT+cuR68
 kPpaCfPE7CXbd9glOVwtB7TmHa3sPVJDk/HqJquczvk28rdAdX4IAK7nubLc22rfuoPaCDmep
 typ+Pehh7Zlb7OTK9Gv241QyJ9cD0e0EivNCJZZKWycfpFOuKVEcp2d9oALvwgigzb2ZnliD4
 BpBQrfJQ/1OGw2I4vjKwJR1AJJRDFraiLyx2CFc9+2ojYVSA20aGVwoGsh7+e0uL5RYePvihy
 ujlqotaYVWjhKv3qd5SNNIpkTRtnxApfQCIZ945yGqMvSbUxSDzJEuOlR6JsemxD1xxl5txsy
 gfgjyfzsqhCY2xfjp35seViWEbw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/14 17:35, Christoph Hellwig wrote:
> generation is an on-disk __le64 value, so use le64_to_cpu to convert
> it to host endian before comparing it.
> 
> Fixes: 12659251ca5d ("btrfs: implement log-structured superblock for ZONED mode")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Shouldn't we use btrfs_super_generation() helper?
Just need a type conversion to btrfs_super_block pointer.

Thanks,
Qu
> ---
>   fs/btrfs/zoned.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 57aae7694f12c..a055b10c6c884 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -136,7 +136,8 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
>   			super[i] = page_address(page[i]);
>   		}
>   
> -		if (super[0]->generation > super[1]->generation)
> +		if (le64_to_cpu(super[0]->generation) >
> +		    le64_to_cpu(super[1]->generation))
>   			sector = zones[1].start;
>   		else
>   			sector = zones[0].start;
