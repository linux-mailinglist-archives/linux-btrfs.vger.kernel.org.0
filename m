Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 319B114D931
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 11:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgA3Klh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 05:41:37 -0500
Received: from luna.lichtvoll.de ([194.150.191.11]:51327 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726913AbgA3Klh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 05:41:37 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 1EF5DA9490;
        Thu, 30 Jan 2020 11:41:36 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Martin Raiber <martin@urbackup.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
Date:   Thu, 30 Jan 2020 11:41:30 +0100
Message-ID: <10361507.xcyXs1b6NT@merkaba>
In-Reply-To: <CAJCQCtSVqMBONCuwea_9i6xBkzOHSkCSoEAaDi2aH+-CLnNwBg@mail.gmail.com>
References: <112911984.cFFYNXyRg4@merkaba> <2049829.BAvHWrS4Fr@merkaba> <CAJCQCtSVqMBONCuwea_9i6xBkzOHSkCSoEAaDi2aH+-CLnNwBg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Murphy - 29.01.20, 23:55:06 CET:
> On Wed, Jan 29, 2020 at 2:20 PM Martin Steigerwald 
<martin@lichtvoll.de> wrote:
> > So if its just a cosmetic issue then I can wait for the patch to
> > land in linux-stable. Or does it still need testing?
> 
> I'm not seeing it in linux-next. A reasonable short term work around
> is mount option 'metadata_ratio=1' and that's what needs more testing,
> because it seems decently likely mortal users will need an easy work
> around until a fix gets backported to stable. And that's gonna be a
> while, me thinks.
>
> Is that mount option sufficient? Or does it take a filtered balance?
> What's the most minimal balance needed? I'm hoping -dlimit=1

Does not make a difference. I did:

- mount -o remount,metadata_ratio=1 /daten
- touch /daten/somefile
- dd if=/dev/zero of=/daten/someotherfile bs=1M count=500
- sync
- df still reporting zero space free
 
> I can't figure out a way to trigger this though, otherwise I'd be
> doing more testing.

Sure.

I am doing the balance -dlimit=1 thing next. With metadata_ratio=0 
again.

% btrfs balance start -dlimit=1 /daten
Done, had to relocate 1 out of 312 chunks

% LANG=en df -hT /daten                   
Filesystem             Type   Size  Used Avail Use% Mounted on
/dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten

Okay, doing with metadata_ratio=1:

% mount -o remount,metadata_ratio=1 /daten

% btrfs balance start -dlimit=1 /daten    
Done, had to relocate 1 out of 312 chunks

% LANG=en df -hT /daten                   
Filesystem             Type   Size  Used Avail Use% Mounted on
/dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten


Okay, other suggestions? I'd like to avoid shuffling 311 GiB data around 
using a full balance.

Thanks,
-- 
Martin


