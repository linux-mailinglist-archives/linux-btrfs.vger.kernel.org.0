Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16271FC28
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 10:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjFBIea (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 04:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjFBIe2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 04:34:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150301A1
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jun 2023 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685694858; x=1686299658; i=quwenruo.btrfs@gmx.com;
 bh=Ob55J0aZaUHCWrZu47x/+7zktOLJO/1OFxQEl8xviCk=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=rKzgg0jDWdrJdEevWftcWBqJYkuHDP2mFU4SpYuFNdINWuQffFDeIIqUKUyeLRB+IPdDjPx
 ux983yizgSqg0yJ2NYklbNLYcq3WExSPq3OOqyAJToHCJq6amuL2NI40r0M0pyWez+v0Uclj+
 C86f3SI4nV1YRrDZVoLSAVourzOOfyIzzmSspH7fSAUdo17PWYEV4IvnnWO0UjCinkLPCnxta
 ORS5MXESdDYOWmp7P2q4HVQDx7KqyeRwS6D5+9qBi5zbhv2EiciV7GgyBY1V6efC8l8P+QOoR
 39t9OLdObwmDAXMhiEOoYltOse6xZBhSevyMv7pvvtZcBngOK5ZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSKy8-1pcQlt2yEa-00SbJO; Fri, 02
 Jun 2023 10:34:18 +0200
Message-ID: <2ce845b8-add1-072a-239c-18df81381aca@gmx.com>
Date:   Fri, 2 Jun 2023 16:34:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: 6.1 Replacement warnings and papercuts
Content-Language: en-US
To:     Matt Corallo <blnxfsl@bluematt.me>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <4f31977d-9e32-ae10-64fd-039162874214@bluematt.me>
 <2a832a70-2665-eb9e-5b66-e4a3595567e9@bluematt.me>
 <62b9ea2c-c8a3-375f-ed21-d4a9d537f369@gmx.com>
 <2554e872-91b0-849d-5b24-ccb47498983a@bluematt.me>
 <5d869041-1d1c-3fb8-ea02-a3fb189e7ba1@bluematt.me>
 <342ed726-4713-be1f-63dc-f2106f5becc1@gmx.com>
 <fa6ebdfe-acf0-e21b-5492-9b373668cad0@bluematt.me>
 <82b49e3f-164d-a5b4-0d19-b412f40341b9@bluematt.me>
 <07f98d39-de57-f879-8235-fb8fe20c317a@gmx.com>
 <add4973a-4735-7b84-c227-8d5c5b5358e6@bluematt.me>
 <6330a912-8ef5-cc60-7766-ea73cb0d84af@gmx.com>
 <b21cc601-ecde-a65e-4c4e-2f280522ca53@bluematt.me>
 <e82467d6-2305-da7c-7726-ec0525952c36@bluematt.me>
 <b22bbb5f-9004-6643-09ea-ee11337a93f0@gmx.com>
 <e0107d51-57fa-6581-88c8-77f88f6effd6@bluematt.me>
 <9d6b2ad9-24cb-54aa-2dc9-5039f9eca76f@bluematt.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9d6b2ad9-24cb-54aa-2dc9-5039f9eca76f@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XteDpNP5JGMuKw/L03w0R46IuY7LlPiQzDf/yCl6mtVpaLaDVye
 YzPILCIlrOf//6lf38XV4vL6lxmnmtFAo0PIscD6/h2/A7wcuf8Z6HbdiMhU/5UwOnUQq4o
 LEbYdfZfrxmIG6EC0YnYRMlpgYKqRuyb0LSylhu0hOPO0eHgiNuUVKI6m9A24fG3lqh9Zvj
 yxW+kCJpx085ilUzWa7jg==
UI-OutboundReport: notjunk:1;M01:P0:awePrsl6ujw=;xJUxoDRy4qTXg1indL4nngElEa6
 q4k7XFtGMS/9ej3iEM7r7xB+qPP14ID9f487fte48INWIp9nJyEc+1g7SaGrHXoLu5w1BWRVA
 hIntaIkB30/dN4UO40FzJljQHw7B/9Ne3t8qwG2oKLowMNzQLI0ZY5eSnvKkMh+8iOkmaA3fw
 WxF0JPNsT0WhxCOT3FqItpu9Y/MpADgUxHAOvXAJQD4Osa907qipSCpHO/wfOKCvdsK5pohCN
 KH8070VijILHcG8TlNCN6fw+nrPOjrgmC5RRt6yxXnEbW/caK8aCITAiqkK2UHDPulFs2VzaN
 O7PBe3MYVnkOFB2wSfxFC9pvCsXg6XzD/6aCDcuFfdV91eB4ZnnpfASPTEUOUNOZ4vsw+AkOE
 EAaWP8ppqJRQz0PaBfQf4+L1tgcPXczOmAnPIj2veneOMV4pd98kHeutnjOsKHW0aqK0Df84P
 oMMwZ25HFxTtIlNDBl2HAlDNgiQvB0qfBZWuZGQtwOM+/2E/82vFnmjwiaHlDD/GxqALwFS+e
 rAabijbV7iFoXBZHvFhGiGfzrIXm4N71DlESOonNSzsq4uLdpjTjYBOz8JhpQlrMfIO5/vePx
 s40k28x9Lbwy/kiaLT/LeIjWb8c/JtuEQwhMUMNAdhepEH6Y0sRgJbXgvI9YNvkDeD4Pc4/iY
 clqRIRQPGjqxgNMEk0paymZoOSgDs7CPBByof4ET1t+LkbFFzhgez1HlUNF8mRwEn3wRf9tWL
 e0GG4dte3H4zU0k+8f3Wav5kojYymp+vSHFZx0+JF7RjW30p0sUEnft0Z4OkFXzifrw95/cdY
 g/GPPRBNsLfva9X76DnqcdTZ01pNHkfB5ijzBIozuAFo9spi4YIdFkZmP7GxfUZg4z5KZLesa
 q0meA9vx6gyVx5HQDjR0JIsYwFEt6MYcYtvq72NTPAceOUG/HyCicfDcMEagQKAfImdxaET+W
 qTdlSm/tSlL2SLwzuicd1k21pqI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/30 04:48, Matt Corallo wrote:
>
>
> On 5/29/23 9:37=E2=80=AFAM, Matt Corallo wrote:
>>
>>
>> On 5/29/23 3:15=E2=80=AFAM, Qu Wenruo wrote:
>>> Sorry, I still failed to reproduce the bug, at least with my 64K page
>>> sized aarch64 machines.
>>>
>>> I updated the debugging patch and submitted to upstream, with better
>>> output for all the different bitmaps.
>>>
>>> But never really triggered that assert_eb_page_uptodate() here even
>>> once, and also failed to see any location where metadata can be read
>>> without going through the regular btrfs metadata read path.
>>>
>>> Unless there is some other mechanism which can read the pages and mark
>>> it uptodate, without the involvement of the fs, then I failed to see h=
ow
>>> this bug can happen.
>>>
>>> Sorry for the inconvenience, but mind to do more debugging especially
>>> with ftrace?
>
> I could try,

Unfortunately I really ran out of ideas, everything doesn't make any sense=
.

Unless there is something special in ppc64, I have no way to explain the
whole mess so far.

Just a final struggle before the full (and would be slow) trace_printk()
patch, have you tried memtest the whole system?

This should rule out any obvious hardware memory corruption before we
jump into the rabbit hole...

Thanks,
Qu
>
>>> I can craft a patch which would record every metadata page read from
>>> btrfs, and save them into ftrace buffer.
>>> Then setup the system to crash when that assert_eb_page_uptodate() get
>>> triggered, with all the ftrace buffer dumped at that timing.
>
> Is it not easier to just have some utility that's constantly fetching
> that buffer in userspace and write it out when an issue gets hit?
>
> I could run something but given this doesn't seem to actually be
> corrupting anything it'd be nice if I didn't have to panic when this
> happens...also the machine isn't *that* fast that I could tolerate a
> complete performance implosion, but some regression would be fine.
>
> I don't have a debug serial handy but do have an IPMI to be able to at
> least see output after a panic.
>
>> Sadly I've finally finished the months-long process of converting `cp
>> -a --reflink=3Dalways` rolling backups to `btrfs subvolume snapshot`
>> rolling backups, so I don't have any more huge metadata trees to remove=
.
>
>
> I take that back, this seems to happen on ~any unclean unmount, see the
> "Transaction Aborted cancelling a metadata balance" thread :(.
>
> Matt
