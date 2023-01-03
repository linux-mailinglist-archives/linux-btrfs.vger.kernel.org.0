Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B133365B970
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 03:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjACCmt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 21:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjACCmr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 21:42:47 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1832A443;
        Mon,  2 Jan 2023 18:42:46 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4a0d6cb12c5so90979267b3.7;
        Mon, 02 Jan 2023 18:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32k+QjSjRemO1Tg1qPMKeRirDDvyrIZsu/E2y4bsDvw=;
        b=gk055MnKT27dmB3faGo9GCuEYWLARzwIq/X4I3WFw8nHK0XjNMIjzXIkMULtWhfNuH
         Fqude6ZVGVz/2Fpwm8l1I3tn7PzQD+QHS6Oq0F3o67uH3z0Xyt5VlEG1aL7UAjD+MBNg
         APUeQnKZv4ibpuT7wgkv7BXVbPn8zjBmhbc4UxRt5qbpcWR3JUMMo71P9iHEL7YAIf5b
         WMyyHLsq0BxDcZjdElAGmd/0A06yg9VYmqEKJVLlDtHgeI3OmdbmpxRGO/1Iuc3yM4mR
         9jD4tF0eRSzq/ai2JXt+XtEuTIW5qOvF+MRjs5tBnW+1E9FsCEVJftN3SKsMYy6VYX3e
         5PMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32k+QjSjRemO1Tg1qPMKeRirDDvyrIZsu/E2y4bsDvw=;
        b=kaBzodehXneSwn7xUVh8JiQCoQYYJ9DDv/1ZZz1U/SfC1is42bcoFbRMVXRbOs5JHE
         lodGrTAPN5IJRZzHePVZv7lDndC9SHbnpthfVEwYB0NXsmc8tNyDANqnb4+zsJV1yP9D
         KOJLic0CkwrpKmjCzoH88P8P2sPXE/ZcVVIbX+PyzJi4PlQ+ML1fH925p4s5CsmHaj7R
         /2eE/KrDJzvjsVZ1r0iyajr8YhhakO7+9hhl09dgkey+fZl5FRPQmDmFF9XSEXrF5TgW
         9pUzenTiCJt8W1Q2yAIYnSCwu0tTGmWFb4eN7ypwT3A6JG4DFQn5IaKWRY4kFcn6/snH
         KTxA==
X-Gm-Message-State: AFqh2krVtxfld7btxsVu25QVZWydiwBACbgApIGAjZNV2mNmqWBvHoHG
        x4OW4mBA9/5EOlgFBnQ0jNV0P4yoS7MFLTsTGxgLIsKQ/rwpDQ==
X-Google-Smtp-Source: AMrXdXso50CtecjrLjnnc2WB6PMMYjvBwKnxRH4/b6ktlhYQ4/pFCnHwqU/dS28j0HkH/hX/wz/DY+8veMjQl0qbS1M=
X-Received: by 2002:a0d:c481:0:b0:4ad:7104:1f66 with SMTP id
 g123-20020a0dc481000000b004ad71041f66mr267784ywd.53.1672713765970; Mon, 02
 Jan 2023 18:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20221228040447.3566246-1-zys.zljxml@gmail.com> <20230102150357.GF11562@twin.jikos.cz>
In-Reply-To: <20230102150357.GF11562@twin.jikos.cz>
From:   Katrin Jo <zys.zljxml@gmail.com>
Date:   Tue, 3 Jan 2023 10:42:35 +0800
Message-ID: <CAOaDN_RjW1UZn5Zmiqr1Yc7mTazb=GRCMv_k7zhsOukmOT=PQQ@mail.gmail.com>
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

I will send a new version soon. But I only find 5 such conversions in
fs/btrfs. Could you please check it?

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
