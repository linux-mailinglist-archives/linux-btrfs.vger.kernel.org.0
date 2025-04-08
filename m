Return-Path: <linux-btrfs+bounces-12877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD693A811E7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 18:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CCC88626E
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B62522E41B;
	Tue,  8 Apr 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnAG/ivK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E3722AE59;
	Tue,  8 Apr 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128639; cv=none; b=GooKwIJmhS6SPz/r2+q5KRzk9TGeKrbpxeYn5JxI1tQwdGwJSAZZqSlVndePDeUiRj69O4Bl+ZZfUQ+aOAt4IivUSXVg+CrWQjFjyUaTC9HzhFBDG0d+kJOpFVfgkChS36taJ1WF50YUhCsjYlzMvhyvKBPweTOG1bcm4m/AuSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128639; c=relaxed/simple;
	bh=nnjE8A9hH0LTvD7fVNOUTgMeMel7xJ+k0Gq6yPmF130=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plx5xhZ964M8Y24rna+P8FsB/VIv/7V1zdCXtX2P0UrWsiZdx4QNWxNfwJ0B234wMrEiJ92Wakg24iXXtZRV8b3K6DmP66IvZN4nm9KLuIWXvOD+SVRnUC8Noxr7er5roebk31JPt0T8s74Wu2sW9CJLRI6pxF8McZyluN9VopQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnAG/ivK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C00C4CEE5;
	Tue,  8 Apr 2025 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744128639;
	bh=nnjE8A9hH0LTvD7fVNOUTgMeMel7xJ+k0Gq6yPmF130=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YnAG/ivKPpWKTODadXa1sIdbTnTNogGlMLt0vMR/YuFEOtBlaWxDhdeQ/+2DQ1zGp
	 68f51vu/Or09repCUej0vXCYqA3ejdCehDE/yK6nH2D9LDN6BtBf16SVEMP6Uau2LB
	 BUR14u3qAD/GFq+q0/Ew1D3rDFE0BqAb4mz44p49GWiRh+WXxb8S+PD57irx8nVspw
	 G75Beg72jY2ewyjg4qtDt9Ho0LCgJ2h9tu9pWhXZb42mQx43YNUoFjhtI6gp+9llG1
	 MkA6/1+zslaKKN/VYS+GUkZPwkB0xJivJntpx3XRWhzqc0MJyWZ6T8OqrsauOAZcdX
	 u4SVNgkRxnjmA==
Date: Tue, 8 Apr 2025 09:10:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: Re: [PATCH v5 2/6] fstests: common/rc: fix unset seqres in
 _set_fs_sysfs_attr
Message-ID: <20250408161038.GE6274@frogsfrogsfrogs>
References: <cover.1743996408.git.anand.jain@oracle.com>
 <5e081252abdcf7253ad83d2b5eda49a8818305ad.1743996408.git.anand.jain@oracle.com>
 <20250407165847.GA6258@frogsfrogsfrogs>
 <06bcbb2b-934d-4b66-8ed8-9acaf1072a28@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06bcbb2b-934d-4b66-8ed8-9acaf1072a28@oracle.com>

On Tue, Apr 08, 2025 at 11:10:43PM +0800, Anand Jain wrote:
> 
> 
> On 8/4/25 00:58, Darrick J. Wong wrote:
> > On Mon, Apr 07, 2025 at 11:48:16AM +0800, Anand Jain wrote:
> > > Ensure logs don’t write to a `.full` file when `_set_fs_sysfs_attr()`
> > > is called during setup (before a testcase) in XFS due to unset seqres.
> > > 
> > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > > ---
> > >   common/rc | 11 +++++++++--
> > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index e89eee5de840..ca1d13ca1f0b 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -5201,6 +5201,13 @@ _set_fs_sysfs_attr()
> > >   	local attr=$1
> > >   	shift
> > >   	local content="$*"
> > > +	local logfile="/dev/null"
> > 
> > If we're not actually running a test, should the error output go to
> > $check.full instead?
> > 
> 
> Ah. I didn't know. It seems like no one is using check.full.

Oh, they do, but it's subtle:

$ git grep seqres=
check:852:      seqres="$check"
check:1120:     seqres="$check"

--D

> -----
> $ find . -type f -exec grep check\.full {} \; -print
> 	rm -f $check.full
> ./check
> -----
> 
> Thanks, Anand
> 
> 
> > --D
> > 
> > > +
> > > +	# This function may be called outside a testcase during setup,
> > > +	# so seqres might not be set.
> > > +	if [[ -v seqres ]]; then
> > > +		logfile="$seqres.full"
> > > +	fi
> > >   	if [ ! -b "$dev" -o -z "$attr" -o -z "$content" ];then
> > >   		_fail "Usage: _set_fs_sysfs_attr <mounted_device> <attr> <content>"
> > > @@ -5208,8 +5215,8 @@ _set_fs_sysfs_attr()
> > >   	local dname=$(_fs_sysfs_dname $dev)
> > > -	echo "echo '$content' 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full
> > > -	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full
> > > +	echo "echo '$content' 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $logfile
> > > +	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $logfile
> > >   }
> > >   # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
> > > -- 
> > > 2.47.0
> > > 
> > > 
> 
> 

