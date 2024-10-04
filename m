Return-Path: <linux-btrfs+bounces-8559-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4985899021C
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 13:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A24B1C22146
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26B815666B;
	Fri,  4 Oct 2024 11:33:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out198-172.us.a.mail.aliyun.com (out198-172.us.a.mail.aliyun.com [47.90.198.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB4613D503
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041598; cv=none; b=b0FNlXEi/9LmoOwU8pFqEcR8/i44cWReS/CywmC30XYkx0keOyCrYL4CQHUzW1NduaB/Ho1xbXUaMEgJDqrL+ixyYg5JNzm01gJMWySnVibNxGrFGwoxP9U88idk2M2OxKrWl7AxG6/u2yjRwk1Stn54Umc7HSes0kcEpw4MX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041598; c=relaxed/simple;
	bh=PfRuxMiaJtDGDgtbxzGvt6BI5NPthqhi7Yt+Gd0/W0c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=pTtDa/QcGwWOPqK8WW2FX8z99lJbFydO4irC3IXaACiHCNNoKBpJj02OcfaEIb30YzL8wdd8hxr00PIGGIOUcLqPFLD6YdCKl7m3iSv7EhIXYDBFVatgWqKj+QmfTKo4sSNqUBAt8Yj8jaTa3E3mGUlx7haP7zqxve8ni+Q9gwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.ZYwVj43_1728040649)
          by smtp.aliyun-inc.com;
          Fri, 04 Oct 2024 19:17:30 +0800
Date: Fri, 04 Oct 2024 19:17:31 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: fix the sleep inside RCU lock bug of is_same_device()
Cc: linux-btrfs@vger.kernel.org,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
In-Reply-To: <0acb0e85c483ea5ee6d761583fcaa6efa3e92f01.1728037316.git.wqu@suse.com>
References: <0acb0e85c483ea5ee6d761583fcaa6efa3e92f01.1728037316.git.wqu@suse.com>
Message-Id: <20241004191730.C4C3.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.07 [en]

Hi,

> Previous fix of the RCU lock is causing another bug, that kern_path()
> can sleep and cause the sleep inside RCU bug.
> 
> This time fix the bug by pre-allocating a string buffer, and copy the
> rcu string into that buffer to solve the problem.
> 
> Unfortunately this means every time a device scan will trigger a page
> allocation and free.
> 
> This will be folded into the offending patch "btrfs: avoid unnecessary
> device path update for the same device" again.
> 
> Reported-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/volumes.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 93704e11e611..5f5748ab6f9d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -800,17 +800,24 @@ static bool is_same_device(struct btrfs_device *device, const char *new_path)
>  {
>  	struct path old = { .mnt = NULL, .dentry = NULL };
>  	struct path new = { .mnt = NULL, .dentry = NULL };
> -	char *old_path;
> +	char *old_path = NULL;
>  	bool is_same = false;
>  	int ret;
>  
>  	if (!device->name)
>  		goto out;
>  
> +	old_path = kzalloc(PATH_MAX, GFP_NOFS);
> +	if (!old_path)
> +		goto out;
> +
>  	rcu_read_lock();
> -	old_path = rcu_str_deref(device->name);
> -	ret = kern_path(old_path, LOOKUP_FOLLOW, &old);
> +	ret = strscpy(old_path, rcu_str_deref(device->name), PATH_MAX);

It seems a hardcode of rcu_string_strdup()?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/10/04



