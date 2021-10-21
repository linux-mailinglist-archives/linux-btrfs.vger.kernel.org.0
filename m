Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875A743677D
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 18:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhJUQW3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 12:22:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39570 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhJUQWZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 12:22:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BE5FB1FD59;
        Thu, 21 Oct 2021 16:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634833208;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPySkzYNZnK3gG7WR2Xmr2p+USyCl+wmjxlJcRWCs5E=;
        b=ZX7Xjd8xzC1KWHuFL1xsaH2antHwD5FjIWrufJ7Nlh72evXSuVV6qQJXxckGmjq+rFb8em
        KLsHF0EknfrMAPpLTDnXQK2lRzA/stjHq/2HbR+NtqaRCZ4gX3yGsaeByuTHphCc3rXWU8
        VOK0plWYw6g08dFIXSoa9bdlbXEXpnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634833208;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPySkzYNZnK3gG7WR2Xmr2p+USyCl+wmjxlJcRWCs5E=;
        b=zHNm/arhgo3heboXWvGsFxSN7stSqcU7MUSWvE8G5ZcfHO32gl3q53lQOB8Y+89H7aEQiS
        fD498nwZO8UK1OBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B76BFA3B85;
        Thu, 21 Oct 2021 16:20:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF7EDDA7A3; Thu, 21 Oct 2021 18:19:39 +0200 (CEST)
Date:   Thu, 21 Oct 2021 18:19:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/2] btrfs: sysfs convert scnprintf and snprintf to
 use sysfs_emit
Message-ID: <20211021161939.GE20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <cover.1634829757.git.anand.jain@oracle.com>
 <8ff89162573399dec6ce5431243e4b45ec2fc4f0.1634829757.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff89162573399dec6ce5431243e4b45ec2fc4f0.1634829757.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 11:31:16PM +0800, Anand Jain wrote:
> commit 2efc459d06f1 (sysfs: Add sysfs_emit and sysfs_emit_at to format
> sysfs out)

Please use the common formatting which is 2efc459d06f1 ("sysfs: Add
sysfs_emit and sysfs_emit_at to format sysfs output") in this case.

> merged in 5.10 introduced two new functions sysfs_emit() and
> sysfs_emit_at() which are aware of the PAGE_SIZE max_limit of the buf.
> 
> Use the above two new functions instead of scnprintf() and snprintf()
> in various sysfs show().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>

Reported-by should be used only for when the patch is fixing something
based on that report.

I've applied the patch over the local version 1 but I don't see any
fix related to the the crash report, is that correct?
