Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E302C6CF78A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjC2XiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjC2XiR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:38:17 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237CF12D
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680133096; x=1711669096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=trSlsKzGDIdMPkatCLLhm/IW4lDqvQLyF89j6Acxt+c=;
  b=Gj56nBHQauwY/wGbYU86+5tVcTdrG79qOgq1eT4Zhs0sxoAm0ti4+YqP
   EuIXDb+uCg6xyEGGh/wOXcrblsIr329N2xJu0jMie/Jxv8hZ26kciGNbF
   4KD0IgprTkmFmmhtoZ3DR4kwltcda9nbTquiqGtqDikg4muOR6Zmn5uZ1
   HFAyaQKKXZ79acRgUX3Ntbb/8gz1/zMk+/xT0+dNZcnutnY7Dgi5YxE8U
   Khy7nVCPaVHF7k0tBAaIDo+fO1K8YvZ6C/l0o/gyGw1ZtjHC02s5ABo4M
   YbXYK/ilBSgyYp1hCOj0W0QLjiV50y3BjXqemposPTp3quHIY3Ad4GM3O
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226648449"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:38:15 +0800
IronPort-SDR: r4sTNHTc2+m9EbVbU1J1KeMUOizlDE5ABCQLWJi7+ntk/na12IVawZTUc2Sq5HGPV34X+frFSO
 esqpZuhGZba3BGaFw40NA9MBzLDNd7DYzd5Zh4Ca5QPmr4NL+vrXEytuN4TrzbZeIthD1gVbQ2
 2SDalBdtAWtO3C6Ae0AaXC/YLkfJaPclWciEhDYivIVuHQ8xkHrQxuZixD059eb9+9CK/fGU8p
 2HpGC7k82YUgDIWECyObeS6u4AIBbPw9dGhp8jmPbS7Eca84mtiZHBeL/tp1ChvfICPi3YNtnK
 5R0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:54:24 -0700
IronPort-SDR: /tLlh2pUA/q52XEET39ENmIGSJ0jIR9i66Rnog+yu0ZyqXxYZpE8FOx0P61CcuTHecLGBNGTK/
 hP8PNGBoesbJqSP3X0NeGCwEijNxJdcu2eJNRjTeWlWyzVDurFDp5oZE8c03I1c5Su4yu8UY4L
 69S/a1lsyvtE4HBP/yMXfuvURxG6appb1S5EDHW3wHKTt+PNu3HKOaYFBkHCE+Ifzx8RsMrkP0
 jUB3bTZ4ELX6mTtrfioscaZ0xJk4tmaPDb3GyYmF6PvkviAIov75oDYZ8PF8v/Z7J3DYtmwlVt
 rEY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:38:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2zq0hKpz1RtVv
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:38:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680133094; x=1682725095; bh=trSlsKzGDIdMPkatCLLhm/IW4lDqvQLyF89
        j6Acxt+c=; b=IwLM6OxTQ5LWzxAC4NcyXZ1dr2nvfgOzo9MYnLjHJuGsYvXhajL
        hlDO/OUe2nXi2knwvLTDrpf7NjCBruC2QzmIpB4JE9IyVsUJJAG/YLLsSyvDJh6t
        qxwxrHBhyTsmBCFnvPnxGjsvWVabw/lioMS9Htl+JJJqa4JvEgAHA2zECs+RUwul
        t+dnEFKBLZOQyEWCGPk1uA6JA048hYHWTFe/WWVJRogq+WSguIeHywIZ5y4oQkjK
        dU94SWBhAlGUm9MArYUGt90AtfkGpTivTX688Qa5D0tXrxVoC2lWcu6DZA0NboRO
        DWfvkb0SzT2gUKXzOI9on0y1QnPiBSGbu9w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L5I2HSregPxf for <linux-btrfs@vger.kernel.org>;
        Wed, 29 Mar 2023 16:38:14 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2zl2Krzz1RtVm;
        Wed, 29 Mar 2023 16:38:11 -0700 (PDT)
Message-ID: <546786e3-79b3-f9d0-008c-23d2de7eb3de@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:38:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 15/19] md: check for failure when adding pages in
 alloc_behind_master_bio
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
 <76f5748e386870c034b46e919101a878b87a79bf.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <76f5748e386870c034b46e919101a878b87a79bf.1680108414.git.johannes.thumshirn@wdc.com>
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

On 3/30/23 02:06, Johannes Thumshirn wrote:
> alloc_behind_master_bio() can possibly add multiple pages to a bio, but it
> is not checking for the return value of bio_add_page() if adding really
> succeeded.
> 
> Check if the page adding succeeded and if not bail out.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

