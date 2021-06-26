Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF33B4CD0
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 07:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhFZFUP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Jun 2021 01:20:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59170 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhFZFUO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Jun 2021 01:20:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C8A521E0C;
        Sat, 26 Jun 2021 05:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624684671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZumZMk2OPh6pNJCkwFEDp7q/pnx8l6nm8Jbn+ImnyE=;
        b=wxgWll1oJ7ly8zj2bttnKPky9yA7rs/FMC6Dp3AsqGLa89ynCRv9t+GpUk64SHmO1wriwq
        grItqJHCP4vfoBN1k9cZSMvYvy9Nb2oJtRH7dklvNicbSeIYPWpg1wZVH1Y+juW+gkVCtf
        DrMmA49vma8+R8TLZObaOrsdvLGvaPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624684671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZumZMk2OPh6pNJCkwFEDp7q/pnx8l6nm8Jbn+ImnyE=;
        b=2tHvwlxO2NkOvokxqYbzCEDIGBiwyRmlYYsICgBtDzXuXWwc1yyHrkMr6vpRXv5Y+k2UHl
        bGn8VcWAzWozhcCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id D5D8C118DD;
        Sat, 26 Jun 2021 05:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624684671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZumZMk2OPh6pNJCkwFEDp7q/pnx8l6nm8Jbn+ImnyE=;
        b=wxgWll1oJ7ly8zj2bttnKPky9yA7rs/FMC6Dp3AsqGLa89ynCRv9t+GpUk64SHmO1wriwq
        grItqJHCP4vfoBN1k9cZSMvYvy9Nb2oJtRH7dklvNicbSeIYPWpg1wZVH1Y+juW+gkVCtf
        DrMmA49vma8+R8TLZObaOrsdvLGvaPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624684671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZumZMk2OPh6pNJCkwFEDp7q/pnx8l6nm8Jbn+ImnyE=;
        b=2tHvwlxO2NkOvokxqYbzCEDIGBiwyRmlYYsICgBtDzXuXWwc1yyHrkMr6vpRXv5Y+k2UHl
        bGn8VcWAzWozhcCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id hpU2IX241mDuPwAALh3uQQ
        (envelope-from <neilb@suse.de>); Sat, 26 Jun 2021 05:17:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Bart Van Assche" <bvanassche@acm.org>
Cc:     "Martin Steigerwald" <martin@lichtvoll.de>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: Assumption on fixed device numbers in Plasma's desktop search Baloo
In-reply-to: <ec60fd7f-7020-5168-81f1-809da73763f3@acm.org>
References: <41661070.mPYKQbcTYQ@ananda>,
 <162466884942.28671.6997551060359774034@noble.neil.brown.name>,
 <ec60fd7f-7020-5168-81f1-809da73763f3@acm.org>
Date:   Sat, 26 Jun 2021 15:17:46 +1000
Message-id: <162468466604.26869.10474422208964999454@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 26 Jun 2021, Bart Van Assche wrote:
> On 6/25/21 5:54 PM, NeilBrown wrote:
> > On Sat, 26 Jun 2021, Martin Steigerwald wrote:
> >>                                  And that Baloo needs an "invariant" for 
> >> a file. See comment #11 of that bug report:
> > 
> > That is really hard to provide in general.  Possibly the best approach
> > is to use the statfs() systemcall to get the "f_fsid" field.  This is
> > 64bits.  It is not supported uniformly well by all filesystems, but I
> > think it is at least not worse than using the device number.  For a lot
> > of older filesystems it is just an encoding of the device number.
> > 
> > For btrfs, xfs, ext4 it is much much better.
> 
> How about combining the UUID of the partition with the file path? An
> example from one of the VMs on my workstation:

A btrfs filesystem can span multiple partitions, and those partitions
can be added and removed dynamically.  So you could migrated from one to
another.

f_fsid really is best for any modern filesystem.

NeilBrown

