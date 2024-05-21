Return-Path: <linux-btrfs+bounces-5176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A718CB2A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 19:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB27281560
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADE41482F1;
	Tue, 21 May 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G/aokEN4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J9+WDJIv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AE422F11
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311576; cv=fail; b=NyY30m+YWHm+hBjq378+bpz4dKq3i0nBzISdEc8uV1Bb8JjkQQ8ZxtfdnP8z4vSNyQaZ96QcLjvbqOTe8Y1mCj8XsHGxznWjR6SAGd2QzHCZYNOtDJF5FtbFSfrDFyi/KhwitUiyPKFeTryu1ek99zfEO28VLunyxOKZuf/0OwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311576; c=relaxed/simple;
	bh=tEEdKdYSFANUWzeeKyQsgxfagrkkFW03mzD2LRHXAAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lgKV4tWLBvGHXBLWqFxNRsZWLRrjIe1t3Yc42zbfNWAf1FC/3bV9QcwHF0RQUzodtsY0z2aqYAoasTPrnZL10iYD2NYc9G4I9SgYucTIkrp3ocw8qTYkr8oJE6SbAEiRriLxjbKnz8N1tRQhuUZWYNLtblFn8N4qy+Jbm2Ye3OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G/aokEN4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J9+WDJIv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGxMJ4001546
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=BzBPKXoRkmgzu7WZey9QwHWBuna8Ft9iQ5DOd1no1eg=;
 b=G/aokEN4EX6+CRQM/1aUTVj4v4jASvObSzIm2CGjM2cSlF3Ix7YtfMHZyPHzUB/k1l8R
 T4C59MEDp3ktqnjBuKvFgrJXwiYVtLA56g+YhrzIUel/iqQ8Ro7q9TwfKB0HkjWH3ILL
 YDe8UzBFITlOjrMLxWXju+RY7M3lSkpIPBKzYNxGKFtDdVyGnnLNHpyzs+pCBTwvwJ9H
 V0Wn5p3fAFR6HisohhOIz3bpOHmNbpIFCWl8KATN9VvSuHFjRvHragailr8QEoB7UXQW
 bBfGWlEmYXP6DEWquDgzAmROWa0GZhUFGbzd2/1+lhSQAczQcnlXiZ4y/xZX15VkHCk+ Gg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv5vyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGTK8Z005029
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:52 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js88stc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzdD64wNzxjblojbQgvRUqmdz/xLWcls6USvRJDmStKba9hRddHuMrEnxtmuetAOQJNE+fU+23RviOq8RLHLAr7655RQ/h9lHMvZusDJZsj2ZG6+CQeB6A9wHnEM4fCoAWH8r+chz3aSfDnC+s1f8TH3e3mTOcxQB3TMmlf/ZlrKTz4jJmkGJnEsO0MnJwjbW0eRY/uJh5c2N0m5XIq7NnLCkS4VEL1+HLTaxFotvZ1XQZXSQw1qN+277extw3GhVmKJ7F4z+VMODI9FQLRPNw7ITbo/FEtTG6/ZStVONMPfKr/tVyXx72YZLRMRyHzhjzcSm9F0cdiOlBgINv9tDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzBPKXoRkmgzu7WZey9QwHWBuna8Ft9iQ5DOd1no1eg=;
 b=GBfFhe4ntvJbtKQO3yY17YsJOscrNP6Xqblic0HZTVteGU1QPhIGlkqac4AvdU9A/eAW2CQzTzX2vuqpTJ8JQY0nUZ87TDHg+jvQ4lNc8NxvjbQxxpRF9ESshPr/PS3eI4k8uUqpCXOSLyaP/cMndYtl9Cfpln3sUDyn925SPIpYHcpIGspOwZ0jUhvBhOd+HuzDO0KuxpC5EuqPQBfNdoy/UEcElU7iXfzRGg966dPUA50CLiQHs0My0LMWhbjnWA4yzo0oGLJ6wdujc96AFmFy6dyMs8NDOkkqN/43/PZ/Vj0QCCe97nQAhpfigbp9mm3cK2ToZwzhfCQ6/Vv+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzBPKXoRkmgzu7WZey9QwHWBuna8Ft9iQ5DOd1no1eg=;
 b=J9+WDJIvNvi3o9+oPmIWHKKldHNtdP8V+vHclPwMsNS//bwsad6BFFTmTitONmE7Q8P4jkGJpTZZesVBwDHG0qGrHEXHh92gw4a5FYP3nBJIftIsq7MUdVq6CkxfkYDiU+wbSwNdabu2/cMBivUBvBjHgKHJrgM5KJUkD2zIHZ8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB7520.namprd10.prod.outlook.com (2603:10b6:208:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 17:12:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 17:12:50 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4 4/6] btrfs: rename err to ret in btrfs_recover_relocation()
