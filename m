Return-Path: <linux-btrfs+bounces-13566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7B6AA5670
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 23:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831F91C04354
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02CE2C1080;
	Wed, 30 Apr 2025 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MRMY9CpY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576E20E718;
	Wed, 30 Apr 2025 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746047171; cv=none; b=PYenXz1czB56l84TdbG9axydqOO6TzmlP5adr7imqlCmfNDMIbqX1aH0sKvePTtLxFA1SCnypqaoObnjZ1eMtw+OYfyUq5wenn2MXeGSoUs/9UPouVn/RpozPCp70f6C7A3TtdopyKQ+aqygYeWBM9UYcfhq/i0kz6Fbr6sWI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746047171; c=relaxed/simple;
	bh=0B+5Z98ekMLiLmIzWnYv6+PxibYH2kiCCIm4YVzpntQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eTp9k1gi0uaxDzymnFVOSCnFq0OZbcnY50opPctswURnloe1GUUw2PnbL7j4YXxtVkK0CjzqXdYauNHLTMR9EJ8JyZTa82s7Ta1cCUP/mh2bqUOBfbaawc9SIaGT+5aeMQdjRiSR0LI0opIcN7eafRqXjc/uaVkrhWyAlCxp920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MRMY9CpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2E5C4CEE7;
	Wed, 30 Apr 2025 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746047170;
	bh=0B+5Z98ekMLiLmIzWnYv6+PxibYH2kiCCIm4YVzpntQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MRMY9CpYyvWeJz2Gf5/64y2fvnv9hQlndP+VwNxV0X3xYfqeRCVYHSKxaTTqq1szM
	 vf4y9Ay0+6GOsjUXXWcVXemCVlc4jA0JEzW+m/OUfZKavT33gyu6gQ8jLqDRcYADV1
	 cFKL+pgm3zWKUhqwC5ADKeT3E200pza7kmx8VCWY=
Date: Wed, 30 Apr 2025 14:06:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <kasong@tencent.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, Matthew Wilcox
 <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li
 <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, Yosry Ahmed
 <yosryahmed@google.com>, "Huang, Ying" <ying.huang@linux.alibaba.com>, Nhat
 Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3 2/6] btrfs: drop usage of folio_index
Message-Id: <20250430140608.6f53896a1f09d58e65dd1cc2@linux-foundation.org>
In-Reply-To: <20250430181052.55698-3-ryncsn@gmail.com>
References: <20250430181052.55698-1-ryncsn@gmail.com>
	<20250430181052.55698-3-ryncsn@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 May 2025 02:10:48 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> Cc: Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: Josef Bacik <josef@toxicpanda.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: David Sterba <dsterba@suse.com> (maintainer:BTRFS FILE SYSTEM)

Please tell us where these extra tags came from.  Did some tool
generate them?

I think they're quite useful - perhaps something we could encourage.

