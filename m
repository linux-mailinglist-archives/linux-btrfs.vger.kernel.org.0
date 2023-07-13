Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCB675248E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 16:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjGMOCn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjGMOCm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 10:02:42 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4101998
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:02:41 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-579ef51428eso6610027b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689256961; x=1691848961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7E427WUBwZ1OYZp2rOKrgG09ceOLjhc5th9ctm7Eq4=;
        b=uFmOXGWgjJVvE31oRf/BrLh1vf81Xzqah1VRLoYDzUjHj5BsQAcSotdpa2AkBsyP5A
         F9RO4PtyevZ9TKXw6roFMybWP5haxijwo5gOt53JH4laFpuKxhCFZtUgoY1y7z7M+9IR
         5A+C/6hve8piE526SCUnWphhhaWzAMU911LJ386xsziX7BWUAuMOp5kMxuI5Pqy85Na3
         tJRQohR3Ds1RUw88yNUKKKFlK1M/O1jM0+n9OMyoJVZp4Gr3qct0GrYJrbM33AsRzS9B
         n4UkNZ+o6Mwz0UENwwx5ejPrk6lrLP2KNxu2CReZp5vKVJOn86Hfs6pXQklVmvgApSGR
         h+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689256961; x=1691848961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7E427WUBwZ1OYZp2rOKrgG09ceOLjhc5th9ctm7Eq4=;
        b=f+sb9Uc/peM2pRjfX4Rj1XKr/WhokIK/3BojZRMPFeweKl6SHBXEpWs8PA7hucJWxO
         z6um3Bss+UgGxpIa8EKA3/JrlYVPjlGCz8XWEcZ0mYZz3AZGuZfXmQh4kypW/9t9Xo3M
         MtXcXR67ZRUhyAcp0xmRDlXm2UCBTbcOQMtm/zkl+4W+9ERqvYDFcJ1HdLgfqzefzEBI
         DTXg2ctqzmUxuNZAj+UR5a7He4MEZ2YjLP3drymJtL8zantF8fA91FIfAExEu5Ba3XIN
         KyVnfWrIp2A2tFzoJH9B4MokOoSTdeRPnNWL5eb0QFOtgxf67Cbuajeq/681IaQW6tye
         dFqA==
X-Gm-Message-State: ABy/qLb47lnpihyZRcLMiJxkF6kc9ENKe9zA9LqRlGXZ5zgOlogV02bj
        TfKk9gREmL+2JoR9pVOcTs0gsA==
X-Google-Smtp-Source: APBJJlF7BiDK8rpAWye0iZA8l3Bnyu1ls6hwVLxE01BFtgKpewZ5tlRHPfnQtVS05dqHIZyXJqm3Vw==
X-Received: by 2002:a0d:c884:0:b0:579:e8de:3580 with SMTP id k126-20020a0dc884000000b00579e8de3580mr1683697ywd.9.1689256960959;
        Thu, 13 Jul 2023 07:02:40 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x6-20020a0dee06000000b0056dfbc37d9fsm1783106ywe.50.2023.07.13.07.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:02:40 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:02:39 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 03/18] btrfs: introduce quota mode
Message-ID: <20230713140239.GC207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <2a0d955252c28b3652bac098e6229223f0847be6.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0d955252c28b3652bac098e6229223f0847be6.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:40PM -0700, Boris Burkov wrote:
> In preparation for introducing simple quotas, change from a binary
> setting for quotas to an enum based mode. Initially, the possible modes
> are disabled/full. Full quotas is normal btrfs qgroups.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
