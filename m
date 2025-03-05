Return-Path: <linux-btrfs+bounces-12027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9668A5031F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 16:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD006163397
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4852500C9;
	Wed,  5 Mar 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jf8Hzd7N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5C024EAAE
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186925; cv=none; b=mXjab2ztwER/PM2xgNDfFaPjZq4RbrFKPNOfcMxletPq/Td2MHIoC/bht0foudMZDb4HE6XYPfhVLGN7YEyhaJpSgsBkbvURHfbYZpgXq2jlA7U5Pf2DPXEpCzlteruQ3OWgPX1EWH+SKOgiZZ/eyZ+Gl0ona4NNKUu1oPKvXwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186925; c=relaxed/simple;
	bh=AZOTwFYWbPNw3YuwetCS180YuQ8bs6mW3Lff9LCM/Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hHOmitMsE71BrPVhQPF5TrjDHZQqtfUV2g2pjEQWY1xNr5fOWq7K8ZGxgKCm+Z426tqPpvGRdm/y+Y5u+yB/T9p7E3S/nuLwbbQ9yXFmpueZ7HKZURdKElmVZe64TuKlh72nXEo0EmzajcQGJtoTFR+eqFZ2jjZG5n1f64Jap54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jf8Hzd7N; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3911748893aso1544042f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Mar 2025 07:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741186922; x=1741791722; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quIzHQCFH7E36KayRdIr1tq1n0GnpOtfG9r6i1uUzGM=;
        b=jf8Hzd7N1UQieBqwMtFyPFlowLytWYKCN2izwlkXdGE/fFZxuPXH9ITKUWQY45qqPe
         z/9QT+gf1DhrV9ICaotrstqCK6hsMLtJp9CkUySUv/SSPysceC7cMdNJ+TOiVZ8wpgh/
         nnShK1NpTg1xrcC/LOlvUjFCWVbahnAjLuAunx6b0/WAHQSuLEItm47REGKmSjnA7Do+
         LKBoYRqQqOkrKpeDxi6V7O6Ogq0oScNR3vf7Nmed2JidNd2eQZw0Rj/WX1Wh/N9/8DJv
         /9QPytj0KcIFgGRqps8NcHd2fMxeZk8I9kT1GppGXhOP93wOlmhCkWjslcYhk3ROPylr
         5rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186922; x=1741791722;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quIzHQCFH7E36KayRdIr1tq1n0GnpOtfG9r6i1uUzGM=;
        b=AuEm4q5zGWaGx7+QvNp1S3gtz1hcl+eGjHOhjDkq/1zv8nDFJhIZFycYE6TX2sZxvC
         +4fcrKxExXPfl/1x+YlYjXBiO5HMDTOaVy1bR9vgu63bPs7BY4RKXw9T4rgLXenogUAW
         vmfHC4Uy/iUnLJOM7eL4ei1MHLIrU8sgsDqbtMsGt55kYVen15Yrw1oVMvnLuP4PL6rR
         T1RLqTPREha1KeY8YBnLxtkDrlVu/nqxelG8Vr7nU1n2z6I/+lPMiX6HdkY5/AcF9u8n
         pY/xhO8uyXgFxcYJAf9SXysSNt+9XaGPKm6RiyNk9Lhyse/93tbnUVBmjdzYWenue5Po
         54nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj/xPY8xjvKjnRsTGGPrrlfQP3yZPG5xo0uFQTKn2dsKqXyIeYKp5s6xft7np/8otQhjT0WCIACpeDww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4LbwIo4uSlV8oKq/Je1/9jryx3X5SpVS/TTUNlAA3ARnNSZKc
	azeozh8E+kFNnH6LvGhHjD2Yb/FRqdn5o1jTLzccQc7SYawcVJewAxvT/3P+AAc=
X-Gm-Gg: ASbGncvwDadUOSts4xtJ/e1+vGZPVBbTg75fvZkVamfQO0i9EV9gau6R0pa5zOZhWi3
	4yx2KwkdCFQ1CsF3KlEqflHgh6sYpcScAMGgaIV1pHDMf/sEhnlb10Mw6GNrAx1tzysvEXO2r4D
	6TOic26pCvjw3jgJ/9QXFPxqYmtCR+Xz0lhtavkw9TC1LbR9ahq2Bb1jiWLzDmOgUaJLWib2Bwf
	TvDi74vMQXAcqKbm/aJVKFJbwW1+7TBc8HymrxTqvFJuVLF2SD4FxP1PG0D4fZZHVbM03AFiS1r
	MbKmK1QASsIgg2SzWLr0lKKeDUiSoJstGDlTrxGJf9dEGPnKUw==
X-Google-Smtp-Source: AGHT+IFepSDmvEhbE2UKLwqNcX3nTfRjGIucY9eQ6hTOqgtRykqc80R9HD8DtvfhRl/fMPeU5nq5wA==
X-Received: by 2002:a05:6000:1fa6:b0:390:f6aa:4e80 with SMTP id ffacd0b85a97d-3911f7d238dmr2965078f8f.53.1741186921645;
        Wed, 05 Mar 2025 07:02:01 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd4352e29sm19571995e9.32.2025.03.05.07.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:02:01 -0800 (PST)
Date: Wed, 5 Mar 2025 18:01:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: return a literal instead of a variable
Message-ID: <2b27721b-7ef9-482d-91bb-55a9fed2c0f7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This is just a small clean up, it doesn't change how the code works.
Originally this code had a goto so we needed to set "ret = 0;" but now
it returns directly and so we can simplify it a bit by doing a
"return 0;" and removing the assignment.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/btrfs/dev-replace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 1a82e88ec5c1..53d7d85cb4be 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -103,7 +103,6 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 			"found replace target device without a valid replace item");
 			return -EUCLEAN;
 		}
-		ret = 0;
 		dev_replace->replace_state =
 			BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED;
 		dev_replace->cont_reading_from_srcdev_mode =
@@ -120,7 +119,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		dev_replace->tgtdev = NULL;
 		dev_replace->is_valid = 0;
 		dev_replace->item_needs_writeback = 0;
-		return ret;
+		return 0;
 	}
 	slot = path->slots[0];
 	eb = path->nodes[0];
-- 
2.47.2


