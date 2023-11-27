Return-Path: <linux-btrfs+bounces-395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4BC7FA66F
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 17:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13E71F20EFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 16:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0C36AF4;
	Mon, 27 Nov 2023 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="kpDMOSYQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CF1CE
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 08:32:38 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso3754716276.2
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 08:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701102757; x=1701707557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDxDo1N+Bt7cuxAb2iI0JUDxn+oZ0VSeKhTea5jj0Ag=;
        b=kpDMOSYQUPu5UT4MG1OphLaOBFxazfFgabinVNCRyh0/55DnditzQoARkTVdaFwXWk
         dTsBnGzrqmsGLdqvjTt1/4fT6fjgcC8F5PZPjT8QjzTJNYgzBQUoen+DAl2cGxj/ZK/W
         xHVRif9a4UhR9DxYZjjMokNisTpf/U45On/Gxaf6l9FeK4SMJ5gKMQDeai7wrTYOrHoV
         HPmXIP8kpnsO2NJ7ii7C1OxlFxL/y2TPCG15jYeuRsm2xc0aFsFbtb71y8lIpAqTMAFD
         wc3HkL7vstct70lL30wuODXt9JxsnjiVaa5LCsaHHVpKtzte0o6Ica2hlOwrz0V56s1i
         ZFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102757; x=1701707557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDxDo1N+Bt7cuxAb2iI0JUDxn+oZ0VSeKhTea5jj0Ag=;
        b=w2W3rNch5o31UuxKoK6Uk6/n4yBb5wTtbsiqqVhTdR+DCyhwGtgIom547PN1ETTXGm
         naGQ7AsekudC3OAAwLSj1SheIPiRxAkXzh2Q8tSwgxnzsogzDUfkmKc5KNYmTPVKo7iH
         vQ9dZKtCDbtLpDGv05mfIXgIgu2YNcjRpTKSJMkSpS4UxqN98PYh/WIogFyF+5JH26ax
         kbPgbOeqG6mKRMXS4PKL/wAlCTAuw4fFQLhPR6328xGgq1RFq9tYW06Yf9NaE70ZD6Uj
         TFssVXOepwsPoLa0j2p0TYu8mWYFn3Xpneim8ScQ34Gzv04IbM608dAOuQjx6QCc7Ugq
         djZA==
X-Gm-Message-State: AOJu0YxBQNSJyc1MOyYObk2SbGSl2Z1r+G/3+T4icSuZsgHokkOkdAkf
	fAiG5AAJ5fNuUc0OUU/RWd2LmsZ8oQeMDJh+GhWBxYwi
X-Google-Smtp-Source: AGHT+IG2k+SRhQHKAu+8wqsE+fEpQDrV7gOh6cQCZnCQNs4cESQUXgxwAkZJf8ZwpRyC4mfU4c4/6g==
X-Received: by 2002:a5b:c52:0:b0:da0:95c0:d157 with SMTP id d18-20020a5b0c52000000b00da095c0d157mr10038527ybr.51.1701102757221;
        Mon, 27 Nov 2023 08:32:37 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f126-20020a255184000000b00d8168e226e6sm3136953ybb.47.2023.11.27.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:32:36 -0800 (PST)
Date: Mon, 27 Nov 2023 11:32:36 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: migrate extent_buffer::pages[] to folio
Message-ID: <20231127163236.GF2366036@perftesting>
References: <b87c95b697347980b008d8140ceec49590af4f5d.1701037103.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b87c95b697347980b008d8140ceec49590af4f5d.1701037103.git.wqu@suse.com>

On Mon, Nov 27, 2023 at 08:48:45AM +1030, Qu Wenruo wrote:
> For now extent_buffer::pages[] are still only accept single page
> pointer, thus we can migrate to folios pretty easily.
> 
> As for single page, page and folio are 1:1 mapped.
> 
> This patch would just do the conversion from struct page to struct
> folio, providing the first step to higher order folio in the future.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This doesn't apply to misc-next cleanly, so I can't do my normal review, but
just swapping us over to the folio stuff in name everywhere is a valuable first
start.  I'd like to see this run through our testing infrastructure to make sure
nothing got missed.  Once you can get it to apply cleanly somewhere and validate
nothing weird got broken you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

