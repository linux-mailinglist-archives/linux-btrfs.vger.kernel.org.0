Return-Path: <linux-btrfs+bounces-21937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FaVN4eJn2nMcgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21937-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 00:45:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5722319EFD6
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 00:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD0CC30683A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 23:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182F33859E1;
	Wed, 25 Feb 2026 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="NZaA/URT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC2A3783AB
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063084; cv=none; b=F7AgcyrIicXe8R0yeKHiOqtpISkVdtGd9qpX5f69n5NzClycziYLcSN4nGGBBCCDnJD7xr+B5l/AOVBtdFhoIooIB81SI/N7ExceNsgrlt0T8hDW1jOrfzzGjaeb1/lltxh0Uuif+GsxQGVTmEti/lDFu5fgYSH6Aup+dwfiGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063084; c=relaxed/simple;
	bh=RPYa8SOtCEMGYvfhLiG7oMZP0LUGjYMFBvMU/E6aYSQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mtzc0IgdPKsg9aWiISz8uCrdwRPgu/Ry0zKi/AHeZ44RRqvn6KtW9EcQwEkendUGkkn/WT3gTsHj3WS+UOczis1ptB1gUrYjx27v0D5FNHdF8QV0yI9Qi1f8j63ZgpQSedNcQIIBE5Kkp0Z3v47xFaYDsxysVk4o0ZiAnQvHv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=NZaA/URT; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNNBpO1399656
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 18:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=05jgbknsbqZP1uCdgxmv7u4HMp
	tdcfek0XZsU81eJwo=; b=NZaA/URTtN755x3xQdd19/fuZUZtYv1FQpcevc3XwH
	GiJ5HRxGcY9iy/OYljXRxusFlBguMsPnyZDcmgj6ga3FB3ZEB6s8V8MYK1RQkRqs
	73E3y2Il0kMvjM1FeCKvErS6Ge1o+L/OrnSKHrzy/0gMDrz4XGhlptm9EW5EZsiN
	KbNXNDLUxHRAHYoImMhwtPfSo5MKLD5TPNctjPWYbFCDuzg3+QLXfj4h+8nzvl+h
	eF35anfVfxgICHTPN/s3s6nvmvXB97+RSUwbstEdYahxR2kI4oqGBDlsjZPhkjFA
	35Gntn163Y2SMifNAIheBj42FBACqKtXgkrnpRQmM3NQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4chx6v6b9b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 18:44:41 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-899b4ce513cso24881136d6.3
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 15:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772063080; x=1772667880;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05jgbknsbqZP1uCdgxmv7u4HMptdcfek0XZsU81eJwo=;
        b=i3kdF7DVmq1csldA6iMXwdUBLW5+4ulHYYh1dvnrvKcRI9UIuOTz7y36wU9VzmVm5X
         NllbcLU5xorSiLH2k7fs//6NCRZ05+ttnSOsIYR8r0cUIMfz33jZtbUZaGVLxmmPKYbX
         sKvgFR0WFJ5QFvSLCmEvfk+xhc493H1kFjxKNvULL4fKHTBOvFTpOijxbqkzR7dmunGH
         4eOsTQJ88SqgkBbvEpnCz1hqh/T05hwyz+KtNSuRZzpkmI+fQx8U4MF21aEZioH9gWko
         7NhQawkeYRccF0G1v5L+W+MT3wdzig00V+8EcddBRGfmLXUceFQNU6ysj7qUSk9/sJMe
         moZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX09QOFNUywUdtuo4XU8a7tZBjA5d+t82Fm1AM/fKNn+M7kYLLTdL8IUqxjWToNvr6TWH4TTdkRQ7lBhA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc3NdUnCTEzcI7KDp6ioGIxhKb0bCZxaq61zlDvzx6Ae05IMFP
	xhP6hW9yP/NAfyEgg2tUJY7r+c7SKO0sKyBcZEuReQl1KSr90EKK7vacqAVWZ4HAdjgxR9spTAF
	QWMUnUoctIC4xeICh9rtL9FooQOFk6upXl2rRXr7aNVyNfYzMArAZfKO6hkVN
X-Gm-Gg: ATEYQzx/IQbv0ZX18P1GFbRZYzB2zn5HCVP6e6vbyjAykiMmdudBtp88bpppwp81zti
	FgAKRRB96OIx6QjUCxweaxqiiz0iUZQqRvBdMnKgSWgI/cWfPkFMxiGDnmBLKf98XelF8oGJMI/
	GB2ARGtWyuiybRt28FPRtZG8NNgr6dyOBrfvKGB0bldH4aFMo5PQa/GaXKE3WSJSSG4slRrO+kF
	1YouqfEuVYbyo+8wwRy6B2q48TQkUWnmG+DxwgjA4wHFFXClPO6xmNkrAHAUgd4YP0uspGLLWZT
	1cdH1wFx5ejecztJNBfK3sdu5TsYRpMay5LTjS8B6dhqDF0aUAsYXOVCwVA3CRKR/ewG3zQgh/P
	OpGPx+K6EfV1Ec6FPb3pSxyvO7cv74CBg
