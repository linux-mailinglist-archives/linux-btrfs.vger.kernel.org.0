Return-Path: <linux-btrfs+bounces-21121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB6dJW0MeWnyugEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21121-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 20:05:17 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FF79997A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 20:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BD68300DCF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3244D329C77;
	Tue, 27 Jan 2026 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="LMnKiunO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZuNGNiRX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18827CB0A
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540606; cv=none; b=hxQ+SpAXKCaseRKKnybbMfV89yhsoBoshQX8AoJ8EcgxUeKHyzSVEUuTeXWbY+3JiEAMWADE0pNl4lXsnOPdY1Fbt9kwVolqycW563xSDs3WtHxOmxWMIYVPujf2MjMlme/Dp2jgCZwEXHJoEnZlcfVE4xFbL2aWMD+eOOHDUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540606; c=relaxed/simple;
	bh=heh+iEiAELDjVVBCHAEgs8XzUSpm9CHSVRXKcvYzLU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCVmChoYMwyDK7ZbXyKjFJPmolsBG26IzvEOd1c2PU94LTFNfnNKtM3jYJKA++YjeGABnqX9FqhixU34V2ImSAQ3nipra+ayacFa2WXbUTrK4VoxJGLuJjU+3PCE8H3lZnuOn7eHooX275ybVQ3vVbLI8VUfVdgGJvnrki3j0nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=LMnKiunO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZuNGNiRX; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 03FEE1400033;
	Tue, 27 Jan 2026 14:03:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 27 Jan 2026 14:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769540604;
	 x=1769627004; bh=A/7jr/yrl0TP+O3Li3Gzade8nvKiNXd0VsT9IRYuZiQ=; b=
	LMnKiunOr6cMRl0nAlFjxq0kVoBC5F2l/bIWxhsmQCFdK3ghW5+Vu715LqhWVPrg
	kGSLUIYZUqnHAiBwbfJ77lHYD2ayxkVw4KF6YrEzALFnF6hMfxTvjg+zdeJdFnxn
	nYakrmkPXapMWYja8eLB6tZpTFw3XU6+803SnbIcUilCgoFDVLXQyG7k4/LxbAr+
	9RgIjfHqtSlFZp7a/r35hXGHbBRWtwzQIuCSXfol3WNxFVaUCvXA8CdlBpA4SmXg
	vM3tWDG9AJQu3RzftdIax4vgFEh8uItQnxYjBEsByS0DFQeBEC05c0PFJqQ4Vpza
	9dxyTLgHWgmHmZTX165KoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769540604; x=
	1769627004; bh=A/7jr/yrl0TP+O3Li3Gzade8nvKiNXd0VsT9IRYuZiQ=; b=Z
	uNGNiRXZ/IHhWDVr8XBlumbLAWWkddw20+tPwzavZ24Du9Y9L3ujjXS4IXhuwia5
	CvUA3g6vWrMTSDgYSKapEK8XWQZ1Miq2V9dsAQtPTAsLB0h7ZUqM0RKpJvQvtPEa
	xTPIOb8jkwXPASO40UbxFpuIRxLfX7SP+5T2PQy4MND988x7KZmzmOnY/U2ki/lR
	DaX32sTPOsg/GP7eGNm3WWlj6P0xPRM7suGJNE5AkKCrA6G9wZu4U61WQQXyMgH8
	zG0mXtt78u+ZIDlhez1YbNGlTJtaEaDHD7xtEPUFEnAY6OOT0YdExqCYNF7EW7Pp
	1B7hadANCvxsJDBJ5shWw==
X-ME-Sender: <xms:-wt5aT7Shir3KIR6chpAbt1l4VZUenaJiHZAtirhh4o_N21fZkCRcQ>
    <xme:-wt5aQUwRYNAnORkLrLUhANBOkY2SlK8YMyBUBQVYjmd2YjPuUFxwFSqZ8fyt-XaE
    4llCwAzs-5qxFdR7uY1siDSQt6LiZjgeMu_Jfpa5fC2EwJE1XpSKgM>
X-ME-Received: <xmr:-wt5aX34s9x4T_L9X3d221gd6CVKinID5OIqYgo6ZXi2GlEOBQTsNAA0nErZPJXhqxvGSI_ISHo1PRDtHdxFg_HDOy4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepud
    elhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeifrghnghihuhhguhhisegvudeiqdhtvggthhdrtghomhdprhgtphhtthhopehlih
    hnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgv
    rhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:-wt5ad2e5wvhi0tdNnebWnN8JeEcIFEXh_oITPAzOKWnIs5e9Uxmag>
    <xmx:-wt5aa-tdq7NFJyTHz0AOOHLYk1VhoR2lpY82efEm2SkIVvVnppqFg>
    <xmx:-wt5aa2ueNJuU-jHTvFNNRlHtXc51OnLop3koiqcczG_RGuuYGYGoA>
    <xmx:-wt5aX_XoIU8RKb76UQdMoGgQEuov4n9KO74gIdx-GROki6aLaLqTg>
    <xmx:_At5aW5paikM1kuc4BXn_cPxUVdz_DsRxnoWmFyULGsBW4dUla7VjMLf>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 14:03:23 -0500 (EST)
Date: Tue, 27 Jan 2026 11:02:59 -0800
From: Boris Burkov <boris@bur.io>
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 3/3] btrfs: forward declare btrfs_fs_info in volumes.h
Message-ID: <20260127190259.GB3450664@zen.localdomain>
References: <cover.1769447820.git.boris@bur.io>
 <4c839922e88a33145eca264394ff8aab08c0a871.1769447820.git.boris@bur.io>
 <20260127070401.327D.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127070401.327D.409509F4@e16-tech.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-21121-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,zen.localdomain:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43FF79997A
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 07:04:01AM +0800, Wang Yugui wrote:
> Hi,
> 
> > Fix the build warning:
> > In file included from fs/btrfs/tests/chunk-allocation-tests.c:8:
> > fs/btrfs/tests/../volumes.h:721:53: warning: ‘struct btrfs_space_info’ declared inside parameter list will not be visible outside of this definition or declaration
> >   721 |                                              struct btrfs_space_info *space_info,
> > 
> 
> Could we fold this patch into the patch 2/3 which introduce the file of 
> chunk-allocation-tests.c?

I suppose so but I intentionally split it out since it isn't
fundamentally related to the new unit test, that is just how I happened
to notice. btrfs_create_chunk() takes a btrfs_space_info pointer but
it's not forward declared.

> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2026/01/27
> 
> 
> 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/volumes.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> > index 8cb72e84dc84..ebc85bf53ee7 100644
> > --- a/fs/btrfs/volumes.h
> > +++ b/fs/btrfs/volumes.h
> > @@ -30,6 +30,7 @@ struct btrfs_block_group;
> >  struct btrfs_trans_handle;
> >  struct btrfs_transaction;
> >  struct btrfs_zoned_device_info;
> > +struct btrfs_space_info;
> >  
> >  #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
> >  
> > -- 
> > 2.52.0
> > 
> 
> 

