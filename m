Return-Path: <linux-btrfs+bounces-19516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 359E9CA3154
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 10:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36B1C3005C79
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF583370E5;
	Thu,  4 Dec 2025 09:49:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FC331237
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841768; cv=none; b=NrBoGmeXig1qplUVNiu467+CZZG9Oqm0/tZVo+xmagSIc3FT58hG+zNo0gW/c2D7tsDoX/QJEYLNkOhjBs7FbZfRfMEPPyo9ECbYaddKQf83QOPbE2eg3bUqnh8L4x1zFVdclQaJdQBKb2tVRN4Cs74O2rsWLY/oBiMyC9hiI5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841768; c=relaxed/simple;
	bh=3+wZ17fjavHIUIGkQz2WrmvvrMsrbhEWvRcgGRmeusk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4iPFJBWxnX//tpujWQ7V2m2QJYMj8lB6u6yn3Uf8R9HjCz3h2uoBYn541FIMeXltT2bv5S10pvNsx5yNR+PjEl0CJddwdKfhaKAJTGxf4xPOPFOkxWWtFTWmm15+YWL86NJnwz7MMg73wRcxdVhPn2PSgo6JE9uAg8w9Ng2Qhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B78B968AFE; Thu,  4 Dec 2025 10:49:21 +0100 (CET)
Date: Thu, 4 Dec 2025 10:49:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH v2] btrfs: zoned: don't zone append to conventional zone
Message-ID: <20251204094921.GB20158@lst.de>
References: <20251203133132.274038-1-johannes.thumshirn@wdc.com> <20251204092649.GB19866@lst.de> <2804c8fe-3c8f-4395-8ca9-6a99de1e41bf@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2804c8fe-3c8f-4395-8ca9-6a99de1e41bf@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 04, 2025 at 08:13:42PM +1030, Qu Wenruo wrote:
>
>
> 在 2025/12/4 19:56, Christoph Hellwig 写道:
>> On Wed, Dec 03, 2025 at 02:31:32PM +0100, Johannes Thumshirn wrote:
>>> +++ b/fs/btrfs/bio.h
>>> @@ -92,6 +92,9 @@ struct btrfs_bio {
>>>   	/* Whether the csum generation for data write is async. */
>>>   	bool async_csum;
>>>   +	/* Whether the bio is written using zone append. */
>>> +	bool use_append;
>>
>> The code I'm looking at doesn't have async_csum yet, but with that and
>> the existing bool + blk_status_tthis would grow the structure, which is
>> a bit unfortunate.  Either make these bool bitfields by adding : 1, or
>> just pass the flag on and stash it into async_submit_bio for the async
>> case.
>
> My code base (with async_csum) shows there is a 4 bytes hole, thus this new 
> one won't increase the size of btrfs_bio:
>
>         struct work_struct         end_io_work;          /*   160    32 */
>         /* --- cacheline 3 boundary (192 bytes) --- */
>         blk_status_t               status;               /*   192     1 */
>         bool                       csum_search_commit_root; /*   193  1 */
>         bool                       is_scrub;             /*   194     1 */
>         bool                       async_csum;           /*   195     1 */
>
>         /* XXX 4 bytes hole, try to pack */

Oh, I didn't have is_scrub either.


