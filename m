Return-Path: <linux-btrfs+bounces-6930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65728943901
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 00:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D27B2583C
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 22:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296FA16D4DE;
	Wed, 31 Jul 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="U2/opMSL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65B35280
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722465030; cv=none; b=clx+F3I0DFFC7fyMuvdoZn9yojCJcrGqYtl9ylH986f+5q1Vu8MeM97BURyHrW0ZDur40s94p4kRvu7gtVZkYbhBnZAHuRNsL6iQxJDeAOCn+7Dsu9l2d9AV6chC/i67cTRItw2Q6NrTtVpx8eYFjyNfrDw/FXSY8XsJxkeBYDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722465030; c=relaxed/simple;
	bh=duWDHwJJ2O+/sjPGdA72MsBaPfNbNsGn4OL7S7Krk3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nocSyudU5tPnZAHWmPk3bwLuDRScZiwn+tI/+0LzJB9Ka6jmbUeypL8rv906kffI0lQNbwzg56j+ND8wMlL19OflM3TNPZnnCzrhL70EpRQSUoy4Z2UPNs2MjHIaMpdmLYnp5iV96Bl2RX8phSYSdTpovvoywyirx+Kc8O/aOK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=U2/opMSL; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722465020; x=1723069820; i=quwenruo.btrfs@gmx.com;
	bh=DFez3fCMxi+YLidgZDZOEFu24IkA3rea0LajslCKs7Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U2/opMSL7G6xY66UMKza2EnLMO+IJH0i4tJ2POSZ8JegCkDjA9cD0/wSOBCEJgoS
	 AsRMpXfw+rJg4y2nvFdrjtp7W19IUTXAMAgbRQuXAVPYXif5Tut7tchqElJL1Z/Ie
	 suCfrq1Z2le6syC3fqURUyB1gTEo8Rax4bh+N+dHOwuhB+drkc0/C3vqZmc8RTqFt
	 +2jhZ6ExSVOY2QA+6LvBZliMBOH/kuonkPKTr7gbCqK0cf3vmYx0SW96ZVxW6gg9d
	 XaQNzR9ZCGxkygUauq32072QldcfPMFAZ4jy9Bss7KS+mWoJ4fIBwl3CjDEGMfAo7
	 v572TQyWSgZB+nq0uA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxUs7-1sK4IP1HAn-015hmj; Thu, 01
 Aug 2024 00:30:20 +0200
Message-ID: <4c8f9a60-cbaa-4475-b584-b647aaa71155@gmx.com>
Date: Thu, 1 Aug 2024 08:00:16 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: add --subvol option to mkfs.btrfs
To: Josef Bacik <josef@toxicpanda.com>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20240730093833.1169945-1-maharmstone@fb.com>
 <d67ca8a6-9b5f-4ba1-aae3-70e1cb22ecda@gmx.com>
 <20240731134549.GA3908975@perftesting>
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
In-Reply-To: <20240731134549.GA3908975@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tvaPYJQl4zVio7R41PqInSEZmLxVROK62tNtzaZs8fFPVUvTPKR
 +8xmcgPpBqlgfZTArusTgvw5KPFA0OKc8Ye8xg67I3A65Xg1/iJgV3kC5lHNvcG8oipnP2V
 IaoOmVpCz1snOUIFV6xMVfX86KFZ+EppQ7cbFD4bOxecwlcWSoAo/MzjdbvNKUfH8TBiv0Z
 fHllq5FrJxSatL2e6SK3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w1RakRyb6Pk=;mzD1ru7oIZlzGfBaJ7JyTAhA+QT
 Blg16pApiEVbbKuMe5gfujjxF0Wc2BSKAb7CeTRBGwqMMzAAWrxYm5EHskxQLLc6ic3YULa80
 kasRfGh2yNuZO0Mj0Wy9sXGp0WMp3nlUIDJW+WAWDL23pO9U6IWnc4lFBhgJ2iUivvFMm4o0g
 TVEyRC5trEZEJsytSDnO8qfedYW75VVQUrdwgbI+3SSq383NZP695/z9u/3VqtBi0pE+vwopt
 liApItOXNVpspz7ytV30eoJxJOxdgoWaRurumzzEklpt0kURJvskVwpF5bQ/YehlLQhNQMpcF
 SBXLHr4hvm0n1gnBT2+u/7LD7frDpbB/T9SazDUdCUO9a9TSX7CtHHS8gRAQ8Vm1n1IwHlRyz
 t8gnwcKw2EZRhaCQuh6wZ5gHHTNtYx50FTOeFVonB//RoMp+zHAlP/g1rTiKRlzQ6DPzPeKBT
 r+v12VjO2NIFQA6ggAXep5Yya8ExSW/zL6rggh7mY7W5Jau8r4RPZlMu5LSRt31Kub4YyMcJd
 pBiQd7ua+c69+mdtgILJgGGPdcUnQfjx6O0F393NeHVsMNnZJqSdXUxDoEtu/K72YrknS4vYB
 cMwiqWM/7XDPdpCrl5NFrfZPiS9iC/0P0gl9fuQK2Ww6umx+7igZtdgB0dqJmVHH2AIbMoF6M
 AUNyyoBd5t9pvxC3UhZm/RruAPpkJwcH6jAPDEVsdr7c1E2JxX1ZujiZY+H64zEzg+auLQ8fi
 4W+5d/uNl8WO1/ij4D/Q6KKBVal/+RQRfDuaJ7+FBl3gpo10yl4VMQxxXYWf95xTkQosdiMNL
 mSarXR3k7MnIIeYAoLbsHvW6cQiiPuIkeGN2htffLX9ck=



