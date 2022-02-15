Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258DD4B6C13
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 13:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiBOMcp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 07:32:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiBOMcp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 07:32:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300CF107D33
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 04:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644928345;
        bh=fcK0EZ7sVHY0jCt/AQTgl1wx/cFSVRnY0PZfwXZ5NRc=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=hNYJsgUOT+ha9lbJMj+Wwe1iEG99asebVbl4WoK2FGV6eQZDDv8xlghJTl2P43IIw
         pclCchHfRJMwTmgBQM4PmckeqZVNMwt0VS1WcdvDvJOGOHj1/WMR4I6nqwmTFbpmTF
         6O3P+xcactm2khkoO5pl4vIJgJiZu2CLnoGVt/oE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fii-1oHIvY3iDg-0122It; Tue, 15
 Feb 2022 13:32:25 +0100
Message-ID: <37c59b99-bd45-c017-6d2b-ff9b7a7fc1af@gmx.com>
Date:   Tue, 15 Feb 2022 20:32:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [btrfs] dae7bf275f: last_state.incomplete
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     dsterba@suse.cz, kernel test robot <oliver.sang@intel.com>,
        David Sterba <dsterba@suse.com>, lkp@lists.01.org,
        lkp@intel.com, linux-btrfs@vger.kernel.org
References: <20220215072054.GD28159@xsang-OptiPlex-9020>
 <20220215120541.GL12643@twin.jikos.cz>
 <5dc2fd83-5c87-4ec7-2b2a-3eb6a48b7186@gmx.com>
In-Reply-To: <5dc2fd83-5c87-4ec7-2b2a-3eb6a48b7186@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OUIB1NM7taye9meh/pgWsrFZSj0Hq8q5crJ9KUy84Wzd6CSNfty
 o7ogFpDgpS4Pd9Xg3+IeKME5xFbXn88DSOPk9DmuFJdtRyZfCY5VaawM1zScyojitx9Rcos
 Sycy84AxJSRghEVYmIk2ACHy73XQPOu3nmXd5vvsu0AhWkjpKeGEr8QrozD7uLtkWZS+9yc
 4hjSijrdSPtxPI6mgqzIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:42NpN5ONcFE=:p5ilGCu0AJNWX83v9DY7pN
 Sa7Fcz0pSy6UnUYzbq0seqZFFD1darL/bnGrGNXQSj1xqDM9F37se9O3jn29g8kJg7IiU3vWZ
 X1JVy0bjveVNfBrFzqVPOZHZowZM7z57fOG5jf1fCblQ3nlH8Ft+FR7T4Zq35lcTXYjcG/JYm
 rWquzBj3yvlYUc4+1fEVaokZu5IjkT3jxnPHkE3e4110SA83ExytLnV/lucPxIyr3m9FVTf9O
 4zr50rBXYAORBHSedFRAx1NOrkO5m8QwK5FYSF3vXaoJlOIOaDMNWiRezbEuykfLg60wYPU1X
 VjUjYwyvajdkmoQRp+cFh93FPrYzn0gGt/Umz2bZZ+kMOsIY88VhjDsZvutpHHb5F70LaZ7+G
 kC0ZN2m299KNvgvr3eX4XRQ3f9C+mFNL4zm2xZVA3Uv84IoMnoHbH9YXeec8+zqQFrbjJUEE4
 6nij74GXngChN7O2bWbJW0GQTmAFChd3OTGF95TMGuu8SiDRuX7zg1w51T70pHvUwuC51DDyH
 fc8NejK8fgoX3Cl0KUKBV7UVo9SSTGx7qJ+NVbjQeT5zHTWHd3plMdyQyXrx3mR+mk6gW6Pp8
 0d7xRvRGPe/6uLL5eKnWFy3bG1seFFQ9MQLyyAwbFoeNhTQGa9uBCDF9KpguVWb0WnoqZbonu
 ngpdrrznyFP3aIDqp1F8b5cheopzu3LNi0haDuhVgIue8lfk0Jom4V46aroiuvH2NXcLK4xic
 ddOy1+8ulUoq3+48AQ+JuilFyau0TwEPdZitdjP/9wykydGLgmrxlUQWMVlMCE5OsMNcN5+fj
 rZvTkjeDz/oVqeIGX+gvzDkF5eOwVFfqsFhCeVoOyFibLdC15o8SUr2/uuMUvr5ZHkjnBxLp7
 u+MvkO8FxWPNHew8qO/eSyCCjeWTVnjHZc5hdkCdLgFLBtR64irDYQx7E4fIr9nYQzy+z2NUt
 w9w5kVrSV6+nFSe00mNNUjrwevn7zg+XiT4zcOxKh7vymelql4Xl3ILpUlKlo15IHoZo93GlI
 BDQexmlEG9Lug7K/dRJCV72OWPFOaK2ybuMA82NsKG7NXBKRMhfw7t6TgT3tlJR1rLqORwSjk
 /wzs9qe8hPRLjs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/15 20:25, Qu Wenruo wrote:
