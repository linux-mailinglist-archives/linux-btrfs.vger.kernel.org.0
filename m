Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ADD718B4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 22:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjEaUiE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 16:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjEaUiD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 16:38:03 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B51123
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 13:38:02 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bb131cd7c4aso41130276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 13:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1685565481; x=1688157481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ytiCHZC8VVB46Ss5pK0/88JBBgACI3l4vuNc8O8ENw=;
        b=rqIlxW2Dp+JTvj3n7Hb/nS8Y2f0hmgXQVi+VGs2NpQEI05yoBIiIVHtWQUCOmEFZHF
         0Pu9U9s/ZH/DkOkJgEFvyNMDPDSPr7tPzKq9tfYgIjVwmyWuj5MWZ7VCk1jy42pa8WRb
         yvzAQ3/lEQLtV7MuiN5r4WWt0ksZEZukkoKUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685565481; x=1688157481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ytiCHZC8VVB46Ss5pK0/88JBBgACI3l4vuNc8O8ENw=;
        b=gp+h/PcUVuKZYozlR9ExSpQQuAg3/vZjKLVLjtQ9+GfpW7ZF7Og8ZcqQ3eKyJgBgik
         Xtfp/cFib2HAQjY1LVRb0B8+o9S/zPALs16LEIH3C9oy372wUF0eJWnO2zh2Yo4iTMry
         hJVOpLNjPfCX7H1RTtIds2e3xKgxnOmMmP0KsOLf7c4FmLJZsFht3cZ062naqenWTq1h
         NmFFJeHJ00yvkzD1cL6F1rn3BRV3Js5gegMSpwTS6slmqf1Dzh54azJoCnXu56VNPvRP
         ZWKZmTKjHMYpx0x2TqhU4U1Oqfh4hN/sTcXpM3fdAFtsAmLWxEmECYfcU6fPhI57vBAY
         zGbA==
X-Gm-Message-State: AC+VfDyjE00gnLz9fo75MV0fxt1/HBzdryz1U/Ezxifig0mIzVzxxraf
        EIyC/z8elVKI4OCD2SUSlIUnXm7JzhaogQFu6x91JA==
X-Google-Smtp-Source: ACHHUZ6psx2U2FNXu4cl6c+ze//uIx4NV0fw4XArg9JiL28yX+iORode52JaEHXvMr3VouYueL16Hw==
X-Received: by 2002:a25:74d0:0:b0:ba7:2531:28af with SMTP id p199-20020a2574d0000000b00ba7253128afmr6759187ybc.11.1685565481446;
        Wed, 31 May 2023 13:38:01 -0700 (PDT)
Received: from bill-the-cat.lan (2603-6081-7b00-6400-94b3-8a65-fec1-4b24.res6.spectrum.com. [2603:6081:7b00:6400:94b3:8a65:fec1:4b24])
        by smtp.gmail.com with ESMTPSA id l6-20020a252506000000b00ba83509b758sm4524718ybl.4.2023.05.31.13.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 13:38:00 -0700 (PDT)
From:   Tom Rini <trini@konsulko.com>
To:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Huan Wang <alison.wang@nxp.com>,
        Angelo Dureghello <angelo@kernel-space.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Wolfgang Denk <wd@denx.de>, Marek Vasut <marex@denx.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Marek Behun <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 0/8] Cleanup unaligned access macros
Date:   Wed, 31 May 2023 16:37:59 -0400
Message-Id: <168556545384.862325.15800321440697977117.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522122238.4191762-1-jens.wiklander@linaro.org>
References: <20230522122238.4191762-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 22 May 2023 14:22:30 +0200, Jens Wiklander wrote:

> There are two versions of get/set_unaligned, get_unaligned_be64,
> put_unaligned_le64 etc in U-Boot causing confusion (and bugs).
> 
> In this patch-set, I'm trying to fix that with a single unified version of
> the access macros to be used across all archs. This work is inspired by
> similar changes in this Linux kernel by Arnd Bergman,
> https://lore.kernel.org/lkml/20210514100106.3404011-1-arnd@kernel.org/
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom

