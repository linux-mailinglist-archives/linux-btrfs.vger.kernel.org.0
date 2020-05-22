Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597E41DE848
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 15:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgEVNry (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 May 2020 09:47:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:38280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbgEVNry (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 May 2020 09:47:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4C4B6AFB0;
        Fri, 22 May 2020 13:47:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B17F0DA9B7; Fri, 22 May 2020 15:46:56 +0200 (CEST)
Date:   Fri, 22 May 2020 15:46:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v7 rebased 0/5] readmirror feature (sysfs and in-memory
 only approach; with new read_policy device)
Message-ID: <20200522134656.GL18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
 <a963d6c8-f0ec-7d41-ff0a-26d3ef9d013d@oracle.com>
 <20200515195858.GS18421@twin.jikos.cz>
 <c61a44bf-04ab-01a0-3fbe-4d5970827085@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c61a44bf-04ab-01a0-3fbe-4d5970827085@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 19, 2020 at 06:02:32PM +0800, Anand Jain wrote:
> On 16/5/20 3:58 am, David Sterba wrote:
> > On Thu, Apr 30, 2020 at 05:02:27PM +0800, Anand Jain wrote:
> >>    I am not sure if this will be integrated in 5.8 and worth the time to
> >>    rebase. Kindly suggest.
> > 
> > The preparatory work is ok, but the actual mirror selection policy
> > addresses a usecase that I think is not the one most users are
> > interested in. Devices of vastly different performance capabilities like
> > rotational disks vs nvme vs ssd vs network block devices in one
> > filesystem are not something commonly found.
> > 
> > What we really need is a saner balancing mechanism than pid-based, that
> > is also going to be used any time there are more devices from the same
> > speed class for the fast devices too.
> 
> There are two things here, the read_policy framework in the preparatory
> patches and a new balancing or read_policy, device.
> 
> > So, no the patchset is not on track for a merge without the improved
> > default balancing.
> 
> It can be worked on top of the preparatory read_policy framework?

Yes.

> This patchset does not change any default read_policy (or balancing)
> which is pid as of now. Working on a default read_policy/balancing
> was out of the scope of this patchset.
> 
> > The preferred device for reads can be one of the
> > policies, I understand the usecase and have not problem with that
> > although wouldn't probably have use for it.
> 
> For us, read_policy:device helps to reproduce raid1 data corruption
>     https://patchwork.kernel.org/patch/11475417/
> And xfstests btrfs/14[0-3] can be improved so that the reads directly
> go the device of the choice, instead of waiting for the odd/even pid.
> 
> Common configuration won't need this, advance configurations assembled
> with heterogeneous devices where read performance is more critical than
> write will find read_policy:device useful.

Yes that's the usecase and the possibility to make more targeted tests
is also good, but that still means the feature is half-baked and missing
the main part. If it was out of scope, ok fair, but I don't want to
merge it at that state. It would be embarassing to announce mirror
selection followed by "ah no it's useless for anything than this special
usecase".
