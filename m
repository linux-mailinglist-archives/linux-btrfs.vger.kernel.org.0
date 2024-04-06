Return-Path: <linux-btrfs+bounces-3998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72C789A91A
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 07:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5A7282B2B
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 05:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9199208BA;
	Sat,  6 Apr 2024 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lLPAYrt5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641231CD13
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Apr 2024 05:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712380856; cv=none; b=KK0n2I2iVIcATkUuAtugzZy+fBXkuQQUEUNbyo9y4g4E2qP/HJAn8KOoquslQj1pbYMIIlazlqMBZKcgQI017GG70YgjNqsWym2VeYRk/4m20Vn8/1hPOhRB2TmJLuCUGqsM3IMiwh9ShyEiUWnxeWHrH3RB347yOxq1XO4hDD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712380856; c=relaxed/simple;
	bh=PIoOgNzqkPt6pFqlUzqJVdnsJcxBBJL9KPIQo8L9CWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heQrbeE7Ijt2hhEKpgYF1KUAJAC/C1cQvwoDgIjGMDp+NWg2F1nS2JQkEX7wo7wEUbv7wYr/NFI0DQ4lNwAacRM1EtNrIYAymaDK4LUq/NUzEXVPeTJeQSGYjM0tMZRgc4rMFus9kfhc/Qop1sB2OTTFDM+xzKdoscCc9D7grVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lLPAYrt5; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 6 Apr 2024 01:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712380852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhfWeUnybAsPC5w2wnk+v+3mDew6UZBufRKxuTERnpI=;
	b=lLPAYrt5fteZomt541z2r9imi7ugwkVNiZC5pZZu3KjNFo/chRlOU1XA+bzccxMdMbIll9
	iA+zhVqapFEEo0NHoRaICnZZ4CQhn70DUUTzecq//OFELR8OzaQySC7v12I2ZtwQTy4tva
	HKowOJToS6St8IaHHb2Zg43DVWkqMkE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, 
	Jonathan Corbet <corbet@lwn.net>, Brian Foster <bfoster@redhat.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, linux-doc@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel-team@meta.com
Subject: Re: [PATCH v3 13/13] bcachefs: fiemap: emit new COMPRESSED state
Message-ID: <2iyoi665o6hogzzlfhs6ets6vq2joh4xi5t3fbcpdmlv2cyrxu@7umadxpnaql7>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <943938ff75580b210eebf6c885659dd95f029486.1712126039.git.sweettea-kernel@dorminy.me>
 <7CF0A3D0-50E7-448F-A992-90B9168D557F@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7CF0A3D0-50E7-448F-A992-90B9168D557F@dilger.ca>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 05, 2024 at 01:17:45PM -0600, Andreas Dilger wrote:
> On Apr 3, 2024, at 1:22 AM, Sweet Tea Dorminy <sweettea-kernel@dorminy.me> wrote:
> > 
> > Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> > ---
> > fs/bcachefs/fs.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> > index d2793bae842d..54f613f977b4 100644
> > --- a/fs/bcachefs/fs.c
> > +++ b/fs/bcachefs/fs.c
> > @@ -921,7 +921,7 @@ static int bch2_fill_extent(struct bch_fs *c,
> > 				flags2 |= FIEMAP_EXTENT_UNWRITTEN;
> > 
> > 			if (p.crc.compression_type) {
> > -				flags2 |= FIEMAP_EXTENT_ENCODED;
> > +				flags2 |= FIEMAP_EXTENT_DATA_COMPRESSED;
> 
> (defect) This should *also* set FIEMAP_EXTENT_ENCODED in this case,
> along with FIEMAP_EXTENT_DATA_COMPRESSED.  Both for compatibility with
> older code that doesn't understand FIEMAP_EXTENT_DATA_COMPRESSED, and
> because the data still cannot be read directly from the volume when it
> is not mounted.
> 
> Probably Kent should chime in here with what needs to be done to set
> the phys_len properly for bcachefs, or leave this patch out of your
> series and let him submit it directly.  With proposed wrapper in the
> first patch of the series there isn't a hard requirement to change
> all of the filesystems in one shot.

You get phys len from crc.compressed_size - that's always guaranteed,
even if it's not compressed

