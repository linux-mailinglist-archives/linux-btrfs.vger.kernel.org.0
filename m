Return-Path: <linux-btrfs+bounces-3059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E52874D05
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 12:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D6C1C22AFA
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 11:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04911292CE;
	Thu,  7 Mar 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xg/3nNAc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XMMjEXJD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A220126F39
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809729; cv=fail; b=S/WxJ81pgXf1oUbSJ2FGN8AkangRv2vef2KHycIPDojFtu5DF6o9MdZiGIKjHKp+U/Oo5KEqKpOniQ05mUFkjDq81wUWjKLKHr0UX+7qPYDQUTW60x0OITuf5vxEJQjYrXShzROtRRX8+TaYhWo5K1OhU/gkTFLV/jBrTfMpaaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809729; c=relaxed/simple;
	bh=eNMX9dOOs6tDOEvHE2dWom3HQEPjgXPW3yeS0g+sPrg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=r8DfA8tY5HvEUvadc2x9WNexEHcPwsPtYpWh5VtHXNDSMjhehXWsePW3DzHbL5AgIo8IHfLqoH0Bq8dNKILXuwO4EFVMGOGmcaY/y0WXLey2jaGTdE5gkqbgjx0sUYSY6eNAk4KzsBv4NH+GA8zpehRRNkYRDXW6Clc2aoY/gA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xg/3nNAc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XMMjEXJD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279nc65020788;
	Thu, 7 Mar 2024 11:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=nqXtO5QqOzvLITnAJHMXIx0/rXhvCFmHHfQ7DBKLlmw=;
 b=Xg/3nNAcaghZpM1u3RaD4fItg2JNwkyJMisMVv62jslld0sfMsCoVSqysITEzsPYGRJK
 UFDbwLtC0zedRrNTL40y0jCD16yiujwU0w9+YRp/XUUDa8XarGF2BnfWLJWK2868BaCd
 rKL2x1X/TijGPau/UO04UZCY8gzzRNqtldCWcYZlN7U3OcB9KA4R0l0ngUAl5uNtEeOY
 F2bIijGvgCwl8KaRcIV8G9rZvErw69YnUyYgzotKqe9FfVFu4dEA0HBet03Wqq2xOQEs
 0diR1cADosh8QAZmy7Vqa7VpJHeenQtMJnUH+vnhPCLmHSzQuPUlE9iMpeWoDryVfB3f 5Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq2bq55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 11:08:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427AZttF000320;
	Thu, 7 Mar 2024 11:08:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjgujnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 11:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmOiJGrSdab3ZYSi6jj9paO4/rOI9dbBsZf+EcE0PM9UGPVQY2bKrRl2N84zMJvTx02Qbkr6uukPPS8koxHeK6Cvrek5ngo6Yi5gi9xYoaiM1yBIUjL8aC/YmNFwV1gqn6i/j4N3xXoNJDEt5vPaPsflkd2OL+PP314h0SOwI1JPUFWoxOOn0aqzs1choy5REEVMojgeuOVoXqSvXWd9lvFESwSlnwx7dLFcePgtD7De7e7pBGoaU3HNezwbzvjkqxwoQKIzjPkC5KGZsTWEEhV536TCfACj0EtzdbuawEAvYxe0UEUJxo04nVBgkrwsUDah0bw9xrZw66SggHbcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqXtO5QqOzvLITnAJHMXIx0/rXhvCFmHHfQ7DBKLlmw=;
 b=LRs9KyQ7ICus+NAknNWOmKJEiNYtZH9KG73JcZaW+df7esHbDjBiVIj2PGKN0oMKnpk2eQ24Cirlp+A3kfgqVmL8T49/5pIi/SnKmR1gy/NR9qxNHAk+2LRyE107T24i6l+lR+p66CVVDhpKTw7EhyqSDG6IbOjgPYTQTb4l/EP8Dc+04M4LIpOjASxGfaxFFgeiX5x5riljWPggl82EDafR5lA/ZauiXyBQrGCeO8Cy3er9YTFn9w5xuK9wJ7dImWzMZfGZYGCAl6Wc08vxhKk9uf+s8B5T8l9HHl7Flf/VgONZRhCklCGUTt7713nigiMzxB/Qvii+F4A/+rYnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqXtO5QqOzvLITnAJHMXIx0/rXhvCFmHHfQ7DBKLlmw=;
 b=XMMjEXJDn4F+1gR/AbnpbTN+G/E+PCsQklP2IWdb0y3DEAzjKZsS/w/FFgege+zojA9tUtWCONvBrb03Kdc+iuTEiJn10yEjhR36JN1Q86OcCfMSFdTj6FxsTOyi4qJZSq/X/NukGnGNChPmyql1Uey2IJK3nzLl7GcxIpJC2zE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7020.namprd10.prod.outlook.com (2603:10b6:8:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 11:08:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 11:08:36 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org, aromosan@gmail.com
Cc: Anand Jain <anand.jain@oracle.com>, CHECK_1234543212345@protonmail.com,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v4 RFC] btrfs: do not skip re-registration for the mounted device
Date: Thu,  7 Mar 2024 19:08:22 +0800
Message-Id: <65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 65287e3e-f6d1-480e-b65b-08dc3e96ef82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wj6lIeb6ix/pqPWA+YoqA8XFiJvOrdPZEbnnQg8Q9gxwDomDMbNYsaADtrnpT5yI0Em46sBjlx0TE3G9GTu0ZhWbBHT3FTqsTzKGkk7BUjyXCPPtrDtroXOLmP8Iyd2rdNzdQr8yGj6puLdGzTXZDz8SXMo5dSl05Ss2AsKrM3xZqdc/jA+Yj3NKFXqFRgrDJmqQCvq+PjSocpe2FA3LpVGbNdN5zcAwg1S8tA8yMokL7Gz4Uq6xDEbgCnjQR18pek/rlRZKH81KeQ03eyYN0PseKcczZYAte/c54FbSmHA48n9vne+P4JLWTfkqaW+T4f9my9418g4sNxZnFU7nzjdb0HjVRx/MzPrLFjBvadusGmDcD7Iz/P3NWO1Z+rbDHYp55hxzStq3tIz4DD+NSnGlgDoBzMmTfuRuX5pr2sMQGpvjCKbg/FXGBypOBjK/eXXPhzLsMn8HVN0aGbdtwEABkldkaxHQ3wKHNdV3qhNQWR+sAABudNl30mqO1DWm0YVyGp6fFH8LWUD9QlDh4HBcNWmmkV+2rzO9er38vu75fd6tZOC7wV93XwWG4wy1MNK2lpuPZP0sORq+pew/JQD7p27a8WijfybwPgI7UvqZrC/fO/5I5PVAJMz8Ut0q
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yBFznQ2zwKLwvCh3vNJLPfwp52cU1WAMGWKKeHV0D14Q1B+FYuLPp5t05XzH?=
 =?us-ascii?Q?dluEfkvB9s4PPXUbSO89o2NBWIZGJ4MrfKWPOD0qGrxbh9XHyd1FbbMjL4Do?=
 =?us-ascii?Q?bCZAPpF9SSfPzUIRZu58VgYRtkVRpCOtUDKWbLca2Xe/uzDbuTFhYP7vih3W?=
 =?us-ascii?Q?LxmJ4PFFmkPcuEISJOINunGsvSuOwi3iNRvyKwurZIo1O/CQWIliZp+SDuhG?=
 =?us-ascii?Q?NT9X0AGXdk6xE1UsMvzBihrMekCw4NB//UV0JTxwwjKDSgV0HOrr8zl2642C?=
 =?us-ascii?Q?26gJr/xoMgcq7TsYwy72Jyo9mDujs4YjSt0ANIAJNxW02B1WzRt0ggCkslJs?=
 =?us-ascii?Q?NyTjHZdJlRopHnxQkETJD1zFYWdSusYsxVUwIKL2ec1REksmf/PvaKsBul06?=
 =?us-ascii?Q?k2SE6wuujkhkERaXIm25PShhQ6QC07wYo+aXqFfiM73kNtkR8PvoL4mfjQyH?=
 =?us-ascii?Q?66rwPGN4EzOttp+JQ9/MFiauNhXt34aXw7aP1fN3plsDURNQlP2pBXBm5LMP?=
 =?us-ascii?Q?qGEl5XWI5R8vw/dXe3DRKTT8fdNSLA3C4AzXeondslmh84T4qEBIJywUlgvj?=
 =?us-ascii?Q?eaIkV+H6XsDKJJV9lGVSr1PCnfA1U6aUAjh8PABz46Zdr6e9OooAuqKMLEtN?=
 =?us-ascii?Q?uGY62BCks9bvNlw4Rl/UA5bNxDrDwBmk+bl+KLN/jsGKqaIo6vEjkVAcY0qV?=
 =?us-ascii?Q?I1faPXYjgPEEPELRJMFcvlHkdKijdxS417hoVYAbGm9Ei1vW8/+p/HXhgUjr?=
 =?us-ascii?Q?OF76QlH/qb9eoZJveA6zZkN4vAasHQmZZkiHxVWVSg+50iPe1PsWZaslB80a?=
 =?us-ascii?Q?tVs81ZOKlB9NpGY+OJrMfQmtS7A6Fihpj19bPpZ1SceFYMjY4zk+sjY8nU2H?=
 =?us-ascii?Q?NMUE2ETXHjaCSQhwR2NtorK0emv+iIHT01RC2G8GbWWX+VNWcNzcE6taI1Va?=
 =?us-ascii?Q?G8vTowg2UArad0T4VAIjakvx7kOTHH0550uqdYJhUcQZl/Cj6ZC4n8BXhIQ+?=
 =?us-ascii?Q?uhrr2YQ2vNIx5gD9vMEW1khyxq42SS6GD0Mv+D1FyxQQmEBxCzxr8xMATNWw?=
 =?us-ascii?Q?vCCysRnUbjAcRZJ8m27ngNKVl7qCFFHDU7f7EsUPrzzUseTK/Hdwh6k13+EJ?=
 =?us-ascii?Q?B2jW4f2IstEkk3lkFSDZwk4CTA530ZzVkkeg0J7mGqZrE7VRmeZpBthj+Ecl?=
 =?us-ascii?Q?V4CiuKLlmq+TSoGu8+LHddoBs/1Ij7+Pp+6LVfao3loARRV1X1vFAwxUNAqK?=
 =?us-ascii?Q?cnJ/uU6+kpyQRnzPuWPEHDNZtCZ+7SmFpJdyuLD/A3Lyikc6Wih3XEy+/Mz1?=
 =?us-ascii?Q?hk7XWlnx9WdTQggvwwppZev99E5XyLGUI6o5L2jeTye6uJqjgFh3o/g9/joX?=
 =?us-ascii?Q?e7J2dIMrH8L9UVxHzgsK+CiJuw+Dey/ZDpNp862Q3kRm6qbhEG6C5SH+7OPy?=
 =?us-ascii?Q?lgNVG+5TZAXraQ+8tX70Pg8GlX4VzL8Rw0vRjo04BoMcyIl8IpvuJc7tiRYx?=
 =?us-ascii?Q?qoTUtdawL4cJiV88nxxl5owJ7HRs+/yZJETJ9jWQUc4uKMQ99i+3RmM+LblA?=
 =?us-ascii?Q?yJUVqW5ogGWFgUW4ErwRC/6JY6e6LeKY8JBo24j1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5hBeUOlCB62juDFepc+nk3tAEQpbpUklt1F7l9bRyqdcnOkmwsnR5BNZhZIvjX00L1tWEXMuAwTike6CvdjStRhvd1zvRSoEM737K4MQgHh2zIJVLAFQ7TYGGF3p4MLoItPiUIK9nuC31acrzxA3bS3Q9yo7Y2WFFzIeUVzq6/0kYMMEdL0Z+ClWiHw+nx08ddJZZMrYfoOEmsraFLH7p/fPasa6tuOrmLdTgtjJsgZOd7pryr94VdAPtAugVpVB9QLP36/7WcPEjXTHh/Ji5ktu4Fk450pHadeEGh0/4fv0rJprdIrtBXV5OJaaduJgSgW75/h8Q5N7RhUfLANOrLaLDekY0JhGMSUZXYlRLVSieMevQwRVEs51N7hYF35Ajooyan46PsuhUgJ3F8ynak6JRIMmkVMrITkWMqudIX8xRZpDk6XDrRaU0RcCthySVkNeCc5ZNSGW2OVCggqqPE13YQlI3F9XzclYgv2VkSJTPgwglhXPlPVJYNO3nXq1KF+cCjy0wxqjQmn3QrfL5eK8yYwdSJD6aCZDnJPGVVDz3tui2d+GpLU+Dts0DWXPRyO9nWDnCM21eBBFNmVe3R1frphJreWrHlnMIFM9eec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65287e3e-f6d1-480e-b65b-08dc3e96ef82
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 11:08:36.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1b0YBrjBeQez2tMY6JmYnLENRvO3mZdEIPVhud12BfcJi+oPB5dBpKwbC8VRfOfr7limKeBgesv2+qo0ykX0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7020
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_07,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070082
X-Proofpoint-GUID: G299_Q07ydCIn6BeySA3h3bJu7gcayDU
X-Proofpoint-ORIG-GUID: G299_Q07ydCIn6BeySA3h3bJu7gcayDU