Date: Wed, 22 May 2024 01:11:10 +0800
Message-ID: <85f302e316b167baa19504f4148b77cc4cae8bb8.1716310365.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1716310365.git.anand.jain@oracle.com>
References: <cover.1716310365.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e3a43d-a1e4-4134-6245-08dc79b93dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8I59IzBKbaplu6zQPWLuyDJGU5/brrQg2lFoXLLYHrTWYZyk8c2AmzwF3wv7?=
 =?us-ascii?Q?lXUCpe0+j2zo9aozJMcFKni13zfBzswUX9ql/V/jKakltCkyF6HO2Ldh2NxO?=
 =?us-ascii?Q?Ozm0xWcakWdW8NJYfZBbDPlGXw0DDOE7TrsFWCB5xR1u5cZw2oIXCB/zWxRb?=
 =?us-ascii?Q?udukM3punR0lUEvbp80cZo0p81EsVVJNgnLeF1UD5SK2JKGs47PlazfKKcz9?=
 =?us-ascii?Q?nhEWig3w/1mxUQGIRPg+wyDregXRu6fj827NKZeoXdRSXH/GviGMmSB8meJj?=
 =?us-ascii?Q?BMP1RYha3BKW/LH3yZm2lmqbNvZMtzfWgo1sPUBHjgtUCkxLCWpmD4Aw0pJU?=
 =?us-ascii?Q?11cOciSFqEyOv4iJIJxXnb2peROywBY2sXlo0PPhoLYNm+l5VCW48DOmpnbU?=
 =?us-ascii?Q?dWi+MIN6UdS5RdduXkZd/osRJ6X/UfNjQ4h7iiSGXdWnedlwgFvgikGrYr5y?=
 =?us-ascii?Q?y1aPMPGsYxFPudosj2pouva0iLeJmfJUxEBDZztHtA87sLRufq0w65UTCCi6?=
 =?us-ascii?Q?ABxH5TbIsgqWJm6UT06g3gzKv4nytxTNCME9BKgTQ7K+ODK9KjPruzyMsVkH?=
 =?us-ascii?Q?JEDRik3eaohIUGmcMr3kOndD+OXdJakDjWOKwnIzq6bqkj7jdH/gW2BE+Riz?=
 =?us-ascii?Q?3d+tYmh4a2NwnVyb2Vd6entiWH5WNpoLH2oybezMK3vtObCjC/xu/sDdLjvz?=
 =?us-ascii?Q?LRUiChyTQlElhe49PA1ULQZa2eY7Uk1rW1wb1usu1n74zEaXA9+LbYfX7BF7?=
 =?us-ascii?Q?Xw3LPjhmUwQk0NmXjh/Seuk6SnfwPRQOeCweTfdwPp1aBTBxUzVJ+PdkNtS6?=
 =?us-ascii?Q?qaLWwxZET/xzriEUffdIdNpsh9PXbE53ZdFnD8kMapYH7u2N5n0EKCFraIYH?=
 =?us-ascii?Q?iaant8V5xMUzJ1xBNpn2lt+2p7chk5Z3Y+KxGQvMhelZVraH3BGCfx7vt18x?=
 =?us-ascii?Q?ffPkukLo4p7Q55x/znUYl0fV5/Qd2g4h1ofgod2QKHc6qIDs1saRUnLTyhPL?=
 =?us-ascii?Q?k9Ri5RFwicTaJGJQU2VVbzZa3O/yRDU5umOiUNZWBm1zvFChT7/4hoUzdns9?=
 =?us-ascii?Q?6xf8qGqeqbD1CvCIPYurLY8o4ERG23ZXb/9bJzJVilFWZtgXHw7IapHl0qQG?=
 =?us-ascii?Q?pFhcMj/dVIDPUCjk5j9+w6Nfp6WCXiiXv7zsb2MfPciYWvLkqmWYOY1dGJUs?=
 =?us-ascii?Q?/XHdb05Iz8mpp5fAM5Ov8/CFzexgXYR5ZcmfJ2swsDTmL9YyZf8IFe3V3ino?=
 =?us-ascii?Q?tBsjoQ5UAaqlkyvDJZihaP0dJvs/1KBwMpmiaYiGSw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Oqe1F1Wn9jan2wqo/daDJenR8kpwjsRMYEMvq4XQ/FVC31cqwxTZGcPyuH+o?=
 =?us-ascii?Q?pL32tKB2ZcCcpOm8d/GRWH0dTDBbvt21E5Jc/dBgkN25onoJ2OzNqaXRAS4c?=
 =?us-ascii?Q?Q05ny8Yl83FUN4o1nsQjYFPrLkJZWD/BU2bXvVYOBw7a66c9jP64Jg4ZMThQ?=
 =?us-ascii?Q?w0kc2HvPxye7PszZg8OJ0jIonZEelFmc0JUNEJHNNTq/gSzY9nr6EJoh/OV0?=
 =?us-ascii?Q?/aZ9CIs3PQ5exfNG9Y1jWolzCpdq/Z9g94HHWhZro4Lev+xbQ/RoJqEX8QK9?=
 =?us-ascii?Q?vd22BpT3mUWn/kT2v4VH3vt/cVaWPbkeJOh2ABcS/X8sipDviuoiENjgTtgs?=
 =?us-ascii?Q?t/ohzW3eDa9j9Kwpc7jyfSmfFZ/SHQohKzeRuqUTJrnQOOLKhPuIVNcJmPG4?=
 =?us-ascii?Q?8JOiVHfv/21rZRgHzhTmGocPt1E3IQPXBoPnttqw0//o23uLkqhuMjySnZF/?=
 =?us-ascii?Q?AmLLJSUemjiLlzdJhhIsZRnohQP8uIbE8Pi5dEgGv5k23jil9RGz+WylQJLR?=
 =?us-ascii?Q?7pTSflQCIFGtS7CNqxHdKD9VVxngnTnSVI/tnj3SxMukadgzn+TPoEvgFfGU?=
 =?us-ascii?Q?gb/cgZVS1F8/RC8lxKjpxQYKsZ0i96ApzqrNKI8XpH4q0kWobo8Oa/pWB3KT?=
 =?us-ascii?Q?ZXxDpxnXi+EBT7y8/nojsThNltEzvkhcqf/D4TWXqL/iyxs2shiZtTyyOz70?=
 =?us-ascii?Q?zGq+uS3wIqqkl0DmX+eqrbfw8cdXiAp8ldGf403sZ0ZgtBFTRG2KETvMgHn+?=
 =?us-ascii?Q?77e3wv9W8Vl42bGnPclyLxV+6Iq8vBVaBt52IFbshvle89qr1eSATKDSrvxI?=
 =?us-ascii?Q?mD8+qigstE9VM8o8K3ZE9BTWPBDgcT/JiTS4LmM6KkW3fBlq0zQ903RQfg1m?=
 =?us-ascii?Q?XRXTqbiFyG5a4ULaAXu2btNibn6aLF9X4b78V3VT8YUZCupvkdAODaL8LyS2?=
 =?us-ascii?Q?SB1EVNC2Gq9dpRw9EKKZ3gYfucTZEeekDzxAfz0Ya7wOKMPVgieYP0k0Rtv5?=
 =?us-ascii?Q?F+cNi7J7c+qT6SUzj7T95oK53kTG1EeYLPNEuvcFzu9BSZOU1PzhM6op4wFo?=
 =?us-ascii?Q?9ZT/mKfFCyjsGw7gHuG32ckjxPVh6zzI9wJHyt2hza3AeGNrLIvUctIoSeNQ?=
 =?us-ascii?Q?NEbUZTUFqZHfTiaRWwh+27GQ/q7j8SfqzNr9ABrn3ZzdA7cyjXciVI8jV8n7?=
 =?us-ascii?Q?uJmPhA5/VJSi3Rp+KCBiiT/TbuD+16sgf33Z5vk7jjsx9Hwsp1xxqudGYwjp?=
 =?us-ascii?Q?x3IlbkOVZe8GWHcViXRyOSf5SOat9G9n8CSBm79PZdXHc2T3Y/JVja2BBCEj?=
 =?us-ascii?Q?PtGto2boXKO66cBw9I0tExWUmBo+evJ6nfC+quGtZeWCT6RL5bK9Kf6ds0WY?=
 =?us-ascii?Q?uy/EbnlcZTvMcRLO1fE31fU7INVkmiIb5sQw7N5leDnJXUlT4CqksVGS2WER?=
 =?us-ascii?Q?Xpag1TOq2MQcOozcuhGLcEdkZcSUB/m8u8jA2El60iIi0O3GdtnajmGQMwzu?=
 =?us-ascii?Q?opxdIYc/R2Jllo1NyaB5CRN3a3X2BSp3dpA2YZK/HJM18UHgbY6ItqtUC//v?=
 =?us-ascii?Q?4n+Bnfd0xa0i8Z6V6mpBDRHF0M0ZqQnEtCOwSd5yAEbgxoiHrdYRtlLDD30Y?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OFWY3K7wX4TYuodW7VgxDwwJv6MY+PoGKPugvHGrLHOjulsIDVkOuT6w33qRrkBRCaICe39um8ZHUdNawfP5nf3QukooGM4shyxA+z7sJJUeV7Bm/LnTTJyYjQh8Mi6oNidc6f1BXOXW53zEUMut1zN6jCv62GZEktlDGUgwAELwGXqMTDkb+sXCrd4o5HkaW2UKJxSiqYQfVDkj4OzSgonN/GMgEGxS1o83iqdjMxjBnGBUaFd/JvyIIuAxD5whLrYIHzHKiIdUM1KLhyzkoXX8soUdrVa7f9wbjTyjjP0UQfaBrF7mwwSbF3hkNV36l9W/Posi7qrpCR5rTRZNJ9riyojXDsQxU91Dlu9wJnZcpvLtw0p8jTifOtwujxudOucuLNfn6TEoo/Slbk87CleYHtyCON/A7aTxXbF2s1jxFVrE45/YdmClsvtc9fCv6nmbvjmb1wRTsIAM0yIqbuR8wEmq0f37Hh4xr9tGWWbIsG+hEgYDXVbmW7lWlTQNDZAFPxnWJP5/IUGldN16kkFBuBpgMHtX9lSezIBQxHSqTUR74adr/NEHDUvhHY+RmKw3S0IZDlYSEKQW3HGHoUKtx8hY7KPRzc6IS4BP9wA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e3a43d-a1e4-4134-6245-08dc79b93dbe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 17:12:49.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BH0shLeflek8pgKW2P9enWnK6U9FXOObO5X/WtM9IKHEERAZx2UmmJY30/05bKj6wZ9vssL012IsVDYEepQugQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210130
