Return-Path: <linux-btrfs+bounces-7091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDB694DF96
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 04:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A89FB21017
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 02:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70137175A6;
	Sun, 11 Aug 2024 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="U9SNEEoi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE35C8E9
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723342916; cv=none; b=Bjb4MAu7yeV31+wnLmkiRjOdKT8qpQP7ZjXe5MCj3Jbrm2r2IiqxnA7v3YHQ1bAvKIs1rIjacnEw2/Jco4gBuT+ZsW77AIN2t2VFoRqiUoxf/fv2W88+EGeYPALZe13g5WAKzY3nZwUXxgAPUSY1OJKLS0iMgJLrI9/7pe0wltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723342916; c=relaxed/simple;
	bh=DiUcwritsVZRS7PdaUsspBhel0T1nBxCGOAFUtb/Fao=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NhRw1K3+50feHkXJnYkkNNvynowbbwANx3dGIQJ7l5rrvdGNJhX7SiHKZkGmnVGWA9GahlNyT7jwcX8DfErdk5bmhY41TBbvqXiWJ6q2J936M/fcYcQhMNJE/zqd27MbK3zduIEa+9v9KCHmKhP2TAPRuNvItdF8SLyWPExj3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=U9SNEEoi; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723342910; x=1723947710; i=quwenruo.btrfs@gmx.com;
	bh=2/g2cabu1SGkyagp/+t+Rvh+lIlVdzWq6rTI8XouISQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U9SNEEoiLpX1WsIGm1icGYLd3TyZW9GTSPIzXMEXL9WgqNEIy771hzzjq41InAfQ
	 D6UrK8YXz6eSDlTA1aCZDeqZlconBvo63pazHJR5Whu6fabOht8776C3abMOaEhvX
	 GOpVYUDM/FRCZuVVNNk36tmkVqH3IkRisOMJ3CK97BXX5WXM1Fu5Kkb7gx6SumWk/
	 Xwnjc3mQqPYa3vt0zwziY6ZQaKEclTFUsTf56mb/BayzrTzeDDQ0NSjOWlFOiR3KQ
	 LUHoR2wxeObFq+h+nPW2lnSaax7gm0bmKQht9mFYjxKY58MGg/EXNi9WjDJjY3t2/
	 hvUqxCCOBXCxj8usGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MA7KU-1sSUsh498s-00Cukt; Sun, 11
 Aug 2024 04:21:50 +0200
Message-ID: <ac2ff9ae-b2fa-49df-9ce3-fc32ddd3c222@gmx.com>
Date: Sun, 11 Aug 2024 11:51:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help! Unmountable due to dev extent overlap
To: Stefan N <stefannnau@gmail.com>, linux-btrfs@vger.kernel.org
References: <CA+W5K0rSO3koYTo=nzxxTm1-Pdu1HYgVxEpgJ=aGc7d=E8mGEg@mail.gmail.com>
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
In-Reply-To: <CA+W5K0rSO3koYTo=nzxxTm1-Pdu1HYgVxEpgJ=aGc7d=E8mGEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DtSHQb1iEjAjqR3qhB8AAPiwCvp5rTnVCFC6Mffq+Sp9A8UO2+F
 2EG9HQLdSAc4ulZ7c9d56eTaXh6GMycdKM7FngqFzXbdPRBv0Xmf5dtcFK3z/PGhd/VIYz+
 tuGdzT5L5O/yK0hji4PVLZxWtCc9LCkXt4rbsSgn8kmF5I3mfk/mO1McCoMg3eFSo+RbMC6
 Whw9g3RvAEjOsjARPh48w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZE0zUQ+pE8Y=;qG/mqmEkJ9modAb6zm+Zf9d3AAp
 cGB0cBfj20IYwxYqMvdFYHl7wHMytYs6sY4Tfpk3gvme//MsW+NdoXy0SlQs8KHsJklnQVxLE
 V2MRLkuHMQKwzQXPNcDCsyeoAnBpQrzZg6l17iaKa7s2zsw1bOgMQePx9EmbTOOge7pZOiEoc
 pagyiAFQtvRQvUp77S+CCVVXHRlZzODfJxKUwFvMTloHoWQ/cspA1C733aQB5Kv+pvTWenqPd
 Jp/ZLZuViFrf0Hr2jRD427lsixgyylV7ee1SwXtXPWB5mI761LAqBihvioNyWg1KP7xvM7IWJ
 M1xc2o3OgP6YRo/mWDNrDGrC+uYbZ3zuxEr3ok0du/hsBo3C905mGjiuiVgNAViynmVuiN0Mq
 wJFhhYJ+wxitixGQjgqSa/UhXpvm/sLjQeUp+CTnoWFZ5C3VTvygBnIzu8Zpjt44VpjUpw305
 DC9Ra3BpRwGsi1j7dxKAM/pmbey9i8IrtZQA37uMDfqBVxtUo8u+Dozyq8ACG6Ac2pblXGkUe
 661FvIrHWfqAMctQM5LUPqg5D2F/IQcpfbInLtFc1oR5KywpatxB/aSn7KvE+m7/Tc36UCd+x
 PkISap4r3jDslDeI8iH2ACVPNavmmqU3AFTKHMa3L4tvA4q3WzGUwXcRwlLmKybJGtNDKM0Z3
 XJEtXh77/eC8JT9kS8QrMRV/Xf9QqxdcN6mnUhfrmMTZDmUmmZzkXyJSeuD9FqRvi8GH09rv/
 VXWDWfHWhawypcCjPZdb0hsbB34VxTPKtFcKpP+ocioNRKoL62e55+NqrGn4Mdtgu+vOpvjXM
 qBDXFODTgBNAx37A3L3zjPIA==



