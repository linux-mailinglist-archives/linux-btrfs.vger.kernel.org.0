Return-Path: <linux-btrfs+bounces-6983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AAC9477D7
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 11:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7BC282873
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 09:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666351547E7;
	Mon,  5 Aug 2024 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NEl2s/Zt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2814F9E6
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848405; cv=none; b=beVTw1peZuX/XFwzqWc5axoKhKgQAAgFXYe1lBTXa9N2RWCOmfUYpxSGIaCkw/47x6XTKfI6fKD/3QGImmi6s4U6rV5pHS8BVXdG8y0WiHptHJ5NIWnwlvWU0B9bvcldvkTsoMwADhk10RKYkz/rzJSNeFCPI0P2XX+JZ3KFHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848405; c=relaxed/simple;
	bh=72cGIOuSALTvRRW0t+4QmW5gfxnHg9//W5rsoFuLSeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKYmoMwTHsRKysIPZavLoyjnQk+Q3Ii6ru51GfHZ/TetMOAi8nXvtynFeYAjMK4cDKl82ZizCZBixzMoD1jCmeZK/fBh3qXo7ix169MSDGdl1Yr5H3eFrYkElT2Rcn/UMKIJ2jpsUNfu4guLQnxy4fYrHSPEuhnfeqIciEldWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NEl2s/Zt; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722848385; x=1723453185; i=quwenruo.btrfs@gmx.com;
	bh=okn3Z/GmMNP4l8p/9q4JnZrQx2aG89nf9s+JK/dE7xc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NEl2s/Ztx6w2fObkeX88DpK1ZJ3rGd77WT2RuyYIRUIumJS8sK4JcyYkSguItbaQ
	 Oc7RSdhnwFx84Y3ne92II/rOMCacZj8Drg3end0xIpNFGDfhkPLMfZgTCNXxLF2xc
	 N4jPd0uetBODb3wN/zfnypbQ1r3COTxZ5vU8OsObM+Az2VlpFDATnnAymVTtv78aX
	 dtRcbyKxS9FucYWWt/alCb+p5k6QcW8r6tWnW4YeCKbJU7DVla2DOUMpmEOpD5nVF
	 lZpj4VJWUaClJJRhZ96WMHZCgp2Gu2xmj8RzEPFhWiQtgAMI6AQxQAHdMowkqv6f8
	 1p144/xmRq0mbMgEJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MowGU-1rsEZC2gLG-00c6wE; Mon, 05
 Aug 2024 10:59:45 +0200
Message-ID: <086eee00-f2f3-420a-abd4-771f6098fd2c@gmx.com>
Date: Mon, 5 Aug 2024 18:29:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Force remove of broken extent/subvolume? (Crash in
 btrfs_run_delayed_refs)
To: "Emil.s" <emil@sandnabba.se>, Yuwei Han <hrx@bupt.moe>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <CAEA9r7DVO8gCRz-9vbwaNWznz9AOFxOyPLO0ukOJh-6Ef0o5Bw@mail.gmail.com>
 <20240725224757.GD17473@twin.jikos.cz>
 <aeed4735-f6f2-49ef-9a02-816a3b74cbd3@gmx.com>
 <CAEA9r7AzYtQ9BifUPcW3=1zz=RmS9Fb3CnProGMg6GVkmd14TQ@mail.gmail.com>
 <2598F89C9D10565B+29575f56-c98e-4316-8360-0e3e9e7748ff@bupt.moe>
 <CAEA9r7CaJJRvDZ3iL9LuKtgi-xO+R-qOxiUg-4Ms-vzG_y+Y5g@mail.gmail.com>
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
In-Reply-To: <CAEA9r7CaJJRvDZ3iL9LuKtgi-xO+R-qOxiUg-4Ms-vzG_y+Y5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ACPiHWCAj4C+sIa/pzNm3nMq8Xo9OfXXKKRTlBeluzuZVGcThK/
 pU2dwqg6tSFzip2kGaeZrUJ8FJcoyMzuim6gmTjKLWBo5AwjimtnlV4kqKd1H8JNWjUdc3d
 cSqbA9lqCg8ZC079duoKfuFTv2ZcpXWPGDVjE5SVw0sTOxujCE8N1dziLwSRQF2yBJ6eHld
 ykEfhvZg8L1VCjSyZO7aw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kf4TnuYUpUs=;t2APyqqo5c0tX7IMudkX3bUxsob
 ym34OHFKgrTQfwY0jviet/9s/yGKMRJeII2BeZ9CkZk/8sYf/fqbmyjlRns7kofNgI4FwT1YS
 WeYx4ku5/Ob3d34TYY3EAy/w/hxDXHJbnC1M4eLQkOj6ekGje9SsEPAwn39N4V3lrHFbAebok
 QAV8CAplImHhgzaJ4mnSxcvkIsa4d85ysjU9k9zT0/Bry8M1WsvB8BSSwqkIJXOKQLQNOLZs3
 +iddUzWp7WDxJ98kHxFo9ZBvYh97zJ0dcFQfIf5zh9zsCXd0a6Uxb6kVqkeYGE5+JfAKlTR2v
 FvJMkzak6uwCeH3nDXEHuO9A9JFLxcVw+A8EcDQcYBOnH1jaBS0uW+Q/Bp+9NNYs2H0j3RBWx
 veLsiyK/HoL/BOYodf1ayePDTwMdyJMtO9Zz+8PjvzLtw+weoNbBhVbt9F8MlpMFC010ts4We
 97vnC0dP/SIeXLaj7TT7FYWuw60v8XIGWcU2pJvuYyV2sOWyWZYjVNdT2ukcui6IFSZEymAAF
 YF9sWq0NEKjqvrY0chmP2R0dh+SG9AC43FRpV5c0Etu53uXk53lfjqa4zRUtgZukenH0FC+h2
 rhEHoH0IZznd5pyIyOBJAZVW51Eg5XiJ5uOXrKheLjrRxezXsYPCJhCZmmF2VyDe2Jk+AjHVH
 XbN7xOXqo8irijKby4U7c3bDysZSrjkfegWT7jg9VdTw2cbdAxfja+0F6QPQb1Bp74JPvj9FD
 RjwG9dlp0VF1DYopymhqCCzIXHRX4OmSzTTZlpvMCf5K0ASSqx+wURBmADpDtWjZYNEWj4AbL
 eKhHEgJKT7/YDjhjKfHA0iWAVD1meO1c2UogYGFCaqzrA=



