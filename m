Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8515EC580
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 16:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfKAPSI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 11:18:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:51778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727810AbfKAPSI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 11:18:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03CAFB4F0;
        Fri,  1 Nov 2019 15:18:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 789FBDA7AF; Fri,  1 Nov 2019 16:18:15 +0100 (CET)
Date:   Fri, 1 Nov 2019 16:18:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] btrfs-progs: make quiet to overrule verbose
Message-ID: <20191101151815.GV3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20191024062825.13097-1-anand.jain@oracle.com>
 <20191024154151.GI3001@twin.jikos.cz>
 <1166a5c7-8bc9-b93f-6f4c-8871b5fc394b@oracle.com>
 <7b97f0ce-1f62-09fa-ad86-6a4d0af40e1d@oracle.com>
 <20191025163555.GP3001@twin.jikos.cz>
 <79a8fa97-6aff-3698-2263-548fbb68baf0@oracle.com>
 <0bf84f2d-d125-8c06-cb1a-e5498d84d196@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bf84f2d-d125-8c06-cb1a-e5498d84d196@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 30, 2019 at 03:42:56AM +0800, Anand Jain wrote:
> >>>    Question: command -v -q -v should be equal to command -v, right?
> >>
> >> No, that would be equivalent to the default level:
> >>
> >> verbose starts with 1            ()
> >> verbose++                (-v)
> >> verbose = 0                (-q)
> >> verbose++ is now 1, which is not -v    ()
> >>
> > 
> > Oh I was thinking its a bug, and no need to carry forward to the global
> > verbose. Will make it look like this.
> 
> What do you think should be the final %verbose value when both
> local and global verbose and or quiet options are specified?
> 
> For example:
>   btrfs -v -q sub-command -v
>   btrfs -q sub-command -v
>   btrfs -vv sub-command -q
>   etc..

Ah that's the conflicting part. I'd say treat all -v and -q equal, so
modify the bconf.verbose variable, and it's straightforward to document.
Some time in the future we should also issue a warning for 'sub-command
-v'.

The order makes it unintuitive so

  btrfs -q command -v

is going to be the default verbosity. We can't ignore the sub-command
part, and making it conditionally work in case there's no global
verbosity setting is kind of complicating it.

So let's take the simple approach, maybe we'll have second thought on
that before release.
