Return-Path: <linux-btrfs+bounces-4524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A398B0F12
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 17:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AD42957E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970C16D9B0;
	Wed, 24 Apr 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATd3/GrT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CAC16D4E9
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973774; cv=none; b=s1h7QVDffRvKBFPb9V1MW9lzVE5zRZKsJKhP1SPY4BwAmuHQgZHrmU1vl4XjvZxqptWepA1PzzZI1l5bVA/Ntu/AC174+8DwLg7cCyXZB2hBL3QPBWEo1XEOLw0u7ABQi+sVyoQ903iX1iyDxzjVz7rut7vGsbhh7h6H+MClQ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973774; c=relaxed/simple;
	bh=kXJk6kNFF4nFAEWQIzEOfIIfxOY1xgcDmy6PHzr3pKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCEyBa34lm7nys7NpSCsrlIlC7TsAJE0YMeLlQnFGEnNWUUq6i7ORQBmhqzewtfmLESKJ4eZymWQo6bbLMagXwtvj3CPD+B/g/ohElS9InhVF9lCkwsYJ70FXu3woaI9FwR6XWld0Y6guE72vdxAwcm/kV4QAqccD0+41KepT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATd3/GrT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713973771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JzQjLglwKUFTRFQABxbDKmlx68vnFPiDHmxbq9YCs3c=;
	b=ATd3/GrThRo+aMQt3itfDp2cHbEmRzWdi06GgAuFdC0Ywf5gbRhY75YHtC7fqgBZmqzsj1
	e5Ep8eSQbAU9cjKjz6UMd1SSf74e7rcceLcXGTC/kWR3NQ0HkHYS7ODYzaA01r6c3M+oeE
	muNrDjKjPkQMcnleC1Pe6C0ZeB1EEsc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-AIZYmCxeN02UKwbdfUEXJg-1; Wed, 24 Apr 2024 11:49:30 -0400
X-MC-Unique: AIZYmCxeN02UKwbdfUEXJg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a4ff147030so42106a91.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 08:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713973769; x=1714578569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzQjLglwKUFTRFQABxbDKmlx68vnFPiDHmxbq9YCs3c=;
        b=iAKkaaROv0/MbjB3QO0j7QlqJyq9dNRU1BRJdZFQrXaOA13ZKxJHkRLMlmiiB4NS+G
         fOHmmuGNPTdOzoOmOUwuWvEoDU1w9Mg9tXKpPoOhKlVQvfg753DrDGm778yMn/z91dbc
         uAkPmZCS7ch6xwzQBuP1yO9KYRIjgUsoWV+0t2WeKk/Ib0hIBh89dBtSs+WPZqSBOzVp
         /4VtyOHHBbNbbd8IqCWgX+Dnyjvfk5ncIvg56CHQBYoY3ZiMuS9k1N5khXDtafUYtpmI
         CUH270Shp+HYSHlAvYd9rMqErf2aAQLpkGchuUpp5H0RCrrYX0PgxzhnB2Doytr9WJaY
         J4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCV7rAzzArbto/gXO3TvqTnzWy5gAjR3dUvu/HTMYT5limokluQP3aqo1CmSabFTSaArwwQJwFRcZWg2oi6Lrp/oHA9x65EvcwoOhBo=
X-Gm-Message-State: AOJu0Yy/EcPLGD5nNkitNIqDi2FlQ5YGpIGYStGe5gBFoZMJAyPd+w9W
	GO9DlUWBgoyIT+Hu7jgkYrz40jLgmZdQmQ5H1VOnwl1/BGae+r2Z8hbSE2isQH1sxnvV2GOhPUy
	ql5fLbI0HVQnBeY9G3ACW5VTreDhgguxTRs9MeT0BXsD5jwM/rJXSwpINK2Xs
X-Received: by 2002:a17:90a:fa06:b0:2ac:d9f:de9b with SMTP id cm6-20020a17090afa0600b002ac0d9fde9bmr3003764pjb.45.1713973768967;
        Wed, 24 Apr 2024 08:49:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+HDBpNiZnNg1utwK3fYvcD12Jg84gdzbHjuvxcA4YpTBSLcIh3eSP8ueBc9z856iMhGHxCA==
