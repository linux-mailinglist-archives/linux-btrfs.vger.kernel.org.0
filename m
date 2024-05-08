Return-Path: <linux-btrfs+bounces-4842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9C8C005C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 16:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC8B1F21E80
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 14:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB1886652;
	Wed,  8 May 2024 14:43:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC186621;
	Wed,  8 May 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179411; cv=none; b=rTCn2sAJUEaxqB/WjQ/Bnb88W8fGPGEvEPccr7BgnzY0+Uksd5j1t4AF2+AFvCPjxJPQwbaNw582C5r+fB/ImWG9aw8ehdNq2xMF7DPXPnxsb2Odbotl4b9SC7Qr5XzCFfGOzWH63xWk8mR+gxtLysLlyLFb0+xtRA6uMUeMCqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179411; c=relaxed/simple;
	bh=5cvfBGfQ1cSzb6/XP5aipsaEXZK9rqKx7tJpGXt/ljM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNZwcJJZlhDqCs8LiIWxVVYSsH2/mInM6cHmhHR51pTwdTsgyXTCJ8yrfvyvFvZZ7C/o0DGftUTTL8iF+Q2Iqzsy7TqnjuGzI8mw9HbeVYhzZJN86k8tWb+81MOJ2UITRqlkzEdQqUm/OLujpzxWLndsGoLPeqI2bhvD+z93ce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZHqq6GpDz6JBD7;
	Wed,  8 May 2024 22:40:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 962D3140A36;
	Wed,  8 May 2024 22:43:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 8 May
 2024 15:43:23 +0100
Date: Wed, 8 May 2024 15:43:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 00/26] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <20240508154321.00002073@Huawei.com>
In-Reply-To: <66385b6eb5f54_25842129416@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240404184901.00002104@Huawei.com>
	<6632d503f3ae5_e1f58294df@iweiny-mobl.notmuch>
	<20240503102051.00004a99@Huawei.com>
	<66385b6eb5f54_25842129416@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 5 May 2024 21:24:14 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 1 May 2024 16:49:24 -0700
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> > > Jonathan Cameron wrote:  
> > > >     
> > > > > 
> > > > > Fan Ni's latest v5 of Qemu DCD was used for testing.[2]    
> > > > Hi Ira, Navneet.    
> > > > > 
> > > > > Remaining work:
> > > > > 
> > > > > 	1) Integrate the QoS work from Dave Jiang
> > > > > 	2) Interleave support    
> > > > 
> > > > 
> > > > More flag.  This one I think is potentially important and don't
> > > > see any handling in here.    
> > > 
> > > Nope I admit I missed the spec requirement.
> > >   
> > > > 
> > > > Whilst an FM could in theory be careful to avoid sending a
> > > > sparse set of extents, if the device is managing the memory range
> > > > (which is possible all it supports) and the FM issues an Initiate Dynamic
> > > > Capacity Add with Free (again may be all device supports) then we
> > > > can't stop the device issuing a bunch of sparse extents.
> > > > 
> > > > Now it won't be broken as such without this, but every time we
> > > > accept the first extent that will implicitly reject the rest.
> > > > That will look very ugly to an FM which has to poke potentially many
> > > > times to successfully allocate memory to a host.    
> > > 
> > > This helps me to see see why the more bit is useful.
> > >   
> > > > 
> > > > I also don't think it will be that hard to support, but maybe I'm
> > > > missing something?     
> > > 
> > > Just a bunch of code and refactoring busy work.  ;-)  It's not rocket
> > > science but does fundamentally change the arch again.
> > >   
> > > > 
> > > > My first thought is it's just a loop in cxl_handle_dcd_add_extent()
> > > > over a list of extents passed in then slightly more complex response
> > > > generation.    
> > > 
> > > Not exactly 'just a loop'.  No matter how I work this out there is the
> > > possibility that some extents get surfaced and then the kernel tries to
> > > remove them because it should not have.  
> > 
> > Lets consider why it might need to back out.
> > 1) Device sends an invalid set of extents - so maybe one in a later message
> >    overlaps with an already allocated extent.   Device bug, handling can
> >    be extremely inelegant - up to crashing the kernel.  Worst that happens
> >    due to race is probably a poison storm / machine check fun?  Not our
> >    responsibility to deal with something that broken (in my view!) Best effort
> >    only.
> > 
> > 2) Host can't handle the extent for some reason and didn't know that until
> >    later - can just reject the ones it can't handle.   
> 
> 3) Something in the host fails like ENOMEM on a later extent surface which
>    requires the host to back out of all of them.
> 
> 3 should be rare and I'm working toward it.  But it is possible this will
> happen.
> 
> If you have a 'prepare' notify it should avoid most of these because the
> extents will be mostly formed.  But there are some error paths on the actual
> surface code path.

True. If these are really small allocations then elegant handling feels like
a nice to have rather than a requirement.

