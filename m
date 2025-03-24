Return-Path: <linux-btrfs+bounces-12519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87457A6E470
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 21:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD60165884
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 20:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE041D7E2F;
	Mon, 24 Mar 2025 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="niTsw9Ck"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B61013B2A9
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848246; cv=none; b=mydUOtZ/gvxx2EmaLOXuajNKFdJzkaYeEJjCF6WpBbYGe24iNYXaKeDS5rY9xijZPZ9Es0LExcBHJiZHBJkRe1MyB55THcEWcV0X0S+ZUgdXizVyZ2b8OSQYDQmjtTFcj4GLgXPc63J/wF0fEAKIJwPXekt1bUf+f0M91ZF3Rt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848246; c=relaxed/simple;
	bh=F5Pp7oI9k+FmndTf3KzY8CSALqDB4gLmQJ4PT1oNsIw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j/d+/7rVTkWtC5jKAUUvTijLC3J5LujnMH0OQZ480wLAXpGJfZ2L6sGJ7mKd7SjfsXxpZxl3WLzMEqRKa3ddDdFlV/cDAlFVFDqHtKVSaMl2O7xcL1l1kBubil7l/+7eSRGo/LeqYqaXXJlEf5bF4gyhckPYec1qy358veZrEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=niTsw9Ck; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1742848180; x=1743452980; i=jimis@gmx.net;
	bh=CP4zIUK+JeQ+PeKOrW6pSyJNHcpbDzYpv5LBGgRXr7I=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=niTsw9Ckdc1QC/IbVnFtRE9aLA1Lz8fBAmNlJrLeOPBuGj7Kwi4Cg6JYV4vrKeBg
	 mLDkuGNsojixXTm+QICJGz3ra2DPOu+XPTj5+Z3Qf5QgImtH2v2mgmx8m8jWl3N62
	 +vZY1nz5/oh2ApncSfoLkmh1UG17d30H2TN3zQbYA/EmaEWvu+I7F9FwYVyg/1HWR
	 oEDiDZiCaX8XncQ15RyKHpHDyJUeagoXqHhlRqUw5t22+AF63buVVcASKoko0FlmC
	 FjhPDrHXBf3QAECIm31hV+aJ/t3YmLLXOmv5oXNbGHdmZnIQiNWVrR2B9EzyFpSOv
	 HAZp0Ckbct5AmB958w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.81] ([185.55.106.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJVHe-1thLyd35su-00NTD3; Mon, 24
 Mar 2025 21:29:39 +0100
Date: Mon, 24 Mar 2025 21:29:38 +0100 (CET)
From: Dimitrios Apostolou <jimis@gmx.net>
To: Gerhard Wiesinger <lists@wiesinger.com>
cc: linux-btrfs@vger.kernel.org
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
In-Reply-To: <50f0a049-22a9-4732-8286-4443e92ae18c@wiesinger.com>
Message-ID: <da4f900b-cece-d8d4-bb7a-c614d76de298@gmx.net>
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net> <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net> <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com> <3ecd06ed-a1f1-595d-a7ce-c1018bc15baf@gmx.net>
 <50f0a049-22a9-4732-8286-4443e92ae18c@wiesinger.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:pRHlhCKztLQv+u0MKA9usGiCM18EddOqVmFZ36ZxZNGYhI2DRrd
 EvXaM330FQfBCljac2kmbYthTBj+wwxoH4yO9+EyIieZqrk0ZZzSfl5jy/k9Mhixm8wFEkG
 h7h9Z6AzP/X88XbuTKVYWLxnfr70jCoJSbuyQF8LXpLwGAKGyYNC499GVkm7Xj58I6orzWm
 PW+KPloyFbyj93j/S++Tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EaTK9AApFXU=;MSFAHYdOKdEEbzJkFevaIjd2ung
 QgQWM6oAUMDtHfEtMVKt88w6cfoZk4oUyXFmSegjrMUpFzSI0s3TmmEu+FiuvEaDd+DyBA+MZ
 ZnAlGW5qG43wkZiTpNx644oDXR3Ft6ru6Lo/UdNvD+0fbZT47NRTOqXj3CzLKWCgWP0LsMWrX
 hAR5Ujzl5aK6LRGoqlWk3gXvvn+7XznrG+9u0/ltJu8+TpYemw2Uye2wBLa16Ld6YdtGP8XGr
 KYPxNnP1PWmfYKqvRMDha5L1kFXCWVBH6B7ruybTyuDIBqhiYXe0ClSzjhyU/zIYcCbn72cdu
 1mnZCZTeCxxjjH0U2Xg9WJkjpqnidAUYdvQsoHSXSn7/R4HYfvWS4J1pC/bBG/CgoKtPqZwi2
 rL9RqMdtxkXAJer2UOtBDbq4gbyJQ87M9QAgWFEYuMHnKhsbsxzvOHfONyCGzURIv56mqa2nO
 M057Z9+1ryHo7DHP09Rf8sb8A9BJ6qzaT/L3v/zvJLVseYiHAAbBVHibQ6yYpDZjWKbjlortz
 OyqXBlhXCsHKF1lx9sceBFJRNtNQLwdww8jfLj/OYJrqd0eu9leXdiv2+To10jaohVZFA1nUH
 fsN4XEmrg5kaGnMZnXXFxqRZqebUkfY0Co92MvnzOarKuWpQ6gJAdhi/UNHBo9XV4u5KEKva/
 0onCZr18eXnwR3SdiOrR7jCBn4bNoR/DccArSLu/OcqKrB5vlv+PByPLJa+mfaBebw8R5NvOF
 CP2nVetWLrzfEhrv5pCEfJtZpiArKzrDPGuf+u5TK4UGhAnLwbhf7JKgIoebTCAuiyzauz3Rz
 aZiM09P56eKoBTgNDbFDuY4TS/LVEEAiCerES136FrhynKArqfaBfIZnKkNY0fkGbXn5NXUvS
 1OEzocJ84C1puR+ktVUoXVtzQAhgmk0KBrvVu4YsELV63RjUT9WVasALEPC9bgSiLc/sMUAfK
 9fhNWjypi+5qF8tpNkCN1kD0VRuJfwtpbbu3KumNihGIhr4kSaVvj98TO21nKrZl1Z3h+u96F
 79bC4SBpW2hOdx8I5d9b30b0qDLWSNrblqLqN6rknRn6yAFjBY+I0cpi9ocHsWLmMn1M1Jrr9
 L0yql53wM59qILMpllcpZyz+KUMzlJQqlxWTbA7hSTv/m8m+hni3JtXe/ZVtk388U8rVpVjVX
 f/kysNMF1BR57jVmgcGxGXZmLK3mWKSzndUZ+5lyDR+HbVb/sYLlckvR2NaOg2BnZfeiZfAJm
 gtolfidIB9R05L0ka+6x2S6kGsrMiESucwb9cMWMJDdFwjNrtCorMZ4kZlkIlrbyJbJEN4P8o
 Sll0/SMQ6XGS6yFGDljC9lbOGfCqehOKWI0Fi/Rf9Y8cwVBDV98QgXD2wsCB8OGIyKIEsAMLL
 /OTjDp+XMuVTHvw4QVEQ7CS3ytXAiTYnjbIvaayXNssDVbzl59p18NItUVdNEAeMQ6AxYEeCr
 sceWtpg==
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Mar 2025, Gerhard Wiesinger wrote:
> On 24.03.2025 20:11, Dimitrios Apostolou wrote:
>>  On Mon, 24 Mar 2025, Gerhard Wiesinger wrote:
>>
>>>  I guess you always had the issue but you didn't notice it.
>>
>>  I definitely didn't have it with PostgreSQL 15 on Linux 5.15 (Ubuntu
>>  22.04), I don't know for sure if I see it after upgraded to PostgreSQL=
 16,
>>  but I see the issue with PostgreSQL 17 on Linux 6.11 (HWE kernel in Ub=
untu
>>  24.04).
>
> Yes, it occours when FALLOCATE (in any form) is used. So it looks like i=
t was
> then introduced with PostgreSQL >=3D 16 and is NOT kernel dependend.
>
> Are there compile options to disable usage of FALLOCATE at all?
>

Probably -UHAVE_POSIX_FALLOCATE in CPPFLAGS. Haven't tried yet, so take it
with a grain of salt. :-)

