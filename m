Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B528411377
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 13:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhITLZ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 07:25:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52664 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhITLZ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 07:25:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E12421FE51;
        Mon, 20 Sep 2021 11:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632137041;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S+Wq7+1tm+icKn5GYfktf7Uk6bsLyly9n/gnvHR5070=;
        b=P3uRZzlD4o78YRriTp5cO94XMImhmII114I5UO8z/6typM7ftD0wjhywahUrf8wEJQ+K/I
        /qaQ5kUSJQiV6YkUdP89SksWPenYlu1yK8CODT2Z/7Ivvv8FOOn3d3o5+wBTVCPTfhZMSO
        IPV79qOs2Qq8RAx3SBe5jQeNZ8TaFHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632137041;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S+Wq7+1tm+icKn5GYfktf7Uk6bsLyly9n/gnvHR5070=;
        b=KhGj/avB7ArUSN/pbEmkXe3llbH8M1F+gA3dwAbot84PHd2Ga0p8K25DzHy28wCF0N9TW3
        n/+M5GNHOZTUnRAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D8984A3B87;
        Mon, 20 Sep 2021 11:24:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8932ADA7FB; Mon, 20 Sep 2021 13:23:50 +0200 (CEST)
Date:   Mon, 20 Sep 2021 13:23:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Select DUP metadata by default on single devices.
Message-ID: <20210920112349.GE9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <9809e10.87861547.17bfad90f99@tnonline.net>
 <20210920090914.GB9286@twin.jikos.cz>
 <e28ecf10-99c3-ce99-f3c1-218175646c2d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e28ecf10-99c3-ce99-f3c1-218175646c2d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 20, 2021 at 06:46:31PM +0800, Qu Wenruo wrote:
> > - single by default for data on multiple devices (now it's raid0)
> 
> Is there any discussion/thread on that part?
> 
> As I'm not that aware about this.

It's been discussed on IRC long time ago. The problem with raid0 is that
it's a striped profile and changing to another profile may be
problematic once all the chunk space is alloated. Unlike for single
where it's on just one device and converting to anything is easy.

I think that for multi-device fs everybody specifies the profiles
manually anyway, but the defaults should be sane.

> > - free-space-tree on
> > - no-holes on
> >
> > I'd vote for one version doing the whole switch rather than doing the
> > changes by one.
> 
> I'm fine on DUP and FST.
> 
> On no-holes I'd prefer more feedback from Filipe as he has exposed some
> no-holes related problem some time ago.

Yeah I know Filipe is not all happy about making no-holes default, it
removes some capabilities of 'check' to verify extents. Some bugs have
been fixed recently (kernel side) but that's IMO on par with regular bug
hunting & fixing.

I don't know when would be the perfect time to make no-holes dfault,
it's a feature to reduce metadata consumption which is IMO worth as FST
will increase it again. Backward compatibility is good, lots of stable
versions support it.
