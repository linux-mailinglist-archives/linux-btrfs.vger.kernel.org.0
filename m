Return-Path: <linux-btrfs+bounces-8344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CEF98AF59
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 23:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABEB1C20B50
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 21:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5F18661C;
	Mon, 30 Sep 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mJy+5j6T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CE2185B6C
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732540; cv=none; b=c3gS/5EHtDTgWCyLXWT20Hm/fD9pG1G8XNHztJP/MnypPibe552Hj0X7V8fTtuCPI8u8MfLQ3qYGnF381mhqgVfbOMwhyAh1V7EDzxiWXHSApCnxshh9R+6lHDdaoYEkjqqDoryj1etfmNHDiOLDcJApUzQrj7kt4BvdVEaVF1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732540; c=relaxed/simple;
	bh=M6og70XBEwR8lk+gq4exZnmBSvFpV35uJP9fBtuTOzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPHBgOiGoSlgQDsojSKxbNiaLZwrI4fy4oUMEP1ftKC6bp/VhcaCSeiYLZ6by59Rgvr1vFOy7F7YCXxy+ilfHLk/Fwtp6+685boQ3pZRr1TPXwctyfqXDZelILcWO5B/8fltlLUosc2a3fZrMxb7wEa8NXRm5M6nbfKL1Ym4ml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mJy+5j6T; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727732530; x=1728337330; i=quwenruo.btrfs@gmx.com;
	bh=M6og70XBEwR8lk+gq4exZnmBSvFpV35uJP9fBtuTOzU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mJy+5j6TNBCzeg4FyX1qC8BHizSvo5wBvIymorl3nWVVjcw20b+T6eeTOTsCgz4E
	 HcnNUS93KGa63fLXYiCJhY4xCH61/8Nt9Av89zfB8w43SNAWoUOVghz90gsqiUiqI
	 lFSDDnAO/baEApC5lNf6xIJf3J+HH84M9jtMqb7uhOYTKtFdICuEAgukDB2sOPfWO
	 j7r3ErfIXtdGBBOxhtfLBWLEtVnxeR7DYuD1lrNzJ3U+EAiib6gnBYI6X0iS/aM3V
	 lsHHVm2sJbr8RIrgpoZ0Wl1lEhhyxOd/w7xtXa2vLqBYna5JM3LuNy4po+JOuboyA
	 ThgBVQBDZ422TXsBWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLR1f-1sd1xS3JGl-00MG9t; Mon, 30
 Sep 2024 23:42:10 +0200
Message-ID: <ac327e16-3002-4d6b-b073-27be759cf608@gmx.com>
Date: Tue, 1 Oct 2024 07:12:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: canonicalize the device path before adding
 it
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
Cc: Fabian Vogt <fvogt@suse.com>
References: <cover.1727222308.git.wqu@suse.com>
 <3b0eb4cd4b55ae567abfc849935b4a72cea88efb.1727222308.git.wqu@suse.com>
 <af8014ff-d4c2-4f43-8602-49d11d4977fa@oracle.com>
 <97e23756-2740-45ea-a1d6-7cf95a115e8b@suse.com>
 <d9f1189d-b51d-4b0b-a3c8-cc7141fa9584@oracle.com>
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
In-Reply-To: <d9f1189d-b51d-4b0b-a3c8-cc7141fa9584@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rMQs7Ooc95J0TRebF1maDKKwB8yLQ94zmykvXg7d6JcK1INKtV9
 wW3ukTWqJZJEI5D2GnWV+FtXEf9xC0iYm79ZMki4spPF0M9HUv/hGK2NDTDEuvasSc7Qbu/
 pbuV7h+6k8VSg7SP2SG7tiyG/ngoKyBzbZlX3s4Qt9F88Rqzn0ou1YYcO+9OWtRr4vcOIoX
 cBUaZYzbpPOadk+/FmO/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8xDq1O8gAFM=;oJNtDqknMBl7Y4jHMtFH54DVO2e
 tU4votXZc88usMNq8zJ28KqDJVarxu2tT2OSo6NCB7di0ZSjTfdoTppvZ9FvwJpjJYfvszfpd
 zK5Kri14c/4ruz+B5nA8CQtyFRQPvL+k0QMjFclhSkTl3dMOClGiCacCQcXKK2B0h4Fmu8Abp
 Yb9S5KhBB/OlrMeJ4HGKIWWbrTDqSbA6CBTFxIe6PuUGwYgCWnfnXhHeaOWPwwZZEx4MxMepw
 PMAKMTs8g0rkhvny8LKBizJRnjeMDwrmulyqkq3xWl6kzBS95kYzRjg5Jzy/5knoOVlBrhnzp
 Q1XcKE2L+ej09mCOyBjEvDpPAHMYhfKVUENEusF479ee1vTCZXTx/JAfDec5uQyRw0D5r37M3
 UINKKUlH6oKOTGVIlh/Yvw05NvAHH7t60nWtDwYTOosFrMtp9tXWrwhMt120abVoUsD+Bx+ct
 KhrUsbYMND+w2wJxnpiva12Ru/hBL3dIKS+nXQ9BpERJR6XcUsOYC8cmjRor8yEqmpqny6uMu
 RtvQ6vOy1+fOjGRWW7PM5ZDuaXIeBmxEXb7D3DBOKpcgCswfsKZJSxdfxIV6Pa7uvySDRrT9g
 xk9yjbJYrwQ/PdjKYeOTK/wQv6HZje882ClGN5Uk4OBWEJYVw7RVR6Be9r9pC34A8qeOe7xb6
 jGVhYuui4EpS7typqPsmdLeEE3lSGq62ZSvybVD9ePnV3m6Xqi6P1a9FWiPhCpqIP/ETycSMV
 khtF2YAaHlLiCnvg5onjTyofIbJV/aEYnJmLIanBrDIgAUAGnGb0wUlLkpBGKu7l0sM7wXFeZ
 d9wlVqR5mBAomOF0cgFwd87w==