X-Received: by 2002:a17:90a:fa06:b0:2ac:d9f:de9b with SMTP id cm6-20020a17090afa0600b002ac0d9fde9bmr3003733pjb.45.1713973768368;
        Wed, 24 Apr 2024 08:49:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090ad68600b002a20c0dcebbsm11508653pju.31.2024.04.24.08.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 08:49:28 -0700 (PDT)
Date: Wed, 24 Apr 2024 23:49:23 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes staged-20240418
Message-ID: <20240424154923.fo526va22bplhaug@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240423220656.4994-1-anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423220656.4994-1-anand.jain@oracle.com>

On Wed, Apr 24, 2024 at 06:06:43AM +0800, Anand Jain wrote:
> (I just realized that the previous attempt to send this PR failed. Resending it now.)
> 
> Zorro,
> 
> Several of the btrfs test cases were failing due to a change in the golden
> output. The commits here fix them. These patches are on top of the last PR
> branch staged-20240414.

Hi Anand,

Thanks for working on this! Now I've merged all 12 patches with below changes:

I added your RVB to:
  fstests: btrfs: use _btrfs for 'subvolume snapshot' command
due to I trust you've reviewed it as you'd like to push it.

Then I reviewed those 4 patches from you (refer to mail list):
  generic: move btrfs clone device testcase to the generic group
  common/verity: fix btrfs-corrupt-block -v option
  btrfs/290: fix btrfs_corrupt_block options
  common/btrfs: refactor _require_btrfs_corrupt_block to check option

and merged these 4 patches with the review points (to save time).

Please check the "patches-in-queue" branch of upstream fstests. If you
(or other btrfs folks) feel anything wrong, feel free to tell me. If
no more changes are needed, you'll see them in next release :)

Thanks,
Zorro

