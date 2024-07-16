Return-Path: <linux-btrfs+bounces-6505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDF8932841
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 16:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB421F23B87
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4235119B591;
	Tue, 16 Jul 2024 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="EU6uZLLL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X6KPMa7i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6B19B595;
	Tue, 16 Jul 2024 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139800; cv=none; b=YpdHBgjUU9sx6n6j9U5vnUPZfGKwFtjCnoAEayzW6IOrtKEfohJ7X2Yhk6HEpMnJydlvEphjI+XPsHwNQpjpuUnvleKnN7WUA4J1Sxs1mXz+WqlWQHxjMhsipVx5AP0EsOMgiA/L1vjCjqcCtdgEygtWUMFhWXO4e4DL5UbKu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139800; c=relaxed/simple;
	bh=3j7UmV5Osm9gGYW64tfdXxw90byedZUmsDtrYUOjV80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyZpK40EbztMKjcjpYHuJrrH/Y+T8gEGv+0ZXmb/YZH7+VZSOu7Nn+D0yw8Y3yiJaasX+gSR7XzcvKLTt4Zfla5kV0GVXpMDRCa9fH6XaWdoHeLYZp6nTdCOVa/7+av05PTTG8MaawwpYE5tg1X1goYISUlPJi61mAkKxxx7hP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=EU6uZLLL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X6KPMa7i; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1F21C1388B5B;
	Tue, 16 Jul 2024 10:23:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 16 Jul 2024 10:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721139796; x=1721226196; bh=D1EqHmNIMe
	5lNyHhuTa/bOsnQk18KfRt8q3WMidg1Mo=; b=EU6uZLLLHni0SF9+UIRQx/jcwv
	aWexbLviX7O44UuNJpCif7tJmkP/pBlWgSZqSxQxmOJKIk7FwmwiNj4l7gpTmd0E
	TnklrywKMNINl219ZbNwX99p8luiDZPPHZMZvgJESgxv1EPTzVdiHEtB/3YRcoRH
	P0HrYfKKLh5w1KDywUZrCVgt7Nq5P+2IKIS6rk/eT4hGNdB1btT0oE90V4bB7un4
	MiWZ1GLpULYn0/j6vuDUgwswronnlYWWFlM02YtWGusZk5PBZi6Toj9t/SDKx0Rj
	RVslwe5MAmoEvJLRvS2SuGOJQsLn1IDV+BNBQIsR16rgblSnICuPZ3CGjp7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721139796; x=1721226196; bh=D1EqHmNIMe5lNyHhuTa/bOsnQk18
	KfRt8q3WMidg1Mo=; b=X6KPMa7ip5dftf01GzT3ngOrLVf9jgqJ72bMwNfW+20s
	pN52QbZJIMyVsFArcwk9BRneMt7c8wDqfmN+/6lOMKSu+nGApcqjqNEFL86HP3zM
	UDZtLT9JHtJcNjIi/L7nUHLc7CBFQ/z4LqjsiiXyRCOlsBrPLywfKvQ5Q5J+zglo
	Zo8y7CK9LMFz7eryy9Eth1GxmhfJ0F1+ZO5NZtRDkO8+YGmCs8e1sm1RwoxRsDIe
	J4DzSs3d5HDtpnXgEOYBm4dfw2wLWbgWqXn6Bo0hm6ATUIpHm8XJaPMTY8sfGdUg
	zNoorUxi4Z884zwxl6HNYsdBfiNZESjly4+ojCTAMA==
X-ME-Sender: <xms:U4KWZgUuruuvdbeYaT05yQKtkfmUMZCQoSlUXFnUf0qpoQ2T3KaG5w>
    <xme:U4KWZkkyFOHmD7t4warUQDwEm6_X5czLVurl5vBSVahq3jXbyZ0H1_rmpzWsfHtlg
    w2wlbQn3cp1OA>
X-ME-Received: <xmr:U4KWZkZXc5sLTvAUls1tAuRdX6Dac_tmjLjTyw4OCAd5LprbNVQsbc9jrXkd_B2OBF4REmRSGC4qtg3-CRfSrLPzb2x7bt7mImWOdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpedvjefhve
    fhjeejfeefleejteegtedvgeeghfeuveevgfffueelhffhhedugffhkeenucffohhmrghi
    nhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:U4KWZvV48D0e_yiW9kclqTjWGp4mza3mSxdeRV6MOVkGByMp8wpuzg>
    <xmx:U4KWZqliL6AjQliqURiSrE8HGVkT-JmfER_EkuGngV8Snz8mYfCwdA>
    <xmx:U4KWZkd0g8mPY9ZMWMJBYxlbKcF4sGsbKAoAmxVG93tDyEV85FbUAQ>
    <xmx:U4KWZsHdgR0KBJKI78cLfYIEv5DZLA6sRIZeoSpqwraZAJmIvgjd9A>
    <xmx:VIKWZjfxx6-9qHniPKQ5zOxwOybc5_eOiYOy8EPB1W9DZxjqimtjbx0t>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jul 2024 10:23:15 -0400 (EDT)
Date: Tue, 16 Jul 2024 16:23:13 +0200
From: Greg KH <greg@kroah.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6.6] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Message-ID: <2024071606-countdown-tactful-e647@gregkh>
References: <63189f5d922db2bc525f5251be46fe857e00a2d6.1721120987.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63189f5d922db2bc525f5251be46fe857e00a2d6.1721120987.git.wqu@suse.com>

On Tue, Jul 16, 2024 at 06:45:49PM +0930, Qu Wenruo wrote:
> commit 1645c283a87c61f84b2bffd81f50724df959b11a upstream.
> 
> [BUG]
> There is a bug report that ntfs2btrfs had a bug that it can lead to
> transaction abort and the filesystem flips to read-only.
> 
> [CAUSE]
> For inline backref items, kernel has a strict requirement for their
> ordered, they must follow the following rules:
> 
> - All btrfs_extent_inline_ref::type should be in an ascending order
> 
> - Within the same type, the items should follow a descending order by
>   their sequence number
> 
>   For EXTENT_DATA_REF type, the sequence number is result from
>   hash_extent_data_ref().
>   For other types, their sequence numbers are
>   btrfs_extent_inline_ref::offset.
> 
> Thus if there is any code not following above rules, the resulted
> inline backrefs can prevent the kernel to locate the needed inline
> backref and lead to transaction abort.
> 
> [FIX]
> Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added the
> ability to detect such problems.
> 
> For kernel, let's be more noisy and be more specific about the order, so
> that the next time kernel hits such problem we would reject it in the
> first place, without leading to transaction abort.
> 
> Cc: stable@vger.kernel.org # 6.6
> Link: https://github.com/kdave/btrfs-progs/pull/622
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> [ Fix a conflict due to header cleanup. ]
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/tree-checker.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Now queued up, thanks.

greg k-h

