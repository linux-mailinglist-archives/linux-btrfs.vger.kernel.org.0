Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873DA2F34AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 16:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392112AbhALPwM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 10:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392107AbhALPwL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 10:52:11 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89B6C0617A2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:51:25 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c14so1834115qtn.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=czDseoOnOGRSzCZMGapC9qH4FJPI8pYW205lRRKqplo=;
        b=BjymW39KXrPg2F5A9D5yXqibmoS7kh0mIiVWqbp41P7iiqkS6TxFW+s3pZIY1jivu/
         Ao0gmQFcW3K8+njEvHVM5O6PWhLOB9G6DaAshCNpBblqq2dIYIkuUrucyr/qC/Ykl3bl
         c58HCyCTg/qxf9Vh1CeBfVaePBXOIA2brec87O2fdaCqEpjvUxwgYp0HcL551qcVik94
         ynZ+utGJUyZ02hbOkSbrQtwrIRQw3nV6Bx0EHDbBUV3L3aGh+BVP6uO1gAnflM1RvPIq
         JiuZDjJxkp8oJQfs7AKhHeKfAqKuLWFUaMK8JF8OsZQaQy1tN5Bb1y+Um1g7PD1ItP1G
         Uemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=czDseoOnOGRSzCZMGapC9qH4FJPI8pYW205lRRKqplo=;
        b=fdbrIsOYT0XsEgzye229Sg2rG0llKmerzrYTij2fxlXl4fTIvxiph85VWci0NfCQZm
         lWFZqi32uIGYqa/2HUeN8OnRJ/dit+WFKq+l9nYJlGj7zkKYFclYGaKR3BP/5OO1tE0y
         tRyGhdNt4ceQkUEw09ZCtQxM7aapK/rXVeKqumJaHr82e1I1CfmX1btM1XIDKpUZczwh
         QDY3QaqwA6gOc59SmBZDCb/Cvbb3XrTsLJFgARowkjpCB+C70k1vgO8nUQyTO8HtQeIG
         62XwlP4iPOLRDqV4P2QDjsBt0gz3FSPzHFfj0LJ0ldfsf8a2BBe+RAC8Da0MmYzheGxU
         VXxQ==
X-Gm-Message-State: AOAM532c/kFOgsP+W6oejgfeZgjhd8eldScY1/3hU/douQHm0HCaTaAO
        iWVu3/Ni36QtbVu4XyJmjmhmDg==
X-Google-Smtp-Source: ABdhPJwtibQJQig0QFWJDWN40ncrChyt6y1cnTC94rRpeGkBg5SboaHya8cIIrahcIekU9yJHHujpQ==
X-Received: by 2002:ac8:110e:: with SMTP id c14mr5048776qtj.293.1610466685026;
        Tue, 12 Jan 2021 07:51:25 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c7sm1457585qkm.99.2021.01.12.07.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 07:51:24 -0800 (PST)
Subject: Re: [PATCH v11 15/40] btrfs: redirty released extent buffers in ZONED
 mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <530bf9339d499c4f2209baeca7769a1c32a245bc.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8fc5abec-521e-4022-31c4-a63428dc7642@toxicpanda.com>
Date:   Tue, 12 Jan 2021 10:51:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <530bf9339d499c4f2209baeca7769a1c32a245bc.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> Tree manipulating operations like merging nodes often release
> once-allocated tree nodes. Btrfs cleans such nodes so that pages in the
> node are not uselessly written out. On ZONED volumes, however, such
> optimization blocks the following IOs as the cancellation of the write out
> of the freed blocks breaks the sequential write sequence expected by the
> device.
> 
> This patch introduces a list of clean and unwritten extent buffers that
> have been released in a transaction. Btrfs redirty the buffer so that
> btree_write_cache_pages() can send proper bios to the devices.
> 
> Besides it clears the entire content of the extent buffer not to confuse
> raw block scanners e.g. btrfsck. By clearing the content,
> csum_dirty_buffer() complains about bytenr mismatch, so avoid the checking
> and checksum using newly introduced buffer flag EXTENT_BUFFER_NO_CHECK.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
