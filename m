Return-Path: <linux-btrfs+bounces-9789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646BD9D4008
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 17:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339D328335D
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E391C14F108;
	Wed, 20 Nov 2024 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeqHHHOd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFAC13D638;
	Wed, 20 Nov 2024 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120108; cv=none; b=dCAJV894TkFcxtIQWJR9kCxXjO/M+vnfkzvYWAuCeoO+9JqxMKsQKvlig5ejgVoat2ZLxudESekjhNydQ8gMdM96LWpD8WZYYOYR2kpO+B4PEaUgmzBwdVkcRM3btIaVQX0bV2nJPUcQR9wf3YHwVYVWz5ajo8ZerNZU8NogwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120108; c=relaxed/simple;
	bh=FwCA5kpv5qBVIFi6jHShRB71izAMJl84UI018I3EImk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrOkK8n3/oSQ/8ym3Lls+IpsKA/zGpbHvlXVlBUVuK8+zLGUxSnMfZNPMOJv3SNNWCuF5He4k3Lg0qagX/5OEP2sfW9Z8mEuPAkv1rZFUgtA1J2jg24WwaV0G9BIB5/GWmaR7b3axcdTRbacrtjXLgiWw112JaaaxEOUSGFlkNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeqHHHOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6362CC4CECD;
	Wed, 20 Nov 2024 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732120105;
	bh=FwCA5kpv5qBVIFi6jHShRB71izAMJl84UI018I3EImk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZeqHHHOd/fueuNwvyIx/uID2irjKJ9kFoJLTgqPiaZN1qmmuXZDmv5onILfpTIWvH
	 bWW1M1lBXjGTg4WpaUr6a1YJIV+feCQlSNuDWTR0h3sY2ZE0d24GrbGSNFUZIiEbdZ
	 1Ay29mSRSsJNl0i2J17gEuMoysQL8ee/8dT0KsEMYIkjL98k048MdFUAxKALBOUbm8
	 KV7f4PN4q83ucMqfe1rcH2BaypwSdHaJmrpuLFu02Kqc5KPSpaE/TcBAjOWEjiEg6Q
	 or+OTrEZAnQpxrejwrX6Y/8QAO3TlK3P0gE8S1vtA57n0piXpvwD7GhGXvlQYdZmai
	 Umy2c1Db8puZA==
Date: Wed, 20 Nov 2024 08:28:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fstests: fix blksize_t printf format warnings across
 architectures
Message-ID: <20241120162824.GC9438@frogsfrogsfrogs>
References: <c4847cd94f86bd98fc563f112e177b317dc21111.1732102551.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4847cd94f86bd98fc563f112e177b317dc21111.1732102551.git.anand.jain@oracle.com>

On Wed, Nov 20, 2024 at 07:40:41PM +0800, Anand Jain wrote:
> Fix format string warnings when printing blksize_t values that vary
> across architectures. The warning occurs because blksize_t is defined
> differently between architectures: aarch64 architectures blksize_t is
> int, on x86-64 it's long-int.  Cast the values to long. Fixes warnings
> as below.
> 
>  seek_sanity_test.c:110:45: warning: format '%ld' expects argument of type
>  'long int', but argument 3 has type 'blksize_t' {aka 'int'}
> 
>  attr_replace_test.c:70:22: warning: format '%ld' expects argument of type
>  'long int', but argument 3 has type '__blksize_t' {aka 'int'}
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

I waded through a whole bunch of glibc typedef and macro crud and
discovered that on x64 it can even be long long.  I think.  There were
so many levels of indirection that I am not certain that my analysis was
correct. :(

However, I don't see any harm in explicitly casting to long.  Nobody has
yet come up with a 8GB fsblock filesystem, so we're ok for now. :P

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  src/attr_replace_test.c | 2 +-
>  src/seek_sanity_test.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
> index 1218e7264c8f..5d560a633361 100644
> --- a/src/attr_replace_test.c
> +++ b/src/attr_replace_test.c
> @@ -67,7 +67,7 @@ int main(int argc, char *argv[])
>  	if (ret < 0) die();
>  	size = sbuf.st_blksize * 3 / 4;
>  	if (!size)
> -		fail("Invalid st_blksize(%ld)\n", sbuf.st_blksize);
> +		fail("Invalid st_blksize(%ld)\n", (long)sbuf.st_blksize);
>  	size = MIN(size, maxsize);
>  	value = malloc(size);
>  	if (!value)
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index a61ed3da9a8f..c5930357911f 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -107,7 +107,7 @@ static int get_io_sizes(int fd)
>  		offset += pos ? 0 : 1;
>  	alloc_size = offset;
>  done:
> -	fprintf(stdout, "Allocation size: %ld\n", alloc_size);
> +	fprintf(stdout, "Allocation size: %ld\n", (long)alloc_size);
>  	return 0;
>  
>  fail:
> -- 
> 2.47.0
> 
> 

