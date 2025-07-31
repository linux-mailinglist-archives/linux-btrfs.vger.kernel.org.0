Return-Path: <linux-btrfs+bounces-15781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC819B16F49
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 12:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55AB9188F63D
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAC92BDC2B;
	Thu, 31 Jul 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IuzJ1yEv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CA3154426
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753956934; cv=none; b=JSz3vyFHrFnL7E/QX+173//Z5NQ9QDirY1nkp6PsEx1RqUsF/dJpTttBJvbWoqhjZ77cGpHkIjARYHQdPtd63SnGys+2zUrj4SbS15Hh1RtIA0LyLNgfrkqfuw6Mby1CJMXzy6hAR7FMauPsTKNKnU3ZfmtzfuXCNuqHlvJBKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753956934; c=relaxed/simple;
	bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tcRoMQsqbqb6UtVUiuM+l5RH+TdLevnxrPq51i/4pjT/eJL4VQuTJ5nMWqKr4mdB1EmsoEntCoPkyjYhvs0peqc6rU6dhzD2AedtzhdLYCw22VXEqgQ/Qb/wOcwZX9YL0S6SKMvJztmzZ/3qQELWpez/XWFlNA5KSBOSPatqqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IuzJ1yEv; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753956932; x=1785492932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
  b=IuzJ1yEvSDQ79rAE+4P6EXiU3BF+R9OxAyQ9qXcp39uBXWR2OCh+Fs9m
   hO7mQJTuCxlcjh319DVeSsV6cF/hnAEMuT0BuHX8XpX/3MPwyEvr3z1OY
   XCjilG0XDkuek5pr5T1zcews7fwKhzrv10GtugCEdQ//tM8P5OtSFPZNs
   ewB+XwRKYQ4yjIx0gH+WzWCIkamnJkjhn6YaS4tsV4PuxqhJk9NQsNomQ
   yiQ3NZkKGy8x5xhL97dNWh8h2A4/+1Soc3uSgWTQbwZ9WQlWNYWb5rSsd
   zkv80GCjjZ1prMBTLQ7176OepsALOisE/cn69oa6ty+i5qfeySvDhGjBU
   w==;
X-CSE-ConnectionGUID: 00GR2G5AT7qjCJrSamy+qQ==
X-CSE-MsgGUID: WK+ZedyIQsaIKXr7bTFapA==
X-IronPort-AV: E=Sophos;i="6.16,353,1744041600"; 
   d="scan'208";a="106054179"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2025 18:15:26 +0800
IronPort-SDR: TEU1NKe99garum7/ocf5yqg+VJ73sAWmGQ5vam7We1m5jEpE9HxGD4rGs6dPBUL+0dpptNCsNX
 G64wBo/O9xa+nJXM/kkecEaqljXPT72tklG5JF1zH8hj1WLV7N9O8NUKVLITxlIN4z/BYtLQSu
 MYZ/QwdfjgFB8nd6IBdASWWhfroDP8DXV2Z4bhpKhTPdVAgxNcrOJprFSiDjFqnUcbqljdN/JS
 yYiCEdHOKb5nBr0BFoahCDNnalc512LdzaMMXW0ClCtjtfBpCalZji2luW2qx1ddoKDrKEVRQY
 Pv0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2025 02:11:36 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Jul 2025 03:15:20 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: naohiro.aota@wdc.com
Cc: linux-btrfs@vger.kernel.org,
	wqu@suse.com,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2] btrfs: subpage: keep TOWRITE tag until folio is cleaned
Date: Thu, 31 Jul 2025 12:15:13 +0200
Message-Id: <20250731101513.30903-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250731034656.1386451-1-naohiro.aota@wdc.com>
References: <20250731034656.1386451-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

