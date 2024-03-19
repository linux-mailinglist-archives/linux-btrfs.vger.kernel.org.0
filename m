Return-Path: <linux-btrfs+bounces-3398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E681B880003
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157681C216BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138252E82E;
	Tue, 19 Mar 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZJUeW5no";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sW7809VD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E656776
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860201; cv=fail; b=UdXc9xVvzBQZQx69T7oZJ0F4/tRsWvl8wWWOQQv8kXNlfXLL7NARRm88RN00mCWH/4AywZs8rEUkWoGlZ225x0MSnwTI+UezVoCkxlyDzPkqcswJLa3L5VIKEcUwra5mOLYesbbw6zckF3jEVC8FwVlqQ0bweEqI8g2hO2qt0p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860201; c=relaxed/simple;
	bh=JCuObB9DUXou1EGRA0RLp3tIn16Bzo+3Vda6D/vKKjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FMlLJZajKEWfH3ZXgX7m9fawmWACx6lIlbgs8CKL4t7UvkzZXOBNireuoQSCKzmQO0XI/9P/a8ObWUdLRunQ0b+18AgcbKR61CFkpHy73+aaDYlz2Fqdeoc+8RyCiyo2XpfSEEhtjwcQlJanwsfvGHqwPV6TI0YHnP/nsXGDrIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZJUeW5no; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sW7809VD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHYab026414
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=sfDlihruz91ILTqSsRBUow9swDcva91Cm4AuDDt9r7o=;
 b=ZJUeW5no4RfrX2v27SFvYIAfnD80y31fZjBmwA76qCFN7C20OMVz62Mbd/0GDisN3yqn
 sreFUqRFsBcbWERWJbLoHDf7zfgurggNPOY6bzkjzHmG8p3sVY2CJJWqms1wF6Co4cHS
 YJvpNtTZ68TNmKOUojeh//HDNknDGmpKXiQdokwZf3X09WmDC1M5r16Kxodc/RByB1lB
 OL+qsHqoNEv9mtRfz92Ma1eULSRPpY8kRgpF6ER2sRe2aFOvxSnBeMqO8F6aOhMGemUF
 Xa67fxllv6TnsK+62Akf779DQhB0eLFpokmNs0GZJgd36uvUbjeIbCUMntOUAm7H40u0 Jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww272wts3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JE84xk003725
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6c753-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhBywu0A/UES/tOe90o1zssnuB/wT/HZ7691rapmDDVqDNaBQzXs2EdsR+85JAooEp2nbrGCuytW5gxb7RR+pFOh2band2VomDUnQR2KxB469ywC2EpcWsRf+6AYhawWBJgVRLd7NkViPaVX0llvBsLnCEGPA8Une2TJbUKmTUMq+qKrS8L4sScxS/4/bDCEe/57LxgPKnoge2pah+vh8pUL0cTWg90AErZmGQ0/ILgvUgLSeAftLB4vWTsvEksXp63TXRBMnyL0wSppEQGt2MSN5t0ezpJOBLmmq2qXxkkyEWj750lXPdO0lKPIQXDhI07r0e1/Lnc5RCyBa2sqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfDlihruz91ILTqSsRBUow9swDcva91Cm4AuDDt9r7o=;
 b=h+gOHPAeDX7/6v3jByKel1A1Lwz5KO8NDcywm/v27lRi3a1MHOBgkrXjHZiI+sEpc09+yo5CzbdqTj+UJqZogk5RtbiNiRST3dj1+TJxs9DWP8xO0hK76Nf7KKlRJFndTNyNZHXcZc7wmTe9CXQoIVFFtZKXAm8QwnhjhlEZWI8aT+FEoQd5sug8WcERAQLmIuhDUdzWx2Eq8UYPvd5DaGSlufQ37/6410SJJwcODU/ct2+8w1qCEwdYFgy3Wa3HW9cpUw0dIb3SJvCu6Svj4iYKjXKeqlAqB1s3RQWVKF7RAMDOcvI2s6scH+O0EIVPtZpagJ0HM22CWbl0gY0C7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfDlihruz91ILTqSsRBUow9swDcva91Cm4AuDDt9r7o=;
 b=sW7809VDDTbw/IwP7HNRW0vQV4/SsshFDba2p3i/+gjx25F2sKtXLP/JOgx0PGfwh9377jyum2K+0TJ1AUknJ1kKy/j14Ip7k2RjMnzJZ4dgB4MXUoai7UnKOIkySVl6OaDJUcXMnGt6WrGeWnTqvtcg2v6T1C73lyiWf+pny2g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6120.namprd10.prod.outlook.com (2603:10b6:930:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 14:56:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:56:35 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 03/29] btrfs: send_extent_data rename err to ret
