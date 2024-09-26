Return-Path: <linux-btrfs+bounces-8275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F010F987B29
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 00:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC80A1C21DE3
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 22:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3BA18EFF0;
	Thu, 26 Sep 2024 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TbdhLh/q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D118EFE1
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727389761; cv=none; b=Wj741hS4NiZCwspRi2LgaGFEmMtGyz5RZtzC1ryg7tOoGr1chAgAPp9FP45jvzpCEQDCWfAxmsU6tA/CZLjyXmdiTfFKc83SRo8oQ/De3YrwFWf7ltCh7vD6tfsHXQLUiVBhvmNnKWCS9TPYD4mskKtaAv94eDjfm9Y5l1WwKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727389761; c=relaxed/simple;
	bh=0z/5a+l2P7K21yT+9BgxNa6pJ5WxoWR264QUHKQbJe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=RDkbMkZGMcePv3LhqeDGYhNQzY7cuxaN8PoY+a/pwSLyfCLUmfLLi0p5PjrXx0LuuN8NQqjAq7+fWFSMgt1AOa8eSqkNSMWeW0Bp33crYeJAjaVozONk4HmHPNNHFSurxIlyW9AYmKoWELDT9k52/ZTqceJXSjBZE4yFEHdWdgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TbdhLh/q; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727389750; x=1727994550; i=quwenruo.btrfs@gmx.com;
	bh=ulakFDmS9LFjx8Bs0BJ1X49e6dFTPIddgJesqX2KCgI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TbdhLh/qgTTzE6FzmpVP/JqPfTYlBfvopfjCo8sf9nYzO6TzPE4OrfE9p5VtLm1T
	 eyAVn/BJk0MYmYkv7HlRfLABVsZ3MRyTm92vsLclpzzKSzsZZ+d2hzWZDXvR3jFYg
	 mYr01+jdIgt1acV8CnPPr51w6qh7LvrVIEkOWm03eeieCV/YcWKsPPG7Qc/G5yTXU
	 MWlGChfcX+8kR0d3nZi3VDudFoYZibnN9wh3wiAT4WdP8ubiKyKq/t9RsRZ1ooOWg
	 6hFQbh35dGG+0O3WWIBAhlG7RDfcCZVdzRd+kijS7ZREoz6EsXwe3PvakSF3u7ZEc
	 UPp+LHxnqNIOaIph3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4b1y-1stPHf0ynu-004kg7; Fri, 27
 Sep 2024 00:29:09 +0200
Message-ID: <1171b314-be9d-40cf-b3ab-b68b03a96aa2@gmx.com>
Date: Fri, 27 Sep 2024 07:59:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ERROR: failed to clone extents to [...]: Invalid argument
To: Ben Millwood <thebenmachine@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com>
Content-Language: en-US
Cc: Filipe Manana <fdmanana@kernel.org>
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
In-Reply-To: <CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vvpInKC7i2KSBqQ2LV4hTq8l62tQLF54DqBHZWKRgJbRGQdJ9S6
 iYIlKpE+Wdkj3sZwtisHsUR8+Lk+hx+da1maw+VAj/5eL1TXzSvpudevDomuyA1sC9oO6z3
 6iWru90G/97w8Ursx25+pAwN1hyDWDRfNp23VskGwf4GPlypgDHVUzVR1qVfZVHld5OUiFu
 9lwjhPSIIJ39Fxbi87bOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I9AX4lrsgGw=;MVPMkOfYWHwitSM6aP6f1zJpRxg
 xW/VXcm73LI4n9D58sroxgJAJuBj9DifcuGf/FdMyDpsy0HhxVpsjrcqogUBi7a1g54aXx6pP
 m8HUfxBl3n1JzJO62Kuka3ETeDOPmSRFiW7IUfsMJNaeLZEmZmhnEl2DAZc2HUUXZxo4T0/Lu
 eCBTaAq3/h9G5/oCxR0YOr+ECwI0oiWOC6rxgjrWMmUnJ/VClaS4QaW6SW5hl6otO/TsORpIl
 HXYbNYyxcM5teh1kh5K6RBQ58i54oaYdKGNPbBXr6PJ/k1YdeX/qZmgbwstlzpYp3GzjPUQ7+
 MNcHThERShJhZICZhno8wdbcJTyoEhsmS+Tli+6jHxMvFxvctSGNQaRGZREVyAux/yERnjxdv
 W2l+1A3LTAn0hA+/V0bIbuMr+yEDNPJ/cnY62ABl2Uh4xXM9zlOKJjpUeh8HYFaoIjrKwFyGW
 T1IwC3A7U3v/T4Mos7fAWdi6fJlCO/e+dYOQas5HsYzduAlIBM3upQP/mc6hrCWtCdwzV2a8K
 xM1cgjYodFsbNl6leSIgn+BNKuKKLSQ3srt1PW8Quarsxfzmndwsl51OCmoII9oDqyMdXUQyh
 74O++xadv++pWlRPoMu3ir+iOUc08sxuu8Hf965/I2h6FrVpN9ORNDR8K/qjXRABe1y1rI/pW
 Me12a829iK4zUViclgww63P+yGnggJw4hg+Tu500C4Sry6PT/Kb8Qlrh2Thva5oY50uz6JxN8
 NeuOIfSfLGm1KlByf9DzlXaShSZQzZbQ5NrySHDg13j1KQZXs9yzho6Wq7jCHSej/YuPb4Olh
 FzeIo//a86UQ9uYIVVhcY6BpiRw6MU5fST6GJDHwRXDjU=