X-Proofpoint-ORIG-GUID: 980JZz9Aj_jvgHdeIpgqj8XIDm7djoqO
X-Proofpoint-GUID: 980JZz9Aj_jvgHdeIpgqj8XIDm7djoqO

Fix coding style: rename the return variable to 'ret' in the function
btrfs_recover_relocation instead of 'err'.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v4: title changed
v3: new
 fs/btrfs/relocation.c | 56 +++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d621fdbf59f3..cd3f4c686e5f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4222,7 +4222,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	struct reloc_control *rc = NULL;
 	struct btrfs_trans_handle *trans;
 	int ret2;
-	int err = 0;
+	int ret = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -4234,16 +4234,16 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	key.offset = (u64)-1;
 
 	while (1) {
-		err = btrfs_search_slot(NULL, fs_info->tree_root, &key,
+		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
 					path, 0, 0);
-		if (err < 0)
+		if (ret < 0)
 			goto out;
-		if (err > 0) {
+		if (ret > 0) {
 			if (path->slots[0] == 0)
 				break;
 			path->slots[0]--;
 		}
-		err = 0;
+		ret = 0;
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		btrfs_release_path(path);
@@ -4254,7 +4254,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 		reloc_root = btrfs_read_tree_root(fs_info->tree_root, &key);
 		if (IS_ERR(reloc_root)) {
-			err = PTR_ERR(reloc_root);
+			ret = PTR_ERR(reloc_root);
 			goto out;
 		}
 
@@ -4265,13 +4265,13 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 			fs_root = btrfs_get_fs_root(fs_info,
 					reloc_root->root_key.offset, false);
 			if (IS_ERR(fs_root)) {
-				err = PTR_ERR(fs_root);
-				if (err != -ENOENT)
+				ret = PTR_ERR(fs_root);
+				if (ret != -ENOENT)
 					goto out;
-				err = mark_garbage_root(reloc_root);
-				if (err < 0)
+				ret = mark_garbage_root(reloc_root);
+				if (ret < 0)
 					goto out;
-				err = 0;
+				ret = 0;
 			} else {
 				btrfs_put_root(fs_root);
 			}
@@ -4289,12 +4289,12 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	rc = alloc_reloc_control(fs_info);
 	if (!rc) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
-	err = reloc_chunk_start(fs_info);
-	if (err < 0)
+	ret = reloc_chunk_start(fs_info);
+	if (ret < 0)
 		goto out_end;
 
 	rc->extent_root = btrfs_extent_root(fs_info, 0);
@@ -4303,7 +4303,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_unset;
 	}
 
@@ -4323,15 +4323,15 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		fs_root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					    false);
 		if (IS_ERR(fs_root)) {
-			err = PTR_ERR(fs_root);
+			ret = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_end_transaction(trans);
 			goto out_unset;
 		}
 
