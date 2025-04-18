Return-Path: <linux-btrfs+bounces-13155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4741FA92F9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 04:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0C61B61C0C
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 02:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE2C266F01;
	Fri, 18 Apr 2025 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mvqb0B6Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD66266EF9;
	Fri, 18 Apr 2025 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941774; cv=none; b=DpFlrseF9O7DimQg3MSiJCLr23/dQ/0TMAC1wteUcDaiPl8d6qnmrPmjhP3W/64+YhxoyEhgP4Bel3qVBX5qZm7TzJ5a9JJdLJcXiF2vhEkRjovhyaC+WgDGUGADEHJWhl2JWuhgWQK4+QxjlHtfW5TSIYdiiB2Uo24ikeGS4oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941774; c=relaxed/simple;
	bh=PxFVNn7Ji1Dpt9HMNQnbI2Ioxn9KKptoT2yEoBTEOcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRENaPerKIwc16sScWjr2rfsUi4zAkgwX/7Y1A7zPsB/sjmBkCfzUV2uk3uW/oPJVGmf67CChF7bQjIrr0WxGqNRZv9sbXit6jkNvzxjELJYXyPDDWdSs/C+dVNdmqHSgHo948PYvt+Qxt4QyNmAJ+O776dwrKm4Q6Yre7LjKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mvqb0B6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F868C4CEE4;
	Fri, 18 Apr 2025 02:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744941774;
	bh=PxFVNn7Ji1Dpt9HMNQnbI2Ioxn9KKptoT2yEoBTEOcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mvqb0B6Zr4XP6vvI8iTNzrtJItL/k9ma4ZCCgN24S4l906x+sTWm4qMuZlc+Sujv6
	 klomh8OcSU9C006zQ5hqoAMNi9vAinZ58L71OAawG0oEr6JqfJmHtCuB6fJ2WqKtdc
	 f5pyEd04K/qK80OtIlB77mRAXnqLnuko3rFAQ9teXcW6Vp8USENtCSxn5I6kwSB4QV
	 UgK1K3/XJPj4o3QAam+JxZMGywdDeezmoy3eMLD2OFFXRF6tJtUbDRdnDvhejdpom9
	 uieexVojP6ZP0ISTgnLEUPm3oRU53+7sbA4XBxQ1Ka/Z8Q/8yG6VPyeYL17WzK5tMs
	 RklqcgShRaYEw==
Date: Thu, 17 Apr 2025 19:02:52 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	kdevops@lists.linux.dev
Subject: Re: btrfs v6.15-rc2 baseline
Message-ID: <aAGyzAx6p9-IxZN3@bombadil.infradead.org>
References: <Z__4Fu6VsCVDFKkO@bombadil.infradead.org>
 <8ad1f78e-3ea0-4a50-8d9b-f0078ff0f810@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ad1f78e-3ea0-4a50-8d9b-f0078ff0f810@gmx.com>

On Thu, Apr 17, 2025 at 07:45:24PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/4/17 04:03, Luis Chamberlain 写道:
> > btrfs developers,
> > 
> > kdevops has run fstests on v6.15-rc2 across the different btrfs profiles
> > it currently defines, and the results are below.
> > 
> > The btrfs profiles which kdevops currently supports are:
> > 
> >    - btrfs_simple
> 
> It looks like the simple doesn't really mean "simply the default mkfs
> options"?
> Which is a surprise to me, as I'm digging into all the failures and only at
> generic/015 I noticed this.
> 
> I really wish you can put `default` as the first profile.

The [default] is an optimization we have in kdevops which we can
upstream if folks think its useful, so that we don't repeat the same
crap over and over for each profile.

So its not a test target profile.

> >    - btrfs_nohofspace
> >    - btrfs_noholes
> >    - btrfs_holes
> >    - btrfs_holes_zstd
> >    - btrfs_noholes_lzo
> >    - btrfs_fspace
> >    - btrfs_noholes_zlib
> >    - btrfs_noholes_zstd
> > 
> > These are defined in the btrfs jinja2 template on kdevops [0] and described
> > on the ext4 kconfig [1]. Adding support for more profiles is just a matter
> > of editing these two files, please feel free to send a patch if you'd like
> > kdevops to test more profiles. A full tarball of the fstests results are
> > available on kdevops-results-archive [2]. Since we leverage git-lfs, you can
> > opt to only download this single tarball as follows:
> > 
> > GIT_LFS_SKIP_SMUDGE=1 git clone https://github.com/linux-kdevops/kdevops-results-archive.git
> > cd kdevops-results-archive
> > git lfs fetch --include "fstests/gh/linux-btrfs-kpd/20250416/0001/linux-6-15-rc2/8ffd015db85f.xz"
> > git lfs checkout "fstests/gh/linux-btrfs-kpd/20250416/0001/linux-6-15-rc2/8ffd015db85f.xz"
> 
> I guess it's better to name the archive as "*.tar.xz" (so that
> *sh-completion can work).

Done. Pushed for new tests.

https://github.com/linux-kdevops/kdevops/commit/7af3abbefc05a156e63dc2ebb034d0de3f2f7f23

> > Few questions:
> > 
> >   - Is this useful information?
> >   - Do you want results for each rc release posted to the mailing list?
> 
> Definitely yes for both answers.

Fantastic.

> Especially the history of each release (each rc may be a little overkilled,
> normally -rc1 and release would be good enough) is very useful to do a quick
> pin down of certain bugs.
> 
> But before the quick failure analyse for btrfs-simple (really bad name
> though), I'm wondering why there is no default one?
> I can not find the default result inside the assets.

The [default] is an optimization we have so we don't have to repeat the
same crap for each profile.

There really is only two files for adding new btrfs files to test in
kdevops for btrfs:

https://github.com/linux-kdevops/kdevops/blob/main/playbooks/roles/fstests/templates/btrfs/btrfs.config
https://github.com/linux-kdevops/kdevops/blob/main/workflows/fstests/btrfs/Kconfig

Adding that to the CI drop down menu to let you configure if you want to
reduce scope to test is just one line change here:

https://github.com/linux-kdevops/kdevops-ci/blob/btrfs/.github/workflows/kdevops-fstests.yml

Care sending a patch to add new profiles you think we may need? In order
to scale a kernel-ci for the community I am convinced we need to have
folks chip in small ways they can, I hope the above is not *much* to ask
for for adding new filesystem test target profiles to support.

In fact it'd be great if someone might want to just be the maintainer
on the kdevops side of things for btrfs.

> Before I dig deeper, I really hope a default mkfs option run can be added.

Patches are welcomed, I hope I made it easy. I also just updated the
version of fstests that kdevops uses to the latest tag out. So we can
push another version of tests and include a default profile in the
next run.

  Luis

