Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4AB74B4A5
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 17:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGGPxE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 11:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjGGPxD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 11:53:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7137B1BF4
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:53:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FmOxK031722
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=d1zlSyJu75TRaqMwq3sXDNKlw3NKDdbbXjl/Dac7d74=;
 b=Kj3W1ryTtoCvzFZWTmK1tngZwc0bOFZ8GJ0PVlWz0GwCPCT65mOXeU8yyu4iD5ysuDRx
 rEq8ppA03415hVShspkk92K42K4lpPLb3R6dwO/eWxYHOuQ5+diThyzfMI2lnBNSbcZs
 f7dDgIWHmRRcUQAYv6yWEKBQ2yPfK/iH5ig0EsOhoSdkZKui6j1skDfKGn+U4f6XN8iR
 3fOPF9Lo8+cTIGq/qQxjAzB2vhc1Goj6hHZD/5OETfGc3NlsLowOvwSrcKpvBKy9YpdW
 n1dBMV/vev34GVEB5YgQBC4b4/lb/d9ao6VyxExHWdOSZWsFS0ktMObTBGCG6Stc8PDd 3w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpb4xh6yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367FeNVv010256
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8kfh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVZ+PrEyOeWixvz8WGX1F8uEOwwSe4mlGZG6ICNNBcsRtvxkeLxqARK1P+a+7WyeF1eyCZOKo+bRsvserlL8WvY5rTT2w2w7AcLXm8WWkYl7CejaWzTOuI9ADWgp8fR5qQTOlNzrU4iwCKHdM6rc4OKyPoIHrg3tY2bPPVEjGoeOY+nU1H//aUBeK4igA5WX+OmEaqy4XB54BREz/IbkrSdpB9KKKRVeOQcodIG1s/tVPASh4KXoQm2uejN/94CPDpieN3EFH814bsBD0j3ey5QDtkziXe42YfNVlzOBglwFHPzLixtag01GjHsNoaCZojJKrMwmv0L/nyyMu/4YUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1zlSyJu75TRaqMwq3sXDNKlw3NKDdbbXjl/Dac7d74=;
 b=Q6E32Wx0Utta8FPO0QvgQ24XtljIGQm0rkxekrmBeShVgQ00iLw1UC5ldP8A8vWm8LsBKCUgZiWaBNQdYc99CkCpkspDVaD2ahM6MBf50Z3Mrnkz3NPrXU3xkGT4ErMWA95nYByyoEV0ORnSpi4U1Gi4NW/eVnxEmiCmvCu7b7JVjZNP/RPdKdJJBUReCA92mLx02ePcyJqO5kFnbFIQ6r67+CTM6DPAdU/LilQDigMSJbZjh3WZ27ZwZB1vNE9lnd6dvnerYLZ1JUDOdITWVX0qfkLaUEbZ7qH+AbVEjGURyFUyMoNyoyF3UvwmJrYkH3wkug/J71UKKFp8aGoV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1zlSyJu75TRaqMwq3sXDNKlw3NKDdbbXjl/Dac7d74=;
 b=KSgFgML+7O5vyETviBoUGQ+FyY5Z7Md8OWwEDzTsMOCRPVEoa4mUo27nvx8XbTiyaWSnFbjfCcEb3VKMt93SGIq2lhzUxNdnspzphMI4AGJVlDTeFWUNmKGDmTqhLSivobW9u6HhJoexXHdVfmqKYNwPVr/XqxZp125CdBxX9G0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6156.namprd10.prod.outlook.com (2603:10b6:510:1f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:52:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:52:58 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/11] btrfs-progs: fix duplicate missing device
