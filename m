Return-Path: <linux-btrfs+bounces-1330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168C2828ED0
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 22:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBB62842FE
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 21:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D81C3DB80;
	Tue,  9 Jan 2024 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LrFmmvfI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC983D551
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704835186; x=1705439986; i=quwenruo.btrfs@gmx.com;
	bh=4T1RKhJK+OuxzPyxdyWEzrKlSS0V8TVGd23+xM12Bus=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=LrFmmvfIRQ8ABBbfzLOeqzI6C5cT7QcKlP6zySRj1UrxfDfGOsGGmRarU2k4pdAK
	 NzgOLsUQR9TZUSPFTS0bCDt17KHm8twJfRXglLe/HB6UvET+sR6UaEsWlN5hwQ22k
	 thjRaVdZE143ImCAhLgESRZGZ2+bNH/BrYag4EXyvfxKJFdr+BjjFwbUE0iPw0Mi4
	 GDQzm2mP/7JPXsLrKuzFq01c/X1YjqjQFr82MVHm7P/PwgKvKAnjtFCvENSs3fFRs
	 Y4y+YopzYibK2HOnV2RW4qbZRdQ1L0M44WsqKsyKSgpL4gYk+bJp4VM3SA9t6ywnE
	 NBDnl1BXig/NMxtZZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.113.22]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv31c-1r5e8P44Bc-00r3k0; Tue, 09
 Jan 2024 22:19:46 +0100
Message-ID: <27fb4ed5-c3ce-4ab7-a3fd-d77dc8dd4fb2@gmx.com>
Date: Wed, 10 Jan 2024 07:49:42 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Scrub reports uncorrectable errors with correctable errors
 unrepaired, but all files are fine
Content-Language: en-US
To: Rongrong <i@rong.moe>, linux-btrfs@vger.kernel.org
References: <8bd12a1ee60172f53ee0c27374f41c3ec9976be8.camel@rong.moe>
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
In-Reply-To: <8bd12a1ee60172f53ee0c27374f41c3ec9976be8.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1zBKkSRtFbBRBbbCv6jV4VBJl53th8HBr2j6WrH/m2cxSKsD0fd
 ZtzNlXGbpL1a8zVCw1LSQkswEVnyXgLT2r61CSpayzgIstKtVDxLGqPblvrPFaT2YXlQWNe
 inIKVY8Lv/f8CkJ1XIFLrUUHnglE3QqhRJ/Ggcp9WTNGWPa31/6tV47OpOHos5xR5CUI5Nu
 sWn3WjyC7wWUTORy+eOJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1gulMhAugY8=;vOQX1IBXRzr4cE75m71YuQ7huEb
 /W3ozU4sq88Szpx7T2ZwHNoMYeb/8dLH3hqjUQmJveAwfJ3xycZo7/Ugel2l9MRIQcqJMtPw3
 lxfn6vX+WZOCG8xhevgDuOnmtZqHqyLAZEOTf4E+YYUaDkcpf2K2SNTqKTM5FF1ZBTByoLPCG
 pEMOtylddMH7m1fV/bxYjHFbNdiRBeROtS4gZH0ZX6dNRrNYmHYmarcZdZqKmlSviE4tZPweD
 fb4iuYxbuWRz0OU12XgJDoFSsAoSJEV74VKrEA1kaZZlV2VcRdf4E0O1YRRnFUEOmr2MBnq2p
 m82pl7+d8g36pS1xRhjZrI1oFKJJUG64vaW1Y8powv/6Mgq6GA7oYPvdeSxoMvcorbnobZE5u
 J5dMPQbXo3fG3yLBV7FFmrsFMJ1CzIBL957wd5UPGxusZ6cyfFVstBAsBDo43i0ihK/FYWUdi
 nM93INRVTopRMdtNwxv3CU/YxT8vBFCvdTVYp6bKivetTiNU/51lnqzNeQ5ZldN4lurcM9nSP
 SDLRm3yX51s0ic2WxCOC/4O/s9czlEadcedXwC/UbFsntgsMPbWkRTEduZQi60GAnYmHG4+fB
 uUocYwv7LxkgLKUqfQC+JcWXJBbkdNKKTE2EgbbnZvrLtExjxEZgjp8sbRv9GAc5eURkxqZJI
 kxXJ2ySUl+RPpR79mrHnA7IQWqCdWMVMHHf3KI/WRZzk6ip7Ww3VNtSh81JDsgOp3Lc074D+D
 hOmy2c+L7kX8aKZ8BtZ83VCcsW7zTn+m4b5coehLyFOcAH1X9KepXNMuWgWF7k8Q2rQ2DjDtg
 jOxSQRS7bL71tDpumCD7koffQhYqrDoLE9uSnEC77AKWWUnGjjHIBqtbYrw/2flpYfr+m9UCR
 wuj9/j66TSh1O6nXQ8vZFBFCUEAHAuHU2IfK1An98i3sUUS+FL9L0fOhoUp3BeungwB8XxEpT
 gCX0bQ==



