Return-Path: <linux-btrfs+bounces-18033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E5BEFAAF
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 09:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969953ADA20
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7362DAFD8;
	Mon, 20 Oct 2025 07:28:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1601E264A90;
	Mon, 20 Oct 2025 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945312; cv=none; b=uPnO6jbxFVgiaKUcXF40QG5cqB1id+IoOReVudw7bF2Z2jXwyBs7c2wm2VFnihz6Ec1vhgRY9gY4vnc04N4QPT2VAtD5NKPYbO6KBipZdNXpH2YN2i8gvj8twNmMNXSrOvC497x2SylzmjZzizZ5hkHGTK4ePzCxwX/cZ9S9L04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945312; c=relaxed/simple;
	bh=jDjH+ohaZmejbfb9zqfXBjtq0NyX2pvNIgbid43g+OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD6MdoFa6NbIMJeZwr2LvSlYBVfSr7sqXFtGxfp0B/aiVvWGr9VvQSibN4ECUtEbjjv7kUYNtpA7EwhD+O7q5QmtPuVBHJOUZNt8DTbS1LBusuveoNtr25Yselb366M7CwOW18rar4L7ERQpHTQEpHBWifwnOyxij8uXd03M7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A30DA227A87; Mon, 20 Oct 2025 09:28:19 +0200 (CEST)
Date: Mon, 20 Oct 2025 09:28:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251020072818.GA28882@lst.de>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com> <20251016152032.654284-4-johannes.thumshirn@wdc.com> <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Oct 18, 2025 at 02:56:33AM +0800, Zorro Lang wrote:
> Does this mean the current FSTYP doesn't support zoned?
> 
> As this's a generic test case, the FSTYP can be any other filesystems, likes
> nfs, cifs, overlay, exfat, tmpfs and so on, can we create zloop on any of them?
> If not, how about _notrun if current FSTYP doesn't support.

We don't know, and it will be different based on the kernel version.
That being sayd, we should check for a block backed file system
probably.


