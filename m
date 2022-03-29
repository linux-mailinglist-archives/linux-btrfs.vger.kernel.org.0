Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3D24EA795
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 07:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiC2F70 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 01:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiC2F70 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 01:59:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA90324B0AB
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 22:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648533443;
        bh=f1IaLK/bthAKDTw1JP7XD2SmXFi57MCLTjUAfCKfHoE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=B3JqW6Gfq0PAf2ADDHSPhwjzVkXj1HjXuGLPsSRmkG+ei8pWQt7VZQLzUbU1YTmKm
         gNwWD+IKiiwD+qLMbqTxy8ob+B77Cn4RcT6zifs6PPV59anwEgMkZ6nNWjF4rTe2rY
         2Yi2tWM8NAOvcvSSiVIXvpIPQ5FkIMoFL2KBeil0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M42nS-1nZ4r42uHI-0000sf; Tue, 29
 Mar 2022 07:57:23 +0200
Message-ID: <9e32aa01-c712-1def-6d54-1db450fd2750@gmx.com>
Date:   Tue, 29 Mar 2022 13:57:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [5.16.14] csum mismatch on free space cache on subpage
Content-Language: en-US
To:     Matt Corallo <blnxfsl@bluematt.me>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <61aa27d1-30fc-c1a9-f0f4-9df544395ec3@bluematt.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <61aa27d1-30fc-c1a9-f0f4-9df544395ec3@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SCCWaWS290ixOxIob/7Ni8Xn7mAHw7E9yYolFT6x9em79b/Us7w
 tkJntoYbIz0hpY75G7dHsQrVTNo7JqByYsxk5lPdRdFuMj4GYl7MhKv36K/trN8fJSNcx0W
 vmGy+kAHQ+tr2yq/6cKfH3TK1vhKKvMhIpUUBG6FJoWEXR8jrysLkj+ADwgdZ75QcKA8hkP
 CRcjjX83zDATRv2jRJRFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5UuBTgsnntg=:r06xqpfJlztMFQHQV8DN3J
 NEBApOOp+X3J/xqd4hNE/4DvGGLl3r/uz1f4XUPoOaR/KjVWBvqevOLoubQKEJcnf9ksvldsv
 efRvKTeKccpDnxBDN9C+spRY6thqjptNht9qPiuifmkAD7e3rW8IkrXF8X2XTGpaI4qNGN3DO
 /XpC/P2NWveKaU+w0pCOsmO8Ik6x9/KHyBlsAmTMLWJ2iteOyukbwN5BUhBv3mfQesVoemt4K
 X7OqdlxsITEq/wFkkj8ACtytHZ/e8FTzPCJOmuVRoPZiT83xCu+RM8fo0KFHSqHKEqOvlhQke
 8s4X2kNp1HhAMTeEQSahGKkXBxgqJQf9c+fTGo7IfoXOqnSO9uVP5AT9AqpxJrW+oMEZB2KBC
 hIfUzkLt7Nc0H2U1v2rpj7zjTbUxOPsh8oec1W4v/cParHrtOeKaWWK7ukoEljLhIufmcEtLm
 8Qjn2pze7KC10bhMHupCdyp4rFBbLYdoLbjRkFMaiDQHu5J6X/iiKxlg7f5ski3XK34HuSnyA
 ikM98pvojbjNkDc3j1WZjwFbZqONK7sWDkNpOnrNK1Y7FO3SAYw1RzmaOARxzczDHGyMgae3b
 O8k0c+QEGfTtlSMSIpht/sNrOnlEThYEAd3O36Eg1fQ9SSKNzp2zqiiLQsHhtQmBA8EtECu4F
 1wwPtH8yBZz8vcyBbyhosnHl/pyATsEeVhxem4kwzOyD2QGh1ZbCoh0bTkxWvyia5G2nkmXcg
 Ocab4abMxgDWSNUmb6eQtLJ9BYaYZCnFKhUrNbiGF0/SUiyT0cuL8CT/dpC+AuEUJoN5Y3dEc
 0K4YIOID6cFrRovRQ0AaNvhVK2eMoDgoeWAi/XrBIV9Jf9/i206ag9rmz4qDEBXriGqSxQ0YD
 YWUMlnRDPL066OXCidEcjrbld3XOAbbEXa4MiU3UHAV4KgC8LKa3DEWxeMyAz1lwNmr8Eu17f
 BBaeoalqtHo61Xf5BQjiW1GB0v9Tq/Up+i0/fLZw8WMd4xlhTEwXycoBlggGZriFrs40nsuce
 VIqYYzjOznK6rM+dAkNjMroBmx2Lm9pFSB5ifpGhnJdoBkz6PYEvwkN02P1rDETn5XU8irGSs
 LSTt6emhCoAao0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/29 05:18, Matt Corallo wrote:
> Basically what the subject says. Any time I mount an fs on my 64K-page
> PPC host mount a 4K-page device (so far two-of-two - once a flash drive
> with mirror and nothing else, once a many-TB volume across multiple
> disks) I see a stream of csum mismatches in the space cache in dmesg.
> The FS' otherwise seem to work.
>
> Matt

Oh, so you're using the subpage feature recently introduced, awesome!

But it looks like there are still some v1 cache code using hardcoded
PAGE_SIZE instead of sectorsize, thus it's reporting the problem.

You're completely fine to continue using the fs, as such PAGE_SIZE usage
will invalidate all old cache, thus there is no chance of corruption.

Or you can convert to v2 cache as a workaround.

I'll need to investigate some time for this fix.

Thanks,
Qu
