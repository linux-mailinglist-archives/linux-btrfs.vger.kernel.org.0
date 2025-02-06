Return-Path: <linux-btrfs+bounces-11330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A2A2B526
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 23:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F0418887DC
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 22:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B483122FF35;
	Thu,  6 Feb 2025 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5BRD8y8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A2D23C380;
	Thu,  6 Feb 2025 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738881194; cv=none; b=bDiHYvAT49vFCXqwsVOYSrK0g4RBoIqPyCZrkA2g5PYVLvgy5XOlMEfyVR1kYENnYWm5kSyioB4hx9nuoHanl2vWWG+ZM0VXJGTf9Yf8Rj8cXK7k+j6YebyOc6IiI8T9AahOBI0GM4m8z+PEVDXKtMYbiRpr2K9/8JKbR9KjSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738881194; c=relaxed/simple;
	bh=sPSC5n0NRWrypCVNR/WnfE6y93TFIP2ULZa5xRfwh90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+ECtBjFEhyNF6PeHHrH9AIAcVWIWDN745maRLVv7PEHDA865E+ttN7sAFfw74NkoNmiaSowlmquHxAv5k6b18LQwNb2YhWZeTREe2HqfsTBcZEj1jM5BQqRqlrW4u/k8ka0Z+J95RDiVnq924eMBdfAKAlpBRUngtGAKUG7T1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5BRD8y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E861C4CEDD;
	Thu,  6 Feb 2025 22:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738881194;
	bh=sPSC5n0NRWrypCVNR/WnfE6y93TFIP2ULZa5xRfwh90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O5BRD8y8MMOuGYCszBUoLQZtWFecxOFMV7ym0TQb/RkpdBPDVdN4A3/2bQCebVuOD
	 he9ZOlHOm2Vens7qzzwZpGHGBCjuXvjx34V08paQn+K9u0hCku45+BLFacME/b9vRE
	 8CCFmlq9YorcvqTBDMBANUkuQL1ROE5H7kr3BQgUaRg82PeX2GwyU44t6pynWMlVMH
	 1ysDxYW/OCGDKEhzbbiq6fgQKI48k+qPUATHhJcWPor7uzPRXx7MZvqpuJSOPDrzcP
	 dv8ZaTGjZdZb3t7LbIAbI3hDDp2JYWj32Qutr65FlPOQI3bkHJANCHtFvtFBsIDPkT
	 ZQKeyvuP5qkrw==
Date: Thu, 6 Feb 2025 14:33:13 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, fdmanana@kernel.org,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: suggest fs specific fix only if the tested
 filesystem matches
Message-ID: <20250206223313.GA21783@frogsfrogsfrogs>
References: <8c64ba21953b44b682c72b448bebe273dba64013.1738847088.git.fdmanana@suse.com>
 <Z6TC_yP7pTlzDOH4@infradead.org>
 <8ea6c977-7cb2-4d64-8efd-c3587e096c25@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ea6c977-7cb2-4d64-8efd-c3587e096c25@gmx.com>

On Fri, Feb 07, 2025 at 07:42:29AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/2/7 00:41, Christoph Hellwig 写道:
> > On Thu, Feb 06, 2025 at 01:05:06PM +0000, fdmanana@kernel.org wrote:
> > > +if [ "$FSTYP" = "xfs" ]; then
> > > +	_fixed_by_kernel_commit 68415b349f3f \
> > > +		"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
> > > +	_fixed_by_kernel_commit ca6448aed4f1 \
> > > +		"xfs: Fix missing interval for missing_owner in xfs fsmap"
> > > +fi
> > 
> > How about you add a new helper instead of the boilerplate, something
> > like
> > 
> > _fixed_by_fs_kernel_commit xfs 68415b349f3f \
> > 	"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
> > 
> > ?
> > 
> But what if the fix is generic? E.g. in mm/VFS layer?
> 
> Should we choose some placeholder name like "generic" as a fs type instead?

Keep using _fixed_by_kernel_commit then.

--D

> Thanks,
> Qu
> 