=E5=9C=A8 2024/8/5 17:46, Emil.s =E5=86=99=E9=81=93:
>> For curiosity, did you setup any scrub after rebuild FS?
>
> The new FS is built on new drives, on new hardware and new Linux
> kernel. And I'm rsyncing over all files so that everything will be
> built from scratch.
>
> However, I still got a snapshot (from 2024-03-20) on my offsite backup.
> I just scrubbed that drive, and it reports no errors. I'm also quite
> sure I scrubbed the corrupt drive quite recently without issues.
>
> Another interesting note is that I'm also unable to send any file
> system from the corrupt drive (which is probably a good thing).
> ```
> $ btrfs send /mnt/snapshots/user_data_2024-03-20 > /dev/null
> At subvol /mnt/snapshots/user_data_2024-03-20
> ERROR: send ioctl failed with -30: Read-only file system
> ```
>
> Wasn't expecting a "Read-only file system" error when sending a
> read-only snapshot? (But maybe that is expected?).

In that case, please provide the dmesg of that incident. (if any)

It looks like something else is wrong.

Thanks,
Qu
>
>
> On Sun, 28 Jul 2024 at 18:09, Yuwei Han <hrx@bupt.moe> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/7/26 18:52, Emil.s =E5=86=99=E9=81=93:
>>>> As for any bitflip induced errors, it's hard to tell how far it got
>>>> propagated, this could be the only instance or there could be other
>>>> items referring to that one too.
>>>
>>> Right, yeah that sounds a bit more challenging then I initially though=
t.
>>> Maybe it is easier to just rebuild the array after all.
>>>
>>> And in regards to Qu's question, that is probably a good idea anyhow.
>>>
>>>> - History of the fs
>>>> - The hardware spec
>>>
>>> This has been my personal NAS / home server for quite some time.
>>> It's basically a mix of just leftover desktop hardware (without ECC me=
mory).
>>>
>>> It was a 12 year old Gigabyte H77-D3H motherboard, an Intel i7-2600 CP=
U
>>> and 4 DDR3 DIMMs, all of different types and brands.
>>> The disks are WD red series, and I see now that one of them has over
>>> 80k power on hours.
>>>
>>> I know I did a rebuild about 5 years ago so the FS was probably
>>> created using Ubuntu server 18.04 (Linux 4.15), which has been
>>> upgraded to the major LTS versions since then.
>>> I actually hit this error when I was doing the "final backup" before
>>> retiring this setup, and it seems it was about time! (Was running
>>> Ubuntu 22.04 / Linux 5.15)
>>>
>> For curiosity, did you setup any scrub after rebuild FS?
>>> The Arch setup on the Thinkstation is my workstation where I attempted
>>> the data recovery.
>>>
>>> So due to the legacy hardware and crappy setup I think it's worth
>>> wasting more time here.
>>>
>>> But thanks a lot for the detailed answer, much appreciated!
>>>
>>> Best,
>>> Emil
>>>
>>> On Fri, 26 Jul 2024 at 01:19, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>>>
>>>>
>>>>
>>>> =E5=9C=A8 2024/7/26 08:17, David Sterba =E5=86=99=E9=81=93:
>>>>> On Thu, Jul 25, 2024 at 11:06:00PM +0200, Emil.s wrote:
>>>>>> Hello!
>>>>>>
>>>>>> I got a corrupt filesystem due to backpointer mismatches:
>>>>>> ---
>>>>>> [2/7] checking extents
>>>>>> data extent[780333588480, 942080] size mismatch, extent item size
>>>>>> 925696 file item size 942080
>>>>>
>>>>> This looks like a single bit flip:
>>>>>
>>>>>>>> bin(925696)
>>>>> '0b11100010000000000000'
>>>>>>>> bin(942080)
>>>>> '0b11100110000000000000'
>>>>>>>> bin(942080 ^ 925696)
>>>>> 0b100000000000000'
>>>>>
>>>>> or an off by one error, as the delta is 0x4000, 4x page which is one
>>>>> node size.
>>>>>
>>>>>> backpointer mismatch on [780333588480 925696]
>>>>>> ---
>>>>>>
>>>>>> However only two extents seem to be affected, in a subvolume only u=
sed
>>>>>> for backups.
>>>>>>
>>>>>> Since I've not been able to repair it, I thought that I could just
>>>>>> delete the subvolume and recreate it.
>>>>>> But now the btrfs_run_delayed_refs function crashes a while after
>>>>>> mounting the filesystem. (Which is quite obvious when I think about
>>>>>> it, since I guess it's trying to reclaim space, hitting the bad ext=
ent
>>>>>> in the process?)
>>>>>>
>>>>>> Anyhow, is it possible to force removal of these extents in any way=
?
>>>>>> My understanding is that extents are mapped to a specific subvolume=
 as
