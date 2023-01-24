Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC61679476
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jan 2023 10:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjAXJpy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 04:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjAXJpx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 04:45:53 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483854EE7
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 01:45:51 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxlzC-1oTxCj2uP0-00zDAa; Tue, 24
 Jan 2023 10:45:44 +0100
Message-ID: <30259d35-28e8-31db-c2f4-6d4eebe4ac80@gmx.com>
Date:   Tue, 24 Jan 2023 17:45:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] btrfs: separate single stripe optimization into a
 dedicate branch
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <4e4d6e0aab34ab40fd0ac69874141bb02a559f10.1674546545.git.wqu@suse.com>
 <8cb1628a-bf0f-57c5-551c-21ed3fe5a035@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8cb1628a-bf0f-57c5-551c-21ed3fe5a035@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xlSDOe161XyAMwlHWNXZv2CDbwZC+bmoH/SqgkTZ+5Hsk+MxJdK
 gA+TLQ9GtESovYtw0m65kMJlmYTaAjlAZrB7FK5m+Db2Ct+FOM8k9kX3/5sxQhCNSGSOOqE
 QMo0TmGc2Q4sEGoGuPhsM5csStEGad3rydTFtjzR/8cTbVW0LX7PKpXn0r8f6KnAHYq1gp7
 TjFwwVeUKm7ksoCKE6Q5A==
UI-OutboundReport: notjunk:1;M01:P0:FGRx52i38sk=;+guwcb1Jp4u61loPLWa/5sRSWgF
 MdurK8AkgvBUKwodGTiVdBsYip/5SClnNE9Mlg267oD++V0kuOONl8k0gUgBeciu+KjgVed+z
 WVGXyzhAoEimn6rTIeBlLA5thK0r69KzXc047DjBQTLd8hj2/Y2BQN9CpvcFJ4a+1H5f9FTxT
 O6eQK8YlJ2IhPIbHKEDuOjs30Ka6DHWLxBApEDWz0C4XyTh7+locpRGCaUi7FUPsydeHXwx5f
 zFH+V7QWLvM88ayKRbKggG5k9htOhbT7VqqiuTuGZOzcaChZ4Yptr2OA9s3xuN2xkKvBENSxg
 eepQOFIkNOPHbWmqeL7w9ClwlOrNfk5AVe1zP2XNduL/aY0HErr2E0m+9QTiI4xfcuf1jk8c8
 sKi1pnbSHBqDVIFbh/dp4to+4PqMMS8vCI+gkjMuKuQU5VG5jitAjRsXyqfZ8PCC5gCPitspD
 62Y9U3nG+D+vzi1VQbNFTrlbQC1xUlYhR7qyZhb7UuZyd0Ze0VpzYmgT5aILJUgNm7u+SKCjN
 y2+PIcERIFpfe5NXmBOIXcKxDeegemgNyb5HPSx8Add9t7VI4+KsaF6v1Pj+QYngev4d5fnY4
 nfIc26CSU3Z49BAQxntSLOR3io+BWGCwcC6XcKuBHMLA+H6txmPATJwVEZuiUmmQXLPdZfJ7S
 u7GYd9jDAx5H/ElO5nTav+L/eCKk4xsV76qGL0z0F2b4eNMETABU8Rba8RRcYioWEZ4XWr3up
 3JjDzgYZdX2i5WwiY3uPfEGBs5KWcVJCt3Lt5gbhGSjSlFTiYbKmikT+gQTvZaCi/hKKA+dWC
 si57qpUQkE/LnkaD8Tq3rdTbZAqxc179EQ+vYmzPlPDMudZhFI9a6waBXF+YnEJqlxMnF2qy2
 SpSC3Cli7P7ZcX3huHkPZOopRR58c7M9m5/5Ncw3koC/1KuESP0y7xbv+tk7m9/gAGaaS308Z
 rz9zgQ79/+lWBJWdXDm0Ja/IU/npR83utJQ6pdvjSqCzZM0pYHFtOVlL/LysNBdY6lQJPA==
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/24 16:43, Johannes Thumshirn wrote:
> On 24.01.23 09:00, Qu Wenruo wrote:
>> +static int patch_single_stripe_for_replace(struct btrfs_fs_info *fs_info,
>> +					   struct btrfs_io_stripe *smap,
>> +					   int mirror_num, int ncopies)
>> +{
>> +	if (mirror_num > ncopies) {
>> +		if (mirror_num == ncopies + 1 &&
>> +		    btrfs_dev_replace_is_ongoing(&fs_info->dev_replace) &&
>> +		    fs_info->dev_replace.srcdev == smap->dev &&
>> +		    fs_info->dev_replace.tgtdev)
>> +			smap->dev = fs_info->dev_replace.tgtdev;
>> +		else
>> +			return -EINVAL;
>> +	}
> 
> If you'd reverse the above if statement and return early, you can save one
> level of indentation.

The problem is, the above one is way too complex.
Yes, we can go if (!(xxxx)), but I 'm not sure if that's any reader 
friendly...

> 
>> +	return 0;
>> +}
>> +
>> +static int map_single_stripe(struct btrfs_fs_info *fs_info,
>> +			     struct btrfs_io_stripe *smap,
>> +			     struct map_lookup *map,
>> +			     struct btrfs_io_geometry *geom,
>> +			     enum btrfs_map_op op,
>> +			     int mirror_num)
>> +{
>> +	enum btrfs_raid_types raid_index = btrfs_bg_flags_to_raid_index(map->type);
>> +	bool is_raid56 = map->type & BTRFS_BLOCK_GROUP_RAID56_MASK;
>> +	int data_stripes = nr_data_stripes(map);
>> +	int ncopies;
>> +	int target;
>> +	int rot;
>> +
>> +	/* For non-RAID56, just select the target stripe.*/
> 
> Why not have a RAID56 function and a non-RAID56 version?

That's a good advice!

Thanks,
Qu
> 
>> +	if (!is_raid56) {
>> +		/*
>> +		 * After BTRFS_STRIPE_LEN bytes, we need to forward @stripe_inc
>> +		 * stripes, and increase physical by (stripe_nr / @stripe_div) *
>> +		 * BTRFS_STRIPE_LEN bytes.
>> +		 *
>> +		 * The default values would handle SINGLE/DUP/RAID1*.
>> +		 * Only need to update to handle RAID0 and RAID10.
>> +		 */
> 
