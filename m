Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3975E4B6BFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 13:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiBOM0X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 07:26:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiBOM0X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 07:26:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8183107AAD
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 04:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644927962;
        bh=stS9VAXb1+TTHkcy69O1/SuQarOty4RkDZgFmgvD4gA=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=QDJBTPeqcXGwyXGhODn7OZADZvTAmh8LKzheP2PfPCFfWh0tVmYAcNl1G0Cmk4Qgt
         vp3ZzVS4gy7jltRH8jMeb6Lmv9/2A+FSrwM3uhg97yzPWCPNDeEsYQ5VGf20zZJfXk
         xrqxmz15eb7z6p+rgId1XEIf84NxP1h1MEXq0Hg4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUosT-1nkArw3SKn-00Qo1Q; Tue, 15
 Feb 2022 13:26:02 +0100
Message-ID: <5dc2fd83-5c87-4ec7-2b2a-3eb6a48b7186@gmx.com>
Date:   Tue, 15 Feb 2022 20:25:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
To:     dsterba@suse.cz, kernel test robot <oliver.sang@intel.com>,
        David Sterba <dsterba@suse.com>, lkp@lists.01.org,
        lkp@intel.com, linux-btrfs@vger.kernel.org
References: <20220215072054.GD28159@xsang-OptiPlex-9020>
 <20220215120541.GL12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [btrfs] dae7bf275f: last_state.incomplete
In-Reply-To: <20220215120541.GL12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8MPLlonZPZQAhPCOHVGyfRRbqEHnlbyARxypm5YzVDIUhhJgXVy
 YnWvmwLSIyQColLHMF18LVjrpTgDsEShviatZv6rFOUPFinNpoBDd7a033m5ALq1xy2XMxN
 z88QsEeLlbpBjIWtmZNWxbj7nRgBEjAykNdcZldZtIQlCUH71dWgfWoCO/cljayQDKZJQe8
 hpp0xNRj1slrnTjqoo4Bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d93fPvoximk=:600/LtPCm8FQz3C2+M0Gyn
 Bj5kf8JmexX11L4xXAqfeJ+TtmYW4VN6itNU+lKjTsLsKPN468c4KuM14A56NGjSXvMIEZbg7
 L9uVNcAThuARmjuI6jZsn7n78cVbAuvp/2nWOjs0VtYDVNJePQfRm/v1l+h6IZNGkwNURPvzp
 /kQVC43DdET632agh8Djzo2YJf2SrRFPtyOBMl0ryhciuY/yj+b28fiZarLD86bNzuUgZHdu4
 ySm3/vClFxQuKDeBrKhFBUDwJnt6UPnSuR3AzkJbT2bu5Z5SErwVY/BkTPWL1q+1b8erjGxHk
 gxU0tlHYwEpSfbTFrbGmKPkTfSmLHUU6SU1lQXYN0o/g85Qc1VVJqjkoOSDBwv0pWpWJBX5Nt
 GUtGWXqJRMFbtKPUpVRwqfJ9lQxe7xRcn8LRVNgyzIWENo34cZgBtSeyTJtTXEE3ZEPx+VrJt
 W9PjxyjtKseWLubIXeAuknzmvMiEAJiAkkJ0kQTpt2Y+ztTP2Ki+2rZy9OBHck3puJC3+Azy2
 LGfcgHCneVolKdwbE+jrepdhm7KnT3kaeu/vjn3w1WU9FBVttEA55J+d8X4XkGpC3WU6AfQtI
 CMPKVwbFT+QPoV0pffPypXjQ7TAAf4No93eghpeCZmpipXiqEsEkG58fRT1CIrT8hWnK3uKzl
 mSRJvmxbI7AZDcWbOeN9AblmYW77VAth1IL+a0pE+ZcJ/V434KIeOyr3o2x+TfjJ1ukFHAAqz
 mrygrJzUT6ufxUurLaa7hPxwAXdoqdTX+D8GqRMCBOBoBYdYrnWfVsj24sNKrLCvJx4oygOtm
 0UkbXfLtPZNuWp4GpiqLZfx1jBSXfeG+MFZ1xWWBebjlcMRtEhpOnfVW6nyw5MKOMK0MHn9TN
 /pyxY0j5IEJjsoYmuLx7JVjPmTlQ1X7Lj+i1mCUzW14LLkA7vK/y4hzQ1yH5aU5G4MdjwfoE6
 O6V7DOImYi/nx2hhbZma6Rhpky2RcXbxIkClVKJOMRHzOOovnupyWDkGyw0BOkU2DC0lJnPBE
 CwjPJajpNHA52sZXL6dlrK/Y9PhNQY9o0g5MaJJrxS0YixakWPk5hDhmDctfE81E845mpguZg
 6ZwZFw240xCcqU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/15 20:05, David Sterba wrote:
> On Tue, Feb 15, 2022 at 03:20:54PM +0800, kernel test robot wrote:
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>
>>
>> the test's last state 'incomplete' seems be caused by below error (deta=
il
>> in attached dmesg.xz)
>>
>> [   49.293458][ T3822] BTRFS info (device sdb3): flagging fs with big m=
etadata feature
>> [   49.301630][ T3822] BTRFS info (device sdb3): disk space caching is =
enabled
>> [   49.309039][ T3822] BTRFS info (device sdb3): has skinny extents
>> [   49.320312][ T3822] BTRFS error (device sdb3): invalid number of str=
ipes 0 in sys_array at offset 17

The offset is just one key, so we're reading the first chunk item in sys
chunk array.

If you guys can reproduce the situation, please provide the dump of sdb3 b=
y:

# btrfs ins dump-super -fFa /dev/sdb3


A quick glance gives me some concern, as for super block sys chunk
array, we're not doing the proper extent buffer thing, but a dummy/fake
extent buffer just to get the extent buffer accessors.

Thus some get_**bits function may return false 0 and cause the problem.

I'll try to reproduce and hopefully fix it.

Thanks,
Qu
>> [   49.329910][ T3822] BTRFS error (device sdb3): failed to read the sy=
stem array: -5
>> [   49.346302][ T3822] BTRFS error (device sdb3): open_ctree failed
>
> Seems that your setup has some problems with creating/using valid
> filesystems. It's reported on a patch that moves a sanity check from an
> ASSERT, and your kernel is not built with asserts enabled so it actually
> started to test more things.
>
>> CONFIG_BTRFS_FS=3Dm
>> CONFIG_BTRFS_FS_POSIX_ACL=3Dy
>> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
>> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
>> # CONFIG_BTRFS_DEBUG is not set
>> # CONFIG_BTRFS_ASSERT is not set
>
> Not set before, now it is. You may want to enable this to see if there
> are more problems reported. It can be one time or enabled for all
> testing, the assertions should be lightweight enough for that (compared
> to CONFIG_BTRFS_DEBUG).
>
>> # CONFIG_BTRFS_FS_REF_VERIFY is not set
