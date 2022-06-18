Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159EE550686
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jun 2022 20:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiFRS6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Jun 2022 14:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiFRS6P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Jun 2022 14:58:15 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Jun 2022 11:58:12 PDT
Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287386435
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jun 2022 11:58:09 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id 2db8oQ6a1aLeZ2db9oWETA; Sat, 18 Jun 2022 19:55:07 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=D+hUl9dj c=1 sm=1 tr=0 ts=62ae1f8b
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=kj9zAlcOel0A:10 a=kGwieKohNxy_kdwPbdkA:9 a=CjuIK1q_8ugA:10
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     <linux-btrfs@vger.kernel.org>
Subject: Problems with BTRFS formatted disk
Date:   Sat, 18 Jun 2022 19:55:06 +0100
Message-ID: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdiDRDL5GV2kmmenTWWoca+rCFjBtA==
Content-Language: en-gb
Importance: High
X-CMAE-Envelope: MS4xfIwzscCpg40rYY/iIg48egMDdLHhgdkt2BAk5tDidQZT8eM1jDhAB8/YjwDkkAhC7qLWhWtLpUuL4LR7iHvk01QAU7k7qv/iGFRS0mLCg4iEk/HLzRnE
 uFFaKhA6BNP4oVixKmT1LKOtAG7/ycnhYWUlzQqeufAbq1RPshIHhBKJZa9/ZuJ185LyPUNK2Oz/DNzAMUpG30FhRP63M5Gavlw=
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_40,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It all started with a power outage.

When I brought the system back up I got:

Jun 18 15:40:27 charon kernel: BTRFS error (device sdb1): parent transid
verify failed on 12554992156672 wanted 130582 found 127355
Jun 18 15:40:27 charon kernel: BTRFS error (device sdb1): parent transid
verify failed on 12554992156672 wanted 130582 found 127355
Jun 18 15:40:27 charon kernel: BTRFS error (device sdb1): failed to read
block groups: -5
Jun 18 15:40:27 charon mount[629]: mount: /shared: wrong fs type, bad
option, bad superblock on /dev/sdb1, missing codepage or helper program, or
othe>
Jun 18 15:40:27 charon systemd[1]: shared.mount: Mount process exited,
code=exited, status=32/n/a
Jun 18 15:40:27 charon systemd[1]: shared.mount: Failed with result
'exit-code'.
Jun 18 15:40:27 charon systemd[1]: Failed to mount /shared.
Jun 18 15:40:27 charon kernel: BTRFS error (device sdb1): open_ctree failed

I tried:
root@charon:/home/amonra# btrfs check /dev/sdb1
Opening filesystem to check...
parent transid verify failed on 12554992156672 wanted 130582 found 127355
parent transid verify failed on 12554992156672 wanted 130582 found 127355
parent transid verify failed on 12554992156672 wanted 130582 found 127355
Ignoring transid failure
leaf parent key incorrect 12554992156672
ERROR: failed to read block groups: Operation not permitted
ERROR: cannot open file system
root@charon:/home/amonra# btrfs check -s 1 /dev/sdb1
using SB copy 1, bytenr 67108864
Opening filesystem to check...
parent transid verify failed on 12554992156672 wanted 130582 found 127355
parent transid verify failed on 12554992156672 wanted 130582 found 127355
parent transid verify failed on 12554992156672 wanted 130582 found 127355
Ignoring transid failure
leaf parent key incorrect 12554992156672
ERROR: failed to read block groups: Operation not permitted
ERROR: cannot open file system
root@charon:/home/amonra# btrfs check -s 2 /dev/sdb1
using SB copy 2, bytenr 274877906944
Opening filesystem to check...
parent transid verify failed on 12554992156672 wanted 130582 found 127355
parent transid verify failed on 12554992156672 wanted 130582 found 127355
parent transid verify failed on 12554992156672 wanted 130582 found 127355
Ignoring transid failure
leaf parent key incorrect 12554992156672
ERROR: failed to read block groups: Operation not permitted
ERROR: cannot open file system
root@charon:/home/amonra#

but that didn't achieve much.

Following advice I tried: btrfs rescue zero-log which appeared to work, but
attempt to mount afterwards gave me:

Jun 18 18:58:38 charon kernel: BTRFS info (device sdb1): flagging fs with
big metadata feature
Jun 18 18:58:38 charon kernel: BTRFS info (device sdb1): disk space caching
is enabled
Jun 18 18:58:38 charon kernel: BTRFS info (device sdb1): has skinny extents
Jun 18 18:58:39 charon kernel: BTRFS error (device sdb1): parent transid
verify failed on 12554992156672 wanted 130582 found 127355
Jun 18 18:58:39 charon kernel: BTRFS error (device sdb1): parent transid
verify failed on 12554992156672 wanted 130582 found 127355
Jun 18 18:58:39 charon kernel: BTRFS error (device sdb1): failed to read
block groups: -5
Jun 18 18:58:39 charon kernel: BTRFS error (device sdb1): open_ctree failed

In desperation I tried: btrfs check --repair which gave me:

Opening filesystem to check...
parent transid verify failed on 12554992156672 wanted 130582 found 127355
parent transid verify failed on 12554992156672 wanted 130582 found 127355
parent transid verify failed on 12554992156672 wanted 130582 found 127355
Ignoring transid failure
leaf parent key incorrect 12554992156672
ERROR: failed to read block groups: Operation not permitted
ERROR: cannot open file system

So what do I do now?  I don't have a disk large enough to attempt btrfs
restore (if that would even work).  I don't have a backup of this volume as
this is my backup disk.

Thanks 
David










Cheers, David


