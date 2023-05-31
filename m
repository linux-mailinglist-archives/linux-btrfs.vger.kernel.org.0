Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533847187A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 18:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjEaQjH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 12:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEaQjG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 12:39:06 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DEE12C
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 09:39:05 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75b08ceddd1so686846785a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1685551144; x=1688143144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WkMqorMco6wXsDGobcaP2+P1weqa8NbEJ4ZSR07dGmA=;
        b=exoNeqwqXJ3HjhNYVG2g+7Q9xdCyXArkqhA4F/nKIC5exZDx7jc7EJ7Lb+xHO+PH/d
         2kpRfe2YUhDifNFidwJ0McXI7WasZAKU44SFpr0OmiX6b3otZaod3MpE/+xf8uYp/dYF
         44Yp0Q0uyPtPYHfKkdE0+kE1I8ypXvfe/0xVeT15Pn8roWbaTdgYd2JNuvh6EA09+fu3
         8+xmnZ5uD1BOCcalpuOAzmRlBC5zoY17hQFo7OXZLkMPKZVibq2pMkGxU25Gk8VskR0W
         VRplVkCC83W6g5OKOe4OaSzsHbUi+U3Z3encMtom5aoDsI70YCgWjsuIDZ7v1HXoUqtS
         LUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685551144; x=1688143144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkMqorMco6wXsDGobcaP2+P1weqa8NbEJ4ZSR07dGmA=;
        b=LECLdTdWOJDCxvIcWDH4hQISFnLuyJ3sQ0TielktAYEgpkvk7Qb/mRkPqPeOG6K8pt
         bU7sSwDxxz4TCq9Db9z2p4NlGMhMPvCdyt6qI9P/JYFeM/QT7IvFDAufyc6Lg1/LNjlp
         mGcsmj/XTwkvWs841OpgZ+7Y5L6aKrGudrYHa+/OAGl8/38v/7jj7/Y8Y3qssIX0dQ5v
         bu/SN5hfPOrVIVaknBTJMWc83jGn6WsKQhyd/Gy0RGpyvNKR+9napIj994JK3IgGbcwb
         nZ2dF43OU7kxz/baciCBfNX678X2S4vZcMZsRlrsTNg0wJisgVK0sewsf0yJEnYj2+go
         sUjA==
X-Gm-Message-State: AC+VfDworZZELCrYWxnjwNCr3p35cHpmS3N/Nbh8JUBTa9TQaaaUn0AS
        YlAbm/oXeRkHYI+y9raH6NiHt3tDgvxk/wWApttctA==
X-Google-Smtp-Source: ACHHUZ5YcO6DZbvVT7Wr7J+pyLpUsUWhEakXuD3hzx6j+U92AGqRLkp+XdN0honyS41gyO3C0rjzLQ==
X-Received: by 2002:a05:620a:8782:b0:75b:23a0:dea0 with SMTP id py2-20020a05620a878200b0075b23a0dea0mr4917421qkn.30.1685551144580;
        Wed, 31 May 2023 09:39:04 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c19-20020a05620a165300b0075b0ded49b0sm5274142qko.13.2023.05.31.09.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 09:39:04 -0700 (PDT)
Date:   Wed, 31 May 2023 12:39:03 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: writeback fixlets and tidyups v2
Message-ID: <20230531163903.GB2884256@perftesting>
References: <20230531060505.468704-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531060505.468704-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 08:04:49AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this little series fixes a few minors bugs found by code inspection in the
> writeback code, and then goes on to remove the use of PageError.
> 
> This replaces the earlier version in the for-next branch.
> 
> Changes:
>  - rebased to the latest misc-next tree
>  - remove a set but unused variable in pages_processed
>  - remove a spurious folio_set_error
>  - return bool from btrfs_verify_page
>  - update various commit message
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
