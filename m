Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1DB53576E
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 04:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiE0CCk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 22:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiE0CCj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 22:02:39 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41A7E277A
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 19:02:36 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id z7so5683545ybf.7
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLVM5M04ogJOWvvIUakGdD/7uvbrF0wvEXO55MVQn6o=;
        b=MOzvEHzkfUJMgqFL+j5IV2q1nuRb2MtbMjiD+zYsp6mGt3oPmYgt1ld5HhMfnzHJFN
         QLeRDnopafhZuYoyUF4/3g3L3+4PF1hy4f5zaW6pgR11Jp55KfmEpxFHS7IF0fpAxLz/
         dOJtgRjUfUVbaIjMMcLgDuAO4151lQvQGYUoMjoISepzCqowRFXra3YCvTOGGLRbVRVa
         YypGj9qC05pYDyfH4UMLBTo6QzkLqjT1SSCpamnRMm417otM2duLc3CDJP2PV1coIsF/
         9nmHZcoTy4eJPdFNP9A91rnwrLoRDE73wEbL2F733jVp5lq4TkDrU2LzuDi8zOhxorGi
         /5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLVM5M04ogJOWvvIUakGdD/7uvbrF0wvEXO55MVQn6o=;
        b=PtAwmjxRVELVgqUxjhbL7R/jMotoF84DW1/OvjF7YsA6OuMDKgfYs56DkzZgYfutI5
         WVGfXBj1Ymwaigmi0yHVvDk9QK4beZrfhGYV8KKDrLSdgUkfuFxojLaxBFshuUBWQdM+
         BYTE1B8mlHzGvvcrhfg++z2VZFs6sVtOp12CIFqizjFCbu4bimQodMqtiZ1unibOY/8d
         oVBKB/bn3exkeTYcXlNBDcUHWE4Cgwupci4JYVhxgpT77LujK7594Qs6LEFW6vUDjXpk
         tLDRf1wq/L74cuLDR0dUZ+RSv9Cg5Mupp0OVbDas8oLW/ebPRHH9CO5TBxFZC1WGncv8
         KhuQ==
X-Gm-Message-State: AOAM533CKjO9vO+Z6Q0YV49AYu0oUDbiWlbplHn/o2w5eEvqtZUOR8rU
        m9o7Cuvx1EIGU+wydApNMAUN/OyQmZSn3Y+Xl4bYzaB84IRf1uEf
X-Google-Smtp-Source: ABdhPJzZJ4SKEJIIyQ1V+GQ0AHiSOcWquayOx6L9O9Y+qeoR6A2uIky13CXX7Mb+1uUiZShUvs7Z1gtchU5vCAX6Gmk=
X-Received: by 2002:a05:6902:282:b0:64d:e139:c9b8 with SMTP id
 v2-20020a056902028200b0064de139c9b8mr39788503ybh.6.1653616956223; Thu, 26 May
 2022 19:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220526143539.1594769-1-bh1scw@gmail.com>
In-Reply-To: <20220526143539.1594769-1-bh1scw@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 27 May 2022 10:01:58 +0800
Message-ID: <CAMZfGtXj2jOQBAExT5B9BfmkO0Xo1KP-TQ3fzrhz_abUcegRYw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use PAGE_ALIGNED instead of IS_ALIGNED
To:     bh1scw@gmail.com
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 26, 2022 at 10:36 PM <bh1scw@gmail.com> wrote:
>
> From: Fanjun Kong <bh1scw@gmail.com>
>
> The <linux/mm.h> already provides the PAGE_ALIGNED macro. Let's
> use this macro instead of IS_ALIGNED and passing PAGE_SIZE directly.
>
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
