Return-Path: <linux-btrfs+bounces-5515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718D68FF7EB
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 01:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364091C261F4
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 23:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142A13E3F6;
	Thu,  6 Jun 2024 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aiEP4DnJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BD413C9AF
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715151; cv=none; b=euaDG+okz+fnlpqidEDY9cZg1XNidaJrhQ9FPwbUASrD72Em4Fx66YJRdvOlawV+X9eXLGqAkIfyuBnWTXGSCs3Nu5WMPMuQouhCtkuFTNzwf/cL4Qjc6qbUzqviimNv5MpwvkUwCJWS6lzJVEctbowvTEb7CPUq9qX22gMekKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715151; c=relaxed/simple;
	bh=lRogg2CPvISSJzxUmSh3fOslkfdN9TSXECCIirREqpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V4zlwAcx6neJK11+akDtW6+yXysRf3wmX4TrJ+CT/tQ5yYKlzuzLsDUt9e12Y0a0f9+RHiSYT3x7VjUVb1g0/y+VFIVNGUSwsK0uCYKKiS9tqfkl7i0AADJXOT6FyUPO/TrXa5lah1GWYXfzqThDjRoTCykW4ARVluGyqXWW6LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aiEP4DnJ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717715146; x=1718319946; i=quwenruo.btrfs@gmx.com;
	bh=0XN6uJBnuEmoaFeIT7uz8Sq/q2OFgl2hQ29y/z823js=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aiEP4DnJs8f2nTLvBnhdd5SNkVU1AoijSLy91ACnVQMFOSVw7eDSoKbTiVqvws7u
	 kXgIJV+YIpSJ+tjbbERmviA1IMQzsqQL4JLpWv7kn640rnjLh1gKGm0nZ95F+H+cI
	 tl8KL20z9JmzQBlNRWQmExFH0QvndamB0S8kAywRKAye76VSv6yBt1y/UZ/TPKvme
	 WAevFjiPmu6M04RI2WpRFotOESjo35QwcUW1n0VYIG8qbXYAazi6AFJgR9CTXn/II
	 A1hZggYnaBJI5op+D22HwwdOHneWU3gSr2FYyVQn4iMX3bSD+bUxg2yaI176/iHfQ
	 5w2bgdZ8vUCTC+f4pA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVDM-1rztgn2YS8-00IZk0; Fri, 07
 Jun 2024 01:05:46 +0200
Message-ID: <4525e502-c209-4672-ae32-68296436d204@gmx.com>
Date: Fri, 7 Jun 2024 08:35:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: scrub reports uncorrectable csum errors linked to readable
 file (data: single)
To: Lionel Bouton <lionel-subscription@bouton.name>,
 linux-btrfs@vger.kernel.org
