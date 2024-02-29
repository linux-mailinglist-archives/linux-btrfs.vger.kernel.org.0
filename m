Return-Path: <linux-btrfs+bounces-2894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8B286BE84
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BB81C21B38
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710A137149;
	Thu, 29 Feb 2024 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aUPpdA5s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mDoG1dWf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3736B0D;
	Thu, 29 Feb 2024 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171463; cv=fail; b=eryJgcrBjpTCgVwSzP6naRg3LF8E+2bir2H2zhpRCBXpStHzvsiXMDZsAFyOwNo0CEwkffJ7GBO+uBo2WE/2zBPCoT6nX+1lrsN6z/UkBBSql6ehQeW8cTJXTl3Z9ZXnP8KWsgnhwZwjtJLCh89u6Nxka8bjkxqTyps5m3vzzYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171463; c=relaxed/simple;
	bh=Dm+579C7KVexMNWIl6eabPdlXwxknZFjXfkpKHSfmXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=avR9E/ipYIOYIgEWj8uwRbmA2PMd2UglayKxOIgbkKQY9vE3A9/GEd8j6Q5nEBEB9HxAqDvmz7Jl7HABt8gSr+aHn+AwRMkQZTLAZojdUxUNlxKxzvGec80mgLdqPGmZQWS2kvSTRJxN5hY6aBJPsiFqiyYTDL+E9uMptOBJogw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aUPpdA5s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mDoG1dWf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SKItRu012815;
	Thu, 29 Feb 2024 01:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=YruqHZWPVJrC0A8PB8HoDBpCNCAsHT3SNxgFBMGGS10=;
 b=aUPpdA5sm7bSgqrQQ41vlOyLvStNVi5JzG4Aw6NHlZ6KlLBGgUJ7QEH80uFVYPmBikyz
 GgeK4Dt6v8vF8TdUjWgwqtHEYvkqYI4tLz9KPrR9Qbj4gw1eiJ2YRo+rR7ggVYAygrmm
 A2MMfK0sJ46fFMQigr/0/wVMacjHJnS2YIkW5Uf+zYuE0A/WgIzXim9RA2goMOyCphPh
 An7S0kucAIG+N/EpXWiDMqsS3VllwY0LuRfwtZ0puGTRnOI0pearqEbn76y8kwynmeAH
 ZpSW8Q52hyCXmXyq2TmIxnXBMlkMf/GxLqN+AibvHrBZCLp7QYQWFd1FUDmns+CzlSpZ CQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784m5jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T0sjNd001682;
	Thu, 29 Feb 2024 01:50:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9tbu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSWb3l0Kh0SNXtuA0iKxp2Kl39DBb5JfJ77oBJ5PCHofNI7QAT0Ff0NOJgxLxgjHlE8Mpds6toNmPBq2RiF5NDzATlOer9SXdzWKnb1n+MjItHCUtacysXOQHoLqpsQ+wqQZnebZJdgP5UbdadaEzKLyXZx4NUjP7gw/Jn0K2JmJh7hzJzWsSUis2WM01J+jV819TliJ0BWgdZprQnwc4C4II5aczux88iGLQ/sfBiAwslR5wbmOWTrec/k4RQtoCRqDwO9PCtzZdwIsQuDFn5r1BQrZD+HmM/N4xO+LiJuHklU4It8WNUC7+u0ZU79WD+bvnnb3evruKgziDl2cLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YruqHZWPVJrC0A8PB8HoDBpCNCAsHT3SNxgFBMGGS10=;
 b=Jjaw/Oea7PDMsDOUXz+AOiv7C78u2+KCPKoBDopeIyUevFywEgbQ3FSnIZKbsdDDL5M/U2aScTYXGDJ5LPFzR6onfUsq+oWgpCir1FUlyRAkJIIajdf3TVSKN8vPgmasWhLYXEEdniHozX0br61F7PXXNqSm49wSsRq7bh9lchczGeAzEDWec/ndcIWIOqjNITVeUnFVJELSyUKF4Nt0oTedD1Vv+/wWsyZ5Tpql26paneDNLLSBeMwyArdigFtZt6y1PNS9KFjlP8xoSviFKWZh1tPAcCqREQlUQIU3mpHApmlRUVpZXgDl+4jvy63ADpBoRw5yw9yHp08kt9mrdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YruqHZWPVJrC0A8PB8HoDBpCNCAsHT3SNxgFBMGGS10=;
 b=mDoG1dWf6THR1igCrw57e1r3ItN10BuCgjVmnfCwDhjbdtFaF77Ry9uVubjhed+sva/C0XflqbWeZKsGpMCYJ5AJwhLXk8jPXUrn97LAfvriZNOwYK9FXVIKrnV1MKIHMLsV8Xk14s/gFwmZBjPECngZkcOpbea4YPUdq803GMg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6239.namprd10.prod.outlook.com (2603:10b6:930:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 01:50:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:50:56 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v4 07/10] btrfs: introduce helper for creating cloned devices with mkfs
