Return-Path: <linux-btrfs+bounces-3746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C8F891880
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3906D1F22734
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 12:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8225E8565F;
	Fri, 29 Mar 2024 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1FD2lMGV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9579185926;
	Fri, 29 Mar 2024 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714568; cv=none; b=YmpSGIglk7bWWdCK2mWK/UR+YYU4gFaKc3RLX1PzVO7DaVIlDpuqXlC+7su5Nc8/dbIyz0K0tIPisTlU3LBU/XUyGWFKO5ayiqqcC/PyCIF9t72zOt1NkIF8BEbuCKlzZzI3YqIJe8akQxVkoS0IqITySH3ur3Q2xG6ebmnSGtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714568; c=relaxed/simple;
	bh=DvKUDWV/EXNQIZ+0TFa/9gUHACM9R6BvIrd7Pb2rvdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5PMbr7YrkNE+wx9JbzliwsJ18Z1mifO21iWyrVzBz8WAc8FfrCb1GsgCNhTcrzH2PiqWPaTQlThC5R96Op5nWgQB/2Xnwl6Ku5VG1HyfNuEfcBBY7hTipO8O/jcuve4s6YFP7y07Y7pLCAtJ5rNv5iNTwCVq0CkWt2pOF+cuF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1FD2lMGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB76C433F1;
	Fri, 29 Mar 2024 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711714568;
	bh=DvKUDWV/EXNQIZ+0TFa/9gUHACM9R6BvIrd7Pb2rvdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1FD2lMGVU+MwKTbxTQB2F5/MMKBMSVWKGAOXW4I2ZwM8DxP969Nn9iX30EMxCHYmP
	 MIGH3PLIAazO8V4+zwTa/O+89JJOhJ1KtBCcTlAYcN0+3oNbYEr1mpZG2dCksFX+qi
	 TVzUGHoZrgsbxBL8P93iA97qSEN+429eIdk3l67I=
Date: Fri, 29 Mar 2024 13:16:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: David Sterba <dsterba@suse.cz>
Cc: Maximilian Heyne <mheyne@amazon.de>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>,
	stable@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: allocate btrfs_ioctl_defrag_range_args on stack
Message-ID: <2024032957-muppet-scabby-e708@gregkh>
References: <20240320113156.22283-1-mheyne@amazon.de>
 <20240320161433.GF14596@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320161433.GF14596@suse.cz>

On Wed, Mar 20, 2024 at 05:14:33PM +0100, David Sterba wrote:
> On Wed, Mar 20, 2024 at 11:31:56AM +0000, Maximilian Heyne wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > commit c853a5783ebe123847886d432354931874367292 upstream.
> > 
> > Instead of using kmalloc() to allocate btrfs_ioctl_defrag_range_args,
> > allocate btrfs_ioctl_defrag_range_args on stack, the size is reasonably
> > small and ioctls are called in process context.
> > 
> > sizeof(btrfs_ioctl_defrag_range_args) = 48
> > 
> > Reviewed-by: Anand Jain <anand.jain@oracle.com>
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Reviewed-by: David Sterba <dsterba@suse.com>
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > CC: stable@vger.kernel.org # 4.14+
> > [ This patch is needed to fix a memory leak of "range" that was
> > introduced when commit 173431b274a9 ("btrfs: defrag: reject unknown
> > flags of btrfs_ioctl_defrag_range_args") was backported to kernels
> > lacking this patch. Now with these two patches applied in reverse order,
> > range->flags needed to change back to range.flags.
> > This bug was discovered and resolved using Coverity Static Analysis
> > Security Testing (SAST) by Synopsys, Inc.]
> > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> 
> Acked-by: David Sterba <dsterba@suse.com>
> 
> for backport to stable as a prerequisite for 173431b274a9a5 ("btrfs:
> defrag: reject unknown flags of btrfs_ioctl_defrag_range_args").
> 

Now queued up, thanks!

greg k-h

