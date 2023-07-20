Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D875A3D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 03:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGTBVz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 21:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTBVy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 21:21:54 -0400
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 18:21:53 PDT
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DADB1FD7
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 18:21:53 -0700 (PDT)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id A4E0940569
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 20:23:54 -0500 (CDT)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 9B10E8037790
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 20:14:10 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 8B0968036FC3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 20:14:10 -0500 (CDT)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 05yRbx86Hge6 for <linux-btrfs@vger.kernel.org>;
        Wed, 19 Jul 2023 20:14:10 -0500 (CDT)
Received: from [10.4.2.11] (unknown [191.96.227.24])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 779628037792
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 20:14:08 -0500 (CDT)
Date:   Wed, 19 Jul 2023 21:13:59 -0400
From:   Eric Levy <contact@ericlevy.name>
Subject: RAID mount fails after upgrading to kernel  6.2.0
To:     linux-btrfs@vger.kernel.org
Message-Id: <B3M2YR.U71TM7CWM1P12@ericlevy.name>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_20,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I recently performed a routine update on a Linux Mint system, version 
21.2 (Victoria). The update moved the kernel from 5.19.0 to 6.2.0. The 
system includes a non-root mount that is Btrfs with RAID, which no 
longer mounts. Error reporting is rather limited and opaque.

I am assuming the file system is healthy from the standpoint of the old 
kernel, but I may need help understanding how to make it viable for the 
new one.

Mounting from the command line prints the following:

mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdg, 
missing codepage or helper program, or other error.

The following is extracted from the boot sequence recorded in the 
kernel ring:

kernel: BTRFS error: device /dev/sdd belongs to fsid 
c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already mounted
kernel: BTRFS error: device /dev/sdf belongs to fsid 
c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already mounted
kernel: BTRFS info (device sde): using crc32c (crc32c-intel) checksum 
algorithm
kernel: BTRFS info (device sde): turning on async discard
kernel: BTRFS info (device sde): disk space caching is enabled
kernel: BTRFS error (device sde): devid 7 uuid 
2f62547b-067f-433c-bec1-b90e0c8cb75e is missing
kernel: BTRFS error (device sde): failed to read the system array: -2
kernel: BTRFS error (device sde): open_ctree failed
mount[969]: mount: /mnt: wrong fs type, bad option, bad superblock on 
/dev/sde, missing codepage or helper program, or other error.
systemd[1]: mnt.mount: Mount process exited, code=exited, status=32/n/a




