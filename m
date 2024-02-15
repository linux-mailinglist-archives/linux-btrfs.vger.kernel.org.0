Return-Path: <linux-btrfs+bounces-2402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7C8855A79
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 07:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90507283398
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 06:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC029C15B;
	Thu, 15 Feb 2024 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dpGfO6Om";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kdwnL5Ur"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B178BE65;
	Thu, 15 Feb 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978879; cv=fail; b=mN8h7nFu/7iUQsEeWyDTul2Hu+Uo9fss+Zn4qjYGQoLn8G6Q9birflJ6T/IUeF8YICV+GBly6TkgX2ESliyirclLeAWmju43r09aXzIGhnZ1VmMV0xQ2LD3IMDv5p/GkdzP2yrC6A6XIUnbbZ/xkP9SSFtgHpYxan/kTyKLoiAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978879; c=relaxed/simple;
	bh=m4WCl6RgsHAfXWJteGShTMzz9iKxSeUYbDbHs5EE6pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MqyL4JB/aPaKdzFa6i9EvNqQaPenyOqaztlj50pZgBu262y38II80bCRwtYg0lMLMlH8ojE5UCNjPqreJBNxmPWRB5h+emtygBUstjEo9Jg8qnnvsZ5E2n0NM12KKxASOQkX0X0TaODieviIMbaVJx0L2xD9F0RnUabxJEzMbYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dpGfO6Om; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kdwnL5Ur; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMhtfp007009;
	Thu, 15 Feb 2024 06:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=zrDg6cGZCuVRowL0bHFt+KCE7rhkGGXgXgF52Q+JPEo=;
 b=dpGfO6Omfk8JFWf5zgJb9KN2ksiTq6k3jyw4uYmFfx82mWz/wdn7DCPbl24XQLLq4nY7
 awlOQLzuIEZ9n8iXXRivb6GBYKA5tigmlcd+z9G6H00leVyO592nhfA/WzrDs3OsFPNH
 zvLlCom+rPGBp99ZVV4tY72X4Jw9yuV6qLjJ83o0HyfNVBWEIOtjkhDXKalPVFZu6GBi
 pd8ofsRPjiqbVg6MkCduDP3J/IyzJ2tAJTxmotRe35tee5FwJswRA5Qi+kYH0zhMNPpa
 TManEjNdeUfeiyeD4RXcKWb7FyPYV4hFTIyslljQrGOtDUjRB+JeXAEFDGIsQAgtouue Hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92db1657-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:34:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F5piD4015009;
	Thu, 15 Feb 2024 06:34:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yka28ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:34:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWdfFfimEdGmC6U+aIhv8cnfqfOsUFjCfblwU9xKG37FHd+mqBdgNG/fwD8HuDhq9JVtS7G+SP2wlfpeDlqNMGso5ddNG/z2p1a1SJe9IjXYsVo2ih+WxrL+xMuE4FVg43dRwiXPVgdJcKPI5+do/1+UxU+vSV1vFfJsB7e704f8wu9gYs/HXGDx7RAn1l2iCS6xKsXAuBy9UP7D9TRgklT89o84wtDXMFycsaulPuPKyjn9HJXR84lFFAsgnxV9lb+cIzB56UiEiIIPlALGL1ZfFc3UMpFGbVAcZKFg5CSIHAH7xjQ4fDeEWqyRw1aP0EPhitJTlTCXNROD74Zbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrDg6cGZCuVRowL0bHFt+KCE7rhkGGXgXgF52Q+JPEo=;
 b=Bvx/LG08aTQmiAfCuMsVLzr4U0+zRj7xkclkZfQV2gZhtSySWVmba7BBzWi7mXYB0Cxbgm93bOneAwyN85lfZ30pvFJuqx5YaoROlxuDPYh4f3pM+OBe9Xh9P3gE/6LxLeHfBBCKTGYsJzQ0sO5cZlNP/e2rflgHkN1ytRjOilmtvt+CdKxfoayHvXA7NJHNGBjZlwWWh17C+Iif/FCd2hWZGe5piGyajAzI+cvSEGecmF7smwFyOu66Fpe7DeyX07mofFDB2WnicLHwc8y3kDFOI9v2CTpKmT7J50EK8mejqsrxV5O99vgd4f7vBJJj8rq+Sl9Odv9RXuDEeYzbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrDg6cGZCuVRowL0bHFt+KCE7rhkGGXgXgF52Q+JPEo=;
 b=kdwnL5Ur4QZmUzaBByodnARj2Kdq+gq5T7yf40TRT/veQk9gw1b68DiowBwgOjM80FUxMnuyflfjzZcJ9oZ+8aTryhwbEt/XMZ1XBY29vD+VQ2LgDfpxtWWHqUcRYH0DD7+bGYyDFIRdS3+VtU5P7XRdnPjGPusVcNVtxg722TM=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 06:34:34 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7249.047; Thu, 15 Feb 2024
 06:34:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/12] add t_reflink_read_race to .gitignore file
