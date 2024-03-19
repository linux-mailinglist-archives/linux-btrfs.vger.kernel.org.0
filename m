Return-Path: <linux-btrfs+bounces-3421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BFB880020
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E001C21F8E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8E66519E;
	Tue, 19 Mar 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kIs432up";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kTf9tQbC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765EF6166B
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860337; cv=fail; b=eVoIi3MD7PpvE5Z1cOj8DdD9F5u1+0WfIU6NK1LTJlM4a3VR+9mfow6VskSkLt7zjelH5Vk08kCiFbhkacYqcu9PbmrKlVuRNEy3c4BhG5ZZJ0u/v4GPEG3AzVQvLSeYr+1g0Z+mX0Ia39zJQcgS61RNy2ygF1rFqNEGWfVomK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860337; c=relaxed/simple;
	bh=LecBtQW1rjbmgzpx/+Kb1XZZgExFp9Oecw9vk9Pa0vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JCB8T/+zjdAS8Kz3iXMHXXAbRqGkhr4gFPQ56O0o1e8Us6zrKKVk5iTXo4jr2xzEfGNiu47MYUq82o8waDly7hfdQFNrhdfR/1uRX0IeEj5XnLvLKWMI/1fw0BcuKtE2Chb945J5Lj/vWuP4cwWITouXQtLUZl8X729moNr+SqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kIs432up; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kTf9tQbC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHbxM013398
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=riZhxZpcuXPdGh92DElKmHVbn5ca2hqwKPK/JH/OECM=;
 b=kIs432upxFjpSop2nfEgL7H4EBuYjPPC9ShzcibSF03L7aKvfnf1eai0zLLlynU1AX5T
 R+Rz57LJW2TeRZMD0CESM/y9DkXl30hcb+0jvc37iGHz70MpZmrECtcm8XX6KCkm7bc3
 SFQaFTYiy3DjqdOpAWef5wdjIHV6Xi5VMlnKjO+LVxWliCyxokoxMMQtGvmARmzp15gT
 3hBE/Bf6sQj9K0hTfFgsdWZZ55as4mJezdTsmXOctq1+3mIN4HlSUBFhfo5LFxKVwExb
 81iaIs7mC9BWxQ1rluRpETuAkYQd0imUhUfOOtS2o50qt3wNpyM/Sxp/18YIizqC+kyF Ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww1uddrqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JEAqAn024383
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6mtfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJgfHj7KyRuBheMynvaJz2rF8iruPGFeg456mwUisC7Zquzno7BYYSII05hQf69H0XKg+gZsW5Qd225miixe2oYvClU3t9MJP5ZwKnabPglxe2Zw6FqTzkJQYx+6LCnr0SH4GDhRv92bQqRWB8ks+DeJrJWPfLyacDo2esCYaVb+1uwlW8V9kWxqJ46lFU8GmCdkMLjicEP2woOX/n/zEsSB+UU2lYNQt1gvHsviCTXIzXrimgO4C5t+rtQ+GfsnZTpdIqGBE3OXcixDFENQpEfVD+G7pL539ghKxvmih9EeCV4QPH/O89R11J9ZqYa9EsAz2SWzSnLKGx2EGXS7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riZhxZpcuXPdGh92DElKmHVbn5ca2hqwKPK/JH/OECM=;
 b=N2AGQiTvnSVM4zibdZhwfKimx0nDy1BwCP1yr1DwP9HsrKra5fXDqL07z67b3+ruHK/jhfXmK3WvJGYwUP2Nw+WkZ22GIxr/pwfJUCKdSnACC17Ko75/Jdo476WvpdqDsW4sVpNTcPBKifrKeHgCXLu16iuQ1nsQlJB4LrnIPqS2VNqczNS9I4PRD/84qfupFGqzT43+E0gqmtGm6vw6mnQXVo/DlaeYjmXXtdLCSJjzC3knRHjqERk9WbrKNHhynoD8UHIjgrZc4yhQDTsOpGzixJ3K5l22PvELXuT7ISR3801Ck9/Nh5XDblEJ1ZZjzJ5jNEfUvxKMo0vl8sHyGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riZhxZpcuXPdGh92DElKmHVbn5ca2hqwKPK/JH/OECM=;
 b=kTf9tQbCwxohzZnLq6NmaE4oK/YOZaRyUl9wkGdCxxCjP6y140yYENNGdDW7aq6g8wa3XZqFkzcpYkqGbuhJq+InwMnjfOjLHXDAg73922+98Tu8ZoGWJLUZkznKpSgP0MiHnssUaJtd1zC9VGtSJmU1T0GXDEYZ6ENlocUpHCs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6543.namprd10.prod.outlook.com (2603:10b6:806:2bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 14:58:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:58:51 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 26/29] btrfs: btrfs_dirty_pages rename variable err to ret
