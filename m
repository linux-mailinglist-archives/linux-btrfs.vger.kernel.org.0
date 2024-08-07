Return-Path: <linux-btrfs+bounces-7040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADDF94B457
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 02:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097042832DB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 00:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADDA3211;
	Thu,  8 Aug 2024 00:55:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-68.mail.aliyun.com (out28-68.mail.aliyun.com [115.124.28.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6BB8BE5;
	Thu,  8 Aug 2024 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723078502; cv=none; b=lugr9HYPsG2uX0BDfAWUDdQBruvfFuvUmucBbhaCBH5innaKEAB8n6STBxsrpJXFROerOqUxL2gOdBAP4bVtZRmcSiZPFlA1vdHpN3uKo1LkD8GxZxAL2YDj43Fn1zsbmsp1GhXJZT/bQf0ng+o8eDhqUC84cH0sXO2WNLAZLsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723078502; c=relaxed/simple;
	bh=tGTzP6UR7W4tynTzhj2WXPUVKgzYxwUrF3OdOFMRScI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=RI7IWKNs7kjQAYdfWIoT54FaiaK6WDUgCdtOD5yip3hMwZ1QgGvdO3+hJc/b1fQNBUK99LqMfLxnYmULvAcpvl9j4QLKkbAdK3l/Tk4vZipZIBZHTPBWGUROLNPiO47gTp/RJQTRjNgfhKD/4o7fxBsmC1+t89tD416v8M+2EEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2374859|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.172003-0.00357247-0.824425;FP=3017930540838543335|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040106183;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.YlCKUi6_1723074820;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.YlCKUi6_1723074820)
          by smtp.aliyun-inc.com;
          Thu, 08 Aug 2024 07:53:41 +0800
Date: Thu, 08 Aug 2024 07:53:41 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: fdmanana@kernel.org
Subject: Re: [PATCH for 6.6 stable] btrfs: fix corruption after buffer fault in during direct IO append write
Cc: stable@vger.kernel.org,
 linux-btrfs@vger.kernel.org,
 gregkh@linuxfoundation.org,
 Filipe Manana <fdmanana@suse.com>,
 Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <d17ff87e1c8302c6ef287e81888c1334f014039e.1723044389.git.fdmanana@suse.com>
References: <cover.1723044389.git.fdmanana@suse.com> <d17ff87e1c8302c6ef287e81888c1334f014039e.1723044389.git.fdmanana@suse.com>
Message-Id: <20240808075340.FEF5.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.06 [en]

Hi,

> From: Filipe Manana <fdmanana@suse.com>
> 
> commit 939b656bc8ab203fdbde26ccac22bcb7f0985be5 upstream.
> 
> During an append (O_APPEND write flag) direct IO write if the input buffer
> was not previously faulted in, we can corrupt the file in a way that the
> final size is unexpected and it includes an unexpected hole.

Could we apply the patch
	70f1e5b6db56ae99ede369d25d5996fa50d7bb74
	btrfs: rename err to ret in btrfs_direct_write()
to 6.6 stable, and then rebase this patch?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/08/08


