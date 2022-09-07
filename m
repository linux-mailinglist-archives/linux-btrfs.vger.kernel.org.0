Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F1B5B0ED1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 23:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiIGVEz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 17:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiIGVEx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 17:04:53 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6685C43E5F
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 14:04:52 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l5so11451111qtv.4
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Sep 2022 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=tL260q14vnjvd8h6wZ4315+2PR2g4ctqHjhPegXiYHE=;
        b=7AJXrAO6L9XjLu0ZAAVhRjGQFFH5y9cbsKq8og3y33xvxJ2Fi+HbK9cTTBpIjFIbNW
         rZnaF+TJZlILIMFOFYdOl6p3xqDngMh+yMtfTYSd2V1tIC2t0Xw/CgU8Ne8E6g7kPbHV
         GN6ajtqpQUHzAA40lD+7VhJlKzr3hy5gJ5WxFJjvHux50jzUbrD9OT3D4V2ejGjMPxdq
         jE25a955SK5BL9c3ILmQeapTIuFlyk737tVrX8HFU5GpjPZwyYGuljhhvQ5WGZJZmyKq
         KS66XlkQ3Xf8bapYa2KaiHTO+vLXhQ1edC90ZeNO02pXy56ZIdGw2nFH5qh6kVG9xWKh
         ezQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tL260q14vnjvd8h6wZ4315+2PR2g4ctqHjhPegXiYHE=;
        b=gEBKo6WA07vcfjF8eE3ACyt4a/4kzyfD0sdj/B3f5nGTOwbgoD5j7PT5zxfSdOdVNj
         FB8vfnI3g3BK0o4RR963sYl+fcca4yPfHKD29OIJBSzgY49I4gvOlJO8lhW6h/n005NV
         G2WypCP3E3bjvBZOEH6rnHl9wQpyVL7wtXp8Llzm1NDFz3JbYkcepkootrrZ+QjOgplM
         p0DKKwdPKAsIc33HX+hpqI1elbFm6/Y+E2wzNXyLtm3QrwTlS3UmDZ1IW5G5N7ZF+sI0
         JXEAQxg+Iq9QjqJPafxpBrt8Gpcg0F/CmePUgXJpmdurtSkHJBcHZeLoRU9fg5YZonEH
         VOyg==
X-Gm-Message-State: ACgBeo3ooDqvQkHjZoytv89A0KyXA1fQdz1I5Az/myHvXg4E6OHt00kh
        EGwhyp7WiUq4aLygQklTl+pXhw==
X-Google-Smtp-Source: AA6agR5zPI40PG+WDMG3lWYyFuSGLe6nQZTsNFYIvFPzABdVJasmRZ/4y4br8oUWq/CslElHY/NGSQ==
X-Received: by 2002:a05:622a:52:b0:344:7021:dafa with SMTP id y18-20020a05622a005200b003447021dafamr4945617qtw.52.1662584691377;
        Wed, 07 Sep 2022 14:04:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id he22-20020a05622a601600b00304fe5247bfsm12740691qtb.36.2022.09.07.14.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:04:50 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:04:49 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/17] btrfs: remove stripe boundary calculation for
 buffered I/O
Message-ID: <YxkHcQI7+EqNhsOv@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-10-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:08AM +0300, Christoph Hellwig wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> Remove btrfs_bio_ctrl::len_to_stripe_boundary, so that buffer
> I/O will no longer limit its bio size according to stripe length
> now that btrfs_submit_bio can split bios at stripe boundaries.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> [hch: simplify calc_bio_boundaries a little more]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
