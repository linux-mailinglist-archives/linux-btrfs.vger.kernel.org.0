Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A55690460
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 11:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBIKCO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 9 Feb 2023 05:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBIKCL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 05:02:11 -0500
X-Greylist: delayed 932 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Feb 2023 02:02:09 PST
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702722CFF6
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 02:02:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id EBD213FB4C
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 10:46:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -0.9
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_40,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5Iy6EKlgAeaS for <linux-btrfs@vger.kernel.org>;
        Thu,  9 Feb 2023 10:46:34 +0100 (CET)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 4C3DF3F363
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 10:46:34 +0100 (CET)
Received: from [104.28.193.223] (port=14860 helo=[10.99.201.44])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1pQ3Vh-000FY8-MX
        for linux-btrfs@vger.kernel.org; Thu, 09 Feb 2023 10:46:33 +0100
Date:   Thu, 9 Feb 2023 10:46:32 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     linux-btrfs@vger.kernel.org
Message-ID: <e99483.c11a58d.1863591ca52@tnonline.net>
Subject: Automatic block group reclaim not working as expected?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have set set /sys/fs/btrfs/<uuid>/allocation/data/bg_reclaim_threshold to 75

It seems that the calculation isn't correct as I can see chunks with 300-400% usage in dmesg, which obviously seems wrong.

The filesystem is a raid10 with 10 devices.

dmesg:
[865863.062502] BTRFS info (device sdi1): reclaiming chunk 35605527068672 with 369% used 0% unusable
[865863.062552] BTRFS info (device sdi1): relocating block group 35605527068672 flags data|raid10
[865892.749204] BTRFS info (device sdi1): found 5729 extents, stage: move data extents
[866217.588422] BTRFS info (device sdi1): found 5721 extents, stage: update data pointers

I have tested with kernels 6.1.6 and 6.1.8
