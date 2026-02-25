Return-Path: <linux-btrfs+bounces-21938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM5kNomJn2nMcgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21938-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 00:45:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7893E19EFE6
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 00:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F51A3032072
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 23:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1336438735D;
	Wed, 25 Feb 2026 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="k8p8qfY6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582183859D0
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063086; cv=none; b=lEasHLl+RfvK2VB6/RiW7qSmLEXsIoSHJbPmJRNOPWwXXado42E5zb7Bv6X+D6g2/uSX6Ji8OumwVCIXP36LcLJCcTVDiTfvU7GBXOv7hAjbRevx2Svcpj/t1O9hVaM6udYI50Yok4gNcwEeIzMGhIhdCEb19OVyNaUFIT6czKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063086; c=relaxed/simple;
	bh=86tTrdoOnAn/xo3cekp1XuyRqb4HRFNzoiKbv0I1ps4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bmd45btKR31GI386pj5v71BgKq5inDHxuA7y1nWLK+OxCAXz7wYDHQP9n1w8ZNNjY/tle6y1FpomdXk893rv1R1tR0IeTfFZPaAV3iiFVPFsbxPzqYBq4H/8pZnEM3gw8+qS4V+lBUYWQMIYuI8aebX4z8kzeW8tCh2/rKAQedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=k8p8qfY6; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNNFCR1399730
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 18:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=QbU8
	qIjBMGeq/4CCh33jplvuFV4mV/Z7tLyPGzkrhRQ=; b=k8p8qfY6LKJTKzyyIu1T
	MBHAySeSL2rGW18v7FXhhfE5FBzkAnsvzwwdn7GkjnE3GX/FS+1Labq+PlugfXXz
	vOec7glehBd8/aUWG3kwI+2K7MIntwvnNxIlbXeb4MC2Iz8OIYCgGdmmdQomMWcR
	jawfPFhJyFIek32736qXfJ1Zsf8PihQodtpVLS4wPMGxrg7MiHzMTOTAz5tsZHSw
	kZ64SjLH0jiAaG/crVhQ9y25MdtNe8NaKVc7DRq0nHaElnWsMUg1K68u6t5fD41K
	7efzQ1T71c41RoTR8AQXiabnd0+DiFVVEkIL0sRUwP2Sy7x2D3aUqGREmAiKw7yl
	/g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4chx6v6ba0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 18:44:43 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50340e2b4dfso49144951cf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 15:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772063083; x=1772667883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QbU8qIjBMGeq/4CCh33jplvuFV4mV/Z7tLyPGzkrhRQ=;
        b=C/AJPcnNZMs0c/rah9iNJIri6MY5KeWrGvVBB4v/v1vnl5Nsl/SwBvMQvQvpLnXf2H
         CKAkyXbD9LuhPN8J/JYTyKzT7GaUnzZ42kXyrmp3Y4Vl8QejakIBWv9zrhPUWwc+CwEP
         kExvMfsS1JxE2zKlAYECncKArl9Yl6Gf28sZ9M9T4/UwJm955wXwVTF6esjRTtULoajS
         hQchUNO57GtKTdNLp1UlITLHGPggC2FhWRUZZxkbyR8+oA7A5taMV1174aGF98Vxlm+a
         nflfuC/JoY+My82/1qfT+HQzR6o4hd1oF486wES0WCr9d/Kog7uHAuX4f+uMThIK+0Iz
         4yEw==
X-Forwarded-Encrypted: i=1; AJvYcCXLE/3odYeuOBquuHXGEWU0ySHeoZUl3NFqTaIZvayV4e3y8M6Zy+KVAzhSuDbOE4MVudb6MCqZOvJhMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpeipV/rUuk01AW/KDZaMDPifwcS7c7VST89x+WpiZQfbIFeIV
	aHZLAW/Hwi0G5h1Ck5RP1ISKN05S+/lrrGD7L9SpOytM83pcKXsyUp0uWOMdlm3WD6xh6U5+sp/
	UlxhmUkGCkDm5U76n4ct3WOEZIkQgg5iQRXKv+RHxkka29alQNCOUATZPEBBq
X-Gm-Gg: ATEYQzze8SqUTBKg72T3u16EYC2UMQuQqEtLQ8ANSQce8lPtdgIfH8AyKpH1D2v1uGK
	iVTErHgLARVVOZsDhJM0Hrd08vez1UWuLmMMZWjrZlZTkmSRn5WSRsIgYHVgEPPr6QoL3GTWJua
	5klfLAwF3UMov7YNvt7F+kTmYC9XOEN9KZkgz3XSWZ2u/qcy7WIUfAwpPacnPhVX7KlKbNShWk0
	A0MztQiRaKxo/DNAMZ8uS6aJA/9XyFUvv5SaooM4U7qoCcDjmAZGzHv5ADZ+P+794nZnJvJ5MMw
	W2bRoTOp1fQt+Mcwtu8afDA2k+wZDiKI5KJSOU+HYdLHI6i5VpBlsxtCyf5lpGD9gfO/SegdkSI
	O1dgg9fjYbrLJXBpIqzsRlskUGxn1xeUz
X-Received: by 2002:a05:620a:bc6:b0:8cb:50d6:18be with SMTP id af79cd13be357-8cbbcf5fcf3mr351655385a.18.1772063082586;
        Wed, 25 Feb 2026 15:44:42 -0800 (PST)
