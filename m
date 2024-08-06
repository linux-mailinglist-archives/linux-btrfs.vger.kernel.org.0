Return-Path: <linux-btrfs+bounces-7011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7000E949A88
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 23:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F361F236DE
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 21:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E27216F27E;
	Tue,  6 Aug 2024 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ppltINGG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249D616D33D
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981321; cv=none; b=oJOPLr3MjxRL8vNClJD/DjvE0s6GIplYyhy4aUMfpZXIeBg0Z3JQENGySdr4R85CQdOlQl3jSzPHNssoRU0kRXOu0PqDjIQ02SAZnjUw3uXT67Yee1pG/kb6oPdHh+zj016c6uiuoXyIgANsnTF/zEJktb9v1ePDC3alfnGEr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981321; c=relaxed/simple;
	bh=DI+7Na59YAq3uRMTxWVQR9hDcSI2KracsMaOXYs9wkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZSFFxyzr2x0xYRyK+aIsAQMElPLmmAqjAZ4lLIPM/F/qaiNPfcY0JQ1va79xVwsRmTyqbAH7UHkt+/yuaWr4BPmM0jltQW7DqUo8yyBWGbmTU6lubHFEHhkxksElH24ard7Kz4jMFPwn+QWTGNqt+l+vsUcITUttjH3Mjy5Sxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ppltINGG; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722981316; x=1723586116; i=quwenruo.btrfs@gmx.com;
	bh=DI+7Na59YAq3uRMTxWVQR9hDcSI2KracsMaOXYs9wkc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ppltINGG8udHc6oFnFmQACPC8+1XFjoQjrS6JrV3n4uX3YCeS04N648Vt9oBw2UQ
	 mlKPsKM8+RLrE3GkYPYcs2pAUdFHdbIIcrXPAkW09X4ftSH0RydRVhpKRdKKQmTPR
	 6RauZpZdhliWZABwDCTu5HkFxrkIdtx56evO5zy61omsNhyTN3VcamSa5AvjCEmmm
	 zdw6REYqWnlspjgYKuv4iXEA0xoUBcIh53qKvRtQzEQXIfVrpqBz7BV79RqiruKve
	 bR0MNzeY0sIZpRq8EQCWxMvVY9DBqYe6dA8pCRqgC0XHOVACuZkOq9BVS1u2biKah
	 p9w2OyxJRHmolzSLOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpDNf-1rrx8N0xih-00cNwg; Tue, 06
 Aug 2024 23:55:16 +0200
Message-ID: <716c3de3-63be-420e-b11e-cfd3eab9aea9@gmx.com>
Date: Wed, 7 Aug 2024 07:25:13 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs corruption issue on Pine64 PinePhone
To: ellie <el@horse64.org>, linux-btrfs@vger.kernel.org
References: <9b4f0e79-6e77-48a4-b87d-b27454ffb399@horse64.org>
 <b9103729-c51a-487f-8360-e49d3e9fc5e4@horse64.org>
 <e53fdb4e-bbb2-4777-b822-f1173dfed3db@gmx.com>
 <7d692229-d3d5-4b82-a70a-b7371c8724f0@horse64.org>
 <1e96ef22-b51d-488a-ab90-84fd85c981ea@gmx.com>
 <ad8a9333-8732-4d78-a86b-22dea00aabbe@horse64.org>
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
In-Reply-To: <ad8a9333-8732-4d78-a86b-22dea00aabbe@horse64.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vudeeTCu6KWh34/mFvDMyRUL+fjJI0QIkkK/87Q01Gz1OchAqdf
 6oG6CIZSyslQgbrIFyfDkwpF6ZkM4pwfZwQSexUIi+fs/kanogW+JHYD1sqoawnEoMD1k7b
 0nLsXt7qU1O81HrWmiCdk2/fMcM/FBjIFQHXyAxpi3GKkNjyo5L6bHRMq4xXBU9gxkRtwgz
 cimDPrjmINyGXOdcbzrNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DHcFK5S2w4I=;ydQC1UICmZeZ8qvuduQPG5/7RVv
 XFOszLfysiUtthoXLdDuIRqpmaJk1UExfJCQ336Ycgb67OV3mMW6z4LgWklI0HEhW9JRZnfxr
 ng8E2Yq1HzGQUCz4sNiLTnH4J0jn4zrH7CNcF3QcjBbi0/haqET85vIpcBlS+8Hu+JMatrNKM
 yE5yWVcSpMIw+kbxQE0m05mtMq1tZYtfmxwCuJdemYD2PRNqRQbtn+r3cIzAyVcV/zp5Knuye
 NnsDxw+ck2d9aBH3xvCuVXqS4JlgGYYzoeznQq24Uh2jQPDfLvuR9t6tDz4GPfgxQLEFWXlLa
 XA+mscZhigzWDaOL/bdTFkaLgGODMQRXCqfXnGVVxRJxAfGRezyI96sEPYvdsyVp2bgVkgvjJ
 11dij+UwohmRVtyHHDtDGSl5XDD/2PSUo81OgUx33j8bJ/X+QTiAHiI9yn+xydGpCv519ac+L
 VDwanELKlRVBqzwzn3J+w4btjnreinp7WSFKzRmekl8RqSsKlTL4WuBl540xNBRtaCjkDuLtt
 PTMItoTSKIc1dnN46UMfPksdc9xoJfAljWUyTHOdwkdoT+22E9blFYfs1BA9ymjIqtcTVbZZx
 zYmE0f0JQvJappYrQ0Lx0qAASy2GOQmTNpQQM3WsUTc+lvtdmwDquEBFDTbrR0IhM85qLikPr
 pV8AJyOb3VnAqqwezTWOzIvggPKQTsS0qVeRkkOO4xZMC2GQp6oxM+BV9YslQypk+LbIUi1PE
 L/qrioy4Oa/3l9/qYEudTCex40PWzUNXyHEWDHMR9Czhk1PgxJSFa0tX/Uj+OaJd61tGslj+X
 fY1wUMD3E8yDPQZu1casvs1pFIpZa0joWYOqFjPkzEaqk=



