Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E435C44FCBD
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 02:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhKOBdY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 20:33:24 -0500
Received: from scadrial.mjdsystems.ca ([192.99.73.14]:52007 "EHLO
        scadrial.mjdsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhKOBdW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 20:33:22 -0500
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Nov 2021 20:33:22 EST
Received: from cwmtaff.localnet (unknown [IPv6:2607:f2c0:ed80:400:9a1:e909:22b4:2b45])
        by scadrial.mjdsystems.ca (Postfix) with ESMTPSA id 0C85281E3545
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Nov 2021 20:23:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed; d=mjdsystems.ca;
        s=202010; t=1636939418;
        bh=qNKukkvlOVQOm7KRanw9MYdP0kz7CnJyF+V1n0xVuJg=;
        h=From:To:Subject:Date:From;
        b=LKcArCIkjk0itD5DdmhAXryWAGK7dhjycTfJd49+HY0kuTiJJAjfSgEaooFlbva/o
         kPK8v3iQDeS2Ui5dOI+EEQ5zJWrDx58Gz9WIWxqsZDIRU63RaxQP9S0LQaFv0dmV4m
         IeG0frQ3mFG16Y7UGK7iQSMWKFXPdAoR1O1VsV1MTq+bxQLq9j0iZ4kTS3GroeisCr
         f+ZXw0vwyJOJLj3R9eYRaa7U4tXnfGYIjwUnkkxks4KdjgoIETg+g2ZeN5a36QLawa
         Rjxvq791x+8qVKmr61+wxwkAb1dYxt+WLASRR9OlGy1qxh3llGXxgUUTzl/d4iL6//
         j57CKiQJQkUPh5CGebtSZq78gV61eXULx2FU01xK1D8xwTVATO+BXytNkPJv+Vo6TJ
         8elwk30+sSR2/ZV/M61J+I51GUI100YGUsMV5mtdxN1iMTIrQV66rdLoGjPIK/OstM
         +p015Q87w6ahdikm2KqT/KhQ7wyRG/sAIzvzyrBZxECS+MCysR1EhWyTl/R0+AQ6/i
         7fkVwqxU7zrp1+JZ/wP8AEVXq1bHbgs8rec7pbC7kRxOtvGnrBe/nPIv646R6+1/E5
         5rZ0fqcb41myea4nBct38kuTQ+ummi7k95ydlg9xzl4eQ07YUB4uRmYJJf08tpNxfa
         hAl7GkxdgKy8tPDdvnpmU7oE=
From:   Matthew Dawson <matthew@mjdsystems.ca>
To:     linux-btrfs@vger.kernel.org
Subject: Help recovering filesystem (if possible)
Date:   Sun, 14 Nov 2021 20:23:34 -0500
Message-ID: <2170643.vFx2qVVIhK@cwmtaff>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

I recently upgrade one of my machines to the 5.15.2 kernel.  on the first 
reboot, I had a kernel fault during the initialization (I didn't get to 
capture the printed stack trace, but I'm 99% sure it did not have BTRFS 
related calls).  I then rebooted the machine back to a 5.14 kernel, but the 
BCache (writeback) cache was corrupted.  I then force started the underlying 
disks, but now my BTRFS filesystem will no longer mount.  I realize there may 
be missing/corrupted data, but I would like to ideally get any data I can off 
the disks.

This system involves 10 8TB disk, some are doing BCache -> LUKS -> BTRFS, some 
are doing LUKS -> BTRFS.

When I try to mount the filesystem, I get the following in dmesg:
[117632.798339] BTRFS info (device dm-0): flagging fs with big metadata feature
[117632.798344] BTRFS info (device dm-0): disk space caching is enabled
[117632.798346] BTRFS info (device dm-0): has skinny extents
[117632.873186] BTRFS error (device dm-0): parent transid verify failed on 
132806584614912 wanted 3240123 found 3240119
[117632.873542] BTRFS error (device dm-0): parent transid verify failed on 
132806584614912 wanted 3240123 found 3240119
[117632.873592] BTRFS warning (device dm-0): couldn't read tree root
[117632.883662] BTRFS error (device dm-0): open_ctree failed

I then tried using rescue=all,ro to mount the filesystem, but got:
[117658.264048] BTRFS info (device dm-0): flagging fs with big metadata feature
[117658.264056] BTRFS info (device dm-0): enabling all of the rescue options
[117658.264057] BTRFS info (device dm-0): ignoring data csums
[117658.264059] BTRFS info (device dm-0): ignoring bad roots
[117658.264060] BTRFS info (device dm-0): disabling log replay at mount time
[117658.264061] BTRFS info (device dm-0): disk space caching is enabled
[117658.264062] BTRFS info (device dm-0): has skinny extents
[117658.286252] BTRFS error (device dm-0): parent transid verify failed on 
132806584614912 wanted 3240123 found 3240119
[117658.286573] BTRFS error (device dm-0): parent transid verify failed on 
132806584614912 wanted 3240123 found 3240119
[117658.286614] BTRFS warning (device dm-0): couldn't read tree root
[117658.294632] BTRFS error (device dm-0): open_ctree failed

Running btrfs check (not repair) to see if it had anything else printed:
parent transid verify failed on 132806546751488 wanted 3240122 found 3239869
parent transid verify failed on 132806546751488 wanted 3240122 found 3239869
parent transid verify failed on 132806571458560 wanted 3240122 found 3239869
parent transid verify failed on 132806571458560 wanted 3240122 found 3239869
parent transid verify failed on 132806571458560 wanted 3240122 found 3239869
parent transid verify failed on 132806571458560 wanted 3240122 found 3239869
Ignoring transid failure
leaf parent key incorrect 132806571458560
Couldn't setup extent tree
ERROR: cannot open file system

Running btrfs restore to see if data could be recovered prints:
parent transid verify failed on 132806584614912 wanted 3240123 found 3240119
parent transid verify failed on 132806584614912 wanted 3240123 found 3240119
parent transid verify failed on 132806584614912 wanted 3240123 found 3240119
parent transid verify failed on 132806584614912 wanted 3240123 found 3240119
Ignoring transid failure
Couldn't setup extent tree
Couldn't setup device tree
Could not open root, trying backup super
warning, device 6 is missing
warning, device 13 is missing
warning, device 12 is missing
warning, device 11 is missing
warning, device 7 is missing
warning, device 9 is missing
warning, device 14 is missing
bytenr mismatch, want=136920576753664, have=0
ERROR: cannot read chunk root
Could not open root, trying backup super
warning, device 6 is missing
warning, device 13 is missing
warning, device 12 is missing
warning, device 11 is missing
warning, device 7 is missing
warning, device 9 is missing
warning, device 14 is missing
bytenr mismatch, want=136920576753664, have=0
ERROR: cannot read chunk root
Could not open root, trying backup super

(All disks are present in the system)

Is there any hope in recovering this data?  Or should I give up on it at this 
point and reformat?  Most of the data is backed up (or are backups 
themselves), but I'd like to get what I can.

Thanks,
-- 
Matthew