Date: Tue, 19 Mar 2024 20:25:34 +0530
Message-ID: <f3e77c036d03512160da8918364354f10eb6f098.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6543:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9p0aaSXq7FuWGYJF0oIqqngLlexC/bmvHzgng8dox1QUcn1cdsMG0nk5IRxsHftxoT2gKxNXzJvT1q+5PVrSS8/WxjWUOcZebPqo3Ufg4YR0MDeGGwzCiQXXvPo+VU3A0t/69vmgRRHIfPm83voRFo1UJNihZPsInKhXexfYT7x9kX7ZQjHfInKdx/DARDeeZKMPuBVkhq9zcHNP9sZOCWDhJ7f9MlG6hx+Nvy/kkXe3uOg/GhmHBhIFBfPkuXcDneR4peFTQjGvW1EE49mZWMCoP52z7owGlxa/0Gul/iyAwdqgKsphPFDDKPSjsTUieLxVSvcdwi1hyE1Ucnx32iAd7QGqW5viNcL7Hl3CxElim3hkU3FSAFZJWB4ITlWwVDGD7PdZNHsa7FT04PqiskE1LJWQS0yk2rEmO+tXYQqcbGYWpWQ5OMb90AZPEy4S2TV8R5sxNyH+iy6+AszCO1d2605RR4/qCSGoH/Gxa7yD/0yGZXf1myu91eR4bmNI5qTbIs70mSoecnk7eNVO2L3Pc4VfDysShftOHOWKv85uyqofLDjLHBZxABpLgQaBvncQ9RxGCwaVilfeTr8d1JpK/rFwNBbl1TztyUXzHtSQHwpRFeelR0MbyNtn/sX81kUIkI/qvCkZonCRx0TL5g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?m9QFK4Wz9+EP3zHoCaBz7NldpT8mFNSWZakVOUy407FaG62l7nKQIZww3rYl?=
 =?us-ascii?Q?mGjYNXgLxlt16E9HCNW3G/j/Bfk3CUH1p0/pFi6FCgsL4oUL8DNL10KofWYJ?=
 =?us-ascii?Q?Yo8hU0CbgkQyC8FFou+yCvFE69/VpGg7bfSCmcmI14BfEnzeBh2XXNpeGjbo?=
 =?us-ascii?Q?aOZhCPOYYdGp7bc3dcS6hi7vQqbpw7DgHc1PluwOSA5cYnUvZvm3vm6rhPZt?=
 =?us-ascii?Q?RUsSxKZ+8IH/IjWaISDaO97uj8hmsAX3U2jdhEk5WSyDtzsIYisMqmQGB15Y?=
 =?us-ascii?Q?2ALvGQ808il59mXxsomLoF3pqPV9lhzM24iAjZQJ2Sy6xTGQOduqycZ+wNMA?=
 =?us-ascii?Q?3XE8gSnI/jN7tJbfeo63MwRmO63HjryqyX/Pvbw5zn/ypYS0nA7k/k07K6jp?=
 =?us-ascii?Q?TRU648ZSScuTYer3nFxGqeCxZm6mglohWwTko/EoU1R5yWJ8MYo0gXH+X5Di?=
 =?us-ascii?Q?1iGZ4xOuWazrJXEC7gh/PSvy+TX72qxTTKk3u4mu29u3aBeztElBCUWbqhVZ?=
 =?us-ascii?Q?HynsXwP7ulvzw0UjYfVIyU2pKqrsYkmkUmuxuBMCCJTy1KKv2My7r57hdCGW?=
 =?us-ascii?Q?8iDtn07+nRpVHVcSyKO+AHd9eeFJPXhtbnGD0JHu0Y8SJnOX+QufHQaJpZZp?=
 =?us-ascii?Q?u5VD/6evBQJlQbksDIWeL3RQiQqVuahgEDgeH9CiANZaxnoEOBtmANsGdiHD?=
 =?us-ascii?Q?p6VbBQqejvlKSyvDYYDyY48B9rUxGwXr6HgXNpL1ENunKczPD8SM6GmP1pNl?=
 =?us-ascii?Q?8pMd7WUWefPjowtZ6UUmaHaDzqyGhy7QIBJSmNIRfuJEm2ow73MBAVSmLhbP?=
 =?us-ascii?Q?DGwaYJjgVWdVXXZ75+Byk4p/BOIogTrYRCBynITdf+WuhEiHsC+T41DTUC8U?=
 =?us-ascii?Q?xx9cj8O+asnqRIEihd8xeRI+pM8gM1kx6nHQxjv0QK2wka3sc8Kojf/rbW3o?=
 =?us-ascii?Q?SrOfGHtZ1rBWRiXQeWGiemiypicgv4kPHjgzKQn8pY0kzl/CohbVTswgORAN?=
 =?us-ascii?Q?JqeP+Bffy5TOI7ErhthxLjvsbn+fyfRjoSgYkSyw1zbzYI0sSSoA12Q8sutD?=
 =?us-ascii?Q?AHTVIHfGBvYAkVCfAdVUICYS+BXn6pInBdMCb2NmWucQQGWq/JMxdporjk4F?=
 =?us-ascii?Q?/pyzipDv1gMfdeg0xi4V/mC/2/MKalW/vVH4pa7CB2T8+Q71gvYJ9TeOVeSH?=
 =?us-ascii?Q?vrmCMDUiDqrsz1bVF+yFjPoCyrdOwg9Jt5kPh765fmIXESyO9Rg+LCJxcmqC?=
 =?us-ascii?Q?1jGuTYvlgNLXxiXciy0C7J5zk03KTfMIB0ORtTgATQRglqxt5L8oNyP/5L9o?=
 =?us-ascii?Q?8ycuzHZi/r//ht1y0KTFHz9A3+5OA9xR0TFQPZezWY6ZYAqYCVJ/5q2RilRl?=
 =?us-ascii?Q?pdAMvGpBVq5zlmmgOKxOyfyhx85swJWsXpDGxM9N2BcEi3xk0rS0buKNS64C?=
 =?us-ascii?Q?DVnx4iyVJ48i3KDoAXAhCfbkpN8wEDS0ZuoE2Zu9Jc7ByKiB1S6oerSRCVN0?=
 =?us-ascii?Q?0JOAi2aBRKGa9bXvpXWsixUgpPvdpa06iYRgwV05nLWvJxe8JuOXUjyL7JK4?=
 =?us-ascii?Q?mnDAM30z1HkGkBlodLBtiwITxQHA+YR2eC57vmcJ9Shi2UGUOA40i7082I8T?=
 =?us-ascii?Q?31KSImTR2Xgj93MCp6uQUplKZFZJWYCqtuY3L5jA05QF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LBQl8fIXP8DfLFuiVAist2rsYSyj4qJTUMgDLtQmkEITRdNFlOE1zpU3yYAPvfmpRKeMtLufjDaVdDlFJjbM1m64JX+RDO/2QAXsumMBRB4jKqvMhMIDxzuvtWBH1bcn4Bkov5A+RErWtTrOeTwS1qjzXAsibGqh53B+MeQvgYxaiqeaBuk87/ESJMIg0gmHd2x56ZMaarNrdZCqwZg6y8eSQxGloampu4ZJ6jhNZXY+ynE9w54vJBYbRyDd8sWBBgDA7f3T+vhfN8ra8Dlcc4X4j3P3aGBXy1zxycqKaVxiKh5KtbXYkbC8zcj/I+m0aklwbT68+/nm2WjfxTKY6FA3ggp343bzSgHcPX7vRBHJflu+G6eRdLEQZmsMZcYhNlo0cqCbjkLRlB+3twga5SRP0gg0nW92mDGa09uaWAwA7gXKFCa+wmdPcnWx3HG7zrNA5fJa/R95k5eVo/wGFn+iV9SADygbKh1RjOeYJFrzPyOQJroiiT7/cgPg1bQ3nyrj/HK7m3pdFxhecEAgr+A2/R+1hvDwZXVmlG2Ie42TTgW/Rn8QxOTbQqRUdeopKvyg9zBJxlreiUI/3mH29otZPpjmYFLDldoGx/TAjDg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1488b3f7-d1f0-4aac-7540-08dc4825168a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:58:51.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPCUd6d6yQ7if9Fjs53P2tdQ6aJYqt3hKq22Zi1kCNS5BAz0it7qlMSOZvH58MYIcXCfP9qtNKDVKUGnJhassA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190114
X-Proofpoint-GUID: Oejkt4sYlzPz_1I0pwSmPq-M9rQKtYcS
X-Proofpoint-ORIG-GUID: Oejkt4sYlzPz_1I0pwSmPq-M9rQKtYcS

Rename local variable err to ret. To make it consistent with the rest of
the code.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f9d76072398d..f55ac15d727a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -128,7 +128,7 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 		      struct extent_state **cached, bool noreserve)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	int err = 0;
+	int ret = 0;
 	int i;
 	u64 num_bytes;
 	u64 start_pos;
@@ -158,10 +158,10 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
 			 cached);
 
-	err = btrfs_set_extent_delalloc(inode, start_pos, end_of_last_block,
+	ret = btrfs_set_extent_delalloc(inode, start_pos, end_of_last_block,
 					extra_bits, cached);
-	if (err)
-		return err;
+	if (ret)
+		return ret;
 
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = pages[i];
-- 
2.38.1


