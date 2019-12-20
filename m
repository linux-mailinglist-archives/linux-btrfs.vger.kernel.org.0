Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65DC61274C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 05:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfLTEoB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Dec 2019 23:44:01 -0500
Received: from mail.nethype.de ([5.9.56.24]:43567 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfLTEoB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 23:44:01 -0500
X-Greylist: delayed 915 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2019 23:44:00 EST
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1ii9u8-003Aqr-EV
        for linux-btrfs@vger.kernel.org; Fri, 20 Dec 2019 04:28:44 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1ii9u8-0004A0-6w
        for linux-btrfs@vger.kernel.org; Fri, 20 Dec 2019 04:28:44 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1ii9Xl-0000T8-7C
        for linux-btrfs@vger.kernel.org; Fri, 20 Dec 2019 05:05:37 +0100
Date:   Fri, 20 Dec 2019 05:05:37 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs dev del not transaction protected?
Message-ID: <20191220040536.GA1682@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I used btrfs del /somedevice /mountpoint to remove a device, and then typed
sync. A short time later the system had a hard reset.

Now the file system doesn't mount read-write anymore because it complains
about a missing device (linux 5.4.5):

[  247.385346] BTRFS error (device dm-32): devid 1 uuid f5c3dc63-1fac-45b3-b9ba-ed1ec5f92403 is missing
[  247.386942] BTRFS error (device dm-32): failed to read chunk tree: -2
[  247.462693] BTRFS error (device dm-32): open_ctree failed

The thing is, the device is still there and accessible, but btrfs no longer
recognises it, as it already deleted it before the crash.

I can mount the filesystem in degraded mode, and I have a backup in case
somehting isn't readable, so this is merely a costly inconvinience for me
(it's a 40TB volume), but this seems very unexpected, both that device
dels apparently have a race condition and that sync doesn't actually
synchronise the filesystem - I naively expected that btrfs dev del doesn't
cause the loss of the filesystem due to a system crash.

Probably nbot related, but maybe worth mentioning: I found that system
crashes (resets, not power failures) cause btrfs to not mount the first
time a mount is attempted, but it always succeeds the second time, e.g.:

   # mount /device /mnt
   ... no errors or warnings in kernel log, except:
   BTRFS error (device dm-34): open_ctree failed
   # mount /device /mnt
   magically succeeds

The typical symptom here is that systemd goes into emergency mode on mount
failure, but simpyl rebooting, or executing the mount manually then succeeds.

Greetings,
Marc

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
