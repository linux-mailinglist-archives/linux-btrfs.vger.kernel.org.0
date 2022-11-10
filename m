Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771A7623F87
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 11:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiKJKK6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 05:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKJKK4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 05:10:56 -0500
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 02:10:56 PST
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450951DD
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 02:10:56 -0800 (PST)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 3C9CC405BC
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:14:45 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 58394803775E
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:10:55 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 49C99803775A
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:10:55 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ck1IoiByH79a for <linux-btrfs@vger.kernel.org>;
        Thu, 10 Nov 2022 04:10:55 -0600 (CST)
Received: from [10.4.2.11] (unknown [37.19.198.182])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id E993780368B5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:10:54 -0600 (CST)
Date:   Thu, 10 Nov 2022 05:10:43 -0500
From:   Eric Levy <contact@ericlevy.name>
Subject: trim calls not occurring during device removal operation
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-Id: <VXM4LR.EC4IKXTTFU8W1@ericlevy.name>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I recently removed a device from a filesystem. All the devices in the 
file system were thin-provisioned LUNs. From the LUN manager, I was 
able to monitor the space allocated for each LUN. I noticed that during 
the operation, as the file system consumed increasing amounts of space 
from the other devices (from transferring the data off the one being 
removed), none of the deallocated space was freed on the backend for 
the device targeted for removal. Apparently, the file system was not 
calling a hardware trim operation for freed space.

For physical devices, such behavior might not be problematic. However, 
for logical devices backed on storage with usage approaching capacity, 
it is preferred to free space as soon as possible. If a single 
operation consumes increasing space on the backend but frees none, then 
the space on the backed may become depleted before the operation 
completes.

The file system had been mounted with the `discard` option set to 
`async`. In addition to noticing that the option was not causing trim 
calls to be made during the remove operation, I also noticed that calls 
to the `fstrim` system utility targeting the mounted file system did 
not cause any of the space to be trimmed.

In order to avoid overconsumption of space on the backend, it would be 
helpful to trim space as it is freed on a device targeted for an 
ongoing removal operation. Even if the backend space is not imediately 
needed, freeing the space as part of the removal operation would leave 
the device in a state that clearly signals to the LUN adminstrator that 
the LUN is no longer storing data, and so may be safely destroyed. It 
reduces the chance of data loss by human error if an administrator may 
understand that a LUN may be safely destroyed if and only if it is not 
showing as having allocated space.

Would you consider adding more robust support for trim operations as 
part of device removal?

All of my observations occurred under kernel 5.15.


