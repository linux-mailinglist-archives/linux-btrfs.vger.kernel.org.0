Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5181F4113A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 13:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhITLkY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 07:40:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34998 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhITLkY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 07:40:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0F3AA2203C;
        Mon, 20 Sep 2021 11:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632137937;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AwyUOh5/7M0IBcp6xLXjA25N9BjkDaEt6jGnizMn/FQ=;
        b=1FUApbd1bB2se+jdRYTumdYpyUihjand8ygiKuj6sjZCdg35j2Al+EXVlhyHwotY/LSWyH
        yNoXdiMMI6bAtZoicRJmM46JyqBoEnVkxqn5OYs9v6EIaHDF6ZSEX53R1iDNR4sp2Y24H7
        8C1E3i9L5surZDZwf0DGsTIujL86xOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632137937;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AwyUOh5/7M0IBcp6xLXjA25N9BjkDaEt6jGnizMn/FQ=;
        b=3MGV0aBaxw5g1uvF7zTrznQCkKz7cyfota0nAS4AuaCEZEyvfKFqyNdCchVeR/NJ6YMsRS
        N2+WaneslimIDjDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 068C1A3B8C;
        Mon, 20 Sep 2021 11:38:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C39DFDA7FB; Mon, 20 Sep 2021 13:38:45 +0200 (CEST)
Date:   Mon, 20 Sep 2021 13:38:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Select DUP metadata by default on single devices.
Message-ID: <20210920113845.GH9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <9809e10.87861547.17bfad90f99@tnonline.net>
 <20210920090914.GB9286@twin.jikos.cz>
 <e28ecf10-99c3-ce99-f3c1-218175646c2d@gmx.com>
 <20210920112349.GE9286@twin.jikos.cz>
 <a9b4ce46-27a2-377a-3c36-7706d71daf28@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9b4ce46-27a2-377a-3c36-7706d71daf28@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 20, 2021 at 07:26:38PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/9/20 19:23, David Sterba wrote:
> > On Mon, Sep 20, 2021 at 06:46:31PM +0800, Qu Wenruo wrote:
> >>> - single by default for data on multiple devices (now it's raid0)
> >>
> >> Is there any discussion/thread on that part?
> >>
> >> As I'm not that aware about this.
> >
> > It's been discussed on IRC long time ago. The problem with raid0 is that
> > it's a striped profile and changing to another profile may be
> > problematic once all the chunk space is alloated. Unlike for single
> > where it's on just one device and converting to anything is easy.
> >
> > I think that for multi-device fs everybody specifies the profiles
> > manually anyway, but the defaults should be sane.
> 
> OK, that makes completely sense.
> 
> Then I have no concern for the switch so far.

Now tracked as

https://github.com/kdave/btrfs-progs/issues/406
