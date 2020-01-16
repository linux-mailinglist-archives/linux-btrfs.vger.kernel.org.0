Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E3F13DF88
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 17:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgAPQDc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 11:03:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38443 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAPQDc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 11:03:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so19560465qki.5
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 08:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GpVIAE7NuViSh2roi918aATHpmfpAtvuxiYM7fHfD4Y=;
        b=I071uFWE0P3FG+Qj6SyPruHkw9PKfvhPBBNqtE+tcij+tGFnpX5FzJ0aAJ+4qKmaXb
         V8njyH4XXNyEzcXKq4Cl5oXJN2kc9zX/29qgcCoN8AXN0qSYxWDxr7ZH7nG/d9T2shp/
         TRoGKdUoT3c8dpL0LU1MH37MfTxyIx7/XWzEdMyxps7hBxIEbQ0viLtuuUFIpi7a8hJM
         KFv2mYRPsVfEA4522FWgPoJaGv2udcS59IPRnvd8HrcY2sf8saqDssY7BsZUJ2PH3JML
         2XthI8ceHUGlCV6XzkGRWGhP8MY0csp0NqA8It2vGf4oZ0dQ4/xQBO2mFYvDonzraW3n
         yfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GpVIAE7NuViSh2roi918aATHpmfpAtvuxiYM7fHfD4Y=;
        b=JYSNwnaxAee8+aa4clTt7ev5/dmDPzuRLys8QhozpAYZbAMI/YG0CN+w4QLt5Ks/PW
         LVs7tNmysiNbLx9Pqp9kIeFMl8GDZH90xiAobagKKCDGvgUkGJgWceJJCvl8vmjUW5ew
         MC42D2Bvl5QrPqw9eVnNJ62wQiFx00HHDz9kfIWkRo47U0FlIri4ocrLXfgk8E6SnE6Y
         b/kX1zJBgehPeHQG5YBems/8C+T9rPJpLO+LTMRKBlI9cgxDbNDcBBMxt68LDMunCecN
         OKAOAVXXu07CIrX3rdFumLZbf4Oxa2ruEqGa+bmu3IISUDAFKoJSevTQuBl86OhmOinI
         OhdA==
X-Gm-Message-State: APjAAAV32PtPrkJMQEOMGy279GOgVMprl3smy1Q+yqMz5xOYYMYQtaoq
        U0B2zoCN3X7ZsZTZSirU2lpBJHGOUvV+Lg==
X-Google-Smtp-Source: APXvYqx5U/tXAWqgPEsHr6+R+/RNTyrvlX89saqzI7VQzY42BnODnSGZuJNl2Sx5SFqbOYRGRxnYXg==
X-Received: by 2002:a37:7bc7:: with SMTP id w190mr33196888qkc.193.1579190610661;
        Thu, 16 Jan 2020 08:03:30 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6813])
        by smtp.gmail.com with ESMTPSA id f19sm10192083qkk.69.2020.01.16.08.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:03:29 -0800 (PST)
Subject: Re: [PATCH] Btrfs: fix infinite loop during fsync after rename
 operations
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200115132135.23994-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2edf8b89-eb17-92a2-ab0d-cb90a654951e@toxicpanda.com>
Date:   Thu, 16 Jan 2020 11:03:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200115132135.23994-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/15/20 8:21 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Recently fsstress (from fstests) sporadically started to trigger an
> infinite loop during fsync operations. This turned out to be because
> support for the rename exchange and whiteout operations was added to
> fsstress in fstests. These operations, unlike any others in fsstress,
> cause file names to be reused, whence triggering this issue. However
> it's not necessary to use rename exchange and rename whiteout operations
> trigger this issue, simple rename operations and file creations are
> enough to trigger the issue.
> 
> The issue boils down to when we are logging inodes that conflict (that
> had the name of any inode we need to log during the fsync operation),
> we keep logging them even if they were already logged before, and after
> that we check if there's any other inode that conflicts with them and
> then add it again to the list of inodes to log. Skipping already logged
> inodes fixes the issue.
> 
> Consider the following example:
> 
>    $ mkfs.btrfs -f /dev/sdb
>    $ mount /dev/sdb /mnt
> 
>    $ mkdir /mnt/testdir                           # inode 257
> 
>    $ touch /mnt/testdir/zz                        # inode 258
>    $ ln /mnt/testdir/zz /mnt/testdir/zz_link
> 
>    $ touch /mnt/testdir/a                         # inode 259
> 
>    $ sync
> 
>    # The following 3 renames achieve the same result as a rename exchange
>    # operation (<rename_exchange> /mnt/testdir/zz_link to /mnt/testdir/a).
> 
>    $ mv /mnt/testdir/a /mnt/testdir/a/tmp
>    $ mv /mnt/testdir/zz_link /mnt/testdir/a
>    $ mv /mnt/testdir/a/tmp /mnt/testdir/zz_link
> 
>    # The following rename and file creation give the same result as a
>    # rename whiteout operation (<rename_whiteout> zz to a2).
> 
>    $ mv /mnt/testdir/zz /mnt/testdir/a2
>    $ touch /mnt/testdir/zz                        # inode 260
> 
>    $ xfs_io -c fsync /mnt/testdir/zz
>      --> results in the infinite loop
> 
> The following steps happen:
> 
> 1) When logging inode 260, we find that its reference named "zz" was
>     used by inode 258 in the previous transaction (through the commit
>     root), so inode 258 is added to the list of conflicting indoes that
>     need to be logged;
> 
> 2) After logging inode 258, we find that its reference named "a" was
>     used by inode 259 in the previous transaction, and therefore we add
>     inode 259 to the list of conflicting inodes to be logged;
> 
> 3) After logging inode 259, we find that its reference named "zz_link"
>     was used by inode 258 in the previous transaction - we add inode 258
>     to the list of conflicting inodes to log, again - we had already
>     logged it before at step 3. After logging it again, we find again
>     that inode 259 conflicts with him, and we add again 259 to the list,
>     etc - we end up repeating all the previous steps.
> 
> So fix this by skipping logging of conflicting inodes that were already
> logged.
> 
> Fixes: 6b5fc433a7ad67 ("Btrfs: fix fsync after succession of renames of different files")
> CC: stable@vger.kernel.org
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
