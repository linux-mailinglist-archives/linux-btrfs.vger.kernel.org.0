Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C84E6CF758
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjC2XeG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjC2XeF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:34:05 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE035257
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132844; x=1711668844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GDXEDSyEMJWiW+7+O1GblQg3NUjwO7C813zV/2S0RGs=;
  b=EzuBTmc2duI+8DSz153sZCucaS0dp/4F4b5zYjfAVxsGrvZJyuFyw3i/
   3dXdZqG925q6KoLw9PW8Q6I5VOL8GQx5Yt1LKrQFsJdrTbnnJXkE66AE9
   CkfX7zuuFJ4Pi7yDt9oLCpsqbOpNuagYlI3PBCT8hTsS3ZoqRdvsBMPQv
   WHO4dWEnY/XNcQuRpajNE+kH0ac/FviwHkmPcjXRtr9zoZ5yOOsiJtLAS
   Y14yBvh0eyXmHG177I6ohWG7m8le5c4yG5k7EHJe9RYUUxeDSZ95bvzX/
   KvlTINuOgA5mGNoGbXxehFaEmqjGpLPlaI9NCQgO3hKXom+FIQeBbIWCd
   A==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226648258"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:34:02 +0800
IronPort-SDR: mtglumxmg+zRy48yfoM2sxBDRmPiSl4T5A/eufvZcs2Os8pHVfuLwItSl2xvDrmVAFsz7oITbS
 k8k0AjMw43lpEy8/DwpNsslZ4sN9u1sfNJmmzvEHYHYNPQjV1TwRxX6oaCCK6o9BvBWNeGP4t+
 3aM+RD9jZZCIVjitYZClBLL7cv3/xsodu3lP1p5kauKDDBlBVT30//sW4EaveAvdRMZZqmyW3u
 IfcAS1aAqgCyPOsz5P4LLDvObSfgfpoLrshTh5e0CJsp7sDGruksFdBeyG8IXHV17bpzY5X+8c
 oIg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:50:10 -0700
IronPort-SDR: /lUbHhELVJE7TDHB3WCodEjYrydtv2T/8Q9h67ORt+7dd3nN9KHiQnNbTUXu7gI0Q1a2cEGaEr
 JKg/P7FfaBkw1FOitNk7T5xOywCqnmhE4FUALdAOHZWqg0xLMWI69VkzqOnrvvYa10KrpDkq62
 G5Wz3SbVrke3P2xpV+3Vhdg2eDTXYbphJHMoKUwqHddbDir6tx7otb7InSPV+tejDy+6seHtle
 q34ZnZj2ZMD5u42fuUzyZZCn+rsuI9AJV2tqKGy0OlLPIo5NrhzSekfpJrEyiqg7jQbjwqNlNd
 aTE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:34:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2tx4p9Mz1RtW2
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:34:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132840; x=1682724841; bh=GDXEDSyEMJWiW+7+O1GblQg3NUjwO7C813z
        V/2S0RGs=; b=Kl9kIAB48YMkB355tdUzMAD6Lq7A95Cb8NfzVQHNcITpVbKpz5Q
        Bf/AlRacy+pwRPXxv/Y59EYwdHDj+sTzoN5d7khiJg1/fGxSDSjw6dIQly/wyEJ2
        ukCLhjTvrSGecTdk0ROBuOBGbsnuKbXyOPdM7YY2E4Dni8ehYMBTgPC7NIVoKJxc
        8IKPtyMNTgTUJYWyKfuXjNsbQw0QIXDyQWwuAWgSMepI8V9fHAzLY/2GXcTCzi1T
        8EIsd+WBdRLyK8+qPFbQ6B5xdnHCAUKseq3eKeeBNbs9gw2iB6jUvVdXetSvwOGq
        ede4DlUtPAZbbK7Xl0zEQL9cV4gZzJeC4yg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7J8EbE48BHpc for <linux-btrfs@vger.kernel.org>;
        Wed, 29 Mar 2023 16:34:00 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2ts6Vtrz1RtVm;
        Wed, 29 Mar 2023 16:33:57 -0700 (PDT)
Message-ID: <3f1c6faf-b558-14ba-a2bc-ac12aad41ba9@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:33:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 09/19] btrfs: raid56: use __bio_add_page to add single
 page
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
 <5ce38530bc488f9d4f1692d701ca7ad5ea8ca3e9.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <5ce38530bc488f9d4f1692d701ca7ad5ea8ca3e9.1680108414.git.johannes.thumshirn@wdc.com>
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
> The btrfs raid58 sector submission code uses bio_add_page() to add a page
> to a newly created bio. bio_add_page() can fail, but the return value is
> never checked.
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

