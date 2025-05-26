Return-Path: <linux-btrfs+bounces-14241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4862AC3E5C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 13:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6E0175A5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 11:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239CC1F8EF6;
	Mon, 26 May 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MS1edMEv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4427454
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748258069; cv=none; b=tBjOZRDWMZZjJTX6aDNWnHExg5IeajDfxnBNAoMjM+cN4HJdT5MWl/vuhJ6OSa9Wkt7r4A8uOlWd2XQsGekwtKWnTLKfwVRm9/4qSEiIOViTvHDpVkLemnxU8qbuPw9qERhV3sjjr21BtLiwjG47JDNDpNFbdfPgbQgROuc9QYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748258069; c=relaxed/simple;
	bh=1b63bQDNcOMNQdfzq7bDqdSNx/EDEh6OzetOLbJSXZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dt3A9TttGEAdDzzKphKGFsxP9tOKJQpnbC+Dt3K74/ckQ5e91fG2Acvri7aYbiV2HfUHmSn4l/4ZC8+UISDGZw8tL6gWe4Unfm7Vfvw/+oRSsv1dWdH0VhfbHgk7XlXmys1b2xt09FnOnGoxXAxR712S+NKBELQuxEtNlO6rrUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MS1edMEv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so29723585e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748258065; x=1748862865; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJSy6dVquxfx+vFA6CdJdgFf3ogWH+xHVWrPfaIjxIA=;
        b=MS1edMEvYLH5u5wHNrLq7Nw33LUtZI1mFuwZirjbFupAdLUP0FICZ8tjnKKEKdQG7P
         FvPuew/xhNjNZ6BqyhKcniXzEd2j3iVtCKJxqQs/SJvkzRnGA3N2j1h99KpgwFgqgqoi
         bRAeELHDFhFR6kL8UtiYFwxCya0k8zUwHKo1KT8XjEx3kunChWFEg6kkRcc5Ah2BfRKu
         pn0lunb6iut47UqjSkJV6XAK0y2ypM2yLRBBGExsVWRAuSVdgBqltHuCmJOiNac0FIXt
         OIKtjBpZ7AubocBK9gqSgFNg8Q66lNlJFH+ZZ9LKo7PGF2tePVtTLp432skj+QG68nDP
         DphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748258065; x=1748862865;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJSy6dVquxfx+vFA6CdJdgFf3ogWH+xHVWrPfaIjxIA=;
        b=DiDNlmHLwPmE3n95U7CnPBZZSswPHJkcd839vC/CWM6go1Y8OOaAE3fbeKtnv+Up5/
         5TL49qNF49Jh2ofyZZaY2gU5C6ikPVffBAIPZK+lpCkZzub8Nm5oE85uAvmX/tp/bPSf
         8h+tbLtnYi+mkonSJcDSGGSU6rJm0ieSqEvTSw8Z/lkmoGw13kngMgwQyBzzh/aufyl0
         a142ooeh0WGaphMOm4/RaylCJCVWqcwZHQUdf5AxCUOFY9Tp7ZzE3nbS1C0VgexLDfpu
         60rnI5CsZNTK8ao6Unkb3ZU+5P3IVCo/gRZB6phgVYFmix8ohpcG4FQZZvTBihACzrAF
         SaCA==
X-Gm-Message-State: AOJu0YyL0V9Fm1+JAdQE3bS1nxVvxY2yNDvuoi4hswUa2LIXbx3rw3Ta
	eAndVGtGjGD9TdAYb+s5eADIRVWiW0GXQK8S3XAO2252jDbzUc7bfBt0KbVMm05xAL1lXHg6C2d
	0nT7h