Date: Thu, 29 Feb 2024 07:19:24 +0530
Message-ID: <75f514c0b05e138c5fb03921c25a8309ce9a3c33.1709162170.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709162170.git.anand.jain@oracle.com>
References: <cover.1709162170.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: addcff67-faaa-4f17-c964-08dc38c8df0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qn4XYsKLsquRUrW6diIl6coDmsHxqxnwZaFGO94DiBAu/iBb39AwkncAvyWKT1JR1VAlSZ+852tW3pyNWXo24+Z60Be0UAm5lL0vAIN2rIlkbYhkFQA/wcEf0WZD0Ce6nDhB7R7esnmaQb1K2mnBWZbWjb2CvT50+3dO/YEmW4Qfwl2S7cIwrLLouqAxy36yQPlYdhUFBPeSX3yB1rXuFluwfH5jKdNYw7Tpnp8vG6yVp0IPliQAkTdO56XEGumARazcI5teg/Nqd+OrDMD4msorV4m4X1jfG0wwZwgIwWOnEU3vGIpHwez1RDs45cIc49nfsmWSVfgcGsJslhC7VfqSfm9OT+4IOLYrO3/81l2Prgx/R1DA//O4tOXAHc8RQrhDEGr7SUezQ/QnJcJiWaj9IwZ63nndPQKRX+evC5PQFORZYsn1q1KbaP14zwwIFFOhie6sJHXWBMdeIh+Oxin3+mE8Usor2kXDngzuPeBQnQh/PLR9DOLtKjV/N8kPpVf+yR3OsEeisGyJYv4MQcHKzVs5IqKiBfq/Bu+tcqHH0cqaESf1zDahg2EtC/uI52aEoIkL3jPOwgqobhqIOMxAOiaAqmIKay/CaFR7nEJVMpGI/9fSUqOcGfZQZLI5kQAa85bObNEvPaUsHSV9vg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8XouLesMN13duaM37RYTq3oKpGcStfd4Vh1c/DxwZ9ukmsJ6cZZmzEjs9zkg?=
 =?us-ascii?Q?TjjDVdapfIHT/G+G+SMVDnNvL5nT9VyGQMbyRypdkocPHCmWrUIF7QJLrVp+?=
 =?us-ascii?Q?nVGKVw9s2E9PPrFD71/DyIhoOT6m3bGSMOdQgLlnPDbWRPju1p/eEblGlONE?=
 =?us-ascii?Q?vNO8SHBzG0zxPoKe4vUBKWQ34MaLXHighTp/WANnJczTsxSyssHl73cXbgil?=
 =?us-ascii?Q?9nbPe/lOrqo8Oh+Gryr2LuWxO/T1K6Z4tKZ9rzYRo7XY7HUeZ/1W/ZUF2OWJ?=
 =?us-ascii?Q?WrgQUdut4RewAN+RSt5isZmMXCFkiHD49UsPdpIcv1uwSszquimj7gmnnwR8?=
 =?us-ascii?Q?Yp5KKFYxwnoFQ2yUlDAuEdVxvmbotaEPtm/OLBppSyyetsdx9mXGp0R4URgp?=
 =?us-ascii?Q?UcFfdt1lnIV+yPJ55NW7xjryIcQ9rsl/KTdOCClXe/mmh0pJOtk/mgxyYwBh?=
 =?us-ascii?Q?nxWg3/jX4IPR9sfubDdiMw9uzEHaBqNsnBcdOhAUXSIpuNlVziwAeaNOLYC7?=
 =?us-ascii?Q?ITdDtllW9/gAzadvKTpZLu/zk7qeVup0lSfoEmr+H2lG3Y3M2KqtigTLB5j0?=
 =?us-ascii?Q?uSap6Tsc7qjW102AC/85QFhrnmztdeHbIp95hsLiugj0n+kn8LKND61B98BT?=
 =?us-ascii?Q?UM1m2gXWutiFCIJ/+/NMKtqr7UCkSs0R63YPSJf7LOID6xdzHuBvV+1tRm8E?=
 =?us-ascii?Q?iAgWgwwo9hF04TiTaHW5w/ZRW9KoitNdfvSWxCHEsq3OUq5+F8AyxF1Onoj8?=
 =?us-ascii?Q?Nia5OllYFy2DT4qtyfECKjNJgMTpQt2MVwUpM1v361aM9lVC5sPPxckKw6L7?=
 =?us-ascii?Q?ONLtacCXj7pUpS0HWgk0cuHgEfn7RoTcUqdHs587slmC224kJyr+JrEiREZ+?=
 =?us-ascii?Q?DxOcfDhD74o50Ptv1sf1cJe/HtaWPhydwvjhiRSfaGBxD/ah0LfY4+t4AU6+?=
 =?us-ascii?Q?kmrD/zAne107PAiWwBUVchPO3vy3O8IcJOsq3OgcQeGL47XVGSl8/4R3k8Gz?=
 =?us-ascii?Q?ZGPzbTpQjCdd8j5muVYO0OTOqRbB1OXGzD6THVzWULrxuHJ9GDNzxSY51UMO?=
 =?us-ascii?Q?tc2SSKCgDy65cMgiwMEOAAUH/HQYRhQ89VOLFkxpQ5Is538BF+vGb/QfAB3P?=
 =?us-ascii?Q?YBxHzYOEQnM6bK2M8ySDUGpJBiOT83q++t1Xp3LZXL0U+pPX5jqO49iROAJC?=
 =?us-ascii?Q?fYAhOi6zAKFqHzW1Xfyt2Z0NH6ogXnFeSgdJ34+zjCfEsiNh2oKe/24xB+yp?=
 =?us-ascii?Q?xJ5JBzploa5MrTNU4sEmJUKMHQtxeCKQkPvTJxhXX4IVWWmEJzH8CDDV+i6o?=
 =?us-ascii?Q?48OD4DYdSObniPJnr/7DMkChTyDzn41FDBXtgdSRBoFCckWhLdSEpSyDdGbs?=
 =?us-ascii?Q?icn7mM1CZto+5MWinQEqM94n5mt5+Lz3G83jSD/YOfKhOcqKAeLNFLd3POeI?=
 =?us-ascii?Q?5EJrSu2Stq6eVanJqnYxKz7vvl+aRe6Gx+RHlzGdDMBeNp8z0BFvPl8Gg3iI?=
 =?us-ascii?Q?DYv85EqGaS4D5R0OHsdeQAe6pUPIHSYDab4cGRc6b8KQbLEvPnSxhea95pFL?=
 =?us-ascii?Q?Zvv6XxtlUFtQ6K8AkPBBnkoNcDlAsT3pPImel7XR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	An+9t4EgUoIV2gytLsxRDA+a3v7flAmTgIr2tV4ujoPqWIydMJAoi1vF6H6FdJInuRtdXK4ZE/xWb/Vr8WTERdvULArL1m6hvd5kbjq6LWALM0tnMnB7vlUP0jYWkSpx4DmETn7kgMjWJTTfHnlSeGWxGU5LBOw/JLICldazi94vtZKnfARWKYYqWoxL4aT1ure6GpzbHYgiuCb5hplSVRe0b98o+h1yTPt1gK/YbtHfKgzjAC1chLbHRfnKtOKN93MgcfsLHtoIaNRbf2kORB5D5/wogR70BX7rHM8yB7iERGHmjuInnOagtKVbxVUT86wBWlSCn/ud2cUDtf8MGbSg4dxa9FDNuuBuiKl/mJZdr1/v9oDtIVgUDuR3N7DYFLQzEF3MlFeHBUVScA7LKlOIGm4SbFbXYc/SCnhXU3itfhd1VBXj+xIR88lkvTCBSaCEsoZ+YqKTeUM81w3cZJUt/GFfjt8CWB0MvEc4b1tfb4/tYWKc3Wdx7eezEJ9t5BGUwQC2yW0wXrxmvb7ytkj17S1VdIJDa4U7fvPq4IYETQl9x53f4HTgNtKglzXiFgP5W0Okaoz9YPaxkJsEIAGKfiJuy9cjdtbL34UF5hM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addcff67-faaa-4f17-c964-08dc38c8df0f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:50:56.7562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlydmqEb58uGgQ5FuA6CtMfqdblskzfxK2mNMHUI0OL6bSY7dI9zAg7Kf7L6vuozHje/A04+8nfQt7cDmRr7dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290013
