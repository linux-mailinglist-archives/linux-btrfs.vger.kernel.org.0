Return-Path: <linux-btrfs+bounces-8291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED848988267
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 12:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDA81F2231E
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A171BC09F;
	Fri, 27 Sep 2024 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ViqapKqD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65B19FA66
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727432758; cv=none; b=pScsiCb3oHdEcMzv8Ddz3bKbA15m+ZJmqDWNyzxlFLvwJ/ZiIA2H5KoW2gzYOEpw5RScnTVIctK5oqJcRVgLLRrooaRhE6VNZcIAxHBxOxxEvtIGvlK66UiZp/5n6CSiuGubLUba2xh0mbvQ6bi11GtvWuSENQ1rINLlEqyhF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727432758; c=relaxed/simple;
	bh=PJQVszfJx/XogaGoOUXNyjz2F/Bi/y4GvhWNbbE24IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6Rt337vtNKvdmxQNfSzca/CnybM6uPwXtJ2uZwvsEP4b+trZ+ytVlijrTPYIbuVZ3qbkdn53XGcUGeYOyqF/RtoJn50FEONP05iF48p3AnLr4sFUcJRdpp3+C5MltTt2VXCvdbT5exY0jYUrUSwGf4xFRpWHLBFDBJ0BVdwZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ViqapKqD; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727432746; x=1728037546; i=quwenruo.btrfs@gmx.com;
	bh=fWlQaHOht7CILEPTL663ZdqUVspbbFmAVvbQALxTZPI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ViqapKqDs19EkaQGEbfRYY5NTZfIS2596pk/GDZriBoe1536DvcDsdVKqyKnbDNL
	 jysYHc/FT1I9nkJjMo1VuSaxeN3rKsK3Rl1D6/pDrIHB0/PwvWqYlqIVWyUeGz6GJ
	 q/f/eMSQfiIjuZBh+T+vQ8H5faaI9Ws+sKusjf62bdhmQ0RJRiIunQoDQv9/vjfFz
	 tqoYWLzj96YxfYlRewreFhiJV5J4vK0o8D+bNgi/B+EtV25tb5kCRYqTydLcNM06/
	 Eyct7lkAUkbEN4TNPJpXuW2BW7hNmjUarf1K0J2VcNgSzLRj96UjRlnPXPlIcFWM0
	 eBOsIhKPWVrMeWn7gA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpnm-1s9I9b1IIU-00kUjk; Fri, 27
 Sep 2024 12:25:45 +0200
Message-ID: <4c631f0d-1040-496f-b86d-710ad2a37a37@gmx.com>
Date: Fri, 27 Sep 2024 19:55:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: use the path with the lowest latency for RAID1
 reads
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, waxhead@dirtcellar.net
References: <cover.1727368214.git.anand.jain@oracle.com>
 <f284d932a61c293ac1c350ac11730b11b651300c.1727368214.git.anand.jain@oracle.com>
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
In-Reply-To: <f284d932a61c293ac1c350ac11730b11b651300c.1727368214.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KzXUL2gwcSJABbWK5TEK807XUW3o5WOhmMBcr1fiYKqxXqY03c4
 3shmvCucR4F6+cXlkeShrJlIGUFkWlL93WdSO7mgHZ4n8tUOvD/hdAtgEMhgx/P3P3QYoQx
 mVRE5ik+qdKssTHwIrWaDdi9alag7HeKhBHP7ilBQPGxwy7TNi4euG2ZHuh6ZmLyj8lDUAX
 wiyFXpnRBuDPm+FBDQ4TA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:36JcpuUQniU=;4gHmjXHiNmgTuDohJQdbx7YU7z9
 YaapujsU/tLdZzWVdWS9W8JAXa3gVphwxylzyGk4QtkaN0W7r+Em1fk5sVouSSK146tfoHOfB
 cn3JucKaMzJuZEniR7JEeYKY+I+v4IV5mntRYfRzTBW/TKQsqY2UEJCEWaTW4pIEzYDSEbdt9
 JxkukN5VoFlv5RZWzJDIO4FM4CQZBGIZnbfyMpnw5ScO8xP1VhppLaXyLTePVYwwsBCOVK7Uh
 5CFDdNu2LcGg1YwDS0ctN88lUfLEgpTuJcB1V6KOl2ay3svVI3227ijTRpPuXOh4BpVz3X6AW
 DpIKrD7a5C3+OWdUw8EnnyYYcAiX9MbYxi11ZNYWT7KqGr80shKW6iEJV98FLb/8ZEF+uTTF/
 b5jnKmEjZMLgs3pv6XtkzNcp2H+ZDArRHxsEi68swQMR1pA0jZd81RAeRXrfgKso93kzlQ5K2
 uHcqk8K+ImckYvlNqNk7ts5hVs3nMy3jo4js7B4C311aeX01k6eJjF0cUc6KEKq3i0y9kDXP0
 ONKPHEvT+onf/nSpw6N//be/zphuD4afCXpjl6aKqagnhO3lFAvaeQ1QuiPbVtty3RMaj9UX7
 O0fgBGcetAO5nQQuROjgP4GncqJ1OVBxCGIIJ5XXqf7x+004J3P+SV8xzbA7YC27qPoPEcYXY
 33+/5L9BpBROBd77G0U9R2WUlOMBfpwOkB8Iab5I+fx8Gk6zkACSo3g4nHdOsa7DedT83p2gx
 rYmV+fWz8iIgm4X8xaPcxY20K+sXDGuJ00UkPhfwOPbouRa1dcAVmSWZFwdXSAbpx8MVG0HXf
 RjP7mP+Ov0AXJqB1sXxvsMCQ==



