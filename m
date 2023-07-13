Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5A67524AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 16:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjGMOLE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 10:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjGMOLD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 10:11:03 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9CA2711
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:11:02 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-570877f7838so6820247b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689257461; x=1691849461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RV2ohCtDzd3MzDNoRkqKbXeR0HHVKgopXssN7i0i0Y0=;
        b=bXC6A9yAYNxeO8FPp/rVyiIJaey8g+Qcu/t2co12G75IQTJcQ+0xHDNzvaJa4J7wgf
         SEQFCUpR4teQPEHNCWFQK03cORSOPPtRgtOkS+YX0t+DbyoYg0j/+hR75qvfTfB4lScp
         fGhtmIKFoUG2Akku3e0SU9Zau6clM5+wbDzEhga7CxkZxe5mekmJRPRR+4c0k3U2TYTv
         F8/baIMvf3lqjeW2WK+lxH70jXjSwQLXBHsj1Gtc7m/uin4T9SlK1OG/kxxMjhQrhGqN
         1F3aur9ZbgKTK/jQ/Hq9hZYBMzU2J2hn899m8WUPcmmebv6wBGlterjNSOGPupYw9b5I
         NcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257461; x=1691849461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RV2ohCtDzd3MzDNoRkqKbXeR0HHVKgopXssN7i0i0Y0=;
        b=dOsthnyRHBAaLtQmnW/ZqyazpHE8Yy6mHDsjVLNXPRUaPXLrGbkR93DXBVCEQApQJq
         lJxRLNTomGS21Wd6sVKnRARLLCMySCu2YlVgeNdBOa28tB48z4IcUgsPYRhEyY4amJ/Q
         sIziYOUpMjKjbVMx1MNlbBuGogyOveGwKd/h/1oVC76oNFXgn1g1LVJMww6jLuWXP2Jq
         bSVYUHPiuqTRLr73npSO4iWSv+bZcXfU7Yx5XolPx0KWif4dtdmkQpa7LTE/KHnBNMIl
         Iqbaf779aDbwfKmHDDbNarsfr6vby8RKIsWuSwVsEb9T4RSRkK2Je4HLwHEnGCFckNE5
         il3A==
X-Gm-Message-State: ABy/qLYlnGTJdNQb/EsztsIF4tBfY5IvRPwtX3Ai4vS2xgD78TEuprH7
        70jYmrlfZCTm42KR57B9g2Od5mPOWorcc2ncGbw2Qg==
X-Google-Smtp-Source: APBJJlFZOsjD6Mj4/Ie1MM7RNC+aWjeU8bqQxdxSD6r3aipZBULHlxvHpIwSXYFQrvxGO4Wa2LQWYQ==
X-Received: by 2002:a0d:e8d5:0:b0:576:b999:3d75 with SMTP id r204-20020a0de8d5000000b00576b9993d75mr2027625ywe.14.1689257461269;
        Thu, 13 Jul 2023 07:11:01 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z62-20020a816541000000b0055a931afe48sm1784204ywb.8.2023.07.13.07.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:11:00 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:11:00 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 05/18] btrfs: expose quota mode via sysfs
Message-ID: <20230713141100.GE207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <0628cfee8bca3506127b46ac49ee4e2603f081f0.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0628cfee8bca3506127b46ac49ee4e2603f081f0.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:42PM -0700, Boris Burkov wrote:
> Add a new sysfs file
> /sys/fs/btrfs/<uuid>/qgroups/mode
> which prints out the mode qgroups is running in. The possible modes are
> disabled, qgroup, and squota
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

but you should also include another patch for BTRFS_FEAT_ATTR_INCOMPAT() so it
shows up in /sys/fs/btrfs/features as well.  Thanks,

Josef
