Return-Path: <linux-btrfs+bounces-18137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C6BF9F1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 06:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A68560306
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 04:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DD62D6E43;
	Wed, 22 Oct 2025 04:32:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031C1DF252;
	Wed, 22 Oct 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107554; cv=none; b=gtPY595ngPidpcXQE8tNg6XyLrXjfFVyRxwfgYuTzGCjmV+dn73tDMSLU6Tu9gPy+iO0f3IZdysTvM/vBA6LdOvtogVWAxFcl8dYPJib7eZQTK747tkD0tpU4d+b/BM5F1vZjJ42tolA6IEapygqkUMNK2VmiVUKuYtiMVxonzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107554; c=relaxed/simple;
	bh=saVwz+KhFex0Y4QpEcot6u4UOspVXV/nqJ39ZKC2ie8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFbNMqDcVwB5DYsCHodVNTbi5756UX7LFimC6snzFKFgq679lO+iKk2NXSbtuS8TPJQAO9gA4TBUPIkuzGs37jC/UlBSGwOSdZ7mhe+WLdHdbLQ0vrUeHrckWNqQYO8IwGWGi8dIZKCCHRWJv+m9hJfHt8T1xnVdOt3b+y1Z5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BF04227A88; Wed, 22 Oct 2025 06:32:21 +0200 (CEST)
Date: Wed, 22 Oct 2025 06:32:21 +0200
From: hch <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Zorro Lang <zlang@redhat.com>, hch <hch@lst.de>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251022043221.GA2371@lst.de>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com> <20251016152032.654284-4-johannes.thumshirn@wdc.com> <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com> <20251018140518.2xlpmmqajgaeg7xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <8253d6b9-e98b-4a05-80c0-f255ec32ee38@wdc.com> <16e539fe-b9f0-4645-b135-3930df249eab@wdc.com> <20251021144920.GH3356773@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021144920.GH3356773@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 21, 2025 at 07:49:20AM -0700, Darrick J. Wong wrote:
> Except for zonefs, I think you probably have to try mkfsing the zoned
> block device to decide if the fs really works because the others all had
> zone support added after the initial release.

zonefs isn't support by xfstests because it simply shows a fixed layout
of one file per zone and thus none of the tests would work.


