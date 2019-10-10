Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 731D6D2E6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfJJQQl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 12:16:41 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43238 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJJQQl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 12:16:41 -0400
Received: by mail-qk1-f195.google.com with SMTP id h126so6105391qke.10
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PJdFlsjqpTB6rKW9GR7WNJ/9mY7i0/mp+7/AZ5rZflA=;
        b=ED2W9gBCZ5aEJ2stO6e35bOZYlgkGEUwnbK/8w+zL3rti3c4D8IglyJOSRN6Hf+7Nv
         85s1L8z9X2gz958mCY8wzxZTG1ATXQWrjrVVTbsZspjVun8O39WBxY4cS4/4qT7zLYAG
         yx5sH7L5Jz15dzivpnyjDoL9HM9vXPF60wYCzI0H34Nl+DvwCka0BnzygkQ0QNUYVGkC
         SJKzDOsN8ukIvPkTm1DgDBobld/qmcU8CRuguna+P5mcfz4IX/Vrex+K7mM6hYVg6JBU
         N1FQSblNDcy4OOOBChmTrjBVZyVW0zqQRipihHtlA8p+tC7ZkKrEKz6gBh87Ifak2dDx
         NENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PJdFlsjqpTB6rKW9GR7WNJ/9mY7i0/mp+7/AZ5rZflA=;
        b=CTP+BvhbioH1PXAUxA0Eh2EYNJdhSv7tczLMfE174Ap8VJibcy3+v8i5LLH1quYN1O
         x66QYtp04sBnpgFA+G4fl8zlpAU85OAMFOdLCkGyc46wCR5roX3s88rQJ1mAWOC5Wf3g
         h11X3R4la5DfSNaeQUUYfjrIFskJqjWr3fioTGBaMgj+lLBbpODfyueOXlsqMetjt+mN
         mRGpfICMBktUzFmhIC9ye5gU7gnzQQvZvXdR5aL0oMyC3ytjeI40d7W8i5+sq+1OHucM
         m+RdOKZiKKWPloooJynY68JIwbTx8XKbw1EYBgWmLG3CnM1CKADDxST5JlD2cyvS3JMa
         ypgQ==
X-Gm-Message-State: APjAAAVaQ5lRcW+j1Vn8MXMVlvrO8ZY0+RjpwuF+tPQ2RpjHQ8P7vIEY
        cOOw7jy7YIpGkrULn2J2uR1+eQ==
X-Google-Smtp-Source: APXvYqzIBQToF6DBgJuSSjQ1mRkq1Mb75ukSWMYyqa6yw/3pJJSgwzYTonZ76nBzjuhxB9tqVI+Bdw==
X-Received: by 2002:a37:8707:: with SMTP id j7mr10501243qkd.399.1570724200469;
        Thu, 10 Oct 2019 09:16:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id z141sm2793251qka.126.2019.10.10.09.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:16:39 -0700 (PDT)
Date:   Thu, 10 Oct 2019 12:16:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 12/19] btrfs: limit max discard size for async discard
Message-ID: <20191010161637.5tyauzyb3trb72te@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <7eed2e0ebdc4cc4a7e31c6fa7a180f10158fba0f.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eed2e0ebdc4cc4a7e31c6fa7a180f10158fba0f.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:43PM -0400, Dennis Zhou wrote:
> Throttle the maximum size of a discard so that we can provide an upper
> bound for the rate of async discard. While the block layer is able to
> split discards into the appropriate sized discards, we want to be able
> to account more accurately the rate at which we are consuming ncq slots
> as well as limit the upper bound of work for a discard.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/discard.h          |  4 ++++
>  fs/btrfs/free-space-cache.c | 47 +++++++++++++++++++++++++++----------
>  2 files changed, 39 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
> index acaf56f63b1c..898dd92dbf8f 100644
> --- a/fs/btrfs/discard.h
> +++ b/fs/btrfs/discard.h
> @@ -8,6 +8,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/jiffies.h>
> +#include <linux/sizes.h>
>  #include <linux/time.h>
>  #include <linux/workqueue.h>
>  
> @@ -15,6 +16,9 @@
>  #include "block-group.h"
>  #include "free-space-cache.h"
>  
> +/* discard size limits */
> +#define BTRFS_DISCARD_MAX_SIZE		(SZ_64M)
> +

Let's make this configurable via sysfs as well.  I assume at some point in the
far, far future SSD's will stop being shitty and it would be nice to be able to
easily adjust and test.  Also this only applies to async, so
BTRFS_ASYNC_DISCARD_MAX_SIZE.  You can add a follow up patch for the sysfs
stuff, just adjust the name and you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
