Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDEF6F2620
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 21:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjD2Tyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 15:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjD2Tyc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 15:54:32 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C71BC2
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 12:54:30 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-552d64d1d2eso17916317b3.1
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 12:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798070; x=1685390070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSpzDPpTAh98vTojhkSS6UFAJ2Y+YqOTnWZ+bYo7rc4=;
        b=vSjBjLMFdC4iAYQk5CjUS8bZcnGtU8I95g1XHV5Fjd2A3hjnSQagCN5w5d9TX/NAjK
         tZqxFOTBQBNZ+ANulq8BreZFSxbx9WyTKTPB8fsIa2vIYYjjpr7xBxus0evJbd21Ochm
         X/SnaSHN9c0Mru/zx8rA/hssnqPObj6EjRl1aTprBtnaGaY8kPPWy14cxd3nyqoOldDc
         3AVRreNPDXHT/3nTK2TEf2qx9zyOlgzywfM2t0XnIHAjwrRvPfniTTyGiy4vCG6ie7Pn
         0LRV/mXk9AkXzJcpFC2hXvAheqn+lDW550xZZ7+g+wEAjUSDYf/wzTXbyeqKhbfxQjOK
         cAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798070; x=1685390070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSpzDPpTAh98vTojhkSS6UFAJ2Y+YqOTnWZ+bYo7rc4=;
        b=RiKZWXO813+bl5qCJ65yJEfChTxgspPjXmHionAE7VD2BkqakmFdsA22Xa57asLU9C
         JChvNmyB/RreGFR76LQ7P7UC+zN+nsm9LmvU0tcOhcLQElvmzpPH2Uj2FDTeJ0Xnx1aJ
         q1w8cXX2iDDk8ft5iGMP3iBizMmJwLe/0lpPvmVl8+knIz/d20Rajedve2/hvfVBRCes
         udYjWIX/pNEgIezT6wGh4ieddJvK0KgMJG6+aUoi9Ql9ipCnnvhP0UFY4+YYbMMno5SU
         K8PpzULeYNRp0E1Qhmj7pLNAXfjYWP+jp4sy+oQDTsX27VHFFCoqCERdm1RKjm7FlUDB
         1Y9A==
X-Gm-Message-State: AC+VfDxcdWMtPHU/fMgYubzgpvz68zJi++OIpMjIZHsuAlgjJ+AxVzlj
        8gfmyPiJ6fRSVs7UWm1y2Dz6rQ==
X-Google-Smtp-Source: ACHHUZ5f6F0nbk49qnarFNlnEFvm2oin/F9gH+x9duY43kOJZyAwdBicdecjWC732c9/Bg7nYbYt5A==
X-Received: by 2002:a81:8787:0:b0:555:cee3:d143 with SMTP id x129-20020a818787000000b00555cee3d143mr6757704ywf.4.1682798070009;
        Sat, 29 Apr 2023 12:54:30 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b10-20020a0dd90a000000b00545a0818487sm301725ywe.23.2023.04.29.12.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 12:54:29 -0700 (PDT)
Date:   Sat, 29 Apr 2023 15:54:22 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix encoded write i_size corruption
Message-ID: <20230429195422.GA1455986@perftesting>
References: <e340cd5aef01df9826746dab5a74cb2fcce19a8e.1682714694.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e340cd5aef01df9826746dab5a74cb2fcce19a8e.1682714694.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 28, 2023 at 02:02:11PM -0700, Boris Burkov wrote:
> We have observed a btrfs filesystem corruption on workloads using
> NOHOLES and encoded writes via sendstream v2. The symptom is that a file
> appears to be truncated to the end of its last aligned extent, even
> though the final unaligned extent and even the file extent and otherwise
> correctly updated inode item have been written.
> 
> So if we were writing out a 1MiB+X file via 8 128K extents and one
> extent of length X, isize would be set to 1MiB, but the ninth extent,
> nbyte, etc.. would all appear correct otherwise.
> 
> The source of the race is a narrow (one code line..) window in which a
> noholes fs has read in an updated isize, but has not yet set a shared
> disk_i_size variable to write. Therefore, if two ordered extents run in
> parallel (par for the course for receive workloads), the following
> sequence can play out: (following "threads" a bit loosely, since there
> are callbacks involved for endio but extra threads aren't needed to
> cause the issue)
> 
> ENC-WR1 (second to last)                                         ENC-WR2 (last)
> -------                                                          -------
> btrfs_do_encoded_write
>   set isize = 1M
>   submit bio B1 ending at 1M
> endio B1
> btrfs_inode_safe_disk_i_size_write
>   local isize = 1M
>   falls off a cliff for some reason
>                                                             btrfs_do_encoded_write
>                                                               set isize = 1M+X
>                                                               submit bio B2 ending at 1M+X
>                                                             endio B2
> 							    btrfs_inode_safe_disk_i_size_write
>                                                               local isize = 1M+X
>                                                               disk_i_size = 1M+X
>   disk_i_size = 1M
> 							    btrfs_delayed_update_inode
>   btrfs_delayed_update_inode
> 
> And the delayed inode ends up filled with nbytes=1M+X and isize=1M, and
> writes respect isize and present a corruted file missing its last
> extents.
> 
> Fix this by holding the inode lock in the noholes case so that a thread
> can't sneak in a write to disk_i_size that gets overwritten with an out
> of date isize.
> 
> Fixes: 41a2ee75aab0290 btrfs: introduce per-inode file extent tree
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
