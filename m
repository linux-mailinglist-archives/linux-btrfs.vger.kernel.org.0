Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AB24DB858
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 20:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241626AbiCPTFt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 15:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239926AbiCPTFs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 15:05:48 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B87539164
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 12:04:31 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 73A0C2607F4; Wed, 16 Mar 2022 15:04:28 -0400 (EDT)
Date:   Wed, 16 Mar 2022 15:04:26 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Phillip Susi <phill@thesusis.net>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <YjI0uk4tQcnBPYMP@hungrycats.org>
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net>
 <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net>
 <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
 <5bfd9f15-c696-3962-aaf9-7d0eb4a79694@gmail.com>
 <87bky5wxt6.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bky5wxt6.fsf@vps.thesusis.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 16, 2022 at 02:31:34PM -0400, Phillip Susi wrote:
> 
> Andrei Borzenkov <arvidjaar@gmail.com> writes:
> 
> > btrfs manages space in variable size extents. If you change 999 bytes in
> > 1000 bytes extent, original extent remains allocated because 1 byte is
> > still referenced. So actual space consumption is now 1999 bytes.
> 
> Huh?  You can't really do that because the page cache manages files in
> 4k pages.

You can get a 1-byte file reference if you make a reflink of the last
block of a 4097-byte file, or punch a hole in the first 4096 bytes of a
4097-byte file.  This creates a file containing only a reference to the
last byte of the original extent.

In theory you could create a 4098-byte file, then make reflinks from that
file to two other files covering the last 1 and last 2 bytes; however,
that's disallowed in the kernel to make sure that assorted dedupe data
leak shenanigans with shared reflinks that don't all end at the same
byte in the page can't ever happen.
