Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EEA4B1AA1
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 01:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346486AbiBKAm3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 19:42:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346470AbiBKAm2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 19:42:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419FC5F88
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 16:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644540145;
        bh=BPUkuvzrJhnO4MgIRHV7ho6mJa8UW6QxpvJUEw3eTMY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=JSce4lLoSfXaKSQtvn6TcsEtRkuoDR5XJ3IqiAvBfD+8jRNGnrNC13KZ8QhbYur5L
         zvqJP9vjrNgUXIi+3z7287qf/gFXSgzXh4Lsitf7XCj5LTRM0egCqYeL08B6nBwpsU
         VuXnw12jxLO7nxJSQ/0rc/PtTwEZCujK+a00NFIo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wuk-1nLbng1nUK-005cU6; Fri, 11
 Feb 2022 01:42:25 +0100
Message-ID: <bf3e761f-c68b-8375-c933-06ae79f6c3ec@gmx.com>
Date:   Fri, 11 Feb 2022 08:42:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 0/5] btrfs: defrag: don't waste CPU time on non-target
 extent
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1644039494.git.wqu@suse.com>
 <20220208220923.GH12643@twin.jikos.cz>
 <b50e1856-f03e-8570-6283-54e5f673a040@gmx.com>
 <20220209151921.GK12643@twin.jikos.cz>
 <38abf10b-cca3-0c75-fb18-a90c658541a4@suse.com>
 <20220210142652.GO12643@twin.jikos.cz> <20220210165253.GQ12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220210165253.GQ12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:prIsNfyWkp6Z5R7b05J1oviIOPLtuBBn4naDbmK9KoA+vezsobC
 aytJK/ug87j8AUk7tjVdtRl7CTukFBKMm39AHznXeeMO14N3p03/JiOICQqs+lsWeM6+6hb
 f5/cQ440Mw9tSU4XlG8GXty3EoFE4T1omwiERsuJOSHD9ihBxkqj8J7LZxiQEuSBWbssSQT
 3IJmyZqhQlmk0Bbe/e2IQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G3OlllLRidU=:nnSWxc95Hfs9MHiagJ5a2s
 nhGGm9IrhxF0aeV54Ha0qSMf40NeVuYwvKyMftUWJhttStfCkbnojkR5khwOSFUZzBBcB0+9N
 ugXZJtiZTHboMF01i3U2kDz9Gunntxmqoj9+vFXkYWYIwhnPhfI9qqURQqI6DsPyX9C7pb7pI
 N80pH+bemz0y6WsOK6UiWOhwxNRISqtUwl/Oj2A4DaAnoE6acRBQlFXD1dyIINHgqzb+Z67M/
 EblaRoWCQ1hiNun3JFVWAAqvuPNKv87L2nFD9lAd1MZ9NPcqNaHvw8T3IJkx5gwexeC4OkqVC
 6nED9cRtFNjcW2eAFZAvY1vUlnkkolqhtAIX1hqaI6qiAk9Kel32Eh4CkrQpbtIKEK7zw78ro
 QEjNQ/vfgZ7jmVbRn/muOH067VMVZKNdRCAWSZFQ+nskJPpq/iPW/o5rDJnzq1GaR7jJE5uNw
 Ot6XDghsDlKvoah3mWPG4yUNw2reK54qK3c786kGAiHlrwaXxqq0DFaOUCenF9lV+0UcAd3dP
 3hze9kjj/sxscNw4lqojkNz+DI4XvMdJQPrMLNaTUq9tDxp0HtlQTmifDJgynCiO122LDLVIg
 gkmdi+pIvaeO+sab1dHRLduBJ9gcrByrSF3UXETyHU9Zhxa8jYvep6qJ22WLg0tXiPuupW1F9
 W3JSYr4BDQgboCzbRk4D7c/WdvKiY98rThYPVlYegoAb5ok3efo0STbikfZ27ykQJmL1JtWTd
 +mToQt7+82+mayCAcNJEDP9cMQuQWsgR8DAYathrf30vcCsCJ1EJEbHWr8sEoU3xgGclL8hzr
 VE3APGLyz2L7/44eDNTctaWD7K5k5mN0vUI/hL/Kea6yt6C4L7bCGViXIt9TnCIECeTut9i3I
 9J0tk32ljXTAKUpAWUX8SpWsvP6uhAj2/1lsVeTbCBqwT88kIECYBhGOSSktGQUTiGpCQETp+
 ukXq1IiXVEIKfaFylMGiSGqs8wY08cR8dPXgj7jA5UpVl9PF9GGluHvrr82JXqmuy8HpMgUiC
 geYh9b3Igz8KJObdQYJnV87myMLlK8RC8QTuIjYurCneYrDHLgCDi02y2W/XcXmMhbH9QtDaq
 9N2r+uMkdxNdxI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/11 00:52, David Sterba wrote:
> On Thu, Feb 10, 2022 at 03:26:52PM +0100, David Sterba wrote:
>>> Unfortunately, it looks like without this cleanup, all later patches
>>> either needs extra parameters passing down the call chain, or have ver=
y
>>> "creative" way to pass info around, and can causing more problem in th=
e
>>> long run.
>>>
>>> I'm wondering if it's some policy in the stable tree preventing such
>>> cleanup patches being merged or something else?
>>
>> It's not a hard policy, I don't remember a patch rejected from stable
>> because it needed a prep work. The fix itself must be justified, and
>> minimal if possible and that's what I'm always trying to go for.
>>
>> This patches has diffstat
>>
>> 4 files changed, 163 insertions(+), 101 deletions(-)
>>
>> and the preparatory patch itself
>>
>> 3 files changed, 71 insertions(+), 93 deletions(-)
>>
>> Patch 4 probably needs to add one parameter, and 5 is adding a new
>> one even though there's the ctrl structure. So I think it would not be
>> that intrusive with a few extra parameters compared to the whole ctrl
>> conversion.
>
> I've tried to minimize that, basically it's just patch 5, passing around
> the last_scanned, but I'm not 100% sure, the ctrl structure makes it
> incomprehensible what else needs to be passed around or initialized.
> If we're fixing a not so great rewrite I'm very inclined to fix it by a
> series of minimal fixes, not another rewrite.

OK, I'll re-order the patchset to put the fix in front of the structure
rework.

Thanks,
Qu
