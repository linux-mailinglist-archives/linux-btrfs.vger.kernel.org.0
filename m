Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7E33FAE53
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 22:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbhH2UDA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 16:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbhH2UDA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 16:03:00 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAF5C061575
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 13:02:07 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q68so11348282pga.9
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DSRMYpXUlWEn3ZK+ewumta/haEIY9FlrZ8jQsmiqJKk=;
        b=IunugvwTAEd5OQNLY9nulNK9feReoBxJrB8CgEoWPHjzidVtxjBkuKu+/0GBy/UTJQ
         cglO8yoL5hO9lBVL1iGHGop+QkVa/x1e4Zl1Z3skxTyXAPcK64+jjCzlQ6oGD8P9PZmd
         vVvdfLxw2Hc5MrUtcl+YYhubbKGN9x11JcqiPo0supUracHGe5dQOD/QBDfRNYh3CKrP
         bjyxDBth0ikB0gb27TCGHtQsYNzFfYBGejBKQdkr38/xwOtAeMlHo7HfafN3RlagOf5C
         a4zaMKSf/zurxnsXxRXke1fKa7lqhSdU4nTbDxXthrAGu5gKZcJcAco7iBe81jhZozb/
         557A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DSRMYpXUlWEn3ZK+ewumta/haEIY9FlrZ8jQsmiqJKk=;
        b=iGEw6FhVQ0KFltzi+eEKiyfGF5sEf61poV9oRMcD0Tvpn+ahn+uER+ibq4XZZM0Vs5
         gdKWbh3f4D6iBMlLLk0rIpGre3jPZ4PltO3CkhyYIrMb0CgpOePf1wuFs9kJVti9CxN+
         m3C5P78VO5MRSe3Hf0WOWy0Q671n9cRBwmpmooWLom4YwCaVpyEJHCWVaqEz3otILNc+
         IJumRhEJFpSyN6RdqcKqync9HoVR462vRTMjsGjmCK80PIpUlUia8v+nTUwMmhHTKqsR
         aTWLomDVQdLhHsY7fssohNMx39GN+2roET2VntgX6DiIw4xS35huOrwEYyVmwUoKXqWZ
         6KwQ==
X-Gm-Message-State: AOAM53338St2gRWtC7C0ValXgJuiQ0xY2NzmN1kQalpiru6Q5eEaK4Um
        YVMF6b11p+K1FYJqz8BSHfZC+cCr0d3mGg==
X-Google-Smtp-Source: ABdhPJw0xSzGifSUablwogZz4gIR7fYMioLnwYyWlxoEdyiC8XYa/UHxnJlS3ubqtguKn6u7HI4qTw==
X-Received: by 2002:a62:88d7:0:b0:3fd:b2db:79c5 with SMTP id l206-20020a6288d7000000b003fdb2db79c5mr4179932pfd.21.1630267326958;
        Sun, 29 Aug 2021 13:02:06 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id l185sm12513159pfd.62.2021.08.29.13.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 13:02:05 -0700 (PDT)
Subject: Re: Trying to recover data from SSD
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
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
 <7e8394c9-9eb3-c593-9473-5c40d80428a5@gmail.com>
 <1785017b-e23b-e93d-5b78-2aa40170fe62@gmail.com>
 <14a9a98c-50fc-eb7b-804b-2fe36775b5fa@gmx.com>
 <36652872-850c-fe92-9fcd-c9c95dc25d65@gmail.com>
 <cebedd98-1fe4-731f-fc54-5366c8f18a2f@gmx.com>
 <d0ebdff7-10f0-c8f3-e098-18f651a149d8@gmail.com>
 <597bd681-c7ba-075c-4376-142695b91f93@gmx.com>
