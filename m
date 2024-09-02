Return-Path: <linux-btrfs+bounces-7725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAF89682D3
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 11:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6155A1C21A1F
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015018757C;
	Mon,  2 Sep 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Rg5mrh4p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7234F18734B;
	Mon,  2 Sep 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268369; cv=none; b=oLc/eTveOa21ZMgUCWM8hA6oSpAZk+pcFp1s5iq/omL97WSAmro9WQE3+tPf4JhLaX+mj2oVlY/nBqSGSjxGPRe33Dr8hTzGHWsPN05+zhdQfQ8SYokrau1EQE0pg4lnfcivN1puVOOpKZbQ8r4oOMgG3YxI7WVIAfO4cMu7ML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268369; c=relaxed/simple;
	bh=S92NC47Qc0wJvYxRIpp/x4JE9fuaORvOexnu1yfGB0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUNrMJRnorCLzN8cXOvOWuwzEzCmiMIknP/46G/r7A0RuWqXfWLRr1i4pUcU7BkRT9pDkb0ecLcYg/5NVnoKzBtnsvb0SS0RbHANIYRruvVnxseYzA05RDa8RRpNNHbpVhqM7ZiBbgpVGTAIpWM/tzY07BSVcnZf8zCKjwbE8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Rg5mrh4p; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725268358; x=1725873158; i=quwenruo.btrfs@gmx.com;
	bh=0cCbof5mnQkwHeMLnS55VGwZEQ64LyCqZ2LkiuaG+OY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Rg5mrh4ptY4nH3dDUL8QG8FyrzYN3S3NHjBz3RmZkt7K4Vsf0B9NvH4NFs6/9keG
	 ApO8g6cB3ZFkum2A4udsVrvOU+7qKV3KQeWz7d18TDpn2+yLIW9pUH8z+0stbz9k1
	 CzpNcTQhLLqSLlhTxYU2rnnMIgC14Re5RI4skYtAnM4meHEY9yjOjthr/JXS3XSBQ
	 fm0KrgiB362njJDJlf4u0hv2Upaugdn/Vcu9ZiUR5+QemS/ei186XiWAoqxvBLm5S
	 3SjKPylg//a7wF8Xg3I0+99z+rchtsaTgpNzwfgnZxXC76whu7coSznXDZn6+DdXc
	 FQ7/pkkbT8KaG4Cwkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHoRA-1soxP93GXG-00Cu8G; Mon, 02
 Sep 2024 11:12:38 +0200
Message-ID: <22c49ecd-e268-4738-853e-9f79ea1e87f7@gmx.com>
Date: Mon, 2 Sep 2024 18:42:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Don't block system suspend during fstrim
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240822164908.4957-1-luca.stefani.ge1@gmail.com>
 <400d2855-59c2-47d2-9224-f76f219ae993@gmail.com>
 <745754f6-0728-4682-95a0-39807675bb18@gmx.com>
 <CAO0HQ0X3zk6aau50Ew2nmNP-pwNEkmgAoC2Ewmi30sGi7uQwDA@mail.gmail.com>
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
In-Reply-To: <CAO0HQ0X3zk6aau50Ew2nmNP-pwNEkmgAoC2Ewmi30sGi7uQwDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p7FmOurjr57rZL1yQqpuanAebvUlALxaM9j5VaEGyVF55oYsWov
 9mtW6M3SVArompSvH/cAlkrTzUeOP0MSdjuK/cmg+a187pALIOCQ0M8kmtJI1J0yTz2tanw
 dl6yJQ3Yu9NskXqRfnqYGA5XzvXwJEZzO87PAQqQvfAMEM9tBPVw1GZgSyke3ZLaXXSWx2f
 v5ybQApqgEHP9mTB2+1MA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jq7tX5DSX90=;e1k2WSn/MMGFZX01Wd/EusHG1E0
 4ZCs2n5L4Ka/8sEyIjOs0aN2OA54U7S0cjdn7diwAc/pY4X0+IucCFPSPHEc3C1KojfsrEqXu
 JAQEHIomrpBqctODr/YWHm5BfQlngDI5uC29/KuknSnp3FzV7ZcBMJ0HsdoOZg2+A6iObnQru
 6T1F3Iy/zGo/lbK54QFv1Xgyxjrgievf6EMZfEdKtp/Bq1+suHVPsiDf528nphYUU8OY3cqCB
 ijWvvg77o51BpdhddDjMOMzk4Kg7yty6iZTT5u/XxsUJVYuGUvELw3ivlzz8pI0RRy5C5VlT7
 slvIsAMK2lvMqBAsVgQN4m/XSwDKEdtD95SNyUCoX2dNniOnvAHwHcJM/ua3VyvXLjKjDl/sV
 jn41cPIIauM2Hm3IPIZAkXCBzdl5QVh9MHy1qE7mkGDprLgUCGjenZsHx0g+QuY1JGlLryvSn
 oU1tyS4CJ7wzDOIYcKlT61Iqlw2uVqBdrecTjy8E3XKG8g7G36VDrLAGrdg/l9Mt6APMwO0DE
 AvRuaUNlWMCDKuLDECuH7hYABKhiLDthKlbW78Xx6eK2VKZn1J69yw32hzYRWkwW537vMpKCp
 0Im4Gfkn48Mx5H6d7lYVRxigqLNgKvpt5JZnGooRRHp2NQkthpOYD6/mjfcoqPjFmgas/IGpp
 DLgVjvqwhEotumMJeRxyd0unI7m1DrUcGz/DrMtl3ivUg3BON4V6yF2w3QF/9kch+WVYG967T
 sAVd9wkvJ1i9ukDwlutKWRO1ngWSLz+wf0UdIup7ucCDsi4qOACvRhjgFB8rgRlSsZvCvMrtu
 nOtkyirIe0CRY9CyOlm6JBAUhPBiRxj5f/prf1aoM66Qg=



