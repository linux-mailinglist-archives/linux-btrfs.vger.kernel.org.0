Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7663139C
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Nov 2022 12:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKTLTt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 20 Nov 2022 06:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKTLTs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Nov 2022 06:19:48 -0500
Received: from sm-r-002-dus.org-dns.com (sm-r-002-dus.org-dns.com [89.107.70.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B29F6DFF0
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Nov 2022 03:19:47 -0800 (PST)
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
        by smarthost-dus.org-dns.com (Postfix) with ESMTP id 1A703A0BCE
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Nov 2022 12:19:45 +0100 (CET)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
        id 0E291A0C56; Sun, 20 Nov 2022 12:19:45 +0100 (CET)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smarthost-dus.org-dns.com (Postfix) with ESMTPS id B1367A0158;
        Sun, 20 Nov 2022 12:19:44 +0100 (CET)
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 94.31.96.101) smtp.mailfrom=hendrik@friedels.name smtp.helo=[192.168.177.41]
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Paul Jones" <paul@pauljones.id.au>,
        "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re[4]: block group x has wrong amount of free space
Date:   Sun, 20 Nov 2022 11:19:43 +0000
Message-Id: <em53860311-b978-4908-abfd-24b5acca9c5a@7b52163e.com>
In-Reply-To: <SYCPR01MB4685F00E2D2EB81E014D33159E099@SYCPR01MB4685.ausprd01.prod.outlook.com>
References: <em9da2c7f3-31bb-426b-89a3-51fd1dea8968@7b52163e.com>
 <em7df90458-9cac-4818-8a43-0d59e69a14fc@7b52163e.com>
 <ff2940de-babf-d83c-b9d0-1fe8d18909a9@gmx.com>
 <emca736322-38d8-49ca-9c93-083a5bbe946f@7b52163e.com>
 <bcb7a3f2-fa48-1846-e983-2e1ed771275e@gmx.com>
 <em62944e8a-0e4b-4028-ae00-383aac0608ab@7b52163e.com>
 <d7cc9778-9e97-f749-e110-d93a7045e341@gmx.com>
 <em7ed36627-a727-470e-872c-a2af32cdb18d@7b52163e.com>
 <em8aefb52c-4cdc-4cfb-ad52-1c807d8f7756@7b52163e.com>
 <emcca5c139-84cb-403b-af68-e288e31878e3@7b52163e.com>
 <c91c89b4-58e6-526a-bfb8-fb332e792cc3@gmx.com>
 <em6eb00339-18ce-4f15-8b9d-da8058301e72@7b52163e.com>
 <5fcf68ec-836a-3517-289d-bb77527468f7@gmx.com>
 <ema0c172ea-7620-4949-8f89-1504aaf516ca@7b52163e.com>
 <SYCPR01MB4685F00E2D2EB81E014D33159E099@SYCPR01MB4685.ausprd01.prod.outlook.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-PPP-Message-ID: <166894320706.31607.4799699414340934766@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
>This indicates you have a physical problem with your disk - I would try swapping the cables. Try and fix this before you do anything else.
>
Yes, I think so, too and I will work on this.
What I do not understand:
Why does BTRFS not cope with this without filesystem errors? I mean: I 
have two drives. BTRFS should mark this one bad and continue with the 
other.

Is this expected behaviour?

Best regards,
Hendrik


>

