Return-Path: <linux-btrfs+bounces-3621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4837A88CE38
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 21:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE5EDB2515E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 20:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445D213D2B6;
	Tue, 26 Mar 2024 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="OlNqAa5Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="faVLjkaW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7059D13D2A3
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484507; cv=none; b=QNqjTZUIlBq72pJ7nBchHHAPvVhfdBpX7GIPPc2NC9ZRp8rUeTN5EvW0nAd7o6sg/Lpcq6iX9JtYfzsowLtGW/I4G5EzbN72MhG1gnSgTdpYDqowAMJbvsB8u9VERTaizS8tW8+trX8vvdxyHFnt99PzlYRShbSrps+BgVvte1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484507; c=relaxed/simple;
	bh=a+qrEG3PN19xPI/PaNlwVUPD2UInFO/1qdqf/643Sb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4nbQKMLqhHIBcFpJ8jGJIBpX9/8r4ayhipbHuVxNHAFE8hKHB71QnFjq12r9aSKZ5/w97AgmDwDKfCIaoPpHtoJpf3eiz8rROeLuRpqNLcjrDAMSbZ6Rq6e8VwhVocwro2YlTABfHTONRcUHTfVG8yN3F8+glpZKWCGfcyX16A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=OlNqAa5Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=faVLjkaW; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 46D653200564;
	Tue, 26 Mar 2024 16:21:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 26 Mar 2024 16:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1711484503; x=1711570903; bh=gj4MXk5AiV
	qn89KVYR29Gh0Lt3MTsyLPg7Lnbswr6E8=; b=OlNqAa5ZgOJdCUuw1m/g1O1dwv
	7tH3Ay4onAcPmN56JgTBMpcWohrg2PfiaG03Gd1l/sy6k9FQEPuReGnnFsFJSTWv
	9AKJrWflpL8ranRc2QAgNrZ9UmIW8UElEQ4iIAWTNW752+Bm/sMp9Y84umAtzR2w
	AGgrsXJyEtYdYoKx/Msu9oIt66c+puIBDb4qHiRPXEK6JdJmn70Y8SmAs3Ixh/bX
	pj7EFQsrzu7PadFnEXXVkGs1REyMvHzofwO5CTffjIhIZbgtmsY7im+qUm/QeEvW
	3nF/EMJ/mB+WuJx4zk+eivWYy/VSvQmZVZ2n7b0Hy9n7yTel7tvXoAEkCJ7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711484503; x=1711570903; bh=gj4MXk5AiVqn89KVYR29Gh0Lt3MT
	syLPg7Lnbswr6E8=; b=faVLjkaWkDaF+v5A2SxpnLkq/q/FXD3Ds7Harz71wNgR
	7CUGYYm5XXQ77vCTZmQeeJgmBj2MwHevOAz4D4yM9r9dgEeeetLFNvQnxXks7Blq
	VhgwV0ifCoAVV6fRhPDgrTEz4gWbWrbbcHYuXSA5jVWz11fmg/RoxWjazOnQRu/P
	4KHcg8r8oNwZAM/hFVlAuz+E7XeT7FFUb+dFSylScZcoUVKSQfG4gE6RT2oRAn6M
	ZYNt+5v1uulldMGQRux1C8Nc4cbWlKmq6JUlkcxL+tEgLUvA/yqVmCYJUpGHIdPf
	icvowicQtyKSF9m7MLeIPEVeTzE+xEVzYIah3KHgHw==
X-ME-Sender: <xms:Vy4DZlTk-21izGXwuYb5Igcn4-WljEFt-41cXdandg0afId8Rh1Qog>
    <xme:Vy4DZuzLycAGm3diEx_Nc5Kmvf7wI7sOvoRUtIiWuASg0XiOx_dn5LLO6cYSsFpT5
    fIL5q05q2zBpg3dkGA>
X-ME-Received: <xmr:Vy4DZq0zEgBQgTWsfOOO4nikLEXKhWAscGVD28zxI-m1nOWn47Tu1Zgshisx6fflB3WHX9FfPXd2lLPhyf-wFELQ0ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:Vy4DZtDajFDtq5ZN1--9I6gRLdzIk_iNSvqw3k-nViGNNO9Q2u_LIA>
    <xmx:Vy4DZujOkyzeHga6_bmoIUr2w8yjhiuRAL_xZ_SAmYJlGbxMRSx6cw>
    <xmx:Vy4DZholmjU2HwCTnoPi_7dnNBhu7tqIUUoR1dZIda9eMrUKwq4F1A>
    <xmx:Vy4DZpi5jIKI-GCgSivMZ8RokJI-Vxwsu0CHVL87E2XGmb1h40iOTA>
    <xmx:Vy4DZhvR4khWlGKnJ_Z84WqyqS7ZLwimr10_QgmbLbysIP71hHVOJw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 16:21:42 -0400 (EDT)
Date: Tue, 26 Mar 2024 13:23:49 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: subvolume: output the prompt line only when
 the ioctl succeeded
Message-ID: <20240326202349.GA1575630@zen.localdomain>
References: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
 <20240301125631.GK2604@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301125631.GK2604@twin.jikos.cz>

On Fri, Mar 01, 2024 at 01:56:31PM +0100, David Sterba wrote:
> On Tue, Feb 27, 2024 at 02:41:16PM +1030, Qu Wenruo wrote:
> > [BUG]
> > With the latest kernel patch to reject invalid qgroupids in
> > btrfs_qgroup_inherit structure, "btrfs subvolume create" or "btrfs
> > subvolume snapshot" can lead to the following output:
> > 
> >  # mkfs.btrfs -O quota -f $dev
> >  # mount $dev $mnt
> >  # btrfs subvolume create -i 2/0 $mnt/subv1
> >  Create subvolume '/mnt/btrfs/subv1'
> >  ERROR: cannot create subvolume: No such file or directory
> > 
> > The "btrfs subvolume" command output the first line, seemingly to
> > indicate a successful subvolume creation, then followed by an error
> > message.
> > 
> > This can be a little confusing on whether if the subvolume is created or
> > not.
> > 
> > [FIX]
> > Fix the output by only outputting the regular line if the ioctl
> > succeeded.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Added to devel, thanks.

This patch breaks every test that creates snapshots or subvolumes and
expects the output in the outfile.

That's because it did:
s/Create a snapshot/Create snapshot/

Please run the tests when making changes! This failed on btrfs/001, so
it would have taken 1 second to see.

