Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93166CF765
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjC2XfA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjC2Xe7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:34:59 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7374C13
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132898; x=1711668898;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eeHaifFAhmRPPQjhcQgNdDiqHkPhvUoOQEh9qZdcZBI=;
  b=nwV+wIED/Q7YNoZuyBLObCCPHxZQ67T4mdS4MS0MHtnRVdC9XMhLLEf/
   itbgJ9IQ8I9aJbeRksJophYANs9pb2p3dp9j65fkh5jDgaec/hYkSqZc5
   bvxxPgJedycs5p6rHHiqAbI9z7m1icyQb8eeUF4GEvh6Dxfr1WVHfwaxh
   E99grbaVtY13TFsiPkkH9Iy8s+R6GspbLsKJY5QxPy0YxgSOpyxiVaWeN
   Rfbm0o1AI0ACHxK03y7Ldp0deoow0DYwg1RpEDah6jpknFX+W67Qj40vb
   OlsHWkYYiQi5ZP7E3qmvXIdUuoRnVVpY44ouN6fVizaUocMLzffPpBA0k
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225113716"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:34:58 +0800
IronPort-SDR: c8tYYOlwWtGoHiI2quhbeSuwXcpDY1IPLByIH/RRRjtVmpQyjY27DV/CFwpkyl7Npoa0SXhwzD
 u9cZHlFy6jbQ7IzU3+rKdo9JNysBwSaaBKeCeBTgsjOJQLOVTSgwocsFesIPoiTJ5v5+Y5er8v
 vFBX3/nEAM0YXq9gH8zbn+vR7FWPze8kjILshyVP06/Lp9htFsynQW/gy4aIiI3qsjo5wOdh4J
 Y0t2y/0NBsf9j6iYxQsqXABUQcJ7hFVE9lwPCrQTmF+nsoH1JwvaJLsuD96tWY9bGYdkkTse5I
 HhM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:51:07 -0700
IronPort-SDR: gOEbeSHruH2MPx7O6sLyaCuVzdcUaR4nU1T0wdqr3aB4KJuCmT+/ceAYdu1MOYk0t5iSGSQ0uP
 dVMdKrij9xzzx0Op+2yRYabyv58A/S5sSs5oHwGcqRGkxweK6ziKVsf3Y7tO8sAhBrWi67CUp+
 YgH3KIPTMbOKgBQIv1xPWyFUkF5+FHJ4reb9pvZfuFGu5ph/PzhG49VIYYJK7pGH8XRwuZI18D
 noFayO5uQgt3re9vtwy6CUZAoeHvve5CWmdHAthRBVcHOPfgl2vAL2VhJQv/+XDkXQtqPl9NSp
 7kc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:34:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2w233QGz1RtVn
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:34:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132897; x=1682724898; bh=eeHaifFAhmRPPQjhcQgNdDiqHkPhvUoOQEh
        9qZdcZBI=; b=BXNDcLcmPPrVqL0uFQjErIzucxTlO2TIjyuUMny2mRGUWmQis2+
        Kp33jWSJF1g147Opo3rTneP3H7gwmNnEY+Up30cZQPxCibvRicdthlRAp7HwfA3s
        yZ2CR0pSt1DWieL+O+5noiTVyC18th0YJN7NxnEc9WA69UT3Aek5Gf1Ykc8KUD/E
        fCMhYTIDSrIhJoUmE5A9NvofEQI3CB/096YNkJxWerVVLA5+j1USgnk3t3REY1DB
        4txAUQ8raXYpQ2EQFHL2FPvKU/3Tn62ZAbsAG7vjHNq3VUhum4TuE7DV08/TeyBl
        eQW/1XF2djdTME7GQEAjbOj7c59rU1TGj7Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 68KbyfsgXMnE for <linux-btrfs@vger.kernel.org>;
        Wed, 29 Mar 2023 16:34:57 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2vy4wThz1RtVm;
        Wed, 29 Mar 2023 16:34:54 -0700 (PDT)
Message-ID: <14a2f204-32a4-5108-560b-98c3dac2abfb@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:34:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/19] gfs: use __bio_add_page for adding single page to
 bio
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <51e47d746d16221473851e06f86b5d90a904f41d.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <51e47d746d16221473851e06f86b5d90a904f41d.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> The GFS superblock reading code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is never
> checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

