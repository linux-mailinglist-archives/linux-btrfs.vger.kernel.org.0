Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294CF5FBDF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 00:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJKWtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 18:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKWtO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 18:49:14 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7BC8F96F
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 15:49:13 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1364357a691so11168876fac.7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Br1aOdu+0HvIKGR71tLPfM2hoANr+BgT3DPpmcCrU0=;
        b=QJenybZKtzWXRYI7zhSXlqbKHYaFpIo3Ip7jklH2D7OU6phpfAPRNV7sMlgQHnLMWT
         7Fth5BsJnV0dezNYthINb3VWqV7Inc1OFa0neLlJec+Phvcjs/HL2jJT9gsJ8ceJrRA4
         usze5nCYoBA0RYcpzcejAuUZKz0RXSSEbTgUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Br1aOdu+0HvIKGR71tLPfM2hoANr+BgT3DPpmcCrU0=;
        b=N0JpjmHkkrSP8NPXHwqBRpslIxO3QSECwiIZL31LO7zJvk/Dl5xhY/5Iqyjat0BuyK
         8WIIMAtfaCF8/b2SRN4CKBxSZbeOj+gqTqMAs0KLUtNzMsJCQ4tn3b5HdxRMInSFws3h
         qif+1I9KDvPZ2TUlCJe0FlqgquxDYGEE6Be5C7ceFxLyhmlhgDgPspnPt5DNd7hvl1DM
         19Al8EPVJyUIE7JcONHpTv4ibTYakBvm3bWGp6pqeFIVUKxxjQQA7l6RCdpjTCZCso95
         zVo0WAbLJs4+qH6HDi7rTiDeqXF+Ip4LK2UtEKZisieMdyfx3N4aSeSPUxVrSqyfRmDJ
         WbWQ==
X-Gm-Message-State: ACrzQf2G7Pa1gcGB23lk7V2zhRslw8gMnqd6z09iNb6QGLqUiU62SyD/
        YzLdulDpQ+ENdnHebjOi2zK4Q3HWQw0quA==
X-Google-Smtp-Source: AMsMyM5xhVF+m+CgWccNW47UMQ4Aj329/C78Y12bOu4POS5aVzPQmEg61CScTW75CHReZlVVALy4JA==
X-Received: by 2002:a05:6870:d349:b0:136:9a09:572f with SMTP id h9-20020a056870d34900b001369a09572fmr883638oag.262.1665528552677;
        Tue, 11 Oct 2022 15:49:12 -0700 (PDT)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id y63-20020acae142000000b003357568e39fsm5965514oig.57.2022.10.11.15.49.11
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 15:49:11 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id m11-20020a4aab8b000000b00476743c0743so11059022oon.10
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 15:49:11 -0700 (PDT)
X-Received: by 2002:a4a:4e41:0:b0:480:8a3c:a797 with SMTP id
 r62-20020a4a4e41000000b004808a3ca797mr1313796ooa.71.1665528551551; Tue, 11
 Oct 2022 15:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221011132256.333-1-dsterba@suse.com>
In-Reply-To: <20221011132256.333-1-dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Oct 2022 15:48:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB9sHzsNcCRRkgeyXLu09hV-FgRLwvFHoA_uCpZRJJwA@mail.gmail.com>
Message-ID: <CAHk-=wiB9sHzsNcCRRkgeyXLu09hV-FgRLwvFHoA_uCpZRJJwA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update btrfs website links and files
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

On Tue, Oct 11, 2022 at 6:23 AM David Sterba <dsterba@suse.com> wrote:
>
> We have the new documentation hosted on Read The Docs and content is
> migrated there from the wiki. Also update http to https and add the
> tracepoint definition header.

Hmm. Did you intend for me to apply this as a patch?

Since you normally just send pull requests, I'm a bit confused.

Is this a "it's outside the btrfs subdirectory, so I'm sending this as
a patch"? Except I've seen you send stuff that has changes to mm/ for
new exports etc, and in fact to MAINTAINERS too.

Or is this just an informational "let Linus know about this patch" email?

Anyway, if you actually want me to apply a patch directly because of
some "I'm not going to send this as a pull request because there is
nothing else pending" kind of issue or other reason, please do state
that explicitly in the email.

Because as it is now, as explained above, I'm not sure why this patch
was sent to me.

               Linus
