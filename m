Return-Path: <linux-btrfs+bounces-9797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991DA9D43E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 23:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7542834D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 22:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9801C1F11;
	Wed, 20 Nov 2024 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXdxpbYu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5620154BE0;
	Wed, 20 Nov 2024 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732141314; cv=none; b=ouCkehmPFh0NpBGm3j3ywXr+3zJhkLKUYDjDspoyJZZDDO5xa2D/o9D1eZGXYpA7DAGxQeNro9wuGADlAmbyacroOmekwvnwT1EEsYFlRaxn9m6Igrunj6B/K0eHe6OPjBldXnHWYt43/St/NvQXvOBw49FJdYDu9YogXmWisUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732141314; c=relaxed/simple;
	bh=SoroNqA40CTc4MCD+Dy3fguymXOPJHB9yu3SetcIPYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKwL1ItmZwyyYqmMpBN7dwnAHgXHDyc0X1K+T1Cx/UylJBAkKgVJchf/tOH1VHMsLNCoJB6mqVUj98ZT074fFzX/KdAHR866TP7PCPdvvroyBIHWNtRH9KISz25CuySe3xnviWuwRnOYGDnudvITcQKb5gbOf7ihA6ikyg6vu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXdxpbYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C89BC4CECD;
	Wed, 20 Nov 2024 22:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732141313;
	bh=SoroNqA40CTc4MCD+Dy3fguymXOPJHB9yu3SetcIPYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXdxpbYunQEEO2sy4f6HmdVID1JQ+Qa5VA5mHmrp9b70d6KCBOrNu31vsIC/8XDAP
	 RSy72iRwwYa/ltoRwc7qNq4co2HyUNe/WuPnTlF033pg9m9dfBnf+ZGNhvrN8IRGuL
	 P4PcnmgHmolDZqVb+mA+OojNoeXUKtGF2rJGgt3lGuLyr6+Mpwly1kj4uLHroo3f/X
	 VTgy3AYNfgjjc7Lo5ofMbXKi1xjHwdtpMnzGvbOc856+5nFB7dSTYe1lb/DH3bjU59
	 C+X16V+HNonfqQIHcMofIndVam2W4eoNPQc8MOug8VIkXHkYW35k2MRLvbomGqJxkN
	 oGTAJLUYQ93Uw==
Date: Wed, 20 Nov 2024 14:21:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fstests: fix blksize_t printf format warnings across
 architectures
Message-ID: <20241120222152.GD9438@frogsfrogsfrogs>
References: <c4847cd94f86bd98fc563f112e177b317dc21111.1732102551.git.anand.jain@oracle.com>
 <1141f20f-86e4-4638-adc4-5cb290f87691@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1141f20f-86e4-4638-adc4-5cb290f87691@gmx.com>

On Thu, Nov 21, 2024 at 08:36:58AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/11/20 22:10, Anand Jain 写道:
> > Fix format string warnings when printing blksize_t values that vary
> > across architectures. The warning occurs because blksize_t is defined
> > differently between architectures: aarch64 architectures blksize_t is
> > int, on x86-64 it's long-int.  Cast the values to long. Fixes warnings
> > as below.
> > 
> >   seek_sanity_test.c:110:45: warning: format '%ld' expects argument of type
> >   'long int', but argument 3 has type 'blksize_t' {aka 'int'}
> > 
> >   attr_replace_test.c:70:22: warning: format '%ld' expects argument of type
> >   'long int', but argument 3 has type '__blksize_t' {aka 'int'}
> 
> Why not just use %zu instead?

From printf(3):

       z      A  following  integer conversion corresponds to a size_t
              or ssize_t argument, or a following n conversion  corre‐
              sponds to a pointer to a size_t argument.

blksize_t is not a ssize_t.

--D

> Thanks,
> Qu
> 
> > 
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > ---
> >   src/attr_replace_test.c | 2 +-
> >   src/seek_sanity_test.c  | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
> > index 1218e7264c8f..5d560a633361 100644
> > --- a/src/attr_replace_test.c
> > +++ b/src/attr_replace_test.c
> > @@ -67,7 +67,7 @@ int main(int argc, char *argv[])
> >   	if (ret < 0) die();
> >   	size = sbuf.st_blksize * 3 / 4;
> >   	if (!size)
> > -		fail("Invalid st_blksize(%ld)\n", sbuf.st_blksize);
> > +		fail("Invalid st_blksize(%ld)\n", (long)sbuf.st_blksize);
> >   	size = MIN(size, maxsize);
> >   	value = malloc(size);
> >   	if (!value)
> > diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> > index a61ed3da9a8f..c5930357911f 100644
> > --- a/src/seek_sanity_test.c
> > +++ b/src/seek_sanity_test.c
> > @@ -107,7 +107,7 @@ static int get_io_sizes(int fd)
> >   		offset += pos ? 0 : 1;
> >   	alloc_size = offset;
> >   done:
> > -	fprintf(stdout, "Allocation size: %ld\n", alloc_size);
> > +	fprintf(stdout, "Allocation size: %ld\n", (long)alloc_size);
> >   	return 0;
> > 
> >   fail:
> 
> 

