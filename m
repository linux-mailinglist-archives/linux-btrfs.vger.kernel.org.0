Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39D0545848
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 01:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbiFIXPs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 19:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239446AbiFIXPp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 19:15:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128C715436A
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654816522;
        bh=5osOT7nMPI2dwlSLbsU8+jGWx9/O/w1eMBEAg2fBgN8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=jg+UOrk3Pl1Ra08PZ416Fjnkz+KKhFn5X+Vu3Y5ytzs0S95hIzNFJatIz2h5MamRQ
         5B8iN3GV1dturtg99PL5Jms6rXLD5atrKY42vWl8Hyk/QqzDDHJUbyzh6ldjEObtsV
         CXo4cNZMhk4Z1QVgZbLSLGhX0YxuwHn6dt1YVEQ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8ygO-1o4Mn939CY-00687I; Fri, 10
 Jun 2022 01:15:22 +0200
Message-ID: <fa8e446c-1a17-4239-efcd-f4f2004f0e34@gmx.com>
Date:   Fri, 10 Jun 2022 07:15:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Content-Language: en-US
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, willy@infradead.org, nborisov@suse.com
References: <20220609164629.30316-1-dsterba@suse.com>
 <17d8d373-f836-5d23-2939-d9dfcb65ae7e@gmx.com>
 <20220609225906.GX20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220609225906.GX20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:czKh0RGNEu2HoRsJsKpmRxUb7cqsBbn1SqI9MFLQgeZ0pFzqZa3
 PWBZarqAkvhH/W0zFO7UZE8lt2pFwqjbTno+KRg/snhuYHGuFEStD1g4sfHxNdQP9slbS4V
 wOG9WsvYeM9YhJjQbfCPVzryisczoi8wLw5L/VdzkZpFqqmImYBYheR0Nf+AQGFZ9bymA1F
 ZzPsf4a0zclD6KnUYbsHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yawfyB8SSCM=:uOh773n2K3sNaToKWuIYsH
 yqv64mt1ppGUpZ+jH8jeAc9FxND9PnTfCSoSeiQgzSFidFMuWpY94aCGp8Ne3KfDpgfauXbPL
 piDUTjnsEXRbzs+n1QP/iE5it2V7vQ+RQo/oMUwScfJrItK3Zs2X/FuRF+QRr0Il+Fb4n2Rku
 AYXLfcuPDnZt8zcWYTCQJJH/rUWisEwXLoYx6u6xMZD4KpsmPMRqcAjRVmTnR41u7tIap98QD
 tSxKyPFR0Fkb1h+au/5B1W05tJ4zyvkVxp6vmP94QV8aTHmmnYZGFvluXAFdURI/mHUyvgARg
 oyCnQg8206YvgJxd1DL+R6adz7ALT4ydsZDdzxW2EF7fLBsa636q+Zg3bCzE7QuT8Ht2IHAbw
 Qkdlwvo1jAKJnV+5g1rNgPVt3gTa+KIwyFYnLfZqOgSVnhCc+HuRce2smZNS4Oje+QbhfpsMV
 z3VODDe2I+eA6zRhDsD8TfW6Ala2Ani+91KIkF8KFdUvpMlC6BCYG+zuSD+1B4A0cgJL7S51G
 QLVgrHBvhV3/YU4SBGD+E9Ixl7zIDeaFGg7oquUG5Hi703ot+WxxsFTz1SwbmdWtLBPSYT5qf
 KM/vx0qHPvjY+vxIaBOHtcRdC0WlajrG6ZlwTtePHvk90IDM7wmKCawPCWyJBN9+5tHEj5+A9
 dCHp8PkAqPwmuCj1eYUBoHR6cYXvSErr0omOEuPkBQy7Ctow/2VmwYA0jSG4d1NQVDJxLF4dp
 wvSUHqpYnqVTWnGmuVXM36hlYjUVJn4uOeYHie7nAAcUxWZjjQ7XDrCfuW1zcGturMlRJRtJK
 yBSsWewrU0T3O/xgzPER7y7/c+0lSmvp2SnFF/SNg49jjbzs1E5eq8HmKmibwXkBo7QLsnVXE
 OGzXmDVPxMRqHAiHE6bNWsCgwvCoSsQBtIhF1/lcfk7sQkbA1bhtWllZOE7xRvO7QfxDqCoWW
 w/EtaBBVYMtCMXN5L8xqgS8MCnl/mR7fhDfh8lrDdu7KVrJNr3gkTMIcFoXcjX+d+n70j5snX
 xH4AaPdqmlHTStCd7SfD58NWtTLKXvciiMIFTbWXB6AWugk0vnI3yxKMJtgHragvoI7Z1KZJc
 ygY5nvFEP+v2A0CxoqsEGono/tsAStLo95Zyr1lq/bFhpBM2A0tZ4ILaw==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/10 06:59, David Sterba wrote:
> On Fri, Jun 10, 2022 at 06:58:00AM +0800, Qu Wenruo wrote:
>>> v2:
>>>
>>> - allocate 3 pages per device to keep parallelism, otherwise the
>>>     submission would be serialized on the page lock
>>
>> Wouldn't this cause extra memory overhead for non-4K page size systems?
>>
>> Would simpler kmalloc() fulfill the requirement for both 4K and non-4K
>> page size systems?
>
> Yeah on pages larger than 4K it's a bit wasteful. kmalloc should be
> possible, for bios we need the page pointer but we should be able to get
> it from the kmalloc address. I'd rather do that in a separate change
> though.

That would work for me.

Just want to bring a little more love to those larger page sized systems.

Thanks,
Qu
