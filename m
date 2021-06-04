Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56B639B75B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 12:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFDKxW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 06:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFDKxW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 06:53:22 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E856FC06174A
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Jun 2021 03:51:35 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id B81949BBB3; Fri,  4 Jun 2021 11:51:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1622803889;
        bh=JlKfN4wiMT7V8X4FYn+E4NcIfEW3y+zkR2NFM535zFY=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=ybn/gle+9de6p0AErHfRirSznxMJZHrtEV4Xsyj4Nv6agws181ENt8amEU0d8QFhM
         g189cd3os9Wnv+aGAXNVdpEpLNfdDQ9cijPXxLiR2mPJDqT9/GFM2Wh5ks20u2RBWd
         Vwi5cidUSlcs1kW65KHLvmVHVA8OsplybMjugC5Cp0kvof6V4+4BdajYBA2IpgKVwf
         Sj9vUUuaHMPFqtAVVN23FlU5REiyBRsuJOMnr3hL8g0vix7V8kNPv00RptOUCjsDhc
         bEMa851zZF+xXqCDQ96rVTeweaj0iNStHGwlSdRMIMBK3Yz/p/TF9RQTup0Q3SFj+O
         pPSi6WWEZCbqA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.6 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id D5CDB9B730;
        Fri,  4 Jun 2021 11:51:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1622803886;
        bh=JlKfN4wiMT7V8X4FYn+E4NcIfEW3y+zkR2NFM535zFY=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=ZjQEXV1kN9kz6LKMPZNzJJp3lp/aMa+Tpqp4wAIbGhBDMdaIQzcmJ7OALIuq2JUJP
         8zRF5Lnjsti84bIjl5WwEhHUR6QERToHOVHGXCS0ahy77qBUupgYYaB6Il2xwXz9it
         z/haJFSOeK+eNQmChRqtR1rqZjALlcUa96Jgdkz91+4xy1WElxvg1/Mqjf+AN4tupM
         JKJSgdtZHwp6IhZmgoL1POV/hKarn59SsFSwju/1nt+L+wQvPQnC/6WQvkb4yh6bUY
         13/WtQbOIPmD1gOBRNlnnSIm23UwiwzXEXkxm/+ZS6zhVGDUXLzo2FDUx0bLwz+Jw8
         e4dTEPIry7Q+Q==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 6873624DCED;
        Fri,  4 Jun 2021 11:51:26 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <2c3054e5b93f023cabd003ab4006d5f18ef3d484.1622717162.git.anand.jain@oracle.com>
Subject: Re: PATCH RFC] btrfs: support other sectorsizes in
 _scratch_mkfs_blocksized
Message-ID: <20049d72-e875-3f4a-1f2b-ec3f1ffde354@cobb.uk.net>
Date:   Fri, 4 Jun 2021 11:51:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <2c3054e5b93f023cabd003ab4006d5f18ef3d484.1622717162.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/06/2021 10:36, Anand Jain wrote:
>  
>      case $FSTYP in
> +    btrfs)
> +	grep -q $blocksize /sys/fs/btrfs/supported_sectorsizes

Should this be "grep -qw"? Admittedly there is unlikely to be a false
match but the sectorsize should be matched as a whole word.

If there are any greps which do not provide -w then the search string
could be "\\b$blocksize\\b".
