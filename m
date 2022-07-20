Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E400857B8B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 16:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiGTOqX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 10:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiGTOqT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 10:46:19 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC6F4C619
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:46:18 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c3so8040568qko.1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AEvXSiXG+LK3hGyI5/WoYX4mBgh+ZcZK4d/qzNsJMlg=;
        b=nCctB7gs29ADSGCRbvmaEYNqNIFk6eT4uf+czM1/BrHXFwiBCCOy1mL+0qaZlG+Atv
         AJKNRNV40p7N/qkJ4BNlj5LmIBpyNXu6V5PabMPGmR4JmvBElJY8GCsNEIKx02VK9xSC
         iaNPAwBIoX+JSWUvuCuMgbNIIaJlV7GQ5uhe63122dhXubejJTIHX71bSMVvBVclqicr
         ka61NX0wf0YaIuzn0YNCBP6AvGno2pld+Y2P7ASfwjTjjipRex8tg9lV66tIHZgGYdpY
         P68c4gCkLqKo4+/Y+F84Q7ifOOmfB5XYdwhUNsWbkMstmrFTytzwog01xM1m089DxDK5
         2c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AEvXSiXG+LK3hGyI5/WoYX4mBgh+ZcZK4d/qzNsJMlg=;
        b=SCiyWfh5FSkl0Q/yw/Ex6nlBqhc6/TcI5tFlzcoxKDmEm6duurl2+sgktd0iEZXUu3
         lmexHxmLH62yvlkuSoJrdLhYtP32212DTscsNH5zjs/t5Jq5TpurxcVU+khIw3QubEWp
         Uh756AkHdyWScRxfRDOLyPUOWIFQqSg+OcsPcgjf55GVUG6hhA/h5NjBrZ3h63wfI9If
         S0p3AQxvo57n1pNZVYSB1Dbu0a14unXc/7PBOAMqfJ3Co1geZ/w1DYm3eSADmLSYRCC9
         j2uC6FH2Pout1ZFPO3FrMK3AiC+t7gZzh0OTgrE28okVNTmVqCFyoevrjUMwO3E6TUM4
         XHuw==
X-Gm-Message-State: AJIora/wm0lSYtllgH57jl09yQRSfUybEiM5Q8TZBCAfNwD8/ZgRhYiv
        vcFIKdGBPLUZpCSszXWhsleajOAm6qeaHw==
X-Google-Smtp-Source: AGRyM1vL7/2e2OjnHns/Mkl4iizERNuk5/yKcwAdeFaoFvvZc81ExdlOZGlvWczFV/KY4JmfTAddMQ==
X-Received: by 2002:a05:620a:1478:b0:6b5:e085:9c03 with SMTP id j24-20020a05620a147800b006b5e0859c03mr12757144qkl.550.1658328377290;
        Wed, 20 Jul 2022 07:46:17 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l5-20020a37f905000000b006b56a4400f6sm15869192qkj.16.2022.07.20.07.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:46:16 -0700 (PDT)
Date:   Wed, 20 Jul 2022 10:46:15 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/5] btrfs: Add a lockdep model for the num_writers
 wait event
Message-ID: <YtgVN+VONGZMwu9j@localhost.localdomain>
References: <20220719040954.3964407-1-iangelak@fb.com>
 <20220719040954.3964407-2-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719040954.3964407-2-iangelak@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 09:09:52PM -0700, Ioannis Angelakopoulos wrote:
> Annotate the num_writers wait event in fs/btrfs/transaction.c with lockdep
> in order to catch deadlocks involving this wait event.
> 
> Use a read/write lockdep map for the annotation. A thread starting/joining
> the transaction acquires the map as a reader when it increments
> cur_trans->num_writers and it acquires the map as a writer before it
> blocks on the wait event.
> 
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
