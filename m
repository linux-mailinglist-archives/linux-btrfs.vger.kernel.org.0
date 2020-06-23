Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B82C204BCF
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 10:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbgFWIAM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 04:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731296AbgFWIAM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 04:00:12 -0400
X-Greylist: delayed 21026 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Jun 2020 01:00:12 PDT
Received: from smtp.sws.net.au (smtp.sws.net.au [IPv6:2a01:4f8:140:71f5::dada:cafe])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1CDC061573
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jun 2020 01:00:12 -0700 (PDT)
Received: from liv.localnet (unknown [103.75.204.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: russell@coker.com.au)
        by smtp.sws.net.au (Postfix) with ESMTPSA id EE14513C3B
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jun 2020 18:00:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
        s=2008; t=1592899209;
        bh=RVk+jabm0bRaInHIpGwrtbFPn8Q6W7YYboS6N7+hjsU=; l=4197;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=xVvFFvdhQFmY3kb8sqJg45q/nfodFKqrNenfr8j+dVXxoY+D4USw1jYbUmYiFNOe0
         qyTI1Y7zp4U48cv4Lv1d0mFIk98umJkZVHenI0dusl2JVGQ1+9rEs3yYu9TycU7Zwr
         du/ME8oW9SmNYsU6PnK9NGAmaDN4CsdiRE4fqpF8=
From:   Russell Coker <russell@coker.com.au>
To:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs dev sta not updating
Date:   Tue, 23 Jun 2020 18:00:05 +1000
Message-ID: <5752066.y3qnG1rHMR@liv>
In-Reply-To: <08121825-9c05-87c4-4015-f6f508193fa8@suse.com>
References: <4857863.FCrPRfMyHP@liv> <08121825-9c05-87c4-4015-f6f508193fa8@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tuesday, 23 June 2020 4:03:37 PM AEST Nikolay Borisov wrote:
> > I have a USB stick that's corrupted, I get the above kernel messages when
> > I
> > try to copy files from it.  But according to btrfs dev sta it has had 0
> > read and 0 corruption errors.
> > 
> > root@xev:/mnt/tmp# btrfs dev sta .
> > [/dev/sdc1].write_io_errs    0
> > [/dev/sdc1].read_io_errs     0
> > [/dev/sdc1].flush_io_errs    0
> > [/dev/sdc1].corruption_errs  0
> > [/dev/sdc1].generation_errs  0
> > root@xev:/mnt/tmp# uname -a
> > Linux xev 5.6.0-2-amd64 #1 SMP Debian 5.6.14-1 (2020-05-23) x86_64
> > GNU/Linux
> The read/write io err counters are updated when even repair bio have
> failed. So in your case you had some checksum errors, but btrfs managed
> to repair them by reading from a different mirror. In this case those
> aren't really counted as io errs since in the end you did get the
> correct data.

In this case I'm getting application IO errors and lost data, so if the error 
count is designed to not count recovered errors then it's still not doing the 
right thing.

# md5sum *
md5sum: 'Rise of the Machines S1 Ep6 - Mega Digger-qcOpMtIWsrgN.mp4': Input/
output error
md5sum: 'Rise of the Machines S1 Ep7 - Ultimate Dragster-Ke9hMplfQAWF.mp4': 
Input/output error
md5sum: 'Rise of the Machines S1 Ep8 - Aircraft Carrier-Qxht6qMEwMKr.mp4': 
Input/output error
^C
# btrfs dev sta .
[/dev/sdc1].write_io_errs    0
[/dev/sdc1].read_io_errs     0
[/dev/sdc1].flush_io_errs    0
[/dev/sdc1].corruption_errs  0
[/dev/sdc1].generation_errs  0
# tail /var/log/kern.log
Jun 23 17:48:40 xev kernel: [417603.547748] BTRFS warning (device sdc1): csum 
failed root 5 ino 275 off 59580416 csum 0x8941f998 expected csum 0xb5b581fc 
mirror 1
Jun 23 17:48:40 xev kernel: [417603.609861] BTRFS warning (device sdc1): csum 
failed root 5 ino 275 off 60628992 csum 0x8941f998 expected csum 0x4b6c9883 
mirror 1
Jun 23 17:48:40 xev kernel: [417603.672251] BTRFS warning (device sdc1): csum 
failed root 5 ino 275 off 61677568 csum 0x8941f998 expected csum 0x89f5fb68 
mirror 1
# uname -a
Linux xev 5.6.0-2-amd64 #1 SMP Debian 5.6.14-1 (2020-05-23) x86_64 GNU/Linux

On Tuesday, 23 June 2020 4:17:55 PM AEST waxhead wrote:
> I don't think this is what most people expect.
> A simple way to solve this could be to put the non-fatal errors in
> parentheses if this can be done easily.

I think that most people would expect a "device stats" command to just give 
stats of the device and not refer to what happens at the higher level.  If a 
device is giving corruption or read errors then "device stats" should tell 
that.

On Tuesday, 23 June 2020 5:11:05 PM AEST Nikolay Borisov wrote:
> read_io_errs. But this leads to a different can of worms - if a user
> sees read_io_errs should they be worried because potentially some data
> is stale or not (give we won't be distinguishing between unrepairable vs
> transient ones).

If a user sees errors reported their degree of worry should be based on the 
degree to which they use RAID and have decent backups.  If you have RAID-1 and 
only 1 device has errors then you are OK.  If you have 2 devices with errors 
then you have a problem.

Below is an example of a zpool having errors that were corrected.  The DEVICE 
had an unrecoverable error, but the RAID-Z pool recovered it from other 
devices.  It states that "Applications are unaffected" so the user knows the 
degree of worry that should be involved.

# zpool status
  pool: pet630
 state: ONLINE
status: One or more devices has experienced an unrecoverable error.  An
        attempt was made to correct the error.  Applications are unaffected.
action: Determine if the device needs to be replaced, and clear the errors
        using 'zpool clear' or replace the device with 'zpool replace'.
   see: http://zfsonlinux.org/msg/ZFS-8000-9P
  scan: scrub repaired 380K in 156h39m with 0 errors on Sat Jun 20 13:03:26 
2020
config:

        NAME           STATE     READ WRITE CKSUM
        pet630         ONLINE       0     0     0
          raidz1-0     ONLINE       0     0     0
            sdf        ONLINE       0     0     0
            sdq        ONLINE       0     0     0
            sdd        ONLINE       0     0     0
            sdh        ONLINE       0     0     0
            sdi        ONLINE      41     0     1


-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