=E5=9C=A8 2024/9/30 22:10, Anand Jain =E5=86=99=E9=81=93:
[...]
>>> Quick question: both XFS and ext4 fail this test case=E2=80=94any idea=
 why?
>>
>> Because they are single device filesystems (except the log device),
>> thus they do not need to nor are able to update their device path
>> halfway.
>>
>
> How is a single or multi-device filesystem relevant here?

Since it's a single device fs, they won't bother about device scanning
nor updating their device path to handle re-occuring device.

Thus they just accept whatever path passed in.

Thanks,
Qu
>
>>> Can a generic/btrfs specific testcase be added to fstests?
>>
>> I can add it as a btrfs specific one, but I guess not a generic one?
>>
>
> Yes, you can make it a Btrfs-specific test case, as XFS and EXT4
> currently fail on this test.
>
> Thanks, Anand
>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks, Anand
>>>
>>>> Then we can have the following weird device path:
>>>>
>>>> =C2=A0 BTRFS: device fsid 2378be81-fe12-46d2-a9e8-68cf08dd98d5 devid =
1
>>>> transid 7 /proc/self/fd/3 (253:2) scanned by mount_by_fd (18440)
>>>>
>>>> Normally it's not a big deal, and later udev can trigger a device pat=
h
>>>> rename. But if udev didn't trigger, the device path "/proc/self/fd/3"
>>>> will show up in mtab.
>>>>
>>>> [CAUSE]
>>>> For filename "/proc/self/fd/3", it means the opened file descriptor 3=
.
>>>> In above case, it's exactly the device we want to open, aka points to
>>>> "/dev/test/scratch1" which is another softlink pointing to "/dev/dm-2=
".
>>>>
>>>> Inside kernel we solve the mount source using LOOKUP_FOLLOW, which
>>>> follows the symbolic link and grab the proper block device.
>>>>
>>>> But inside btrfs we also save the filename into btrfs_device::name, a=
nd
>>>> utilize that member to report our mount source, which leads to the
>>>> above
>>>> situation.
>>>>
>>>> [FIX]
>>>> Instead of unconditionally trust the path, check if the original file
>>>> (not following the symbolic link) is inside "/dev/", if not, then
>>>> manually lookup the path to its final destination, and use that as ou=
r
>>>> device path.
>>>>
>>>> This allows us to still use symbolic links, like
>>>> "/dev/mapper/test-scratch" from LVM2, which is required for fstests
>>>> runs
>>>> with LVM2 setup.
>>>>
>>>> And for really weird names, like the above case, we solve it to
>>>> "/dev/dm-2" instead.
>>>>
>>>> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1230641
>>>> Reported-by: Fabian Vogt <fvogt@suse.com>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> =C2=A0 fs/btrfs/volumes.c | 79 ++++++++++++++++++++++++++++++++++++++=
++++
>>>> +++-
>>>> =C2=A0 1 file changed, 78 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index b713e4ebb362..668138451f7c 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -732,6 +732,70 @@ const u8 *btrfs_sb_fsid_ptr(const struct
>>>> btrfs_super_block *sb)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return has_metadata_uuid ? sb->metadat=
a_uuid : sb->fsid;
>>>> =C2=A0 }
>>>> +/*
>>>> + * We can have very weird soft links passed in.
>>>> + * One example is "/proc/self/fd/<fd>", which can be a soft link to
>>>> + * a block device.
>>>> + *
>>>> + * But it's never a good idea to use those weird names.
>>>> + * Here we check if the path (not following symlinks) is a good one
>>>> inside
>>>> + * "/dev/".
>>>> + */
>>>> +static bool is_good_dev_path(const char *dev_path)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct path path =3D { .mnt =3D NULL, .dentry =3D=
 NULL };
