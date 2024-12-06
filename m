Return-Path: <linux-btrfs+bounces-10092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6869E6E78
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 13:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D551886065
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 12:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A17202C4B;
	Fri,  6 Dec 2024 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QC8tRGke"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E01FC107;
	Fri,  6 Dec 2024 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488666; cv=none; b=JObVh3eT30W++kQVFlTCivRuEYGPJdb6h5oLGScBCD5ROcX6m7xJpogRIfhWXQ8qc6bJdeshRtuOP238TQ6mmXFPe3Muhudz4kc46xz1kM1Ny0/fY84+yJhnu/Yzqe9OK2yDOF87wF0EcEoYQUj+q6CaOyOKZgh2MwkdHQou/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488666; c=relaxed/simple;
	bh=MTBlHdWW/VoP2jEQuIra4lVHdD6SmKOwIDWgkPH/P0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5AalDmvA5tQKA3Cp0GOiLqXcIEC8BIEMg9J0ct4gWI/zD/cH5zOLnVyAaLYpgcM3WfENFo7kWeBTQhvgQIc/2xlor/V2Ycw+gZKSShZDpc/p2ElR2sV60kpDGJ2ZBXJ+jAza93kdmkY/y685KDG2Aqfn+9jY6HM96WGtZ28QN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QC8tRGke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89879C4CEDD;
	Fri,  6 Dec 2024 12:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733488666;
	bh=MTBlHdWW/VoP2jEQuIra4lVHdD6SmKOwIDWgkPH/P0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QC8tRGkeKyBa8U0oPbCSk5OBpEftOLDJwk2kqgsGDvFK+Wn2gIKJ1QISjOiPkglNj
	 2y36X7rta8w09FFglGdLxsSq1P3toRteV4PmgukDTilHFr8wIhawdcWiw7t4dE/OCd
	 rryYNs+TcWU+qKlmKActAyp2KmcP+VVGFWEyInXc=
Date: Fri, 6 Dec 2024 13:37:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, stable@vger.kernel.org,
	linux-btrfs@vger.kernel.org, git@atemu.net,
	Luca Stefani <luca.stefani.ge1@gmail.com>
Subject: Re: [PATCH 6.6.x] btrfs: add cancellation points to trim loops
Message-ID: <2024120635-linked-frenzied-9a2e@gregkh>
References: <20241125180729.13148-1-dsterba@suse.com>
 <2024120245-molar-antidote-e93a@gregkh>
 <20241203152756.GA31418@suse.cz>
 <20241203154159.GB31418@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203154159.GB31418@suse.cz>

On Tue, Dec 03, 2024 at 04:41:59PM +0100, David Sterba wrote:
> On Tue, Dec 03, 2024 at 04:27:56PM +0100, David Sterba wrote:
> > On Mon, Dec 02, 2024 at 12:15:54PM +0100, Greg KH wrote:
> > > On Mon, Nov 25, 2024 at 07:07:28PM +0100, David Sterba wrote:
> > > > From: Luca Stefani <luca.stefani.ge1@gmail.com>
> > > > 
> > > > There are reports that system cannot suspend due to running trim because
> > > > the task responsible for trimming the device isn't able to finish in
> > > > time, especially since we have a free extent discarding phase, which can
> > > > trim a lot of unallocated space. There are no limits on the trim size
> > > > (unlike the block group part).
> > > > 
> > > > Since trime isn't a critical call it can be interrupted at any time,
> > > > in such cases we stop the trim, report the amount of discarded bytes and
> > > > return an error.
> > > > 
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
> > > > Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
> > > > CC: stable@vger.kernel.org # 5.15+
> > > > Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> > > > Reviewed-by: David Sterba <dsterba@suse.com>
> > > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > > ---
> > > 
> > > No git id?  :(
> > 
> > I forgot to add it but meanwhile Sasha looked up the commit and added it for me.
> 
> For the record it's 69313850dce33ce8c24b38576a279421f4c60996

Great, can you resend it with that information?

thanks,

greg k-h

