Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B9D37BFBF
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 16:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhELOUk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 10:20:40 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:2842 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhELOUj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 10:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620829171; x=1652365171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9+sf+N1rWccVkKGahOqoNHFJRDl2hIPtInSr58L7gSA=;
  b=Jb0NBR8CFMXUM4zaM6Dl52cSV6N5gmGyKKDvz3vCPY0fv3Gs9aEkDtaV
   jfKuxk4ByqHmmjfnD9oVuolVlD6AOJxFXe2gMjrbGBy8azkekOom8U66S
   dfqFheDdJA9r0LTGEFq1Jj4NrNqVYMlIIgf3LuUwIexdcMzdzNGdMvR34
   tkgYiw/vb+jbFFRb2VfY9F7tB1f4NjbtXTwG7q4oyXxm1elYl74KZ4m0s
   kBON4f3Zmz+m70CpMgGuXK/Fgy9TxPzHXWxibGg929yzbu+GQRFHC+pVj
   ij11hyh9JE9vEdYduKp6JswgRlU95ntTALM35JuuhMTyzvnRz9CfICmdi
   Q==;
IronPort-SDR: Cp3mA65wdXREqVwmWXidgaYXCpCIeXqFHzvbYe5wzb3nz1L0u3Ja4hzFkAwFGL6/QhHnJEVrlF
 AZWorPrC4QJF8yJzkFtli+tes+017L4i2/Q1nmkyY1OcbIlrFjozEifugm073Dv8B40aGrkvN6
 Rlkw8Du/trmDmCmRfUz8P4gBqe2b9Dr13emdf1cImfiols8AJ4IGI6+AmcSCJuezykeQCryQl1
 7cVqVKoeZrvEYm7jMSCTA59vZNAK5RNi3A/ke72YKwYfcTRAXNl7K8+myeFtvRTu1Yc+ESeuog
 e7E=
X-IronPort-AV: E=Sophos;i="5.82,293,1613404800"; 
   d="scan'208";a="167220729"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2021 22:19:30 +0800
IronPort-SDR: 2t2+Ucd62HT24tf+ff7hoq6FKWKzDAGNcUX3fBLrfdR2HoHoClHa0spdx4ncTH6Owdms17Cgzp
 yp15ud7GWAnDjj1UR9t849OvlXhvw8wgx8wy4k1m/whbZYze1Go9WxPoc2J4xUIDCDCUUK9Kml
 rdhW7HF9FVicfRn2Q4RhvzBaMeluBMv9fYh9xxm1u17dTWwj5MQd4M09Iu1KhNIWTEJsnPuB2Y
 zx598MDsErG5RtezGcZ/3gzqcDINIlD+GvD994x7CHnhRNvyH3SiazP5vPNCp5DBkv1lxg2UDi
 JZ6eREimIziK05u/wwHBVdY+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 06:59:27 -0700
IronPort-SDR: p1v4qAajty1dTo7oTvkuFK0aNhTBy0A/YfwglalE/0XGec4pQnqx5GtqzWnrg9+XytX/mAlPMH
 uc0eL9eJ66E5aq3/YRwaoZ5yTIPMTEi31OceYrAThc2t+fPM6JOO1B/kf+DSbM4jGtOOAbmoYl
 36omqMJZA6Nx4ia3raGxqyrNTME1RZk+waA5SHMmiHfuvv/3Ur+g++ZUh3RnM4ESH/4/rAftSg
 w6A26N+qOm4wiye0zbHQ4fxP3oWliKNX9WGAkVnOtnuXIG4Ju4RXjAoN5rvsjLtHlHpS8F98uG
 3YE=
WDCIronportException: Internal
Received: from jpf007636.ad.shared (HELO naota-xeon) ([10.225.49.239])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 07:19:30 -0700
Date:   Wed, 12 May 2021 23:19:28 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check for minimal needed number of zones
Message-ID: <20210512141928.rkk4jt6wn3uegvdx@naota-xeon>
References: <20210512075305.19048-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512075305.19048-1-johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 12, 2021 at 04:53:05PM +0900, Johannes Thumshirn wrote:
> In order to create a usable zoned filesystem a minimum of 5 zones is
> needed:
> 
> - 2 zones for the 1st superblock
> - 1 zone for the system block group
> - 1 zone for a metadata block group
> - 1 zone for a data block group
> 
> Some tests in xfstests create a sized filesystem and depending on the zone
> size of the underlying device, it may happen, that this filesystem is too
> small to be used. It's better to not create a filesystem at all than to
> create an unusable filesystem.

We also want to think about reserved zones for regular
superblocks. For example, with zone_size == 16M, we reserve zone #4
for regular superblock at 64MB, and this setup require one more zone
to allocate a data block group.

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  mkfs/main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 104eead2cee8..a56d970f6362 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1283,6 +1283,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  			min_dev_size);
>  		goto error;
>  	}
> +	if (zoned && block_count && block_count < 5 * zone_size(file)) {
> +		error("size %llu is too small to make a usable filesystem",
> +			block_count);
> +		error("minimum size for a zoned btrfs filesystem is %llu",
> +			min_dev_size);

This should be "5 * zone_size(file)".

How about extending btrfs_min_dev_size() for zoned? Then, we can avoid
repeating the size check code.

> +		goto error;
> +	}
> +
>  	for (i = saved_optind; i < saved_optind + dev_cnt; i++) {
>  		char *path;
>  
> -- 
> 2.31.1
> 
