Return-Path: <linux-btrfs+bounces-17532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A20FBC5860
	for <lists+linux-btrfs@lfdr.de>; Wed, 08 Oct 2025 17:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E1754F9C77
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Oct 2025 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C70D2EC56E;
	Wed,  8 Oct 2025 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcZWaN5X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946A127E1DC;
	Wed,  8 Oct 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936088; cv=none; b=SB8WDsrB/x9xPF1qGTPnY1w2epZx9mtv1d5SUlxuR/FqfbdfN/K3I/TsvahFlRno7mbAO/Tnf+PLIodPMiTkJnLh5Vf037dhB78/X46UEPAp+jqYfmn3OSrNx7jEl0zFSIPSJ93Zn8iPPUqYXwBm5dxycmoQYOH2sRbcawUfSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936088; c=relaxed/simple;
	bh=CnlS2MAp+wmpOSvzFnyBlUqd3zqkBmyzCs2N2fSCDMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AScGqlfZdGF+v+wOUec9M4Wvel4q1Fnhir2kd8BiViWyt9XZ4hqKe3TZy3Rjsb0UBql28bPS3XMhYzKa22h6CYPVAMlLPh1CkhN1z9HV2wnnpxSJLjSdsMYoFlprDVhifSRuXrgMGsjr7ImMK+83J2v/3AlWiHL0en7Ti7v7nAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcZWaN5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1442CC4CEF4;
	Wed,  8 Oct 2025 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759936087;
	bh=CnlS2MAp+wmpOSvzFnyBlUqd3zqkBmyzCs2N2fSCDMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DcZWaN5XcPH1pQHJgW4fQq0ezF2qmYous4kfKKzKSEsDd0OZ8OfFxBqyZmJOqXl1n
	 PsJkjqsJj3w91MJJ70jGIyDeF1zoRfijQqb6YTDh6lD2H1C8E5LZEvA7zbUxVPoU4s
	 GMqNlsZ5sKXtxoErOv/S4L96W+/IZEKNZ/iXDCAYj975wechieuAwvRfl4b5VvWRIL
	 0wPh07s0a68D3KT3O0mSFzFJfdRjJALmHi5x808XKQgxWPdnw6QSqQrdQ98pOAkbMX
	 /ikzbG6X8NUgRtM0ZUpXt8L8PROEN5uGco4HcRyZyGPkcCNUky9kRYad/ZRAknKui+
	 KkMGRkgF1B6jg==
Date: Wed, 8 Oct 2025 08:08:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Carlos Maiolino <cem@kernel.org>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] common/zoned: add _create_zloop
Message-ID: <20251008150806.GA6188@frogsfrogsfrogs>
References: <20251007125803.55797-1-johannes.thumshirn@wdc.com>
 <VGGoqK-5ZWJTAAy5zOK2QgRfnghNzWtGFoBwL6Sw9bqE7moL7lyTr43XUUgtMM54gKwCKIpC1Jz9u5ZcnpNATg==@protonmail.internalid>
 <20251007125803.55797-3-johannes.thumshirn@wdc.com>
 <hrht5llavtcgd5bb6sgsluy3vs2m6ddzzshkhwqb4fjgujgrli@6px7vpsk7ek3>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hrht5llavtcgd5bb6sgsluy3vs2m6ddzzshkhwqb4fjgujgrli@6px7vpsk7ek3>

On Wed, Oct 08, 2025 at 04:38:16PM +0200, Carlos Maiolino wrote:
> On Tue, Oct 07, 2025 at 02:58:02PM +0200, Johannes Thumshirn wrote:
> > Add _create_zloop a helper function for creating a zloop device.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >  common/zoned | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/common/zoned b/common/zoned
> > index 41697b08..33d3543b 100644
> > --- a/common/zoned
> > +++ b/common/zoned
> > @@ -45,3 +45,26 @@ _require_zloop()
> >  	    _notrun "This test requires zoned loopback device support"
> >      fi
> >  }
> > +
> > +# Create a zloop device
> > +# useage: _create_zloop [id] <base_dir> <zone_size> <nr_conv_zones>
> > +_create_zloop()
> > +{
> > +    local id=$1
> > +
> > +    if [ -n "$2" ]; then
> > +        local base_dir=",base_dir=$2"
> > +    fi
> > +
> > +    if [ -n "$3" ]; then
> > +        local zone_size=",zone_size_mb=$3"
> > +    fi
> > +
> > +    if [ -n "$4" ]; then
> > +        local conv_zones=",conv_zones=$4"
> > +    fi
> > +
> > +    local zloop_args="add id=$id$base_dir$zone_size$conv_zones"
> > +
> > +    echo "$zloop_args" > /dev/zloop-control

Hmm, so the caller figures out its own /dev/zloopNNN number, passes NNN
into the zloop-control devices, and then maybe a new bdev is created?
Does NNN have to be one more than the current highest zloop device, or
can it be any number?

Source code says that if NNN >= 0 then it tries to create a new
zloopNNN or fails with EEXIST; otherwise it gives you the lowest unused
id.  It'd be nice in the second case if there were a way for the driver
to tell you what the NNN is.

The _create_zloop users seem to do an ls to select an NNN.  At a minimum
that code probably ought to get hoisted to here as a common function (or
maybe just put in _create_zloop itself).

Or maybe turned into a loop like:

	while true; do
		local id=$(_next_zloop_id)
		err="$(echo "add id=$id$base_dir..." 2>&1 > /dev/zloop-control)"
		if [ -z "$err" ]; then
			echo "/dev/zloop$id"
			return 0
		fi
		if echo "$err" | ! grep -q "File exists"; then
			echo "$err" 1>&2
			return 1;
		fi
	done

That way test cases don't have to do all that setup themselves?

--D

> > +}
> 
> Looks fine to me, but I'm not sure if some error checking would be
> worth here in case setting up the zloop dev fails?
> > --
> > 2.51.0
> > 
> 

