Return-Path: <linux-btrfs+bounces-8208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E8E984E3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 00:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20161F23E02
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 22:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF37C183CB4;
	Tue, 24 Sep 2024 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAhXEYQP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9718308A
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 22:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218778; cv=none; b=AVmoG/hpQHD3c7q9UyYcCwm1WED5qUdXUmDPMPOld/uQf6aMQXd3f/tYbvimnqF7kyeUXM1UstcHVAzoIMIFpE1sRKR5LV5MCveT3FMlPJ06TTPUF/vZgbLP7dwCogi49tJRobnCJr+u2tI7dayybGKNy+IXgBbGSb1CLeIYoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218778; c=relaxed/simple;
	bh=eXbV2uH1ENYWIBFaIYaZ+QrCdba+tfIqsv0jAkYvMjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=c+yf2CEVxiZLveEhrzXcqZpiMGoF6kK2PygbJsA6/SDX8M77LsXt+WxccZVjMY03x7GbfgQGdxZJlgcZK31y4PYmI8XOdg33J2d7kXMkqgAX6PCv099tT96jW+pqN+bq8bM9xh7xGD84MF0N9WqrHLhfd69fSMi7OAel7k8DGJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAhXEYQP; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-3e26d148991so2562963b6e.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727218775; x=1727823575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hpOriF6/7dD4nIN/R+7cU1cXPajp9vmCN7TPqgAdS+Q=;
        b=CAhXEYQPhhHUV03pEwGhq6+ojNF29DZJTXeuRFEcfjDvQF8otyfQN7hLNH1sPTi8zW
         R0iACBl7uH4rr0T3S1JwYem/tUuFYTv7LI54IiK2i6GOjkgB8hs3btfyaZR7zZAoljWY
         m3IRUxCTiGjtykz7nNLuHPazEXrGca4/xQ487EvT6uPU7O9QHKbqtxrBtNz17iWPznmE
         nsnmUYPYrBWsemypdgm9iuu3fHFcqi3qay/s6tjv2KKHQQRg4H3vzl1NtC18dYfzUlnE
         Mw0iBMeojI5Eqat+BEut7SDizYDR8GQ/ayAoGOEC8Eot//fMu0VkuCqravVDh2GK7xTR
         rSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727218775; x=1727823575;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hpOriF6/7dD4nIN/R+7cU1cXPajp9vmCN7TPqgAdS+Q=;
        b=rBDBp2D8o0ZkfIqEZvFDZ/zG3PoewRJsXT3Jw80PbLfxi0pZLPZONyPDTnD05tOMjW
         E1DFJgaeSDkdNCeO0FVP9XsmMhrfXBfMTyRvQdeFytBI8m3TzH8ZkPQhD7AukyQkTdfD
         vvZsC4gPrLf36ptwdks8aerHRWNjfBXwczKVa7LjX7w4oyXQBymzglNKLMtQqxDkYpdY
         tagLtEMd4SGm5GAp+C+jRHa/kVLisMIkUENSeyo23fRfxgcGnWL9TqIK+LWdJBmVL5RZ
         XNKRV3Lh0Vpu0JAiieju/iEpCjeC16xcQnXzpkup3KFXROyRfmZJPLLkwP7RgUyJQqE9
         h62Q==
X-Gm-Message-State: AOJu0Yx6SGP+5EUCMgjvCcA25vFP4FVrQFbD+cCOf4JSg68QFE1B4/nG
	GMpRioFsx61eqypQPOcpwbYF4emHBCmII0PnGjgxJ9rhndY0v7bh
X-Google-Smtp-Source: AGHT+IFajKfsl8SWkN3AhFudF75kkwI5xqxiUF8QsNUS+yG43FkG06kAmToHR7JKT9PdEo3E3/RnrQ==
X-Received: by 2002:a05:6808:30aa:b0:3e0:416f:fac6 with SMTP id 5614622812f47-3e29b7918d3mr548646b6e.24.1727218775489;
        Tue, 24 Sep 2024 15:59:35 -0700 (PDT)
Received: from localhost (fwdproxy-eag-115.fbsv.net. [2a03:2880:3ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e29396fe3csm712883b6e.52.2024.09.24.15.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 15:59:34 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:38:12 -0700
From: Leo Martins <loemra.dev@gmail.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, David Sterba <dsterba@suse.cz>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: set flag to message when ratelimited
User-Agent: meli 0.8.6
References: <0628fc55984c3507c5365d4e1d5ed96d28693939.1726261774.git.loemra.dev@gmail.com> <20240917163045.GE2920@twin.jikos.cz> <p6svr5p3q7yezuqsevuzq7jxqbhn2wbq2cjz43e3nuk5bxfxhl@pgkaoqo53byw>
In-Reply-To: <p6svr5p3q7yezuqsevuzq7jxqbhn2wbq2cjz43e3nuk5bxfxhl@pgkaoqo53byw>
Message-ID: <kcaj8.ncm2uv11etg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed

On Tue, 17 Sep 2024 23:06, Naohiro Aota <Naohiro.Aota@wdc.com> wrote:
>On Tue, Sep 17, 2024 at 06:30:45PM GMT, David Sterba wrote:
>> On Fri, Sep 13, 2024 at 02:26:06PM -0700, Leo Martins wrote:
>> > Set RATELIMIT_MSG_ON_RELEASE flag to send a message when being
>> > ratelimited.
>> 
>> What does this really do? The documentation does not help either:
>> 
>> /* issue num suppressed message on exit */
>> 
>> > During some recent debugging not realizing that
>> > logs were being ratelimited caused some confusion so making
>> > sure there is a warning seems prudent.
>> 
>> So you can enable it only for debugging level.
>
>Adding my point, I often see btrfs_info() in btrfs_dump_space_info() is
>ratelimited and the info is incomplete, because it tries to print usage info
>about all the block groups. For that purpose, I don't think printing the
>number of suppressed lines helps.
>
>Instead, I'd prefer disabling rate limit for them, given that the messages
>are behind some debug flag (e.g, CONFIG_BTRFS_DEBUG and/or mount -o
>enospc_debug). So, how about adding btrfs_debug_info() which prints the
>message in INFO level without rate limitting?

When I previously sent this patch I thought that
RATELIMIT_MSG_ON_RELEASE flag caused a warning message to be printed
when ratelimited. This is true, however, a warning message is printed
regardless of whether this flag is enabled. When the flag is disabled
there is a printk_deferred [1] that will warn the user of the number
of callbacks that were suppressed. When the flag is enabled the warning
is instead printed when ratelimit_state_exit [2] is called which happens
on closing of /dev/kmsg. I now think that setting the flag isn't
necessary and instead I'll send out a different patch that implements
what Naohiro suggested.

[1] https://github.com/btrfs/linux/blob/21b136cc63d2a9ddd60d4699552b69c214b32964/lib/ratelimit.c#L56
[2] https://github.com/btrfs/linux/blob/21b136cc63d2a9ddd60d4699552b69c214b32964/include/linux/ratelimit.h#L31

