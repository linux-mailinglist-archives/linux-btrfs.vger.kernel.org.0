Return-Path: <linux-btrfs+bounces-3624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B05A88CF00
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 21:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1401F83DCD
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 20:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79503140E30;
	Tue, 26 Mar 2024 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="NE1uHLOp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wh1v6Tac"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A012B15D
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485113; cv=none; b=YO3EKxKBNfvmnPFwvqRa46XwTqntfXRyEFhX/Ays2BRMSZSro2opoJCIBvkZjM31RDhg0JcKakyY/458fI4vrRQCo7rnMH2sJMZx+Ap4nyPs0eZR3Bb8uuluueR1DRrn2xh85WDB/xhcmPqSpFvCQxUdedKp9aSjur+pGLhuzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485113; c=relaxed/simple;
	bh=tGhtXT6CT/bMFYXGC2z205veIzhN2E4vPI4HadUPETg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMf8iKM0BBp/U5/z/idiPn44v00ORS4el44lYyC5F1HgsaAcVRf5Exr+pVhHgPCZIR0Lx4wK5Nx6p76ZpkIsif88Rtqj6qe/pRMG/Ex/R7euhclQtbSPAPlRI7w8F00pSA55jtvMzW5aWMgIxv4sXmAEkIt75Zym17hvuLaRhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=NE1uHLOp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wh1v6Tac; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 0861E32001C6;
	Tue, 26 Mar 2024 16:31:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 26 Mar 2024 16:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711485109;
	 x=1711571509; bh=bxODCPBoF0GJJeTlsg7MEbuZPv4uP3SCNGMQI3yKFKQ=; b=
	NE1uHLOpVEtIvd+0JFA02/jWcwQVLTBUvQGZTrC5Hnevo/kF3HEYSUyNfx9oGOky
	atks22ZeboTUToL538fWjOG5GYUN3Z3pYP5XDu7sp4A1Zui/C7T/UXLSz5RPdb6p
	sKjEkGgCJ13sfn3Lio4YnnUpT8LdNaNhFGNbMDNVCYetdAgzgfLKNwfmfi0j9sth
	s44+HnaEsQPitDky7sPpcxqLpbFKlySD0CWqD75bwgCyRqhhjeSCPafiAqkrSjH+
	5vg6KHZGeSHUHlLCto/3ZhllXOFh+B6q/7biMKTOz1wmzqE2yU91vTXbOe8R/9pq
	+CgOjbjB25HucMulab+4Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711485109; x=
	1711571509; bh=bxODCPBoF0GJJeTlsg7MEbuZPv4uP3SCNGMQI3yKFKQ=; b=w
	h1v6TacRldgN4YNi1KcMBc2mEXIx7+vvjaZvkJtaw7EoWtocCJ/+AZQLFLgpH9T+
	xoifwbQPkz+wPBBUwWtZE1esnjvA9nSFqDZF1XFLZ9QBkpiTy3mKAv4OS0Y/k1WA
	tPXypCoX3l4wb0zg5WdBbhgPMmjLNhlUquZfikpY3JKqWb86bbjgeuSKQ1fa+u/O
	lshLXCKN4ffV8F72eXOtMPsf/v7kEzE0IWi8yBYJGY3VEZZR9ElbeeY1spDb+vLl
	xX0I1jl3R3mKubaas9y8p6rMXRuIJ3/fdkRF+E9KUMzVO0nDeOkmQm7/wxdntYjW
	OlmeBYxjIiB5gQ0GIGwyA==
X-ME-Sender: <xms:tDADZhNILTfAgyfav6zDnCg-py71ze4aPJszxtMgsMN1uDx35WrzOQ>
    <xme:tDADZj_egmCyMibzA7fEb1tUIsMZNMj3Akany4FpYTr58GZBVRXX5Iqq40vSKqNYr
    Wlro6vIQBWh90GD5ug>
X-ME-Received: <xmr:tDADZgST2SZvulL57gMDOhR3Yuxwu4NPBxIxdDGJfoSTFaMUHGtlho1l4SFAPr3c-ALVmiA5yGhm3cJ2kYXX7Ut57FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    rhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrh
    hnpeeikeetvdfhjeevheeiteduvddvffekieelleekjefgkeeihfeukedvhffghfffkeen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:tTADZtucTEmPwMbCW7sQxzQGY7JUBPc8CaN3uS8yyoRQh1ZguvE_Hg>
    <xmx:tTADZpdPs8qgfe4f1Nn2Yb-yYn56n-3F5xCptukwSzvOQuDBZ2Mb0g>
    <xmx:tTADZp0p9TnL19pmHVuDJlqGUt0ZxSZYUUBLUNlHHgXus81yvsvg1g>
    <xmx:tTADZl9XH-bip9l1XzzyUwT9p5DRHyd_MTpzd8bHNmaMly7X7ezKxA>
    <xmx:tTADZqoYKobYKdQEntsJtO6gOBmTGFY5CZBHSDVuQYBGZpsI1Uf8aQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 16:31:48 -0400 (EDT)
