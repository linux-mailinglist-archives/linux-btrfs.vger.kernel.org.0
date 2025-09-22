Return-Path: <linux-btrfs+bounces-17088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF91BB924BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 18:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504E12A5F1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4C2E7647;
	Mon, 22 Sep 2025 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SDY9slc8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EA63126A5
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559689; cv=none; b=YPbwevVmWwtmwTWENi6nvkf0Ndzpl/WwBds5Ps1/zMSpeol6ymBGRkcL+qZDRnTdtCZ6HOERW2DhK3bSJdhm+MMuCfqfCqKZsLbd75YkBrSqFmZuAKtPuZ+nEwm0zUqNE+rvBl6JQudA6ffAhZUEpH5LQWJPzPSWJOzTGbQJmWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559689; c=relaxed/simple;
	bh=PLrF8wmo0aeh4vR2S8ylJ00wtzsd5tXLmjKALr5s0zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxCeJJ32Cpjog6lPj//DjmTKJJz/7maerSGGLX8nLSag0JH6R1+tccc4h+UlVe7JFzA7oBZPDDO7zw4AQhNyA1e2b1XPOJIdHZBn9ja0SBboEibt7d1ngmBm78kx/5K5MvUu17Al+ugK6n9Hbysry7s3DUlACFqHsLdCokoeUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SDY9slc8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zT2zKQpFx8eh1hOlTNS/xkasQvQq8CbU6LWY3gyJdMg=; b=SDY9slc8UQF6JHoQ7PorbPGnsR
	wc87KnvJ3SImivoAM+xRRVTaQOg/uyb3Fatp/umWEwlmtCwC7ligJWjLAODt5H9ihoOAeqR6Tk3sT
	NBAVbHhyStMB+x8Eih60nYbppR0xyuEtcMUOJVG2qsH4F6MOVV4sYqLT8wQcsSYXvnf2fQD2Bpw3K
	De4ZGcPZE3KZ3uE3xLsshf4HEyhAHR9xIBBrfFJPM9/xGYB1vctyQoflHsE/tj1pz8i3V2CQkEiYd
	T53NycT3FJUy6Ot+NQngVe/9NX9NokWoSC0KNVBGb4TZQg2inbZo/licKHI3u/YhBFDoMe2yhnPWu
	NsLXJzvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0jhs-0000000B1Qc-2MOT;
	Mon, 22 Sep 2025 16:48:04 +0000
Date: Mon, 22 Sep 2025 09:48:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
Message-ID: <aNF9xH30pAEq5y4r@infradead.org>
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Sep 21, 2025 at 08:07:10PM -0400, Demi Marie Obenour wrote:
> Wyng Backup (https://codeberg.org/tasket/wyng-backup) relies on FIEMAP
> to determine which parts of a file have not changed since it was last
> backed up.  Specifically, the output of filefrag -v is passed to sort and
> then to uniq, and differences between the outputs for the file and
> the previous version (a reflink copy) determine what gets backed up.
> 
> Is this safe under BTRFS, or can it result in data loss due to data
> not being backed up that should be?  In other words, can it result
> in data being considered unchanged when it really is?

This is not safe with any file system.  FIEMAP is purely a debugging
interface, and the output may or may not correspond to physical
block numbers.  E.g. for btrfs it points to virtual space, for XFS
it can point to the RT device.  It also is racy against file I/O.

The idea of that tool looks nice, but without a proper kernel interface
to look at the relationship between two files in a way that is locked
against I/O it is fundamentally unsafe.