X-Received: by 2002:a05:620a:bc6:b0:8cb:50d6:18be with SMTP id af79cd13be357-8cbbcf5fcf3mr351647085a.18.1772063081985;
        Wed, 25 Feb 2026 15:44:41 -0800 (PST)
Received: from [127.0.1.1] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c738d80bsm3357606d6.41.2026.02.25.15.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:44:41 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 25 Feb 2026 18:44:25 -0500
Subject: [PATCH v2 1/4] mm: Remove stray references to struct pagevec
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-pagevec_cleanup-v2-1-716868cc2d11@columbia.edu>
References: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
In-Reply-To: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772063077; l=2123;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=86tTrdoOnAn/xo3cekp1XuyRqb4HRFNzoiKbv0I1ps4=;
 b=0ov9kj7XAzT78Flm+u7++Q86OOmjR2OlGmMBdpiKWPN48FTWijPSg85hjs6TZBPJjXCzDYWnL
 klFYhD+F1AcALAkegHF4EiMet5ndziKuMEd8gAJMsRTj0W6VnFL6fSO
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: wbVaIm94ynMN3mLTj9Uwv33XWYEXCL9z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIyNyBTYWx0ZWRfX/YtzZwReEX0D
 UeZC49y/szUw/xrb16adi3/7Z3rjmq77o2ILvvvDRrXbbqL0dmlJcZDaCPKvmR79t2Kx0blsm23
 JQ5KcsK1irrkbksjcoS6hFLw2NRr5mbsE7Pmlb2YTgw5ME1jQqVEPZUwBZAQ0juwrNL8VCLML/c
 dFA8fX9JEg9HkjmVjtLZLTQG1pxOYkIZlisuYRlDHUPAR37nMprRvrba+U/DRuztfhFwfG42Bk1
 WAXdivDkS24LYOBUOYanipiu8ek6agFe1ZVrYuVb+iBcMpt0guDP1tAMzHjqN/aMC8aPJAt3XMu
 UGuK5pYNeI48E2zl9J5ZB6UxC82ZqbjaCOEPPmT1j+In3G90q4p70Z8UrkPyW04RJYbyf9wKEcr
 GxU/e7BT46QOJK8cmnpDugYgbFXnxglKOqq0b0163v3Srp2FEh3fPXG3457J332wo7LrAM+iAVf
 o44pwT65rXfdLItiFFg==
X-Authority-Analysis: v=2.4 cv=FqMIPmrq c=1 sm=1 tr=0 ts=699f896b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=KlNbpEHeXbYZISPg4o8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: wbVaIm94ynMN3mLTj9Uwv33XWYEXCL9z
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[columbia.edu:s=pps01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[dilger.ca,manguebit.org,kernel.org,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,gmail.com,microsoft.com,talpey.com,linux.intel.com,suse.de,ffwll.ch,intel.com,ursulin.net,fb.com,suse.com,redhat.com,dubeyko.com,linux.dev,oracle.com,brown.name,ziepe.ca,nvidia.com,cmpxchg.org,google.com,bytedance.com,lists.infradead.org,vger.kernel.org,lists.sourceforge.net,kvack.org,lists.linux.dev,lists.samba.org,lists.freedesktop.org,columbia.edu];
	FREEMAIL_TO(0.00)[redhat.com,auristor.com,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,tencent.com,huaweicloud.com,gmail.com,infradead.org,intel.com,suse.cz,zeniv.linux.org.uk,mit.edu];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21938-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[columbia.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,columbia.edu:mid,columbia.edu:dkim,columbia.edu:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tz2294@columbia.edu,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[97];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7893E19EFE6
X-Rspamd-Action: no action

struct pagevec was removed in commit 1e0877d58b1e ("mm: remove struct
pagevec"). Remove remaining forward declarations and change
__folio_batch_release()'s declaration to match its definition.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/afs/internal.h       | 1 -
 fs/f2fs/f2fs.h          | 2 --
 include/linux/pagevec.h | 2 +-
 include/linux/swap.h    | 2 --
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 009064b8d661..599353c33337 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -31,7 +31,6 @@
 
 #define AFS_CELL_MAX_ADDRS 15
 
-struct pagevec;
 struct afs_call;
 struct afs_vnode;
 struct afs_server_probe;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bb34e864d0ef..d9e8531a5301 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -28,8 +28,6 @@
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
 
-struct pagevec;
-
 #ifdef CONFIG_F2FS_CHECK_FS
 #define f2fs_bug_on(sbi, condition)	BUG_ON(condition)
 #else
diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 63be5a451627..007affabf335 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -93,7 +93,7 @@ static inline struct folio *folio_batch_next(struct folio_batch *fbatch)
 	return fbatch->folios[fbatch->i++];
 }
 
-void __folio_batch_release(struct folio_batch *pvec);
+void __folio_batch_release(struct folio_batch *fbatch);
 
 static inline void folio_batch_release(struct folio_batch *fbatch)
 {
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0effe3cc50f5..4b1f13b5bbad 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -20,8 +20,6 @@ struct notifier_block;
 
 struct bio;
 
-struct pagevec;
-
 #define SWAP_FLAG_PREFER	0x8000	/* set if swap priority specified */
 #define SWAP_FLAG_PRIO_MASK	0x7fff
 #define SWAP_FLAG_DISCARD	0x10000 /* enable discard for swap */

-- 
2.39.5


