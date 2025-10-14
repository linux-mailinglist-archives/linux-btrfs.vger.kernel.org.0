Return-Path: <linux-btrfs+bounces-17750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59203BD7415
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 06:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB8B19A1B7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 04:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AA430BB81;
	Tue, 14 Oct 2025 04:30:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581BF3090DC;
	Tue, 14 Oct 2025 04:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416208; cv=none; b=fz5tFw9/7wexCKzgIvk1thOCVYeOK2JGf5F/S6h7L/DzaDtvKf5YvOw16KeL5sH9uVAzSKgosbIPnjh1wj3D6VdoTfuZcsbQWC6QajGYdOnVCKIEQjHaed+NMVkTSxHzDIN3c37wOJ0be7+Hw3Tgdr70TiQk2xiLI3H7CeDq7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416208; c=relaxed/simple;
	bh=Kdt3TcrVab/EWVFqOCiAkBoyxuRkqAiWHLfEWei8klQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLVveo9cZik2ftXqKzOXqTvZbJ8oxVQIgaPipJ8yK37sjUJiwO+cUx5YV8PiCZ5vcIbQ1ry/XrtpAz/0BoFN8jLV+G6eEqS4gMOvajM5rj7A6rNPQbJQy8i0htpvdasf/ODJbH326HdstgJERRb/WuWPKvlJ3YbaIgByJqpPc7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B6DF227A87; Tue, 14 Oct 2025 06:30:01 +0200 (CEST)
Date: Tue, 14 Oct 2025 06:30:00 +0200
From: hch <hch@lst.de>
To: Anand Jain <anajain.sg@gmail.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Zorro Lang <zlang@redhat.com>, hch <hch@lst.de>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v3 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251014043000.GA30741@lst.de>
References: <20251013080759.295348-1-johannes.thumshirn@wdc.com> <20251013080759.295348-4-johannes.thumshirn@wdc.com> <006ae40b-b2e6-441a-b2d3-296d1e166787@gmail.com> <4eeb481f-b94d-4c2f-909e-7c29ac2440b2@wdc.com> <97aece25-d146-4447-9756-f537acadace1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97aece25-d146-4447-9756-f537acadace1@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 13, 2025 at 10:42:03PM +0800, Anand Jain wrote:
>> So I /think/ you just validated that the skip if !CONFIG_BLK_DEV_ZONED
>> && !CONFIG_XFS_RT check works.
>>
>
> Ah, thanks for clarifying. Any idea if the redirect to seqres.full can be 
> fixed? It was missing the mkfs errors.

With "fixed" you mean not having the mkfs errors in $seqres.full?  It's
kinda useful to have the messages there to see why the test wasn't run.
What speaks against having the messages logged?


