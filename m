Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7562305474
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 08:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhA0HW3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 02:22:29 -0500
Received: from smtp76.ord1d.emailsrvr.com ([184.106.54.76]:38893 "EHLO
        smtp76.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233536AbhA0HRi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 02:17:38 -0500
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2021 02:17:38 EST
X-Auth-ID: a.isaev@rqc.ru
Received: by smtp18.relay.ord1d.emailsrvr.com (Authenticated sender: a.isaev-AT-rqc.ru) with ESMTPSA id 59A62A0148
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 02:08:09 -0500 (EST)
From:   Alexey Isaev <a.isaev@rqc.ru>
Subject: btrfs becomes read-only
To:     linux-btrfs@vger.kernel.org
Message-ID: <cf9189c0-614c-26e8-9d3e-8e18555c064f@rqc.ru>
Date:   Wed, 27 Jan 2021 10:08:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: ru
X-Classification-ID: af5e707b-d7d9-4897-bfe6-5172d4b7ff93-1-1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!

BTRFS volume becomes read-only with this messages in dmesg.
What can i do to repair btrfs partition?

[Jan25 08:18] BTRFS error (device sdg): parent transid verify failed on 
52180048330752 wanted 132477 found 132432
[  +0.007587] BTRFS error (device sdg): parent transid verify failed on 
52180048330752 wanted 132477 found 132432
[  +0.000132] BTRFS error (device sdg): qgroup scan failed with -5

[Jan25 19:52] BTRFS error (device sdg): parent transid verify failed on 
52180048330752 wanted 132477 found 132432
[  +0.009783] BTRFS error (device sdg): parent transid verify failed on 
52180048330752 wanted 132477 found 132432
[  +0.000132] BTRFS: error (device sdg) in __btrfs_cow_block:1176: 
errno=-5 IO failure
[  +0.000060] BTRFS info (device sdg): forced readonly
[  +0.000004] BTRFS info (device sdg): failed to delete reference to 
ftrace.h, inode 2986197 parent 2989315
[  +0.000002] BTRFS: error (device sdg) in __btrfs_unlink_inode:4220: 
errno=-5 IO failure
[  +0.006071] BTRFS error (device sdg): pending csums is 430080

-- 
Best Regards,
Aleksey Isaev,
RQC

