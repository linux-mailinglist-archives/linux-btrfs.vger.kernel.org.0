Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C03E536957
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 May 2022 02:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344768AbiE1AUo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 20:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiE1AUn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 20:20:43 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ED95DA02
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 17:20:42 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f35so7325513qtb.11
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 17:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=HSBYnSWaAB3q+Uw5rjPw89F4rFHV+rblkmsWldtxPus=;
        b=ZVQle2F+hNg/ns7nyZbLX9wR5Ti8Xj6dNPTsEiz5CnZgbQTLwFcDmv4Ix98z6TBje8
         Ye7Q7C36z+tmq+DbMhffbg4q9WfYd0B9l2mbo/0rXGJ1Z6rFkFW7ipNRGjpMeZ0ROCTD
         MBiIvHefTNg+RXcTS1MiPGvbUngpg3csptJNZs8lFRi2+wzgZEMzPRmUrhuV9/bDp2lZ
         7rQWPvBWqC6YHNmLTESWqe48Yd9vzgPwBWtvn3QibUbLyW6Q4hytLe8VpRYCHV0NIpBo
         Z4WdGsrqRzON7460vYqOTQ9D69/Fy/zzotmuYYQgBXHGs2bzZSMPUDX+Q5XR+2e49SEc
         aSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HSBYnSWaAB3q+Uw5rjPw89F4rFHV+rblkmsWldtxPus=;
        b=fZ3kpfRdnn8noiXz2QJrctjgrECbmgK5mC1tkfulQcDpaPwzGUERiBc4Q7GE9SmZSR
         TxzQICpucIh7YnlsSlt0i0NafTldz+rbJndCi29UqZNYiwMA2WxuAHXZvYWJptfBvALp
         A4NIcv+B6Z4nf3qwPohA2sgdxxa7FJ9dEG329FXXMfJeVV3C+E2ecrGVqWg+AmuL/Dla
         5tephKT99pMSPSKUGGRIA5djwG4ppckJk94mD1TEy2wQBKYjYoa4w/eaKJRLUCLbbXui
         xO51/I//MN/OmpKsJAZGA/NMTPISBq7NfZ/yWjWX3z9dhkJepQYSv+OF0xD7qDLpXWuG
         8c7Q==
X-Gm-Message-State: AOAM532ct/ikPDRziCoiSEQ4pzrZrKy3na1tj1cfjRxoJDcIR+kQBDOp
        8h3Y5iZD1UWy9sqSwg/ABUAYC2eKa63idw==
X-Google-Smtp-Source: ABdhPJx44z+i9Ft9T1ZeKUyQMHp2v5ZBWVPMIWDIDZw2oZ/m3aFpM8MkFBixD/ONCRwEll344sCClA==
X-Received: by 2002:a05:622a:5cd:b0:2fe:c5e4:701f with SMTP id d13-20020a05622a05cd00b002fec5e4701fmr1405189qtb.683.1653697241138;
        Fri, 27 May 2022 17:20:41 -0700 (PDT)
Received: from ?IPV6:2601:46:c600:af85:8c40:e9db:35ac:5452? ([2601:46:c600:af85:8c40:e9db:35ac:5452])
        by smtp.gmail.com with ESMTPSA id m190-20020a37a3c7000000b0069fca79fa3asm3592798qke.62.2022.05.27.17.20.40
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 17:20:40 -0700 (PDT)
Message-ID: <95422f7b-e0f9-c716-212e-ee1007176d7e@gmail.com>
Date:   Fri, 27 May 2022 20:20:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Btrfs progs release 5.18
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <20220525140644.21979-1-dsterba@suse.com>
From:   John Center <jlcenter15@gmail.com>
In-Reply-To: <20220525140644.21979-1-dsterba@suse.com>
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

Hi,

