Return-Path: <linux-btrfs+bounces-3357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4482D87EABA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 15:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D6E1C211B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D004CB20;
	Mon, 18 Mar 2024 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7OQ4Lk+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71D14AECA;
	Mon, 18 Mar 2024 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771519; cv=none; b=FD/RRFw+MRuolCmUlqTQo3ubetvXvIupbMznx3hyv7pr5puU1ShK1cYOfzSPjEJ6TF2xFNV5uqlHymiA9g6TLvRTHTovz/1GCD2jjT7MARMevGcU63Vofi9kz45GE0h2RGb9LY00cfwWyeUMFG3go0HWWUWItj0SkTNrx8rTQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771519; c=relaxed/simple;
	bh=c+EJsJ4lo9mv4RH4IasCH1QvoE0TFkuE2iylhHttUZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOqsvcox9MJoniFg2JJ4U9QgN8zqBC+EDae5IFEXYXf0hOv9YwPUz7whlo/XIUFe1g20mgnj6vy+AIZyt/TVC6e0XkSpHlLolGFYmdAtgmOf9BleYn0LCiFs7+vC9CZrkCaujt0DT35XdTie74nEADU5WjAm1riSIE8HkWl740k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7OQ4Lk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE40C433F1;
	Mon, 18 Mar 2024 14:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710771518;
	bh=c+EJsJ4lo9mv4RH4IasCH1QvoE0TFkuE2iylhHttUZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7OQ4Lk+bJkSLp5R/ojNbZn14jfMuoX8zuAj6dvYFyAZ1mi+tEeJLW3T/tSKXkZ04
	 rmTsG5Qhm9ixx6m37FOOL0VFvr9MxxxkSC7OIINYTZScHnyOQyEWrBw2BHLARYnpVo
	 eT8iWo2vROO3h/rWw74cB9t4pYhb8CGW56nkubOKNk2ytaCGiByl17oUSA0E4VS4/f
	 0bBFsSQdMo3XEz+zWyxQk0w/iX9iekRK7fnRnnvnjhMl1aOyOGzdQgtqbTLjJbNOBR
	 6/fn4AzoqeQfeni3IBlZvMLPxVAjDCo01Xsjjaqk1SgIlyNQKVljIjpw0zEQlerT25
	 oQH6pCbfCanYQ==
Date: Mon, 18 Mar 2024 10:18:36 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>, clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 1/7] btrfs: add and use helper to check if
 block group is used
Message-ID: <ZfhNPInQFHipsW3c@sashalap>
References: <20240229155112.2851155-1-sashal@kernel.org>
 <Ze9w+3cUTI0mSDlL@duo.ucw.cz>
 <20240311210540.GU2604@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240311210540.GU2604@suse.cz>

On Mon, Mar 11, 2024 at 10:05:40PM +0100, David Sterba wrote:
>On Mon, Mar 11, 2024 at 10:00:43PM +0100, Pavel Machek wrote:
>> Hi!
>>
>> > From: Filipe Manana <fdmanana@suse.com>
>> >
>> > [ Upstream commit 1693d5442c458ae8d5b0d58463b873cd879569ed ]
>> >
>> > Add a helper function to determine if a block group is being used and make
>> > use of it at btrfs_delete_unused_bgs(). This helper will also be used in
>> > future code changes.
>>
>> Does not fix a bug and does not seem to be preparation for anything,
>> so probably should not be here.
>
>Agreed, this patch does not belong to stable and I objected in
>https://lore.kernel.org/all/20240229155207.GA2604@suse.cz/
>
>for version 6.7 and all other stable versions.

Dropped, thanks!

-- 
Thanks,
Sasha