=E5=9C=A8 2024/8/11 10:57, Stefan N =E5=86=99=E9=81=93:
> Hi,
>
> I've got a currently unmountable RAID6 array with no particularly
> obvious trigger that I'm attempting to repair. As it's unmountable
> I've not been able to include btrfs fi usage but it's RAID6 data,
> RAID1c3 metadata, and afaik is not out of space.
>
> Background:
> Having previously scrubbed all disks by devid successfully

Unfortunately scrub doesn't do the full verification of metadata (yet),
a successful scrub can only ensure all the checksums (for both data nad
metadata) matche the content.

> I had a
> complete hardware failure on one disk, which I resolved with btrfs
> replace -r and did not notice any errors immediately after. The new
> disk is /dev/sdh devid 5, and the last disk replaced/added roughly 3
> months prior was /dev/sdf devid 12.
> Roughly a week after the replace completed I began a scrub on /dev/sdc
> devid 1, and roughly 36 hours later without anything logged, this
> triggered a kernel panic (btrfs_create_pending_block_groups:2716:
> errno=3D-17 Object already exists) resulting in read only, and
> unmountable since. Several days later, this scrub then finished
> successfully and reported no errors.

That "panic" (to be more accurate, just kernel warning, not a panic)
shows the first hit.

Do you still have that dmesg? Or it matches the one you posted here?

>
> While the data is all replaceable, due to the amount of data involved
> I'm keen to retain the filesystem and identify specific files/folders
> to replace, provided this is achievable and can maintain the future
> integrity of the filesystem!

It's a little hard, especially when we do not have a clear clue on what
is causing that warning yet.

>
> Any help or direction would be greatly appreciated
>
> Command output and relevant logs included inline below
>
> Cheers,
>
> Stefan
>
> # btrfs check /dev/sdb
> [1/7] checking root items
> [2/7] checking extents
> Device extent[13, 2257707008000, 6488064] existed.
> Device extent[13, 2258112544768, 6488064] existed.
> Device extent[13, 2260271366144, 6488064] existed.
> Device extent[13, 7812682350592, 6488064] existed.
> Device extent[13, 7813260705792, 6488064] existed.
> Device extent[13, 7814399262720, 6488064] existed.
> Device extent[13, 7815832010752, 6488064] existed.
> Device extent[13, 7819053236224, 6488064] existed.
> Device extent[13, 7821200719872, 6488064] existed.
> Device extent[4, 15746057961472, 6488064] existed.
> Device extent[4, 15977630334976, 6488064] existed.
> Device extent[4, 14263979671552, 6488064] existed.
> Device extent[4, 14367058886656, 6488064] existed.
> Device extent[4, 14369206370304, 6488064] existed.
> Device extent[4, 14624786284544, 6488064] existed.
> Device extent[4, 15141140627456, 6488064] existed.
> Device extent[4, 15194827784192, 6488064] existed.
> Device extent[4, 15486894211072, 6488064] existed.
> ERROR: dev extent devid 4 physical offset 14263979671552 overlap with
> previous dev extent end 14263980982272

Please provide the following dump:

# btrfs ins dump-tree -t dev <device>
# btrfs ins dump-tree -t chunk <device>

> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> Opening filesystem to check...
> Checking filesystem on /dev/sdb
> UUID: guid-x-y-z
> found 104052224266240 bytes used, error(s) found
> total csum bytes: 101533362472
> total tree bytes: 117929181184
> total fs tree bytes: 1742323712
> total extent tree bytes: 1548320768
> btree space waste bytes: 11865883351
> file data blocks allocated: 139229426343936
>   referenced 139218099167232
>
> # btrfs check -b /dev/sdb

This just provides extra noise. The regular "btrfs check" is the most
important one.
If possible, "btrfs check --mode=3Dlowmem" provides a more developer
friendly output (but much slower).

>
> # uname -a
> Linux mynas.x.y.z 6.8.0-39-generic #39-Ubuntu SMP PREEMPT_DYNAMIC Fri
> Jul  5 21:49:14 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux

I guess your NAS is running this newer kernel even before the first
warning? Or is there any older kernel involved?

A quick glance into the tree-checker shows that we do not have any
checks on dev extent items.
And I guess that's why we didn't detect the corruption in the first and
let the corruption sneak in and written the corrupted one onto disk.

But my current guess is, it looks possible some kind of bitflip sneaks in.

Just to be sure, after taking the dumps, please run a memtest just in case=
.

Thanks,
Qu

