Return-Path: <linux-btrfs+bounces-13626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59518AA7325
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 15:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8614E0D8C
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA0D254AEE;
	Fri,  2 May 2025 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SAuSZMxB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3940253938
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191766; cv=none; b=G2a8sZAICVgB73G9MQuiLWdN3qBLBZljMkQHJyUBnYJlhPRMVmXYO27pY7MQqRoFMUj0ibV2KHcXo//IbR9IkWuRNob6vD3VqOGzoNwZQoxPznmbhJZ85iYNNhutkyOEIxwfvPS5J0IJVQVbmWprMJTMXbEQdKlZUbguXV0DFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191766; c=relaxed/simple;
	bh=+XGT/vaeCnbtMGHjBNo2CoDuaNsktBmNEgjoDyDTM1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9pCwMa+XV350kWB0v3sO8ajoBh2msdpNGgMuERpeCx/XFyYGbmo8uTBqhtzfF8XLSnMXN8MqLqhNYB7ajtyqZTpbK/F4K6aowYJH4PNSYu1mJmydEVqJdfhx3Wl3RcsZpj9JzwZrFnmvJKf8udI30y2AiVzUqvbzGbcZvDHjiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SAuSZMxB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso319624766b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 02 May 2025 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746191760; x=1746796560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8CnM46We8JcvZEGDTQ6iBs4QLy+RQrWergy/dT2Roog=;
        b=SAuSZMxBthaaUbTi7OHKrPMlwD37oF1dvFjN0G1xxo4Nuh6Li/BcCcQhA6xLX4lR2x
         siv0MkAju7ETyuC/d7QTFJNQ0GILWmWxNGV+jr4cm9EhJ6j5xsHCqzBQjI//TuShPcR6
         PD3k0RGEGTrioPDMQDv2MWosEGXKrwfNPiPhmhitDfH59x6EE9IoUkiisowkSe+9r2do
         lHfWXO4RmXeHtGh1Qk0wA09CwUOPytNEFmj579kCXmTbTU9Dqm31Shhvk24vX7K1BkaP
         RdJsqPM3bLnIHbUacV6hRnF+/ONoSmAqh9lLk6ZANsTMCm4b9jbVcAgKqGYjq80DvP92
         6r/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746191760; x=1746796560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CnM46We8JcvZEGDTQ6iBs4QLy+RQrWergy/dT2Roog=;
        b=alZn/aQQms9r1Y/UExN9TyFkmQamf+6Fo1XZN00m03E9b29i5XYoruy6TuzBT7tdir
         GIhZ8uNbdIm1Opl6dUD0zMKv214nzeOhpjUnJtCbK58nHiimIiI8ijPC1KbmfxDfHQdj
         a0KzKr0Q5GMBW4v562vXxqWV3wbaB328kaddPkmg9pB9TGmJMaT1KbFBRZ8Dlz4O/JsL
         i2syIVDh2aLs1rI1f3H9msug3KkduIEjURR6KA89H85WPbiICTnWjJ/qRArZcMF7mAub
         j5eGbeLPsuSxFRCHaQ+GFy8hei8h6Wu0Q7ITCRHg4+D1wKAEShM5O+wQ0Vls6/zvlNlu
         qPQQ==
X-Gm-Message-State: AOJu0Yzy9scO+w5q5A87IXDzRjvfiUeygmWkhKIJEYijNHtorORXumVt
	CQBOUHiY08ptFkmvwwkUeVOYNjzLwte11JHFyjdnZbKIJWVIYks6LB3ACaNA02ZWY5LxaZ3iAJL
	UelQ2D0OTHLrQXryhZ31WnvAKJyqHSJylB2i+Z1Q4uWLGFbzr
X-Gm-Gg: ASbGncvEESZ1LjnkmbjYMs+aQHYq2QGUYrO0q7u7YfA5dedyuWmTUAUS2F+VQPigcLp
	R/LGNXi/7PjPF+E0UeWqBtL/PwLtYBMXqYQEUxDYfEMODahnp2DUj7IWFqgTFf0gQFTaeiGjR16
	smfvadUO3+NKyQplMpsUvlwoV40wDN84w=
X-Google-Smtp-Source: AGHT+IE4NcJs7SXUQHd1Rw3lwRPpGiQ824p/PFvDMtH8lK2DbkwVf66AN/Dxr7DRfr/WYXvHl19RZ+SoYcxkhLqC3Og=
X-Received: by 2002:a17:907:c28f:b0:acb:5583:6fe4 with SMTP id
 a640c23a62f3a-ad17ad3b23dmr291029166b.6.1746191760123; Fri, 02 May 2025
 06:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746031378.git.dsterba@suse.com>
In-Reply-To: <cover.1746031378.git.dsterba@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 2 May 2025 15:15:49 +0200
X-Gm-Features: ATxdqUHeMelZ8zYQsXPy_5YrsF5T45pCkoVrdJDLQP9Sl3i1e9Rx6bDyIhT9Hho
Message-ID: <CAPjX3FcAA=2cR4WqxFUOXZ4zYHS8hS75-ii0HPKQddgwhtr=Vg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Transaction aborts in free-space-tree.c
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Apr 2025 at 18:45, David Sterba <dsterba@suse.com> wrote:
>
> Fix the transaction abort pattern in free-space-tree, it's been there
> from the beginning and not conforming to the pattern we use elsewhere.
>
> David Sterba (4):
>   btrfs: move transaction aborts to the error site in
>     convert_free_space_to_bitmaps()
>   btrfs: move transaction aborts to the error site in
>     convert_free_space_to_extents()
>   btrfs: move transaction aborts to the error site in
>     remove_from_free_space_tree()
>   btrfs: move transaction aborts to the error site in
>     add_to_free_space_tree()
>
>  fs/btrfs/free-space-tree.c | 48 +++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 16 deletions(-)

This looks like unnecessary duplicating the code. Shall we rather go
the other way around?

>
> --
> 2.49.0
>
>

