Return-Path: <linux-btrfs+bounces-21059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH91KJBQd2n0dwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21059-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 12:31:28 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 436EE87ABE
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 12:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D39AE3005AAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 11:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD8E330311;
	Mon, 26 Jan 2026 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgaCRjho"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F9B2FF662
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427083; cv=none; b=DMNU1Iju4s738ZOprtKZmbqE1NFZgjFZVDmWU31VYG/jEFuUOLqwCFFu5LKaV/LQGGNa5V30ZRMT8f0XgwXbJoQGhyGDYY9T7FVdau64xJGzNAejYTxINGeBzEyqcL480gTphiVDd0Snaokpv7D8oBv8PNQEy6s/8WeUV4sRmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427083; c=relaxed/simple;
	bh=z4ylmV1oKH/Snipz1CCA1p627T5Ca8DrXU71mm7xp/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMIt1gqYG0oFpZFhGlzhdfSswhW3gYg7d17fsSOYWQSoitfSx5FV/rjNk5oFCzNHOw6S9+uNo06Xs0L4zxhZ0U9ql6AmhpJxFjK8qtUZULfpIFhMapJFKowVfHlqPZMl8b8ZVw/zpSlYrFokebucTPiypJtvK66Ar8MWYoIt0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgaCRjho; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78f9be198aaso1451577b3.3
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 03:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769427080; x=1770031880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgL4nG8fb4sFVJ58goonxK7sNRtD6PdytU6Ug6kNleU=;
        b=NgaCRjhoIRjOFxMRerTr9eJdINhS4CCR+LrRg/vjEE/W84X3HSLyfZCUBrBiDmAnEt
         2g1PrvYsC4SgxZawUgAz5RrhTfhS2n/gpHaNgUjn9DMJNMTV8HG1Z0oYZRuAiXUs2dGG
         00vSxpgz6xu0OESHbtR3dthSLd49rnRn46BurDHoFN/6T27mOqUFPZA3c34FIeY5MehL
         AG2CGGDXQh1vqhCWTaxf3Kbb9XPKQT3KKiCcvBKo8QtpHMv4Dn/zIvN7GUpwGF/L6rpl
         7TQYBzY4O22OCHXKsymLJzU5Pr68JEzdo/XeoWZoHw0MCgCSwKiGCxgew8YMkFL8mBZe
         QecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769427080; x=1770031880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgL4nG8fb4sFVJ58goonxK7sNRtD6PdytU6Ug6kNleU=;
        b=bBhcH1U3Aiaa7UUFCqGaDmWJdsT3aWyKoFssaSa3QVaIRqWhnjIzekB/OXg2AtnW47
         RJHlkqFar2KAK59g8ANjMiq4czsBp5KoIXuTGJRYg9N/49rt5Equ21llGPsOtFcsXNEf
         tpjE4N2oFDIr81HCPQvK1s68SKR+kxNUJiovBxBShaibqDxYPfcluCCAzlgiAC99srVA
         EVp+JQKbIYHNADmIppzhRNqXov/Hqix75LRvqsj0KP1HloymdjUiPG4vJbTLlwWfAYjf
         swUAR8/SYbHhrEYQPwjQFTB+rkRDEHkKajUmbjGoTqzf8Eda1CtmlE0+zjzTnZwaWCX2
         HyGw==
X-Gm-Message-State: AOJu0YzJdiLiIZpD6qUGvVZHR6gTk/QRJgQ8HrlXmj8FJjGtF0f3UJ4B
	g0O/eU9jkY+5VF8VB1c/F6mhgNl2SdJBCvm/QFB+4so0lfmb7XQVry0xtvpItVBWFMUNfg==
X-Gm-Gg: AZuq6aIEiPVQldtqMzmXo1DY0S9QeV15k2cd65erIvqRlJUhsv7TQlhm9kt/RCjHNSI
	ndQ0FWDJGQwZtGowMrLwXhuL1ikeOcQsJwFH+xrkANhu/Fa6xFLT/U4GS0aeOdapz7c+KECXP1h
	JdG2hEmDypQ9O8ixCLAHN8ZtrJxnqnNNIoht6KN39a42qEyDlg2fp5XyG217p35lk9ltLgr6XaJ
	GPWv9WUHmvVsATH/dGPtA/vTnGi+WjbTMUoSXZFGYEgyID84QnDleACyeSWbSuj4rdCzd6292TB
	LG9+rBZECB5bBLMFpYHh80vUAqQK+ReiB2KQiEYD2dPtOf1JNI3u9CPFBNjlmHbb12TUxfOcSLK
	iV4KGjdlRX4QlWmBbNSrWrSvwIpp73VszOjHlvP5WJwHlm6DdkDb4X3MtaQwa3EbySjNXcWxUrc
	qNAbTXERhugQSgXB9FZEQ=
X-Received: by 2002:a05:690c:6612:b0:793:c58e:7bc1 with SMTP id 00721157ae682-7945a6c5a5dmr25347937b3.0.1769427080487;
        Mon, 26 Jan 2026 03:31:20 -0800 (PST)
Received: from SaltyKitkat ([193.123.86.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943ae2d7f9sm46631237b3.0.2026.01.26.03.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 03:31:20 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH] btrfs: initialize periodic_reclaim_ready to true
Date: Mon, 26 Jan 2026 19:30:52 +0800
Message-ID: <20260126113104.9884-1-sunk67188@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,bur.io];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21059-lists,linux-btrfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 436EE87ABE
X-Rspamd-Action: no action

The periodic_reclaim_ready flag determines whether the background reclaim
worker should process a specific space_info. Previously, this flag
defaulted to false because space_info structures are zero-initialized.

According to the original design, periodic reclaim should be active from
the start and only disable itself (set to false) if it fails to find
reclaimable block groups.

Now that the reclaim condition has been fixed in a previous patch to
properly handle reclaim_bytes, it is necessary to enable this by default.
This ensures background reclaim logic kicks in as soon as the thresholds
are met after mount.

Fixes: 862dd2fd93540 ("btrfs: fix periodic reclaim condition")
CC: Boris Burkov <boris@bur.io>
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/space-info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index bb5aac7ee9d2..1530c30cacc9 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -250,6 +250,7 @@ static void init_space_info(struct btrfs_fs_info *info,
 	space_info->clamp = 1;
 	btrfs_update_space_info_chunk_size(space_info, calc_chunk_size(info, flags));
 	space_info->subgroup_id = BTRFS_SUB_GROUP_PRIMARY;
+	space_info->periodic_reclaim_ready = true;
 
 	if (btrfs_is_zoned(info))
 		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
-- 
2.52.0


