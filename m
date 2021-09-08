Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53C0403D98
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348946AbhIHQby (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 12:31:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34168 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhIHQbx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 12:31:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C75DD22296;
        Wed,  8 Sep 2021 16:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631118644;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HpBW3bvMPBTxV7lfrE2L3xUcfenoZIvgAhZIObnjmpM=;
        b=QB5kNYklH+QYNMhH+5mPTr6YF4++6Xe3gVdhb8DqNB2l6rFuActUYozE/u1LYqyeMqeP7r
        DRIwxzKuLpckkGdC+X6L6qE2t68uu/v/KpwHm/wFDojWOhHj1zu5xknnaLWaOwHVINuhFf
        wS2UkOiwpYLvF1sE2OrB7dW1yjIuuws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631118644;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HpBW3bvMPBTxV7lfrE2L3xUcfenoZIvgAhZIObnjmpM=;
        b=EerxA210RH79SAwnBArRMjkoj71aea16aRUuSSI2e5F9JeKPZlfQLfVxkc1uVbeAzHyL7m
        bYUDlMvCShvKSqAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BF6DAA3B98;
        Wed,  8 Sep 2021 16:30:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 160E9DA7E1; Wed,  8 Sep 2021 18:30:40 +0200 (CEST)
Date:   Wed, 8 Sep 2021 18:30:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: fix mount failure due to past and transient
 device flush error
Message-ID: <20210908163039.GT3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cover.1631026981.git.fdmanana@suse.com>
 <dcf9de78faa6ec5cef443d031a987c87301805b1.1631026981.git.fdmanana@suse.com>
 <89c736d1-2e8c-b9ef-40a0-298b94fcebde@oracle.com>
 <CAL3q7H4B76EqcUY2Ynb1T4d16LqRvyS-41tf8Ze=gfg6ZqGdFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4B76EqcUY2Ynb1T4d16LqRvyS-41tf8Ze=gfg6ZqGdFg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 08, 2021 at 03:26:55PM +0100, Filipe Manana wrote:
> On Wed, Sep 8, 2021 at 3:20 PM Anand Jain <anand.jain@oracle.com> wrote:
> >
> > On 07/09/2021 23:15, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > When we get an error flushing one device, during a super block commit, we
> > > record the error in the device structure, in the field 'last_flush_error'.
> > > This is used to later check if we should error out the super block commit,
> > > depending on whether the number of flush errors is greater than or equals
> > > to the maximum tolerated device failures for a raid profile.
> >
> >
> > > However if we get a transient device flush error, unmount the filesystem
> > > and later try to mount it, we can fail the mount because we treat that
> > > past error as critical and consider the device is missing.
> >
> > > Even if it's
> > > very likely that the error will happen again, as it's probably due to a
> > > hardware related problem, there may be cases where the error might not
> > > happen again.
> >
> >   But is there an impact due to flush error, like storage cache lost few
> > block? If so, then the current design is correct. No?
> 
> If there was a flush error, then we aborted the current transaction
> and set the filesystem to error state.
> We only write the super block if we are able to do the device flushes.

Should the last_flush_error be reset in btrfs_close_one_device once the
filesystem is unmounted? I wonder if we should allow leaking the status
past the mount and care in the next one.
