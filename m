Return-Path: <linux-btrfs+bounces-18733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B60C36978
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 17:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C2D64443B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01132ED58;
	Wed,  5 Nov 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oXBG7qxR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A861331A59
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357510; cv=none; b=pxm/u+zuJe+riWzMtDW7/tmC1JTbQn+5GT/UhC1YhsgI4fPfztm6G8UnyC2rwy4gQazoffw5LBcU7cUxXTFZwLQHnArPVV0peQnCUQBnpDLFvG9i0Vp753c5o2bCvUryBOpgDvFMI1ripk6u0lszhy1lukwAzTXXKuAXi9Wtc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357510; c=relaxed/simple;
	bh=vBpIbHl5BJYu3GvhFAscHMjHAct8CImIgNJ4c1z/oeA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a7xdwuaaEDdHjcx2qOLpMz4oU1tLm+MOJyYUywuA4wnXeiBbxjpx0fsmSd7aBv2HWNvxd0xPCoMgkbK98I21nblnW6maMrAQWYyaZLVHm1H+ztbpstOVnyjY/4BY1neSgzQo2KZ45tzEBUO42b7LO7KvqvUaYsb1CAvc2jkqjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oXBG7qxR; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-94863b3620cso154170839f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Nov 2025 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762357507; x=1762962307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmEA5UIRtFUkoJTebXPiJtfqEeDxZBhUOtjCk6lwm1Q=;
        b=oXBG7qxRAgxxpjvyoxPULOa1fgROdBp/4Z8g918iu8f5OrPjl3F4GHIx5MFNTDhIAn
         pqEWO68Dj3gmQhJr7qUItHwJwG64ld8NCI3MV7bCUWXu1dZb9kfWdGjqhLEvZ479OLxd
         7WiqKEvubQDho+R74G9Dyx22NjREEAjXzpV9A8ulR2vqMXlAUzbRrF27vJeKUN9IErWH
         nS5fM8dz6irJDPhN+oXQW2NNuh/Xd+GhLhTh5UE92ErPNvWvCwMnK0USG76HfdDLNIZh
         XCRNyUDNOSW9hHsEDGFGMI7ZCsw/O3VLkbMk72QQA/atz5Zr6aL5e+7DVF1PHSDpOj60
         NUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357507; x=1762962307;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmEA5UIRtFUkoJTebXPiJtfqEeDxZBhUOtjCk6lwm1Q=;
        b=AzAnd1Zv8schziWRRABIP7WboW0ot9PoQu4H67r1snsPhmUAd42Z3ZTxlJLV+zEKuS
         7CyHNpzdzhBjyJ4w810pXVdko5523vFcp4Jbd24wMyHluhRzbyNxChcP3Xz+SfWP7qhn
         KTIDft4xlLxkI50sXDLCR3RgNKGxCaldqfp01PPHOoxpgEzOcAoG7aXA99tuy0j5Avkl
         8KwHApk2dzWk5TtmGIjjNFIBne7OVWGKoz0I3dU0sBCHOESJymqEqEo6f7QI/t//pfHx
         QGTovFW7AnUIYJlrV/CVJGebdb8NPMMO/7PczNVlleVWRUTvMjBaZpT/1f8+Gp97MTH4
         Hi0w==
X-Forwarded-Encrypted: i=1; AJvYcCVeRQHtfe66kDd8UYqJXeAe9fIPvuqsR/WX/tOTCb2dDvNUHxK4QjlQcmPFng9oQeS2HLg0FRvn3yvp3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmW6/OTntKnL3uTcPxL0iuaSc5qCtJNB+GegX5J3HYDXrYVI5N
	biAWc9lzrkS3zc0snunW3Lf81JHmgU6kp3LM9xk8WrG+E2MgTuJF3uMsoKFtRbsa34A=
