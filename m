Return-Path: <linux-btrfs+bounces-2708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D6E862528
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 14:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A41028278A
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9234C41212;
	Sat, 24 Feb 2024 13:43:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out198-150.us.a.mail.aliyun.com (out198-150.us.a.mail.aliyun.com [47.90.198.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F410A3C;
	Sat, 24 Feb 2024 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782185; cv=none; b=dNgiLW+sjGjOgwWjdcclMr1wxxFDny7TdtRvqWWjafBTkZZkC+mz8OrQgLoC3KSms3c/SqOV4a8oUZ1Yae5Wn3PSCFWafxKwoVuoBZRUMiDPpiYRY8psHWDvxKPIEwZUtJ+727h3Xg0GEoDiqhsLcv0xTpk+TSi0qXEj7DvYe8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782185; c=relaxed/simple;
	bh=tbTQsDldIVaiWZ1C928G3z+vjqEkh7/o96Jtv4gDa3E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=Mj+Za07B6Vr7tQimHkKpyuks5PG6VvxlW2T4kV0dlsROENROxTixO87+2uPwNGj0aE6ej8L0lYxR1eQ3yr/l3gNStDUTQVUQhrZARTc5gHKIuVRubaOfJAdjU7MJrJuMYTkgCMo+1ANhtk4ZuUXhvL1M9ZT81G8+8/8Vy5lVsio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3970036|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0115895-0.00118961-0.987221;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.WYNhXpF_1708782160;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.WYNhXpF_1708782160)
          by smtp.aliyun-inc.com;
          Sat, 24 Feb 2024 21:42:41 +0800
Date: Sat, 24 Feb 2024 21:42:42 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] generic/733: disable for btrfs
Cc: fstests@vger.kernel.org,
 linux-btrfs@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20240222095048.14211-1-dsterba@suse.com>
References: <20240222095048.14211-1-dsterba@suse.com>
Message-Id: <20240224214241.840F.409509F4@e16-tech.com>
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

> This tests if a clone source can be read but in btrfs there's an
> exclusive lock and the test always fails. The functionality might be
> implemented in btrfs in the future but for now disable the test.

On linux 6.8-rc5+, generic/733 with btrfs filesystem have some chance(>50%) to
success now.  Is this expected?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/02/24

> CC: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  tests/generic/733 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/733 b/tests/generic/733
> index d88d92a4705add..b26fa47dad776f 100755
> --- a/tests/generic/733
> +++ b/tests/generic/733
> @@ -18,7 +18,7 @@ _begin_fstest auto clone punch
>  . ./common/reflink
>  
>  # real QA test starts here
> -_supported_fs generic
> +_supported_fs generic ^btrfs
>  _require_scratch_reflink
>  _require_cp_reflink
>  _require_xfs_io_command "fpunch"
> -- 
> 2.42.1
> 



