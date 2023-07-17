Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF567565DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 16:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjGQOIg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 10:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjGQOIQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 10:08:16 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6B11BFB
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 07:08:06 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7654e1d83e8so370857085a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689602885; x=1692194885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jpizAHnM7D6WnxVkqxoZZx6DMW1iHuffbX1jlMBZ3n8=;
        b=cfTzF8ZLRr6mGJbg+d9sGeMqm+vzegzRbX55jkj+CyKwoo3kqPSq3C/cMbESqJ4OQv
         JS7aHF51QvvKbw1hWLwK9txsir6WirPGvo3EjTXc6sR96FYiLjrL3l2ZL3poUC8fTBfn
         cVxQx/0fMfsQqPEsuBZwnJwFM6UDaN5fYK117GtSh/Gq4R72Zn0gfCrzlIm/NzOyoJYl
         CD+TN0MaWubOgHs2dwS8ntc18osRlqEZqSjWEv9PuAputZYJ4MCjyxh/Facfs5UqyZjX
         lQFsQT7Nniiibc7gPHCH6I8HIt0mcSKVz9LGjxU6q7IQa4fgyFai9n/ZVMmD4vuAu2bm
         ZDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602885; x=1692194885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpizAHnM7D6WnxVkqxoZZx6DMW1iHuffbX1jlMBZ3n8=;
        b=IOcCKjNG1b0FXj/uuzYn+9NZC+MuhvCoWpf6KCfjchl//CGCjpG42x0lmFhADlVXAx
         xtzTgzcE3JP9i7aiMRZmrZjAGfWt+kf3P8npL1ln25fWg8ibrRfJ/Mx/7cBsOaYIdMk+
         C6cfPxjw9FCYcugM6Yu5iHAhzqjOpfmI8ZExTUAuQ8RVKgFBlvHe4GPMzCrTwbAfXGhD
         Q209VsHgA5D+6vTltQVQfowhjJm3L0DJqccJVh4eMcAcBvrbtRHJm1klL7TlxPuTM5WO
         zIWGMLnXhC1yzNK5nS8Q3K1UvWJ42SReF1V+SiDdb+Z0fTyJRQFT1wE8OGPw2QSKFNEA
         a2CA==
X-Gm-Message-State: ABy/qLZjexX5dSBe++OqCySloyVKZQSz+enU6kExyrJaU4zhQcjir66V
        35M0LhW8xzsL6dVLiZQXW9Ol/+s2XDi/W58GuM+t8g==
X-Google-Smtp-Source: APBJJlH+xgDLzXcvxcvldkQ9uV0O80ya9neqyprXGO26M5arVqBgUT0wWnfRWY4gbUwqPllrOJIB/g==
X-Received: by 2002:a05:620a:290d:b0:768:efd:2685 with SMTP id m13-20020a05620a290d00b007680efd2685mr8388045qkp.33.1689602885037;
        Mon, 17 Jul 2023 07:08:05 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o15-20020a05620a130f00b00765a9f53af0sm6091300qkj.128.2023.07.17.07.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:08:04 -0700 (PDT)
Date:   Mon, 17 Jul 2023 10:08:03 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove duplicate free_async_extent_pages() on
 reservation error
Message-ID: <20230717140803.GA691303@perftesting>
References: <p6swvbl7oht2xiz7nrw3iexpa5ytuqdhbwneqm3phcm5igejd3@ao2eyoslwbdj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p6swvbl7oht2xiz7nrw3iexpa5ytuqdhbwneqm3phcm5igejd3@ao2eyoslwbdj>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 14, 2023 at 10:18:19AM -0500, Goldwyn Rodrigues wrote:
> While performing compressed writes, if the extent reservation fails, the
> async extent pages are first free'd in the error check for return value
> ret, and then again at "goto out_free".
> 
> Remove the first call to free_async_extent_pages().
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
