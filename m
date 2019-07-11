Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DC366213
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2019 01:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfGKXOt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jul 2019 19:14:49 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:41904 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfGKXOt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jul 2019 19:14:49 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jul 2019 19:14:48 EDT
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-02.dd24.net (Postfix) with ESMTP id 724355FDE9
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2019 23:06:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id v22p-4GrnZAL for <linux-btrfs@vger.kernel.org>;
        Thu, 11 Jul 2019 23:06:35 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-46-244-248-28.dynamic.mnet-online.de [46.244.248.28])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2019 23:06:35 +0000 (UTC)
Message-ID: <e483092adc63d3d86cb99c8e4dcbd56f1d1539b8.camel@scientia.net>
Subject: Re: "btrfs: harden agaist duplicate fsid" spams syslog
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-btrfs@vger.kernel.org
Date:   Fri, 12 Jul 2019 01:06:34 +0200
In-Reply-To: <c01ab9f6-c553-3625-5656-a8f61659de7d@oracle.com>
References: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
         <c01ab9f6-c553-3625-5656-a8f61659de7d@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm also seeing these since quite a while on Debian sid:

Jul 11 13:33:56 heisenberg kernel: BTRFS info (device dm-0): device fsid 60[...]3c devid 1 moved old:/dev/mapper/system new:/dev/dm-0
Jul 11 13:33:56 heisenberg kernel: BTRFS info (device dm-0): device fsid 60[...]3c devid 1 moved old:/dev/dm-0 new:/dev/mapper/system
Jul 11 23:43:35 heisenberg kernel: BTRFS info (device dm-0): device fsid 60[...]3c devid 1 moved old:/dev/mapper/system new:/dev/dm-0
Jul 11 23:43:35 heisenberg kernel: BTRFS info (device dm-0): device fsid 60[...]3c devid 1 moved old:/dev/dm-0 new:/dev/mapper/system

In my case it's a simply dm-crypt layer below the fs.


Some years ago, there was a longer thread on this list about the
fragility of btrfs with respect to accidentally or intentionally
colliding UUIDs.
IIRC there were quite some concerns that this could have even a big
security impact when an attacker e.g. plugs in a device with a certain
UUID and the kernel or userland automatically adds or somehow else uses
such device (just by UUID).
Back then it was said this would be looked into... has anything
happened there?


Cheers,
Chris.

