Return-Path: <linux-btrfs+bounces-879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5134F80F13F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 16:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D66FFB207BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E2A76DDD;
	Tue, 12 Dec 2023 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ePLs+thr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927A5EB
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 07:38:42 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1f653e3c3dso600670766b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 07:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1702395521; x=1703000321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qDZp7gWbuTVE22AvhJgQ9vIXXo9oTgtdlKx+S8j/dsw=;
        b=ePLs+thrYIrckuEll35ovE9pmJp5cwokHTvPGSt9XpSrlwBHAdYY/R2Aa58IidFGwY
         dhfMNhx0XPeLeVDliY50RMI9d9CfMfoOfJMvZcRLjPqSTwO2mLwhQA/WflpZiIFd6soB
         NhFBy50pbUzvBumih5waDU+xa1DM15XnC54gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702395521; x=1703000321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDZp7gWbuTVE22AvhJgQ9vIXXo9oTgtdlKx+S8j/dsw=;
        b=ghcoWll+Y9GXuRSYGvS2OQlqfUQHDMjc+fkd3b9YRlSidJp9rp72/2rb4eyT22QYMJ
         4z72fJyqiG6KfMu2G/lGXPx8s5l/XcALYrF1dEn/1tyblc8LG53y2AUfDGZpF+L8R2/n
         xoMLO17coi3hJAHh6DYWzwXwZWSiSH7WazIuJIm5/84byqLwAtstXZkWDa+QXlMTVz7k
         /51yTvtB92Tx8+yK8LYxcQ4mkIXvGqMQkaGyLEFyhrGf/MvGwzh2h8ovzNI6E7HEpIhS
         9a5vgmwOFtK1DGRsGhHB2OHEhaHEzPuf2umWJf0WGKn085HyDOwhnxL3GIOx3Vw6AI5z
         nIuw==
X-Gm-Message-State: AOJu0YwIXz0krDURGfbcetgoYhZmIXybfQAZUHo6AygiaRdkciYC621f
	yLWSWEWQMCPW4xHXMUJQTxmnY6KPvPM5H1rJ53Ilzw==
X-Google-Smtp-Source: AGHT+IHmZCdgCSlsAh5hzabUbuYuMUlh4UtiP5FO9/RLbX9bRONO0dRdKVOceruL+MQnVZvFpB3AboTApbM1hEUFH3Q=
X-Received: by 2002:a17:906:10c4:b0:a00:185a:a12b with SMTP id
 v4-20020a17090610c400b00a00185aa12bmr1425258ejv.34.1702395521086; Tue, 12 Dec
 2023 07:38:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan> <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan> <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area> <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <20231212-impfung-linden-6f973f2ade19@brauner> <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>
 <20231212-neudefinition-hingucken-785061b73237@brauner> <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>
In-Reply-To: <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Dec 2023 16:38:29 +0100
Message-ID: <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>, 
	Donald Buczek <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org, 
	Stefan Krueger <stefan.krueger@aei.mpg.de>, David Howells <dhowells@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Dec 2023 at 16:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:

> Other poeple have been finding ways to contribute to the technical
> discussion; just calling things "ugly and broken" does not.

Kent, calm down please.  We call things "ugly and broken" all the
time.  That's just an opinion, you are free to argue it, and no need
to take it personally.

Thanks,
Miklos