=E5=9C=A8 2024/8/7 01:32, ellie =E5=86=99=E9=81=93:
>
>
> On 8/5/24 08:34, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/8/5 15:50, ellie =E5=86=99=E9=81=93:
>>>
>>>
>>> On 8/5/24 08:10, Qu Wenruo wrote:
>>>>
>>>>
>>>> =E5=9C=A8 2024/8/5 15:25, ellie =E5=86=99=E9=81=93:
>>>>> On 8/5/24 07:39, ellie wrote:
>>>>>> Dear kernel list,
>>>>>>
>>>>>> I'm hoping this is the right place to sent this. But there seems
>>>>>> to be
>>>>>> a btrfs corruption issue on the Pine64 PinePhone:
>>>>>>
>>>>>> https://gitlab.com/postmarketOS/pmaports/-/issues/3058
>>>>>>
>>>>>> The kernel is 6.9.10, I wouldn't know what exact additional patches
>>>>>> may be used by postmarketOS (which is based on Alpine). The device =
is
>>>>>> the PinePhone revision 1.2a or newer https://wiki.pine64.org/wiki/
>>>>>> PinePhone#Hardware_revisions sadly there doesn't seem to be a way t=
o
>>>>>> check in software if it's 1.2a or 1.2b, and I don't remember which
>>>>>> it is.
>>>>>>
>>>>>> This is on an SD Card, so an inherently rather unreliable storage
>>>>>> medium. However, I tried two cards from what I believe to be two
>>>>>> different vendors, Lexar and SanDisk, and I'm seeing this with both=
.
>>>>>>
>>>>>> The PinePhone had various chipset instability issues before, like
>>>>>> https://gitlab.com/postmarketOS/pmaports/-/issues/805 which I belie=
ve
>>>>>> has however been fixed since. I have no idea if that's relevant, I'=
m
>>>>>> just pointing it out. I also don't know if other filesystems, like
>>>>>> ext4 that I used before, might have also had corruption and just
>>>>>> didn't detect it. Not that I ever noticed anything, but I'm not
>>>>>> sure I
>>>>>> necessarily ever would have.
>>>>
>>>> In the detailed report in pmOS issue, you mentioned it's a video file=
.
>>>>
>>>> I'm wondering if all the corruptions you see are from video files,
>>>> especially if the video files are all recorded on the file.
>>>>
>>>> If that's the case, it may be related to the IO pattern, especially i=
f
>>>> the recording tool is using direct IO and didn't have proper writebac=
k
>>>> wait for those direct IO.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>
>>> Thanks so much for the quick input!
>>>
>>> All the files I mentioned in bug reports were written by syncthing, so
>>> there wasn't any on-device video recording involved. I once saw Nheko'=
s
>>> database file corrupt however, so it's apparently not limited to
>>> syncthing. I'm guessing video files are affected so often simply due t=
o
>>> their large size.
>>
>> I did a quick clone and search of syncthing.
>>
>> There is no usage of O_DIRECT directly, so I guess it's not the known
>> csum mismatch caused by bad sync of direct IO writeback.
>>
>> In that case, since the corrupted file is syncthing synchronized, can
>> you do a diff of the binary data?
>>
>> To avoid the EIO from btrfs, you can use "-o rescue=3Dall,ro" to mount =
the
>> sdcard on another system, then compare the binary.
>> (e.g. "xxd file.good > good.xxd; xxd file.bad > bad.xxd; diff *.xxd")
>>
>> At this stage, we need to find out what's really causing the problem,
>> the btrfs itself or some thing lower level.
>> (I strongly hope it's not btrfs, but either way it's not going to end u=
p
>> well)
>>
>> Thanks,
>> Qu
> Thanks for your detailed instructions! I was about to do as you said and
> ran the sync for a few hours, stopped it, and planned to run btrfs scrub
> this evening. However, I then ran into a hard shutdown due to what might
> be an upower bug (won't lie, was very annoyed at that point):
>
> https://gitlab.com/postmarketOS/pmaports/-/issues/3073
>
> Should I still attach a diff for an affected file I find now? Or are the
> results going to be worthless if there was a hard shutdown in between,
> and I need to first fix the filesystem, repeat the sync test, and repeat
> finding a new corruption error to diff?

As long as you didn't touch those files, and scrub still reports errors
on that file, the diff is still very helpful to provide some clue.

Thanks,
Qu

>
> Regards,
>
> Ellie
>
>

