Return-Path: <linux-btrfs+bounces-9161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C69AFA69
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 08:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897B2B2296D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 06:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40181B2180;
	Fri, 25 Oct 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcuU+Vks"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF8E1AF0D9;
	Fri, 25 Oct 2024 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839317; cv=none; b=OUvQSuA2DdyegyFZCm9j2p3yJJNCiF+j4sOR14cIPua1QpDlJntARmDD1eMvcCi3AS97A3XuFirkPrFKV566CTL7wcLGxlATDMP4W60TvYJX9QaW6pLIeI0bApa/TUVcdIwWaorpuyGO1VtL0FNYuVU3JVsgAF2ZAKQ8I0wogKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839317; c=relaxed/simple;
	bh=/JItxWNziaTuB+BcwqQBBwBM4dWowYBdi7Xikd/kyOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNBl6mfJVUghHuRuRT/TtLormFpQJ0TLs2NfjjR+awhL00LYPa0jjW72xyEN9jZfPfTEP2nKEIgIyGn970LKu/I+lWUU9pilEI1R2pFIrldTW3IwZF/zqJsReUMJyV0M/LT/WStu93QG+wgjIEenuRJNjPMPJ/eAJecUQod9TxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcuU+Vks; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso6936545ab.3;
        Thu, 24 Oct 2024 23:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729839315; x=1730444115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNjDVyBRROsCV0AJmQTnON80eXjlh2cMkWXKec7psWY=;
        b=JcuU+VksbS+ODQiyUm4jTVXZk1P+upB+XcOqhRSCtbGfXHlpd/0ezrpWFbfTPaWd4p
         CjQC1rbqAmYjV2EJTKaxHVPGEH9C9AdiXM2VELEgCo+2HDyERFXMQLOXOBJK/Ae4lkqA
         XzCZ/xaLixqk3Rco4rxYeLN/FnWAdeqyAoJktSbph8o2QSUGZAyPJErBQfS9wSUbj+J2
         JR6j/Ub8KdPS2F4MWwIaB5agnlPP4F/DXjLDBIcvksHEVZixvZpec7Dy5tju1sZPp3sE
         tOAG1rxb/qG87xKswE563qdND7Tl9Noz9lABnO1mBVVKM4MXvq+ureQLdxIdjYX8y+SV
         tRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729839315; x=1730444115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNjDVyBRROsCV0AJmQTnON80eXjlh2cMkWXKec7psWY=;
        b=SuWAJcz8rf8p5t82yzL+BCqzo/uamhYR6XrUeNch1XU8mKMjrVV7mYPEkL7JCjOpS6
         H8qoQKLyvuNjr9CS1+oxAUccGZPz2ZQ06Nqc5zSBPz4/EHD2bK9vrY/L/I3QBn++GnX0
         nrj3Xy+9YGxeIbe9O2My1doe0YOEfvH0GkAPRpjAZf3bO5lYC5pB3o/4U3SY98NaYGs2
         6aBLosrndtsKqyWRj0unzNVGnPypdyvFQ8UkKOdUuREj/6tMSshki2aA3pmno89EfwNx
         vyMS8C/4f7I5hGwtdSaYOMdxL+sz9NW4+HAOXN+m1eyvbnwXL7EogZdGYwXUzgRjxDDP
         PA9w==
X-Forwarded-Encrypted: i=1; AJvYcCU3nX4RpQoF8SS7xnYzyaxpFD21yYNh51oF+ATxuG1kkO9SHj6pGTLTaum64w3H/qkUjLqoCQjpp+gxSQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySalHZzN+2kWOgPhDTmJiVTNlFVzlOl8vjIiHisBJmskjCcBpL
	cCKJInPq+dcCqkigwpR4qVhtA8Jfc1YxNRblxArzAjC6ClsfwvY6rreIvavM1lk=
X-Google-Smtp-Source: AGHT+IHRcwZ5WTFWwDOpmr6FEVl41oLNAlUlRUfrLAZmtiXk5gDFp33V4Y+kzqUurKZERaOi05JFYQ==
X-Received: by 2002:a05:6e02:1a83:b0:3a3:b1c4:8197 with SMTP id e9e14a558f8ab-3a4de827cd1mr53375055ab.23.1729839314806;
        Thu, 24 Oct 2024 23:55:14 -0700 (PDT)
Received: from VM-213-92-pri.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8685729sm464011a12.37.2024.10.24.23.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:55:13 -0700 (PDT)
From: iamhswang@gmail.com
X-Google-Original-From: haisuwang@tencent.com
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	wqu@suse.com,
	boris@bur.io,
	linux-kernel@vger.kernel.org,
	iamhswang@gmail.com,
	Haisu Wang <haisuwang@tencent.com>
Subject: [PATCH 1/2] btrfs: fix the length of reserved qgroup to free
Date: Fri, 25 Oct 2024 14:54:40 +0800
Message-ID: <20241025065448.3231672-2-haisuwang@tencent.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241025065448.3231672-1-haisuwang@tencent.com>
References: <20241025065448.3231672-1-haisuwang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haisu Wang <haisuwang@tencent.com>

The dealloc flag may be cleared and the extent won't reach the disk
in cow_file_range when errors path. The reserved qgroup space is
freed in commit 30479f31d44d ("btrfs: fix qgroup reserve leaks in
cow_file_range"). However, the length of untouched region to free
need to be adjusted with the region size.

Fixes: 30479f31d44d ("btrfs: fix qgroup reserve leaks in cow_file_range")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Haisu Wang <haisuwang@tencent.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5618ca02934a..3646734a7e59 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1618,7 +1618,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		clear_bits |= EXTENT_CLEAR_DATA_RESV;
 		extent_clear_unlock_delalloc(inode, start, end, locked_folio,
 					     &cached, clear_bits, page_ops);
-		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
+		btrfs_qgroup_free_data(inode, NULL, start, end - start + 1, NULL);
 	}
 	return ret;
 }
-- 
2.43.5


