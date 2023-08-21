Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2418C782FE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbjHUSF3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 14:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbjHUSF2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 14:05:28 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE8E10E
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:05:27 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58cd9d9dbf5so50125297b3.0
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692641126; x=1693245926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CsB6SuuPDLsDh6igJIKPtm5Qg6C822eZTTEC47K+rdU=;
        b=Peh/wvof45Gy/TPXUa8q42NQt1zTrF8JdCJXhrlkDFzMiXu0Hna2puqAMjnaqLeUoY
         BoUDeWLUkuA8xl6jQQR9aqfUFXqhoNk4fkWrtINV0IbNhQhMXf63eX5rBHakaLPDLQN1
         bljGEFXMxuEhQ77Ao1CDrAZLP8MqEne+3UR02xXSnL8po1kxu72CwdhMoi3o5ywsF/BC
         jxLcmx/fNJr20Mvkq6L+AQetbV8OucZErd/KzWGZClaLgsAGozAiiXYxRlFfZMPs+bWN
         xMn8M2M55/Q/DjgGQDKRfmLkSuE219wF7nSigJwKX2jy2JVGe/j9i7qyVdJCY4VdEGs+
         dGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641126; x=1693245926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsB6SuuPDLsDh6igJIKPtm5Qg6C822eZTTEC47K+rdU=;
        b=lkf1PIPPnmg6OXiK5XXhjIDFE0d5V2JAo0PLvPGkzWYnTtGea6x6GzngO0gA39o3oJ
         eFWA5oz4pOiQOcCbW6p62WbGqDciA67jffb4ow7GaOz7QsAFulx9IwYtTGrznXiCsq6b
         SQYip5ZGGPWR46qzsB9fgO+prYg5+qVVyy4yCPrz0k95DTvrnVDRaKoAVmZlS2WaJDC0
         sHrl982I2lRNbQGGccZADIIaju0Zg8UQeJYuvEZYct/dkhWgethFTjhpiRjewe5DB32N
         CuB4Uk4u1R8s/CHBxkcFhmPgYr4Q8c+Wk2AphuZjtvo5rIdlKax51zpDxZ/j9rIzVXAd
         jSig==
X-Gm-Message-State: AOJu0YwNZr0vIBw+4+y0TAXxTOWuwt3ZtcCyuvjo1jI5h+FItLFqxbW2
        DVppCaB7p4JQvP/W8wp87hQPKDVdDsDKt5UyjaI=
X-Google-Smtp-Source: AGHT+IHONr5O39pI/0mD4ajyL6ZHCrBG3M6CHONKtF/+azbjAVblnitSXixLSGOTGklstOwFvUFP9g==
X-Received: by 2002:a0d:d7d2:0:b0:581:7958:5bda with SMTP id z201-20020a0dd7d2000000b0058179585bdamr5521126ywd.1.1692641126380;
        Mon, 21 Aug 2023 11:05:26 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l4-20020a81d544000000b005839a780c29sm2313099ywj.102.2023.08.21.11.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:05:26 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:05:25 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 09/18] btrfs: track owning root in btrfs_ref
Message-ID: <20230821180525.GF2990654@perftesting>
References: <cover.1690495785.git.boris@bur.io>
 <7f601950d5e04b4cf18e3054346f2437633775e8.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f601950d5e04b4cf18e3054346f2437633775e8.1690495785.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:56PM -0700, Boris Burkov wrote:
> While data extents require us to store additional inline refs to track
> the original owner on free, this information is available implicitly for
> metadata. It is found in the owner field of the header of the tree
> block. Even if other trees refer to this block and the original ref goes
> away, we will not rewrite that header field, so it will reliably give the
> original owner.
> 
> In addition, there is a relocation case where a new data extent needs to
> have an owning root separate from the referring root wired through
> delayed refs.
> 
> To use it for recording simple quota deltas, we need to wire this root
> id through from when we create the delayed ref until we fully process
> it. Store it in the generic btrfs_ref struct of the delayed ref.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
