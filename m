Return-Path: <linux-btrfs+bounces-1300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C9F826987
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 09:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3FDB213F8
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 08:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CFCBE6B;
	Mon,  8 Jan 2024 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U7IUbRV2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P33bqTc3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02FBE65
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4088OS03027890
	for <linux-btrfs@vger.kernel.org>; Mon, 8 Jan 2024 08:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ya287vvEggiKNKmMl7b9EsdS5LHUibyYRkZWHN9FaSQ=;
 b=U7IUbRV2WL+uCvEzu1S4iyo1OafIf97mPFv+viOQXdIsnDuOwxVhUUZzHrfCCl+gdwo9
 dPMX2BXskrLiNcus8kSthyCyPNr7foiafGKd6L3uRfp0ircYNwT0+w18oR9L/tiyMQL8
 Rvaq4pDZTggVpqTZmKqvbaEjB+i9kw7ulzElS6NI8pYyO12JHASuhuqaltT5RsH4Amkj
 pUJbtH155+UGv8RzPv731tw9FtNocKL1CvuLTeXMD8/XY7XAMtvMsLhuKoApo+MpZwmZ
 e/xhfNV9Rha4JxvTmFYTklT00hCV6+7d3Qg5bVkRnivQQuG5glDtzJbgTiM6WlIqRE38 fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vgdgm80ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jan 2024 08:31:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40873wkN014040
	for <linux-btrfs@vger.kernel.org>; Mon, 8 Jan 2024 08:31:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfur9a5my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jan 2024 08:31:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIsMQHjPz040AMwmQDIY+F/O7HyXtg2FBQxPfRdpre6f6O4Em3KcDnbMrUMcDNPKp0qQsehblKvrV/6Toh2SedtcFlyTYeSOSw3rUkiflArt9vgUINh8Jxt5K+u0HMq84eeE3Uyb/6n7GNN2XTsk+NWaKOGf/JPM34Hg6L9WPb/Exv6UmvqKuUoAjT6yNPAOU1g48S+oIAUWAINQS0c7Om3XgTjXeAIQ+ljfK50sFLZL2OQbkPKILieJLyw1bgC1Ubxibjv5AEuisDqu+SsOInkr9po0h8kJog3N6ij7Mu8sXo60k38EaL99di58Lde/orcDUtie5BD2kV+bZ19jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya287vvEggiKNKmMl7b9EsdS5LHUibyYRkZWHN9FaSQ=;
 b=LJj3+RKnaHbvpBjRT2CFIdcvVm5XpaP7/DvQHi6nwxVyEBXRqLxup4O+DBRhsCsMw57hFW1tgq1e0ch/BpVPdXmR9TobCya3cgxilfLtPw4Ykj1OoVjgic3R8bZ3YvADfavxifMx9JYBIGuScdoBr/Z1U7HXJLqza4xNYisMV5aII1bELIFhFya9yP8+WRhXfYaDSPl+QmZ608wpLMYgcSlH0ZHfz494SgmdlFysSzB6hS7VyTgBYgHB7vvg/LRghA/esvO3VAfeJi8BK+ZvMng3e4R7j9Q8gYo+1XO/SEZNGDVtCeL1q2K1VyNCt5uwHiQyQR5nu0mSvvB7pY4QbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya287vvEggiKNKmMl7b9EsdS5LHUibyYRkZWHN9FaSQ=;
 b=P33bqTc3cLUTvsE2MPP1oA2skLo+U5d1/5E9bHPvZjekdlDYD20RZFv1ZZQyyMm+1arHyGkuujwy//SqD6sd8xKbCTe/6wdeU+zk4+ubX8u0YfHxh8ifob3xc3iIq1+ZgA0KW1KJDwcd0B3B5FJ2/cjzU1Ps8/NYobV5hoKQBBo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4302.namprd10.prod.outlook.com (2603:10b6:208:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 08:31:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 08:31:18 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: Documentation: fix sphinx code-block warning