From:   Konstantin Svist <fry.kun@gmail.com>
Message-ID: <4a5d64fd-637c-bd8a-fe6f-db1bb20942c2@gmail.com>
Date:   Sun, 29 Aug 2021 13:02:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <597bd681-c7ba-075c-4376-142695b91f93@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/29/21 00:19, Qu Wenruo wrote:
>
>
> On 2021/8/29 下午2:34, Konstantin Svist wrote:
>>
>> # btrfs ins dump-tree -b 787070976 --follow /dev/sdb3 | grep "(257
>> ROOT_ITEM" -A 5
>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>> Csum didn't match
>> WARNING: could not setup extent tree, skipping it
>>      item 13 key (257 ROOT_ITEM 0) itemoff 13147 itemsize 439
>>          generation 166932 root_dirid 256 bytenr 786726912 level 2
>> refs 1
>>          lastsnap 56690 byte_limit 0 bytes_used 1013104640 flags
>> 0x0(none)
>>          uuid 1ac60d28-6f11-2842-aca2-b1574b108336
>>          ctransid 166932 otransid 8 stransid 0 rtransid 0
>>          ctime 1627959592.718936423 (2021-08-02 19:59:52)
>>
>>
>> # btrfs restore -Divf 786726912 /dev/sdb3 .
>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>> Csum didn't match
>> WARNING: could not setup extent tree, skipping it
>> This is a dry-run, no files are going to be restored
>> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
>> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
>> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
>> bad tree block 920748032, bytenr mismatch, want=920748032, have=0
>> ERROR: search for next directory entry failed: -5
>
> This all zero means the data on-disk are wiped.
>
> Either not reaching disk or discarded.
>
> Neither is a good thing.
>
>>
>>
>> 1st set of "checksum verify failed" has different addresses, but the
>> last set always has 920748032
>
> Have you tried other bytenrs from find-root?


Is it normal that they all fail on the same exact block? Sounds
suspicious to me.


The other 3 attempts:


# btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root
        backup_tree_root:    787070976    gen: 166932    level: 1
        backup_tree_root:    778108928    gen: 166929    level: 1
        backup_tree_root:    781172736    gen: 166930    level: 1
        backup_tree_root:    786399232    gen: 166931    level: 1

# btrfs ins dump-tree -b 786399232 --follow /dev/sdb3 | grep "(257
ROOT_ITEM" -A 5
[...]
    item 13 key (257 ROOT_ITEM 0) itemoff 13147 itemsize 439
        generation 166931 root_dirid 256 bytenr 781467648 level 2 refs 1
        lastsnap 56690 byte_limit 0 bytes_used 1013104640 flags 0x0(none)

[...]

# btrfs restore -Divf 781467648 /dev/sdb3 .
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
Csum didn't match
WARNING: could not setup extent tree, skipping it
This is a dry-run, no files are going to be restored
checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
bad tree block 920748032, bytenr mismatch, want=920748032, have=0
ERROR: search for next directory entry failed: -5

# btrfs ins dump-tree -b 781172736 --follow /dev/sdb3 | grep "(257
ROOT_ITEM" -A 5
[...]
    item 13 key (257 ROOT_ITEM 0) itemoff 13147 itemsize 439
        generation 166930 root_dirid 256 bytenr 780828672 level 2 refs 1
        lastsnap 56690 byte_limit 0 bytes_used 1013104640 flags 0x0(none)
[...]


# btrfs restore -Divf 780828672 /dev/sdb3 .
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
Csum didn't match
WARNING: could not setup extent tree, skipping it
This is a dry-run, no files are going to be restored
checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
bad tree block 920748032, bytenr mismatch, want=920748032, have=0
ERROR: search for next directory entry failed: -5

# btrfs ins dump-tree -b 778108928 --follow /dev/sdb3 | grep "(257
ROOT_ITEM" -A 5
[...]

   item 13 key (257 ROOT_ITEM 0) itemoff 13147 itemsize 439
        generation 166929 root_dirid 256 bytenr 102760448 level 2 refs 1
        lastsnap 56690 byte_limit 0 bytes_used 1013104640 flags 0x0(none)
[...]


# btrfs restore -Divf 102760448 /dev/sdb3 .
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
Csum didn't match
WARNING: could not setup extent tree, skipping it
This is a dry-run, no files are going to be restored
checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
bad tree block 920748032, bytenr mismatch, want=920748032, have=0
ERROR: search for next directory entry failed: -5

