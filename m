Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34FB7BB1B0
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 08:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjJFGqv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 02:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjJFGqu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 02:46:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2433CA;
        Thu,  5 Oct 2023 23:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1696574797; x=1697179597; i=quwenruo.btrfs@gmx.com;
 bh=RkLX+Zm7Ynv5tgK52EobqPUfHx+7O3wilpNPT6eXDw0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RXEGm0IR5wkzhEr3tlYwA/lRMhXWwSJoBugSAgt8Sg5xxVskI+eSp20k0acqMQo8qs7LdtLaJSF
 iOxxu/NLqYkwuJ/wSgHMI8FgQHVc12a5ygzQlC0pbaZ/IV8L0BHOJxKo7EvnAyYLVvxXnqiwOjSuT
 XCt1sEpYumk7GmPy8V8YyFyr7fgf4ZKVk0GEvipYpoOBfG8vY+YdfnBr8B8ItV+QlEe/5NDseDZdh
 ZEG1cEARoUuiggyqJLI1lXDfWt9HdnpBJRhgx3g2tM/8loEi3DTZI3g0lC3b6VIaTVVrKOJiaqS8m
 7DsEtrCuD85pFd5nsHNHkssU0b1t/Z4vwEEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmULr-1rWChZ1teT-00iWe0; Fri, 06
 Oct 2023 08:46:37 +0200
Message-ID: <1f23346d-ad61-412f-b59d-1f76e2d1df6c@gmx.com>
Date:   Fri, 6 Oct 2023 17:16:31 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fstests: add configuration option for executing post
 mkfs commands
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, david@fromorbit.com
References: <cover.1695543976.git.anand.jain@oracle.com>
 <eff4da60fe7a6ce56851d5fc706b5f2f2d772c56.1695543976.git.anand.jain@oracle.com>
 <dfc4cece-d809-4b5b-93f7-7251ba3a492a@gmx.com>
 <5485cd32-2308-c9c5-4c97-9ff6c74c64dd@oracle.com>
 <0a8d40fc-501e-4d85-903a-83d9b3508bf5@gmx.com>
 <20231006060932.GD21283@frogsfrogsfrogs>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20231006060932.GD21283@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KsbQmVgchZxrsFhocsraNEKr7ULQNOAUPr++80tFGzGTMJPDNX3
 PiCDzCPfKLeU5Kmp3/9mSCyXSo0baM5eP6n55/1Fe+xu2FFTY20bsJou1UWlz0UrM34o/sU
 ZWC+lIv5sz52Jjx4W05aHybni1yz9l3u6sYOYBPwbSfTnv/AmtjvG7YpwJt0gUl91VlWB20
 C8DvzQaRoABw0HdE9Ujvw==
UI-OutboundReport: notjunk:1;M01:P0:ruqD/Aq6EhY=;lej59FlK+CH5D6pw76HQjXOqN9A
 UxbIXFupCiriMkblgRAmojkd1jceIEY9VjVk4c4bzwjNS59PkYpCKppDguxSUZMzkplUHy8EB
 sHCh72dnEPHVMAmkbx+8u0CNRK3BcX63cPl3ca/usFVdidv8PWMXwOZJ2vhlXuNLWld70ac3F
 Ieza3abTgO6hS/tPoj1QI6EN6omHvXe95sEVu39BkxK4W1syUyH2+VSnweUQ2ivxfbuA/KxsZ
 hYG9Cs2A/D1jvHuRTbo/8GVhKxHLaIfRMytFSbimlF25f0E8IQbEV8fGs3WaBZt5xbJxdq97y
 0AnW9x0u2PJYvw66GW4uY9ygtlN2gdQA5J/kYYXhcbIt/sRoeRgzhjqKHOeCGshnfWhJ8fBrB
 uLHjX9uSFhtcQwgU8+ItS3PfujUbKwe/nHQm6PEHsC8AjdsJbGzZO9Ruf8uARMPjOPPcWTcgh
 2OGtPVB6rteY5qBwx21iY8xZFseo1p89rW5KrPqEbnboUD2mtxCtj2l7IUDBFe5ZPRnMAQ4of
 9gosslaW7NtmYurXnSOdheSBRk6kIn0vbBmOUpYcEE+9gd0TX2tW+icQ7ErnB8ux1VSPzHGGp
 LNLxzhFZfYYs7HCP9T+9X3LwTTXsVXsT9+It97sjLE7S/hsHE2+rknqHQKsk3bxEtHbM+p2kg
 K75U7ccoruI2SpoCIpJTJ2/OEkzNstAVBJU1tArq+rJw08tLpp96vv8eZ3Rad/YoST9Ys6PJu
 lpZZK+FPEOpZfABHeiP+eWQZUJaYHxrsh4+v5YZn61tr3ZZFF4K2kExiQff0wkV1yVKhVfdky
 a+1ZCsj7FZyBlsj1jNENHTHJkpQwtkGo4aDSSRjUrqNR9vpIzJ3dIstYHsV3WqhV+fSXqBHOl
 AP3s1KR/J2wwc0/Lp24688E7X718+GHxrXDXeWZCZ/OTGpbOOb2GXk1A1G6icqm7CZZ2jvpHS
 7qOkgUcApSCz9opi5J8AFOttXgE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/6 16:39, Darrick J. Wong wrote:
