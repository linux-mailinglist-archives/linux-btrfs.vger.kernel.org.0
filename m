Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2659677307
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Jan 2023 23:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjAVWtX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 22 Jan 2023 17:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjAVWtX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Jan 2023 17:49:23 -0500
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Jan 2023 14:49:17 PST
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BCE1714E
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jan 2023 14:49:17 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 01AF43F85A;
        Sun, 22 Jan 2023 23:39:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -0.308
X-Spam-Level: 
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_20,DATE_IN_PAST_03_06,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XPOhor_M37LM; Sun, 22 Jan 2023 23:39:19 +0100 (CET)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id E24333F548;
        Sun, 22 Jan 2023 23:39:18 +0100 (CET)
Received: from [104.28.193.223] (port=59746 helo=[192.168.1.6])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1pJizO-0008Pw-Nv; Sun, 22 Jan 2023 23:39:18 +0100
Date:   Sun, 22 Jan 2023 17:55:00 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <f6963c1.787339ff.185da679725@tnonline.net>
In-Reply-To: <CAN4oSBcsfBPWUc9pwhSrRu5omkP7m8ZUqhFbF-w_DwQJ3Q_aSQ@mail.gmail.com>
References: <CAN4oSBcsfBPWUc9pwhSrRu5omkP7m8ZUqhFbF-w_DwQJ3Q_aSQ@mail.gmail.com>
Subject: Re: Will Btrfs have an official command to "uncow" existing files?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Cerem Cem ASLAN <ceremcem@ceremcem.net> -- Sent: 2023-01-22 - 12:41 ----

> Original post is here: https://www.spinics.net/lists/linux-btrfs/msg58055.html
> 
> The problem with the "chattr +C ..., move back and forth" approach is
> that the VM folder is about 300GB and I have ~100GB of free space,
> plus, I have multiple copies which will require that 300GB to
> re-transfer after deleting all previous snapshots (because there is no
> enough free space on those backup hard disks).
> 
> So, we really need to set the NoCow attribute for the existing files.
> 
> Should we currently use a separate partition for VMs and mount it with
> nodatacow option to avoid that issue?


The issue with nocow, is that it also disables data checksums. This is the reason why btrfs won't allow conversion between nocow and cow, as there is no way to determine if there is data corruption. 

This brings me to the second question. Do you use a filesystem that does data verification (such as btrfs) inside the guest VM? If not, then how do you guarantee the integrity? 

If you do not need data integrity, then it might be useful to use LVM with thin volumes instead of btrfs as your backing storage. 



