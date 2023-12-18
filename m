Return-Path: <linux-btrfs+bounces-1029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1B581748F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 16:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BF41F21CEF
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D189837892;
	Mon, 18 Dec 2023 15:01:43 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EADD1D132
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8EBBC68AFE; Mon, 18 Dec 2023 16:01:37 +0100 (CET)
Date: Mon, 18 Dec 2023 16:01:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 3/5] btrfs: split btrfs_fs_devices.opened
Message-ID: <20231218150137.GA19041@lst.de>
References: <20231218044933.706042-1-hch@lst.de> <20231218044933.706042-4-hch@lst.de> <9326eff4-fc35-42e7-a381-973a9a3d5e80@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9326eff4-fc35-42e7-a381-973a9a3d5e80@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 18, 2023 at 11:56:11AM +0000, Johannes Thumshirn wrote:
> >   	struct list_head seed_list;
> >   
> > -	/* Count fs-devices opened. */
> > -	int opened;
> > +	/* Count if fs_device is in used. */
> > +	unsigned int in_use;
> 
> Can we make in_use a refcount_t? That will catch eventual miscounts. 
> Also open/close devices isn't exactly a fastpath so refcount_t is good.

The refcount_t doesn't allow an increment to go from zero to 1, so
I don't think it fits here.

