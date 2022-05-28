Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8A15369E9
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 May 2022 03:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiE1BvI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 21:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiE1BvH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 21:51:07 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A313981D
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 18:51:04 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id s5so5758961qvo.12
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Et+VR9VpolYuZ92iq7StkSu4G+gaedfm89Dyw42vRD4=;
        b=ClKGEDSVpgqCfl0RZIhZpPtywj5YpunTKJG1MXDX5fI1flzqnZDFjw2jF3o7ebh26j
         cz3fnUxsQn+i4Ess3NGpIb/fHqh+WgLJv3A3HDN4yMUrMY6CHJEm7G5QUdyGCGDPhTIZ
         IvAX1tDPhMjdat8fofBcZOhCrHPf619EpsvMTHV2CflW54N/c0IDA/6KNvDH71fxHHO3
         O8QwkV6OwcfhTlFRltAeVhH1ldMxvrmG6JP6xKVdjzAmuYoIq+a/m4feh/8Ymv3U/UVP
         pjCT5pNnpzd46+Dl/pIPoRDsQdJivbYxKlOWV2N9oO18PFij5K11NbY9zTgnYilcPuJK
         pEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Et+VR9VpolYuZ92iq7StkSu4G+gaedfm89Dyw42vRD4=;
        b=zpxlDilmX+MjfeeIR2Gu7TL5py3qPVO27FA9zI3/EgY7P985Sg+OXeVeSutvX2t3Un
         smuL0xnJYuWO41kFMVt3SaGC7NSDlnQX9dRM3WvwpeRmfSDORoQP9YFaaWY7ONtjwiYR
         mWw0SQCrqxygWDEx10EFpyn15OZeo3S+Grhm6O4eYJ9Or9U1Fxfpwv74w1okTeQRgiWX
         AuAWwf0F/FzhySSgEy3RrFT/rGY6y+hhUyxZx+3xBnh8vxj7kIWOPVuwKkuuTv68IshF
         pjDXDRRt4A9bwNMoToCNwoiWjSLDpnY8sWC+Uo/LcB5gVCmDYjPmTYiMZWGzZXhnq52L
         UZxA==
X-Gm-Message-State: AOAM530OLOu90Bnt/69ZIelbaQFuqx7yWp7pm/JbnUbll5BKfw78kH1d
        mSDqgcVHgQYFINO3zdnrHoZlkZxtceDTZw==
X-Google-Smtp-Source: ABdhPJxPfD7eUisan37zKQIWR0M9XMTtqfEN4V64HtRtdG87dQ7p7eDJ/m4y3AZ5C+3LfrkbIUm8Bg==
X-Received: by 2002:a05:6214:4006:b0:432:ea2b:5aad with SMTP id kd6-20020a056214400600b00432ea2b5aadmr37752323qvb.39.1653702663914;
        Fri, 27 May 2022 18:51:03 -0700 (PDT)
Received: from ?IPV6:2601:46:c600:af85:8c40:e9db:35ac:5452? ([2601:46:c600:af85:8c40:e9db:35ac:5452])
        by smtp.gmail.com with ESMTPSA id p199-20020a37a6d0000000b0069fc13ce253sm3267757qke.132.2022.05.27.18.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 18:51:03 -0700 (PDT)
Message-ID: <dfc1abba-da2e-168d-d7de-0e516df0f9d7@gmail.com>
Date:   Fri, 27 May 2022 21:51:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Btrfs progs release 5.18
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20220525140644.21979-1-dsterba@suse.com>
 <95422f7b-e0f9-c716-212e-ee1007176d7e@gmail.com>
 <90214e83-4450-8e0f-6a86-f30acaeda931@gmx.com>
From:   John Center <jlcenter15@gmail.com>
In-Reply-To: <90214e83-4450-8e0f-6a86-f30acaeda931@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Duh!  Yes, that was the problem. Thanks, Qu!  -John


