Return-Path: <linux-btrfs+bounces-11818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76194A44ED2
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 22:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC7017791A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 21:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE43D21324E;
	Tue, 25 Feb 2025 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="siYU52+w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-71.smtpout.orange.fr [80.12.242.71])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F4320D513;
	Tue, 25 Feb 2025 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518769; cv=none; b=K2XBLsaMFGr69Gd50SMpcToi3ovwV74tYkqFZAg6Jxv6k49cndqDdvcuvXlnFpbfzOdDzGWEp+GNNd9N2iHXB0d8msDq6Ll46lE6jp36YgykWKnnprBSaADuoa1HJy08bq/7Xx+d7Y8cKpiG5TOYC6r+sxh7hu70yB0C8WE4fZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518769; c=relaxed/simple;
	bh=pyuUKKIK/oqDwIAa4v1WeQ0xbo398GEv1psrnk7fMjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSYtzlNPG/uxjKGROYZKov/fs5BZippQgLF/3+StNMqQgXF4DpRPRup1aaWoPmeNPfqb9HR/q9f4Ca7HqBu6skGE+hBoovEY6VahB7ttC7RmbFFYg09DUON/+aYLY+FegjFMuvI8YbuTfNrLG5vXjqW8XSXTXZlMbFR/x4f+jcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=siYU52+w; arc=none smtp.client-ip=80.12.242.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id n2R0tkeFQ4iG7n2R3t60Fm; Tue, 25 Feb 2025 22:25:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740518758;
	bh=CDOnVbuHRa5TlckniZ+QbcxrKwAHtppPzAjAscxNHSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=siYU52+wZ9L1fww+iQDN9rtYX6/aPczL9atUE2l26+nq1Ri8dh3TYGdKOZSOl8FUk
	 XrbU+P2TpuXPZmylEcNVhm7IGsserFCZYBNjOT562ZUYjLqKjMa1SJH893MOHidh6R
	 OQATR7VDki3fiHZfHEF2JqtwL04PZvB0Oj0pypFUs2f2NaghtKWNKg5zY+oKMy9gx3
	 hJDV0lXDGXzAw1PjH65vHLOKoP3lFuSvJzAbZkaII3cDH1jfDHrdCDL8+lHftSY/+S
	 CY90Fz3FaFYxcLZzbR4khlsrjLfgaLUxO0uOmAn+6ltyDhAKQJ99yzzK2ZVeFXSo2U
	 OrHC+r+ja1CFQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 25 Feb 2025 22:25:58 +0100
X-ME-IP: 90.11.132.44
Message-ID: <44dd2b5b-d91c-4daf-ab75-ed4030180028@wanadoo.fr>
Date: Tue, 25 Feb 2025 22:25:45 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/16] libceph: convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Frank.Li@nxp.com, James.Bottomley@HansenPartnership.com,
 Julia.Lawall@inria.fr, Shyam-sundar.S-k@amd.com, akpm@linux-foundation.org,
 axboe@kernel.dk, broonie@kernel.org, cassel@kernel.org, cem@kernel.org,
 ceph-devel@vger.kernel.org, clm@fb.com, cocci@inria.fr,
 dick.kennedy@broadcom.com, djwong@kernel.org, dlemoal@kernel.org,
 dongsheng.yang@easystack.cn, dri-devel@lists.freedesktop.org,
 dsterba@suse.com, festevam@gmail.com, hch@lst.de, hdegoede@redhat.com,
 hmh@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, idryomov@gmail.com,
 ilpo.jarvinen@linux.intel.com, imx@lists.linux.dev,
 james.smart@broadcom.com, jgg@ziepe.ca, josef@toxicpanda.com,
 kalesh-anakkur.purayil@broadcom.com, kbusch@kernel.org,
 kernel@pengutronix.de, leon@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 martin.petersen@oracle.com, nicolas.palix@imag.fr, ogabbay@kernel.org,
 perex@perex.cz, platform-driver-x86@vger.kernel.org, s.hauer@pengutronix.de,
 sagi@grimberg.me, selvin.xavier@broadcom.com, shawnguo@kernel.org,
 sre@kernel.org, tiwai@suse.com, xiubli@redhat.com, yaron.avizrat@intel.com
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-7-a43967e36c88@linux.microsoft.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-7-a43967e36c88@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 25/02/2025 à 21:17, Easwar Hariharan a écrit :
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@ expression E; @@
> 
> -msecs_to_jiffies(E * 1000)
> +secs_to_jiffies(E)
> 
> @depends on patch@ expression E; @@
> 
> -msecs_to_jiffies(E * MSEC_PER_SEC)
> +secs_to_jiffies(E)
> 
> While here, remove the no-longer necessary checks for range since there's
> no multiplication involved.

