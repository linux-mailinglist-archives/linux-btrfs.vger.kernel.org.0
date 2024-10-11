Return-Path: <linux-btrfs+bounces-8869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C94799AF83
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 01:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E833F1F230CA
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 23:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB2B1E5732;
	Fri, 11 Oct 2024 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4Av9Hq/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0940919FA9D;
	Fri, 11 Oct 2024 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728690247; cv=none; b=u5YMko3IVxkOTzC/GDT5Ys9nX6enzaO+V6TT2ydZtGnzgSAHQqFChT+Df1RCt13ReP0fIUuU8qRhVrA5lK1VdgKWt1yuJ6Pv4HBoOPcv7Ah8vhu4Gf4U+L+pAQ+Jdzr4TAOo+VdmGzwO9pdPmMDJuoCpaHuK6wBX66IrZWn8lFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728690247; c=relaxed/simple;
	bh=T/7poQ0v58EGcoJVjCa2iY+JOM6wG2pJAUoXbiUGiwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIkxVvDjBwyDRe41YVg0kjoTCuMWHx4NA9rug/qX8Mw8Al6Z4fWqhR+9gL9ZuQkNwI7JyP+HJZ/YZSyZ0lCgKNlk0Cf2bWNU6KU20zZcEHsTgxnl9J6+ppN+kBeAk+vIfbRiXpU98ZB6WfhHtpty+a5dIkaUTl1np9FZWkaomvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4Av9Hq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A125C4CEC3;
	Fri, 11 Oct 2024 23:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728690246;
	bh=T/7poQ0v58EGcoJVjCa2iY+JOM6wG2pJAUoXbiUGiwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4Av9Hq/20wyjqf9ZpySsZaYhix+n02xq8S3RyMvceKWDTuC/zz1PWg2xXtZsKH54
	 pBWsVIQUBX/r3HWyymuO7NxyBypx4ug9AqkKhOGvixJ5Anxe64IuHfcT1FQdUypJ+5
	 VoZDGae0WT+bMAboBQn8AKQn1FP3AhMyUVfHdm0e+fafuo7CAbWymW+q3r9OaF7/vh
	 7uJG2Rc6JwGQ+PS19C/Hml8BU7gzjQVzMJ6Q8QgrC/uOkgBMRI1GWHGK4cQ0KThaPT
	 uSBfHORwcPEyDfA5gjSgyWRj0CNsrFppAlYkTIK53hx/f9nQZ9KcgjQg39wH2DErfZ
	 kiRNf7k3k8hMg==
Date: Fri, 11 Oct 2024 16:44:04 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@redhat.com>
Subject: Re: Root filesystem read access for firmware load during hibernation
 image writing
Message-ID: <Zwm4RMDAfMH-ussN@bombadil.infradead.org>
References: <3c95fb54-9cac-4b4f-8e1b-84ca041b57cb@maciej.szmigiero.name>
 <413b1e99-8cfe-4018-9ef3-2f3e21806bad@maciej.szmigiero.name>
 <ZwmwtZivKP8UDx1V@bombadil.infradead.org>
 <20241011233953.GJ21877@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011233953.GJ21877@frogsfrogsfrogs>

On Fri, Oct 11, 2024 at 04:39:53PM -0700, Darrick J. Wong wrote:
> On Fri, Oct 11, 2024 at 04:11:49PM -0700, Luis Chamberlain wrote:
> 
> Reads are generally supposed to succeed on a suspended system but if the
> read causes a write (e.g. atime update) they can block just like a write
> would.  So in the end you probably have to cache the firmware blobs in a
> tmpfs or something like that.

The fw cache stuff caches is it in memory to avoid these races on resume.

> > So.. we just now gotta respin the latest effort. I had stopped because
> > I know Darrick had some changes which he needed to get in sooner but
> 
> Do you remember what changes those were?  I don't. :(

Yeah I have a random tree somewhere lemme see...

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20230507-fs-freeze

Fortunately most of it is coccinelle smpl so should be easy to rebase.

  Luis

