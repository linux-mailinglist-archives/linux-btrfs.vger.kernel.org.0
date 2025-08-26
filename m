Return-Path: <linux-btrfs+bounces-16376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F25AB36E28
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C80366B72
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61032D3230;
	Tue, 26 Aug 2025 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZOPAyxj3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D035335B
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222868; cv=none; b=bv0W02UMt6W0Ay3J0B9TYZ+hIKh4Zb3h+R7ejZPI9qW/xksgK2R+lAxVznCMEA2A+ljoM70QoAuiFu/FnkM3XZlKNLdK4FdTjW8GvZ8iCRuz9SlqRrtB2AUvp9U6WYzbesdTb/fEUm/YvmUcRyjmh9CrD73d8Wuyew/VWg60NAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222868; c=relaxed/simple;
	bh=i08d7EU1qtP0hre72cGWsXMuWQRhkvfGuBLQ0ClvHDw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXoN/p/flsmCe5c08WUyIcftKJQK/a0phAwuwvf7rj5G6v63cxCLeB32TyIXWxTy8D7gg9t3BBV7CuHjmCoSzvHzHs5lMiaxhupc7GYk71jCsyzeNeJR0VyFWgMofiY+7VI928fmsxfmm7pfDqDJwWtjoWzx+me8zuQbOjEbwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ZOPAyxj3; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e95230750ceso16353276.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222862; x=1756827662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUdrFFBfeSCCz5BvIAzgXKAAiu4bIaqDFMnpkxh49FM=;
        b=ZOPAyxj3H6QKMxpdjneOBvd604BCzKSOqEUrDEkuibQqucMKP9vI+RiEEaloB+3yLn
         fFKIqefV7NLTDgVp2+i3z9YuuuiDn+PGaaWHEuntkNyBfFTtVxPR8oamlwxAuBixwbaI
         If7vDO/qk6QMlqy1nZ93vsC9msRnfg8STQqshr4RT30PcIduDPSX/fMBctVY+qMDdr2n
         QrHZlIcec4ejDB3gGcXYNDc3G1UqUttm9obOa0wg6ptVYkJhu4LAK9/YYKu/yPphSAEP
         aP2gVldwYel/jg72OwRShcEd3qJgz/8VLBEB0wg9G86Syr6QkkxIt8/koPtlRoyxpeCH
         R/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222862; x=1756827662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUdrFFBfeSCCz5BvIAzgXKAAiu4bIaqDFMnpkxh49FM=;
        b=l60ztvZzc1D5oBk1XvL4QCSPEodUjx28+BD8cKb/h6VKChDbj8RmZFQTIEUnlz9mUF
         PaKK6uBkbDFO70WGCwtv8QncFRhfBnTtNKaPkGMLTi2Z4I3m3SRHPW2xK05qRxzw557C
         6g0XqgHFw9QfN9zQDPgfwZxM0auUk53lml9cfpJU/qcUed08BztYOW2WfKLxDWNv+1hV
         8tbueAtOvC7wUAl6Hr9Hz4EBXXNnmirIvelPZ2yvFRQMUBLbS9DgUDrHfdm6eTF2Inbg
         6d+HYjMWVeSJwQAXwS4OqjqDffbc65AALZuICeYTOyYFTKZCN10ZpDS2bDLa8saOuB93
         dMog==
X-Forwarded-Encrypted: i=1; AJvYcCUUI3iYdLDkoa6LQUqxqhIYPscAksFX40QGne2T6kq2ZqsNrWCwT6BhaYLH+vtS/b+I57MaoLGwyQ1wTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQUDOyYYEecWEIFp+I3lF3Bgd+5TgJuKRwI+laEK0B2CHR70dk
	S0dRKRLx506JWqLGK89TsFWgEciFB6jTIBLedS/bLeOsWrtGzqbFg8IYecQL/nkBWCb2UrRM9w7
	66UOX
X-Gm-Gg: ASbGnct9QFeomHhN6UceeeGBWfg42Dfo5N8y9RNhGkwX8iN+EwsWqFik/baMW6qQdZ8
	N6/5EQX9UX10qLl1ekpyZA9w6h0KIHpolvw0KVxg+t3NCBOrWDSTCZrbPkqtpWIhf2l4lpzXdRA
	HsjoQInVRFfW0FMfnt9yBvCgS1oPTBe+z2mdCRFKoHouaZTsZCR8JOLKFtl1Iv42xRhwCxeVGwe
	lLdCobFyvHYfscJELKrKllQOGqCJ7YwcHZ3l8uqEbIv0v1apS92okqQuwq1tc+Mzl7PDeGBLQY+
	2bLy7RWw8pxF0qumVJiiG7IRZlZHcUO6SdyilcNSX09rho22Mxc+N7mtHZUuZfwd6ErlgjCnfYq
	2yxhAoIen+sB1rCGsk7TjDlU8nxgHu/RTgSSqqmEQOb8BiUTTivqc/L1TyJs=
X-Google-Smtp-Source: AGHT+IF7RynrrWFe9fbQoevH3erjAdy+diX1JnF6ZTRRIvx21HIrszb+j08T7FJ+0UEw8lO9Zl2Jew==
X-Received: by 2002:a05:6902:1004:b0:e93:4b37:f0a5 with SMTP id 3f1490d57ef6-e96e4792411mr2039154276.7.1756222861630;
        Tue, 26 Aug 2025 08:41:01 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96e0567840sm603896276.4.2025.08.26.08.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:00 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 09/54] fs: hold an i_obj_count reference while on the hashtable
Date: Tue, 26 Aug 2025 11:39:09 -0400
Message-ID: <89e15be97f804cb135ff942eff556d1f271f2f16.1756222465.git.josef@toxicpanda.com>
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

While the inode is on the hashtable we need to hold a reference to the
object itself.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index d426f54c05d9..0c063227d355 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -667,6 +667,7 @@ void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 
 	spin_lock(&inode_hash_lock);
 	spin_lock(&inode->i_lock);
+	iobj_get(inode);
 	hlist_add_head_rcu(&inode->i_hash, b);
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&inode_hash_lock);
@@ -681,11 +682,16 @@ EXPORT_SYMBOL(__insert_inode_hash);
  */
 void __remove_inode_hash(struct inode *inode)
 {
+	bool putref;
+
 	spin_lock(&inode_hash_lock);
 	spin_lock(&inode->i_lock);
+	putref = !hlist_unhashed(&inode->i_hash) && !hlist_fake(&inode->i_hash);
 	hlist_del_init_rcu(&inode->i_hash);
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&inode_hash_lock);
+	if (putref)
+		iobj_put(inode);
 }
 EXPORT_SYMBOL(__remove_inode_hash);
 
@@ -1314,6 +1320,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	 * caller is responsible for filling in the contents
 	 */
 	spin_lock(&inode->i_lock);
+	iobj_get(inode);
 	inode->i_state |= I_NEW;
 	hlist_add_head_rcu(&inode->i_hash, head);
 	spin_unlock(&inode->i_lock);
@@ -1451,6 +1458,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		if (!old) {
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
+			iobj_get(inode);
 			inode->i_state = I_NEW;
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
@@ -1803,6 +1811,7 @@ int insert_inode_locked(struct inode *inode)
 		}
 		if (likely(!old)) {
 			spin_lock(&inode->i_lock);
+			iobj_get(inode);
 			inode->i_state |= I_NEW | I_CREATING;
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
-- 
2.49.0


