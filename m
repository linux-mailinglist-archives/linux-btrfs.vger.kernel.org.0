Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C57B610448
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 23:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbiJ0VVW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 17:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiJ0VVS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 17:21:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A9B58E80
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 14:21:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k2so8356294ejr.2
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=92na2+XISkVNVxBCyyFgt05SUut3WLPn4BZgXhX8OY8=;
        b=fol8mcyuJzR1ZLcKuO9Vkmugzt/EWEafC6cwSOdEHYRfcoOsUlMP9bcHGuQ3xyHjiu
         O5y2+yS/Tt+KndlrhKRwd7OOSSV5WZlhFGfdYEXRKbfDHf+n9Oz+HQ+bsk3bZHCe+o00
         QzBYX/blFrWMSv27uqU42VMlxL7sMAHP5Et5jCDMWjTSp3vuT2cRUKzfZDjGiqkNSGnM
         kE1j/wYmJsaP71AkQdD6zN+VwMJ1NQ8YOE8KWcnAk0d7kfNM8QUQftI8dic6NEn18kZV
         Q9OtEU+ZOfKb4i78vPJawt3itqvD21YWDW34wxjtY5/7hwwG0C++3TuLl9E0tu3LlD8Z
         giag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=92na2+XISkVNVxBCyyFgt05SUut3WLPn4BZgXhX8OY8=;
        b=156uBMrPfIwYOFMNT35cI/gZsy4fiysJM+FD8z3+qNX/3cI7Vky/Oe7KWnSfl6k/N7
         lr+2blKvfYniwV5xnLOfmL2/xuS5zuvdG5eIlUATE41802BgxeYRYRENJcX8f158lbHr
         3poZEwEmjCdAThIs72+xzWyxCzYkNQ2N3v1ujzRmtvW3/+AY3Xb6xH7JyxXgl923On+C
         iEN8/29KmSon4JbgBq13WzQfNVmmFvP//HXDJ8AvEwjTilF0yyIFkzHwfEVwQl+Lg2xg
         BIREyEiE9Gcq90/KHyM92W5byTIgKDIyy+mNewi9VKH6xhSK6FXgPiUWEicxb1//oai/
         vwSA==
X-Gm-Message-State: ACrzQf0mXz4nGdXwcfNoYoWxJr2lEZT3u92ZxCrC8JLi71qLcyw0Fr+W
        IszKrpiu7g5Xf4IbOnTAL143Kwo+l70Y8tv3nwU1SedTkZAdRg==
X-Google-Smtp-Source: AMsMyM7Pr+wAy0ANJn0GgNfigKDOeYT8au/S6xeNlmFyNsNd07vxAf6Ys7BvRPWmLfiIBz/nnCvhl7A+6AkcuHOVWEc=
X-Received: by 2002:a17:907:d90:b0:78d:48b1:496d with SMTP id
 go16-20020a1709070d9000b0078d48b1496dmr45701332ejc.665.1666905675288; Thu, 27
 Oct 2022 14:21:15 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= 
        <socketpair@gmail.com>
Date:   Fri, 28 Oct 2022 00:21:04 +0300
Message-ID: <CAEmTpZGRKbzc16fWPvxbr6AfFsQoLmz-Lcg-7OgJOZDboJ+SGQ@mail.gmail.com>
Subject: Major bug in BTRFS (syncs are ignored with libaio or io_uring)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

How to reproduce (I tested in kernel 6.1):

2.  mkfs.btrfs over a partition.
3.  mount -o lazytime,noatime
4.  touch file.dat
5.  chattr +C file.dat # turns off compression, checksumming and COW
6.  fallocate -l1G file.dat
7.  # prefill the file with random data
    fio -ioengine=psync                      -name=test -bs=1M
-rw=write                 -filename=file.dat
8.  fio -ioengine=psync    -sync=1 -direct=1 -name=test -bs=4k
-rw=randwrite -runtime=60 -filename=file.dat  # Will show, say, 2K
IOPs
9.  fio -ioengine=io_uring -sync=1 -direct=1 -name=test -bs=4k
-rw=randwrite -runtime=60 -filename=file.dat  # Will show, say, 32K
IOPs
10. fio -ioengine=libaio   -sync=1 -direct=1 -name=test -bs=4k
-rw=randwrite -runtime=60 -filename=file.dat  # Will show, say, 32K
IOPs

Steps 9 and 10 show implausible IOPs.

This does not happen on, say, Ext4 (all the methods give roughly the same IOPs).

Removing -sync=1 on all engines on Ext4 gives immediate return (as
expected because everything gets merged and finally written very fast)

Adding/Removing -sync=1 with io_uring or libaio changes nothing on
BTRFS (it's definitely a bug)


I consider it's a bug in BTRFS. Very important bug because BTRFS
becomes default FS in Fedora server/desktop now. This bug may cause
data loss. That's why I set this bug as high priority.


*****************
https://bugzilla.redhat.com/show_bug.cgi?id=2117971
*****************


-- 
Segmentation fault