Date: Mon,  8 Jan 2024 16:31:07 +0800
Message-Id: <b5e7aa00820d6fcc680b201070f81e3178571dea.1704438755.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1704438755.git.anand.jain@oracle.com>
References: <cover.1704438755.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: f27ec9b6-8314-4c8f-9543-08dc10242fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	075ck2ASDYhqrTnKba1LWh4eC1mpYnZhhpfbDLsqgXWIgSBdtM86f13gnyuL9iAq5cLT2OhTIs/2hQyXl/ncC1qil5i8mqhakv/uaGR4NQm2B/fbPjtRKgv3BvgCwov06CYd/7BAyormRKJw4saW2KE7ZVSTnIalp24fMlX7W02gng6ODNetmQ2CW7aLc4mINfhoJ/aDAV3UT0v5C3S/OHmRmYRl/G2XK5P7QaqPeL+InadspRhSe8F5e0v/LcIc6387p1uR3UM2G8xRD9QoBho/w07tMpyrg2W9m1sAMEjFKnMTpzPR3tNN1vx0QTadUStObLbE0EBF6/VybpGiqd3gmn6d4aru7c2RauTWDDWmYEDEOzDfw+SLsaNLJKixa+I/qga9szG2tig0VLeut7qCZaXid39l9cVHq/F7FnmolA3M1phXHgbhWl37ZY+d/IW8hJNcmaBY6tWoPSbTXVX7yK/D2t/5FoMUI3JkpBlKFGq1k5QtgBgiMBuOnQxVyv45QfLQ0Gpd8DB40KEH5ikGq8Vp+eBXmg8sOH36bF1pQ0I5ekj/8xe/5o7HszEYyaf/NhPPd0oF5t0CpDGaouacW50cI531+udURpkX7mvO7MUmHl8WhTR6ABbVtkU7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(2906002)(6486002)(2616005)(26005)(66476007)(66556008)(66946007)(41300700001)(86362001)(36756003)(5660300002)(316002)(83380400001)(6506007)(6666004)(6512007)(44832011)(478600001)(6916009)(8936002)(38100700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ei9YNmJUNzhLU2lXdjV4c0I0RkFwb1dFZWNCUU9TWFJjNE5pOHA1OHQzeDZC?=
 =?utf-8?B?a1EvUG0zNS9aWU5xOHU4cktWWHZwNDdlOGUrZm1KNW1YMzM2cy9RVUVVd1ZU?=
 =?utf-8?B?TC9ZL29WbHVKYXU3d24rTS85M2tFU0xXOHIvNjhYSnBsaWVLd1dBY0xpcDV5?=
 =?utf-8?B?WVF5VnpQckxkWkYzS3lYSmRZeG84aXhwanpwYzNybG9HMTVJdFdZdkFhTCtZ?=
 =?utf-8?B?OGVnUkkwcjNQMUxMS05WckZJc3B2MFpLWE5laWpsZEJwcHpxTVJGQ0xqOUNH?=
 =?utf-8?B?bnhPZ1FlbUp6THpDNVpCRFduY3VqYVRiS2RHSlVpdlByQjk4MVhIbFViV09h?=
 =?utf-8?B?Rk1SM01SQlhKM2ZEamZ5NWgxVG5IcFM5YnpxdDlTTmhJTWNQZ2ZQcFFlMHJB?=
 =?utf-8?B?Uk9SK0lPaW5za0pCdzNvMzJzbTRGbElmMW5qbU9nODNmTnVHUDFDTjEyN2xB?=
 =?utf-8?B?UE1zY29TMC82cGxnS1dTeEZQZUI5S1J6QVhiVkdOQmh1NW9DNi9Ga1gycXpI?=
 =?utf-8?B?YjhISU1PUUxrMUFJUWUyeEVNRk5zMGhzSFA0SW5ZcTlQYithWU0zb3BhQ3dT?=
 =?utf-8?B?enJ5R1ZSYnY5NCtqT0hFRU9sZmphb0lMTXpYeGdUWkpwbkNnVmVwaVJFL3pl?=
 =?utf-8?B?VHZoZnZJZVlWQ2tZQmhzY3hpL29zMy9Wc1Q5VzREZ0NibnJ1R3pkR2prbkVh?=
 =?utf-8?B?aEI2Q2c3REhuZEFiNHVNcVh1VTg5R01UZzBuWDZWUzBCREg0dndBUmE0ZUNQ?=
 =?utf-8?B?eDFnL2N5YXc3Y1BqZ3pzUFZjWDUrR0xtK0hFUTM0S0k2RUVzTGRNV2JlTlNz?=
 =?utf-8?B?QWs4Y2tkMDJ0NjZXL1BTTU1LQ2pQYzJRaDM2ZUoyK3hkRkR3YVJ6dU5XMnNt?=
 =?utf-8?B?RlpQUUw5ckFzMUZNZmE4elR5eGtld09IVEEvWVZFWXhPVEFmTStkTE13SmEw?=
 =?utf-8?B?MHRVcXhFd1JmM0RTUGQxaDFTK3hyaGZxU2hzenROaWQ3dXlUVHN3OER0eXZz?=
 =?utf-8?B?MGJOcWhnZzVGa2Mvb1cvWHp0cnowc3VndUMzQW8wNzI1ZzVrWUFxOGljUkZW?=
 =?utf-8?B?MVJlU28vc2tpS0lkeFkxK3FwNWNkQ2tWeEJyd2Q3R2tWenF2RVZIeXNSS05F?=
 =?utf-8?B?UkdCTkVsZE9FYUFvMU9KeDBpYm0zYTFybXhhVUVJb0ZYZWhlMXBiWDlJT1lW?=
 =?utf-8?B?cVRkMFQxQm8yK3hhdldMTzUrcFRxejNuR3lwMUVrTE9GYmZaalZpNzhORElu?=
 =?utf-8?B?c1g5WHhVMXg1YS9TSWpPS1JBd3NYeTZDM0phbkx4SXFtbWxHRzZLRGNHYlN1?=
 =?utf-8?B?RmZ2Zmw2dU5ZUjEwLzhDampXeGx4Z2hrMHlYL0V4TmVvVy9iandKaXRWb1lN?=
 =?utf-8?B?UWZUbnJKYW5qN3Z6bkZHajVkQ0JEQ01mNzF5cWZqOTc5U3plcTNKbkJKMzlo?=
 =?utf-8?B?YzlvT0p0U3R5dTEzVVN4a0lNYlFCUFk2bHFYeFhzaXd3QWhTZGtZc29zVGhx?=
 =?utf-8?B?OUo5UWJ5cEhEMEwrc3ZvRkZCbS96VS80UHVuTjRkTnd4MHdsN3czMXpkajFP?=
 =?utf-8?B?RldkaTAzalVleVA3bVgxQ3hzOUFSdWhRVVJiZ0JvZnMxdVJRTjJjK1dPU0sr?=
 =?utf-8?B?SExXV1NkTUh6dCtVaVh0TnpoODd4L1prOTh0QjBOU2RBRW82ZDhkQUhEQVBD?=
 =?utf-8?B?VTY4U1Q4dXBIcmwwcHF5bURlRk01MWVSc2RxNXNpaGRZQUJsU0lrQTJPQ0pJ?=
 =?utf-8?B?RkhwMXZtOFBqRWhKOEtUL1gwMjhJQ1hWdVM1VjA3UkZHZFhVaStWK0ZCVjRn?=
 =?utf-8?B?QUJqdkVYNzhrSzJVMGd6L1VjUTJyUXBNOHVBanpsZ1ZFd2N1MXg0UzNnS3M2?=
 =?utf-8?B?cmNiNnNDcjBOTGR0YUdmNk95dVZ4WFVJY1M3T0FYK3A3cVN5VTRtWTFOSWNa?=
 =?utf-8?B?MjhSKzVOejh1U0d0KzRYL3NZZXNYZWZXUUZESGZJeHErVURPYW5zY1REU2lR?=
 =?utf-8?B?dUFUZkZKeGVzNVo3V1kvWCtMVHBvTDI3NmF4WGhyZ3RCbVpkL0RKZlh6dnpj?=
 =?utf-8?B?a25zVXJYQWVCYXRkZTVuQmpzeWhZcFhWckZ2d3NaZ0I3a2tSVVJETkFhMkhm?=
 =?utf-8?Q?8qWrx956DV6Bm4yEJf0M/jBww?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GxT6SRGa4of38d1k9FySeQ1fFaViDjNPeSCQ28p0cfifCrOPlGDYFwpAQLXxYGZPHAsiekTWTcK4Dv+JuGBOaGnA6wxO2Qz5aQVYOvLybyC2MfOnJ6wnm65GHrhPojX8ft2P/3EELMvq55ADErTjmCRk9dd5LnvdHK154epIOBArkDOYrdxyMFgkCuplbDCoBEeSUD0tD2gA6EAon58uAWAvTnkm4Spc/MM/koIrJoTzkxxjeJmcUf6b3DXQ+n3DOJNyQkQIocS/qBkT8EDy3FN0eZkbwOk5yAz/g/5j8emcsuC7eP9urJVdjCEx8sifIsM/7YphE8bjeLT0re2QZoIPp4ZI+GcUQdC3lSUtR6Wh0kTZFEkrENLtf3XMnQvrAlLY2dUewKD8v8+/NWdnQnjaxVrmYdn2m9nel+6b2hWFIqGeaLIIGF73vo77j6LttJWmwloVfAVQTBcs+RvKcgt4/r+eRAqwFsaMb8B2vP3ggVtrsxqvvKxTyOr4JG6aLr7EP6QMFQ73shnJtVZB2AvKZrwyGmHRXK5Hm5Xmyyj/rROKQFhZA01MxVpiJ6Y/228945+L3McENabOA71GgDaUmP8aQx1NZBMZbgMhBYk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27ec9b6-8314-4c8f-9543-08dc10242fc0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 08:31:18.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyS124aYZoAg2fAaU+Xfb5BwUC/rta0sNjIzliKRVAnsrCu4JaRC6d/Cu1JO07F9+f1XboHXojV7X40oZtwbKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-07_15,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401080071
X-Proofpoint-ORIG-GUID: CDPtIrDcWGaMPLWYTQnJVMkACxlK0TpR
X-Proofpoint-GUID: CDPtIrDcWGaMPLWYTQnJVMkACxlK0TpR

There are several warnings regarding the absence of an argument for the
code-block directive on some build servers using python3-sphinx 0.2.2-17.

For example:
Making all in Documentation
    [SPHINX] man
ch-subvolume-intro.rst:141: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.

.. code-block::

   27 21 0:19 /subv1 /mnt rw,relatime - btrfs /dev/sda rw,space_cache

 Etc...

Adding the relevant argument.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 Documentation/Tree-checker.rst               |  4 ++--
 Documentation/ch-subvolume-intro.rst         | 10 +++++-----
 Documentation/ch-volume-management-intro.rst |  2 +-
 Documentation/dev/Developer-s-FAQ.rst        |  2 +-
 Documentation/dev/Experimental.rst           |  4 ++--
 Documentation/dev/dev-btrfs-design.rst       |  8 ++++----
 Documentation/trouble-index.rst              | 16 ++++++++--------
 7 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/Tree-checker.rst b/Documentation/Tree-checker.rst
index 68df6fdfa0de..c0e5e316d958 100644
--- a/Documentation/Tree-checker.rst
+++ b/Documentation/Tree-checker.rst
@@ -30,7 +30,7 @@ fine.
 
 A message may look like:
 
-.. code-block::
+.. code-block:: text
 
    [ 1716.823895] BTRFS critical (device vdb): corrupt leaf: root=18446744073709551607 block=38092800 slot=0, invalid key objectid: has 1 expect 6 or [256, 18446744073709551360] or 18446744073709551604
    [ 1716.829499] BTRFS info (device vdb): leaf 38092800 gen 19 total ptrs 4 free space 15851 owner 18446744073709551607
@@ -54,7 +54,7 @@ checksum is found to be valid. This protects against changes to the metadata
 that could possibly also update the checksum, less likely to happen accidentally
 but rather due to intentional corruption or fuzzing.
 
-.. code-block::
+.. code-block:: text
 
    [ 4823.612832] BTRFS critical (device vdb): corrupt leaf: root=7 block=30474240 slot=0, invalid nritems, have 0 should not be 0 for non-root leaf
    [ 4823.616798] BTRFS error (device vdb): block=30474240 read time tree block corruption detected
diff --git a/Documentation/ch-subvolume-intro.rst b/Documentation/ch-subvolume-intro.rst
index 57b42fe7a97f..3a138f221cc6 100644
--- a/Documentation/ch-subvolume-intro.rst
+++ b/Documentation/ch-subvolume-intro.rst
@@ -3,7 +3,7 @@ file/directory hierarchy and inode number namespace. Subvolumes can share file
 extents. A snapshot is also subvolume, but with a given initial content of the
 original subvolume. A subvolume has always inode number 256.
 
-.. note::
+.. note:: text
    A subvolume in BTRFS is not like an LVM logical volume, which is block-level
    snapshot while BTRFS subvolumes are file extent-based.
 
@@ -34,7 +34,7 @@ Subvolumes can be given capacity limits, through the qgroups/quota facility, but
 otherwise share the single storage pool of the whole btrfs filesystem. They may
 even share data between themselves (through deduplication or snapshotting).
 
-.. note::
+.. note:: text
     A snapshot is not a backup: snapshots work by use of BTRFS' copy-on-write
     behaviour. A snapshot and the original it was taken from initially share all
     of the same data blocks. If that data is damaged in some way (cosmic rays,
@@ -68,7 +68,7 @@ change and could potentially break the incremental send use case, performing
 it by :ref:`btrfs property set<man-property-set>` requires force if that is
 really desired by user.
 
-.. note::
+.. note:: text
    The safety checks have been implemented in 5.14.2, any subvolumes previously
    received (with a valid *received_uuid*) and read-write status may exist and
    could still lead to problems with send/receive. You can use :ref:`btrfs subvolume show<man-subvolume-show>`
@@ -138,7 +138,7 @@ Mounting a read-write snapshot as read-only is possible and will not change the
 The name of the mounted subvolume is stored in file :file:`/proc/self/mountinfo` in
 the 4th column:
 
-.. code-block::
+.. code-block:: text
 
    27 21 0:19 /subv1 /mnt rw,relatime - btrfs /dev/sda rw,space_cache
               ^^^^^^
@@ -151,7 +151,7 @@ then a snapshot is taken, then the cloned directory entry representing the
 subvolume becomes empty and the inode has number 2. All other files and
 directories in the target snapshot preserve their original inode numbers.
 
-.. note::
+.. note:: text
    Inode number is not a filesystem-wide unique identifier, some applications
    assume that. Please use pair *subvolumeid:inodenumber* for that purpose.
    The subvolume id can be read by :ref:`btrfs inspect-internal rootid<man-inspect-rootid>`
diff --git a/Documentation/ch-volume-management-intro.rst b/Documentation/ch-volume-management-intro.rst
index c93576c72586..15b44c9447b8 100644
--- a/Documentation/ch-volume-management-intro.rst
+++ b/Documentation/ch-volume-management-intro.rst
@@ -27,7 +27,7 @@ RAID level
         standard RAID levels. At the moment the supported ones are: RAID0, RAID1,
         RAID10, RAID5 and RAID6.
 
-.. _man-device-typical-use-cases:
+.. _man-device-typical-use-cases: none
 
 Typical use cases
 -----------------
diff --git a/Documentation/dev/Developer-s-FAQ.rst b/Documentation/dev/Developer-s-FAQ.rst
index 6d8d78e54b4d..f79d96a98cf1 100644
--- a/Documentation/dev/Developer-s-FAQ.rst
+++ b/Documentation/dev/Developer-s-FAQ.rst
@@ -178,7 +178,7 @@ For the next iteration, add a short description of the changes made, under the
 first **---** (triple dash) marker in the patch. For example (see also Example
 3):
 
-.. code-block::
+.. code-block:: text
 
    ---
    V3: renamed variable
diff --git a/Documentation/dev/Experimental.rst b/Documentation/dev/Experimental.rst
index 4817faa56c79..8dedf667050c 100644
--- a/Documentation/dev/Experimental.rst
+++ b/Documentation/dev/Experimental.rst
@@ -11,7 +11,7 @@ filed as issues.
 
 In the code use it like:
 
-.. code-block::
+.. code-block:: c
 
     if (EXPERIMENTAL) {
         ...
@@ -22,7 +22,7 @@ where it would break default build.
 
 Or:
 
-.. code-block::
+.. code-block:: c
 
     #if EXPERIMENTAL
     ...
diff --git a/Documentation/dev/dev-btrfs-design.rst b/Documentation/dev/dev-btrfs-design.rst
index c3a6d73872e9..7ce0b4df6d45 100644
--- a/Documentation/dev/dev-btrfs-design.rst
+++ b/Documentation/dev/dev-btrfs-design.rst
@@ -15,7 +15,7 @@ The Btrfs btree provides a generic facility to store a variety of data
 types. Internally it only knows about three data structures: keys,
 items, and a block header:
 
-.. code-block::
+.. code-block:: c
 
    struct btrfs_header {
            u8 csum[32];
@@ -30,7 +30,7 @@ items, and a block header:
            u8 level;
    }
 
-.. code-block::
+.. code-block:: c
 
    struct btrfs_disk_key {
           __le64 objectid;
@@ -38,7 +38,7 @@ items, and a block header:
           __le64 offset;
    }
 
-.. code-block::
+.. code-block:: c
 
    struct btrfs_item {
           struct btrfs_disk_key key;
@@ -311,7 +311,7 @@ field of the root block may be different from the objectid of the
 snapshot. So, when dropping references on tree roots, the objectid of
 the root structure is always used. When a backref is deleted:
 
-.. code-block::
+.. code-block:: c
 
    if backref was for a tree root:
         root_objectid = root->root_key.objectid
diff --git a/Documentation/trouble-index.rst b/Documentation/trouble-index.rst
index 8de7d6232a11..66c75831cd1e 100644
--- a/Documentation/trouble-index.rst
+++ b/Documentation/trouble-index.rst
@@ -12,7 +12,7 @@ Error: parent transid verify error
 Reason: result of a failed internal consistency check of the filesystem's metadata.
 Type: permanent
 
-.. code-block::
+.. code-block:: none
 
    [ 4007.489730] BTRFS error (device vdb): parent transid verify failed on 30736384 wanted 10 found 8
 
@@ -59,7 +59,7 @@ persisted and possibly making old copies available.
 The most obvious way how to exhaust space is to create a file until the data
 chunks are full:
 
-.. code-block::
+.. code-block:: bash
 
    $ df -h .
    Filesystem      Size  Used Avail Use% Mounted on
@@ -98,7 +98,7 @@ action is possible. If not, ENOSPC is returned.
 Error: unable to start balance with target metadata profile
 -----------------------------------------------------------
 
-.. code-block::
+.. code-block:: none
 
    unable to start balance with target metadata profile 32
 
@@ -111,7 +111,7 @@ Error: balance will reduce metadata integrity
 
 The full message in system log
 
-.. code-block::
+.. code-block:: none
 
    balance will reduce metadata integrity, use force if you want this
 
@@ -126,7 +126,7 @@ The preferred way is to use the :command:`wipefs` utility that is part of the
 *util-linux* package. Running the command with the device will not destroy
 the data, just list the detected filesystems:
 
-.. code-block::
+.. code-block:: bash
 
    # wipefs /dev/sda
    offset               type
@@ -137,7 +137,7 @@ the data, just list the detected filesystems:
 Remove the filesystem signature at a given offset or wipe all recognized
 signatures on the device:
 
-.. code-block::
+.. code-block:: bash
 
    # wipefs -o 0x10040 /dev/sda
    8 bytes [5f 42 48 52 66 53 5f 4d] erased at offset 0x10040 (btrfs)
@@ -172,7 +172,7 @@ at 64MiB, the third one at 256GiB. The following lines reset the signature
 on all the three copies:
 
 
-.. code-block::
+.. code-block:: bash
 
    # dd if=/dev/zero bs=1 count=8 of=/dev/sda seek=$((64*1024+64))
    # dd if=/dev/zero bs=1 count=8 of=/dev/sda seek=$((64*1024*1024+64))
@@ -180,7 +180,7 @@ on all the three copies:
 
 If you want to restore the super block signatures:
 
-.. code-block::
+.. code-block:: bash
 
    # echo "_BHRfS_M" | dd bs=1 count=8 of=/dev/sda seek=$((64*1024+64))
    # echo "_BHRfS_M" | dd bs=1 count=8 of=/dev/sda seek=$((64*1024*1024+64))
-- 
2.31.1


