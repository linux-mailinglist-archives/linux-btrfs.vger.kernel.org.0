Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B74436743
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 18:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJUQJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 12:09:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53828 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhJUQJf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 12:09:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4DAF92199D;
        Thu, 21 Oct 2021 16:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634832438;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zn0YY96pQQ+7esOb9nn3z9JX5AWAoSInOdv8w10wHnc=;
        b=vCSuWjJGf2rm5QuO32lFBsATll0F5dXK+BOKTguOq0In2anMWdm4F9fuhrNdw2V+E3uhoT
        5sZgeSFEaxacfzlKaWRuYfHvSHAect6X7oSOCLmklTAYsgm+WCupSg8z9QtU3kPab4mDvM
        CZ1GvQewvZ7YxwhArhP+UCt4MGs/E0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634832438;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zn0YY96pQQ+7esOb9nn3z9JX5AWAoSInOdv8w10wHnc=;
        b=NLjMjYA+vlUL///3gBEjBFkh6+R5mNYuzC03qXoyVFdQNj8Ym4kUsviFtw65Jdw+7W932j
        sgGpZbUnyJhYziBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 18701A3B84;
        Thu, 21 Oct 2021 16:07:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 19D92DA7A3; Thu, 21 Oct 2021 18:06:49 +0200 (CEST)
Date:   Thu, 21 Oct 2021 18:06:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Anand Jain <anand.jain@oracle.com>, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [btrfs]  0f80799866: WARNING:at_fs/sysfs/file.c:#sysfs_emit
Message-ID: <20211021160648.GD20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        kernel test robot <oliver.sang@intel.com>,
        Anand Jain <anand.jain@oracle.com>, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <f748bd08259e2b770a5d9f2355c58c33d8566d16.1634598572.git.anand.jain@oracle.com>
 <20211021133538.GA16330@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021133538.GA16330@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 09:35:38PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 0f807998661ecadb74638c18cbaff8785bb46f8d ("[PATCH 1/2] btrfs: sysfs convert scnprintf and snprintf to use sysfs_emit")
> url: https://github.com/0day-ci/linux/commits/Anand-Jain/provide-fsid-in-sysfs-devinfo/20211019-082356
> base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
> 
> in testcase: boot
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

I wonder if it's related to the 32bit host, I don't see any crash.
