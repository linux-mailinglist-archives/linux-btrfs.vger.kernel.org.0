Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30B357B8DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 16:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbiGTOs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 10:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiGTOsu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 10:48:50 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65DC52E59
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:48:46 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x11so7794975qts.13
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gXxLdOu11tS05MIJBioO50lsp0yvNv11hpVUDyhQIBE=;
        b=QKTnHf1QeNVX+bnppygq1OFyjU3O9DceqtYMy2WQut+tqp6vsNDJqJsVIxsMwPXXRk
         NG3Mp7dMCNVrAuVA3dK0yN2PXzbexsSR3YaRxAIvLmgMBVlikx1n0ofM18RIZ79YdXWc
         lTb+k0Hp/NSF1tjEN91vTrZZuJq5GzT1YsSoO7BUykaAHqJZ234AZfkQLXI5ayzoeIsl
         gOD0BD8qPuZ7GK14sWTZXgcda7t084rZ12rjGnwbvaQme2cWPLVzXb8vUaBbO7uoj0yk
         gwtCjP2Vo47EpkEK6i4LGSPDF2O4w+nnbKWi2SEmfdCfqWRNQmOXP4OFfQo7EQfF6ICQ
         fWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gXxLdOu11tS05MIJBioO50lsp0yvNv11hpVUDyhQIBE=;
        b=BoMtK3g2ry7qggTGBGjT1NBciXT3Y92LxeH6Mm64hKkA84nPbWrr2ehX4oMe9KI98o
         di+7T9UDBkt9NZrU25Fo679VbvWspkT0JXhdF6uKN9X1HJnQFFq2c7FB7eGpW/PHFzyU
         KA9O8owDa2okmqXHVrjNXoFA1k2xg6SzqWnWxHNFWCWo5Qe/5Ekw7BKh6kbM6DTLXr7J
         TB0LhbOiQW9mU0oflUExAwFzVG2WrTQ7Yye3R5c4NrQFQmUqtOxTq8JaSpZLRrPIhwwN
         PTlXC/TYBuB1QY/xf0keP2/9UBalUSfBn9IEuHhbFotLeuqcGZgH8vrXiG+JluAbX5zu
         tf+w==
X-Gm-Message-State: AJIora+PrBw1dZms8AGcIESuDxQkBSE+fNSthjacoxMTv3E54EbJ79+4
        DP5jea0u7uGJMR7vLoVT/K0sjeMXRrW0mQ==
X-Google-Smtp-Source: AGRyM1vLQNWedBd4kPKM2B7dgo/ibBMNWth1yjZwZ9esY6WEitXSHFf0tip7+kNU4s/yDNBelKI6HQ==
X-Received: by 2002:ac8:5e08:0:b0:31f:230:35c with SMTP id h8-20020ac85e08000000b0031f0230035cmr5669362qtx.189.1658328525674;
        Wed, 20 Jul 2022 07:48:45 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a430500b006b5bf5d45casm18264464qko.27.2022.07.20.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:48:45 -0700 (PDT)
Date:   Wed, 20 Jul 2022 10:48:44 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 4/5] btrfs: Add a lockdep model for the
 pending_ordered wait event
Message-ID: <YtgVzDFROuSZ0qF2@localhost.localdomain>
References: <20220719040954.3964407-1-iangelak@fb.com>
 <20220719040954.3964407-5-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719040954.3964407-5-iangelak@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 09:09:58PM -0700, Ioannis Angelakopoulos wrote:
> In contrast to the num_writers and num_extwriters wait events, the
> condition for the pending_ordered wait event is signaled in a different
> context from the wait event itself. The condition signaling occurs in
> btrfs_remove_ordered_extent() in fs/btrfs/ordered-data.c while the wait
> event is implemented in btrfs_commit_transaction() in
> fs/btrfs/transaction.c
> 
> Thus the thread signaling the condition has to acquire the lockdep map as a
> reader at the start of btrfs_remove_ordered_extent() and release it after
> it has signaled the condition. In this case some dependencies might be left
> out due to the placement of the annotation, but it is better than no
> annotation at all.
> 
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
