Return-Path: <linux-btrfs+bounces-2808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54C4867E14
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 18:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EF61C2CC7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5242612F58F;
	Mon, 26 Feb 2024 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jsdp7qVR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dj9dLVa/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE9C1DFEA;
	Mon, 26 Feb 2024 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967811; cv=fail; b=Z1woeh07tISwq840gF3AlT1Ikg90AA7gOCMI9lWweW2no4gvehP8XUfOOfh8I8Z9sqNOdnXYanwGX12Z+nr4Rh4SnwFox2Hoy7yfNwRq7v1hnrpgureM9RsaWAadqfN2aqsGPNC5c8IO2oFg/KZEkEBiG1D3N70B3/mhpaOjfRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967811; c=relaxed/simple;
	bh=pgGLXg7+sRlpjwhY1fC2nh9sp20YACUwkjoFUrB6Vo8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VCiNXO7zPeBxmC+3hD/JfcZp7lwztO+g5YJfd47Qc192zyTFCUi/eqfMASITte2qqDFo0WTv8Oebn8EE2M7+uz6OimwN0CwB5MIRmSO0teFIk4FppFDPFj6kdzytKGq10e8sgI7OZ6OeDVgBgkcKU5uTTguI8H0HB7NetgC38Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jsdp7qVR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dj9dLVa/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGmiOa001385;
	Mon, 26 Feb 2024 17:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dojOl2H592QHK5NNhxDyTgNqFZuBg0TCgLq97nECtZc=;
 b=jsdp7qVRB1IzGfWR++cVtUSaE1ZwE7Dxgr5oW4zKGOFgCM8TNwKwk04HKsw5tX8F1Cph
 CaoXqpaUN/RD8uTSG3xUxfbjXUcuiZTf4Tu/DznZJ+fLMM0P3h2oF9yOy8EXGHKZs/G7
 g9xqnklztmLNvek6SDLON40gLe8N2w0W4Za1Tx97BNVkHdNcll7pOSwDt4Dja3Iv7/G+
 2wfQCXJRVORTjGJRkoWaFYEHAzBUTlMvFfQvo9lhx5/Kw9Y4ZqPPFcTEwV9mNaMXfncY
 RIY8Jg2IFveu0+bSPDJ3qxPVbcBTWYgMphr1VBMRXR6/UljlgAn4ZuuQPxj+9MAldvQz yA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784d93k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 17:16:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41QHE1Ti001699;
	Mon, 26 Feb 2024 17:16:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w5vv27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 17:16:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkdKK1z8t7NC038GEK77HqTMDzsY7X4ZagJ21VxfrmSJLuc+g6Vdy1AzxugiwlGCHuTF3pAtepHt7I3fZwZVRK6kSWECjYbeOcEi/pHzEEd48prKCc9D4RppAp3xYoVLuNEK+IrmvKlYldj74DDzp32EruSnVtLpu8oRoHfUGFndpMcMZcyuumG9sRAqbNPEeXYQXbOfmeeFZlrsWtfkUtpNVKeSKR3BkEV/+21lsfWwWmn6to6B9ArMGoqePmEHY7RSADE+SHnVGZmIh4LwsrRPPFAJJJ5cRYHo2xqjHpmoMJghhvMspVtdQUFEXxhwGLqQd/6RVlk8MvU6qFW0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dojOl2H592QHK5NNhxDyTgNqFZuBg0TCgLq97nECtZc=;
 b=E0DVA/R+AymzrUxzq5NBg3QiFcb/fFEdfr1sxfZnkbDc2f2jYzsKoDJw/BjQKdxoOnE6UqQm/xIVV7W9fLLAFmNCUYXEgWt0W1b61yiMsn9thiuD4gq45b5jC9FKElIDl3mYuHpKsROCVpAX2cb/Nr9+juN60sI56SJwnF9gbVnHySeZm5r0eDwPE5kaD9DQJVTfaw6zLOPXXeJbqxvcQuh5oJgON9WCKeKWKga+jDpOYHZXsSfdSbw6RMezU0J5Pa1S+hQD+Qb4U77keBmFIktqpKF3KrqpGbcn4VtJT5f+FJGM3sGuQX4kRM3L0fG/+P1GgxjIZOkJB3yYVQJcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dojOl2H592QHK5NNhxDyTgNqFZuBg0TCgLq97nECtZc=;
 b=dj9dLVa/5e3RVluJPQzTdGVsjdJbzz38rytF6Mvxvy4TRWmnSZJ2D42MgmRi2qC0XKsg6ods8bpU0calOathZblqPwdAfxosXY2T1SO0Xu+baLBT9tWMxevBov4WEllQt9I4fu2kD5/zFRSvDrhtnXbNNC2oa+7l1TS2+W1Ha+M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6331.namprd10.prod.outlook.com (2603:10b6:806:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 17:16:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 17:16:42 +0000
Message-ID: <43fbb951-664a-4224-95d0-a8011495d698@oracle.com>
Date: Mon, 26 Feb 2024 22:46:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] filter.btrfs: add filter for btrfs device add
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, fdmanana@suse.com
References: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
 <20240215-balance-fix-v3-2-79df5d5a940f@wdc.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240215-balance-fix-v3-2-79df5d5a940f@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 3979335c-cafa-4b6e-9be4-08dc36eeb3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	R2wspH0KY+TjGKwP9KsFUO+ndeD9sUyzU+bE5DasnhrBlAn3uHEQpSjWnQIuBq0uyOneyOhM0zMq44R3CFYJD3WZ6hRKzJTD/B4HiDTRMFm8g2WRbzvWtxIzTSz6kkNvOFKcbViWKmIpvWNk9ETdB8yGuLv4px8QTmh4GFIxIAzc0NliqGumgcHCy/sAaAUjPi8CLt609DKAeQjy5vI1rTW2YeuCnAqZjRuNLKpmZcm4AIA1lb8SrAbWN+yD7x8qJeyiZPiRjm9PCdhcQi1AkVxxXargf2AUk1wPMpA/bYABl1/CkTfk/CJzW7xQJdOFKTIGNKrTRZfTBj3ycnmWBvLzio8ZQaoBrne49TPnvkjZaF9tigfwu7HPPag50rZlEntpwcp2JemW5SUVIb6EilJoBf6ku2ORI0aF1dp4Hi6SnHAYEuYabZcgs7y30VTH0z6ds91xlyF2gB3zPBTEe3RM83jRmmMx2wZocxc8kibrdIM+Zw/fQxOHoCRfivNJEKFEuLC1wppPfylmhNJIksPELZ8qz4lWPghoyemZME4ivBZ24cX1H7LBupvCjpd8SaZZaHAs4uDXSTTanLFJFFe4/0h/TTyK4W+fY2W4XARWkbetis/nM/1Ah55OYyIg0sOnp3qLL1fsaQmArl1fEg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ejNLcUh4QUZnZmwxVXZDKzdlRURZajZ0eXRrS1lMSzhOR2dXWHlWcXBVVDA2?=
 =?utf-8?B?SjMyaTRGbVF1TGJJb2ttNGV2YjZJcXlPVHlWb2Y2QmNUMU5DbUJmY0RiVnNZ?=
 =?utf-8?B?emJDQ2gvQmlaR3czdHlKZ1dlK0I4dEw1dTE2ZDBnV1k3ZVlXczBkcEx5QlNE?=
 =?utf-8?B?VkRCTTB1TnZaSDZWQ2dvTVI5Y0pRY2F5SzlsMFZMYytBdnNOdnNvOWxEZklW?=
 =?utf-8?B?UjJKVUN3dGEreEIrZXY5eElXZEJTMDVEMlJKaVVDV0tYa3JKd1hEaEExWmtm?=
 =?utf-8?B?SmNMQ01Jb0pXdTl5Y1NDUDYrc3FIN3RKaVFDKys5N3laT2FWbE45VGJlSGlq?=
 =?utf-8?B?aytESVNMZDJsY3lyNnk5NHFuU24ra2JNUEsvUUhZU094OGhIb2Rhc1RMcitr?=
 =?utf-8?B?TTE1MTQxbVdoVE1wS1doQU5ZMjNTSmtsekN2OGFVN0NkYzdTK1pXdUErL1B5?=
 =?utf-8?B?eWlpakZFWFhFdUN3VHZ0a3dhUFNGNjBZQm9ueG9wRXVOQ2FvWGNzL3FydUx2?=
 =?utf-8?B?VlFPZnU5UGQ4eGVEMXVidzgyQnFSRkJXL1c1SDR4Mjh0ZzNjd0hSUHVCZjhQ?=
 =?utf-8?B?engyWTFsVW96Y2o5YmphSmUzMGdjRDJldExtQ1I4cXlJNzhJVW91b3NNYWs4?=
 =?utf-8?B?WGM3aTJ5SThseXg3Zk1pb1VjYUluczNydjNNS0laWW83OEUvL0xSOCtUdzhr?=
 =?utf-8?B?d2RTdjlJVTExMEZUMnFtSW9ISCt5M2pENFhUVmZVcm5jZG1VeWpSdVZ4MEt4?=
 =?utf-8?B?aWhzcUlPbjdjWFdBV2wyRzQvVkY3UkJIZWd5THJRRXJSa3RONXM0cVZYUTNN?=
 =?utf-8?B?blFDV3BnUUthN3FjM2NxNGZZWGdBVXV6NWJuSEVvZGhvQlNRM0l3bzFwbSs3?=
 =?utf-8?B?bmFZblRoWEV0WVovYjJvdGhqV0VhOEMxZFNEWFFaMmFNa3dGcHBMcm9UU2s2?=
 =?utf-8?B?aFpZeFNFV2o2U2V5VEdlbTg5VEFvcURiQ3ZTVVJkOERTTGpSMHJGd3E1Z29H?=
 =?utf-8?B?OW9SVkZUYjN2MzNrYis3R29KOThtREgzSk12MCtiRFB5a044QWZKN2JhRmV3?=
 =?utf-8?B?NWhtT2FKUXN6MGxFYkk2YS9GNEN4MGJJNTZsWU9YZ1VtMnh6ZE41SmRZTzQz?=
 =?utf-8?B?Yms2YkpnWnpnU215Vjl4dUVmTS9EcDRGT1lIQmpGbGYyTVo1OTJrL1hLSFdw?=
 =?utf-8?B?Vy9NeXhSWWRuY1lkUjlzQUppYWQ4RUxxM1cyUGs1b0thQnZVRklYcnhsRWQv?=
 =?utf-8?B?L3J0c21RaFZpZG85b1d2TldOVysrVWwyQ0pwcFF5cUxOcXF3eHIvREVQUUhw?=
 =?utf-8?B?UjFkY0FSb21QdTl1L3BnSWM4NzBlRjU0KzlZQXhuUWZBWkltZGEvZC85RHlM?=
 =?utf-8?B?Q1RQbE00NVg1S2duLzI3ZmxML2R1a1FKTHZpaUczRlJoQUllbWFtSjU1cWUv?=
 =?utf-8?B?TjlscW8wWDRBdjNwdU52TWgxRUhEeTBsME9pN0dHTFdnenkxSGFrSGRaZVEz?=
 =?utf-8?B?ZVFocWxHcXlrQzNZVzA1dUFRWTFUTFd5VjF4My9WeERSbW4rZUN4TE1ndm9U?=
 =?utf-8?B?RVJHRmZ2UWtEVjI3MFBWaFhLSndUNmdHMHc2d052Q0Vab0pWN1lVRWdSeFZ4?=
 =?utf-8?B?Tm9wUUlZYXg2OUlhVmRTV2V6RXBGTVhjVlhxMnEwajNPK2pXVnFxdUF5cWRl?=
 =?utf-8?B?N09hTW90V3FOMUxCV1ZkVG1pckR3dmZuamZNS1hPT01pWmpoUHdHZUxyRWJH?=
 =?utf-8?B?aU5FbFdhZTdjZUZpMEplZTB3VW04YkNqUE5jWGRxVFhsUnh6dVZrQWJkRUl4?=
 =?utf-8?B?bDhEak1zUzA4VG1tQWJXMVM0aW5vT2kyL3JHS01GM1hEdG5zSjJFNGVTcUlX?=
 =?utf-8?B?ZGdRcUlMRnJnM1BNaXFkNUFMUUo4bWcrV1R3MGV6ZStEdXh1anFLb3RWLytX?=
 =?utf-8?B?cFNlcGhIVDNjZHFTaGZ1cDhzN3BZN0ZoeHZROWtoR3o4SGNIYlNqZ2pGc2NE?=
 =?utf-8?B?OHBPOEVuOWR1U0xNR2VNQTRYYXJ5ZmRPSERJZUtzdW5vMnBPcTRoUkxVRjJZ?=
 =?utf-8?B?bkVNeWQrMDRoSzJvMzFJbkYzTU5oOW9nSTZ0bjR6cFpOTGdtYXE0aTNaanBF?=
 =?utf-8?Q?pTGHptnj5SJZ9Ry23/9xobLIs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2tD8rjBQU8AbSudo7IreUiNjbcEZc0+S2cE9AmenWWoryNRPmxqxHeaqY3gp6dYfcPgiEsOh0xCFvZ9BfbTgLypJqiiaE6dEd1lhWnxNcHJAmE0vq9klzc3ZJvZVPgKLyTDK+OAkz7UZLSq0VH/RZauQ6eamx57JjUC/C3FRWJi/RADddNRiOwxXeKkaNaulQXnDErvTRqilLREhBn4raDCsi1Uu1ig1X+dyZE8vQQRUYjHv5dAGS10W4hpaJkbfLuhsTQ2a0/PdWTGVsR5ugduAA/Xbe12rXln5l0L165bdTYLxWwUkNejaMBxmzfZx/V4El5zY1mXIyTalWVjs2lOboPc8NSpYzDUDrWBSnLgZukQw1LqGhiruZYFLrF7a1jr6DVkwrBxYDejtoAo2ulWIm5FsF+YVEXpEJkbLACeEjO5rKDUdnzM1CLgeNMt6P4tUJPw/EWsSBiSIJ6EcKbKJPW3n1V3JJ6ao0/kpLZ7CvOnJxqgUaAj/et0NmnXwa0FZxMLVYIAvjdaCoKHljcTLrZXUbobpar1a4/kStoYzagSA1PeixqXISCgKSpyX0HVlUZZJDPH9WxUN9g4OhLbqpAxSsOZ9MwZSx1VOKN4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3979335c-cafa-4b6e-9be4-08dc36eeb3a6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 17:16:42.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMPu/Kw/C5GyhuKC66R+vsk7uvP6AeGkoJg7EbkQW6FvqltQiNOqRaT6DSM/CZ1PeRUhvbnAm1sb1xmgm3nCxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260131
