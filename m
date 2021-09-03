Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376B34000F1
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 16:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhICOFB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 10:05:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56526 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhICOFB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 10:05:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 565B4203E0;
        Fri,  3 Sep 2021 14:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630677840;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8sUECfA/DsOHaemzjxO6+uzrK8BJUBjncGprOdVWsU=;
        b=GhmcfMRbfuk2lCxip+8hU2//5yPFL14wvl5174r6lO0LmBv+JJPIc3zC5Vf5eQpU6CiqKO
        skmLygKVpDqb8bAdcE7JCMsYwPqhzlDZW2qwvW7izmC/ZpjvxaUoVgh1XQmtoHnKBS51bg
        E0Z6CfEFriol79spKBhFglUlBzpZ344=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630677840;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8sUECfA/DsOHaemzjxO6+uzrK8BJUBjncGprOdVWsU=;
        b=htRP2tBmR0ArBSGm3Fhw/upK5LGZA/vIby+Uq46CZ5yV3ur9DypBz9qLWD0u/tB9rc1m44
        F2tRI+sfw35vE6BA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4E473A3BBB;
        Fri,  3 Sep 2021 14:04:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9632DDA89C; Fri,  3 Sep 2021 16:03:58 +0200 (CEST)
Date:   Fri, 3 Sep 2021 16:03:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: sysfs: introduce qgroup global attribute
 groups
Message-ID: <20210903140358.GF3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210831094903.111432-1-wqu@suse.com>
 <20210831094903.111432-2-wqu@suse.com>
 <20210902162840.GA3379@twin.jikos.cz>
 <9f48f55f-a4f3-ad0c-e48e-1da02b0ef068@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f48f55f-a4f3-ad0c-e48e-1da02b0ef068@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 03, 2021 at 06:30:36AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/9/3 上午12:28, David Sterba wrote:
> > On Tue, Aug 31, 2021 at 05:48:59PM +0800, Qu Wenruo wrote:
> >> Although we already have info kobject for each qgroup, we don't have
> >> global qgroup info attributes to show things like qgroup flags.
> >>
> >> Add this qgroups attribute groups, and the first member is qgroup_flags,
> >> which is a read-only attribute to show human readable qgroup flags.
> >>
> >> The path is:
> >>   /sys/fs/btrfs/<uuid>/qgroups/qgroup_flags
> >>
> >> The output would look like:
> >>   ON | INCONSISTENT
> >
> > So that's another format of sysfs file, we should try to keep them
> > consistent or follow common practices. The recommended way for sysfs is
> > to have one file per value, and here it follows the known states.
> >
> > So eg
> >
> > /sys/fs/.../qgroups/enabled		-> 0 or 1
> > /sys/fs/.../qgroups/inconsistent	-> 0 or 1
> > ...
> >
> > The files can be also writable so rescan can be triggered from sysfs, or
> > quotas disabled eventually. For the start exporting the state would be
> > sufficient though.
> >
> OK, that sounds indeed better than the current solution.
> 
> Although there may be a small window that one reading 3 attributes could
> get inconsistent view, as it's no longer atomic.
> 
> Would that be a problem?

I hope not, the status can change after reading the sysfs files anyway.
