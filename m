Return-Path: <linux-btrfs+bounces-3415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105A0880019
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BC91C20E42
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6664657BE;
	Tue, 19 Mar 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="esBo2Nzo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w6HALz4H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8453E651B7
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860311; cv=fail; b=BiHt2Q+Oc88i8aoX9k9mcInJd5h/2em9XEhyYCClog1W14pNmtt2QWxctwW3LyhgNOkw1lUQMUfSHdgwZWTbyRwe9bifvHl56RJpix6iB32IGpT0i11Dds9iWWN08xRD+7BDQglsgIF8NnYAolajVxFYCmG/LuYHet5jaflKtyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860311; c=relaxed/simple;
	bh=YLnB1Kpfzy+HwwA4gCZlqxcG0K8K1wLTelPKX7ABTDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pf1vsuq4snQK/rFaplENZfF/PzlmgJ/RCgXp3xl0UwchjGuxDzFoTyYJrYCH2W10Vn9MOYkLhuLlvlCEoEgIl2ByUCrIZ5bK7P1G4S2Kx9nNcO0UdyIRpvl8pVyxWWJ/OJccnkaW1hLFXvIA/Z94l9nOfVE1TW4LxUAyCT0MOmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=esBo2Nzo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w6HALz4H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHaiL004983
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=YkzG6pnrTsTGn/RvXw0hMonESIHMldKAm4epdT+x3CA=;
 b=esBo2NzoIxxlj+9KJPFWrMEo0k3xGGM1ncYIMecw5iACmE+9RrwHSb3I2xv3ofexqbNg
 mZu2xDpvyUVrWmlQbRJZVMFtlr8aGHY2ySPdC94eoYfcbs15w5a487E+XxzNdyhuqEgJ
 w5zYyW7oShgBpFHM9KWlnz39NMCmbIPdS9QI6g89hfXwvrfyYR8wSHEAHAYcMmLZm1Ao
 sCeKYJJyVy27qrsaVlfGx0Pw6/e+LRK8fctCU0Q5rTXydVVVTKWSoaqC2W2PIVMY6V6j
 ZIFpgVwD6MG46c2KrNibpOhbguizwZyqQVi3XNs18F4uG4mGNThGxPJxAJU0T25lwrNP 6w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3aadnjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JEKOu2015748
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6v86h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSdja1H4Cs49P68BNUxfzYKPMWVZrcxqh03syy1+D/sLEykv3rstNTk+8GWKqcVcdbThNAy0rhbrAsi/pBxevmGM2mqygsGcRfZ3TaEgF4VhSeKGEsH4CebWZSbkXPwmfadtV2WionP/IgFQ0Q6e2pMqWPrxzIo0SqeZw3XRV4FIQ/0xHXaFF3A44cWeiSDI0zNSKusjHe6wk4UGupi40NERnVKrYjfCW9R3KUL+VpSiPqIUuFRMOjxsQkB5Mv/A0xV263UxVprdJXAGHNPZxY7Ky7DQ1r12DSyyyXeda4qO+Fb4CKL901mysRrVowvJxW8fSoOVSpBO+GRc4F/E4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkzG6pnrTsTGn/RvXw0hMonESIHMldKAm4epdT+x3CA=;
 b=Rc/1IghnaokNTvNWnyIAci8Ykey/R0RzL45jlbXi9iTKGE+EgwY+Pc6JrvmIJZ8lSJnsqTBwRESnChzRyP4tQQC2bIIu4X+rFGpaJqU6UP5PpJX343qaS8r8GuJgKnnfFPvsWrvlyZpzSdpPCz9QaR2pVCqgST+f5SSPUXW2NykMWVQRJpVrSIlwLL0UEWzb9Sz8oPTtDYc0Hynk2kJBz3vuubJQ3xOPkwXwY7TgohGA2K2tlPAmDOLsbYHSVbxqvydaxb+Z1qSKx2d5/m2Be5NzNszcXfL/QWZ8QDOoh/uBUEDeGLyWX9fbUI8UYkqwk78x0XLlZnwTMnLafxby2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkzG6pnrTsTGn/RvXw0hMonESIHMldKAm4epdT+x3CA=;
 b=w6HALz4HKfhlLMGmOS9XePP/azAQN3ss5+Sok36tOZ4lDCxzJNxCk9IA3g7wiN0ryKZPWsG/oi+5spYQodjSXxSVQWIWCwLrg99J3StI3w7hPWb7FnVyXIEOY3RzTqzP82Lyep//ns5Mw94EOyG9eTkQeDPcK3oZRI1ZAZMqAq8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7460.namprd10.prod.outlook.com (2603:10b6:610:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 14:58:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:58:17 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 20/29] btrfs: btrfs_recover_relocation rename ret to ret2 and err to ret