X-Proofpoint-GUID: m_KzczPiUSKAqAsv9yyoDyTdceavAOOp
X-Proofpoint-ORIG-GUID: m_KzczPiUSKAqAsv9yyoDyTdceavAOOp

On 2/15/24 17:17, Johannes Thumshirn wrote:
> Add a filter for the output of btrfs device add.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   common/filter.btrfs | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/common/filter.btrfs b/common/filter.btrfs
> index ea76e7291108..a1c3013ecb5d 100644
> --- a/common/filter.btrfs
> +++ b/common/filter.btrfs
> @@ -147,5 +147,14 @@ _filter_balance_convert()
>   	_filter_scratch | \
>   	sed -e "s/relocate [0-9]\+ out of [0-9]\+ chunks/relocate X out of X chunks/g"
>   }
> +
> +# filter output of "btrfs device add"
> +_filter_device_add()
> +{
> +	_filter_scratch | _filter_scratch_pool | \
> +	sed -e "s/Resetting device zones SCRATCH_DEV ([0-9]\+/Resetting device zones SCRATCH_DEV (XXX/g"
> +
> +}
> +
>   # make sure this script returns success
>   /bin/true
> 

Works well with all zone devices.

When only the first device is a zone and the rest aren't,
you are seeing.

-----------
btrfs/310 1s ... - output mismatch (see /fstests/results//btrfs/310.out.bad)
     --- tests/btrfs/310.out	2024-02-26 19:17:51.092325188 +0800
     +++ /fstests/results//btrfs/310.out.bad	2024-02-27 
01:07:13.097603491 +0800
     @@ -2,11 +2,8 @@
      Done, had to relocate X out of X chunks
      ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
      There may be more info in syslog - try dmesg | tail
     -Resetting device zones SCRATCH_DEV (XXX zones) ...
      ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
      ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
     -Resetting device zones SCRATCH_DEV (XXX zones) ...
     ...
     (Run 'diff -u /fstests/tests/btrfs/310.out 
/fstests/results//btrfs/310.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
       XXXXXXXXXX btrfs: zoned: don't skip block group profile checks on 
conv zones
-------------

I have the kernel with fixes.

Thanks.

