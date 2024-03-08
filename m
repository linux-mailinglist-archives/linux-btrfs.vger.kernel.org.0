Return-Path: <linux-btrfs+bounces-3111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C72876805
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 17:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100BC283A25
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0597D2C18F;
	Fri,  8 Mar 2024 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mFViQY0V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h68jkhQt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8215C0;
	Fri,  8 Mar 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913895; cv=fail; b=UMHnu3/+CKK9i67KdJOHd3VyqEL3KNSlKwq0km2CjuFMd9YhVDUygp7BHBprWsAD48IugEi9x9vkfErnMHeIrb5RzWOUQWGgvopSQUDnof35isElJII4M+Tqt5sQnAb6tZekeksjXICGuD/h6em+H+Gozg1Ti7DBTXqv8dWbQQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913895; c=relaxed/simple;
	bh=gCa/jmuF25ZwtjoG+WRRmpOP7TDTQsFyU3IOwa5+Fmo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rLBRkEiFmYpoF5TG/53OK4fqSnU/+93sZbIT6+wf7/dzJIw4CYwwvw7DbMhtvV5vqvsrT+oxzTcJN2UrzEBtUgJQ9XCnwQy45l4q4nollWA2akcopQ6YILTzaxB0RiUtb/JvykCbz74qi9EK1YJXLmHogm0ffj1ewhU9xkS6zXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mFViQY0V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h68jkhQt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428DThKE005340;
	Fri, 8 Mar 2024 16:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Zjn0s7win2F2DqDuWsgEre/hokUNPiR3EJVS4AGwC+Y=;
 b=mFViQY0VoZaYK7EbFnjtIBpDvg6NB/rfcGvbHoacWKSmmFHR+q8oYtq7NYkyHMF/jZr9
 F6flozJYT/Gg6aVZXVplzwDLouQn5pM266wVNLkwZ5cg+iHp4SHGVdLe31WhVSe3gYRu
 XuihlThg8mDF+oG/OMBgQJDKHLTbxKVmOKuSRf8Db/dT4IoICEv6wNoN4kFCyYkfyVsp
 1Dtx3VMP/P55ZsMZiuwQ9DFjc66nem1MMJB04iDaRTVY3YFb1T6XGkTvi3h8OIwX982o
 u2qdv2V5oIX7BcTdvg1viedf41Wq4d1aMWEYN35iSaIe6mPZsmHwDOZI/5KLgbkTNuh1 lg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1cpauf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 16:04:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428FLhuP015959;
	Fri, 8 Mar 2024 16:04:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjd1129-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 16:04:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oU3DXQK9ydzM6N+BB7bx4r2uwJRh8U+EmMm5vkD6cFKBDzgilPAzddf6qsQlEL5h8e3w5TY4mkVm7SwoeywJNHbgHwayrCwjrc74BZOM84GK0AwpO1Yl1TAi9HHjIyDmcJCh3PQzSXDq4ARzakalLUu7kcBAqOg27R4+60/h9hi7ujl705xHU4ziyu6hoAb5YprzchGQ3+ssDWaf08JoCKcm3z+PIYp2pTOVPhJw7MWX+ApqQgHFUxvd2f5LLedCN9JxxwHxx5QfjQSnvKhzJYrSoWXEpGogBSCEDAXiF9g+EtoMhLaP1jdwh7iVsks3ol2fcdpW/3fe1RORPh/qDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zjn0s7win2F2DqDuWsgEre/hokUNPiR3EJVS4AGwC+Y=;
 b=KAvHnh0H4MtnXXJRI+aL8lMkauaq97c5Bh/dzp0ISgcmHEfr0kc/ko8RnpJFs6sFPftHM5GB9hW2BBB0XPDZB21rOyNN6smlg9AP4GotvkCu08C2vYpbPq+9WkobdPydFc2jdV5fczQzyj6gORH0ap0VW72G3JF66RB7bXe1YIezLWewLqXwwkEItgx4foAupudIFlD2mxzxBdirjhrbYDSkmtWSlRj53cRU9y2YuEkY7YYih4CKoxQTOGo/ehKiZgJoXrNiJ05vSO9/taWLTfGobF5uzCiQG7INLZF1FrLpq7a2KtzmXrPrRabPtuvBveorJClPCctgzxvCwWxF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zjn0s7win2F2DqDuWsgEre/hokUNPiR3EJVS4AGwC+Y=;
 b=h68jkhQto083+JriO3KGaP2w5Ng6pD4bh16/jztSy02agDb45WWKRM6RQ6zRh+VraPZ1TGgQeCRGpW/CosK91vldqNurk0/sX7BgKb5kQC4kDWori7J05futFFB+yCXk6n2B0YgMiqmUo3//F+DHQE4xjZ0xqjJJz3ruCVOfFZQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4966.namprd10.prod.outlook.com (2603:10b6:408:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 16:04:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 16:04:11 +0000
