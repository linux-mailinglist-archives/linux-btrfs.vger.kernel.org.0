Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE6CA185E44
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Mar 2020 16:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgCOPtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 11:49:04 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:52217 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgCOPtE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 11:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JnBtoVBhrYW15MgnTiORI8iNnwrOhhwNExtjzAQADmk=; b=LNgMZr2YWO0aJL0oSWXxnpY4vM
        +25ih8G+JLFdF1IB0Mt6N5ZDGIiMzNHLehtmht7OOiZ3+INoyAav6o193LjG9QhCyvtyzo0zoSfsD
        VuIo7M4dLS8pZxE7jrzOnkGbbtpHZNdDRw6wQI7Jlvm+KUvJylkvA5H1q8o6qvwHxEyqylOvJVhPN
        wluPUBH1x/JKkZ3Cq9lEN+/sJxDB8zfbnFggtlCyXx8WEmQUu1S2PdCyTjIfX0utAihxaqDepmiid
        sW7CUleS6Ls8LYlIOgF2rTQn6hrRAtuhs4/InGTUQ4YHDw842GhssfqR8O/YPHsFTlQBgSgK3Ggbj
        bDePUzew==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:14640 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1jDVVd-0000OH-IB; Sun, 15 Mar 2020 16:49:01 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: the free space cache file is invalid, skip it
To:     Hendrik Friedel <hendrik@friedels.name>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <emfc09a7c5-74d2-4f64-92cc-9a8cffa964e1@ryzen>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <f2e7a222-0f92-a905-bd9c-6a8d1a5a0cd1@dirtcellar.net>
Date:   Sun, 15 Mar 2020 16:49:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
In-Reply-To: <emfc09a7c5-74d2-4f64-92cc-9a8cffa964e1@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

First , I am just a regular btrfs user so take what I say with a grain 
of salt.

However, according to the FAQ here:
https://btrfs.wiki.kernel.org/index.php/FAQ

You should run btrfs check on your filfeystem. This may be a brilliant 
or horrific idea. You probably want to drop your free space cache file 
as well ,but wait until a developer answers if you wanna be on the safe 
side.

If you expect some serious help you should probably post the outputs of 
these commands and state just for the record what distro you are using 
and I am sure you will get help soon (the BTRFS list is very friendly).

uname -a
btrfs --version
btrfs filesystem show /mountpoint
btrfs filesystem usage -T /mountpoint

Hendrik Friedel wrote:
> Hello,
> 
> I see these errors in my syslog:
> 
> Mar 15 00:16:31 homeserver kernel: [524589.677551] BTRFS info (device 
> sdf1): the free space cache file (12785106812928) is invalid, skip it
> Mar 15 00:16:32 homeserver kernel: [524590.494705] BTRFS info (device 
> sdf1): the free space cache file (12787254296576) is invalid, skip it
> Mar 15 00:16:53 homeserver kernel: [524611.371823] BTRFS info (device 
> sdf1): the free space cache file (14405383225344) is invalid, skip it
> Mar 15 00:18:18 homeserver kernel: [524696.803108] BTRFS info (device 
> sdf1): the free space cache file (15598377500672) is invalid, skip it
> Mar 15 00:18:18 homeserver kernel: [524696.935340] BTRFS info (device 
> sdf1): the free space cache file (15613409886208) is invalid, skip it
> Mar 15 00:18:19 homeserver kernel: [524698.074946] BTRFS info (device 
> sdf1): the free space cache file (15643474657280) is invalid, skip it
> Mar 15 00:18:19 homeserver kernel: [524698.074952] BTRFS info (device 
> sdf1): the free space cache file (15643474657280) is invalid, skip it
> Mar 15 00:18:21 homeserver kernel: [524699.353843] BTRFS info (device 
> sdf1): the free space cache file (15663875751936) is invalid, skip it
> Mar 15 00:19:37 homeserver kernel: [524776.142963] BTRFS info (device 
> sdf1): the free space cache file (15062513221632) is invalid, skip it
> Mar 15 00:19:38 homeserver kernel: [524776.307788] BTRFS info (device 
> sdf1): the free space cache file (15065734447104) is invalid, skip it
> Mar 15 00:19:38 homeserver kernel: [524776.549028] BTRFS info (device 
> sdf1): the free space cache file (15070029414400) is invalid, skip it
> Mar 15 00:19:38 homeserver kernel: [524776.675084] BTRFS info (device 
> sdf1): the free space cache file (15071103156224) is invalid, skip it
> Mar 15 00:19:38 homeserver kernel: [524777.004195] BTRFS info (device 
> sdf1): the free space cache file (15076471865344) is invalid, skip it
> Mar 15 00:19:50 homeserver kernel: [524788.446974] BTRFS info (device 
> sdf1): the free space cache file (15559722795008) is invalid, skip it
> Mar 15 00:19:51 homeserver kernel: [524789.965874] BTRFS info (device 
> sdf1): the free space cache file (15570460213248) is invalid, skip it
> Mar 15 00:21:59 homeserver kernel: [524918.102725] BTRFS info (device 
> sdf1): the free space cache file (15064660705280) is invalid, skip it
> Mar 15 00:25:49 homeserver kernel: [525147.576735] BTRFS info (device 
> sdf1): the free space cache file (15564017762304) is invalid, skip it
> Mar 15 00:27:33 homeserver kernel: [525251.725178] BTRFS info (device 
> sdf1): the free space cache file (16411300724736) is invalid, skip it
> 
> a scrub of that drive was finde.
> Also, the stats look good:
> btrfs dev stats /srv/dev-disk-by-label-DataPool1
> [/dev/sdf1].write_io_errs    0
> [/dev/sdf1].read_io_errs     0
> [/dev/sdf1].flush_io_errs    0
> [/dev/sdf1].corruption_errs  0
> [/dev/sdf1].generation_errs  0
> [/dev/sdc1].write_io_errs    0
> [/dev/sdc1].read_io_errs     0
> [/dev/sdc1].flush_io_errs    0
> [/dev/sdc1].corruption_errs  0
> [/dev/sdc1].generation_errs  0
> 
> Is this concerning?
> What should I do?
> 
> Regards,
> Hendrik
> 
