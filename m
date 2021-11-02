Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE25B442EDB
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 14:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhKBNMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 09:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKBNM2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 09:12:28 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F79C061714
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Nov 2021 06:09:53 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id az8so8343001qkb.2
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Nov 2021 06:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kfiS2PmMzJMhlLMbYFwTfnZJKP0XIBAqCboiuL8cFHk=;
        b=rdEvdV2D1jB1oj6NyV57eDbEANnEcmTlmNn8bvzoQEj1zvcAiUMR+VTFNrTLYuqL2w
         QTdjlPTSLnibXdTcOlTponzkqBmYAtc91QBNxxBvuAOfgeLqZJMmyhV9SqqXFRk3xHlw
         xPR6VDiSPUQtPaDOgK2yfvQy54hDJMukIkTeXF/QY0AOl3uQUSYqdBQddy9uNF/nlb4a
         8XgOLXaMNA8QWlqPWYFQauKlfrZcgqgldvlBcaJNTwo8F1sgFPhyvnF5ZiA60QkKMPG9
         dD5/EJwWhM30yrImK80rzjKpqS/aohKmQF6LwhW8Jebv3gMWhDR4mE2dQm7BBEPK+BOg
         ZQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kfiS2PmMzJMhlLMbYFwTfnZJKP0XIBAqCboiuL8cFHk=;
        b=i+PiduwT3CJkI2X1L1Vggt1IVhE3ytAkWxrzWs0GubawKKPje7HbYck5zD8h/b5Mln
         3zeU+4FD+B6UfWLHZsya6qQzHlK0eIliEKrOKTmcDXbsCtBlVDWPpOLgO/lYMQGxV9qu
         IS1aQJJTvcShcd75249HtWYBueaqO3zqvLVYWvCuwc8mbmvTX9mPAoSg+cD8cFNL28m2
         SOvFKYb6YsXcgdm8MrKWCX07Mcs5zETIB/trY4xckm44oH3gtSv/MEzlewfXt3QU5hhD
         KjUN/KAMfPnY9L9DdpuEJN91pZ6PSYEto4106+rb/JM1QcJwxGL5a9edlU8odN9CvlK4
         y/IQ==
X-Gm-Message-State: AOAM530fiQaqpMkrzpwQPj4TT9/DgQ2DM6F0qytOEqJpyyg+dFJdPlVk
        UyFWva76NKJLF3Ezcq0H7wZkGYWVaSbPFA==
X-Google-Smtp-Source: ABdhPJz1ytmECcOGzY7EYG2wHiAnwo847SFkv7CPjUzRvy5ki9AEGqXd5d/re52LJQuOaZ910nqxqQ==
X-Received: by 2002:ae9:f815:: with SMTP id x21mr29437042qkh.484.1635858592939;
        Tue, 02 Nov 2021 06:09:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v16sm2312070qtw.90.2021.11.02.06.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 06:09:52 -0700 (PDT)
Date:   Tue, 2 Nov 2021 09:09:51 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Murphy <lists@colorremedies.com>
Subject: Re: [PATCH] btrfs: fix memory ordering between normal and ordered
 work functions
Message-ID: <YYE4n4+LdL/nnGpO@localhost.localdomain>
References: <20211102124916.433836-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102124916.433836-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 02, 2021 at 02:49:16PM +0200, Nikolay Borisov wrote:
> Ordered work functions aren't guaranteed to be handled by the same thread
> which executed the normal work functions. The only way execution between
> normal/ordered functions is synchronized is via the WORK_DONE_BIT,
> unfortunately the used bitops don't guarantee any ordering whatsoever.
> 
> This manifested as seemingly inexplicable crashes on arm64, where
> async_chunk::inode is seens as non-null in async_cow_submit which causes
> submit_compressed_extents to be called and crash occurs because
> async_chunk::inode suddenly became NULL. The call trace was similar to:
> 
>     pc : submit_compressed_extents+0x38/0x3d0
>     lr : async_cow_submit+0x50/0xd0
>     sp : ffff800015d4bc20
> 
>     <registers omitted for brevity>
> 
>     Call trace:
>      submit_compressed_extents+0x38/0x3d0
>      async_cow_submit+0x50/0xd0
>      run_ordered_work+0xc8/0x280
>      btrfs_work_helper+0x98/0x250
>      process_one_work+0x1f0/0x4ac
>      worker_thread+0x188/0x504
>      kthread+0x110/0x114
>      ret_from_fork+0x10/0x18
> 
> Fix this by adding respective barrier calls which ensure that all
> accesses preceding setting of WORK_DONE_BIT are strictly ordered before
> settint the flag. At the same time add a read barrier after reading of
> WORK_DONE_BIT in run_ordered_work which ensures all subsequent loads
> would be strictly ordered after reading the bit. This in turn ensures
> are all accesses before WORK_DONE_BIT are going to be strictly ordered
> before any access that can occur in ordered_func.
> 
> Fixes: 08a9ff326418 ("btrfs: Added btrfs_workqueue_struct implemented ordered execution based on kernel workqueue")
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2011928
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
