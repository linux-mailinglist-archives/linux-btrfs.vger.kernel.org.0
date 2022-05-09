Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC93251FB5B
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 13:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiEILgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 07:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiEILgF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 07:36:05 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C991DE579
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652095932; x=1683631932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v0lVI0gmiUvzoNmI5a0guGMpgDZX+uKFFD4KLqB/fQU=;
  b=jqj4ZCR8YmssCzTh7IcPWd3vz9jyGwCAO5tZK1uPSJgGlg3iY5qifmRS
   gSSyyhTq/QzCzqc5zxPUNpAhF0U1HbGQOBSGxIvikJevvOvUBmMj/dl4c
   umvmG5E3D9SaQgb0aOFlKUGMsrhGxb0ceumvIPdG/vRa6HYGZlFMQUXIP
   HEZg2rZaoqZgkRsrM2s/gsDSuStjZ1JRycTM9nYPO0TmHrm9YW4HsAZtz
   H1u3U/9tErzmFMkUhyv0WMCYOdkhuqCsZzQ6ipGECpvZIzQK5fpgnWdMO
   kA01r58y6JbgYz5L1236Wl+y6f7lBnGnkIgiOO+b4oEv8rrum1p4wOlDk
   w==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647273600"; 
   d="scan'208";a="200733505"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2022 19:32:09 +0800
IronPort-SDR: aPeAH3zA6nVOX1qKDAS27bY2A+cMZPesNJ4detAbKh/gSIKOLyzjiYYIFuFwXunITqkAsyovac
 x0VFQik1NuHuDxdkSxUyHOxe5B6KGbrMs5kX4IHqqXyobG4RAL0w8gb4R9MB0wn7sJrxGdNys0
 r2PFGmGz4xZxaLnIH2HEMD26LjE7NRWND0zkpSHieODuC1vz6MdM94WzJTU2HTYqNnU6v63xm1
 4XxsfmtUi4axUFPUlvgp+UXLrngTJ1XlX9+oIox2gW2MaIljZcwOsiz93XfDuh9rSAn/PT1MS3
 jLMEXmOZns/tC5MZnQiWochq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2022 04:02:14 -0700
IronPort-SDR: rzUyegYN+J7BQ2P3KDYhXQPZGsDPYFeXteE1tns9wg632/jDLus1cVWR52yYF1obHs6nCdxRE6
 B2Ar9GZ5NpieOcItUITTGVWT9IPkpwR/W/YRCq4hqAN53OhHPGbU7rGmmcrcDaDlYwzCeuNicM
 A0XKc7NOPY4Z7g/elQIl8U3unZg1DcIqfCqQoSHXimPFbC2njIvZRr3J/hwfWg7CyWiw46AFbs
 zumGZCw5+0B4pRkfRhrO4fLVftKhixIhC9FfHnsBCQ+ztO79IFXkIEiRi48IHhvwaXyIWGen3U
 DSU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2022 04:32:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KxfCW2FQ0z1SVp2
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 04:32:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652095926; x=1654687927; bh=v0lVI0gmiUvzoNmI5a0guGMpgDZX+uKFFD4
        KLqB/fQU=; b=E/S7+ftCKDojRwdfWfMiCt2FBFS6P6O4vQv9CY0mSrWKcOA/TUZ
        cINZhwkUJYr2VgFPHiRT6KCIT63B1UNrpbQrpHSC1d6EEDVjfyCzgGRo25Yk+Mak
        ke234L+h8WlpCNwP12dZFkUA1RUzY8bhjo/4g7dLD/EYNiArXQLxsSKwun2bK3Ud
        0wdN4f58GNZYl3Y6Xy2a/6WnwZ19GsujmmSXyN8pGC3Pw9VYMxpmDi/CSROhi8Gv
        ZaE8OWsdQY3K0YdfRMnjbNkDESbv3xgPsyP35A+xnGM6iDPATqr5gNEjatknRWB9
        QJziNpUStccPtJO2rPx1Sa+x/ad4k2zfTDw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mYZKPBn9kARO for <linux-btrfs@vger.kernel.org>;
        Mon,  9 May 2022 04:32:06 -0700 (PDT)
Received: from [192.168.10.49] (unknown [10.225.164.111])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KxfCM384lz1Rvlc;
        Mon,  9 May 2022 04:31:59 -0700 (PDT)
Message-ID: <9eb00b42-ca5b-c94e-319d-a0e102b99f02@opensource.wdc.com>
Date:   Mon, 9 May 2022 20:31:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v3 10/11] null_blk: allow non power of 2 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        hare@suse.de, dsterba@suse.com, axboe@kernel.dk, hch@lst.de,
        snitzer@kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        bvanassche@acm.org, linux-fsdevel@vger.kernel.org,
        matias.bjorling@wdc.com, Jens Axboe <axboe@fb.com>,
        gost.dev@samsung.com, jonathan.derrick@linux.dev,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alasdair Kergon <agk@redhat.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098@eucas1p2.samsung.com>
 <20220506081105.29134-11-p.raghav@samsung.com>
 <39a80347-af70-8af0-024a-52f92e27a14a@opensource.wdc.com>
 <aef68bcf-4924-8004-3320-325e05ca9b20@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <aef68bcf-4924-8004-3320-325e05ca9b20@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022/05/09 20:06, Pankaj Raghav wrote:
> 
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>> index 5cb4c92cd..ed9a58201 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -1929,9 +1929,8 @@ static int null_validate_conf(struct nullb_device *dev)
>>>  	if (dev->queue_mode == NULL_Q_BIO)
>>>  		dev->mbps = 0;
>>>  
>>> -	if (dev->zoned &&
>>> -	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
>>> -		pr_err("zone_size must be power-of-two\n");
>>> +	if (dev->zoned && !dev->zone_size) {
>>> +		pr_err("zone_size must not be zero\n");
>>
>> May be a simpler phrasing would be better:
>>
>> pr_err("Invalid zero zone size\n");
>>
> Ack. I will change this in the next rev.
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
>>> index dae54dd1a..00c34e65e 100644
>>> --- a/drivers/block/null_blk/zoned.c
>>> +++ b/drivers/block/null_blk/zoned.c
>>> @@ -13,7 +13,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
>>>  
>>>  static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
>>>  {
>>> -	return sect >> ilog2(dev->zone_size_sects);
>>> +	if (is_power_of_2(dev->zone_size_sects))
>>> +		return sect >> ilog2(dev->zone_size_sects);
>>
>> As a separate patch, I think we should really have ilog2(dev->zone_size_sects)
>> as a dev field to avoid doing this ilog2 for every call..
>>
> I don't think that is possible because `zone_size_sects` can also be non
> po2.

But when it is we can optimize that. All we need is add a "zone_size_sect_shift"
field that is initialized when zone_size_sects is set when the device is
created. Then, you can have code like:

	if (dev->zone_size_sect_shift))
		return sect >> dev->zone_size_sect_shift;

Which avoids both is_power_of_2() and ilog2() calls for every IO.

-- 
Damien Le Moal
Western Digital Research
