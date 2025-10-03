Return-Path: <linux-btrfs+bounces-17421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FE0BB86CA
	for <lists+linux-btrfs@lfdr.de>; Sat, 04 Oct 2025 01:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7C7A4E76FB
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC5A2765CF;
	Fri,  3 Oct 2025 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWQ2tQb5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2626738D
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534936; cv=none; b=sjQmnFofjcJ0ID7xC4s5AlpQwwbsT4Z8SV1YemIAyCH8v0kvF1YOEecrf7AltqZH3JI4/1fVSppd6XMpbtyRxSbIu7x0ArWUr5ttgLy7jdYBE3pb4vfv7hKWSnOHfTWqSdWI8g1yCf55FjiUbzI0B391k4oAwWxwUPvDsiFIGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534936; c=relaxed/simple;
	bh=tAVytkghSNKtospDj8vid1JCmnJy8U61e/9n6jzqIto=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Owk8vCqZaYRVnp6R6XwbDawMVHcO0y75fSAvkZ+jbHh/aCHy/v5N521EjS8Rr5+n65bLL+CQEXfag5MGA2CVDLCHNPkBIPJHCxJmyLcfa2/JOmJ2ZR73zfCVDxHdq2vEVj9PJmgQx16GhmsuHT8Zoa6qQNWJ4F2S7y/6fl/dZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWQ2tQb5; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-743ba48eb71so57657597b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Oct 2025 16:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759534934; x=1760139734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BqqYOTmLcrr8/GA/6KFAhPxl+1vUC2lGU57KY10Mbx8=;
        b=MWQ2tQb5LZivT0spO38XNqZUKQWS21mMbpBD4l/Y00sKYSJpmH+UVpPlwuidS6RzVR
         o/BG9pR09r/TV2f7zxZUsBOR0z16ec9uXsLgQYI6SxCffsO/JSMNfDw5h592BsmmGxmO
         ltmwvRGJE2jYD49yQA4l52VX38NLPoBQrsa75uOcPJmQEHF5FwThoR0JDWNozbIyzOUO
         fOCm91qucr7SRwzPpP69LLjzMjsC2L13Yk+F3F3zNgD/kLrv0sUdkJ3HMz2oLau9WrL3
         AS/YfUBnJNoIO+ffn6oXqBH5M8D6y4WgNiVtFPdI0CcysiqhfBx9xBFUgOZm2+5FmhQN
         bB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759534934; x=1760139734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BqqYOTmLcrr8/GA/6KFAhPxl+1vUC2lGU57KY10Mbx8=;
        b=TUnffbj2jhomHCgPep/mcW7oUZ93uTrjxUaGk7JuoL5dYE7FsJUHNFZUxVb9JXCA5J
         mkYNK//VVJ/nnys+oXVe+1OyT49+vC3hi++r+onn7UwCfZuR3EPCk3DbpB4C/Yl25QMq
         Stc0Gom3QEROZn2Zn4THkzkPs0GpEQTHZ0e0UkpG29GZ4xwXY6OMTSWPBlvgy1Por848
         f2OWlvFmVe1FsWtCLnqyRuRphq3NYEPmveTSF6TmCM05jsBNQUPi64/2x8rSGTbxGvZN
         InQ/S70pi7DKz8cSrVtHq3KadjfDOkSrqiGpqEiBpsOerLmCy+mV/Fvk59AF9a1b6r5p
         shBg==
X-Gm-Message-State: AOJu0Yz80ZysqNqHL/C7owwbfFOKfkw5KgW0++eH2HmOb1nj6wWL2TbC
	Uhofm7FCx4EwrNpBqqg8/iqk6pU8L5Lc6LyaayE3wa0rCVAnV41CKGsAwNWr5evO
X-Gm-Gg: ASbGncuq+wZvsOM8KuPl/KFlNXcp7C8WZ1YYuxrOuyFSWIDIofocmEDlF8Z9fX/CIt7
	5KUpk4B7kRkf5m7tnN1tdPmJPq+sLPw8HV466UbXuJ4KBzJmFvaoWJr63sGAMTVdcFVUIJdRP4V
	I5Uwg3HJg6iZnF6jh6Kv93M82GXGExKXxWanussut+XWPhGDCi44Rz17eYZlINUR0N+txaZC9Te
	rqoQN5i4wvS9yk04Go9mi0yzvgxDpdja1e3wsq5NAqC64jH0Mi8bGQjxpdtpBwrDHlEy1TqRJMx
	TJef5QKpC1Pl7d35u3pJRQpvNG7jyHcWK9jdCgEAIuxTlMHVLvxOPg58pRxLU8Mf5Djgu+qOQ+T
	+7ZJsMeZtEaat9nv7S4WgSKVEtaKB5o5LOySv2sF05JXd5R4lhfA8
X-Google-Smtp-Source: AGHT+IE9t/QoSBjuScNtvVhNZUa79PfU+L7XqTXjxSvDtk/YW7kmdiUjNxKD0ryrtYT3c8HKMjvr4w==
X-Received: by 2002:a53:da50:0:b0:635:4ed0:5721 with SMTP id 956f58d0204a3-63b99670231mr3365432d50.25.1759534933787;
        Fri, 03 Oct 2025 16:42:13 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63b846c9710sm2164084d50.30.2025.10.03.16.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 16:42:13 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: find_free_extent cleanups
Date: Fri,  3 Oct 2025 16:41:56 -0700
Message-ID: <cover.1759532729.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch removes redundant RAID loop logic that became obsolete
after previous changes ensured allocations only occur from block groups
with matching RAID level.

The second patch adds comprehensive tracing to find_free_extent() to
improve debugging and performance analysis capabilities.

Here is a bpftrace script I put together to analyze the allocation
behavior, along with output.
Link: https://github.com/loemraw/btrfs-scripts/blob/main/ffe_analyzer.bt
Link: https://github.com/loemraw/btrfs-scripts/blob/main/ffe_analyzer.out

Testing:
- ran xfstests btrfs/auto
- verified trace events output correctly
- new fstest that tests RAID conversions under stress

Change log:
v1 -> v2:
PATCH 1
- re-add full_search
PATCH 2
- standardize naming of skip reasons
- remove preapare_allocation_failure reason as it's not a skip
- add more error_or_values for skip reasons
PATCH 3
- new fstests for raid conversions under stress


Leo Martins (2):
  btrfs: remove ffe RAID loop
  btrfs: add tracing for find_free_extent skip conditions

 fs/btrfs/extent-tree.c       | 70 ++++++++++++++++++------------------
 fs/btrfs/extent-tree.h       | 17 +++++++++
 include/trace/events/btrfs.h | 66 ++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 34 deletions(-)

-- 
2.47.3


