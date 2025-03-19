Return-Path: <linux-btrfs+bounces-12426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E9FA693B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 16:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90AD1B62848
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1E81C8602;
	Wed, 19 Mar 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="F7oM9l28"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99C1C3C11
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397994; cv=none; b=d0eyuQIzQNlieJDtlkvdzmU1Q5Pc8FwPsn621e8iOeZjEiKIW+9RMbbKDmRV/eeS49d8/8Lhz9Yjow2twyxpgEbICc0WRTwfVN+13tNRJc9zlQnF3whMaGhFKjWg+L1ddODtnCIhwRTBC4VhzlCCbqFOyohzTGdmw3zV7ZkcSu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397994; c=relaxed/simple;
	bh=b6OGf6ty07rhqd72Rca7OnvW4KUA/qKgWWNZmFcHBF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XnzvrAZ7klj5HvqCrOLqQsBgPAan8vS2TcaNlqj+4bmg71OPBpUQyoGHT/ducgjiut82h4Z1WCvIjfaFIDK/X0Sn3nmzc5TAu7BcwqGgPw2BJGZm7yrxk1sGVIrbCFxdsLyVPsKjtwzxbKTMAbT3Hy9VYpyzpIy2GNo+JRl4Ewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=F7oM9l28; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85db3475637so29468239f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742397991; x=1743002791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6s7stxj6j02Q9GM2Q+eifwtx2fkSLIEYuHEkF4Kxt0=;
        b=F7oM9l28PN32B/udFja7KBDY4deoNldFRvcNzN0nXA3ZGQoxW0WkOhvOrTLQIjTFhX
         kcFOX961epeGJdJkW5dWlUTNJ4OzONPClAtI/eHUNcuxbH8DkvMLjreaWfb5AhDYqEjG
         uhChtoWVGJfyjm/3GqRBa4jwhXjT5dSn7OPM4mtNaGPqjRM3/x/B/fs9eTkLA2nPDhii
         qAkKO+wy70ZPomeK6H0s8yes4HIAXlmEO9L/egyP4o3lkqkLJw/Vm3LMxc6F3F/emHPr
         gJEeiaiDsZ2bgFy72rj9gMyx8rimUaLRWHufduSKMPvKa6hSaHXO51F1LxKdaJPM62Lt
         Q8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742397991; x=1743002791;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6s7stxj6j02Q9GM2Q+eifwtx2fkSLIEYuHEkF4Kxt0=;
        b=sjuAsQFCVRUhTsTN2lLnP/y5CTfnvtCHJW5t7HyJq0dcjaLFGR8qFfPfaU2NupAnim
         vRxgrwHwYUEyzkj5ig9XKERKPsHhiIlkK/ivZBxqNC6ksR6HT1CLZt1t+i1witETziVu
         d2jqe5UrnWWWdSaGItyDJ6Qlz7D4QWbfM3x2gDmJ6RIEQZv6H49jNXsFkX5tAt2/xHkT
         NnjG28+shA/CRqWxjIghBwnkMvRS1xzn9OL2YNxIUzIP/FKMJhnl534MLxGYzrox5tyf
         ijzx+AcDZ3p2dgR5fusmMWjqO7SQ1g9Qh27WVpk5Ol29Mo1h6nz4qttPOU7N5r9T/6Dl
         RtWw==
X-Gm-Message-State: AOJu0YzBjbZlOiZoF0LA+qxz7lYMDpSNvn4aJ/vkpYA5lDkYtwlAimsQ
	E+D2GtParSkrQBmR0ZMVDrmxstRSf5rMPeV9Mj45W8EU1gY63M/tQuppeWvWHGk=
X-Gm-Gg: ASbGncsqtIzVDLG7J5oG3zchjGDip7aXhLHUwdPA18f/7VEAkek7i+ma0gOSggdn4vx
	zqwZy/vYPX8CDgdBPDCeve40XCjpHSv5cpfjWQ8RZs2LYCk1bR2a9mNrgg2DJ8RiijwqegxYN9v
	hjHeR65PXvtrKbf26DNUyAGFhf3ObLFqG1fdUUozbrLZTo0rb29XYZLgd8QWsjEz52EYEhDzITI
	P3jN4ptRCI/52nnhOJ2e5rV2UHJh/JrsVLWj3AXImcV9tRZ8d4tPtuzqtdkdEJ/Ivq0SEcVkMQ2
	VhBCBjW4u90mJgvG3bMoOt/rgKqIlNfobp8=
X-Google-Smtp-Source: AGHT+IEPszl/ebd/oSF2Uq2+SIS8aH9d2S8RxCBgdwIWLD2tLo1SckfHzcpZd8Mmqb1Lnvr1oYw0lQ==
X-Received: by 2002:a05:6e02:c6d:b0:3d3:d08d:d526 with SMTP id e9e14a558f8ab-3d57c4448b1mr60362905ab.11.1742397990791;
        Wed, 19 Mar 2025 08:26:30 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a83850esm38761295ab.64.2025.03.19.08.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:26:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Sidong Yang <sidong.yang@furiosa.ai>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 io-uring@vger.kernel.org
In-Reply-To: <20250319061251.21452-1-sidong.yang@furiosa.ai>
References: <20250319061251.21452-1-sidong.yang@furiosa.ai>
Subject: Re: (subset) [RFC PATCH v5 0/5] introduce
 io_uring_cmd_import_fixed_vec
Message-Id: <174239798984.85082.13872425373891225169.b4-ty@kernel.dk>
Date: Wed, 19 Mar 2025 09:26:29 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 19 Mar 2025 06:12:46 +0000, Sidong Yang wrote:
> This patche series introduce io_uring_cmd_import_vec. With this function,
> Multiple fixed buffer could be used in uring cmd. It's vectored version
> for io_uring_cmd_import_fixed(). Also this patch series includes a usage
> for new api for encoded read/write in btrfs by using uring cmd.
> 
> There was approximately 10 percent of performance improvements through benchmark.
> The benchmark code is in
> https://github.com/SidongYang/btrfs-encoded-io-test/blob/main/main.c
> 
> [...]

Applied, thanks!

[1/5] io_uring: rename the data cmd cache
      commit: 575e7b0629d4bd485517c40ff20676180476f5f9
[2/5] io_uring/cmd: don't expose entire cmd async data
      commit: 5f14404bfa245a156915ee44c827edc56655b067
[3/5] io_uring/cmd: add iovec cache for commands
      commit: fe549edab6c3b7995b58450e31232566b383a249
[4/5] io_uring/cmd: introduce io_uring_cmd_import_fixed_vec
      commit: b24cb04c1e072ecd859a98b2e4258ca8fe8d2d4d

Best regards,
-- 
Jens Axboe




