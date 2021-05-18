Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5FF3871D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 08:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbhERGXB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 02:23:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27975 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbhERGXB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 02:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621318904; x=1652854904;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=e99A1pnjib/4HcwJbgK28nu6XSyRE5VHwHgAy/d/fEc=;
  b=b37mzpqi8WxntWaqRXN/veZ1sOfP+AHkzVRm+WbimA44xrewO5aSr6iY
   8aQu2YZoyxRPdFcAd6PJ5y/rovIR9oH6TWY7RLPfhXKo499pJnKSON1HZ
   YfEbZVsZPrWVS/CTxYf13nv+sGweJtN91nqsVEhO7bGg2Ugq9OKJfhirq
   NtS2MI1I/E2vfb8p4cGYRf87+W/Yl1wZWe3vsDsuobz4xCQKaYWQ8IzXi
   TSdpeFGdbmQisNoC5nWXdaXmAuO/ddB8sCapOT/hUV9Cy5fZzNRat80kh
   Y9oA2fj+srCibYv+AKPDxQvu6CefWlpm4oyhZj9CjXfO4KN0s+gu46xWC
   w==;
IronPort-SDR: h2DXZLZ+VMka0YCl9a/fVsc6XQevEczKzgK06TmSUoqxYfih85+fmYH+thpXExX2dlimBOYkrT
 2rYGouCqP/VrJuMmCHvb2FK9UYEETrH+63GwFYV5TxIm40b4OPFlRvuINwfaN39lid2c99aEeP
 kxjQYmN2HWIgo1EGz7NOwZgcb6JdRS3N5cQFiHFZGND/HLwJRCqyApWUuZC5BjaWzj1jqEANkW
 giVSRwCy1o6Xlj2ApViVtg/K4b4q0SBfKegfAATmm4qgCzMDk/E/T8dnuD1mtyaOGCb4DBCEJN
 GeY=
X-IronPort-AV: E=Sophos;i="5.82,309,1613404800"; 
   d="scan'208";a="169078184"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2021 14:21:44 +0800
IronPort-SDR: M1g6c0ltOqk2tqz9FI0xFhvHQMZ2iNvzk6m2OC0KsogWN5o2E9TelMNOx5WwA9Fe15GfjkSkK/
 afOG7lgg5IkhR0YE16YcATOI3NdY9BH4fbaOYatAiV5qNoipV+wxJ2iJPH/fwiQsmUqgBxv3EB
 Q1bH+w4wElVSSa+5s0CuHjo+purY78ms9yZoov0L/f5ejTv3BXPNm9WpAhFi6Lzew+1ZP7wa8T
 BCfNp9dQ2VXBjwIOMfz4eobHU8/Sknx3RyLPNF3/1525ml0NRwlLwPyIds63gK3An7eUUOHuGH
 x9JQpuJ+xBTnTTD0JjEniVvP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 23:01:23 -0700
IronPort-SDR: reYSArcrL8OM15xHVPwNHTVPBJD/fHhVDvur9Xgw69k3l0wYm3Vy3oQQF3P9BBCudy6pX0M2lN
 67nlH8XXxMRZARSOGTZWc/p6g/eFi9BsouQbpWKo4tBldeX3QooFFoMlNBTcaMo1qRZ/nzvxFs
 BazA8m+RfQdvjzvLCezLSBqG+93ikwy0e6VciI0cMUX3vOzbEeFaX1d/ZUJqYvBDlmrBQjOXCW
 2l8rIdFJW7/ww7I2ekLWp4gZs9giwWyfOaHL+9QdBLOuyTarEMy7RJeKdC8T/OUJPxAQVbLxDk
 izw=
WDCIronportException: Internal
Received: from jpf009086.ad.shared (HELO naota-xeon) ([10.225.50.145])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 23:21:42 -0700
Date:   Tue, 18 May 2021 15:21:41 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: disable space cache using proper function
Message-ID: <20210518062141.vgjuswx3ldwzy45l@naota-xeon>
References: <20210514020308.3824607-1-naohiro.aota@wdc.com>
 <20210514152742.GY7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514152742.GY7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 14, 2021 at 05:27:42PM +0200, David Sterba wrote:
> On Fri, May 14, 2021 at 11:03:08AM +0900, Naohiro Aota wrote:
> > As btrfs_set_free_space_cache_v1_active() is introduced, this patch uses
> > it to disable space cache v1 properly.
> 
> Can you please describe what problem is it fixing, of if it's a problem
> at all? The two functions do have quite different effects, resetting
> generation is simple but the new function starts transaction and
> iterates over all space inodes. That's beyond obvious so this needs an
> explanation. Thanks.

Sure. I'll rework the commit message to tell we want "cache_generation
> 0 iff the file system is using space_cache v1."

Thanks,