There are reports that since version 6.7 update-grub fails to find the
device of the root on systems without initrd and on a single device.

This looks like the device name changed in the output of
/proc/self/mountinfo:

6.5-rc5 working

  18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...

6.7 not working:

  17 1 0:15 / / rw,noatime - btrfs /dev/root ...

and "update-grub" shows this error:

  /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)

This looks like it's related to the device name, but grub-probe
recognizes the "/dev/root" path and tries to find the underlying device.
However there's a special case for some filesystems, for btrfs in
particular.

The generic root device detection heuristic is not done and it all
relies on reading the device infos by a btrfs specific ioctl. This ioctl
returns the device name as it was saved at the time of device scan (in
this case it's /dev/root).

The change in 6.7 for temp_fsid to allow several single device
filesystem to exist with the same fsid (and transparently generate a new
UUID at mount time) was to skip caching/registering such devices.

This also skipped mounted device. One step of scanning is to check if
the device name hasn't changed, and if yes then update the cached value.

This broke the grub-probe as it always read the device /dev/root and
couldn't find it in the system. A temporary workaround is to create a
symlink but this does not survive reboot.

The right fix is to allow updating the device path of a mounted
filesystem even if this is a single device one.

In the fix, check if the device's major:minor number matches with the
cached device. If they do, then we can allow the scan to happen so that
device_list_add() can take care of updating the device path. The file
descriptor remains unchanged.

This does not affect the temp_fsid feature, the UUID of the mounted
filesystem remains the same and the matching is based on device major:minor
which is unique per mounted filesystem.

This covers the path when the device (that exists for all mounted
devices) name changes, updating /dev/root to /dev/sdx. Any other single
device with filesystem and is not mounted is still skipped.

Note that if a system is booted and initial mount is done on the
/dev/root device, this will be the cached name of the device. Only after
the command "btrfs device scan" it will change as it triggers the
rename.

The fix was verified by users whose systems were affected.

Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
Tested-by: Alex Romosan <aromosan@gmail.com>
Tested-by: CHECK_1234543212345@protonmail.com
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v4:
I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the RFC stage.
I need this patch verified by the bug filer.
Use devt from bdev->bd_dev
Rebased on mainline kernel.org master branch

v3:
https://lore.kernel.org/linux-btrfs/e2add8d54fbbd813305ba014c11d21d297ad87d0.1709782041.git.anand.jain@oracle.com/T/#u

 fs/btrfs/volumes.c | 57 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d67785be2c77..75bfef1b973b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1301,6 +1301,47 @@ int btrfs_forget_devices(dev_t devt)
 	return ret;
 }
 
