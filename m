Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6862FBF46
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 19:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391918AbhASRxP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 12:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389518AbhASPBp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 10:01:45 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1D6C0613C1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 07:01:05 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c12so8295025qtv.5
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 07:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vn5Y0TrG3Ui6LBbbxvYnxl2nn5t3OepGIypDVq8V4YM=;
        b=pVUDC5WiZM6Lp8yH89xT1k/YpP/3TyrwAZ15/iuWX8RBRpjlf+jFHDFgLTMtLU49SW
         kEgj71/8gTx8uUrcUqv22pjWXvmAkk4+JJZsk/LNpOAvMGyURf5ntpntikem4UAdkJmG
         qDOyNrfgyoTi6CRDwvwFDajSm8kWtjdnUlLRIqDQEpqlUC7OINwQ6kVz/aldXxJjQoP5
         MYUKt/PXULwtUE7UtG7pCk3dYIcLp50Gn7OBfoEA7a8X+HS5qin3yAo+UQVY1bXrt2Uf
         4/dAwPqazua4LeUKIitWS+j1v7XvAyJz/3HiR12eJJa0QTCjoU3WExHuF4czyxSiqnRH
         2paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vn5Y0TrG3Ui6LBbbxvYnxl2nn5t3OepGIypDVq8V4YM=;
        b=uKileGnjJGm66ahkLWBU+1vI9EdQXyYr1A74rStIkqeSzQOUa4izSp2XcemSveGVQP
         qLH7bIMGQc/lPfMrXS0J4/G9u+Qtt0wGptrefUDjsXvp7EZDK1V6/c65BONp/vn5XdR1
         3iZGTpqFeedLApYSqH8T+MP9MKGjLHQulkvsQg5bzD5FYJs3CLkbUmmPFAOBynyM2d02
         SM/V4oaDXkI5ZrmKPSwdeef+4m9kkp7OLTVLn7OlTjXLZKU+D2lF0ouM8Kle6Ved4eN+
         ncE9e0/SYuweHrfOTz2XWVjCRHMP10rr39O2pygqhXVKofpJ4mC5RyMcSI9RvJoDDCFY
         o+5A==
X-Gm-Message-State: AOAM531hvYLCwH3wlrka+ANyf0NBg8SaAm+KVMExBNk9HV7uxt5C3rBh
        zVtgwbPAaG3EVrV2nSIIxT0xoA==
X-Google-Smtp-Source: ABdhPJw9hzTjA0HJ6VQUPwDH9drSNqii0WFZZyVd4uYqJRq1euvOSRi+J16/swjVIXriRDU/RjWmOQ==
X-Received: by 2002:ac8:6f07:: with SMTP id g7mr4493450qtv.308.1611068464463;
        Tue, 19 Jan 2021 07:01:04 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::117a? ([2620:10d:c091:480::1:150f])
        by smtp.gmail.com with ESMTPSA id w91sm6339412qte.83.2021.01.19.07.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 07:01:03 -0800 (PST)
Subject: Re: [RFC PATCH 00/37] block: introduce bio_init_fields()
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com
Cc:     jfs-discussion@lists.sourceforge.net, dm-devel@redhat.com,
        axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, efremov@linux.com, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, clm@fb.com,
        dsterba@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        rpeterso@redhat.com, agruenba@redhat.com, darrick.wong@oracle.com,
        shaggy@kernel.org, damien.lemoal@wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, tj@kernel.org, osandov@fb.com, bvanassche@acm.org,
        gustavo@embeddedor.com, asml.silence@gmail.com,
        jefflexu@linux.alibaba.com
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6eab7373-3c7f-fccf-8a6f-b02519258d23@toxicpanda.com>
Date:   Tue, 19 Jan 2021 10:00:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/19/21 12:05 AM, Chaitanya Kulkarni wrote:
> Hi,
> 
> This is a *compile only RFC* which adds a generic helper to initialize
> the various fields of the bio that is repeated all the places in
> file-systems, block layer, and drivers.
> 
> The new helper allows callers to initialize various members such as
> bdev, sector, private, end io callback, io priority, and write hints.
> 
> The objective of this RFC is to only start a discussion, this it not
> completely tested at all.

It would help to know what you're trying to accomplish here.  I'd echo Mike's 
comments about how it makes it annoying to update things in the future.  In 
addition, there's so many fields that I'm not going to remember what each one is 
without having to look it up, which makes it annoying to use and to review.  If 
it's simply to make sure fields are initialized then you could add debug sanity 
checks to submit_bio().  If it's to clean up duplication, well I'd argue that 
the duplication is much clearer than positional arguments in a giant function 
call.  If you are wanting to change a particular part of the bio to be 
initialized properly, like Dennis's work to make sure the bi_blkg was 
initialized at bi_bdev set time, then a more targeted patch series with a 
specific intent will be more useful and more successful.  Thanks,

Josef
