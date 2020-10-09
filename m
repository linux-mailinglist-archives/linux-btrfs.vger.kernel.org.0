Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46E288AA0
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 16:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbgJIOVH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 10:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbgJIOVG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 10:21:06 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3554CC0613D2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 07:21:05 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id a9so8014596qto.11
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fLFci4XYZu7892lPoRPutudbFZryQukrvrtGjgUeDAE=;
        b=uSz9wunJYf3fs9gTFzyTPUmX8q0XrJBH7Q4sej+x/VjfXRCDtZHM9gyaEJNIr/z8nY
         2biSDT6BQraXzdMOYQxQfDc08y/T5sGxABO9MSS9I9lyMqSOxieR7VLVUpB4yCbLy22r
         UgHBsadQb0dlS6nF7eHKki/3tgldwmpqXup3iJWT6nhTOSDxeiVd+9I7yRSeYl1CE7I7
         xBVdxO9Je6LlrQAIp/Iof8cTW6Am9H151m43Vv1UxmBdBBVYxXZymKuzg5wCPXMRWPLA
         Wf5F7tKSYT/AAPt4MaiWwHk+DERz//zLW+8dogx5KtWCa6tN5EvmxjacBCBp6E675OYy
         Kbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fLFci4XYZu7892lPoRPutudbFZryQukrvrtGjgUeDAE=;
        b=eWsF+dVVYv/qE5lnhrtEKAVDYwsbETyhDTEC0ShIvdOwnaTUmBOj7HA0n/Gge/vRm5
         5eCnDgSg5B0WvnqMMxw92m7BQJXUPEEa3gCW3YE9hBqep85/zRUPt7MWQF4V8lApMl28
         5eJPna/lPawmVqvZtC7zAD2XQ0eFDUmUpVrkkdimGXlCJSo4EC6CNeoBkTQCRFXg7PLw
         LZ+ogWmprnaVryrQLCX83ySxPyNAxzMBJ7uC8bqy2/5bwS1BZP11Iy3PdadwzxqIE6ec
         8kw/QMpIWxEJ3qjl0DjX01wZjfNPg+Sv8x0kXVnlGTy++pN/L4nr4LFyLApLdU5Ochxl
         84zg==
X-Gm-Message-State: AOAM530s2XnhH2jOzzWiy72Ru0XEv2Rh6dyn4ENONiYbH3m6QJpxJJUq
        RdIWKLzTZKGUshtKIY+bgtK9wQ==
X-Google-Smtp-Source: ABdhPJxhaMcjkW217Z6HVtdIL7bQB3wI1s28tLA/akSMvA1dDI+6GrW0oWlGaagVulav3SPPBZvTxg==
X-Received: by 2002:ac8:5c4a:: with SMTP id j10mr13409908qtj.322.1602253264384;
        Fri, 09 Oct 2020 07:21:04 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::107d? ([2620:10d:c091:480::1:f1f8])
        by smtp.gmail.com with ESMTPSA id n38sm6539624qtb.91.2020.10.09.07.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 07:21:02 -0700 (PDT)
Subject: Re: [PATCH 08/14] btrfs: Introduce btrfs_write_check()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
 <20200924163922.2547-9-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4be296ac-b6d9-a755-5a78-e4f962c4d7e6@toxicpanda.com>
Date:   Fri, 9 Oct 2020 10:21:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200924163922.2547-9-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/24/20 12:39 PM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> btrfs_write_check() checks for all parameters in one place before
> beginning a write. This does away with inode_unlock() after every check.
> In the later patches, it will help push inode_lock/unlock() in buffered
> and direct write functions respectively.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
