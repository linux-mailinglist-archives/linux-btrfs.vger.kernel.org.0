Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3291B475C3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 16:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbhLOPvV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 10:51:21 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56730 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244127AbhLOPvT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 10:51:19 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6B0BE21108;
        Wed, 15 Dec 2021 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639583478;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4qsZ+61Rd3TIfS21g24ZRvRJ04u9Id0vY3pgjbURrK8=;
        b=id0sGbJAcXy/JL9oVx1jzNlRQca4wNiFKhWkrsD1fwjNtK+Ol2zyTQd/+PdraYrlsGTQx7
        OQwf8GiqO2QoqC0DmO+RX9yIs5bmz3xYPf+q3yXTgu82zvzhcjqa0diFZ1oBcOpqRyc6i7
        WRbj7/b2EVWhWtEnQk21RBNt8o6maxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639583478;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4qsZ+61Rd3TIfS21g24ZRvRJ04u9Id0vY3pgjbURrK8=;
        b=vOsIvYimRtkORQrKGJLkyoGp7G3A/b6EMHlIMFm+ecvRrdhzHikY0RShrAmtwfCRWshf9Y
        MrtTxHFXxyiT8WBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 63EE6A3BFC;
        Wed, 15 Dec 2021 15:51:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2771DA781; Wed, 15 Dec 2021 16:50:59 +0100 (CET)
Date:   Wed, 15 Dec 2021 16:50:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jingyun He <jingyun.ho@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: unable to use all spaces
Message-ID: <20211215155059.GB28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jingyun He <jingyun.ho@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAHQ7scWFUthGXGs72M9VYPHc2eiZ2hSSs6LJd6XVL2oQO2fgLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ7scWFUthGXGs72M9VYPHc2eiZ2hSSs6LJd6XVL2oQO2fgLw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 15, 2021 at 10:31:13PM +0800, Jingyun He wrote:
> Hello,
> I have a 14TB WDC HM-SMR disk formatted with BTRFS,
> It looks like I'm unable to fill the disk full.
> E.g. btrfs fi usage /disk1/
> Free (estimated): 128.95GiB (min: 128.95GiB)
> 
> It still has 100+GB available
> But I'm unable to put more files.

We'd need more information to diagnose that, eg. output of 'btrfs fi df'
to see if eg. the metadata space is not exhausted or if the remaining
128G account for the unusable space in the zones (this is also in the
'fi df' output).

> Do you know if there are any mkfs/mount options that I can use to
> reach maximum capacity? like mkfs.ext4 -m 0 -O ^has_journal -T
> largefile4

There are no such options and the space should be used at the full range
with respect to the chunk allocations.
