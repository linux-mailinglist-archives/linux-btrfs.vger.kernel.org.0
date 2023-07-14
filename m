Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85DE752F1D
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 03:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjGNB7A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 21:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGNB67 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 21:58:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8381A1993
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 18:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689299883; x=1689904683; i=quwenruo.btrfs@gmx.com;
 bh=x9OW5BDyy3jVQ5k4Bqxploaie5X6847BuQOGzgxovpE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=SYz65Zw+gxg5IGS+CAee2Y9vgiCSYi2xaUDJ5lKkEOagvg9ZrpmGcHheDah9Or7XXv2A1Rx
 IrMLW0xAjObVNcLji4OHfb28yl03GCxvMSKkkd6jD/I7wYNgptJn25gX13w+QNreFE+uEDeva
 n+8RiVQesaXS0nSHWtXPlcrY3CBL3enPv5jhL/HjUM73AT8qCuxG2GGc9/cTPUttk0TiZnIW/
 sAFS9UzFgAKX5R3BwvgKbgu9Tmlq4s7cLHfZn/NdJ/6p/1MAzB7kw9hzWHg35f8j4CZQ0ZokJ
 +iyarENwmlnzPRCLwj7+iygNbraY4NWkww79995NisoBY+EL0xDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq6C-1q4eW249BQ-00tGUD; Fri, 14
 Jul 2023 03:58:03 +0200
Message-ID: <1bab3588-9b53-c212-3b45-91ee61f5b820@gmx.com>
Date:   Fri, 14 Jul 2023 09:58:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1689143654.git.wqu@suse.com>
 <20230713120935.GU30916@twin.jikos.cz> <20230713163908.GW30916@twin.jikos.cz>
 <9251d155-2e2e-a126-579e-2765e98a4a9d@gmx.com>
 <20230713220311.GC20457@suse.cz>
 <6c7b397a-8552-e150-a6fd-95ae73390509@gmx.com>
 <20230714002605.GD20457@suse.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230714002605.GD20457@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fVMiZPdQM4RF54e4CCw8WanKjOKs4+aZfjwwL5brHX2m1MRRoAQ
 0Y5NyAhg6ECfdKvN19DG3vDDkiEBf42d0BQKjbknkUgJ5cvs6W/oJMzsENRC2KiVYaI6p9K
 +AIUEu98K/bQEVOwGleE/B58HRKqkp3AFT6bwknT9g6RmGwk6ljkMtbCgg6RCdeudLv2tNa
 Ny9TcsxGtp+mN4hN5uOoQ==
UI-OutboundReport: notjunk:1;M01:P0:EPUHVTJRlJg=;b7njYTlh3DLDP4vqdEivvQFMsIp
 cJJa4C9fKAtOYYSzPIPn46Si3POpKv1YV6V9WQyvNIdJ3TXbJhwoeVMtAjkAg39JZFoB2XcuJ
 5xEY2gEynOGpe5P33ywe6b/U4KbTUzKDsn9jzsCA5MRZak2+aBkBqEStCfhNLGzTWO7v1bwyZ
 YcI/wwvTayBsrVgNroh1li4YPb5zIh7qha5Gtl2Vs2czrRbMDZ1BoWyPG4AlSyQYEo5JSilzG
 DIFawbwtVroNIL7n6eYYVTSouf9P8DrxWjyMNobuS/TmZ1N34j+OvtxHIhFd/Dr7D1C29ekVW
 /S5Dd1a8LxxKlD6YLUN0Hnk/5Ei8BhzzxEth2wIKuVxvjt7vwVtJPfZ7fHRh6MBFFc4b+ttQQ
 OM+2SxQPdKnh+kkDQ7VMWvqnZhr6t90ym069+hN8KZjRuTiEdC0rqA6ULC6rJhTyPGUYyaKNS
 wupZgRHUpdn0Gmfd86r48TS3bqNV8M5gIHqY9B75eErShpKSCPJrEgTYYt2L7cJywoDLeKpif
 P4RIiSd04eBwOdDAo/5SOXTS6jH7usn+2WYIXR6wsGGUCUJSf42W6Km/QqCkiTxsvv2a2FeHV
 PIV8AL7RkFe6jB5lPsTEtvqEDruMG7dS3sELHBjEdHdHkseICBd43xo/MjF8N8tZdIIjnp6aO
 FOLB6ZU8cDSyK91cXik/wABEVmBw2KnlcsrXz8YvXY9uuzrMDxOpPvjyYzMhkPjWU1Wz7CHQZ
 1a3QGLNJdy7EBkLzBmX3F/LWX7pYlA8i0Ir8FDgDLEQvLTAr2q0YhmcZFJN0iUN3xagltsAIC
 bF1sdvKYiwB4iBqz4CbiDzNW68mi8tF0lp0GVBw/YvAvzGhtCGtCfZK7j0IPJa2MNYcsmbZTS
 ZG5r2icdrIGDMfC2p54t0sZUJ/iof44gk590t2vEMRF2yLARXH5b//6wPE5coBiiaNyDNyni5
 tcdz/GZPuLbMHTLqsgGP5Yz9asU=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/14 08:26, David Sterba wrote:
> On Fri, Jul 14, 2023 at 08:09:16AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/7/14 06:03, David Sterba wrote:
>>> On Fri, Jul 14, 2023 at 05:30:33AM +0800, Qu Wenruo wrote:
>>>> On 2023/7/14 00:39, David Sterba wrote:
>>>>> 		ref#0: tree block backref root 7
>>>>> 	item 14 key (30572544 169 0) itemoff 15815 itemsize 33
>>>>> 		extent refs 1 gen 5 flags 2
>>>>> 		ref#0: tree block backref root 7
>>>>> 	item 15 key (30588928 169 0) itemoff 15782 itemsize 33
>>>>> 		extent refs 1 gen 5 flags 2
>>>>> 		ref#0: tree block backref root 7
>>>>
>>>> This looks like an error in memmove_extent_buffer() which I
>>>> intentionally didn't touch.
>>>>
>>>> Anyway I'll try rebase and more tests.
>>>>
>>>> Can you put your modified commits in an external branch so I can inhe=
rit
>>>> all your modifications?
>>>
>>> First I saw the crashes with the modified patches but the report is fr=
om
>>> what you sent to the mailinglist so I can eliminate error on my side.
>>
>> Still a branch would help a lot, as you won't want to re-do the usual
>> modification (like grammar, comments etc).
>
> Branch ext/qu-eb-page-clanups-updated-broken at github.

Already running the auto group with that branch, and no explosion so far
(btrfs/004 failed to mount with -o atime though).

Any extra setup needed to trigger the failure?

Thanks,
Qu
