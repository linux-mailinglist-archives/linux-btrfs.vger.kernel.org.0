Return-Path: <linux-btrfs+bounces-12389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F28A67A59
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 18:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA58616DAC6
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA3211A1D;
	Tue, 18 Mar 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LSDIQkAv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2131E5B8C
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317656; cv=none; b=J5T8ICySajJXtI/W9kqMmY7Ib6yMb/ZyCX567vm8/g04EoHOcTA5ALwZfWsE2/1F/aqdg7zIz2kyXU63BAAucBD6KDRTrLLt2NwDn6VT1JsqLP4OsHem00wu0q+DazQa62g5eDojrAw5bBhbvT5HevLdQDXoPCnEgd9cQGTYu74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317656; c=relaxed/simple;
	bh=LlLg6jwde9CUgeBq+7ayo6eExyGhvmbmW/yF4J6CMCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+zc1m3NXzywc6fPAYOakpSFoFbg59qSOfJo5/yggCkqVJ4YZhUomPT5zljCAfO7tKquRI41kSSQkN6egQGADQuRGkzQEmxCoHw6LoIvUR4F+FObPZ5PHSzGIJLwWGWZuYLJOChzwSFdfRI0IuU+ruEcktpW8HygCEIFP4HFTv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LSDIQkAv; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac3b12e8518so13100866b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742317652; x=1742922452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LlLg6jwde9CUgeBq+7ayo6eExyGhvmbmW/yF4J6CMCc=;
        b=LSDIQkAvxLviRWA5DUsNaFIJFFbUQxn/gioLwGWLiz1QUP01si3YnJx5inbk94/71A
         er2NC0Le0UKbo9qSFHuypRSR35SUVuYEZULdyKebFeDskj28141E1ZH5vFKseHXYfFVE
         I8nImRcfIxYWtMkHnM/u0kMjvw1qayklTTXyUkvl4nDgd0fpkdHYiy5SK5P3c0Y2kMDo
         5sgODP0jH+RX0Oc8oaSL3FY9ksogltNpNa/6B1SV6IKBT7AD0vUOehzmk76yyd7UJCbJ
         D9lpq035SMmZ82sR6ALkqLdPWZXR0YBrrXegkFKLHUHrcev5bsNuLNCzHi0Q3SVnnx86
         u+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742317652; x=1742922452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlLg6jwde9CUgeBq+7ayo6eExyGhvmbmW/yF4J6CMCc=;
        b=dJe0P4tFGEVYx/Tuf91OLiIEx2/4iAIJfdKhaOOd6zMuOWrAjFOdkVPQTysUUQCOrF
         d1UbdPwBbb/2pm1RYgQwJx+FeCiURREopzpKL7+g+IDqhMKR6jytbqx0anpH1Ec7tJ2O
         Y1PrfOf9DtQsKHjZrPAkbRuAml7A7C3ndPyyWD+4MewV4rlutMyd4ZdB2BBYCR6VC0Zn
         oQmBgQjqhBaVdeImpOJf3StsFoPtNEEGfeUjsnEqxXxXYT2he9PK0AXjcjzu/K6t5IS1
         WcaZpriSXMWfi6pR6IZh31CFdwpfJ9rCpconazfNv/djr6ymXnDIF+gtVHF56JJDbp4U
         FEZA==
X-Forwarded-Encrypted: i=1; AJvYcCVRWvwkTh78Znk4SKfA7vXjzbvfOgJLvuyhHI0Hb7zzV0Tdgah7HdekPE4jsIK8hEKtfvqIySnrsOr1Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyySFgB0iE2aHzLMEnvdYggIKBlja5m/WtEuAzULUbrQT2kGOZR
	oZXXE2zPRKRJzNR2joSYa/B0+FePNNU7FyKBs60wZW43wOV8wgaDAWf8ATRiDsX5E7ghHtK8E5t
	FtcH/INaTDnKW0Jp0E7hwgj6VS9uJGi+AkC8unw==
X-Gm-Gg: ASbGncvpQ8KiqX1gRuqW6tanj0LkyhCyWzHHYSApf4ti/nR7yeFVNICCz5vhUNdMki1
	HM6JBLA3d5qi4V3P1LDcacp6JjyuK7xD6IapSHRGV6lFJ6GRaIrDPd7+IC3HzBicZlCiW7kSAlf
	dUiVIRo4yw5GbHUTDFaXO+P2FR
X-Google-Smtp-Source: AGHT+IEow1BlcqFlv//R/FmMhI1O328lsFzXKamFqknJTFtdD0P9/1gODkLqTO2VRrWyJMhH2t2sWaT9w+Ksqb5BWSs=
X-Received: by 2002:a17:907:2d89:b0:abf:5266:6542 with SMTP id
 a640c23a62f3a-ac330489385mr1911248066b.55.1742317651722; Tue, 18 Mar 2025
 10:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318095440.436685-1-neelx@suse.com> <20250318154552.GE32661@twin.jikos.cz>
In-Reply-To: <20250318154552.GE32661@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 18 Mar 2025 18:07:20 +0100
X-Gm-Features: AQ5f1JpWZKk3yj8wKqrNv31flLCogTgPfnG2zjF65sslmtXCPL-IDmWnGlGQUo4
Message-ID: <CAPjX3FdLp-niyvQX5vkrPtqwJcRB+hcax=0wRbKdQvJS4T+-PA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove EXTENT_BUFFER_IN_TREE flag
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 16:45, David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Mar 18, 2025 at 10:54:38AM +0100, Daniel Vacek wrote:
> > This flag is set after inserting the eb to the buffer tree and cleared on
> > it's removal. But it does not bring any added value. Just kill it for good.
>
> Would be good to add the reference to commit that added the bit,
> 34b41acec1ccc0 ("Btrfs: use a bit to track if we're in the radix tree")
> and wanted to make use of it, faa2dbf004e89e ("Btrfs: add sanity tests
> for new qgroup accounting code"). And both are 10+ years old.

Right, I could have checked the history.

Though honestly from the diff of these two commits I don't see any
valid usage of this flag either. Must have been somewhere in the
context or I'm missing something.

> > Signed-off-by: Daniel Vacek <neelx@suse.com>
>
> Reviewed-by: David Sterba <dsterba@suse.com>

