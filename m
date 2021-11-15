Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B615D44FCD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 02:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhKOBz3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 20:55:29 -0500
Received: from scadrial.mjdsystems.ca ([192.99.73.14]:47201 "EHLO
        scadrial.mjdsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhKOBz2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 20:55:28 -0500
Received: from cwmtaff.localnet (unknown [IPv6:2607:f2c0:ed80:400:9a1:e909:22b4:2b45])
        by scadrial.mjdsystems.ca (Postfix) with ESMTPSA id C0B4C81E3855
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Nov 2021 20:52:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed; d=mjdsystems.ca;
        s=202010; t=1636941152;
        bh=qNKukkvlOVQOm7KRanw9MYdP0kz7CnJyF+V1n0xVuJg=;
        h=From:To:Subject:Date:From;
        b=oj8AyNn4xAYZiS0M9F4VR44nSHE8986PbOcxWQwADqpLMtF6AQtdMSoy6XHjWhogd
         31K9G7+MKwwWNoQMsJzDXFEBol8lQJre+d5/j0WZ832HE4tZfmSdPyvhlaeom+O/9K
         +0Nz5xAEP+jcsMUHeT4pQBmQGrlwUE5MiIjhffVXqeBzCGVzbPdB9JRhyLRYtBWU/I
         6x0HYLyPj8bSa9Wh/S7IGndOsczfasbKfgAH5qvgYkuc5ukwzcYq1Yx70Ou/K4H/nQ
         +/USh2LQmTIK/KNLr4n9oi+jsmpcMbDxBI9JySU4o548W1xNHYKniSTcEPcwzY/XvT
         SsitxTeEy35x8DslYm1T/REcYtqkqMLTYwZQtseC7TrEF+bd772xnj+BxdrrZjsF7e
         QQhWdpAaum3o+MrJhs2//J8lLqhf+Cu8VrsHdVbyNLMSJVngKsnkVmRFs1ALrKXpq9
         00s4oEGOSFNtIeWiSzri9pp60tKnE0iI2gEWWFXrhmN3AkcWNBaBWRRBdkg6MqZtVe
         gNgz2UxA96Jm6wu99XP8LT0Op4HYfICbvBvDXTDucwxMmxkmqX4LfSuOcGBBqkbriA
         3ZXIIhQp5Yvu5raJFZSzNc+Nb/HMOPA+Y+rPvl2rF1D251HrjPza9o8rWrNfhQvKjv
         lyspWh3RDMFx1LlbLLXspeyQ=
From:   Matthew Dawson <matthew@mjdsystems.ca>
To:     linux-btrfs@vger.kernel.org
Subject: Help recovering filesystem (if possible)
Date:   Sun, 14 Nov 2021 20:52:32 -0500
Message-ID: <2586108.vuYhMxLoTh@cwmtaff>
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


