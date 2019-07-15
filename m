Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC68697CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2019 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfGOPND (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 11:13:03 -0400
Received: from mail.render-wahnsinn.de ([176.9.37.177]:44740 "EHLO
        mail.render-wahnsinn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732036AbfGOPND (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 11:13:03 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jul 2019 11:13:02 EDT
Received: from localhost (localhost [127.0.0.1])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1563202980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L8N8pYcl5SVYs7zMSuOGvNXiKnYa1D+pGJ93tCU92fk=;
        b=SMEq9Tpvi39pmnM6QaWKezHY7Tm9J3nXNsCPoqVhVC7sgCwxCnGPRIQD0iWoWzwtFphRe3
        x5SJzVKNiXa+KSYh/EbUzQ7i5/VGpmO65SdKUlcNoTjXZofZqnPf6D8IZjkJyMz9YYExZB
        M8mYpDZS7CADbeonRMb33gA1N+F1OUmBTxSZKETcokrN9Vv7E93fRjdDI7+8tkLwGL77Nr
        VBFVCzBzWR+qIkIFcwz1uGSqnliS4gw287S99a+swVX4flNk+062utCDcZsk5dE80JNBUe
        w6fxHEp+18A56IkI8Ly9leg9mpM3Y5K4jMN9oV/iwsWD8CmU17M3T131axTfrw==
Message-ID: <6f5f659ce3967c7cef2c6f8f9c07e8be8e5a2a70.camel@render-wahnsinn.de>
Subject: Best Practices (or stuff to avoid) with Raid5/6 ?
From:   Robert Krig <robert.krig@render-wahnsinn.de>
To:     linux-btrfs@vger.kernel.org
Date:   Mon, 15 Jul 2019 17:02:58 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=render-wahnsinn.de; s=dkim; t=1563202980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L8N8pYcl5SVYs7zMSuOGvNXiKnYa1D+pGJ93tCU92fk=;
        b=FlExIz3X9iEAzKMHhCEGjnK/yTsmxJA3kSvRPOp9DhRGd3jHMCOTG4rC7DqOcvEEVKUzEL
        +uMnhueuORc2HjdLTjA+w6W7onZB1BH2pDTP4fMp29Hb7wKW0HhZA6Y6XxtFuI0xnN/Y9Q
        GW3h8bMTEDa8YGYmz9f9K1OiM/+wVVKKVg/1D+ajPPMY2AyHSGgGV+rUh+nnnu/2AMlRSd
        HcEybWSTpsb2rx6Om2jyYNn+fEjNlcFy6zleGlB85QKxnBak2ANJy0eFXpcWj8V2SmPoAq
        C3JlxQgQI3PSrCRoHwGtv+HkEoXmXu8AUILrZsoHKc4pNW9PVox/nCdEpO7JlA==
ARC-Seal: i=1; s=dkim; d=render-wahnsinn.de; t=1563202980; a=rsa-sha256;
        cv=none;
        b=Tz++zDjvjI0lVcIoudlKzdXjLHeIhVNFOu9KT/yR0nwQhWK+61GXu3dT58JI2AOZ7Y6378
        wK3M3TuQUYxNJtb/JtIswZBzdizw0h0KhAO/GI97h0cqRpLl11L+SJDhRBzpi2+exY4MTQ
        n2Zzc5EM0ZkfoLsN0t9Mq0JMk3DV8B7Cb3Pfyr8/lyG6Yd/nWP8oK7cmT4OwwPUXWLy7xe
        18uqspr4MY/42IoTa8KteUf6QmIxyEWbmDHUwMElxmbxleqP4PSANah5wCMNh85KcqqgdK
        OxNVE3Zed5K2N+RbS1qhijRenXsMyULOeKMRALx2nXN8B8v/wG+nVecTg47feg==
ARC-Authentication-Results: i=1;
        mail.render-wahnsinn.de;
        auth=pass smtp.mailfrom=robert.krig@render-wahnsinn.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi guys. 
I was wondering, are there any recommended best practices when using
Raid5/6 on BTRFS?

I intend to build a 4 Disk BTRFS Raid5 array, but that's just going to
be as a backup for my main ZFS Server. So the data on it is not
important. I just want to see how RAID5 will behave over time.

That being said, are there any recommended best practices when
deploying btrfs with raid5?

According to the wiki a good recommendation seems to be to have
metadata as RAID1 and data as RAID5.

Other than that, are there any mount options which should be used or
completely avoided when using raid5/6? (autodefrag,commit=,...)

Anything to consider when using realtime compression? 
Balancing issues? e.g. should you always do a full balance (when you
decide you need one)?

Whats the best/proper way to replace a failing disk? What about a
sudden faulty disk? e.g. won't spin up anymore. Just use btrfs replace
as it says in the wiki?

Thanks guys.




