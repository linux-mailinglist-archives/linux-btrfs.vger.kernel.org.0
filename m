Return-Path: <linux-btrfs+bounces-19457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B929C9BA5D
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 14:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19B584E344D
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 13:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6F8315D52;
	Tue,  2 Dec 2025 13:44:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2383530EF88
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764683058; cv=none; b=AP3uNsvpht/XINt9uNrNkdTkzSd295UjCukoPHSdakmgAcMGGFPvChlLiB5o8kILO98b789lTV0XsCYT85f1/sS2nn55h1QdM7fB+zaLS+iHM1kvUJYFy1VECXB7zYQ7Ge5Ls9Sa6PO+KxkqU8oT0q7JutOrkRN79m3l3LNbvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764683058; c=relaxed/simple;
	bh=0c7ebdwVgg8KFiQ4JNJsljyKuTP70taQa/Y0KxfVP5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um6WfxGAgMmbiVPzmofBcxp1w9ljbH6GGvJO+qjkUnBpJODfQOR3AqX9JGCimy762fmSc4Ot8j1TUQKNUlcj1TQ+1a0CWwztOLaTW/cecGIBhCOooc8QawOT+zsMG6ETfI5RPxR5HSfia08XNdflY9T7Bqep3gVYbNqvQHTxYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3004D6732A; Tue,  2 Dec 2025 14:44:14 +0100 (CET)
Date: Tue, 2 Dec 2025 14:44:13 +0100
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: don't zone append to conventional zone
Message-ID: <20251202134413.GA25716@lst.de>
References: <20251202101631.155235-1-johannes.thumshirn@wdc.com> <20251202132943.GA25391@lst.de> <f746ae11-f29d-4b6f-b2c2-1fcd63713c24@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f746ae11-f29d-4b6f-b2c2-1fcd63713c24@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 02, 2025 at 01:43:07PM +0000, Johannes Thumshirn wrote:
> On 12/2/25 2:29 PM, Christoph Hellwig wrote:
> > On Tue, Dec 02, 2025 at 11:16:31AM +0100, Johannes Thumshirn wrote:
> >> In case of a zoned RAID, it can happen that a data write is targeting a
> >> sequential write required zone and a conventional zone. In this case the
> >> bio will be marked as REQ_OP_ZONE_APPEND but for the conventional zone,
> >> this needs to be REQ_OP_WRITE.
> >>
> >> This is a partial revert of commit d5e4377d5051 ("btrfs: split zone append
> >> bios in btrfs_submit_bio") which was introduced before zoned RAID.
> > Hmm, how does the BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE flag used by
> > btrfs_use_zone_append actually work for the raid code?
> 
> 
> If one of the zones backing the block-group is sequential the flag is 
> set, see btrfs_load_block_group_zone_info().
> 
> > Either way, this is a bit ugly as we now special case zone append in
> > multiple places.  Can we just pass the use_append flag down to
> > btrfs_submit_dev_bio and only set REQ_OP_ZONE_APPEND there to keep it
> > all tidy?
> Let me have a look how we can make that non-ugly. Or just use 
> btrfs_dev_is_sequential() in btrfs_submit_dev_bio(), which is probably 
> nicer as it doesn't need a rbtree lookup for the block-group.

Well, it still needs to check all the other conditions that prohibit
using zone append (metadata, reloc inode, ...)

