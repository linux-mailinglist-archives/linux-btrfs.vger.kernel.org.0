Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBA8615258
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 20:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiKATcv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 15:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKATcm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 15:32:42 -0400
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D381CB26
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 12:32:35 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id F28C44007C;
        Tue,  1 Nov 2022 19:32:32 +0000 (UTC)
Date:   Wed, 2 Nov 2022 00:32:32 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Matt Huszagh <huszaghmatt@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How to replace a failing device
Message-ID: <20221102003232.097748e7@nvm>
In-Reply-To: <87v8nyh4jg.fsf@gmail.com>
References: <87v8nyh4jg.fsf@gmail.com>
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

On Tue, 01 Nov 2022 12:13:07 -0700
Matt Huszagh <huszaghmatt@gmail.com> wrote:

> $ sudo btrfs fi show
> Label: 'btrfs'  uuid: d31878d6-3a77-4f0f-9fdd-bb9a2c4e578b
>         Total devices 4 FS bytes used 2.76TiB
>         devid    1 size 931.01GiB used 928.99GiB path /dev/mapper/cryptnvme
>         devid    2 size 931.50GiB used 931.50GiB path /dev/mapper/cryptnvme1
>         devid    3 size 1.82TiB used 1.55TiB path /dev/mapper/cryptsdd1
>         devid    4 size 15.88TiB used 0.00B path /dev/mapper/cryptsdc2

Remove this cryptsdc2 from the FS (btrfs dev remove), stop the crypto device,
wipe sdc2 entirely with wipefs.

Then power-off, boot into a rescue system such as grml.org, and use "ddrescue"
to copy the entire content of ex-sdd1 to ex-sdc2. The reason for calling them
"ex", is because it is extremely unfortunate to refer to disks by their sd*
names like that, as those can vary per kernel, distro, random delays during
detection, etc -- and of course, the controller ports used. So double-check to
ensure you get the source and destination right.

After "ddrescue" manages to copy whatever it could, power-off and remove the
old failing "sdd" from the system. Do not boot the main OS with both disks
still plugged in. You can wipe the failing one later (after verifying the
created copy is good) on some other PC, or booting into the same rescue system
again.

Of course this eschews the question of why Btrfs is not behaving in a more
desirable way in these circumstances (maybe someone can weigh in on that), and
does not use its native tools to recover, but this feels to be just the most
straightforward idea of "what you can do" right now, to bring the system back
to working order.

> Label: 'backup'  uuid: 0bd10808-0330-4736-9425-059d4a0a300e
>         Total devices 2 FS bytes used 1.08TiB
>         devid    1 size 1.82TiB used 593.00GiB path /dev/mapper/cryptsdc1
>         devid    2 size 1.82TiB used 588.00GiB path /dev/mapper/cryptsdb1
> 
> (the above is printed, but the command doesn't return...)
> 
> $ sudo btrfs fi df /
> Data, single: total=3.15TiB, used=2.74TiB
> System, RAID1: total=32.00MiB, used=432.00KiB
> Metadata, RAID1: total=110.00GiB, used=18.25GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B

-- 
With respect,
Roman
