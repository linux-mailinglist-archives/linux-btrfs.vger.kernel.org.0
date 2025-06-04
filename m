Return-Path: <linux-btrfs+bounces-14469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 491D5ACE6D8
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 00:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F07A1724FD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 22:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817151F3D54;
	Wed,  4 Jun 2025 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sRlcpays"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CE1B4145;
	Wed,  4 Jun 2025 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749077632; cv=none; b=sx3TPzsxzR0lBqrItM+xu5ni3CaB7rSDcK2K8GAiXsfczsn81NwAlDZ6cTj2MQMPt0J+AarNszy4GDj3TmfwLhM+vszpWmK/2JlMs/DP9sY85JmM+GXTZ5RuUI3zAgw8oGfXhg1oKQ7U+jheYWk7CxShUP5xSwM9Kcr6roDXZzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749077632; c=relaxed/simple;
	bh=v7sGuBc0u5XZMp8KHHODHm/vC3BCSm2pohi9WU+V6y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ji4iP+ikqlS041NvlJnsZUz437ABMZLtPpSanH/B0f16ZDflqeDClQIEhRRwQ+wSJtiXc9gF03IMlX3tp1NYE3dGQh0VGLhxfeYSgtM+QT2xt7H5w8hjCGtQK2/iZU4ZqJvcGD6UwCuCi6Pd9XuWe+11gw00HA4DKhjvleEMUKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sRlcpays; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749077620; x=1749682420; i=quwenruo.btrfs@gmx.com;
	bh=+kDA7NAJkW+p8vIYFTmsWVXRqVvxNLhV0K2T7UJrcGk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sRlcpaysHGvt+ScqlPPAlXJQ7vb3btwK0kOl65g3y+OgNLYsIpbK1E8xZvk7Ruxp
	 atB9Uptfjg77x+DSOJ0b9bLjv0lgh7du8qadqL9QUvcShX5EcUPD70SvUzJmsJv+T
	 Al/A34OhkRah5BPoTKPRkodAjBDzA8JCkiecn/8hzUylMysqIXZKKov5fy6vkDQtZ
	 EZ9v+RcwJs+hJ9VBGckfowl8ivgKiXHLnessTSKRAAlk6qtT72mmnnU6+ZmePb9NC
	 DXtMb5aN8Rgnvdfn10oYHJLVZKroz9/e2+TU2XwZvxuMio1gBWEXJnYWgPcoHr4IT
	 d2qzSvwycbKg91PQIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJZO-1v24Un29pe-00qMA3; Thu, 05
 Jun 2025 00:53:40 +0200
Message-ID: <d188b1ef-5e84-438c-863b-807e534fb67d@gmx.com>
Date: Thu, 5 Jun 2025 08:23:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [btrfs] 8af94e772e: xfstests.btrfs.220.fail
To: kernel test robot <oliver.sang@intel.com>, Qu Wenruo <wqu@suse.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <202506042235.7e3a37da-lkp@intel.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <202506042235.7e3a37da-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TxDBeL26Xax1jDircGl5E+qo6JjRzAFuHZAo+aUnVOTeNCOX7kH
 t5u/oSAmJu2kdmgqv7HTXJZcguen7QPThvxsR6HRllb8qSeWUYoEHuqW6VXKJUxL81IdLfT
 5WunUMsmj52CYIQOdsRguvERUqnHEMgaCLkENLY0WpGf4Hrho581XwNHgIhh7XkCeCBy2CD
 wEaUOcEs/p4fIJmJ4Ynww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NkefiVpwn+U=;SRrJq1IUkdumoKCxKIfRIAGDuGc
 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



=E5=9C=A8 2025/6/5 00:21, kernel test robot =E5=86=99=E9=81=93:
>=20
>=20
> Hello,
>=20
> kernel test robot noticed "xfstests.btrfs.220.fail" on:
>=20
> commit: 8af94e772ef7bede90895318a3fda6c68a652774 ("btrfs: remove standal=
one "nologreplay" mount option")

That is fixed by fstests commit: 49170253afef ("fstests: btrfs/220: do=20
not use nologreplay when possible"), which is in patches-in-queue branch=
=20
already.

Thanks,
Qu

> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
> [test failed on linus/master      7d4e49a77d9930c69751b9192448fda6ff9100=
f1]
> [test failed on linux-next/master 3a83b350b5be4b4f6bd895eecf9a92080200ee=
5d]
>=20
> in testcase: xfstests
> version: xfstests-x86_64-e161fc34-1_20250526
> with following parameters:
>=20
> 	disk: 6HDD
> 	fs: btrfs
> 	test: btrfs-220
>=20
>=20
>=20
> config: x86_64-rhel-9.4-func
> compiler: gcc-12
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GH=
z (Haswell) with 8G memory
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202506042235.7e3a37da-lkp@intel=
.com
>=20
> 2025-06-01 10:11:00 export TEST_DIR=3D/fs/sdb1
> 2025-06-01 10:11:00 export TEST_DEV=3D/dev/sdb1
> 2025-06-01 10:11:00 export FSTYP=3Dbtrfs
> 2025-06-01 10:11:00 export SCRATCH_MNT=3D/fs/scratch
> 2025-06-01 10:11:00 mkdir /fs/scratch -p
> 2025-06-01 10:11:00 export SCRATCH_DEV_POOL=3D"/dev/sdb2 /dev/sdb3 /dev/=
sdb4 /dev/sdb5 /dev/sdb6"
> 2025-06-01 10:11:01 echo btrfs/220
> 2025-06-01 10:11:01 ./check btrfs/220
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.15.0-rc6-00302-g8af94e772ef7=
 #1 SMP PREEMPT_DYNAMIC Sun May 18 15:54:12 CST 2025
> MKFS_OPTIONS  -- /dev/sdb2
> MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch
>=20
> btrfs/220       [failed, exit status 1]- output mismatch (see /lkp/bench=
marks/xfstests/results//btrfs/220.out.bad)
>      --- tests/btrfs/220.out	2025-05-26 16:25:04.000000000 +0000
>      +++ /lkp/benchmarks/xfstests/results//btrfs/220.out.bad	2025-06-01 =
10:11:04.131877139 +0000
>      @@ -1,2 +1,5 @@
>       QA output created by 220
>      -Silence is golden
>      +mount: /fs/scratch: wrong fs type, bad option, bad superblock on /=
dev/sdb2, missing codepage or helper program, or other error.
>      +       dmesg(1) may have more information after failed mount syste=
m call.
>      +mount -o nologreplay,ro /dev/sdb2 /fs/scratch failed
>      +(see /lkp/benchmarks/xfstests/results//btrfs/220.full for details)
>      ...
>      (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/220.out /lkp/ben=
chmarks/xfstests/results//btrfs/220.out.bad'  to see the entire diff)
> Ran: btrfs/220
> Failures: btrfs/220
> Failed 1 of 1 tests
>=20
>=20
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250604/202506042235.7e3a37da-l=
kp@intel.com
>=20
>=20
>=20


