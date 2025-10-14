Return-Path: <linux-btrfs+bounces-17747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E85BD6E38
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 02:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AF442002C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 00:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAE51E25EB;
	Tue, 14 Oct 2025 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="Ayy1Q4Cz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sonic308-8.consmr.mail.gq1.yahoo.com (sonic308-8.consmr.mail.gq1.yahoo.com [98.137.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCD734BA45
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 00:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760402521; cv=none; b=I2RqN5J2kie9aUhryt52XgdLl8X2AmC4Gi8oTPUCdo23Q3XPTQtV3ipaZuaafnxoInkkkR0xICKd8o2SXvQdmVT3IUk1I1xFaxVlTgzShox/pm9mo85tUXT7BveepiAs55v2GNwWuOjcWpAsCKkUfH6Jp3VVNa8eBDDGVzOxia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760402521; c=relaxed/simple;
	bh=RH5DrpW1lNrgo+JlkM+SKqWaWJm1wV3enfT6BQth4eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CPNcYBBQ5OXRNbcdNdwM/WDUIzFxrcgasiYpu9zt/tWllUx2x6ZrrHIR6jwWuDVhLg+F4n+xPzUuvF2wC1ICqzR1KcELsjHSbw9K6zDsGIW97WxbqK8lbPpSpY4ziz1p1jIG2MWgSLlIch+PgZyt64xMVf/vpBSVFIygQwn4Ro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=Ayy1Q4Cz; arc=none smtp.client-ip=98.137.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1760402513; bh=DlWcZFQB/PhzHSj4rZVRN92Dx3/0cbkDn6n8uB6+myU=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=Ayy1Q4Czdd/bwP9kr3Ssh/+3p4s15Ai4pAqNY48meD9F+cpiBf9AwI3xGb6hEbzQeS8Ot7iJ8M6ulzQ8MtxfFGcZ24xcEJ3Ex6/Ij1RDX9ufDTwkwsacxRbELIq3nMMJq8A53bpKFX2NThFXxvPNn5xLR7vTnh8xD5aHAwj+J43z2LbZHvHft2lNjpkW9RmDEQO9++x7nE4hEzj6GKm5SFvAcIJj1VxjlCc+M8O90MvT1t3xMnsi2nWs2LPP7auCQqed4F+QEvrN+H0Fh5x6xqzxazxNpQI6yvxTIFYhwH+Rmu/ShsBMiDfq6bZTirLFtH8xTUOkOyH6K7X/UgUwew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760402513; bh=ndZDPSLrh0SE7BbZ4t4u0I4UHHc/FQ6G2KMGv0TwNab=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=KeGSNpoEk3msx4EJjn3MyDUyuy6mYo8QUgIYKDF88BtTUx54B4O1o1zFwURwI8tkYq5POSApxsawgjj97JDD5CfqKL3C4bUuhitET+YZv7rX70tDsnfXyHCwDAjuVzdlATIq/7PDeVJBWFr6dumTpDe2qu8jViQ2nnl6mk4bdDsmCSH8X3WYfr8DWNEaXueVsd7nBH2VHo2EOF4heA187aC9Mg1YAGIIhuK5shCKhrWbRITZB7bqekEpMXmoq3tz6CQydSOB5RiT0ZREjmgKOr50UBDUYBE7GzFj0p2diiKEK5xngJKODNFCFNX019yyExFi0I6x6xoWrpAyEdEXIA==
