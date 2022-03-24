Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159A44E5C21
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 01:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbiCXAIY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 20:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiCXAIX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 20:08:23 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F068D8C7CE
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 17:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648080411; x=1679616411;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mELbjtWyX6T5i8m1jUKmp6jnYkgBZZhowxWCLq71Szk=;
  b=feo2byTBUxwVRv3Dzb/Yzsh1ao16YFiO1Nt+2uvcM6K0G3h2zVdmVybR
   3r5z4KLZxiEILXnYrcQSOdXzjLzXK1YFXe7q3L9w3X+Ey6p/FkR9kw7Y+
   gkYyun1q1AT5qZgwF7QghlaicFEKWfDFlvKTUcg5E3hQvWVgZGa8DpmVF
   daNaDSByjjjNXv/d2JHU24nkMjUbGrqp4VS1YzKGyPLyrAB2pucnHiKqq
   zBrs3I3UuAVqgJWqvc1AQ0USqRcrp0Igj+LjaH9gzz150o+uVbnwXeqJM
   F/lSRXLiAwoMWdnwRKqc/QRT1rw4N+K6uZ1wqA42OeLqX6UJ3FsebtQtO
   w==;
X-IronPort-AV: E=Sophos;i="5.90,205,1643644800"; 
   d="scan'208";a="196117014"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 08:06:51 +0800
IronPort-SDR: /bjk31bqDeC3bUaX2pC9xoLwjaOI1CCBY0dIyyvIkhbFlmzObQZfk/+c5WIU/MISbmQ3R4uUUv
 1CyLsNiSjxyp/0yZh1Lv6FtFufqDH9Y/gJerTW/PqCaXztrCDs1WUxPh3go8G9iERDkuOEEizh
 jhNC/IQKI3bWGuLca5Fh31mlkw+XKWNWLjEYq2+tAiOSZIugxLg6ulNVw3GtEkiY/Qqu1mtIcj
 Qs9bidS03arN8fNaVlCogrzIlI9RCgbB279Ea5C/DBqXIFO38neCMh8Om2NPd7GbjX/GaKLbHq
 o7fe6ZpLYACnd6CgUiDUiM5h
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:38:45 -0700
IronPort-SDR: hDAZqNyUOvlIQ6KuEfdqWfQV81R4neh3/P3f+jzw3iO2M53bC+ZxnwFczqEFHgiHKv7UntwtB9
 ciG+z+ZVyvG06kJdMHTgp4DfRxMYr6RJr7/2UGwcQUPJNY3TAG0AdiGIYy2zR4VtTVNqExqgEO
 4reQdbjc2XoEnZIzc4RPtG3S9xAepm3uAraMcKhBRA7Bmcou+EGqYp1R76Xao5KpwEAduRkHOc
 OXUn8qCyVpYLAvf9NV5BtMed/tGla04FsiQMgoybQHGDo+gS8xrTXFDv3jUMmoD/lsdN0hOuLd
 2Qs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 17:06:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP5B42HvRz1SVnx
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 17:06:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648080411; x=1650672412; bh=mELbjtWyX6T5i8m1jUKmp6jnYkgBZZhowxW
        CLq71Szk=; b=V1vWhGR1GphJ6Hcwvp85q73P+Ptam751yGRu5IsUl9hH578aQdZ
        VNYO7VGPJ4GNTDjCDb5raDzU7deoWQ+uLyhFUApT5d8CEIGTYv7Y+Xzju1WNYk8L
        ByBAEhyY+XI5dG+vMTNmBRvKIc1h1itPrlZJRtX661kLfU1L4Vk4SzhyO+kJNP3G
        sc8za1VqUoMPcozkIexqDJT9JwCSn+MebtQiEZ4cb/KROa58yRo6X1nMzFye4/xI
        UsVUlUsFEh3B7BnIXBV2RlrD8MQyu6ztlesP0oB9HM2oZ9OCznttPEdCRNfpL5VJ
        2JaJdFENgcabtTxcuTpRq8wVOe3dN+UCKXw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yMA0Hs4k0nmT for <linux-btrfs@vger.kernel.org>;
        Wed, 23 Mar 2022 17:06:51 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP5B20r7Sz1Rvlx;
        Wed, 23 Mar 2022 17:06:49 -0700 (PDT)