=E5=9C=A8 2024/9/27 19:25, Anand Jain =E5=86=99=E9=81=93:
> This feature aims to direct the read I/O to the device with the lowest
> known latency for reading RAID1 blocks.
>
> echo "latency" > /sys/fs/btrfs/<UUID>/read_policy
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/sysfs.c   |  2 +-
>   fs/btrfs/volumes.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h |  2 ++
>   3 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 18fb35a887c6..15abf931726c 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1306,7 +1306,7 @@ static ssize_t btrfs_temp_fsid_show(struct kobject=
 *kobj,
>   BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
>
>   #ifdef CONFIG_BTRFS_DEBUG
> -static const char * const btrfs_read_policy_name[] =3D { "pid", "rotati=
on" };
> +static const char * const btrfs_read_policy_name[] =3D { "pid", "rotati=
on", "latency" };
>   #else
>   static const char * const btrfs_read_policy_name[] =3D { "pid" };
>   #endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c130a27386a7..20bc62d85b3b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -12,6 +12,9 @@
>   #include <linux/uuid.h>
>   #include <linux/list_sort.h>
>   #include <linux/namei.h>
> +#ifdef CONFIG_BTRFS_DEBUG
> +#include <linux/part_stat.h>
> +#endif
>   #include "misc.h"
>   #include "ctree.h"
>   #include "disk-io.h"
> @@ -5860,6 +5863,39 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *=
fs_info, u64 logical, u64 len)
>   }
>
>   #ifdef CONFIG_BTRFS_DEBUG
> +static int btrfs_best_stripe(struct btrfs_fs_info *fs_info,
> +			     struct btrfs_chunk_map *map, int first,
> +			     int num_stripe)
> +{
> +	u64 est_wait =3D 0;

Is this a typo of best_wait? Or do you mean estimated wait?

> +	int best_stripe =3D 0;
> +	int index;
> +
> +	for (index =3D first; index < first + num_stripe; index++) {
> +		u64 read_wait;
> +		u64 avg_wait =3D 0;
> +		unsigned long read_ios;
> +		struct btrfs_device *device =3D map->stripes[index].dev;
> +
> +		read_wait =3D part_stat_read(device->bdev, nsecs[READ]);
> +		read_ios =3D part_stat_read(device->bdev, ios[READ]);
> +
> +		if (read_wait && read_ios && read_wait >=3D read_ios)
> +			avg_wait =3D div_u64(read_wait, read_ios);
> +		else
> +			btrfs_debug_rl(fs_info,
> +			"devid: %llu avg_wait ZERO read_wait %llu read_ios %lu",
> +				       device->devid, read_wait, read_ios);

I do not think we need this debug messages.

The device can have no read so far.

> +
> +		if (est_wait =3D=3D 0 || est_wait > avg_wait) {

You can give @est_wait a default value of U64_MAX, so that you do not
need to check for 0, just est_wait > avg_wait is enough.

Thanks,
Qu

> +			est_wait =3D avg_wait;
> +			best_stripe =3D index;
> +		}
> +	}
> +
> +	return best_stripe;
> +}
> +
>   struct stripe_mirror {
>   	u64 devid;
>   	int map;
> @@ -5940,6 +5976,10 @@ static int find_live_mirror(struct btrfs_fs_info =
*fs_info,
>   	case BTRFS_READ_POLICY_ROTATION:
>   		preferred_mirror =3D btrfs_read_rotation(map, first, num_stripes);
>   		break;
> +	case BTRFS_READ_POLICY_LATENCY:
> +		preferred_mirror =3D btrfs_best_stripe(fs_info, map, first,
> +								num_stripes);
> +		break;
>   #endif
>   	}
>
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 81701217dbb9..09920ef76a9b 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -306,6 +306,8 @@ enum btrfs_read_policy {
>   #ifdef CONFIG_BTRFS_DEBUG
>   	/* Balancing raid1 reads across all striped devices */
>   	BTRFS_READ_POLICY_ROTATION,
> +	/* Use the lowest-latency device dynamically */
> +	BTRFS_READ_POLICY_LATENCY,
>   #endif
>   	BTRFS_NR_READ_POLICY,
>   };


