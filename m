Return-Path: <linux-btrfs+bounces-4388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5B48A8FE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 02:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AE6282617
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 00:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391C53FEF;
	Thu, 18 Apr 2024 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QNPOVqHK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2B715C3
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399317; cv=none; b=pYXeuGLwWm+R49z55ZrcWiZR3cFrFaAFAguBGkaXF3KYzYjWFdf6L75+vgQKYNc7ljtMLzQk7MovN1F076dFQg9JnRS6SFDLNk/JN1D1TVHX7bCfNl97cOYxQZGH9vEwNQnN9Se6xXwdbQLgI8yBbhrBLWj+ZAU6VraRx9j8uNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399317; c=relaxed/simple;
	bh=hyvG3v6XAKRWm3hH6ODN6kbZbNuRyM4HM33dcRdxujU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W65V7yPB+PZI+QIz7IbpFterDbiUWzx84Db5chQKfTzNXLWSfJpm7rKHuL06KXP2DVHjTIpYplOtW8Kb6/rNTnCqK08WvJCAiWvsfIDbo2U1TLwGc9UegL8YmYNWuT4uwSAhkDpmJH7akS4/OXCbM3AgSm+UV6ZmElAkhhmE9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QNPOVqHK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e509baddaso275218a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 17:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713399314; x=1714004114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E+HEY7o6NmipJTF9VPab4N+W3wy3ABQnhFnH4fGACVM=;
        b=QNPOVqHKZtKRd0I9CLUYkbzzETC3erXf7309SHt9HlN5qRq4cND5ErBxL9hxebVBLs
         ggpRB75ptkwx5yE0m49ON0b6o3zVTf56fx0TsbT8Fx5R7Kwhvt30cNU2PJWHEiHwbB5i
         jENTNKNnsKeZ/pTixEs7S03kk1ec2b5fVhrxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713399314; x=1714004114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+HEY7o6NmipJTF9VPab4N+W3wy3ABQnhFnH4fGACVM=;
        b=td81/1r69i8Amc0/tlIDlPDUjADceGy5rL26eWtw2wt3pB4rywEmoDoV1vBw/3/bhK
         KDzBhJdn/3xjr1ytRo0yGMELgFB7BBPWsLNJA5yq/568kaMksjmwU8og05wfgSmlyXkq
         Y1ey/d12n7mZ2uzQNbbQpexuhKdKpgFfoEw2TpvrQe7VP20iIhk6p/JODzx1r9++k4J1
         z20B4kb+4EPoerwGs5k3e+VXOImIwj1hVwgkwIBRrvYnks3mM4VNcsSojDYWmoT67zIz
         Pcdolf4dKWImLKt6GSxr08xTGseWLXut0wAYdBj1ErJXEY+j8VIcnX1Aa+orAQr/47zG
         00lw==
X-Gm-Message-State: AOJu0Ywm2+LE4cReWWJyVx0YtQa0bpKy7TcrWN2ZA6GAPpWZYzFkUPrl
	FKTVqKMR13NWLu+f5LmZrQCeT84xs0ainEQXkkgIYdsqs7nhFZs5vftq/ayeFjyNQNK9bEtAU9G
	DO5Y=
X-Google-Smtp-Source: AGHT+IEdxQekCtmfj71vSvU4IV52PP9589CO56xI1X5oDVfvGHKuixVZ+6R+LVggWjfyjiGr4L2Jlg==
X-Received: by 2002:a17:906:3ada:b0:a52:4d96:85e with SMTP id z26-20020a1709063ada00b00a524d96085emr453530ejd.53.1713399313799;
        Wed, 17 Apr 2024 17:15:13 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm108344ejk.57.2024.04.17.17.15.13
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 17:15:13 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so291352a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 17:15:13 -0700 (PDT)
X-Received: by 2002:a17:906:32d2:b0:a51:c71b:e1df with SMTP id
 k18-20020a17090632d200b00a51c71be1dfmr570874ejk.47.1713399312874; Wed, 17 Apr
 2024 17:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713396900.git.dsterba@suse.com>
In-Reply-To: <cover.1713396900.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Apr 2024 17:14:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirVv7e6r+UOe5Svjrkx-Cy_=1bNSigdYrWWwzfv_-4gA@mail.gmail.com>
Message-ID: <CAHk-=wirVv7e6r+UOe5Svjrkx-Cy_=1bNSigdYrWWwzfv_-4gA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.9-rc5
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 16:53, David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc4-tag

Nol such tag. I see the branch 'for-6.9-rc4' with the right commit,
but not the signed tag. Forgot to push out?

               Linus

