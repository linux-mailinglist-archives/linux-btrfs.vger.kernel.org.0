Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED84DD07E
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 23:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiCQWHY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 18:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCQWHX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 18:07:23 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DD211B0BF6
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 15:06:05 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id D783A264B19; Thu, 17 Mar 2022 18:06:04 -0400 (EDT)
Date:   Thu, 17 Mar 2022 18:06:04 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Phillip Susi <phill@thesusis.net>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <YjOwzJ2lddBiz8+u@hungrycats.org>
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net>
 <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net>
 <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
 <5bfd9f15-c696-3962-aaf9-7d0eb4a79694@gmail.com>
 <87bky5wxt6.fsf@vps.thesusis.net>
 <YjI0uk4tQcnBPYMP@hungrycats.org>
 <87wngspb9x.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wngspb9x.fsf@vps.thesusis.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 17, 2022 at 04:34:51PM -0400, Phillip Susi wrote:
> Zygo Blaxell <ce3g8jdj@umail.furryterror.org> writes:
> > You can get a 1-byte file reference if you make a reflink of the last
> > block of a 4097-byte file, or punch a hole in the first 4096 bytes of a
> > 4097-byte file.  This creates a file containing only a reference to the
> > last byte of the original extent.
> 
> So the inode only refers to one byte of the extent, but the extent is
> still always a multiple of 4k right?

Yes.

In theory, the on-disk format specifies extent locations and sizes in
bytes.  In practice, the kernel enforces that all the extent physical
boundaries be a multiple of the CPU page size (or multiples of _some_
CPU's page size, with the subpage patches).  On read, anything with a
logical length that isn't a multiple of 4K is zero-filled.
