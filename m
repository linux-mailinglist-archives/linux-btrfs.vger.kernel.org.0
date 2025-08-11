Return-Path: <linux-btrfs+bounces-15987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3F7B20C31
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 16:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA3A7A5EAF
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD98A2D3725;
	Mon, 11 Aug 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VN24MNSn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5C2561A2
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923198; cv=none; b=PGOSnn8/z7B5oZhpIwtdc4R/YFSd37uFaR+Unl/Ys/mGSDdxwA1phenmFEyyqqF8o3/HCd7qWF9MCLG15EN8JqYqvPF8wxJJoz7pRUTCl+E9XjmGv6wcK0ocWcaG/VEj8syEHq5A+iAAZ4dqNrkngDT3TntgaSYGgAPBOTtB0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923198; c=relaxed/simple;
	bh=/ioprKEzI1qcsrbEC6w+eZ9U3l5T/Hu9whZ62ICUdU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hodroU/4cbpJv5k7hLuuazMWUA4FMCeganZfhQVRBOX8nlnExagQIGfW5cq5zpQdTTgvRvpydIwoWUsXpSR7gqXhKy2LqxNXKD/1PymjgwQr3Cf1FDdBoUAGAfUVlMfxX5FkRYEbqkFS8nSW39PNv5SKChpE8kL/LM1mIQXsVZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VN24MNSn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754923195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3jBX4j3yDpmQs2pQdcmkFlIUwpnim2gbOcYS+XAZawI=;
	b=VN24MNSnX8FATshQ9CkdFmTo8F/d3K1vFB83gSSpJPjNR1Ar/Dt3C8TLLfQ2GwKE3NNMvD
	zJ861SFH/nZS9EFvscsxikElANCIxpbWH7FWXbfo3LF7Ai9HDOrNIAqfnUaEBP1qKwhaPr
	B+Ci/aa0LArYcpu8xdVHF2WpYdiCWPc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-tBxsDExvMIqRtRkuzUh6Kw-1; Mon, 11 Aug 2025 10:39:53 -0400
X-MC-Unique: tBxsDExvMIqRtRkuzUh6Kw-1
X-Mimecast-MFC-AGG-ID: tBxsDExvMIqRtRkuzUh6Kw_1754923192
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459e6c564fdso18413785e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 07:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923192; x=1755527992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jBX4j3yDpmQs2pQdcmkFlIUwpnim2gbOcYS+XAZawI=;
        b=ss/gTPKwFA6pUQ568Z0uulbI2knjI76cmZOpYVZOyeLR+jA1QTeMKMVb3ZkgMiq7vy
         orjyCb+Y764gbYq4ZFZbmYlNK3jXtDx031lbj5Xnjp6yG3rLPegJY95tP7X0qXxXK6yM
         0mNyC4VOrzUDVMDMsqh06bzJPFysZWYdYfnmUAyylYy6ugLhG1S9MVqTkE2mU81hSe2A
         /JSoh1c52rgiC6OjLRc8js08XtQ4B22nbK7kSF4bnwFBpztZM33LvjngE/rZS0osBjOv
         zlX3aa5Ngm7/Vt8jyeoAt1cuQ0st5eE3FVkmTfUAUDHwV6qg9DFkUvhwXguMFZ7MU7pC
         bPbA==
X-Forwarded-Encrypted: i=1; AJvYcCXDtCPm90yy/phVDatw+1xhu89vXSaph8XZEsH8EgkqcfjSNm5SWERkQH+l8JD3Ae97kJtZph9rDY4QpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMjoUVx0bx4C27Ko7AAKa7gx8vFdYEcEhaP/haLQ6Eff41Jkun
	mX7KZya8OVAoZWoRdeJVpU8VEys2Ql6C6yIEIQiUzIioZH5jKYnC/9iLHoa+1dJv+XVDE53tvf5
	Br700bVTHIY0Wi2NPrSKh5Mmxr1uvHAAU1y9YY33dLvz/Ih/bkiO6SsnWJFtzGIGf
X-Gm-Gg: ASbGncs95d9h+XSalT/KJCd95JHMt1iwJ3qtir2NbdtSORs4esznJpoGw3ECbGwDrlk
	1KKQVn+KGJLhL2z1Lb2y5DuqwzXsCTq9uK5MN4KSYDPqq98v0Lh1Ko8avJWmr3JIcGpFmxLq/3u
	3Gea3SRs8UKDjwB+Y82A++A+PnhND8l3EA2PYrDLAIo4W6aILkpN6UXl9ekUQVc9ku2zxKrJ827
	dz1B2pMWNSPjNBOKbXfHRXX4fL+cX3Nod+ms2m33paSYa5lOec44elh39doOp9auAFzlOX4toVR
	AXO/m2gbidMk+C2fi/JEU09iabsokg/OIpv1IoQVKqtpPaUyGHyRH3wiV/woOhO3xuiNfUrhBHL
	PXlZopk1yPY2vzccy2vQRseCC
X-Received: by 2002:a05:600c:1c18:b0:459:443e:b180 with SMTP id 5b1f17b1804b1-459f4f3e153mr122954975e9.8.1754923192289;
        Mon, 11 Aug 2025 07:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+bcYyrzEHtg5O8YCja39RJfZF3lc/0BwBvrhjiRJgNhfaMkviNPqO5gGtgSpeCPJqwbl5CQ==
X-Received: by 2002:a05:600c:1c18:b0:459:443e:b180 with SMTP id 5b1f17b1804b1-459f4f3e153mr122954665e9.8.1754923191851;
        Mon, 11 Aug 2025 07:39:51 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e0a24bf1sm280478765e9.1.2025.08.11.07.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:39:51 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org,
	linux-btrfs@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Dave Kleikamp <shaggy@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v1 0/2] mm: remove MIGRATEPAGE_*
Date: Mon, 11 Aug 2025 16:39:46 +0200
Message-ID: <20250811143949.1117439-1-david@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is against mm/mm-new.

This series gets rid of MIGRATEPAGE_UNMAP, to then convert the remaining
MIGRATEPAGE_SUCCESS usage to simply use 0 instead.

Not sure if it makes sense to split the second patch up, a treewide
cleanup felt more reasonable for this simple change in an area where
I don't expect a lot of churn.

Briefly tested with virtio-mem in a VM, making sure that basic
page migration keeps working.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>

David Hildenbrand (2):
  mm/migrate: remove MIGRATEPAGE_UNMAP
  treewide: remove MIGRATEPAGE_SUCCESS

 arch/powerpc/platforms/pseries/cmm.c |  2 +-
 drivers/misc/vmw_balloon.c           |  4 +-
 drivers/virtio/virtio_balloon.c      |  2 +-
 fs/aio.c                             |  2 +-
 fs/btrfs/inode.c                     |  4 +-
 fs/hugetlbfs/inode.c                 |  4 +-
 fs/jfs/jfs_metapage.c                |  8 +--
 include/linux/migrate.h              | 11 +---
 mm/migrate.c                         | 80 ++++++++++++++--------------
 mm/migrate_device.c                  |  2 +-
 mm/zsmalloc.c                        |  4 +-
 11 files changed, 56 insertions(+), 67 deletions(-)


base-commit: 53c448023185717d0ed56b5546dc2be405da92ff
-- 
2.50.1


