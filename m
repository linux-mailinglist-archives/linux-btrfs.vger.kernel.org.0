Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66053623F96
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 11:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiKJKOd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 05:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiKJKOa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 05:14:30 -0500
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F093663C8
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 02:14:28 -0800 (PST)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 042CB405B4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:12:42 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 2139F8037758
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:08:52 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 12848803775A
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:08:52 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3AOBh5wzJfuI for <linux-btrfs@vger.kernel.org>;
        Thu, 10 Nov 2022 04:08:52 -0600 (CST)
Received: from [10.4.2.11] (unknown [37.19.198.182])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id B71C88037758
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:08:51 -0600 (CST)
Date:   Thu, 10 Nov 2022 05:08:44 -0500
From:   Eric Levy <contact@ericlevy.name>
Subject: kernel improvement to support reordering of device list
To:     linux-btrfs@vger.kernel.org
Message-Id: <KUM4LR.0UME6I8K4U963@ericlevy.name>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have been using a file system spanning multiple block devices 
attached to an iSCSI target. Whenever devices are added or removed from 
the target, I must reboot the initiating host. I have not been able 
safely to refresh the device list while the host has mounted devices, 
because each time I change the device configuration and refresh the 
device list, the address of existing devices changes.

While ideally the device list may be refreshed with a guarantee of no 
changes to the address of any existing device, it is possible in 
principle that the file system, with support from the kernel, might 
handle safe maintenance of existing mounts despite changes in device 
ordering. It would require an event propagated to the file system 
notifying about a possible upcoming change to the device list. The file 
system would need to process the event by resolving existing 
transactions, and then suspending I/O operations, until notified that 
the change in the device list had completed. After such notifications, 
the file system would need to scan the new device list, and adjust the 
state of the active mount before resuming processing of queued 
operations.

In such a way, it would be possible for the mount to persist across 
changes in the addresses of the devices included in the mounted file 
system.

Of course, the removal of any device that is part of an existing mount 
must be a failure condition. Even so, the new feature would add 
resilience by isolating transactions from potentially dangerous actions.

Has any discussion arisen for support of such a feature in the kernel 
and file system?