Message-ID: <8d09bc99-0a7f-dcac-0d63-1979ba7dadba@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 09:06:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 5/5] btrfs: zoned: make auto-reclaim less aggressive
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
 <CGME20220321161435eucas1p28901f03d0533ae246f51a3b96bfc07b4@eucas1p2.samsung.com>
 <89824f8b4ba1ac8f05f74c047333c970049e2815.1647878642.git.johannes.thumshirn@wdc.com>
 <f4e4a70c-0349-fafa-8375-8c4177a3e260@samsung.com>
 <PH0PR04MB7416CD1BC88132E22790A1869B189@PH0PR04MB7416.namprd04.prod.outlook.com>
 <b0e84388-b56f-d8b9-2795-ec8d74431475@samsung.com>
 <PH0PR04MB7416E2A6492CA8BB2DF07BE09B189@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ec5f09ab-b868-7128-cacd-000f66f3b9e1@samsung.com>
 <PH0PR04MB7416D06ED74EE14B13C1DB3E9B189@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <PH0PR04MB7416D06ED74EE14B13C1DB3E9B189@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/23/22 20:52, Johannes Thumshirn wrote:
> On 23/03/2022 12:24, Pankaj Raghav wrote:
>>
>>
>> On 2022-03-23 11:39, Johannes Thumshirn wrote:
>>>
>>> It looks like we can't use btrfs_calc_available_free_space(), can
>>> you try this one on top:
>>>
>>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>> index f2a412427921..4a6c1f1a7223 100644
>>> --- a/fs/btrfs/zoned.c
>>> +++ b/fs/btrfs/zoned.c
>>> @@ -2082,23 +2082,27 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
>>>  
>>>  bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
>>>  {
>>> -       struct btrfs_space_info *sinfo;
>>> +       struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>>> +       struct btrfs_device *device;
>>>         u64 used = 0;
>>>         u64 total = 0;
>>>         u64 factor;
>>>  
>>> -       if (!btrfs_is_zoned(fs_info))
>>> -               return false;
>>> -
>>>         if (!fs_info->bg_reclaim_threshold)
>>>                 return false;
>>>  
>>> -       list_for_each_entry(sinfo, &fs_info->space_info, list) {
>>> -               total += sinfo->total_bytes;
>>> -               used += btrfs_calc_available_free_space(fs_info, sinfo,
>>> -                                                       BTRFS_RESERVE_NO_FLUSH);
>>> +
>>> +       mutex_lock(&fs_devices->device_list_mutex);
>>> +       list_for_each_entry(device, &fs_devices->devices, dev_list) {
>>> +               if (!device->bdev)
>>> +                       continue;
>>> +
>>> +               total += device->disk_total_bytes;
>>> +               used += device->bytes_used;

Does bytes_used include all the unusable blocks between zone cap and zone
size for all zones ? If yes, then the calculation will be OK. If not, then
you will get an artificially low factor not reflecting the need for defrag.

>>> +
>>>         }
>>> +       mutex_unlock(&fs_devices->device_list_mutex);
>>>  
>>> -       factor = div_u64(used * 100, total);
>>> +       factor = div64_u64(used * 100, total);
>>>         return factor >= fs_info->bg_reclaim_threshold;

Not sure if the factor variable is really necessary here.

>>>  }
>>>
>> size 1280M:
>> [   47.511871] btrfs: factor: 30 used: 402653184, total: 1342177280
>> [   48.542981] btrfs: factor: 30 used: 402653184, total: 1342177280
>> [   49.576005] btrfs: factor: 30 used: 402653184, total: 1342177280
>> size: 12800M:
>> [   33.971009] btrfs: factor: 3 used: 402653184, total: 13421772800
>> [   34.978602] btrfs: factor: 3 used: 402653184, total: 13421772800
>> [   35.991784] btrfs: factor: 3 used: 402653184, total: 13421772800
>> size: 12800M, zcap=96M zsze=128M:
>> [   64.639103] btrfs: factor: 3 used: 402653184, total: 13421772800
>> [   65.643778] btrfs: factor: 3 used: 402653184, total: 13421772800
>> [   66.661920] btrfs: factor: 3 used: 402653184, total: 13421772800
>>
>> This looks good. And the test btrfs/237 is failing, as it should be
>> because of the change in reclaim condition. Are you planning to update
>> this test in fstests later?
> 
> Yes, once I have an idea how to do. Probably just fill the FS until
> ~75% of the drive is filled and then use the original logic.
> 
>> I still have one more question: shouldn't we use the usable disk bytes
>> (zcap * nr_zones) instead of disk_total_bytes (zsze * nr_zones) to
>> calculate the `total` variable? The `used` value is a part of the usable
>> disk space so I feel it makes more sense to calculate the `factor` with
>> the usable disk bytes instead of the disk_total_bytes.
>>
> 
> disk_total_bytes comes from the value the underlying device driver set
> for the gendisk's capacity via set_capacity().


-- 
Damien Le Moal
Western Digital Research