On 5/27/22 9:34 PM, Qu Wenruo wrote:
>
>
> On 2022/5/28 08:20, John Center wrote:
>> Hi,
>>
>> I usually build the btrfs-progs when it comes out.  I've upgraded from
>> Ubuntu 20.04 to 22.04 & I'm having a problem with configure looking for
>> ext2fs.  I have e2fsprogs & libext2fs2 installed, but it fails with "No
>> package 'ext2fs' found".  What am I missing?
>
> Is the -devel package installed?
>
> Thanks,
> Qu
>
>>
>> Thanks!
>>
>>      -John
>>
>>
>> On 5/25/22 10:06 AM, David Sterba wrote:
>>> Hi,
>>>
>>> btrfs-progs version 5.18 have been released.
>>>
>>> Changelog:
>>> * fixes:
>>>    * dump-tree: don't print traling zeros in checksums
>>>    * recognize paused balance as exclusive operation state, allow to
>>> start
>>>      device add
>>>    * convert: properly initialize target filesystem label
>>>    * mkfs: don't create free space bitmaps for empty filesystem
>>> * restore: make lzo support build-time configurable, print supported
>>>    compression in help text
>>> * update kernel-lib sources
>>> * other:
>>>    * documentation updates, finish conversion to RST, CHANGES and 
>>> INSTALL
>>>      could be included into RST
>>>    * fix build detection of experimental mode
>>>    * new tests
>>>
>>> Tarballs:
>>> https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
>>> Git: 
>>> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
>>>
>>> Shortlog:
>>>
>>> David Sterba (34):
>>>        btrfs-progs: reformat CHANGES for RST
>>>        btrfs-progs: unify CHANGES indentation
>>>        btrfs-progs: make device add and paused balance work together
>>>        btrfs-progs: btrfstune: fix build-time detection of
>>> experimental features
>>>        btrfs-progs: docs: move glossary to overview sections
>>>        btrfs-progs: kernel-lib: add rbtree_types.h from linux
>>>        btrfs-progs: kernel-lib: add simplified READ_ONCE and WRITE_ONCE
>>>        btrfs-progs: kernel-lib: add rb_root_cached helpers
>>>        btrfs-progs: kernel-lib: sync lib/rbtree.c
>>>        btrfs-progs: kernel-lib: sync include/overflow.h
>>>        btrfs-progs: kernel-lib: sync include/list.h
>>>        btrfs-progs: kernel-lib: sync include/rtree.h
>>>        btrfs-progs: INSTALL: update dependencies for docs build
>>>        btrfs-progs: docs: link INSTALL to docs
>>>        btrfs-progs: INSTALL: drop reference to libattr
>>>        btrfs-progs: docs: add note about ifdef EXPERIMENTAL
>>>        btrfs-progs: delete commented exports from libbtrfs.sym
>>>        btrfs-progs: docs: separate bootloaders chapter
>>>        btrfs-progs: docs: document paused balance
>>>        btrfs-progs: docs: separate filesystem limits chapter
>>>        btrfs-progs: docs: move flexibility to Administration
>>>        btrfs-progs: docs: separate chapter for hardware considerations
>>>        btrfs-progs: docs: merge storage model to hardware chapter
>>>        btrfs-progs: docs: copy more contents from wiki
>>>        btrfs-progs: docs: add subpage feature page
>>>        btrfs-progs: docs: convert Experimental.md to RST
>>>        btrfs-progs: docs: convert btrfs-ioctl.asciidoc to RST
>>>        btrfs-progs: docs: convert conventions to RST
>>>        btrfs-progs: docs: fix superscript formatting
>>>        btrfs-progs: docs: update header formatting
>>>        btrfs-progs: restore: list the supported compression
>>>        btrfs-progs: tests: remove ext3 tests
>>>        btrfs-progs: update CHANGES for 5.18
>>>        Btrfs progs v5.18
>>>
>>> Forza (1):
>>>        btrfs-progs: docs: clarification on mixed profile
>>>
>>> Qu Wenruo (9):
>>>        btrfs-progs: remove the unused btrfs_fs_info::seeding member
>>>        btrfs-progs: print-tree: print the checksum of header without
>>> tailing zeros
>>>        btrfs-progs: check: lowmem, fix path leak when dev extents are
>>> invalid
>>>        btrfs-progs: convert: initialize the target fs label
>>>        btrfs-progs: remove unused header check/btrfsck.h
>>>        btrfs-progs: docs: add more explanation on subapge limits
>>>        btrfs-progs: do not use btrfs_commit_transaction() just to
>>> update super blocks
>>>        btrfs-progs: properly initialize block group thresholds
>>>        btrfs-progs: tests: make sure we don't create bitmaps for 
>>> empty fs
>>>
>>> Ross Burton (1):
>>>        btrfs-progs: build: add option to disable LZO support for 
>>> restore
>>>
