Return-Path: <linux-btrfs+bounces-17784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA91CBDB561
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 22:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C446F4FCCEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 20:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1155C307AE1;
	Tue, 14 Oct 2025 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCjdJ7Ke"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC89306D50;
	Tue, 14 Oct 2025 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475234; cv=none; b=ExLgL7ivQy7hb4FwKMlPyyNFtBnur8YyfETdWSEL6+DdyTN0iek4vlmoH4Jtc5akcrT7zwHHi2kq1QPPCqaXsL4XCMcgeEW76UUFcfPcJ4CPH0rBmcVeQCuxlZm+2yo7QosdBku1dvjIOgf5T+SKYb6b957VXsYEI0JioorwznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475234; c=relaxed/simple;
	bh=IFmvDy+AzTnIxjb/CA6rcF2VMO6nxV6/sEb9CjvR1fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1L0rUIY7X3/uxFwrpUvUQBxe+/Z81LJzEjbsafs3rBusRzlQeLT2HvWzO/Pa83G+ygKSOmwUemCbi0laL8eJ66wgLnfg3XDsWMpzq0aen2a7VmT5gkF2sPCZI+Os1fXzQrnvhmUYKjCRzRZ8oE0ERfZYgChTm9ejjM5P8FAwbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCjdJ7Ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1264C4CEE7;
	Tue, 14 Oct 2025 20:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760475233;
	bh=IFmvDy+AzTnIxjb/CA6rcF2VMO6nxV6/sEb9CjvR1fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCjdJ7KesPuIy7IJNvnYK3JVo6iqEQGB6TkPE09ZIkwd0Z7g/eWjKQ4qSzCNckaSK
	 GISj+jZL7zVWafw3aKXQrvSRLYZzIslR5r9+MIue0AueMUG7Rp9FKxsRPSQetvvqEB
	 /4Sw6umncBguTZO5naoYVHLdHQqcmq/yQ8/OOg1EcNQOP4bLhA+D141fiWrp6UARNg
	 HkHGXmUHnncoANjcmzCQV40PXM+1c1zSTfREoOllbSGo4ge1lRY6GzSyNczfGZRGhE
	 h5qlHR+4ZP1PKR0Jwt5jdM87EWUhMdZ56ayLD2+e1CIqEbAhKQ1clWdIILH3N+rVeI
	 HgSwoQPXe212Q==
Date: Tue, 14 Oct 2025 13:53:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v4 1/3] common/zoned: add _require_zloop
Message-ID: <20251014205353.GA6188@frogsfrogsfrogs>
References: <20251014084625.422974-1-johannes.thumshirn@wdc.com>
 <20251014084625.422974-2-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014084625.422974-2-johannes.thumshirn@wdc.com>

On Tue, Oct 14, 2025 at 10:46:23AM +0200, Johannes Thumshirn wrote:
> Add _require_zloop() function used by tests that require support for the
> zoned loopback block device.
> 
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/zoned | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/common/zoned b/common/zoned
> index eed0082a..41697b08 100644
> --- a/common/zoned
> +++ b/common/zoned
> @@ -37,3 +37,11 @@ _zone_capacity() {
>  	       grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
>      echo $((size << 9))
>  }
> +
> +_require_zloop()
> +{
> +    modprobe zloop >/dev/null 2>&1
> +    if [ ! -c "/dev/zloop-control" ]; then
> +	    _notrun "This test requires zoned loopback device support"
> +    fi
> +}
> -- 
> 2.51.0
> 
> 

