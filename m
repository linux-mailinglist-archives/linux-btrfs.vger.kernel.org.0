Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F8165B97F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 03:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjACC5D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 21:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACC5B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 21:57:01 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB3763BF;
        Mon,  2 Jan 2023 18:57:00 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id n78so31733712yba.12;
        Mon, 02 Jan 2023 18:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJ9jQQLOHKUeoD2MjrzWkeFuLpVavsyn745Xv7NtXJw=;
        b=P99+XAJNKeKUIHcwZx+629Bn9LKwwFqNpYLwFuppMWrWpa7Ea62S7yczVFQNzKM27d
         ndxZHiNeobTlaY2f1bVzMSdd9Sp+d1mDM6pA6bfHxWvze5+KvH6+4BdGw6WRFeRjW19O
         F5rBBu7qTtgugBg6XwdTUNl6rZQmw3depdR4sZVPcxaHBghZSaYETZaB8rjWj/gEvs2u
         hAjbhk4cIev5XLLJwF4gyKoSYRhyd4Z/xcdGmwD0fJwB9EpP1nB2GdLSl1qBlPkwd73C
         rcY16PC/wXPvxNV1R3xkjAUwIyeyhIE/iwJxzAAuTrg88Mvg71QQr1bnU+IRtgnwhF4o
         1WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJ9jQQLOHKUeoD2MjrzWkeFuLpVavsyn745Xv7NtXJw=;
        b=taQzYvtKpQb63BVJ5DOPiB2kQONcGLhQ7AC8+EH11bQ89+5X+kgvGY0SvipgaU/0e2
         qTluWybq5g19YqFjb2Xo+dueVSt+nnmXWmBXRUqKWMzhAHa6+WGZD4ksWmu171E9/HIA
         qHCaW0lHkI5Mf6Zh0nKCEriNeYbOluljrt2E7zwUYGzFLLICkKxmvMSQc7h4uDu3xA0r
         IFcSvZIwclt+nJ8zqVBjrUhgKUD14eJu5JW8p5e9mBBREZiSc2lNxy+xCRELyAS1ntPm
         dyyiJQMhzb3ZAvZYBdFqmL/X3sni6KcJf0UCHB0T1P0BpXdGmL8pQN4v7LmPhv/VMOLe
         1W1g==
X-Gm-Message-State: AFqh2kpDYh8BiUQzJwB00FZ7u/yRQ8FOQbkJsjh7HUmH9i73PkGs5CE+
        0chpV4FwS3DW9s7k8A5Ih1qFOeDF27bkJETGv2A=
X-Google-Smtp-Source: AMrXdXviT6wBbOCJSobvbRMv9U9K+mO2nodEZvqmvWZeIwZDpMAKnxFzqJTwJrgg7BSnQIp9DOA29aJvVKN60W8L+KA=
X-Received: by 2002:a25:4288:0:b0:762:7ce4:2288 with SMTP id
 p130-20020a254288000000b007627ce42288mr2710500yba.303.1672714620217; Mon, 02
 Jan 2023 18:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20221228040447.3566246-1-zys.zljxml@gmail.com> <20230102150357.GF11562@twin.jikos.cz>
In-Reply-To: <20230102150357.GF11562@twin.jikos.cz>
From:   Katrin Jo <zys.zljxml@gmail.com>
Date:   Tue, 3 Jan 2023 10:56:49 +0800
Message-ID: <CAOaDN_TK=0VGwbHBy+=+D_tOgsHyR=xmAuV57muF6MZQcX9RcA@mail.gmail.com>
Subject: Re: [PATCH] brtfs: use PAGE_ALIGNED macro
To:     dsterba@suse.cz
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The macro ALIGN(addr, PAGE_SIZE) can be replaced by PAGE_ALIGN(addr),
and the same as PAGE_ALIGNED_DOWN.
Do you mean that? I will send the third version and modify the commit
message a bit.

Best,
Katrin

On Mon, Jan 2, 2023 at 11:09 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Dec 28, 2022 at 12:04:47PM +0800, zys.zljxml@gmail.com wrote:
> > From: Yushan Zhou <katrinzhou@tencent.com>
> >
> > The header file linux/mm.h provides the PAGE_ALIGNED macro to
> > test whether an address is aligned to PAGE_SIZE. Use it instead
> > of IS_ALIGNED.
>
> There are about 8 such conversions in fs/btrfs/, please fix them all.
> Thanks.