>>>>>> well?
>>>>>>
>>>>>> Here is the full crash dump:
>>>>>> https://gist.github.com/sandnabba/e3ed7f57e4d32f404355fdf988fcfbff
>>>>>
>>>>> WARNING: CPU: 3 PID: 199588 at fs/btrfs/extent-tree.c:858 lookup_inl=
ine_extent_backref+0x5c3/0x760 [btrfs]
>>>>>
>>>>>     858         } else if (WARN_ON(ret)) {
>>>>>     859                 btrfs_print_leaf(path->nodes[0]);
>>>>>     860                 btrfs_err(fs_info,
>>>>>     861 "extent item not found for insert, bytenr %llu num_bytes %ll=
u parent %llu root_objectid %llu owner %llu offset %llu",
>>>>>     862                           bytenr, num_bytes, parent, root_ob=
jectid, owner,
>>>>>     863                           offset);
>>>>>     864                 ret =3D -EUCLEAN;
>>>>>     865                 goto out;
>>>>>     866         }
>>>>>     867
>>>>>
>>>>> CPU: 3 PID: 199588 Comm: btrfs-transacti Tainted: P           OE    =
  6.9.9-arch1-1 #1 a564e80ab10c5cd5584d6e9a0715907a10e33ca4
>>>>> Hardware name: LENOVO 30B4S01W00/102F, BIOS S00KT73A 05/24/2022
>>>>> RIP: 0010:lookup_inline_extent_backref+0x5c3/0x760 [btrfs]
>>>>> RSP: 0018:ffffabb2cd4e3b00 EFLAGS: 00010202
>>>>> RAX: 0000000000000001 RBX: ffff992307d5c1c0 RCX: 0000000000000000
>>>>> RDX: 0000000000000001 RSI: ffff992312c0d590 RDI: ffff99222faff680
>>>>> RBP: 0000000000000000 R08: 00000000000000bc R09: 0000000000000001
>>>>> R10: a8000000b5a8c360 R11: 0000000000000000 R12: 000000b5af81a000
>>>>> R13: ffffabb2cd4e3b57 R14: 00000000000e6000 R15: ffff9927ca7551f8
>>>>> FS:  0000000000000000(0000) GS:ffff992997980000(0000) knlGS:00000000=
00000000
>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> CR2: 00000ad404625100 CR3: 000000080ea20002 CR4: 00000000003706f0
>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>> Call Trace:
>>>>>     <TASK>
>>>>>     ? lookup_inline_extent_backref+0x5c3/0x760 [btrfs dcbea9ede49f94=
13c43a944f40925c800621e78e]
>>>>>     ? __warn.cold+0x8e/0xe8
>>>>>     ? lookup_inline_extent_backref+0x5c3/0x760 [btrfs dcbea9ede49f94=
13c43a944f40925c800621e78e]
>>>>>     ? report_bug+0xff/0x140
>>>>>     ? handle_bug+0x3c/0x80
>>>>>     ? exc_invalid_op+0x17/0x70
>>>>>     ? asm_exc_invalid_op+0x1a/0x20
>>>>>     ? lookup_inline_extent_backref+0x5c3/0x760 [btrfs dcbea9ede49f94=
13c43a944f40925c800621e78e]
>>>>>     ? set_extent_buffer_dirty+0x19/0x170 [btrfs dcbea9ede49f9413c43a=
944f40925c800621e78e]
>>>>>     insert_inline_extent_backref+0x82/0x160 [btrfs dcbea9ede49f9413c=
43a944f40925c800621e78e]
>>>>>     __btrfs_inc_extent_ref+0x9c/0x220 [btrfs dcbea9ede49f9413c43a944=
f40925c800621e78e]
>>>>>     ? __btrfs_run_delayed_refs+0xf64/0xfb0 [btrfs dcbea9ede49f9413c4=
3a944f40925c800621e78e]
>>>>>     __btrfs_run_delayed_refs+0xaf2/0xfb0 [btrfs dcbea9ede49f9413c43a=
944f40925c800621e78e]
>>>>>     btrfs_run_delayed_refs+0x3b/0xd0 [btrfs dcbea9ede49f9413c43a944f=
40925c800621e78e]
>>>>>     btrfs_commit_transaction+0x6c/0xc80 [btrfs dcbea9ede49f9413c43a9=
44f40925c800621e78e]
>>>>>     ? start_transaction+0x22c/0x830 [btrfs dcbea9ede49f9413c43a944f4=
0925c800621e78e]
>>>>>     transaction_kthread+0x159/0x1c0 [btrfs dcbea9ede49f9413c43a944f4=
0925c800621e78e]
>>>>>
>>>>> followed by leaf dump with items relevant to the numbers:
>>>>>
>>>>>          item 117 key (780331704320 168 942080) itemoff 11917 itemsi=
ze 37
>>>>>                  extent refs 1 gen 2245328 flags 1
>>>>>                  ref#0: shared data backref parent 4455386873856 cou=
nt 1
>>>>>          item 118 key (780332646400 168 942080) itemoff 11880 itemsi=
ze 37
>>>>>                  extent refs 1 gen 2245328 flags 1
>>>>>                  ref#0: shared data backref parent 4455386873856 cou=
nt 1
>>>>>          item 119 key (780333588480 168 925696) itemoff 11827 itemsi=
ze 53
>>>>>                        ^^^^^^^^^^^^^^^^^^^^^^^
>>>>>
>>>>>                  extent refs 1 gen 2245328 flags 1
>>>>>                  ref#0: extent data backref root 2404 objectid 11410=
24 offset 0 count 1
>>>>>          item 120 key (780334530560 168 942080) itemoff 11774 itemsi=
ze 53
>>>>>                  extent refs 1 gen 2245328 flags 1
>>>>>                  ref#0: extent data backref root 2404 objectid 11410=
25 offset 0 count 1
>>>>>          item 121 key (780335472640 168 942080) itemoff 11721 itemsi=
ze 53
>>>>>                  extent refs 1 gen 2245328 flags 1
>>>>>                  ref#0: extent data backref root 2404 objectid 11410=
26 offset 0 count 1
>>>>>
>>>>> as you can see item 119 is the problematic one and also out of seque=
nce, the
>>>>> adjacent items have the key offset 942080. Which confirms the bitlip
>>>>> case.
>>>>>
>>>>> As for any bitflip induced errors, it's hard to tell how far it got
>>>>> propagated, this could be the only instance or there could be other
>>>>> items referring to that one too.
>>>>>
>>>>> We don't have any ready made tool for fixing that, the bitlips hit
>>>>> random data structure groups or data, each is basically unique and w=
ould
>>>>> require analysis of tree dump and look for clues how bad it is.
>>>>>
>>>>
>>>> Since we're pretty sure it's a bitflip now, would you please provide =
the
>>>> following info?
>>>>
>>>> - History of the fs
>>>>      Since you're using Arch kernel, and since 5.14 we have all the w=
rite-
>>>>      time checkers, normally we should detect such out-of-key situati=
on by
>>>>      flipping the fs RO.
>>>>      I'm wondering if the fs is handled by some older kernels thus tr=
ee-
>>>>      checker didn't catch it early.
>>>>
>>>> - The hardware spec
>>>>      The dmesg only contains hardware spec "LENOVO 30B4S01W00", which=
 seems
>>>>      to be a workstation.
>>>>      I'm wondering if it's certain CPU models which leads to possible
>>>>      unreliable memories.
>>>>      From my experience, the memory chip itself is pretty rare to be =
the
>>>>      cause, but either the connection (from BGA to DIMM slot) or the =
memory
>>>>      controller (nowadays in the CPU die).
>>>>
>>>> Thanks,
>>>> Qu
>>>

