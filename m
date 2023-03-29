Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC006CF718
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjC2XaF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjC2XaD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:30:03 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE001A8
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132602; x=1711668602;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Y/8nFwSzVjprTaZ9/Wyk96kEMW0qhqMfVVhpdupNbM=;
  b=bR/elBEad6DlD8fi7OhUbTlBngKOHSzHYtkuUDr+jeSUshLOSSZ3gRk4
   vrmDjv5xjwjOw8mcKihv3pRtAGW880KWq1f1YgKAXAyDY/5QVRVTBHVMz
   Zg+vIPx5faL5NFYk3wu+2nIZZVBPrhy9C5sgPv8CwpgsI8Byf1mBhMOUW
   7N0FHev2nHAcPJ/Il3p5yAWQjTYjFQnl23o95tt7qYBVfeb3McfMC0Egr
   HmJDKCgaGq/Noe/+1r9HZfXs2WLQAXBNCyGeIHNAm9oqxNbAGl1deDEVC
   Qaimr98roy9QMyXvtiu8Jl1KxtfPOEcM1wUgSXkMTAbsdHigRhgdGcZhU
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225113377"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:30:00 +0800
IronPort-SDR: WfCarY+dUFvFEHQKJ/u0V5JW+zioE8I7vG1hhtK38a9BYLIZEPfwa6PJL+4iu/9jE2VYe1RmNH
 7UI7SHjsqPRXk34Z2kSnKQeZ8uZyKMjaWJdorCZylGdCQrifXDgZ/k/+cK2/JunVCngn235APg
 g2c8d8dLgAwoqjyTcpbXSC15fQJddQgGaK7wtbWq/zWtPbvZM2Us1lfFb4hnQ3OPDjR8tqtmkP
 tLTdIh4tl7SQ+KVgZZL+Nyv/wWjjE1UkSyj4FzxhP1J5KHE/sByTIBgC12k9A9tdRMnwypOu+Y
 IDA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:40:29 -0700
IronPort-SDR: 3pUNRQ+JAql9rGeZr1ya3QpwYMzHwfDS7CGlpjChr773pH97kNi23/KMB1oEWasM4IG6jwfN19
 Ogk4qolUzZyUYzKrfsK82rwD4zv0P7O4vyimlsvPVrChP+V9ktywXEaMvy0AnjKcaOwF6a1rzD
 ibkMI4Xkzq+rCh3Yw2mTGt6d8DewPTC8yXf5e+uoOd+Wj3nVFtGHFlY5/sU+bK7/1lYVSLtjBl
 dpTBj2MPfdjY3d6Lh0YxvQ4TYtCH+JrpmHxISUgcw7jYbSShD+AoJ+Afc3pG8qGsN+aLqgEALd
 rd4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:30:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2pJ2YStz1RtW4
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:30:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132599; x=1682724600; bh=/Y/8nFwSzVjprTaZ9/Wyk96kEMW0qhqMfVV
        hpdupNbM=; b=attI7Cb1FiJUfGooWKuUBF69nVtx8C0v6ZnYPU/aallwnH131e8
        koFS+onmiGvEVL5Rsy8MD8W84BqTFny7oW+UX3Q0EgmJyd7MjsjVGq5Fag+o00/p
        kBXyOu8rVI1MppDWnwv1nSsJjZgW3+f/JtpOKGfbDSqhjxMshlz8soCSdqYWdxyR
        mZbB9MxATuHT290hQKyTcBQsnd1Zs0bx71V0NrVJwmHkHSmV/TllIeaQKFtE+uS6
        +2zu64x2THYHjMlElnTspmwc+eMYbDW16URD8fpUN8smUWhlgc3H2/33t07voR+F
        ONOgbvSndu0231MHqn3BP6ebhDrfi+c2eNQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yvhX_MCLpdSe for <linux-btrfs@vger.kernel.org>;
        Wed, 29 Mar 2023 16:29:59 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2pD1Xt9z1RtVm;
        Wed, 29 Mar 2023 16:29:56 -0700 (PDT)
Message-ID: <ec7a0c67-a0b6-64d7-0f3e-dee9744daffc@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:29:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/19] drbd: use __bio_add_page to add page to bio
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
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
 <87d0bf7d65cb7c64a0010524e5b39466f2b79870.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <87d0bf7d65cb7c64a0010524e5b39466f2b79870.1680108414.git.johannes.thumshirn@wdc.com>
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
> The drbd code only adds a single page to a newly created bio. So use
> __bio_add_page() to add the page which is guaranteed to succeed in this
> case.
> 
> This brings us closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

With Matthew comment addressed,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