References: <c2fa6c37-d2a8-4d77-b095-e04e3db35ef0@bouton.name>
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
In-Reply-To: <c2fa6c37-d2a8-4d77-b095-e04e3db35ef0@bouton.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M0SwQ8LR9S/DUDBAwDINGDuWAxWaSgo4ZlmD5w8WwgBF/3D+nGP
 mQZZ4MWCDUVhI2iezSASq5ugZSvN8NcxTaJ+xW244fUVKaJEL4ThpNUFvtsZVYvKgM5iUD7
 6lMDg/l5BbVEcsVxfKYt7X7yxOuMoSt6f7Vm8v2OvowvjqTUV6J595uljI2d6T03nbT6k22
 jPFrumBMf+W6GioxlqLyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X582DX3mg1Q=;T7+4oqVnfVBmFLI7R/e/vX+8vBp
 k82O+hyUvoZZxzz6axcAG0ezL+R3Ba/UgMxDFyLObdddq10PT0ZSidpJYnWVH++yG/lJHvMEf
 GjuDX7YaXLQgj8GN04whpBT+We64ccujQezXjed5xbFYWz17NpP5WtK6TeGuszEYOd9B9qt7M
 6xHSXiZ1i+dNy8uC+YSu9UOQn9+J5ikZPLqgPWpkv+aQe2UYLBiRfedhjtGicN03uAio3Z5VH
 B1Z8jGcSQCkeBN5rc5qsUdUxn/Z6XC/v11j+GiWn06/Y4gexN4Fc2BfWvdWKaUFUbYng7wk/O
 MWxJOp7F3SktKpL6LeTFNUWR9NKeUFz1Cd8ro4pr87JwF+q2c8DnzOuiS+f55lQ6w+mygiSmt
 O6J5cSTqwB6DU1D/3QC1ZcuGjEKtBmhpGGovlIaI/Dvtqul7ZC0BuxCpWBtGSjv2JxwV2Y1nr
 xtW67uFpZSekAnJK14hMBPPilDFs1UCFStd4cATCqFnaou86A6cdIbX2V8GSYY4ZBnlPo7Io0
 EpcXfkdR3Qd2xW+EJcvDAKTprLq0qF100SDxgI5ynRO6H65nEewOswukQSO+YPAxUWw8sWTAW
 4b7wKkSFsDSxPZnjwXKAetkDRsaUo5vjcJK8Fg8+6gbwttDEd+anbNbyIUPhhijCdEbKcvFzv
 1nLr2s6Em/1W1gFVvUs37yGtKd5BEbAwJsPEwpdMTnxe2q2CE5yzvjLXshXMk2T0SxbOa3EeP
 sqL8KtSz2UlTVhW/sy+3ZWUMn+MH7jQXHyE/ozqXJvjkFRU0HyBpJxDKr4gwljp2/bi9IKVPw
 APY8p5dli4rtiH4LqFagQf9N389UoykJHWt/651w+cU1k=



=E5=9C=A8 2024/6/4 23:42, Lionel Bouton =E5=86=99=E9=81=93:
> Hi,
>
> It seems one of our system hit an (harmless ?) bug while scrubbing.
>
> Kernel: 6.6.30 with Gentoo patches (sys-kernel/gentoo-sources-6.6.30
> ebuild).
> btrfs-progs: 6.8.1
> The system is a VM using QEMU/KVM.
> The affected filesystem is directly on top of a single virtio-scsi block
> device (no partition, no LVM, ...) with a Ceph RBD backend.
> Profiles for metadata: dup, data: single.
>
> The scrub process is ongoing but it logged uncorrectable errors :
>
> # btrfs scrub status /mnt/store
> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 <our_uuid>
> Scrub started:=C2=A0=C2=A0=C2=A0 Mon Jun=C2=A0 3 09:35:28 2024
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 runn=
ing
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26:12:07
> Time left:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 114:45:38
> ETA:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Sun Jun=C2=A0 9 06:33:13 2024
> Total to scrub:=C2=A0=C2=A0 18.84TiB
> Bytes scrubbed:=C2=A0=C2=A0 3.50TiB=C2=A0 (18.59%)
> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 38.92MiB/s
> Error summary:=C2=A0=C2=A0=C2=A0 csum=3D61
>  =C2=A0 Corrected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>  =C2=A0 Uncorrectable:=C2=A0 61
>  =C2=A0 Unverified:=C2=A0=C2=A0=C2=A0=C2=A0 0
>
> According to the logs all errors are linked to a single file (renamed to
> <file> in the attached log) and happened within a couple of seconds.
> Most errors are duplicates as there are many snapshots of the subvolume
> it is in. This system is mainly used as a backup server, storing copies
> of data for other servers and creating snapshots of them.
>
> I was about to overwrite the file to correct the problem by fetching it
> from its source but I didn't get an error trying to read it (cat <file>
>  > /dev/null)). I used diff and md5sum to double check: the file is fine=
.
>
> Result of stat <file> on the subvolume used as base for the snapshots:
>  =C2=A0 File: <file>
>  =C2=A0 Size: 1799195=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bl=
ocks: 3520=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IO Block: 4096 regular file
> Device: 0,36=C2=A0=C2=A0=C2=A0 Inode: 6676106=C2=A0=C2=A0=C2=A0=C2=A0 Li=
nks: 1
> Access: (0644/-rw-r--r--)=C2=A0 Uid: ( 1000/<uid>)=C2=A0=C2=A0 Gid: ( 10=
00/<gid>)
> Access: 2018-02-15 05:22:38.506204046 +0100
> Modify: 2018-02-15 05:21:35.612914799 +0100
> Change: 2018-02-15 05:22:38.506204046 +0100
>  =C2=A0Birth: 2018-02-15 05:22:38.486203934 +0100
>
> AFAIK the kernel logged a warning for nearly each snapshot of the same
> subvolume (they were all created after the file), the subvolume from
> which snapshots are created is root 257 in the logs. What seems
> interesting to me and might help diagnose this is the pattern for
> offsets in the warnings.
> - There are 3 offsets appearing: 20480, 86016, 151552 (exactly 64k
> between them).
> - Most snapshots seem to report a warning for each of them.

