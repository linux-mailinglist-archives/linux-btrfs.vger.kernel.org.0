Return-Path: <linux-btrfs+bounces-7223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FCC9541F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 08:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947931C236AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 06:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAED83CD9;
	Fri, 16 Aug 2024 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzkVZwtQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F482866;
	Fri, 16 Aug 2024 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790582; cv=none; b=lRUrdVf2d+JejVAZEOPAGjStUUOjnNzVF8Z5N9HCW4zqOugEHKD3h2bTPNM9aW6lBEBxHsDlOrr1SSYZYPSRwFOkYkqIU/lXOwD1tl0TknuBjXI3wR79+FEuvn8jjkyeOg2nLNZynuKBqvmxSke2j2fTNpNfe+sstYixXbR4PvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790582; c=relaxed/simple;
	bh=9MzRT6MQhoASRVKxtLl6TLviFlnQnH0RbQCnybUc2go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chUyrlNoAek88k1Hx7GwFn+LJislVu5zwIdFjkb1WMjsU0nUuKK00nK3cYJR0om4tZ0BYDczkuczXQzKsVa1NzdwhD7QlIMKbdqOEHk/WQc9IXaNQuDw84qGlchWL6Qm69Kw1LqlLvnWQyun7bwwNd7Zzp15pLFjussqT02vftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzkVZwtQ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-69483a97848so17093797b3.2;
        Thu, 15 Aug 2024 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723790579; x=1724395379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9984CAS7CNIQxBvvTikDkZZTlOsU6w6r8X2XroTC3V8=;
        b=JzkVZwtQ/tuT9AXT0oa8KELY2buQY+jP74ikg6bkA4hcY1SUmmsc8mlI3HNg71Sm2Q
         fURijlSYZ10TpM/zJfcWyjO6JOklo3oxlmoJqNlBfgOa8yK5hFq+LgwH1qOToI8iQLAH
         yl76ufT5L1WdJa74tYG1bm6ipH1IkqnrCbHsuwux5rJCHyZxPcRVp6bPDyScioG/zmOl
         I+8mhMalExzQzf8EZeE2YNuIT/Drkur4nsAnAhaUvrU0Tn652g5sit/9gTdfdorzt5uh
         +fOU5BQChk8jo41GUZnvX6BmlIpAQ0gEE5nY5sfbVMiu8ZnOPNsTKExpLNVMoSaPIr61
         DaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723790579; x=1724395379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9984CAS7CNIQxBvvTikDkZZTlOsU6w6r8X2XroTC3V8=;
        b=XD6RyTFzU71kgm5wHowQQIEyPndAiIFiD5UmnNzFf6uw19C36b+YPgEHxWJ//Wm8/u
         mtzTRGg467cXhXUjznwAcqELIwLrIZ3zM2bdIqnDTg5YdbOZwRSM+5nR1Hv8xO6xJicL
         BbULxv7T4dq7aB/f1PLyFdnoQn/YLtBssdfU4S/qrKnZvsM2pviSzCMGhHgK5jQdNfuU
         p7Geav2aG4Vmheue1k6zp//X69wf3BBJ29wSak53krUEyOlCe5KOMJRcoN2DgKIFHiBE
         YSfKqEfgD2DdzJ2BYQ7CSsdY8RNj6UiEYJ5CWWtmf3WEbNSeA3BCqWwX0mD0S9BhPzJq
         74gw==
X-Forwarded-Encrypted: i=1; AJvYcCXivrFk7DxGLlhUn3vqUpUrOCjqsBzwJOBFOPyJZdryxBCZ14On2Iw6oLMC7dsyCaC+wKiaPxNRN+uEcf6aSZJtmWZK07USHOe7AeRKhucg/rwdq1PQ9MzFW3zg9jqVacTx76ymmH4R7UI=
X-Gm-Message-State: AOJu0Yylv0Z0rTVdXVWMefqgvNDEyg3AY3VSroIwFfvIRLt2iXgjaLre
	5Q/KqQArZ8NAh5oIqDv+jlAGdfWjXRn1Xrw/3kGAh511TaVZFSQx6z4CtWb+gjGHiLoP95lVfGW
	W8cxZWYUpwAJdPpuwegcALKlSDWg=
X-Google-Smtp-Source: AGHT+IFwaUdjqwZ0EpK280Y4+BayIVwVmptraNcFRsFUCRRzajjVCxtXiorbxlU3aWf+0BDjO9tNnEDrqszN/MseIaw=
X-Received: by 2002:a05:690c:438a:b0:6b0:70fc:f6d3 with SMTP id
 00721157ae682-6b1bcf8ec67mr14579087b3.45.1723790579487; Thu, 15 Aug 2024
 23:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H5zfQNS1qy=jAAZa-7w088Q1K-R7+asj-f++6=N8skWzg@mail.gmail.com>
 <277314c9-c4aa-4966-9fbe-c5c42feed7ef@gmail.com> <CAL3q7H4iYRsjG9BvRYh_aB6UN-QFuTCqJdiq6hV_Xh7+U7qJ5A@mail.gmail.com>
 <3df4acd616a07ef4d2dc6bad668701504b412ffc.camel@intelfx.name> <95f2c790f1746b6a3623ceb651864778d26467af.camel@intelfx.name>
In-Reply-To: <95f2c790f1746b6a3623ceb651864778d26467af.camel@intelfx.name>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Fri, 16 Aug 2024 08:42:43 +0200
Message-ID: <CAK-xaQaPbmZ+pcqFvfgtwTyMnHbMcs6j8KjgVOYBxGzGgoAJ7Q@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: intelfx@intelfx.name
Cc: Filipe Manana <fdmanana@kernel.org>, =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>, 
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mikhail.v.gavrilov@gmail.com, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Il giorno ven 16 ago 2024 alle ore 01:17 <intelfx@intelfx.name> ha scritto:
> Can we please have it reverted on the basis of this severe regression,
> until a better solution is found?

To disable the shrinker I simply remove two items:

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f05cce7c8b8d..4f958ba61e0e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2410,8 +2410,6 @@ static const struct super_operations btrfs_super_ops = {
       .statfs         = btrfs_statfs,
       .freeze_fs      = btrfs_freeze,
       .unfreeze_fs    = btrfs_unfreeze,
-   .nr_cached_objects = btrfs_nr_cached_objects,
-   .free_cached_objects = btrfs_free_cached_objects,
};

static const struct file_operations btrfs_ctl_fops = {

This is from my thread with Filipe about same topic you can find in
the mailing list archive.

Ciao,
Gelma

