Return-Path: <linux-btrfs+bounces-17714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AD9BD4853
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D6A3E02C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ACD31079B;
	Mon, 13 Oct 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI/zQxNU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D01A3112A3;
	Mon, 13 Oct 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368086; cv=none; b=tFkN+PZq4FdthlVNOFak2heQiDJ+BtsEAyTiFkUiU22fGSMTzTQXe4tjvCurijqsfwia2b+iEZ6UxejWkKboZin/yi0Oq29SuS/Qgh+Yo7kNkG9RonNrqN5xbeHtvkbItuihaRUqWunR6y+8qdZbpkAZ8vPebMG/ui6VPwgibaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368086; c=relaxed/simple;
	bh=Qi9c0tGx2o49HK+ogDKWK7rwq/cNq41kXnz1Xy/Ucyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDk8qfZJBfdzlHQyDm5MUncfPhWQ3sh5QFRSlDMJMr5fP6kcEOJgW74w/Lr2jLyR6Zs4WxE58IeRBmrjdiTINkGz0de3ETulAtv4iO1zALOWT3dhvRAGBYG60Kb8kUF90yaKSVuKpcZhGJ4wq+nB4r0y4zoHgihqqfZ9YLcM4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI/zQxNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA00C4CEE7;
	Mon, 13 Oct 2025 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760368086;
	bh=Qi9c0tGx2o49HK+ogDKWK7rwq/cNq41kXnz1Xy/Ucyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AI/zQxNUaPkpSC8BbLpMXPbugOrt7Hd0JUNoN2RL9iudQgGuw4gPyKQ6NLY4EzpoM
	 CwMxoMCMh1g9e1+WEHsOqCxW+faNryvlB4xCNGqqT71xxNl7uzrJ2n9DKRH67UnjeI
	 xzKnQ2XckWzPP4rKteBH9Vq78ruXb9w4GoMj6P0ZQ8XmZ5qzu+vvQf3XXcRsybgNSI
	 UoEO7dcZDrTr+RBqAzOs3GSO9bOiDGT0nR30QHZZySMOYXvqD6dvZFil+3Bq+H/2jD
	 mplFsqDbEqLRbMs3r7ZQsUfjAQrxCbi4dFxGlo4RX5WwgQGTPZFWFWP624mA5WL94k
	 SrBsbsCifNGWw==
Date: Mon, 13 Oct 2025 08:08:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Carlos Maiolino <cem@kernel.org>, Zorro Lang <zlang@redhat.com>,
	hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] common/zoned: add _create_zloop
Message-ID: <20251013150805.GK6188@frogsfrogsfrogs>
References: <20251007125803.55797-1-johannes.thumshirn@wdc.com>
 <VGGoqK-5ZWJTAAy5zOK2QgRfnghNzWtGFoBwL6Sw9bqE7moL7lyTr43XUUgtMM54gKwCKIpC1Jz9u5ZcnpNATg==@protonmail.internalid>
 <20251007125803.55797-3-johannes.thumshirn@wdc.com>
 <hrht5llavtcgd5bb6sgsluy3vs2m6ddzzshkhwqb4fjgujgrli@6px7vpsk7ek3>
 <20251008150806.GA6188@frogsfrogsfrogs>
 <f0713993-cebf-4e42-9c1a-26706a52be4d@wdc.com>
 <14046f78-e1e9-4188-8405-16055520513f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14046f78-e1e9-4188-8405-16055520513f@kernel.org>

On Sun, Oct 12, 2025 at 09:36:18AM +0900, Damien Le Moal wrote:
> On 2025/10/11 18:34, Johannes Thumshirn wrote:
> > On 10/8/25 5:08 PM, Darrick J. Wong wrote:
> >> On Wed, Oct 08, 2025 at 04:38:16PM +0200, Carlos Maiolino wrote:
> >>> On Tue, Oct 07, 2025 at 02:58:02PM +0200, Johannes Thumshirn wrote:
> >>>> Add _create_zloop a helper function for creating a zloop device.
> >>>>
> >>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>>> ---
> >>>>   common/zoned | 23 +++++++++++++++++++++++
> >>>>   1 file changed, 23 insertions(+)
> >>>>
> >>>> diff --git a/common/zoned b/common/zoned
> >>>> index 41697b08..33d3543b 100644
> >>>> --- a/common/zoned
> >>>> +++ b/common/zoned
> >>>> @@ -45,3 +45,26 @@ _require_zloop()
> >>>>   	    _notrun "This test requires zoned loopback device support"
> >>>>       fi
> >>>>   }
> >>>> +
> >>>> +# Create a zloop device
> >>>> +# useage: _create_zloop [id] <base_dir> <zone_size> <nr_conv_zones>
> >>>> +_create_zloop()
> >>>> +{
> >>>> +    local id=$1
> >>>> +
> >>>> +    if [ -n "$2" ]; then
> >>>> +        local base_dir=",base_dir=$2"
> >>>> +    fi
> >>>> +
> >>>> +    if [ -n "$3" ]; then
> >>>> +        local zone_size=",zone_size_mb=$3"
> >>>> +    fi
> >>>> +
> >>>> +    if [ -n "$4" ]; then
> >>>> +        local conv_zones=",conv_zones=$4"
> >>>> +    fi
> >>>> +
> >>>> +    local zloop_args="add id=$id$base_dir$zone_size$conv_zones"
> >>>> +
> >>>> +    echo "$zloop_args" > /dev/zloop-control
> >> Hmm, so the caller figures out its own /dev/zloopNNN number, passes NNN
> >> into the zloop-control devices, and then maybe a new bdev is created?
> >> Does NNN have to be one more than the current highest zloop device, or
> >> can it be any number?
> >>
> >> Source code says that if NNN >= 0 then it tries to create a new
> >> zloopNNN or fails with EEXIST; otherwise it gives you the lowest unused
> >> id.  It'd be nice in the second case if there were a way for the driver
> >> to tell you what the NNN is.
> >>
> >> The _create_zloop users seem to do an ls to select an NNN.  At a minimum
> >> that code probably ought to get hoisted to here as a common function (or
> >> maybe just put in _create_zloop itself).
> >>
> >> Or maybe turned into a loop like:
> >>
> >> 	while true; do
> >> 		local id=$(_next_zloop_id)
> >> 		err="$(echo "add id=$id$base_dir..." 2>&1 > /dev/zloop-control)"
> >> 		if [ -z "$err" ]; then
> >> 			echo "/dev/zloop$id"
> >> 			return 0
> >> 		fi
> >> 		if echo "$err" | ! grep -q "File exists"; then
> >> 			echo "$err" 1>&2
> >> 			return 1;
> >> 		fi
> >> 	done
> >>
> >> That way test cases don't have to do all that setup themselves?
> >>
> > Unfortunately the user has to create the zloop directory (e.g. 
> > BASE_DIR/0 for zloop0) beforehand (might be a bug though).
> 
> Not a bug. It is by design since the user can specify the ID of the zloop drive
> to create. And there is no fixed association between device ID and directory
> path to keep things flexible for the user/distro.

Hrmmm, each zloop device gets its own notion of the base dir, right?

> > What I could do is  encapsulate the find the next zloop and mkdir -p for 
> > the user (and call in _create_zloop if no id is supplied?)
> 
> Yes. Do that. The zloop directory si not something that the tests should touch
> anyway, so you should just define your own id <-> dir path mapping in the helpers.

That sounds fine to me...

--D

> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 

