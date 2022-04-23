Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE75D50CC54
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 18:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbiDWQjE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Apr 2022 12:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbiDWQjD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Apr 2022 12:39:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3339011A37
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Apr 2022 09:36:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h3so14583632lfu.8
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Apr 2022 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qb5Szh+CcKy2SBrVNCKts80EODHTuY3uc2BaRSQms88=;
        b=DY1qADisgv4bdnv5TOJXAoTsHGxPnzMJtTUEpOVn3Cevi/YDTmZqy13LyQ+f7Fzr8f
         BDsGuSh7cddzLWLWnuMvJFflGmiSd5+Ou/nCN59b52nfewu0XF6gU/hq/w0YVaKtMhOi
         nAuo0+xpgMEeAUbjsbMs9AtgbjUdaSu4QnUeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qb5Szh+CcKy2SBrVNCKts80EODHTuY3uc2BaRSQms88=;
        b=fQm3Q5/Bpqtwdrmm2T3DPiZh6Bk1DSpgYKa7J0g02FIvtu4za2lm9sDtgiWntRXlxc
         CVVoEhrzqyJbJPRj5NQDC1A7GqJZLLlYQICDlv+SM2tmJsAti6BtDXYjgn9pHfPPcSZi
         RdaQFV61MVUnnlpHcRGu5pXzvXvkM7nCA5ugJh49ni1nTiRsYVkFrBmx4NUP9kXfiLf+
         IhkAi/no4+z0n/q7JBgCg28Z/9YkOw6q30WeJNh56Ia3Rz5F8jG84VgJa7EAq/DVGwKF
         zdv2oybb9lS4L6ksYicfYsKs+7n8tqEhoLdI8trXCYW3pSC9cVKuZ8LOQY4sDJBEUNvm
         AqOQ==
X-Gm-Message-State: AOAM530pIhrL3lvC7aTxA6VqDzcsQ1WBk/hzqv+aIxxZrChHijb5G2cx
        9yV19dRUYqBxwfBBziJ4FkD7Qfot1xiq1ICk
X-Google-Smtp-Source: ABdhPJyZOGnM84dnAH5Q5cwepeXrpCWiFiA59VtzhbxDAqVgcpTHOeQPgLs1w364YM0KnxaAV7P6kQ==
X-Received: by 2002:ac2:4107:0:b0:44a:3084:39f8 with SMTP id b7-20020ac24107000000b0044a308439f8mr6827180lfi.209.1650731763126;
        Sat, 23 Apr 2022 09:36:03 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id bq5-20020a056512150500b004433c791651sm675897lfb.69.2022.04.23.09.35.59
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 09:36:00 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id x17so19292469lfa.10
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Apr 2022 09:35:59 -0700 (PDT)
X-Received: by 2002:a05:6512:6d4:b0:470:f48d:44e2 with SMTP id
 u20-20020a05651206d400b00470f48d44e2mr7148386lff.542.1650731759019; Sat, 23
 Apr 2022 09:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220423100751.1870771-1-catalin.marinas@arm.com>
In-Reply-To: <20220423100751.1870771-1-catalin.marinas@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 Apr 2022 09:35:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgafGgBC9JEu397YxFD8o8qiCZHQS+f5i+BSXOkOFqX3w@mail.gmail.com>
Message-ID: <CAHk-=wgafGgBC9JEu397YxFD8o8qiCZHQS+f5i+BSXOkOFqX3w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Avoid live-lock in btrfs fault-in+uaccess loop
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 23, 2022 at 3:07 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> The series introduces fault_in_subpage_writeable() together with the
> arm64 probing counterpart and the btrfs fix.

Looks fine to me - and I think it can probably go through the arm64
tree since you'd be the only one really testing it anyway.

I assume you checked that btrfs is the only one that uses
fault_in_writeable() in this way? Everybody else updates to the right
byte boundary and retries (or returns immediately)?

             Linus
