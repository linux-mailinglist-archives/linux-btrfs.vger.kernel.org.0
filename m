Return-Path: <linux-btrfs+bounces-14752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328C4ADDD6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 22:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44DF171F31
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 20:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6E1132103;
	Tue, 17 Jun 2025 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgSJ0lqk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9578C1E9B3A;
	Tue, 17 Jun 2025 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750193306; cv=none; b=ah42a+SQjY+6JuBWs58wtPRVhap612/wU7g0O7NM13PCSmVhPCfliKgB8E+zAyfIPDFZQThnwEW0QYFp5J8kqKoVbaOTYsi25EfPcDGceWSk6dJVZnplfzO6eosB7r41XV89Dekiz7Td9iBSH21vX9SdmloY5KU1CGftvjC01cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750193306; c=relaxed/simple;
	bh=Wec92PgEyyyypFkgDUUa/r5kvbTpPe84rjzT+I7CgGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyzwj34IFGAjp6uXtaHDDnTvrpmbN/Hsg4XFiR/9Lm/DFZ+pZJDEFhfwM86vgb7KEtzGB2NZOTiMR2aZmRJ8x4mBpPBIMOqxezLS5t5p6myRd9imo4vBmvJAITUwAlaHleCEVGk2y6LyENzINRRJlFzfzfjeyYN6Y0N2qM8lcWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgSJ0lqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BCBC4CEE3;
	Tue, 17 Jun 2025 20:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750193306;
	bh=Wec92PgEyyyypFkgDUUa/r5kvbTpPe84rjzT+I7CgGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lgSJ0lqkBuEtJ1chPa4W9jPDllq9N2AjyD4mbN6tSXLughX0fEeaTftNIVJ7kk8V3
	 /ysj3OU0qgCaaTI8DuPOPGE7odUV0cnfCcAV+ZrZGRrSOSDIINlL5GA9mmBmvYhHQ6
	 td2nB3wliud1qlR4G99+QEBTcckMpp9R158DXC5g1dB6frhMZIT2LzoUhORQXaUdZw
	 ZFHq1LG2aeKAiLjhWR7DvJxi8EdSTD1BGzX8brKAGjDjs687TwfJuX5VzYrm3GnR+/
	 mjQyMVemT+6KVcdEsqlS7yzkKx4Fg7miyt0XB4/yQkh2RnMC99te7eKP3Q1DN9l58A
	 42bQUpgocBj8Q==
Date: Tue, 17 Jun 2025 13:47:56 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, linux-btrfs@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 2/2] crypto/crc32[c]: register only "-lib" drivers
Message-ID: <20250617204756.GD1288@sol>
References: <20250613183753.31864-1-ebiggers@kernel.org>
 <20250613183753.31864-3-ebiggers@kernel.org>
 <20250617201748.GE4037@suse.cz>
 <20250617202050.GB1288@sol>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617202050.GB1288@sol>

On Tue, Jun 17, 2025 at 01:20:50PM -0700, Eric Biggers wrote:
> On Tue, Jun 17, 2025 at 10:17:48PM +0200, David Sterba wrote:
> > On Fri, Jun 13, 2025 at 11:37:53AM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > For the "crc32" and "crc32c" shash algorithms, instead of registering
> > > "*-generic" drivers as well as conditionally registering "*-$(ARCH)"
> > > drivers, instead just register "*-lib" drivers.  These just use the
> > > regular library functions crc32_le() and crc32c(), so they just do the
> > > right thing and are fully accelerated when supported by the CPU.
> > > 
> > > This eliminates the need for the CRC library to export crc32_le_base()
> > > and crc32c_base().  Separate patches make those static functions.
> > > 
> > > Since this patch removes the "crc32-generic" and "crc32c-generic" driver
> > > names which crypto/testmgr.c expects to exist, update crypto/testmgr.c
> > > accordingly.  This does mean that crypto/testmgr.c will no longer
> > > fuzz-test the "generic" implementation against the "arch" implementation
> > > for crc32 and crc32c, but this was redundant with crc_kunit anyway.
> > > 
> > > Besides the above, and btrfs_init_csum_hash() which the previous patch
> > > fixed, no code appears to have been relying on the "crc32-generic" or
> > > "crc32c-generic" driver names specifically.
> > > 
> > > btrfs does export the checksum driver name in
> > > /sys/fs/btrfs/$uuid/checksum.  This patch makes that file contain
> > > "crc32c-lib" instead of "crc32c-generic" or "crc32c-$(ARCH)".  This
> > > should be fine, since in practice the purpose of this file seems to have
> > > been just to allow users to manually check whether they needed to enable
> > > the optimized CRC32C code.  This was needed only because of the bug in
> > > old kernels where the optimized CRC32C code defaulted to off and even
> > > needed to be explicitly added to the ramdisk to be used.  Now that it
> > > just works in Linux 6.14 and later, there's no need for users to take
> > > any action and this file is basically obsolete.
> > 
> > Well, not the whole file, because it says which checksumming algo is
> > used for the filesystem, but the implementation part is.
> 
> Oh, right.  It's one of those sysfs files that don't follow the normal sysfs
> convention and contain multiple values.  I'll update the paragraph above to
> clarify that it's referring to the driver name part of the file.

I revised it to:

btrfs does export the checksum name and checksum driver name in
/sys/fs/btrfs/$uuid/checksum.  This commit makes the driver name portion
of that file contain "crc32c-lib" instead of "crc32c-generic" or
"crc32c-$(ARCH)".  This should be fine, since in practice the purpose of
the driver name portion of this file seems to have been just to allow
users to manually check whether they needed to enable the optimized
CRC32C code.  This was needed only because of the bug in old kernels
where the optimized CRC32C code defaulted to off and even needed to be
explicitly added to the ramdisk to be used.  Now that it just works in
Linux 6.14 and later, there's no need for users to take any action and
the driver name portion of this is basically obsolete.  (Also, note that
the crc32c driver name already changed in 6.14.)

