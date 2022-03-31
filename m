Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221154EDFA7
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 19:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiCaRbt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiCaRbs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 13:31:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762FA16F6E3;
        Thu, 31 Mar 2022 10:30:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3074A210FC;
        Thu, 31 Mar 2022 17:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648747799;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pPs7BScwn3Gb8H8NTJQGKbvPx9S/Gi0731uzRmABSCY=;
        b=y8uvKwYoylti0qC/RmSlDN7zerCQLiLvaPXL7Hc+AZ0OsgPnywn8UpiyTB5RfWRKAyv7dr
        YPcPzNOkmEF1+BN2en8M0Zd9hAJpCqaoc85FrQ1GvuvCBQOkyw4x3ex9gO0EjCD9y7qwDI
        XWjOPKAEJv6N1Gw7kMTb8WYjya28xFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648747799;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pPs7BScwn3Gb8H8NTJQGKbvPx9S/Gi0731uzRmABSCY=;
        b=4Pr7CWms7CFD3QZwqTbsGnC5lIB4d4CTJzmgcn/SMhA3IhsLZJEMiSv+kywgGJiZlSKlRv
        mczrRCbZqcY7duCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 255E0A3B92;
        Thu, 31 Mar 2022 17:29:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8E11DDA7F3; Thu, 31 Mar 2022 19:26:00 +0200 (CEST)
Date:   Thu, 31 Mar 2022 19:26:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 1/2] btrfs: factor out allocating an array of pages
Message-ID: <20220331172600.GE15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Nikolay Borisov <nborisov@suse.com>
References: <cover.1648669832.git.sweettea-kernel@dorminy.me>
 <3feb62bb8e605e708a0f839136a7354ec66b7b6b.1648669832.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3feb62bb8e605e708a0f839136a7354ec66b7b6b.1648669832.git.sweettea-kernel@dorminy.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 30, 2022 at 04:11:22PM -0400, Sweet Tea Dorminy wrote:
> +/**
> + * Populate every slot in a provided array with pages.
> + *
> + * @nr_pages:	the number of pages to request
> + * @page_array: the array to fill with pages; any existing non-null entries in
> + * 		the array will be skipped
> + *
> + * Return: 0 if all pages were able to be allocated; -ENOMEM otherwise, and the
> + * caller is responsible for freeing all non-null page pointers in the array.
> + */
> +int btrfs_alloc_page_array(unsigned long nr_pages, struct page **page_array)

I've switched nr_pages to 'unsigned int', that's what all callers use
and I don't see a reason for long.

> +{
> +	int i;
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		struct page *page;
> +
> +		if (page_array[i])
> +			continue;
> +		page = alloc_page(GFP_NOFS);
> +		if (!page)
> +			return -ENOMEM;
> +		page_array[i] = page;
> +	}
> +	return 0;
> +}
