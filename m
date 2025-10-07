Return-Path: <linux-btrfs+bounces-17493-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B0FBC024A
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 06:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDA31899ACB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 04:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409862153EA;
	Tue,  7 Oct 2025 04:15:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512AA945;
	Tue,  7 Oct 2025 04:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759810545; cv=none; b=TbH+iFsz7oGo+Cff28HaST3rDFC6EjpI871sXt/yT61dDi1XStZuLiCaiffAGb4/7KSPuDLdIzYiAf0ImiJzaV02e/IA8Cxjbmsg7lWUwEs85J78Okof4ZSVdAeFRngr3iYl/k+HCxqDzssq9uDMahkTrqrTcM24q4vtuszK2OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759810545; c=relaxed/simple;
	bh=k7b4vBLrnUNM1hh9LWLBsC6EIL+o0Y79pivSXwYilR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To+yQWi+OCY+DorcEYvlDGEdfcBrTnENi0vT85BvPAnuFL0+xCBx307auG8lGeHlHH99Bbim9L0P9f0HKHoixy2v9dClZZoNRHGkZl1mK/5HGhtNRVl53GtNSLrJg3IUOsm0u3bcQC5dChvsN3AN3KMy4dbfGCPq+VH0jQp9xDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2DA1227AB1; Tue,  7 Oct 2025 06:15:39 +0200 (CEST)
Date: Tue, 7 Oct 2025 06:15:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/2] fstests: basic smoke test on zoned loop device
Message-ID: <20251007041539.GA15817@lst.de>
References: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 06, 2025 at 03:24:53PM +0200, Johannes Thumshirn wrote:
> Add a very basic smoke test on a zoned loopback device to check that noone is
> accidentially breaking support for zoned block devices in filesystems that
> support these.

Thanks!  Having a least minimal zoned file system coverage in standard
xfstests runs seems really useful.


