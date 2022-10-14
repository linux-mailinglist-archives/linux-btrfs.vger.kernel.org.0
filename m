Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321F35FF695
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Oct 2022 01:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJNXEh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 19:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiJNXEg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 19:04:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D0A32A99
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 16:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665788671;
        bh=J3978gCthlPSc9L5uJ0lhPt3GAWZEw36iqP03hOgVAk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VsWQkGi+X0O16aAPhS1S6QlgXbXASoGyW1xxo1wZ/l2BOcpQPEe2N1rPkE4B51dt8
         /oRCgWnW9VG0r+oD3aNyRWnoMYbfSLvzhTuM6m6jmBPZQNcM8r96zg2612YanXeaOo
         g/RsUJzY9dJzkiNwrPimj5IoyePR3j0AtOfyrvy4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAwbp-1oplFH1ykT-00BIys; Sat, 15
 Oct 2022 01:04:31 +0200
Message-ID: <794674a0-a58b-2e8f-acba-d779537e71d3@gmx.com>
Date:   Sat, 15 Oct 2022 07:04:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 15/15] btrfs: introduce a debug mount option to do
 error injection for each stage of open_ctree()
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1665565866.git.wqu@suse.com>
 <cb7312a3d6c88100df88dc61c911e6d5e8455070.1665565866.git.wqu@suse.com>
 <Y0lZbFnapZ6Z3Xcv@localhost.localdomain>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Y0lZbFnapZ6Z3Xcv@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y7fpmQgxAmoS2JPpke6imOcPaEqmetaulSASNaX55mCNb/L0ESw
 rDZutBWHyVdkwepl7KaIzaxEKIvlW4pmL8sivKNRy8KsB/pqL8aw9qbd1l4aQEKSY9xadP6
 lo2kDy9HUMWEKwR3zAnxLDoRQX3AHoy+9rCTZJc3kPdvYVPe4mNR9lcOSvyoCZzxXA5/dfo
 e5g1VA1tHaiguhc5vrDtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E0wU0tFExag=:HrxqKyNmgsbFqm7BgNerKm
 N099MLDlEii6W0VyN+O0bFWNNyIzc5Nl0QfoV2wlsxD+LBKcDDLO7mKH8mABgC/PyyU17u83i
 ltX7d2MydnZuTb9OYUXEd5WLgNkbtgQx2LlmnYU+CyiItqAMCe0W+sCp5y7jSPiq/Ilz2VJq3
 90lv8SGqymWcgR9jpunPg5NUnVs7plLOWKMl/RvDOW07CH5aq36T9NCGATwbesp4LpV00FFNG
 UKnoVQxzWLsyP0MKBDZNhn3L1qTolWVs5mhCvMUXK2pJt1X5jnvUptfup5W3lNaljRW2KZcto
 9fcwd6vMzT5WXWtBu3WNzJAMHGoqDDZB9JchmLmq2zJDXcgV646rVtV5PuoK9T1nJesIcA165
 68lKw+6KBzH209bBHrZXK6KvtiZtCpJATc0w5YMKYRfOyr8aGDhVKTpa+MlbJr4K6r3aWPQeP
 GmTkbXafZztjDLGC4RrTRbtsbAur32t2Vz01CVHSAYDxf77HE0YDtYhdoOgootP+lUJbXdIBl
 8dnIIS0fEevRy3DLuao4+k6lAeFBxi836ntFk7G7CkQM5CbpLfideBM3qM99sLeGhdbvLJiek
 N7Vd1j0tMu2LjJyu7mJtKIGLAY2iFmMa2rcvwp8hlF1csk4pkknWCZP9x09oNI/Dxk/QZWWZe
 t/7ZSo3X7mGPFTs+zJCq3etBOYlTnoxb1GC3I79SHb23JLItTgyiJo97G4WEdBmUM5/5IIpmc
 spr7deYoUg+019O8tTF45jxnTJ2wVckjPIfCh+djetLj68e2avwuS65fKzgyUSZE+vpqtEl/D
 r7ooqiXnsq80xpt7qCAdmH+m7Up5tTgrg868ZvdX3+/ZltCyS+Gg0XcGIgwvmHlUd6hNm3zAJ
 ojzEfVVAyL6O8kDG6IthMQt+Zy6Id2XC/WGE8m6UuzhV3HBEd5ewQi/3vDjgI/fnmBilVwh8S
 5mXmox3ypGBY0UQCgq14sj+oGAHe1bDiqQ72X30hXAkO/HcSkewwPlbHiUcEe2UjmcVWgbJg3
 k5aTHw7aSh6gDNywpatKZlvrtlH9us9TIT2l+Jqol1k1OIEDjc/9PdXO72iP7f0O3LRw2uivJ
 urHyKuI7gl4oHxLKttmJlCWq7N4GqsqFaBFUsp4up+r3mxvp1x9XRqHXDa7pOnEG5PWadtnad
 MDI1K3AbE7iUZ8ECMqkY6ROnO0NZtQrpqdu7BYfOiXzeitJJqaGW4TgR5k1OYN3crTx1rS4Du
 PpyCVkYJtr9C2Fw8n3f7Bqpq7mjDlnzbY3nmewpINPQs8FwO/wRL1uCIMq38pkCc3DJj6FzIK
 UP0k6wwi80G6yox/hRvLFgtjTIAZcnXmpJ9k0mhO/B/ZtNb1VJcJt/8FxpoiUXr/YaaYQO8gl
 p2HH6DfOTpJFqscp5tMOnf3SoFifNm7nk8nkRoO5zXIbb4U2iaHz6MDgvvi5UeheKxdQ+pDyZ
 nHRHyMZXdRPxKFY4Z7+SoOm8lUAYJHmEcAeH9pjdPFBMliHKZc09Fvt/2o0T6Fvq0gNo4gNI0
 yRDyrlJ1KpZdqqr//HDUigkjz+kXtkFu6LNyzuBVLa/yk
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/14 20:43, Josef Bacik wrote:
> On Wed, Oct 12, 2022 at 05:13:11PM +0800, Qu Wenruo wrote:
>> With the new open_ctree_seq[] array, we can afford a debug mount option
>> to do all the error inject at different stages to have a much better
>> coverage for the error path.
>>
>> The new "fail_mount=3D%u" mount option will be hidden behind
>> CONFIG_BTRFS_DEBUG option, and when enabled it will cause mount failure
>> just after the init function of specified stage.
>>
>> This can be verified by the following script:
>>
>>   mkfs.btrfs -f $dev
>>   for (( i=3D0;; i++ )) do
>> 	mount -o fail_mount=3D$i $dev $mnt
>> 	ret=3D$?
>> 	if [ $ret -eq 0 ]; then
>> 		umount $mnt
>> 		exit
>> 	fi
>>   done
>>   umount $mnt
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Death to all mount options, especially for this.  I'd rather see somethi=
ng like
> this inserted in the main loop
>
> bool btrfs_mail_fail_init(struct btrfs_fs_info *fs_info, int seq)
> {
> 	return false;
> }
> ALLOW_ERROR_INJECTION(btrfs_may_fail_init);

IIRC the error injection system can not do a proper conditional
injection according to the @seq parameter.

>
> and then we can error inject that way.  Alternatively you could just use
> ALLOW_ERROR_INJECTION for every one of the init/exit functions and achei=
ve the
> same thing.  Thanks,

That is even worse.

The problem of injecting error directly into init functions is

- No exit will be called if init failed
   As we all expect the init function to cleanup itself if something
   wrong happened

Another problem is, it's much harder to test, we need to inject errors
to different functions, while a debug only mount option can easily test
the whole thing just with different fail stage number.

Thanks,
Qu

>
> Josef
