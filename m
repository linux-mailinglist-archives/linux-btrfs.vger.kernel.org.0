Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827236CF733
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjC2Xb5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjC2Xb4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:31:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088541FFF
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132714; x=1711668714;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+kVHS+U6z9asf4h5hbfmudX0RZseimMtPqZrPjZ6sRo=;
  b=G7/PEtig9Dz4Q+gLCt3wJw5kEpy3qUWMTxb4wK7p5fBYG42sNLZ6FH1K
   54FtK3+HRtDt/TtpzPveRUYFaXcVwWqaRSHYe9XIye0LqBII4OzaRLQtg
   htsvYFUaUoCU4agFZ3k+EC6pdp9MtnHzM6cY3ugfHMKzlJOzxRikSw0bC
   i/4EAJ0K8ldOXp1E5zXrrIC38o/kG2GIUi9lKs3UryCe3B9Gka4A0N4Ps
   T7RkU5zgiPFklDi697gIakdL1Gt+x/1Rd7t8qibYMpNakxgZs/kEcu7bK
   5BKVxbXot3KOb8LPmOXQ2Lz2IH3VtSX8e8dc4gQx8wMaaGlcMFhfsnqXn
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226828499"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:31:53 +0800
IronPort-SDR: xEsdjybsNN61oOQWLQfE2zb231nx/LYGOZIk/YDVxpypMjUnclT9kaL/8Y8gZJdHZ+hkFVvzbO
 adQBfDnXCUL+O7m/98z5+8fnE8/9fhrf28KHhkQ17Z/+DlFt0tYGkx8K7Yy7KTe7tTzgVEcmka
 AbjMPc1nhOJ0q+DBEVa/cegW09e4fKpvj//n5VHusSdqnqtAqp4+D2dLIL3hCclhkCXHv1LCIO
 waEz2vs0sCC92bAIWe/75uuPdEMUEEqE4se/ks9g8lpaBcLCAYDQXm86M3ddb2l3Rypz76MCTq
 eVE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:48:01 -0700
IronPort-SDR: gFdtEHdkdalBtzlvd35gtxBkemNKH8Z9N39TkFEi3OfoidhCM7Ss9GpBqE1nSakW0DKnjameq+
 2dzYIDIvSKuTzjD9NZd1hqxF7q9x8etoy/jzjolo01V9Camw+kO92AaGIagIRpRldph0wv31x2
 vFP/HREdPVeGGLixg9Qy3UhilIjeH1jXKb+aQf6Y7DHlbGtOP+2g6fdq96kjthOotFBeXnX6ER
 8jsRBeWP8NibiPUEekzNKXqv5SSkX0p52JccJBiyWNOFnezv2VRYJ353fC70aflI50u3kFtN41
 3Mw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:31:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2rS5dccz1RtW0
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:31:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132711; x=1682724712; bh=+kVHS+U6z9asf4h5hbfmudX0RZseimMtPqZ
        rPjZ6sRo=; b=MSq/WJxnLgUdzNLdphZIxQyHpRfCEW6j0Wdm4bITDd3uXIJqQ4U
        6qdg8Jn+9J/5Vy15M0ezWVKJWT8F8K92ngiUMKiBHMjvNoXlsCiavKM2pCNvEVov
        vlK/ucLB7MVAxYZ5cHk1jabnY+TbwEwlTT9KgXLD0a9q8dyAASHunSVnEyJEYJ7P
        7iw/QMpUPkVls7zoUoEY/Arks/dS+UANaSD74pMDu1fcBTeFf/On+bqerWeu/wXb
        w18aQHkuSirM7cbXNck9eth9dOrIym0BiZLWxzFL+lQf5z8+AxH9izE6FsdvqzY0
        s4/hXeC/IEhI1jqvjLH2uTpMFvpk3PLBGwA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m9ZBSTe2U66y for <linux-btrfs@vger.kernel.org>;
        Wed, 29 Mar 2023 16:31:51 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2rP0PPLz1RtVm;
        Wed, 29 Mar 2023 16:31:48 -0700 (PDT)
Message-ID: <c90afdff-55c6-a4f2-0ad9-a7bb30e6c214@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:31:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 05/19] md: use __bio_add_page to add single page
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
 <55ec6659d861fd13e8e4f46d3e5a7fbad07e3721.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <55ec6659d861fd13e8e4f46d3e5a7fbad07e3721.1680108414.git.johannes.thumshirn@wdc.com>
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
> The md-raid superblock writing code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is never
> checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Signed-of_-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

