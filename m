Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE2669F9D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 18:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjBVRS2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 12:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjBVRS1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 12:18:27 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9730BA5F1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 09:18:26 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id b12so943713ils.8
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 09:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPyhrp/fWi6m0T8y48mX7SV3fXWuCf+DN39lAY2ucxY=;
        b=dA3MPu+c6uoBnKR9zbPMB9VcPiGNCcHHzrvu2Zym3N3Qpdd40l3fUGCV8HYqGUHmHs
         IteGkt6SO15qzHbRXfGa/HuLVzEvmxyy/n2XDoHOLqbZbVsEPsQk2aRsIc/gqXHfmyhJ
         kTJUMOJzGfcslllwzKpgNyaTffOu++Ds0dHSQme3ZaQfu63eO1RxrOZ9aCUl3zC9D/Y/
         NXj19IQg0uxDefOnOcevYOnPCQ8h5/8Q68ZGKH8eYtVWVBVjzy1rDOLqOhcg0sd5Kken
         QdKiIUhLDjbNpO/HO2oulwn7BBH5U618dZBLyYmTzPI16pMhtQG3rCxIafIstNRFF7DF
         DNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPyhrp/fWi6m0T8y48mX7SV3fXWuCf+DN39lAY2ucxY=;
        b=EWGAJxyd3mgzuThqJoSZtzXuncfoUnaAlTXnycydmMcZLfnxc5GAzSqOW7PyP4Txxo
         wEKH+s3bp65VxHe/5Wc0tGpUiA32hDB8/LeKPJ3dzgtC95/qaifzU4rbGq6gKSwC+xGV
         xowPyzeW24wMbkGqLu97cO3gfR2yLdKne8L9w5OM2R2jzuIxTx0L5dQBQ3dn3juZll2Q
         +lT5xKfX5uFZu2Pet+JvhrJbknzA/hZTMk3n/F3oId/qZCQLGWP53f80Bp1YVhVCQjCu
         VWGPQr57b4ivAfAq2GPSIAHOnFt+jMQ77XpbZ5G8TyRR4wzwWc2hItOk2ekmy5oI9TMA
         R/pg==
X-Gm-Message-State: AO0yUKXcaopvk5exaHYXf2tyQN8T4OUk6tnMhqTUUZ/1hZ6qAd1EJY32
        SzRmqcy/z0T8ui3xPAE5xMs=
X-Google-Smtp-Source: AK7set8WoDZXbm0NrYujhmevLdlvIdE81ZaJfWA3kqISAJmLFVdPjmHEDaSN0yGlZ4nLGm3srJubmQ==
X-Received: by 2002:a92:7a0c:0:b0:30f:36e0:21d1 with SMTP id v12-20020a927a0c000000b0030f36e021d1mr7072391ilc.3.1677086305961;
        Wed, 22 Feb 2023 09:18:25 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v25-20020a02b919000000b003b0692eb199sm1532179jan.20.2023.02.22.09.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 09:18:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6c308ddc-60f8-1b4d-28da-898286ddb48d@roeck-us.net>
Date:   Wed, 22 Feb 2023 09:18:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1671221596.git.josef@toxicpanda.com>
 <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
 <20230222025918.GA1651385@roeck-us.net>
 <20230222163855.GU10580@twin.jikos.cz>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 8/8] btrfs: turn on -Wmaybe-uninitialized
In-Reply-To: <20230222163855.GU10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/22/23 08:38, David Sterba wrote:
> On Tue, Feb 21, 2023 at 06:59:18PM -0800, Guenter Roeck wrote:
>> On Fri, Dec 16, 2022 at 03:15:58PM -0500, Josef Bacik wrote:
>>> We had a recent bug that would have been caught by a newer compiler with
>>> -Wmaybe-uninitialized and would have saved us a month of failing tests
>>> that I didn't have time to investigate.
>>>
>>
>> Thanks to this patch, sparc64:allmodconfig and parisc:allmodconfig now
>> fail to commpile with the following error when trying to build images
>> with gcc 11.3.
>>
>> Building sparc64:allmodconfig ... failed
>> --------------
>> Error log:
>> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>> fs/btrfs/inode.c: In function 'btrfs_lookup_dentry':
>> fs/btrfs/inode.c:5730:21: error: 'location.type' may be used uninitialized [-Werror=maybe-uninitialized]
>>   5730 |         if (location.type == BTRFS_INODE_ITEM_KEY) {
>>        |             ~~~~~~~~^~~~~
>> fs/btrfs/inode.c:5719:26: note: 'location' declared here
>>   5719 |         struct btrfs_key location;
> 
> Thanks for the report, Linus warned me that there might be some fallouts
> and that the warning flag might need reverted. But before I do that I'd
> like to try to understand why the warnings happen in a code where is no
> reason for it.
> 
> I did a quick test on gcc 11.3 (on x86_64, not on sparc64 unlike you
> report), and there is no warning
> 
> gcc (SUSE Linux) 11.3.1 20220721 [revision a55184ada8e2887ca94c0ab07027617885beafc9]
> Copyright (C) 2021 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
>    DESCEND objtool
>    CALL    scripts/checksyscalls.sh
>    CC [M]  fs/btrfs/inode.o
> 
> I.e. it's the same version, different arch and likely not the same
> config. In the function itself thre's a local variable passed by address
> to a static function in the same file.
> 
> 	struct btrfs_key location;
> 	...
> 	ret = btrfs_inode_by_name(BTRFS_I(dir), dentry, &location, &di_type);
> 
> and there it's
> 
> 	btrfs_dir_item_key_to_cpu(path->nodes[0], di, location);
> 
> which is a series of helpers to read some data and store that to the
> strucutre. At some point there's a call to read_extent_buffer() that's
> in a different file.
> 
> A local variable passed by address to external function is quite common
> so I'd expect more warnings and I don't see what's different in this
> case.

Me not either. I also don't see the problem with other architectures, only
with sparc and parisc. It doesn't have to be gcc 11.3, though; it also happens
with gcc 11.1, 11.2, 12.1, and 12.2 (tested on sparc).

Too bad that gcc doesn't tell why exactly it believes that the object
may be uninitialized. Anyway, the following change would fix the problem.

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6c18dc9a1831..4bab8ab39948 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5421,7 +5421,7 @@ static int btrfs_inode_by_name(struct btrfs_inode *dir, struct dentry *dentry,
                 return -ENOMEM;

         ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 1, &fname);
-       if (ret)
+       if (ret < 0)
                 goto out;

Presumably gcc assumes that fscrypt_setup_filename() could return
a positive value.

Guenter

