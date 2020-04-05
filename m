Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C0619EA9B
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Apr 2020 12:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDEK55 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Apr 2020 06:57:57 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:48504 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgDEK54 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Apr 2020 06:57:56 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 009859C3E1; Sun,  5 Apr 2020 11:57:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1586084275;
        bh=GZcnd+ahhl/Z2Urgft1wWdQQrho4zf74/N2VGHS6dZU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=NTH5lqnWpTyAmTyrVWJWrhzQdkDGlzWh5R1Ef35bWMVVeR7tjvlNHL46ADx4yfy3V
         NIBL/cK7Hf6rRJtPhrWEnG0++kK+2pZKyAuT38uPjahP7AQ/DQ6b71jfxEM217dwbR
         K4ccwEZrqgXWCFsT3zyCmQkOJGKJmblrBi7JAjXW6llSF6tttGeY8LMOVXIWr+anNi
         fTBqOnzwKnEOdki3tpEh5wf5aLnbiC41aWcTdecwpuzGHtMF/ayS3Cg8W6va6c0cV/
         qcKKC2pJd1DGdslTN5PtHdxOHhxYuzK0rwnUnxaDJ5nJEFSiQf8iTyYHjoGUCwZ3wr
         zr+1A+R2cx3EQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 2BE6D9B9B1;
        Sun,  5 Apr 2020 11:57:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1586084271;
        bh=GZcnd+ahhl/Z2Urgft1wWdQQrho4zf74/N2VGHS6dZU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=jho7+McTu97jbWRQOcPjjUBbXHThV/mKuwHfUHYO8+My52dEG3Rk/g934oOEXyiaQ
         wySzfLgTsjdYaFjUy9jRIXlJGvtvcSzFpK7XzjB1t+l3kwcf0W0xJvse/WrOuPRUmq
         GVgkI9YB0Rg6JgjXA+/vrFK0i8a1qHsRwDGybmjVVEh2PzepFp0R4VcjiqsIb2csok
         dB4iEcuuzSqTkp2x7NsQCK6Pt4yZTt6YsakkTU9j35Y9xFh5wiSZ+/O3B60taxBDm8
         8VkLmz/7vqhzWxcrp2riyaJ84Wpvus09cu6hPN0rdztd0jygJdq/RCexWIitqgVfRo
         5vM0MWi9YR2Zg==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id EBD2CE0503;
        Sun,  5 Apr 2020 11:57:49 +0100 (BST)
Subject: Re: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
References: <20200405082636.18016-1-kreijack@libero.it>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <58e315a1-0307-9a26-8fb4-fd5220c1d5a6@cobb.uk.net>
Date:   Sun, 5 Apr 2020 11:57:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200405082636.18016-1-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/04/2020 09:26, Goffredo Baroncelli wrote:
...

> I considered the following scenarios:
> - btrfs over ssd
> - btrfs over ssd + hdd with my patch enabled
> - btrfs over bcache over hdd+ssd
> - btrfs over hdd (very, very slow....)
> - ext4 over ssd
> - ext4 over hdd
> 
> The test machine was an "AMD A6-6400K" with 4GB of ram, where 3GB was used
> as cache/buff.
> 
> Data analysis:
> 
> Of course btrfs is slower than ext4 when a lot of sync/flush are involved. Using
> apt on a rotational was a dramatic experience. And IMHO  this should be replaced
> by using the btrfs snapshot capabilities. But this is another (not easy) story.
> 
> Unsurprising bcache performs better than my patch. But this is an expected
> result because it can cache also the data chunk (the read can goes directly to
> the ssd). bcache perform about +60% slower when there are a lot of sync/flush
> and only +20% in the other case.
> 
> Regarding the test with force-unsafe-io (fewer sync/flush), my patch reduce the
> time from +256% to +113%  than the hdd-only . Which I consider a good
> results considering how small is the patch.
> 
> 
> Raw data:
> The data below is the "real" time (as return by the time command) consumed by
> apt
> 
> 
> Test description         real (mmm:ss)	Delta %
> --------------------     -------------  -------
> btrfs hdd w/sync	   142:38	+533%
> btrfs ssd+hdd w/sync        81:04	+260%
> ext4 hdd w/sync	            52:39	+134%
> btrfs bcache w/sync	    35:59	 +60%
> btrfs ssd w/sync	    22:31	reference
> ext4 ssd w/sync	            12:19	 -45%

Interesting data but it seems to be missing the case of btrfs ssd+hdd
w/sync without your patch in order to tell what difference your patch
made. Or am I confused?

