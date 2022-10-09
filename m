Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2DB5F8AC9
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Oct 2022 13:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiJILDo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Oct 2022 07:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJILDm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Oct 2022 07:03:42 -0400
Received: from spamschutz.webhoster.de (spamschutz.webhoster.de [212.172.221.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C35F2528F
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 04:03:40 -0700 (PDT)
Received: from mail.psa14.webhoster.ag ([195.63.61.219] helo=admiralbulli.de)
        by spamschutz.webhoster.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <admiral@admiralbulli.de>)
        id 1ohU5g-000RWl-5q
        for linux-btrfs@vger.kernel.org; Sun, 09 Oct 2022 13:03:32 +0200
Received: from Areion (ipbcc08fe0.dynamic.kabel-deutschland.de [188.192.143.224])
        (Authenticated sender: admiral@admiralbulli.de)
        by psa14.webhoster.ag (Postfix) with ESMTPSA id 5745E7027F8
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 13:03:34 +0200 (CEST)
From:   <admiral@admiralbulli.de>
To:     <linux-btrfs@vger.kernel.org>
Subject: BTRFS w/ quotas hangs on read-write mount using all available RAM -
 rev2
Date:   Sun, 9 Oct 2022 13:03:34 +0200
Message-ID: <133101d8dbce$c666a030$5333e090$@admiralbulli.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdjbzjGOl3AzpYGpRVmjXf9GHWaJgg==
Content-Language: de
X-PPP-Message-ID: <166531341482.1476998.5084857419601342087@psa14.webhoster.ag>
X-PPP-Vhost: admiralbulli.de
X-Originating-IP: 195.63.61.219
X-iStore-Domain: admiralbulli.de
X-iStore-Username: 
Authentication-Results: webhoster.de; auth=pass (plain) smtp.auth=@admiralbulli.de
X-iStore-Outgoing-Class: ham
X-iStore-Outgoing-Evidence: Combined (0.11)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+10hxVIV3mK1xyOlRXz6nIPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5ztW2DfCmdqRCMoho/8w6SaWy8Zi3U/W0AnUgWIBqewEKvp
 k7Vp2UXVHEQMIct0liI45dkoJ1g6vFd52DfQ79G4swKQDamPN66SYe4XX4xmgHpumUehsM559QqW
 FFoBA9ZZ82GRisxPmPRTeC38EWDVqr/s5zF19+UXUogLDrjW+VLc3H0jP45f5X3qB4WPL3ODwIE7
 VKe+bqpcdCns72R1lS2rsvbM48KtAYuafMoHXgMOM8AjFc2Mlq2e+vr61EnBPeWxfLTyo52lpUOn
 40xHoOAmb0xgXrrQKITtclJwwgEWSXSs+rtFDTCy3oL7i3cDFPZI3xOxBaPpD+a4iBFJsVNNUIbs
 Z7IUm5ep8Wy2d+f8WNLr6FgRDn86t0RtvMCO8OL3MKmWpyx7GTPK+LOWY5R6BpcvGp3jcY/qUcse
 gwpMsSu5ym64kNjdWJnNgLKQg/grtJdXoEcgtrkTMdhrJLFZV2VsWrEXxYzPJvIeyCEnVSsgPP/M
 gqSGMx92qX+/Ib/3gD1xdv4OjYexFN7irTewnrFbPU7PCf8oqOmnTgbaykvg0omtYBj1nosLf015
 WoZ+lPuoe+u6j3Pohj85B5hQ6nsDvccjqgmDvD9Whxx8gXHSKRwJ0JD+dlHFPj42KirgeViAp2PJ
 jzfDplFOay8MnlNTR6NsYlc6yMrSFDA5svc9/3FBml+NRjJSjtOcTD53rSwSTIedTYkUaByAeIvy
 2XI3Pq5ORLZ1gI2j55oiu8eNlY3cwoWTHujvw4mOK/4I4n8vyJdfqYgH0VN0TDHtCCknrGVMF89u
 6C1TQ+VWhkbOqULHLrD8UvEFkiAf+9UC6dgzRPgUcOh8WLtt3jR5NeVaJQBh0uawl0Cg8vug2b7T
 AIvbzEx4v/6tWJnGj6GDxFqp5y6IuJSYFp1AtgffC23R81gLiCRGg3bfHxEvVIn6jMhOiUH5AcIh
 x9cxL7hrJSk60SF3F6RYOYr2
X-Report-Abuse-To: spam@spamschutz.webhoster.de
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear btrfs team,
thanks for all your great work!
I have been running btrfs now for several years and really like the
robustness and ease of use!

Last week I experienced 99% the same thing as described here by Loren M.
Lang:
https://www.spinics.net/lists/linux-btrfs/msg81173.html
only difference: This is not my / but a 40TB storage mounted to
/media/btrfs1/

quick summary what happend:
- enabled quotas to better understand where all my space has gone
- started balancing
- system got completely stuck due to the meanwhile well understood reasons
- pushed reset button

I can mount my btrfs system perfectly read-only and access the data. As soon
as I try to mount rw, my system will exremely slow down, memory will fill up
until I will finally end up with a panicking kernel.

So, no problem to successfully boot with the fstab entries on ro or
commented out.

   admiral@server:/$ uname -a
   Linux server.domain.loc 4.19.0-21-amd64 #1 SMP Debian 4.19.249-2
(2022-06-30) x86_64 GNU/Linux

   admiral@server:/$ btrfs --version
   btrfs-progs v5.10.1

Here the question:
I am looking for the option to disable quota on an unmounted btrfs like
described here:
https://patchwork.kernel.org/project/linux-btrfs/patch/20180812013358.16431-
1-wqu@suse.com/

All my trials and checks et cetera were performed with btrfs-progs v4.20.1-2
as debian buster's latest state:
https://packages.debian.org/de/buster/btrfs-progs

I already upgraded the btrfs-progs to debian backport v5.10.1 but do not
find any option to offline disable quota, yet:
https://packages.debian.org/buster-backports/btrfs-progs

Can you point me some direction how to move forward to recover the btrfs?

Thanks a lot,

admiralbulli

