Return-Path: <linux-btrfs+bounces-1441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D913282D1D0
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jan 2024 18:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7805EB212A4
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jan 2024 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A671078B;
	Sun, 14 Jan 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b="QJJ9eHTQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.mokrynskyi.com (static.230.39.109.65.clients.your-server.de [65.109.39.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E5F9C6
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Jan 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mokrynskyi.com
Message-ID: <4bdc87ff-2cee-44af-9a23-fdf447c6ae7d@mokrynskyi.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mokrynskyi.com;
	s=dkim; t=1705254168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w11t1me/S8FEWje/51md0SouGpNlb8y6UcGCIRXmzeU=;
	b=QJJ9eHTQavMjK3kPTO8JWHDz0QPK5YL0TR1rRJDGZmWu5sT0B0yKy5vHhyeOjwK14ENtqB
	6S7/HH2coVhWTEL9Cs175BViLqmu5ewkyW4qWGinSC0XNgvhW5fsJnvtbOB3UTutV9eqRd
	Z3YtBh/OXsHZ3C3fckWjQv5KAG9eQtdkiPpzRzkP0wVmmW5dEsd+WugPCl8zA0Q+xyXR9K
	H2wTE/RGkzijP9SfpOwyfLoMnybYFCBDx0ShV+BK91Lgrv9PvUrqIUzxRIGq9r1wp+jE0F
	P9OWunU+HBvN+Q2TRhGlEFj0sjWn9RcenZqRIGk9kkQbv2lTd0IxV2xrYiPYww==
Authentication-Results: mail.mokrynskyi.com;
	auth=pass smtp.mailfrom=nazar@mokrynskyi.com
Date: Sun, 14 Jan 2024 19:42:47 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: linux-btrfs@vger.kernel.org
Content-Language: en-US, uk
From: Nazar Mokrynskyi <nazar@mokrynskyi.com>
Subject: With BTRFS RAID1 most I/O is happening on a single drive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: -

I just looked at one of the file systems that runs on two identical HDDs and noticed that sda spends less than 10% of time doing I/O and sdb spends almost 100% doing the same.

This is odd because I use RAID1 for data/metadata/system and drives are of the same model, size and age. So I would have expected I/O to be similar as well: in case of writes they should happen to both drives and reads could be interleaved between sda and sdb since both logically have the same exact contents.

Is this an expected behavior right now?

-- 
Sincerely, Nazar Mokrynskyi
github.com/nazar-pc


