Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8131C53313A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 21:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbiEXTEm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 15:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbiEXTEe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 15:04:34 -0400
Received: from libero.it (smtp-33.italiaonline.it [213.209.10.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB053ED24
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 12:03:18 -0700 (PDT)
Received: from [192.168.1.27] ([78.12.14.90])
        by smtp-33.iol.local with ESMTPA
        id tZnmnDyUZtMz4tZnmnmCDB; Tue, 24 May 2022 21:02:42 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1653418962; bh=gyH00TqffGmaeqnisLqFQobpLC7yo/Qfw5Of8p89cH0=;
        h=From;
        b=thefg2zomnAbQyeFoG/fGnqs8WX9KaEODT60MAfMCHbU8++iAgKOTvXHKqm1hQnNQ
         gCB1pwKMgVSeEA1O+X5eT9CmbWEDEAsddJGTi4oYG0ifbUzloW0+0u3IJVjlFCBsh5
         UTvzikMCoUWDtKKpxhUqMjSB7NPys1XPBtbvwiTBk9n2ksnTVkKN7X8PjoRC/4N0s1
         lstqqgRtnw9IZYaMUdsAk4wTFGIF7OoO0BOJHs3nah7Ogr+mcw2SnYHODKCm1k/u5z
         CmvJa0ZcI3Do5xC3rJxvm1HBVsKrEuGTFP2Z4yDujCZ6rpK5VBBa4wSJrLDvnw//Xb
         DsDRWjM69hBRg==
X-CNFS-Analysis: v=2.4 cv=RvwAkAqK c=1 sm=1 tr=0 ts=628d2bd2 cx=a_exe
 a=tzWkov1jpxwUGlXVT4HyzQ==:117 a=tzWkov1jpxwUGlXVT4HyzQ==:17
 a=IkcTkHD0fZMA:10 a=ciYIJ-ledbM0H_Oy7lUA:9 a=QEXdDO2ut3YA:10
Message-ID: <c6f55508-a0df-aea3-279d-75648793dfb2@libero.it>
Date:   Tue, 24 May 2022 21:02:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: kreijack@inwind.it
Content-Language: en-US
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Subject: cp --reflink and NOCOW files
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKNFmwHmgb2pbRWaKYRyyvkA7rLFL2yEjeWTDt2h1qlytnPNSkJyQc1BLLYhfeTx/4SQzZ11jYndNNLL0eGUUTWARlAmVnqwyvXljyNSan3brs7loiiG
 oCR3wtJkqxQd0XyiPP71ioefHwoew9Es2KFlSau4KcFJm+tl5kI6z6PEfCg0Lst5sIj9J251x+uLhg==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi All,

recently I discovered that BTRFS doesn't allow to reflink a file
when the source is marked as NOCOW

$ lsattr
---------------C------ ./file-very-big-nocow
$ cp --reflink file-very-big-nocow file2
cp: failed to clone 'file2' from 'file-very-big-nocow': Invalid argument
$ strace cp --reflink file-very-big-nocow file2 2>&1 | egrep ioctl
ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EINVAL (Invalid argument)

My first thought was that it would be sufficient to remove the "nocow" flag.
But I was unable to do that.

$ chattr -C file-very-big-nocow

$ strace cp --reflink file-very-big-nocow file2 2>&1 | egrep ioctl
ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EINVAL (Invalid argument)

(I tried "chattr +C ..." too)

Ok, now my question is: how we can remove the NOCOW flag from a file ?

My use case is to move files between subvolumes some of which are marked as NOWCOW.
The files are videos, so I want to avoid to copy the data.


BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
