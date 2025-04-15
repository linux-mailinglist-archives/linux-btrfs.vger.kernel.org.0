Return-Path: <linux-btrfs+bounces-13033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12893A8A179
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 16:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109AD3AD04F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 14:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C75D20ADD6;
	Tue, 15 Apr 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYuWtinQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1361E5B75;
	Tue, 15 Apr 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728315; cv=none; b=c7sR41SjXYLExvMBJkVLP8EueOgY9SqvpE7OyhUZgeC9NLWof57dEiqRSqmeg77LcYL+Vs0WVK9xnvM8+tecuXTim1jX8UJUfYRrl2sZWIgZtJmYzZdHzsq7bAbyNNyGggta/JuSP5TV3rteiJt/J2gwQX0sVDN/vJdlAxIkqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728315; c=relaxed/simple;
	bh=hVS16O7bOlwnYmqzAzb9HTG4t/ytEEKulnmJAqoT6Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=pH7vmR+WADc29RCJQQ7KMxcGhDfz4tGCQ/mrtF+STR4ObKXDRuv7MW3u8ZVdg8tozPpMT4XiA216CbMI2M1WEz9fGZgSdkWvOSQ2cNx7z7NRKRdKNjF84r0cSUUtyrxm3r8XpFNtWr3FCB3a41HyaN2EVoAGPCEA18r1kMMwSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYuWtinQ; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7390294782bso762221b3a.0;
        Tue, 15 Apr 2025 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744728313; x=1745333113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OtSoNXYfEh1otQMulz3T+amcq5Y6Ks8jS1M4d4tDegY=;
        b=iYuWtinQfGEVa8H5xvipdXShBgS6KXO7KCJD8DWkWK4K0m37lwKHGDwxWbJMgsfxdS
         Uropqvv22I0NJUWDQVUx2YNGB2ExNRzNnkUdOGsnT0U3us//KVPgGfpF5O0rb/ZTx3DH
         7KpLGC5t3ib1I5CxmTUT/Lx83oSlyVNThI97YF7aRAj51Ycj8+g8uPpmN78ipe83OAKp
         Rxb4/fykZl4l9dX55DPzqg9cBnbnIqISqf1d/wu3v9eb31Ix6jurvdyz8m5hPaXaixRR
         R8Ea8m//jt22xbLsgINbu4G85d3D8Ji1XObPkqx2Y5dL5MApFM5/IFXuDgzFs0tMjhJu
         qn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744728313; x=1745333113;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtSoNXYfEh1otQMulz3T+amcq5Y6Ks8jS1M4d4tDegY=;
        b=rW3HBynLDspok9FXX2bKsrTazG0CHFIOpiUSP7m9lqcorFa0vgYk8nqNOl5Y6rOia8
         W++by24MW2lR62wSMHSYR7QndtuC7I9xTh/8tj1jz0nWk3kKLswBirwWqJR0r7IZUWVl
         Foh1ooUZjLlO09tiE1EP1flINrrUOdGhgmuf+aN7x1qj6S4sD0HzP43VAWeN/nexv6Lv
         5ujODoiV+k+0oPxU3/sLfjlb102o6Qnc3Zhy7h/atkGb3AhDKk4EQLORtpelRcH+Gh5J
         T8HE86r67H3FYNgtLFYTqh8m0Kz2nhQklsYpRP/h/dsYx+h+WlKjg4uJPyAQPCr2nnY7
         m68w==
X-Forwarded-Encrypted: i=1; AJvYcCUNTFWH1UB15SnzLzZuxhmuJEyRM4YSvzHPBkuJDiFj0+RnVN5OQs7IuBJt7JJmXpkfOsA8tqbxPBcc0zfL@vger.kernel.org, AJvYcCURrtHrDvAzT1JFEMi2eWHuBcDktBQssh/YT/yY+wd/Njf9Wj6WoOCFjAmbi77g1O9Muk+LFudbWZa1uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHq0KaABum8OJPJtxw8Qx30wvRjqvzGDHLsOjcQbHvrkUHcq98
	NmJi4e49eTgiFmKLte7huhO+h//PLWpyhtEsL1by645iq3Ab9SYL
X-Gm-Gg: ASbGncuLiPGSCAvPLT8UhOffrWG6x9T6eCrYjH2YjHUrB2Dm0GrCjqmd2cCMCwkxlPB
	EqFrTtwOxKKBsg0nxIgriQK6whAlydMfXVcF1mAikvfeAfoh+fg0Jqj2LrEAu1JgTP/xWOYn/F+
	mopd0nC7XGu+zkajRQd7ftrexiEhnVx0mlqQ92kGq7ynmnNKKr3laRvRuKOILvjvm0IfnirV6Ie
	YzqXjrlANLZw+FDZLxhyaAAKiJihBpjOUqTFlMuOvp/hi4laFulR1Zita/TUYIzCdWKp2fJtcT+
	fONywmzJh18RxoKkrqwh4XSz36Bkc+0BlRxz0y3tmOQrjts7PLg=
X-Google-Smtp-Source: AGHT+IHNTQtMtgUlFDNGLFKf5onxilwdC5diWtObOX6v0sS/BOFebGkvat9lR+cl7ysGqSLEmaLKnA==
X-Received: by 2002:a05:6a00:a94:b0:732:18b2:948 with SMTP id d2e1a72fcca58-73c0be35542mr1925263b3a.1.1744728313603;
        Tue, 15 Apr 2025 07:45:13 -0700 (PDT)
Received: from saltykitkat.localnet ([154.31.114.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f1040sm8815609b3a.98.2025.04.15.07.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 07:45:13 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: frank.li@vivo.com
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, neelx@suse.com
Subject:
 Re: [PATCH 1/3] btrfs: get rid of path allocation in btrfs_del_inode_extref()
Date: Tue, 15 Apr 2025 22:45:06 +0800
Message-ID: <3353953.aeNJFYEL58@saltykitkat>
In-Reply-To: <20250415033854.848776-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

It seems a nice try to reduce path allocation and improve performance.

But it also seems make the code less maintainable. I would prefer to  have a 
comment saying something like the @path argument is just for reuse the 
btrfs_path allocation and only a released or empty btrfs_path should be used 
here.

Also, although the path passed is released, it seems the bit flags are still 
passed, which makes the behavior of the functions a little different. But it 
seems fine since those bit flags are never set in this code path.



