Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4622C3F2CA1
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 15:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbhHTNAp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 09:00:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33512 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbhHTNAp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 09:00:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9665F2212D;
        Fri, 20 Aug 2021 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629464406;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l0xMO8u+R/1LaM4pcU/rgUmcyRRX+eCuhsSabqgQNd0=;
        b=xNeprGdZEmKtjTnuoUKovRUKaJHsUkF388Z6dmNqCRsLposzaCjzkojoLXTwHeX9QT8qn6
        AD5l5M0NDaCAtHl/gp2D+G0aZtLH53lh40Zb4cI0siauQWuWzizrDP2wgbuimGFcD9effO
        EBndVLaCBQVcfYVMNr8HLUnVan0unWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629464406;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l0xMO8u+R/1LaM4pcU/rgUmcyRRX+eCuhsSabqgQNd0=;
        b=bYLAiNmFg1+hOicHzVbP6SzufAqlHpwFqByJ+hFCw4r82lyBYp6iSJsod8TAMj1BB+aA4x
        ZmdCqO2vldAT00Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8CE8FA3B88;
        Fri, 20 Aug 2021 13:00:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CEAF2DA8CA; Fri, 20 Aug 2021 14:57:08 +0200 (CEST)
Date:   Fri, 20 Aug 2021 14:57:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] btrfs-progs: make check handle invalid bg items
Message-ID: <20210820125708.GS5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1629261403.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629261403.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 12:39:19AM -0400, Josef Bacik wrote:
> Hello,
> 
> While writing code for extent tree v2 I noticed that I was generating a fs with
> an invalid block group ->used value.  However fsck wasn't catching this, because
> we don't actuall check the used value of the block group items in normal mode.
> lowmem mode does this properly thankfully, so this only needs to be added to the
> normal fsck mode.
> 
> I've added code to btrfs-corrupt-block to generate the corrupt image I need for
> the test case.  Then of course the actual patch to detect and fix the problem.
> Thanks,
> 
> Josef
> 
> Josef Bacik (3):
>   btrfs-progs: add the ability to corrupt block group items
>   btrfs-progs: make check detect and fix invalid used for block groups
>   btrfs-progs: add a test image with a corrupt block group item

Please use prefixes for the "subsystems" that get changed like

btrfs-progs: corrupt-block: add ability to corrupt block group items
btrfs-progs: check: detect and fix invalid used for block groups
btrfs-progs: tests: add image with a corrupt block group item

Series added to devel, thanks.
