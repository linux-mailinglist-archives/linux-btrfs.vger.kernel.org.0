Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D25AABF928
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 20:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfIZS1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 14:27:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45121 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfIZS1m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 14:27:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id z67so2594323qkb.12
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2019 11:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=adXcb6rrHJjFPUhmf/eXdGmJ8eGqtzbtQuL+Q2940Ug=;
        b=lHqz4GJNRTy5PtXA6IjlIxDrZF5/XVWlh3MR+xAmD2uaiKBk7huUJ/R6EwTl7jaOET
         Qx4u+4fA8Wg1aZ1hSYNRrXKdU3yJlqPDaM2m9gdFrMBW1I/TRNky9jBWP9jUZJETRJGm
         JnamCzFO2nJneDiUK788AZltOcqH2zqDlJ8V3qzhFWrbxggdYbmbGlKg1rlhXnSU19TH
         TjRd4iXGWKtTUK773eLyFiyQnwOIt+/52az0kuAsQ4MW/c7Ih7Pzygztde1QozbAi0sv
         JZL2S3U/ynZ78dkdLCW4r/3tGtTpeAKJ+Z3W5jytVoQtI31kFm8DXkW+hW2UNtVfIeRr
         2FKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=adXcb6rrHJjFPUhmf/eXdGmJ8eGqtzbtQuL+Q2940Ug=;
        b=i3rQqgAohUVXB5NdN/UKPG1kGAg5LzLBcmAtIa349BsA31AKv+H8z1WAS40qGCuK1P
         J7dkD2ArD9mn4zpUryvMPI9CReQhEtzDmHhSNc0JbhxF2PIB524WVIgLd8Qr9XxFOYmh
         MLuAPZax5fjsMtFjPrrBSDsH0kaPjxWrI49uuE/zhqmwCQrJD+BQJVEGK33UkPt3Hf7i
         QJ7N0KCOBmAoO4IS2ISwxTm2zi5Lqes88D9s3gPhcWu5LdqZ2rFZIIfoTErFunh8ruj3
         DZmECErBr5nvVW1WwfsM0x2M+lFMTVd2xD/XQu4UOz1eUggQOfjzM1UJxfkmvRLp7O6x
         wNDw==
X-Gm-Message-State: APjAAAXsHXntRkDzKOBGZ7ruavtvmMHlig8U7PjE9XAZQmcRymd9CMSK
        3pevCh5pM2eyYwuVl7zEZqFveBv8aHfheA==
X-Google-Smtp-Source: APXvYqzlH2qCbwZPZ4fezqEzewt+RDCzxWeleJomP/T/JSrVqGPOwOWxm8Q7Si6Ud/pYscZwfegqcQ==
X-Received: by 2002:a37:be87:: with SMTP id o129mr222343qkf.254.1569522461198;
        Thu, 26 Sep 2019 11:27:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c9a9])
        by smtp.gmail.com with ESMTPSA id u27sm1837483qta.90.2019.09.26.11.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 11:27:40 -0700 (PDT)
Date:   Thu, 26 Sep 2019 14:27:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: Speed up btrfs_file_llseek
Message-ID: <20190926182737.ow55svjkj55rxhlm@macbook-pro-91.dhcp.thefacebook.com>
References: <20190926113953.19569-1-nborisov@suse.com>
 <20190926113953.19569-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926113953.19569-2-nborisov@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 26, 2019 at 02:39:51PM +0300, Nikolay Borisov wrote:
> Modifying the file position is done on a per-file basis. This renders
> holding the inode lock useless and currently holding it makes the
> performance of concurrent llseek's abysmal.
> 
> Fix this by removing calls to inode_lock. This is correct because
> find_desired_extent already includes proper extent locking for the
> range it's going to interrogate for finding a DATA/HOLE region. The
> other two cases SEEK_END/SEEK_CUR are also safe. The latter is
> synchronized by file::f_lock spinlock. SEEK_END is not synchronized
> but atomic, but that's OK since there is not guarantee that SEEK_END
> will always be at the end of the file in the face of tail modifications. For 
> more information on locking requirements see ef3d0fd27e90 ("vfs: do (nearly)
> lockless generic_file_llseek")
> 
> 
> This change brings ~85% performance improvement when doing a lot of
> parallel fseeks. The workload essentially does: 
> 
>                     for (d=0; d<num_seek_read; d++)
>                       {
>                         /* offset %= 16777216; */
>                         fseek (f, 256 * d % 16777216, SEEK_SET);
>                         fread (buffer, 64, 1, f);
>                       }
> 
> Without patch:
> 
> num workprocesses = 16
> num fseek/fread = 8000000
> step = 256
> fork 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
> 
> real	0m41.412s
> user	0m28.777s
> sys	2m16.510s
> 
> With patch:
> 
> num workprocesses = 16
> num fseek/fread = 8000000
> step = 256
> fork 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
> 
> real	0m11.479s
> user	0m27.629s
> sys	0m18.187s
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
