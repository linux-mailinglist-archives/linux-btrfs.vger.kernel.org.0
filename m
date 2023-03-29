Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF916CF76C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjC2Xfk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjC2Xfj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:35:39 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5734C13
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132939; x=1711668939;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DWbdU79pQfFU8gOZbr/b3mO5eH7xSF4O2WK0oT2d+QM=;
  b=RmyY9llVDRCKMCQoWx1Hn92pvIoETbtgV5CZZPyX9IQFh/06nP709ghd
   tsGzNF47s6Y3Nx9PqFuURWgk7nBKswUmfIchba94CexuUiymjfTg3DYED
   Yu3MbXLXbDVfL12d6wTboWhTei2vJ5jCvMqsDRmiwkOza+Db5UMXaKWac
   Uh4K3lsWfnm4beaYoxAINBkYEP0CE+76iy1s+HZRjASqEWac9bLGs/2TG
   EYcsF+RtSOiMmIhE7QR+8at/lcR29eAWiXPnQfvVP6EqkCz1YB7K22L4k
   O8xLj/i33lgtkxWN5P5Bk75DbmIn/wo5C20EXpkGxtEMBFgJDzSur3Dh6
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="231808792"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:35:38 +0800
IronPort-SDR: UzrZZVpzuQmjV1eswX17M5JwKHewkkNLXVtOrOzhRcHzNUUIi3Ipke+JmE6kK/X/k4/AiGilpl
 Z8SOWtfHdVJuIgn3a+2O3zZtVjn/N6EapB/g+po0lVN9DHv58i2qx/L1oXw1Z/SAP54VtituWK
 /gkL0Uv24SeaDhFEXTCBe2bAmxMPgcezWe0XiiTEfCrBiLt8XhzRN3vxa9JmO9PMEkHFSDdvgN
 43py+g11R//upFv5U9/16caZzCyRM63Qba+/ZnTmms9wggttScm6kLvIP/ixe0vWzoJix5iPIA
 778=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:51:47 -0700
IronPort-SDR: XVvdr9dN/b8j7nxwqkLomeErRFGad90aeudEvRcFmtef66dQH+8EYn1LCYxEIxJgIsHhiTC/qB
 M5f6cc2WGepdGVipSzjBIMmwO/QV4j7Hm3mAApo8dd57ZfXwe5rDGszm7BIxg0DC2CXEcsn/hu
 mbwVl0dRjkkkuX8aIu0ZP8wgp3X8XZRrZr50Ndr8jQms1Qonnw8Btsckbt+4fG8ghSPZHMC/6N
 b1ATF0EW22b5C2MoPPElrISjGGzT+KQo/vmDYDV97WEiTtaZ/IAdkP7+9Quo7TnV3d2l4I8OU3
 in4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:35:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2wp0tzKz1RtVn
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:35:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132937; x=1682724938; bh=DWbdU79pQfFU8gOZbr/b3mO5eH7xSF4O2WK
        0oT2d+QM=; b=pGtiZj8FTU2zGz7vQdRVApevxKgf2Ka8vvY3tec47efsQI9KN3F
        6TNrUUZy3srMM5hOLLaNJ9cj/RFbng7Lw8c+GhcUj+WX8KJI8fIL7Yjnd4bTPSsy
        stRUmGBxBOV4gys+ZZFaJ27DeqO7fJhqYFoNYW7LF3jJeGSCgJuHLKFdrC46mgR5
        469/TVxEK1vciOHd8I6Ja/b0kn7Me63VLOI+P7tjou+N5OBIOT0FMExqkO8OsOGA
        8OP7Fy+8XEeqfKciX1F/w0JzBSWbRunSIFL7UwQ/deJBQDb0gvxDp5EIV13Eq79s
        Squ+hzD5gSNXTu1SYU5Wiz5w5imKszOHOFQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j_3HfMsrS127 for <linux-btrfs@vger.kernel.org>;
        Wed, 29 Mar 2023 16:35:37 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2wk4Fdnz1RtVm;
        Wed, 29 Mar 2023 16:35:34 -0700 (PDT)
Message-ID: <ce3889b4-8689-ac73-0761-fc35a78b8dbd@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:35:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 12/19] zonefs: use __bio_add_page for adding single page
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
 <ef742ee32fd0623008114e929d9a3e688fd721f7.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ef742ee32fd0623008114e929d9a3e688fd721f7.1680108414.git.johannes.thumshirn@wdc.com>
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
> The zonefs superblock reading code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is
> never checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