Message-ID: <be3571d7-2bfe-4bad-b2c6-84a0bf121140@oracle.com>
Date: Fri, 8 Mar 2024 21:34:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: validate device maj:min during open
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: boris@bur.io, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        stable@vger.kernel.org
References: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
 <ZeszQwa8721XnZsY@infradead.org>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ZeszQwa8721XnZsY@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4966:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8a7536-5893-4ebd-24d9-08dc3f8964b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c9jzGLQ7anl3PkCWykAhYgFT0OacB0MhkGqKQfCpDTooObmxg5M8SivCbV3JpOiEkIMarw9l6aDlaCDO78syfROWCNbWbSRda4XQi4P79/gU3oY2Vv75rRtd5i47N3/ydzk4syibZn2seIWXD6NTbsdPFPdTp2evrmfRLs0xOruBCt5J55o4AyFEXGqrUthtK7REJFRPBPtKGnHeRNKRW1evX78xe/bz3glMJh2du3U5E2GMC+sh06xKM98xFrtNIOlSae/fYzaobMITgVoKbIWUxpTzgjVL1lDefztnM0nV6v/RZaDSnis67sgVS83xkGfA2yv1mFjXq9oT01PGyTMHHBmWVbuK2BHmruNtOyZdHMzaQ4nlY5+g4teRSnmncOtqghgRKpvUMIWdCTT2hBYm+s31bNhiU3lyQQAwIAO/aPrfeqZMYmFS4ACsAtwEYAYk74+KR6tU1wdb0tzyeIiBHKumMR3Q1I2G/hcg6A9e7DFughElMAzR7xujQkaecodsiRpwv3Tbes5bheevU8TRYrFhpnld96agSggamnToed7pK1JsIlD6kBNGaeQf7mk2ktdrz3YbkF93iUDURAG0I2mo2tRl41y38uieiXSUrlbqFTZr2YysetYT6UwNY2+BtkQGsJSjrd5F7vYY03lKHXA2hZLnNX/0l+1EdJs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eFUxRkdPSFloNUxSa0dNNHpTakNLNit4OEYwR2JmVElNZFlQbURFbTc3WHU1?=
 =?utf-8?B?L3NTZnBieU50NUgzQUhvNjVjVjUwWm5zMGZ0MmpQcVhzU1hsWVdFVW9OdkYw?=
 =?utf-8?B?VHV2eTk0V0l6eUorYmlHZWVmblRRL0JTMkl4eEhFZVhUeEY3by9XekZDbXBh?=
 =?utf-8?B?RWNRUzV4THp1UEtjeEF2TTdGS1liMGVlUThYU1NQVlY3d1JmS3JFbTVGYkRW?=
 =?utf-8?B?Mlo3SGVVdkxncHdOa1ZYcHJFa0dKNzlmNzl4czBUckdLWElEZ0QvVkNrejJt?=
 =?utf-8?B?d1AyeFhsWldZSFIwNXF1eVFLa29BbFczbnlaQmhxQzJHMTRNNnBTWXg3Tnpt?=
 =?utf-8?B?aU9nWGFRL2llbnBuMXFrbFAzZG9yZlNScVFXWEwrTC9SZGlkTHpiZE9jYUMy?=
 =?utf-8?B?WFVlRHBabGxKRFpYWEdJNkpVRVJDVFFGNFpwdEwrNWZpY3lFaUh3aGZDN2cr?=
 =?utf-8?B?TUkvN2dyZmdQeUVrajZWRHJyamRZNUxoTi9lQWlNU1A5WUl4K3QxdnJic0lo?=
 =?utf-8?B?bUVtYW9aS0NBcUZGeklSL1dtWUg2ZHFFMms3Sm9MZkk2anR5MnNYMncxUjZm?=
 =?utf-8?B?N1dwMlgrMVcyYUQva0E4N1lDVmpxU0ZybjlwaW5KbldSeXRJRWJ3ODBTSG5x?=
 =?utf-8?B?OU5NRUorbmQ3RlBRVXJiN0pFMTRXc3o5UG5HSUdGeVFMTExpK0I4dkNyN1dQ?=
 =?utf-8?B?V2Z2d05DTXFkL25jT3kyNDNGYllKK0s5cHBQRmRuL3o1SG1PY1BkQ0g0ZHpY?=
 =?utf-8?B?amRIbzJqTzZoMHBkVHltOW4yM08zVW8wV2ZLbG1KWkoyVENtNlhqNnJBbEhi?=
 =?utf-8?B?NWxabzVzTVVaVzk5NXUvTWJ2bUZkZW5DNGxJbzEwMElIYXFHcFBOTjRmMEE1?=
 =?utf-8?B?Q0RsZ1Q2cFljT1c1eU40ZFVIcmJhRE94YVVMN1ZHRFVYOGkyTnVKVVhZVzhQ?=
 =?utf-8?B?V1ZkK2hhekVwWDZQbXFpc1JXanE3cTR5aXVycVlDOS9lbWhrMk1PQ2UwcitG?=
 =?utf-8?B?Y3ArenVpZ3Q4Si8wVzR1b3Bxbm5uMDJxdTFleG05R2d6RUdOTUN2UlJlWCt2?=
 =?utf-8?B?Mjd1R2I4a0oxTER0OUM2ZlhWZm5BUWVPN3JNTDFlUTBxaVB4T2ppbkFUakN6?=
 =?utf-8?B?RDBFWE9wWU9WUnFzaE41a0VacjlZdFBtS1BTWUNROElZeXpUM0NxdCsxeTRT?=
 =?utf-8?B?ZEFPL2ZMQ2tWRVNIMDFXeE1rSVo3SVRHZm9VZGx3Z3lRa2daUUFxUXdGcS9o?=
 =?utf-8?B?NEs4VzZmN2xqdVdiT280TGgwcDlmYitsdEdOTTZoQWlLV0hFVDhmN1VsMHQx?=
 =?utf-8?B?ZXorUjc4UlJERlh2bWg1TXN3V0pPdHFZU1FBRnZvb1NlalNPVEFoeG9lU0sy?=
 =?utf-8?B?NDdKVlhQQkVpRVRPRUVNUTQ4cFQyTUdjTDB4elVraVVFSXNudkxwREVzUFlt?=
 =?utf-8?B?ZjNGOWxrVGg4dklSYnZWWkFzWjlDMVE5TCtoanVMLzBUczcyVm03V0x6ZW40?=
 =?utf-8?B?VUJaWU1uajZjZTdFN0oyYXRpbDErdThtNDZVdWQ2OW91K0Z3anlYQkJkWklR?=
 =?utf-8?B?cUcwczU0Z20rVEJaSTh0RFA1RzNSNzZlRDcrVE92OGcyTUZIc2lTQ3l5bkdY?=
 =?utf-8?B?OXRuNndiOUFIa1VIM2VjRjd4eHpHWTd2TldYOUp6VVpESlI3ZXdWaUNMQlcz?=
 =?utf-8?B?U1BISWRrbjV4OU02WUNZTUZxNVE5bU5qRm1DdTJBRTZxVGNmclJpQ3ZLRU9K?=
 =?utf-8?B?em5saXhnWU9FNkxSOUplMlB0SVgyaTZ1dVpNYjFKVHdHVkVDMGkybi9nVWti?=
 =?utf-8?B?OHJtd0JmOE8ydkhVS0RRcWdicmFaL0V6NHllWDJqUSszVEZzMzhtV0lMTzhT?=
 =?utf-8?B?Q0lGSlk1Y1lPZlFLOUdXYWpPazdzSmlUbDYrWldqdzhoWmE1ZlVxODFLZytQ?=
 =?utf-8?B?L2lyU21GaFRFSU5WSmNEWklzS1VBMHcyTjM5ZEJ1Qlp1RGxnSVE0KzEwdzM0?=
 =?utf-8?B?d0lQVmtEYVRsQ0NxZnpqQmJlR0IrZi9OelJTM09FM3ViU2lhMy9Jek5WK01Y?=
 =?utf-8?B?czZQak1aa3h1ZXBoZ21oQ25Ia3NzRmcxOExyOEZHWGxRdU9HR0F4S1ZsRWpN?=
 =?utf-8?Q?syHgkStDr0mEEImX6vxipGoUB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BDMaz6bOd0Bg4oilIAQig7DmrDO8cy5tGJzfiW8zjCs1n9bDmX4Zf4mefTz4X7MaJ1tqxNpyFWPRTQ+Nqo//afdnHCvARxja0Je0/ocVEQyUDx8OnmAvkEEcGfRaFru8UbiZ5IpdoePm0v+CqTTc7pB+5GBhIlNych/TY7lgy45jMKeoHzTbKOHx8zzK+LyUU4GiVDGhggFWj79HbxWzlZ87JGzWnEOEj8goxBpAW2o26/72fkZ4aYgic4rEhP47VERqGB1UEqPAhsdNKLNLRrcoCC8ZK04oJd0m1H+EB8NSQr3zJ+D4Ht52WzrQGiuiFv6jHefHlp3k/iBfEhpZmIbu2HVdm88UWD/9tdgTFjthxcXP62K5h0aqV1zQgvXowmb9ZrJJ5c0s1zJ/8RzH2oudNHXvskflDm6/5vHMb+/IJEURIQggYwSZTx23S0Hv3LL6co3L84DJW3uKM7haU7aL27uDHniU0ymjf6fbO9OUErQLnWuVxgs5g5C+yc6gH6bLbRnaul7ltx+C/WJMs8HU9VoZY9zjmikLng27RSy6BQB0PUf0AUH+G+SD4LSMxJu3gKkTTMR1aXX3JfUnAIH84XOaI3qxfKDVunRAs+A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8a7536-5893-4ebd-24d9-08dc3f8964b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:04:11.6168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BkXcWNvXJ4tg34Yuw4+943yDfqaYsIWKnRd7loD1xG957kTElOCsGWl45aYfclb9osOSbex+znSLYArk+1lJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=747 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080129