I usually build the btrfs-progs when it comes out.  I've upgraded from 
Ubuntu 20.04 to 22.04 & I'm having a problem with configure looking for 
ext2fs.  I have e2fsprogs & libext2fs2 installed, but it fails with "No 
package 'ext2fs' found".  What am I missing?

Thanks!

     -John


On 5/25/22 10:06 AM, David Sterba wrote:
> Hi,
>
> btrfs-progs version 5.18 have been released.
>
> Changelog:
> * fixes:
>    * dump-tree: don't print traling zeros in checksums
>    * recognize paused balance as exclusive operation state, allow to start
>      device add
>    * convert: properly initialize target filesystem label
>    * mkfs: don't create free space bitmaps for empty filesystem
> * restore: make lzo support build-time configurable, print supported
>    compression in help text
> * update kernel-lib sources
> * other:
>    * documentation updates, finish conversion to RST, CHANGES and INSTALL
>      could be included into RST
>    * fix build detection of experimental mode
>    * new tests
>
> Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
>
> Shortlog:
>
> David Sterba (34):
>        btrfs-progs: reformat CHANGES for RST
>        btrfs-progs: unify CHANGES indentation
>        btrfs-progs: make device add and paused balance work together
>        btrfs-progs: btrfstune: fix build-time detection of experimental features
>        btrfs-progs: docs: move glossary to overview sections
>        btrfs-progs: kernel-lib: add rbtree_types.h from linux
>        btrfs-progs: kernel-lib: add simplified READ_ONCE and WRITE_ONCE
>        btrfs-progs: kernel-lib: add rb_root_cached helpers
>        btrfs-progs: kernel-lib: sync lib/rbtree.c
>        btrfs-progs: kernel-lib: sync include/overflow.h
>        btrfs-progs: kernel-lib: sync include/list.h
>        btrfs-progs: kernel-lib: sync include/rtree.h
>        btrfs-progs: INSTALL: update dependencies for docs build
>        btrfs-progs: docs: link INSTALL to docs
>        btrfs-progs: INSTALL: drop reference to libattr
>        btrfs-progs: docs: add note about ifdef EXPERIMENTAL
>        btrfs-progs: delete commented exports from libbtrfs.sym
>        btrfs-progs: docs: separate bootloaders chapter
>        btrfs-progs: docs: document paused balance
>        btrfs-progs: docs: separate filesystem limits chapter
>        btrfs-progs: docs: move flexibility to Administration
>        btrfs-progs: docs: separate chapter for hardware considerations
>        btrfs-progs: docs: merge storage model to hardware chapter
>        btrfs-progs: docs: copy more contents from wiki
>        btrfs-progs: docs: add subpage feature page
>        btrfs-progs: docs: convert Experimental.md to RST
>        btrfs-progs: docs: convert btrfs-ioctl.asciidoc to RST
>        btrfs-progs: docs: convert conventions to RST
>        btrfs-progs: docs: fix superscript formatting
>        btrfs-progs: docs: update header formatting
>        btrfs-progs: restore: list the supported compression
>        btrfs-progs: tests: remove ext3 tests
>        btrfs-progs: update CHANGES for 5.18
>        Btrfs progs v5.18
>
> Forza (1):
>        btrfs-progs: docs: clarification on mixed profile
>
> Qu Wenruo (9):
>        btrfs-progs: remove the unused btrfs_fs_info::seeding member
>        btrfs-progs: print-tree: print the checksum of header without tailing zeros
>        btrfs-progs: check: lowmem, fix path leak when dev extents are invalid
>        btrfs-progs: convert: initialize the target fs label
>        btrfs-progs: remove unused header check/btrfsck.h
>        btrfs-progs: docs: add more explanation on subapge limits
>        btrfs-progs: do not use btrfs_commit_transaction() just to update super blocks
>        btrfs-progs: properly initialize block group thresholds
>        btrfs-progs: tests: make sure we don't create bitmaps for empty fs
>
> Ross Burton (1):
>        btrfs-progs: build: add option to disable LZO support for restore
>