X-YMail-OSG: YG.ypwUVM1laP86LmmvqQut.pJHZUgIsxX4izMNx22VoKjtIxIU01qNc5HPnEz3
 emN6WMKUJiApEGluygEyIdEpE175ai7YwzwtmoYC5ly7QVvJZcF3jDW0ScfMDQiy.wfoA6MyjzGx
 cnxI_ESAQeChwXWG0KSYWPN10EOovLbom843EYRD87deiCVJiAQWc6xr2pvwe38ZrjTpRBX1hEII
 hu0CzyR.pNIeNU35sTq4ae71O2BgeKxaS9IsvDMFyAnXwM3CfQFMd44Ld3jfLl4gV5Hyxc0vyX.x
 RqJP3lOFbRmKheU6.ZrxXn1AGy6.kfX1_P0l4ZZV1dp.1bX_VluKRcvCht3whJR3xzhAHMqssG2o
 4Ll.uBBT_VE3JnvKiolgaNh3kp77VU_TCcywPXpZGXvr8C56169AkKVWcbh6UMZeimTlqi3WR.9h
 biONIk4eIHRq4Eot3hWBJdJP1sIw6R2Sw8RPIfBvRj7UkiuWh4p_tMRfQq88PHeKuIKAvniKlDV_
 eqcXPYXfD_6HJVl4OOHQhb9bKQiyD5dV7Czpt.8nMQrfxXB9p0Tja5LHzBk6hpN1InhKV9W4NZNJ
 ni.wFCRuchHKJ9fl1gv2PaEsDwh1k29Gqi2dH.KXus9WFEIKPX3ftgzzL0mS5JQReQR344DeQXwz
 78UD1LaRyQ0hJQyXiLn5pAawO8iCzOBvoDqDr5Qd3TSggnUihxTieGkyXgyyLUeZObc7rpW3Xi8u
 J9ipmcA68tQLtEKB3SohP_Z9kCU4DGTvTSDbrAUzRsXxsU5tfDAjYDj8WndmH92jKWuxpv3nF8gK
 gd4_8s7uPU9Gsiz5OaDeZZbQzYL4aRgK0VVzs8tQE90x7SV11W.vcLl5ulno17xYdqbt1.zhCxPs
 JEg.RmVpnIWksDA45qad7Yc7Ax8iESfrr_42WTjCbkRWZef8s4cluxLbCchwK.v1Xo8AhBOF8Pyb
 sTIolBLSMN9H4itxLlTAZMP58gYhuzljG.V_1iwgw0Bg2oy7qa17IyUuaVdI8sLzgLEVttNIO9cS
 6yd7tM8MVArfmDvDSKhpKf4veJS3fx6Hp.r0XsOhwH7B9v5O5frUj.kZ5fcnopW.tEZnR7QJxFvG
 piHs4fwOa0f1OHjrLvITX59IvxJRsM8oY9eitFQU24ahA71g_PBx7_EY96sLCF56yAHzrXW2ZSGG
 T332jtCgIfP3gpJStN2rm4co0wmRtlB_mndfPAcK.J46eKrPoXa2p8FTg1sXAwlGTVXc3UH.bHsh
 bOqdaqz9UP3y75mDMKdQ_kDoHzg3AjjMGBLpoAQIjXMJj_sN0f3oVsdZhnvVPYG7o1ORuLiEoquP
 8AdPhMVTdSPfi4biyboNckXjH.6vx0rDQVxezoZoidLNqipVl3qilKHxHZtaLM0AyZGYKwxOvyfv
 PDfyhbZIpXTl3wYk1tHeE6c8xVT7EEaLADk2KGDq38e5l0fZaQ2_3.J_hK.UDgF5.C5oJUi974XB
 LJlwdIIR4z0ADTR6Om0r5CPE2_92wBj2PUt.jo6Xigsa92EOAyKfG7FEBAeAq3GCkIX.LDqsZ1j0
 ypfNpeh0UNs_aQLR7aG3ejxL4eHazyJa79rS07ulFXkIzmLFcVX6G5y6my2EDaiCLrha.Js0Ujjo
 b5E7n22LjCQ_.YEovqj6IHp3Or9poDQ1Ds4vmXrdkDsSPpixvjnbLRCcFdUoG59O.3rhJTPpBC_m
 pIlPJKfNJhafOhVbgwYJ0oJ9jiyzmKW2RyXcLPi_6wnVOX3jU5RN98m6.8JxVir8CgJ6TztIQ17g
 2JgFNQjMP_phTaNMNWdsM_qRCt2q_6b24.pwuwkxASTswXeTNBt_oxtkQjVesRUuGzhWfRAVayzp
 0tBcsocKzh7e3U7ZV5BdtJ08uICcSq7Xqe4Nab_EGtlu14a4N57u0nT8yCTP8tiXcOF.ij1TYQP.
 sTnzZA6iu_exmsP8QNkjxX7Zw8pfx4BIBRgEQhPpuT2BmApQkZFiRkN15Uq3S7yQ8qqCGNvKxFU_
 gFvJE15dwHFEiVPmVdsrkfvY.Jx93tGLpiALUUJGHtw3j61BoXQYPs3mafU4bf9a91vtDFJCr5ta
 OAFbGJpF8ywmERMJQtozHzyszV5L4JEOXS.pYWclMXvI8JN7prD65iHMAx5uNirtVP1mYxeSiciB
 rLEBOVyD5lsY.N1DZCYNIfqhO3nJDKUTwiSNoeS2TrPeCabzTUAIk1ybxnRcrRaYNc4UWWTes4hw
 MPznRCQlt5Qf9FcnbJWSPZXmN9ygAqdc8q9TW.TqmZrNCoFeE6bpavXyE5r_TqHeu
