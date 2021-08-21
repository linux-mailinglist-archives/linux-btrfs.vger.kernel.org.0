Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6973F3822
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Aug 2021 04:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhHUC45 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 22:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUC44 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 22:56:56 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF8EC061575
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 19:56:18 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j187so10223119pfg.4
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 19:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6rCwQfaqDz1mvPBT77pjDTQGN8/bqaZlNkvzK2fWJCg=;
        b=RhO9GnUIRWdkSsdVyJqcoHsAtcP/l63QKN4um3hRojcd8PMpa+DPROXCLqzi3KhsAS
         0PBkibLfYXK8auq2IdzJ29iIBrjkYjZvz/Hejlf3sbesO1JozBYXv9siCMp7bBUA09gz
         M4tu9obnRgozP090lu8WNvsgpTtvn29kG+wI9Q10beks8AZ0Z7GbMLz0HnTA6gp/OqFm
         vtUXkVHW3Ku+y3WfJx2UORyO0UvW2a3xmYj3KVaf+VbVFijQMnfi2qCl9sT+ucjHYoWe
         SELw/FryF63UEI+/QhAA6x6IBF2h0mSRObsdeht8xKvhZ8lh23PQjK/fl+Xmp6S7QJSI
         QOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6rCwQfaqDz1mvPBT77pjDTQGN8/bqaZlNkvzK2fWJCg=;
        b=tm+2rEigYiDjyuET86On7TGj55lruvxsDBHCZsORSf8ZQg1wCftu3JDwkSOEYfzS+P
         e/LTgbtkWPxIgDBPacyPK9ZPW7Gvbq/Etr79EW2Xl4mYj2F1dLq9RVBhcsFRHu4QfJqN
         oKfrESwWoRgZbZyd0joZJe6+n4H1G6bBUpiAx4KtzdgIzhN3gJQ5uPZ1hYwP/7R7dCFQ
         C/TtVvlmfj2ZmdP3fnfEyffGvN6GOkCO6poHp6LiIrOoKOU04wf24cdewg72BOFwhIt+
         5sgjPDtR52jIFwAHzGthv7YelUff7sqQyM4BoutSJmfV35yHA9UKXCR+bz2CR8EokHRM
         Igag==
X-Gm-Message-State: AOAM532UuWpaHRnxidRgkzQJUDi+/wD9W8SebF1EFiV+nU9KxEaC7cuW
        i3TO4tANVU805Rcz2+rlATM=
X-Google-Smtp-Source: ABdhPJxshGk3bcQ+pDOpfFIqcPnzT6FdK3vdtuuNC0Cvs0iCD4fhHFPKHO3z2+NW862IDtg8PwJEjw==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr21569724pgq.206.1629514577441;
        Fri, 20 Aug 2021 19:56:17 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id 64sm8394681pfy.114.2021.08.20.19.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 19:56:15 -0700 (PDT)
Subject: Re: Trying to recover data from SSD
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
 <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
 <1c066a71-bc66-3b12-c566-bac46d740960@gmx.com>
 <d60cca92-5fe2-6059-3591-8830ca9cf35c@gmail.com>
 <c7fed97e-d034-3af1-2072-65a9bb0e49ef@gmx.com>
 <544e3e73-5490-2cae-c889-88d80e583ac4@gmail.com>
 <c03628f0-585c-cfa8-5d80-bd1f1e4fb9c1@gmx.com>
 <d7c65e1d-6f4e-484b-a52f-60084160969f@gmail.com>
 <2684f59f-679d-5ee7-2591-f0a4ea4e9fbe@gmx.com>
 <238d1f6c-20a9-f002-e03a-722175c63bd6@gmail.com>
 <4bd90f4a-7ced-3477-f113-eee72bc05cbb@gmx.com>
 <fab2dab5-41bb-43f2-5396-451d66df3917@gmail.com>
 <60a21bca-d133-26c0-4768-7d9a70f9d102@gmx.com>
From:   Konstantin Svist <fry.kun@gmail.com>
Message-ID: <7e8394c9-9eb3-c593-9473-5c40d80428a5@gmail.com>
Date:   Fri, 20 Aug 2021 19:56:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60a21bca-d133-26c0-4768-7d9a70f9d102@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/11/21 18:18, Qu Wenruo wrote:
>
>
> On 2021/8/12 上午6:34, Konstantin Svist wrote:
>>
>> Shouldn't there be an earlier generation of this subvolume's tree block
>> somewhere on the disk? Would all of them have gotten overwritten
>> already?
>
> Then it will be more complex and I can't ensure any good result.


It was already pretty complex and results were never guaranteed :)


>
> Firstly you need to find an older root tree:
>
> # btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root
>                 backup_tree_root:       30687232        gen: 2317
>  level: 0
>                 backup_tree_root:       30834688        gen: 2318
>  level: 0
>                 backup_tree_root:       30408704        gen: 2319
>  level: 0
>                 backup_tree_root:       31031296        gen: 2316
>  level: 0
>
> Then try the bytenr in their reverse generation order in btrfs ins
> dump-tree:
> (The latest one should be the current root, thus you can skip it)
>
> # btrfs ins dump-tree -b 30834688 /dev/sdb3 | grep "(257 ROOT_ITEM" -A 5
>
> Then grab the bytenr of the subvolume 257, then pass the bytenr to
> btrfs-restore:
>
> # btrfs-restore -f <bytenr> /dev/sdb3 <restore_path>
>
> The chance is already pretty low, good luck.
>
> Thanks,
> Qu 



When I run dump-tree, I get this:

# btrfs ins dump-tree -b 787070976 /dev/sdb3 | grep "(257 ROOT_ITEM" -A 5
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
Csum didn't match
WARNING: could not setup extent tree, skipping it

The same exact offset fails checksum for all 4 backup roots, any way
around this?


