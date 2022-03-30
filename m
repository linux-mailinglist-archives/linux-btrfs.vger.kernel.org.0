Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D157F4ECE83
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 23:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351081AbiC3Un6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 16:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiC3Un5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 16:43:57 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A951242A07
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 13:42:11 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k14so18443659pga.0
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xm97QiefQSXSHctbjy4njYhuMycfLtMCJiVS3CiwNwI=;
        b=GiFRb/iJfDAJXSh+bEFeV6U/9AKy8uSLyz57yYHKEbt42KrSiqBgOLY6kd4JWInKCD
         4+7Zv3kHBmqZmA4ss6eYNY0rkwSdVuXG7cJuqDn0N/iPwWZfVt/6xjTkwVc7yLykw9fy
         xW0lsrvXiSbG3Gx9slf0lpccPnXyoOXsnstCur5r5ZqWoQYlqwSWEnI2nex3OF7u4LSw
         Gi71QHaGnbQDsSsEesLg+z77lwww6pMKiuHVN5AaSswFDH/arrP09BOkMtoMU2Wv+Rht
         d/hdk4x7HQjvGVtM38sHBTkNPOe+yMmDPzhMbmTKVvtmW+ntSJmK1NLrxamkCdwIaNPP
         pBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xm97QiefQSXSHctbjy4njYhuMycfLtMCJiVS3CiwNwI=;
        b=GKDvAeFbNWZtIj0aEkIsKnDNQY394aFG4uEMMf8hWx6G39N+/Q8BFXVLrRbaYnmCE0
         eMnsWLxA4YG4MmVuTk+aY994+cmo8cyTON6zkFeujP4nNux284txxDDyLhm+lNTKz8lv
         K+t+P8DBtDC92vm+XsbM6ZSKgBtAyZsqvcpHE1fevLEDGeo9Wt+yxJz6Y8boRraqE1fY
         5M1sjKz4cjvfGa4+AhvZImPFnWbQ5mxbTcesciQmuI7UtTLLO9DR+qpIAEU70WnH1mLQ
         tzAs2jpl1B1ofBEcqdOR+gXrPBNr4ehtf3NBoFbW4YzUXXTvmuBQellFIsB/mHZowRTO
         +cDg==
X-Gm-Message-State: AOAM532+Iuo42d20hnGMA1UVU8eT69tqOcNAU/WqzuTJTGbGqAOE8PW5
        dBN+nAYwaJn6qDXsZ1D7lAkZq+LU7PITvQ==
X-Google-Smtp-Source: ABdhPJx4+3Xhsx+xKNPE9eaRT+sHkD1/6cf4AEFA7ShleS9tVmvvpkV+D+bKkz2pkHerzLlLeIoaTg==
X-Received: by 2002:a63:e52:0:b0:382:6927:a63c with SMTP id 18-20020a630e52000000b003826927a63cmr7649078pgo.437.1648672929874;
        Wed, 30 Mar 2022 13:42:09 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:7694])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a00229300b004fb157f136asm20782056pfe.153.2022.03.30.13.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 13:42:09 -0700 (PDT)
Date:   Wed, 30 Mar 2022 13:42:07 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v14 5/7] btrfs: send: allocate send buffer with
 alloc_page() and vmap() for v2
Message-ID: <YkTAn44i6Se++wOT@relinquished.localdomain>
References: <cover.1647537027.git.osandov@fb.com>
 <4353fe7122eb0aae24e3c9ff2399f2b58b74f79e.1647537027.git.osandov@fb.com>
 <fb73fe9a-21a4-0744-2a61-bfd3602a0f20@dorminy.me>
 <YkR/QuBrKPYTwIFt@relinquished.localdomain>
 <598151ee-7a14-0c54-34d6-4591bc19fb73@dorminy.me>
 <YkSPsV0l0JV1Lx1f@relinquished.localdomain>
 <9b168d90-e0e7-459b-36e1-ea5cbe23c8ea@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b168d90-e0e7-459b-36e1-ea5cbe23c8ea@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 30, 2022 at 02:48:42PM -0400, Sweet Tea Dorminy wrote:
