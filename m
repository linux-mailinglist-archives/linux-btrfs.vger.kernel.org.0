Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8C253111
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 16:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgHZOSq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 10:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgHZOSj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 10:18:39 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30530C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:18:39 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dd12so770209qvb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SSQO6QPMe7KjkOSa9kGz1ge9QdYFrUAbw2hzD00JaCQ=;
        b=KPHnYchgGI2GSu65K9Av16y7wjFYoZZLozyTeBkQ4GwPP+m/xweRP55w6Ddom9PLm1
         FUTqfoSHH6KD0TxlQmY0v3qsNv6Xt0W27kPe6Fd7tf3AFmvAJhgvjBaw875p7QZ/YCUo
         X1s+dgvjWxJdmRFi8Z65JOePjikMs4zXs6pakH6kxVgb6RyWZjrFXcAW3XTBwY1akKTH
         fNACw7TdRG4hYTEAP/KYP3G8U/qb2H+96+UORyGRsWfCMrse59AW4kIMf7Kj/LLJPNch
         2l52D0Tj5SP0xnXQBvxXghxvnhVhoskOvoDIg4qPk4QqyF25vSFsXhR4FeJhlMgxrTmY
         MKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SSQO6QPMe7KjkOSa9kGz1ge9QdYFrUAbw2hzD00JaCQ=;
        b=h3X4Cb8UeaDzCPBhPeXQJCtJaOWhpp9Lmxt++p1U9QrM/JiQ1KFtfONosSiBIsd1L0
         137EMp/MkfaQJuwffbHtTf3HnpGJJ4zUzU6BvmxLM0vP7qUI1jadeUHdOxKQ61LfU3jV
         6NHloWelmzYtSaXEu+gIGQFosX1EtY4A8vBtsGS/BvryfpLScCoEnHTxZuaxpOfMkkqx
         5fY31JZUYtJxAD13QDfbIWMvuevu3w+17k5sgemCKQ+gV4742EQRaGAFWkdytcxI2NA1
         pryaGbMGSZKrD5hoTnP1fGh3HEpaHgDD0twI9jF3MAHg3BIR86JCVO2VIofxZ8eYoSla
         OBSg==
X-Gm-Message-State: AOAM531K7nETo6wOC9PA3idKfIqDVRTxhvKhgr9usHWYNu9ZwHtHLSg5
        wOnah/7eRIPeT1P9sRURs6+Z1Fdpa7U+4dsd
X-Google-Smtp-Source: ABdhPJwI3+q+UVh2f6n9Vfl3KFehjweQTqlF7MmEi0pxMZwfL8wRzLMp5vUwZZE80Mc+tJc1vUN00w==
X-Received: by 2002:a0c:bd8d:: with SMTP id n13mr14212662qvg.199.1598451517945;
        Wed, 26 Aug 2020 07:18:37 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10f3? ([2620:10d:c091:480::1:efc3])
        by smtp.gmail.com with ESMTPSA id t1sm1751482qkt.119.2020.08.26.07.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 07:18:37 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: Only require sector size alignment for parent
 eb bytenr
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200826092643.113881-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f047e64f-4397-2173-148c-f2fc9d70ef52@toxicpanda.com>
Date:   Wed, 26 Aug 2020 10:18:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826092643.113881-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/26/20 5:26 AM, Qu Wenruo wrote:
> [BUG]
> A completely sane converted fs will cause kernel warning at balance
> time:
> 
> [ 1557.188633] BTRFS info (device sda7): relocating block group 8162107392 flags data
> [ 1563.358078] BTRFS info (device sda7): found 11722 extents
> [ 1563.358277] BTRFS info (device sda7): leaf 7989321728 gen 95 total ptrs 213 free space 3458 owner 2
> [ 1563.358280] 	item 0 key (7984947200 169 0) itemoff 16250 itemsize 33
> [ 1563.358281] 		extent refs 1 gen 90 flags 2
> [ 1563.358282] 		ref#0: tree block backref root 4
> [ 1563.358285] 	item 1 key (7985602560 169 0) itemoff 16217 itemsize 33
> [ 1563.358286] 		extent refs 1 gen 93 flags 258
> [ 1563.358287] 		ref#0: shared block backref parent 7985602560
> [ 1563.358288] 			(parent 7985602560 is NOT ALIGNED to nodesize 16384)
> [ 1563.358290] 	item 2 key (7985635328 169 0) itemoff 16184 itemsize 33
> ...
> [ 1563.358995] BTRFS error (device sda7): eb 7989321728 invalid extent inline ref type 182
> [ 1563.358996] ------------[ cut here ]------------
> [ 1563.359005] WARNING: CPU: 14 PID: 2930 at 0xffffffff9f231766
> 
> Then with transaction abort, and obviously failed to balance the fs.
> 
> [CAUSE]
> That mentioned inline ref type 182 is completely sane, it's
> BTRFS_SHARED_BLOCK_REF_KEY, it's some extra check making kernel to
> believe it's invalid.
> 
> Commit 64ecdb647ddb ("Btrfs: add one more sanity check for shared ref
> type") introduced extra checks for backref type.
> 
> One of the requirement is, parent bytenr must be aligned to node size,
> which is not correct.
> 
> One example is like this:
> 
> 0	1G  1G+4K		2G 2G+4K
> 	|   |///////////////////|//|  <- A chunk starts at 1G+4K
>              |   |	<- A tree block get reserved at bytenr 1G+4K
> 

This only happens with convert right?  Can we just fix convert to not do this? 
Thanks,

Josef