No sure it is correct.

Same comment as on patch 06/16, available at [1].

CJ

[1]: 
https://lore.kernel.org/linux-kernel/e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr/

> 
> Acked-by: Ilya Dryomov <idryomov@gmail.com>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>   include/linux/ceph/libceph.h | 12 ++++++------
>   net/ceph/ceph_common.c       | 18 ++++++------------
>   net/ceph/osd_client.c        |  3 +--
>   3 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 733e7f93db66a7a29a4a8eba97e9ebf2c49da1f9..5f57128ef0c7d018341c15cc59288aa47edec646 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -72,15 +72,15 @@ struct ceph_options {
>   /*
>    * defaults
>    */
> -#define CEPH_MOUNT_TIMEOUT_DEFAULT	msecs_to_jiffies(60 * 1000)
> -#define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
> -#define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
> +#define CEPH_MOUNT_TIMEOUT_DEFAULT	secs_to_jiffies(60)
> +#define CEPH_OSD_KEEPALIVE_DEFAULT	secs_to_jiffies(5)
> +#define CEPH_OSD_IDLE_TTL_DEFAULT	secs_to_jiffies(60)
>   #define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT 0  /* no timeout */
>   #define CEPH_READ_FROM_REPLICA_DEFAULT	0  /* read from primary */
>   
> -#define CEPH_MONC_HUNT_INTERVAL		msecs_to_jiffies(3 * 1000)
> -#define CEPH_MONC_PING_INTERVAL		msecs_to_jiffies(10 * 1000)
> -#define CEPH_MONC_PING_TIMEOUT		msecs_to_jiffies(30 * 1000)
> +#define CEPH_MONC_HUNT_INTERVAL		secs_to_jiffies(3)
> +#define CEPH_MONC_PING_INTERVAL		secs_to_jiffies(10)
> +#define CEPH_MONC_PING_TIMEOUT		secs_to_jiffies(30)
>   #define CEPH_MONC_HUNT_BACKOFF		2
>   #define CEPH_MONC_HUNT_MAX_MULT		10
>   
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 4c6441536d55b6323f4b9d93b5d4837cd4ec880c..c2a2c3bcc4e91a628c99bd1cef1211d54389efa2 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -527,29 +527,23 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
>   
>   	case Opt_osdkeepalivetimeout:
>   		/* 0 isn't well defined right now, reject it */
> -		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
> +		if (result.uint_32 < 1)
>   			goto out_of_range;
> -		opt->osd_keepalive_timeout =
> -		    msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->osd_keepalive_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_osd_idle_ttl:
>   		/* 0 isn't well defined right now, reject it */
> -		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
> +		if (result.uint_32 < 1)
>   			goto out_of_range;
> -		opt->osd_idle_ttl = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->osd_idle_ttl = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_mount_timeout:
>   		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)
> -			goto out_of_range;
> -		opt->mount_timeout = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->mount_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_osd_request_timeout:
>   		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)
> -			goto out_of_range;
> -		opt->osd_request_timeout =
> -		    msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->osd_request_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   
>   	case Opt_share:
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index b24afec241382b60d775dd12a6561fa23a7eca45..ba61a48b4388c2eceb5b7a299906e7f90191dd5d 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -4989,8 +4989,7 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
>   	linger_submit(lreq);
>   	ret = linger_reg_commit_wait(lreq);
>   	if (!ret)
> -		ret = linger_notify_finish_wait(lreq,
> -				 msecs_to_jiffies(2 * timeout * MSEC_PER_SEC));
> +		ret = linger_notify_finish_wait(lreq, secs_to_jiffies(2 * timeout));
>   	else
>   		dout("lreq %p failed to initiate notify %d\n", lreq, ret);
>   
> 


