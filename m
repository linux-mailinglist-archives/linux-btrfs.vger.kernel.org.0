Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570505476FA
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jun 2022 19:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiFKRy0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jun 2022 13:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiFKRyX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jun 2022 13:54:23 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB72724
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jun 2022 10:54:21 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id E5160688;
        Sat, 11 Jun 2022 17:54:17 +0000 (UTC)
Date:   Sat, 11 Jun 2022 22:54:16 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Andrea Gelmini <andrea.gelmini@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <20220611225416.25c8a8d6@nvm>
In-Reply-To: <20220611145259.GF1664812@merlins.org>
References: <CAK-xaQYc1PufsvksqP77HMe4ZVTkWuRDn2C3P-iMTQzrbQPLGQ@mail.gmail.com>
        <20220611145259.GF1664812@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 11 Jun 2022 07:52:59 -0700
Marc MERLIN <marc@merlins.org> wrote:

> 1) mdadm --create /dev/md7 --level=5 --consistency-policy=ppl
> --raid-devices=5 /dev/sd[abdef]1 --chunk=256 --bitmap=internal

One more thing I wanted to mention, did you have PPL on your previous array?
Or it was not implemented yet back then? I know it is supposed to protect
against the write hole, which could have caused your previous FS corruption.

> > > 5) mkfs.btrfs -m dup -L dshelf1 /dev/mapper/dshelf1
> > 
> > Personally I have switched from Btrfs on MD to individual disks and MergerFS.
>  
> That gives you no redundancy if a drive disk, correct?

Yes, but in MergerFS each file is stored entirely within a single disk,
there's no striping. So only files which happened to be on the failed disk are
lost and need to be restored from backups. For this it helps to keep track of
what was where, with something like "find /mnt/ > `date`.lst" in crontab.

-- 
With respect,
Roman