Date: Tue, 19 Mar 2024 20:25:11 +0530
Message-ID: <03e43b7538d2a8e8213d491d65bcc02aa9fa437d.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6120:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	giZ3cuiWngmBvzBy2NeYTiTzMors5MFww89Pv3abQIjeqp/t7dINoW+Zo/fJF1K0Z10J2UdOQpQHTQDCnaOnsedixtAlUYFf5JVZCzp6kZPKWrBzdYhA/kxxB1zXhuzE4mzdFtroa4kc7jagSEAPXygvJE9BRGMXUl9C3+rXhoxNwz8Jj1OhUqH7YAWd8gh8PMmjID5fHAbJyJZ88/bNqDTs4Qvx9ib2Hv7eDTIqY73hKtM/BczKCIEecDd1Kyl01cy2g12hR6gZZYU2MfRJNHjmE2FEoEUZ+UMASMzIZIbQw77muqZm1yJDr74Gekcqvq1P+NcZi/ccAPlB/hYr1Ip/suEDdyb2FZCFGCaTI12Ss9QXbb7TqJvUwJosFJvGnOTC6fBJUPCL3BbWhS7a9pr+lZ8Q5fMUCukLdtTxCFuV7uFWmjy1V17CLYO9IXAIKMyxFwWh55YM2Qj1YisshNV9sSxlIv0qzz82dCsTPxwFgu6yyWNmzC29wZ2gke+RK+94HtcVPTUbuyRpg9+avtuaWoNWjtWYvXnYVXj2Mg8h5LbrEsi9R3nnHJ+cBEBwgBe1em6bpvi3Lhir0AUgg7ZvBrFiz3CYTTkKsISbgWRUajvkldqkIdBIKo0wqws07UCwugOu+u9F2XERBw6DJFdpKfXdFZg4s7UAlwUnRqU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Wnog3A0zlWHptcIXp4fyPUVgip95xNw7KxnTr6mnf9J5zW2cPOFYcXyyx6if?=
 =?us-ascii?Q?84AoPG1pc4xed/iiVuvsgmGctZIoHM1SqQfxr7Jy4G0qCKXFz7NqOfprVmRA?=
 =?us-ascii?Q?+54DuIrFPEg8O9ZkzRSVRIcLDfsOuwPrqK1C+xexm3uI5+MPeljoUHuJvNVl?=
 =?us-ascii?Q?qAl63aiLUC6oMdkzTor8fhT+2rdDaeaAysAyy4H3xi9DxtjrxtDvVb/NJArj?=
 =?us-ascii?Q?qWSucmo3CNyGqxiJk5SNb8RUQst0/djbnTcY8a6x0puZCtppQQ/VzB9/CzqB?=
 =?us-ascii?Q?DU7UI062822keg33kIRFk/orn32hyYLtHCl0MkHhJFmXg5Nr+meK/ba2QqR4?=
 =?us-ascii?Q?aj382AtwvPriGQcCvA+vRhRcBZ85ZpHOZaMEEt21P3jOJaT5a2JyYPc/aDCj?=
 =?us-ascii?Q?BvBAn4HMjc8fKoKxlMUYbt3eDULfi92Ozk0qcapNvUd76XiqWhbMid41pxvW?=
 =?us-ascii?Q?/7BtNJ9lKGOzwZYu5zKuSHeM8k8ekmu2pluwUrdULVUZtShO9rAL9vWA3mAW?=
 =?us-ascii?Q?Vh4khzWKFCGkXmfSHsb/ZqbCKktvsdyRViu49tuFrEZtbiNo2c8WnUVQducE?=
 =?us-ascii?Q?9MNyy255Kb0Ox9TklkicVaqJNO48f4TrZlNAVNlZ4lhyWqMuA62XueBPLJ6f?=
 =?us-ascii?Q?iodebkTZmG5vjaX+faApE6iaVqPW7/koZ8WOCUsZxPULk8L1Fa5CD+01mo2x?=
 =?us-ascii?Q?Dy/Vzd8xzChRqkc6bzAB6ftyjfut1JeBZeDBPd1XI7qERM7cbSuYgB5WQC/p?=
 =?us-ascii?Q?yqQYG7YZOsu3wtUegHU8mkYxRAU7PtFkaRNS85KrHSyyXKqg1xkNQ/g1HKzI?=
 =?us-ascii?Q?Is6y7aFfq5YG/IqN4QY4Mj+aA3LHlXozbdRCJISzYG2AIDQpVZSYQlml2y/b?=
 =?us-ascii?Q?qWtkyhlCWz8xmiuGxzm9L93NRYm9v7eyJgk70B1Q0m38MJabOAP9nCjBXSso?=
 =?us-ascii?Q?Bwmq/C+YeW4YjHZu4iTvs8zhK52QlDmQC8LI93UEb/UY6PVFW1Pc7gA8aVmh?=
 =?us-ascii?Q?4pHFFm24DCoBJrrFVDilvj4SypxO+WWZIE1uGecXPbnWm8j8B1eKiHfALOVA?=
 =?us-ascii?Q?LeKVAbyQU/GIGMYs0Rhld7vdMBugkYBbS0yFxo6Jt8GQXXjcilJr+uGgW9Ob?=
 =?us-ascii?Q?AhKNbnMYljX+H396QW0gEtmpWNKjcC5hR51rvMq0qgncFgS4lOk72qkvOSjn?=
 =?us-ascii?Q?aWN3dWSbsCg/BncWt8UyCwRoHIIcohdqGARBk19P56engO+/1XFmQ4G6pH66?=
 =?us-ascii?Q?Ig1aEV2GnJnKYgkzQf+d2pO6phGz2r3nCzQ9bXyT27jvrh3GvE/uFNBu/e0k?=
 =?us-ascii?Q?YfOx5hyOJ48aoEd5vwfmAdOHkaVu/78tF0of9sVrb83lt6liAFBnVwQPmB4R?=
 =?us-ascii?Q?Qi4NS44MvSU908BHo17stmY2Ac4cjDAANArtVnCDU1/ZNA8R5udAacKxPfjU?=
 =?us-ascii?Q?Ku1H7EVRFpc+qtK4f/aKq0VdFfbSFna6YdmHrVPgAFmFS0eH3eMWNV9co0k+?=
 =?us-ascii?Q?2kxXqS+FuoZlCR1s/pX86h3nTRR6yZVALnbtCS6U1HdR1qEAPL3bbhFGcNZC?=
 =?us-ascii?Q?+l7L3U1NOyZ+BXFtTl5cOHlqkMY1uqcTYf0GG2GjPMyT+O/WG6chpDrKJDJ1?=
 =?us-ascii?Q?ql2jMCu4nZ5oSApvC3rGEdBzSVPpZYWJozrxDBVHdXS+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SSLhposb+bb4uD0GqvjUlU7o1y3S3nUCoUyulwUbNzyZNpbt8buuB4r8Q7WYzviAyVTG+ScPlDfkTT8WTcAkswfryZkXiJ6lzkGq9S7twwIHz/qiZefHELANfLEe/h6SdQL1qbakAntLECQX1g45jDx7utXDySBXchMvAGeI76TCW4aMgtgggSPJ138/E6cbtanOnTi+uaoy6gdf264t8RTyqjq9q1rT5idmu68X7Kodg33lB8ywIQuVnn/MT7jevAOCoxR2oKv9yMDTipvdPadJ6c0vOMd2vfbKW5Ug/UcpktAsjHnwBYhvlWjvlD+2FPeVBnO7Tp90vt6YtgEIq/Vsxi90vFEh0eGcSjl6kVbhGFbvbdl6WGcniGzFEvs0J+KYEH4vH7EziZnsy68+jD9Lg2YSUyawFTXXcC0iKQND56IUUmKsTW/EA82Gqs1BQTksCU1yEyusQqMm4fM7rKbYxPEM4bNN0xYfSaniMOZgK23RwqwT1SrmZ+g8hb+9oIY7CSByZBfU4s+RuLfHdWJIPS5lxrDpaGnReIhbaMQy509iziQt2hPjonUIYmmDIJ8nE0B9QkrV8O9glzENyXUHfDdiVHKcRcd8c6yScek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c3bcee-f966-4334-3158-08dc4824c58d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:56:35.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6jF4274gLWHuljcEjxKCONkvpMU656uV50cZkWX1xUulQsywWhllM78Hcv517RHv/PPeDWIhV8aN9X4DXo/Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190113
X-Proofpoint-GUID: fNe0alA0XqDv_eZwcq0xYLwzXNFg7v10
X-Proofpoint-ORIG-GUID: fNe0alA0XqDv_eZwcq0xYLwzXNFg7v10

Simple renaming of the local variable err to ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/send.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 50b4a76ac88e..7b67c884b8e1 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5748,10 +5748,10 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
 
 		sctx->cur_inode = btrfs_iget(root->fs_info->sb, sctx->cur_ino, root);
 		if (IS_ERR(sctx->cur_inode)) {
-			int err = PTR_ERR(sctx->cur_inode);
+			int ret = PTR_ERR(sctx->cur_inode);
 
 			sctx->cur_inode = NULL;
-			return err;
+			return ret;
 		}
 		memset(&sctx->ra, 0, sizeof(struct file_ra_state));
 		file_ra_state_init(&sctx->ra, sctx->cur_inode->i_mapping);
-- 
2.38.1


