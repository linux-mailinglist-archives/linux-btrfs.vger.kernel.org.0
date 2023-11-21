Return-Path: <linux-btrfs+bounces-261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB117F3471
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 18:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7E91C20ADB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6342C5674F;
	Tue, 21 Nov 2023 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0EF12C;
	Tue, 21 Nov 2023 09:03:30 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D72267373; Tue, 21 Nov 2023 18:03:27 +0100 (CET)
Date: Tue, 21 Nov 2023 18:03:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 2/5] btrfs: zoned: don't clear dirty flag of extent
 buffer
Message-ID: <20231121170327.GB19695@lst.de>
References: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com> <20231121-josef-generic-163-v1-2-049e37185841@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-josef-generic-163-v1-2-049e37185841@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  	if (test_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags)) {
> -		WARN_ON_ONCE(found_start != 0);
> +		memzero_extent_buffer(eb, 0, eb->len);
>  		return BLK_STS_OK;

> +	if (btrfs_is_zoned(fs_info)) {
> +		set_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags);
> +		return;
> +	}

Maybe these two places would benefit from comments on why the buffer
is just marked as cancelled and zeroed out (that is to keep the
write order because block numbers are already assigned)?

Otherwise this looks great:

Reviewed-by: Christoph Hellwig <hch@lst.de>

