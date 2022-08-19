Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF85259A597
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 20:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350520AbiHSSif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 14:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349937AbiHSSi2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 14:38:28 -0400
X-Greylist: delayed 537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Aug 2022 11:38:27 PDT
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D034AD42
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 11:38:26 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id B0264DE40B; Fri, 19 Aug 2022 14:28:58 -0400 (EDT)
References: <a3fc9d94-4539-429a-b10f-105aa1fd3cf3@www.fastmail.com>
User-agent: mu4e 1.7.12; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     George Shammas <btrfs@shamm.as>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: What exactly is BTRFS Raid 10?
Date:   Fri, 19 Aug 2022 14:10:24 -0400
In-reply-to: <a3fc9d94-4539-429a-b10f-105aa1fd3cf3@www.fastmail.com>
Message-ID: <87v8qokryt.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


"George Shammas" <btrfs@shamm.as> writes:

> Hello,
>
>  I've been searching and reading docs for a few days now, and btrfs raid 10 is a mystery to me. 
>
> This is mostly a documentation question, as many places reference it
> but nothing actually describes it and the real question is how does it
> differ from btrfs raid1.
>
> Both BTRFS Raid1 and Raid10 
>  - Allows arbitrary number of drives (>=2), including odd numbers. 
>  - Will write duplicate blocks across disks.

Btrfs raid10 requires an even number of drives with a minimum of 4.
It's pretty much raid 1+0.


> https://btrfs.readthedocs.io/en/latest/mkfs.btrfs.html?highlight=raid10#profile-layout
>
> The Raid 1 example there also likely needs a bit of explanation or
> validation, as all the blocks are written to one device. In that raid
> one example three devices could be lost as long as it is not one of
> them is the first device. It also cannot be accurate once the amount
> stored is above 1 full drive.

It is meant to show a *possible* layout, not every potential layout.
The data may be stored like than and then yes, you could lose multiple
drives and still recover as long as the lost drives were 2, 3, and 4.

