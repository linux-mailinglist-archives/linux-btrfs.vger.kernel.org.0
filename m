Return-Path: <linux-btrfs+bounces-5313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 477C98D1444
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 08:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D93B21247
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 06:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBA14F207;
	Tue, 28 May 2024 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkE6UCCe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B6B1361
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877043; cv=none; b=eJLlVi0Ubj2MMZHp4dFeTc8MRpGOQi9mo1ewEGn4IMyzNCdp5PeQYKBmNIv581Ie78KPXvvO5HwT6bKaY5noENjr7ES5Z7bFD9PvJO45QZC/JyzrYLUdf9vnJe9JJa+7E6bHahLT0wM0/YztfCv6VGdQJbVl9O50feuw9etCoks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877043; c=relaxed/simple;
	bh=LwHaGWHm8ws61deTkYQTxs5OmzoFLMBMOIZ9l285zWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxoW9MiVzbwdn1gHiU5Wk3BlImWz/iwnQLz35lWAonU4exx7VAHbraeVo+mrc4Q7BlPue7uhpHVrl7HF7R7vSKiy1x6BFENptOiFEgA+ZuXTcK4kJ0z2bIaniYFnfe0qMtp9/LtIjA86VD7Ljb4kYJXv7hgl8qJaHUV/PEghYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkE6UCCe; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-523b20e2615so499733e87.1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2024 23:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716877040; x=1717481840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwHaGWHm8ws61deTkYQTxs5OmzoFLMBMOIZ9l285zWY=;
        b=kkE6UCCe30We4etojD84Ii7y6WU53DO7AOthNV8crPtnN2gjw/xp0h6aKeqvnENfev
         fR2lblEpxZ6biEmEGRAn3hWb1ttzk3p8+X/iRBLtJ/kIj1bju/aZAVAREM++3GFgXlHS
         PkGf2rBLK6ohMMhSiAN+q+cvOZVMb3z0gHbfKjGJ6vFTm8glP6p9hWG94EC8CxgmbOHS
         pSennBnN8Ox8zrfr5vYqz95bbMZxidfrr/YsDvkbp6ynP66V3lYOQuuIVypdSQqp0x5k
         Z1+e+2vm+FvDrg74wFe9lGThqgkGGF6EE20AdnICe8GFP6JhP8CvYLpHbrXxGcLI0Lui
         DTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716877040; x=1717481840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwHaGWHm8ws61deTkYQTxs5OmzoFLMBMOIZ9l285zWY=;
        b=HRqugn/YqPRhgYnRh+KGVQmHLPEXwmlwBOYk+YQvW8zueQYBGRMYsrqyC2OqQChddy
         gMKNJeYIPBlaI68q6vR5qnZ5jhG9/pI1wrcdR2gBXAItsxpzUhrTPgoLpGA9Cuak5Ek6
         RB7kOXCfMmG0ZrAEAwKUY0E47LGzfJr2VUAyCyEnrH2YulvpPm3nRSbY+cRfNmKgjIL5
         V6dARKAyii+bWkpkssN/aFX1/1LT8N/GSinXBoEGjz3Esk0ui1xLUpPzkfZqWEEkUEit
         50Ld4BbxZdruPVu/zDoQ+ALf2mLBWmrMIfUCPqcaDUxNG/KLhh9CTHGCjnMt1P/1OJPI
         IuFg==
X-Gm-Message-State: AOJu0YzfRRhAGb49gQsG7dDa56V9scfwFlOEpUlJoGTZWu9LUEGif77E
	6kSk6IwdJUrbbPhTqvPMdqy1lPxUfNvN2Qrk49XTQTwVZ9bECUmvmIMUCbZtL17xGQfRuUn2ANR
	WLCsn2MyJIzjuAX9ricoZFhS+p1s=
X-Google-Smtp-Source: AGHT+IG2jqaEubXLA2nNJk+sSa6EyMiUidp1ftSl2HEry2eQuP/z5lPs7o5Hx+BnQZDk+WY1L6Jxl9WEmqwLbg8bSDU=
X-Received: by 2002:a05:6512:3ca0:b0:523:8c7a:5f7 with SMTP id
 2adb3069b0e04-5296410a4abmr8364023e87.6.1716877039643; Mon, 27 May 2024
 23:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527101334.207228-1-sunjunchao2870@gmail.com> <20240527152707.GA8631@twin.jikos.cz>
In-Reply-To: <20240527152707.GA8631@twin.jikos.cz>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Tue, 28 May 2024 14:17:07 +0800
Message-ID: <CAHB1NagHxAfoJ5h7-HgcQUkHib1sefafNb6n-_Pm5v=c3aJQMA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: use kmem cache to alloc struct btrfs_qgroup_extent_record
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David Sterba <dsterba@suse.cz> =E4=BA=8E2024=E5=B9=B45=E6=9C=8827=E6=97=A5=
=E5=91=A8=E4=B8=80 23:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, May 27, 2024 at 06:13:34PM +0800, Junchao Sun wrote:
> > Fixes a todo in qgroup code by utilizing kmem cache to accelerate
> > the allocation of struct btrfs_qgroup_extent_record.
>
> The TODO is almost 9 years old so it should be evaluated if it's
> applicable.
>
> > This patch has passed the check -g qgroup tests using xfstests.
>
>
> > Changing kmalloc to kmem_cache should be justified and explained why
> > it's done. I'm not sure we need it given that it's been working fine so
> > far. Also the quotas can be enabled or disabled during a single mount
> > it's not necessary to create the dedicated kmem cache and leave it
> > unused if quotas are disabled. Here using the generic slab is
> > convenient.
It's reasonable. I will send a patch to delete the todo line.
>
> If you think there is a reason to use kmem cache please let us know.
> Otherwise it would be better to delete the TODO line.

