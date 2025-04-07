Return-Path: <linux-btrfs+bounces-12836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B076A7E7BE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF97A175276
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 16:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B432E214A6C;
	Mon,  7 Apr 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIKRqm+x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024DB2144D4;
	Mon,  7 Apr 2025 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045128; cv=none; b=hnTlrcIXSGZiiYJoagfjZ10cuW/qN4O8K0ZAaZd4cMJP/Y0BYBjANPXiV0DOzz6Hg0t6PoOHaVwYWqhusR6RLxXQxunTyVkwN3/xPgNmZ5sOuDQhhTYtkloqZEH24Tv0m9r8meU7F7Cox1HwHALf3oVb1UnUEyvmyfdhauoLr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045128; c=relaxed/simple;
	bh=/RWfTipcwgOur9TXUsz/EWqA5eTY0InHbfCcXaLoitc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mo2/MCbWY+01V0qI0LuI+xyUJ1nVZb+I/qaBIB6JKUXnhw74+SbWg7PLahL6ziJbUwKc37by+LwAQyR2BhYlAf6naYi6p3vrK9O/q1e8Xq893c6pZvOOohaEntdj8WIWh/jL/hEhr4fNFZqFxbj9mxLBFO84Bot+tEvuEDPT37I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIKRqm+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87D9C4CEDD;
	Mon,  7 Apr 2025 16:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744045127;
	bh=/RWfTipcwgOur9TXUsz/EWqA5eTY0InHbfCcXaLoitc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JIKRqm+xZnqPEs7k7kxqajZ4hqFmc4isiR3Nb5eb+47vxXA+XhP3Tk2Qu7MgkqtEr
	 +16Z6E+6QIFbgGTa4qCPKZm6tTHTKT5RGraBd6p1gRchxX5JhYDjBo9to/LwtubFi5
	 xUQPmJ46oTiGz43er6buKlrczhVxOJD0ipTBdm8sqgXESIzCEwy0JQ7kx5EE2Ux7wq
	 VLC7BqQ6pdZiId2xeaDPie0qrr1c+RT/ypREcDw5IWRluS2WQE1J3yo+aVTbpAOC5P
	 4h3drlTYpk4xaIZGPjZkXCAOfi500ADqgwGDP5nfJOnFXkgnWcWDK/HZRUklUtfxuO
	 LjDQAmo5hfOsA==
Date: Mon, 7 Apr 2025 09:58:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: Re: [PATCH v5 2/6] fstests: common/rc: fix unset seqres in
 _set_fs_sysfs_attr
Message-ID: <20250407165847.GA6258@frogsfrogsfrogs>
References: <cover.1743996408.git.anand.jain@oracle.com>
 <5e081252abdcf7253ad83d2b5eda49a8818305ad.1743996408.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e081252abdcf7253ad83d2b5eda49a8818305ad.1743996408.git.anand.jain@oracle.com>

On Mon, Apr 07, 2025 at 11:48:16AM +0800, Anand Jain wrote:
> Ensure logs don’t write to a `.full` file when `_set_fs_sysfs_attr()`
> is called during setup (before a testcase) in XFS due to unset seqres.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/rc | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index e89eee5de840..ca1d13ca1f0b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5201,6 +5201,13 @@ _set_fs_sysfs_attr()
>  	local attr=$1
>  	shift
>  	local content="$*"
> +	local logfile="/dev/null"

If we're not actually running a test, should the error output go to
$check.full instead?

--D

> +
> +	# This function may be called outside a testcase during setup,
> +	# so seqres might not be set.
> +	if [[ -v seqres ]]; then
> +		logfile="$seqres.full"
> +	fi
>  
>  	if [ ! -b "$dev" -o -z "$attr" -o -z "$content" ];then
>  		_fail "Usage: _set_fs_sysfs_attr <mounted_device> <attr> <content>"
> @@ -5208,8 +5215,8 @@ _set_fs_sysfs_attr()
>  
>  	local dname=$(_fs_sysfs_dname $dev)
>  
> -	echo "echo '$content' 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full
> -	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full
> +	echo "echo '$content' 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $logfile
> +	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $logfile
>  }
>  
>  # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
> -- 
> 2.47.0
> 
> 

