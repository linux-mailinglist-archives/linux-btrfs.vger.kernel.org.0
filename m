Return-Path: <linux-btrfs+bounces-9900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370169D8C00
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 19:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CB3287BF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 18:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C030C1B85C9;
	Mon, 25 Nov 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVSviS3m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63FEEED6;
	Mon, 25 Nov 2024 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558279; cv=none; b=K/NsfIRZduEM5ZJd5dKbkFYFA9cV7L1lDKRkgIy4mW+zxB2aHw7X4jIc45gDwY6QI//vqkpAscKCh4ehXRZLcN+j7mUW0Ic4SrsiYXjhJjg3YmSVvFxmZJw3uwk+hNnLwtajYSTme0iGGGgzDvM2DUUjZ09cX1WcoaWUnvrv8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558279; c=relaxed/simple;
	bh=F04s+fEH/ptoXWiv/Ipc8melapQ4no8N8FDTD7H/zRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ietpi0ozMUiZBa683zGsgS2JZoK1Pldw2LWqBkI0NW+1i8DbsCE3z5rz1PJBnuWYP+M/xmne5En6skg0IUusbfdq5aT4P2cT5sh5fjRYAILHJ6cJN2fyOQ72BELMD0VyRJhllMXaLWn8+RNiZXq73MFQEl14LJsEwVqZ7zqIoc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVSviS3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC229C4CECE;
	Mon, 25 Nov 2024 18:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732558278;
	bh=F04s+fEH/ptoXWiv/Ipc8melapQ4no8N8FDTD7H/zRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVSviS3mTXbw1ZrFW7RDO9YEnVqciKdj1GCpI4yDKHuf76WAMbvyLWWAXmwO/aS1+
	 Wx/22KQOx964qHLpUynY/e70FY0YDIJSKEw+c576eiTcFRD16jFhuuq4WbXg7LXAm+
	 6SPvQ9KHIMUafG1go4WWaIy/FYpEnywbM48RHbY0y0T0JoI3wQ+b4S1rhua7N/+bph
	 27mLxJWGYzTn1WWcCUuzkUR9h6bCMwzc6DSjp9GzanoAlmikdVRpwdHZiqlauxpaI/
	 X+u4CuvT4DGtfphmJo1w9Bjplj+1aHaVPTJyzlFJzO4NGl5rHvoMYrjuSHEdWJTcvM
	 v79qBVPkHl+WQ==
Date: Mon, 25 Nov 2024 18:11:17 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, linux-btrfs@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: Re: [PATCH] btrfs: add FS_IOC_READ_VERITY_METADATA ioctl
Message-ID: <20241125181117.GB1242949@google.com>
References: <20241125084111.141386-1-allison.karlitskaya@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125084111.141386-1-allison.karlitskaya@redhat.com>

On Mon, Nov 25, 2024 at 09:41:11AM +0100, Allison Karlitskaya wrote:
> e17fe6579de0 introduced FS_IOC_READ_VERITY_METADATA to directly query
> the Merkle tree, descriptor and signature blocks for fs-verity enabled
> files.  It also added the ioctl implementation to ext4 and f2fs, but
> seems to have forgotten about btrfs.

At the time, btrfs did not support fs-verity.

> 
> Add the (trival) implementation for btrfs: we just need to wire it
> through to the fs-verity code, the same way as was done for the other
> two filesystems.  The fs-verity code already has access to the required
> data.

This ioctl isn't too useful, but I suppose adding it to btrfs can't hurt.

Can you run xfstests generic/624 and generic/625, which test this ioctl?

- Eric