Date: Tue, 19 Mar 2024 20:25:28 +0530
Message-ID: <ebbe199d7e44b7a1c03605da163d27ed4e362c04.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7460:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e9f6XaGoSJlZmUCMNOTAihL59aCLZ3DaVDpvQ+uESAJ7RDaEyu2zvgQJsANKaxPr6Xthb9Zd24Bn79y5YWk17lOY/bU6qmZs/2iGOWwDQY97KOF1JFdT/e4ZZvkjYTDGEiF+DHpH2ZZPUZY+SuV/QTI9gFIy0vt9gi8tHxP7mppacBXnkYW095a7KhEs5exQUgpSlDJPBLxsTEn2POmIQuQt0ZkeqGxG4ggj+XnIC3DK3c4dT3z7IhHNImd4nGVjiILvBRmjAUN0FPmAfvmxuB3Wu0HXZKnDH6NY0g2v3SdRJ6mUIKa3e9OiVNDs5naZVCrZbmaTuwP4ORZ8sSd4oJNTuenDEmdIX6/xIekdMYhll76EkmtNvUvWZhkj6iMZ+MwCEfyHiZjrkOvc36drKOcXNjFT8mT4T2hvCZg1Grg29DFEc+zWwImEq9LikpDxYmBnTgTJCTrLxEXSwd+KsFsPwg1y4oU26wz0G8z5M1SP+Lnl1ksPZXjv+OeMML3TH/0vXe64bTlaIrkymwo2WHJNw7DwAdq71v8IoGQNMOMoEZsC6+zwcvy8kJyp8udyepQ5S34zhriuKb26LHSKkDMIMaIZKk1YLlilPFWdfO/CMvnhIuIfhInMkRse7p/cNSx+jNztk9956zAFI8jPlYy8cWR8sgJMHX+fti3X8Zw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?p3x+jpFPTp68CfunEJMif+CxfHaNF8UAUHwH7p2BJudECShil5pJuGJmk3MY?=
 =?us-ascii?Q?Aetfc1plzcX8I4xokFyPU7NnIx/ckRUUUz7kY3cwEz4qmjO3EI9SmcKQuY6g?=
 =?us-ascii?Q?9I9wTKK0gQzFfy0tmV3+OMk//FZzhxFpWwgGftd3vyZUHCIIE1gLICIXC/qP?=
 =?us-ascii?Q?J79+4YemM8VQ4zcoHQU2bUAj/KP3KDbh0kavOnMHt44oS3gaFtfhT+8UAzpP?=
 =?us-ascii?Q?/NkEb1wF5jey3+gXkzV5gLo6je0q93Lt7zxT+HXv1cBRbhPoyuhQqe+Zn4LT?=
 =?us-ascii?Q?zvZwgQVuIlggd+EXSfOuJGvFNetEWH998b1g+hn7iTtwoYl+JTfoizqUVlj+?=
 =?us-ascii?Q?ftfEMza+v6tcnmdBpYrFhr8biybVqTN3eqBmYiwSaO2cgDrZlp54ZbG5/uKq?=
 =?us-ascii?Q?LDZkG2lxBjtP5cqxCgk62ghvVE3hWUQRU9XJry2q+VFgNB9eAFzcRSkn9yC7?=
 =?us-ascii?Q?7Ww1NunCPciGyOSI+sGnSgPkbhzuSLg+o3LR/qSUOFOcFUDn8P10d/bxIJEF?=
 =?us-ascii?Q?9PO5ZVRXRKmaQdrQZOfB+3BzorCRWUHCfxpQ+NO/bJLHv4MmSuYE3lPlbVC0?=
 =?us-ascii?Q?IXTvkCx3pKMEHxnWdpt9kHps41gAJef/cF/WGMfLcEIYw7ZFCp3eLxnChSgC?=
 =?us-ascii?Q?KdJtiTrI1vO9OA8y3i/SqGut5OTYvKNvoMzXobFceY3Aey713nOie0uR8v5X?=
 =?us-ascii?Q?+csmRCeaUkVhCZliEbWr5diFr/DZIlzkSbtx8QsM6C4mKqEa1jrZsYaj2rQ4?=
 =?us-ascii?Q?VkzG8uxBCCchj9Jlw5grgqqAh4yiRjV7I5/jOxjCNWU+y17fkpD4WYQOPmYj?=
 =?us-ascii?Q?w/Q9Ob9gOvtjI2p8K05ez3dj+h6UxAixgdvuzTmY4saDCar9MBBl7mlu24bD?=
 =?us-ascii?Q?SlYpXAzdCKR36+GRnPLp6sqkm1MNZYZGolNpAGjPk5tOz7FwfY3BZoYSY8SH?=
 =?us-ascii?Q?gbVNmZ2ZH1G7jGbE5jqNddXtdqerD8BMA0WYIWWkCV1DUk4NL1N43eR855vT?=
 =?us-ascii?Q?KIDbRehpDMbUI8+XaWed0D9IVTncdWaaUKQuMhqqy0FBnJlIzdPRQI+7fKx9?=
 =?us-ascii?Q?HQHCxebv7ABW0ogpoTDQrrJ62Tju2ueLey4GSK9scagDzueR4KsNVIJq8SIu?=
 =?us-ascii?Q?WyzSBp14eqqrM2WVbBrA1qj6C8kSR6ks7dqIxJ1eHrjm1r8z7ZAa1FjXQ+ao?=
 =?us-ascii?Q?BECAwc79qnx6ytmkcqo4UTDF+LM+qy2ZWe6GR4cUurvjjvEcZ7GFPD9Vk9yG?=
 =?us-ascii?Q?hO2cRRTTBnzyt9bKTAqSXB9iLesG11BErvjrMrxEfH8SOTUv09wnSzwieX9y?=
 =?us-ascii?Q?gMoVpPW5OCZIlLr9aI8MNJ5FbB3psOTolX2HwoZ+QKxPra+pET5P3ZYmyzRB?=
 =?us-ascii?Q?8xdSfyIeFvS47RXg9mthYs8OFu+wN02YNXILJvuEI3zpIyOTLFeO3972Yli2?=
 =?us-ascii?Q?G+jTtC3JnDJDcZYTZ6fz/Wl0Lc/YqEtJ/iOP4ahQ768QikEQ1J6CzP7Ii2lr?=
 =?us-ascii?Q?zf8qdtTophqCB/z1D2YsHPbt7UkvZBFaZ9abyjB5zONRe0TNzdAm0bDFYH4o?=
 =?us-ascii?Q?yGXlmASdON0CBSq7Un5JbeIjNpwxBcdNi1ySNLke33Z0dSJdAEu+AtU7U5hw?=
 =?us-ascii?Q?IiKhpLHqyoQJR1zo0UxBa0+bQ0Hd6lOHS2kUb/Dl0Uw7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AyBJVrY8aCoKHvyhL8Fe9rQd3gSY/xQUSezQ9/IDF6OFMdoV2hLKRpofQrkddQRszL5LjoB9V34Jleo3sQt9rBrGe+k1lwS4Rb+BI9ftxgTyFE3yAJ70s9DcUD4+XGqT+exXcAte9Ghqt4/qEKMqO0vSx94VvCtc7DVNpZ167362b8ofQzdUeIsBa6XYAhmo57OJTIKz+BWs7QqBOLEWnaQQmVG818fOJMueOcLybOc8kQUXL+IGsJmBrvGPulSvTA074qpbUqVVtCZQNucc6XstoqndZB5Qs69VIl1oKlMocbrW5GXbwN0i8GF7GyhXsrsUMoU41jyxoz2Q43KmbDOUQbCMsiW5rujvJV+b9WwVRT8i63LOgWBwchzm/BpCPOhkzM1C/RZf6SU4CdAorWA2cV6mlIVAyvNiHc2U2pu4aa1pLbUMXV6+i9FTsZs4Kh34VRVNdgc4g9/KMIi8v1g1OcN2d/B6Bu7iXbwAgK+I7rp1lUi229tNZz0gh22dSn4oURBYO3lx2TEHm0CWldOPCKaFYYewPtfcuiP3fAFjPr8EGoHfMdLJoCz7OmyIkqct1NYxTMYgMsxLj8vORlfY0L1IDYlFae1JPcIPhAk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ead0116-0429-43b7-ad5d-08dc48250255
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:58:17.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwzyINFc3NnReYSZYx0AqvTbIYGm7Q5Qp+W/O38Aex+nhVzwmKu0z7axa4y6MjGe53zxP7hayr6EqY3nD0PYlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190114
X-Proofpoint-ORIG-GUID: APaSpEEEgueCambpPlJxtvoolhZAAXgd
X-Proofpoint-GUID: APaSpEEEgueCambpPlJxtvoolhZAAXgd

