Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192066CF792
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjC2Xiz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjC2Xil (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:38:41 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8334200
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680133120; x=1711669120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aODFcqxqHz5iuZ9R2+Bd+E8Nkx+iNXfbVHgy68x60n0=;
  b=pjXjIy9ijoRUd1C5IN0e4crRBYnEnG1Liug0VxsT/NR8V6dfk1xBaRK3
   AB0X+w9NDw0E+qy93p4Nl8JIan7kI5KitENt5fDC/CchWtDrz2o6V/uEr
   K9CQpbPWSLijcVfxeY6758BdQBgk8AgxU9mPvcRdXGjR/fYRbxIU5Ae/P
   0mUrz03akeUmJiNv2SG+LM7cssdr1Zg6hJ6Jtct2Zvsh7OLZsv722oe3i
   jEcDeVQxTXjKlZDaw46MlcwzN+m7X7CRdYiD/Yv9KgxhBW1fVAYUw5BDQ
   ZP3AYum6MxCajbDmvttjSzTG455N5bwxJ9BR1fpf8OY9Wo6bvId24K1hC
   A==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226828799"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:38:40 +0800
IronPort-SDR: 5R7RdqpAEQCCWhUnrHZ1AGryB8W4jZ0Lg6OJJ9dkZbXuSuZu5qo4s/J+J6/wLZEajeFdRJEsfB
 r76UIYKdLWsRB4qBON+8sj67jkjM+lfxpK/KquI9v2ejI4Iys+TOiPnrthMGHnhGCv/I59hYL/
 2XXNvEEuIztrIc+S1LRNKf02nkqeILzpdxy6TaLs/kuRR2dgkV/6+kjg6HxIEPkAKjuNUwpBlB
 mnir2Y1VN0qa12fRbejQk6z4V2TTEtbafUOGIojjJQQ15Yqz0ragvIb/6kHo2qgqOKGfnoDX3c
 lho=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:54:49 -0700
IronPort-SDR: PxumUK8cv1s+DHmeSwOF/1+Ne68Jkwa1L3eIzr815cqhPYLWcGC1w6xXytacAsY7aMvMRagBd/
 cruMPhJNdHc7QpS4mquSqKIkOVU1rUyH1/FmzAPFW6RC2hWdQhiN7nOW7U6JWSC6e6h2HxiZNf
 y8sHFIjvjcUyvONJsryFd3Kq9UD4tHFc0rsvYnVamFq/Ls/DP36Iw1Zjcn2S44x9jP/wRBtQc6
 umLNpahobRTU5O+s8Urf+8QHmFZigzi/LsrvzCaeuABAT+FttxU8O+7p4UCv4V744YEFf2jxqn
 jqg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:38:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn30J2lY5z1RtVm
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:38:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680133119; x=1682725120; bh=aODFcqxqHz5iuZ9R2+Bd+E8Nkx+iNXfbVHg
        y68x60n0=; b=KBjlQKVFv+faQXsHdbboX8Xx9NxcmIm9AdBgDadiYuEI6iU44Gp
        jIKLTOiXkry8UpjbdYwauGh77NnsPrQSFZpCT7/P7YDoBzDw9zAFX+sbYXbItBD4
        Awy5kRAsBzpAxGEQt6/iFRAhFRIvGXb6QP2BKhHdWdA6t/8jyHKIjGtg0XDfA0ep
        9/S+K4tRXJIRFwdQ+UasHvlXj7W7pXISUVz/O/kQ1s0icT+btM6C83LvSU896SWN
        zX3mTR/5AXoqxmQ7Cm4R0QRAsxtuKFEiZ8wGyy7Y6iwGwfe3kKGL98CIKdDi6AJd
        jzR0sEF+xRcPBDw1yJoRYinpIPNolkCqMHw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LmPMWxE__1T5 for <linux-btrfs@vger.kernel.org>;
        Wed, 29 Mar 2023 16:38:39 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn30D5vG4z1RtVn;
        Wed, 29 Mar 2023 16:38:36 -0700 (PDT)
Message-ID: <84d3057f-58b3-b3da-a473-082806c4b5f2@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:38:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 16/19] md: raid1: use __bio_add_page for adding single
 page to bio
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
 <8758569c543389604d8a6a9460de086246fabe89.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8758569c543389604d8a6a9460de086246fabe89.1680108414.git.johannes.thumshirn@wdc.com>
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
> The sync request code uses bio_add_page() to add a page to a newly created bio.
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

