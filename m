Return-Path: <linux-btrfs+bounces-392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 809C77FA5A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 17:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F48DB21351
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 16:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08883589B;
	Mon, 27 Nov 2023 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="qbvfV7s6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A07EBF
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 08:07:07 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d05ff42db0so10706737b3.2
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 08:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701101227; x=1701706027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0X43bDr5cjDi5fuHxxsDsh8V+3EmZKapeWWbTvrBlA=;
        b=qbvfV7s6UbqYUSzgJDG1yJB2ezcAidpkiLuCvYWBU9TteZg/LHzkvUnIkwPq4fCnLm
         4SqinaNZ+RzMigSEQG6iluMfc1E1FpE/VsOZSKbNDjWoG2FZsK93sSvtgHBijsuaLGQ4
         VBK58FGcsodR5fsYLm27ibR+NFs1jncSF8l/yrFjfg3QTTG68V0U28e+hsKrt3dpQu6z
         FhOpDDtACvf0upCost7eM5OnSamvx8WHejJqKfNmIhONufM8olI737dNZptKkrNNZlPd
         Wa5UqF6yXVfdqabO3zav+07oecZeZuu1N2GSjPNGDaQIoY8fxqhJpkkB+a1bAQjd5F8S
         /IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701101227; x=1701706027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0X43bDr5cjDi5fuHxxsDsh8V+3EmZKapeWWbTvrBlA=;
        b=fW8UexMBGGTy6lIBo066YwIzNKrd0qNUBhiGk3+5UKBAbnmKGhNjdwbCQxcpXG1Lb7
         vekHruoAHLWY/ZTo7J4WkflbhgSnTlHjTa1+manWcKQtoRWsaLrGZ/QoqCxEmtQZp+mT
         K3Bq54XQ+Szxs0AanaHuQZh8euTceu0W7uVBNjVdV+SsBrlZQttPc9t3Jeo3qui4MqLe
         4DroolHKz3TkotMr4KrDD6bSPLEIRt7nzWKLZmbGyWRmqxZqUvZDni3d+VsPmUIPK5GD
         tSS1IQOv9ET+ZzkLs8E8VbJtjI9Vmqp1Bycnnstv7krOZ3dCcIXR0u2aTcRX35ZMg/s8
         W+UQ==
X-Gm-Message-State: AOJu0YzJm4X7bPXE8oKtGFJOIC7KsaJkTOs0XVccu5ZnvnXQSRTF6CDl
	LSQGYsRWh/DVPayW940ly63kIWe5tGBVK+PYXmr1EtjB
X-Google-Smtp-Source: AGHT+IHATw6Rbur2TSAVcg15XMVzcMVALzHGkYvmB39Sp4N7Ngeawq8PipONQMn2m9xPsAgUzMXjlg==
X-Received: by 2002:a0d:e885:0:b0:5cd:6dd1:b3dc with SMTP id r127-20020a0de885000000b005cd6dd1b3dcmr12226081ywe.29.1701101226582;
        Mon, 27 Nov 2023 08:07:06 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p8-20020a819808000000b005ce2e66394esm2694661ywg.70.2023.11.27.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:07:06 -0800 (PST)
Date: Mon, 27 Nov 2023 11:07:05 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Neal Gompa <neal@gompa.dev>
Cc: Linux BTRFS Development <linux-btrfs@vger.kernel.org>,
	Anand Jain <anand.jain@oracle.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.cz>, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Davide Cavalca <davide@cavalca.name>, Jens Axboe <axboe@fb.com>,
	Asahi Lina <lina@asahilina.net>,
	Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH v4 0/1] Enforce 4k sectorize by default for mkfs
Message-ID: <20231127160705.GC2366036@perftesting>
References: <20231116160235.2708131-1-neal@gompa.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116160235.2708131-1-neal@gompa.dev>

On Thu, Nov 16, 2023 at 11:02:23AM -0500, Neal Gompa wrote:
> The Fedora Asahi SIG[0] is working on bringing up support for
> Apple Silicon Macintosh computers through the Fedora Asahi Remix[1].
> 
> Apple Silicon Macs are unusual in that they currently require 16k
> page sizes, which means that the current default for mkfs.btrfs(8)
> makes a filesystem that is unreadable on x86 PCs and most other ARM
> PCs.
> 
> This is now even more of a problem within Apple Silicon Macs as it is now
> possible to nest 4K Fedora Linux VMs on 16K Fedora Asahi Remix machines to
> enable performant x86 emulation[2] and the host storage needs to be compatible
> for both environments.
> 
> Thus, I'd like to see us finally make the switchover to 4k sectorsize
> for new filesystems by default, regardless of page size.
> 
> The initial test run by Hector Martin[3] at request of Qu Wenruo
> looked promising[4], and we've been running with this behavior on
> Fedora Linux since Fedora Linux 36 (at around 6.2) with no issues.
> 

This is a good change and well documented.  This isn't being ignored, it's just
a policy change that we have to be conservative about considering.  We only in
the last 3 months have added a Apple Silicon machine to our testing
infrastructure (running Fedora Asahi fwiw) to make sure we're getting consistent
subpage-blocksize testing.  Generally speaking it's been fine, we've fixed a few
things and haven't broken anything, but it's still comes with some risks when
compared to the default of using the pagesize.

We will continue to discuss this amongst ourselves and figure out what we think
would be a reasonable timeframe to make this switch and let you know what we're
thinking ASAP.  Thanks,

Josef

