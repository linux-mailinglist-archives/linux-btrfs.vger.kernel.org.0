Return-Path: <linux-btrfs+bounces-4748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8988BBF67
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 08:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD05281BB3
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 06:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831A73FC2;
	Sun,  5 May 2024 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Y2dcbVTc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DCD184D
	for <linux-btrfs@vger.kernel.org>; Sun,  5 May 2024 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714889387; cv=none; b=Dg4ht+SCyPap+nEQbJVguXhelAUtEMxSFHTcgCaHNrP4d2iw3SYKoqVpYpITD9COboQj9DHTBvb46g9ilNfJsYGONV+5tMVoTtstyzv3r1dtxDMvzWjGlESPJdXZM0EUDOU3UVIauJto9MyTxsSCE5+5ezMfgS/m4HmGZ3Wd7UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714889387; c=relaxed/simple;
	bh=0zY/gyqgmOndxQMGB6cgf/ruByxb8+fxYsY86YqjQfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L5f4nfkc1Flhj3Psv3dUNwJ5yni7uL7cvWRnofRcA82bfGNaN6dyS1J0mBSc/2PPwoCBMY+SvC6Nt4vdxqSq4k3oSRrLI33hx8X71lzBtunZD1FyCMFL+snTYxyeRHLU2xVKTm5zh5hu3E7ZKHStDWsS9SvWdxmUbf/RXeYi/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Y2dcbVTc; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714889382; x=1715494182; i=quwenruo.btrfs@gmx.com;
	bh=f7g22AV84mRqxokSjJpVulrKJKsB90YRfhtCiRc0+Jg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y2dcbVTc8pXQnbgdPNQoJOpNARFw7YpmQNmrvu24D8P7FXxXKmCNlj8Ss5tqX55d
	 GOewCfwJV8uTCBZS0AuJbEt+ZXIF7A/uJ7hI/sSmkvFOcI3xPgYIo/B6F6wyCGSib
	 8N5fbAH6kU3saDIDVj//Kosj3iTuY5yhPa4fTetPlCptLNCKoDpif4/t81G6vUj5w
	 ozayC/76VNKniHvzRtSV30WPLTgkrpepwLipaPGuw/qR2sE1NC3HGgGAvWyO0AMuM
	 10DstBG+jSYFCxPjtG713MSUwLTQaXFTFkiOPJVaTPoZGrKkx9tnjIAMuuPGdXToN
	 6jK1RRQwe5peVej0SA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M89Gj-1ryI8k3VmF-005HMw; Sun, 05
 May 2024 08:09:42 +0200
Message-ID: <618f7bf7-0ffd-407d-a42c-bf86199bb1e0@gmx.com>
Date: Sun, 5 May 2024 15:39:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS w/ quotas hangs on read-write mount using all available RAM
 - rev2
To: O'Brien Dave <odaiwai@gmail.com>, linux-btrfs@vger.kernel.org
References: <57CAA156-27B5-453F-8A83-1C8812E49B98@gmail.com>
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
In-Reply-To: <57CAA156-27B5-453F-8A83-1C8812E49B98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1PEeY5JsDZbvNpAH1dpP06D+Fx4rH95R+DTEgOKtRyzFpxZkpfP
 5tAto7PWtJsYF3CX1CDP2/a3J1nNjlJZDRKA2l7PvKnnkRPSsVMx9p1o0j17TsWGCmgH7CP
 Bd4Bj4YFLSNiVPLN5c9LRs+fdTQpbYNR3/qauNKYJuwx33aVm0vEoADlHlNM81wT1PTuyXH
 tdYaajgyZeSVL3voeV4aQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:50yhiacUfzw=;ou/vQE2w8iD1KDv+Gs7QWHqKF1G
 hA5fL3MZK9ymAXa5d/sGeX84EPDWeKbBUXZjZKwd/KVWPN2nr18GcPiOX2iT7anHcZoHokVdt
 b6o49VZs+y9bsIaEZnk1x1vNU5I37p/RiQXpG7zdmT8kuEiGEcMjktDXjtKe9TOOs6WT0lfzU
 FcBi0B0Y1vKUikAUmil/G3QA4EE35g1MeH74pTAoaNC4URpgimBfSZPJVYy9IQQr7TCZ9ZbfB
 NhwhO8ibPq/Axy/19TFDGNeElv2GQPl0y6FTCs+3VNd76YU4UNxjKd9xDKBzzueNrmmA/NeK8
 q0DAiVWbgm7YWFVG0TZ25cVV2ONvaq7LnsdTXap+xs5hM1RW4F9YXF7eBFuopNEfMecru5UxI
 RkQD3KEAUuHlFWw0L38AOPZF4Oum+DPvq1XayT7mqBfmvkdpJIrH0q6dooup56THv0SRTazux
 6kLUlR3vPhE3LJyEMegSseGJdROtfkOuHfSP9q5E4nkFwvc9yTPkzxBMjpeMyOI31uyAFfwsM
 KqPDWbg4MSZGJ8z3ekYpoa9vwiI0IpjYKx4imOBUQdiRHmepS2shBE7SZsFIKT6KCCTStc2in
 vuzx6CPLwAv6LRCz8Z2EYJ9IyfsXE6KuDZgM9IS7r4ADWhi7baDw5XOvQXHN8mUdJRUeIoBtQ
 9H1NPzMjUxt6DbawPNtBrlMpn36A2TR8rOFVpIUtJ558hkKxjcJdZwoSZBWVHdouCcCMYoDD8
 ptN8jxSDdYFSeIBrxBgqNJW8BQTQ1l066Oa+qsbhLm+uWtSUJIBO7zHlo3E91opFCs9SR3CIW
 D4X6AFGS5j/FZKiVbbqIYMI8QuTOciGH43hnTgGjIcAc8=



