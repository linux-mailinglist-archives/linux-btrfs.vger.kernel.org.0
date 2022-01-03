Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5044834A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 17:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiACQWS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 11:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiACQWR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 11:22:17 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81461C061761
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 08:22:17 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id r139so30836482qke.9
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jan 2022 08:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zxJ1QDpUGRZdBYwoMf3rRMuXWg8qHgGMbR+gHpeK7S0=;
        b=QKB/3a0xJXn9TXVA1lyIN0s/IVFP96n6Dbna8ERuvCkmirBnbhWnJU54wBHWYH5S1T
         iVQIYlWKIkljl8DAvvXNwvST8NeqPeRyV7mtjHafWaBTJSenfUtssrxTcCzp3kEHhHF7
         fNXaBk4Jyvt0F2Dx9UdWlbr/n/vDc0yge7jUCf5hTLDileVEqRTthcqiC3Ubmf1Ckyka
         NLaLBVZOAyYgYET0JMKfkCcezeEODF/4R/76RI3zQc2ss+xh6leAZddcHBaPRZ1lvoDT
         gsM69czAPynEXcFqPhTd8HSf9EFax3rfWuH0/cKcnROcUG8BtOrGDop6Pk0WYALnT/VU
         Vw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zxJ1QDpUGRZdBYwoMf3rRMuXWg8qHgGMbR+gHpeK7S0=;
        b=EN8flvB+KfqbsYMlTsoGQMklPMpZPkxsSSn+O48zajxlivXfv+ySaPWA28KpE9YfAM
         EQIRk6Hs4r1NWT5lNU0QSCD1CBc/QC4vqxsH3AcVkmaGKdejT1mdjt/84sFbazyygLtM
         7VqjghN30abLV5FP/y7NxV5mJriCvIG132w9CIUNYXa84zKYARtWc8RiBUz/HCYOqV4y
         heVHtFKdEQUSZOuVoYflBtAwMZVWU0ZQIeTCe7L2oHwBA+6b1R1LiofWliKHV2I41VzD
         LHgITdvsGAphacQqL/M+2sp6H4AHDdovHtm1tc4iMKOfWFgC+H32Q6qx22bAEodYLlK0
         LMRw==
X-Gm-Message-State: AOAM533f7rDojk4IvCHYuybcrIA38SqyKzrPDPh4oEr3GZHqKXJbWeOH
        nQuPlsborT8f8/ahHUifZxtWN0krm2dyQQ==
X-Google-Smtp-Source: ABdhPJyouNkcf2Z0fNBRUF9HhsJsd7Xi9rSH6Jbnj2xtdEnHWCjYxWfW8B4HIHxnOkue+OnH9luQzw==
X-Received: by 2002:a05:620a:68a:: with SMTP id f10mr32439867qkh.651.1641226936590;
        Mon, 03 Jan 2022 08:22:16 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p67sm25179660qkf.49.2022.01.03.08.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:22:16 -0800 (PST)
Date:   Mon, 3 Jan 2022 11:22:15 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs-progs: check: properly skip
 preallocated/nodatasum extents when re-calculating csum tree
Message-ID: <YdMit5hpCtAxlJHW@localhost.localdomain>
References: <20211224055019.51555-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224055019.51555-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 24, 2021 at 01:50:14PM +0800, Qu Wenruo wrote:
> Merry Christmas and happy new year!
> 
> [BUG]
> Issue #420 mentions that --init-csum-tree creates extra csum for
> preallocated extents.
> 
> Causing extra errors after --init-csum-tree.
> 
> [CAUSE]
> Csum re-calculation code doesn't take the following factors into
> consideration:
> 
> - NODATASUM inodes
> - Preallocated extents
>   No csum should be calculated for those data extents
> 
> - Partically written preallocated csum
>   Csum should only be created for the referred part
> 
> So currently csum recalculation will just create csum for any data
> extents it found, causing the mentioned errors.
> 
> [FIX]
> 
> - Bug fix for backref iteration
>   Firstly fix a bug in backref code where indirect ref is not properly
>   resolved.
> 
>   This allows us to use iterate_extent_inodes() to make our lives much
>   easier checking the file extents.
> 
> - Code move for --init-csum-tree
>   Move it to mode independent mode-common.[ch]
> 
> - Fix for --init-csum-tree
>   Using iterate_extent_inodes() to do that.
> 
> - Fix for --init-csum-tree --init-extent-tree
>   The same fix, just into a different context
> 
> - New test case
> 

Eesh that's not great.  Thanks for fixing this up,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
