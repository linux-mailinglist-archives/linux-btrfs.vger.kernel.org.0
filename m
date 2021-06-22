Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C143B0508
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 14:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhFVMqa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 08:46:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57112 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhFVMq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 08:46:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 746E52196F;
        Tue, 22 Jun 2021 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624365850;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1kb9tUI5T73deItbiP9bzK+IVj2L61CB9Hps3RgS3w=;
        b=kpuPB2OhjX+zCz03AcoyXAwUUzNZqW6e/hdzFAByMcm/lypTbNXfe2mohGDhKFLXzKahLy
        cFvqyPW+pkzFhdCUBCizG7W1FvPi4xDRVk2llS6LF+0LamCfKKA7gP7TIby66NID35vSPv
        oXbw602cBtbUnTPBZBYV13SYjwIGVKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624365850;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1kb9tUI5T73deItbiP9bzK+IVj2L61CB9Hps3RgS3w=;
        b=IQt1QcRC/YqOz4LeAoA1DpMyvzI4Pes0wxneZZTG6MxTgq3hHNfHxGBLzmh/I/ZXJDNW8q
        zWgXRb+yNuyCR3AQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6AA18A3BAD;
        Tue, 22 Jun 2021 12:44:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9C39DA77B; Tue, 22 Jun 2021 14:41:19 +0200 (CEST)
Date:   Tue, 22 Jun 2021 14:41:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/9] btrfs: compression: refactor and enhancement
 preparing for subpage compression support
Message-ID: <20210622124119.GI28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210617051450.206704-1-wqu@suse.com>
 <20210617164703.GW28158@twin.jikos.cz>
 <d184445f-a1a1-3f17-c33d-ffe3fc066c66@gmx.com>
 <20210622111403.GF28158@twin.jikos.cz>
 <ae3df571-4eeb-d046-6a90-ac67158d4067@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae3df571-4eeb-d046-6a90-ac67158d4067@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 22, 2021 at 07:50:38PM +0800, Qu Wenruo wrote:
> On 2021/6/22 下午7:14, David Sterba wrote:
> > On Fri, Jun 18, 2021 at 06:46:51AM +0800, Qu Wenruo wrote:
> Although the biggest challenge for testing is the hardware.
> 
> I guess even with subpage merged into upstream in v5.14, it won't really
> get many tests from real world, unlike x86_64 that every guys in the
> mail list is testing on.
> 
> Although we have cheap ARM SoC boards in recent days, there aren't
> really much good candidates for us to utilize.
> 
> Either they don't have fast enough CPUs (2x 2GHz+ A72 or more) or don't
> have even a single PCIe lane for NVME, or don't have good enough
> upstream kernel support.
> 
> So far RPI CM4 would be a pretty good candidate, and I'm already using
> it, but without overclocking and good heatsink, its CPU can be a little
> bit slow, and the PCIe2.0 x1 lane is far from enough.
> 
> But I totally understand how difficult it could be for even kernel
> developers to setup all the small things up.
> 
> Like TTY, libvirt, edk2 firmware for VM, RPI specific boot sequence etc.
> 
> Thus even subpage get merged, I still think we need way more rounds of
> upstream release to really get some feedback.

Back in January I got a hold of a decent arm64 machine and tested the 64K
build in a VM, the hardware should be good enough for running at least
3 in parallel and I think there were more identical physical machines
available so we can use that for testing once all the prep work is done.
Right now all people involved know that the subpage support may be buggy
or incomplete so we can rely on external testing for some time.