X-Received: by 2002:a05:6214:4387:b0:894:663f:cb4b with SMTP id 6a1803df08f44-89979e31f4amr253355046d6.7.1772063080184;
        Wed, 25 Feb 2026 15:44:40 -0800 (PST)
X-Received: by 2002:a05:6214:4387:b0:894:663f:cb4b with SMTP id 6a1803df08f44-89979e31f4amr253353936d6.7.1772063079588;
        Wed, 25 Feb 2026 15:44:39 -0800 (PST)
Received: from [127.0.1.1] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c738d80bsm3357606d6.41.2026.02.25.15.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:44:39 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v2 0/4] mm: Remove stray references to pagevec
Date: Wed, 25 Feb 2026 18:44:24 -0500
Message-Id: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFiJn2kC/3WNQQ6CMBBFr0JmbQ0dsBpX3sMQU9oBJkFoWttoS
 O9uZe/yveS/v0EgzxTgWm3gKXHgdSmAhwrMpJeRBNvCgDWqGvEknB4pkXmYmfQSnbDt2Uhl+np
 AC2XlPA383ov3rvDE4bX6z36Q5M/+byUppGguhNiqRjUWb2ad47NnfSQbocs5fwEZhc9ksQAAA
 A==
X-Change-ID: 20260225-pagevec_cleanup-d47c16cb0f2d
To: David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
        Paulo Alcantara <pc@manguebit.org>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-ext4@vger.kernel.org,
        netfs@lists.linux.dev, linux-nfs@vger.kernel.org,
        ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        cgroups@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772063077; l=3877;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=RPYa8SOtCEMGYvfhLiG7oMZP0LUGjYMFBvMU/E6aYSQ=;
 b=N/1edh2L6XTHkwD9ieSfOXn9kYa5DYTkRpLgb6W+Pjo3fqU/OShuTpJ0EUyLfSHC66PI9wcY+
 BU8+4Nx0zdtBWryBzWRqlHj5gGJzMg+bWxBXZztU9BaHETUf5RWJ+Bm
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: 8t3wS9BDlxX2htMExU5aAK4wCeN3D60z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIyNyBTYWx0ZWRfX4AhKYBhYlaMO
 H/F5uMjys3N0eLTJGqULMSLyXKiprJBiJNRw64Ve+rQ8gkSwLaxad9qhddMBTekSDoMyTe9Xd3f
 j1L3ymjkOjQjPKBl+N9e+UKZLYgCqqPIb7X3ijdZmNRrCYXXuAME1EV60Z4/z5YSUhhDcmnTcEg
 /JsGvOSOG4GGTyUFEtbO2F/XhbAcPE0fciRZ+aq4hu2bbqGM1HttcTmfcdpWXdPpXHPsB5hnRT9
 BLxHPG4ARyKfqaq2t4xYAFs5jE1/pYZhy4vwRVJsJH6hnFPqX4nBAwTHaMmbb1KevIivKO78G/H
 7SnDVxcZAGJW8roMkAIwOs38sndJuc7rDZrfm5F0jjAJvjaeQ9LEmHhGDXd4e4tLWYbq0SksAZl
 Sl2MtnpbCXxU71A8K5Bu0mhrdnLZ8Skms5s+lHe46rNJCJnB2ftHQFw5t0u9kVlQpu2Xa5RXEpc
 QySAUeLmwA5IWO2ggRQ==
