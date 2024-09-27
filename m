Return-Path: <linux-btrfs+bounces-8298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE8D9882A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 12:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E163B22C6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44F71891A1;
	Fri, 27 Sep 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SQqATQ7N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A713698F
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433516; cv=none; b=tS9TqRRcZZaqsQee4bKPoNSeX29TcFaJWcfBBQ98qTB+np0iEo5n+JPVLLETYE+xvNijWFeyri17qH1Ft1mlhCFSzfJ/Xj6ziuWcAvIto+ZX4TrdLpE5h2BXNyemw1E91+fhuiXpqbwHqBqQaqJvjrsINkPEeWeuUWPlc2b3UB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433516; c=relaxed/simple;
	bh=m+iiwjfVOgw5+qD2XcOp/NSGORyLtc9htFEyk8mTN9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpX3+Lke1ohFq52QJIfZdfHazq84DUS+rCAjsRk1OGBw0a/3R8bWsYOTbgR3km6Dxdr1HhVCjXDExQvsaCDqiMF1+/sHFUW2JuCftpURRv3mn0pXe3O/0yArv8t2V4j5+jPDVUIGLpklhSyFg1Xisby+8ivexdmKSpeNPrzhX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SQqATQ7N; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727433507; x=1728038307; i=quwenruo.btrfs@gmx.com;
	bh=h3ERxrTnaC1GjyuIIjL5iCRxHyLklCLi29HxdFr3KOU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SQqATQ7Ny6vIJoYUBwh1XgYp7ExNj7PxAWemzxibGGCF3RTYtFRpVXwZGeAhehAy
	 r2e/+uHtPXI2NJ86B0qPkSaVsd9s6+j36rz4iGSxA2n419TB+3tCxKW0AtG/oI4dJ
	 n8B1ClWg7WiObHHomTWa03JYHXzJDGX/4kuSnszUnCYOis44/KacIZijeB8zyubZY
	 3LxHf4coQa5GV9Z+VGEUMLCHSHH/7hu8f4gRE/hHo2wo1vYmBk1M1C/fFuykUrMr1
	 VF5PyBjsFFcpoLRJKXeW/uOVCBMIvBma7cfVuo2llp+nnMrOj6cE0Mw5iSlt/fgEc
	 kDFPBcWEvpKfbmeJ4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mg6Zq-1sGxbQ3oC6-00cpGZ; Fri, 27
 Sep 2024 12:38:27 +0200
Message-ID: <3676e9bd-af5b-4678-9ef5-fdfedcd0e743@gmx.com>
Date: Fri, 27 Sep 2024 20:08:24 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: send: fix invalid clone operation for file that
 got its size decreased
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <5a406a607fcccec01684056ab011ff0742f06439.1727432566.git.fdmanana@suse.com>
 <ac929d10-d263-46b1-9584-fd00a38e6189@gmx.com>
 <CAL3q7H6vr1sDHR9DwdE7xqgr6uL=meyoGAYJz2AygtuisR1DyQ@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <CAL3q7H6vr1sDHR9DwdE7xqgr6uL=meyoGAYJz2AygtuisR1DyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d/WYMs3Tt9vUeUs635i94J/Ci0whKB0iyPs4/6qF2RVryqgZHCu
 KaaBS7/GkLK9XuBgj9vLNcO9oGW7jhxfzeHXfBZjKbrEm6Aqdrdu97eP63YmBuc32GtY2OA
 Hqld7cU6RoMZJFv5ssI+hTTwrtYEfHeSreXnILHorzGdRVsf+wQ3cdgcIncIRJycMw/iFvh
 DW/L2m3CP9bjNDaTL96jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wWoKWShxO0M=;6dWZBvxvAbMv002d9PAQlHyBOMk
 ViLOCC9wmACAPjde+ljkhRl8O7K3PbEBJOs1c8lw4rCFiQ2AUzOV5g1lYhXeRhTTHk+fVljzg
 nKVTd4YxuShPyuRZtSJIsDu2gYzKD4BoJa0F5JUykOR4J8nO+SL0rYfuXdm0cOxOFEGXxe+Zo
 Gm2top9Nr/Sr9yEQYk9dZa9JoH+xrkU0ISakfLuj7V+Wabft59ENb9p2B0C1s1q2XwdS8TIDC
 Y8Y15HpdzSY8rDsZu2yl/YwSXg3dIpP++gU0komYm7+uEtcCiUFJciVpE4uTYvkHEkw403014
 zJdGtdfW/0OXe2KfWPzKWiPmPDGCYbAQ78KLlICRdypvJgUSPDw5EfDKu4c0Yg3+EDW4JU7ld
 pVxriMJq3gMva6bDnouAIkO+nWiCLDCGeDPHHMRvaWMRix5ix45eKnUyHv9N1pVx6Js4qV1io
 cTPj7vl0qyij2rbHT2FYlLwnMtXkWzAFEj8zIiQrKhx9yIOEA/QqdQjNMgOkeImXttTz6qvvp
 Rv/trO7M7BraDINQ0CjuK9lnK0+KwCIJhuHVQWIyLSonlU3IHL3vrNe9vJTSoAU6u1ULUAI2N
 Jc9+lNlPRcXnovEuxDCBUKWVic9zn9pZu0OCn4C8JzUR4dWAkY5B+If/rIh58Kh6M4QGMhmFq
 mOp24Hyhd1C0bcNlHU9VDZl5/mt9gDCW18zn9tnSlWTTk8dFrrQbT+RJFg9gEVc0PpZeJ8+0g
 PWU6OLBuSJ7HThTgL93MGqbZ+NpucXqiXTlKv1aMgUOpYK6gryHuzgSImOuk20v5CHL/eMlPg
 VoSVB0ApOfp143nrrZzk8BtQ==



