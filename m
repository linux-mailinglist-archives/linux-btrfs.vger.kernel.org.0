Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D84617C61
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 13:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiKCMTC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 08:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiKCMSz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 08:18:55 -0400
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A942624
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 05:18:52 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id 73C264007C;
        Thu,  3 Nov 2022 12:18:49 +0000 (UTC)
Date:   Thu, 3 Nov 2022 17:18:48 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Matt Huszagh <huszaghmatt@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How to replace a failing device
Message-ID: <20221103171848.540a9056@nvm>
In-Reply-To: <87v8nw3dcg.fsf@gmail.com>
References: <87v8nyh4jg.fsf@gmail.com>
        <20221102003232.097748e7@nvm>
        <87v8nw3dcg.fsf@gmail.com>
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

On Wed, 02 Nov 2022 20:51:11 -0700
Matt Huszagh <huszaghmatt@gmail.com> wrote:

> 99.99% data rescued with 2 bad sectors. Since I didn't have any trouble
> backing up recent data, I'm optimistic I haven't lost anything of value.

If your backup is incremental and only copies modified files, you can ensure
all other files are also readable by recursively reading them:

  find -type f -print0 | xargs -0 cat > /dev/null

...for a kind of manual scrub. Unless you had nocow/nodatasum files in there,
any damaged ones will return a read error thanks to Btrfs checksums.

Or maybe you could check if Btrfs scrub has also stopped hanging, given there
are no disk-level unreadable sectors anymore. (And after you have also
upgraded the kernel).

> I'm investigating RAID configurations (probably RAID10) as a way to make
> the process of replacing faulty drives somewhat smoother in the
> future. If you have any opinions on this would be curious to hear
> them. I'll probably also setup a periodic systemd service to run
> smartctl and detect issues (hopefully) earlier.

Btrfs currently does not seem to be famous for smooth disk replacements
unfortunately, even if you would use RAID.

I would suggest keeping up with the good backup schedule, and then rather than
using the Btrfs "single" profile stretched across devices, switch to MergerFS.
That way any disaster on a particular disk leaves other disks and their
independent filesystems completely unaffected.

-- 
With respect,
Roman
