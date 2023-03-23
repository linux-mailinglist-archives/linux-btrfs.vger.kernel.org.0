Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28CE6C6231
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 09:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjCWIsV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 04:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjCWIsS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 04:48:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AAC1026A
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 01:48:15 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQ5vc-1psW9E00Dg-00M1WG; Thu, 23
 Mar 2023 09:48:12 +0100
Message-ID: <04f6de95-1c1c-4b05-812b-ee4448d789cd@gmx.com>
Date:   Thu, 23 Mar 2023 16:48:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 03/12] btrfs: introduce a new helper to submit write
 bio for scrub
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1679278088.git.wqu@suse.com>
 <c9482839875af328d7fe5ff6a9bebdc84c33c5ab.1679278088.git.wqu@suse.com>
 <20230321001445.GJ10580@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230321001445.GJ10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eDUGoUCeidhSSpDtyyF8hm9tiHjmWaZGOTpipDJdoeW2i2VHmKH
 klyiw1QVsa8FfuhuzIoiZ6t4I4Fv7y9AFUqNaZ1vNsb7hDwfVMN33+Bj+Rz2yjImCaHwsa+
 vW5BX2jEf81iLX8qZAjgDceCl4EzVIFKVL63BEqjf+eO1FYjO7GQDtySZuqbO4yylrnY4I9
 NyiV+I9MgBrvEFxdPa4cw==
UI-OutboundReport: notjunk:1;M01:P0:L7kDuD7Iu+g=;kJoRGdY9BqE5cajEuysQfbq2odc
 QztGnSgg5on3iQEkKGNxkpVhB4g41cdaLp01RVFmYIehsxOP8oxUHSbKIa0dgzDHWiKlS2Bpx
 HS6FcU45uke3BkXx6YUHqONpIgmzZK2ik8cEyk/ZdeSVhJ0o/3fglPWtIYcvG2o20m5sGC0DD
 AteD3MFRuxZG8vkJHO0bQ0NVRyKy/jdVFR7RFo63XyRJuZHFANHijFTHBlixfgLRPpgyYKCVG
 lV/grCsXstiAMG4ZsPruHtc/rC75zECzcLFm2dsKIohVeFXj5KAM4lBDHjAV3MR042cJBLIbF
 cKvknT96iZJx8o5xOFPxXFlrS4vW9cprxFS1qQvlTz6I6IGa6lNp1cq1CvMFz9k7zd8mrtL5h
 9xkntORBKsx0iPRRLvAHYeMUbITETOMtyQQmY6juJlShntlNvS6rVkDiK9g3fmkZ+Ce9LJdOr
 nOyrhJOj40DzQbc5rOld/nIr4onQkk6XawuwmDSzJTknO/35yP1X7l+i/KoyYGaEiyR/LpHDQ
 UN7Q/ePTlApQ/WAUGebJ3Ld3FqbYos9k60+EtZAlYFoYbNG0I2OWOrEYElUWS7L+PLXJUiopg
 DbWh/EA1MzYm8BCjcbZpB+Udy9nqA8zI+cqrJKhV85PcgUqOINicJYgnRGmVvXE8P1Uuz8Hs0
 hL6FJRBcBhhTrTgcShyvy+LC9vFlHWiuMTN4g8nZ3dbsmFBj0r7okb50ovnrRmJQoyBCfUzR9
 Ys5WzbxziYadleQ/R1X82Zx/C9lF/PLm0NILwFHRpW59ZJd/7CVlb+SAoNPqJn424JQWRRB9t
 3dQ7AJOz0KhHzrNYceDzUAoeYFrShDE1G1LRG6XaDgkXqBHZTeYNoz1PNooH59M1YCyd7EgmM
 b7QvAzqzIEJAZMAV75cFWyNpWlw3h8tsAU9rdPv4zoeTBCX8KwvVjNB9YeivtaOxsHihhifgk
 u/VEJfu8yE7BAkZgvL/NhyDMp/Q=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/21 08:14, David Sterba wrote:
> On Mon, Mar 20, 2023 at 10:12:49AM +0800, Qu Wenruo wrote:
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index b96f40160b08..633447b6ba44 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> +	/* Map the RAID56 multi-stripe writes to a single one. */
>> +	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
>> +		int data_stripes = bioc->map_type & BTRFS_BLOCK_GROUP_RAID5 ?
>> +				   bioc->num_stripes - 1 : bioc->num_stripes - 2;
> 
> When ternary operator is used in expression, please put ( ) around it so
> it's clear where it starts.
> 
>> +		int i;
>> +
>> +		/* This special write only works for data stripes. */
>> +		ASSERT(mirror_num == 1);
>> +		for (i = 0; i < data_stripes; i++) {
> 
> 		for (int i = 0; ...)
> 
> We can now use the iterator value defined inside for (), it's relatively
> new due to bumped minimum compiler version so I'd like to see it used
> where possible.

Although I'll follow the new "for (int i,...)" style, this particular 
location can not be replaced, as @i would be later used to grab the 
physical and dev.

Thanks,
Qu
> 
>> +			u64 stripe_start = bioc->full_stripe_logical +
>> +					   (i << BTRFS_STRIPE_LEN_SHIFT);
>> +
>> +			if (logical >= stripe_start &&
>> +			    logical < stripe_start + BTRFS_STRIPE_LEN)
>> +				break;
>> +		}
>> +		ASSERT(i < data_stripes);
>> +		smap.dev = bioc->stripes[i].dev;
>> +		smap.physical = bioc->stripes[i].physical +
>> +				((logical - bioc->full_stripe_logical) &
>> +				 BTRFS_STRIPE_LEN_MASK);
>> +		goto submit;
>> +	}
>> +	ASSERT(mirror_num <= bioc->num_stripes);
>> +	smap.dev = bioc->stripes[mirror_num - 1].dev;
>> +	smap.physical = bioc->stripes[mirror_num - 1].physical;
>> +submit:
>> +	ASSERT(smap.dev);
>> +	btrfs_put_bioc(bioc);
>> +	bioc = NULL;
>> +	if (dev_replace) {
>> +		ASSERT(smap.dev == fs_info->dev_replace.srcdev);
>> +		smap.dev = fs_info->dev_replace.tgtdev;
>> +	}
>> +	__btrfs_submit_bio(&bbio->bio, bioc, &smap, mirror_num);
>> +	return;
>> +
>> +fail:
>> +	btrfs_bio_counter_dec(fs_info);
>> +	btrfs_bio_end_io(orig_bbio, ret);
>> +}
