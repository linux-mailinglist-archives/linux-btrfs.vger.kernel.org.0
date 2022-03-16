Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375044DB7FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 19:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbiCPSgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 14:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbiCPSgq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 14:36:46 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371CA7648
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 11:35:32 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 6F67C83F42; Wed, 16 Mar 2022 14:35:01 -0400 (EDT)
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net>
 <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net>
 <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
 <5bfd9f15-c696-3962-aaf9-7d0eb4a79694@gmail.com>
User-agent: mu4e 1.7.0; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Date:   Wed, 16 Mar 2022 14:31:34 -0400
In-reply-to: <5bfd9f15-c696-3962-aaf9-7d0eb4a79694@gmail.com>
Message-ID: <87bky5wxt6.fsf@vps.thesusis.net>
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


Andrei Borzenkov <arvidjaar@gmail.com> writes:

> btrfs manages space in variable size extents. If you change 999 bytes in
> 1000 bytes extent, original extent remains allocated because 1 byte is
> still referenced. So actual space consumption is now 1999 bytes.

Huh?  You can't really do that because the page cache manages files in
4k pages.  If you have a 1M extent and you touch one byte in the file,
thus making one 4k page dirty, are you really saying that btrfs will
write that modified 4k page somewhere else and NOT free the 4k block
that is no longer used?  Why the heck not?

