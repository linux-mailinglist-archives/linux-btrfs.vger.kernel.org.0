Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E98B2FC2B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 22:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbhASVsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 16:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbhASVpw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 16:45:52 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D8FC061573
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:45:12 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id bd6so9929073qvb.9
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Udut2JpILEhQwPzJ8z0MalsxhfzeoMaFchp5A2+RP/4=;
        b=QkWTOi6lqLOnI6vPPS7Mva15SfTiKlZENLst1nsnsTUureRUfVwREb+SDe/xuZBnxt
         6jwt2nFzypL3RtZPiCeOv4M0EPfw6jXRV2Qofc/x8h1Qtp8w8GHOiZ/Y4iAn/hNdDRvF
         rP2wrxmWYHzvlNHuBr0EtEw8xt3bjtfuRIyqXE5jhyducfk3jKBwCWs9d7Tg13faYM+w
         tjNdYBrOaEam3fJEuY4J1l5rPUYk5qKDikI76i+7H0cxavuFPDZ26XPwnYgmixoLrY7c
         Tsm6y0otNXhjjL5uf8sVDkqtbeRXB4FgDa7J1khVkgJmhWtOL/3c/BWnY99u5jeCSRhf
         XQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Udut2JpILEhQwPzJ8z0MalsxhfzeoMaFchp5A2+RP/4=;
        b=NRkXS6zDXFafe4sepI2Wb9pRfVFipPyJdzsH7HNdbBX9gLoxQvU9+/TfaSietbKBIa
         hBzwTZbW7CbEdcfq+lH/ksfmq40A31embgg8EESwAJa8E2LswEPPadQgevzKfNlKOo4o
         9LsWRN4HthRLV/Qm+VuRFlfqygLltIJLjUCNWeT0eHknp8RSvIlOY+r0VDV12Xt4m631
         Wrn5FyFtBoGlLMWmFb+k5S6OrUFYRy5P2PdigVbi5oEAeUxHymtDeqUwKKCvBWZcCwsg
         dN9b36o37vfDz1lLibFk4KyqlElkcx19Z8TZ3kSlyVQFcXlkfgEGSHhv8BF4rKq/tdaA
         iSMA==
X-Gm-Message-State: AOAM530OdBWdfI3IhXVKVxGiZuLdv/JizMI3Kdip7ZpOf2qQhV8pg7Fu
        B4nqMuJMIRHDXqq8YmDbgcik7Bld3+dsZVikAWk=
X-Google-Smtp-Source: ABdhPJyVhsrivuw2GPBN5wFGR/H8cGWk+Ukn4myls2WagHqH+nM0NX50XUNrafRNDfpmW7RhZ4O2EA==
X-Received: by 2002:ad4:452f:: with SMTP id l15mr6599493qvu.49.1611092710999;
        Tue, 19 Jan 2021 13:45:10 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1325? ([2620:10d:c091:480::1:2a44])
        by smtp.gmail.com with ESMTPSA id c7sm6317811qtc.82.2021.01.19.13.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 13:45:10 -0800 (PST)
Subject: Re: [PATCH v4 02/18] btrfs: merge PAGE_CLEAR_DIRTY and
 PAGE_SET_WRITEBACK into PAGE_START_WRITEBACK
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5dc997b3-66e1-a896-970c-a95491b332bb@toxicpanda.com>
Date:   Tue, 19 Jan 2021 16:45:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116071533.105780-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/21 2:15 AM, Qu Wenruo wrote:
> PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK are two macros used in
> __process_pages_contig(), to inform the function to clear page dirty and
> then set page writeback.
> 
> However page write back and dirty are two conflict status (at least for
> sector size == PAGE_SIZE case), this means those two macros are always
> called together.
> 
> This means we can merge PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK, into
> one macro, PAGE_START_WRITEBACK.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c |  4 ++--
>   fs/btrfs/extent_io.h | 12 ++++++------
>   fs/btrfs/inode.c     | 28 ++++++++++------------------
>   3 files changed, 18 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 3442f1746683..a816ba4a8537 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1970,10 +1970,10 @@ static int __process_pages_contig(struct address_space *mapping,
>   			if (page_ops & PAGE_SET_PRIVATE2)
>   				SetPagePrivate2(pages[i]);
>   
> -			if (page_ops & PAGE_CLEAR_DIRTY)
> +			if (page_ops & PAGE_START_WRITEBACK) {
>   				clear_page_dirty_for_io(pages[i]);
> -			if (page_ops & PAGE_SET_WRITEBACK)
>   				set_page_writeback(pages[i]);
> +			}
>   			if (page_ops & PAGE_SET_ERROR)
>   				SetPageError(pages[i]);
>   			if (page_ops & PAGE_END_WRITEBACK)
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 19221095c635..bedf761a0300 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -35,12 +35,12 @@ enum {
>   
>   /* these are flags for __process_pages_contig */
>   #define PAGE_UNLOCK		(1 << 0)
> -#define PAGE_CLEAR_DIRTY	(1 << 1)
> -#define PAGE_SET_WRITEBACK	(1 << 2)
> -#define PAGE_END_WRITEBACK	(1 << 3)
> -#define PAGE_SET_PRIVATE2	(1 << 4)
> -#define PAGE_SET_ERROR		(1 << 5)
> -#define PAGE_LOCK		(1 << 6)
> +/* This one will clera page dirty and then set paeg writeback */
                     ^^^^^                         ^^^^
                     clear                         page

Sorry for some reason I missed this, then you can add my reviewed by from my 
previous reply.  Thanks,

Josef
