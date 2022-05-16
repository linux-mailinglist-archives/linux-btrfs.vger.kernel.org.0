Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A55286BD
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbiEPOPs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiEPOPq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:15:46 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D6EE3D
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652710543; x=1684246543;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zOv+Wev7E5lt7EeSM9kcmJh0rO5V+6OnlZIVl0tMHMU=;
  b=gNwZBKgCfyhrTKiCCB3x1nm/TFnJZCjxKWx17jXnaGav6PUGhi3QgjW+
   XjszBwgosW8wCV1JbnLcQl7onbKbA3YlCaECjEXBtIMHRcLarbKg4mY3m
   VYxh2Ip7M0nNC98U0ZW1id58Y5MiTtwCukMXYlIxV2jOMfyljbQriJNE4
   SvkqOC2pgY8zoHuLgEq8cDAeHIkwmyksMysoWPlM4Ilq+RmHTo/od/z+p
   Tdp2tokbP2UyiKZQDuiQQ3YcLhB6Z7qxcQ56oSk/Vlss9DmK26WoVgPPD
   upUfVfW0AMc10qiKiBX72leT2M+yAxIvKTFig4OP1EvMpC1Kzvcf0L035
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205308052"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:15:43 +0800
IronPort-SDR: c6ARqlzwsqnoCKiFLX3mOCTTiXQQZ155gG8YHIC/T77p3Vai9QF0mD3LF1n3hm7eUo6n1UHiIe
 k4jo067UPOm7YKjvMqLcIHe7kC3nMLcm7nAaJmcqy7Wxj5wBuaGM54YsUNGSkM81OohveIZ+GU
 aT/5H+zZ+kaK82IUdZaXu5gp2XFM2wy1zMSUBOTQJ0hckBld19mJnKNVJJwD78cbKnVBAVkcI/
 5xB7CQHsVOvOsMK8j1wYX0EwBWnS5Ou1yuBuoo3+No3g/+c6DQLQaNHhHmpcPk36kO337V7rN7
 F6B2UuS+3hD2qyOxpUuXjhl2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:41:24 -0700
IronPort-SDR: oeNs1mEjzLJ4H6T0X35VMpUvV7R8+x+fFw61IMg3JURJRvp6rjRkal0/rBtulm8rx/SilqaNOT
 CtNcdbfoVx3bzmD5jShs25PZshg9ENUZUs038giQECkRv97WKujttXvgkMF/4m61NMDYjn7Llu
 R76jiBGQ4Hw7siYt3wQ/4IVNsHF4CjIbPgwgab2o/91Yf8UmET5BGNyDf/VxpAe5G/Q7bo/g/a
 7tED7A6LORt8tuXt4TxKZw+EnwsY4Rg49tpIhpyCDQHFdS0vbekHiKh/XoQnWM7ASH6uPTJOvt
 Y0s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 07:15:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L21W304nKz1Rvlx
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:15:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652710542; x=1655302543; bh=zOv+Wev7E5lt7EeSM9kcmJh0rO5V+6OnlZI
        Vl0tMHMU=; b=i4y52IglqHa1njsCmAT+LslWANsFjmGWNuC+BQusYwJboYbqlpx
        1K5trb7R/DS0LQM7zIGMW36j5tKV1MkXjwyqWyIuVDc9mYbpFnl/PFabswil526a
        8PiySSAYXnoSsIriKA/fIQIfIzGNus805nNa9Qt91pNUX3WFWNouE47CHlBB9rel
        maqyn8618u1OIr5FZQpjtBkmCq16SVwivVnZFernknGS9rgAJn+4/1wc9xKfDMsc
        KdcjDRBgvTZk1H8sIVIYRnv8T+1SqXKjglgem7sY9T2qTTW/b7gkVCrv7G4sfF23
        zShZbGhGxHLSBwjGLH9SpFHHDxkqgHQgncw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UMYRfs75UpAf for <linux-btrfs@vger.kernel.org>;
        Mon, 16 May 2022 07:15:42 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L21Vw31VPz1Rvlc;
        Mon, 16 May 2022 07:15:36 -0700 (PDT)
Message-ID: <31e03f27-6610-c4e4-58b9-6b9db000a753@opensource.wdc.com>
Date:   Mon, 16 May 2022 16:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, dsterba@suse.com, jaegeuk@kernel.org,
        hch@lst.de
Cc:     jiangbo.365@bytedance.com, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, bvanassche@acm.org,
        Chris Mason <clm@fb.com>, matias.bjorling@wdc.com,
        gost.dev@samsung.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        jonathan.derrick@linux.dev, Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
References: <CGME20220516133922eucas1p1c891cd1d82539b4e792acb5d1aa74444@eucas1p1.samsung.com>
 <20220516133921.126925-1-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220516133921.126925-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022/05/16 15:39, Pankaj Raghav wrote:
[...]
> - Patchset description:
> This patchset aims at adding support to non power of 2 zoned devices in
> the block layer, nvme layer, null blk and adds support to btrfs and
> zonefs.
> 
> This round of patches **will not** support DM layer for non
> power of 2 zoned devices. More about this in the future work section.
> 
> Patches 1-2 deals with removing the po2 constraint from the
> block layer.
> 
> Patches 3-4 deals with removing the constraint from nvme zns.
> 
> Patches 5-9 adds support to btrfs for non po2 zoned devices.
> 
> Patch 10 removes the po2 constraint in ZoneFS
> 
> Patch 11-12 removes the po2 contraint in null blk
> 
> Patches 13 adds conditions to not allow non power of 2 devices in
> DM.


Not sure what is going on but I only got the first 4 patches and I do not see
the remaining patches on the lists anywhere.


-- 
Damien Le Moal
Western Digital Research
