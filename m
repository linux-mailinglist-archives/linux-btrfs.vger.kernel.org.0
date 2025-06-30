Return-Path: <linux-btrfs+bounces-15136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB49AEEB04
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 01:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF6E17BD39
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 23:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CBB28D844;
	Mon, 30 Jun 2025 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Y2yBRZ12";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bR3fWG7V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03C2571B3
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751327047; cv=none; b=kJc8EuBkvKSUpd1IeFDBIt6uzEEcc6D0/CFga4u0icXF1mR9bSJg8bTwSvFWKp/tH4C952w2KZZ6gKtz9XJOuzKJOoNmK+3UMkD/YZH/0DpjX485VZjA5/sxk2NcDcTWa2WwrLZjNUh/1BmG8QJ9axh171WeEgAqVlwlXooQAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751327047; c=relaxed/simple;
	bh=3fa/MbTJDCqxKuFCDs6BPcWrG7oMko0TU+HiZtRN2Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEJcJPjPljZ4/NZkn+ywXimqmg0xa03TOf6zo2eTtGrGKr2NI0TOK0iYny7HpRrksLbnvKo2ABumhau7/Xqm3ckum67A2v9UlJhi57cXw7HX6INKbuAu77slhP5rCmRNgY9QDkP09uDOr54FhWnhwt/naXh530MoimOtc7VP5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Y2yBRZ12; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bR3fWG7V; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 19CA11D0028A;
	Mon, 30 Jun 2025 19:44:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 30 Jun 2025 19:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1751327043; x=1751413443; bh=EsajN6eSHD
	PofUM6o3K+MjdBBdMgrf7rdAq0yCQae2Q=; b=Y2yBRZ12QkkE1Ib241iNgTOzJ4
	ZA3AagA7s4CdIb5067uqzFByxwIAwVy9FthK6c/0KsonxvzAzD0GdUg+5E1BUA01
	YSJUZ+RNc8bLxybfSyFS3LukcOaNeHCXu4Y90YvXQxU2X8KAVM8FmtKbZKudwAFA
	a75m23fGAoLXZPSSUBXFhJisa5QoNdc4WRImXtaJBt2zv9TT3+XEvGqgTDnNh3+8
	0oRfkQEof8Ujs55pPC0N1FLcINMQxpbwxuHnFAohKo+WcxQFsHx0lAacXKBO+Y19
	2zM/hX3hjbJR5EvCrKx/nt9IzY9rTXSiP43IKuyPpflbOWJfNIhMDzlm40wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751327043; x=1751413443; bh=EsajN6eSHDPofUM6o3K+MjdBBdMgrf7rdAq
	0yCQae2Q=; b=bR3fWG7VndDTuyWym9fGlujaWkxR9hgbz1+Kb+bH9DEk27mSbn9
	IhUMb6eePUks2gXPtKJ56XZF9jUCCCESyG7AwnY0nB05ksjH6mlWDLV/AuuIeHId
	5n8OoUekP+ES3IfRHum5Et72GTh/kJhRHjMDsUEQNkhVK+sw3LjyCFfLYaVeh/Mx
	AeKGalF1UqU5znoUJHykr48zmSgnrmE+mGPlnQq7LeT80YA0/pi/OfS+9Cm8JbY8
	9CaQLNy89pf3jdoH7jddJVn1u/okqEl9Us8aVZb0sHqm+w0mXHty9gpwqfvxM1u5
	ftoCjmlHX37GmPH9nWieihSTRFcsaDbGGGA==
X-ME-Sender: <xms:QyFjaLKM23I6NmSTQHNtYj-LBt5CjXZu-aB3U4ScnQOxYUEknTLisg>
    <xme:QyFjaPLv8H_FnzA99fy1fq3eWC6S2Zy3-_VMI1np8uN-znxHnDnhVZg88QREJfKzZ
    xNMeaT1Ez2UPSWR7ZM>
X-ME-Received: <xmr:QyFjaDvuoffhgNvPMytbiINgq0REfeLrGcKmA-BQldfgeUyHDM2obJgl8-RjVH4qd8UWV3wRhopdMPczHF5Fw-mUs8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegushhtvghrsggrsehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QyFjaEbdQvmC9MRFN07OzgENgA7wYnHKBFvFgRHL4XrsLyA6a2l8JQ>
    <xmx:QyFjaCbfECGdzkeiKNc3ay24UM_5T9QN5F54pUsW-dzTfpNZurlz2A>
    <xmx:QyFjaIDDmWiYmoDKUkAw3fcL4wcRezwRcI9riwqLA2Tg0IrNAs7JEA>
    <xmx:QyFjaAbPultLXfwWYoLMaa_BBiTZuu69Zo6ch7_UfdN1h5-qoqjDVg>
    <xmx:QyFjaCIT7FfKWF-mwsPQNizmH2YllmiB0ekDU5_2wKSPzLnUhE0Ui8Fm>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 19:44:03 -0400 (EDT)
Date: Mon, 30 Jun 2025 16:45:41 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Parameter cleanups for subvolume/snapshots ioctls
Message-ID: <20250630234541.GA1265689@zen.localdomain>
References: <cover.1750948128.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750948128.git.dsterba@suse.com>

On Thu, Jun 26, 2025 at 04:30:08PM +0200, David Sterba wrote:
> Use qstr for name + length parameters, some other parameter type or name
> adjustments.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> David Sterba (4):
>   btrfs: use struct qstr for subvolume ioctl helpers
>   btrfs: pass dentry to btrfs_mksubvol() and btrfs_mksnapshot()
>   btrfs: pass bool to indicate subvolume/snapshot creation type
>   btrfs: rename inode number parameter passed to
>     btrfs_check_dir_item_collision()
> 
>  fs/btrfs/dir-item.c |  4 ++--
>  fs/btrfs/dir-item.h |  2 +-
>  fs/btrfs/ioctl.c    | 37 +++++++++++++++++--------------------
>  3 files changed, 20 insertions(+), 23 deletions(-)
> 
> -- 
> 2.49.0
> 

