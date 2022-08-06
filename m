Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8552158B435
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 09:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiHFH3w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 03:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHFH3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 03:29:51 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39680CE29
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Aug 2022 00:29:48 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id p4so2140507qkm.1
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Aug 2022 00:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=DzUluBnEg/xa31e66n/ClDwZ7pOu+S1N1s6splcrgGA=;
        b=0HO4rc/D8qNawPxmemOy/DqI0eTMuCHhRLBVOa+K7nMYEKMgmF2WVL+FKlpGJoCUV/
         5vYmd1SbQtjXHGVFDNi+zbCh326b5PjY2V+UCp/NUq6Oi1PyCylRVGRUZkNb8MX3j9gW
         cJbAgDJLKXyogOy2k0hzNTT4DaTwlbQxnIYlZMeMUQLms9UH6B6rm8DPxU4P4LF/aX0u
         ontUTYBQ4L9Uq3DNJsdZpRT45U/UYSaTfQ59c+kAD831+7stqA8DyFXqg5GS4Ug1QlgJ
         4m/KUk9vh8huAdHQnC8vX++YSEUfy+ysiLW3IIgTBhi5vj6R+80qoWECae06Q4hmaamW
         0bUA==
X-Gm-Message-State: ACgBeo1sqRhfCYbUQ8Fpmh2jI3BZ4ZpsVYQM4SYSwreD4OJ/Aj/D6HCC
        t9IsrUYRL0ZPNfJufr0vWWboe96IHa8=
X-Google-Smtp-Source: AA6agR61AD7gR3zkpdO89CenzqeuqiA/6tQf6xJFbI4Kc9C+EzLSurWW6ydAWx4gTX6IcYkmRkPC1Q==
X-Received: by 2002:a05:620a:1029:b0:6b9:714:47d9 with SMTP id a9-20020a05620a102900b006b9071447d9mr7530658qkk.274.1659770987085;
        Sat, 06 Aug 2022 00:29:47 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id bl38-20020a05620a1aa600b006b8df80471csm4500344qkb.119.2022.08.06.00.29.46
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 00:29:46 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id z5so6846697yba.3
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Aug 2022 00:29:46 -0700 (PDT)
X-Received: by 2002:a25:ef50:0:b0:671:85f8:f01c with SMTP id
 w16-20020a25ef50000000b0067185f8f01cmr8413177ybm.19.1659770986548; Sat, 06
 Aug 2022 00:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220727150158.GT13489@suse.cz>
In-Reply-To: <20220727150158.GT13489@suse.cz>
From:   Neal Gompa <ngompa@fedoraproject.org>
Date:   Sat, 6 Aug 2022 03:29:09 -0400
X-Gmail-Original-Message-ID: <CAEg-Je80F9VK_Azv8naQa_yvteQiRa6ZQ_ezt4f9rpA1h-wnag@mail.gmail.com>
Message-ID: <CAEg-Je80F9VK_Azv8naQa_yvteQiRa6ZQ_ezt4f9rpA1h-wnag@mail.gmail.com>
Subject: Re: [PATCH] btrfs: auto enable discard=async when possible
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 27, 2022 at 11:28 AM David Sterba <dsterba@suse.com> wrote:
>
> There's a request to automatically enable async discard for capable
> devices. We can do that, the async mode is designed to wait for larger
> freed extents and is not intrusive, with limits to iops, kbps or latency.
>
> The status and tunables will be exported in /sys/fs/btrfs/FSID/discard .
>
> The automatic selection is done if there's at least one discard capable
> device in the filesystem (not capable devices are skipped). Mounting
> with any other discard option will honor that option, notably mounting
> with nodiscard will keep it disabled.
>
> Link: https://lore.kernel.org/linux-btrfs/CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com/
> Signed-off-by: David Sterba <dsterba@suse.com>

Looks great.

Reviewed-by: Neal Gompa <ngompa@fedoraproject.org>

-- 
Neal Gompa (FAS: ngompa)
