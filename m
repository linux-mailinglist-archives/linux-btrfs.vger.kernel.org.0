Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B8F4EBF09
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 12:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245501AbiC3Koi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 06:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244873AbiC3Koh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 06:44:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E4D2BB1C
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648636963;
        bh=UFgSe3pYmtPlhzJdfIh1YgrSzlzVW74vY3XhHz+7Tbs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QsUlnEiNDyF9fW5KGqWZgE9OgVmfe6f9FUcuqwd1mpbHBm3gz5Bx6IdZfEmOFOJBI
         G92z1YpZ9wBIV0Neb0cn8Zp4ooUu2fICnXwaqp3BpJ1z0EdX1QISzQKub9coCnYjDT
         c1a9X5mdmCrGtUX4/oHq5CjANhF0Zy8Arnj5POdM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDywo-1nhAkY21wa-009wgL; Wed, 30
 Mar 2022 12:42:43 +0200
Message-ID: <6e5e4112-8b9f-fcb4-1a04-c68db2fa9880@gmx.com>
Date:   Wed, 30 Mar 2022 18:42:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <20220328185121.GQ2237@twin.jikos.cz> <YkLYJ+xRvmm0yN9Y@debian9.Home>
 <ed81efec-0303-d152-a84d-74f4ff4f5058@gmx.com>
 <YkLwAf7SK95iOreD@debian9.Home>
 <d7e95b14-1e87-9c09-e172-680d53cb51c5@gmx.com>
 <YkQimcdT5KwU5i/P@debian9.Home> <YkQyLfTjAjbPZR9y@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YkQyLfTjAjbPZR9y@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AgshONwvW+p+F52PlLfGOJZtigZ39vw0LTAc0fG/Zreibye5wC8
 aTFudQ3b0mCKPPrdDrcZ9xb/GL9mxssW/Z5t0NlskLnQge2llILeCDkNwsRwSNpFIkoK6ie
 QiDQ+BaER84kMpA/1Ia6tM/BfDckT8IJZQ7N7Bs3mXxdBQ9o3QlGGB3KwV4zmHEbrMVIs82
 MrW0+eHvId7mIO1+PfRcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BML/vFp8028=:Z6advYTvbMB59VAqYs4IyH
 bX6KlB7fr1FrdDd/v8QyJFM/z1rEo0CA3nLIbrYJYJ+BIKlkF146YCEyc8VEDIiuNOBw4VZSQ
 B4k32VJvAGqHCdLEYeb855jjtsgSI5K6gORWF4OJ5+8kK/DW5fC/BLV2qXiJB1YGUtO62tESF
 QE1e9SGe3e39oGc1BYyPYlrr/oucKmIgryjKfY9vWSaReZwuZboostJTH9S+uCeyvg6lwe5i1
 JejE6BR7L9iscMMRwA4wriPud4aK0v2B8GcSfkKzfiRwAdhWFdF+fZapAhUR6Oj2H2rr/BeDg
 2M0pLAGuEYxBxaFTP23KB1EVpTgd6ucnbCWq76Niv+e3wsOocdqZ2RslMPtI2LAPGWx6HMpTN
 dfw1OuSaylfx7eI8HAw+B1ZM3ostSy034G1PBjX35GDcOeVCLHNK3KLaNdGMntsAOxoiQRzG2
 1CAkTkyb805nCq3Jgy0Ww8erLc+dyOVg7KYq2PRbeGce5tKjSvMbf3jIT9PkWpyTjDbrIY4b8
 UNLMrsNR1+te+7ENvBK/DrLmbl2hxTzR9kqVHX6m84xtSpg2RD9h2WiXYRPcRS9UpwbjyLP34
 J771FX1uGrc3KoAKEXPoW6G2D955e47oVFtDFn0ZVwD9Z3AAjk8BiPNojRZBQh/OCt0hUhosa
 4xxmlIahSF1CEoX7rwcod5vbW0chKkl76865toN7yqtaSChzOSf8KJFSXy+4AhCu50Pg25Rfv
 bi9ZCeoERd7aXrlkmRHfcc73IXLpLDFckIgMVWzWZ+hbAR+GHWY12HqJMnekYpGNeXylRBBrc
 qc57aCVZEzig1uq2PJKSoWNaUpYddfh63uMUhD7QNWjaWM91DQJ9BHEqv4MD/hpwQnrjhx1NB
 iZ+4UJqBsR+tB57tqTzDbX/NjmipNaM42pgn8FlF+kB8Bimaac8BoHyjm5dRXb5YEQeR3BlGG
 5hi9mDO7MCykvysGoL4q1/AK1C6ERRZIe6BteBbZVi91O6CbnDjbG2CUPCTfOTkNV8Pvg0raS
 yMrGpmPE/Cdl+vU5uvFhVKL5hXvFmJIHvRNe9xevAE0QX/QMtQdJdEFb1ErkyXCxPfFxhkmzi
 /X6J1d6Nmc1q4U=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/30 18:34, Filipe Manana wrote:
