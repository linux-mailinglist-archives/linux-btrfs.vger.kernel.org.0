Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 672E416F041
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 21:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbgBYUkJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 15:40:09 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:38887 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgBYUkH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 15:40:07 -0500
Received: by mail-wr1-f44.google.com with SMTP id e8so279697wrm.5
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2020 12:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JK7E0kIr4KZUij9M1JjmwPEonY1lu+WxHb7q6BfsHgY=;
        b=FLPjXDFUwOypLuGl1+5J4ct/jHoNy7eioQVF5YoSEKlhY4OqYx5JfnS7pqOiBMF4zT
         r/rSbme6xEjCs9N8dGVFpZ8oUhlxCsWZlPyqLB6bU4nvCOMmORkwpBIL3wbPr6hbODkH
         j523PDbCgSTfvg3kE9Ph66s1wxV2q0fUTLe5u7Cj7TjKwiobYrGtGhfXwtQH7ggKC7Nz
         kfwxJSE2EFcjfr+SuvkE1Crp2WIGCeoQ0BnTwWUM9G8x8zveDmH5yT41cO8IhVMeNbpN
         bj9m6D9q5GLJJj5rfzhwx9AWjFc4LpIhMd67hTpoklkoNIjzYt4LppuRijio/g1bPeeV
         xBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JK7E0kIr4KZUij9M1JjmwPEonY1lu+WxHb7q6BfsHgY=;
        b=NkrCpUt5ItoAqAG7MKLDT+4hqJxeisTr00RqMabMtQ1agBVNolGqBWNEV8GGGxIRoE
         PUSUB20VwOt3eJ63v0llb3ppl2k9eICR1ArRnyorqIUaVKZDQ0aGNXMslcLrZYgeFCEJ
         EfiLnYrMfk4YxQf/vMqDdymzzx6antLcPuwjNFfDSu3v9awtAuTZsQuPUOXWb6jm8q2n
         xd8HCD9ypkiMyTh8vr1Xv8CQSf68WCXLRCHHtuKj9WJim/WngfGfQziVDrrgPGitA6i1
         GhWOhs+k7b3E/UDWmhM7XSZeFttxoD09p2CDAWThrSmSd6bzrAk1q30ZXQyk0S6LTxrE
         ZJGA==
X-Gm-Message-State: APjAAAWxwn4k11J4SN5T1g3GpKUqJlbdnMZiOE2aH4tzTUVIBGuMecY8
        kLy9a1VOHyLtnhhxnvhYt9RKr7mBGSTBngDbiqFVPo1xeg==
X-Google-Smtp-Source: APXvYqxbK5YJuMomeF9hbz6gLrAFJr02kCFHVk9cOm6ear1nIdSV4cNS5QvRQhpUz754uTBljDXpK0XMCfR0B7EpgAM=
X-Received: by 2002:adf:ed8c:: with SMTP id c12mr872617wro.231.1582663205501;
 Tue, 25 Feb 2020 12:40:05 -0800 (PST)
MIME-Version: 1.0
From:   Jonathan H <pythonnut@gmail.com>
Date:   Tue, 25 Feb 2020 12:39:39 -0800
Message-ID: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
Subject: USB reset + raid6 = majority of files unreadable
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everyone,

Previously, I was running an array with six disks all connected via
USB. I am running raid1c3 for metadata and raid6 for data, kernel
5.5.4-arch1-1 and btrfs --version v5.4, and I use bees for
deduplication. Four of the six drives are stored in a single four-bay
enclosure. Due to my oversight, TLER was not enabled for any of the
drives, so when one of them started failing, the enclosure was reset
and all four drives were disconnected.

After rebooting, the file system was still mountable. I saw some
transid errors in dmesg, but I didn't really pay attention to them
because I was trying to get rid of the now failed drive. I tried to
"btrfs replace" the drive with a different one, but the replace
stopped making progress because all reads to the dead drive in a
certain location were failing (even with the "-r") flag. So I tried
mounting degraded without the dead drive and doing "btrfs dev delete
missing" instead. The deletion failed with the following kernel
message:

[  +2.697798] BTRFS warning (device sdb): csum failed root -9 ino 257
off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 1
[  +0.003381] BTRFS warning (device sdb): csum failed root -9 ino 257
off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 2
[  +0.002514] BTRFS warning (device sdb): csum failed root -9 ino 257
off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 4
[  +0.000543] BTRFS warning (device sdb): csum failed root -9 ino 257
off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 1
[  +0.001170] BTRFS warning (device sdb): csum failed root -9 ino 257
off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 2
[  +0.001151] BTRFS warning (device sdb): csum failed root -9 ino 257
off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 4

I noticed that almost all of the files give an I/O error when read,
and similar kernel messages are generated, but with positive roots. I
also see "read error corrected" messages, but
if I try to read the files again, I the exact same messages are
printed again, which seems to suggest that the errors haven't really
been corrected? (But maybe this is intended behavior.)

I also attempted to use "btrfs restore" to recover the files, but
almost all of the files produce "ERROR: zstd decompress failed Unknown
frame descriptor" and the recovery does not succeed.

Since, then, I have been scrubbing the file system. The first scrub
produce lots of Uncorrectable read errors and several hundred csum
errors. I'm assuming the read errors are due to the missing drive. The
puzzling thing is, the scrub can "complete" (actually, it is aborted
after it completes on all drives but the missing one) and I can delete
all of the files with unrecoverable csum errors, but all of the issues
above persist. I can then turn around scrub again, and the scrub will
find new csum errors, which seems bizarre to me, since I would have
expected them all to be fixed. However, all transid related errors
have disappeared after the first scrub.

I have also tried deleting the file referenced in the device deletion
error and restarting the deletion. This seems to be working, but
progress has been very slow and I fear I'll have to delete all of the
I/O error-producing files above, which I would like to avoid if
possible.

What should I do in this situation and how can I avoid this in the future?

Thanks,
Jonathan