Date: Tue, 26 Mar 2024 13:33:55 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: subvolume: output the prompt line only when
 the ioctl succeeded
Message-ID: <20240326203355.GA2197422@zen.localdomain>
References: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
 <20240301125631.GK2604@twin.jikos.cz>
 <20240326202349.GA1575630@zen.localdomain>
 <bafb239d-5c78-451d-b981-8d79aa3c1200@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bafb239d-5c78-451d-b981-8d79aa3c1200@suse.com>

On Wed, Mar 27, 2024 at 06:57:48AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/3/27 06:53, Boris Burkov 写道:
> > On Fri, Mar 01, 2024 at 01:56:31PM +0100, David Sterba wrote:
> > > On Tue, Feb 27, 2024 at 02:41:16PM +1030, Qu Wenruo wrote:
> > > > [BUG]
> > > > With the latest kernel patch to reject invalid qgroupids in
> > > > btrfs_qgroup_inherit structure, "btrfs subvolume create" or "btrfs
> > > > subvolume snapshot" can lead to the following output:
> > > > 
> > > >   # mkfs.btrfs -O quota -f $dev
> > > >   # mount $dev $mnt
> > > >   # btrfs subvolume create -i 2/0 $mnt/subv1
> > > >   Create subvolume '/mnt/btrfs/subv1'
> > > >   ERROR: cannot create subvolume: No such file or directory
> > > > 
> > > > The "btrfs subvolume" command output the first line, seemingly to
> > > > indicate a successful subvolume creation, then followed by an error
> > > > message.
> > > > 
> > > > This can be a little confusing on whether if the subvolume is created or
> > > > not.
> > > > 
> > > > [FIX]
> > > > Fix the output by only outputting the regular line if the ioctl
> > > > succeeded.
> > > > 
> > > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > 
> > > Added to devel, thanks.
> > 
> > This patch breaks every test that creates snapshots or subvolumes and
> > expects the output in the outfile.
> > 
> > That's because it did:
> > s/Create a snapshot/Create snapshot/
> > 
> > Please run the tests when making changes! This failed on btrfs/001, so
> > it would have taken 1 second to see.
> 
> Wrong patch to blame?
> 
> The message is kept the same in the patch:
> 
> -		pr_verbose(LOG_DEFAULT,
> -			   "Create a readonly snapshot of '%s' in '%s/%s'\n",
> -			   subvol, dstdir, newname);
> -		pr_verbose(LOG_DEFAULT,
> -			   "Create a snapshot of '%s' in '%s/%s'\n",
> -			   subvol, dstdir, newname);
> 
> +		pr_verbose(LOG_DEFAULT,
> +			   "Create a readonly snapshot of '%s' in '%s/%s'\n",
> +			   subvol, dstdir, newname);
> +		pr_verbose(LOG_DEFAULT,
> +			   "Create a snapshot of '%s' in '%s/%s'\n",
> +			   subvol, dstdir, newname);
> 
> Thanks,
> Qu

Hmm, something weird happened. I'm looking at commit
5f87b467a9e7 ("btrfs-progs: subvolume: output the prompt line only when the ioctl succeeded")
in the master branch of https://github.com/kdave/btrfs-progs.git

and it has the (relevant) diff:

-       if (readonly) {
+       if (readonly)
                args.flags |= BTRFS_SUBVOL_RDONLY;
-               pr_verbose(LOG_DEFAULT,
-                          "Create a readonly snapshot of '%s' in '%s/%s'\n",
-                          subvol, dstdir, newname);
-       } else {
-               pr_verbose(LOG_DEFAULT,
-                          "Create a snapshot of '%s' in '%s/%s'\n",
-                          subvol, dstdir, newname);
-       }

        args.fd = fd;
        if (inherit) {
@@ -784,6 +776,15 @@ static int cmd_subvolume_snapshot(const struct cmd_struct *cmd, int argc, char *

        retval = 0;     /* success */

+       if (readonly)
+               pr_verbose(LOG_DEFAULT,
+                          "Create readonly snapshot of '%s' in '%s/%s'\n",
+                          subvol, dstdir, newname);
+       else
+               pr_verbose(LOG_DEFAULT,
+                          "Create snapshot of '%s' in '%s/%s'\n",
+                          subvol, dstdir, newname);
+

