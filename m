Return-Path: <linux-btrfs+bounces-11669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D84DA3E1E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F783AA439
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5027A212B04;
	Thu, 20 Feb 2025 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5J+IazE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411420D4E2;
	Thu, 20 Feb 2025 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071014; cv=none; b=GldgD6VGzMjSRXy3J7e7obhQtFxIO1EwzxXFYTQj1oOYbij3dBc0OlRe0myc4GFUJgwxOf9NxnpQxWX3GjmUlLzssTg1MaxLfEcqVkTbuqJIGcSO6uSxY06lgBl0x9IaiFiabaNZXIV+6p9VgthlvxgoBlJmOp1XZl4t8F9mYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071014; c=relaxed/simple;
	bh=OX3zVgBITRhakhwrq7UZ2lxr3CK8y45OpVp4ss++YI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0mL7gXfMxDpCsrWLHs1yvyo9xhqkZ0XJ1namdRop9cFWIbEgfWoBFyOe2AiuQlUe8QnrfsDMsnAtzs+nK8ozJ8p60o8gWnz8zGRSAqBvW23zXf3Wf/d9ISg2VmIZSjSgTQcFebI3iQUCxNU4YMCRYHUAnNVH7ME1oNQVeosp2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5J+IazE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A3FC4CEDD;
	Thu, 20 Feb 2025 17:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740071014;
	bh=OX3zVgBITRhakhwrq7UZ2lxr3CK8y45OpVp4ss++YI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5J+IazELyOoENwuoUk+haL58wFsSjQ/0KCbjqzcpKwsN9rYUtzErD6bvjAMoUBtl
	 h0Phm/IxXRy8VIebUWVSlYhXYhdFaoZ1yCho/JitnIXzRIKQ0eGgcO7XfZ4xvYD54V
	 6PnlO4RmBCB+I+9BT6MLVcYHIvhtcsT0n26JUg1r50hb+cs7Hn02XIwi9LzcIMJ2Gm
	 U1mpAcEJFxs5HvacI89W+03VETlibKp9GPq1vQzvmoTZPQr/O7Ka1beZCLtCd1ZOfF
	 hm3v/4zOHizxLcbZk61VGKM196UZ391mCwgrLZ0r+KUVSe/2PCLoPkWfCJvpONhQyu
	 Q5cswIKyfYjcA==
Date: Thu, 20 Feb 2025 09:03:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: fdmanana@kernel.org, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/2] btrfs/254: don't leave mount on test fs in case of
 failure/interruption
Message-ID: <20250220170333.GV21799@frogsfrogsfrogs>
References: <cover.1739989076.git.fdmanana@suse.com>
 <9aa6c8318d11b2fd1c2e208d85b2f83ea81ff88d.1739989076.git.fdmanana@suse.com>
 <d2d72753-5bf2-48cf-b2f0-cfe184ec75a7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2d72753-5bf2-48cf-b2f0-cfe184ec75a7@oracle.com>

On Thu, Feb 20, 2025 at 01:27:32PM +0800, Anand Jain wrote:
> On 20/2/25 02:19, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > If the test fails or is interrupted after mounting $scratch_dev3 inside
> > the test filesystem and before unmounting at test_add_device(), we leave
> > without being unable to unmount the test filesystem since it has a mount
> > inside it. This results in the need to manually unmount $scratch_dev3,
> > otherwise a subsequent run of fstests fails since the unmount of the
> > test device fails with -EBUSY.
> > 
> > Fix this by unmounting $scratch_dev3 ($seq_mnt) in the _cleanup()
> > function.
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   tests/btrfs/254 | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/btrfs/254 b/tests/btrfs/254
> > index d9c9eea9..6523389b 100755
> > --- a/tests/btrfs/254
> > +++ b/tests/btrfs/254
> > @@ -21,6 +21,7 @@ _cleanup()
> >   {
> >   	cd /
> >   	rm -f $tmp.*
> > +	$UMOUNT_PROG $seq_mnt > /dev/null 2>&1

This should use the _unmount helper that's in for-next.

--D

> >   	rm -rf $seq_mnt > /dev/null 2>&1
> >   	cleanup_dmdev
> >   }
> 
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> 
> 