>>>> +=C2=A0=C2=A0=C2=A0 char *path_buf =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0 char *resolved_path;
>>>> +=C2=A0=C2=A0=C2=A0 bool is_good =3D false;
>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 path_buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
>>>> +=C2=A0=C2=A0=C2=A0 if (!path_buf)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Do not follow soft link, just check if th=
e original path is
>>>> inside
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * "/dev/".
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D kern_path(dev_path, 0, &path);
>>>> +=C2=A0=C2=A0=C2=A0 if (ret)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>> +=C2=A0=C2=A0=C2=A0 resolved_path =3D d_path(&path, path_buf, PATH_MA=
X);
>>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(resolved_path))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>> +=C2=A0=C2=A0=C2=A0 if (strncmp(resolved_path, "/dev/", strlen("/dev/=
")))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>> +=C2=A0=C2=A0=C2=A0 is_good =3D true;
>>>> +out:
>>>> +=C2=A0=C2=A0=C2=A0 kfree(path_buf);
>>>> +=C2=A0=C2=A0=C2=A0 path_put(&path);
>>>> +=C2=A0=C2=A0=C2=A0 return is_good;
>>>> +}
>>>> +
>>>> +static int get_canonical_dev_path(const char *dev_path, char
>>>> *canonical)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct path path =3D { .mnt =3D NULL, .dentry =3D=
 NULL };
>>>> +=C2=A0=C2=A0=C2=A0 char *path_buf =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0 char *resolved_path;
>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 path_buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
>>>> +=C2=A0=C2=A0=C2=A0 if (!path_buf) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D kern_path(dev_path, LOOKUP_FOLLOW, &path)=
;
>>>> +=C2=A0=C2=A0=C2=A0 if (ret)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>> +=C2=A0=C2=A0=C2=A0 resolved_path =3D d_path(&path, path_buf, PATH_MA=
X);
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D strscpy(canonical, resolved_path, PATH_MA=
X);
>>>> +out:
>>>> +=C2=A0=C2=A0=C2=A0 kfree(path_buf);
>>>> +=C2=A0=C2=A0=C2=A0 path_put(&path);
>>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>>> +}
>>>> +
>>>> =C2=A0 static bool is_same_device(struct btrfs_device *device, const =
char
>>>> *new_path)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct path old =3D { .mnt =3D NULL, .=
dentry =3D NULL };
>>>> @@ -1408,12 +1472,23 @@ struct btrfs_device
>>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool new_device_added =3D false;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_device *device =3D NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file *bdev_file;
>>>> +=C2=A0=C2=A0=C2=A0 char *canonical_path =3D NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 bytenr;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_t devt;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lockdep_assert_held(&uuid_mutex);
>>>> +=C2=A0=C2=A0=C2=A0 if (!is_good_dev_path(path)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 canonical_path =3D kmallo=
c(PATH_MAX, GFP_KERNEL);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (canonical_path) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
et =3D get_canonical_dev_path(path, canonical_path);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (ret < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 kfree(canonical_path);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 canonical_path =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Avoid an exclusive open here, =
as the systemd-udev may
>>>> initiate the
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * device scan which may race wit=
h the user's mount or mkfs
>>>> command,
>>>> @@ -1458,7 +1533,8 @@ struct btrfs_device
>>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_disk=
_super;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 device =3D device_list_add(path, disk_super, &new=
_device_added);
>>>> +=C2=A0=C2=A0=C2=A0 device =3D device_list_add(canonical_path ? : pat=
h, disk_super,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &new_device_added);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(device) && new_device_adde=
d)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_free_sta=
le_devices(device->devt, device);
>>>> @@ -1467,6 +1543,7 @@ struct btrfs_device
>>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>> =C2=A0 error_bdev_put:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fput(bdev_file);
>>>> +=C2=A0=C2=A0=C2=A0 kfree(canonical_path);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return device;
>>>> =C2=A0 }
>>>
>>
>
>


