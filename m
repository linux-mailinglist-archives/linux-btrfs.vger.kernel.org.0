Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD4725096D
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 21:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHXTdZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 15:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHXTdY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 15:33:24 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56095C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 12:33:24 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x12so7158895qtp.1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 12:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=51kP9Tifqbgd3Uyz9HqcjJGWpWdHZ2apFmWcYfbWByQ=;
        b=cZpArxXL14yz7I2zGy87ZKjyTQeiikaabE4c/UxB4d64VkhBvLVumjxm9n0twhHm+s
         jf/W1XVZTCTWoQAjqVRoylTK0wJD7g26WhG8EPT+JPQfcdMHAikfE0owmnbTwWZF/6+M
         CnfLcgyCSqMPlbbvUfJjhoQzyQbMG+h8psuFdV+orCynGMTdrwnco4NHyqEHnKCM3hV5
         GR/xu/UUQlEPGRqXzNisKUx7rdnKsMDbT7UQADO1XY5ujEG/dn0XCHb1IkX6wC0tMsMI
         C4PqR/Iha07VfpTrwTd+uAoQZkQYbCP3a511EEtYNgbsiDWUtkzbsbVv0cd2LWrxgKTQ
         Wr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=51kP9Tifqbgd3Uyz9HqcjJGWpWdHZ2apFmWcYfbWByQ=;
        b=Ta7G7bFNagcAxi7UIKFhdb4BmhTAKRnaPde2A1q0U00AgTvuxXABGqacoU/i7aHAq/
         tG53di01NrMcZRHGDk8rJVq0hwko8i5W4khmMGB1g2zHn3i/6nn9dPTPWu7zQdFtebCE
         V1fQLleAiDMQjsA8TXAh+h24QTlLty8IprEwjz+vFKqAAAGplr5TejaUxY+MgJSDmcdx
         mryOYWqH2BWdD6nFWIf6h6xMuLQBo8Iy6DexZdynKTD0/s9FsiPThUnq849J4DdG0dcJ
         vyQDTdxofWGETOxFwhRGnRQnNpcb67TZDyrNySF7mLqXxtf1FHPwH3AEmU+8ZUeG28oO
         cDIQ==
X-Gm-Message-State: AOAM530sOPERJtZ75ObjNNj08iN7ZS/AhwQAxrzBmhHxNjxK9Tnr/GzG
        Crk8USBvfPHW+uV0XyGRFPudJA==
X-Google-Smtp-Source: ABdhPJymbALVwQ+92K7/Kx4PwQy+Axcn5LRTFd6I+yOZ6Qk3mbyyw1qrGGRQofxKv3o2mvWYzTXqKg==
X-Received: by 2002:ac8:3ae5:: with SMTP id x92mr6125835qte.139.1598297603305;
        Mon, 24 Aug 2020 12:33:23 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x2sm7317766qki.46.2020.08.24.12.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 12:33:22 -0700 (PDT)
Subject: Re: [PATCH v5 7/9] btrfs: optionally extend i_size in
 cow_file_range_inline()
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1597993855.git.osandov@osandov.com>
 <602ed7659d19b2693cd1277fcea8dbe21928157f.1597993855.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e72ee90f-f587-fd8a-bf79-257ca9aa6851@toxicpanda.com>
Date:   Mon, 24 Aug 2020 15:33:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <602ed7659d19b2693cd1277fcea8dbe21928157f.1597993855.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/21/20 3:38 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Currently, an inline extent is always created after i_size is extended
> from btrfs_dirty_pages(). However, for encoded writes, we only want to
> update i_size after we successfully created the inline extent. Add an
> update_i_size parameter to cow_file_range_inline() and
> insert_inline_extent() and pass in the size of the extent rather than
> determining it from i_size. Since the start parameter is always passed
> as 0, get rid of it and simplify the logic in these two functions. While
> we're here, let's document the requirements for creating an inline
> extent.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
