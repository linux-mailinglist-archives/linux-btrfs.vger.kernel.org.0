Return-Path: <linux-btrfs+bounces-1147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B85681F0B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 18:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8FF1C21A7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83BC4643C;
	Wed, 27 Dec 2023 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeTGrmYP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DBD45C12
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Dec 2023 17:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98640C433C8;
	Wed, 27 Dec 2023 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703696948;
	bh=Dld5E7RaIlOfmKFLhDbKN+y2lVlbmipTfc0PejiPZJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QeTGrmYPLLjKPPXN9IYSxqR7ef+ju3BzAkQ3PQ2rL0Ks+kUazD+2L02dJ8Gf/fJA9
	 409BFMLynsPYhMG0lhqlk5nyFdIiIkrhgMhqxol+Gf3+neCIFLOr5owVHPEBh1oalk
	 n8JoRtBBZPJgP8pGgHdGS+2z07716TgOnKPQlvGVhTU4YpAmHPuxnrKabCS6+cf/gY
	 bZkN7kSbU5CQS0MLgrtSxc1/vMLhnLEQLNI1Uw4QGEkNl8w1+dw8b591H6ypP1Z1n9
	 MZDvENK5DbHh1bCYd3YaMkdAad+M/Vo9oPROCgONrMH3DGGAFxdSFb5ku0W8ARPpei
	 GaCDDvy8+0nKA==
Date: Wed, 27 Dec 2023 11:09:03 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 2/5] btrfs: call btrfs_close_devices from ->kill_sb
Message-ID: <20231227170903.GA1144@quark.localdomain>
References: <20231218044933.706042-1-hch@lst.de>
 <20231218044933.706042-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218044933.706042-3-hch@lst.de>

On Mon, Dec 18, 2023 at 05:49:30AM +0100, Christoph Hellwig wrote:
> blkdev_put must not be called under sb->s_umount to avoid a lock order
> reversal with disk->open_mutex once call backs from block devices to
> the file system using the holder ops are supported.

This contradicts the following from Documentation/filesystems/porting.rst:

    **mandatory**

    Lock ordering has been changed so that s_umount ranks above open_mutex again.
    All places where s_umount was taken under open_mutex have been fixed up.

So the rationale for this patch seems off.

It's still needed as a prerequisite for "fs: move fscrypt keyring destruction to
after ->put_super", if we indeed go with that instead of the alternative patch
"fscrypt: move the call to fscrypt_destroy_keyring() into ->put_super()".

- Eric

