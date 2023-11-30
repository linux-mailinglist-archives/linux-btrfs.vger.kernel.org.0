Return-Path: <linux-btrfs+bounces-455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D8B7FFD22
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 21:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29B81C21246
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 20:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E12553805;
	Thu, 30 Nov 2023 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qOdgQvC0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D01510E3
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 12:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701377611; x=1701982411; i=quwenruo.btrfs@gmx.com;
	bh=vDZwIkSZBZRn0JOhzppCFhxLlnaZ3BmuBoT88cyasOo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=qOdgQvC0xL6mjEioquU6uc0dv5JWhchIwgEs+3mueQM3WLNhKHvYZPWy+0nNEzNw
	 AaqSgh9lYOswjm8eVXorimDcFoo6cYCp2+ZY7piFSC89su6/X79DIOnMHzjfh+Ggd
	 gqojXTPZrFIR1wahOCe3T14g8g6l1bUvsz6GstGxKo7PlWkoA3jXejwOcVD4KxP4b
	 1tAPEhF6Xon07v9rZ8AErolVyKK98QQiv6JuHXpA1NWXIS6dyZ7WzOFJQZKR5iIkQ
	 8Oa5/i92k+S88g1meX7vGXK9LjE/+qIuqIzmz/GvM2Ub7r4A1mlVRHi7SHsTXkZBF
	 1OQMGb0Qw1jykM1l8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPGRz-1quhXC07gL-00Pasi; Thu, 30
 Nov 2023 21:53:31 +0100
Message-ID: <ccec2d73-98a7-4e73-a9ee-9be0fc2e1c92@gmx.com>
Date: Fri, 1 Dec 2023 07:23:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS doesn't compress on the fly
Content-Language: en-US
To: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
References: <ac521d3f-6575-4a72-a911-1991a2ca5f67@wiesinger.com>
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
In-Reply-To: <ac521d3f-6575-4a72-a911-1991a2ca5f67@wiesinger.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gi+fN5pYxivg6IGdQcXClS554I5tpHmBbbNJ/ON/5GyuIFe0jN2
 r754QSnBb6v1wY7KivUZB+ySdUMfihjCncq+LyUafiAXVrueXsRoQ2iKyj4XU0pjVT+SxXu
 lp2QvwttZ24Q/1hpJvZBbykHyr3n7MufWFogT3uQh5iFuV3ZOVSSikfgm2BpuyaFtHfhSfu
 DcbbEjV0+HFLtjPqXqcwg==
UI-OutboundReport: notjunk:1;M01:P0:/eBe9T0QFX0=;nYzHGRbRIh7Zn2y3GxyKdhG0jWT
 +n9+0m96EsLtBWF4MfeptZHvqUZ2kduUy6wiiso48NhjhtXKWLHYREHc8OTDw85vjhxOoW+Nu
 DhBh8CypQS2/Mmt6lPtqh7v+10iAAmnlvRy2kZOT8NHmFMtss2K+B3yXb8FXYNzVkH3sHtNdI
 waorsLj6BC8y44V2a/F1UbbE5Hn6tiQe2ZpwxZiE+OHX9rRbFWREYUtRfvJr38xwtQPeFA1sA
 tR5kaK8K9VTzL/V3ajPQk1PXIkXn9bpZTjiLgS2SNbLMTF23I4TIpXl3WZnaGt81EvmwQepTI
 Ghmx84lkPbvo/w5WuU7US0PnHmkOyBC8LKBXm/MlcECdZ9BDoB3IN0LZWNHtxx6WCkqa7/jUb
 XkqgbLxZnx4XaFkx4UdYQSluRTn7TW0rCHqkrfSvSe9cGf0rr4xVtVVpM9LPYSjJhcFDq/5dd
 GgZUuv6gssGIycR9pfSziFuyB83cvDuzjKLMJPS+xvEiklKnfzF8VqbYpcaoTf49QB33z3cYE
 3OuzVaCPbDh16duAIANw/FLKIE247oRFHHawHcvffvOQAaN1pQ/TJ8pVLWNRMS9D08zpFpUid
 rgynTPUvYNseR3Vuqk+2XAksH1oHbLpCsvVetH48LZAmBMtzjZdNlTbni5GZmbNav1oFbjxzT
 ec7U8xW+zEFXV3z9PTYUrGY5T/AYLSLk51Np82N/Hlo0+MFcLaZft/lLM4uGDpxp9Ze0lSfTX
 GoIn9zESS7c7f+R+aDXbz6wrPbCLXiK9kwo1aN4fYour1m5bSV5bUCWM2mluymg6pLknY9fna
 Eh9knMSnPcNnnpx2fQgiqsSFMrGTUZpdgvQttSSzSkFlmOGw0GGt/mzU5atyCnC3vaMwfZvS3
 EWjKb6ywwRhxMooGRl3uYUfS4oQyppcliKuQCjs7VAIElI1ngPlz5ic+A/As2eRDdxpSureH8
 lx+xxzhZbH0Xgx1kbHHbpBnKbwY=



