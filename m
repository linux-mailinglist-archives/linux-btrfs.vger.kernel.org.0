Return-Path: <linux-btrfs+bounces-6186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4619D926C6D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 01:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6804D1C2109A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 23:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E75194C6F;
	Wed,  3 Jul 2024 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="p3+lMvgJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A06194ACF
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049215; cv=none; b=gT/thTtkkCh8Ui+Y/V3XmILFRHlzEopTomntexPyBVESc7MkX7aVs0ilVtxLV8GOy48amdaYGj47BHfGbHTTmo+jE8lr/4NXBw7fOfwQ/x2+BVW9QJ/SsdfIl9p+sHHLJjGNGxOaSQDUNO+eII6c0WoWy00VA6RpE6AH1yUZkaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049215; c=relaxed/simple;
	bh=jkY34msTRu2UMswYLXlnVfqHJc7mxnxmoxEgR6ul5BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UxYDOxPVvXbBg7VclCC7rLvA9uk6hXddk2dmokKGoTSRv1JrTEI5iFAKBYaVJ+ha7r3MKV+rKOdwKRXfDbedNPhmTSyXtHgj8G/imGDRJ/3D+5U9THXJ79x8gbOrKlNBIsblCPi85Rk6QZxOMpjV4PqPI7+WM1lqcTCRDqKv0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=p3+lMvgJ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720049210; x=1720654010; i=quwenruo.btrfs@gmx.com;
	bh=k7zmLJwQfSquqQeRbSYSuzivujfrG1p8ccMgKtWj+Zc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p3+lMvgJER08AzTqxgJpmUH8bWDGChvkXu03r/8suhoLFaNvLo5r+C2dGBCiw7b4
	 gX9dyksnvDsKcs5mu8QgLMQ0P80NwgtaG+WavSg8DOYKKd1HKXko//EBePUDgzGQa
	 n71uS52QdiW0vQ2iMlLgNjcPffJE9DyWGBa7GkIu12ZTkBsS5QWVoes9kt5C4U69Z
	 /bZGlwrUCy5POvcAhgx/QY7qBhx18nFbaWFL2frb0SDy6rJk/w/mun/vk2rRPm3Cj
	 7HypyyyFChxYKapvMrdn9D/S7LJZusa2F1tQ/tFWyIDUslTkb/iy3+aRGWwLdoAAo
	 4P8voKspNpjAxrTX1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MD9X9-1sXi4u2n5t-00AvwH; Thu, 04
 Jul 2024 01:26:50 +0200
Message-ID: <af92c238-a5d0-4023-8001-042f17085198@gmx.com>
Date: Thu, 4 Jul 2024 08:56:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-prog: scrub: print message when scrubbing a
 read-only filesystem without r option
To: Li Zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1720028821-3094-1-git-send-email-zhanglikernel@gmail.com>
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
In-Reply-To: <1720028821-3094-1-git-send-email-zhanglikernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LNQ0sVE41U2WZ+VUivMNqGyfFnYBcoTmvLv4nAtZQZhYSLlKZO5
 nBy7JaVdevC9HUChRIxH5KxFrU2Gij8ODdP9zOz352gm4A1HMS0Un4PRmg6k/n3WxVmu050
 Sra4T/GSj98nSIbyHerey0E0xqPnerTXpJQ0FA+aPMXPYsIYLnarfbsHTuA9qQZ011idCrz
 NLyk6cGpYmbYwEklLAtsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Hx7x3itX1e8=;36SQZ4S7U3RRYQdgO60KC64Lms2
 G4e0ERhx5iMI5/KISrb/sfjlAJPx68CUtCquIgy5U+5JACIbEmInx2TlnJsfc0ML1kUarVcnf
 fzmVJ3Eyj8RzFQ72jGtpa+n1UgaURZvVOpYlaDcMdguSiXp1VenFmy4dqVYsXMAmfmsTr3u7W
 xwMKiJiMh3TytGtiCUzqhuHllxA/wWYVg0P2GMmPRHGrp0ZjZ/gYbJwSWJLc73kMZCsvKARTa
 0vwJAXYtA66ygdZb+Whd7YJPi1nFbM6VMFMyZhdV1hOUFL7Zq+4yXYBFKU2KrQDOwWVIdIwfS
 kQIWMdqLCsmz0alwjjVeMxu9farGmEPsdySZEQLWLIrg1i5YRoLXLo30naHkEQDTQnR0Hm8gC
 1/fh/gnVWXTNMXWGJV8rHCOgA97TJQ6esfc5TFgtHHGt/aVvd3NKtuaJQJ1qxb88yIFLVSFfG
 YoZ4b0sOL5Wip9SrQBMO9UM3Ff5fghBeaQH318l8w1kf+RCfolQ34nU2GuKlDFbuz8Iq8Q2Me
 ntFnBsodiFNUOvYkAFo/gUIIQdcy0HIoom5qbvQA5tujVkelFUPbhuV3y69vGa96hnPqSniAg
 sZMXczsEE49ia+tAGYscSvWtzhcIsJiSMwpJFBK3XOfhZ5XlAqYkEcay8jPzTQmLt3Br8DmJ5
 E62YWmbKSmJnaNU1jbE7c/9GToCYCQjqlRqtn9vVRT54JL3Pyc14M7TKwJmGUYb2P9NFKu3N5
 OkIvMyn79O035R9ENkyIndq3b7JQShAHcOwY43ivKn2AYbwnXrERzJ0R77NVEuzyzr+16VGfK
 q7Ko2Q9cfg6Z92NPhXL3dhJqlab0dFNg1OLY4f+VMoiAk=



