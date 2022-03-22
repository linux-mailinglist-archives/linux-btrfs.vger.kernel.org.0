Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D104E36B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 03:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiCVChF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Mar 2022 22:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiCVChE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Mar 2022 22:37:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CD81CFDE
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 19:35:37 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w4so20028224edc.7
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 19:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9U+Osd0Ywd7K3Q5dzjNP1l5cw5z550AZ4vENcKfoJTI=;
        b=hPhRJKwpCtvaJRJ5ORxoXh/YpcExsBn6BCoOQ1fC5K3xC4ibXYRa/+JIiwpG7UqQnl
         og3vOm6xY2vogsMHLP2MND6ONWDDrhj/oRlPKWGMQ+OJbEsw/tiVhGhkeQ3mdifI4zG5
         cMFPD2G32t5pVc7oQD6XJDUck4f2/nbDY0/4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9U+Osd0Ywd7K3Q5dzjNP1l5cw5z550AZ4vENcKfoJTI=;
        b=wYlH6uhAQemWC5f8fWQDPqnLASxC2BkqQbEcnAg25gHjrtJXV553UCzWrd5QmanTRj
         0k4irKzsiR1VzUwirKOZ1LGHEOCfNW7+GDipXqyl1jO7IrhwrUjfFNohyWXaSK8hppP+
         hA9Slcm0JwDfFD0Gy7bqfXuqsNzUHKBWO7ChxZe7q/Lo2dyKxKzbJpf3HmNUdtWDStS7
         Vhuo84nSc1KIQXu732hqHKN0PuclAezRVJQeJJ5IfP53s8/bpwZ8H74rmYOOx9IkFDNL
         BXsbKH1uQOFnibZQfrUP/rr4EqvdFwIzWiBpUOpOUwMS/YdSNfFT7ta4yX6PgcgTLYTx
         yhRQ==
X-Gm-Message-State: AOAM5317z8hKX37fCABi2/OzmEUhwN70fria0a7Nut8xfdd6yS6T8SB/
        TpA+wsXXdLVPGfd8NmG3AncGL55bowUVdrL6JUSi+w==
X-Google-Smtp-Source: ABdhPJwAWZr4dSQPkIi4kcb7ZF+mdJ/97ynQL1DHvgNE5S0Npt9H/NohER38+Qxw8+xN+RkulppxmTdJDfyIMWPo7Ec=
X-Received: by 2002:a05:6402:207a:b0:419:3e9f:494f with SMTP id
 bd26-20020a056402207a00b004193e9f494fmr8125843edb.397.1647916535965; Mon, 21
 Mar 2022 19:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647894991.git.dsterba@suse.com>
In-Reply-To: <cover.1647894991.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 19:35:25 -0700
Message-ID: <CAADWXX96p7Np92nJfVTd-yWbgqETyzYMC+kBbyjxmCXfi+trTg@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.18
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 21, 2022 at 2:37 PM David Sterba <dsterba@suse.com> wrote:
>
> this update contains feature updates, performance improvements,
> preparatory and core work and some related VFS updates.  Please pull,
> thanks.

Hmm. This was marked as spam for me.

Not sure why - the email looks fine, and has proper DKIM and SPF records.

              Linus