X-Sonic-MF: <brent.belisle@verizon.net>
X-Sonic-ID: efc40f28-29f0-4fc8-85b3-a426de53a213
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Tue, 14 Oct 2025 00:41:53 +0000
Received: by hermes--production-bf1-565465579b-7gz6q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 663e5b09922bf7934533c643f89d0d43;
          Tue, 14 Oct 2025 00:31:42 +0000 (UTC)
Message-ID: <586bcab1-f799-4920-839b-d09daf6ed840@verizon.net>
Date: Mon, 13 Oct 2025 19:31:40 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: Discard=Async question
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <acb2f7d4-ace1-488c-a7f5-cd499d3f637f.ref@verizon.net>
 <acb2f7d4-ace1-488c-a7f5-cd499d3f637f@verizon.net>
 <afb0b3f2-3012-4f98-9956-6f4030f282dc@suse.com>
Content-Language: en-US
From: Brent Belisle <brent.belisle@verizon.net>
In-Reply-To: <afb0b3f2-3012-4f98-9956-6f4030f282dc@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24562 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

Qu,

Thank you for your prompt reply.  Looks like the fix will eventually 
make it into the 6.17  kernel.  I'll just stick with the 6.16.12 kernel 
for now..

Brent


On 10/13/25 06:49PM, Qu Wenruo wrote:
>
>
> 在 2025/10/14 09:23, Brent Belisle 写道:
>> I hope this is the right place to ask this question.  I noticed that 
>> when using the latest Linux kernel 6.17.2 and I issue a findmnt 
>> command, the discard=async mount option is not showing up in the 
>> output.  However using the Linux kernel 6.16.12 and issuing the same 
>> command the discard=async command shows in the output. So my question 
>> is is/has btrfs discard=async been disabled in the Linux 6.17 kernel 
>> series?  Or is it really enabled and it is just a findmnt command 
>> display issue.  I'm including the output of both commands  so you can 
>> see what I'm talking about.  Thnaks for your help.
>
> It's a known bug and get fixed by the following patch:
>
> https://lore.kernel.org/linux-btrfs/95f198ac033610c66c30312743fbec4869200229.1758862208.git.wqu@suse.com/ 
>
>
> Unfortunately the fix is not yet pushed to upstream, thus no backport 
> to affected kernels yet.
>
> Thanks,
> Qu
>
>>
>> Linux Kernel 6.16.12
>> LMDE 7 Debian 13 Trixie
>>
>> findmnt -t btrfs
>> TARGET        SOURCE                 FSTYPE OPTIONS
>> /             /dev/nvme0n1p2[/@]     btrfs 
>> rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=33929,subvol=/@
>> ├─/btrfs_pool /dev/nvme0n1p2         btrfs 
>> rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
>> ├─/home       /dev/nvme0n1p2[/@home] btrfs 
>> rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=33928,subvol=/@home
>> ├─/970_EVO    /dev/sdb1[/@]          btrfs 
>> rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=256,subvol=/@
>> ├─/EVO_POOL   /dev/sdb1              btrfs 
>> rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
>> ├─/PRO_POOL   /dev/sda1              btrfs 
>> rw,noatime,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
>> └─/850_PRO    /dev/sda1[/@]          btrfs 
>> rw,noatime,ssd,discard=async,space_cache=v2,subvolid=256,subvol=/@
>>
>> Linux Kernel 6.17.2
>> LMDE 7 Debian 13 Trixie
>>
>> findmnt -t btrfs
>> TARGET        SOURCE                 FSTYPE OPTIONS
>> /             /dev/nvme0n1p2[/@]     btrfs 
>> rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=33929,subvol=/@
>> ├─/btrfs_pool /dev/nvme0n1p2         btrfs 
>> rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=5,subvol=/
>> ├─/home       /dev/nvme0n1p2[/@home] btrfs 
>> rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=33928,subvol=/@home
>> ├─/970_EVO    /dev/sdb1[/@]          btrfs 
>> rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=256,subvol=/@
>> ├─/EVO_POOL   /dev/sdb1              btrfs 
>> rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=5,subvol=/
>> ├─/PRO_POOL   /dev/sda1              btrfs 
>> rw,noatime,compress=zstd:3,ssd,space_cache=v2,subvolid=5,subvol=/
>> └─/850_PRO    /dev/sda1[/@]          btrfs 
>> rw,noatime,compress=zstd:3,ssd,space_cache=v2,subvolid=256,subvol=/@
>>
>>
>>
>

