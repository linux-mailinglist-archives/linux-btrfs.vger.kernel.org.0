Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9B1379F06
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 07:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhEKFO1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 01:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhEKFO0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 01:14:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF0EC061574;
        Mon, 10 May 2021 22:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=92vbIUnZWAAzNpY967Q6Gm7dIUmOdX6k9EiMXw1tTKg=; b=ttzagEansgjXWY/vsH58Pyp6AX
        vg7t4xB5Pz58MVHJO2nA37pw13znKkgtP5SHXBW7etr7Eg7dWXMHkvdw9bSDgfyE+mhsRUiknwRcJ
        nnL9D3p183JaQo94WBhc5LLgneKKSa4D05K6YposgJFQXjalzb3pSIh/54qty6MJLLXPTp2gl0jYm
        oYv2+ShfIL1CVWMXM++3HWHgS0OxwDV/4p1gPG7n3SoaKVzQJG9mziPHEm6lfsXMi1baHgLiUU3bo
        SQcJfSRxR1x4+jeQnzC5MBsr33K53HJBZj20206NSWzC0j37vZcg5MLCbMhL1tn15BJlLO2ntd9DN
        7MFtF6VQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgKhr-009JM9-Eb; Tue, 11 May 2021 05:13:19 +0000
Subject: Re: linux-next: Tree for May 11 (btrfs)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20210511133551.09bfd39c@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <56cef5d3-cfb4-abe2-1cbc-f146b720396c@infradead.org>
Date:   Mon, 10 May 2021 22:13:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210511133551.09bfd39c@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/10/21 8:35 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20210510:
> 

on i386:

ld: fs/btrfs/extent_io.o: in function `btrfs_submit_read_repair':
extent_io.c:(.text+0x624f): undefined reference to `__udivdi3'


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

