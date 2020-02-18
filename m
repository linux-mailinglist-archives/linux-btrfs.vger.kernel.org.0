Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD8D162993
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 16:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgBRPkl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 10:40:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42147 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726338AbgBRPkl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 10:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582040440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MPDSJagHBif548aMbDjzaIcvP2AHCn4dh2vIC3MX1QU=;
        b=hT9I09aVmAuGNlpiD5gNugu1MMO827H4uBqM5YInu02z4aBw9LKoEmiUrzKSNQSeNWtFPf
        1fLwYOEpDGV2ZrEVsmBT3/IOcbUMzRPwruYTLK0eDodsmhsy9kQtJn/OqQt3bEPQDmsRDf
        U5LRwMjfqgHHk9vrnqKNIv8ITTZ6Gh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-3pyTI1qzOmupi835c6s0Ow-1; Tue, 18 Feb 2020 10:40:36 -0500
X-MC-Unique: 3pyTI1qzOmupi835c6s0Ow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A5C7107ACC4;
        Tue, 18 Feb 2020 15:40:35 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8805C19756;
        Tue, 18 Feb 2020 15:40:34 +0000 (UTC)
Date:   Tue, 18 Feb 2020 10:40:32 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] xfstests: add a CGROUP configuration option
Message-ID: <20200218154032.GA14734@bfoster>
References: <20200214203431.24506-1-josef@toxicpanda.com>
 <20200217163821.GB6633@bfoster>
 <ad711a8b-f79d-380a-dc11-7e6d1e1e79ba@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad711a8b-f79d-380a-dc11-7e6d1e1e79ba@toxicpanda.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 18, 2020 at 09:17:10AM -0500, Josef Bacik wrote:
> On 2/17/20 11:38 AM, Brian Foster wrote:
> > On Fri, Feb 14, 2020 at 03:34:31PM -0500, Josef Bacik wrote:
> > > I want to add some extended statistic gathering for xfstests, but it's
> > > tricky to isolate xfstests from the rest of the host applications.  The
> > > most straightforward way to do this is to run every test inside of it's
> > > own cgroup.  From there we can monitor the activity of tasks in the
> > > specific cgroup using BPF.
> > > 
> > 
> > I'm curious what kind of info you're looking for from tests..
> > 
> 
> Latencies.  We have all of these tests doing all sorts of interesting
> things, I want to track operation latencies with code we're actually testing
> so I can see if I've introduced a performance regression somewhere.  Since
> Facebook's whole fleet is on btrfs I want to make sure I'm only getting
> information from things being run by xfstests so I can easily go back and
> hunt down regressions that get introduced.  With BPF I can filter on cgroup
> membership, so I know I'm only recording stats I care about.
> 

Interesting, might be useful to document the use case in the commit log.

> > > The support for this is pretty simple, allow users to specify
> > > CGROUP=/path/to/cgroup.  We will create the path if it doesn't already
> > > exist, and validate we can add things to cgroup.procs.  If we cannot
> > > it'll be disabled, otherwise we will use this when we do _run_seq by
> > > echo'ing the bash pid into cgroup.procs, which will cause any children
> > > to run under that cgroup.
> > > 
> > 
> > Seems reasonable, but is there any opportunity to combine this with what
> > we have in common/cgroup2? It's not clear to me if this cares about
> > cgroup v1 or v2, but perhaps the cgroup2 checks could be built on top of
> > a generic CGROUP var? I'm also wondering if we'd want to change runtime
> > behavior purely based on the existence of the path as opposed to some
> > kind of separate knob (in the event some future test requires the path
> > for some reason without wanting to enable this mechanism).
> > 
> 
> Oh I probably should have looked around, yeah we can definitely use this.
> My initial thought is to just make CGROUP2_PATH exported always, we create
> /path/to/cgroup2/xfstests and point CGROUP2_PATH at that, and then any tests
> that use the cgroup2 path for their test will automatically be populated
> under that global xfstests directory, so I can still capture them with my
> scripts. Does that sound reasonable?  Thanks,
> 

Not sure I follow.. are you saying that we'd change CGROUP2_PATH from
simply pointing at the local cgroup2 root on the local box to some magic
field that directs creation of a cgroup for the particular test? Or did
you mean to use a different variable name in the second case? Maybe it's
just easier to see a patch...

Brian

> Josef
> 

