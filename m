Return-Path: <linux-btrfs+bounces-11947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC95A49DD1
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 16:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1682E1884403
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C3A26E17F;
	Fri, 28 Feb 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QMgjprQT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O7OQFG/I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0267718FDAF;
	Fri, 28 Feb 2025 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757451; cv=fail; b=q4LcJ6lRnhPnb4oMC3aO/TDQTGl0PzBt25jVvtfUHyIDUWTiVUUilS095uSbZVH7u18+hxmsYXrAgVu8Ai3dqc1GO7R+VlRyrFy7ntCY3KKg2rdKA9ylLhgGdS3a/6M/wH6khBL5Mv4vfIfjyV0TvxgSv8C/ZUjzFC0ZkVKES7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757451; c=relaxed/simple;
	bh=yQ4o38jptIhbpQBTEkbvsmueCiGqPB1aIF8u0X4yc/k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q0GyDtow9QSiYJl/ZWiT2eH3OBKTqmbdRfp+jM71ATZdNNzjhh2SDRaG0jyVwOFpzhENO/tioXBg8zTk6XHMxU+zk0DRo9IDMROlFYzkP9Pge4+ppDHxEz+ImixVbDj1Vm5bU+YBq6vwrD1nlMSusVpgJQbDyutGSZ0XPumIrgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QMgjprQT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O7OQFG/I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SEGaU2023484;
	Fri, 28 Feb 2025 15:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=wU+Dt8JnfSK0DmHt
	eOOjgVsUejONUGUIyaenkgHxG9Q=; b=QMgjprQTkOd+/VAJLCUrHfPnDCCiCzeV
	/rUC8ctn1/9XS1ohL58X1vNyUDGhIqjrpqmx5GD7zLim4Oc1yI0di9i0rL2BfjfU
	R2zgwokFmGVE3YaGejZETxmSJdwFydUnCwSzRAy7n/GQpnxMcxdDa9Po/tLTSGRQ
	bjSvgur/h1Kdg8R2YXn2WrXn1+4akM3CDZwyoUXR+zQJKGss0x07LXUUMxdpxUnK
	B4BQ1moyqGArMCQDCcyNSZHDcRqYq1a6vEUcnJeohIhfY75sW8SifrqZ7iyBSmXa
	bLNXOkWUv+zwcHfR9VabI0P9tAWzhtJ0HunMzJKBZ90LDuURG6QRjQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psedtbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 15:44:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51SE3pbC002881;
	Fri, 28 Feb 2025 15:44:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dywtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 15:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSA9NFSpskw7weCmHSN3X49Ly3Y2x3zlq7IA55yIbbb1k72B89jpVQy3jKI8PVRFNWd1hPd5DMx7VmwOhD2y3gJ4hGGD+NvRyvXXcpO56dLBW7RG902ZmEFVN8JJqjkDnfwNmZcM9PbhdKcj1MbUMxYqHHAn97XDVdzuJIegKT2Cuy+tNtHDQKbm4Ak5/s6038H/SpZLNkBy0N6Lak9gy/Db6meew7nUMRANUK4X564dQHN61xwQi+XLL8oRSoFxVnEycyLgaw1LlyOeMlqqeobuIuHjqes5ijUheqAlEh/au9Pw4Zff8SSiUdu9fR7w2hupceYt7NtGtpQ4uUe+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU+Dt8JnfSK0DmHteOOjgVsUejONUGUIyaenkgHxG9Q=;
 b=RUQSZ8QT+v0F4/imNG4WzdUh7AHGRUE3ZjCndv7nNA2KhnWwWvJNB3e4RTQhPTxegXKq3TqG3d1iC3xmogLs0UFLQmMas3HnQbR5aeHm+1ASicLGkYrdQT2swUW9TfcQwcbncFT4SRTKFpVMnqbZZqO9mBgz50QCyI8u4PKgs/XC/zTn6U+uM7mk8Pch7GeIzZDkCTYt+QzvwV3GioWTU+IBb7hhvAIyvYoLbEbo115INhfgpB036sHapwG70YjEsQ749koocUt1rkC161sodHdkkUp3fA0ZmLUASsm3W3vRURVD8dqTJS3RnPbhOMTUi/ty4TH9uJMjeUVuRaODHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU+Dt8JnfSK0DmHteOOjgVsUejONUGUIyaenkgHxG9Q=;
 b=O7OQFG/IICSdCcnJgS/+P+MchKrGjJZqsWzDcIZxJbMsQFKgLnqT/sR74USjIcWXPfPAMO8M1+oNcsGY+Q1ThQunk5vhkwqLgVTIJahd5wYDdn6N/Td/DVSXQrfS2iQQyrOs8NF7ecyLdu6fBlqa7iLJFoYguStD5iadvhoVa2E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB7464.namprd10.prod.outlook.com (2603:10b6:610:191::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 15:44:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:44:05 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: add btrfs standard configuration
Date: Fri, 28 Feb 2025 23:43:07 +0800
Message-ID: <2223e599a760bb1a9e7b7aeb47961e970d4cccf7.1740757274.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f5b188-8a1d-466f-a113-08dd580ebafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STdFcXRmZkdMWUxHS0xOckxoVWxlcDAxemZBY0ZmWXJhZUd0c0ZqODJITkND?=
 =?utf-8?B?KzNwZ3drMUhTNi94bTUzQzUrd3VqM2xnTkRmM1pjVDhkeTI3cWh4QUZBbWV6?=
 =?utf-8?B?SG0wNlNWYkFaMlJOZFFVK0RLUDFoWjk0bkpscllkOEMvZDRzbUUrVjJxSnVo?=
 =?utf-8?B?d21LY1B3TjJORW9nYkhTQVZxK2UwZkJwaE04MW5JTlFUT2xJbytmSjRpQm5m?=
 =?utf-8?B?UGwrRVNEb2JycHlJWStTYW1DY1ovLzMvNFcrMm9CNnRMaGsraG5QL09xcEdR?=
 =?utf-8?B?YldDZ3BXV0IrejZMbUpjVVNlWXRDeG9sMUx1QlpvR3lXZlVvTDlBUU16MnEz?=
 =?utf-8?B?ZVdCUXVkc3BJMnhFRnE5Y0NCVGIrWmhNMmVnMkpld3NtSlEvQkhaQVJEQzBC?=
 =?utf-8?B?dDgwektXREl0bGRFaER0cW9BZkdHSFNEc1NNQWlxeEE3UTFIZXl5NlJPamRR?=
 =?utf-8?B?aFpvK3NROVVqRUFTaUZRVUc0SW9ZMlg3ZEE4NlBXeVlocEZMUFAwQ0ZWYWQx?=
 =?utf-8?B?b0liZUJBTUFDRkl4VnAxTHVYRTBrUFR4REMwVmM1Z0NBOFduUElqNStkem9y?=
 =?utf-8?B?TXJ5Qm42S1Z0QlhUVkJINnBUNGNNQXg4SWEwMnQzTmVVdjJ6UlBXRm1wTldk?=
 =?utf-8?B?N2hyM2kzQVBlL1pXeGZab0pOMi96dzh5TVRvaG5iSG1XcHdwdzlqMHNnWFpM?=
 =?utf-8?B?bkFFUDA1UHJBczBIQyt1T0ZQb3VlVklkaFdzWExWYlI0NWVMT1BVMDNnNFFt?=
 =?utf-8?B?OE5BNTluSlMxWlhMK2NWRVRWanFLQk1nTjRHcG5iaXJCaWR0Q1RSVGVaSFdi?=
 =?utf-8?B?dVpjT2FqLzI2OWNrd0ZKR3JpeG1XOWJwdE40MGpPektaUHJRdTRZSFppeG9z?=
 =?utf-8?B?OGVEbVEwL0w2MlJpMCsrTW1PTFgzQWNLQ0F2MGFNRmJwcTl6YkZ1VlhTR20r?=
 =?utf-8?B?MVFITGdCdTVScG9CWFBDdncwUHd0YjlJTzF3aVhrN1RDdkduTmJmWWUremUv?=
 =?utf-8?B?c211bUVWcXdiMHUzTFROWjg2WnQvREpLQWVPZWJ5dlA2Z1hzeGZtT1QzNFJ1?=
 =?utf-8?B?YStaWkcySjk2cWNSRG5UMUlkUGs5S1RZUGhWRmZFNFJQeklXRStyeDJQV0Y0?=
 =?utf-8?B?WmtTRDdoZEhFZGNxK1dneFhGeGpvUTc2OCtmd3NBclhlUHNRN0QwR09NN3d4?=
 =?utf-8?B?aGI2K2hpOEZGdjJGNXppSHZLNkdlWHRmdzRPV1JVaUs4VFNTMzdvTHhhT2ZM?=
 =?utf-8?B?T2lCb0IvM0dZb3dZaEFzaUxwcXY0Smh3OHdoVFdPOVR1YW1abzBwSDBNSDFE?=
 =?utf-8?B?a1lya0I0a2tsdmVWb2NuQ0RIZWovdmlSeEdyZGY3bWxxMFc0UDloUGk4djRa?=
 =?utf-8?B?NU5nUDlJMmpqdWoxVTQrSnlkQStybTB2VWpNTE9RcTVmbXFlSUVLTzNhaVl5?=
 =?utf-8?B?RWlreUtZbkZvZXRuNUJOZzNiNWZJMXBId2V0MU02SDVJL1ZXb2NhemY4Nll2?=
 =?utf-8?B?a2VIdzg5K3ZTbTluVTdIYmZXa3RvZ1BRdEJkODZyMXpLZ0JIUjA0bDRZUmVt?=
 =?utf-8?B?WDZ4c1pWaE55Rm1hR0lrelBkYzd0UUV1OHVmT2N4QVJXcjZIZk5ZOVJhNmQy?=
 =?utf-8?B?ejhHK2w1S2lZYlN3RThsOUxFbnhNZEx5dm5BNkFKL1ZVRHZqZjZBTHFlWW50?=
 =?utf-8?B?TC9MYUtSRkU2UVlZNTI5TUlyTWxiaFh6K2RNRVdGRTFjTWJFMmNaN3ZsNFli?=
 =?utf-8?B?MFhjN2lLbDdlV29mZ2VJMlI3Vk5MMWRucmNaNkh1dGFXMGdGaFRmK3o0R056?=
 =?utf-8?B?RmE1U2VMd2ZEb3BjaG1XMnlIaE1XUXU0OTJ5TG1lME1hbkxkSHp3bWxFQU8w?=
 =?utf-8?Q?V6bNh8WGoBm8i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDFPUjdPRnVYQ3RqaERPZjNkUlVGekM5Q3Y4Y2d3UTRiUXFMY3ZEL0FjSlVk?=
 =?utf-8?B?YUVuU2NlODhvejdpY243SkphRFE5K05JaEplUllLOTJXMEl6dlhtbXBLVUZw?=
 =?utf-8?B?andCVU1ZVXU3SGlUWEMwT3pkUnd2eFpGdjArYW5PMlVzU0hVclRoQUpXck5T?=
 =?utf-8?B?aDEwUU1aYUhKRFNDOERLTktiUWtIV2tQUFZtRDFZTHU2KzlPOWRDZjFvK2Z5?=
 =?utf-8?B?V1F0bWFSMnVyRzRneS9Cam1IMHk1M3c1OXo2SU1sdHZ3elNOcU9TTFhDUDhS?=
 =?utf-8?B?blBxUStvUkdZRTh1ZkhwU1FFby9mQU8vMVNKdmJHazFWVTloNVhHVTRyU0FN?=
 =?utf-8?B?YTlQbi9aZEdrVXBvNzVPZTJTcEFIV3BuK21ybWF6SjVmMXl2bGNwV2ViaVI3?=
 =?utf-8?B?bDJHU2M2VnBOajZoUDZ3bXpWeWlVdWhkdzArZnRZMGtOcE9BQ1pkS1ZsbXFi?=
 =?utf-8?B?ZUJGN0hua2lNUjQvbU4rVjlyc1gwZGtVTVNVV25Kb3hxU3RveWJKN0FiNi9D?=
 =?utf-8?B?dFZEcFFjNk5ybjlFWlBNaU51aEV5ZjdnTDlVVzdlMmNuMkZsd2E3U0d5Qy82?=
 =?utf-8?B?ZElIU0pFcUhpVWZjS2JGSy9lUGc2U1JOdVIyYUcxd3pVcjBOa0lDc1VZZ1Rq?=
 =?utf-8?B?Z1IyTU1xTUNQZ0c5U3VqY092ZDBkTjlQcnV0V1NhUHJJbkJBdkozQTlhemE2?=
 =?utf-8?B?aXl3ajFjTWErQTQySkFJWlJBcFVnbGNPTDZvMDVocEN0NHdTSnk0R3R5bHox?=
 =?utf-8?B?ZVdPWXB5VWlWVUFwK2l4WnVSOHNENEt4eWdFTmNQdVNERVVkQ1lZWm1HdE91?=
 =?utf-8?B?Z0RjdFJ4d0xTSkRMWlVGb0VJQUVUb2swZUdWNGVianhwa1pVaTBLWUVWUzJa?=
 =?utf-8?B?eUUzK0s0c1I2YVh0NTZFU3diUG5oeHZaV01zdEs2UVBocU54cVhkYzZOZXFv?=
 =?utf-8?B?WTlkT29WMTRZdGVzMGZ3eGh5RXFPRGpZRjg0KzJUbmphQllSUm5uYUVFZFFY?=
 =?utf-8?B?V25zREhvQWxjdkNHY0g5VDc2SXhCTm1GVU9uU0xQQW5yNUt5NUVGVmhuNkVm?=
 =?utf-8?B?MWNiRUs5V2M5ZGN1blQ0V1Y1OG9WL3A4OHJoRWk4ZElra3FxU3dwdjkxaUdw?=
 =?utf-8?B?ZkNFalE2dmNtcFFuelh3L3hFSVlIZWFTdVdCRmJLRnZNbmVub3VjSlhhVTE4?=
 =?utf-8?B?UGF6TWhGWWZUaXVISFlFYXJtYUk3UVRIY1JwV3lBQnM1dGxwaWFCSHdoZjJ4?=
 =?utf-8?B?MEl0NFJ6dDNGYWY0ZG5pVjJSVU9xRWRlWGJCVnJuSFhYSkE4cFFQY3FRZG1J?=
 =?utf-8?B?d2RBaVE1aktHNUN3VjhnVENndGk0UjM3QnFnK2E1SDJrOXUzNVk0YWVUMzVo?=
 =?utf-8?B?RTZWRCtDakNDeUc0NkE5YU5GVTVWa3NVVmxtTlNhTVh6MVB4VS9VdUVmY01h?=
 =?utf-8?B?TDVSak9vbVhCa1VpSmF0Nno5ZXQ5aW9ta0NkZ3k0K2VwNWp5Vk9UODJUOUFO?=
 =?utf-8?B?eHFXREtDZG1EbXREbkNPVnlGRHpjZlBHcXVESEhYanVicGZRRUNDU3B3bVlt?=
 =?utf-8?B?YTd1WTFWemNVanpBMjNoYVBLQ0tIK1d5ZEc3Qit1T0crZ05ranVIS3I0N2wr?=
 =?utf-8?B?bEZlVGdhWjJ1VnAvbXU1TStvSGpvUTJLWmFWdEJJOVZucmlHSnZkNXVpamJi?=
 =?utf-8?B?eTFZaTBNRndCMmNJcVdrSUUvd0UxWFVoWTZ3STB3ZGJjeW95cTB3bmQ5NE0v?=
 =?utf-8?B?Q1NGV090UThXVmNraHlwNFA2U1ZOT01kT2dSKytjb1k2V3B5ajR4UXJ4d1ph?=
 =?utf-8?B?TDBZSVR4bnBvczVyZW5venJ3eFBpRXVvcHB0QSs2OE9ZVkNwSWVySk1nSTQy?=
 =?utf-8?B?Sy9CS2lEcFNKNHJWTm5rSXBmT3FXeHk0ZFRaNlg2YS9WLy8yUFlLa09USTh0?=
 =?utf-8?B?MFhwMTdoNnNqRlc0V0owc1JmVFNvTGZ4UXkySVZ3UmRsd1Z0c3N6U3duOSt5?=
 =?utf-8?B?RkJiWHlXM1FqU2pDRXVIVnMzNGMrNGRWekxobDNOLzQyMWNZQ0xkZW5FMHJn?=
 =?utf-8?B?QUdmZ3NOSnFmVlZNbGpCRVV2R0hkclE2VzVqd1VwK2lKeXFvNXltTnpKWE4w?=
 =?utf-8?Q?P37Y2I3RtLSeSoK2EUT3qUuUk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MJBPAtWC/WOmuJhs0BMEsQx7eeKY+gw3ngmFGQ3P0+Xps+0qx4KKdP5YpDQICDJdCqzkINJ+p07w2B1Ho33zl3/4UFbeHaZak2YNwsANuYCAHJMMRqIBtjjvoAfffxyIgbsAlrmS0OIqb3KWddsI7Ck+ZcTzjd3gIpRqZbgvCDbkhcaMzraDKD7JXA32HYS18+/WDgHbERx/mNmrXRC3VOvRlI0uqh5r33BkzKRHA3PLyWX+lpQVe817ZdPvDPlRonPHSfuZLyd/LE8HOnebjoXNO02ceOqqoeGEe6F2CQMBoAYr8pfyxPLkFYal95oCdYjEfz9J7leQz2VDimxjUr417o/YCfL3EiGQ+UPcrqAN4Z9JnMHgwcjsyN7gA+1m1Aitv+HEuMGtOfu5KMDnr473MUL+U1DEtB2QGvb5beD1FFdTQQm4Q0Yd7kqktrv7VOHJJr4Z7Oar2xnJzIZWSjEmQ0OqbucIMSwhfx91RkzWqDRubjWGo+kJ+UMEF87kvS6bU75JOWPoqqBNgwZAOixo/KGQSabp3hxTwgYjfFoyVBrmy7EluNqqs8Tmnho1YDeLts9ORJzxMh9swCfTvFg5qfNM2FnpcaV+uX3zvkg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f5b188-8a1d-466f-a113-08dd580ebafa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:44:04.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCVZ454qFPKQKMvCYl0KZrjzdOjLNiiQ3JIZ5ZBozSQFL5OlbBCZRzOg9VM6SW7AajXabzuE4/CgID/QNADUrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280115
X-Proofpoint-GUID: aQZX1RtcEaPQ912IxhNj0vGOmeN57x3U
X-Proofpoint-ORIG-GUID: aQZX1RtcEaPQ912IxhNj0vGOmeN57x3U

Here’s a typical configuration for quick, regular checks.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 .gitignore               |  2 ++
 configs/btrfs_std.config | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 configs/btrfs_std.config

diff --git a/.gitignore b/.gitignore
index 4fd817243dca..bcfbacb1f86a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -44,6 +44,8 @@ tags
 
 # custom config files
 /configs/*.config
+# Do not ignore the std config
+!/configs/btrfs_std.config
 
 # ltp/ binaries
 /ltp/aio-stress
diff --git a/configs/btrfs_std.config b/configs/btrfs_std.config
new file mode 100644
index 000000000000..d66a8ee93f44
--- /dev/null
+++ b/configs/btrfs_std.config
@@ -0,0 +1,39 @@
+[global]
+# Modify as required
+TEST_DIR=/mnt/test
+TEST_DEV=/dev/sda
+SCRATCH_MNT=/mnt/scratch
+SCRATCH_DEV_POOL="/dev/sdb /dev/sdc /dev/sdd /dev/sde"
+LOGWRITES_DEV=/dev/sdf
+MKFS_OPTIONS="--nodiscard"
+
+[btrfs_compress]
+MOUNT_OPTIONS="-o compress"
+
+[btrfs_holes_spacecache]
+MKFS_OPTIONS="--nodiscard -O ^no-holes,^free-space-tree"
+MOUNT_OPTIONS=" "
+
+[btrfs_holes_spacecache_compress]
+MKFS_OPTIONS="--nodiscard -O ^no-holes,^free-space-tree"
+MOUNT_OPTIONS="-o compress"
+
+[btrfs_block_group_tree]
+MKFS_OPTIONS="--nodiscard -O block-group-tree"
+MOUNT_OPTIONS=" "
+
+[btrfs_raid_stripe_tree]
+MKFS_OPTIONS="--nodiscard -O raid-stripe-tree"
+MOUNT_OPTIONS=" "
+
+[btrfs_squota]
+MKFS_OPTIONS="--nodiscard -O squota"
+MOUNT_OPTIONS=" "
+
+[btrfs_subpage_normal]
+MKFS_OPTIONS="--nodiscard --nodesize 4k --sectorsize 4k"
+MOUNT_OPTIONS=" "
+
+[btrfs_subpage_compress]
+MKFS_OPTIONS="--nodiscard --nodesize 4k --sectorsize 4k"
+MOUNT_OPTIONS="-o compress"
-- 
2.47.0


