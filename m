Return-Path: <linux-btrfs+bounces-13127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA166A91B95
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE8F188B9DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25511241CB5;
	Thu, 17 Apr 2025 12:06:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C91DE883;
	Thu, 17 Apr 2025 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891578; cv=none; b=GHaeMlNFevAL9CDs8oWS4zVanGv1vsFMqI8OzaimSlHOC32jhvGqmAeJFM1enKkBZ7KV++aELrEwh1a3wrXIBzGqfATkGC+V8i/Ncaj+X2vyHz0f+iONM5hqwGwM4KDwu/gMd2xt3TmLN9g1Nwou2+xEouo5CjAztK0sJZ1JdJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891578; c=relaxed/simple;
	bh=iSdXQoelmJnQXN4dVp71IRwrxfStnR9aN5XGL93YJOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o10711UaiIsSgeg0KfSk7uEZQuC3PWAgCbxEotXIlJAJ11810Xso3XUWXOf2PVcreUBSCPtfR6J1lIqP3xKJX0bRSIEyjYP4iQ+Ok4A1P5kSxgUTU3aSHU9/HKTjycLksNq+oWtyRlqPeqLqjeM89S2G1xxXDVKIS87aVjrOgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f620c5f7b9so157174a12.2;
        Thu, 17 Apr 2025 05:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744891575; x=1745496375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPC/Tw0J3R2ZF5QYS3uvOoHpke5dyn7SpTIE7KBhYEU=;
        b=C/MFcswbnjMHjq5cP1Z32gNEn+L8rXajucLNl2JYRKoUeVQDd72cF5Sfxv487Q1o0P
         A2+uq8MCVOy3GYnBJy2NB5JUYuBgIybby/0yf42Lbj4/OkKgGzPY7s3VMCgFyNS+W3wd
         JzuCh1T1VIEHA4AP3NgDDcapuftnWEfyIkASYHTrodiXEvIs2gUhILt0DAy9TB3J6spx
         1KExt+Q7UxIDLPYHVMtIN+Scf2vlgpUSYg+7w59CgB/FVo0voW+Eln1OhXDMJ40J0VA+
         tGzuGfHsvp1hHxhR+sGr/RJwsRxKuGkyuxWYDDg3shCw+SXjywM/kDjZgfhD0G3Q1xGF
         uvqA==
X-Forwarded-Encrypted: i=1; AJvYcCWgrGwgM3PWc29CTaSdtRTHc/3ADBetyFquiRvRXkeU/Dyr9VPTyHSqUWp4P9N5GQnZBgdTk/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqpFUJerWrNgP4RQWASvEn55wKefNFe1vqeb3kJiEwVUB91b+
	zbMjA4qtGyTZ4HLil5u6i/MdFqu1iuCpGGkbwkPjT8yaaZek9eIv
X-Gm-Gg: ASbGncvHMR9GlZ0cln7q7+cE9fwmy8YYtNJ+00CJ3lqqIx2/0zKRT32W+4bWQG5HxuB
	8v/9OOxlyoQXPBB9R5fJeQhfl0CAEbTPNiXEmWgAf2eJrumyt56plEpGYlBuzKJAkF6jCEJM8dA
	C1XqYU9TfIQpyhmc/KEtiwOUfAGMVQoh4jCDfBTcyIV7n1FfgygIcqYqNvlfttQUMQcpYrPGhqA
	4oOj201bO5rzcY0p0DYuj+CAgu+FKOCHVx3IrHvVqLMXSqHZBwohfqNYqx/Cq3gX4yjGz07lwH9
	pT/DEt+Zkkdg356jqt+ZVc/BNLGPwgZwygFff7osud9kMeuGkuo/Kk7zzBC0YfRZ9MGVuEvpU19
	uvNzP6LoNaxM7HSlOhtfMNpQ=
X-Google-Smtp-Source: AGHT+IFncMX86ohvf6hLOHZ0bvDjF3/JZq3LMERDxuMTVRHKYEaK0zbgiB2RWv7v8huSfmkwpLQonw==
X-Received: by 2002:a05:6402:524b:b0:5e7:c438:83ec with SMTP id 4fb4d7f45d1cf-5f4b71ea7e4mr4416374a12.6.1744891574918;
        Thu, 17 Apr 2025 05:06:14 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f710db00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f710:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f06bf0fsm10202345a12.46.2025.04.17.05.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:06:14 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org,
	Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v6.1 0/2] btrfs: stable backport for multidevice btrfs zone (de)activation
Date: Thu, 17 Apr 2025 14:05:57 +0200
Message-ID: <cover.1744891500.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

   Here's the backport for btrfs' multidevice zone (de)activation that failed
   to apply to your v6.1 branch.

Johannes Thumshirn (2):
  btrfs: zoned: fix zone activation with missing devices
  btrfs: zoned: fix zone finishing with missing devices

 fs/btrfs/zoned.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.43.0


