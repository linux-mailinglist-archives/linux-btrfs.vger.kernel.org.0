Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF2A4DCF6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 21:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiCQUhR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 16:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiCQUhQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 16:37:16 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7DE4B873
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 13:35:55 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 9AD8B842E3; Thu, 17 Mar 2022 16:35:54 -0400 (EDT)
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net>
 <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net>
 <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
 <5bfd9f15-c696-3962-aaf9-7d0eb4a79694@gmail.com>
 <87bky5wxt6.fsf@vps.thesusis.net> <YjI0uk4tQcnBPYMP@hungrycats.org>
User-agent: mu4e 1.7.0; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Date:   Thu, 17 Mar 2022 16:34:51 -0400
In-reply-to: <YjI0uk4tQcnBPYMP@hungrycats.org>
Message-ID: <87wngspb9x.fsf@vps.thesusis.net>
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

> You can get a 1-byte file reference if you make a reflink of the last
> block of a 4097-byte file, or punch a hole in the first 4096 bytes of a
> 4097-byte file.  This creates a file containing only a reference to the
> last byte of the original extent.

So the inode only refers to one byte of the extent, but the extent is
still always a multiple of 4k right?


