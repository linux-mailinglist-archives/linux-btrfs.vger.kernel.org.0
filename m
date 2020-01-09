Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C992013534D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 07:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgAIGif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 01:38:35 -0500
Received: from mail.render-wahnsinn.de ([176.9.37.177]:35780 "EHLO
        mail.render-wahnsinn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgAIGif (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 01:38:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D03D5F86B;
        Thu,  9 Jan 2020 07:38:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1578551908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aX0eMvpCz96NpTPlZlz9VYVyFsBJdzjt4oYFJzBg+qc=;
        b=SDHjUNa/M3AF7dzmaxka1k1tkUqR5Ln2G5G1ruFVrZD9t8ZvD1t0r0p62SPjIoFiAxkmF6
        atk03ShPfO9prUieWGxnHnJbze91Lc5TmARtDc5nNEdOZKzSxtgWjEqi8CxkMsQJ9EQs6Y
        1/jANCd8RqiwmHXkN/f0vqQuW/d3eRT9D2Ix4qIvAxTisfzY+9UP6SjiUt+doN2CZ8qV/E
        8obE9NVbEf8Fo8tlF2rzqu0lCVnQca52Ku//sV66kqXh9KMjWYkjBb8s1qhbNm7gf9VFeQ
        ZL8G9Clu691qqqw+xPcAR87lGKYxwbHBbGicML13lZZFxS2BP8F5RQBWsBEBbw==
Message-ID: <0530e18f43a5f31ff8d446be362951f68068b5db.camel@render-wahnsinn.de>
Subject: Re: How long should a btrfs scrub with RAID5/6 take?
From:   Robert Krig <robert.krig@render-wahnsinn.de>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Date:   Thu, 09 Jan 2020 07:38:20 +0100
In-Reply-To: <CAJCQCtQQWGRQBAeCKt07MG33t9vwi-gahn7Mn9xJpA=HSAuTbw@mail.gmail.com>
References: <b2ccde6952d0fa67c9948a21cd3ac8eddcdb3970.camel@render-wahnsinn.de>
         <CAJCQCtQQWGRQBAeCKt07MG33t9vwi-gahn7Mn9xJpA=HSAuTbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm on Debian using Kernel 5.3.0-0.bpo.2-amd64 and btrfs-progs version
v5.2.1.

Here's an output of scrub status:
######################################
UUID:             c4adb372-178b-4398-977d-bc91bef6130f
        no stats available
Time left:        87884330:53:42
ETA:              Thu Oct 26 11:30:49 12045
Total to scrub:   18.67TiB
Bytes scrubbed:   35.70TiB
Rate:             55.60MiB/s
Error summary:    no errors found
#######################################


On Mi, 2020-01-08 at 14:49 -0700, Chris Murphy wrote:
> On Wed, Jan 8, 2020 at 3:19 AM Robert Krig
> <robert.krig@render-wahnsinn.de> wrote:
> > Hi, I've got a server where I have 4x8TB Disks in a BTRFS RAID5
> > (metadata and systemdata as RAID1) configuration.
> > 
> > It's just a backup server with data I can always recreate.
> > This server is in the bedroom, so I send it to sleep/suspend when I
> > go
> > to bed and then wake it up in the morning.
> > 
> > Since a scrub takes days on such a setup, I issue a btrfs scrub
> > resume
> > whenever the server wakes up again.
> > 
> > btrfs scrub status shows me that the total data to scrub is
> > 18.67TB,
> > but it's already scrubbed 36.60TB. Is there any way I can calculate
> > how
> > much more data is going to be scrubbed? 4x8TB is 32TB, so we're
> > passed
> > that, but I'm guessing this also has to do with parity data as
> > well.
> > 
> 
> What kernel version and btrfs-progs version? Recent btrfs progs has a
> new output that shows more info including a time to completion
> estimate. Can you post the output from 'btrfs scrub status
> /mountpoint/' ?
> 