=E5=9C=A8 2024/7/31 23:15, Josef Bacik =E5=86=99=E9=81=93:
> On Tue, Jul 30, 2024 at 07:25:29PM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/7/30 19:08, Mark Harmstone =E5=86=99=E9=81=93:
>>> This patch adds a --subvol option, which tells mkfs.btrfs to create th=
e
>>> specified directories as subvolumes.
>>>
>>> Given a populated directory img, the command
>>>
>>> $ mkfs.btrfs --rootdir img --subvol img/usr --subvol img/home --subvol=
 img/home/username /dev/loop0
>>>
>>> will create subvolumes usr and home within the FS root, and subvolume
>>> username within the home subvolume. It will fail if any of the
>>> directories do not yet exist.
>>>
>>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>>
>> Unfortunately I'm still not a fan of splitting the handling of subvolum=
e
>> and directory creation.
>>
>> Why not go a hashmap to save all the subvolume paths, and check if a
>> directory should be a subvolume, then go btrfs_make_subvolume() and
>> btrfs_link_subvolume() inside that context?
>>
>
> We don't have a hashmap readily available, and btrfs_make_subvolume() ha=
s to be
> done before we rebuild the UUID tree, otherwise we won't get the UUID en=
tries.
> You're asking for a good deal of work ontop of an already relatively lar=
ge
> patch.
>

For initial version we do not need hashmap, but just simple string array.
Yes, that will be a little slower but should not be a big deal.

> <snip>
>
>>> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
>>> index 2b39f6bb..e3e576b2 100644
>>> --- a/mkfs/rootdir.c
>>> +++ b/mkfs/rootdir.c
>>> @@ -184,17 +184,58 @@ static void free_namelist(struct dirent **files,=
 int count)
>>>    	free(files);
>>>    }
>>>
>>> -static u64 calculate_dir_inode_size(const char *dirname)
>>> +static u64 calculate_dir_inode_size(const char *src_dir,
>>> +				    struct list_head *subvol_children,
>>> +				    const char *dest_dir)
>>
>> And before the --subvolume option, I'm more intesrested in getting rid
>> of the function completely.
>>
>> Instead, if we go something like the following, there will be no need t=
o
>> calculate the dir inode size:
>>
>> - Create a new inode/subvolume
>> - Link the new inode to the parent inode
>>
>> As btrfs_link_inode()/btrfs_link_subvolume() would handle the increase
>> of inode size.
>>
>> As long as we're only using btrfs_link_inode() and
>> btrfs_link_subvolume(), then there is no need to go this function.
>>
>> Furthermore it would make the whole opeartion more like a regular copy
>> (although implemented in progs), other than some specific btrfs hacks
>> just to pass the pretty strict "btrfs check".
>
> This is legitimate follow up work, but this thing exists today.  We have=
 a long
> standing policy that gating peoples work on cleanups and refactors is ge=
nerally
> unhelpful and demoralizing behavior.  I agree this needs to be reworked,=
 but
> that's out of scope for this particular patchset.
>
> That being said this will be the next thing that Mark tackles.  Is that
> acceptable?  Thanks,

Well, I have already done the cleanup, furthermore the cleanup would
make new subvolume creation much easier:

https://lore.kernel.org/linux-btrfs/667ee4f02fdc2cb6f186eb8b06dd089f3ce531=
41.1722418505.git.wqu@suse.com/T/#u

Furthermore, with all the new rework, I believe the patch itself can be
much smaller than the current one, since we get rid of all the complex
hacks.

Thanks,
Qu
>
> Josef
>

