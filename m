Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE4E6D147F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 02:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCaA5k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 20:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCaA5f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 20:57:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0891043E
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 17:57:09 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M42nY-1pi34c46jY-00019q; Fri, 31
 Mar 2023 02:56:59 +0200
Message-ID: <e6129b7c-f70b-dc9c-b4d2-07a12fb26eff@gmx.com>
Date:   Fri, 31 Mar 2023 08:56:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 04/13] btrfs: introduce a new helper to submit write
 bio for scrub
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <cover.1680047473.git.wqu@suse.com>
 <72f4fa26c35f2e649bc562a80a40955d745f1118.1680047473.git.wqu@suse.com>
 <ZCTK34vrpfGiCu1B@infradead.org>
 <b38a9aa2-9869-2f95-59a0-d2fe20f4e1d6@gmx.com>
 <ZCYJn6ygcvtX+ZEh@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZCYJn6ygcvtX+ZEh@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FfoOpOiDD5YruKe8yI0p6P8tInMF4AYLB6eGf+Jc+p7JDRuenei
 wBZWEV4DxT7TEqZTx0j+6xJU3YYnKR+GTMshHObi7vhFHRwYjmlpHduf6wnOIYcP9JEJnjq
 UfgJdq5wJD6pdNxH04F0lj8Hg+6dTTFdeyi8l9oNpykU+RkPDk3ewbzBkppia4tNKii5x1X
 Uek9dHBkBRIdVs/6U027g==
UI-OutboundReport: notjunk:1;M01:P0:oMofYve4CIU=;CIQvnGcZEA1DxyPiFagkvS2T2Gw
 tf9XeSRGR97VnwE5Xi8Bi9bdNWiMt8vktDeVCPay1Z9SurCGEe7LIDMGWdyOUbD/umevBWSyn
 /dZwVvtjVFStDCg9YYsSrgXg1bj7qzPmiXLIeZgxFON11SrN2WvxIA3md0fpff5k9mseKjAPi
 wURCupZl3QlkS8xpjt/8Rz3GBzkfovaOYqMlsPsaaRqjvKNzeNoyzkXesF0oieVp5zy0/0h7U
 MVcfb1QeIH+omJiihsmO+2AcjOQ27ZTjR06Rb/d6sK22PTMe3GIaGq3ZZ2SYyyQCD0ZWJpOCp
 V1yRP/dlOxdXN1IJYFCypSiHJV94+CVnqj5b/io9aAnCqc6e6wda6Jn7CrzKV8af2C2jRmwJA
 q/nZNFutZDkTUPkPd0lp0ga8FeRIQhaelpJt79LiTDymnHvVCz09AUFpQggeoAg9QZzCpBA51
 sUMhxgUqc7AmxlBy/GoRkCUlFXIg8O7FK1TN2ba8q8qNAev5PPxs9zSzrtoSsGDLrKAsb9eub
 wk5fQcrbkXu7vsUBeqT6Anxnfh6dejnO9y3i5mWjr7Bm7nR5+XUEn4WlxS9FE94X0HKJUyP6R
 Wns72R4jZHewvJLBmXBnPOpwIyta9UNtBhUFShd0OcIiUf919qEW2+tNmyLw/a78uhiUMHKo2
 PqT+FMdYCv5Fjwuqr+vs+GWWIVsmOD2e+e3R7igEl7MhFFCcBpeevicFrQLbskvfevPKldmPb
 lj9KJYASeqwJSR8G4u4Bq8voGoEdbkW1ieh7ze3eVODnsYrUZvVBaZAdq/o4jfK+OGAfyT2nP
 GpNoIAJSD/02ruWCwKc+nQMNihX3XA56hp0CYVQMiX8oA2875C+TpwAdGYNo3LZ6+dn+6vFot
 i2PvDUaNLGhO8v4FrKSQJtm5XlXQjyXUreAu2pd+1rnQvp5bpS8Xy8KKM4t4tjSbRaJdo/P5D
 qs0EUO1d/ZhwrPc29Jtt7dCH3rY=
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
>   - I'd factor the raid56 branch into a separate helper
>   - the non-raid56 case should probably call set_io_stripe, to make
>     Johannes' life with the raid stripe tree easier

Forgot to mention, set_io_stripe() is only available inside 
__btrfs_map_block(), as that has a direct grab on map_lookup structure.

But in our case, we call __btrfs_map_block(), thus without a grab on 
map_lookup, but an bioc.

Thanks,
Qu
> 
>   - all new code in bio.c should stay below btrfs_submit_bio to keep
>     the main I/O path together
>   - typo: "No csum geneartion" should be: "No csum generation"
>   - why can btrfs_submit_repair_write skip the
>     BTRFS_DEV_STATE_WRITEABLE check from btrfs_repair_io_failure?
>     Shouldn't that and the ->bdev check be lifted into map_repair_smap?
> 
>>
>> The whole series has been tested without problem for non-zoned device.
>>
>> Thanks,
>> Qu
> ---end quoted text---
