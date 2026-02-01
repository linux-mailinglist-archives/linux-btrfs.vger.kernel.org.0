Return-Path: <linux-btrfs+bounces-21268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PO2Dnf8fmlThwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21268-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 08:10:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5B6C5177
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 08:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40676301410E
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Feb 2026 07:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD532DC337;
	Sun,  1 Feb 2026 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT2zH3zP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144E4283CB1
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Feb 2026 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769929836; cv=none; b=MV+JQZ5Dx3DsOJe3MeNR86+4qS/G8A3GIjmtXmYlO1CsondHS2kh4qw32ylbpuEdjvX5BA2fCJihigyjZchSDofimE/vE6O15rdB7YQYaGib9Dv8NKHXRPGcLJ49VKVKXfK3losPuH9ByWO3DmRUxjjuFsYQ8dXnBPBJNvdIiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769929836; c=relaxed/simple;
	bh=/+vbohuWCeA5apK0xQZdqX1BArl3qOvcWSMuYG2I2XM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQ5E6Qt2yBwGsV2aqf85YmfnYXvXUlRTue15hUV+Z+45MgAV6cbVrJYVvivHjtV++wgHPcZgW+SLhyUR3RWCfaDKJKZiO76NG/XF/nMRvypOOBU2MGz6OleYYiGIqbeOEfcUpL+OgrXS7X5ofckTeiCky+8MWtowdw6L5gqfQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT2zH3zP; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6562759eec.0
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 23:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769929834; x=1770534634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzXD3tBTqqP8oZwwUMhbpbowxhGXxwF671sYxC/ntIA=;
        b=QT2zH3zPCQnaqkgMKXnabxiywIRFiR9McJxKxMOf7c0tLMmQuHhGWxJjcpVKXEA+uc
         gCxH1cAJ6gkU10dRj5oDwXt9IaQPZAj/RUCdldUMoKaQ4AMkpFWewsW0pCoJTd+Tytck
         U4Wqf7i68iygwYSVRnx8YLc5R2Z9UgWYuYgz+QYp1ea5c/iNEvVUIJcJ8ZUnku1fT1Tc
         1B4yzd04iAvGVU58k1jBH0BSCMOatxHp9AEDnVK18ZHFr8iEA/5YJ8mQIQP9E/e1w3Qg
         UlGxY8jGJ9F8oWT5+T/sGviYu8ncau21QDL8/+TnM1tuyH+Na4fmyW+oOBw5gstIYrN/
         qG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769929834; x=1770534634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzXD3tBTqqP8oZwwUMhbpbowxhGXxwF671sYxC/ntIA=;
        b=WTPo/7Hq25Y0M24x5djuPsKDiEPCQmqdTLgUqUJcJ51nELPBH/RUjgHyEOuQ6dBt+F
         G/p0u8NYwO0nXzf3NlOoz9EO9Fyfxgb/94wEoG+9bkf76D0X4Lw/4gnNQ4Y2TtNDNdNG
         Uuww+Vmaoh+DdImApZhVg5al3Lw6vxEddPBcpwVF6jfO2GWUK6XXCqPjUWv/yXZ44PTI
         6YeeasL0IXTUAWdcZ8Gq0GXV3630rDUv7tLZn2DAeXCz8/+XN5W9FhmRTYsBCDb0wTrR
         HTkphpkdCVXjAxCHgaUS9Igo5PAkM1XSMYYXMAQZ2Wq9jCXfTRZcIwNwFe4bKLg4fbie
         2v6w==
X-Gm-Message-State: AOJu0YxO4rYuwMj0k0W7kG5I7YFgp/+ubnT6DStowc/wDAxSGg1pruRw
	9LiSWAte+ZHoRF6X0sVQVYkRIMk6kMS8v2gXpVeju6icaFkzM0vMdKWT
