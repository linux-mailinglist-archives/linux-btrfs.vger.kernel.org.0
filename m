Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4016A248C6A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 19:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgHRRFg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgHRRFL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 13:05:11 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2589AC061389
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 10:05:11 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 77so18917047qkm.5
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cii/aqkDJocYYqjYTW6qZb6XZSm2jdOl+U/9nnMoq9Q=;
        b=pdrVL/OulhputsU/XyLSRHQBMFzvOsIsRnFbT4zF0m3hEMQoBhmMaSkhdlrIZdEe9J
         AXBiSeXhWKNKoG/GPTqqZdOkRtZVt73WGxxYsOa8moRISCVuU0AeIN8Seqtnif9y4Spl
         Aw+UhAzhh6DTiB0z/YOFKlrWLEdNDMedzX6xu8c9+59VilK4+lD4ryCt36PiIFKSf+Dm
         RmME0eTxGHvfG9jQ51v57kq9Sd+8kHOdYocrF5WM/4J5NNIxTyeyq+RF9L5NVo+DtIB6
         d41maCxjmV7SF5qwKvIEinsSCDzqj80vxhg3fvv6+qex/QXEGlAujR+k+7Jv+TOWerK9
         RraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cii/aqkDJocYYqjYTW6qZb6XZSm2jdOl+U/9nnMoq9Q=;
        b=c0lBrA6FXDC86sr9GxWmwggQoOLAf0ml8QHfUZtws+IrhWgHMEguWBeagnNSrecUsE
         ing0hHRJavga1Qft82oCTws50ZrIdXiTY1ZnBaduo/buxpTyaCkyW1NMhkx1klwmINWc
         d1Y6rk4zoj+yb4n+0Qrz41KkwoQhPZVfzZ0dUAz8yjrqf2dfSRqSPPJNQuOYeZfMo6+0
         IKbf3Vjti5Toe1h+CegNLgckmgsR5zuhPi6FUU3pYsAqPdtY+sdCR5bklcPLHTjeyXao
         0HbC2rRusDKOi+B3ngABmArHjQ6aDXH0q3xv7A6NWjgdCOGFN+v8dIdO3Xn+m0stMAO7
         w5Ng==
X-Gm-Message-State: AOAM533uEI+hcxBVd/k01n0h0ahPltsVf9jPUnHcgXLA6/BSVXgadZSx
        7LylNsBS96ON7a6rhfm5Y7arH1fgL5EGobR5
X-Google-Smtp-Source: ABdhPJwemBi3nr1EtR9fSwcOSpj4PgE+29BpPZFuQH28GuyKw2bso6FrfKe/uTV5IxArFIzfhlCN3A==
X-Received: by 2002:a05:620a:1256:: with SMTP id a22mr17934523qkl.95.1597770309601;
        Tue, 18 Aug 2020 10:05:09 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1055? ([2620:10d:c091:480::1:7359])
        by smtp.gmail.com with ESMTPSA id q13sm22012482qkn.85.2020.08.18.10.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 10:05:08 -0700 (PDT)
Subject: Re: [PATCH] btrfs: switch to iomap_dio_rw() for dio
To:     dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200817161821.53ljczz3ahudfb2a@fiona>
 <65ed4f24-b772-8cbe-129c-4b23c9354522@toxicpanda.com>
 <20200818165652.GI2026@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fe8b9e8a-aff4-dd14-1f20-431842c7e4a6@toxicpanda.com>
Date:   Tue, 18 Aug 2020 13:05:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818165652.GI2026@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/18/20 12:56 PM, David Sterba wrote:
> On Tue, Aug 18, 2020 at 12:47:55PM -0400, Josef Bacik wrote:
>> On 8/17/20 12:18 PM, Goldwyn Rodrigues wrote:
>>> [Rebased against kdave/misc-next]
>>>
>>> Switch from __blockdev_direct_IO() to iomap_dio_rw().
>>> Rename btrfs_get_blocks_direct() to btrfs_dio_iomap_begin() and use it
>>> as iomap_begin() for iomap direct I/O functions. This function
>>> allocates and locks all the blocks required for the I/O.
>>> btrfs_submit_direct() is used as the submit_io() hook for direct I/O
>>> ops.
>>>
>>> Since we need direct I/O reads to go through iomap_dio_rw(), we change
>>> file_operations.read_iter() to a btrfs_file_read_iter() which calls
>>> btrfs_direct_IO() for direct reads and falls back to
>>> generic_file_buffered_read() for incomplete reads and buffered reads.
>>>
>>> We don't need address_space.direct_IO() anymore: set it to noop.
>>> Similarly, we don't need flags used in __blockdev_direct_IO(). iomap is
>>> capable of direct I/O reads from a hole, so we don't need to return
>>> -ENOENT.
>>>
>>> BTRFS direct I/O is now done under i_rwsem, shared in case of reads and
>>> exclusive in case of writes. This guards against simultaneous truncates.
>>>
>>> Use iomap->iomap_end() to check for failed or incomplete direct I/O:
>>>     - for writes, call __endio_write_update_ordered()
>>>     - for reads, unlock extents
>>>
>>> btrfs_dio_data is now hooked in iomap->private and not
>>> current->journal_info. It carries the reservation variable and the
>>> amount of data submitted, so we can calculate the amount of data to call
>>> __endio_write_update_ordered in case of an error.
>>>
>>> This patch removes last use of struct buffer_head from btrfs.
>>>
>>> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>
>> This thing is huge, but it builds and passes the dio tests, and I went through
>> it twice.  I imagine we'll still find things broken after the fact, but IDK how
>> to break it up more since we're converting to a new style.
> 
> Thanks, ack, I think this is a resonably small version we can get. There
> are 3 patches doing some post-cleanups but for now I'd like to get just
> the switch so any eventual fixups are easy.
> 
> Tests finish for me but I haven't scanned all results so there are
> potential failures. The plan is to push the patch out early for wider
> testing despite that. Functionality-wise the patch is complete so we're
> now going to just hunt the remaining bugs.
> 
> I'll add the patch to misc-next by the end of the week, it'll be in
> for-next until then, more reviews are welcome.
> 

Agreed, it's going to be one of those things where if it does fail it only fails 
for some of us in a subset of our xfstests runs, so might as well get it in so 
we can all start hammering on it.  Thanks,

Josef