> 
> Thank you.
> 
> The following changes since commit 943bbbc1ce0a3f8af862a7f9f11ecec00146edfe:
> 
>   btrfs: remove useless comments (2024-04-14 08:38:14 +0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/asj/fstests.git staged-20240418
> 
> for you to fetch changes up to 6fc18c4142c9470013dae598cdc29a2f67887a94:
> 
>   fstests: btrfs: use _btrfs for 'subvolume snapshot' command (2024-04-18 20:16:21 +0800)
> 
> ----------------------------------------------------------------
> Qu Wenruo (2):
>       fstests: btrfs: rename _run_btrfs_util_prog to _btrfs
>       fstests: btrfs: use _btrfs for 'subvolume snapshot' command
> 
>  common/btrfs        | 15 ++++++++-------
>  tests/btrfs/001     |  2 +-
>  tests/btrfs/001.out |  1 -
>  tests/btrfs/004     |  2 +-
>  tests/btrfs/007     |  6 +++---
>  tests/btrfs/011     | 10 +++++-----
>  tests/btrfs/017     |  6 +++---
>  tests/btrfs/022     |  6 +++---
>  tests/btrfs/025     | 20 ++++++++++----------
>  tests/btrfs/028     |  2 +-
>  tests/btrfs/030     | 12 ++++++------
>  tests/btrfs/034     | 12 ++++++------
>  tests/btrfs/038     | 20 ++++++++++----------
>  tests/btrfs/039     | 12 ++++++------
>  tests/btrfs/040     | 12 ++++++------
>  tests/btrfs/041     |  2 +-
>  tests/btrfs/042     | 10 +++++-----
>  tests/btrfs/043     | 12 ++++++------
>  tests/btrfs/044     | 12 ++++++------
>  tests/btrfs/045     | 12 ++++++------
>  tests/btrfs/046     | 14 +++++++-------
>  tests/btrfs/048     | 16 ++++++++--------
>  tests/btrfs/050     |  6 +++---
>  tests/btrfs/051     |  6 +++---
>  tests/btrfs/052     |  2 +-
>  tests/btrfs/053     | 12 ++++++------
>  tests/btrfs/054     | 18 +++++++++---------
>  tests/btrfs/057     |  6 +++---
>  tests/btrfs/058     |  4 ++--
>  tests/btrfs/077     | 12 ++++++------
>  tests/btrfs/080     |  2 +-
>  tests/btrfs/083     | 12 ++++++------
>  tests/btrfs/084     | 12 ++++++------
>  tests/btrfs/085     |  4 ++--
>  tests/btrfs/087     | 12 ++++++------
>  tests/btrfs/090     |  2 +-
>  tests/btrfs/091     |  8 ++++----
>  tests/btrfs/092     | 12 ++++++------
>  tests/btrfs/094     | 12 ++++++------
>  tests/btrfs/097     | 12 ++++++------
>  tests/btrfs/099     |  4 ++--
>  tests/btrfs/100     |  6 +++---
>  tests/btrfs/101     |  6 +++---
>  tests/btrfs/104     | 10 +++++-----
>  tests/btrfs/105     | 14 +++++++-------
>  tests/btrfs/108     |  6 +++---
>  tests/btrfs/109     |  6 +++---
>  tests/btrfs/110     | 16 ++++++++--------
>  tests/btrfs/111     | 20 ++++++++++----------
>  tests/btrfs/117     | 18 +++++++++---------
>  tests/btrfs/118     |  8 ++++----
>  tests/btrfs/119     |  6 +++---
>  tests/btrfs/120     |  4 ++--
>  tests/btrfs/121     |  2 +-
>  tests/btrfs/122     | 10 +++++-----
>  tests/btrfs/123     |  2 +-
>  tests/btrfs/124     | 10 +++++-----
>  tests/btrfs/125     | 18 +++++++++---------
>  tests/btrfs/126     |  4 ++--
>  tests/btrfs/127     | 12 ++++++------
>  tests/btrfs/128     | 12 ++++++------
>  tests/btrfs/129     | 12 ++++++------
>  tests/btrfs/130     |  2 +-
>  tests/btrfs/139     |  6 +++---
>  tests/btrfs/152     | 14 ++++++--------
>  tests/btrfs/152.out |  2 --
>  tests/btrfs/153     |  4 ++--
>  tests/btrfs/161     |  4 ++--
>  tests/btrfs/162     |  6 +++---
>  tests/btrfs/163     | 12 ++++++------
>  tests/btrfs/164     | 12 ++++++------
>  tests/btrfs/166     |  2 +-
>  tests/btrfs/167     |  2 +-
>  tests/btrfs/168     |  6 ++----
>  tests/btrfs/168.out |  2 --
>  tests/btrfs/169     |  6 ++----
>  tests/btrfs/169.out |  2 --
>  tests/btrfs/170     |  3 +--
>  tests/btrfs/170.out |  1 -
>  tests/btrfs/187     |  6 ++----
>  tests/btrfs/187.out |  2 --
>  tests/btrfs/188     |  6 ++----
>  tests/btrfs/188.out |  2 --
>  tests/btrfs/189     |  6 ++----
>  tests/btrfs/189.out |  2 --
>  tests/btrfs/191     |  6 ++----
>  tests/btrfs/191.out |  2 --
>  tests/btrfs/200     |  6 ++----
>  tests/btrfs/200.out |  2 --
>  tests/btrfs/202     |  3 +--
>  tests/btrfs/202.out |  1 -
>  tests/btrfs/203     |  6 ++----
>  tests/btrfs/203.out |  2 --
>  tests/btrfs/218     |  2 +-
>  tests/btrfs/226     |  3 +--
>  tests/btrfs/226.out |  1 -
>  tests/btrfs/272     | 14 +++++++-------
>  tests/btrfs/273     |  6 +++---
>  tests/btrfs/276     |  2 +-
>  tests/btrfs/276.out |  1 -
>  tests/btrfs/278     | 14 +++++++-------
>  tests/btrfs/280     |  2 +-
>  tests/btrfs/280.out |  1 -
>  tests/btrfs/281     |  3 +--
>  tests/btrfs/281.out |  1 -
>  tests/btrfs/283     |  3 +--
>  tests/btrfs/283.out |  1 -
>  tests/btrfs/287     |  6 ++----
>  tests/btrfs/287.out |  2 --
>  tests/btrfs/293     |  4 ++--
>  tests/btrfs/293.out |  2 --
>  tests/btrfs/300     |  2 +-
>  tests/btrfs/300.out |  1 -
>  tests/btrfs/302     |  3 +--
>  tests/btrfs/302.out |  1 -
>  tests/btrfs/314     |  3 +--
>  tests/btrfs/314.out |  2 --
>  tests/btrfs/320     | 16 ++++++++--------
>  118 files changed, 375 insertions(+), 435 deletions(-)
> 