-		err = __add_reloc_root(reloc_root);
-		ASSERT(err != -EEXIST);
-		if (err) {
+		ret = __add_reloc_root(reloc_root);
+		ASSERT(ret != -EEXIST);
+		if (ret) {
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_put_root(fs_root);
 			btrfs_end_transaction(trans);
@@ -4341,8 +4341,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		btrfs_put_root(fs_root);
 	}
 
-	err = btrfs_commit_transaction(trans);
-	if (err)
+	ret = btrfs_commit_transaction(trans);
+	if (ret)
 		goto out_unset;
 
 	merge_reloc_roots(rc);
@@ -4351,14 +4351,14 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_clean;
 	}
-	err = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
 out_clean:
 	ret2 = clean_dirty_subvols(rc);
-	if (ret2 < 0 && !err)
-		err = ret2;
+	if (ret2 < 0 && !ret)
+		ret = ret2;
 out_unset:
 	unset_reloc_control(rc);
 out_end:
@@ -4369,14 +4369,14 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	btrfs_free_path(path);
 
-	if (err == 0) {
+	if (ret == 0) {
 		/* cleanup orphan inode in data relocation tree */
 		fs_root = btrfs_grab_root(fs_info->data_reloc_root);
 		ASSERT(fs_root);
-		err = btrfs_orphan_cleanup(fs_root);
+		ret = btrfs_orphan_cleanup(fs_root);
 		btrfs_put_root(fs_root);
 	}
-	return err;
+	return ret;
 }
 
 /*
-- 
2.41.0


