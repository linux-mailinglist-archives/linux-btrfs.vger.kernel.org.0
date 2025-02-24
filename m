Return-Path: <linux-btrfs+bounces-11747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D2A42B1A
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 19:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163C01890E07
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 18:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CF924394F;
	Mon, 24 Feb 2025 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5j51DpS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D1D265CBF;
	Mon, 24 Feb 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421135; cv=none; b=C0aUeQc5lkg3/oTMFv7RfnyBZMOYsB+uNE0+pQdgVHjBlTYWC0ZoDYCRj6zX1wubrqfzAULhSYivejL/XN1Qe4WKNPkxkZmsb8pLd5weaRFpQMYKG42kc/5PezbDJPCPniS0MH4SswyzlGx/u0c1Ggu09kCyIMCWGF6vOsbZZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421135; c=relaxed/simple;
	bh=2mg1avw/PiNF4XVt7bVe0O569/2GhiFh7nOGBRqUuKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm4WLTkkSoE2D1mVS5ThOJJFn9GcJzeVHHRp8P3p7eu4idpO+Vpjg0V3XT39dXH3wXcaYnw7nyFt+HadSRogUaDoLC0tBull4F1sl9t+zFmN3HrKT/TS0hvQrAQsbH4LhPUXKb3rZVA+3T+66fCOFI21OTQCxUOSpxYDrAZOG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5j51DpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA286C4CEEA;
	Mon, 24 Feb 2025 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740421135;
	bh=2mg1avw/PiNF4XVt7bVe0O569/2GhiFh7nOGBRqUuKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5j51DpScS0YY9wvq9uBEh8jNvAbwHmE85ul06TrsxA9im2z53VivcfcWkIEyeCc/
	 WM0Nao0XbErgE15Zv+xbBemOwm9m1MQkC/DJy+5fSUpUomBoKMu9MTyGUHKQfHGnX7
	 tCY59tpOGoT17wTTIChfKBzXeR3cL77JjVTzdHW2ssj01+tRej1sc1hJDSqOeKVuyr
	 nToyeloOwpQKd9TXK2rx/aZMt7+UPE9IVEhMgRgE+BuKHbStLx38/JPALhNHPXXG7d
	 5xfmleg6DvB/iVJN4zYbRwfvucWIIotH3BCi2ZXIDW7z5klFVAeJXU1ohvqynXkF/v
	 r/HM6g5bu5bIw==
Date: Mon, 24 Feb 2025 10:18:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v3 1/5] fstests: common/rc: set_fs_sysfs_attr: redirect
 errors to stdout
Message-ID: <20250224181854.GB21799@frogsfrogsfrogs>
References: <cover.1740395948.git.anand.jain@oracle.com>
 <e18babf503e66ce798c3df4353174afd4f771303.1740395948.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e18babf503e66ce798c3df4353174afd4f771303.1740395948.git.anand.jain@oracle.com>

On Mon, Feb 24, 2025 at 08:15:04PM +0800, Anand Jain wrote:
> Redirect sysfs write errors to stdout as a preparatory patch to enable
> testing of expected sysfs write failures. Also, log the executed
> sysfs write command and its failure if any to seqres.full for better
> debugging and traceability.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/rc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index cf6316a224ff..942e201649dd 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5081,7 +5081,8 @@ _set_fs_sysfs_attr()
>  
>  	local dname=$(_fs_sysfs_dname $dev)
>  
> -	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
> +	echo "echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full

Did you mean to    ^ escape ^ these double-quotes?  Without it,
whitespace in $content might not be logged correctly.

--D

> +	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full
>  }
>  
>  # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
> -- 
> 2.43.5
> 
> 