> 
> >   
> > > 
> > > To be most safe the cxl core is going to have to make 2 round trips to the
> > > cxl region layer for each extent.  The first determines if the extent is
> > > valid and creates the extent as much as possible.  The second actually
> > > surfaces the extents.  However, if the surface fails then you might not
> > > get the extents back.  So now we are in an invalid state.  :-/  WARN and
> > > continue I guess?!??!  
> > 
> > Yes. Orchestrator can decide how to handle - probably reboot server in as
> > gentle a fashion as possible.
> >   
> 
> Ok
> 
> >   
> > > 
> > > I think the safest way to handle this is add a new kernel notify event
> > > called 'extent create' which stops short of surfacing the extent.  [I'm
> > > not 100% sure how this is going to affect interleave.]
> > > 
> > > I think the safest logic for add is something like:
> > > 
> > > 	cxl_handle_dcd_add_event()
> > > 		add_extent(squirl_list, extent);
> > > 
> > > 		if (more bit) /* wait for more */
> > > 			return;
> > > 
> > > 		/* Create extents to hedge the bets against failure */
> > > 		for_each(squirl_list)
> > > 			if (notify 'extent create' != ok)
> > > 				send_response(fail);
> > > 				return;
> > > 		
> > > 		for_each(squirl_list)
> > > 			if (notify 'surface' != ok)
> > > 				/*
> > > 				 * If the more bit was set, some extents
> > > 				 * have been surfaced and now need to be
> > > 				 * removed...
> > > 				 *
> > > 				 * Try to remove them and hope...
> > > 				 */  
> > 
> > If we failed to surface them all another option is just tell the device
> > that.   Responds with the extents that successfully surfaced and reject
> > all others (or all after the one that failed?)  So for the lower layers
> > send the device a response that says "thanks but I only took these ones"
> > and for the upper layers pretend "I was only offered these ones"
> >   
> 
> But doesn't that basically break the more bit?  I'm willing to do that as it is
> easier for the host.

Don't think so.  We can always accept part of the offered extents in same
way we can accept part of a single offered extent if we like.
The more flag just means we only get to do that communication of what
we accepted once. So we have to reply with what we want and don't set
more flag in last message - thus indicating we don't want the rest.
(making sure we also tidy up the log for the ones we rejected)

> 
> > > 				WARN_ON('surface extents failed');
> > > 				for_each(squirl_list)
> > > 					notify 'remove without response'
> > > 				send_response(fail);
> > > 				return;
> > > 
> > > 		send_response(squirl_list, accept);
> > > 
> > > The logic for remove is not changed AFAICS because the device must allow
> > > for memory to be released at any time so the host is free to release each
> > > of the extents individually despite the 'more' bit???  
> > 
> > Yes, but only after it accepted them - which needs to be done in one go.
> > So you can't just send releases before that (the device will return an
> > error and keep them in the pending list I think...)  
> 
> :-(  OK so this more bit is really more...  no pun intended.  Because this
> breaks the entire model I have if I have to treat these as a huge atomic unit.
> 
> Let me think on that a bit more.  Obviously it is just tagging an iterating the
> extents to find those associated with a more bit on accept.  But it will take
> some time to code up.

The ability to give up at any point (though you need to read and clear the extents
that are left) should get around a lot of the complexity but sure it's
not a trivial thing to support.

I'd flip a 'something went wrong flag' on the the first failure, carry on the
walk not surfacing anything else, but clearing the logs etc, then finally reply
with what succeeded before that 'went wrong' flag was set.

> 
> >   
> > >   
> > > > 
> > > > I don't want this to block getting initial DCD support in but it
> > > > will be a bit ugly if we quickly support the more flag and then end
> > > > up with just one kernel that an FM has to be careful with...    
> > > 
> > > I'm not sure which is worse.  Given your use case above it seems like the
> > > more bit may be more important for 'dumb' devices which want to add
> > > extents in blocks before responding to the FM.  Thus complicating the FM.
> > > 
> > > It seems 'smarter' devices which could figure this out (not requiring the
> > > more bit) are the ones which will be developed later.  So it seems the use
> > > case time line is the opposite of what we need right now.  
> > 
> > Once we hit shareable capacity (which the smarter devices will use) then
> > this become the dominant approach to non contiguous allocations because
> > you can't add extents with a given tag in multiple goes.  
> 
> Why not?  Sharing is going to require some synchronization with the
> orchestrator and can't the user app just report it did not get all it's memory
> and wait for more?  With the same tag?

Hmm. I was sure the spec said sharing did not allow addition of capacity after
first creation, but now can't find it.  If you did do it though, fun
occurs when you then pass it on to the second device because you have
to do that via tag alone.

I believe this is about simplification on the device side because
offers of extents to other hosts are done by tag. If you allow extra ones
to turn up there are race conditions to potentially deal with.

7.6.7.6.5 Initiate Dynamic Capacity add.

"Enable shared Access" Enable access to extents previously added to another
host in a DC region that reports the "sharable" flag, as designated by the
specific tag value.

Note it is up to the device to offer the same capacity to all hosts for
which this is issued.  There is no extent list or length provided.


> 
> > 
> > So I'd expect the more flag to be more common not less over time.  
> > > 
> > > For that reason I'm inclined to try and get this in.
> > >   
> > 
> > Great - but I'd not worry too much about bad effects if you get invalid
> > lists from the device.  If the only option is shout and panic, then fine
> > though I'd imagine we can do slightly better than that, so maybe warn
> > extensively and don't let the region be used.  
> 
> It is not just about invalid lists.  It is that setting up the extent devices
> may fail and waiting for the devices to be set up means that they are user
> visible.  So that is the chicken and the egg...
> 
> This is unlikely and perhaps the partials should just be surfaced and accept
> whatever works.  Then let it all tear down later if it does not all go.
> 
> But I was trying to honor the accept 'all or nothing' as that is what has been
> stated as the requirement of the more bit.

That's not quite true - for shared it is all or nothing (after first host anyway) but
for other capacity it is 'accept X and reject Y in one go'.  You don't need to
take it all but you only get one go to say what you did accept.

> 
> But it seems that it does not __have__ to be atomic.  Or at least the partials
> can be cleaned up and all tried again.

With care you can accept up to a point, then give those back if you like - or
carry on and use them.

Jonathan

> 
> Ira
> 
> > 
> > Jonathan
> >   
> > > Ira
> > >   
> >   
> 
> 
> 


