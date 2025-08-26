Return-Path: <linux-btrfs+bounces-16392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F8AB36E78
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48488E63D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98433301028;
	Tue, 26 Aug 2025 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="E7v9DGwg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323D832C8B
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222888; cv=none; b=FtDZGGxnnXGj6w7lQMacti5XjNbboDR4K2THv7J7/R/OqrdvTCiDwgpfkoRdvgNeipSwTy4LeEP/lT56uYz2KaEQlAW6Jp/K4z5OXrN/R4zyIIvCR/LLOlPh7JksxwMjesBlZ4mkIjUZ2f6NBQ508fYcCCbFnAWQ2erIYCSnELA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222888; c=relaxed/simple;
	bh=n2PMRuPR6JYZVUW2/KJe5vnseijKbMo3WzgrzTCJifo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iL4HQ7QKA/K6bnVPOAxP7cyD4cT3KnQzZSLp6ugjJuzkZAFS7P1T5M0CL/5sJ4fS/4o/FHZJ7uG3aV3Bw+qnPmVs3PHaWlbzNnD3zxqscoqyGQTmU6FlZIu4B0OtexO+ZBZ4pbBmh6RThRICRVBtRhBWhxs1rF9jvimlLng8eXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=E7v9DGwg; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d60504db9so42627087b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222885; x=1756827685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlLhOSIwCH5Ivh3dHEMbxIwp8egJF9NMtkZv3ZbCr3U=;
        b=E7v9DGwgsmKY7t1jhTV4pIfLjhzC5WYtx+XzOZFLGfh1YpY05yFYpOIIUX9D055s4j
         225zoSyf7juEHEWrhLt42HsvDWo5m0OQ8iCDW6GpILZdfFzbCgLvXGaJLgBuh3WzR1oG
         e+2svNTsgeUTWbdzzh5IJXQ5TZi/weAOn++0qe+Pmwlvv0+Knx+MvLhrqtPUd/m6EEzO
         awxa3xEX1qpVaGCAFf26fC8Zp3owRAvGFgzesZpK2P8aEAfXY2N3G3lnRcXw4D7/b8kS
         K+KJFXkUcq4jXbV42Xa4WZ59sTk25VaXqrf3rJ7U3oXTCWPoWKkyeOZR/1NkyB9/OPEc
         PCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222885; x=1756827685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlLhOSIwCH5Ivh3dHEMbxIwp8egJF9NMtkZv3ZbCr3U=;
        b=tYLZUaueum4qJ7sLcKgMqPqzWdvKaAnW4Ul4RG+H9x/czymsebnFbNI+/AqL+yQQ1g
         zYO+tVokRNFY7vpX/K93M+XZ6mjidH5AktZ894LyXnLwYbves1GxrIwmQmUu96c7kfl+
         /9FUSo7QJ/iCerqdMWZ050ncU53y1TWpigFTo/F+lU8wFRT7AqM9NnNX+Y8iTEgLX8+Y
         soY6Dno9wokqE4e7xto/MjDYfUUAsOgcGpmeaehyaLkBEPbyquTwqp0sSCehPBlzZYTr
         BvlklH7IRp+KQ1zzVBmayDrxI0RsmjKGeTDNUJ0p9/tznfEFa+op6WiEsNIUgLdu42LZ
         1cxg==
X-Forwarded-Encrypted: i=1; AJvYcCXKA+ZTkpBz86wrZv17vj9/fUa3pFJ5HXoGOLGgorhQzerKEfm/K3ayZ4HKLCLrDsTvPrAu1wEkTlV0cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YweoPWarM88XV32WBEtZbWLJ9kb8nPyLN+WU3Mi/5K88SlTecbR
	UUWjQMW/bRdkdZ/r9nb66myf02c1mrpoZBQq45OYlvxe7qAGueFb0nSMDnKKDGZJ024=
X-Gm-Gg: ASbGncuNHikuagUMxnCBpmeZ423AMYMEN44G9Sykc4TiIlYjngS/s3oH2GDoUNZd9Lm
	YNzPd6ESnC17pKVQxZdmBJJEVZIST52t0bY/gNIvtkIRJDOSUEr0Zm934OZ/Zd7fkBgyotKN6Jx
	I3P1dUj13iiRF9BwxU79M/AcEaIflqXSZHUUNk0CHuvzwN+bAazWj+6JBOalc53/xTY1BjQpAm9
	8kiPwFpfQUBwVN+SKiI7HSNlyqwUpNpH/rVzwDzxkCBQ/y8+eVWWBJ7tYaDknEJLuOwpx6rqMV9
	x5nGzOIhDL635d67B7bC7DDlVOB8jETwV3/UH/1Am/XH1u5OGomlJkGERw5qcpSUlP5K0/wu7O6
	kUPK3rSvpPO69toPVx7B4rdUxfsGlPkuqYOtDyyfD2Lz57gGDs7jbrXCc7TfWKjJV1oNR8w==
X-Google-Smtp-Source: AGHT+IGWS2z+DTg1fDukCryUmw/K/ldjfo8vScGliNb0JD4SGdAHIMczu/WUBMkIGgEqVpAF9+oHHA==
X-Received: by 2002:a05:690c:311:b0:71f:9a36:d33c with SMTP id 00721157ae682-71fdc41251amr159709517b3.46.1756222884962;
        Tue, 26 Aug 2025 08:41:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18add4fsm25000297b3.51.2025.08.26.08.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:24 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 25/54] fs: update find_inode_*rcu to check the i_count count
Date: Tue, 26 Aug 2025 11:39:25 -0400
Message-ID: <d612f83abe1ff518ee85319cb593c0ac4f266cb2.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two helpers are always used under the RCU and don't appear to mind
if the inode state changes in between time of check and time of use.
Update them to use the i_count refcount instead of I_WILL_FREE or
I_FREEING.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4ed2e8ff5334..8ae9ed9605ef 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1823,7 +1823,7 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
+		    icount_read(inode) > 0 &&
 		    test(inode, data))
 			return inode;
 	}
@@ -1862,8 +1862,8 @@ struct inode *find_inode_by_ino_rcu(struct super_block *sb,
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_ino == ino &&
 		    inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
-		    return inode;
+		    icount_read(inode) > 0)
+			return inode;
 	}
 	return NULL;
 }
-- 
2.49.0