X-Authority-Analysis: v=2.4 cv=FqMIPmrq c=1 sm=1 tr=0 ts=699f8969 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=VwQbUJbxAAAA:8 a=C2eTfLYCeeefI48a-yAA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 8t3wS9BDlxX2htMExU5aAK4wCeN3D60z
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11712
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=10
 spamscore=0 bulkscore=10 lowpriorityscore=10 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250227
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[columbia.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[columbia.edu:s=pps01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[dilger.ca,manguebit.org,kernel.org,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,gmail.com,microsoft.com,talpey.com,linux.intel.com,suse.de,ffwll.ch,intel.com,ursulin.net,fb.com,suse.com,redhat.com,dubeyko.com,linux.dev,oracle.com,brown.name,ziepe.ca,nvidia.com,cmpxchg.org,google.com,bytedance.com,lists.infradead.org,vger.kernel.org,lists.sourceforge.net,kvack.org,lists.linux.dev,lists.samba.org,lists.freedesktop.org,columbia.edu];
	FREEMAIL_TO(0.00)[redhat.com,auristor.com,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,tencent.com,huaweicloud.com,gmail.com,infradead.org,intel.com,suse.cz,zeniv.linux.org.uk,mit.edu];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21937-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[columbia.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[columbia.edu:mid,columbia.edu:dkim,columbia.edu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tz2294@columbia.edu,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[97];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5722319EFD6
X-Rspamd-Action: no action

struct pagevec was removed in commit 1e0877d58b1e ("mm: remove struct
pagevec"). Remove any stray references to it and rename relevant files
and macros accordingly.

While at it, remove unnecessary #includes of pagevec.h (now
folio_batch.h) in .c files. There are probably more of these that could
be removed in .h files, but those are more complex to verify.

---
Changes in v2:
- Add tags from Matthew, David, and Chris (thanks!).
- Add 3 new patches with more cleanups.
- Link to v1: https://lore.kernel.org/r/20260225-pagevec_cleanup-v1-1-38e2246363d2@columbia.edu

---
Tal Zussman (4):
      mm: Remove stray references to struct pagevec
      fs: Remove unncessary pagevec.h includes
      folio_batch: Rename pagevec.h to folio_batch.h
      folio_batch: Rename PAGEVEC_SIZE to FOLIO_BATCH_SIZE

 MAINTAINERS                                |  1 +
 drivers/gpu/drm/drm_gem.c                  |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c  |  2 +-
 drivers/gpu/drm/i915/gt/intel_gtt.h        |  2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c      |  2 +-
 fs/afs/internal.h                          |  1 -
 fs/afs/write.c                             |  1 -
 fs/btrfs/compression.c                     |  2 +-
 fs/btrfs/extent_io.c                       |  6 +++---
 fs/btrfs/tests/extent-io-tests.c           |  2 +-
 fs/buffer.c                                |  2 +-
 fs/ceph/addr.c                             |  2 +-
 fs/dax.c                                   |  1 -
 fs/ext4/file.c                             |  1 -
 fs/ext4/inode.c                            |  2 +-
 fs/ext4/page-io.c                          |  1 -
 fs/ext4/readpage.c                         |  1 -
 fs/f2fs/checkpoint.c                       |  2 +-
 fs/f2fs/compress.c                         |  2 +-
 fs/f2fs/data.c                             |  2 +-
 fs/f2fs/f2fs.h                             |  2 --
 fs/f2fs/file.c                             |  1 -
 fs/f2fs/node.c                             |  2 +-
 fs/gfs2/aops.c                             |  2 +-
 fs/hugetlbfs/inode.c                       |  2 +-
 fs/mpage.c                                 |  1 -
 fs/netfs/buffered_write.c                  |  1 -
 fs/nfs/blocklayout/blocklayout.c           |  1 -
 fs/nfs/dir.c                               |  1 -
 fs/nilfs2/btree.c                          |  2 +-
 fs/nilfs2/page.c                           |  2 +-
 fs/nilfs2/segment.c                        |  2 +-
 fs/ocfs2/refcounttree.c                    |  1 -
 fs/ramfs/file-nommu.c                      |  2 +-
 fs/smb/client/connect.c                    |  1 -
 fs/smb/client/file.c                       |  1 -
 include/linux/{pagevec.h => folio_batch.h} | 16 ++++++++--------
 include/linux/folio_queue.h                |  8 ++++----
 include/linux/iomap.h                      |  2 +-
 include/linux/sunrpc/svc.h                 |  2 +-
 include/linux/swap.h                       |  2 --
 include/linux/writeback.h                  |  2 +-
 mm/filemap.c                               |  2 +-
 mm/gup.c                                   |  2 +-
 mm/memcontrol.c                            |  2 +-
 mm/mlock.c                                 |  2 +-
 mm/page-writeback.c                        |  2 +-
 mm/page_alloc.c                            |  2 +-
 mm/shmem.c                                 |  6 +++---
 mm/swap.c                                  |  4 ++--
 mm/swap_state.c                            |  4 ++--
 mm/truncate.c                              |  8 ++++----
 mm/vmscan.c                                |  2 +-
 53 files changed, 56 insertions(+), 73 deletions(-)
---
base-commit: 957a3fab8811b455420128ea5f41c51fd23eb6c7
change-id: 20260225-pagevec_cleanup-d47c16cb0f2d

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>


