Return-Path: <linux-btrfs+bounces-3084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1850875C7C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 03:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E123B22C4A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 02:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0F928E17;
	Fri,  8 Mar 2024 02:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q7TsLwun";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EO2j1sbR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7171922F1E;
	Fri,  8 Mar 2024 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709866045; cv=fail; b=TrvEX4Lwh1gEoIdQbanEGpNvZ/YYDkJ0BuHG7B5mRAhHdMTE/WZJXNyRPQqj0/idh4wwSC0Y3FwfnR012RMzRdfElQsJ0HgoCPVCcGHRa51hxmj6ADrcHbP6z164SGyHBuncT9W1VgYm1pCSD6Ye1yJvnvwlbpJqez7fh1898L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709866045; c=relaxed/simple;
	bh=/LWQydewJIADno1exfk0OFSWPYva+DcrFQByI+5vE0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LIc+3NiNTwW+BYbgIB4XLlHK+t3HpDmljeH88Jz/UP240BMewGRD69FGaMEQNSlSQNMtMHWXfj1EBek8V84WGqvhmtzXNFoA734BU2gRRVZJVXogSUj3kgCRthMWFItdqKaQ788kZPbIW/WPFL3PCveyDfhs/sMmgg2KXB5dFWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q7TsLwun; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EO2j1sbR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4281iJ4i019928;
	Fri, 8 Mar 2024 02:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=R3PVBIAux8MTABMox4QWz0iKyPZ4dD7DWEKJghbhDCs=;
 b=Q7TsLwunF+zn1FHybOLsprCxQM7Mf1g+/E+OnV4soGJvNaI0/dY/q4cM0pSaTCxsbmTB
 y73+KuI3vfxWUh/pJu2GONzrWufSOlIiJDmvn0dF3hp+hzm/3Q5gsJFOI/f+lSagojV5
 ZTxfMqd+q/luffEpy10xiKxhtwaZdI9gI6zJrOOqI1MdS47r88BpsbXK/NvcX0Nmvka1
 NM+gsA2RK7hBl7r5Nht+asztXCexrOeQmLSydYZGNPghhPicdJvwXMzT8O8YVYp7kPlo
 rMnokLhBsKVtbccaKr5k2Jsc/5TYkKVAKt1ARIYVc0ZbFCAEx4aMY5arBSSsDLmyd0if aA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv0bms4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 02:47:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4282e0wf016023;
	Fri, 8 Mar 2024 02:47:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjc58fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 02:47:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WF0Nlt46/WLRdsmX/rugM7RNHtG6ZGEDAn94u3Yp+c1vRM8W5ITwhMbQLxuZi5eQ7mcyhJr8qj1cY/aOjzqMcglD/rPlEFJEa3Eu2P5YMGJyvz76GMHPUimC5ctk/KQnnaaOpW2ZsOLz4S0sUjSJYmv0cKTd+7F4QaQlJuSTOy2ugh/yfH56OnNZQuHmxnkA9THnEXnMj7gwBvgljKcFE0JoTeZrWOijsu9YyySTS9d9CbjLKa+Z5tmFqI6oFBPY3s86klmL6bokxxAhIMIP7jPtDoe0w2HSbR/3dxOxzWfa4uvHgFaDHXFNHkEefqCMCi9zT4J213ekZkjevAEZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3PVBIAux8MTABMox4QWz0iKyPZ4dD7DWEKJghbhDCs=;
 b=hHXiCM5vb3Y3gfQ2kw1/J5QADUU0DNkHGl5Or+BoW3HfUq/YlN00yGcJeKrHE3lMgYHnM8BVbz3UUzxiwyeaYPvBPe8Maxrwrq7G4xWlYn2H+BgH1c47HagUrkjzKiFAtnVzSoitAsBSg4bWxH1Y8CXH0vRTee/yabfNHYeBrywZWxkJovR6lXYnNTGkpm0ulTI/uGLgQWXUU+jjXRPavYIjAbjLNnpeGXaquNVQACD6iAguF8CmWZKlBmID6zbvoKfas5w4WcWeHF4dNBA/7Mh2vbLPmzTE/eenfqUse2EtfCB7AViErBiF8a8/Z328GWD8FWwvhXSG1fGNj+Ajhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3PVBIAux8MTABMox4QWz0iKyPZ4dD7DWEKJghbhDCs=;
 b=EO2j1sbRHmqFWun8b+NUI8B5E7TkJi+LKq4Wf+UfFcfDIlkBFhdsXh8uhqgGZYSfx3VpxWx+AZsHD4Mop4EaxCcq4Gfmia6+W2gdzHh9Ky/u4x1dLJ1cMwllJ7KIAyTTBUjDBu1j/xmiCuFCyUZkezx150yoXBRNU3SITsDehqo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6405.namprd10.prod.outlook.com (2603:10b6:806:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 02:47:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 02:47:14 +0000
From: Anand Jain <anand.jain@oracle.com>
To: boris@bur.io, dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v2] btrfs: validate device maj:min during open
Date: Fri,  8 Mar 2024 08:15:07 +0530
Message-ID: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c36fdf4-e12a-493d-0c26-08dc3f1a0f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	N7HzqLZnTjets76zEiqGWI9H3t0Oa//9H4Vd0QkEF/MQewOtyck/wEzjanv7Bb43CPq5Zq+9Ou2T8mz+03cgVH2jDgUqx+6MrStv/567Uzlk6q42f7ePhclmQXSVHWe5cuchtB0HfptjNqhVfDTAfPp7CpuKAATJblxxgo9sZK/SAd8nOeixle4mtJ1yeO/JjNx8Hmhw6eAIeCgS3elfEZNehojnDy8Aa+zslKzOXHxkdzm1ta0wbXsH8gNuj3byHLUM+IluilM08MCTHk43im+5g/e8gp4FOHtaV1AjOdzo+qJJddd1j1xfQg5n+WTq1wfOk298JU27gwaEEwB6H8FOwO/p9UOL7H3Gynj8GLoFiJjHSy9je0D/QxkYTJ0+ezc9iVfcXZUN9/yodmEjUqEaiVSLljQBLJTgCczvK4XrQu3nI6+JndF/4qufkK8AbbufMV9mPuuH5If1P/pscaOgw/k2b1/pE+nAMsXnrW1VeiPpDnmafFsSuJxQCCTqpFgZ5+SKujSsb5iBRjkqjn51OUMdhdQ8ShWxEWOJ4aAp5O2Haypm/r6jWVHCeVc1AY18i1ABAXxfxT47LY8BgrFgiSoh738ARsjXUDlLJUY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UXbbFm5S8KyqSDioESA8OK2GPzKqDlAOK6FfhssK/Gg+S/DqY8qvBjwt9QMj?=
 =?us-ascii?Q?mX2SMDP0VlWf+E3DYlzVmJTKxPuIjQIqRsU3iCHAw4ncemPyoZtDSS8qfyLC?=
 =?us-ascii?Q?+z993Rn0cMz8eA8c89UxNuWOFjfrkQFZKOeGBnlqwxhDRe43nuITwZK/PFOx?=
 =?us-ascii?Q?VNda4szmg4bdfNdl8EjLWAaq2G/Eq8DW2lAxkuu4SN6T5CElkEQmhesy7f/G?=
 =?us-ascii?Q?XAnuLXTNRzuET/LCL4CgmqoKD3SaU7lOX1TCv5wZzVYc2oqnl31BMP/4IOzm?=
 =?us-ascii?Q?ljv95seWJRuddwAXGjmnyFtyKOFD1ankk/Jq+zrJtH/y1Hi76mT4pX2vl1Zh?=
 =?us-ascii?Q?ipE8hoQcyBXhCHe6U5xJV+Q0G9Mf7Eow5tDXQGd7cIuzo11mZ3RiEtiIxmXN?=
 =?us-ascii?Q?HSj//J4/OYNyYlfjscqmBFjTzIaKNYwvyVNnAwZC/ZAtjotR2ku+T3c5+fqi?=
 =?us-ascii?Q?IqEhydZSL3U4RncXDTTxKsO3BuOED9cjNEHR+pVw6pzu9dyC7mX0WldC8MBl?=
 =?us-ascii?Q?zCxnlkfAyRhF8yiA22MwNdjXsrdv4Nw72mUi7Dc+P5v0ZcvMX8sEUyZj7bdK?=
 =?us-ascii?Q?C7LxnlOjsahXuCAjwJgr7dFQXr1/R4dwwnsnWVqFMyvId6/wg394UsggRnMi?=
 =?us-ascii?Q?OiUSTrdUSvYRQPCGrvIC5pve2EYIWoI/HkQQd05CNSdqBQl0TzzGF1eHWrTZ?=
 =?us-ascii?Q?aoLN6CpTDd9KyTYg8qVvlXFbL8DHuN3x1b3uVpnupqheOJzN0oDYGWVszZ32?=
 =?us-ascii?Q?jehjBe2S9eNR9ooD8hRZbmXeagmEc5GXKclR/xthu+YL9qUYHqdVxidA7IXY?=
 =?us-ascii?Q?Map3I74C7mRrK+s8t6Q1ha8SmVGxJWzhCTm0RNtw5V2wtMG3nOHpqkjMlc6g?=
 =?us-ascii?Q?mGN61OX6Nzn660W0jt5N0mUkEFIuufynzI/uggVtf51LvhtfSSTAmgUx2DHX?=
 =?us-ascii?Q?FkrQgPCDYC3CCz8RzIM0cAw5/dKGQaHu7sfqaqhpORWbOtMcFAWcb0CQTnHB?=
 =?us-ascii?Q?IlBYIQbQC9VLel1TwPX2gC0zt7nLRmAJ9T2BE2i+/TGMsDu6TlVKDHdGxDZY?=
 =?us-ascii?Q?zuM3EmiLoWy/6a6YMa4d0zPkLXuvLyadY1Uy0b9JvWqtQsQixk8th9BHj+gZ?=
 =?us-ascii?Q?OtX2KBD72AGNAaasye4CXetouJShLvZr85pSFixj0m3xHBlA8+xfoM7se2YN?=
 =?us-ascii?Q?nKU9CPwxYXCk47p8VKZPFYG/Pt9+abkXoOuc8DO4H6ys2Ulv5xlnQDwsctxT?=
 =?us-ascii?Q?RpDLoCrR41GRuEzW8ltv7kMZ3A5AgOnMWJsDTwgpXOdUpn3le4jnE1X1McQv?=
 =?us-ascii?Q?VgadNYnttGrYA0nAOl3tK2qGhbf42HNUcdsDCXU3zjpuJIM+GyIdmPeDvkQZ?=
 =?us-ascii?Q?eDQhgaQABuNDC/jg90bunPcO+CLvykgL+BfnvOlhr9k+mPCcfYUQd1NxRmZW?=
 =?us-ascii?Q?kI16e6NS+EuVR7U+KXmwBieQczTA7ma2oIyHz/jXtKE1YxSbltlh7llRfuno?=
 =?us-ascii?Q?XW/iLxY1aJJ5rbiCIxbsOGdXU+aMznNmTw64kpAeqj+7I1FxoXrJhDc2+7bJ?=
 =?us-ascii?Q?+JCDOJxY+9wOCks0Dy/V2SpNX1BWyS9BPizBuu20?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9Uw0fhuVsG1aphWstGjflOJnw0zpvaKDX8p4M9egFomgzggAw4GJNFbSZW+KGO4fNQX2cDg5l/qWRxD5C/v+n8ssiXzDlBvCVfNqS2UKqqDjg2odor0Gsn5/v9maQ3jKoG2sXsFVO56sv991iixP6fZc7sNT0UHZ69cWod3A3pVPJC3UGeOFM+gDNdbZVCU6k0bpHHHe8SL5S5DhrINt7dIlT5KFKh6Jx94F1s6y7NVjDWhJGGY2kLYyFPXwsrS2VQmD05EYEfd1Sr9VCFQ6DmJA6iaCqoComuY/xWRsFcJoabn+sKSFs5/mxV8tr4FrdBg49ZGme9gMbCt2dfnCyN50WBDb6adMGLVv8cJQNdTeF3Z8Yx49ozbDjDyKMkPHb730H+sNUyeR7EnVOMNjKt7/69V5FWEUo3bt3IVJgsCk70I8TDK8HvS3edDrbrx5XXCcAH/WRPifhp+24Ht1tf0FZEn4ZVeWyJSKuXNY27k8wm68XWLPmwsHPbjG3iE4mBZUNCO6kZie8/rJurX9T2LOa/LA4I+YoKS2zTPG/ijpuXz+6u7ya5Rn6Ak1NKFiJ5QVGv513dBtUc3pVaGWYEm5qfwSfS0ZDEZG3pcH2XU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c36fdf4-e12a-493d-0c26-08dc3f1a0f7f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 02:47:14.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iy1mUF7bZv2K34+YZ7yauKplhnocMTPbtjbQMluF6Dpf4cK7siXLta9XGgWxwgsXTISHrgOVUBatBJ9LzVtqmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6405
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080022
X-Proofpoint-ORIG-GUID: CnS2Ep2R4UQsDhjYfm1kwdVE0qOdT0gH
X-Proofpoint-GUID: CnS2Ep2R4UQsDhjYfm1kwdVE0qOdT0gH

