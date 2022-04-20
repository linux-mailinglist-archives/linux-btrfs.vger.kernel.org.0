Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4322507EC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 04:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358910AbiDTCXA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 22:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241043AbiDTCW5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 22:22:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B482716C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 19:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650421202;
        bh=ugRbclLBbjosX4R4SmB/GkQlBXKTdbOXRw1LlK7ztvo=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=cOt0ROthaJnFv5ZbDIdS7E4fZNbnAYybQysdinOTtj4NPMlACW+SByzj/Dlt7SK2s
         iUbqCma9IXXry19VAVvvTnWhO3LIZ+ihdsE7IdKi+YYccTx0A6dRCyjjLkkYj3PmjY
         7MANpfecHVxdER0IFkm290NQZsqfIhNAtFdvcj6A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmUHj-1oOp1c10Az-00iSV5; Wed, 20
 Apr 2022 04:20:02 +0200
Message-ID: <e68334b4-12ea-8308-0e4e-4edc3b23df25@gmx.com>
Date:   Wed, 20 Apr 2022 10:19:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: RAID-[56] stabilisation
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <22677769.8507095.1650409322744.JavaMail.zimbra@karlsbakk.net>
 <a59b507b-f528-472b-29c9-da2e62deaad9@gmx.com>
In-Reply-To: <a59b507b-f528-472b-29c9-da2e62deaad9@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rwyfgSu7Kbtfk9Tg9GAwAWEL1Q9tCYpAdq3l8KlDuEWpIZhuquq
 lRXjOKfSEhm3AXAlNtZxalYvLx09PrpcaxW8mSQLY112sJGtsUoJ2m3kpN2AEc3bj3eu5xJ
 6LXXrWi0wUN9+spkcLM1O0KdhYVdkfT8YWW8DRRPb4cupkDSEtyZfhHhL/NS+PczTPl0U/6
 rdSLvMzFykoe2p0d2rHuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cWLOcuA/gkQ=:w3Pmh4IhM4xnFjaQQESpXE
 uADY81R6kk3jrfvAPUQUeKiSJdDRKR0bZm/WcR1EnCFkjd0ovZ0c8ywxZCZNuc022PEUWdNgg
 /3cTn/VqVKsuAZqEWkirFSerOr0UMrLGb7sRhrMMb9bqxCQUCxR6wZHLLfrEfsyY3LHPyB8kf
 VB2YvmfJLemYUPjWEUUA9xq/OAXheAhQA7OGkAViEqTvR3quBsYGugZ57BRvPB8GocPMlh1OD
 zvmjDiuBplunYGA6GJYrnEhRQt4mG3JEudbAtBJJekuIjS7Frw7UhnemEaIWRAsRtRAMQPhvu
 HtYE2FdJxyxfZzCFKexDMtyUUACETZpBM2YNzinB4788xfHkh3g90Cit3x7PjQMAk619OXhrf
 VNs/0EI26Y0VkFcw3VaJurL9qM6R+W10Ne/VztNL6etTD2gETbCdpv71KC4b17LIVzPbYLcap
 xXdJm3d2JhPBU7Aw9L4TyJA1t5U7sZ+FD09cyR4L/lrBKCFZlqUvHJ1fMyPBPu4D45fPd3ppw
 sayf21MGI1v4fqs7F+EquE2lOk4kpWCHNAs5sVrWrkEAimXi459xIKpK7vgzC2Xc8Qr3zarzk
 qpeMgd0iSDK52DfA6cGCmFiwFYtpw7mn7wwQEjLasA0XFTJ7GdfKxGTUKaqCIJsCX5Vk3hGh+
 BsaOplhJ4n1gWKOh6mBI7NMJbmJZWrEN7XaeLP2ZjUuVKA/RFncWJ6QEuQCFfAUAfiT0nVcay
 COBb0I8YlL+38U1CUTDu8yqcSZNwT2K7OlRyuzSWkDPbnN0/8lNchmTbVglXiN/U3FMj5uD1L
 HhnkStmuHsDYwm0MIVGCUasPBuHiOD3Q+Ruz8B/FuCL/h5K0DxMePgWNmPEK2Ub6RWglmhOZ5
 ZHQa8WK0LToB7oA/d2S9cyRrPW2ngZ4wHy8SmRp56xSfs6XZXZSbPd+dy2KFQaqc/5NTuq/gx
 6+8vp48y0CqJTh0rVlKNf7fPowqSkNzOaH8TkW7VwR0anC6jjZO2ey51XzWCEz6tqmusYjN+h
 gF7gSdjR24BG4FP7cWAYn5zfjp9yF5j24itevpdk0cI7lTOkY3L7AuL5gFxGOHJm61NcNYjye
 59JiDw4GLZA2zU=
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/20 10:17, Qu Wenruo wrote:
>
>
> On 2022/4/20 07:02, Roy Sigurd Karlsbakk wrote:
>> Hi all
>>
>> It's been a wee bit more than a decade since I started to look into
>> btrfs as a possible ZFS replacement. I just wonder when one can expect
>> RAID-[56] to stabilise as in usable for production, since this is, for
>> my use, rather critial.
>
> Currently the main problem for btrfs RAID56 is write-hole.
>
> To solve it, either we need a big feature in extent allocator (to avoid
> allocate extents in the partial written stripe), or go traditional
> journal based RAID56 (needs a new on-disk format change, and new code).
>
>
> If your use case can rule out power loss (by using UPS) and unexpected
> shutdown (no way to prevent kernel panic though), OR you can afford a
> full btrfs scrub before any write (can be very time consuming),

I mean "before any write after an unexpected shutdown/crash"

If you can ensure your fs is shutdown cleanly, then no problem at all.

> you can
> try btrfs RAID56.
>
> There is some plan to implement a RAID56 journal, but there is no
> concrete time table for that yet.
>
>
> Or, you can run single device btrfs on md/dm-raid56.
>
> Thanks,
> Qu
>
>>
>> Vennlig hilsen / Best regards
>>
>> roy
>> --
>> Roy Sigurd Karlsbakk
>> (+47) 98013356
>> http://blogg.karlsbakk.net/
>> GPG Public key: http://karlsbakk.net/roysigurdkarlsbakk.pubkey.txt
>> --
>> I all pedagogikk er det essensielt at pensum presenteres
>> intelligibelt. Det er et element=C3=A6rt imperativ for alle pedagoger =
=C3=A5
>> unng=C3=A5 eksessiv anvendelse av idiomer med xenotyp etymologi. I de
>> fleste tilfeller eksisterer adekvate og relevante synonymer p=C3=A5 nor=
sk.
