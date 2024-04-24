Return-Path: <linux-btrfs+bounces-4511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195B88B0590
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 11:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F9B283FEC
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DF3158D71;
	Wed, 24 Apr 2024 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlUYXtPf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42DD29E
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949973; cv=none; b=aAbOxV8brSJiyVp3lXv+JKEoVux16jy4E5/aG+75ZXA3HzySXFlQye6qjuYtOuq73E/Fn2XYuNNWkFt+LtS2u69MXkQmywhSTwij3z1IitGcqCsWY6U1M1ESYsDbI2UDQFxOjPXj+rJlvI3WOzOjQN3jkEMpJkov/hrMHtFhcYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949973; c=relaxed/simple;
	bh=jV48hhl6PEhyr/6wHOChojTMe6HRPDNOOYzcYU7Cy1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eggJMyUbMiC06v68jLHel/7YxrbjtqJ6wZbO5AWgHBLE2Bd4Qn0jR9hIiff1DG04Q7Knf9Typgm9T2LLcGPXmrMcFuKQF9htzLS833r3n3tM6xjojuNsI/EclIObcAsj1od1iF2jIKSaUApgzr95ROIaehYQQlLiKDrLXQp5mHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlUYXtPf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713949970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUS+agYprfM+Bpal/Up1Af2H7C8tQy3CjTwX1w/sipM=;
	b=JlUYXtPfjmgJej88q0O8p1IDUUDn91hhd9sca/WJqh1knxFt5HHyRgivL8Mejgrs/+W3fY
	aBEY9w+S3+3RqSQ+ZV29tvtv6MuaBtLGWIklOWFX2bpOCJHoGfHyaSoEnKAoxjqL8Amszz
	KQj0AjfLwuUMuOTjoyyRS1x5Fa1MkkA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-9J9ExlU8PlO5yD-2EFugyw-1; Wed, 24 Apr 2024 05:12:49 -0400
X-MC-Unique: 9J9ExlU8PlO5yD-2EFugyw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5aa319be326so11511218eaf.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 02:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713949968; x=1714554768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUS+agYprfM+Bpal/Up1Af2H7C8tQy3CjTwX1w/sipM=;
        b=cDLI6kLZ4Pcv4fY5B4CzYaMQezQJqlYnjbZxTi4sKZ76X4Fhe2U1xXgIVBabOwKL1C
         IGEJX08bHklTd7TtEX4mWPkP5yROKXK3t92wTGdYqpvayceBgoHg6M3ZrMV9ijUUE/US
         gluyGQVCl7O0iHgewuRyWu9/xMhpdBK2mvxQpfjrhixCNhnzlMU61nJj5KmpfO5knEp2
         fm7eAjZVKxUBm2G72VuWINBp6sdfGiR/eAjta9sRI6ywW1G2GRZuasd2XcJXANAsNEWe
         UwMIBgXefFYrFzggxqvjx2Ra/8QA6F1bRTTaQqV+S8mDy2+fHbLsJu9n/MI17yWD3K6t
         h1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWqubLzdJEqdQLsdnQv3lehQyBy08idEs9l9P9lhi+A2WvMHhn4NUy4sgXnmXoM9DKZxofbl7o16wk3swR/UESz0pakk3CT/8MhDBc=
X-Gm-Message-State: AOJu0YxnKzjQS+RO5rTmKu5uRv1Ta0PVcu2I/RMwJMLpHVO+yf5mGfJv
	aeMCiWXeTPvUSsdVgOjrf/+ZoylA1MMmxL5E9UA5nbjSyFt8IyF9Yd//we3Og5kWgrwIp/+hkRi
	IydHyoQcRWLnETcXrr9THte0Fp10HYosH0RW4ptP6cZQiOvCR4gKjkCvvNSmk
X-Received: by 2002:a05:6870:5309:b0:229:e574:9c82 with SMTP id j9-20020a056870530900b00229e5749c82mr1945349oan.3.1713949968324;
        Wed, 24 Apr 2024 02:12:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd1StJDHzP4IfXK0Ev0mA1jSpYOsoNXzvQrxuNXNYZRnn+npcx56WL/RIKAKUAhg6OIczkcg==
X-Received: by 2002:a05:6870:5309:b0:229:e574:9c82 with SMTP id j9-20020a056870530900b00229e5749c82mr1945319oan.3.1713949967798;
        Wed, 24 Apr 2024 02:12:47 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ka4-20020a056a00938400b006f3aa6a03dbsm460983pfb.127.2024.04.24.02.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:12:47 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:12:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes staged-20240418
Message-ID: <20240424091243.72n37q2xlwf5hxky@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

I found lots of patches in this branch doesn't have RVB. That's not safe, if
we always do things like that. We need one single peer review at least, that
requirement is low enough I think.

Better to ping btrfs-list or fstests-list or particular reviewers to get
review, if some patches missed RVB.

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