X-Proofpoint-GUID: KJIfKkKjABdI7bjkgieN9OSxZLYFymfB
X-Proofpoint-ORIG-GUID: KJIfKkKjABdI7bjkgieN9OSxZLYFymfB

Use newer mkfs.btrfs option to generate two cloned devices,
used in test cases.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index fe6fc2196e68..7141a0bb7b78 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -843,3 +843,26 @@ check_fsid()
 	echo -e -n "Tempfsid status:\t"
 	cat /sys/fs/btrfs/$tempfsid/temp_fsid
 }
+
+mkfs_clone()
+{
+	local fsid
+	local uuid
+	local dev1=$1
+	local dev2=$2
+
+	_require_btrfs_command inspect-internal dump-super
+	_require_btrfs_mkfs_uuid_option
+
+	[[ -z $dev1 || -z $dev2 ]] && \
+		_fail "mkfs_clone requires two devices as arguments"
+
+	_mkfs_dev -fq $dev1
+
+	fsid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
+					grep -E ^fsid | $AWK_PROG '{print $2}')
+	uuid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
+				grep -E ^dev_item.uuid | $AWK_PROG '{print $2}')
+
+	_mkfs_dev -fq --uuid $fsid --device-uuid $uuid $dev2
+}
-- 
2.39.3