> On Thu, Sep 28, 2023 at 05:10:25PM +0930, Qu Wenruo wrote:
>>
>>
>> On 2023/9/28 15:04, Anand Jain wrote:
>>>
>>>
>>> On 28/09/2023 12:26, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2023/9/28 13:53, Anand Jain wrote:
>>>>> This patch introduces new configuration file parameters,
>>>>> POST_SCRATCH_MKFS_CMD and POST_SCRATCH_POOL_MKFS_CMD.
>>>>>
>>>>> Usage example:
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 POST_SCRATCH_MKFS_=
CMD=3D"btrfstune -m"
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 POST_SCRATCH_POOL_=
MKFS_CMD=3D"btrfstune -m"
>>>>
>>>> Can't we add extra options for mkfs.btrfs to support metadata uuid at
>>>> mkfs time?
>>>>
>>>> We already support quota and all other features, I think it would be
>>>> much easier to implement metadata_uuid inside mkfs.
>>>>
>>>> If this feature is only for metadata_uuid, then I really prefer to do=
 it
>>>> inside mkfs.btrfs.
>>>
>>> Thanks for the comments.
>>>
>>> The use of btrfstune -m is just an example; any other command,
>>> function, or script can be assigned to the variable POST_SCRATCH_xx.
>>
>> The last time I tried something like this, I got strong objection from
>> some guy in the XFS community.
>>
>> Just good luck if you can have a better chance.
>
> As another guy in the XFS community, I also don't understand why this
> can't be accomplished with a _scratch_mkfs_btrfs helper that runs the
> real mkfs tool and then tunes the resulting fs.

For this particular case, sure, it can be done through mkfs flags.
(As I already mentioned, I also believe this is the correct way to go,
for this particular case)

>  Is it significant for
> bug finding to be able to run an entire separate fstests config with
> this config?  Versus writing a targeted exerciser for the -m case?

IIRC it's mostly lack of test coverage, but I won't be surprised if we
really found some bugs.
Lack of coverage means bugs, just sooner or later.

>
> Is there some reason why the exact command needs to be injected via
> environment variables?  Or, why can't mkfs.btrfs do whatever "btrfstune
> -m" does?

For this particular case, I think the mkfs.btrfs way is good enough to
handle, just as my first reply said.


However for the whole btrfs/fstests combination, we have several
features which can not be easily integrated into fstests.

The biggest example is multi-device management.

For now, only some btrfs specific test cases are utilizing
SCRATCH_DEV_POOL to cover multi-device functionality (including all the
RAID and seed support).
This means way less coverage for seed and btrfs RAID, all generic group
would not utilize btrfs RAID/seed functionality at all.

For a better coverage, or for more complex setup (maybe dm-dust for XFS
log device?), I am not that convinced if the current plain mkfs options
is good enough.

Thus I'm more interested in exploring the possibility to "out-source"
those basic functionality (from mkfs to check) to outside scripts, as
we're not that far away to hit the limits of the existing framework. (At
least for btrfs)

>
> I suppose the problem there is that mkfs.btrfs won't itself create a
> filesystem with the metadata_uuid field that doesn't match the other
> uuid?

That's not a big deal, we (at least me) are very open to add this mkfs
feature.

But there are other limits, like the fsck part.

For now, btrfs follows the behavior of other fses, just check the
correctness of the metadata, and ignore the correctness of data.

But remember btrfs has data checksum by default, thus it can easily
verify the data too, and we have the extra switch ("--check-data-csum"
option) to enable that for "btrfs check".

