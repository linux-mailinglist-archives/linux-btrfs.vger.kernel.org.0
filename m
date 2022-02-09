Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904194AE5CC
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 01:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbiBIAP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 19:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbiBIAP4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 19:15:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06185C061576
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 16:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644365746;
        bh=44oorTOdiJa2T7zWwMY1N1r4n4cn84v6u8RttOQhX1Q=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=CA7nYQ/I2am+5Z9YRiCxb54EIZfEjpa2CJbANGdDyUlCOYjEHOa0hlPUlcFbpjV44
         DyTBbYav6+765yg40YJUo9iS1x8SWC6jCWN6IdcXEZT/F/yDL966+5vmh7yqXXbQVr
         bCmRnRwcHFgzKfAGDY6xTm3HVu1uLZug8NRNktHA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY68T-1npXKO3CUX-00YTdU; Wed, 09
 Feb 2022 01:15:46 +0100
Message-ID: <9292fc4a-9c6e-8e28-8203-f70118e9ee20@gmx.com>
Date:   Wed, 9 Feb 2022 08:15:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 3/4] btrfs: defrag: use btrfs_defrag_ctrl to replace
 btrfs_ioctl_defrag_range_args for btrfs_defrag_file()
Content-Language: en-US
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1643357469.git.wqu@suse.com>
 <34c2aa1e7c5e196420d68de1f67b8973d49e284b.1643357469.git.wqu@suse.com>
 <YfwOJ0UT5t64BhVG@debian9.Home>
 <64316118-4f91-a277-d28a-24f74f2e6056@gmx.com>
 <20220204175742.GG14046@twin.jikos.cz> <20220204180031.GH14046@twin.jikos.cz>
 <20220204181707.GI14046@twin.jikos.cz> <20220208170044.GD12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220208170044.GD12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YWHu+rAxCetE4TCpwESIKyHiP2HVR9NKL+N2CU1TOG74BtT7lqq
 PTyynTkf6OhQPWFp54EAELqoDS28R3GOBFR/8Tm1GgIa1qKuEZCQzQGCMud180Z7ecVCgiU
 Cn2LwQpNs/gPkrH7VpzzCWSu3yrx146sEabICsDm0UsvdOpmmmSCs+Df9w93Rn9heK8lRBv
 3LDkrx1fAlt9SbvfvMGaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t/jwb1zjTnE=:m1AnRO5wDM5/Yi0uNHkthz
 j2yfhKJXjBLQI/QJ8Hpj1KkKxL8WyIqaZxwpUzmZql2hN/k5fYy0NGfc4ETfAGWtsmqhjD0aQ
 j0MogKiDLsJ2N00LRl3S50IS5CL9TmAhx/LSQvyakBDCVo5kEise629U1zOaqPoT1mkHikNds
 ciFPhF/uJBSUHvd5u2/1UdKJ1FsfQm1qlwChVVkCdufTVfZWZKhgabuJTE2V3cGFI/qPNk/wJ
 JBVeQwTOIVeKcfus5M24jT62tM7V8YeYb1bsjfaaQ8PA1XgluUCQoXDfTtsS6hBoa0Q4k26Sf
 sjPVDKgOeEw4JQ4RUYdPmL8k4ZsBH/SLfqUj4duzCeC/iqBznj7Lyrbll+ZxpM1RIm34oehen
 Apnnp+4EPGjhWfZlluVzitbHWEv7sEcFIElioSSvfEUQmWEtZ2O4Y7uQaONXUplG+mbZCqSCU
 ATtQ+SwRm+v077RBU/Ga7NMZOq9UcETCP0qRceQZFxK9E72QN8BsE8vnpNHDtSOhfQXXnE+XM
 bl0mZRTAOasfor4ksEbxc/aNmkGsyStOZAV9sOTM5O9gBKjrvTOrG0Hgyihl8Mg4pkiBKQzKO
 vwZy0qDzhwV0Ujo8yJVpWOP4LyRdjMwQmn3Al0Jdh0VIG9zNOplIzPuQswkqKls4lVMr9XP4r
 L6LHR7kPyqhNC72PcOJy7XT66AfNzrwDcfokrMYtb0yvfl7UzSGyTE+YnmoUw1LQpd6Llf7vg
 EES1TmTKI9yR+8GJpScYaxkdPBVNc4nchW4Y2rkZ9bMkkosD3tc65/YRECV6MGHeJwNx2HcvV
 MAR8T4mR6PZVGH4V42YFjN5hfL5nCrdckP6k6vt6DxeRH3804yxS8CtakYRAHMhjwUMcF27Hm
 1IsMRBQz7Jjl/ZiN1DR6BU7hRFwjUnDt9YtmZ9ByJnQOtku8aYzJQwS04zb2bCVsnb29kS+RB
 ouvjMjD0J+9m4X7Wqp60KNe6KVEWzn4aGcOqlnIkbmCCvhP5VCKYbkVJxfulyKhWY4zKRjskB
 UDpdeGXsa9qE+5XiwydM/UJ2TUMgsfhttH7aLtV/imp9+awtELUj5QD6aiU3OIbnLGoLI2t1t
 99whwSQ0OMkASQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/9 01:00, David Sterba wrote:
> On Fri, Feb 04, 2022 at 07:17:07PM +0100, David Sterba wrote:
>>>>>>> --- a/fs/btrfs/file.c
>>>>>>> +++ b/fs/btrfs/file.c
>>>>>>> @@ -277,8 +277,7 @@ static int __btrfs_run_defrag_inode(struct btr=
fs_fs_info *fs_info,
>>>>>>>    {
>>>>>>>    	struct btrfs_root *inode_root;
>>>>>>>    	struct inode *inode;
>>>>>>> -	struct btrfs_ioctl_defrag_range_args range;
>>>>>>> -	int num_defrag;
>>>>>>> +	struct btrfs_defrag_ctrl ctrl =3D {};
>>>>>>
>>>>>> Most of the code base uses { 0 } for this type of initialization.
>>>>>> IIRC some compiler versions complained about {} and preferred the
>>>>>> version with 0.
>>>>>
>>>>> Exactly what I preferred, but David mentioned that kernel is moving
>>>>> torwards {} thus I that's what I go.
>>>>>
>>>>>> I think we should try to be consistent. Personally I find the 0 ver=
sion
>>>>>> more clear. Though this might be bike shedding territory.
>>>>
>>>> The preferred style is {} because { 0 } does not consistently initial=
ize
>>>> the structures on all compilers. I can't find the mail/commit and
>>>> reasoning, if there's a pointer as the first member, then it gets
>>>> initialized (the 0 matches) but the rest of the structure is not
>>>> initialized.
>>>
>>> I thought we've had all the { 0 } converted to {} but no so I get the
>>> consistency agrument.
>>
>> https://lore.kernel.org/all/20210910225207.3272766-1-keescook@chromium.=
org/
>>
>> A tree-wide change but it did not get pulled in the end. The problemati=
c
>> compiler was gcc 4.9 but the current minimum requirement is 5.1 so I
>> wonder how much relevant it is.
>
> I've asked Kees, seems that the conversion is not necessary. Thus, I'd
> stay with { 0 } that we have now as it's the most used initializer.
>
> No need to resend patches just if there's {}, I'll fix it up anywhere I
> see it.

So the preferred style reverts back to "=3D { 0 };", right?

Thanks,
Qu