Date:   Fri,  7 Jul 2023 23:52:31 +0800
Message-Id: <76f85159f72bfef17a702295086745bf31fa09b5.1688724045.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1688724045.git.anand.jain@oracle.com>
References: <cover.1688724045.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 4283b207-9492-4819-5c48-08db7f023c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNhU9+5ruT7EXaViu8TkA2klBuGshypL2IIQ6OLoUVrn907iJ8hycnSE7llKitkukXAVZfdjhpHOM3IW+eYcHj6OWFrjjOO1V7ywipttdoLjmZU0A3kuLOiRa9J76JsoVLqQRad75aTkIhUyKgNrnsFcxriwibtt/gJDGUE50pjCtZ2yqqEL6TYUn3p/JuU2jQGyrYr0c4ORUVp99Mp2tRFDrsfKzI/qcuezVK2vjE0irKBdBf/Ow9Hu0HNXMXHq7vSvEMGdgpMY6T6YJLThkP3Gmq+jnBWDWZDYPCm68FrU6KkbSshu/RbA3rY86c0oVop3HHhLhU/2ItIZcr+n8PvJOX7jYXyVCKvGeOv8Vx5TcOgE5a/bQYFANjZ+o8KoEWAP0JIysqSLBGOy5OI4+FjI690JXo/lkw8cuajiWIYmiBVaWp5TpxfSBFYGPnqcyEx3gj9ZnWaD0C8hMbzJjRwUg5tU1UBw4/PnOHu5SFyMNQBd9OxyMirJODQ1Sy0wBezk7H9Ol0QxxYxu0jq4XinTEN22Ts/kLCvZciYzVQ8gpw05vA8Fv88a5qCbhmVw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(44832011)(5660300002)(8676002)(66946007)(66476007)(6916009)(316002)(66556008)(2906002)(6666004)(6486002)(6512007)(41300700001)(8936002)(2616005)(26005)(6506007)(186003)(83380400001)(478600001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d7OBnxXNPeQiIVSzie2WsEmPMwJUeszRB/PwTfi56xRmNURvS1b9NbYMSwyv?=
 =?us-ascii?Q?CYkpzJB/PzVh/QYw8VBxopkZAuzfbKMAN6ARge0G7bsm0k+SMwaq6MTCuhzY?=
 =?us-ascii?Q?35GY6JywJTSqf6h59Q83nUnL/txUnUC8T7AwAkapADaqQI+/eafyZp3WG4jA?=
 =?us-ascii?Q?onDUnYYGRIzrevakvoOhyXuHAzH2aK/EkSarz1AcBBx7B0wlBERVvqYlppp0?=
 =?us-ascii?Q?JkmNOAsTpfCkMbE9XaNzT8aLi1Cvu9SY2HzPIH3TiWcxs38ntAHCB39VgGYu?=
 =?us-ascii?Q?nuiVUgmK0+koJrF5NUNPsX8DN9ytgVBN12sm7s2RuzToGhXZfLGtLq/1pMuB?=
 =?us-ascii?Q?oRPe3pzVwSlG/4qAQamj4uFIkH7C/B2D146Z0IE52UcwdSMUSKJo2OU3A0vZ?=
 =?us-ascii?Q?aF35uR3o/UUBTp2NEygwc+4UNNBd11ynWlbb3RZv2ppg4kdsvUOT8WGTDv0T?=
 =?us-ascii?Q?NziRJLygrfwkfb5DfWCT0IvuKrj/v9b6g/xal0C81zaSqEJxr54UJ1mesta5?=
 =?us-ascii?Q?59j2RerceeEJK/f2i0r3RYK+9LkBUHCuzfPCT6qPTz1LX71sjCOb7GpGkABo?=
 =?us-ascii?Q?SUqdkQ5txTkRcB2qc5xK7pb7BTHl/bCcdgnYog41YKhAP3BLPalTElZKu1VU?=
 =?us-ascii?Q?8wumVEm1SDiuzg6hYD+xb3EY+C+/sJ1T4JqAnX2jS18eOVGRq0uUbqU+KpiP?=
 =?us-ascii?Q?91PS5ueVikyHQExBHuyMu9r1kBYwVKRAHolODNhTDGng37U0l1xUQFYTt1JG?=
 =?us-ascii?Q?04qkk1LKvTsS6OwRIe4W1LAVIZn1VlV395h3A13tHL3TVLAnK5KqUNWJ/tQq?=
 =?us-ascii?Q?X7aedWyds+jhAEHvzew+3XC6qtOXp8vLbiJxIhZ5pqDLHOA/EOLiY5rKKemh?=
 =?us-ascii?Q?3LD/TAP6FTk9H7fO4agezMGpQLU09m7tnoXwfo+Za6Vlp9F+Y3ZI5tQ5Q4Al?=
 =?us-ascii?Q?u0QtOoVTAA5GJTHwxUXJXCly9RPCt0dSPMJSyyHmS7Tbh10GlciPzAU3486v?=
 =?us-ascii?Q?c4X4zQUzPxmzeuS64tY6DrFL+OgCIZf+JHc8R5QsSSyMBcFGzKhp00Iapqu4?=
 =?us-ascii?Q?JtUN2GyVlG6C1MZUhB3q+XTOhzcowXjbFvKFSWLOqLMYXxoye54NrfKWTOzG?=
 =?us-ascii?Q?5cXlr5jtKyzbnXPR34qtczpIaWcNmcYubYEtvfdL4MsZrXFfmPKxqMJ6Q3eP?=
 =?us-ascii?Q?RlWXzo3hAM9nP90vefKwMxhPcn6Gm03cE115HnzPqS3uKyVOy97r+XUQJBG+?=
 =?us-ascii?Q?/ZzAwQNTtkcNLlvkWSr9OjUJAXwg+ztVrlRVsOsYtA/dDZhYSjv42/WHlSUy?=
 =?us-ascii?Q?WgtauWi0xuJNSwdxKfhKwtU7zbCxWusVCqEsdJGtbVZc6Rvm9o3+n6c9kmXN?=
 =?us-ascii?Q?+1jlugH+Papui9gnoxxLBNbUfWjQPaWQozWsfxUbRujlfCH4tLJel8hYy4Ta?=
 =?us-ascii?Q?geD6/RJGVdgj4Uzl2Rkp1EghdGxDQdDF37Edo7hPyTDnJJKUZRi2C8Uxe/yx?=
 =?us-ascii?Q?RYjdv1iCq5d3w66PDdRIVBd39dfiRgdX5SZPp9X+EP+q0NAKN4I/5a7BVZvE?=
 =?us-ascii?Q?zR3+yE1GNJVYz6d5Jqx7QJr1knXXj/5cuI5gNgS6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LzNSqYv4Eye/uAsLd7x9Qc5SY+yYPmQX075H/VBY+W8SSn3b1Z9rfjR6KiSvIMNmHNYo7wjSVix4Tcb8SrbSb2gr6OrjTknGufjDFXZOSvJZi7qLmR2CX4YJHdKG03Mgv2EZtw8zUYiNeqLM6AJjb9ZjH+LNX3whCg9EeQb/+IzmZ0U08b85gR8p+scSdo3U0376ZmmYoK+4WEk1AXELk0sqMYZmxjlekKCEJ4+S+/qt7WTea++BbAUOiHSukHWEvJxhSNSclXR1gdE9abYKqdj3ndchecbolxUZXNj54fswJuJ4wcnra5EUbXemAj+wv8G6/Zldhi5gYZx0IF1wQse7GWtJ9AaKJHVZKVcioVJkmvWf5i5GiN0yh+qHHAN9eoJMQF0GTQs1Tb+AAqtlIGa/DLT61SbPCgnSg4Or1n9+mgRjOWtxsyGogRkVwk9fyAI1SDcNTbytWJ9m9lAPi3j3iKyomyG/KChMORbvyIQXtOOMfWOCdwQNARnLGRNnUYbqirG+4WRd0Y364jwFlhozmH06KT0gVh8dPDnAFjiOZ6bRTNlhHtn/3NikiUrQuf0qSTwMHck1Gr1iOncCW/PyqTuA4QdwDo/ToXA6vh3GWGbiQ/oGSztNHw+6CS8euB47nJ3BgJvJusO/H3sc9fPTQxqMf5B9xxWDdcz5BEV2bAM3rC9mL1w5JkeIkz7ACVB3/ZZMn2Oc5mk9fsUFuPpWMxNe8s22vbx9ux95M3dN/Ke6RdU++5+5nOBOHVva
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4283b207-9492-4819-5c48-08db7f023c51
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:52:58.4308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ec9oKQxQoqyX+8zvGAJ43Z9T1czo/cIDBvp2ona1TEryOMgPZ4Qk58S9/voxym0ZoltYAYI8Ygbw3CQ142kXTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070147
X-Proofpoint-GUID: uEPnCSsrLbtTdUUT5xb72y_lLP4SvUUA
X-Proofpoint-ORIG-GUID: uEPnCSsrLbtTdUUT5xb72y_lLP4SvUUA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index 81abda3f7d1c..92282524867d 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2077,12 +2077,13 @@ int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset)
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
@@ -2150,7 +2151,7 @@ static int read_one_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 		map->stripes[i].dev = btrfs_find_device(fs_info, devid, uuid,
 							NULL);
 		if (!map->stripes[i].dev) {
-			map->stripes[i].dev = fill_missing_device(devid);
+			map->stripes[i].dev = fill_missing_device(devid, uuid);
 			printf("warning, device %llu is missing\n",
 			       (unsigned long long)devid);
 			list_add(&map->stripes[i].dev->dev_list,
-- 
2.39.3

