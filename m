Return-Path: <linux-btrfs+bounces-7094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E3194E02C
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 07:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C4E281821
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 05:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D031AAC4;
	Sun, 11 Aug 2024 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Fvm0uGhj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879431BC4B
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 05:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723355721; cv=none; b=SMe/5xLcuHYDIW8t+SXLp+jaZnTfXYZ/fbGmlx+qEEoH70lkSLMg+/pCO9H/SrBHiwMuz8B6dNAvoqyNhwI4U/PopL0DfTi+sWPV7M8YBuxTGDld4R64Q5MOEqXfbPHUhuGtC7KowtM1NCl4kCxrXMJyj6/RBjUcFaGoN2z0aKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723355721; c=relaxed/simple;
	bh=5Wio57cqqi+RSrGBYSloSupA2izuQd+XfHtd7wxUIh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QB58/PyswzwSHjwp7vRLy3cOAiMAppyg2SVBegS6wlxF4aPR6WI6Rpu+qMUqmWPC3vLhbk+X1csbRbmq7FNwXKzXyRRVRd0KJnfgqBaL5mh3cMaJdMZodoQaWd5l5PyYuaLmar2dORaKp7A4p/4gE/W7FuOT9U7QaGHV7hIqdfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Fvm0uGhj; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723355716; x=1723960516; i=quwenruo.btrfs@gmx.com;
	bh=fvJFapIrZ3nmtTPnLX9rnCBQf/Y7mU5wsm+QbFomfPc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Fvm0uGhjNUtggibmXZvFdr5Y1YnIAh/22lZbDsdVtrzHsZQH8uA9MFnWSkqA0CMa
	 +TXT3wcf/pS+nEiMvecSVZNSYKIjwl/LSXiYViIenQvbTLzfk2mk/fcmx/KLd8Pvz
	 3RpHxZlIGBoE7SScpLnLmAL8HwMDDPsOUQVaNryHpP9uDMFa1z0AwaNxHKEvPk9k0
	 OkyjYoKF44HcPTOaxz/MF/8sUolujIIoIIoeayntpn6RCiUnLY8P7OtiNzBwz92cY
	 DnMmECv3mgp91HlRbGpEEQOKPcZTdxpIk5LI6sb3vzzL9uRtNFJLvJ80OJwGC9M0A
	 PlSMjOWc3UnAngOpqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtfNf-1sLENg1RtP-00s4pO; Sun, 11
 Aug 2024 07:55:16 +0200
Message-ID: <de8cdf72-6961-4947-90da-37968de62500@gmx.com>
Date: Sun, 11 Aug 2024 15:25:13 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: property: introduce drop_subtree_threshold
 property
To: Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20240810061736.4816-1-realwakka@gmail.com>
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
In-Reply-To: <20240810061736.4816-1-realwakka@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dbmJ9ZjbftK6GHSoO+6L8dE5kgUnpJgdNJa+TRbujOMaQHq31fj
 2iKufW/paqyYNV4/oETE6Bc5ghOuqi6x2zEqOOEMgrvGMdHseXQ23NDe682nfbVTuzkcQwK
 VyPOFoQKpqE0N6i6OvNdm7l8JSY8CUuRPLD828+4IF1NA+ornroI8b6nXcf/CvKGlV+dExQ
 Q0gxRLNlZ0PZpOE+0NNSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GoWz6YdUvfw=;FohjBzO+oWss8xsi3Gyg0zPGA9s
 iF+bHivEBVRnTJxrCfKtL8k5qX5WdHsvqENgR5qzEJ+Ix+/1h+4O4XiUwEo5pIF4alMGD/tNs
 ueFZviIcvfaL8An0trdTc0mg2xfgdSbovmmo8dJMHF8h3lFbCpzwe7geQCSYswI17wP3Snvcf
 IRA3UHMy0ukiB4kybNu5f94JyciaAMkjblHBD+axg5tFjIE6JhEkhIT0vTx37iuXi9vnQkOY0
 mo4JTtZAYH4hCFOHjp3oUNwlYX1En3zneofPC9yTCRusFEJ9MlORJKu3mcJcrwTtXodgg9Lf/
 HyA8dIxGP/juLCXpO2mDEK8++W9LifO8rPFKVSjuhRXeTau4WL3LE9zx9Q2m5k3jieUBD+hDZ
 uD2KL/L4RC9rDhi2f+3JoCqdoPtN2KVGBAXKWm/iFb6qDn5yLdFRpuUTh47m2V4HddnLlj1nD
 RH6luI2GdbqDAtFAZJXlV3RAKRgbzuQWF4h8q18HvTcvfcWdyVEgnUWGqiq9Wnbe3Snrbqrj6
 l/cUZAl2Wx+4TSf1G1PDeD7QSNEAmt9NknnOjVJWtXP9BDpAaxH4BRxBVKy5MQVqCDJJaECBG
 i5i+TpcvDrKCFAYovGYgIE31qd/QngYqOJF5J3YtUKSDi3AwPEl3lqK8qzSBYeULQDSncp4KV
 +1xjy8ytjYW+yIitUJ6ZfaPiywd5f9RrYHZiGcYaTjDHfAEmuWWOn7/dwmJ6dQ/mHAPKqavIp
 dc62MegSU7q2YODFBQFOpl0Mkfq9HwmY5wb9J8N4P+AvVG+yQGhYhSF7Ocil5h+jzQqVMjk5z
 roJQSt80N/ncYl7+VUbPLfQg==



