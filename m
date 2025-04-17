Return-Path: <linux-btrfs+bounces-13144-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780B5A921EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 17:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83A03B4D41
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B754A253B7F;
	Thu, 17 Apr 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF9MliCv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EBB1CD205;
	Thu, 17 Apr 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744904900; cv=none; b=rNzxhKWeuPl2q9pG1foH7XgdtaAwYsYsA8EcAi3R2TdPF7LtK+0CGbtzclvqmOnCquArUkgAX/tUmlGTJ8MttvnBptM8CnqwIR3OrvgoRYB6E2indmYy1T16Hl59dDYTcID96d4fw/zOA3fbVp608jrEab5gUCjxT8gY9QjOlqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744904900; c=relaxed/simple;
	bh=ZwVYgKdr2RE91rC1R5qigp5HxTXGNwu22jwtN1mprkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuzTtZ9U2ATZur8mn+8FyPtgLXuO6AtPV1y4TZOnSjtsOIlyzM/tq+TAvwn2M56b9bvpaJp4MCiGllwghrtPS9TCkTYvdGTV5IY+DHlkPqu+1x4YMfjkfk9XXeg56GUhZBdCYt1MUvQ38yLvMrP9ATFcVGaou7aZ9gPu+A68WeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF9MliCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51474C4CEE4;
	Thu, 17 Apr 2025 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744904899;
	bh=ZwVYgKdr2RE91rC1R5qigp5HxTXGNwu22jwtN1mprkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bF9MliCvONE7sz+OOwWBoXb+2QG2ErMu7VezFK+oqFyTjD/h9o+REmITJe2H+w0hT
	 iOTG0/ygTp9Y4Wx2GKC9tBjiKj6NgA88VpboSEaUFbWhJMonm5SRilvSEm/zSmc2vg
	 x1JkEskf6+H1fdhzNOCGJVLyWaXWAhFlAAMxBUyD7fYLV+fKO2/ycTg0rxhM3CydNd
	 vDUsNQNG12aO5tJYNddMcOhrWfGPbuE6rF2LDICoTVe2BE4dCAQMCxNMJRShcYd+ob
	 vY3KsbfAIOSF7XM5HAo1r4qnNHzh0uh5T3i/AZWns+HoqF05UqsEaIpvH3U8UgdwYO
	 tEBTbNm0svpPw==
Date: Thu, 17 Apr 2025 08:48:17 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/271: specify "-m raid1" to avoid false
 alerts
Message-ID: <aAEiwc5QxO1J_DSE@bombadil.infradead.org>
References: <20250417102623.8638-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417102623.8638-1-wqu@suse.com>

On Thu, Apr 17, 2025 at 07:56:23PM +0930, Qu Wenruo wrote:
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>

I would prefer: kdevops <kdevops@lists.linux.dev>

As this will just be automated and kdevops is not just me, its a
community now. I just nudge it forward when I can.

  Luis

