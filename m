Return-Path: <linux-btrfs+bounces-17115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC6DB95125
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 10:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECCB1903701
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF8F31D362;
	Tue, 23 Sep 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3Hy0Nl+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B03A4A0C
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617543; cv=none; b=MFEDjkJdhb+cTyPKvegGWZLfEOGbc5zkE1kh1JCpyFQ+Dl9CeUSZ7fIVgo/ICmD3Z4GwKVB1P8A0m7r+jetofbSOQaxbR80SyKkPXrBE3mO0DJQdQ9T9TuOl5LedABUmPMf1cCSYldqLvmpH5dSfhDYxAxrTPhA3HTMIvz80QR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617543; c=relaxed/simple;
	bh=qLe9dVM58MyzNnB136YatYk+IFroPuB9CJJShiFa4Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSJl8rHtBjORAe3rCXlBEKJ/fNZbyzp0d84MdlSzhvR+eAq5UxZl5KE2x1ZYB2veEa528BePE4+lbfZFsUaRIScxFDdgZ/Fo4VPkKY+ZaZbI5jV55N24Rr1vSQ/lW/7Y4qZeKzluSvA3LH+8HpnxBEghAnMxxP4uF0950ngc9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W3Hy0Nl+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee12332f3dso5392565f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758617539; x=1759222339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2l21j2sqVc6rfybicY874C+OlttyYtxVjGIkev4Hmc=;
        b=W3Hy0Nl+1HUkFavlYufhwa95o2PtYvK7AaXhE0A/b6KNA6YWwGb0M/g3xmyj2zBYsv
         anTfb0tq6bQ7jc5xKMfNIcYZc6OSe/EfaOVHMHyOVvXO/oYUBciNoIDfaTcVsp3mp3cK
         kyveBb99i9J/ipdO6WCK6//LkEQZ+5o+GmoLILbNzvH+BkYSMmX8iOImLZpaYyID1R7r
         itFMJH+UA2P7hZY8oEjL08GHl43qGim/tKwAfV1bHflkFrcyCDiAk8a3VgZvpwsCZOp+
         S2AB6uK065iT2FJMHrwRj+9w3cNKax3mt8/zSf2uHXVcokv5Mgv0iuOuf0gVscgPXAAH
         +s5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617539; x=1759222339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2l21j2sqVc6rfybicY874C+OlttyYtxVjGIkev4Hmc=;
        b=tDjUHqOrQoFy4iUgqT/4kjePaSQjFuV8l2h1Tu1K2XTss6uemrgM3I0C9eAKk0Yhv9
         dHH7L1FEg4BKjk7zsZ4J+ErNyaKQ8JmwSoTvo68PLJv9uHqregbLye23TdkVTD14fX4K
         qA+q9nZ8XUTDSxXIQXZh26yrcl3LYUWaqwTJ0I6hspIhInCX0UImxAKb5q2qAJpyz2Rp
         038CrwboG6t/+dpLcOOMZ11N8EmRwchIGPZo/EQ/uGe7d0CzAQLmiBCCSDmkhFOycTHf
         p0/fBUsXwrLIlk3+qPKX5RDW1P/bCrobNnja1Ni1m/mjqugDM1WlKOn/lxUrbZYx8B2g
         ZtSw==
X-Gm-Message-State: AOJu0YxknFRx+MNscukb/gcEMHO3J+HQ7JeGyV23ca9wnHu1Nt4VGUZN
	9Ylk5xc2n3PyRdJzNsRZWSuNuf53y2pcA6T4xV3K5d50K/OPTnzLGyxjNzBzI35UrfU=
X-Gm-Gg: ASbGncucPVU2guPGLPKgLMCh9tDtMHYePaOVsc7D/u2h7wlLKchp2HfMcIi5Xj1OOTE
	nHWZFiQYRF5OctQkzrnUVksBNudsm0V5+Hh3+CTWXXlJVbAIV7zZoEW75jqlAMzNwMXm8xKD3LJ
	CAEcjK+A5mli1Q/nY6O4CqvVQ55BDhX0Sf0SpNuhbiw6GKC4vRKZDGWyyP640pZFfayeXZSpGes
	5gRRVW0mXAuyScG49fBlhxwwjJZ3Xr77in9E6/uP1h4RwCMqjkamN669xwwbFadQmt5OBD5lng4
	APekBu/abmbQy7EAiCh6w3vqpwv5C1kkp5AbOXdB5tie3KBkyTzf3eg6zC52aA2YRNlHVjzRdrz
	o+R7ZaheZ90qdkt5vd9Qdh8eGnEAW
X-Google-Smtp-Source: AGHT+IGiGfVhyGn+NA2nrbn0igxAWo0a2+xvvzVsV3Xcy8zmRrfNcB+J3rx9qgFYgReE7bp7joUcXQ==
X-Received: by 2002:a05:6000:612:b0:3ea:e0fd:28ea with SMTP id ffacd0b85a97d-405ca95a386mr1463562f8f.39.1758617539392;
        Tue, 23 Sep 2025 01:52:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f0aac439sm267020975e9.5.2025.09.23.01.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:52:19 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:52:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: ref-verify: handle damaged extent root tree
Message-ID: <aNJfvxj0anEnk9Dm@stanley.mountain>
References: <20250915063747.39796-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915063747.39796-1-dsterba@suse.com>

On Mon, Sep 15, 2025 at 08:37:47AM +0200, David Sterba wrote:
> Syzbot hits a problem with enabled ref-verify, ignorebadroots and a
> fuzzed/damaged extent tree. There's no fallback option like in other
> places that can deal with it so disable the whole ref-verify as it is
> just a debugging feature.
> 
> Reported-by: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ref-verify.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> index 3871c3a6c743b5..9f1858b42c0e21 100644
> --- a/fs/btrfs/ref-verify.c
> +++ b/fs/btrfs/ref-verify.c
> @@ -980,11 +980,18 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
>  	if (!btrfs_test_opt(fs_info, REF_VERIFY))
>  		return 0;
>  
> +	extent_root = btrfs_extent_root(fs_info, 0);
> +	/* If the extent tree is damaged we cannot ignore it (IGNOREBADROOTS). */
> +	if (IS_ERR(extent_root)) {
> +		btrfs_warn(fs_info, "ref-verify: extent tree not available, disabling");
> +		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
> +		return 0;
> +	}


I saw that someone tested a patch for this bug but it doesn't show the
patch itself...

https://lore.kernel.org/all/0000000000004417f5062141fe65@google.com/

Smatch says that btrfs_extent_root() can't return error pointers.  I
would have expected an error pointer dereference to crash in
btrfs_comp_cpu_keys().  The pointer in the bug report
0xdffffc0000000003 is not an error pointer.  What am I missing?

regards,
dan carpenter