On 2023/11/30 21:51, Gerhard Wiesinger wrote:
> Dear All,
>
> I created a new BTRFS volume with migrating an existing PostgreSQL
> database on it. Versions are recent.

Does the data base directory has something like NODATACOW or NODATASUM set=
?
The other possibility is preallocation, for the first write on
preallocated range, no matter if the compression is enabled, the write
would be treated as NOCOW.

>
> Compression is not done on the fly although everything is IMHO
> configured correctly to do so.
>
> I need to run the following command that everything gets compressed:
> btrfs filesystem defragment -r -v -czstd /var/lib/pgsql
>
> Had also a problem that
> chattr -R +c /var/lib/pgsql
> didn't work for some files.
>
> Find further details below.
>
> Looks like a bug to me.
>
> Any ideas?
>
> Thanx.
>
> Ciao,
> Gerhard
>
> uname -a
> Linux myhostname 6.5.12-300.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Nov
> 20 22:44:24 UTC 2023 x86_64 GNU/Linux
>
> btrfs --version
> btrfs-progs v6.5.1
>
> btrfs filesystem show
> Label: 'database'=C2=A0 uuid: 6ad6ef90-30fa-4979-9509-99803f7545aa
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes use=
d 15.76GiB
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 129.98GiB used 21.06GiB path /dev/mapper/datab
>
> btrfs filesystem df /var/lib/pgsql
> Data, single: total=3D19.00GiB, used=3D15.61GiB
> System, DUP: total=3D32.00MiB, used=3D16.00KiB
> Metadata, DUP: total=3D1.00GiB, used=3D151.92MiB
> GlobalReserve, single: total=3D85.38MiB, used=3D0.00B
>
> # Mounted via force
> findmnt -vno OPTIONS /var/lib/pgsql
> rw,relatime,compress-force=3Dzstd:3,space_cache=3Dv2,subvolid=3D5,subvol=
=3D/'
>
> # all files even have "c" attribute, set after creation of the filesyste=
m
> lsattr /var/lib/pgsql
> --------c------------- /var/lib/pgsql/16
>
> # Should be empty and is empty, so everything has the comressed
> attribute (after creation and also all new files)
> lsattr -R /var/lib/pgsql | grep -v "^/" | grep -v "^$" | grep -v
> "^........c"
>
> # Stays here at this compression level
> compsize -x /var/lib/pgsql
> Processed 5332 files, 575858 regular extents (591204 refs), 40 inline.
> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 Di=
sk Usage=C2=A0=C2=A0 Uncompressed Referenced
> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 63%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 51G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80G
> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 40G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40G
> zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 27%=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 10G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
40G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40G
> prealloc=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.0M=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.0M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 5.5M

Not sure if the preallocation is the cause, but maybe you can try
disabling preallocation of postgresql?

As preallocation doesn't make that much sense on btrfs, there are too
many cases that can break the preallocation.

>
> # After running: btrfs filesystem defragment -r -v -czstd /var/lib/pgsql
> compsize -x /var/lib/pgsql
> Processed 5563 files, 664076 regular extents (664076 refs), 40 inline.
> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 Di=
sk Usage=C2=A0=C2=A0 Uncompressed Referenced
> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 15G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80G
> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 120K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 120K=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 120K
> zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19%=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 15G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
80G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80G
>
> # At the first time creating the filesystem I had also the problem that
> I couln't change all attributes, didn't find a way to get rid of this.
> Any ideas.
> chattr -R +c /var/lib/pgsql
> chattr: Invalid argument while setting flags on

A lot of flags can only be set on empty files IIRC.

Thanks,
Qu

> /var/lib/pgsql/16/data/base/1/2836
> chattr: Invalid argument while setting flags on
> /var/lib/pgsql/16/data/base/1/2840
> chattr: Invalid argument while setting flags on
> /var/lib/pgsql/16/data/base/1/2838
> chattr: Invalid argument while setting flags on
> /var/lib/pgsql/16/data/base/4/2836
> chattr: Invalid argument while setting flags on
> /var/lib/pgsql/16/data/base/4/2838
> chattr: Invalid argument while setting flags on
> /var/lib/pgsql/16/data/base/5/2836
> chattr: Invalid argument while setting flags on
> /var/lib/pgsql/16/data/base/5/2838
>
>

