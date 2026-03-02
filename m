Return-Path: <linux-btrfs+bounces-22159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCP/Jl8SpmnlJgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22159-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 23:42:39 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B661E5DA7
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 23:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8246435AFF9E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 21:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC023975CA;
	Mon,  2 Mar 2026 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EwFZJAoF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809F3975C4
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485496; cv=none; b=rVMG2rWU71+Mbo0X10qgbQdKW84yhxtEs60g26lsCeguSVA016nuXXSTgGcrEe5emKHZN1XG8Ov+SU+D/PlO6snmxY05f2yK2pJgMQaovacR4cxmkVaO+NPoGMYmrPxUDwTq6W6H0aEyXZKiAOZXMaTjzxU5pENpjNA2s4rqG1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485496; c=relaxed/simple;
	bh=bp8MxfLVfOLDFq0aYZEWtSvDAoA1yKcF7Xeisqp8xdM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JnFGwTcCCOjyt7hUS9B5s+eNYDZgwisWz+1h5MW17vdb44SI1d2Gwd2e4chvVLOt6XejwyWZF1Le95of2Phee0+xsXt2NoUtmI/WCLqw2RwpEOPPizFjUa3UXqvGanRnZnBgoamP6cf5ICUTFtfzOBXjbd3QsYm6h3RavrZShyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EwFZJAoF; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-464ba2bb3aeso3891359b6e.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2026 13:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772485494; x=1773090294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+IPbqMq77bOpkXLRkjJ3UFsST92OHSHvZuEyO94T9Y=;
        b=EwFZJAoFW1Wa8eTWGw+cVu6ZnPfwxnM84odhTiQ6Duqsm2P5Y1dbp6KxVwShV+vDZs
         /k3GnrRHNpqFNe5FSIc4HsyqjV4a9R/5eSw5BxQJ6Az7XUEjKJYHT3dG25ySfAT/ao2f
         wZKRpe0x36T4T9viuR4cwDmZ+YnbgMyaO/2bEtn/DvoRc86skNGgzENgM12YBXESwe0O
         JVrTdR6zGPV734wQ+/w3Fnta4zMk4M+SfsnQiCV9VXSXMMk94F0AnD90o7wG7ETcm6fU
         4Z1F0T1FlHPvuGZkuawZgGcN14vh+yZB3Z5g+k/wMS+D+CCh1MqwxOvgk0Mg6UnR3/Wl
         45Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772485494; x=1773090294;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A+IPbqMq77bOpkXLRkjJ3UFsST92OHSHvZuEyO94T9Y=;
        b=r7xUAzL2c/JA+U+Sgs9gTpdyrrLTNGAHaA74URmnlXBK0FW0+1sdF9P2G6tliSzq+O
         kLglNOR+zfYRiAND0pLSR8VEAlFwaxK+gqLtpQKjWqnpbH/YPkCquQTu3nPv8mEPYnvt
         wLqNhD0M9Qgk/tqOPRsanWhuu1Cl9A8ywo3c6AuT7t+2YBkepbgLioi1kPdWLMGmQygQ
         csA8Z8cRbH/sjkKS4M8HwEP3jPwBt3o7TtR51BS7aeRj+Bd65wZyoG30bzp0Ms3nijxA
         3vDxJtWatOGHh8g9oDijZoEvSxR0dmVg5MStV1kRlQHA2zUWlDIVWTfuBxFEUJA7oiX1
         jJeg==
X-Forwarded-Encrypted: i=1; AJvYcCXI3t7Z0I5jvmuxk9nHALxGj46fe5l+uUZv/N6/iF801OLOFW7uex+c7Jx513nHSFAYvVqfIA6fCo+xrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXNqe5ecfqxOhwV2UUpgMSvInJHh3cSbbfDHk4zeIdMTYbGCxT
	A92alJAdDuBPLPdelMZAVplahW6QxvbRJxU2XURG+YJhEC2UXVMsE4f42M/sfYZP4YE=
X-Gm-Gg: ATEYQzyJ85MxvSxqNdxr+haEi6i8PgAwBABNq08jZo5i2bO0Cu5K3o+u/pYhDx5nfYf
	Ui8lhFCwor8sbWMJNO/SQa/95HLxIKAT2Df4pMHkBOO4VPcNGSc7/orNPe8fUa3QGcbGk7PHxkA
	u0pm+r4Ng6MVIcgaPy68JMuEB+aDHZL7z7Rj7jlFGl5ui2UxzgyHai9nnb21WjB34WFCU+st82Y
	wXFSgBff5ocXYAlkl923vZ8nhhLyzTCNrTOQRIoLRtLaKgpmqrbpq428fmU7bcXnvI/BJIWeJRx
	FD2/WyDDoYsX/CcMnK3iKa9lhIELBcsP9yF3AGHpv1Mfiq+fIK5M1HcnJNhm8YBQAkST6RHQQi6
	Joo6kwVpMlXcY6jkMaMa1jgMpmpyHEC9Wv8u5SqPUig+4R6xlCwCsjVufH2RO/qitCPi0sLi1Zf
	MaN8u2upUA9wVCIMdRIk4eYfdx13sFXjlA+PNM+8G6rdqT8oH+EjCT9h+3gMxc5P4/gvv7yfm/+
	Syr
X-Received: by 2002:a05:6808:16a2:b0:451:4d80:5ab1 with SMTP id 5614622812f47-464a5f0d5e0mr10177242b6e.33.1772485494483;
        Mon, 02 Mar 2026 13:04:54 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cff1aacsm12335332fac.9.2026.03.02.13.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:04:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Song Liu <song@kernel.org>, 
 Yu Kuai <yukuai@fnnas.com>, linux-raid@vger.kernel.org, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
 Andreas Dilger <adilger.kernel@dilger.ca>, 
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
 Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260226075448.2229655-1-dlemoal@kernel.org>
References: <20260226075448.2229655-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: remove bdev_nonrot()
Message-Id: <177248549254.151113.14982963467044589269.b4-ty@kernel.dk>
Date: Mon, 02 Mar 2026 14:04:52 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 34B661E5DA7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22159-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action


On Thu, 26 Feb 2026 16:54:48 +0900, Damien Le Moal wrote:
> bdev_nonrot() is simply the negative return value of bdev_rot().
> So replace all call sites of bdev_nonrot() with calls to bdev_rot()
> and remove bdev_nonrot().
> 
> 

Applied, thanks!

[1/1] block: remove bdev_nonrot()
      commit: d47f7c173262bbeb09645ec72bf91755eed6b1b3

Best regards,
-- 
Jens Axboe




