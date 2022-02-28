Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A251C4C78D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 20:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiB1Tb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 14:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiB1Tbz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 14:31:55 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F2BE6DA6
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 11:31:05 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id b20so3830058qkn.9
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 11:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gJEe3NLyrOw4mQuUqYefdQS6R+CB8EnDh4mrUp8pW+4=;
        b=rx9250IC3bJFE3uy15SYRBIyeQ3VjRPjwZiuz5rieizJTrKvyWsLFsFpJbS4QYJ1jw
         LY2umQs2zRV1J1rrDxPR/Fm1m9JiC4u3AqDs3Tj5BBO62vbreOTGeq3mL+XVZbGnAC6N
         wfUg8wCMfcxxM+KiMCAOVhevofIulal2GSnW1Zi5YmboBU055F5lUOwmTHsYOPd3jhtv
         miJVQUM0roEerQZ3ulsuyVQAt7STY1y/FGZ7a5EtjKf689yj+OvGkyvcOsi6lMZq3eG7
         923gRSuNWYrkokBZZHwuwFUflm6AHIQEdXTKMlgbRJAUpCmUTIpEff+2aDI62n4/Yz0f
         tXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gJEe3NLyrOw4mQuUqYefdQS6R+CB8EnDh4mrUp8pW+4=;
        b=ezFqe2j17pLYqnoRR4nCueOq9M5i3zaNmezLXrVWh8qtm0h4yP+49yRZdUspzbdYwd
         9/s4xK1ug7+WWJ9nu0tmxIFOcJZlWDJm3jKd/sSWDZcSg/NtJ+fdu5DQEIUFsWW8AmQU
         4jdV1lPUOypydwjFFb5vdmC/mZntGkYCQnvIkWJVRJ5qbSIk87pB/FwSbXrGHACVMvHF
         6BF5WCwmSlUe8K/rAYozuvbYdHI0mfy0ajBu/u1a0mYgi8PTdK2OkMhbMSM8EOj/a6Ag
         rU+1/C/1Le2uxYAhEnlb7a8ud3mXpjOjJ9Crx9jwnEe6NEP+bhsX3a408mJaWj3Hi1We
         wvAA==
X-Gm-Message-State: AOAM5325T9LT+KeLwe/AB1Ww+gjKAm2G5eWKZxet8+yj3Ti/T234W8/f
        wfBsGVavhP1nLojDFjaU3jh/yb8RH+Ow/kSk
X-Google-Smtp-Source: ABdhPJygRMH902Xs4mO49KMpUQR5zUHvkSjSVAZSErUTyo7mjJxHzQqz6Sb8XwRFWue7Lnv87TCeMQ==
X-Received: by 2002:a05:620a:1221:b0:649:5c0e:b34e with SMTP id v1-20020a05620a122100b006495c0eb34emr11721355qkj.6.1646076609691;
        Mon, 28 Feb 2022 11:30:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s8-20020a05622a1a8800b002de08a30becsm7404984qtc.80.2022.02.28.11.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 11:30:09 -0800 (PST)
Date:   Mon, 28 Feb 2022 14:30:07 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v1 0/3] btrfs: add sysfs switch to get/set metadata size
Message-ID: <Yh0iv8qO9I9k3N7Q@localhost.localdomain>
References: <20220208193122.492533-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208193122.492533-1-shr@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 08, 2022 at 11:31:19AM -0800, Stefan Roesch wrote:
> The btrfs allocator is currently not ideal for all workloads. It tends
> to suffer from overallocating data block groups and underallocating
> metadata block groups. This results in filesystems becoming read-only
> even though there is plenty of "free" space.
> 
> This patch adds the ability to query and set the metadata allocation
> size.
> 
>   Patch 1: btrfs: store chunk size in space-info struct.
>     Store the stripe and chunk size in the btrfs_space_info structure
>     to be able to expose and set the metadata allocation size.
>     
>   Patch 2: btrfs: expose chunk size in sysfs.
>     Add a sysfs entry to read and write the above information.
>     
>   btrfs: add force_chunk_alloc sysfs entry to force allocation
>     For testing purposes and under a debug flag add a sysfs entry to
>     force a space allocation.
> 
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
