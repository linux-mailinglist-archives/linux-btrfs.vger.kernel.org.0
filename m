Return-Path: <linux-btrfs+bounces-16080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAABB2796D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 08:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD9DC7B879A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 06:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD829B8DD;
	Fri, 15 Aug 2025 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NuVF8RN5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38B2C3769
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240599; cv=none; b=RXc5v4cdScSQksXBP6jBBxCp06Lglrz9TQeHWfUvhXJaU3KiwlnKh7k4K/GgGCOjEKcE5UU6z+fIi7xMSmMjoKWNaV9AG6BKkPhoaXEPJkRkWKBWMqRgckkZIbGMYjwvehvZxBDvMOCH2Ad9MIuTDbRq2X+WTbDKRSAWEuUSA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240599; c=relaxed/simple;
	bh=GULlBzLEz5aeLic70XuvtfYZSj9a9He9jxiOz8IdemE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vw8eTapK4JtQhgk5g63Q3Z6ts9FwvfdB/nD1QpmsADXvpwDY6F8r7mKqU/yZqGghgsauJGCLn+orqgF7hOrEq4j/rqkwN7bOu7hYJxhJAfU+/zEXpZy+4ln2b4HmK4HE7NDlohEys3wpSthWbIZXJBUb6p287IbeiifocpWaOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NuVF8RN5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b281d25so6912945e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 23:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755240596; x=1755845396; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9VOA8OLHr4c/bdG0T3/mzqJ513g/qzEaREkj3y/WP4=;
        b=NuVF8RN5QX5xgFXxo9yrCSznzO4uAoVC12o7ErKVVaAItn3KdL70lb3/L5DbhgCOKL
         M0Df/QJhp3yi4W4i616LjjLNcCVLJVrk5UmZRMiYhM3JnTtb/VS2qLTjuCocCwJvKe0i
         P19O5YINmrMWDlGsHQg4Oe4vKIwUb2PSJiQTIUCdvn5K0Y1SHSEO09aL3102rLlV63ye
         RoddxybPJimMlZCis2yKWP06pA45rpkuMHNxYecrs15Yl+qV6+TZMW5Hsxkw35HOQfVT
         B9rIVN1grVffVv3JtyI5SurcQCt/Jbc6rfJPsLpskxfrds+BZjd4ENHkREYJQ6nWBqFM
         I7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755240596; x=1755845396;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9VOA8OLHr4c/bdG0T3/mzqJ513g/qzEaREkj3y/WP4=;
        b=rai57/lFlkUAcIlihscyVqC3Z3OuTa1dRvRR5L5ObzuRBzXpyaHYEueInsNHA0I+Mm
         ve2wqPEY5pAN5rMz7BSAME8T3ibrzH0ICvCRkkbwXVMGmGKjaKmDPCgFwzXWoEiTgUbN
         7/KwfmajDt7TT9+fSvzijhL8eFRyFgVSZdBPJI+yNPJP1kWtJpbHIo1PchLgR3iPBgce
         goQdWC5yxJWVuBSQn+5caNmDCOrz9MJrngyll/n+li27R+EQmaBYcUKa8eKfXR5g7Gko
         yoS8RqQdbCuSVGTC8tHlWBZHm1UVV/6ADgTg+K0/aCSd5Mq5BYUhHUH3AbajgfeY65IL
         0qyw==
X-Gm-Message-State: AOJu0YwTwUFhTastBh0c8xZIF1QSc+nwUJMGpwECo4Re3CoNnKl5zTgw
	yiR56eoIzwpHH62ByiXUL2vykRdWxqUIwASHXiSMC/OOb3RdsniCN0L1xvu7RGx9Yj8=
X-Gm-Gg: ASbGncvQeodKTW9eUcVyZfT+gSApJCzyEti6F6JvrwTy8nTcz5mbcBukNXt47+kI49l
	/wzmleWaoiY0ghaVkIekRCfSaRCbWJAAAV7FpkrfFUH6SYqD1dC7d8BapD+0qLq6xleqNiNUAAO
	PtkHcdWIekvpmbkglxGzO9ksAFkWTtDC3X4jhBA3V0HrK6++6Bk+XVf2+OfxQJ9O1/5B8owcSZD
	4RWhuuzVm03IOf4cKMsTPxvt52fRh77eac0tFb1wmSlGhLQ89jZs6X4LrxZNhzhmzdvrHL5mPUC
	qwMgVJEpMtHS7QnrC/Vxhz40mdMtliRBd3nSVwLB331WquFUDKPufyMl1zVDqAUMhk//SN8dGe4
	2PORY7XZQ+QH+fw6S9AmjtnLOyHqe4cpqN0kXqQuD/fQ=
X-Google-Smtp-Source: AGHT+IELSrXaYuhLFGTpGAo5aYPIeu31yPhh6djHZJ9yjIneMTnO7f6a9gTH5aqppKokIIuznscAUg==
X-Received: by 2002:a05:600c:3486:b0:456:201a:99f with SMTP id 5b1f17b1804b1-45a21839af6mr8423315e9.18.1755240596075;
        Thu, 14 Aug 2025 23:49:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1b7c18d7sm29387945e9.2.2025.08.14.23.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:49:55 -0700 (PDT)
Date: Fri, 15 Aug 2025 09:49:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: abort transaction in the process_one_buffer()
 log tree walk callback
Message-ID: <aJ7YkIlcNnv1YKeh@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Filipe Manana,

This is a semi-automatic email about new static checker warnings.

Commit f6f79221b128 ("btrfs: abort transaction in the
process_one_buffer() log tree walk callback") from Jul 16, 2025,
leads to the following Smatch complaint:

fs/btrfs/tree-log.c:377 process_one_buffer() warn: variable dereferenced before check 'trans' (see line 375)
fs/btrfs/tree-log.c:388 process_one_buffer() warn: variable dereferenced before check 'trans' (see line 375)

fs/btrfs/tree-log.c
   374		if (wc->pin) {
   375			ret = btrfs_pin_extent_for_log_replay(trans, eb);
                                                              ^^^^^
The patch adds a dereference

   376			if (ret) {
   377				if (trans)
                                    ^^^^^
And also this check which is too late.

   378					btrfs_abort_transaction(trans, ret);
   379				else

regards,
dan carpenter

