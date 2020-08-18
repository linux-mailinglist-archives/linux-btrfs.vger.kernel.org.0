Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFDE248BEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 18:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHRQsA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 12:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgHRQr7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 12:47:59 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E41C061389
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 09:47:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w9so15606680qts.6
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gFbd1HlTkFt8SM641hu93uh2PqQqP4bLM1yqLT4EsGA=;
        b=yxqC8RXR7nB+HZA18cdLEc+NH+khhMseVAwQ79sQ4J/jA6Vv6UXS1l7vkSbK5t3z6G
         4UidyS6c4MErjpRR0wVQS9WHc8AFA7TFbrqQ1jgoPCSGOKa13e5359ggCh5r/66/IpKk
         2aYhlSqSSoy8CCgCh1Ej+AXCfU0ktt72p5v7rDHzT+5W6JEC0iAf5bmcpOgCK+eJe0cW
         36+bgXY+pqNKZI7CiQxEwzlcJnlmVlFzzU96zEqHVXLzDvvNwRBYMAuIH/BSEmXzlSPj
         ASude/XV23n5hHsFETWC5spZIoa+rDqXxgP6jZA8Sk20ckomPyA8ktWxdPbWEHEa1Ar/
         ySmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gFbd1HlTkFt8SM641hu93uh2PqQqP4bLM1yqLT4EsGA=;
        b=rcpM5xfN7KZIxllSquSIXkAQR7zTCqX1hVbjs7DA2fKFoRqB0wDbnoaGGSLttC9Ndn
         nMioppcNbUhckZAHYrt6XLmoIocYfNxJKJYvnow0ifUfGPoXrOxyz2egauFpNCKdKUQ4
         mdcJKnhoosbGVzdkzUbHSi4NcoqK1+BtnXL6RfNw4vE4WfP1zd6hrhsal76Zt7GhbqPq
         Uo3rgXb/DyJGZPhGOFePH5+FRG0fCW/njjsl7SHWkCOiLn6kgvAbNXrLIiDdshI+6zqP
         OqOfX4E3CpbP9Bnj/88URJsFK+s17qjBOKLgt/6/FQ71asBebZZZ4aFMrdpuzyoX4uNf
         y6zA==
X-Gm-Message-State: AOAM532iApjSzubN8mGafm/v/0WSA07+wWnEVxcyeLThyqbzHz4/4Jq7
        al1P4pC5R/MqVep2l8dlDpMsfo6L0G8HZ/FG
X-Google-Smtp-Source: ABdhPJwBAwCYm5KlruYtq0STWl10iP9v98zmuca5IlQOAYNQOOZhgMt9PiRyuvX+U1GJ0XPsJSLz3w==
X-Received: by 2002:ac8:586:: with SMTP id a6mr18874283qth.391.1597769277893;
        Tue, 18 Aug 2020 09:47:57 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1055? ([2620:10d:c091:480::1:7359])
        by smtp.gmail.com with ESMTPSA id n15sm21146565qkk.28.2020.08.18.09.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 09:47:56 -0700 (PDT)
Subject: Re: [PATCH] btrfs: switch to iomap_dio_rw() for dio
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
References: <20200817161821.53ljczz3ahudfb2a@fiona>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <65ed4f24-b772-8cbe-129c-4b23c9354522@toxicpanda.com>
Date:   Tue, 18 Aug 2020 12:47:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817161821.53ljczz3ahudfb2a@fiona>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/17/20 12:18 PM, Goldwyn Rodrigues wrote:
> [Rebased against kdave/misc-next]
> 
> Switch from __blockdev_direct_IO() to iomap_dio_rw().
> Rename btrfs_get_blocks_direct() to btrfs_dio_iomap_begin() and use it
> as iomap_begin() for iomap direct I/O functions. This function
> allocates and locks all the blocks required for the I/O.
> btrfs_submit_direct() is used as the submit_io() hook for direct I/O
> ops.
> 
> Since we need direct I/O reads to go through iomap_dio_rw(), we change
> file_operations.read_iter() to a btrfs_file_read_iter() which calls
> btrfs_direct_IO() for direct reads and falls back to
> generic_file_buffered_read() for incomplete reads and buffered reads.
> 
> We don't need address_space.direct_IO() anymore: set it to noop.
> Similarly, we don't need flags used in __blockdev_direct_IO(). iomap is
> capable of direct I/O reads from a hole, so we don't need to return
> -ENOENT.
> 
> BTRFS direct I/O is now done under i_rwsem, shared in case of reads and
> exclusive in case of writes. This guards against simultaneous truncates.
> 
> Use iomap->iomap_end() to check for failed or incomplete direct I/O:
>    - for writes, call __endio_write_update_ordered()
>    - for reads, unlock extents
> 
> btrfs_dio_data is now hooked in iomap->private and not
> current->journal_info. It carries the reservation variable and the
> amount of data submitted, so we can calculate the amount of data to call
> __endio_write_update_ordered in case of an error.
> 
> This patch removes last use of struct buffer_head from btrfs.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

This thing is huge, but it builds and passes the dio tests, and I went through 
it twice.  I imagine we'll still find things broken after the fact, but IDK how 
to break it up more since we're converting to a new style.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
