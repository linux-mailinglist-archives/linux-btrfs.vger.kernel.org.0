Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38D636CB7
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiKWWCO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiKWWB6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:01:58 -0500
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4131CFB99
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:01:54 -0800 (PST)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id A90FB400C8;
        Wed, 23 Nov 2022 22:01:50 +0000 (UTC)
Date:   Thu, 24 Nov 2022 03:01:50 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Joakim <ahoj79@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Speed up mount time?
Message-ID: <20221124030150.0b064549@nvm>
In-Reply-To: <CAFka4xNPJby02JcK+immNU+AL6w-=iH7tNB4ZjULoYxnwG7U+Q@mail.gmail.com>
References: <CAFka4xNPJby02JcK+immNU+AL6w-=iH7tNB4ZjULoYxnwG7U+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 23 Nov 2022 13:33:17 +0100
Joakim <ahoj79@gmail.com> wrote:

> Initially mount times were quite long, about 10 minutes. But after i
> did run a defrag with -c option on machine B the mount time increased
> to over 30 minutes. This volume has a little over 100 TB stored.
> 
> How come the mount time increased by this?

With compression each file now has to be split into extents each at most 128K
long, which means there are much more extents to keep track of than before.

> And is there any way to decrease the mount times? 10 minutes is long
> but acceptable, while 30 minutes is way too long.
> 
> Advice would be highly appreciated. :)

It is unfortunate that you use the bare sdb device, if you used LVM, you could
easily add an SSD and deploy LVM caching in writethrough mode (or a RAID1 of
SSDs and use the writeback mode). In my experience LVM caching of HDD based
storage to SSDs improves mount times of Btrfs really by a lot.

There have been a number of attempts to implement Btrfs native storage tiering
of HDDs vs SSDs (storing metadata on the latter), such as [1], but none have
made it so far, and the patches from 2020 probably no longer apply.

[1]https://lwn.net/ml/linux-btrfs/20201029053556.10619-1-wangyugui@e16-tech.com/

-- 
With respect,
Roman