=E5=9C=A8 2024/9/2 18:30, Luca Stefani =E5=86=99=E9=81=93:
>
>
> On Mon, 2 Sept 2024 at 10:49, Qu Wenruo <quwenruo.btrfs@gmx.com
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>
>
>
>     =E5=9C=A8 2024/9/2 18:02, Luca Stefani =E5=86=99=E9=81=93:
>      > Any update on this? It's not critical but I'd like to know if it'=
s in
>      > some part proper.
>      > Thanks, Luca.
>
>     Sorry I didn't see your patch in the list, thus sent a different fix=
 for
>     it later:
>
>     https://lore.kernel.org/linux-btrfs/20240830185113.GW25962@twin.jiko=
s.cz/T/#t <https://lore.kernel.org/linux-btrfs/20240830185113.GW25962@twin=
.jikos.cz/T/#t>
>
>      >> Sometimes the system isn't able to suspend because
>      >> the task responsible for trimming the device isn't
>      >> able to finish in time.
>      >>
>      >> Since discard isn't a critical call it can be interrupted
>      >> at any time, we can simply report the amount of discarded
>      >> bytes in such cases and stop the trim.
>      >>
>      >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219180
>     <https://bugzilla.kernel.org/show_bug.cgi?id=3D219180>
>      >> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com
>     <mailto:luca.stefani.ge1@gmail.com>>
>      >> ---
>      >> I have no idea if that's correct, just something I implemented
>      >> looking at the same solution made in ext4 by 5229a658f645.
>      >>
>      >> The patch in itself seems to solve the issue.
>      >>
>      >> repro is as follows:
>      >> sudo /sbin/fstrim --listed-in /etc/fstab:/proc/self/mountinfo
>      >> --verbose --quiet-unsupported &
>      >> sudo ./sleepgraph.py -m mem -rtcwake 5
>      >>
>      >> [836563.289069] PM: suspend exit
>      >> [836563.909298] PM: suspend entry (s2idle)
>      >> [836563.935447] Filesystems sync: 0.026 seconds
>      >> [836563.951391] Freezing user space processes
>      >> [836583.958957] Freezing user space processes failed after 20.00=
7
>      >> seconds (1 tasks refusing to freeze, wq_busy=3D0):
>      >> [836583.959582] task:fstrim=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 state:D stack:0=C2=A0=C2=A0=C2=A0=C2=A0 pid:241865
>      >> tgid:241865 ppid:241864 flags:0x00004006
>      >> [836583.959592] Call Trace:
>      >> [836583.959595]=C2=A0 <TASK>
>      >> [836583.959600]=C2=A0 __schedule+0x400/0x1720
>      >> [836583.959612]=C2=A0 ? mod_delayed_work_on+0xa4/0xb0
>      >> [836583.959622]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959628]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959631]=C2=A0 ? blk_mq_flush_plug_list.part.0+0x1e3/0x61=
0
>      >> [836583.959640]=C2=A0 schedule+0x27/0xf0
>      >> [836583.959644]=C2=A0 schedule_timeout+0x12f/0x160
>      >> [836583.959652]=C2=A0 io_schedule_timeout+0x51/0x70
>      >> [836583.959657]=C2=A0 wait_for_completion_io+0x8a/0x160
>      >> [836583.959663]=C2=A0 submit_bio_wait+0x60/0x90
>      >> [836583.959671]=C2=A0 blkdev_issue_discard+0x91/0x100
>      >> [836583.959680]=C2=A0 btrfs_issue_discard+0xc4/0x140
>      >> [836583.959689]=C2=A0 btrfs_discard_extent+0x241/0x2a0
>      >> [836583.959695]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959702]=C2=A0 do_trimming+0xd2/0x240
>      >> [836583.959712]=C2=A0 trim_bitmaps+0x350/0x4c0
>      >> [836583.959723]=C2=A0 btrfs_trim_block_group+0xb8/0x110
>      >> [836583.959729]=C2=A0 btrfs_trim_fs+0x118/0x440
>      >> [836583.959734]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959738]=C2=A0 ? security_capable+0x41/0x70
>      >> [836583.959746]=C2=A0 btrfs_ioctl_fitrim+0x113/0x180
>      >> [836583.959752]=C2=A0 btrfs_ioctl+0xdaf/0x2670
>      >> [836583.959759]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959763]=C2=A0 ? ioctl_has_perm.constprop.0.isra.0+0xd8/0=
x130
>      >> [836583.959774]=C2=A0 __x64_sys_ioctl+0x94/0xd0
>      >> [836583.959782]=C2=A0 do_syscall_64+0x82/0x160
>      >> [836583.959790]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959793]=C2=A0 ? syscall_exit_to_user_mode+0x72/0x220
>      >> [836583.959799]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959802]=C2=A0 ? do_syscall_64+0x8e/0x160
>      >> [836583.959807]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959811]=C2=A0 ? do_sys_openat2+0x9c/0xe0
>      >> [836583.959821]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959825]=C2=A0 ? syscall_exit_to_user_mode+0x72/0x220
>      >> [836583.959828]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959832]=C2=A0 ? do_syscall_64+0x8e/0x160
>      >> [836583.959835]=C2=A0 ? syscall_exit_to_user_mode+0x72/0x220
>      >> [836583.959838]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959842]=C2=A0 ? do_syscall_64+0x8e/0x160
>      >> [836583.959845]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959849]=C2=A0 ? do_syscall_64+0x8e/0x160
>      >> [836583.959851]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959855]=C2=A0 ? do_syscall_64+0x8e/0x160
>      >> [836583.959858]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959861]=C2=A0 ? do_syscall_64+0x8e/0x160
>      >> [836583.959864]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959868]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
>      >> [836583.959873]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
>      >> [836583.959878] RIP: 0033:0x7f3e4261af2d
>      >> [836583.959944] RSP: 002b:00007ffec002f400 EFLAGS: 00000246
>     ORIG_RAX:
>      >> 0000000000000010
>      >> [836583.959950] RAX: ffffffffffffffda RBX: 00007ffec002f570 RCX:
>      >> 00007f3e4261af2d
>      >> [836583.959952] RDX: 00007ffec002f470 RSI: 00000000c0185879 RDI:
>      >> 0000000000000003
>      >> [836583.959955] RBP: 00007ffec002f450 R08: 0000562d74da7010 R09:
>      >> 00007ffec002e7f2
>      >> [836583.959957] R10: 0000000000000000 R11: 0000000000000246 R12:
>      >> 0000562d74daafc0
>      >> [836583.959960] R13: 0000000000000003 R14: 0000562d74daa970 R15:
>      >> 0000562d74daad40
>      >> [836583.959967]=C2=A0 </TASK>
>      >> ---
>      >> =C2=A0 fs/btrfs/extent-tree.c | 20 ++++++++++++++++----
>      >> =C2=A0 1 file changed, 16 insertions(+), 4 deletions(-)
>      >>
>      >> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>      >> index feec49e6f9c8..7e4c1d4f2f7c 100644
>      >> --- a/fs/btrfs/extent-tree.c
>      >> +++ b/fs/btrfs/extent-tree.c
>      >> @@ -16,6 +16,7 @@
>      >> =C2=A0 #include <linux/percpu_counter.h>
>      >> =C2=A0 #include <linux/lockdep.h>
>      >> =C2=A0 #include <linux/crc32c.h>
>      >> +#include <linux/freezer.h>
>      >> =C2=A0 #include "ctree.h"
>      >> =C2=A0 #include "extent-tree.h"
>      >> =C2=A0 #include "transaction.h"
>      >> @@ -6361,6 +6362,11 @@ void btrfs_error_unpin_extent_range(struc=
t
>      >> btrfs_fs_info *fs_info, u64 start, u6
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unpin_extent_range(fs_info, start=
, end, false);
>      >> =C2=A0 }
>      >> +static bool btrfs_trim_interrupted(void)
>      >> +{
>      >> +=C2=A0=C2=A0=C2=A0 return fatal_signal_pending(current) || free=
zing(current);
>      >> +}
>      >> +
>      >> =C2=A0 /*
>      >> =C2=A0=C2=A0 * It used to be that old block groups would be left=
 around
>     forever.
>      >> =C2=A0=C2=A0 * Iterating over them would be enough to trim unuse=
d space.
>     Since we
>      >> @@ -6459,8 +6465,8 @@ static int btrfs_trim_free_extents(struct
>      >> btrfs_device *device, u64 *trimmed)
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start +=
=3D len;
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *trimmed =
+=3D bytes;
>      >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fatal_signal_pen=
ding(current)) {
>      >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D -ERESTARTSYS;
>      >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_trim_inter=
rupted()) {
>      >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D 0;
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
>
>     Here we should still return the same error number other than 0, to l=
et
>     the caller know the operation is interrupted, other than finished
>     normally.
>
> Here I was following how ext4 did it, my explanation for that was that
> the kernel
> may have still discarded some data before the thread was interrupted
> thus it made
> sense to report success.

In that case, progress is reported through fstrim_range structure, not
through the return value.
Even if we returned some error code, the fstrim_range::len is still
updated to indicate the progress.

So we need to keep the error code.

>
>
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>      >> @@ -6508,6 +6514,9 @@ int btrfs_trim_fs(struct btrfs_fs_info
>     *fs_info,
>      >> struct fstrim_range *range)
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache =3D btrfs_lookup_first_bloc=
k_group(fs_info, range->start);
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (; cache; cache =3D btrfs_nex=
t_block_group(cache)) {
>      >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_trim_inter=
rupted())
>      >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
>      >> +
>
>     The same here.
>
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache=
->start >=3D range_end) {
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 btrfs_put_block_group(cache);
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
>      >> @@ -6547,17 +6556,20 @@ int btrfs_trim_fs(struct btrfs_fs_info
>      >> *fs_info, struct fstrim_range *range)
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&fs_devices->device_li=
st_mutex);
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry(device, &fs_d=
evices->devices, dev_list) {
>      >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_trim_inter=
rupted())
>      >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
>      >> +
>
>     The same here.
>
>     Furthermore, I think we may not need the extra checks.
>
>     The fstrim is based on block groups, and a block group is normally 1=
GiB,
>     at most 10GiB (for RAID0/5/6/10 only), thus exiting at each block gr=
oup
>     boundary should be enough to meet the hibernation/suspension timeout=
.
>
> That's probably true, but 10seconds=C2=A0here wasn't enough and forcing =
the
> early return in the other cases
> was also required.
> I tried the current patch you linked earlier in my testing and that was
> the conclusion that led to me adding more checks.

My bad, I forgot that we have free extents trimming, which is not
limited to block group boundary, and that may be the root cause.

So in that case your extra checks are indeed needed.

Just need to change the return value.
>
>
>
>
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_=
bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 continue;
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D b=
trfs_trim_free_extents(device, &group_trimmed);
>      >> +
>      >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trimmed +=3D group_t=
rimmed;
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =
{
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dev_failed++;
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dev_ret =3D ret;
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>      >> -
>      >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trimmed +=3D group_t=
rimmed;
>
>     Any special reason moving the code here?
>
> Same as not returning errno before in case of interrupt, I checked the
> code paths and it's still
> possible to trim some data (group_trimmed !=3D 0) even in case of failur=
e.

Oh, then it's fine.

Except the return code, everything looks fine to me now.

Just please update the commit message to explicitly mention that, we
have a free extent discarding phase, which can trim a lot of unallocated
space, and there is no limits on the trim size (unlike the block group
part).

Thanks,
Qu
>
>     Thanks,
>     Qu
>
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&fs_devices->device_=
list_mutex);
>      >
>

