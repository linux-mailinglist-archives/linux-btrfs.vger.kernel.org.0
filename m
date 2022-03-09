Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC994D392E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 19:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbiCISsk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 13:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbiCISsh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 13:48:37 -0500
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA95D219B
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 10:47:37 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 2B1BA80FF8; Wed,  9 Mar 2022 13:47:06 -0500 (EST)
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net>
 <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
User-agent: mu4e 1.7.0; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Date:   Wed, 09 Mar 2022 13:46:12 -0500
In-reply-to: <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
Message-ID: <87tuc7gdzp.fsf@vps.thesusis.net>
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


Jan Ziak <0xe2.0x9a.0x9b@gmail.com> writes:

> I noticed this inaccurate wording in my email as well, but that was
> (unfortunately) after I already sent the email. I was hoping that
> after examining the compsize logs present in the email, readers would
> understand what the term "file size" means in this particular case.

I don't understand.  You stated that the size decreased by 7 GB, and the
size figures that followed appeared to bear that out.



