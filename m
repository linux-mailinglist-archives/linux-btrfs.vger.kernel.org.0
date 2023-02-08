Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA5C68F83C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 20:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjBHTnG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 14:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBHTnF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 14:43:05 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18201ADD8
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 11:43:02 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c2so22187630qtw.5
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Feb 2023 11:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buUlIB1de3O+KoPQ04ldqpMt/Ayhevlxc8vf1w4UaiA=;
        b=Lbzd+W6B5whGJs5eYDFn23LWwqiZjp0f32Orh6vfRDH81F6UecmCGZmPdsopk0Wp5v
         UNuqHENib56SInwoul074F6UYZzzf3pHfyghLWe/XVDYpQww7m6doq9FVT1mgtllm3Eg
         RKvYhSQdajNOZUMjG7J7wRt7NCAxn2aP3LlL32nEEH3s07Tu+CG9W4B9D2mwAUyfl79t
         BTY3MmbJEBl8YpL2ozhkWGcxk+pupbd5wOMhVrJ1KnLHjKwS3MSpX72cj8w/mvUTHCeD
         3jNJq3TXhSPBY+EbLBNkYNwUB+3L5kXklwy8JKOANGytQAQLspQHx+N5hueZ2WV0si4R
         O9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buUlIB1de3O+KoPQ04ldqpMt/Ayhevlxc8vf1w4UaiA=;
        b=2TYpQ1DkKBEX+rhPkcSTU8zcF05Gj0M5od2Q1DS0ZRju7snKeTS/C9ib7Gz8idI4wZ
         UZqwpHzL69qiWUBPqPWJwiGThtOhM7sDIYzbmaCjGLuDzQtp0NPI8paj/Wz5r6Im+iYk
         OpSgooXAlpjHnFiI7H/stVPSH161gv8+JNwe9qZOviRSUeziWegtiY82R/o/oTEEGgFM
         /83ksiMOD0HYtJNvGcLgYLcqhNQgazywoS8e5eXf9XsZwdVy/h+/Pj6wWcF7nezG1Wzl
         phCCdHYHLh9fLg2eRzFtFhBfn2IJXL7mtz3zGeB5fytahL884fYqfrZdWduoS4qh7NCf
         68zg==
X-Gm-Message-State: AO0yUKXAJXiIucfEec6N3MFnxzhpFaZlkRwiwgylyUx7G6bUF7flp23f
        Z9+lvfVCzz6Mrz30QvDFD6SrhA==
X-Google-Smtp-Source: AK7set+utO1ZQk3IanCNvJ0dVxmt5z89mEfNmx2oHqaP8oNsOjlwogVGEK1HMBfJNBJdVrBG3rt6yA==
X-Received: by 2002:a05:622a:1314:b0:3b9:a586:374e with SMTP id v20-20020a05622a131400b003b9a586374emr12791320qtk.67.1675885381884;
        Wed, 08 Feb 2023 11:43:01 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id fd10-20020a05622a4d0a00b003bb50a9f9bbsm2535417qtb.7.2023.02.08.11.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:43:01 -0800 (PST)
Date:   Wed, 8 Feb 2023 14:43:00 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 03/13] btrfs: read raid-stripe-tree from disk
Message-ID: <Y+P7RLhzkrq/r/2r@localhost.localdomain>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <5898b85677c784bf6af4e3a18d61bf261af3141a.1675853489.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5898b85677c784bf6af4e3a18d61bf261af3141a.1675853489.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 08, 2023 at 02:57:40AM -0800, Johannes Thumshirn wrote:
> If we find a raid-stripe-tree on mount, read it from disk.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
