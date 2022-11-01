Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF4C61527F
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 20:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKATo3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiKATo1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 15:44:27 -0400
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4424D1D64A
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 12:44:26 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id 9F4264007C;
        Tue,  1 Nov 2022 19:44:24 +0000 (UTC)
Date:   Wed, 2 Nov 2022 00:44:24 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Matt Huszagh <huszaghmatt@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How to replace a failing device
Message-ID: <20221102004424.3683a2e0@nvm>
In-Reply-To: <20221102003232.097748e7@nvm>
References: <87v8nyh4jg.fsf@gmail.com>
        <20221102003232.097748e7@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2 Nov 2022 00:32:32 +0500
Roman Mamedov <rm@romanrm.net> wrote:

Some afterthoughts...

> Remove this cryptsdc2 from the FS (btrfs dev remove), stop the crypto device,
> wipe sdc2 entirely with wipefs.

That's not "entirely" of course, but just wiping the signatures is enough.

> After "ddrescue" manages to copy whatever it could, power-off and remove the
> old failing "sdd" from the system. Do not boot the main OS with both disks
> still plugged in. You can wipe the failing one later (after verifying the
> created copy is good) on some other PC, or booting into the same rescue system
> again.

After verifying it is good, you can enlarge the Btrfs' opinion of the
partition size on the copied 16TB device, see "btrfs resize devid:max ..."

> > $ sudo btrfs fi df /
> > Data, single: total=3.15TiB, used=2.74TiB
> > System, RAID1: total=32.00MiB, used=432.00KiB
> > Metadata, RAID1: total=110.00GiB, used=18.25GiB

^ A side note, this looks weird, as if at some point you had a ton of tiny
files, and then you removed them. If I'm not mistaken, running:

  btrfs fi balance -musage=80 ...

could gain you around 150 GB of usable disk space (as seen in df and
accessible for writing non-tiny files).

But of course do that only after the failing disk problem has been resolved.

And I vaguely remember that at some point the kernel may have started doing
this kind of cleanup automatically.

> > GlobalReserve, single: total=512.00MiB, used=0.00B

-- 
With respect,
Roman
