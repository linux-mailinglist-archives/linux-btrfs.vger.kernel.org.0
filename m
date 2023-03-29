Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A26E6CF726
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjC2XbV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjC2XbT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:31:19 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA0C40D5
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132678; x=1711668678;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UNlm9Cgnb69c4/O/u7KM3nCJu6vgziKIZ4YaTqHtuUE=;
  b=Zjg7dg8p+fjLvNjK85BbXq/dPqHa7FY63D9N7TjaILgZtYXJzQp04Lbj
   T3HoMvrPtyxVfJObcJogfKLakV6t/8XMIcOfmUPOPKHtEgNDQvhALmJPd
   IgnPaHI9lnst/7NajeSMpKNzxg3AJtfS2OX/quWbHnegqeZ0v9OrOaf2T
   ATERS2Itsocp2zPaXbApE3VahiI5x6IiE9MrTdwiaIIVTDIDuLws2jZuV
   tfA5MvY+FqH7aGEz80vGuv3QAO29wtT8Ixcfsn4kpejCb2ea72THy418U
   bMYw+YzLQpYU4x7OvTfiXF9ibMhvg5aVVwiYIOCrZDY2xt7B6abqGeijT
   A==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226828445"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:31:16 +0800
IronPort-SDR: 8n0Al8x81WzKfi4/de5/wtDXxUuiAroY3PibP1eyOqKTBd1YqHo+uHKpiGBRBp+W3dSuAt3bvS
 fryXFYCeZjDSey7VW5fGC7wxWbZnUFm5o8hXUuD81skVr/IEU6fRJ8reH2aXvd6TO1Q+Xn2+tu
 gmJ8GeBS89cwYyfbcvPxwWHyQPnxUStDSrZKLUSQo7yGh10tAD3Iq75nS7NAX4hFlTQdkvHEKd
 eawFFua4YxQwHOZq3lHHOev4X80XZujyYXh2c2soGYCAY24BaYpHjBWFG2I+sYJaQkTuY87F6v
 sZw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:41:45 -0700
IronPort-SDR: byoZ/+XbhJLIMEgYEfsT02W1VuelxSnD5SQIr5wWy4xb45N6D5zcA8Jx1OyW9/B6YNNKsNqLYG
 CPLFNX2rJ2WKkX3S3ZNB9OGgjpR49xB1oByCL1F3SrhSiolKYHUpGwN6/9ZRBuz5Kvcxk9OYp9
 f+dbBBEdGwIDYMIjBZWRTJWAsvZISdyGOFoG0gYtO0YjnPYvuddEeR/jRJ9RWjMyQLcI3BSGBu
 dUV+jXc4XWLa5VbSCkUQpfIA39eUUruZxmpXnc2m/Z03/f1znV6ZJKJIuSsSt6q9m4J7nGnoRW
 2AM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:31:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2qm1F4dz1RtW5
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:31:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132675; x=1682724676; bh=UNlm9Cgnb69c4/O/u7KM3nCJu6vgziKIZ4Y
        aTqHtuUE=; b=Ca2fO6rcxglppHNXYxRAHziKkRlfWQdPRtKcotDpyHFiP/dqL1l
        +eRINX7r2eICbC4KQtNpc23E7B6cTVrRj9Ksclu4Jqd/OhE7FGf0WFts4RSkNvRZ
        vyDh64QjNua4rA3LG9nobAs9hY5rxbY67Vr2/TNnOHh89mZ8LeAkwGHM4RGHVU7Q
        G2zLU+l3brOhyc7kjdil5v6zpK4QdjwQTJ4zW86BPD9Cb/sL1GpTuVvrOGcehbqI
        6BtW6hfXgSgZ2432WxO3xb5C7AONp6W2nDb+sKaqwGk9QuSWfywQR32EdxP4QOPx
        RFADdkCfux4rv8H/ZisxP0MjM4uYkF1VzgA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EZ9T0r2MEcWD for <linux-btrfs@vger.kernel.org>;
        Wed, 29 Mar 2023 16:31:15 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2qh3MbGz1RtVm;
        Wed, 29 Mar 2023 16:31:12 -0700 (PDT)
Message-ID: <3ba0a4e1-7b75-9d0c-d6d3-dfc3d4bbbef0@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:31:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 04/19] fs: buffer: use __bio_add_page to add single page
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
 <56321f8ef1e70e9e541074593575b74d3e25ade2.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <56321f8ef1e70e9e541074593575b74d3e25ade2.1680108414.git.johannes.thumshirn@wdc.com>
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
> The buffer_head submission code uses bio_add_page() to add a page to a
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