Date: Thu, 15 Feb 2024 14:34:04 +0800
Message-Id: <578579505765ce6bb5ee8b1cc0e1703221fd9acc.1707969354.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1707969354.git.anand.jain@oracle.com>
References: <cover.1707969354.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: a796be1e-cd60-4ce1-1584-08dc2df02c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	n052bbQxUIGi4AleZQtvD/jMHAYu2hhk6QpCKz/sbKxx5KZFSPsTwl0cKnell12+AT65Ujj2KND0JsaElU/yaNTOwwV5l0PTgPqCCXrszVqFNHzd8eKNr7SxUUwfmVmQiqTZIX3irpkq0mJ+dOeB/PnSPofydg2SdOGi5yLkhjiBGm6yXh3aOME5N+kHDtKg1mYrd9H31tm33J3OThvgJ7eUi2dHlZeFgu0liqbUX8KdKxOG5mGdfqXxECM0Mh5iJqRluzaQnUTvca6HFfyWM/hYH7RiHA95AU5U48wFWz4IFTYtcyi+yINIYGSIj1FqbTIDO5P5NDOJBbUSJFTgTTkzM91BbaX/Ic2TZrBb3kCUXJ7kB6zccwJLyeiciQMQ8SzUvMOby2S8sjcIUXY9y9hDKU6lSYjK5Idd42+xES9uh+OeUDR8UGATnhoNFZsdbcgZ6ry2xQWrkqK00IJCyOnrjhybrLyGm0NrVy/3ObXqPsDdRXKCjKiL/KoFXNsa7WsM+zvXo0t1HtVWdn9v2J9cith4ZXCNB6sCdI/Kw3UNyZjYrdJTPGhGnfLENZ5l
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(5660300002)(41300700001)(2906002)(44832011)(4744005)(86362001)(36756003)(26005)(2616005)(450100002)(478600001)(66476007)(66556008)(6486002)(66946007)(6916009)(8936002)(4326008)(6666004)(6506007)(8676002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CA/rHCkiHrftUOlSsRDUiOaWBzbmmWM625PoSPiaXZwqXAwdOJJxPqsHlUHA?=
 =?us-ascii?Q?rx/6r+slipuqwV6A7npYqNQWldwu9AwgAlEmi0dwivy133M+7+v90GHTSk65?=
 =?us-ascii?Q?xw1/VXiFeOlbvFwAuWqAP0U6Y+freayHkdjvgAXIwBG36cze4X8PNza2Tm44?=
 =?us-ascii?Q?Yp7nzecPnGrvpyIP3nSXVA7rY/h9fyeXA/UIPR6jcEw19PExIklflc1TU/nq?=
 =?us-ascii?Q?YgZxN+VDGa5fSDB8sW20+fYOOn8MzVEv+PnMH4PdH+B72StK4ePFpOJCEUpX?=
 =?us-ascii?Q?f6xNtQCf55coGrpke2gYOi3F5mS6tbYxvV664dRrG3EGX+EBrrQmJAGV52+/?=
 =?us-ascii?Q?pEpnz6ojq/q8buVa8Gl59MXbtTp7IgAAcSQZEFhFLf7mqZhvBlyxXQl4lodF?=
 =?us-ascii?Q?7ODJmkOrhGhkEZIlhw/Xk2Cjv9om/T8jjnJsUb77F8AcAe/qzKTGCpiU4V/T?=
 =?us-ascii?Q?zSRryrmaiQqjbmouzYvfXqoX1JOUieJOIWmp0iOPAcvgyOu7294R3Ehfk/Eb?=
 =?us-ascii?Q?P77zwF26Z3mJgDwxAd+FdoDdT21SasS8NkiMasBt1kU6csDQLrda94VKUbiZ?=
 =?us-ascii?Q?IYsXkai3yZEiAOTBIbTwn0nbWaiqJusIuJ1aNn6Koo+wrUpe3b0hOP9KPTKz?=
 =?us-ascii?Q?682r+tEw0H4a0q2DS38W/WyUgi8Kq03UcMtBPzSKW9R6gdYowpjOrjo5zdtB?=
 =?us-ascii?Q?YpCD6OQJW10/Cby0a++163nEWauzg6XUFPCGnyBuX2NFut4iqP21OmciKafN?=
 =?us-ascii?Q?p2GYhbYpc+cZbM10iHUOff+30BSMqmLwFZj3XK/ka6/K/XkU0q7cjoUv15pb?=
 =?us-ascii?Q?YX+bFQlzVZABehDXFJPzndsaMru61f9y3DsvSE0q1RKmh1RAYtEGzDWVObh5?=
 =?us-ascii?Q?lDjnfadYEQ7ScOm1qWS8zAdtZsSBkoLqvltq46xiDiIM8/uBymW0tesc8Hd/?=
 =?us-ascii?Q?S0HjsQ7PZRlfG0YR+WSlA0CcTvSsrnhV9FWkNtrAXyOvEuJdm1X5b9OUzjh5?=
 =?us-ascii?Q?YMWlWfcpkKsxfoHrhiiKz0TOHDB9FQhEuPCPHUkysPr7QDwtc+Ij/F5Kwspa?=
 =?us-ascii?Q?uxNcSIyv46V+8Dbv4HapahivtU+ItN3fwQw4Y5NUjSeqwZNBxGTzlDNdIlvt?=
 =?us-ascii?Q?Z7Pz1oLGuMmJdgUpNPrjz7JCRYu5/yNwEwvb/tIEdg6Gd2QUgeqZEJSuNrwL?=
 =?us-ascii?Q?w5R6FrQdx7tFBwGJmxZEDnJHPt9lbi7d/MGCzPm/2VrsWeidxbqaRu+FcerS?=
 =?us-ascii?Q?ImuKu0mTyPUFKOuXGlxhD9XTteVEEHwOor4lsKFeEsghP57s5ykmbCMJ4V4h?=
 =?us-ascii?Q?In04p433gqUdqILsCjbdGBxTXBr1p2nHbzhHIuD7qcSe4dnEiaypLLlArauB?=
 =?us-ascii?Q?XNCFg2j6kq8+5UGcZS5JPASCCPLw9AXJb0COTroTDfN3+I4DQ0CtoOsOAPzH?=
 =?us-ascii?Q?ZhBsJrjweYazQB9UuYOaWmJ4RIvrNWRnXJzXAUODYym5xpOvv8WHQp45+C3c?=
 =?us-ascii?Q?AMWB3rl9lTMvts8yOTTr8vU+HsvaCklS8Uj+kB7o0pK53CBwju0Dk8EqCKy4?=
 =?us-ascii?Q?vQEJVlAWTgINqTg2IWnoRYQI3pDry3dvAzMwQ5AH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pYpfJlXX51MSHSEmW3pmVZEdjGeHAC1NCEKTb/gCiZVQCpPk63L+3MB6wLS5fFzBxFWnBsypq5kEe7BRnBBKokpoRL0+/XKMFR8pONQppd5EDthCUk+9GAASTFysx1O07frIbhjboU5yR4pSlDNXURUyS/ANxnelhZ1Gn799uSPckBUi4msOGj7HVGorarpEUgI7j1sBkCM3NOvLXa2kpW1Y0xL20Es9Vpx99MGFs+BYstvJ18VqbMGjxxCM/rUbRm4qHkQMA5yPQhFDvog23AYeWTj2ilRTZ/94osW+3MCZnvfsdumXwadOUcIRhUtQC7MM8f92Wd2JHdepmd7AUNZ9tuC0E3JLlZwcYoj51KA7zapG1efS6wegjHxejo4i9qhzkDv7OIWAPzsjc1S3T4quPAJNgZFjOjKTImGWoUgpYT6HuQtcBYmZTAgb2RoTi2fsR8XM8vM4khaGRLODUSrF5yGF2TtU3a6SV3vBXfjiz2LTxartuAd1V6+ye44PwObYNR+yady3y8COQy0jTezwWAxPIX8Ui/Hpj/jeFqWQisGvDtihYYUUcuPpSRc0u7KudTWCAJ3LWzZOsjFl0Y7SbkjQPjBgecjIa02PbnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a796be1e-cd60-4ce1-1584-08dc2df02c0a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:34:34.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFlLmqnLZCCi0jiaevNUNI56s8M/cd1OWnbd/AuWoitqWJd1yYs6W6OYDFM9oGN1wpLIF1abzt73PNpH6N51Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150049
X-Proofpoint-GUID: HWvT-xnxXTfY_rKVyTh7mMUc2mU_LIWm
X-Proofpoint-ORIG-GUID: HWvT-xnxXTfY_rKVyTh7mMUc2mU_LIWm

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 5cc3a5e4ae57..d930b9cc8404 100644
--- a/.gitignore
+++ b/.gitignore
@@ -204,6 +204,7 @@ tags
 /src/vfs/mount-idmapped
 /src/log-writes/replay-log
 /src/perf/*.pyc
+/src/t_reflink_read_race
 
 # Symlinked files
 /tests/generic/035.out
-- 
2.39.3