>
>
> On 2022/2/15 20:05, David Sterba wrote:
>> On Tue, Feb 15, 2022 at 03:20:54PM +0800, kernel test robot wrote:
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>
>>>
>>> the test's last state 'incomplete' seems be caused by below error
>>> (detail
>>> in attached dmesg.xz)
>>>
>>> [=C2=A0=C2=A0 49.293458][ T3822] BTRFS info (device sdb3): flagging fs=
 with big
>>> metadata feature
>>> [=C2=A0=C2=A0 49.301630][ T3822] BTRFS info (device sdb3): disk space =
caching
>>> is enabled
>>> [=C2=A0=C2=A0 49.309039][ T3822] BTRFS info (device sdb3): has skinny =
extents
>>> [=C2=A0=C2=A0 49.320312][ T3822] BTRFS error (device sdb3): invalid nu=
mber of
>>> stripes 0 in sys_array at offset 17
>
> The offset is just one key, so we're reading the first chunk item in sys
> chunk array.
>
> If you guys can reproduce the situation, please provide the dump of sdb3
> by:
>
> # btrfs ins dump-super -fFa /dev/sdb3

No need, your fs should be completely sane.

>
>
> A quick glance gives me some concern, as for super block sys chunk
> array, we're not doing the proper extent buffer thing, but a dummy/fake
> extent buffer just to get the extent buffer accessors.
>
> Thus some get_**bits function may return false 0 and cause the problem.
>
> I'll try to reproduce and hopefully fix it.

It's the condition, completely opposite:

-       ASSERT(check_setget_bounds(token->eb, ptr, off, size));         \
+       if (check_setget_bounds(token->eb, ptr, off, size))             \
+               return 0;

check_setget_bounds() return true if nothing is wrong.

Now we're already returning 0 for any bit read, and never write any data
for any bit write...

No wonder we got num_stripes as 0, as that's the first thing we really
check from super block...

Thanks,
Qu

>
> Thanks,
> Qu
>>> [=C2=A0=C2=A0 49.329910][ T3822] BTRFS error (device sdb3): failed to =
read the
>>> system array: -5
>>> [=C2=A0=C2=A0 49.346302][ T3822] BTRFS error (device sdb3): open_ctree=
 failed
>>
>> Seems that your setup has some problems with creating/using valid
>> filesystems. It's reported on a patch that moves a sanity check from an
>> ASSERT, and your kernel is not built with asserts enabled so it actuall=
y
>> started to test more things.
>>
>>> CONFIG_BTRFS_FS=3Dm
>>> CONFIG_BTRFS_FS_POSIX_ACL=3Dy
>>> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
>>> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
>>> # CONFIG_BTRFS_DEBUG is not set
>>> # CONFIG_BTRFS_ASSERT is not set
>>
>> Not set before, now it is. You may want to enable this to see if there
>> are more problems reported. It can be one time or enabled for all
>> testing, the assertions should be lightweight enough for that (compared
>> to CONFIG_BTRFS_DEBUG).
>>
>>> # CONFIG_BTRFS_FS_REF_VERIFY is not set
