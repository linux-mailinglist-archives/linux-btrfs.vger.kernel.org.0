Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8685259AF66
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Aug 2022 20:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiHTSLv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Aug 2022 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiHTSLu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Aug 2022 14:11:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358103FA33
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Aug 2022 11:11:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b38so7414615lfv.4
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Aug 2022 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=zhfg2trsSffcWFYAoU8QxD+HOzShSXyDx6lrv7HR/mg=;
        b=f+M1Yj5qfmUG1f9xoJ89ES9sLIiMafGqj7MS3LycbMq0acv6XiVLRE92MqfKWaPz+V
         4JFHhOhQLOpz9uULZ4NKfUapcwZH9I7S+KoTuI7o5GNWwWfUELobRNIsV9vXVq6V+GEo
         pawGQFj0qWw0l1o8XCw7R7mjtb7IGO+sC0EAlvHh0yC7Ntws/igPYEAid1nTEqNm84y3
         ZOJcjBGaE5ZQxm70lO2ISld0/MTXLG2260nB6jKMXs91wqlfFsYykzrRiA9lBOnmSEnB
         jcZJ5o3JPc8DpczHUwf6K8EGe5f/XEahp+aTiCnlsV4PsRf5yiB1hoVY+sV6vy3i8zfQ
         0ouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=zhfg2trsSffcWFYAoU8QxD+HOzShSXyDx6lrv7HR/mg=;
        b=X2irRaESaqulWyoUh1+LyklvXW5lF1pe1iInd2RU/iLnRzjwYe6u2vftCDBwAu/R8x
         cSouACwMt79XRzREJyJL79nCQGTak+ggQ3P8EGgOr1/0kndMVBniH3RTqs4JjA73+cFS
         f8noPvwmtzAJ+9csHiT4+oVx2Y6ntnlSpqXnHQNEo6PzXoq44e7UdyGEuCAeJGtjyoSu
         SF4vju9v5NEf3HndDvQ73n/mz/rLUX/G+tbbxW2eGVuYcTKyJva6MQZvR2tSUP/hHQtr
         rK8Zuw7jM75g8YOmqON1DDLPqR+A8M8OVnSieCIH+HP2uq/cX7brRALVkbxGCMY6twTW
         2gBw==
X-Gm-Message-State: ACgBeo2iTSBjQZpsDVbKA/5Q3tZMUTOIo4vE/1nJfx7cQriVmEPGwHtD
        HBRY9S4FxLiMs2sz8Fgdt75uqBxOsfM=
X-Google-Smtp-Source: AA6agR6Mp2XhgQtOcJSMklPfJCFgOV65qtNQcuLEk30/qlk8M4pwHIYVRNuICqsghXbjcDb0pcwFVw==
X-Received: by 2002:a05:6512:151e:b0:492:cbd3:e8cf with SMTP id bq30-20020a056512151e00b00492cbd3e8cfmr2448302lfb.262.1661019107454;
        Sat, 20 Aug 2022 11:11:47 -0700 (PDT)
Received: from [192.168.1.109] ([176.124.146.151])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b0047dace7c7e5sm1165190lfq.212.2022.08.20.11.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 11:11:47 -0700 (PDT)
Message-ID: <c0080bf6-c433-30f1-83aa-de8ecba60bee@gmail.com>
Date:   Sat, 20 Aug 2022 21:11:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: What exactly is BTRFS Raid 10?
Content-Language: en-US
To:     kreijack@inwind.it, George Shammas <btrfs@shamm.as>,
        linux-btrfs@vger.kernel.org
References: <a3fc9d94-4539-429a-b10f-105aa1fd3cf3@www.fastmail.com>
 <aa81ac50-0f2f-73c0-5174-1709ec24b52c@libero.it>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <aa81ac50-0f2f-73c0-5174-1709ec24b52c@libero.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20.08.2022 14:28, Goffredo Baroncelli wrote:
> 
> RAID1:
> A new chunk is allocated to the two disks with more space available. Each new chunk has a size of 1GB x 2 = 2GB, but only 1GB is available for the data because the other one contains a copy of the data.
> A raid1 layout may have more than two disks. However the data is copied only two times, this means that you can tolerate only the lost of one device.
> For example the first chunk is allocated on the first two disks; the 2nd chunk is allocated on the first and the 3rd disk; the 3rd chunk is allocated on the 2nd and 3rd disk....
> 
...
> 
> RAID10:
> Is a mix of RAID0 and RAID1: the data is copied two times (so you can tolerate the lost of one device), but it is spread over near all the disks.
> If you have 7 disks, a new chunk is allocated over 6 disks (the greatest even number <= to the disk count) with more space available.
> If you write data to a disk, the first 64K are written on the 1st disk and and the 2nd disk (as 2nd copy). When you write the 2nd 64 k of data, these are written in the 3rd disk and 4th disk (as 2nd copy). And so on until you fill the chunk.
> When the chunk is filled, a new allocation occurred. Likely the 7th disk is used and one of the first 6 isn't for the new chunk.
> 

Is large IO processed in parallel? If I have 8 disks raid10 and issue
256K request - will btrfs submit 4 concurrent 64K requests to each disk?

And for raid1 - will there be single 256K physical disk request or 4 x
64K requests?

What about read requests - will all disks in raid1/raid10 be used
concurrently or btrfs always reads from the "primary" copy (and how it
is determined then)?
