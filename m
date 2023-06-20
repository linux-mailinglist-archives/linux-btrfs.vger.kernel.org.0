Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669007374CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjFTTA7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 15:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjFTTA4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 15:00:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0881310FE
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 12:00:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-985b04c46caso752357566b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687287653; x=1689879653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bdyV9dLq2Mdij79/U8UvPIgVPaaCjQd3mFspTqiTiFo=;
        b=dbCzpzWvqbq7pFQGqasieuRvpG/rA0UJ+2Y0VFJN26UilFZKWI9Z5nXP8Y7rDSAtqF
         Lzt56q3epeOyZWxy8kzMNHM3siWOvLLcowfuDax3AabmkBYUk1W39MbPwpQUb3KwmuEL
         KVDtz12BmuIjcrmbg2/OzxgiOfQiWNcEnLLsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687287653; x=1689879653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdyV9dLq2Mdij79/U8UvPIgVPaaCjQd3mFspTqiTiFo=;
        b=RvXjWCInL4+nRncFybBNbB3lxiNiV+eQvs0alfWc84k8mykXWsftFQ/4FOySZ/Hfz7
         5oS+pxp3OrDVSs/bzlqZFnYI0un3h65X2GOfVwQfGttE0whVgvL5Klmd2+YBlsIiK7QY
         b6fwxPn1OEGYJrkiPvTGbAp8uJAtY62EiDnHk9hlWcJuX6ot+SM7mck+7OzmfBKC52r4
         ZzzhvH2uSTKKJnEvukRB2DEPKHPCiqwrZG31JZxISLBRHCEMuDE9CPqE4yPgilG9gtGy
         x5Q9pKHa7f72oqWwmhbeTx3xi0V6KKCaYgD9ZYKDTTGH6wc0VHVZri3YyrHNTX3S9CyR
         McdQ==
X-Gm-Message-State: AC+VfDw5pr40ARQILrqW5k2Ol7CC02lz4JGLgTy42huYfQvU8Q9HVidd
        YidtW5XLpu1aSqtWgeyLg/qqraA1Qzosme8qVjrMaw==
X-Google-Smtp-Source: ACHHUZ5t970HzH/pZM6eWPRoP9QpC77CrI669qLTi0PzyuFainodn13Tv4YzbRe2zY6Zs5kCx1PmYQ==
X-Received: by 2002:a17:907:26c8:b0:94e:afa6:299f with SMTP id bp8-20020a17090726c800b0094eafa6299fmr13062394ejc.22.1687287653285;
        Tue, 20 Jun 2023 12:00:53 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id q25-20020a170906145900b0098503ba0db4sm1885373ejc.149.2023.06.20.12.00.52
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 12:00:52 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-987341238aeso609794566b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 12:00:52 -0700 (PDT)
X-Received: by 2002:a17:907:2d2a:b0:988:d3e9:e61b with SMTP id
 gs42-20020a1709072d2a00b00988d3e9e61bmr5116880ejc.73.1687287652336; Tue, 20
 Jun 2023 12:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687283675.git.dsterba@suse.com>
In-Reply-To: <cover.1687283675.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Jun 2023 12:00:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whH1oW+bFGxbWOdfkB930fZMm7maKywgvpKXkWXmQi2zQ@mail.gmail.com>
Message-ID: <CAHk-=whH1oW+bFGxbWOdfkB930fZMm7maKywgvpKXkWXmQi2zQ@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fix for 6.4-rc8
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 20 Jun 2023 at 11:30, David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc7-tag

I think you forgot to push the tag.

I see 'refs/heads/for-6.4-rc7' in your repo that contains the commit
you mention, but no corresponding signed tag.

                Linus