For now we're not going to enable the "--check-data-csum" option nor we
have the ability to teach fstests how to change the behavior.

Thus I'm taking the chance to explore any way to "out-source" those
mkfs/fsck functionality, even this means other fses may not even bother
as the current framework just works good enough for them.

But IIRC, even f2fs is gaining multi-device support, I believe this is
not a btrfs specific thing, but a framework limitation.

On the other hand, I can also see the possible problems of too many
things out-sourced to external scripts, but I believe we at least need
some honest and constructive discussion on the limits of the existing
framework.

Thanks,
Qu
>
> --D
>
>>>
>>> Now, regarding updating mkfs.btrfs with the btrfstune -m feature,
>>> why not? It simplifies testing. However, can we identify a use case
>>> other than testing?
>>
>> For consistency, I believe all (at the ones we can enable) features
>> should have a mkfs equivalent at least.
>>
>> (And can get around the the test limitations for sure)
>>
>> Thanks,
>> Qu
>>>
>>> Thanks, Anand
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> With this configuration option, test cases using _scratch_mkfs(),
>>>>> scratch_pool_mkfs(), or _scratch_mkfs_sized() will run the above
>>>>> set value after the mkfs operation.
>>>>>
>>>>> Other mkfs functions, such as _mkfs_dev(), are not connected to the
>>>>> POST_SCRATCH_MKFS_CMD.
>>>>>
>>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>>> ---
>>>>>  =C2=A0 common/btrfs | 35 +++++++++++++++++++++++++++++++++++
>>>>>  =C2=A0 1 file changed, 35 insertions(+)
>>>>>
>>>>> diff --git a/common/btrfs b/common/btrfs
>>>>> index 798c899f6233..b0972e882c7c 100644
>>>>> --- a/common/btrfs
>>>>> +++ b/common/btrfs
>>>>> @@ -690,17 +690,48 @@ _require_btrfs_scratch_logical_resolve_v2()
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _scratch_unmount
>>>>>  =C2=A0 }
>>>>>
>>>>> +post_scratch_mkfs_cmd()
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 if [[ -v POST_SCRATCH_MKFS_CMD ]]; then
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "$POST_SCRATCH_MKFS=
_CMD $SCRATCH_DEV"
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $POST_SCRATCH_MKFS_CMD $=
SCRATCH_DEV
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return $?
>>>>> +=C2=A0=C2=A0=C2=A0 fi
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 return 0
>>>>> +}
>>>>> +
>>>>> +post_scratch_pool_mkfs_cmd()
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 if [[ -v POST_SCRATCH_POOL_MKFS_CMD ]]; then
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "$POST_SCRATCH_POOL=
_MKFS_CMD $SCRATCH_DEV_POOL"
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $POST_SCRATCH_POOL_MKFS_=
CMD $SCRATCH_DEV_POOL
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return $?
>>>>> +=C2=A0=C2=A0=C2=A0 fi
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 return 0
>>>>> +}
>>>>> +
>>>>>  =C2=A0 _scratch_mkfs_retry_btrfs()
>>>>>  =C2=A0 {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # _scratch_do_mkfs() may retry mkfs =
without $MKFS_OPTIONS
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _scratch_do_mkfs "$MKFS_BTRFS_PROG" =
"cat" $*
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0 if [[ $? =3D=3D 0 ]]; then
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 post_scratch_mkfs_cmd
>>>>> +=C2=A0=C2=A0=C2=A0 fi
>>>>> +
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return $?
>>>>>  =C2=A0 }
>>>>>
>>>>>  =C2=A0 _scratch_mkfs_btrfs()
>>>>>  =C2=A0 {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $MKFS_BTRFS_PROG $MKFS_OPTIONS $mixe=
d_opt -b $fssize $SCRATCH_DEV
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 if [[ $? =3D=3D 0 ]]; then
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 post_scratch_mkfs_cmd
>>>>> +=C2=A0=C2=A0=C2=A0 fi
>>>>> +
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return $?
>>>>>  =C2=A0 }
>>>>>
>>>>> @@ -708,5 +739,9 @@ _scratch_pool_mkfs_btrfs()
>>>>>  =C2=A0 {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $S=
CRATCH_DEV_POOL
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0 if [[ $? =3D=3D 0 ]]; then
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 post_scratch_pool_mkfs_c=
md
>>>>> +=C2=A0=C2=A0=C2=A0 fi
>>>>> +
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return $?
>>>>>  =C2=A0 }
