Return-Path: <linux-btrfs+bounces-8498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA1098F191
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 16:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7032826A2
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFDC19F40A;
	Thu,  3 Oct 2024 14:36:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5356A4779F;
	Thu,  3 Oct 2024 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966194; cv=none; b=rnep1Edt+uR2h7DvMDpIpp66X6rRt5i22r0bElk8vqyujWRWxGSBLoJOsdW9xHuQKZ73OPoF/WTh+Mmr1FVm0wThX0c4Qzij7wkVgHjzBvxJE1ZRn47h87BkKzqHKtEqi/smD1VXib+5qi8Dm+A15+tpHb3SNq5JJzIjz4FFtsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966194; c=relaxed/simple;
	bh=9Cd4jAAT/ISrdcUUNhKUOa0mBVspFyxtxiriKHL2z6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9Kyl1pBoMglM8ADBTAwsRBVNwlGq21SkrC4cGNqo36o+3Kj+cDE8RFkDWFc2DpjbV51vt0HcaxN7QseStZ5mGUib9E+bra7oLwwmSqqQQIb97VRIP4ADcOHxzo6n8veh7ElwjGMGOQRj6pOaIs00eBRoxYjNanf041TuYjGT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2DCFE227A8E; Thu,  3 Oct 2024 16:36:28 +0200 (CEST)
Date: Thu, 3 Oct 2024 16:36:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux@treblig.org
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, hch@lst.de,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove unused btrfs_try_tree_write_lock
Message-ID: <20241003143627.GA24239@lst.de>
References: <20241003142727.203981-1-linux@treblig.org> <20241003142727.203981-2-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003142727.203981-2-linux@treblig.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 03, 2024 at 03:27:27PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> btrfs_try_tree_write_lock() is unused since commit
> 50b21d7a066f ("btrfs: submit a writeback bio per extent_buffer")
> 
> Remove it (and it's associated trace).

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


