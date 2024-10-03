Return-Path: <linux-btrfs+bounces-8517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363B098F645
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 20:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19451F228C0
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 18:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0475F1AB506;
	Thu,  3 Oct 2024 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="RlaHvJRw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K6RPj3CF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B886A8D2
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980689; cv=none; b=leczbT4TCBX/uZVS3T81rHCH/5V9BeIjoXaK6YKlgP6N7tlQ+8q0XSgnKs6r+5W8p/B1Amc6DSudCWM70yqgVmMg+HELUeQIxyT7Y97ivfYGNjgN5TcZkzGu2sknDtZrbWsIC0u/mGTT5APHkGJRfgDjOLNfhS78+UohD28DkGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980689; c=relaxed/simple;
	bh=+ec9cb7vn2u7Rn1Lz4WKv6NUomND/mWkRN2XTpPZ03I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C71/B82hr/zkHVO4ABSVEC6hV9DH3XnBEJcZ3rBNSoLZf9Cy22zdtTHH2uoqZH7sPa2FbG0cr0RoN5V6olA7MNJYpT0tBRCVpR2mJL0VEVLxsUGfKT/5V+zNP3xqXEF1PgIcaQfH29qsQa5fJjXxKPBwBj3tM/FJzq50kan2Nmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=RlaHvJRw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K6RPj3CF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 1603313802C2;
	Thu,  3 Oct 2024 14:38:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 03 Oct 2024 14:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1727980686; x=1728067086; bh=5AAXA6gOO2
	QlO1vzPupYLHz5h1S+2Ip2B0Ze7j1xleU=; b=RlaHvJRwywWhrEvy0F5XMs8Sfj
	aka8qep+xAEBO3hhjkIZE+lg8fCWPX4nysYJHLBdqjDMPj5Lp0MyMtLTncAerHc4
	EP/5D8qQQGK2nwgCnuMRJssIwOm9kF4Nd5e8iqXB1HFBO72gkn+AHD0jjqMRbBpN
	RBMZqU0BFzRYYiqVxkLzMhWKrs+18xDVQFHoulPG/7y+XTo2nk0J23zj3VeuF4l2
	gTW7W26pogJSXFkr3avCYfs50m1Wh8ITSC2ZUqOVbtOvuSIjGIKy7uOUwmdw+dg5
	AhB05p8iCFiW1ypU7lWyWSqee7PEustcKiwcUbut7vuav1+c9VeNf6pcBKOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727980686; x=1728067086; bh=5AAXA6gOO2QlO1vzPupYLHz5h1S+
	2Ip2B0Ze7j1xleU=; b=K6RPj3CFZgRaYq/owLGQKz4B9aeWxjh0yL51hnpPd/qV
	MaPXwRkLM4KWQJwD48oLjqUtTDluZ2dZSwxC2cjMrUpa879J62skSAvxl4/huSBQ
	DD5F/jdO9IhZ14Ywjy/HyR0AQwBKjeg1krRR8E9jwrzguSw8ml3fI7+OpSiIOu0Z
	Evbh0EwBXKbnCtC3hOplaTMtBpTRZRuygVm/AuCRzOktfeQnu9Jo91B5rlq+cSs5
	uWyYi8l1W5zjVRJgO8HtEdhXmF+AR14BDEsXaT9J8h8MP38QkXP6MMgd3b/blCIS
	IiXPtF6y+5ju4BF3vMWx21T6SWHr4I+po+wFuzloYg==
X-ME-Sender: <xms:jeT-Zv6JNDspCiD2rHX1ggJsiRL-ow-hI9BPwECwWZSD40U1cKgn8A>
    <xme:jeT-Zk4RdytqetfZvuICGK5SCmvNBicjxNM5g0rDOnA3x5xt631a6Mmt_WambWDHD
    1bxPlvkEXbWJjnafxM>
X-ME-Received: <xmr:jeT-ZmfKhgpOSF655vJZ2ev2qGiO6fIpX9CvSJJal867mI1QuK0aHURVPfvma300mH-D_91MzYpIqUhUIATxfqCL27M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeejtdegheejfeeuvd
    ejgfegvedtffeggfffffevffdvgeeuhfdtfeevleejgeeigfenucffohhmrghinhepthhr
    vggslhhighdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvsehtrhgvsghlihhgrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jeT-ZgIkFMOkThib2j6y2ZQV9v_oIuArpGCSg38S6Wl_SE1KI3C2dw>
    <xmx:jeT-ZjLlCFJb2qQ3tUhNf23_1VRz36JogJkAdoSC09WGa6eQIdnP0A>
    <xmx:jeT-ZpwesxIHcTdTypgHvlFWwX-uQhSBz4WrIypGmnFMAQvcLS2cyQ>
    <xmx:jeT-ZvLBMdb8n9xCBXjOoIj4MP5BTCkHPVdxYp9sEB1PXGkQ5cR5CA>
    <xmx:juT-ZqWmhARWZrUj9NV-HiLJT7wB24X-3jvHJLhq54FGU5wbxflMsmDO>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 14:38:05 -0400 (EDT)
Date: Thu, 3 Oct 2024 11:38:02 -0700
From: Boris Burkov <boris@bur.io>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: of btrfs_free_squota_rsv
Message-ID: <20241003183802.GA414021@zen.localdomain>
References: <Zv6f_ALAoC_kFg9z@gallifrey>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6f_ALAoC_kFg9z@gallifrey>

On Thu, Oct 03, 2024 at 01:45:32PM +0000, Dr. David Alan Gilbert wrote:
> Hi Boris,
>   One of my scripts noticed that 'btrfs_free_squota_rsv' is unused;
> it came from your commit:
> 
> commit e85a0adacf170634878fffcbf34b725aff3f49ed
> Author: Boris Burkov <boris@bur.io>
> Date:   Fri Dec 1 13:00:13 2023 -0800
> 
>     btrfs: ensure releasing squota reserve on head refs
> 
> I was going to deadcode it, but then thought I'd better check since
> unused 'free's sometime turn out to be someone forgot to free something!
> 
> Thoughts?

Hi Dave,

Thanks for catching it, and for the thoughtful message.

I believe that function is just pure sloppy duplication. The same
functionality is in introduced in the same patch in
fs/btrfs/extent-tree.c in `free_head_ref_squota_rsv`, which _is_ used
in the cleanup path.

So with that said, please deadcode away!

Boris

> 
> Dave
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