X-Proofpoint-ORIG-GUID: mf31Fp6Xvn8THJkmlox69o0REQNGKrdx
X-Proofpoint-GUID: mf31Fp6Xvn8THJkmlox69o0REQNGKrdx



On 3/8/24 21:18, Christoph Hellwig wrote:
> On Fri, Mar 08, 2024 at 08:15:07AM +0530, Anand Jain wrote:
>> @@ -692,6 +692,16 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>>   	device->bdev = bdev_handle->bdev;
>>   	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>>   
>> +	if (device->devt != device->bdev->bd_dev) {
>> +		btrfs_warn(NULL,
>> +			   "device %s maj:min changed from %d:%d to %d:%d",
>> +			   device->name->str, MAJOR(device->devt),
>> +			   MINOR(device->devt), MAJOR(device->bdev->bd_dev),
>> +			   MINOR(device->bdev->bd_dev));
>> +
>> +		device->devt = device->bdev->bd_dev;
>> +	}
> 
> Just above this calls btrfs_get_bdev_and_sb, which calls
> bdev_open_by_path.  bdev_open_by_path bdev_open_by_path calls
> lookup_bdev to translate the path to a dev_t and then calls
> bdev_open_by_dev on the dev_t, which stored the passes in dev_t in
> bdev->bd_dev.  I see absolutely no way how this check could ever
> trigger.
> 

Prior to this patch, the device->devt value of the device could become
stale, as it might not have been updated since the last scan of the
device. During this interval, the device could have undergone changes
to its devt.

Thanks, Anand