This is how btrfs reports a corrupted data sector, it would go through
all inodes (including ones in different subvolumes) and report the error.

So it really means if you want to delete the file, you need to remove
all the inodes from all different snapshots.

So if you got a correct copy matching the csum, you can do a more
dangerous but more straight forward way to fix, by directly overwriting
the contents on disk.

> - Some including the original subvolume have only logged 2 warnings and
> one (root 151335) logged only one warning.
> - All of the snapshots reported a warning for offset 20480.
> - When several offsets are logged their order seems random.

One problem of scrub is, it may ratelimit the output, thus we can not
just rely on dmesg to know the damage.

>
> I'm attaching kernel logs beginning with the scrub start and ending with
> the last error. As of now there are no new errors/warnings even though
> the scrub is still ongoing, 15 hours after the last error. I didn't
> clean the log frombalance logs linked to the same filesystem.
>
> Side-note for the curious or in the unlikely case it could be linked to
> the problem:
> Historically this filesystem was mounted with ssd_spread without any
> issue (I guess several years ago it made sense to me reading the
> documentation and given the IO latencies I saw on the Ceph cluster). A
> recent kernel filled the whole available space with nearly empty block
> groups which seemed to re-appear each time we mounted with ssd_spread.
> We switched to "ssd" since then and there is a mostly daily 90mn balance
> to reach back the previous stateprogressively (this is the reason behind
> the balance related logs). Having some space available for new block
> groups seems to be a good idea but additionally as we use Ceph RBD, we
> want it to be able to deallocate unused space: having many nearly empty
> block groups could waste resources (especially if the used space in
> these groups is in <4MB continuous chunks which is the default RBD
> object size).
>
>
> More information :
> The scrub is run monthly. This is the first time an error was ever
> reported. The previous scrub was run successfully at the beginning of
> May with a 6.6.13 kernel.
>
> There is a continuous defragmentation process running (it processes the
> whole filesystem slowly ignoring snapshots and defragments file by file
> based on a fragmentation estimation using filefrag -v). All
> defragmentations are logged and I can confirm the file for which this
> error was reported was not defragmented for at least a year (I checked
> because I wanted to rule out a possible race condition between
> defragmentation and scrub).

I'm wondering if there is any direct IO conflicting with buffered/defrag I=
O.

It's known that conflicting buffered/direct IO can lead to contents
change halfway, and lead to btrfs csum mismatch.
So far that's the only thing leading to known btrfs csum mismatch I can
think of.

But 6.x kernel should all log a warning message for it.

Thanks,
Qu
>
> In addition to the above, among the notable IO are :
> - a moderately IO intensive PostgreSQL replication subscriber,
> - ponctual large synchronisations using Syncthing,
> - snapshot creations/removals occur approximately every 80 minutes. The
> last snapshot operation was logged 31 minutes before the errors (removal
> occur asynchronously but where was no unusual load at this time that
> could point to a particularly long snapshot cleanup process).
>
> To sum up, there are many processes accessing the filesystem but
> historically it saw far higher IO load during scrubs than what was
> occurring here.
>
>
> Reproducing this might be difficult: the whole scrub can take a week
> depending on load. That said I can easily prepare a kernel and/or new
> btrfs-progs binaries to launch scrubs or other non-destructive tasks the
> week-end or at the end of the day (UTC+2 timezone).
>
> Best regards,
>
> Lionel Bouton

