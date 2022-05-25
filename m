Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5A533635
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 06:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiEYEe6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 00:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiEYEe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 00:34:57 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8498260AA5
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 21:34:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id CBB443F79A;
        Wed, 25 May 2022 06:34:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -3.1
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DtRKKd22MJsg; Wed, 25 May 2022 06:34:49 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id AA5783F623;
        Wed, 25 May 2022 06:34:49 +0200 (CEST)
Received: from [192.168.0.10] (port=50126)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1ntijP-000MGx-Hy; Wed, 25 May 2022 06:34:48 +0200
Message-ID: <1e7afa05-3510-25c4-43d5-f1a6678ddcf8@tnonline.net>
Date:   Wed, 25 May 2022 06:34:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: cp --reflink and NOCOW files
Content-Language: en-GB
To:     Matthew Warren <matthewwarren101010@gmail.com>, kreijack@inwind.it
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <c6f55508-a0df-aea3-279d-75648793dfb2@libero.it>
 <CA+H1V9zNSiJgXj6w8i2syhm_4qeaxkYPZHuxLgjmfP-jjGMYBQ@mail.gmail.com>
From:   Forza <forza@tnonline.net>
In-Reply-To: <CA+H1V9zNSiJgXj6w8i2syhm_4qeaxkYPZHuxLgjmfP-jjGMYBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> 
> On Tue, May 24, 2022 at 8:19 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>>
>> Hi All,
>>
>> recently I discovered that BTRFS doesn't allow to reflink a file
>> when the source is marked as NOCOW
>>
>> $ lsattr
>> ---------------C------ ./file-very-big-nocow
>> $ cp --reflink file-very-big-nocow file2
>> cp: failed to clone 'file2' from 'file-very-big-nocow': Invalid argument
>> $ strace cp --reflink file-very-big-nocow file2 2>&1 | egrep ioctl
>> ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EINVAL (Invalid argument)
>>
>> My first thought was that it would be sufficient to remove the "nocow" flag.
>> But I was unable to do that.
>>
>> $ chattr -C file-very-big-nocow
>>
>> $ strace cp --reflink file-very-big-nocow file2 2>&1 | egrep ioctl
>> ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EINVAL (Invalid argument)
>>
>> (I tried "chattr +C ..." too)
>>
>> Ok, now my question is: how we can remove the NOCOW flag from a file ?
>>
>> My use case is to move files between subvolumes some of which are marked as NOWCOW.
>> The files are videos, so I want to avoid to copy the data.
>>
>>
>> BR
>>
>> --
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

On 2022-05-25 04:19, Matthew Warren wrote:
 > Goffredo,
 >
 > You can only reflink files which are COW. If you want to reflink files
 > which are NOCOW, you have to copy them to a COW file (eg. cp
 > file-very-big-nocow file-very-big-cow) and then you can reflink it.
 > It's recommended to keep everything COW unless it has many random
 > writes like databases and virtual machines.
 >
 > Matthew Warren

The problem is with coreutils and 'cp', not Btrfs. It is possible to 
reflink copy nodatacow files. The requirement is that the target is also 
nodatacow. Deduplication of nodatacow files has the same limitation as well.

Example:

# touch foo
# chattr +C foo
# truncate -s1G foo
# ll
total 16
drwxr-xr-x 1 root root          6 May 25 06:24 ./
drwxr-xr-x 1 root root        148 May 16 21:53 ../
-rw-r--r-- 1 root root 1073741824 May 25 06:24 foo

# lsattr
---------------C------ ./foo

# cp --reflink=auto foo bar
'foo' -> 'bar'

# ll
total 1048592
drwxr-xr-x 1 root root         12 May 25 06:24 ./
drwxr-xr-x 1 root root        148 May 16 21:53 ../
-rw-r--r-- 1 root root 1073741824 May 25 06:24 bar
-rw-r--r-- 1 root root 1073741824 May 25 06:24 foo

# lsattr
---------------C------ ./foo
---------------------- ./bar

We can see that 'bar' is a normal file. It did not get reflinked.
The solution is instead to create the target file with +C first.

# rm bar
# touch bar
# chattr +C bar
# cp --reflink=auto foo bar
'foo' -> 'bar'

# ll
total 16
drwxr-xr-x 1 root root         12 May 25 06:25 ./
drwxr-xr-x 1 root root        148 May 16 21:53 ../
-rw-r--r-- 1 root root 1073741824 May 25 06:25 bar
-rw-r--r-- 1 root root 1073741824 May 25 06:24 foo

# lsattr
---------------C------ ./foo
---------------C------ ./bar
