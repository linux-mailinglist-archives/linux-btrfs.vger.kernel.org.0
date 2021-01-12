Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C352B2F3AB8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 20:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393061AbhALTi2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 14:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393019AbhALTi1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 14:38:27 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FC6C061795
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 11:37:41 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id a1so1441836qvd.13
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 11:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t/DFjpjGCjobewoVfVJhwj7XY2Y3n6U3nLJ5qpNB6Ro=;
        b=suCB2gWRDi80QAJgcvfxL6TzKyB+MYYdM1uzugI/IxZYgvCUEp36pCI95FYGWlkgms
         Mlqu1qOBwp8qQUHO6LwMFgdBRlmlInV1xeV3xkL2GxxS5N7MHExCHwipIq2AhNqhM/+i
         XoM0f3J+eHNheAF9//JO+0jOMwlvAbPD0NjR0MboGfT2Q+rBxt+nM3H3V/BIQETLEHm6
         6QYpqQDPJSV4XVtjed/nbjI5B/DIzflH3OVPzYPgeZahEfBOXVDzMKMuTw0xqSWK8LMl
         Js4buaBZ/LCJ/j5Y8ee+a6VpNnOqCrr+jIJ1JwQAXedNa0jjNZ2ucc0DT9HlmLm+w8A7
         RUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t/DFjpjGCjobewoVfVJhwj7XY2Y3n6U3nLJ5qpNB6Ro=;
        b=ddzQrjhPgug1cdRdfUt4tBtYeGjq92Xm6PX6S7MR9Qx0SEwqtApPWbyTAwuoS5Cf8p
         bsjtCaaAqvf47u45KUniAlZwrG6AhQJjHmQQJrs15LrHaRyZkEcnygn7sIB5jqy3VW33
         QcNntZNK7L8QlZkTniA9OYiiLWoSGnqiOXMGkfYlxkG7+RwQjylIXmOO5gbtLgJOGJwA
         kMuuL19rZHisqzh1pXzpabW+zBpeXv3xI+nrZx8Twk8avx6PF8SimFn3ncUzHzqFf2Il
         v8RtGomti4zkHkfejHJUr8y+4a4GumVLKIRIJrZxCKmcom/HAKjiSWvNtIkGCZcPEkK8
         /iIw==
X-Gm-Message-State: AOAM5326a12ySCmjZxTfN3PsZyc6g/tAoF5Y7fS6gi+TQnIrYnrhFhCf
        rI6wK37QRUIWW7KbOuUFX9VeaA==
X-Google-Smtp-Source: ABdhPJx187wdJzGwlrDjD5zL4xF/Na+coJtEQix/PUT4spHzVHH5Av5FWDSK82hjMwlExN/Acp9eEA==
X-Received: by 2002:a0c:edab:: with SMTP id h11mr1060212qvr.23.1610480260892;
        Tue, 12 Jan 2021 11:37:40 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r15sm1869840qke.55.2021.01.12.11.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 11:37:40 -0800 (PST)
Subject: Re: [PATCH v11 34/40] btrfs: support dev-replace in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <019923ef8aca1d3d8ccddb439e397df35cfe02a7.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1708e846-f6be-840a-b164-efed02fab7cd@toxicpanda.com>
Date:   Tue, 12 Jan 2021 14:37:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <019923ef8aca1d3d8ccddb439e397df35cfe02a7.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> This is 4/4 patch to implement device-replace on ZONED mode.
> 
> Even after the copying is done, the write pointers of the source device and
> the destination device may not be synchronized. For example, when the last
> allocated extent is freed before device-replace process, the extent is not
> copied, leaving a hole there.
> 
> This patch synchronize the write pointers by writing zeros to the
> destination device.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
