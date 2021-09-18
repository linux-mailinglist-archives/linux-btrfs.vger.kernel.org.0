Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2E24108BD
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Sep 2021 23:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbhIRVkX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 18 Sep 2021 17:40:23 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:21578 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbhIRVkX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Sep 2021 17:40:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id A2A663F6D0
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Sep 2021 23:38:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -0.5
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 tagged_above=-999 required=6.31
        tests=[BAYES_05=-0.5] autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uNBTjAqxjVWN for <linux-btrfs@vger.kernel.org>;
        Sat, 18 Sep 2021 23:38:54 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id C37113F623
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Sep 2021 23:38:54 +0200 (CEST)
Received: from [192.168.0.126] (port=42732)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mRi2w-000GXH-24
        for linux-btrfs@vger.kernel.org; Sat, 18 Sep 2021 23:38:54 +0200
Date:   Sat, 18 Sep 2021 23:38:54 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <9809e10.87861547.17bfad90f99@tnonline.net>
Subject: Select DUP metadata by default on single devices.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everyone,

I'd like to revisit the topic I opened on Github(*) a year ago, where I suggested that DUP metadata profile ought to be the default choice when doing mkfs.btrfs on single devices. 

Today we have much better write endurance on flash based media so the added writes should not matter in the grand scheme of things. Another factor is disk encryption where mkfs.btrfs cannot differentiate a plain SSD from a luks/dm-crypt device. Encryption effectively removes the possibility for the SSD to dedupe the metadata blocks. 

Ultimately, I think it is better to favour defaults that gives most users better fault tolerance, rather than using SINGLE mode for everyone because of the chance that some have deduplicating hardware (which would potentially negate the benefit of DUP metadata). 

One remark against DUP has been that both metadata copies would end up in the same erase block. However, I think that full erase block failures are in minority of the possible failure modes, at least from what I've seen on the mailing list and at #btrfs. It is more common to have single block errors, and for those we are protected with DUP metadata. 

Zygo made a very good in-depth explanation about several different failure modes in the Github issue. 

I would like voice my wish to change the defaults to DUP metadata on all single devices and I hope that the developers now can find consensus to make this change. 

* https://github.com/kdave/btrfs-progs/issues/319

Thanks. 

~ Forza 
