Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E938E1B94AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 02:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgD0ADl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Apr 2020 20:03:41 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:51649 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgD0ADl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Apr 2020 20:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Reply-To:To:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qTTSDwK3vjcdgX17NV60CV+alYQllfB4YiOo/5Ir9qE=; b=jDWNEZBCZSv1RRe8jaWwyzYCKD
        /YP3CfM2yW3i/yBqWQifo1bvt7oabKvTNxumW/v50+Z+Yp+ijv5MzqtSb1M9CbnNvMWywrZhgFUuv
        sPQGWRiCeW/m8EVyos5c8IRcd7v0PXLqC294o3SKj+VJ2OmgQix2svY1XT/WOckLI6alXpo0eqaHp
        8eFQzFlBYP270OIel+dxW0Fc+AiTHTX5fEkKqFofxsolq+pDUNIahMxJ2YlNg/KzhflL+RtaZkhHr
        cQlFA8b61l1TwEaUnDS/SY1LcFX7XbH/gRDR/QNhUpmZ4APr0wyGlMW0rR2PoOLNWcZ7RXqQiLIqk
        MFtDrQFA==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:3994 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1jSrFJ-0001t2-9j
        for linux-btrfs@vger.kernel.org; Mon, 27 Apr 2020 02:03:37 +0200
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Reply-To: waxhead@dirtcellar.net
From:   waxhead <waxhead@dirtcellar.net>
Subject: BTRFS Status wiki
Message-ID: <eec575f0-ec23-655e-488c-fba0223503a0@dirtcellar.net>
Date:   Mon, 27 Apr 2020 02:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Howdy,

Being the random dude that pushed for the status page in the wiki in the 
first place I do have a few suggestion for improvements.

Right now the "status since" column is not very useful, and the table 
does not give any visibility if a feature has "gone sour" over the 
years. e.g. something that was ok in kernel 4.13 might have been working 
great out of pure luck, and may not be recommended to use at all.

Instead of tracking every single kernel release I think it would have 
been good if the status page can focus on the current kernel and the 
last n LTS kernels

I took the liberty of firing up SeaMonkey's composer and did a 10 minute 
(ugly) mockup of my suggestion which can be found here:

http://www.dirtcellar.net/test/BTRFS_alt_status_suggestion.html

For those with URLophobia it essentially is all about trying to 
restructure things a bit - so I am thinking along the lines of something 
like shown below in this mail.

I think something along the lines of what I am suggesting here would 
make it easier to decide if you want to try out things or not - 
especially if you are on a older kernel and not bleeding edge.



Legend:

- Stability tags
* [0] = [Green]  OK (no known bugs)
* [1] = [Yellow] OK mostly (some non fatal issues)
* [2] = [Orange] RISKY (some non-fatal bugs, minimally tested features)
* [X] = [Red]    UNSTABLE (bugs that may ruin the filesystem)

- Other tags
* [P] = [Purple] PERFORMANCE problems - see notes
* [L] = [Blue]   LAYERING issue - see notes


+--------------------+----------+---------+-----------------
| Feature            | LTS 4.19 | LTS 5.4 | Current | Notes
+--------------------+----------+---------+-------------
| Magic feature X    | [X]      | [1]     | [0]     | #1
| Super feature Y    | [2][P]   | [1][P]  | [0][P]  | #2
| Amazing function Z | [2][L]   | [0]     | [0]     | #3

Note
1)
Blah blah

2)
Yada yada

3)
Meh meh...
