Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB394111B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 11:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhITJN2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 05:13:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36156 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbhITJLg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 05:11:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A21AF200B5;
        Mon, 20 Sep 2021 09:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632128965;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5fujqLjg4n0ovgYYfX/4EitPvAaX/pjhr/GEYNhOP4=;
        b=eBK955WxCOJSRXdNIZ//pQB83+PzOHvlJinvW0MaIKUapLLzrKaxsI1V3vpKk765LpWL7t
        UJhqCeCulhp0FPhbcgfZ9vcJhq1xOOboTZPg9LoT/cUgwDIHqF3y01RPniVDzlOdXXVjU6
        +jq4gBg33832F8/cnxnjsWSliCsClhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632128965;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5fujqLjg4n0ovgYYfX/4EitPvAaX/pjhr/GEYNhOP4=;
        b=M6r4iX2pGP53bARad0JTNounEf9JrufqC+gVpEf5y44eLCCBZ+qPgGKXpsdnkcxj4RHP/l
        oEFgWTNQgxHa0uBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 99A0AA3B96;
        Mon, 20 Sep 2021 09:09:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6E678DA781; Mon, 20 Sep 2021 11:09:14 +0200 (CEST)
Date:   Mon, 20 Sep 2021 11:09:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Forza <forza@tnonline.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Select DUP metadata by default on single devices.
Message-ID: <20210920090914.GB9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <9809e10.87861547.17bfad90f99@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9809e10.87861547.17bfad90f99@tnonline.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 18, 2021 at 11:38:54PM +0200, Forza wrote:
> Hello everyone,
> 
> I'd like to revisit the topic I opened on Github(*) a year ago, where
> I suggested that DUP metadata profile ought to be the default choice
> when doing mkfs.btrfs on single devices. 
> 
> Today we have much better write endurance on flash based media so the
> added writes should not matter in the grand scheme of things. Another
> factor is disk encryption where mkfs.btrfs cannot differentiate a
> plain SSD from a luks/dm-crypt device. Encryption effectively removes
> the possibility for the SSD to dedupe the metadata blocks. 
> 
> Ultimately, I think it is better to favour defaults that gives most
> users better fault tolerance, rather than using SINGLE mode for
> everyone because of the chance that some have deduplicating hardware
> (which would potentially negate the benefit of DUP metadata). 
> 
> One remark against DUP has been that both metadata copies would end up
> in the same erase block. However, I think that full erase block
> failures are in minority of the possible failure modes, at least from
> what I've seen on the mailing list and at #btrfs. It is more common to
> have single block errors, and for those we are protected with DUP
> metadata. 
> 
> Zygo made a very good in-depth explanation about several different
> failure modes in the Github issue. 
> 
> I would like voice my wish to change the defaults to DUP metadata on
> all single devices and I hope that the developers now can find
> consensus to make this change. 

I agree with the change, there's enough evidence for it.

The test was not done for SSDs specifically but to see if a device is
'rotational' as noted by sysfs file. This also caught NBDs or other
block devices that were emulated or hidden under some other layer.

This brings some usability issues, we may perhaps want to add a warning
that the device is detected as non-rotational, but that's all I see we
can do right now.

There was a discussion somewhere about a mode or command that would try
to guess what kind of device is it and suggest best options. That would
mean to examine the device vendor or look if it's eg. dm-crypt or
network-backed device or whatever. That should help distro partitioning
tools to suggest more appropriate options for mkfs, as there's
opposition to tweak the defaults.

Regarding the timing, 5.15 at the earliest and I think we can do a big
defaults update. Some of the features have been out for a long time and
got enabled manually.

So:
- DUP by default for metadata on single device
- single by default for data on multiple devices (now it's raid0)
- free-space-tree on
- no-holes on

I'd vote for one version doing the whole switch rather than doing the
changes by one.
