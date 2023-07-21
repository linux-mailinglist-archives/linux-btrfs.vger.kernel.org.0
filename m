Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAB575D557
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 22:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGUUEJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 16:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjGUUEH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 16:04:07 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E845830F2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 13:04:05 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5728df0a7d9so27183777b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 13:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689969845; x=1690574645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TomPELES0btoPbET1jox6LAbgZCiLx1ew5yYJu+tG5c=;
        b=1WLyu4Hpe/lxlxpTM0ehnj5Z7xwaSVJ9zo9iYupdSkjMEwSGENskAXvcaPw1N1D+Mr
         AsoBZajmNzScsMgu7KgUnTDPrHm4DzDCv2RQDEyT53UzPPptIXzx+ZsNABqhdaVg8maA
         bKcalWXYwF1ipjY242Lo+rqTSUuIjb5VV9/h75fLAafQYWxVJfhLu87wRxaPMoZH7R1s
         QVrgBlLDAW/aiv3vVk6BuUZ4plZUnPT2nT7hjkXZTA1JNpSoYyjkp7yE4KLnrpNQ+6sV
         q3520dArS1iNh9IzV7kiwbJ5rRkWI9GINs5eD4yD0T4hAfvCR67wiBO24i5tzB/EEwL7
         kmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689969845; x=1690574645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TomPELES0btoPbET1jox6LAbgZCiLx1ew5yYJu+tG5c=;
        b=PFWyHbKWRyCZjgVsx0jfv4tp1wwsVvBtCPni+fwXpPbpCVuLeace3xktGGrxJeFtNB
         dpDzbeRrTzr8z3wVfcHYvv8HTqdzQU12Q2OCqS/5O4Viesm7VDodWBbm9a4QweD6AnXQ
         G+LwbM4AMrCVhRS/OLvB1pIWc0TSsK25DoeNRV/zNW2O0tzH6zBYrVEX96e57q1XxaUB
         Gt9DQLkm9/CWboPF5UD3VsB1aBqUJRIHIwVYubG9SnCLVAAXZlSjdCeGTmnqM3vdZhgu
         NR195+wdwORZ5WPm7Y2eOVaExMkKFSxNzGRAcXtZo6SkLudevOc0PNbCBgRacFmSwale
         0k0w==
X-Gm-Message-State: ABy/qLY3M03zovy1aAYCnGmmoOrT2lcfG7cs5TFDcaoMVjBAIaV9WK77
        Bqk0OznU5L5OwE5hntumpGkUrE5lNp4anUZpqzrZWw==
X-Google-Smtp-Source: APBJJlEPdMJRxiQhlUd34drFV7vOHEKMeokmBdEVBq+gmiPW+TQda2Yj1JRKVZyYtDsE67iYz2Ks/g==
X-Received: by 2002:a0d:dd82:0:b0:561:429e:acd2 with SMTP id g124-20020a0ddd82000000b00561429eacd2mr835873ywe.35.1689969844918;
        Fri, 21 Jul 2023 13:04:04 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q190-20020a0de7c7000000b0055a07e36659sm1101993ywe.145.2023.07.21.13.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:04:04 -0700 (PDT)
Date:   Fri, 21 Jul 2023 16:04:03 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: make check actually honor expunged list
Message-ID: <20230721200403.GA1275195@perftesting>
References: <732fc62557b3dfdba820b83cd9643de314b6976e.1689968898.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <732fc62557b3dfdba820b83cd9643de314b6976e.1689968898.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 21, 2023 at 03:48:24PM -0400, Josef Bacik wrote:
> The patch 60054d51 ("check: fix excluded tests are only expunged in the
> first iteration") messed up the logic, if _function will be true if it
> gets 1, so the _expunge_test return values are inverted.  Also it
> appears bash swallows the output in this calling convention, so you
> don't get the 'expunged' output.  I noticed this when my CI system
> stopped honoring my exclude list, this makes everything work properly
> again.
> 
> Fixes: 60054d51 ("check: fix excluded tests are only expunged in the first iteration")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

So turns out I'm an idiot, this was just working in my simple case where I tried
to run a test that I knew was in the list, but of course it falls apart with
normal stuff.

Turns out the real issue is that we now expect the expunge list to be in the
format of

whatever/1
whatever/2
whatever/3

instead of

whatever/1 whatever/2 whatever/3

maybe we always expected the other way and it just happened to work my way
because we were using grep.

So ignore this patch, but we should probably document the format of the expunge
list files.  Thanks,

Josef