X-Gm-Gg: ASbGncvH+KzSWJzqHAOm/iayEpb6D5Lb9eR8dSHcGEwTf+IaI6e0vw4nfinnruJWdwd
	8IjBMinexoQ4BLLnnKzJyLmZ7qOdRE2i8WpA+q4c3+Lkx7p7XbJ2gWzCjvbfCYoy9s4saudpxEC
	1zeUxOn27YHaR81Db2SV4+l3InKDGjdLAeCUIKTLT+U9QnuVa00gtLXzFhlKJQX1mlUSFdZKX2X
	JYAgxHxO5fmz1XNXODCWlowpGQugEJkcKOpPbeEW1Fiu3twUp+iEEX1lWwp/AM8/HJXQ6zCFCPw
	HFrakjJA13ioiqQY4Y8oAN5kQSCgOeAI0aaAdR9rsJxAzbvq1Kh+FPmA
X-Google-Smtp-Source: AGHT+IEf+Bu7fbbMrM2QFZVvVfmj+hDVM7InGdJxlI2jqFdSE0NrJCvXJHrq/yK/XbEsCM34rnM99g==
X-Received: by 2002:adf:a390:0:b0:3a4:ce2c:d650 with SMTP id ffacd0b85a97d-3a4ce2cd846mr4493500f8f.38.1748258065575;
        Mon, 26 May 2025 04:14:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-44f706b9065sm9258315e9.13.2025.05.26.04.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 04:14:24 -0700 (PDT)
Date: Mon, 26 May 2025 14:14:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: convert the buffer_radix to an xarray
Message-ID: <aDRNDU0GM1_D4Xnw@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Josef Bacik,

Commit 19d7f65f032f ("btrfs: convert the buffer_radix to an xarray")
from Apr 28, 2025 (linux-next), leads to the following Smatch static
checker warning:

	fs/btrfs/extent_io.c:4336 try_release_subpage_extent_buffer()
	warn: double unlock '&(&fs_info->buffer_tree)->xa_lock' (orig line 4316)

fs/btrfs/extent_io.c
    4296 static int try_release_subpage_extent_buffer(struct folio *folio)
    4297 {
    4298         struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
    4299         struct extent_buffer *eb;
    4300         unsigned long start = (folio_pos(folio) >> fs_info->sectorsize_bits);
    4301         unsigned long index = start;
    4302         unsigned long end = index + (PAGE_SIZE >> fs_info->sectorsize_bits) - 1;
    4303         int ret;
    4304 
    4305         xa_lock_irq(&fs_info->buffer_tree);
    4306         xa_for_each_range(&fs_info->buffer_tree, index, eb, start, end) {
    4307                 /*
    4308                  * The same as try_release_extent_buffer(), to ensure the eb
    4309                  * won't disappear out from under us.
    4310                  */
    4311                 spin_lock(&eb->refs_lock);
    4312                 if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
    4313                         spin_unlock(&eb->refs_lock);
    4314                         continue;
    4315                 }
    4316                 xa_unlock_irq(&fs_info->buffer_tree);

unlock

    4317 
    4318                 /*
    4319                  * If tree ref isn't set then we know the ref on this eb is a
    4320                  * real ref, so just return, this eb will likely be freed soon
    4321                  * anyway.
    4322                  */
    4323                 if (!test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
    4324                         spin_unlock(&eb->refs_lock);
    4325                         break;

hit the break

    4326                 }
    4327 
    4328                 /*
    4329                  * Here we don't care about the return value, we will always
    4330                  * check the folio private at the end.  And
    4331                  * release_extent_buffer() will release the refs_lock.
    4332                  */
    4333                 release_extent_buffer(eb);
    4334                 xa_lock_irq(&fs_info->buffer_tree);
    4335         }
--> 4336         xa_unlock_irq(&fs_info->buffer_tree);

double unlock

    4337 
    4338         /*
    4339          * Finally to check if we have cleared folio private, as if we have
    4340          * released all ebs in the page, the folio private should be cleared now.
    4341          */
    4342         spin_lock(&folio->mapping->i_private_lock);
    4343         if (!folio_test_private(folio))
    4344                 ret = 1;
    4345         else
    4346                 ret = 0;
    4347         spin_unlock(&folio->mapping->i_private_lock);
    4348         return ret;
    4349 
    4350 }

regards,
dan carpenter

