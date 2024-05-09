Return-Path: <linux-btrfs+bounces-4869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B04E8C0FF8
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 14:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1EF1C22525
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0221C14A4EE;
	Thu,  9 May 2024 12:54:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1917579;
	Thu,  9 May 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715259258; cv=none; b=t2Vz4LuTyj74s3kr5ZSfhiN7bnI7qSMaPzFyOI2JlTjx6szakJ+mdbLlFx5oVcPF7ZCLqY7NxwWcfWDZceFSzZdmF6BX//W4xeCkkJHorC2loFQ08f33PcOZF9CXo1oECjsu3MmsX+VOhtgM1ILIlSPmR5Xs4Z8AbKPMkO6JuME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715259258; c=relaxed/simple;
	bh=Bqk+rtNpdO6EGtvjIYubK1QLxzWtDcvjN8jAUeLTt9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYuZTOfXP+MPDrwuOeFpbPvcx26gJXHsAbN60tQWK8ESfAiNj+79QXDTm9MApAc17/fnkpqnzXpC9kHCftBmcTy98WRRIsPPju6C7UV1ju2gPlZ11K48q0zHKjHsmPC4C05ubLrqj8u66UdJJmmuzRjyLox5ALMWfKCsUssqZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9FC268C4E; Thu,  9 May 2024 14:54:12 +0200 (CEST)
Date: Thu, 9 May 2024 14:54:12 +0200
From: "hch@lst.de" <hch@lst.de>
To: Zorro Lang <zlang@redhat.com>
Cc: "hch@lst.de" <hch@lst.de>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	Zorro Lang <zlang@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Matias Bj??rling <Matias.Bjorling@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"daeho43@gmail.com" <daeho43@gmail.com>
Subject: Re: [PATCH] generic: add gc stress test
Message-ID: <20240509125412.GA12191@lst.de>
References: <e748ee35-e53e-475a-8f38-68522fb80bee@wdc.com> <20240416185437.GC11935@frogsfrogsfrogs> <20240417124317.lje5w5hgawy4drkr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <eddca2b5-0c15-4060-ba7b-89552de4a45d@wdc.com> <20240417140648.k3drgreciyiozkbq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <edcb31e0-cddb-4458-b45e-34518fbb828d@wdc.com> <20b38963-2994-401c-88f8-0a9d0729a101@wdc.com> <20240508085135.gwo3wiaqwhptdkju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <20240509054347.GA5519@lst.de> <20240509094208.ulez6lg7ymesmhej@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509094208.ulez6lg7ymesmhej@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 09, 2024 at 05:42:08PM +0800, Zorro Lang wrote:
> Hmm, what kind of situation is this _expected_failure for?

Well, the one we are talking about here.  We have a new and useful
test, and a file systems fails it because it has a bug.

Personally I'd be fine with just letting it fail, but you seemed to
indicate that this is a reason to not merge the test yet.

> I hope we can fix the obvious case issue in reviewing phase, or deal with the
> failure by 1) or 2). For this patch, I think we can find a way to avoid the
> failure for btrfs, or let this test "not supported" by btrfs. Or any other
> better ideas :)

It is a normal use case that every file system should handle and btrfs
developers are looking into it, but it might take a while.


