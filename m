Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEC6274446
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 16:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgIVOaT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 10:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgIVOaT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 10:30:19 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35145C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 07:30:19 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c18so15681102qtw.5
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 07:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nuE+UVvGmsiUeUtO54lri2EG0O8Dj8CZHQJf7wViwjQ=;
        b=CF72Nzv2BOp4sm93Q4Pi1YjKoltpkNg0Q/pIu2bQZ+E8ivN44PmkcMfZxpjqSJnmh2
         SyaXHKd5urOYUPvARO9TGF54czsoH3KDVXaXSlIgpOJjvcOYGFDOF2SjaZ/yiGOPQNk/
         wKB/sFzQ8/WnG1HH8DCJaQLAU0J0KHTPf1TQy1nRKx+/WpY4RQnI7UfnX/HNJFvvLS+p
         95xElFXGA+I18Y5anfFAhpGreLrlmshmsfMnQABSH0Hq2z4cgD25pUtqmhEfCzx6PVk2
         l2uJPhz6+oCnyUITh498hRFpiuTuvpKb9lY8BAdlhDF4OTr4QphP7otdVO3/Jzd+5oOu
         EaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nuE+UVvGmsiUeUtO54lri2EG0O8Dj8CZHQJf7wViwjQ=;
        b=q7TqdEEazKYKD/QEwpm73ZHBKrArWnHePezQhycpa+9I/CtAMt7KETXWtIPlAtMVkJ
         unUQXRZnq/+P95Y7kWK6uBi5lDrTE0PwGLMBUqvh0hQCRSsib4gZzeASoGhbklrOwspL
         dALYJ2sEpF/WfqzITw1tH0gLStVsqpnkWrNgWIB/9h44SGrYhWrklONUD/qK4N9/Ur7M
         II/CCrviEAkx4Wj7gxNqTgIqE7Avxd6Lbt1nLFtrwzOFw/8L820EKsp0O/tNLC34qQXC
         g4wX85d0QtpNaP48KF0Eqtu9AfqSgnOuEOOCDGNTefIqi1Nl+r27b8SXaRpFMFEVfKpt
         889g==
X-Gm-Message-State: AOAM533UkzBE7JqrxbOojTqPIJVkeIm2vR7yNI6HQ74oND5R/kXAh6+u
        a+nLFVRHxMkHfNyoxO9dpNw2XA==
X-Google-Smtp-Source: ABdhPJzjRPwRfVLrM0NoZ9Qs1LlsjWlpzn3zWlJ8s371HacGtldUvqpN68V6QXWDAFW1yILf3gD4YA==
X-Received: by 2002:ac8:6916:: with SMTP id e22mr4822647qtr.141.1600785018426;
        Tue, 22 Sep 2020 07:30:18 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u55sm13370887qtu.42.2020.09.22.07.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 07:30:17 -0700 (PDT)
Subject: Re: [PATCH 06/15] btrfs: Move pos increment and pagecache extension
 to btrfs_buffered_write()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-7-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8baa65c9-5867-01f0-b324-c216c86671ce@toxicpanda.com>
Date:   Tue, 22 Sep 2020 10:30:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-7-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> While we do this, correct the call to pagecache_isize_extended():
>   - pagecache_isisze_extended needs to be called to the starting of the
>     write as opposed to i_size
>   - We don't need to check range before the call, this is done in the
>     function
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
