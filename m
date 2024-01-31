Return-Path: <linux-btrfs+bounces-1949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D0D843777
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 08:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BC91F28304
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4431B679E1;
	Wed, 31 Jan 2024 07:12:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out198-171.us.a.mail.aliyun.com (out198-171.us.a.mail.aliyun.com [47.90.198.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E8664A3
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685132; cv=none; b=d8rsC8PdIZ6rJzaIyIC7+0IDH6fzUlpkOF7YZmSuJDzPhWxJR5w/FGJvL/YeW0eWx6a5fD5hbXyN5gi8RZBGZmQERdoB+/vQwudLmBeFHp0mTQuH1nrEor6pM6k6IDJCi/NsRSZ3+98qCdacR6EJ20hIEgl36CcgFcC9/pZnH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685132; c=relaxed/simple;
	bh=4xABp+6eNy63ejBH+0A4vuc4kIezVh/OIeaeEd4QoyA=;
	h=Date:From:To:Subject:Message-Id:MIME-Version:Content-Type; b=jaFLmztaOUWXB2OV/CfAHCFXRgnXIeBgvC2DnSLdlM7+fRvkW7LByOgtLsCCInzphfidbbqZzX4k6Law1L0SEnX2LLC3NBtldR+lYc2v/La6ik+ksw39SlU5wV+4v03UkIkD4JGzokSnbX9CWmn9b6RNIlfaUtcaPp6b6KdVx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07492237|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0916716-0.00699771-0.901331;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.WK3sCXO_1706684791;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.WK3sCXO_1706684791)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 15:06:31 +0800
Date: Wed, 31 Jan 2024 15:06:32 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-btrfs@vger.kernel.org
Subject: dbench (sync open) max_latency regression in btrfs 6.7.0
Message-Id: <20240131150632.A647.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.05 [en]

Hi,

I noticed a dbench max_latency regression in btrfs 6.7.0.

command: 
	dbench -s -t 60 -D /mnt/test 4

result of 6.6.15(rc1)
 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX     430533     0.014    63.764
 Close         316239     0.002     0.029
 Rename         18242     0.080     0.340
 Unlink         86967     0.047     0.396
 Deltree            8     2.779     6.058
 Mkdir              4     0.005     0.007
 Qpathinfo     390364     0.007     0.105
 Qfileinfo      68334     0.002     0.029
 Qfsinfo        71601     0.003     0.037
 Sfileinfo      35072     0.006     0.039
 Find          150942     0.020     0.115
 WriteX        214235     0.978    86.843
 ReadX         675557     0.004     0.061
 LockX           1406     0.004     0.019
 UnlockX         1406     0.002     0.023
 Flush          30182     0.013     3.074

Throughput 225.11 MB/sec (sync open)  4 clients  4 procs  max_latency=86.861 ms

result of  6.7.0
 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX     419186     0.013     0.266
 Close         307908     0.002     0.046
 Rename         17749     0.110   503.312
 Unlink         84625     0.049     0.400
 Deltree            8     3.125     7.249
 Mkdir              4     0.004     0.004
 Qpathinfo     380081     0.006     0.087
 Qfileinfo      66545     0.002     0.030
 Qfsinfo        69638     0.003     0.041
 Sfileinfo      34131     0.006     0.043
 Find          146925     0.019     0.114
 WriteX        208546     1.007   536.773
 ReadX         657303     0.004     0.042
 LockX           1366     0.004     0.023
 UnlockX         1366     0.002     0.015
 Flush          29357     0.018     3.076

Throughput 218.935 MB/sec (sync open)  4 clients  4 procs  max_latency=536.777 ms

This regession  is firstly found on 6.8.0-rc2, 
Now  bisect-ed to 6.6.15(rc1) ~ 6.7.0.  and more bisect work to do.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/01/31



