Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561C66CF75C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjC2Xee (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC2Xec (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:34:32 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C3212D
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132872; x=1711668872;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ma+GEPR39SMifngZ8BJHd5lgwaD86YsRlpp+x2qXieU=;
  b=A8Tri+9HrNeJkZeU0mQH0Du+9Wp9flidcVkgKm1M9rMGIRGJxwsrzjQt
   9FsJpXnCL9NW2cfPMnw/jIFU1NWOnCZvkwdsoA2WCpZk7MncCDo3hZq5z
   GyHy3asRcPc6ij2Ru2y6flAPuooQsS0Jvh28BW5cf2RsuM5ZooyM6WZkZ
   +x9M3LG4TbYNlTAWJgV4nqgEHgmh+m49rb3bNvX3dV0Tqq32hMU/cHM9i
   y3NYGTxabnjbXdjXwUnyz5sCd90GcBuiA7Fsvb+j0ZlJ+dGPNs16Ql1U0
   sZB21gS39IHSDRztPJvn3/JyQ+UGCUQRlNCI8AP+5rimul/PvyODDC86Q
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226648281"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:34:32 +0800
IronPort-SDR: FsmolNJINGuALkuG3N354BFwAhuff5HrNhWvqf6NrXQnbXuVUJCzqJo/9XIxeahe9Hlk03eOHk
 adcGtV7FZ1X19YCYNG1XApmihvap9BNB/y+QggrwjdepMuolcehMN8Qt8x3DmvD9uce+NUjQHw
 KzVK7L3YiZoAbLSJfQfVOuJ/rZBKov2+jrzwoiLyjeaL9y/xSEtuZlgySWLCe+VJUxPl49pYrn
 +ISywj0BJfUm+6CMRFumuYlmTLIDJq6xF6KWwYYxRHFYLH3Wz+6z1/A7FUIY7HNciTae2SHMQO
 MFE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:50:40 -0700
IronPort-SDR: +bHoHl1OBGNmPGuFvo02zEFeWztKZH8x/Eub/j+uUL9hnFMhPBYJMQuWLJnamv7++Lp3/KLb4K
 w2bNLlb30RbHB+xXfLSZcsr20yXuIOdyj4TRmYkA94Its3JDifSlcyrZsfEgeKSMZRXVIjIb2r
 MYawGWWRutYkqsZfzmf6yt7q3mRkhSjPrPWc5EFFfj1q+lj7xvszM9rNdmMxqx5ORK40va8NbN
 nbWyoNYKfYo0+V0gkZrqQ3LNeDUA6mU3kWDFDsCfIPrWkRK7gR87mhgXJquEshtr09bz9+FLWK
 LpU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:34:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2vW5hJYz1RtVt
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:34:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132870; x=1682724871; bh=Ma+GEPR39SMifngZ8BJHd5lgwaD86YsRlpp
        +x2qXieU=; b=fltjWhcTro3tBLErFz/FZKkzG2DRnrFpnpGJoq06RhvP/J7AK4O
        7Y13aBEddFYPLh9qRwO0kXfog8r+uI+ZEpj3mepNN45RU6pAx2fur9TCfUY6gJI1
        6dh+CAboV3J8Z+TMCQcResD4WNAFsgSD75rA+uDcCBgSl2pXfdspEqVu2G3lBX+d
        yOF3uiVoBgS9RXQiGvI0lrLCKxFf7VBP4RZM/qK3Hpc10swa4bYr8meiIO5g+tR2
        jNxUg/dF7XPNmm0sq2Anptg6+bujSCGgAr6I2EsRid+qpoqMwnWUw/TZET6FvW7R
        EFsv1nA6Q5z1Oldh2VB7ChRoWKk1ezNKX7Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y-arwVCXOXI3 for <linux-btrfs@vger.kernel.org>;
        Wed, 29 Mar 2023 16:34:30 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2vS0ZGvz1RtVm;
        Wed, 29 Mar 2023 16:34:27 -0700 (PDT)
Message-ID: <d07c2d82-0edb-6bf1-b97e-07cd66a33bbb@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:34:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/19] jfs: logmgr: use __bio_add_page to add single page
 to bio
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
 <902f83de56c67b333959d8b8b4cf37a25414e927.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <902f83de56c67b333959d8b8b4cf37a25414e927.1680108414.git.johannes.thumshirn@wdc.com>
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
> The JFS IO code uses bio_add_page() to add a page to a newly created bio.
> bio_add_page() can fail, but the return value is never checked.
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