X-Gm-Gg: ASbGncttbIcsemE1LguWGWFy+XB3kU/JxW6x1m/TJ6f4840RpU/713akdKIsSMJw4x8
	GpAooFxLrKRPjjYqYAk5abOeZbuYxsN2cEnzKRLfJjukqWzXSKkvG8CTI0JwIEDrcA776d18wEm
	EtgcESKMMWA+13XtYt9KaBp+adIQN/5izBi3Xyqs1QLzZsNnlKUdMTXx/7dE1xi38zFEk0Zvqr0
	4P6IGm7+tfYV8no3+6n81N2rH8KEqV50TQjUetAHczo6P08+DPsQfjIALGnyYQSGpI8pKDM1LfY
	X3Jq4Bii/mznpDTk27wNmqlGRd2BOj4bHn5fWHGk+ekuhjy7eEeTAflhHuDBv9ucrQptcjFhkT0
	5vhD5ZsM/phzkWGiRpluOIH+4+TYik5xM3Zs8TfHMvYiIHRIdOTkO1BjRNnS4vnvpFZiwWXGZT3
	mzLA==
X-Google-Smtp-Source: AGHT+IGRprlY0B/j7MFC0euD5DLU4VAIhfixS9xB+G6Pb3CIfQJOwUgjuW1G2xa98UfKd2ncVWvKMA==
X-Received: by 2002:a05:6e02:1a85:b0:433:2957:2e87 with SMTP id e9e14a558f8ab-433407d98e4mr47454155ab.28.1762357507117;
        Wed, 05 Nov 2025 07:45:07 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b72258d4e8sm2521439173.3.2025.11.05.07.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:45:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>, 
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org, 
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org, 
 David Sterba <dsterba@suse.com>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20251104212249.1075412-1-dlemoal@kernel.org>
References: <20251104212249.1075412-1-dlemoal@kernel.org>
Subject: Re: [PATCH v4 00/15] Introduce cached report zones
Message-Id: <176235750606.190479.10317258805246349798.b4-ty@kernel.dk>
Date: Wed, 05 Nov 2025 08:45:06 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 05 Nov 2025 06:22:34 +0900, Damien Le Moal wrote:
> This patch series implements a cached report zones using information
> from the block layer zone write plugs and a new zone condition tracking.
> This avoids having to execute slow report zones commands on the device
> when for instance mounting file systems, which can significantly speed
> things up, especially in setups with multiple SMR HDDs (e.g. a BTRFS
> RAID volume).
> 
> [...]

Applied, thanks!

[01/15] block: handle zone management operations completions
        commit: efae226c2ef19528ffd81d29ba0eecf1b0896ca2
[02/15] block: freeze queue when updating zone resources
        commit: bba4322e3f303b2d656e748be758320b567f046f
[03/15] block: cleanup blkdev_report_zones()
        commit: e8ecb21f081fe0cab33dc20cbe65ccbbfe615c15
[04/15] block: introduce disk_report_zone()
        commit: fdb9aed869f34d776298b3a8197909eb820e4d0d
[05/15] block: reorganize struct blk_zone_wplug
        commit: ca1a897fb266c4b23b5ecb99fe787ed18559057d
[06/15] block: use zone condition to determine conventional zones
        commit: 6e945ffb6555705cf20b1fcdc21a139911562995
[07/15] block: track zone conditions
        commit: 0bf0e2e4666822b62d7ad6473dc37fd6b377b5f1
[08/15] block: refactor blkdev_report_zones() code
        commit: 1af3f4e0c42b377f3405df498440566e3468c314
[09/15] block: introduce blkdev_get_zone_info()
        commit: f2284eec5053df271c78e687672247922bcee881
[10/15] block: introduce blkdev_report_zones_cached()
        commit: 31f0656a4ab712edf2888eabcc0664197a4a938e
[11/15] block: introduce BLKREPORTZONESV2 ioctl
        commit: b30ffcdc0c15a88f8866529d3532454e02571221
[12/15] block: improve zone_wplugs debugfs attribute output
        commit: 2b39d4a6c67d11ead8f39ec6376645d8e9d34554
[13/15] block: add zone write plug condition to debugfs zone_wplugs
        commit: 1efbbc641ef7d673059cded789b9c8a743c17c9a
[14/15] btrfs: use blkdev_report_zones_cached()
        commit: ad3c1188b401cbc0533515ba2d45396b4fa320e1
[15/15] xfs: use blkdev_report_zones_cached()
        commit: e04ccfc28252f181ea8d469d834b48e7dece65b2

Best regards,
-- 
Jens Axboe




