Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555D7718774
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjEaQeL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 12:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjEaQeK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 12:34:10 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA358E51
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 09:33:51 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-75b015c0508so392307685a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1685550830; x=1688142830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfNa49T3eGpQtBM+JMx0eDLj9CX1fjOkQArtJf6g2vk=;
        b=4z9DGU73h7wlngR7wa5i2gEjBUQBp56c8wiDvAbXgcXfCDdPp/wMFeta8z24BBagtJ
         FO+hkopGN4XzMo9NlbZec+OeXraFlKytUpFULOdEI7hUKta/7vqT8UoZ2QznSvIzKz1U
         xVCpVGE3LxO5h45cSRrPK+KtPT7jGGZoYMnW7vIk1Sbdtr0Fcn0qzef4KNH8o7HPlRIx
         tkO5byNC5RJQYWBOsjRmk3O5Pwytg5nVhYwH994pZuJtTvbzqgKoM4hbYSX51N7DZ10n
         y9hgBgcbEeyVD+I1OXRukE2bTJtcyCWgOBQ6Zi4jWdjLJCF2ExgsPpMH/cBxwCM6t4b7
         ms6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685550830; x=1688142830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfNa49T3eGpQtBM+JMx0eDLj9CX1fjOkQArtJf6g2vk=;
        b=bi4GZe0ljSJAj8YTnnxMjx/dtyVCaBJnchofJOGJOBaEU1mzvavznkXpJzgp3MLtg6
         2xsqLaUYr7BPi9wIdDnO70gZSPFwZBmqh4IP2/1Vd9k5rGcyVnEmedeIlp+qnnXNeR0T
         40bbNKIQQ5lWcGl8HJ9D3kMjkrb1O/gNT3MyAuu5D7WIZJMENpJHO96197Y9oO6dGDdl
         ywg00s2XXXK5U+RBy7LB5lM3nDfN85/nX1nAedk06auUf+wzaC7obg8G8ihR23cZAvai
         0AJE3/T7089OtvSwcEb2Cy0So1M6zgnFy9A52fcN4Dlkh5NPj2HmyZ8YODuVmBn7LDZV
         w4mQ==
X-Gm-Message-State: AC+VfDxdQAmE1m7K5hpmh7NULe/aGQvPIXzjG2xmPG/JnI6C7lRorAC8
        xiPp7GnlUVegyHTRAFvCIbhFzpGxObPPFea6S5XuGg==
X-Google-Smtp-Source: ACHHUZ6w8c8izhD/XDgTWDpkB4BQZph1JdFSesnh/npaLjYpOo+Vw/3Tke4zrmHyqAJnV3zDAhrb/A==
X-Received: by 2002:a37:586:0:b0:75b:23a1:3649 with SMTP id 128-20020a370586000000b0075b23a13649mr5459013qkf.10.1685550830448;
        Wed, 31 May 2023 09:33:50 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f25-20020a05620a15b900b0074df70197a6sm5330447qkk.109.2023.05.31.09.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 09:33:49 -0700 (PDT)
Date:   Wed, 31 May 2023 12:33:48 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: add an ordered_extent pointer to struct btrfs_bio v2
Message-ID: <20230531163348.GA2884256@perftesting>
References: <20230531075410.480499-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 09:53:53AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds a pointer to the ordered_extent to struct btrfs_bio to
> reduce the repeated lookups in the rbtree.  For non-buffered I/Os the
> I/O will now never do a lookup of the ordered extent tree (other places
> like waiting for I/O still do).  For buffered I/O there is still a lookup
> as the writepages code is structured in a way that makes it impossible
> to just pass the ordered_extent down.  With some of the work from Goldwyn
> this should eventually become possible as well, though.
> 
> Changes since v1:
>  - rebased to the latest misc-next tree with the changes to not split
>    ordered extents for zoned writes
>  - rename is_data_bio to is_data_bbio
>  - add a new bbio_has_ordered_extent helper
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
