Return-Path: <linux-btrfs+bounces-9763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 234B99D26A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 14:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B7D1F23225
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 13:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293861CDA0F;
	Tue, 19 Nov 2024 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WlC2q2oB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9681CC8BC;
	Tue, 19 Nov 2024 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022043; cv=none; b=k8ecys5YNZ3TsRiy9vMYcFZF81+fnqXU+/12nVpS3NSFGQH6mfdF8NgTsS3Yusb62ObJ1eFgHhwePGeTVH7xGpWq/lco14QxIc50ZTWVPWxRm3u/beEtIl93B0JzwVQdDEdujfY2lnTDpvc6mwz+4huPXy8CXcouiRa4Ncd4TVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022043; c=relaxed/simple;
	bh=HA7ilmPcjKXQ0kKkEkIgzTrUPmgJwaXhrXTUlJ2gqW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jpq9qWYN0dUt2YwbieKlxvnWTYPo3CZbL5Hhu8188qoFlEoMjRFcFuU2k3Pin67FbEbOnZKRCgh/dzsNVc8XSBiYszSbcgnyYgBduA51g91nuehA1yCs4iVJ5ykJb3TnuLHgjJxhzJRSmeC7wKfATDEdG6Im84X5F7etQJ0c9BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WlC2q2oB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C159FC4CECF;
	Tue, 19 Nov 2024 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732022042;
	bh=HA7ilmPcjKXQ0kKkEkIgzTrUPmgJwaXhrXTUlJ2gqW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlC2q2oBCe8mKGYPT3zopR6SO4CbrekXkscT7ykrG4JHICOAbUPcGgHGGrenWgZP/
	 z7dfRh1gRNsFDz0zSNISGILANxkxMBs9VLr4gwjznK06I3p1vLsP9By4cw2fNIHN6B
	 JjKatj4dlRjRPuNIVoG89HcBxAnfcA3vZjwbolSg=
Date: Tue, 19 Nov 2024 14:13:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: git@atemu.net
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] btrfs: Don't block system suspend during fstrim
Message-ID: <2024111923-capsize-resonant-eed6@gregkh>
References: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
 <20240917203346.9670-3-luca.stefani.ge1@gmail.com>
 <SICOALIt6xFGz_7VCBwGpUxENKZz_3Em604Vvgvh8Pi79wpvimQFBQNkDxa1kE5lwfkOU0ZSYRaiIugTDLAfM1j3HMUgM25s1rgpmmRQ9TI=@atemu.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SICOALIt6xFGz_7VCBwGpUxENKZz_3Em604Vvgvh8Pi79wpvimQFBQNkDxa1kE5lwfkOU0ZSYRaiIugTDLAfM1j3HMUgM25s1rgpmmRQ9TI=@atemu.net>

On Tue, Nov 19, 2024 at 07:54:58AM +0000, git@atemu.net wrote:
> Hi,
> 
> forgive my ignorance of the kernel patch workflow but it appears this second patch was only ported to 6.11? Only the first patch here was ported to LTS kernels (i.e. f00545e8386e228aac739588b40a6f200e0f0ffc).
> 
> I just hit the bug this fixes on 6.6.59 (I need to update, I know) but also checked Greg's v6.6.62 tree and it's not in there either.

What is the git commit id in LInus's tree you are referring to here?

thanks,

greg k-h

