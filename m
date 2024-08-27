Return-Path: <linux-btrfs+bounces-7556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CA09609D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 14:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D6EB22B6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E931A254B;
	Tue, 27 Aug 2024 12:18:43 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72946199221;
	Tue, 27 Aug 2024 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761123; cv=none; b=hoWdYxyQJk1uMHJVWpaai/u96m3kZ0FrQ0rKocs9TKWrhYgssl291WshJ341zMndcYvvLh294m4zpZm6baLsx7sO333X8RWrq0hlBhe5e0DyU3hxyAvCH62CCeCNbaeIXTrcbHItS+n5bt2uec9z5M3g3zKQb5vAGqvGD6y92cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761123; c=relaxed/simple;
	bh=95KHJyfATWtfQ1hSP+qD2XKcz9lSRoWyH+iK7mReTyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwmP04s9l1SL6v2QVSJB72Q8gAUdqghf6apxIQU0VkPTFLQqwXUFHbk7218HZqfX5ysNaucIfZWL+SLmgIe5hSI26cxKfyrPtb7sAmWcSyDYXPPD4sL6czSzftkrJHSVqdDFXj7Zfp9csn3MKBa7beUhDwiram9j7EqRFwHk9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC021227A88; Tue, 27 Aug 2024 14:18:32 +0200 (CEST)
Date: Tue, 27 Aug 2024 14:18:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: fix unintentional splitting of zone append bios
Message-ID: <20240827121832.GA1607@lst.de>
References: <20240826173820.1690925-1-hch@lst.de> <Zs278OxdBpn-i9ss@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs278OxdBpn-i9ss@ryzen.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 27, 2024 at 01:43:44PM +0200, Niklas Cassel wrote:
> You say that this series fixes code that could affect every submitter of
> zone append bios, thus I am a bit surprised to not see any Fixes-tag(s)
> in any of the patches in this series. Was that intentional?

I'm honestly not sure which exact commit it fixes.

> When was this bug introduced? Or has it been broken since the support for
> zone append was first added?

Possibly.

> Even for a theoretical fix, doesn't this sound serious enough to warrant
> zone append splits to be fixed in stable kernels as well?

I think pretty much every user could hit, at least when manually
dereasing max_sectors.


