Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CB05B0EF6
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 23:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIGVMk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 17:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiIGVMj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 17:12:39 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A81C2FAD
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 14:12:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b9so11488018qka.2
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Sep 2022 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=V1MPWICjNbVej9alvDqcw5ZrURtoJsrV949+/FBaEQ8=;
        b=BjHkzBZKoRPIJvwkLFDCvXN43YYDxubEuHIfBWgPqt0au5f5ON5tyn6QZxGqy5EMZq
         z2YvpKmBwyDqmbILzOrvHuI9YAI7WTuPpS4jljnj+2cUeLTZPORg5OdLqgBXuSxrYI4Z
         EMo7mYrz2S+qAfc3euniPpEYE7KxDnrKFKm/V1xPcvbQ44fErTNl3ZVYkZ9H9tjqMm6H
         Tap2FGysqqfdqZ9amw5e04BjUw9vDYJ2HbEk3DbrB5zt+Q23S0c9IJRL5dxvB7htGKHQ
         QkjkAAtVsrrCfAqH5Si8CwSyOcj9dh9zq1c+0lamuDIKFxvp1PUZN1POufVlfvh5ehUy
         vA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=V1MPWICjNbVej9alvDqcw5ZrURtoJsrV949+/FBaEQ8=;
        b=oo3fUirREKfVxDkV/BVIQmYpeoQVqTW9rfw85B+LmrO2sfMegtWuTF2fhWgsNs4uhL
         kWdp75PD8J1HAyqvOyHRyuv9YPBY07lp8CC+Af5WpYKS3gXpQKvAjy3nTOls6bTRYcbR
         xB1Fi8DQezSvD/IYhErsgbnD7kIU48vABwN2nhkWT/0i4aNva1zKHJj1XwOSxNSPdV8I
         UZGNo/eMTNLcapTD+ulA5XgcpC7EJCzKiAlGDE+K2/0m1TRoxskI/MyS9PlJI+XqqZfd
         6AhtpoM5sMHh5zn+tp+aS74a4+hzD8x465py+cHXSRO25FtQQaqw4jE+MXLm4J5XquUh
         +RUg==
X-Gm-Message-State: ACgBeo3GCAvYEwWkLB2Z0rQxRrYJeuXP6s6fZHL5gCzHm1BD5zXkfTxX
        gfZQrS766FkRoTHqHLjNKiCdag==
X-Google-Smtp-Source: AA6agR6dqO5hs1i8teqOq2Q7WHsu4pem6GGM9f+pJ4IGoEV9bZ7Z64EjMjRWvAiPHYbn6xLB5jsYBA==
X-Received: by 2002:a05:620a:24c6:b0:6ba:c24d:8304 with SMTP id m6-20020a05620a24c600b006bac24d8304mr4166545qkn.325.1662585157257;
        Wed, 07 Sep 2022 14:12:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z1-20020ac87f81000000b0031eddc83560sm14161112qtj.90.2022.09.07.14.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:12:36 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:12:35 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/17] btrfs: remove now spurious bio submission helpers
Message-ID: <YxkJQ9/CuYo8ytTi@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-15-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:13AM +0300, Christoph Hellwig wrote:
> Just call btrfs_submit_bio and btrfs_submit_compressed_read directly from
> submit_one_bio now that all additional functionality has moved into
> btrfs_submit_bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
