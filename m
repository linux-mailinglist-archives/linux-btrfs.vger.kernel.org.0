Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46D673EA73
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 20:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjFZStf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 14:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjFZSte (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 14:49:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E62E74
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 11:49:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f866a3d8e4so5001801e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687805371; x=1690397371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv1/n2phfniMTR7fzfBDNm7NpHXtOa8amFqPDHD/r1s=;
        b=FoJxOakd/eofxqoI3pWxCqqJ4g5VlQBVkCL9LatQL05sO4bDQv1/YzQvC2dPwj4uzm
         lrZVp9DT4Roob5qxX0i2SjnVMPoD+y/vqDx/BfpAkKGZ1dCYb3ofb7Z/YbplHiILqZsn
         zuPcIPYGj07kGF55QuaMsriLSR03kg212kzLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687805371; x=1690397371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jv1/n2phfniMTR7fzfBDNm7NpHXtOa8amFqPDHD/r1s=;
        b=N8zqY+f4HGNoM2hkz7x47c5V+Ez3oAltbvtiFeo6Ylqqd+fNywP5WqOgNDKPqxlNRV
         nCdvH0HlH/8PDKKns5X5ZdFNcEirP1BJwL29bBw02OpXeHRAdUL0hBmHinqjIL868hmc
         tlnZuPfmv7WkSZ686XJ15OkV+wcMYlqVZwZa3EyIIXM2GGlKfKa3fIODwKkhGyM7nvkJ
         da5lmEw4+OIGWNckgo3UfVWJt9zdEgKzDONwzLWP6iw80wg5MtOy+FTQ8SZLBkJJHrom
         WLHJIh+Nr5dodPolK7KeMf2UiwZSUFkscUAs2+PiwDC+MaZQErctEqmJSnacxzM8e/Cl
         uH+w==
X-Gm-Message-State: AC+VfDwGEKUZA02JmzmJXe3moPYyrD/6RUhJksMpVGqNuiy1FoSl/bNN
        +Z2D1VLkYpDXwAl4ZVjEawM/7vtM4BJ1UEWFTRW86GyA
X-Google-Smtp-Source: ACHHUZ76t7ZHGS8PD723fPsL1o7SMzRFPRaBpp5UteaaPGqLIGwFY7VKJyQJdOljd5TFdMkSy4Dhqg==
X-Received: by 2002:a05:6512:b08:b0:4f7:6966:36fb with SMTP id w8-20020a0565120b0800b004f7696636fbmr19734927lfu.12.1687805371029;
        Mon, 26 Jun 2023 11:49:31 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id h25-20020ac25979000000b004f627ceb33csm1231140lfp.229.2023.06.26.11.49.30
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 11:49:30 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b69f1570b2so25232021fa.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 11:49:30 -0700 (PDT)
X-Received: by 2002:a2e:9898:0:b0:2b4:6456:4553 with SMTP id
 b24-20020a2e9898000000b002b464564553mr17200085ljj.47.1687805370152; Mon, 26
 Jun 2023 11:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687802358.git.dsterba@suse.com>
In-Reply-To: <cover.1687802358.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Jun 2023 11:49:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAxb2PQiAp5eKQmZd1=7DLA60O=+=Y3xcsvDa-N6Y+NA@mail.gmail.com>
Message-ID: <CAHk-=wgAxb2PQiAp5eKQmZd1=7DLA60O=+=Y3xcsvDa-N6Y+NA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.5
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, 26 Jun 2023 at 11:21, David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.5

Ouch. I did this merge twice.

Your pull request only points to the branch. I didn't immediately
notice - my scripting only complains about non-kernel.org addresses -
but then after doing the merge I went "Hmm, I see no signature".

And then I noticed that you do have a for-6.5-tag that points to your
branch, you just didn't mention it in the pull request.

So then I re-did it all.

Can I ask you to be more careful in your pull request flow, and point
at the tag? I did notice eventually, and I'll go make my scripting
actually complain even about kernel.org pulls without signed tags so
that I'll notice earlier (and not just by mistake when I happen to
check later)

                Linus
