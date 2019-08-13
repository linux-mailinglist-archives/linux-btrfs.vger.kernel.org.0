Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457AD8B48D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 11:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfHMJsw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 05:48:52 -0400
Received: from mail1.arhont.com ([178.248.108.111]:33712 "EHLO
        mail1.arhont.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfHMJsv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 05:48:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id C1D5D360067
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2019 10:48:48 +0100 (BST)
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1jEw8wH24Jr9 for <linux-btrfs@vger.kernel.org>;
        Tue, 13 Aug 2019 10:48:47 +0100 (BST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id DB13B36008B
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2019 10:48:46 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail1.arhont.com DB13B36008B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arhont.com;
        s=157CE280-B46F-11E5-BB22-6D46E05691A3; t=1565689726;
        bh=mMwP2t3LQj7pC1I/Qd4mqaGFNtxlVA7HTjmES97jQSA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=U6ohS+daVekRfLoU0KSZ5qgeewj27+rPgO63Zf6Ou+tMfTSPatD0rFCXy0Crj1QC/
         f6ZXEIEwKQudxHBsjwzk38vOvTeCIayx2plO0lYRC5HgJUYdnTxKE6bCBxVso8u1C4
         7rMWX3RjWlcL25RFLS3uML+YnIfnuFGzj7pfEIsY=
X-Virus-Scanned: amavisd-new at arhont.com
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IzqeG9LoDMQg for <linux-btrfs@vger.kernel.org>;
        Tue, 13 Aug 2019 10:48:46 +0100 (BST)
Received: from mail1.arhont.com (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id A408B360067
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2019 10:48:46 +0100 (BST)
Date:   Tue, 13 Aug 2019 10:48:46 +0100 (BST)
From:   "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <347523577.41.1565689723208.JavaMail.gkos@xpska>
In-Reply-To: <632175948.36.1565689408284.JavaMail.gkos@xpska>
Subject: btrfs errors
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3803 (Zimbra Desktop/7.3.1_13063_Linux)
Thread-Index: eq7c5ilmqhTw03ljmcizp5gHFjLgwQ==
Thread-Topic: btrfs errors
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi list

I have run the btrfs check, and that reported multiple errors on the FS.

# btrfs check --readonly --force /dev/kubuntu-vg/lv_root
<SKIP>
root 9214 inode 6850330 errors 2001, no inode item, link count wrong
        unresolved ref dir 266982 index 22459 namelen 36 name 9621041045a17a475428a26fcfb5982f.png filetype 1 errors 6, no dir index, no inode ref
        unresolved ref dir 226516 index 9 namelen 28 name GYTSPMxjwCVp8kXB7+j91O8kcq4= filetype 1 errors 4, no inode ref
root 9214 inode 6877070 errors 2001, no inode item, link count wrong
        unresolved ref dir 226516 index 11 namelen 28 name VSqlYzl4pFqJpvC3GA9bQ0mZK8A= filetype 1 errors 4, no inode ref
root 9214 inode 6878054 errors 2001, no inode item, link count wrong
        unresolved ref dir 266982 index 22460 namelen 36 name 52e74e9d2b6f598038486f90f8f911c4.png filetype 1 errors 4, no inode ref
root 9214 inode 6888414 errors 2001, no inode item, link count wrong
        unresolved ref dir 226391 index 122475 namelen 14 name the-real-index filetype 1 errors 4, no inode ref
root 9214 inode 6889202 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 9214 inode 6889203 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
ERROR: errors found in fs roots
found 334531551237 bytes used, error(s) found
total csum bytes: 291555464
total tree bytes: 1004404736
total fs tree bytes: 411713536
total extent tree bytes: 242974720
btree space waste bytes: 186523621
file data blocks allocated: 36730163200
 referenced 42646511616


However, scrub and badblock find no errors.

# btrfs scrub status /mnt/
scrub status for 7b19fb5e-4e16-4b62-b803-f59364fd61a2
        scrub started at Tue Aug 13 07:31:38 2019 and finished after 00:02:47
        total bytes scrubbed: 311.15GiB with 0 errors

# badblocks -sv /dev/kubuntu-vg/lv_root 
Checking blocks 0 to 352133119
Checking for bad blocks (read-only test):  done                                                 
Pass completed, 0 bad blocks found. (0/0/0 errors)

# btrfs dev stats /dev/kubuntu-vg/lv_root                                                                                                                                                       
[/dev/mapper/kubuntu--vg-lv_root].write_io_errs    0
[/dev/mapper/kubuntu--vg-lv_root].read_io_errs     0
[/dev/mapper/kubuntu--vg-lv_root].flush_io_errs    0
[/dev/mapper/kubuntu--vg-lv_root].corruption_errs  0
[/dev/mapper/kubuntu--vg-lv_root].generation_errs  0



FS mount fine, and is operational.
would you recommend executing the btrfs check --repair option or is there something else that I can try.

#  uname -a                                                                                                                                                                                         Linux xps 5.1.16-050116-generic #201907031232 SMP Wed Jul 3 12:35:21 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
# btrfs --version                                                                                                                                                                               
btrfs-progs v4.15.1


mount options
on / type btrfs (rw,relatime,compress-force=lzo,ssd,discard,space_cache=v2,autodefrag,subvol=/@)

thanks,
Konstantin
