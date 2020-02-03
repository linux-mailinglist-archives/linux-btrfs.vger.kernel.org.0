Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A42E150A61
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 16:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgBCP5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 10:57:44 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43133 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgBCP5o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 10:57:44 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so6990079qvo.10
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 07:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1MQ7FPVnhRTw+81gjVP6g6iR55P6f2OW5I5hdKxVoZQ=;
        b=TX8rj5PSTPQfMz4AgvxcqnPOLllo1MDMu6YFs8qZ9al4Vjnc0/0letHR52zL5jfPgl
         RRsaX+EU5aEF1lmyQGLQ6Xol3hRZm0B9lDrUSAAAImfEaPeNAllccHyqkbVa7UqGBTRo
         0vUNTM8nWV/g9iQ2/+O408srkV4XwwRy5C8XdjyNpbyXPzkjXy48NCjmh1yMjSmBaNVV
         Zahk7UECPvtYVH/jShgA2pgniEs/XRlgH4zKNE025qEjooCW719LYt8cA4YWgCyyTbhZ
         UNJrk4xnEocptPIrgQD0Tjt7Nw01mfGK8HPwR+kzeY5dXXaUEN3FNefvbBel0PFZPau6
         5jlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1MQ7FPVnhRTw+81gjVP6g6iR55P6f2OW5I5hdKxVoZQ=;
        b=QjuzP1OWSuxLeYg92vJ2NIJn0yZC6AU/u5wzH5oRLncFl3rpuu/GkBmM0VtiNZhoaG
         974PnAhDoyqZFCrfz/Mo78zA6pPUZ+xAEqzhlYfaUvZVUg+HdshrH6TXg+J9GR5mywrL
         tSalJY5/s1qPQAcm4N8oxZy6AGwXa/OPB95MoxPkKXDpc/7LadwmZNjSlTen+nbvrwMA
         u/3Y2CcGnIomUdmfjkz7Tde2yPoI9oBfilqdebrSESWgkE7F88gRYjl8oWHc3Pa/2m5n
         yfOdjJPIyWvBG04JmlnFzVasvJXt5CNdfC5Ws/z1gdkH6C6GdkOuCLG0VOvO1EVA38JY
         kSGg==
X-Gm-Message-State: APjAAAWIcrIvQp4009WevLFB+4UxeSmt5A1K/ULLMfgBVHNriPFL2GOh
        pIJ75Ss3Ov8Rf+tzyleePUlE0lTIV5kDkQ==
X-Google-Smtp-Source: APXvYqz+/AZuWGJ4jFXTc5oOaaIMVsd/Kwd8Gnwm0zk0b25tI197IEbFijzHX8X+YwkttTEMle58jw==
X-Received: by 2002:a05:6214:707:: with SMTP id b7mr22900842qvz.97.1580745463087;
        Mon, 03 Feb 2020 07:57:43 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h12sm10028468qtn.56.2020.02.03.07.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 07:57:42 -0800 (PST)
Subject: Re: [PATCH 11/23] btrfs: check tickets after waiting on ordered
 extents
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200131223613.490779-1-josef@toxicpanda.com>
 <20200131223613.490779-12-josef@toxicpanda.com>
 <bff2845a-6947-dfdf-ae1f-d04ebd10eca4@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9e2fe1a4-cc0a-57be-8374-1a40f98a65aa@toxicpanda.com>
Date:   Mon, 3 Feb 2020 10:57:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <bff2845a-6947-dfdf-ae1f-d04ebd10eca4@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/3/20 8:10 AM, Nikolay Borisov wrote:
> 
> 
> On 1.02.20 г. 0:36 ч., Josef Bacik wrote:
>> Right now if the space is free'd up after the ordered extents complete
>> (which is likely since the reservations are held until they complete),
>> we would do extra delalloc flushing before we'd notice that we didn't
>> have any more tickets.  Fix this by moving the tickets check after our
>> wait_ordered_extents check.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> This patch makes sense only for metadata. Is this your intention -
> tweaking the metadata change behavior? Correct me if I'm wrong but
> 
> btrfs_start_delalloc_roots from previous patch will essentially call
> btrfs_run_delalloc_range for the roots which will create ordered extents in:
> btrfs_run_delalloc_range
>    cow_file_range
>     add_ordered_extents
> 
> Following page writeout, from the endio routines we'll eventually do:
> 
> finish_ordered_fn
>   btrfs_finish_ordered_io
>    insert_reserved_file_extent
>     btrfs_alloc_reserved_file_extent
>      create delayed ref  <---- after the delayed extent is run this will
> free some data space. But this happens in transaction commit context and
> not when runnig ordered extents
>    btrfs_remove_ordered_extent
>     btrfs_delalloc_release_metadata <- this is only for metadata
>      btrfs_inode_rsv_release
>       __btrfs_block_rsv_release <-- frees metadata but not data?
> 
> 
> I'm looking those patches thinking every change should be pertinent to
> data space but apparently it's not. If so I think it will be best if you
> update the cover letter for V2 to mention which patches can go in
> independently or give more context why this particular patch is
> pertinent to data flush.
> 


Specifically what I'm addressing here for data is this behavior

btrfs_start_delalloc_roots()
   ->check space_info->tickets, it's not empty
btrfs_finish_ordered_io()
   -> we drop a previously uncompressed extent (ie larger one) for a newly
      compressed extent, now space_info->tickets _is_ empty
loop again despite having no tickets to flush for.

Does this scenario happen all the time?  Nope, but I noticed it was happening 
sometimes with the data intensive enopsc tests xfstests so I threw it in there 
because it made a tiny difference, plus it's actually correct.

It definitely affects the metadata case more for sure, but I only noticed it 
when I forgot I had compression enabled for one of my xfstests runs.  Thanks,

Joosef