> 
> 
> On 3/30/22 13:13, Omar Sandoval wrote:
> > On Wed, Mar 30, 2022 at 12:33:48PM -0400, Sweet Tea Dorminy wrote:
> > > 
> > > 
> > > On 3/30/22 12:03, Omar Sandoval wrote:
> > > > On Thu, Mar 24, 2022 at 01:53:20PM -0400, Sweet Tea Dorminy wrote:
> > > > > 
> > > > > 
> > > > > On 3/17/22 13:25, Omar Sandoval wrote:
> > > > > > From: Omar Sandoval <osandov@fb.com>
> > > > > > 
> > > > > > For encoded writes, we need the raw pages for reading compressed data
> > > > > > directly via a bio.
> > > > > Perhaps:
> > > > > "For encoded writes, the existing btrfs_encoded_read*() functions expect a
> > > > > list of raw pages."
> > > > > 
> > > > > I think it would be a better to continue just vmalloc'ing a large continuous
> > > > > buffer and translating each page in the buffer into its raw page with
> > > > > something like is_vmalloc_addr(data) ? vmalloc_to_page(data) :
> > > > > virt_to_page(data). Vmalloc can request a higher-order allocation, which
> > > > > probably doesn't matter but might slightly improve memory locality. And in
> > > > > terms of readability, I somewhat like the elegance of having a single
> > > > > identical kvmalloc call to allocate and send_buf in both cases, even if we
> > > > > do need to initialize the page list for some v2 commands.
> > > > 
> > > > I like this, but are we guaranteed that kvmalloc() will return a
> > > > page-aligned buffer? It seems reasonable to me that it would for
> > > > allocations of at least one page, but I can't find that written down
> > > > anywhere.
> > > 
> > > Since vmalloc allocates whole pages, and kmalloc guarantees alignment to the
> > > allocation size for powers of 2 sizes (and PAGE_SIZE is required to be a
> > > power of 2), I think that adds up to a guarantee of page alignment both
> > > ways?
> > > 
> > > https://elixir.bootlin.com/linux/v5.17.1/source/include/linux/slab.h#L522 :
> > > kmalloc: "For @size of power of two bytes, the alignment is also guaranteed
> > > to be at least to the size."
> > 
> > Our allocation size is ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED, PAGE_SIZE),
> > which is 144K for PAGE_SIZE = 4k. If I interpret the kmalloc() comment
> > very literally, since this isn't a power of two, it's not guaranteed to
> > be aligned, right?
> 
> Ah, an excellent point.
> 
> Now that I think about it, the kmalloc path picks a slab to allocate from
> based on the log_2 of the size:
> https://elixir.bootlin.com/linux/v5.17.1/source/mm/slab_common.c#L733 so
> we'd end up wasting 128k-16k space using kmalloc, whether it's aligned or
> not, I think?
> 
> So maybe it should just always use vmalloc and get the page alignment?

Yeah, vmalloc()+vmalloc_to_page() is going to be more or less equivalent
to the vmap thing I'm doing here, but a lot cleaner. Replacing this
patch with the below patch seems to work:

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c0ca45dae6d6..e574d4f4a167 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -87,6 +87,7 @@ struct send_ctx {
 	 * command (since protocol v2, data must be the last attribute).
 	 */
 	bool put_data;
+	struct page **send_buf_pages;
 	u64 flags;	/* 'flags' member of btrfs_ioctl_send_args is u64 */
 	/* Protocol version compatibility requested */
 	u32 proto;
@@ -7486,12 +7487,32 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	sctx->clone_roots_cnt = arg->clone_sources_count;
 
 	if (sctx->proto >= 2) {
+		u32 send_buf_num_pages;
+
 		sctx->send_max_size = ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED,
 					    PAGE_SIZE);
+		sctx->send_buf = vmalloc(sctx->send_max_size);
+		if (!sctx->send_buf) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		send_buf_num_pages = sctx->send_max_size >> PAGE_SHIFT;
+		sctx->send_buf_pages = kcalloc(send_buf_num_pages,
+					       sizeof(*sctx->send_buf_pages),
+					       GFP_KERNEL);
+		if (!sctx->send_buf_pages) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		for (i = 0; i < send_buf_num_pages; i++) {
+			sctx->send_buf_pages[i] =
+				vmalloc_to_page(sctx->send_buf +
+						(i << PAGE_SHIFT));
+		}
 	} else {
 		sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
+		sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	}
-	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	if (!sctx->send_buf) {
 		ret = -ENOMEM;
 		goto out;
@@ -7684,6 +7705,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 			fput(sctx->send_filp);
 
 		kvfree(sctx->clone_roots);
+		kfree(sctx->send_buf_pages);
 		kvfree(sctx->send_buf);
 
 		name_cache_free(sctx);
