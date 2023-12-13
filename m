Return-Path: <linux-btrfs+bounces-942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A99811F9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 21:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E871C21187
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 20:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324767E549;
	Wed, 13 Dec 2023 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="XKK21ypo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818B7DC
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 12:01:24 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-db537948ea0so7213022276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 12:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1702497683; x=1703102483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qx+hZ2dW2DhzBWV9ah+UIb3u7WuI0mqLzlIVuMRmEk=;
        b=XKK21ypovCjFb4vuRlEKBd0k8wpyt0zxVAbz6ALpgKwnbcn7TnagI9zJ59lB4LIuhL
         jMJz9fG71o+LSit1JykpNYcjv1K5PvnoiIBUiHd7Gw5usHrNi+n3nNRQFQ8R3rZKKZVA
         b4Yf4HTzT6UAI5eTQrNdwo6hTnPgiuum00Oug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497683; x=1703102483;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qx+hZ2dW2DhzBWV9ah+UIb3u7WuI0mqLzlIVuMRmEk=;
        b=MLCIF4qfPbhVkjpzLdCGjbYsM4YOeE4hyH/rf1H/Bs+qIXXAikGIfFuMdO+h/NAW+L
         9iR1Ypc7WLsr8ugM0LEnCnNzQdkXKpg82PoKZdcv02SQD2UzPqPEXsSAWdAVhiaoGYgl
         xJRzMNwrPvww2Nw6FEDsD/KRvUOeQRx417NRNAdtFiAvP6i/KqgrLEbRsE3cA+jKTcPo
         I3gaufFLXhXoxZedV/IES3aK1Zhu32prxKP3cOs5RLx95vF0ywduTkwXTBpQ0aW74R4d
         NjtfrI6vDRK1/b+8gFYRjVvbd4r/nnQY5/XNBOqrbA3tR0cTplpZcC7qNnYbiFf1Nhym
         t6PA==
X-Gm-Message-State: AOJu0YwWxyMDo5bGiysMbB4T2iacz64ihpTpuBVTRe0dEbBGXxXcw/qq
	YPHzDLfM/Vxtz2oOIS6O94WKeA==
X-Google-Smtp-Source: AGHT+IF6Js/+8Vnspj2WKBMmkNORaO4jxP7E1Zj/Fa4Z7XSCvfnlPXXqryLm5rna5+dsGZbmAXZyKg==
X-Received: by 2002:a05:6902:1366:b0:dbc:b14e:4774 with SMTP id bt6-20020a056902136600b00dbcb14e4774mr3643230ybb.40.1702497683742;
        Wed, 13 Dec 2023 12:01:23 -0800 (PST)
Received: from [127.0.1.1] (2603-6081-7b00-6400-d78a-ada8-3cce-fa3d.res6.spectrum.com. [2603:6081:7b00:6400:d78a:ada8:3cce:fa3d])
        by smtp.gmail.com with ESMTPSA id w3-20020a5b05c3000000b00d72176bdc5csm4176069ybp.40.2023.12.13.12.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 12:01:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Alexander Gendin <agendin@matrox.com>, Baruch Siach <baruch@tkos.co.il>, 
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Evgeny Bachinin <EABachinin@sberdevices.ru>, 
 Fabio Estevam <festevam@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Qu Wenruo <wqu@suse.com>, Safae Ouajih <souajih@baylibre.com>, 
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, 
 Stephen Carlson <stcarlso@linux.microsoft.com>, 
 This contributor prefers not to receive mails <noreply@example.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
Subject: Re: [PATCH v3 00/32] bootm: Refactoring to reduce reliance on
 CMDLINE (part A)
Message-Id: <170249768190.2729322.17736686943926786117.b4-ty@konsulko.com>
Date: Wed, 13 Dec 2023 15:01:21 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

On Sat, 18 Nov 2023 14:04:48 -0700, Simon Glass wrote:

> It would be useful to be able to boot an OS when CONFIG_CMDLINE is
> disabled. This could allow reduced code size.
> 
> Standard boot provides a way to handle programmatic boot, without
> scripts, so such a feature is possible. The main impediment is the
> inability to use the booting features of U-Boot without a command line.
> So the solution is to avoid passing command arguments and the like to
> code in boot/
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom



