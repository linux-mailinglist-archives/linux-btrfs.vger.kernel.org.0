Return-Path: <linux-btrfs+bounces-7705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEBD966F67
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2024 07:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D891B1C216A8
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2024 05:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E3213D60E;
	Sat, 31 Aug 2024 05:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yLKV2yJU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91509763F8;
	Sat, 31 Aug 2024 05:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725082030; cv=none; b=gqG2+xtqR9NmHNhoYAyehAyLW4FJpUrsXFarGHJJaJZFFuh93nekYiMY3DuBi0v/bbytJX239YopAHcxiujg5hUd5Olakfwj0xlqpwMMz1+k8TQk5c0Eyk1fgAaXUeC7q+XwEAEszj3H8DV1KB5BeiqLA5jJhbtDcaLqZFkwvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725082030; c=relaxed/simple;
	bh=QP3vhlRfeNzXA0dFhYwn+0gwljWqnVOdGsJ8e0SalHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oulCYUkxQ9JuPjucWpSKxJsdPhXWwt0RG+nJV/XtTawBOvUgo1EUCrADtasNsntU5f/SS8Rpt+0Xn9jfPAeP8WmXrBlNK47QiodI1cfeHT3XHZtIniWw+gLNTnwKi1aZgDTB8HYNfDXzcoRzPRR3kUyzEbz1FlqmCxIfqm807ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yLKV2yJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F70C4CEC0;
	Sat, 31 Aug 2024 05:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725082030;
	bh=QP3vhlRfeNzXA0dFhYwn+0gwljWqnVOdGsJ8e0SalHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yLKV2yJUKByMvMfWWYeb1wTuPg+UhgScuYwVXLzVT8Vz0e19kkBktga+OxeohHgi5
	 tTIuCTHgoowa8Sd0FSg1XK08pSO1vK1IZdJym55eJBSHTtv/VPofth9CCKN0tfILpF
	 jRDZK++6HIopm84OOz/1xR1l2fK8a4++iVfAyp+A=
Date: Sat, 31 Aug 2024 07:27:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Cc: stable@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, wqu@suse.com, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
Subject: Re: [PATCH 6.1.y] btrfs: fix extent map use-after-free when adding
 pages to compressed bio
Message-ID: <2024083154-neutron-blemish-0f8c@gregkh>
References: <2024072924-overact-drainable-8abb@gregkh>
 <20240830224536.64932-1-brennan.lamoreaux@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830224536.64932-1-brennan.lamoreaux@broadcom.com>

On Fri, Aug 30, 2024 at 03:45:36PM -0700, Brennan Lamoreaux wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> commit 8e7860543a94784d744c7ce34b78a2e11beefa5c upstream.
> 
> At add_ra_bio_pages() we are accessing the extent map to calculate
> 'add_size' after we dropped our reference on the extent map, resulting
> in a use-after-free. Fix this by computing 'add_size' before dropping our
> extent map reference.
> 
> Reported-by: syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/000000000000038144061c6d18f2@google.com/
> Fixes: 6a4049102055 ("btrfs: subpage: make add_ra_bio_pages() compatible")
> CC: stable@vger.kernel.org # 6.1+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [ Brennan: Applied to v6.1 ]
> Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
> ---
>  fs/btrfs/compression.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Now queued up, thanks.

greg k-h