On 2024/1/10 04:36, Rongrong wrote:
> Hi all,
>
> I recently scrubbed my fs and saw multiple correctable and
> uncorrectable errors. Weirdly, the correctable errors did not really
> get repaired ("fixed up") after the scrub was finished. It just
> persisted and reappeared in the next scrub. But surprisingly, when I
> tried to archive all files using `rsync -aAHUXxvP /path/to/mountpoint
> /path/to/archive` (the fs has no subvolume other than <FS_TREE>), no
> error was raised (both rsync and dmesg) and all files were fine. Both
> `btrfs check` and `btrfs check --check-data-csum` also finished without
> error.
>
> I tried many kernel versions, including 6.5.13, 6.6.10 and 6.7-rc8.
> btrfs-progs is 6.6.3. The fs is mounted with the below parameters:
> autodefrag,compress-force=3Dzstd,relatime
>
> Each time a scrub gets finished, the error summary is the same:
>
> Error summary: read=3D416
> Corrected: 168
> Uncorrectable: 248
> Unverified: 0
>
> Only two types of errors were shown in dmesg:
>
> BTRFS critical (device [D]): unable to find chunk map for logical
> [LoUc] length [LeUc]
> BTRFS error (device [D]): fixed up error at logical [LoC] on dev
> /dev/[D] physical [PhC]
> (all [PhC] just equaled to the corresponding [LoC])
>
> I randomly picked some addresses and did some research:
>
> # btrfs inspect-internal inode-resolve [LoUc] /path/to/mountpoint
> ERROR: ino paths ioctl: No such file or directory
> # btrfs inspect-internal logical-resolve [LoUc] /path/to/mountpoint
> ERROR: ino paths ioctl: No such file or directory
> # btrfs inspect-internal dump-tree -b [LoUc] /dev/[D]
> btrfs-progs v6.6.3
> Invalid mapping for [LoUc]-[LoUc+16384], got [Lo1]-[Lo2]
> Couldn't map the block [LoUc]
> ERROR: failed to read tree block [LoUc]
> # btrfs inspect-internal inode-resolve [LoC] /path/to/mountpoint
> ERROR: ino paths ioctl: No such file or directory
> # btrfs inspect-internal logical-resolve [LoC] /path/to/mountpoint
> /path/to/file
> # btrfs inspect-internal dump-tree -b [LoC] /dev/[D]
> btrfs-progs v6.6.3
> checksum verify failed on [LoC] wanted [csum1] found [csum2]
> ERROR: failed to read tree block [LoC]
>
> I checked the commit log of fs/btrfs/scrub.c, and tried scrub on
> 6.3.12. The scrub finished without error. I assume this is intended as
> 0096580713ffc061a579bd8be0661120079e3beb was simply not back-ported.

This should not be the case, that commit should only be included in
newer kernels with the reworked scrub, or it doesn't need to be
backported at all.

>
> I guess the root cause of the issue is that one of the DUP metadata
> copies was somehow corrupted. Am I right?

I don't think so, I think there may be some false alerts, either from
kernel scrub interface, or btrfs-progs.

> I am to confirm:
> 1. is this behavior (false "fixed up") of scrub intended?

Nope. Considering "btrfs check" and "btrfs check --check-data-csum" is
totally fine, this should be a bug related to scrub.

> 2. why btrfs check finished without error under such a circumstance?

Because that is probably the real case.

> 3. since all files were fine and btrfs check finished without error,
> should these "uncorrectable" errors be actually correctable?

I believe it's some bugs, either from scrub functionality of btrfs
kernel module, or btrfs-progs reporting.

Would you please try the following?

- A different btrfs-progs to do the same scrub
   To rule out some btrfs-progs regression.

- "btrfs scrub start -RD"
   This shows the raw data reported, including where the corruptions are
   (data/metadata, and scrubbed bytes etc).

- Do a readonly scrub on a readonly mounted btrfs
   Just to rule out any write-time races, which can help us to pin down
   the possible cause.

Thanks,
Qu

>
> I have a full dump of the disk. As long as needed, I can provide
> further debug assistance and more information about the fs.
>
> Thanks,
> Rongrong
>

