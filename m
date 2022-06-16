Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444D554D604
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 02:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347096AbiFPAWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 20:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244376AbiFPAWV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 20:22:21 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7266E40E56
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 17:22:20 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id B81808066C;
        Wed, 15 Jun 2022 20:22:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1655338940; bh=V5CcHRpjdF93vAs6zDWRPVC0eKwLYtnLzc0LSl5bKSQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DHXduNol5tNdcMN1+bzbDcCVFkWkiZ1La+Yioa4ZGTpPU8P664uiHvqM/TAfCDeya
         QD9Fa0y6l2LAntYi3fhjJMmJxEmZVkIdZzwKlUDENJn8awyo54Sq1DXDuvHhRCExJw
         MSdIT6XAqDCU54jDVt+SBSTkmOmNXeq0+4Oe+/nLCtPca8j0DSLx0tdKBuiPWp6mP6
         RPJGdiDkJ2cv7gR8pfYjKt6nlI2hGu9zOuHPpSq7sBvtMeigfqmZASlZzxH5Hvko4+
         vcLs7fPWOhuN6av7y0KXuN7WAC3r4PLLEjqzKGx0qXLI/v+AyW3ceXBqI14Eputi2s
         DV2hZHM5JEotw==
Message-ID: <969bbc68-7dfa-dedf-55c3-da882c5bf0e3@dorminy.me>
Date:   Wed, 15 Jun 2022 20:22:18 -0400
MIME-Version: 1.0
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
Content-Language: en-US
To:     Eldon <btrfs@eldondev.com>, Marc MERLIN <marc@merlins.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20220610191156.GB1664812@merlins.org>
 <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org>
 <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
 <20220615142929.GP22722@merlins.org> <20220615145547.GQ22722@merlins.org>
 <CAEzrpqdRn9mO0pDOogf37qWH07GryACqidHDbZcpoe7t73GDeQ@mail.gmail.com>
 <20220615215314.GW1664812@merlins.org>
 <CAEzrpqfZMA=NjqAaS1XKZgguD5L73kc7zKFL+cVHnMGxdK6rXw@mail.gmail.com>
 <20220615232141.GX1664812@merlins.org> <YqpqVSvxP8Dcz53V@invalid>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <YqpqVSvxP8Dcz53V@invalid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I too found the back-and-forth very educational and suspenseful; many 
thanks for keeping it on the mailing list.

On 6/15/22 19:26, Eldon wrote:
> On Wed, Jun 15, 2022 at 04:21:41PM -0700, Marc MERLIN wrote:
>> Sorry to everyone else following along, hopefully it was somewhat
>> entertaining :)
> 
> You have no idea. Most entertaining thing this year. Popcorn, suspense,
> joy, tragedy, redemption.
> 
> You really need to put out a tip jar or something.  ;D
> 
> Eldon
