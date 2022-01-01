Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C0048289B
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jan 2022 22:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiAAV7F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 16:59:05 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:48333 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiAAV7A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Jan 2022 16:59:00 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 9B6AC405B6
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 15:59:44 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 680D88034D34
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 15:58:59 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 579148034D37
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 15:58:59 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wR5Bub7KGHKk for <linux-btrfs@vger.kernel.org>;
        Sat,  1 Jan 2022 15:58:59 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 19B918034D34
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 15:58:59 -0600 (CST)
Message-ID: <59a9506eb880b054f8eff90d5b26ad0c673c7e1f.camel@ericlevy.name>
Subject: Re: parent transid verify failed
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Sat, 01 Jan 2022 16:58:58 -0500
In-Reply-To: <YdDAGLU7M5mx7rL8@hungrycats.org>
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
         <Yc9Wgsint947Tj59@hungrycats.org>
         <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
         <YdDAGLU7M5mx7rL8@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here is the new information:


1) Previously, the system log from R/W mount attempt, which failed:

Dec 31 15:15:48 hostname sudo[1477409]:      user : TTY=pts/0 ; PWD=/home/user ; USER=root ; COMMAND=/usr/bin/mount -o skip_balance /dev/sdc1
Dec 31 15:15:48 hostname sudo[1477409]: pam_unix(sudo:session): session opened for user root by (uid=0)
Dec 31 15:15:48 hostname sudo[1477409]: pam_unix(sudo:session): session closed for user root
Dec 31 15:15:48 hostname kernel: BTRFS info (device sdc1): disk space caching is enabled
Dec 31 15:15:48 hostname kernel: BTRFS error (device sdc1): Remounting read-write after error is not allowed


2) Same, but in RO:

Dec 31 15:14:50 hostname sudo[1477248]:      user : TTY=pts/0 ; PWD=/home/user ; USER=root ; COMMAND=/usr/bin/mount -o skip_balance,ro /dev/sdc1
Dec 31 15:14:50 hostname sudo[1477248]: pam_unix(sudo:session): session opened for user root by (uid=0)
Dec 31 15:14:50 hostname sudo[1477248]: pam_unix(sudo:session): session closed for user root
Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
Dec 31 15:14:50 hostname kernel: BTRFS error (Device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675


3) After running iSCSI logout, and login, the devices were assigned new
names (sdc -> sdf, sdd -> sde). Then checking with readonly flag, using
admin tools, while unmounted:

$ sudo btrfs check --readonly /dev/sdf1
Opening filesystem to check...
Checking filesystem on /dev/sdf1
UUID: c6f83d24-1ac3-4417-bdd9-6249c899604d
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 266107584512 bytes used, no error found
total csum bytes: 259546380
total tree bytes: 586268672
total fs tree bytes: 214188032
total extent tree bytes: 52609024
btree space waste bytes: 89657360
file data blocks allocated: 1019677446144
 referenced 300654301184


4) However, mount still fails. Here is log output from trying to mount
/dev/sdf1:

kernel: BTRFS warning: duplicate device /dev/sdf1 devid 1 generation 9211 scanned by mount (1641108)


5) Same kind of results for /dev/sde:

kernel: BTRFS warning: duplicate device /dev/sde devid 2 generation 9211 scanned by mount (1642247)

