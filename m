Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC5E753C09
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjGNNtT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 09:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjGNNtS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 09:49:18 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BBC3595
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 06:49:16 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b9af1826b6so1449648a34.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689342556; x=1691934556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoTMB/N5t7MHXy0+x2nL5IVn7+MR89ZhD4DHO3A7NsE=;
        b=BhbmMM42r4In5YZeAvg8Y00TGWedQmk791zRvLwAYPocn2gl8mtoupYhvfeGPqeM6v
         WZwwere5jJZOrkdwQeY8i8KEo2uwrjDHNKnOvZw4MWxKAISux6nbR6sKZJqBsTvuVgrJ
         ahBnFsRygE+JjiMs8pN/+ZQzyNlv+Vqj3SdXRiIV8H8WQARf29SlRjkQymESjt7jqYkF
         InN65Jfn4eDPnIDbCiRITv0tJ2FH7gt5Qg41aKnrdqWR21r6/SyL2TGXqTHPqE3/9fK7
         PgL6TW6BBJ8SD2Chsqdi9JhTLuyHMZmzyNNAKOe02uykYgSv70W9kRiFokggl5YT1ATJ
         u07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342556; x=1691934556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoTMB/N5t7MHXy0+x2nL5IVn7+MR89ZhD4DHO3A7NsE=;
        b=DmJ4XOwwqi1zXNHpMSGVIIJOenXdk4offtqSYNxAHywsZVMnQ2U0X33w4qzFU3a6BE
         JoRw7Bvl82FehUHxZRxPWnZAz8115HxrSWySf1Mdp0/3s3IAuWrjLL+KGwS+T8ZqpRWP
         oBKH+n3td4P2b5c500SW292Xy7gZNgmwXvtI0g4Qnkg6oIznQwUQtuZhrcFEwLbqzi72
         GHGysVS22ehmJo7aWoVFoOCbvAL/fS1NJGD0OmDKS7zQtHyl4vKlrlt7meK6FlFKzn2r
         VOkdncPD5PT8W//xvZzSNn8Xa2/iVMgXmuDwBg+oLyrwnGwZqlgSNzLo7v2t+tC9hXpf
         E/oA==
X-Gm-Message-State: ABy/qLaScd+10KKt0UEbkzTZzrAuKEfGW9Yknx0oHVuGMo1XgETEyFNT
        NNeziMkzo6fEuU9OzyqAkEMhhA==
X-Google-Smtp-Source: APBJJlGlNiux+dTU5oS/hSa+6d7Goi7MnP87WV0F7QUkq/5OkmhxVmH+iYC99ICU8VjYiu5UtWEM4w==
X-Received: by 2002:a05:6358:4402:b0:134:c850:e8c5 with SMTP id z2-20020a056358440200b00134c850e8c5mr6825934rwc.19.1689342555681;
        Fri, 14 Jul 2023 06:49:15 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m67-20020a0dfc46000000b00579e8c7e478sm2309695ywf.43.2023.07.14.06.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:49:15 -0700 (PDT)
Date:   Fri, 14 Jul 2023 09:49:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: btrfs compressed writeback cleanups
Message-ID: <20230714134914.GD338010@perftesting>
References: <20230628153144.22834-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628153144.22834-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 28, 2023 at 05:31:21PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series is a prequel to another big set of writeback patches, and
> mostly deals with compressed writeback, which does a few things very
> different from other writeback code.  The biggest results are the removal
> of the magic redirtying when handing off to the worker thread, and a fix
> for out of zone active resources handling when using compressed writeback
> on a zoned file system, but mostly it just removes a whole bunch of code.
> 
> Note that the first 5 patches have been out on the btrfs list as
> standalone submissions for a while, but they are included for completeness
> so that this series can be easily applied to the btrfs misc-next tree.
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the whole series.  Thanks,

Josef
