Return-Path: <linux-btrfs+bounces-11234-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD47A256FB
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 11:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A3A7A74A6
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7B5201271;
	Mon,  3 Feb 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1447-se.20230601.gappssmtp.com header.i=@1447-se.20230601.gappssmtp.com header.b="T3YDDux0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C5C201116
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578553; cv=none; b=jetUTVrFmbwYNIizCMVhhKCFbLxmQQg6KdP8AgjR62frwkUbv1LnmdiCRJvy2UG5GlrpVapEgxHS14eTA4D4VPb11dVkLdr6aGbJ0nTsDazNFvvQvt8LsLi/RZEYgywUNWkoLeKhL/R/mmBTlWD5Cg6zgI9fBQfjxnWPoLOq+j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578553; c=relaxed/simple;
	bh=918h+4DCGhPy2wPhXAThICSYSxFuHN1aXiG2zqgqH1w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JyhhislZixhcqp8kvKK5SeGDOQLucX39H0eNW7OvrYSieZjO3z7jDpNYgnFSHAvYinkBJbiN41eXpznG70nzYlvPwd1QrTyXIiOC76tgl4Cwf8aAkNPZKBKMhTS2OILJj6VkBbq6iqPEFRhAoF+U7ZJbwppo3mQ9BwZqiK0BHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1447.se; spf=none smtp.mailfrom=1447.se; dkim=pass (2048-bit key) header.d=1447-se.20230601.gappssmtp.com header.i=@1447-se.20230601.gappssmtp.com header.b=T3YDDux0; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1447.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=1447.se
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30761be8fa7so40152951fa.2
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2025 02:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1447-se.20230601.gappssmtp.com; s=20230601; t=1738578549; x=1739183349; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=918h+4DCGhPy2wPhXAThICSYSxFuHN1aXiG2zqgqH1w=;
        b=T3YDDux0nssDP8G4IrCZU7o8Hr89LkxW87yGyRg7v2ws08h9qsfYgp6RpJbD8QR7hj
         zhxnRcBqJdkWjb1fw63dgrOlhj+j3/SxMFEAlLEDVOwMuMnhzMJwtfAnUDWKLnwRsEDS
         NdHr5SZHKIKEG3kh5kneG/KsfK7OIG/kLpBjhDZp6k+gMyrrb64pue2JfYvrce8oDudA
         oywmqPl0nI6g4pOV7DOsKvP48/nZgS+T5Ku2BB0C4odDQipHnun20zWPbgCWHCQoNj3P
         JOK1b2gk70cJl2e8FqUFZdIv6RJsjalbxwE/xhwTAqstjxplihqPziL5znqKVJUdIvkG
         1ZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738578549; x=1739183349;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=918h+4DCGhPy2wPhXAThICSYSxFuHN1aXiG2zqgqH1w=;
        b=e7i/P9E/rwJ1pkL6NnmG6uXeW3NYqtbqGKnCzrhKC+S4s7D202VKRAcqc+YUPC051d
         xw3BFxCstAbDNGtHsSP9BxUPsPQIX1vEZ1N4lW3XXvDmdWHQihZP+libxjLmOXCd9Di7
         tg9Y5oro3uXYHzgYyFmJmgm5uVSJR7LcdcNteyCC7ToDUuhuxpuv77tS+Dg/yU84Rx1w
         Lqo2gF5b+1b53Rxhb7FhyjOrvXFEs+2EaXMoqmDDDW1Y8wlEmRNXgo5mYvb0C/zK8aro
         OSCPUUOEmPOIbwX4X6BakCILYzgl/AEWxWAjXr+huo76A3uh6ACRu30F0V1smnCngJx7
         cz/Q==
X-Gm-Message-State: AOJu0YzNeBgkpJ04Dr6ugjw2Wze3v2F0hgNxSC6RNCOkf89QKDB7OFWd
	3HsSvWXzecAGXz4NGLp80ne8selYEVjm0Ptk2aTHF+PpJ4xfE3bD3YPjxqJzs3c6V5GQ0tuS0cU
	V9mIsdQnunH4E+3zjtPLh2iAlK9bXgYCOXw2/JqRPy2MNAPFVztA=
X-Gm-Gg: ASbGncvkYLD1faK/FlzrRa/xYZqrhG01DKg+qdeihQjDoW6zzPFodx29PlU5bAdkqkx
	/HdvoJL7z+kTd8s+x17tuh/0pbr07nE/ZuALBiVChDTD5UMyJW9QN745BPAgRQFkZeir7M+GJ
X-Google-Smtp-Source: AGHT+IHBJorgTTzVu76IxHQOusYoF3zgUKEMcj0uDSp1tri9x/7V57lPr5+t1aGO0owz7njDVFYARkLZJ9RjhSKJvdU=
X-Received: by 2002:a2e:9a0e:0:b0:300:33b1:f0cb with SMTP id
 38308e7fff4ca-307968d44f0mr67027511fa.13.1738578549188; Mon, 03 Feb 2025
 02:29:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: magma <magma@1447.se>
Date: Mon, 3 Feb 2025 11:28:58 +0100
X-Gm-Features: AWEUYZk6yFbCcSdgr-4jb6n2ssw7vb84gqJWIOUO3MbJFN2QeyPtOzpJ4kuA8QA
Message-ID: <CAD5A=keuYZ-CvQMk=xpOi70EeC4mNXKRTtjT97nNwg5GZ5in4Q@mail.gmail.com>
Subject: unsubscribe linux-btrfs
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

unsubscribe linux-btrfs

