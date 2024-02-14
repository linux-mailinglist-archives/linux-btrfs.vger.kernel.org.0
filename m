Return-Path: <linux-btrfs+bounces-2396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD26985549D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 22:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A61A28BC2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 21:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B313F006;
	Wed, 14 Feb 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="dHodetJs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VdxBy/iX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3001B7E2
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945661; cv=none; b=DXhsAG17mL00PBS31ayhANTf64z+/bfd68bQNogkFiNmNkbtu1Kp2Mbuc4rSse0ziKe2sjABRvjoXo/nDsi/998iPp2N6lnBxcGIjI2FUFxPt0jENXbL8vSdLwfyyteZ/EnyAhrZc7zVSg4iIsyHu1rFT5wxGU2j6H0xqkK3DIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945661; c=relaxed/simple;
	bh=Ic3iOB9uMSA1c1zTXuYxp0D9zrBy+3imnoKILZgQ4a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S81+lCBAMY634RDhPiQyQEwoa+DDXKuxlwbwvRlRy5EAkgXL9ZTNMiDt28Cuqi9BYvw/3ndcQoaaRYiud3yykP+Th0cxr4pItPfaoTTj+WR+LAVEN5COCP3AZgTPctz4uLvWd1kSXuiCFDTMk/3vR5kRMQ4Dgsc+1U46J6fDEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=dHodetJs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VdxBy/iX; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 5B3C33200A3C;
	Wed, 14 Feb 2024 16:20:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 16:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707945656; x=1708032056; bh=IvU+YmnKLh
	5USnFCyPmgk4VXGlhSOeDP3Lp1FSzY4ds=; b=dHodetJsJlgQ4KEbro0M/6i2oP
	BdxPdpmMopHyk8SZ48rDdalNUskwe9OOD61/T3n30OUimW/zw9ZZI8xZ7hPweBF9
	9LLw1sJoveDSaSCyq95jjKniwMkcXEjHgWg7C9vxW5esWG04putIGP7KNuZSTC+1
	xMDG9y2saKErxMrWJmCK7vBCRg8IMWFNLecMFvLmgUtoqyXhP9qob93bwJRwaFlk
	yECFBswfONP4j982mG7/U9nWJqZHpy3bM9MV3qUqVZvq3NSl4AG1reTMJMizFyf4
	cXzJEHLjLIUzkZnaBu6AtAfjj2ggUIrtNtwmI5PZFQVS11/zF7IgzsXDZlLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707945656; x=1708032056; bh=IvU+YmnKLh5USnFCyPmgk4VXGlhS
	OeDP3Lp1FSzY4ds=; b=VdxBy/iX9w/OS4Vqd8Wzi2SInWBUUtQRnFREKj7lDY9u
	oJZNqbmuGn4JNv/jt4aBxW0+VWtkwLOt8DZLvjkmrfeHErokVzLzqreey5b3G3sz
	/27hFT1XXuJSmI1SnOQQfgC15UZItv6FLs0SBvxMyuXMInwo09WYeN2TpPq6Eh5x
	TBTJenIvYOxN7eU/m29kTD470q6CL1KlEi/ZwXEKyC6Fkn3giUhm9fgBNH3OcFEc
	TfWdyfTGbNi97C6Ex7COfO+TXbxc3TDRnmM7l8rCadP66/eIJEDv7cIrv0j9Coyb
	03E3nGstQ+qTMQ3ufY4NVVczWtVzWaTIhwvbqIjxfQ==
X-ME-Sender: <xms:uC7NZbSzU5Ls2ykQy4q3cb8_V6KObYPWknHBRGLX8ylhvn1ha9R0aw>
    <xme:uC7NZcxX_Ypvy6Pw5HRtFCD0QcwEO8etzmXMS9b69j36lTDR3-4NSvO_iLl9bxWZ4
    E3X45XvUFlOibZaDJM>
X-ME-Received: <xmr:uC7NZQ0CMJrk_9omltlIZhLr-Hv7uScK80HL-eHAh69QGkSFAjJlfn5VajN1MgfuxXPUZrrHe-0iaW0SUZVJ-Rhxgho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehtdfhvefghfdtvefghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:uC7NZbD5JzebXdW-qBIaXEum1tFBVfKvLaWoQQnnAntHOUzVQRLBkQ>
    <xmx:uC7NZUg03XDE0_8nMZGm-q4qzg23b7GhjiwCTv-9ZURsY6UbN3gUOA>
    <xmx:uC7NZfqObu5Eg0jkA0xgQf23GhnSPG_ed0NzJUMy0DHU3mB83OGAjg>
    <xmx:uC7NZQaLAnJ8ywbnTZrtoVB0-RQeg0fgG1RvWaKsFIYf31a-W7Uexw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 16:20:56 -0500 (EST)
Date: Wed, 14 Feb 2024 13:22:32 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, Edward Adam Davis <eadavis@qq.com>
Subject: Re: [PATCH 0/3] Ioctl buffer name/path validation
Message-ID: <20240214212232.GA480208@zen.localdomain>
References: <cover.1707935035.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707935035.git.dsterba@suse.com>

On Wed, Feb 14, 2024 at 07:31:54PM +0100, David Sterba wrote:
> This is inspired by a report and fix [1] where device replace buffers
> were not properly validated (third patch). The other two are doing
> proper validation of vol args path or name so that an unterminated
> string is reported as an error rather than relying on later actions like
> open that would catch an invalid path.
> 
> (I'm OK to replace the third patch in favor of Edward as he spent time
> analyzing it but we did not agree on a fix and I did not get a reply
> with the suggestion I implemented in the end.)
> 
> [1] https://lore.kernel.org/linux-btrfs/tencent_44CA0665C9836EF9EEC80CB9E7E206DF5206@qq.com/

LGTM. One note/question: would it be helpful to pull out:

```
if (memchr(str, 0, str) == NULL)
        return -ENAMETOOLONG;
return 0;
```

into a helper and use it in all these places?

Either way,
Reviewed-by: Boris Burkov <boris@bur.io>

> 
> David Sterba (3):
>   btrfs: factor out validation of btrfs_ioctl_vol_args::name
>   btrfs: factor out validation of btrfs_ioctl_vol_args_v2::name
>   btrfs: dev-replace: properly validate device names
> 
>  fs/btrfs/dev-replace.c | 24 +++++++++++++++----
>  fs/btrfs/fs.h          |  2 ++
>  fs/btrfs/ioctl.c       | 54 +++++++++++++++++++++++++++++++++++-------
>  fs/btrfs/super.c       |  5 +++-
>  4 files changed, 72 insertions(+), 13 deletions(-)
> 
> -- 
> 2.42.1
> 

