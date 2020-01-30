Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B20B14E37D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 20:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgA3T6l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 14:58:41 -0500
Received: from luna.lichtvoll.de ([194.150.191.11]:54215 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726514AbgA3T6l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 14:58:41 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 3E207A9785;
        Thu, 30 Jan 2020 20:58:39 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Martin Raiber <martin@urbackup.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
Date:   Thu, 30 Jan 2020 20:58:38 +0100
Message-ID: <16325152.4fYaUy9WYm@merkaba>
In-Reply-To: <CAJCQCtSwJHR2+jEXY=eK41xR7Z0=+Jf5xhsD03Qvoh92bAHO6g@mail.gmail.com>
References: <112911984.cFFYNXyRg4@merkaba> <20200130171950.GZ3929@twin.jikos.cz> <CAJCQCtSwJHR2+jEXY=eK41xR7Z0=+Jf5xhsD03Qvoh92bAHO6g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Murphy - 30.01.20, 20:31:40 CET:
> > > Is that mount option sufficient? Or does it take a filtered
> > > balance?
> > > What's the most minimal balance needed? I'm hoping -dlimit=1
> > > 
> > > I can't figure out a way to trigger this though, otherwise I'd be
> > > doing more testing.
> > 
> > I haven't checked but I think the suggested workarounds affect
> > statfs as a side effect. Also as the reservations are temporary,
> > the numbers change again after a sync.
> 
> Yeah I'm being careful to qualify to mortal users that any workarounds
> are temporary and uncertain. I'm not even certain what the pattern
> is, people with new file systems have hit it. A full balance seems to
> fix it, and then soon after the problem happens again. I don't do any
> balancing these days, for over a year now, so I wonder if that's why
> I'm not seeing it.
> 
> But yeah a small number of people are hitting it, but it also stops
> any program that does a free space check (presumably using statfs).
> 
> A more reliable/universal work around in the meantime is still useful;
> in particular if it doesn't require changing mount options, or only
> requires it temporarily (e.g. not added  to /etc/fstab, where it can
> be forgotten for the life of that system).

I did not balance either. Except maybe for a very short time during 
holding trainings in order to show to people how it works.

I never bought into balancing regularily.

Thanks,
-- 
Martin


