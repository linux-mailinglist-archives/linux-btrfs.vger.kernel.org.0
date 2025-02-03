Return-Path: <linux-btrfs+bounces-11248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D869A263C6
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 20:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D531654C5
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 19:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B820A5CF;
	Mon,  3 Feb 2025 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZSvpRANI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c+ZFiEUO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD225A656;
	Mon,  3 Feb 2025 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738611107; cv=fail; b=pEV0db7srkxK1Y9eFtMjSaptYFxxAu30EnsYQw7PzKTKvcIciYx+3aXcNJy8C15fMlwB4I3VUv0/2yduPgBmABUDeum09iNyYTuYsem5BTB04RxVSNntoGZ7mypR+KW1bh+1VqB5nDQAzaqwtUkUmZe2F2x9vOFbSsnuq+xB2vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738611107; c=relaxed/simple;
	bh=2xSvs/Fs72P7Nmwz/FHTGjO3hTCtgKZb8fAWO2ubjtQ=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=U3JJc1KPYBx696vPaRfUV8GNSQOtGQqA+3zWeEcZsY83KIA5Qp4Phd7hlcUXv4evME1cJkw0PEILpQ3QJkd/YudcTwGimbB2ODGG8pTURkEUuEhMVyXG+xTuwYFzNRcFyCs60xQR6usgfREC7p4+bYuylrfs3RsWL0VV7U6XXeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZSvpRANI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c+ZFiEUO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JMsVq004439;
	Mon, 3 Feb 2025 19:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=AW/Jy9jJvWsdS8htfP
	0j2FW2sbenCi+SWTWfGOIhhaA=; b=ZSvpRANImZ3f2GW2DEcXXlqHBqTVVh6czV
	xK6yYeAhCsaz51pdpVoZ/IAHq0sEX0H+PocHyzChPCaGY97KE4V7GF7D8RhuZvrI
	ESgzAq0oYSden2U4PuhmQMCd0OTUXF4xvACfdN4q2cRdcoGFTb9XwmuoylpkEsZy
	qXdWwO1Clj1+ik4W+YTcoNzHmSn5aShFEnf7XhWZigQ2GzOy7WoqPI2NIwjdLq8W
	tu5cEcvbF3bPdtQlD3mmNYpGIViml7rrv22IoMwZ4539Ig4WJWf116fIWbrUJQF4
	o4bg9ZAoYv/9G7/U+g6sQzDZSJDoqfEKuzX0VTTJ+aWEIPrFaRUA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hh73ka49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 19:31:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 513JU2O9039051;
	Mon, 3 Feb 2025 19:31:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8e6t3f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 19:31:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KibMi4xiHu/IJHDQK9hrq7hlrDH1XVIWXcVprdzvk+G0u2wq0wj7QeEAuOTttbqtOuDx5PTF+JMl494XchOSIf+IlXctL68wUFXmJzFuydGOR87v46NJpNhc/0XBmIZwCmkSzdLkXElMkIape+h3/3yvUIBovHikfi8OpsqknyIlfCqPmwzK/9xjAtYcBXX7yJcSOFtiVO3WjhAqXebWqLlg3lveXtAQ3de55N+sqmd2Ll+0G7WOFPyQ5xHbgD71TideL+dv1m9S2XO0gZl/WCSVLb5LH+16Ex9xx8AzNu52wdwODZzeaRs0MH7CgzLkCuQnXlwt733+Z6ta2M1Z+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW/Jy9jJvWsdS8htfP0j2FW2sbenCi+SWTWfGOIhhaA=;
 b=Ud2gQxD3wxTsSyQeL5tZQY2afbgljM/8bfg6DqrU7pmUA1pDxP2kl/uYHABLC/yIvV+5f2FL1JNn8sRWu8YYG3x81itr6Hpfp0wju+rhC3mVfR5vAkg1qR3WD4yA0dV5Gee2M6M+XPD7qaNzF37tFF51io6u6y4a5RtnyqFjQRpXOWi97OAMtiHEfm0Irom3aWgbHHCNPd/M9yuEwtWma+yLmWikl8Cdtxu73BCqLwbZzjZkGCKLepJZZnIqy8VV9KJfjN8N349tyWdzrwnuV4Zs24K4OkclusXvBIvt2X/PFQ3Uy65uHf0jOYFe6NjJopNU2FnEeQEvIfG5GG33Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW/Jy9jJvWsdS8htfP0j2FW2sbenCi+SWTWfGOIhhaA=;
 b=c+ZFiEUOBbxiEop8gLdfQuLwE6pzgQTL7KTHOuQgJJcLKH8dM96QtG0LkdzzMb/ZRpxeQkBQlAFPQnaR0JIuwI/SmKQ+76u3Az1ypdVj0wq6hSpJL0992TpshyHATj7HLjgDslAOWcjo+LHZMt4on/5aZUZyKwdLapToNeyxaA4=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by BLAPR10MB4867.namprd10.prod.outlook.com (2603:10b6:208:321::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 19:31:16 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 19:31:16 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kanchan Joshi
 <joshi.k@samsung.com>, josef@toxicpanda.com,
        dsterba@suse.com, clm@fb.com, axboe@kernel.dk, kbusch@kernel.org,
        linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250131074424.GA16182@lst.de> (Christoph Hellwig's message of
	"Fri, 31 Jan 2025 08:44:24 +0100")
Organization: Oracle Corporation
Message-ID: <yq17c66kfxs.fsf@ca-mkp.ca.oracle.com>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
	<20250129140207.22718-1-joshi.k@samsung.com>
	<yq134h0p1m5.fsf@ca-mkp.ca.oracle.com> <20250131074424.GA16182@lst.de>
Date: Mon, 03 Feb 2025 14:31:13 -0500
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|BLAPR10MB4867:EE_
X-MS-Office365-Filtering-Correlation-Id: 5beda007-aa86-4353-01a2-08dd448953ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NNqruoZHhjqVFyqOatp+csV0RtPnqLY2+sfIZXKNJp++TJRasROKAWZVPQ2b?=
 =?us-ascii?Q?K3S4sZrGgPel5c/4DT48JvKF0fgcp3a3HfXQwjzBQnvKAt/vnTLZj0bpBx/m?=
 =?us-ascii?Q?2uZOAI2cWH6exQ9enUu9UGE2cmOxQQDWY4uhL0jmrKG9UaHZMXGqgR/1PZrh?=
 =?us-ascii?Q?y2lEvOnQJxz0Mq9MxU73WYAA/7m4UvnP7QgXDiSuImSo6g0sKt3I759Z2Fz7?=
 =?us-ascii?Q?0RPgOXH22LGwv3bbNdYw7dlauZxO552RQIT5/ZvpLoxOJrJ2IU0Pb7/hXtXM?=
 =?us-ascii?Q?LAr0hNO/DF9phoaTkIksfatjO563RiNf06xwyXkgcI8JpaiHo6U2N0VJsl9G?=
 =?us-ascii?Q?u7s6u3nceeu+NIbtgONaySvYbEN8KUUSBd/pe0AKrbdT5gZRmmUcHkxDnJ6+?=
 =?us-ascii?Q?jlKqvldfDN5zZRcc7nn9J8yFRzWQKyNISta4hjo3gyX478RY/FUFUEqLWrvq?=
 =?us-ascii?Q?FlVZW7oNcItJ7FPB2iUc+zHDV2+sO5VeL2/L+4w9pl0/3+xt8wXgDYYZLX2t?=
 =?us-ascii?Q?t//9OJUL5woj/QJ6DHNfNknmiJjMtMDhpyMEtiQecPIhF10mLVV1jGtEaIvf?=
 =?us-ascii?Q?x3DWiM4cTe2L6T17o3MCuMKL0CoILjaeSb/qSPoKzc8y4wPVTmWmlJBNKeLy?=
 =?us-ascii?Q?Ucpn/ILcW4b6U9YwhtI0DJNONP6vsgq8fyfTHij6ALh3RdthVCgUGTIE4ah7?=
 =?us-ascii?Q?Ez9R6FOLckRXqTNsZbvPVI+n3J8U4F2HYqLEC1JWNjU1Pa4cvqruJ0RrExlf?=
 =?us-ascii?Q?zPG3KyHctmjys5afYB1C03OFJlbOG76PLhS/cmdr+hyVQvWbKKIdpBoL4OB/?=
 =?us-ascii?Q?ZarzOjTrJ58iuwH3D7PiG8EsWBqugrKD/9tl/mXuXuyZQyGBSzqyJjjBYTdq?=
 =?us-ascii?Q?RQR01lUKg9Yg607w+c3u8b/wGinQDCwwaq+BJeiSz0Pq0oD2l0W0HR6feoWp?=
 =?us-ascii?Q?+dTAe/3Ay0HjIKvbk6DErZJoloWF9BKrV14vNI5X0xHVLt30Ks5M2xWxjlI8?=
 =?us-ascii?Q?w4Yi3h5kqqjnoiEJcBOAyuEVQpt2ecUzR3fSd6KFMQGbXuiLdIOhDzuEu8fb?=
 =?us-ascii?Q?4C0RFYp3gGU+dn2+N8bUTi8jGaNv9tAwdnRjxvNk/wxKMiRx07mk5Q7EORnp?=
 =?us-ascii?Q?3sLUR5aAkpaUqRyTUQsk18iC2KGcokjI5ExYiMRgfJnHNZRI/6WmjuOuvx0j?=
 =?us-ascii?Q?IfaTwRHcDsfZ+RreU1Cw78vll0E9cFiVr7vVfl2/sgoLyEdIECylWcLIfjPR?=
 =?us-ascii?Q?uz5xu+G9Fsa0241asSGco7cdMfbE3AMxDa8Z0wpvHdMvLjr4Y2ylHlLoL9Zf?=
 =?us-ascii?Q?hdgN4Zyep6O1zOCk96f1c5QIxDQ08oSZtWD1fJWWfsC+n7hJ610qJoh7dq/T?=
 =?us-ascii?Q?NgvJF2C+9mUBznHWfX4tyfs23gIC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zyc8AnQNCxPqgFLmHXxqjZ6bmFeZGMOuB7ejT/hV7iUgC0RDpDx19BgKiIUH?=
 =?us-ascii?Q?LU/UlqEU0Ic2RaFI7VtZVFfLmBVna0JBedF7Ms4UuWIWFpcK4K011keNdKQZ?=
 =?us-ascii?Q?RTn5V9oUt0EL/vaIqTk2KZGWQUZi//bt4kNQa2yWBLlcAYtkzsn/hAZA3NtI?=
 =?us-ascii?Q?pNz22A75xjMj4lLoCAafFZLnVR6nuVmjClvoVvWkLLRl9oJmAIGfZlG7XCjf?=
 =?us-ascii?Q?c44zHucI//1mPQ3M7vNKlo6FontvwO36e1aFEIuoWU6Fkb2ZVQ9Uyosg/AgB?=
 =?us-ascii?Q?Jjz/Ga8lHuRhtH0goSKBNJea5HW1gOv+NWZvMLrLGVWFiKhM6NfvCDnY+uHr?=
 =?us-ascii?Q?1xoYA5FeSKsWp0488CEKy6LUkY3OGFNKrk8KCZFc8j6BiXRa1+pZ+Ew5vB0B?=
 =?us-ascii?Q?DuILZPDEhJIWIjAHPnMl/XOV+T4nKUrqV2bny4nn1C/N5rhOHwLm3JWtYT4z?=
 =?us-ascii?Q?WZYXh877a7JsjLZbPFki34PQQBNKtisj1h3TSTn5LhloeL78TJy887LVT1kL?=
 =?us-ascii?Q?UrvO/zTJrGb0cd/mEYEdiiHWkJgFV7k0jjXDIOeyyDx64cG2bmyRGe7TTcEa?=
 =?us-ascii?Q?U/zrGFllVQjuncDkUwSJl5kFyY1NkbSEMj61HKxAGz59cdumEIfh+OBbpefw?=
 =?us-ascii?Q?K9YuqXkVGBvMxx1kIOfldQw47KhSdr/124X3YXkkSCQYZbef8Sxz4sN1KrSj?=
 =?us-ascii?Q?r6cvZHyz3ohk7brcbu+mfLJjbKdFmAdMQqBXUOuhKcapsODO6pcPmPkcXziA?=
 =?us-ascii?Q?2/pTDo2qYXGrcHJFpv1LWwEE86CVDmvMAtXoIbYxRskMHFfTyssiFfBCkZ/j?=
 =?us-ascii?Q?+t1gLi7ysPwJ1ITAT/E3RkpZBsnWe2DQAuESG0Mj9JKk1MGFFEg5X44muzRR?=
 =?us-ascii?Q?f67AlX32spVzePARqgY1quE9OBZNuKKuPpmQAEVuKqRhtjESyrTjc67nBdLw?=
 =?us-ascii?Q?WNDnVhzsAb0BPgKSFQkGUP9WbPnSXZqlhrkuVQqeN/5kdwgs/HQCWSaWHALC?=
 =?us-ascii?Q?X5qNHksmNJrBXkwwfdrZ55Mo7Lg6l9bOogioyFX1rmhQaV6OoobUNZeFfBS2?=
 =?us-ascii?Q?C6wnulqF0YWqWXQwOw2q4R6W261PS4jnEowvRGZRDG8BZChfebCFpZq+7lbf?=
 =?us-ascii?Q?ZV9PWOVIqTc5a+qZ1nWU/MHuHmGzs1W4YSeaB0T5xTT7MQaf8ycGpcwd2juI?=
 =?us-ascii?Q?FLizV62bncKLv9OV3YBSvdyQwsyBn+CgX8msG2l5+VCUt5DbJ4732xrfBvWV?=
 =?us-ascii?Q?ux+Pna1WPFnfz3uc0Us+uZkTqQFkiBHtGr3g8Q1/PRp2QYmXqrKQTb5RgaSf?=
 =?us-ascii?Q?D4ylW1kF2NRhmE0jifmEwUSeD8P8lnlNIxYFzW70LxrnyV/4649vsk43q3Mf?=
 =?us-ascii?Q?GeH8OW7x9AMjH+tjx4i/omy9iciAfRnVI7nUZCKO1kxXHIbWuqxPT/e+3LvC?=
 =?us-ascii?Q?T0lzFAvEBFYv4XbNMpDZ8YeWT/tOJOTK4yEgDd+qInsWQtlugLkPGRC4iUkP?=
 =?us-ascii?Q?MftX2uyvuFb3oFWerLuLKFzv06vZ4SW77jNsBkXUaPRutJpeY2LS6gaZM4dT?=
 =?us-ascii?Q?1hopYiVEYlEvGEdlNMOJE6DCxqpKmMcljuXGQ0En189eyMKx3/V6ldOlLl1e?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TIckFHkTukpaFvovizOfTtrp6rersftWGNbu5vP5jivWnjjTjytKkEWTfvoCMbg68ByQ7WH8/2XAF7twgqibSXyRjDVnDvBjxtVD+dKObxRkWC1oRlCCp8DqQetYauKbT8U8X6UF9nRTP6b7nJA/o4uOhIvkHzd0h4jQQYPcCBlW6R9le79FJvW5E2B+J2hKeKyQwKLZ6ipvO/mmmuiAtcYyq7G3bOv6OyZwKPk6Vwrf7SKkziuhzReMSu4IefPT/Jxe5u4NpvzuaKFIlntDGr6nFCA8385hMpnXPaplEWXsqgxSzciVFWgLeIReJsm/ltIXIoRUr08OaXOcYbJzLVVSGIahpdXbwhFF9GaqsIMnSP7stKLeMbW8VX5EM/PHpNCbHS7gptOodYCRJ0i3x6uWuRm673AQxN/4/g/2DTbPzp/AtjmxwbW7onpJm8aRkseQXeK7lY0z3tLewx8o8/sEzM6KosmD2B1BfEjqK4aivzq8vna9mmKmrS/CsQ/e4PybveQ1qgyVfQH6Z66LDiLoeuhsnEmKhPQ9/fnRqUOCdOmSMdQ4VQShmTIgzvd041ZAcEOyrnXQMOYN5mIKbjGrERrrTwJ+VoMOUThqL1w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5beda007-aa86-4353-01a2-08dd448953ae
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 19:31:16.3787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KBrnMNdcJhqOA/+RQ/EZZqhbnyb/doJszVCpW1IO14YG2N6IjMCSJztvo7cYXN9V4T8nL+Ek43WOOMFqRwpVuIlyFQMehUANtgmg7rxkzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=789
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502030142
X-Proofpoint-ORIG-GUID: CatlKx0rNFe5jZQ2Zt_K273UmYchammp
X-Proofpoint-GUID: CatlKx0rNFe5jZQ2Zt_K273UmYchammp


Christoph,

> Except for SSDs it generally doesn't - the fact that they are written
> at the same time means there is a very high chance they will end up
> on media together for traditional SSDs designs.
>
> This might be different when explicitly using some form of data
> placement scheme, and SSD vendors might be able to place PI/metadata
> different under the hood when using a big enough customer aks for it
> (they might not be very happy about the request :)).

There was a multi-vendor effort many years ago (first gen SSD era) to
make vendors guarantee that metadata and data would be written to
different channels. But performance got in the way, obviously.

> One thing that I did implement for my XFS hack/prototype is the ability
> to store a crc32c in the non-PI metadata support by nvme.  This allows
> for low overhead data checksumming as you don't need a separate data
> structure to track where the checksums for a data block are located and
> doesn't require out of place writes.  It doesn't provide a reg tag
> equivalent or device side checking of the guard tag unfortunately.

That sounds fine. Again, I don't have a problem with having the ability
to choose whether checksum placement or WAF is more important for a
given application.

> I never could come up with a good use of the app_tag for file systems,
> so not wasting space for that is actually a good thing.

I wish we could just do 4 bytes of CRC32C + 4 bytes of ref tag. I think
that would be a reasonable compromise between space and utility. But we
can't do that because of the app tag escape. We're essentially wasting 2
bytes per block to store a single bit flag.

In general I think 4096+16 is a reasonable format going forward. With
either CRC32C or CRC64 plus full LBA as ref tag.

-- 
Martin K. Petersen	Oracle Linux Engineering