=E5=9C=A8 2024/9/27 01:45, Ben Millwood =E5=86=99=E9=81=93:
> Hi folks,
>
> I got these mailing list details from
> https://github.com/kdave/btrfs-wiki/blob/master/btrfs.wiki/Btrfs%20maili=
ng%20list
> , which sounds like it's deprecated as a source, so I hope the details
> and etiquette guidelines are still current...
>
> Anyway, I'm seeing an error with similar symptoms as this old thing:
> https://lore.kernel.org/linux-btrfs/87blnsuv7m.fsf@gmail.com/T/ , but
> likely with a different cause.
>
> My setup is:
> - My btrfs filesystem has two top-level subvolumes, /root and /snap,
> which I mount into / and /snap respectively. (I don't remember exactly
> why I did it this way, to be honest.)
> - I have a regularly-triggered systemd unit that runs: btrfs subvolume
> snapshot -r / "/snap/root/$(date -u --iso-8601=3Dseconds)"
> - I have two external USB disks, and I btrfs send -p
> /snap/root/LASTSNAP /snap/root/NEWSNAP | btrfs receive
> /mnt/USBDISK/root/YEAR for each one (I have scripts to do this for me,
> but I've reproduced the issue without the scripts. If you still want
> to read more about them for whatever reason, you can find them at
> https://github.com/bmillwood/backups )
> - Periodically I btrfs subvolume delete old snapshots from /snap/root.
> The ones in the external USB disks stay there forever. (I don't have
> crazy amounts of data, so this has been sustainable so far, but it
> does mean I have over 3k snapshots on there, which is perhaps
> unusual...)
>
> This more-or-less works most of the time, but recently I have a
> snapshot that won't co-operate, failing with "ERROR: failed to clone
> extents to home/ben/code/nix/noether/etc-nixos/system-packages.nix:
> Invalid argument". This happens with the same snapshot + erroneous
> file path for both of my external disks.
>
> I redid the send / receive pipeline with -vv on the receive:
>
> btrfs send -p /snap/root/2024-09-12T16\:29\:16+00\:00
> /snap/root/2024-09-12T17\:04\:17+00\:00 | btrfs receive -vv
> /mnt/electricaltape/root/2024 &> /mnt/electricaltape/receive-vv.log
>
> and here's tail receive-vv.log:
>
> unlink o1209472-383-0/vmsish.3.gz
> utimes nix/store/.links/0h84wh2xnnfqram84dsszzii4v2r497hvxsvbxfyppgfnwc3=
c4rk
> unlink o1209472-383-0/warnings.3.gz
> utimes nix/store/.links/0kh81sw0mh5sm7sgfb5g99rgb45qw85qs1s8qndjh4kchi0j=
1jq6
> unlink o1209472-383-0/warnings::register.3.gz
> rmdir o1209472-383-0
> utimes nix/store/.links/02m8fllf71vlf6wwx2h72k2adfx015gq8sxmbb5b52xdv3rq=
012l
> clone home/ben/code/nix/noether/etc-nixos/system-packages.nix -
> source=3Detc/nixos/system-packages.nix source offset=3D0 offset=3D0
> length=3D4985

The length is not aligned, thus it's causing problems for the receive end.

It looks like it's the slightly behavior change introduced in upstream
commit 46a6e10a1ab1 ("btrfs: send: allow cloning non-aligned extent if
it ends at i_size"), which allows the full full clone even it's not
fully sector aligned.

In that case, I think it's better to make receive to roundup the clone
length so the clone call won't be rejected by the kernel.

I'll craft a patch for you to test soon, appreciate if you can prepare a
btrfs-progs building environment.

Thanks,
Qu

> ERROR: failed to clone extents to
> home/ben/code/nix/noether/etc-nixos/system-packages.nix: Invalid
> argument
> At snapshot 2024-09-12T17:04:17+00:00
>
> The two files mentioned are generally copies of each other. I'm not
> sure if they're CoW shallow clones of each other or not. On its face
> I'm not sure why the clone would fail, given that the file length
> appears to be correct. Here's the file being written earlier in the
> receive:
>
> # grep -nF system-packages.nix receive-vv.log
> 133380:write etc/nixos/system-packages.nix - offset=3D0 length=3D4985
> 133381:truncate etc/nixos/system-packages.nix size=3D4985
> 133382:utimes etc/nixos/system-packages.nix
> 316933:clone home/ben/code/nix/noether/etc-nixos/system-packages.nix -
> source=3Detc/nixos/system-packages.nix source offset=3D0 offset=3D0
> length=3D4985
> 316934:ERROR: failed to clone extents to
> home/ben/code/nix/noether/etc-nixos/system-packages.nix: Invalid
> argument
>
> Here's the local parent snapshot:
>
> # btrfs subvolume show /snap/root/2024-09-12T16\:29\:16+00\:00
> snap/root/2024-09-12T16:29:16+00:00
>      Name:             2024-09-12T16:29:16+00:00
>      UUID:             1640ca1d-94ca-f448-a89c-a3d83023744a
>      Parent UUID:         a14d8622-5729-3543-8bba-62104d53e52a
>      Received UUID:         -
>      Creation time:         2024-09-12 17:29:16 +0100
>      Subvolume ID:         348
>      Generation:         63052
>      Gen at creation:     63051
>      Parent ID:         257
>      Top level ID:         257
>      Flags:             readonly
>      Send transid:         0
>      Send time:         2024-09-12 17:29:16 +0100
>      Receive transid:     0
>      Receive time:         -
>      Snapshot(s):
>      Quota group:        n/a
>
> the local sent snapshot:
>
> # btrfs subvolume show /snap/root/2024-09-12T17\:04\:17+00\:00/
> snap/root/2024-09-12T17:04:17+00:00
>      Name:             2024-09-12T17:04:17+00:00
>      UUID:             f4190efb-ee53-0341-9613-93be3d2afbcb
>      Parent UUID:         a14d8622-5729-3543-8bba-62104d53e52a
>      Received UUID:         -
>      Creation time:         2024-09-12 18:04:17 +0100
>      Subvolume ID:         349
>      Generation:         63122
>      Gen at creation:     63121
>      Parent ID:         257
>      Top level ID:         257
>      Flags:             readonly
>      Send transid:         0
>      Send time:         2024-09-12 18:04:17 +0100
>      Receive transid:     0
>      Receive time:         -
>      Snapshot(s):
>      Quota group:        n/a
>
> and the remote parent snapshot:
>
> # btrfs subvolume show
> /mnt/electricaltape/root/2024/2024-09-12T16\:29\:16+00\:00/
> root/2024/2024-09-12T16:29:16+00:00
>      Name:             2024-09-12T16:29:16+00:00
>      UUID:             cfa79865-0272-3845-b447-4d650c2f6d5a
>      Parent UUID:         3d45fbdc-7e4e-f044-83c3-32ad05b70441
>      Received UUID:         1640ca1d-94ca-f448-a89c-a3d83023744a
>      Creation time:         2024-09-26 14:00:31 +0100
>      Subvolume ID:         5842
>      Generation:         14268
>      Gen at creation:     14255
>      Parent ID:         5
>      Top level ID:         5
>      Flags:             readonly
>      Send transid:         63051
>      Send time:         2024-09-26 14:00:31 +0100
>      Receive transid:     14261
>      Receive time:         2024-09-26 14:09:52 +0100
>      Snapshot(s):
>      Quota group:        n/a
>
> I checked, and:
> - the Parent UUID of both local snaps is the UUID of my root subvolume,
> - the Parent UUID of the remote parent is the UUID of the previous
> remote snapshot,
> - as you can see, the Received UUID of the remote parent is the UUID
> of the local parent (and neither local snapshots have a Received
> UUID).
>
> local parent files:
>
> # stat /snap/root/2024-09-12T16\:29\:16+00\:00/home/ben/code/nix/noether=
/etc-nixos/system-packages.nix
>    File: /snap/root/2024-09-12T16:29:16+00:00/home/ben/code/nix/noether/=
etc-nixos/system-packages.nix
>    Size: 5026          Blocks: 16         IO Block: 4096   regular file
> Device: 0,411    Inode: 1211367     Links: 1
> Access: (0644/-rw-r--r--)  Uid: ( 1000/     ben)   Gid: (  100/   users)
> Access: 2024-09-12 17:05:38.551355079 +0100
> Modify: 2024-09-12 17:26:55.867672396 +0100
> Change: 2024-09-12 17:26:55.867672396 +0100
>   Birth: 2024-07-07 23:50:28.962175308 +0100
>
> # stat /snap/root/2024-09-12T16\:29\:16+00\:00/etc/nixos/system-packages=
.nix
>    File: /snap/root/2024-09-12T16:29:16+00:00/etc/nixos/system-packages.=
nix
>    Size: 5026          Blocks: 16         IO Block: 4096   regular file
> Device: 0,411    Inode: 597357      Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2024-09-12 17:27:05.736798471 +0100
> Modify: 2024-09-12 17:27:04.700785230 +0100
> Change: 2024-09-12 17:27:04.700785230 +0100
>   Birth: 2024-07-07 22:27:35.003876023 +0100
>
> local sent files:
>
>    File: /snap/root/2024-09-12T17:04:17+00:00/home/ben/code/nix/noether/=
etc-nixos/system-packages.nix
>    Size: 4985          Blocks: 16         IO Block: 4096   regular file
> Device: 0,415    Inode: 1211367     Links: 1
> Access: (0644/-rw-r--r--)  Uid: ( 1000/     ben)   Gid: (  100/   users)
> Access: 2024-09-12 18:02:43.410125394 +0100
> Modify: 2024-09-12 18:03:00.161350117 +0100
> Change: 2024-09-12 18:03:00.161350117 +0100
>   Birth: 2024-07-07 23:50:28.962175308 +0100
>
>    File: /snap/root/2024-09-12T17:04:17+00:00/etc/nixos/system-packages.=
nix
>    Size: 4985          Blocks: 16         IO Block: 4096   regular file
> Device: 0,415    Inode: 597357      Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2024-09-12 18:03:10.051482821 +0100
> Modify: 2024-09-12 18:03:09.142470623 +0100
> Change: 2024-09-12 18:03:09.142470623 +0100
>   Birth: 2024-07-07 22:27:35.003876023 +0100
>
> remote parent files:
>
> # stat /mnt/electricaltape/root/2024/2024-09-12T16\:29\:16+00\:00/home/b=
en/code/nix/noether/etc-nixos/system-packages.nix
>    File: /mnt/electricaltape/root/2024/2024-09-12T16:29:16+00:00/home/be=
n/code/nix/noether/etc-nixos/system-packages.nix
>    Size: 5026          Blocks: 16         IO Block: 4096   regular file
> Device: 0,3211    Inode: 42099860    Links: 1
> Access: (0644/-rw-r--r--)  Uid: ( 1000/     ben)   Gid: (  100/   users)
> Access: 2024-09-12 17:05:38.551355079 +0100
> Modify: 2024-09-12 17:26:55.867672396 +0100
> Change: 2024-09-26 14:03:06.227153443 +0100
>   Birth: 2024-03-02 17:39:41.804616575 +0000
>
> # stat /mnt/electricaltape/root/2024/2024-09-12T16\:29\:16+00\:00/etc/ni=
xos/system-packages.nix
>    File: /mnt/electricaltape/root/2024/2024-09-12T16:29:16+00:00/etc/nix=
os/system-packages.nix
>    Size: 5026          Blocks: 16         IO Block: 4096   regular file
> Device: 0,3211    Inode: 33809348    Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2024-09-12 17:27:05.736798471 +0100
> Modify: 2024-09-12 17:27:04.700785230 +0100
> Change: 2024-09-26 14:01:42.081508624 +0100
>   Birth: 2022-07-14 21:32:47.972957386 +0100
>
> Here's various system and filesystem info:
>
> $ uname -a
> Linux noether 6.6.52 #1-NixOS SMP PREEMPT_DYNAMIC Wed Sep 18 17:24:10
> UTC 2024 x86_64 GNU/Linux
>
> $ btrfs --version
> btrfs-progs v6.8.1
>
> $ btrfs fi show
> Label: 'noether-root'  uuid: b7ad9a05-8f7b-44af-8952-a7f717e897e0
>      Total devices 1 FS bytes used 274.02GiB
>      devid    1 size 390.62GiB used 303.07GiB path /dev/mapper/noether-l=
v
>
> Label: none  uuid: 7f916f66-8afa-4de6-be52-a0f127c756e1
>      Total devices 1 FS bytes used 2.17TiB
>      devid    1 size 3.64TiB used 2.39TiB path /dev/mapper/electricaltap=
e--vg-lv
>
> $ btrfs fi df /
> Data, single: total=3D251.01GiB, used=3D249.08GiB
> System, DUP: total=3D32.00MiB, used=3D48.00KiB
> Metadata, DUP: total=3D26.00GiB, used=3D24.94GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> I assume btrfs fi df /mnt/electricaltape is not relevant since it's
> probably on the sending side, but here it is anyway:
> Data, single: total=3D1.96TiB, used=3D1.95TiB
> System, DUP: total=3D8.00MiB, used=3D256.00KiB
> Metadata, DUP: total=3D225.00GiB, used=3D223.61GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> dmesg as a whole is pretty large, but here's me mounting my root disk
> at boot time:
>
> [   11.470686] stage-1-init: [Thu Sep 26 10:34:53 UTC 2024] Passphrase
> for /dev/disk/by-uuid/bfb4d3ae-816a-48f5-a925-30acc0d7a3ef:
> [   17.349037] Key type encrypted registered
> [   17.387864] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] Verifying
> passphrase for /dev/disk/by-uuid/bfb4d3ae-816a-48f5-a925-30acc0d7a3ef...
> - success
> [   17.390297] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] starting
> device mapper and LVM...
> [   17.412379] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] 1 logical
> volume(s) in volume group "noether" now active
> [   17.475310] BTRFS: device label noether-root devid 1 transid 75991
> /dev/mapper/noether-lv scanned by btrfs (214)
> [   17.477307] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] Scanning
> for Btrfs filesystems
> [   17.479005] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024]
> registered: /dev/mapper/noether-lv
> [   17.504504] stage-1-init: [Thu Sep 26 10:34:59 UTC 2024] mounting
> /dev/disk/by-label/noether-root on /...
> [   17.506407] BTRFS info (device dm-1): first mount of filesystem
> b7ad9a05-8f7b-44af-8952-a7f717e897e0
> [   17.506429] BTRFS info (device dm-1): using crc32c (crc32c-intel)
> checksum algorithm
> [   17.506441] BTRFS info (device dm-1): use zstd compression, level 3
> [   17.506449] BTRFS info (device dm-1): using free space tree
> [   17.595741] BTRFS info (device dm-1): enabling ssd optimizations
>
> and here's everything since I plugged in electricaltape:
>
> [ 4782.354412] usb 2-1: new SuperSpeed USB device number 3 using xhci_hc=
d
> [ 4782.369977] usb 2-1: New USB device found, idVendor=3D0bc2,
> idProduct=3Dab28, bcdDevice=3D 1.00
> [ 4782.369984] usb 2-1: New USB device strings: Mfr=3D2, Product=3D3, Se=
rialNumber=3D1
> [ 4782.369986] usb 2-1: Product: BUP BL
> [ 4782.369988] usb 2-1: Manufacturer: Seagate
> [ 4782.369990] usb 2-1: SerialNumber: NA9FP1AT
> [ 4782.374490] scsi host0: uas
> [ 4782.375167] scsi 0:0:0:0: Direct-Access     Seagate  BUP BL
>    0304 PQ: 0 ANSI: 6
> [ 4782.376657] sd 0:0:0:0: [sda] Spinning up disk...
> [ 4783.430402] ......ready
> [ 4788.581955] sd 0:0:0:0: [sda] 7814037167 512-byte logical blocks:
> (4.00 TB/3.64 TiB)
> [ 4788.581960] sd 0:0:0:0: [sda] 2048-byte physical blocks
> [ 4788.582079] sd 0:0:0:0: [sda] Write Protect is off
> [ 4788.582082] sd 0:0:0:0: [sda] Mode Sense: 4f 00 00 00
> [ 4788.582238] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 4788.608463] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
> not a multiple of physical block size (2048 bytes)
> [ 4788.608470] sd 0:0:0:0: [sda] Optimal transfer size 33553920 bytes
> not a multiple of physical block size (2048 bytes)
> [ 4788.703618]  sda: sda1
> [ 4788.703776] sd 0:0:0:0: [sda] Attached SCSI disk
> [ 4808.813728] BTRFS: device fsid 7f916f66-8afa-4de6-be52-a0f127c756e1
> devid 1 transid 14201 /dev/dm-3 scanned by (udev-worker) (21792)
> [ 4808.859452] BTRFS info (device dm-3): first mount of filesystem
> 7f916f66-8afa-4de6-be52-a0f127c756e1
> [ 4808.859473] BTRFS info (device dm-3): using crc32c (crc32c-intel)
> checksum algorithm
> [ 4808.859483] BTRFS info (device dm-3): use zlib compression, level 3
> [ 4808.859487] BTRFS info (device dm-3): disk space caching is enabled
> [ 4895.650086] BTRFS warning (device dm-3): block group 1789991583744
> has wrong amount of free space
> [ 4895.650093] BTRFS warning (device dm-3): failed to load free space
> cache for block group 1789991583744, rebuilding it now
> [ 4896.313609] BTRFS warning (device dm-3): block group 2062722007040
> has wrong amount of free space
> [ 4896.313617] BTRFS warning (device dm-3): failed to load free space
> cache for block group 2062722007040, rebuilding it now
> [ 4896.315812] BTRFS warning (device dm-3): block group 2078828134400
> has wrong amount of free space
> [ 4896.315817] BTRFS warning (device dm-3): failed to load free space
> cache for block group 2078828134400, rebuilding it now
>
> Grateful for any help anyone can offer, happy to do more debugging
> steps. I plan to keep all relevant snapshots around until this problem
> is resolved.
>
> In the absence of any other guidance, I'm going to try to figure out
> how to upgrade my kernel and btrfs-progs to as new a version as
> possible, and see if that makes any difference. I'll reply here if it
> does.
>
> Thanks!
>


