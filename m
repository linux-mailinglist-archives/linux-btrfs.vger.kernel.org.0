Return-Path: <linux-btrfs+bounces-3951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B772899852
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 10:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68131F21D15
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 08:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8923D15FA94;
	Fri,  5 Apr 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B3/9h7Pm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f1UU8AHj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DE414262B;
	Fri,  5 Apr 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306737; cv=fail; b=DLsH0ypMDrwa8yA6oidCBHti6J586sO242cRdEWL9R4snkrc8HUjWr1KuvXa8IIAQdc48ZIOBKK6a3zPNWBJsWzIBnAwXznUuwwZjU+NCwvnp/3lEnil92z0oAGTXjoeLeAwpSGo0cwI9wwOXSd6J2zgKVqb01CKMBEnzLa3QX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306737; c=relaxed/simple;
	bh=zSM0DcoxXwRQj+7bZcVXKtzA9WkNPJXcczHw2RuBHtM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EtrbSa5Q+FZOS457gu5HZXQFykL25S+zkFwluGX7NYs/eoBiqV9iwY9VFpvEG6IxPjhZmQkpDm4XHIFRRU682n5KO6cwFFqQx5IVLrVB0Y7J11s7f4aKZaNLQdFm69I32bMFVS/OpHyttC/w1pm9ZViKjhrkTFpJ+PVuORoI8Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B3/9h7Pm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f1UU8AHj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4358YUf5018829;
	Fri, 5 Apr 2024 08:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=kqFn64vX75cfwhaVFnjJKzPypCTLmidv5RszlFgy6nc=;
 b=B3/9h7Pms8lRgtQDs4NUooSSy1H5NpAJJOgh6XK6DySKl1N3xzPrf8sqA+k6hZGh+25I
 n8925bFyiylCTTt8NwU9UYtPdwjsCH5ceXmK+xr/4q2NLb/4Bo0plxV+jYrgSY3qRBVp
 Ab5BC3ei9VVuh5FWtZ1dwI9EFgBSIsJR5KWmXvjSdH6KgGivvRi9Jgjsi8lI0n8es726
 FPHbcD8Qaab9ZRrS6e82WjmPd8w4XVzYpQdeTeAgWbjtQ0ppSl5aA9UzZ4+n427/slcz
 44ompLwiDuIwiTcMn2k826zPWswBq4Njc35ZAlzdqzYvpCoG7QFc0vea/9PzpnQwtW7H DQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9evyu250-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 08:45:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435706CG031506;
	Fri, 5 Apr 2024 08:45:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emxu8gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 08:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVDHlVm5xfOUBDTNy7lCgCw0uxzAXKbcmpexNMqUvae24+qqCo39kkz44Uo8cQE7o0GEkFa2rdS8SoW50uYNTTwy2trS5NiPaEPQKE+VTsWL+tlS0X6j79ogozQdYLpfReVK5XYeJDFpvLn3MWRK6RJvajhw3luZO5BsGFVGNfIq3UuyK6e53XoaKIh7Ru12K4X7x5hBoVNnzdYmsx8H+45wT+TGD2JNsVL31xrzY209tEK6XS1Fp8D8Oqko91xrFTf19txTCuI6/ik+RzaRr9XN1epwwVOspJ5j2xLjrBrU0Lw6WkSD7RwBEg8ZMHQdwkmeocwn2c4XuWmBmIVCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqFn64vX75cfwhaVFnjJKzPypCTLmidv5RszlFgy6nc=;
 b=iFRYNoV1lgL53LDMmliG9yXYnWT3Fc71rif0FYCU31k4wuMxMjCf+q5EmlJm7i193myHM5KPdgCk4jR0kkDij8z89QdYs++f3FYO9f/aRM7boSp0hPglALh/MlWMj1Nxg6YavocPu6mJVzug36UbSgX7sASm54EtfwyuuNslFsRNYQioCTn23tmu582fY821WbV9KwxyKKSJ7emYQ0qU6uO7kb9HiM2WiWIvT+TeS7DZXwKqGrzPCtTObx67aibyes5G+qvPyT0quG4GpbG9ncXvdnES1oz/rnGKar03kgp7RNJ1o/whshhX4uW9kUF6hNlyZJBMAmgfNdqYlj4ecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqFn64vX75cfwhaVFnjJKzPypCTLmidv5RszlFgy6nc=;
 b=f1UU8AHjtUsqx4u/sxrtIfUDCLM5dFCq7x/y/eXoaYmaQYAAlkgDPRGbzBhLvNLj85xRn8oGC1h9SDL+ZNJ1gCaSoahEC49DVMEniW0tIe34/maEHXBo+1djprr8LNow6ozka7hdLQHnDe+0TK2A0SUKuFTE1Jmucd+v1+bQ6S8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7323.namprd10.prod.outlook.com (2603:10b6:8:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 5 Apr 2024 08:45:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 08:45:17 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.cz
Subject: [PATCH 0/2] fstests: btrfs: subvolume snapshot fix golden output
Date: Fri,  5 Apr 2024 16:45:01 +0800
Message-ID: <cover.1712306454.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7323:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7AkQoXJdvTTEMl6rqB7xPbxDt/pcSr8o6DqLRwB0kCSMSKbrAf+I6At/sFZ55rdmjcasSb6edErjdLqscnZHZ2CaN76iq0YJBxK0EgP8rxCP8FEQM2qEgCZq/EKjecSGzzIJDKBWXsuDKWhJVUazedp6VO7FOV7OC6AECPg+u+6GPsg6uYZ2vIjGgMk5P1n8WLH1LCe+Cj5zxh8nxtQA6FwvpqcTYxWMBb9rZE5ArnxXZnPz1+h2e503pSvrAdf0OeHQ7auIhvy3KSHI9EYwxlHRog6Wy2tWprp05MNAjH6sRHuG2Etb2fdM1ktb5Ue7DPwwIBhTXEh3hjUbfjzzzuXt6yh1EBx1eUXw0UH7wmBeMtvu3YJoI98R+k85aCbs7clUmgBHEUmfWLu6EC//SeYnwlOdcAsTK97ji1xU8Iv6B+T+YkQzX3j+tm9Sd/9s3IWMqxg23bhVuAwwJykesnRk3DwMe13lfTm2R1Xnr/tmPZjjOM8QmQl2T3c3uYtSfsApv4DIDp89Y3ANrjyvrQCMISLar2d7ZvGrzaPlbKxy0brfXHFHBiObbH/T5q42Bdcrh20JD/k1ck1khr2lrLSn8ng8sN73Y8WRd2yUm/QBvraNBHZlF+rOAa3lzh/FObfypluaPGtVwUVjEn8A2fZSbIR+rHtVFtxIB3GSsjg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JIc1cqNdicrTqH64wIr6V665mhOwygdsIJh8Dn+6IUS6YjjRCiWXqYIK236G?=
 =?us-ascii?Q?+UrtPm/PSdQwNt9b7JXxKZ7sdnUDs57hYTTAsg631CfG80UXZ28NVSJ50a92?=
 =?us-ascii?Q?m+CfBVNss1XMzL4Ibc9bfnVUGNQ9NFfsgB6kUAXWZQk6qBP3aYlaO+NGf+m7?=
 =?us-ascii?Q?81pNXZmuyEuLYEtXKhzp5qbfdcTC5SrA0D1RYcM9w8FUav9y21cpDqIjjFrw?=
 =?us-ascii?Q?wBZs0BnzAfDxkK+UlALEBF2CkPiyXUf/qza/O1KvlFFohXehCRlQx+vuUrxI?=
 =?us-ascii?Q?vFUytYn3btibZgq5eJmUXkzjpn3YVfZ8KLnM8eJLA09Q6bOnmBdEln7/C/YZ?=
 =?us-ascii?Q?cXrEORBLAArLnLEGDCuiKjGXGCurbdt6ls883ip4hJVF1ZyjboLqACQZPb3c?=
 =?us-ascii?Q?NOBGs2C2cH1jzaPiFR7ysZDp7bA5rlJYSm1zJfuWoAL8xqcIhy2drNgUuCfh?=
 =?us-ascii?Q?9qXIse4xlaAESWJ3IEcD96onyDzzf5a6mms+yK0q+VMRIl5kdIB2bQDgo2vw?=
 =?us-ascii?Q?hb2gjRcjNYJ59QdS6kEqPCQZ9jROFU/XjRTzG5nEgYWqw9dyhGg7Gfi3V+Q9?=
 =?us-ascii?Q?kXsjQ81Tg3/Ddwi6MZioMmwQaYYNdAkOVIrVca9Vq5VN/A9sYnHTe4cJjc8C?=
 =?us-ascii?Q?GCuo9x+8S82vp6bT4kHlF2YGGxH0qV7cmLonY1A7t72/o0NgH/8dw4oDMPAg?=
 =?us-ascii?Q?4RTcMHoCjtImEn1qnySXHedBBDmoMH2T+2MMMS+sfwxy6jSvlSINT9t4PnYE?=
 =?us-ascii?Q?P80asr/R9Qg0gkd+3uZYjnxxLsTFpO7sY71HT6joTigoJ+SBd6dgzzex2JDL?=
 =?us-ascii?Q?tv5qyxP+5EJbmlrbPoXd3Q4cWttWOriDUD86KlJS1vvuZvxzCLO8EEHmIrjD?=
 =?us-ascii?Q?jQLNH7heO9mGmau93MTU6yhXpqMliYkb+JbxF/JbKjo/pm+/KvjK2ow/T2sh?=
 =?us-ascii?Q?+0ZewY2UsFCkdgaoetoOXszUZUzIiUOotkRq5b3Nn1uk3vGSl6ZYnaXK7uOS?=
 =?us-ascii?Q?oS6jAHj/m/drPMvCE7rCaMUicO8MFmYnzpetyBQBXVYO1Rj9UVzD1lFWMemc?=
 =?us-ascii?Q?mUWy1Z67hfZkFdtJy3zvoqx0li9mFg4pTYyJzzLUUg++xnNBboz1GtLU2343?=
 =?us-ascii?Q?wGZGRqmMcnTzmNobNeP5n8gkrN2c3VGwPAW8WBO6rgW/X9qpFNrRSMHOJYeq?=
 =?us-ascii?Q?1lf7pdE+1qcZ3TN+VRjLR36VDCKwQBolidPw5T3KI2Me2sfIEf+oGexD+P1k?=
 =?us-ascii?Q?Ua5fVMBpa1Hm6inBRWNHkUn0hN7V2ICY26W+EjID5DgUXFdemQOsDa7CocYL?=
 =?us-ascii?Q?0wmwm1hHmFS5sShzfrwEcveFJUM4fF+lZBwdh/rkbi/ePMCV5kHp3VnbdNkp?=
 =?us-ascii?Q?Qk+OSr6ezRb5cdvksznvCVA+e+grD8SUPdbmLqEJXZx0JyWhAjQhqK2eIWYx?=
 =?us-ascii?Q?VY9l81sddrGA/likvUCwTnAC0b8ReY37sLzGkizs386QNOxNzrWBIpeUxuvn?=
 =?us-ascii?Q?IOq4d5wRmUn7SDjBRqQNlVjoFqyaLzm4Lq0ACLEhsVy93Fpecyak7a2ho3Qz?=
 =?us-ascii?Q?UpVJ8/Q0CY41OjOAi2D+LeiTG7xbMDT8Vm/8frmkM6x7poddqXPqeXv2xa8K?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HUsz0NMCbo285mc8JfwTMt0XJNKTGiGNHQ1domK5yv0FnLi6ly7Px9zpp2h6HTBEK/rGFGUpOnLTG0b0kjkVVZd+HaqMrnNhq3chRGANX9WFcDcCVKvoi6o8NpOjKCkXIM3yFxFxvYgKMTorX0sqcfcjVxRscNGMX09/o29OuhJBjy2ntk5LSbRzBbz8mt0Fb9+PLptYKJw5eZMbbNfuxgUBTmtjTH5/DFGSMjTFC6GyQPPEHRWsB2aR7pwjT5dtaQw4UNcEFV++AjtWIHJsrFfF1QyaCB0+BZyn7NzArPWAZmisD/Em/BK8+WgQCIoc9Rlk6TBLXaXEtzaV29n05vq2rbVtYhOVlz7F1dC+6/7zjug112mAoPiy1SJf/gSiD6pykB7tzzzJf/bS1chEVtL4o0UC/RYJAZrDpC4vfyPj2j46v7OIlQpuAQ1vZCSoeOcevSjg8TGtJIr5bs2duQBUmFo63uq5El9J43Cgp4MynQojrvMMAQI6V8cWwqeIsLT63jkAgrwHSarPLTwsAtDobuq+H4aF9dPz270o6zv3mJPNvMGSi+oc4jPvhhf6W6pUULah39hka7cKOICuDWsN8GOSjFWg8ISJV/x6I1o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9e571c-c174-4a60-c7a7-08dc554cb817
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 08:45:17.7118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rhh/4OcEKHe72W4ASCTh1zS6FlephlW9Jsz/4u5BAjvGHOmkk/qBGp2UEm5FrjmapHV40dcdA2x8GMJH7bSZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_08,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050063
X-Proofpoint-GUID: Se6XPY59I19MIucr3Mf6QPo065aKAEaw
X-Proofpoint-ORIG-GUID: Se6XPY59I19MIucr3Mf6QPo065aKAEaw

Update test cases with the new golden output for the command btrfs
subvolume snapshot, further introduce a helper _filter_snapshot() to
make it compatible with older btrfs-progs.

Anand Jain (2):
  common/filter.btrfs: add a new _filter_snapshot
  btrfs: create snapshot fix golden output

 common/filter.btrfs | 9 +++++++++
 tests/btrfs/001     | 3 ++-
 tests/btrfs/001.out | 2 +-
 tests/btrfs/152     | 6 +++---
 tests/btrfs/152.out | 4 ++--
 tests/btrfs/168     | 6 +++---
 tests/btrfs/168.out | 4 ++--
 tests/btrfs/202     | 4 ++--
 tests/btrfs/202.out | 2 +-
 tests/btrfs/300.out | 2 +-
 tests/btrfs/302     | 4 ++--
 tests/btrfs/302.out | 2 +-
 12 files changed, 29 insertions(+), 19 deletions(-)

-- 
2.39.3


