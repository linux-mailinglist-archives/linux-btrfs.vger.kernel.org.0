Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2714A5A9992
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 15:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiIAN6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 09:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiIAN6k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 09:58:40 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C4F22B1C
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 06:58:38 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w28so13430048qtc.7
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=yXvziJnPDDPBI3tnu2gP2xPtn/bLX5mj1b/qE9y0CHw=;
        b=2f/ClYv1gIoLQ449DLb3hmlBi5CkCXpXiVA4rtM/nIf+xt0ylYjS3OvK/VVpdtkDJu
         cNjmDSdzn0VHxrYezjTB/jpkQ+l6w8NlkUeLLnDqrm6NVZD2IRvEogvHYScoRuy1thSv
         0gApsnOhZBAuqeu+LuqpEQHiHKKjWOlSASdiMubhciJu9p2XYlal9/PSyq/DgwYxQK7B
         veGnCC9CDcCdqW/CrgTTVwIxrPUFGwPpkUmVYYwDg+hD8AdAh7RwLX56ot9afFKtGlnM
         KrD66lvSAeWhP3XNSr01qm/m40/MeQgtVLDjxCKdu56YqPhfhzhONct2lF/DoUkcogMB
         +nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yXvziJnPDDPBI3tnu2gP2xPtn/bLX5mj1b/qE9y0CHw=;
        b=yJEzNTJu2/JUDIEqa8LV7IeBlTm+pUrO7cE/PVCJIK4ZRYLEYXTWOkrTDA0UG8er7V
         hPiGWN2VTSNczXrVA7CybsBsgtcD1k/QkCfRSmVH6VetDFSAWtXEeWszVcqNUvRAxm9A
         NONdpNqqvWDeM8Iv6s7u8eeHS/ZF7tsyvWQ+4z1zNgJMvuB0MX87z+z+qTeCMSvGKi0O
         sVAlmlFB4g7dTYCHEwVaut3AiEUrO2e4B84kF167eU9dnF1W+RYIBitAVcZ3FF/g31cQ
         ZCxLqXV8fpGMIeqIMebqcj2lLQkvLKdy3+inRUSwRrc2WEaXV9Kpgsz98u04Azqr2khO
         cEuA==
X-Gm-Message-State: ACgBeo3lZy5ifsn0VJDR+IaPjIxkECR5WFjJknYPGULaqZpc7198I/jp
        P19zBles5RpHnRkzoWf/PJbbuBwH9Uy2iw==
X-Google-Smtp-Source: AA6agR6smDGsebURJMlZHJ8Il1jO91J50HY/J/IassuC1oKOMdzBn1XAfvV/ON7rIcJPdjuG5wzSQQ==
X-Received: by 2002:ac8:5dca:0:b0:343:7769:5894 with SMTP id e10-20020ac85dca000000b0034377695894mr23223339qtx.45.1662040717634;
        Thu, 01 Sep 2022 06:58:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h4-20020ac85044000000b00343028a9425sm10034360qtm.16.2022.09.01.06.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:58:36 -0700 (PDT)
Date:   Thu, 1 Sep 2022 09:58:35 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/10] btrfs: allow hole and data seeking to be
 interruptible
Message-ID: <YxC6i60DtxgX1Xcw@localhost.localdomain>
References: <cover.1662022922.git.fdmanana@suse.com>
 <29ac2c59860774abb16bfb2660e0dd831d793cf5.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ac2c59860774abb16bfb2660e0dd831d793cf5.1662022922.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 02:18:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Doing hole or data seeking on a file with a very large number of extents
> can take a long time, and we have reports of it being too slow (such as
> at LSFMM from 2017, see the Link below). So make it interruptible.
> 
> Link: https://lwn.net/Articles/718805/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