X-Gm-Gg: AZuq6aKe8w8WDkhLZMBBb01UiE5EJsYbAyNR/IHDEI6T+RHkirmIxguMAiGJwZRXF+Z
	/ybrLl+MsevF3c3Y4DkffLGChp6UH6mqmfEYy0Fl5cY8Bw2OeXn9sjfqvE+XTzVaO+gPno1dx2Z
	QTNcTl3OHF3rH3tM6TnN8qm5DklabuXnCyzKCz4o84GI57LgHzgx07jhG0KeI9vc1scHNjXgZDy
	QBtkLo6EthmgkDBTTGGtylrjudTit6WcHXdZTaTpV7XC1T0JUad5OHRinpInM1LAED0jWLA/fjL
	mnWpWqi7SJKLyZEk5Wp7TKS3YbYaFCK1G58zb01ZrXCvJ5ygBBrJP/v3MhrH3lvwvC7cCQ2RsNS
	oOrKRg/Vv0CzDRlc+vDnUqje0QjbsuJHsPh+PYOTbhvEOQYUMkgNh54peAi5ZTj2NMHXu6b+5Au
	rGk/7iyahtK5ux+pnQERfJeC6e2XLJaoxD5ITEYw==
X-Received: by 2002:a05:7022:e1f:b0:11e:3e9:3e8c with SMTP id a92af1059eb24-125c101b3demr4250108c88.49.1769929834048;
        Sat, 31 Jan 2026 23:10:34 -0800 (PST)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d6b663sm15486422c88.1.2026.01.31.23.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 23:10:33 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: wqu@suse.com,
	boris@bur.io,
	clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH stable 5.15-6.9] btrfs: prevent use-after-free on page private data in btrfs_subpage_clear_uptodate()
Date: Sat, 31 Jan 2026 23:09:53 -0800
Message-ID: <20260201070953.129723-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21268-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE5B6C5177
X-Rspamd-Action: no action

This is a stable-only patch. The issue was inadvertently fixed in 6.17 [0]
as part of a refactoring, but this patch serves as a minimal targeted fix
for prior kernels.

Users of find_lock_page() need to guard against the situation where
releasepage() has been invoked during reclaim but the page was ultimately
not removed from the page cache. This patch covers one location that was
overlooked.

After acquiring the page, use set_page_extent_mapped() to ensure the page
private state is valid. This is especially important in the subpage case,
where the private field is an allocated struct containing bitmap and lock
data.

Without this protection, the race below is possible:

[mm] page cache reclaim path        [fs] relocation in subpage mode
shrink_page_list()
  trylock_page() /* lock acquired */
  try_to_release_page()
    mapping->a_ops->releasepage()
      btrfs_releasepage()
        __btrfs_releasepage()
          clear_page_extent_mapped()
            btrfs_detach_subpage()
              subpage = detach_page_private(page)
              btrfs_free_subpage(subpage)
                kfree(subpage) /* point A */
                                        prealloc_file_extent_cluster()
                                          find_lock_page()
                                            page_cache_get_speculative()
                                            lock_page() /* wait for lock */
  if (...)
    ...
  else if (!mapping || !__remove_mapping(..))
    /*
     * __remove_mapping() returns zero when
     * page_ref_freeze(page, refcount) fails /* point B */
     */
    goto keep_locked /* page remains in cache */
keep_locked:
  unlock_page(page) /* lock released */
                                        /* lock acquired */
                                        btrfs_subpage_clear_uptodate()
                                          /* use-after-free */
                                          subpage = page->private

Fixes: 9d9ea1e68a05 ("btrfs: subpage: fix relocation potentially overwriting last page data")
Cc: stable@vger.kernel.org # 5.15 - 6.9
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

[0] 4e346baee95f ("btrfs: reloc: unconditionally invalidate the page cache for each cluster")
---
 fs/btrfs/relocation.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 96c89884988b..e66ec0c23153 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2900,6 +2900,19 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 		 * will re-read the whole page anyway.
 		 */
 		if (page) {
+			/*
+			 * releasepage() could have cleared the page private data while
+			 * we were not holding the lock. Reset the mapping if needed so
+			 * subpage operations can access a valid private page state.
+			 */
+			ret = set_page_extent_mapped(page);
+			if (ret) {
+				unlock_page(page);
+				put_page(page);
+
+				return ret;
+			}
+
 			btrfs_subpage_clear_uptodate(fs_info, page, i_size,
 					round_up(i_size, PAGE_SIZE) - i_size);
 			unlock_page(page);
-- 
2.52.0


