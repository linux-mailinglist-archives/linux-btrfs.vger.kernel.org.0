Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A04968C76A
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 21:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjBFUQd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 15:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBFUQb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 15:16:31 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888C72CFE1
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 12:16:04 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id sa10so7199128ejc.9
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Feb 2023 12:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T19J8kPZvf44xpubhvHPdVZxRQSXthgO97ymHQtN7Xc=;
        b=RjTO6MVzi55KUoms9dNcZXd4wKVbxuQvKmBG1or7HZg/j68skbpB/PoiBdKdgmUq1l
         TRZO9khr8i6KLeAPidoKodjfXTQhtJni/WNlG9eABWrQWUv6z1oWv5NSMySWYit2uJq+
         E2ZglfsGURJVxpYMZ+EnejJ7VR52aq+JwS2RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T19J8kPZvf44xpubhvHPdVZxRQSXthgO97ymHQtN7Xc=;
        b=iJoF4m/6zWKAv1ycUWiFpdykLSXEN9Vguv6ye6j3qIEH7fKcKyFeMM4cIwHuwq6B0m
         idpXcjGaTFxeKcyuw7usZiV875dCCjyI4juzmjcAgGz0ZLMb+rK5YtTYaYqub/k1Xre4
         9zwG7td816Z4Y2U9/WzIOPXXGv9T2o+ut5jscaV+7F3oc5nUC/rP5NM+iCjWfQlTFYvR
         MZYNc3zbC013t+OEctvN/Hi1dvu7+3sLepaUHqKJjqtSynQc5zeTaw6PdZrCM2lmORkm
         UIm+/xJVJOfal/UbylLLxzHhYDgtBZZXdCkjMicNk92CtTN1N9nlTgTjsGSpQwkA9d1r
         v70Q==
X-Gm-Message-State: AO0yUKXAzXBsbooR2EoOdPj7+KGDjb9/5E0oFKAUVdagOV5hOb2zfg01
        uQJNwlJ13KPd/oKWsCejayR2RdP14sEU848kH1X3UA==
X-Google-Smtp-Source: AK7set+nPTWIo0BnhfyYlwJkq6yB+a41g7iSv0ukNVP6mLyXnnwt6hKWZIjhe2MID57uqrvDJ1PGgw==
X-Received: by 2002:a17:906:4a93:b0:88c:4f0d:85ac with SMTP id x19-20020a1709064a9300b0088c4f0d85acmr494689eju.77.1675714559528;
        Mon, 06 Feb 2023 12:15:59 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id rl6-20020a170907216600b008775b8a5a5fsm5833151ejb.198.2023.02.06.12.15.58
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 12:15:59 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id qw12so37654636ejc.2
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Feb 2023 12:15:58 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr166430ejw.78.1675714558652; Mon, 06 Feb
 2023 12:15:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675710734.git.dsterba@suse.com>
In-Reply-To: <cover.1675710734.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Feb 2023 12:15:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wge=yaJ47XewZ0n4EbOLh222M8mCjjmhZji=n--3eyupg@mail.gmail.com>
Message-ID: <CAHk-=wge=yaJ47XewZ0n4EbOLh222M8mCjjmhZji=n--3eyupg@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for v6.2-rc8
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 6, 2023 at 11:55 AM David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc7-tag

No such ref.

I see the unsigned branch 'for-6.2-rc7' but there's no actual tag there.

Forgot to push it out?

             Linus
