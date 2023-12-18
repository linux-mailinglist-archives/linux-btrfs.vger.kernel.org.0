Return-Path: <linux-btrfs+bounces-1024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9463E816DDD
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 13:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D50A1F227E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 12:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA994F5FF;
	Mon, 18 Dec 2023 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I10Ghznv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6F4F5E9
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 12:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6221BC433C8;
	Mon, 18 Dec 2023 12:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702902140;
	bh=QpWcO4LSI0YIPS4915bzrQQ1Xa91Uxh1Axmom11mYhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I10Ghznvdch1TOnqMVsCk9DYfXfpe5++s5CU9SOu1w4jqI8ouNlZ/MZzNOCtRu9/C
	 5rLnR+qoqy3JN/Es1PO1cvsbO0vJ+kjDBYvICfOfRba8q3m4GYpmAex6L8FiVtiK8G
	 5ZFMWyLDzflvYMSwSB9FxUcC7xVtWducpL9qrEHlObp2ehKijSp9xgSlhVQ74DA7aI
	 t98Jh9w0J2KzC9OVZD8XxEe77H6Dfu9uzRSLtzYaoEyt6fOf/q+pcLiybEPsH+FlmD
	 WC+zuO2xRLxceKzd6yaXjCwKbaboemiAxBVSjDOWY3Z/jYxp8vaDOXNMOVjnYfj+Qx
	 NJUbkcpYh945Q==
Date: Mon, 18 Dec 2023 13:22:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 2/5] btrfs: call btrfs_close_devices from ->kill_sb
Message-ID: <20231218-engpass-vorladung-8a41c369480d@brauner>
References: <20231218044933.706042-1-hch@lst.de>
 <20231218044933.706042-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218044933.706042-3-hch@lst.de>

On Mon, Dec 18, 2023 at 05:49:30AM +0100, Christoph Hellwig wrote:
> blkdev_put must not be called under sb->s_umount to avoid a lock order
> reversal with disk->open_mutex once call backs from block devices to
> the file system using the holder ops are supported.  Move the call

With what's in vfs.super that part isn't necessary anymore. Locking
order is guaranteed so that s_umount ranks above open_mutex as before as
you know ofc. And we've got lockdep asserts everywhere so that lockdep
would complain immediately. It's still nicer imho to close devices in
->kill_sb() but it isn't needed anymore.

btrfs folks might want to consider pulling in vfs.super. It's been
stable on v6.7-rc1 for weeks and I won't change it anymore. Last change
on that branch is from Tue, 28 November.

