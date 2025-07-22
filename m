Return-Path: <linux-btrfs+bounces-15622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7253CB0D43D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 10:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0063A6E2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 08:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742162C326E;
	Tue, 22 Jul 2025 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rN87E8E8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A671EB9FF;
	Tue, 22 Jul 2025 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172181; cv=none; b=dVcqmZ+Dh/equVoUTAdthCSduOGyiM0fl4pGvS0sO54k8IW+HNSYAH0gMhNqbrsxIt2tPLskxSUK2W80B4tjNbhQfUTAEr9tV3rBi/tv4ezdKK1N/EqO7ap1x0AIa79KyASXgfGafApBXYWgzB+zpMujHi+5A3UEo6OefY60Wp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172181; c=relaxed/simple;
	bh=QH9N8xGLNGpk2Srk8msJhdqgUd/p4bty86Z/5jwVq+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHv6JAO/OD6R5mQ9pl1jsQ1ynaOZiaDYf2nXwFZFZpK1Hk+DyXvUPnd86dTSLtYqh8M7vVCi5Z4u3C6aMOJ5VnV+AJfwBZPRUicTDLxnnCIvHg70DwS8hIuYu6bSvmgVGbezyULv5ZMfsK88x+kMaz9VS7+a/J7F7UWeeNz7w+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rN87E8E8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w7SDQNCqmEtC4WzvVvc28QG/QoNPCtOImKQljNjeG4U=; b=rN87E8E8oOwUK+imBtBPMU0t/f
	YvEmeawneYojFChEQEVKmnbcS3T8SJx62Y4+bjgz9YO9lOjMVvlFvl9G+Ni0KFzMDxMAbWMaC2MAn
	TJDHkjB9QO2fmhz5MApAIslzofjy1BXtjf5qfEyEYJlGN2iLjtBcWdrL6N56ggR4/hlOAyiDfa55n
	B7wJwqYLxXlMGPS9Wwy/K8BOdUOfD24lUiUJYmdoUzluZjbrTFXkJewClewtOeJ9VmP/whcPTuCVl
	UBMjGMDoClHVwPRLZmoi1TILVQKXDMCADNCSS13PoY0BXf85f/QC7jClZ64+QQRmkbSpPtGHEJoEP
	bLOkgSaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue8Ad-00000001mzX-3QNF;
	Tue, 22 Jul 2025 08:16:19 +0000
Date: Tue, 22 Jul 2025 01:16:19 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"fdmanana@kernel.org" <fdmanana@kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v2] generic: test overwriting file with mmap on a full
 filesystem
Message-ID: <aH9I02-KLVuyybId@infradead.org>
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
 <681c9dcaca0bf16a694d8f56449618001cf20df6.1752166696.git.fdmanana@suse.com>
 <aH81_3bxZZrG4R2b@infradead.org>
 <ee8d5d39-7898-4e45-9f4c-359c2c7a64fd@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee8d5d39-7898-4e45-9f4c-359c2c7a64fd@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 22, 2025 at 07:50:48AM +0000, Johannes Thumshirn wrote:
> On 22.07.25 08:56, Christoph Hellwig wrote:
> > I just noticed this test failing on zoned xfs in current for-next.
> > 
> > That's because for out of place overwrite file systems writing at
> > ENOSPC will obviously fail, and I think the test acknowledges that
> > by forcing nocow for btrfs.
> > 
> > But that leaves "real" out of place write file systems affected, which
> > should also include zone btrfs, but the test actually fails there
> > in mkfs already due to some reason.
> 
> It probably fails the _try_scratch_mkfs_sized() call because that goes 
> into _check_minimal_fs_size() and that should _notrun if $fssize < 
> $MIN_FSSIZE.

Btw, it would be really helpful to improve the test coverage if btrfs did
the same adjustment for the nimimum size as zone xfs, where mkfs run up 
the requested size to the zone size and then adds the required extra
zones that don't show up in the user capacity.  That way all the small
size based tests just work.