Boris managed to create a device capable of changing its maj:min without
altering its device path.

Only multi-devices can be scanned. A device that gets scanned and remains
in the Btrfs kernel cache might end up with an incorrect maj:min.

Despite the tempfsid feature patch did not introduce this bug, it could
lead to issues if the above multi-device is converted to a single device
with a stale maj:min. Subsequently, attempting to mount the same device
with the correct maj:min might mistake it for another device with the same
fsid, potentially resulting in wrongly auto-enabling the tempfsid feature.

To address this, this patch validates the device's maj:min at the time of
device open and updates it if it has changed since the last scan.

CC: stable@vger.kernel.org # 6.7+
Fixes: a5b8a5f9f835 ("btrfs: support cloned-device mount capability")
Reported-by: Boris Burkov <boris@bur.io>
Co-developed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
Drop using lookup_bdev() instead, get it from device->bdev->bd_dev.

v1:
https://lore.kernel.org/linux-btrfs/752b8526be21d984e0ee58c7f66d312664ff5ac5.1709256891.git.anand.jain@oracle.com/

 fs/btrfs/volumes.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e49935a54da0..c318640b4472 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -692,6 +692,16 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	device->bdev = bdev_handle->bdev;
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 
+	if (device->devt != device->bdev->bd_dev) {
+		btrfs_warn(NULL,
+			   "device %s maj:min changed from %d:%d to %d:%d",
+			   device->name->str, MAJOR(device->devt),
+			   MINOR(device->devt), MAJOR(device->bdev->bd_dev),
+			   MINOR(device->bdev->bd_dev));
+
+		device->devt = device->bdev->bd_dev;
+	}
+
 	fs_devices->open_devices++;
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
-- 
2.38.1