Fix the code style for the return variable. First, rename ret to ret2,
compile it, and then rename err to ret. This method of changing helped
confirm that there are no instances of the old ret not renamed to ret2.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/relocation.c | 64 +++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6f8747c907d5..ab3d3d2ed853 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4260,8 +4260,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	struct extent_buffer *leaf;
 	struct reloc_control *rc = NULL;
 	struct btrfs_trans_handle *trans;
-	int ret;
-	int err = 0;
+	int ret2;
+	int ret = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -4273,13 +4273,13 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	key.offset = (u64)-1;
 
 	while (1) {
-		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
+		ret2 = btrfs_search_slot(NULL, fs_info->tree_root, &key,
 					path, 0, 0);
-		if (ret < 0) {
-			err = ret;
+		if (ret2 < 0) {
+			ret = ret2;
 			goto out;
 		}
-		if (ret > 0) {
+		if (ret2 > 0) {
 			if (path->slots[0] == 0)
 				break;
 			path->slots[0]--;
@@ -4294,7 +4294,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 		reloc_root = btrfs_read_tree_root(fs_info->tree_root, &key);
 		if (IS_ERR(reloc_root)) {
-			err = PTR_ERR(reloc_root);
+			ret = PTR_ERR(reloc_root);
 			goto out;
 		}
 
@@ -4305,14 +4305,14 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 			fs_root = btrfs_get_fs_root(fs_info,
 					reloc_root->root_key.offset, false);
 			if (IS_ERR(fs_root)) {
-				ret = PTR_ERR(fs_root);
-				if (ret != -ENOENT) {
-					err = ret;
+				ret2 = PTR_ERR(fs_root);
+				if (ret2 != -ENOENT) {
+					ret = ret2;
 					goto out;
 				}
-				ret = mark_garbage_root(reloc_root);
-				if (ret < 0) {
-					err = ret;
+				ret2 = mark_garbage_root(reloc_root);
+				if (ret2 < 0) {
+					ret = ret2;
 					goto out;
 				}
 			} else {
@@ -4332,13 +4332,13 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	rc = alloc_reloc_control(fs_info);
 	if (!rc) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
-	ret = reloc_chunk_start(fs_info);
-	if (ret < 0) {
-		err = ret;
+	ret2 = reloc_chunk_start(fs_info);
+	if (ret2 < 0) {
+		ret = ret2;
 		goto out_end;
 	}
 
@@ -4348,7 +4348,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_unset;
 	}
 
@@ -4368,15 +4368,15 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
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
@@ -4386,8 +4386,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		btrfs_put_root(fs_root);
 	}
 
-	err = btrfs_commit_transaction(trans);
-	if (err)
+	ret = btrfs_commit_transaction(trans);
+	if (ret)
 		goto out_unset;
 
 	merge_reloc_roots(rc);
@@ -4396,14 +4396,14 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_clean;
 	}
-	err = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
 out_clean:
-	ret = clean_dirty_subvols(rc);
-	if (ret < 0 && !err)
-		err = ret;
+	ret2 = clean_dirty_subvols(rc);
+	if (ret2 < 0 && !ret)
+		ret = ret2;
 out_unset:
 	unset_reloc_control(rc);
 out_end:
@@ -4414,14 +4414,14 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
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
2.38.1


