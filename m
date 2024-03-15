Return-Path: <linux-btrfs+bounces-3319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C1187CB26
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 11:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0F22838B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 10:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36A0182DB;
	Fri, 15 Mar 2024 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lsAW0Iqz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kt8ASkc1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E39182AE
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497442; cv=fail; b=R4En4/2/EpucrVRBnP6HjfguXQTUdkuQlkUmZKFk7OE6Wl7ZaQcV6bD46vCk9R/WhzQF/h31xxANzxmCBkNwNFQiaI3P8l3660uV+oTcyczzOsrHm17XTyc65gjBEuvcFeiyXgVnwsj/NAb5f87h2aREG2LLrFhFyTonIaEOpko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497442; c=relaxed/simple;
	bh=+yosaVXdlMkBlWYeRGmEMhbqxvqNVg/KYO3FS7KvaJ8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MBl0kQggkCZR0CjRso80vkIZpkWaYf/IUpSPSk83wYCx3K+aeIlKnWEqvt2+rO5trKgkoCuc36jzV77NWGHoQ8rCQQcl0A0bM+3hbf97gHqdJabuMXoBykXYFEemk7EwjrnJML0LjIkOxHYaJKytBLrF6qebKr0zidsrBsCjiKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lsAW0Iqz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kt8ASkc1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42F1ENAG018635;
	Fri, 15 Mar 2024 10:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=R3jUO1j6Sytak0U0K1uGLQ6Bhjb3/edo5y5U+GZ6E9c=;
 b=lsAW0IqzB5nRnOtAQmjVeNH6EQB2wMZ9EEn+kw+n+aijtVsy8E5JIS/gXDqMkyNPv6oF
 HyvWLGuRXh0YNK06J415tC7h9ScZVM28B10FRdoFQkJN8NUiS47vW0qXdf8sQ5LBHU3H
 ppUvKCVCcd3U3VGeqTeJD7Jr7pv1/AMWopUC00fuRsEdPcEwE9ofnwJm1L1WFpQ0Sp4k
 3A1Vvhjb7CZSjWNg+D3Gp8SgdSfFVZPJv/nfwS3m0sgnY1h8R7eJU/JDB9S+Td6Corx7
 fFOC4FtG2WBvxGA5Dg2sX00Vs0xiHJTqrCrVHvh7383h64T69yn3ZJMa1E5HFaWekkWZ 1g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0abjadr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 10:10:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42F9KKik037443;
	Fri, 15 Mar 2024 10:10:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7bpu1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 10:10:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGvQO4HZygczO5CW0Q2q70qSl9iJoQF19pfOn4FmOcbuxxmMSLwdIz28VY3sK5HyIHruUWqMr4BscTQUGzZ6lI7Qagp838MsHuKtWaI4evTZU59lh/qPOcj5mjnahlaBsEz5ySRP9zYLRL1v2mJe4EbvAiA3AscG+qvOZGaVN8CZOFum3u5YOigw8U5dPse7Ns7WBx5aiX/2DXOEcIS31Kqw6aA9rmg49Cm2zbuy4YK8gY3jYL1u7kj02rSEugUK3Xu1wCNEqaHqqs6hUwYoqKsWW2nnjwfwQ6N7Q9sqdsEYid8YkxTwwLjY990njaWfkthcP5sKmVEcScYJz8hJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3jUO1j6Sytak0U0K1uGLQ6Bhjb3/edo5y5U+GZ6E9c=;
 b=V/NA4NoM413ustqDFdKDjZ08L0aA5YrmPxAmezqNFbfnYUmEO1yslBA3cGQl5TMDIlRDpuGaRP4MkTIftQyiILiU8ZyYa4Ep3eZ8oAd+H55eEXaGBa8szNM3nkKPcbsxFJvoXJxZ5td7nm1VdISzvexwz2wg/ulNtepjJEYnazre0/8m4fpyT8jTcy36IXZY6KhJhLMVvOLbRw+tmD7o0DXR5nV0B6u8puWVA3+FVO2zo63MEpMp2BZOclNbYan7i0sm2KuV94Ho7ZNRXRH8KsXLTi8dfYMlaxVrHA0sceyb7MfTYIzfmYtWC5jVfDL2tgaPE8qWu2JXkcaFWMqXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3jUO1j6Sytak0U0K1uGLQ6Bhjb3/edo5y5U+GZ6E9c=;
 b=kt8ASkc1q1P+r6y5qr6Wb9MQUpjhFOGgmhTNeSQQ5RDddWYKoP5i9Qm7enCbMMBQ/MIPFw3uUJh1r6pq2Zhk6Uyq1Zt0W7RsslBHxunYkGJnKpMYThtjB8RNZ3J5s9+qWX5NwbkqnPuNYvGFsxFvTgJboTxWBlChRHoRRvLGRyE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV8PR10MB7942.namprd10.prod.outlook.com (2603:10b6:408:209::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 10:10:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 10:10:27 +0000
Message-ID: <3e85e30c-bf5d-4380-8947-8b07edcfec90@oracle.com>
Date: Fri, 15 Mar 2024 15:40:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: use EXPERIMENTAL instead of
 CONFIG_BTRFS_DEBUG
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <a3d01ef26525e9730f1d94de3d7c8e57f3c73fc7.1710458248.git.boris@bur.io>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a3d01ef26525e9730f1d94de3d7c8e57f3c73fc7.1710458248.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV8PR10MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fdc7b0-0c5c-4a60-0a52-08dc44d822fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FWpr14CcPtCozkaTBiWMX2dzqLmJyFtjPEItdI/khr9AbOeNzhIxwxTt9SiIru0mav23F1oNZM1yja46I3mH5mgiCpcAqbGkGQxq2fYmAi+seM/6ZW3CRuIX0bCav0bT2ICehbJiPMBqUXmBFzSznJyUqVgXW03ZUa5isoiOFfihh5PIi0SAf8MO88mxXBCnqqo586h+dGa0xugcowcntfqWPcAW7CeG+kIUDsIBlibuupK2tKW9/I6drcK6eTcbz/kQ3JqgC7clhS1wt6/LhMiDObfXHUWjyOo65AP+3UyFMO708owMVeDCOQWI1sd2PWiMh7Ifn4OqnXRJjcz1Ilp4jlV8r5wnY/LSDe1Eysr5RoNfFXzY4TBxgYD7uXxvy9dxMHqyz9suwjz+cKViRcbXBJZIC1Q93noyMiyD+RES6ucWtmWwo3aHflu4eQ7LwYaO9KD9WeahJSNY05eVCiGhSYbN4UW586VncMMLUl4TrL2GpEuAxKr61lTBZU0F/jQi0p7HFiaMb4rmuOmsIdcQZHoeLFc0M/uOqlBEbIMu2cVklj1D4jCbZHlwbTigINwBhX8QqYswMZpn2uJwNXs3iUU7I42tgRA/b5kSU1jr3z1sYiGV99pu+eXkI+LkLY5paYxXIGls8M5gduh0qQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VmgxQ2JRcWJKSmFsVDJrQ0hMamJNOVpUV0F1WW82UURWVUlWeE5rWjRjblNO?=
 =?utf-8?B?a3diaVByUUZ5K0NXbEkzOGJVMUNXU2pQSXJzQkEzZkl1UHBiTjFmeE90aC9m?=
 =?utf-8?B?dUE2djJBbVBKR3h4VXVBZUZOLzU3bWtRSktmMGhHTXJNTWlmdjJuWFJvTFJ4?=
 =?utf-8?B?d2NSUnl2OVpHa2IvUnJ4bmZlN0JxdEdETDg4NlVHejVPYWR3Y2pmTENXa0lz?=
 =?utf-8?B?MVJCbGVpb0trclByOHg4b3UrV01sQkZiZ1BJMWJ6eS8rRWtnSFRxblMvRVor?=
 =?utf-8?B?eXZmN2xXY04vKzVmUUkrWDlrSkpRUnZHaXBRaFlKWGVtU2dxWVdHTmNMSjhB?=
 =?utf-8?B?dGowYXVxQmFSak1iSUdaZ2hGY2FYcG9iT0ZYT2lqMmlGbEpnRGxWSjVnRnJF?=
 =?utf-8?B?MCtCQk5qZWpnMStickd5aEJOQnp5N2hBNEdPcWowWXVRSkJMTGZIYUVYcUI1?=
 =?utf-8?B?OTJjc2F4bGtpQXVwOWx3STB3RVpnQjhBSWtwa0V5N21Rb0l4SXFONGtnQzVR?=
 =?utf-8?B?bjI1TXhrU2c2RVRiU1F5Y2tBL0xIVjR4bVdBZEc0MEJ2NmNNUlF0N3A4Ti9Y?=
 =?utf-8?B?NVV6cmNtQ0ZTZkdJZUtlVTFlcGtETXpWaUFIZU0wRzFtdnVHMmhPZVpsUzJy?=
 =?utf-8?B?UW4rTGJqdVI1WWY2VUsrdm4xMDdyMnJXOGlWWWV1QWlwbHdvbEkzUE5FTG44?=
 =?utf-8?B?OW1kWTNKRWhWYnc4WXlZWUxRcHFwUXlmdTlSeHRiZ3FYMmV5OXhpV3FqT255?=
 =?utf-8?B?bHF0dy80TVlmK3R4d2g0YUlOM2kyM083K3pEb1pFQjYvUzBFQzNISmc1Tkdl?=
 =?utf-8?B?YzZTQWdBZHdpVVg0NWlBMTBZRmY3TzJ3RFBsSHNPWFU5NCtTcU14cVRCT0lP?=
 =?utf-8?B?b25uMzNVNmZsUGEzNFpTMDV5S2dURCtpMHlzTUZEVEw0MFk3dGpaSzBPNjNN?=
 =?utf-8?B?blFzT0pKaWFDQURrYS8zZ2hqMjI3VndOcmtOQm0vT0JtaDJzRXJnNnlUNWpx?=
 =?utf-8?B?VDBLT3ZnRkI0bCtZZWE5WGhSU2tPYUFudXhIMmpnemp5SGlhcjJ0UElLZVhy?=
 =?utf-8?B?MndMZkY5L3dUV3hzdW5STDBxRVhhYzNqQjB4ZXJlREIyN2lsRjZTVTUvNERB?=
 =?utf-8?B?YVEyT01OLzdOK1NnWUVpdjhGVVJWbU51UkdpWmNONXBwSFNZOXZ4YUMzSGJI?=
 =?utf-8?B?eUNseHJaTlRPdDN4Zy8vVDhZZEdlV3hLck1vdjY2dFdJaDVIM3RzWEVQcThQ?=
 =?utf-8?B?bjJHN1VuVEtUd1BCQmp6SkQ5ODF2cXJ3Sk5FS2dHQlhRTDg3YkQwNXVocEtB?=
 =?utf-8?B?YkdoSi9ZYlhzWTJ1T2VCMnFDSWt6aHg0eTYvc1lPaHlkcEtBQ2N4c1I5dU1n?=
 =?utf-8?B?RW95Z0NtWmNSaVV0VE1IV2s3Y1FWWndCVWFiYTlMWHkxWFUwbk1pdWVKSHZB?=
 =?utf-8?B?MjR4YWY3YW10QmlST1k5a1RBN256L1RHQzMzKy85WUo3M3pRWEdHQUtJdTdn?=
 =?utf-8?B?U3ZNVFZISW82aC81SGZITXNTNW5uYnJyOHI1QW0wYXQ5ZG0zY2xvZXJwMVE0?=
 =?utf-8?B?M3RnSDFtR1dISmtrNXJUem9NdnFvNVNDZXAzbnloZU1RZ0VqcWNzdkZ6Rm9s?=
 =?utf-8?B?RDBTbWs0dHFsQVJueHZaU1dYYlE4OWwvaW5pVzdYYW9pSVh3MmViVXJ2SlBB?=
 =?utf-8?B?VmJGZEYzanpRdkkxRUhhd3poa1B6M3I1djhvcWw2MGRJV1NKNkw2UzBwK0l5?=
 =?utf-8?B?aVJZc1lSY2pZb0djazdTdGJ4ZXhjTVl2dzVVWHNCTERJK2k0TjRYQ0ZjNTNZ?=
 =?utf-8?B?YUpVR2pvYmd1TmJyeHNzeks5OXdFK2l6eER0RVVWVHNxMzJkNTBXQjFjZjFE?=
 =?utf-8?B?TEZuUmw4c29HcUNLUXhoSlhxRldvWE9ORzRLdWhvZDlHN1pmc082ckdEU1dC?=
 =?utf-8?B?K29ldFZrbVNEa0FrbHlibGl2eUszdXJXK0xEWVB1V2l4cDZlaHNESWthTHBX?=
 =?utf-8?B?Z1k4OXB1OGtoUWVBM0VXTEJtSzRtSUIwa0IwRFZrZWJNdnBJeTlhczhsdkRR?=
 =?utf-8?B?VlJMY3I1d2xMYnZwYkJvTWhSQUp3VWlkVjhOd0V4a0YvZS9CUW44NE9ZVDFC?=
 =?utf-8?Q?D7bT2Nnss6iCR8wvI6XQnTVCh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	l7GfLD7CpIVL+adD0K2gt8JZ1tHVCIc9NS8FdZdnHkZuIa8+s5OM0Yosk6i1slnuSimxDRNJ+RZI6GnzXCPih3Ot8Aqt2JlnYeZV9uw8lGY7JBj7K9g15luivrcNK3w1VfXyZA+LSg9RioSiTpx/tEGIUtnfqmHQ2VsSlIjf7kasMjpX36tptXgS9YVAbhA1WVQtZR/xc7S0yYGn1g26YHYdSWi3pCdMIE6F68+JA6uANuC5sLOXBU4sK7xm6vmPMjwspB6IVwglyDh9ZZIUV6p9ra1kEA4zfovm2OVSPOkoJbnM4bvHweqw7B/EbibQ0a4MiBZshNNJz+Ue82Ch2qqCjoHlZxda2aCBZqn5+ZPaYrtmdRn+bRY/DN+ctnexnv2p/gnYynw5Wd5XO76tTS3R1Oi3vs/Cw1iwj5xGrlC/KbINpA7/40WwwkWbDGmHCZYTPfIJOM+AnEjt3WhW8LVNZucI6oKku4KrzWuRy6hMhVcRI/owW/eaySXMPx56FbVe4HOMOE+VYJ+pgIJQpe/3olplOn+w326Gcw9B9LJG+IFjPsPBXhg3rXG0x/jjbzeef6utHBRzVcg+G6d3JJMtzxuSPvI9dhkTI/E3Hwg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fdc7b0-0c5c-4a60-0a52-08dc44d822fa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 10:10:27.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJgmbgMP2iUNw8wFfLrCes3bISnULbbnk7YKbabI3kVIiOQL6dq5Y9vKXY9NWZ9dvk2bbhmEXSo5ZSPck6EUCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403150083
X-Proofpoint-GUID: ZdaNzT5QupNDXGj1iaN-7dvCCurZz5Db
X-Proofpoint-ORIG-GUID: ZdaNzT5QupNDXGj1iaN-7dvCCurZz5Db




On 3/15/24 04:49, Boris Burkov wrote:
> not sure exactly how this ifdef was supposed to work originally, but it
> currently doesn't and I don't see other use cases of this pattern.
> 
> Use EXPERIMENTAL which does work after:
> 

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.
>          ./configure --enable-experimental
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   kernel-shared/send.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel-shared/send.h b/kernel-shared/send.h
> index 34de60ff0..ce4a99e31 100644
> --- a/kernel-shared/send.h
> +++ b/kernel-shared/send.h
> @@ -25,7 +25,7 @@
>   
>   #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
>   /* Conditional support for the upcoming protocol version. */
> -#ifdef CONFIG_BTRFS_DEBUG
> +#if EXPERIMENTAL
>   #define BTRFS_SEND_STREAM_VERSION 3
>   #else
>   #define BTRFS_SEND_STREAM_VERSION 2


