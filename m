Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E565894B2
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 01:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbiHCXOC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 19:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiHCXN6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 19:13:58 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44C55C9E7
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 16:13:54 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-324ec5a9e97so101265937b3.7
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Aug 2022 16:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=i7doGwK1R4TnC0GzxSFbM/dA5wFRSzV6X/9XA49IIkE=;
        b=Tux8aYCuwAkW5BV2rMw6oqiyeYfP03yb6T6R02TlsEzU/IEWw3gU9Yll0Iir0ibwq8
         LevR0FW9hieJJR2ZoBv7zNo+A80Ki41xvsRXXrt4SxM9auRLYolEcE19FGNrMGujh8yR
         ly3N8TEsBGIksNrLr/6M2nF3CHbxjpHLcF6yiYDV96LHxT1rjqDvgFTgF1BP0m171D5S
         WqABqSQ+ulaBfPlFf0hdEBQUjppziXewsBxQ36tPFU2pl4ykFR3nug/2l5tJ/Wc7Kp5d
         5gBz8JdwDgMCIZj6qb1SecY7/6TN7ku693WnmTetOMo0K+KhqPYs7h7a9ZRStsOHQinR
         I5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=i7doGwK1R4TnC0GzxSFbM/dA5wFRSzV6X/9XA49IIkE=;
        b=3orzy6FP8BhG68Y+qggXCMhTr5kJLkllcW5fMdv4/M+b/5eOaOPYxzeLE5kudsMo9v
         ljv6or31SyS9dSSvh6LmF8W7gMwUg+UPdcWoFPgE5Gq4QNe7HqUy+xFv77KRYp8vnUey
         lEQggHBnM8G/7GmgzkMxGLufJWIhwzK7CB/E5rlt6p8na6C3tk1mNbEdLbHBuiGxdIyJ
         uZaXz+J7jL8h9HF5nI2dPuBkQOakmKAB9h6kEiNHFPeCAxkg1DUVx+Ksq136Q0dXx2+d
         AJwBQYsJC1XpbxNtsdnb5E8TI1fnvoSQkDWnyKIh5U82FnrkIqVoiLUEoQTH66T8ses7
         393Q==
X-Gm-Message-State: ACgBeo06660rY8a0MLiVJUkaSzNHWMIrR9xH4yzNlGLUDx5Cke217dQE
        ktmJXNEq9PO9enRM/LzZKHq+ymhoBBNr2xT54+iap+miIpv6mg==
X-Google-Smtp-Source: AA6agR6boSmRSOz/E/LMBP/NjqcDwzhgpMtsASKbexALK61TmsLN88qUYOjOjiQSsPLcIHbffkHDzp9Cv992tbchqyQ=
X-Received: by 2002:a81:6dd3:0:b0:31f:4a2c:d41c with SMTP id
 i202-20020a816dd3000000b0031f4a2cd41cmr25000544ywc.349.1659568433549; Wed, 03
 Aug 2022 16:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHs_hg1NTbSsoev93y0Sx6NguVKndR+d410yZzbMhii2ipaBcQ@mail.gmail.com>
 <CAO1Y9wo_HcouRuOa8b7+2bXwZJOHNiy9PsxcYxsQAZ8ggvTxzw@mail.gmail.com> <CAHs_hg3_KFLSC+kMpT+cbKuhUCJqwaYWcWL7R7Q1xT9_-xWvvw@mail.gmail.com>
In-Reply-To: <CAHs_hg3_KFLSC+kMpT+cbKuhUCJqwaYWcWL7R7Q1xT9_-xWvvw@mail.gmail.com>
From:   Thiago Ramon <thiagoramon@gmail.com>
Date:   Wed, 3 Aug 2022 20:13:42 -0300
Message-ID: <CAO1Y9wo=5d4seXt0PxHNTvtJt=LDa_8FoK0YQETrX-nG8n35qw@mail.gmail.com>
Subject: Re: Balance fails with csum errors, but scrub passes without errors
To:     Martin <mbakiev@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Had to dig a bit through my IRC logs. The command is:
btrfs ins log -o $((block_group_start + offset)) /mountpoint

Eg. from your logs:
  [Wed Aug  3 12:13:26 2022] BTRFS info (device sdn): relocating block
group 103549454516224 flags data|raid6
  [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
root -9 ino 257 off 6809305088 csum 0x26262de7 expected csum
0x0473ecb8 mirror 1

You'd do:
btrfs ins log -o $((103549454516224 + 6809305088)) /mountpoint

It'll say which files are the problem. Chances are there are a lot of
files, and starting the balance after each one might be a bit too much
trouble, which is why I suggest scanning all files first. But if you
got lucky and it's very few files, just doing it with the balance
should be fine.

On Wed, Aug 3, 2022 at 7:03 PM Martin <mbakiev@gmail.com> wrote:
>
> > I've had similar issues. There's 2 general cases which you need to
> > find and correct: actual csum errors on file data, and csum errors
> > outside the file data (AFAIK only on compressed files).
> > The first one is easier to spot by reading all files in the FS and
> > logging anything that throws an IO error. Just running a find and
> > cat'ing the files to /dev/null should do and list all errors, though
> > you might prefer to use something more sophisticated to log and resume
> > if you encounter any problems while doing it (might stumble on some
> > kernel BUG while doing it).
> > After you found all the actually damaged files and dealt with them
> > (ddrescue or just deleting them), you are left with pretty much trying
> > to balance, getting an error, finding the responsible file from the
> > offset on the error message (it's the offset inside the block group
> > being currently relocated) and then just defragging the file should be
> > enough to clear the error. Then just resume the balance and continue
> > on to the next one...
>
> Do you have more information on how to figure out which files are
> affected from the log error messages there?
> Reading all the files first seems unnecessary if I can just use the
> block group/offset to figure out the damaged files.
> Using `find . -inum 257` points me to a file, but the entire file
> reads just fine, so I suspect that's incorrect and has something to do
> with the "root -9" part of the error message.