=E5=9C=A8 2024/9/27 20:06, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, Sep 27, 2024 at 11:34=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/9/27 19:55, fdmanana@kernel.org =E5=86=99=E9=81=93:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> During an incremental send we may end up sending an invalid clone
>>> operation, for the last extent of a file which ends at an unaligned of=
fset
>>> that matches the final i_size of the file in the send snapshot, in cas=
e
>>> the file had its initial size (the size in the parent snapshot) decrea=
sed
>>> in the send snapshot. In this case the destination will fail to apply =
the
>>> clone operation because its end offset is not sector size aligned and =
it
>>> ends before the current size of the file.
>>>
>>> Sending the truncate operation always happens when we finish processin=
g an
>>> inode, after we process all its extents (and xattrs, names, etc). So f=
ix
>>> this by ensuring the file has the correct size before we send a clone
>>> operation for an unaligned extent that ends at the final i_size of the=
 file.
>>>
>>> The following test reproduces the issue:
>>>
>>>     $ cat test.sh
>>>     #!/bin/bash
>>>
>>>     DEV=3D/dev/sdi
>>>     MNT=3D/mnt/sdi
>>>
>>>     mkfs.btrfs -f $DEV
>>>     mount $DEV $MNT
>>>
>>>     # Create a file with a size of 256K + 5 bytes, having two extents,=
 one
>>>     # with a size of 128K and another one with a size of 128K + 5 byte=
s.
>>>     last_ext_size=3D$((128 * 1024 + 5))
>>>     xfs_io -f -d -c "pwrite -S 0xab -b 128K 0 128K" \
>>>            -c "pwrite -S 0xcd -b $last_ext_size 128K $last_ext_size" \
>>>            $MNT/foo
>>>
>>>     # Another file which we will later clone foo into, but initially w=
ith
>>>     # a larger size than foo.
>>>     xfs_io -f -c "pwrite -S 0xef 0 1M" $MNT/bar
>>>
>>>     btrfs subvolume snapshot -r $MNT/ $MNT/snap1
>>>
>>>     # Now resize bar and clone foo into it.
>>>     xfs_io -c "truncate 0" \
>>>            -c "reflink $MNT/foo" $MNT/bar
>>>
>>>     btrfs subvolume snapshot -r $MNT/ $MNT/snap2
>>>
>>>     rm -f /tmp/send-full /tmp/send-inc
>>>     btrfs send -f /tmp/send-full $MNT/snap1
>>>     btrfs send -p $MNT/snap1 -f /tmp/send-inc $MNT/snap2
>>>
>>>     umount $MNT
>>>     mkfs.btrfs -f $DEV
>>>     mount $DEV $MNT
>>>
>>>     btrfs receive -f /tmp/send-full $MNT
>>>     btrfs receive -f /tmp/send-inc $MNT
>>>
>>>     umount $MNT
>>>
>>> Running it before this patch:
>>>
>>>     $ ./test.sh
>>>     (...)
>>>     At subvol snap1
>>>     At snapshot snap2
>>>     ERROR: failed to clone extents to bar: Invalid argument
>>>
>>> A test case for fstests will be sent soon.
>>>
>>> Reported-by: Ben Millwood <thebenmachine@gmail.com>
>>> Link: https://lore.kernel.org/linux-btrfs/CAJhrHS2z+WViO2h=3DojYvBPDLs=
ATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com/
>>> Fixes: 46a6e10a1ab1 ("btrfs: send: allow cloning non-aligned extent if=
 it ends at i_size")
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Just a small nitpick inlined below.
>>> ---
>>>    fs/btrfs/send.c | 19 ++++++++++++++++++-
>>>    1 file changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>>> index 5871ca845b0e..3ee27840a95a 100644
>>> --- a/fs/btrfs/send.c
>>> +++ b/fs/btrfs/send.c
>>> @@ -6189,8 +6189,25 @@ static int send_write_or_clone(struct send_ctx =
*sctx,
>>>        if (ret < 0)
>>>                return ret;
>>>
>>> -     if (clone_root->offset + num_bytes =3D=3D info.size)
>>> +     if (clone_root->offset + num_bytes =3D=3D info.size) {
>>> +             /*
>>> +              * The final size of our file matches the end offset, bu=
t it may
>>> +              * be that its current size is larger, so we have to tru=
ncate it
>>> +              * to that size (or to the start offset of the extent) o=
therwise
>>> +              * the clone operation is invalid because it's unaligned=
 and it
>>> +              * ends before the current EOF.
>>> +              * We do this truncate when we finish processing the ino=
de, but
>>> +              * it's too late by then, so we must do it now.
>>> +              */
>>> +             if (sctx->parent_root !=3D NULL) {
>>> +                     ret =3D send_truncate(sctx, sctx->cur_ino,
>>> +                                         sctx->cur_inode_gen,
>>> +                                         sctx->cur_inode_size);
>>
>> I know this is a little overkilled, but can we just truncate the inode
>> size to round_down(cur_inode_size, secotrsize)?
>>
>> As the truncate will still dirty the last sector, and later clone() wil=
l
>> writeback the range covering the last sector, causing unnecessary IO fo=
r
>> the sector we are going to drop immediately.
>
> For that it's more logical to truncate to the start offset which is
> always aligned.

Right, that's more reasonable.

Thanks for the fix.
Qu

> I'll do that.
>
> Thanks.
>
>>
>> Thanks,
>> Qu
>>
>>> +                     if (ret < 0)
>>> +                             return ret;
>>> +             }
>>>                goto clone_data;
>>> +     }
>>>
>>>    write_data:
>>>        ret =3D send_extent_data(sctx, path, offset, num_bytes);
>>
>