I tested fallocate via its command line tool, and I see the issue in all
possible combinations:


Linux 6.11 - ext4

$ strace fallocate -v -l 1g blah-1g    # returned immediately

blah-1g: 1 GiB (1073741824 bytes) allocated.

fallocate(3, 0, 0, 1073741824)          =3D 0


Linux 6.11 - btrfs(compress-force=3Dzstd:3)

# strace fallocate -v -l 1g blah-1g    # took ~10s

openat(AT_FDCWD, "blah-1g", O_RDWR|O_CREAT, 0666) =3D 3
fallocate(3, 0, 0, 1073741824)          =3D 0
fstat(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(0x88, 0x9), ...}) =3D =
0
write(1, "blah-1g: 1 GiB (1073741824 byte"..., 46blah-1g: 1 GiB
(1073741824 bytes) allocated.
) =3D 46

# compsize blah-1g
Processed 1 file, 4 regular extents (4 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      1.0G         1.0G         1.0G
prealloc   100%      1.0G         1.0G         1.0G


Linux 5.15 - btrfs(compress=3Dzstd:3)

# strace fallocate -v -l 1g blah-1g    # returned immediately

openat(AT_FDCWD, "blah-1g", O_RDWR|O_CREAT, 0666) =3D 3
fallocate(3, 0, 0, 1073741824)          =3D 0
fsync(3)                                =3D 0
close(3)                                =3D 0

# compsize blah-1g
Processed 1 file, 4 regular extents (4 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      1.0G         1.0G         1.0G
prealloc   100%      1.0G         1.0G         1.0G


Both kernels (and libc, as I also tried fallocate --posix) seem to support
fallocate() on Btrfs, and btrfs always fails to compress.

Weirdly enough, I don't think I see the issue with PostgreSQL 16 on this
last case (Linux 5.15). The space growth of the database is looking like
it's well compressed. Can't tell for sure though, the compsize command I
issued more than a couple hours ago hasn't returned yet...

>>
>>  I see in your message that you are on Linux 6.5, but what is your
>>  PostgreSQL version?
>
> Didn't document exactly used version but I was using version PostgreSQL =
16
> (see directory /var/lib/pgsql/16 on the mailing list posting).
>
> I was using the PGDG rpms from postgresql.org to get latest version. For
> support reasons with less upgrades I can recommend them anyway because
> distribution versions are often (far) behind.
>
>>
>>>  There is also another issue with BTRFS:
>>>  https://lore.kernel.org/linux-bcachefs/kgdutihyy6durmrtqi5dfk7lhl2duz=
m4wnf6mlyneiuphf3cck@fxulfyg2ugjf/T/
>>>
>>
>>  And then there is the issue of abysmal performance for buffered read(8=
KB)
>>  from compressed files:
>>
>>  https://www.spinics.net/lists/linux-btrfs/msg137200.html
>>
>>
> Ah, didn't know that. Did you also try ZFS and test also regarding
> performance issues?

No, haven't tested yet. I'm quite desperate though to find an
OK-performing compressed filesystem for postgreSQL, so I might look that
way.


Regards,
Dimitris