=E5=9C=A8 2024/5/5 13:25, O'Brien Dave =E5=86=99=E9=81=93:
> Dear BTRFS team,
>
> I=E2=80=99ve had a weird hanging situation as described by the previous =
email in this chain: https://lore.kernel.org/linux-btrfs/133101d8dbce$c666=
a030$5333e090$@admiralbulli.de/
> The situation:
> I have /home as 2x6TB hdd in BTRFS Raid0/data, RAID1/MData. I make a dai=
ly snapshot by cronjob overnight, so there's about 1000 snapshots on it. (=
/ is on a separated ssd)
>
> To see where all the space was going, I enabled quotas: `btrfs quota ena=
ble /home`, and it started doing its thing. When it was nearly complete, I=
 deleted one of the subvols with `btrfs subvol delete /home/BACKUP....` (o=
ne of the earlier backups, about 117MB exclusive, according to the qgroup)=
, and realised it would take a while to complete, so I left it alone.

Deleting a snapshot is super qgroup heavy, it needs to remark all
involved data extents for qgroup to rescan, and furthermore, the rescan
has to be done in just one transaction, mostly to hang the whole system.

>
> Later that same day, there was a power outage, and when I restarted the =
box, everything came up as normal, but a `btrfs-cleaner` process started t=
hat eventually took all of memory (32GB) and then eventually made the mach=
ine non-responsive. I tried to disable the quotas with `btrfs quota disabl=
e /home` while this was happening, but the command didn't return.

That's the same thing, doing the same subvolume dropping.

And unfortunately there is no proper way to handle it without marking
qgroup inconsistent.

So the only way to get rid of the situation is using the newer sysfs
interface "/sys/fs/btrfs/<uuid>/qgroups/drop_subtree_treshold".

Some lower value like 2 or 3 would be good enough to address the
situation, which would automatically change qgroup to inconsistent if a
larger enough subtree is dropped.

Thanks,
Qu
>
> I rebooted in single user with `/home` unmounted, set up 128GB of swap u=
sing a USB 3.0 flashdrive, then ran `btrfs check -p -Q /home`. It took 75 =
hours to run, and used a max of about 80GB of RAM+Swap, and reported no er=
rors.  I tried to mount the drive as normal again, and once more `btrfs-cl=
eaner` spins up, takes all memory and makes everything unresponsive, with =
constant `OOM` killings of all processes, until eventually the system cras=
hed. It didn't use the swap much, which might be relevant.  All through th=
is, `btrfs-orphan-cleanup-progress` reports that there is one orphan to be=
 deleted, corresponding to the snapshot I deleted, and it doesn't go away.
>
> `btrfs qgroup show /home` shows the deleted subvol as <stale>.
>
> I can mount the volume read-only and with `ro,rescue-all` with no drama,=
 and nothing dramatic appears in the system logs, but mounting as `default=
` causes the eventual crash of the machine as described above.
>
> I cannot run `btrfs quota disable /home` as the command doesn't return, =
and the system eventually locks up when mounted RW.
>
> My current kernel is 6.8.7-fc200, which should all of the optimisations =
discussed in previous emails in this thread. The filesystem is about 3 yea=
rs old (2021/04) but I don=E2=80=99t remember which kernel was running the=
n, but it should have been at least 5.8 according to https://en.wikipedia.=
org/wiki/Fedora_Linux_release_history.
>
> Is there a way to disable the quotas with device unmounted (I don=E2=80=
=99t really need that info, and I can always rescan later.) I made a start=
 at patching the `disable-quota` command into btrfs-progs, but it reports =
an open transaction, when run.
>
> Any advice on how to proceed?  (Apart from backup everything, of course)
>
> thanks and regards,
> dave