=E5=9C=A8 2024/7/4 03:17, Li Zhang =E5=86=99=E9=81=93:
> issue:666

It's better to move the issue tag before your SOB line.

And with something like "Issue: #829" so that github can detect it.

Check commit ab2260355afb ("btrfs-progs: subvol list: fix accidental
trimming of subvolume name") for a proper example.

>
> [enhancement]
> When scrubbing a filesystem mounted read-only and without r
> option, it aborts and there is no message associated with it.
> So we need to print an error message when scrubbing a read-only
> filesystem to tell the user what is going on here.
>
> [implementation]
> Move the error message from the main thread to each scrub thread,
> previously the message was printed after all scrub threads
> finished and without background mode.
>
> [test]
> Mount dev in read-only mode, then scrub it without r option
>
> $ sudo mount /dev/vdb -o ro /mnt/
> $ sudo btrfs scrub start  /mnt/
> scrub started on /mnt/, fsid f7c26803-a68d-4a96-91c4-a629b57b7f64 (pid=
=3D2892)
> Starting scrub on devid 1
> Starting scrub on devid 2
> Starting scrub on devid 3
> scrub on devid 1 failed ret=3D-1 errno=3D30 (Read-only file system)
> scrub on devid 2 failed ret=3D-1 errno=3D30 (Read-only file system)
> scrub on devid 3 failed ret=3D-1 errno=3D30 (Read-only file system)
>
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
>   cmds/scrub.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/cmds/scrub.c b/cmds/scrub.c
> index d54e11f..e0400dd 100644
> --- a/cmds/scrub.c
> +++ b/cmds/scrub.c
> @@ -957,7 +957,10 @@ static void *scrub_one_dev(void *ctx)
>   		warning("setting ioprio failed: %m (ignored)");
>
>   	ret =3D ioctl(sp->fd, BTRFS_IOC_SCRUB, &sp->scrub_args);
> -        pr_verbose(LOG_DEFAULT, "scrub ioctl devid:%llu ret:%d errno:%d=
\n",sp->scrub_args.devid, ret, errno);
> +	if (ret){
> +		pr_verbose(LOG_DEFAULT, "scrub on devid %llu failed ret=3D%d errno=3D=
%d (%m)\n",
> +			sp->scrub_args.devid, ret, errno);
> +	}

Doing direct output inside a thread can lead to race of the output.

And we do not know if the scrub ioctl would return error early or run
for a long long time, that's the dilemma.

I'm wondering if it's possible to do a blkid/mountinfo based probe.
Then it would avoid the possible output race and error out earilier.

Thanks,
Qu

>   	gettimeofday(&tv, NULL);
>   	sp->ret =3D ret;
>   	sp->stats.duration =3D tv.tv_sec - sp->stats.t_start;
> @@ -1596,13 +1599,6 @@ static int scrub_start(const struct cmd_struct *c=
md, int argc, char **argv,
>   				++err;
>   				break;
>   			default:
> -				if (do_print) {
> -					errno =3D sp[i].ioctl_errno;
> -					error(
> -		"scrubbing %s failed for device id %lld: ret=3D%d, errno=3D%d (%m)",
> -						path, devid, sp[i].ret,
> -						sp[i].ioctl_errno);
> -				}
>   				++err;
>   				continue;
>   			}

