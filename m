Return-Path: <linux-btrfs+bounces-7373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B51D95A3E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 19:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE1C1C22BA7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 17:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99971B2ECC;
	Wed, 21 Aug 2024 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UE0U/P61"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C71B2EC5
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261375; cv=none; b=dE+IJvDLydsA9EDRXaJEHG7GRonaGlWLo5jT+8MuzW/KkKUjc2qvovu1EKNI8qJnKQW/1c/lkaCbns1x3nmBPdQw1NPnt7q+mWDGgn3O8QJO7GvWPj+YKHzHrHOI7LguQKcRAL5eY3WroaDS0QrR37J2PN72tGbSRwO7idVTOJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261375; c=relaxed/simple;
	bh=ypnw+NhVeNw0sTxUkwLuQh7W6s4icu+G8LXvjymCP0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4LZkJ+vsxKk32SyVUSyJvgRY522ch8YCM3kWxAXnw3DzE8Wd4H8qYXcB2e2WUrtR4K2fMQ73cUOFontoSNebs2P4FtaysKd/GYWLqu0uEotk2hnKUA7c1BRQGyVuhZDvLBK7P8OWoDnWqMbW3CXVvPTcdWje2Z3I6usMMVLs8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=UE0U/P61; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso7709243276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724261373; x=1724866173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jSjCDZXDYzPKWrv1wdANSmmjh7cWn6ZDaSn4/S94aoE=;
        b=UE0U/P61TWMEcSWwpa5U0/iNFQlb1YD+32ZPKyvX4xChTacCGuiqeNWDH2sdHOtgee
         bL84kcSS4J05HggqEAztQIdZ6N1Rt4DGNjCbBhozZY6/qO/l1Y3rPIbSioLm2AhBLZ8g
         1P7wtpPRLhFe79pBYnqkowKIrhu/GTxgbmb+kevrSibLexeTMFLOcWiRR7MW4TiDlxUu
         ViLWMXCmTZPqJRL85HW7wJUQ4KmK/e0soK/VMNim09ULZlU/DbLysPLqp9wAht/LTXce
         pB+9C+opCh7mFriGa3JCf/apIHr51bwfw9MOcc5JJaCxhn00OAAMcis813prnsVJQJBX
         GNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724261373; x=1724866173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSjCDZXDYzPKWrv1wdANSmmjh7cWn6ZDaSn4/S94aoE=;
        b=Io0+vtQCPVRanFEIzdsuVO0v6ZjRcabm3n40Nom1qGbGfMdmkadUtrrATZ/YjSS6Kk
         WHT6WDBMeLBMMc7ZSxE4L+N4coX4Ui2mQTZtMhTjLogLD74MGMr+7mdP49iBJpLnXeZX
         LnHmij5Onkd5mSM+wKm/yGadCu6qjyjNXjJ3C/BAKHuVUA9A7ICK77hU+g/aKTHrVSB5
         tVgBXoLD2nlJvZZ8Iu8kbAvPvhtSE/enAiuGizAOUr8gCRcR8Kmmn/VoQ0yG7+zgSilQ
         3slt9Tv7mDrH3uqBAIXZirE373YibdZBK/ma+xA0JWBDK24A0sb3I6+aPv3YgwEQg/Pa
         Uj0g==
X-Gm-Message-State: AOJu0YxjsShDoK+fBcVaRGkWglPCw6uKkGa0+jfQ4HUzIQQrZKAagTM/
	rhej/K6wGZzdt7DU64yzPoKOFZ3VRlH1gJzs2anQXllftayM52NGSCBy7zZys7E=
X-Google-Smtp-Source: AGHT+IHGMuPr3BeFzWityp5Ky0GZPqEg+d0PI/+CFQUcZ7cy97d25h616CpZTwA5U8kgQWlEufNE/g==
X-Received: by 2002:a05:6902:118d:b0:e11:56a6:12ba with SMTP id 3f1490d57ef6-e166548faf0mr4089407276.34.1724261373239;
        Wed, 21 Aug 2024 10:29:33 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1172007082sm3094552276.40.2024.08.21.10.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:29:32 -0700 (PDT)
Date: Wed, 21 Aug 2024 13:29:32 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] btrfs: initialize last_extent_end to fix
 -Wmaybe-uninitialized warning in extent_fiemap()
Message-ID: <20240821172932.GE1998418@perftesting>
References: <20240820233132.24652-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820233132.24652-1-dsterba@suse.com>

On Wed, Aug 21, 2024 at 01:31:32AM +0200, David Sterba wrote:
> There's a warning (probably on some older compiler version):
> 
> fs/btrfs/fiemap.c: warning: 'last_extent_end' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 822:19
> 
> Initialize the variable to 0 although it's not necessary as it's either
> properly set or not used after an error. The called function is in the
> same file so this is a false alert but we want to fix all
> -Wmaybe-uninitialized reports.
> 
> Link: https://lore.kernel.org/all/20240819070639.2558629-1-geert@linux-m68k.org/
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