=E5=9C=A8 2024/8/10 15:47, Sidong Yang =E5=86=99=E9=81=93:
> This patch introduces new property drop_subtree_threshold. This property
> could be set/get easily by root dir without find sysfs path.
>
> Fixes: https://github.com/kdave/btrfs-progs/issues/795
>
> Issue: #795
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>   cmds/property.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>
> diff --git a/cmds/property.c b/cmds/property.c
> index a36b5ab2..44b62af6 100644
> --- a/cmds/property.c
> +++ b/cmds/property.c
> @@ -35,6 +35,7 @@
>   #include "common/utils.h"
>   #include "common/help.h"
>   #include "common/filesystem-utils.h"
> +#include "common/sysfs-utils.h"
>   #include "cmds/commands.h"
>   #include "cmds/props.h"
>
> @@ -236,6 +237,45 @@ out:
>
>   	return ret;
>   }
> +static int prop_drop_subtree_threshold(enum prop_object_type type,
> +				       const char *object,
> +				       const char *name,
> +				       const char *value,
> +				       bool force) {
> +	int ret;
> +	int fd;
> +	int sysfs_fd;
> +	char buf[255];
> +
> +        fd =3D btrfs_open_path(object, value, false);
> +	if (fd < 0)
> +		return -errno;
> +
> +	sysfs_fd =3D sysfs_open_fsid_file(fd, "qgroups/drop_subtree_threshold"=
);
> +	if (sysfs_fd < 0) {

Since qgroups/ directory is automatically generated/removed according to
the qgroup status, you have to handle -ENOENT case, other than just
erroring out.

At least you can do a warning if qgroup is not enabled.

> +		close(fd);
> +		return -errno;
> +	}
> +
> +	if (value) {
> +		ret =3D write(sysfs_fd, value, strlen(value));
> +	} else {
> +		ret =3D read(sysfs_fd, buf, 255);
> +		if (ret > 0) {
> +			buf[ret] =3D 0;
> +			pr_verbose(LOG_DEFAULT, "drop_subtree_threshold=3D%s", buf);
> +		}
> +	}
> +	if (ret < 0) {
> +		ret =3D -errno;
> +	} else {
> +		ret =3D 0;
> +	}
> +
> +	close(sysfs_fd);
> +	close(fd);
> +	return ret;
> +}
>
>   const struct prop_handler prop_handlers[] =3D {
>   	{
> @@ -259,6 +299,13 @@ const struct prop_handler prop_handlers[] =3D {
>   		.types =3D prop_object_inode,
>   		.handler =3D prop_compression
>   	},
> +	{
> +		.name =3D "drop_subtree_threshold",
> +		.desc =3D "threshold for dropping reference to subtree",

The feature is qgroup specific, thus it's better to mention it.

Furthermore you didn't explain what threshold it is.

I'd go something like:

"subtree level threshold to mark qgroup inconsistent during snapshot
deletion, can reduce qgroup workload of snapshot deletion".

Thanks,
Qu
> +		.read_only =3D 0,
> +		.types =3D prop_object_root,
> +		.handler =3D prop_drop_subtree_threshold
> +	},
>   	{NULL, NULL, 0, 0, NULL}
>   };
>

