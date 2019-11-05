Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F1BEF26B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 02:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfKEBDq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 20:03:46 -0500
Received: from mail.virtall.com ([46.4.129.203]:57484 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728602AbfKEBDq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 20:03:46 -0500
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id 3EB6337F5669;
        Tue,  5 Nov 2019 01:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1572915822; bh=2ppHHc9ZcJRCGNKaPPvXBX0Gc5gdSSE3OnP2x3/KAaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=jQ7iRYdxEAAfbwDwwdTEIthP7C4S8qkQQvKvj663bYI3ypaaoFGVnooxsI+KvsYi3
         FYbKlPQ/Ijp7Gej65VFwweOSIOB7CsDVAJyGXrSTdEe6cVWdo4BWseYQBgYbK/tIqz
         kUkR3piC/gMUKdIVU0YbAZ6BNNodmlpTiHSLpcRE2F5RfI2xgn/TdQ2qUl6K9rz7Pm
         eFCb5Uh3IXgXM4gPfk79v0gm9EqEAdd/0G5PuxvwKAt/1oeVx0VRD+TfqPPtF6zbrZ
         TPqqCNQ3dDGzlDcitrOvt/lxgwytb+92iagUHYIx4Qk0sXUkMzzGUfJXtdc43gz8zd
         KXAeOffusDh5Q==
X-Fuglu-Suspect: 2128e83a2d9045b98c1b022d2044d063
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA;
        Tue,  5 Nov 2019 01:03:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Nov 2019 10:03:41 +0900
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: CPU: 6 PID: 13386 at fs/btrfs/ctree.h:1593
 btrfs_update_device.cold+0x10/0x1b [btrfs]
In-Reply-To: <c44c5868-6351-4d38-de12-c7903b64a441@gmx.com>
References: <0a25bc52b9d3649d499b76d06e0d117b@wpkg.org>
 <d24256c7-4398-7627-4352-1878af1467e9@gmx.com>
 <94c49648ea714dcd1f087f24ee796115@wpkg.org>
 <c44c5868-6351-4d38-de12-c7903b64a441@gmx.com>
Message-ID: <1e6ad65de01b6808bf9acf781e55dd47@wpkg.org>
X-Sender: mangoo@wpkg.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-11-05 09:52, Qu Wenruo wrote:

>> Now let's try to unmount and see what "btrfs rescue fix-device-size"
>> shows again - I'd expect "No device size related problem found", 
>> correct?
>> 
>> 
>> # umount /home
>> 
>> # btrfs rescue fix-device-size /dev/sda4
>> parent transid verify failed on 265344253952 wanted 42646 found 46119
>> parent transid verify failed on 265344253952 wanted 42646 found 46119
>> parent transid verify failed on 265344253952 wanted 42646 found 46119
> 
> This is not correct. What happened during your /home mount and unmount?
> 
> The fs looks already screwed up.

Nothing happened - it normally mounts/unmounts without errors.

Also scrub works without issues (a few days ago):

# btrfs scrub status /home
UUID:             c94ea4a9-6d10-4e78-9b4a-ffe664386af2
Scrub started:    Sat Nov  2 01:14:17 2019
Status:           finished
Duration:         0:55:23
Total to scrub:   1.17TiB
Rate:             368.41MiB/s
Error summary:    no errors found


It also no longer shows "parent transid verify failed" after a few more 
cycles like this:

# umount /home

# btrfs rescue fix-device-size /dev/sda4
parent transid verify failed on 265344253952 wanted 42646 found 46119
parent transid verify failed on 265344253952 wanted 42646 found 46119
parent transid verify failed on 265344253952 wanted 42646 found 46119
Ignoring transid failure
Fixed super total bytes, old size: 7901711842304 new size: 7901711835136
Fixed unaligned/mismatched total_bytes for super block and device items

# btrfs rescue fix-device-size /dev/sda4
No device size related problem found

# mount /home ; sync ; umount /home

# btrfs rescue fix-device-size /dev/sda4
parent transid verify failed on 265344253952 wanted 42646 found 46119
parent transid verify failed on 265344253952 wanted 42646 found 46119
parent transid verify failed on 265344253952 wanted 42646 found 46119
Ignoring transid failure
Fixed super total bytes, old size: 7901711842304 new size: 7901711835136
Fixed unaligned/mismatched total_bytes for super block and device items

# mount /home ; sync ; umount /home

# btrfs rescue fix-device-size /dev/sda4
No device size related problem found

# btrfs rescue fix-device-size /dev/sda4
No device size related problem found

# mount /home ; sync ; umount /home

# btrfs rescue fix-device-size /dev/sda4
No device size related problem found

# btrfs rescue fix-device-size /dev/sdb4
No device size related problem found

# mount /home

# date > /home/date.txt

# umount /home

# btrfs rescue fix-device-size /dev/sdb4
No device size related problem found



Tomasz Chmielewski
https://lxadm.com
