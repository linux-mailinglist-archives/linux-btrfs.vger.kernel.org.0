Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D7675298E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGMRKJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 13:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGMRKG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 13:10:06 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BF22D43
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:09:36 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-577637de4beso8709687b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689268174; x=1691860174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6i52Wah5MWKvsTfLLAwr/aI01oAHYeuM+HgSADgnt5k=;
        b=PXKcKoj70lvi4MFGOGT3EVetkFz+AC0NlT8RcZsyVjijqzGCEFARJVXYPhyAU/Rb7C
         5HF18ssNGzWhnxHgLKMYMb+rhZq3HPTm1UOtJ6JbsnW0YKKXe5rmBjtS1FwfJsFezm5f
         RmOQpoDgKqD+4lZmfpGY6urRX5lmg0wVNnjWGvtEz8Y6+8iyY59m92xMy5suqHW1i1X8
         AsPtk2yeIUcgLlFOEH7bLL91drGlYE34s/w2XbFjZOGccMRD6uoQ9n+O8vTlJ0U/7XAn
         hYniTJxZMdxnnFU0K5gtj5k/dDxUcvBlXcuGx/SrYLevPY+sz9u3kHN9dlIsjTq+Q/Jb
         jRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689268174; x=1691860174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6i52Wah5MWKvsTfLLAwr/aI01oAHYeuM+HgSADgnt5k=;
        b=AMd2Ykudrma+ZISWB829Fxz1Dih6TpJpCLhW7iVGjwzNkdVpSyz1O3mnD7EX/TmoEa
         mj3DVZyF314rqk8Bb1BGqApVd1db8kiBhlkEKSnsAXx8AVkXKLsKP3a+otvI4wisH70e
         L/Lpnm96OW5xY7RXnHxJp65E00Saz93Q36nbKmOwOFQCTWEPnkWnQvyC45FxzpiVOsOD
         sLGol9xk4MbSLvUiG+VBC+biNZwGvOjVXlp3mgGJ+M9fh3U0r+VOHR1N0c9eGwPCxFHn
         uc9EOzo3VHnYAlGcxDsOW4a5Fn/wxa52oefiYzVvYCVyAYteMgWMTCU/JWTtmoWfDvTW
         BAbw==
X-Gm-Message-State: ABy/qLYt0tSFje5cF3IR82T8EgB6A3rm1YZS1G9fH/knIgBl3Glek0P+
        mgmM4eQDwApDD5Nzrjmof57aaJtZhadT9ljvutbUGQ==
X-Google-Smtp-Source: APBJJlHi5ccl8NceJHelWbJhz781yjx7ucFLyShrczltmjrfA9AWG22PhcreUcq+n4re5uthkMziwQ==
X-Received: by 2002:a81:84c2:0:b0:576:9e6a:67f9 with SMTP id u185-20020a8184c2000000b005769e6a67f9mr2187275ywf.48.1689268174122;
        Thu, 13 Jul 2023 10:09:34 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r11-20020a0de80b000000b00561949f713fsm1876237ywe.39.2023.07.13.10.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:09:33 -0700 (PDT)
Date:   Thu, 13 Jul 2023 13:09:33 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 11/18] btrfs: track original extent owner in head_ref
Message-ID: <20230713170933.GK207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <3ab4ae0d6690a8d69cee48e107ee87102ce5f070.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab4ae0d6690a8d69cee48e107ee87102ce5f070.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:48PM -0700, Boris Burkov wrote:
> Simple quotas requires tracking the original creating root of any given
> extent. This gets complicated when multiple subvolumes create
> overlapping/contradictory refs in the same transaction. For example,
> due to modifying or deleting an extent while also snapshotting it.
> 
> To resolve this in a general way, take advantage of the fact that we are
> essentially already tracking this for handling releasing reservations.
> The head ref coalesces the various refs and uses must_insert_reserved to
> check if it needs to create an extent/free reservation. Store the ref
> that set must_insert_reserved as the owning ref on the head ref.
> 
> Note that this can result in writing an extent for the very first time
> with an owner different from its only ref, but it will look the same as
> if you first created it with the original owning ref, then added the
> other ref, then removed the owning ref.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by; Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