+static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
+				    const char *path, dev_t devt,
+				    bool mount_arg_dev)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Do not skip device registration for mounted devices with matching
+	 * maj:min but different paths. Booting without initrd relies on
+	 * /dev/root initially, later replaced with the actual root device.
+	 * A successful scan ensures update-grub selects the correct device.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		struct btrfs_device *device;
+
+		mutex_lock(&fs_devices->device_list_mutex);
+
+		if (!fs_devices->opened) {
+			mutex_unlock(&fs_devices->device_list_mutex);
+			continue;
+		}
+
+		list_for_each_entry(device, &fs_devices->devices, dev_list) {
+			if ((device->devt == devt) &&
+			    strcmp(device->name->str, path)) {
+				mutex_unlock(&fs_devices->device_list_mutex);
+
+				/* Do not skip registration */
+				return false;
+			}
+		}
+		mutex_unlock(&fs_devices->device_list_mutex);
+	}
+
+	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
+	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
+		return true;
+
+	return false;
+}
+
 /*
  * Look for a btrfs signature on a device. This may be called out of the mount path
  * and we are not allowed to call set_blocksize during the scan. The superblock
@@ -1357,18 +1398,14 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto error_bdev_put;
 	}
 
-	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
-	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
-		dev_t devt;
+	if (btrfs_skip_registration(disk_super, path, bdev_handle->bdev->bd_dev,
+				    mount_arg_dev)) {
+		pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
+			  path, MAJOR(bdev_handle->bdev->bd_dev),
+			  MINOR(bdev_handle->bdev->bd_dev));
 
-		ret = lookup_bdev(path, &devt);
-		if (ret)
-			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
-				   path, ret);
-		else
-			btrfs_free_stale_devices(devt, NULL);
+		btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, NULL);
 
-		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
 		device = NULL;
 		goto free_disk_super;
 	}
-- 
2.38.1


