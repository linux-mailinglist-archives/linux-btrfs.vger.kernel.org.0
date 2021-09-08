Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11A6403F22
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 20:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbhIHSe1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 14:34:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47464 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbhIHSe0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 14:34:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9BF07222AD;
        Wed,  8 Sep 2021 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631125997;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLFetVNjaDGTmp5I78ZM5aOVp5gcP2xREMuD2OSlmzE=;
        b=CT2DLXGd9XI0s38bFK7NrrS0DAr7Wy9Fnj2A1a4rnQru7PK+f/tNom+KZIPjqd4Hv6L9iN
        /3VRU9vrb+bVuWeXL+Lzs8PKg0Rxmcyjmdy8VEiy6y0kN53zgIMJY7eEk9DQPx+vZOuYuF
        unj5KnnnQkVDLZn1LBtVPA5p/JECHeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631125997;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLFetVNjaDGTmp5I78ZM5aOVp5gcP2xREMuD2OSlmzE=;
        b=jv+T56BSkYo4siRvtjRKegJ4wvgwsqMFdSt6pBjEx8tY5M4lCO6U0cFtMuye3cHzTPyCq8
        5S3lCplgSabr8qBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 91709A3B8C;
        Wed,  8 Sep 2021 18:33:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EED72DA7E1; Wed,  8 Sep 2021 20:33:12 +0200 (CEST)
Date:   Wed, 8 Sep 2021 20:33:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Martin Raiber <martin@urbackup.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Remove received information from snapshot on
 ro->rw switch
Message-ID: <20210908183312.GU3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Martin Raiber <martin@urbackup.org>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210908135135.1474055-1-nborisov@suse.com>
 <0102017bc64308e0-f75c4f13-349c-4c2c-a77d-f037340f07c1-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102017bc64308e0-f75c4f13-349c-4c2c-a77d-f037340f07c1-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 08, 2021 at 04:34:47PM +0000, Martin Raiber wrote:
> On 08.09.2021 15:51 Nikolay Borisov wrote:
> > Currently when a read-only snapshot is received and subsequently its
> > ro property is set to false i.e. switched to rw-mode the
> > received_uuid/stime/rtime/stransid/rtransid of that subvol remains
> > intact. However, once the received volume is switched to RW mode we
> > cannot guaranteee that it contains the same data, so it makes sense
> > to remove those fields which indicate this volume was ever
> > send/received. Additionally, sending such volume can cause conflicts
> > due to the presence of received_uuid.
> >
> > Preserving the received_uuid (and related fields) after transitioning the
> > snapshot from RO to RW and then changing the snapshot has a potential for
> > causing send to fail in many unexpected ways if we later turn it back to
> > RO and use it for an incremental send operation.
> >
> > A recent example, in the thread to which the Link tag below points to, we
> > had a user with a filesystem that had multiple snapshots with the same
> > received_uuid but with different content due to a transition from RO to RW
> > and then back to RO. When an incremental send was attempted using two of
> > those snapshots, it resulted in send emitting a clone operation that was
> > intended to clone from the parent root to the send root - however because
> > both roots had the same received_uuid, the receiver ended up picking the
> > send root as the source root for the clone operation, which happened to
> > result in the clone operation to fail with -EINVAL, due to the source and
> > destination offsets being the same (and on the same root and file). In this
> > particular case there was no harm, but we could end up in a case where the
> > clone operation succeeds but clones wrong data due to picking up an
> > incorrect root - as in the case of multiple snapshots with the same
> > received_uuid, it has no way to know which one is the correct one if they
> > have different content.
> Not to overly discourage this change but I think this will cause some
> issues in user space.

That this change can cause issues for users is the reason why it hasn't
been merged. The change on the kernel side is simple, but I've been
missing the progs part and the "what-if"s that happen in practice.

This hasn't been communicated properly so we've got resends without
changes. I had a chat with Nikolay about what's missing so hopefully we
can move forward this time.

> For example I had the problem of partial subvols after a sudden
> restart during receive. No problem, just receive to a directory that
> gets deleted on startup then move the subvol to the final location
> after completion. To move the subvol it needs to be temporarily set rw
> for some reason. I'm sure there is some better solution but patterns
> like this might be out there.

Thanks, that's a case we should take into account. And there are
probably more, but I'm not using send/receive much so that's another
reason why I've been hesitant to merge the patch due to lack of
understanding of the use case.
