Return-Path: <linux-btrfs+bounces-17978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 682B3BEBF75
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 01:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32DB1887868
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 23:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AE42D8DA8;
	Fri, 17 Oct 2025 23:03:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-41.mail.aliyun.com (out28-41.mail.aliyun.com [115.124.28.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE01261595
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760742193; cv=none; b=Y/OlL/14GYA3HrrH/rYZEZiwZ7Qf/60FxOd9ABEzmnPMWGG5fXye40Y7RSmRXgN7iu1lE+eHFL+d0PcxRoRABF3SK+06fVRF7oT8RJvbGmkcNfV7WvdPciShVCofoq4CDmoeJ4OmvCWkzxFaQKndt2gPNkbqPugoFEE79q/Z6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760742193; c=relaxed/simple;
	bh=P7W3Zjz1n9jcYTPJ7a6C/J9NAbE/n0++EE9xfAqdzrE=;
	h=Date:From:To:Subject:Message-Id:MIME-Version:Content-Type; b=d46r71Jo+cFrFukq7BrM7xHPXhZ30qP+YJmC7o3Q6lhGdkaF6WmUzou1aJDrPq0OdKKhMcFIcv4i7qAZ5eWmnwMG4zVM9f3+078oB84Tp4BICzi9fvghMpzxLwMsGC4c6ltrjsesbI3LE3ijdzFcdnGSS2wdnXBkUesCXfzMXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.f1GJdck_1760741245 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 18 Oct 2025 06:47:25 +0800
Date: Sat, 18 Oct 2025 06:47:27 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-btrfs@vger.kernel.org
Subject: btrfs error(dev extent physical offset is beyond device boundary) when mount
Message-Id: <20251018064727.9E9B.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.82 [en]

Hi,

btrfs error(dev extent physical offset is beyond device boundary)  happened on 
a brtfs file system with 3 disks when mount.

dmesg:
dev extent devid 3 physical offset 719991138680832 len 1073741824 is beyond device boundary 719992211374080

719991138680832+1073741824(1G)-719992211374080=1048576(1M)
719992211374080=670545 * 1024**3 = 670545 G 
    This is a hardware RAID device, so the size of this disk is just SZ_1G * 670545£¬
     not like physical disk with the size of SZ_1G * N + some small value

and this btrfs are running on  kernel version is 5.15.y and then 6.1.y.

Any advice about why this chunk was alloced beyond device boundary£¿
- Is it BTRFS_DEVICE_RANGE_RESERVED(1M) related?
- Is it multiple disks related?


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/10/18



