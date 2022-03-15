Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354B24DA271
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 19:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350956AbiCOSgK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 14:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242083AbiCOSgJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 14:36:09 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5FF483B2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 11:34:57 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id A0CBD83A5F; Tue, 15 Mar 2022 14:34:56 -0400 (EDT)
References: <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
 <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
 <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com>
 <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
 <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
 <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
 <87a6dscn20.fsf@vps.thesusis.net> <Yi/I54pemZzSrNGg@hungrycats.org>
User-agent: mu4e 1.7.0; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Date:   Tue, 15 Mar 2022 14:28:46 -0400
In-reply-to: <Yi/I54pemZzSrNGg@hungrycats.org>
Message-ID: <87fsnjnjxr.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Zygo Blaxell <ce3g8jdj@umail.furryterror.org> writes:

> btrfs extents are immutable, so the filesystem can't extend an existing
> extent with new data.  Instead, a new extent must be created that contains
> both the old and new data to replace the old extent.  At least one new

Wait, what?  How is an extent immutable?  Why isn't a new tree written
out with a larger extent and once the transaction commits, bam... you've
enlarged your extent?  Just like modifying any other data.

And do you mean to say that before the new data can be written, the old
data must first be read in and moved to the new extent?  That seems
horridly inefficient.

