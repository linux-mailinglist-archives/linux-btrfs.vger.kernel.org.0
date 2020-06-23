Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA3320472B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 04:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgFWCQf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 22:16:35 -0400
Received: from smtp.sws.net.au ([46.4.88.250]:54230 "EHLO smtp.sws.net.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728447AbgFWCQe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 22:16:34 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jun 2020 22:16:34 EDT
Received: from liv.localnet (unknown [103.75.204.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: russell@coker.com.au)
        by smtp.sws.net.au (Postfix) with ESMTPSA id DC49611CBC
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jun 2020 12:09:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
        s=2008; t=1592878180;
        bh=Dle+d1EcRmtfvpSuKTcp+ONGBKLIHKrxsfzMwOcEFfM=; l=1243;
        h=From:To:Subject:Date:From;
        b=U8C+dGDGBYhN6+rfo9Yf8/n9lzvQ+9/YmB9G8Sv8u20xFFXE59gSeugwyIn0BQn80
         trAcG7GhVLqBo4650fhB+UlTPVgF4vkvt3cfbGgxLMRjT5wbfBEV5B3jZAUhjh4IZw
         /35ZN+bS7Uyvar4n+m7bz5bglGxw/s4ss5gaOWwo=
From:   Russell Coker <russell@coker.com.au>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs dev sta not updating
Date:   Tue, 23 Jun 2020 12:09:36 +1000
Message-ID: <4857863.FCrPRfMyHP@liv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[395198.926320] BTRFS warning (device sdc1): csum failed root 5 ino 276 off 
19267584 csum 0x8941f998 expected csum 0xccd545e0 mirror 1
[395199.147439] BTRFS warning (device sdc1): csum failed root 5 ino 276 off 
20611072 csum 0x8941f998 expected csum 0xdaf657cb mirror 1
[395199.183680] BTRFS warning (device sdc1): csum failed root 5 ino 276 off 
24190976 csum 0x8941f998 expected csum 0xcddce0b1 mirror 1
[395199.185172] BTRFS warning (device sdc1): csum failed root 5 ino 276 off 
19267584 csum 0x8941f998 expected csum 0xccd545e0 mirror 1
[395199.330841] BTRFS warning (device sdc1): csum failed root 5 ino 277 off 0 
csum 0x8941f998 expected csum 0xa54d865c mirror 1

I have a USB stick that's corrupted, I get the above kernel messages when I 
try to copy files from it.  But according to btrfs dev sta it has had 0 read 
and 0 corruption errors.

root@xev:/mnt/tmp# btrfs dev sta .
[/dev/sdc1].write_io_errs    0
[/dev/sdc1].read_io_errs     0
[/dev/sdc1].flush_io_errs    0
[/dev/sdc1].corruption_errs  0
[/dev/sdc1].generation_errs  0
root@xev:/mnt/tmp# uname -a
Linux xev 5.6.0-2-amd64 #1 SMP Debian 5.6.14-1 (2020-05-23) x86_64 GNU/Linux

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



