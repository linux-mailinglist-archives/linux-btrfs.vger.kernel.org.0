Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533A274567C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjGCHyU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjGCHyT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:54:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BABBC4
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:54:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3637ibra020825
        for <linux-btrfs@vger.kernel.org>; Mon, 3 Jul 2023 07:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=8loScO58to+WEK60ZLOXsmeX9GPd0Z9Lf4J9t4IttkY=;
 b=DNV27tuN8tQpj5SximdKl88VHn5Dgae58d2+GKZUgyQf4DC51vOYQxVR9uOTZvNhYaz2
 ttEehc1/gXHpK21tX36wWgoA4EgwNhVoOxRnzr686dVYtum3H8ET7wfAIzAl1ekmz6W3
 SUN9xk3SxZjhpCbFb9Npt6UrBMq55a8iyO6i/n/Nh9B8oatNVrgLYnS/EPa8MwqlyhJJ
 wjKlWKBdPVtw/S93GEHjPH4sugYQTH3Sst3TUNrpj+Z1VNOn1kftaq8cmtbWk5z2sPoH
 zInLlRfSqBQBB2ELi2V8G/I+2oCvu3PsBu1KXS9qCvp6qp9T/39mdtm4VQNFVsr35glo TA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpua0gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:54:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3636FL4N039614
        for <linux-btrfs@vger.kernel.org>; Mon, 3 Jul 2023 07:54:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak2qy37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:54:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTg5i7yum3v+XorFIBlqWZSaOztR+F5F83D1Dq1SzN62ipyvx14JEjKP8+oKiBPsYcYxKk3VNvECx2GqTycz38FH4g8LCLe7Fqt1O4zoyhPnlOVtJax5nxqP+gSf6lQDzrc2jspO6qXv2JP/SzK69vTAl3H9kjW50wLmopKICCNV4IDwUO8ilvAy3YdI6sPvlAtywLrKe3bbW36vLP4QExHXg+Er9E4WB4rOmLfLBZXPsBPHEF9zw8KlE3/FnPBYQvzlYjtNfFPsjN2g/2iNm8A+SXKegFf04oe9p5Xuq7g3j1r5lU63ILBqlyKSIB69bQu/q2AwpkpsOvP6n9X/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8loScO58to+WEK60ZLOXsmeX9GPd0Z9Lf4J9t4IttkY=;
 b=Yrjo7nPhAqh1wGNtpll/BcfbpvliwtZAAD60DYAtJIF8vpVMySbL+z5Hmg3FhyZmqN0t5yZHOK1WrWe0wKRtI1tenXBmcya/jUUG0K3+srrWVd02ej/zr+KxtNXW1DJyveDC0HKvjMDfvuNfb26YWSkh/Mv0nzWHewgUuefEE0hPCDDc+aoaLzbUENh6odugEBvWnwtfLDhT5ULK6K+2ls9jDFxop7bWDMzNwit+OqwNl3eXtFPjrqHGFe5o7LMQXCJnKjcGACMVzbplLlydN7PA+O433mzhAlN7ST+54Ta1KcsxlpyDkU3suCbSbkFVA8e/su08ugA+Njqpm98N5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8loScO58to+WEK60ZLOXsmeX9GPd0Z9Lf4J9t4IttkY=;
 b=fkDutnf6JIIKUnxT0GruwbQKi/JyVWh744cRGDgfTsubXf+ngkuZowSyNNpvntn5l8ZkR+DwNpaL8xcawWwmVCWPFZUuNIcCeLNyQx4ktVCAqMzazIJLlmScUtewFueLBZ249w3NMDj4wCOwOLgIfPrH3J6Yw9DOBrPSZP1hTx4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5243.namprd10.prod.outlook.com (2603:10b6:610:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 07:54:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 07:54:10 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix duplicate missing device
Date:   Mon,  3 Jul 2023 15:53:56 +0800
Message-Id: <4c5c6c8543aeae91544f8a64bda35a76e6615d7c.1688362709.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: af8c5e57-c67e-4087-e3d2-08db7b9aaf46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zU9VyXJ82xN7i9xk4M1PJbdAdJMWd+fEIQ5bsQwBDlKrdpmcaC2fZdxakL3mJ64jkNHEjMt8PL+Yt8UI1I73wmBO22A970KPMmUdb3p3lmLt5+dAOzPVdzMPPR0WjczjH0KxHkeQ7I9IlFyoEpyaPJ2vkRoVJqu3Ocheq7R05o91PLr6rBG3U3xluLdKqOMBJEGDQGSLEuL5lkY6dSju6wibWEQOd7RFV2YP9V5QKscFypGVFYxp8f19yGA9AVI1k6WbnBT7S8V2U2Zs888GNgErD9Iww1Yc0YOXphtOX3zmIsVwDtaQpDkJ3X35XZ8UpNLQvOK1R5pOTCZteolQ0ZwVnf5DUjfoPrtEXv3z2AmEvG/3CYdOw6xmVUSvm4lzN2AQH72UsL8PQ5YEAMRjC+18yX6LzULNR8/1Yj+rQn7btm+7oUAa2RcS5QCibz5KyOcD6jFGgsA5d4WtcALvSZQciOSZC4xsZP3UTs3+c3uVtjfnYXuKNQQy4bm4Ba1ZJXKA9J+EPdZ7/u35b0aubQAomb6DAzQPmRH6kUqc6syWX0FiYnc90yoEWE89WvBp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(26005)(478600001)(6666004)(6512007)(6506007)(86362001)(2616005)(186003)(38100700002)(6916009)(66556008)(66946007)(66476007)(83380400001)(6486002)(316002)(5660300002)(8936002)(8676002)(44832011)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5BgF4G7wwlEkp8ahGoGPMn8dd5s3/QDpsFbtVkXskgdzjDIDIqkvqHS5UL4X?=
 =?us-ascii?Q?qigi/GeXbQ99LgOwRO6S0DXh9i8WU37DLPEeZLvYDvvsAL4emMlmfaiILOWr?=
 =?us-ascii?Q?BAoJm5f4ZUjHv9cuEdwr6jfLD7+kebuPY8EkZ5ThJ9N6wyqUMYQfmAOcNjGj?=
 =?us-ascii?Q?lWp04VsAEGuMDomVBHqNzOfiURelvPgWvWv15AzkuCwICcbz5xut33v5NMu0?=
 =?us-ascii?Q?8qcqJH3sdtuIUluUMIkaLJYUxht5SsDPAvhWBsHUujCUBEYomCg0HZbYEDBU?=
 =?us-ascii?Q?1SusiODpQLytFR5GOEr67+GTkwiO6HEXq/gDq1Jaxjmk9bZzTkfyDJfQMj5W?=
 =?us-ascii?Q?fRYr6NT8kcwGk0PYg2GYJBfhHll3GDVBR/FSj2OtpXAMqXeYMCcCHynfjVrz?=
 =?us-ascii?Q?oTMBNhcykUrgNXw1EcmKT9j/tSi+nSbAD4/zzIb7g0/hr5cmvyCswfcnAlmL?=
 =?us-ascii?Q?GPqDxWoIlZyB79Be/Vhfv/k02Zm2OnKjLEZ5mVFDm60HU6lHiXgSQGP0Xa68?=
 =?us-ascii?Q?hcvg15orzFMOT+7yznY6ftI8JW364VYP1xhKqjX5mN5jBOcVuxdPlKhl3pZn?=
 =?us-ascii?Q?AALcYS5l/7rsQlwCEoVVN/Z5gHbgfbk4t1K8VRHWEJVjSyRSenFAvMyra9zk?=
 =?us-ascii?Q?ruY94IhpVcXiFQmz+thaj5t2uxK3vgzBY/iiQvM0cfuSdNErxqnSWSuTj42c?=
 =?us-ascii?Q?ErxdD3aCMP2hqIURei1kR6uTv8RfRavvF3xZxEHcSDI7BuItX8UtXRiHLpcz?=
 =?us-ascii?Q?CarvKvAYt7AHwGfC0NnwF/fou6htFNHWYm7q1IlX3EYXmqSdjeERwJF/tcOH?=
 =?us-ascii?Q?S94A74TzrvITuY+u2yyenNCgwo0cFvi3y6CV+vnaj9SDUMc9TeH4A/jAHg0V?=
 =?us-ascii?Q?EUptZ5x27B94WJtpAxT4a1k658ZyVZbwF6gneAZbHhhIedwib70PZbHkDG/r?=
 =?us-ascii?Q?kdfopi6YHM+fiuOwPidI3ZPk4HVPIUfXqc8mh5W0Z8TWlk3sEQMFa+/K3L7S?=
 =?us-ascii?Q?a/NYiXUsLODsVtIa8X4cIuH6AvBn/yl2IC0dxuLcHQUuCVL1ltft09eRIfLo?=
 =?us-ascii?Q?mgweUkDxNE0VhKg23/4p1cxuXVOjk+c5ymkSH+/52aC5I4jZJwoxar6GeQhP?=
 =?us-ascii?Q?yuDyMg3AWxSe25gjEq6uf2FM7RG6oOBdG8rk9sEPBfBJADOhzWXq8Km43YZk?=
 =?us-ascii?Q?AYLY5nZSvUGm5PMzQFbM5EwTTngO4ioAL/EN1bzUdDI+dR+4yTHx9UFpPQnh?=
 =?us-ascii?Q?v/sHsbSLW8kTGB2K1PgHLAE7QQrzo8hVR5zD9CRXsBQ+3EzbMAJ51gUPz9yg?=
 =?us-ascii?Q?t2GrNxbU4yPiOGH3ghN/dUziH3GP62CEU1/Cx/ENlmQd+vovmi6OjCOxIjuJ?=
 =?us-ascii?Q?KJllFI/zviewlxPj6ZJIPJW2I3ZgoQinH+YIWk/5yNCBapcFYJg5TJyUeSVK?=
 =?us-ascii?Q?WB2GvLhlKm3VwUkz/rXLRLHdh6ZbB4r5ZTfB+1JYXxmgipc/8TwFYA6hYXAA?=
 =?us-ascii?Q?7RyNf4Pf1Q/VUE4NcoHx0VmcpHuqD7vHpcBmhQy4IHCMHgTYDgR2DV9ekJsQ?=
 =?us-ascii?Q?H8OB/dP6p0wO2tDWGkjIB+2aszXTS9cYCNPtpCpL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aA+hzyQA3IhGod6s2XO+Wvu5xbdT6z2i6dvL62b9xBu8MFg5/3g0a0wT/2tPL8nglVNVaKDzqPSOvrkrRKLJehAwkSzGie2vgfJGyQf+OV32ovWVmDj5DsDjEBuK76A0ZcUkgkloLUupe4/rjvlmHCr4uuARH9rGepy/Zqnkz5cB1wgP/LDw71FWwtUr6FIN7rbIkA7QjiydZMQ3+QHPxiY95XUod5ICA5fCkCCayN+V4hF8cyISHonBoo/tjgWJwZHYH+7K/rTkqjJjnfbGrljpQF5qM3ysc0Ngkh84oumWHvJ8JtQnL7xboWX2dWVeBU6D75H4Xh/LwLquMObRPNCIBz5PH/qwhVWtGsIm6Fupohf4nkv0hPVGIV4l5Agv1BnQaZem9LwS25222IB93gfY7DHa5Bz/PHwMx4pY40XUkbYSAONjXLb70/vmtTqD4AfR2OabLRlMcZxST1sf8Fxkmwju8vTPuHW16ThrsUCgj95O1gbN8/MGpMQG2ozajKtYLB0/ATQG6rcsPnv20os+wkdTY9U8J+wCCbh3emuQk5+Fs0CiopD1iOYWoOUs2E6i81PSNBBvs89tiLUuXY9F5OWK8AWxRT6fRcAATsVDJIPzkZ1qjX/d39Z3AhQr13tpxGKDs1GyrOCGpTclrK8R2YJ9zSyC6e4AwjNIc1SF+3GwjZnpzxzGT0uTq0PnSnHNq9KuS1UzJPgq79BUJvDR7YFgUFpiHDiY5FVLKxdj6aoSUJSdC6rIQnpVFMSE
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8c5e57-c67e-4087-e3d2-08db7b9aaf46
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 07:54:10.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TfkLlAZ/NfSNKuNYzApHmxeAtoY+ePP2G5v8TBtj6lwtJmlLfEIEFW0Z8KaAHLeyCZ0Qaht47pVvFmZPZfANQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030072
X-Proofpoint-ORIG-GUID: qfRn1dk48WzN49wek-d1moDcB6csDw3a
X-Proofpoint-GUID: qfRn1dk48WzN49wek-d1moDcB6csDw3a
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_read_sys_array() adds a device with only devid, but without the
device UUID. As a result, any subsequent
btrfs_find_device(..devid, uuid) calls will still fail, resulting in the
addition of another struct btrfs_device to the list, as shown below.

open_ctree_fd()
::
 btrfs_setup_chunk_tree_and_device_map()
  btrfs_read_sys_array()
   read_one_chunk()
    btrfs_find_device()
    fill_missing_device() <--- dev_uuid wasn't updated
    list_add()
  btrfs_read_chunk_tree
    read_one_dev()
       btrfs_find_device(..,devid, dev_uuid,..); <-- fails
       list_add
       fill_device_from_item(leaf, dev_item, device);

This ends up having two btrfs_device for the same missing devid.

Before:

There are two device with devid 1.

$ ./btrfstune -m --noscan  /tdev/disk4.raw
warning, device 1 is missing
[fsid: 95bbc163-671a-4a0a-bd34-03a65e4b338c]
	size:			120
	metadata_uuid:		95bbc163-671a-4a0a-bd34-03a65e4b338c
	fs_devs_addr:		0xdb64e0
	total_rw_bytes:		1048576000
	[[UUID: 703a4cac-bca0-47e4-98f6-55e530800172]]
		sb_flags: 0x0
		sb_incompact_flags: 0x0
		dev_addr:	0xdb69a0
		device:		(null)
		devid:		1
		generation:	0
		total_bytes:	524288000
		bytes_used:	127926272
		type:		0
		io_align:	4096
		io_width:	4096
		sector_size:	4096
	[[UUID: 00000000-0000-0000-0000-000000000000]]
		sb_flags: 0x0
		sb_incompact_flags: 0x0
		dev_addr:	0xdb3060
		device:		(null)
		devid:		1
		generation:	0
		total_bytes:	0
		bytes_used:	0
		type:		0
		io_align:	0
		io_width:	0
		sector_size:	0
	[[UUID: 1db7564f-e53b-46ff-8a33-a8b2d00d86d1]]
		sb_flags: 0x1000000001
		sb_incompact_flags: 0x141
		dev_addr:	0xdb6e90
		device:		/tdev/disk4.raw
		devid:		2
		generation:	6
		total_bytes:	524288000
		bytes_used:	127926272
		type:		0
		io_align:	4096
		io_width:	4096
		sector_size:	4096

Fix this issue by adding the UUID to the missing device created in
fill_missing_device().

After:

$ ./btrfstune -m --noscan  /tdev/disk4.raw
warning, device 1 is missing
[fsid: 95bbc163-671a-4a0a-bd34-03a65e4b338c]
        size:                   120
        metadata_uuid:          95bbc163-671a-4a0a-bd34-03a65e4b338c
        fs_devs_addr:           0x161f380
        total_rw_bytes:         1048576000
        [[UUID: 703a4cac-bca0-47e4-98f6-55e530800172]]
                sb_flags: 0x0
                sb_incompact_flags: 0x0
                dev_addr:       0x161c060
                device:         (null)
                devid:          1
                generation:     0
                total_bytes:    524288000
                bytes_used:     127926272
                type:           0
                io_align:       4096
                io_width:       4096
                sector_size:    4096
        [[UUID: 1db7564f-e53b-46ff-8a33-a8b2d00d86d1]]
                sb_flags: 0x1000000001
                sb_incompact_flags: 0x141
                dev_addr:       0x161fe90
                device:         /tdev/disk4.raw
                devid:          2
                generation:     6
                total_bytes:    524288000
                bytes_used:     127926272
                type:           0
                io_align:       4096
                io_width:       4096
                sector_size:    4096

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 88d13e047379..4347acfe95e1 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2079,12 +2079,13 @@ int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	return readonly;
 }
 
-static struct btrfs_device *fill_missing_device(u64 devid)
+static struct btrfs_device *fill_missing_device(u64 devid, u8 *uuid)
 {
 	struct btrfs_device *device;
 
 	device = kzalloc(sizeof(*device), GFP_NOFS);
 	device->devid = devid;
+	memcpy(device->uuid, uuid, BTRFS_UUID_SIZE);
 	device->fd = -1;
 	return device;
 }
@@ -2152,7 +2153,7 @@ static int read_one_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 		map->stripes[i].dev = btrfs_find_device(fs_info, devid, uuid,
 							NULL);
 		if (!map->stripes[i].dev) {
-			map->stripes[i].dev = fill_missing_device(devid);
+			map->stripes[i].dev = fill_missing_device(devid, uuid);
 			printf("warning, device %llu is missing\n",
 			       (unsigned long long)devid);
 			list_add(&map->stripes[i].dev->dev_list,
-- 
2.31.1

