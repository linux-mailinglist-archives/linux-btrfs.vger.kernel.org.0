Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69EAD145CD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 21:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAVUFV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 15:05:21 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44938 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUFV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 15:05:21 -0500
Received: by mail-qv1-f66.google.com with SMTP id n8so355332qvg.11
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YeMVJaoW5jD5IEl50CwSFs9IZzjpcxENCcLqbgxKR3U=;
        b=lev9VUHYQirXvng7BZfOdGY2t1s5RprYsD9xkAttXddef0OKYG0XIj0mBO1SvI6H+s
         jxdnM7HHBueg4OBEtb0Gs1COvxybYP2KwGC2etEUFAXoxs91eYo2W6dPvGsEaRG1VOzW
         t+oQEaSaLlI/Ys0ikK7iQfXhuV4x53yigRrbtsBBp9IZHsHxa0iX4v6yr8NUHpWX9eBa
         eb6JrTmCk9TVOUGMDYzgGXDlAHgg+/6mF4akPKCeuQXoXPu2OrGNVbCc2MkBfugSvI1R
         /EjFSc8tf6fQNmJnp8d8EuwAUW+F8ZDTK/BOj/0owIqSGJlbKo5JMbiyrWkC5EVkcvKA
         i/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YeMVJaoW5jD5IEl50CwSFs9IZzjpcxENCcLqbgxKR3U=;
        b=Ocg9XvUogRfxVNHS6cYp4Y/seQdsCSajLDoFiiG0nhaXXT/9K+YV/iM95xswLXj6f4
         KJsWfyO4PS7rJ1gQVBGA8OfwzOK1NvpaIGQ7rMFpUj4+Iry3MYy5hnE/Nj437tW9gPY9
         Hm7eE0O9RdnpPn7eoX191S3ga2tNQ32AdPFZJQUd1lUqsP0dH2Ljyh34qqFWCTCY4OAF
         HNKkd6MSpvoo+376LV0fdO2uQtU55YUMXeUdOjElRgrErJirIDAvEMD38RK6uAlMpJto
         23Yknh2yihEOuGXFb2VSRjhK4B31tWtSuU6GedFo4j9daLcmq3HYfOe5qO3ryZ2sWanJ
         GgMg==
X-Gm-Message-State: APjAAAXqCvglNdYu9xAvUCYEzGSxypxCpl/UaHCAA0D5ExGzgUQpfQwp
        ZlFEXN0pFLRUEjStge47phmKXqvSGYvmQg==
X-Google-Smtp-Source: APXvYqwqrGUEwPve0kM5qF0ybuucSifbNIng4HiWxkmOQqyuarNmtI14150SxnYI5zf/2horL7xXQA==
X-Received: by 2002:a05:6214:1242:: with SMTP id q2mr12891185qvv.178.1579723519986;
        Wed, 22 Jan 2020 12:05:19 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id i90sm21544047qtd.49.2020.01.22.12.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:05:19 -0800 (PST)
Subject: Re: [PATCH 04/11] btrfs: Call btrfs_pin_reserved_extent only during
 active transaction
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-5-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1449d80a-4756-cd90-5677-19e544193567@toxicpanda.com>
Date:   Wed, 22 Jan 2020 15:05:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120140918.15647-5-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/20 9:09 AM, Nikolay Borisov wrote:
> Calling btrfs_pin_reserved_extent makes sense only with a valid
> transaction since pinned extents are processed from transaction commit
> in btrfs_finish_extent_commit. In case of error it's sufficient to
> adjust the reserved counter to account for log tree extents allocated in
> the last transaction.
> 
> This commit moves btrfs_pin_reserved_extent to be called only with
> valid transaction handle and otherwise uses the newly introduced
> unaccount_log_buffer to adjust "reserved". If this is not done if a
> failure occurs before transaction is committed WARN_ON are going to
> be triggered on unmount. This was especially pronounced with generic/475
> test.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
