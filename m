Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB5C740659
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 00:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjF0WBP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 18:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0WBN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 18:01:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C8C10EC
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687903260; x=1688508060; i=quwenruo.btrfs@gmx.com;
 bh=6TbbGcpb5ho5E7oDwpXZhH1IdqGaTxAn3QSKlYRB+XY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=qIpway3ryRt6gr+IVRarprInw67WnMXxCw0RGwyMqAWd6/d/sq28zaFzd1n1U+tN1HUvdxb
 Xwt8sYhoVytviHPjzc5XEgySyAQsQtMpsgmvHF6n1t7Qqfs3eG4wQ7yOJnpbYmkyOdWPmZR8U
 dW1MHsvGijqOeeumz6v4veR1dZqmsDTl877pkxZmw68aq4772a15xQVAKRIckZbbaY0yCAKyG
 xwREq3AY3Yh2p+1ls/Zpw6sz/qV1ltNIAxwu/QJzN4owmmY2NCjYx2JE4Mj963cegTiwcDB/U
 +SxJVtx+6xROKzZObrEqsyargkN1YodQmzqhOnMjuocOaNeoF/GQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJVDW-1qTahX3oyG-00JqI7; Wed, 28
 Jun 2023 00:01:00 +0200
Message-ID: <286ad810-f239-5fd8-92e3-fbf5f7c387a2@gmx.com>
Date:   Wed, 28 Jun 2023 06:00:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: add comments for btrfs_map_block()
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <4564c119bf29d7646033a292c208ffcab6589414.1687851190.git.wqu@suse.com>
 <ZJsJRMQx3oNSaEOk@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZJsJRMQx3oNSaEOk@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0BCpjfH1uK2WTyd2Jm+GnifniKUUsNqHB68S/lUIb6hCgSG5Z4i
 ELmfznJlNUTBQkKPwlNl7/e2O6jvFrkYQrItRTr1OInxD7oLpVBoPVQLLfDtYjH1Vrtbm7V
 XfIslHAQXGPr8igti5JzO79okISnzKyQH+5Ep6J6ZnQhG/MiVDkWL6CzMB13dthrGKeWLiT
 UpfFYgVNcLs69M2uZmcAg==
UI-OutboundReport: notjunk:1;M01:P0:MxIcC5quQSA=;CQqOWeUusHVZKuYtQvGQpzqwMiO
 COavNAaSsiDs0i+UuNXFJek4U3LmqfkdfbPEn3lnSxY02dldRbx+uIxpoDlenVTp74UGyaFch
 5cfAvG0T/yG47bYggv5JoYNjNzY6mRtnT8bLQXE3avnSJIxpWWgiGbYbNcMcm+7TVF+QLCJJ2
 /y0c39/ez0R2wPeoCoiqdanOIGcWwQQ/DpoM6fSRg2Odbr1qAZAEUJsPxxe85X23nvsuLSJjd
 +WwDlcbwUGEKLBSG3C+h9VfaseC09K+QDTRTDegYmRoK6+ORjdH0q9Lu3NhoC4eFHpglAbqJW
 lYKV94wGxSbNzrF8SSRzehQhiKFwNN0+5RBSTrsqQ6dp5egHmepL/9HZY+zcurxbn8ReeSFvU
 uljsE1TAEBv5RIpEBy2/97sIS1ZkftZKs86KEnN6CIUvU9xNI8dm4g7raHwMZoYRXxzTf0dCE
 rT6kWXfs8E7Ui/7rvFA3KcCDzhFnivWF2j0mEuxZjYV9Q2ikBuRiYw4kBdR8upOEvYJ6a/GL5
 idnZXrCwU8f8lw+RfNmlct5O+MURWmxsTqiLRzToea2Ao+2PDxzvLS31oi8Fk9WhGmwemHfgI
 Ef5alR5Uci9j+yTo5nGcwWsvAcNQWGbJyU74Edztvu6+zeoJNqY2lGfbfMoOILWcbPsC+DJ4Z
 efyOMEf9Y4vXsaOurb1AD26YtzumWa2CGYzDKuWivxlvcrzum43XDE5f6+U8jR4IILxxNJc+o
 yfd0aiWBdWfTK991f9n3pnes0XZSYeFZDvXM+CIqHlybUq+UBFoEF+LhQdfCq2pUbVYQ3NfqP
 Fu9hjogLnUEBtJVDwmoNdSkKn74p7UF3F8N3pJsL+Js1xyPzsoi/vZc5mJBZFGMVOgvtZQFDS
 4KpK+0d+yr177gy6DIG6C4Ie4fHLedOW1MR3T3rZphmLjxqpupk+Q35CqdmR0jrdms7NtYwKa
 2XwqVSP0Gqrkwl7q82L5CcIb9qs=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/28 00:07, Christoph Hellwig wrote:
> On Tue, Jun 27, 2023 at 03:34:31PM +0800, Qu Wenruo wrote:
>> + * @mirror_num_ret:	(Mandatory) returned mirror number if the original
>> + *			value is 0.
>
> This one is optional.
>
>> + *
>> + * @need_raid_map:	(Deprecated) whether the map wants a full stripe ma=
p
>> + *			(including all data and P/Q stripes) for RAID56.
>> + *			Should always be 1 except for legacy call sites.
>> + */
>
> Saying deprecated for a paramter to function with just a few callers
> feels weird.  For this patch I'd just stick to a functional description.
>
> As far as I can tell need_raid_map just creates extra overhead when
> used on a paritty RAID BG, but is othr wise harmless and only
> btrfsic_map_block clears it to 0.

Yep, and in fact whether we need to allocate the full stripe mapping
should not be determined by this parameter.
@op and @mirror_num is really determining if we need the full stripe
mapping.

And even if we want a way to return P/Q stripe directly (later
scrub_logical would need it), we can go single stripe fast path for such
case.

Really it's btrfsic_map_block() the only exception.

>  Maybe add a follow on patch to just
> remove the paramter and waste the little bit of extra effort to build
> the raid map for btrfsic_map_block?
>

Well, I'd prefer to remove btrfsic_map_block() and the check_int thing
completely.

Thanks,
Qu
