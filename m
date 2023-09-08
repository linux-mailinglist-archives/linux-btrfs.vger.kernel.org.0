Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48779896E
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbjIHPCx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjIHPCw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:02:52 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFD21BF9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:02:48 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a81154c570so1370827b6e.1
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185368; x=1694790168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N9aiyO254hXdE/onfkreGaeucxRYGmHDc9VCRw0URlE=;
        b=R/AuMoVbOgl9y+xQOEg3XnIVp7xmCohEUHn4zHYSAGcVkkyitRLU5gES9wZV4509my
         mbx1udiE2tvzpohSUPHGicQXAieoJQDVv58AzGpBgGPOSYQs9FavVvRSi/MgLXYnMybh
         XTVrkxo68EFDAi/X034+BoQyBuG0/ZwUNrQzZcSe8kPtMKXGa0yPl1KwejDZICbLqDwb
         fbnXJe3+d12pnA9P3o92cEgjUGy3ZhFPIjkdbqy30tmLfwt7jS/fqbFKPbOFhgGTGFR3
         iDcKC1t8JWw70ikagYwFHUdu2hk6xsBN6pdcfIMvThDRr9zeoTLjGFY88XzmqetUhWuh
         PuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185368; x=1694790168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9aiyO254hXdE/onfkreGaeucxRYGmHDc9VCRw0URlE=;
        b=DBy0kKXUMhcBrY9kRSG1ql5nsl7tdroceoDYgqoszPR9Jig18sTKTZOX1QEHOB9L4h
         BBJtk0mZiHyfGaCvnEMxUzekWsLSZzXSBgEuHQ9QVvtnv6puSagfY8qiUBK7e22vuPfc
         TbMseytDVJr8/pFIL+gvI3Zk4fuxiX6ZiVhfgTZ12wrM17hEA0NsgzPpYHFDDRYSgjyd
         J7axruFu6a39lO93+o5/XE2eRQS5TghMttb9NkHEzUKoy23RZ3IXBHQTzN/Wo1hp9XzY
         aEWOULJpuTWQ3ZCXfxiLM0rABLRQdoV1Nr9A4BH40m+eG7gRzUnWzXvpsG8rJ1uuwfcO
         ysIA==
X-Gm-Message-State: AOJu0YzVFXJK34BIvJ1wLrz+dzx8oDxwZIlXivVfEpyRkFlzDx3xnk0D
        ZYW+WxB0P0zbht4ARiIDWgRFVfc3YSdxJgYVf3Ccnw==
X-Google-Smtp-Source: AGHT+IFExafhsg0zTtk3EGOh+UfUAJW0UYkJMBjAPviJz/Iai67Cz0fqiozt1lwag/pdTdYLAnIPLw==
X-Received: by 2002:a05:6358:4319:b0:13c:dd43:f741 with SMTP id r25-20020a056358431900b0013cdd43f741mr2305537rwc.24.1694185368190;
        Fri, 08 Sep 2023 08:02:48 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z3-20020ac87ca3000000b00410a9dd3d88sm657226qtv.68.2023.09.08.08.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:02:47 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:02:46 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/21] btrfs: remove refs_to_add argument from
 __btrfs_inc_extent_ref()
Message-ID: <20230908150246.GI1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <e4d368a85ac2405337139bdbfa4c4939a961a4dd.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d368a85ac2405337139bdbfa4c4939a961a4dd.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:10PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently the 'refs_to_add' argument of __btrfs_inc_extent_ref() always
> matches the value of node->ref_mod, so remove the argument and use
> node->ref_mod at __btrfs_inc_extent_ref().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
