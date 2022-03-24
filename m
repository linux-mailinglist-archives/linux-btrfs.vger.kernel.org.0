Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9334E6AE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 23:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355483AbiCXWsH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 18:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355554AbiCXWrz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 18:47:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F9FBAB84
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 15:46:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b24so7260086edu.10
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thejof-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=g8BHT8ggL7RJuGp2Vhokz5PerWbUzHaSTehQkS2C1ZQ=;
        b=w32wXhUI8vk4uEHhkJvJXaw7AfvLtILqvnQpwc0wBC8XA9rEkSXHn3fWcFAO9ZI8qo
         jhisvTIfqO/z8GmVBsloJPw+BZDGQlWJPaOeRxUDgio0RXLb3JrVvVKbgBUq/cSp0Duz
         gcjqmQbtk3qmjotFemVpofIo3PY3Sd4CekuqqgJSBIM5oHj61dNiyEhM4uSW/e8a/MFU
         2hV5rFslIoN52dxKh/QahFDVUfEshnX+5MxhSoBTaqxN5TX4ntwGQ3d3GUjXwT6OEiYf
         25xXWBfkmMpxZZQD4r9Qt4K8RnKeoxue2ooyS3gXThf3IS5VCTBUMdgCiaFp2TXxkpYu
         r+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=g8BHT8ggL7RJuGp2Vhokz5PerWbUzHaSTehQkS2C1ZQ=;
        b=KuTDqdyjYhNlNJ1SgrTvVPGS3+BwHLIEsi9rlzJU8I+dC4ozIGe/KCFc7GXALafbi2
         M+FCznyFwST7YHiScGt8NP5h2LFuB9XMaCZ+UDVSQEssSJhYlCQId3TzqAfysbl+kdbY
         mnBCPaFwDG8CZcyXJtExQcTEV4Zq5GgrCH3+TMR40vho4CegAOaKz83KluSzGSJm8JPW
         S78XJrtqvQzMoP8rfLCaDjCwc2EnIPAKJyFZVTpf91clKR+HLp6d1sbF1yGQhMYmG1Iv
         xfSxLG/m4Fr9r2CQgftqBKmtctQCK4n0Xyf8BK01Mkbt8HYAS5mlgP9olxx4Q/IkKCc8
         aOow==
X-Gm-Message-State: AOAM531h1Tzr/GIeFK9WL6s29jJ6pbdA176WcT0EuUOwKGLnLtmuDxzW
        hWiPrLt+AgCtYZyNJfDWpsHuRmdicAwb2/1dLx6swCF8kXcVfA==
X-Google-Smtp-Source: ABdhPJxVCtr1Qk2DR4aZ+67YZR9w/UhIsXfeMx88gFc3qOjhoOl8hBfoxwSaoJmh96aAKuh8IYnKQUrcopTh9/OTbsA=
X-Received: by 2002:a05:6402:c81:b0:410:a329:e27a with SMTP id
 cm1-20020a0564020c8100b00410a329e27amr9390148edb.142.1648161981266; Thu, 24
 Mar 2022 15:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <957b1f70097b44c3fba4419bc96c262f720da500.1647539056.git.jof@thejof.com>
 <20220322174506.GH12643@twin.jikos.cz>
In-Reply-To: <20220322174506.GH12643@twin.jikos.cz>
From:   Jonathan Lassoff <jof@thejof.com>
Date:   Thu, 24 Mar 2022 15:46:10 -0700
Message-ID: <CAHsqw9vLyN25wW9RU0prxHnTKSBOEksZx1rmK5hrsHYesNUfNg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Add Btrfs messages to printk index
To:     dsterba@suse.cz, Jonathan Lassoff <jof@thejof.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 22 Mar 2022 at 10:49, David Sterba <dsterba@suse.cz> wrote:
> So this is just a change in how the printk API is used, right? With this
> patch we don't need to do anything else in btrfs and there are some
> tools that can generate the list that's in patch 2 and post-process it.

That's pretty much what this is.

The goal of the printk index is just to capture the format strings
that developers are using to send things to the log, without requiring
any commitment or expectation.
My main hope is that this printk index can bridge the gap between
upstream changes and users that just want their regex'es against dmesg
to work reliably.
Currently, anything that calls directly to printk() just works and
should be captured by the printk index. However, this printk index is
built at compile-time, which is why some changes are required in
subsystems that wrap their usage of printk() with other functionality.

-- jof
