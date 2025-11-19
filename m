Return-Path: <linux-btrfs+bounces-19122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBD3C6CEE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 07:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE1EC4EFE4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 06:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8013191D0;
	Wed, 19 Nov 2025 06:28:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36AE3191B2;
	Wed, 19 Nov 2025 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763533718; cv=none; b=k+Z1nkqkdl46LSpUHD7oqTffJzWj+oypiKqneMSyr+YtNQqciopAuSJXEqxfo51xDGT/7eCkMHt9jE2yzfWPX02xjD9AkUh99Lp148EU0l+E2REcC2XvE4sHkoh5+1ULpIvwE51omxMWy6si0G79skG1TsnSRmJtpZ9sQjSFYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763533718; c=relaxed/simple;
	bh=uV9aHOFGSAEXlN+kUa3QTGk4uOyacs/HBVBC43oduM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoG+jI48CTFGbzVNqC65hm//+lGg8vS63jUlHfE91iFhaoWieczgtwYQLDrIz5bNaaZ8Zph15EvbEyzF5pCg5lpw7LeWA+y62lyHU/NrcXk5obTurZTFlovR4vHEQ1QvdhbTpG1IXaRjURxTAVTL3cAAWU/tx3Pb6MiC3584/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B98C68AFE; Wed, 19 Nov 2025 07:28:31 +0100 (CET)
Date: Wed, 19 Nov 2025 07:28:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
	Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Carlos Maiolino <cem@kernel.org>, Stefan Roesch <shr@fb.com>,
	Jeff Layton <jlayton@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"devel@lists.orangefs.org" <devel@lists.orangefs.org>,
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 10/14] fs: factor out a sync_lazytime helper
Message-ID: <20251119062830.GB20592@lst.de>
References: <20251114062642.1524837-1-hch@lst.de> <20251114062642.1524837-11-hch@lst.de> <cff9dffc-dd49-45db-bc47-efab498065c4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cff9dffc-dd49-45db-bc47-efab498065c4@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 17, 2025 at 07:38:29AM +0000, Chaitanya Kulkarni wrote:
> 
> This sync_lazytime() will always return false ?
> shouldn't this be returning true at sometime if not then why not
> change return type to void ?
> 
> returning same value doesn't add any value here ..

Yes, it should return true when actually doing work.  So currently the
syncing on final inode eviction is broken, but it looks like non of the
tests actually hits it.