> On Wed, Mar 30, 2022 at 10:27:53AM +0100, Filipe Manana wrote:
>> On Wed, Mar 30, 2022 at 07:52:04AM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/3/29 19:39, Filipe Manana wrote:
>>>> On Tue, Mar 29, 2022 at 06:49:10PM +0800, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2022/3/29 17:57, Filipe Manana wrote:
>>>>>> On Mon, Mar 28, 2022 at 08:51:21PM +0200, David Sterba wrote:
>>>>>>> On Fri, Mar 25, 2022 at 05:37:59PM +0800, Qu Wenruo wrote:
>>>>>>>> The original code is not really setting the memory to 0x00 but 0x=
01.
>>>>>>>>
>>>>>>>> To prevent such problem from happening, use memzero_page() instea=
d.
>>>>>>>
>>>>>>> This should at least mention we think that setting it to 0 is righ=
t, as
>>>>>>> you call it wrong but give no hint why it's thought to be wrong.
>>>>>>
>>>>>> My guess is that something different from zero makes it easier to s=
pot
>>>>>> the problem in user space, as 0 is not uncommon (holes, prealloced =
extents)
>>>>>> and may get unnoticed by applications/users.
>>>>>
>>>>> OK, that makes some sense.
>>>>>
>>>>> But shouldn't user space tool get an -EIO directly?
>>>>
>>>> It should.
>>>>
>>>> But even if applications get -EIO, they may often ignore return value=
s.
>>>> It's their fault, but if we can make it less likely that errors are n=
ot noticed,
>>>> the better. I think we all did often, ignore all or just some return =
values
>>>> from read(), write(), open(), etc.
>>>>
>>>> One recent example is the MariaDB case with io-uring. They were repor=
ting
>>>> corruption to the users, but the problem is that didn't properly chec=
k
>>>> return values, ignoring partial reads and treating them as success:
>>>>
>>>> https://jira.mariadb.org/browse/MDEV-27900?focusedCommentId=3D216582&=
page=3Dcom.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#=
comment-216582
>>>>
>>>> The data was fine, not corrupted, they just didn't deal with partial =
reads
>>>> and then read the remaining data when a read returns less data than e=
xpected.
>>>
>>> Then can we slightly improve the filling pattern?
>>>
>>> Instead of 0x01, introduce some poison value?
>>
>> Why isn't 0x01 a good enough value?
>>
>> A long range of 0x01 values is certainly unexpected in text files, and =
very likely
>> on binary formats as well. Or do you think there's some case where long=
 sequences
>> of 0x01 are common and not unexpected?
>>
>>>
>>> And of course, change the lable "zeroit" to something like "poise_it"?
>>
>> "poison_it", poise has a very different and unrelated meaning in Englis=
h.
>
> It's also worth considering if we should change the page content at all.
>
> Adding a poison value makes it easier to detect the corruption, both for
> developers and for sloppy applications that don't check error values.
>
> However people often want to still have access to the corrupted data, th=
ey
> can tolerate a few corrupted bytes and find the remaining useful. This h=
as
> been requested a few times in the past.

This looks more favorable.

And I didn't think the change would break anything.

For proper user space programs checking the error, they know it's an
-EIO and will error out.

For bad programs not checking the error, it will just read the corrupted
data, and may even pass its internal sanity checks (if the corrupted
bytes are not in some critical part).

Or is there something we haven't taken into consideration?

Thanks,
Qu

>
> Thanks.
>
>>
>>>
>>> Thanks,
>>> Qu
>>>>
>>>>
>>>>
>>>>>
>>>>> As the corrupted range won't have PageUptodate set anyway.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>>
>>>>>> I don't see a good reason to change this behaviour. Maybe it's just=
 the
>>>>>> label name 'zeroit' that makes it confusing. >
>>>>>>>
>>>>>>>> Since we're here, also make @len const since it's just sectorsize=
.
>>>>>>>
>>>>>>> Please don't do that, adding const is fine when the line gets touc=
hed
>>>>>>> but otherwise adding it to an unrelated fix is not what I want to
>>>>>>> encourage.
>>>>>>
