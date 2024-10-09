Return-Path: <linux-btrfs+bounces-8726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E721996E8C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09B7282543
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEA419CC28;
	Wed,  9 Oct 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ0sYz39"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB345466B;
	Wed,  9 Oct 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485205; cv=none; b=cz+ow7ZXIzQxu/3tQ46So43TCkPBQkk0tOIfL/+18uGFSFSVuknb6aF2q4mvMp0g3coxU6UrU10ArbU5j7ROIpJa0icq+LCGkpbXrRp3L/TSB3gLTYpZmfbqKKGKPZeDxvEpir3EJDxoGhtsMwZE26dUR1ltNJRXD/DyfvX9a/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485205; c=relaxed/simple;
	bh=rZt1BDsL7XH/WgQBqMBRmA5UirvaAbx0lcp3+s2Jg20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY58q/LNgdcUmWkTFQFSLk/JENVqwgj06Msr39dt96SFaxDDTW8PikXuMftmrQmVOq9CRekeurkSSTdPm0+AKheWZlbkYZbRtV9BfGeZ6v7/YRDZ8ZCaFObwnzmGgwL+D71OjNyEifrK4m03ieRo/SaBsD06RS/PcWcmyPSsW+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ0sYz39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA742C4CEC3;
	Wed,  9 Oct 2024 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728485205;
	bh=rZt1BDsL7XH/WgQBqMBRmA5UirvaAbx0lcp3+s2Jg20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQ0sYz39EhEsQpXLIPdL81I7Nr1TbHPFSqBQuC8+MqmGrc6UuzlP1s40gxPm2deWD
	 yiEkad7/obJhbcHtFovfEwjYq52oliN4kXWqvOg2G8uKhAqZGQ4GAQXLYbtsaLHF24
	 qhJNufFQttCvCNNbTa/FhExlK18ezUowsxOvpw8DyxKxo2mCuBuJmqCzs6jO77WWdE
	 OEC2wBybTJDKiFvvqRan5wYhgw7bTXZF/d1/Gx61w75iHPSUMz5zWkiH0nEviTwpNN
	 3dAm8HFk9ljw/+Z8RBjQRT16I3IQzywNiHM3cNXtpqRH14ySCQijAqAT/J0Ocm3O4E
	 /eYidywDHXfcg==
Date: Wed, 9 Oct 2024 07:46:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: An Long <lan@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] generic/746: install two necessary files
Message-ID: <20241009144644.GK21840@frogsfrogsfrogs>
References: <9d7ef6a9de1cdd2bbb6d91a407905254c4784c68.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d7ef6a9de1cdd2bbb6d91a407905254c4784c68.camel@suse.com>

On Wed, Oct 09, 2024 at 04:45:37PM +0800, An Long wrote:
> parse-dev-tree.awk and parse-extent-tree.awk are used by generic/746.
> We need to make sure them are installed, otherwise generic/746 will
> have problems if fstests is installed via "make install".
> ---
>  src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/Makefile b/src/Makefile
> index 3097c29e..a0396332 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -38,7 +38,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize
> preallo_rw_pattern_reader \
> 
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>               btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> -             soak_duration.awk
> +             soak_duration.awk parse-dev-tree.awk parse-extent-
> tree.awk

^^ I think this is a broken line wrapping here, but otherwise the change
seems sensible.

With that fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
>  SUBDIRS = log-writes perf
> 
> -- 
> 2.43.0
> 
> 

