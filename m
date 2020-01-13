Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98AD41396E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 17:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAMQ7j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 11:59:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:53748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgAMQ7j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 11:59:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 880C2AC3F;
        Mon, 13 Jan 2020 16:59:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5939FDA78B; Mon, 13 Jan 2020 17:59:21 +0100 (CET)
Date:   Mon, 13 Jan 2020 17:59:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: device stat, log when zeroed assist audit
Message-ID: <20200113165919.GX3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20200110042634.4843-1-anand.jain@oracle.com>
 <7b449175-4e73-7fe9-07b2-d1c04feeba8e@toxicpanda.com>
 <054ca606-1886-d7f3-64e2-b1a032034648@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <054ca606-1886-d7f3-64e2-b1a032034648@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 11, 2020 at 04:50:18PM +0800, Anand Jain wrote:
> On 1/10/20 11:07 PM, Josef Bacik wrote:
> > On 1/9/20 11:26 PM, Anand Jain wrote:
> >> We had a report indicating that some read errors aren't reported by
> >> the device stats in the userland. It is important to have the errors
> >> reported in the device stat as user land scripts might depend on it to
> >> take the reasonable corrective actions. But to debug these issue we need
> >> to be really sure that request to reset the device stat did not come
> >> from the userland itself. So log an info message when device error reset
> >> happens.
> >>
> >> For example:
> >>   BTRFS info (device sdc): device stats zeroed by btrfs (9223)
> >>
> >> Reported-by: philip@philip-seeger.de
> >> Link: https://www.spinics.net/lists/linux-btrfs/msg96528.html
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >>   BTRFS info (device sdc): device stats zeroed by btrfs (9223)
> >> The last words are name and pid of the process, unfortunately it came out
> >> as 'by btrfs'. At some point if there is a python and lib to reset it
> >> would change, otherwise its going to be 'by btrfs', I am ok with it,
> >> if otherwise please suggest the alternative.
> > 
> > I think name(pid) makes sense, similar to what drop_caches does
> > 
> > pr_info("%s (%d): drop_caches: %d\n",
> >      current->comm, task_pid_nr(current),
> 
> There is a small deviation to what we already have in
> device_list_add(), name (pid) is at the end the log message..
> 
> ------
>                          pr_info(
>          "BTRFS: device label %s devid %llu transid %llu %s scanned by 
> %s (%d)\n",
>                                  disk_super->label, devid, 
> found_transid, path,
>                                  current->comm, task_pid_nr(current));
> --------
> 
> I am not sure. Can David can tweak during merge ?

Yes, no problem.
