Return-Path: <linux-btrfs+bounces-15066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED87AECB54
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 07:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C5F1897E6B
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 05:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7071DE894;
	Sun, 29 Jun 2025 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Jho/Tqje"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp153-162.sina.com.cn (smtp153-162.sina.com.cn [61.135.153.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCE87E0FF
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Jun 2025 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751173230; cv=none; b=sM9VkgujneYgFZyrCRcY9g8ZMbSrX6iHKk2lGXBcMRPePBxF11eXsk5K0eQnvYQoTDCazDkShlLMhNfjESDUOIxxVAvVboG6SFw7FPl6ha9y3k3V2vdxpi2q95lM1gJnMJv2Onr+ITuH6p8eJH4y/nhtMSJPIngm/CaPtzlietk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751173230; c=relaxed/simple;
	bh=qkwMuaqVBL2k6C0jeCODPJSsGpyoiid8WNP1j/AHeI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asJBKcyF8jngoukH/4sTL5ArOGuLWRN15qkz3QO8mxl0+IGe10h8dFHhnm/SOlzb0ZQkKJdNmnURrDAwFGZ4lJsHSV2yrtaTKGoH07izsreiVPSyMSjK2I0xuewK5eGOTSbWQQd6yMy/bmm/sU9GPCAm0/0RmqatC6UE+qPopOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Jho/Tqje; arc=none smtp.client-ip=61.135.153.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1751173222;
	bh=KYbr+wBrxlVtcJtvqlHFwwPBR9aRJTLXA19HU8OB1sA=;
	h=From:Subject:Date:Message-ID;
	b=Jho/TqjeMZmDZgg9qMEuryBtxmpaYZwEm8yqkwXtmz9ftqbzzy74ugadHqhOC/902
	 FZsJf4JU5epRqnI7MrSs7pec/0jw9yxoTk2vvkGvW8b97JKj6cAXpYCLm5ohOZDDyi
	 aMO/4OBoPeWmKFm+TscCPeHvu4h/EwGl8ty1PUPM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 6860C85B00004C2C; Sun, 29 Jun 2025 13:00:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2028786816218
X-SMAIL-UIID: B963A4260FE641049E0EC157C63A5D62-20250629-130013-1
From: Hillf Danton <hdanton@sina.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH next] btrfs: fix deadlock in btrfs_read_chunk_tree
Date: Sun, 29 Jun 2025 12:59:57 +0800
Message-ID: <20250629050000.2069-1-hdanton@sina.com>
In-Reply-To: <9e589f47-3fa2-4479-b809-5c1b91e7356f@gmx.com>
References: <685aa401.050a0220.2303ee.0009.GAE@google.com> <tencent_C857B761776286CB137A836B096C03A34405@qq.com> <20250624235635.1661-1-hdanton@sina.com> <20250625124052.1778-1-hdanton@sina.com> <20250625234420.1798-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 29 Jun 2025 13:57:43 +0930 Qu Wenruo wrote:
> 在 2025/6/26 09:14, Hillf Danton 写道:
> > Fine, feel free to show us the Tested-by syzbot gave you.
> > 
> Here you go:
> 
> https://lore.kernel.org/linux-btrfs/685d3d4c.050a0220.2303ee.01ca.GAE@google.com/
> 
> That's based on a branch with extra patches though.
> 
Thanks, feel free to spin with the Tested-by tag added.

