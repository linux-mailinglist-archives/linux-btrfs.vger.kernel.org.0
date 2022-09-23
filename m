Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A915E7DA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 16:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiIWOxV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 10:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIWOxT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 10:53:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D8C12B5F9
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 07:53:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NCx7pb001400;
        Fri, 23 Sep 2022 14:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=KnmBMg4GvqO4BppA0OjEVMFQl8ffJ+d83vohUmfCLgM=;
 b=GtPXZUI6lXyn8IT76BfygR1cTA8D8Sdxr6mTucNqDcCfLIbQTkQG5ntXl5UYS0tKwub/
 1VK3kY4I7EAfg6sbzKADTPDHbfLAtfPImXWC6Zm2xyZ1m/MqrMtmRBJbdnV/p0hqo43r
 EQH7CJ8So17KG/+vStZ6pgV+3+K7CQhr8V1nLDdwK6B7/UhviaG1gYBwLjEfZKSQw79B
 tyE3QX4qs4A7SlzjnipUlaHY56rhtOb4eJESsrcGkh3JfrPxLKDNnMdeAjXWejL4kgvC
 gKmeOFgtmJVjtpVSnLJIfjC3kv9ERhqqjC6W/j7qDU8GaTESlnQRgxxzyrw43CT6MaM7 hQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn688r4sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 14:53:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28NEFnPY001899;
        Fri, 23 Sep 2022 14:53:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39tyn7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 14:53:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5bWMVeq++GKuBtxUSqTTpWMUPOA5dFq027sXHFem59Rh4eAwqOsade9E5LFEazVRYY5xME6tq/eDaNPRTRROYHEUD4PqRQTbunHnrdANijegeRwd42R3YZXDyP9u6x9+45+N7lqKz5w7Dag7QkN1vUKQFg/xaiEFVcUvp2Z92ycT8moolt3HNjvS3yiNJATc0cagi5cRzFmTxGUNSPIPKDlYwY0bzAIzJSHH6QAoN20ZEF1uD7WEhgYtf2GeXlmDgUXa8TLVrNfEQmWGIHiFOPCovPaLw6s7bKzEQzITDNq44HmRIlJV8X3wnMVQhq2oz+bh6XxirAfu+DjFIVKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnmBMg4GvqO4BppA0OjEVMFQl8ffJ+d83vohUmfCLgM=;
 b=EHoY4F5P33tchkKofp2R5HzgWtZCUgVQRqBn5BvIFW0Gtt7LwEGRlR6ZjHoEfCroA7YUmlTjznbqTiLKppYoOJnTk0G8IKn+JEl1yTY8+AJX2Jrq1ViWn4bBlfeShWsIkO1LudsA6mD3ZsaSe7RF0Xp28SWQ3FHiLrpVgk4zhL0qOSNkhBXLAFDBJ1cmXrgMl66P8EuHge4MdCYr62pBDD2G8aYdhs9JRbPIkhStVggWhyTsCpMxO68VagojHBQfakZFCgq5ESVBNXwo1+0xWrTU8NBTyFCgOQhhaR1b/W3LEkGG3jKjqyzQvI1Ib825AEAuffl5JDsJGlcB0JRRug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnmBMg4GvqO4BppA0OjEVMFQl8ffJ+d83vohUmfCLgM=;
 b=LC0Y1XxmgJgI6/Vn3MaB754yuCJbcO9Q/1cZjBuW5VdjWzw4SSuodfXoP+9E1VL0aVIvUogio+Sg6myT4UB5r/czwNZBWiMzV9jgN/Pc2xV9/q4HSxLEqaiAtDPzfY+DYvhpgN4k6mds8HaxKNpXKxCr8e1S7tHx/2mdHJp3eFI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY8PR10MB6825.namprd10.prod.outlook.com
 (2603:10b6:930:9c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 14:53:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5654.019; Fri, 23 Sep 2022
 14:53:12 +0000
Date:   Fri, 23 Sep 2022 17:53:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     shr@fb.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: enable nowait async buffered writes
Message-ID: <Yy3IUPYheKipaIei@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR2P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CY8PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 03249bef-d628-4eae-4de6-08da9d7356b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkoXAJBJh9NxRPQVSAoKp49RQUK/xqkdHqPLhSaIp30HwRIgQJJpQ/Lo2rw2qVlMXoVCRnj9/3tXiyJZ+9PwfcntWyfedqBivWuAKkMVeQy8oe7W3P0JUQlDeky3rW5IDJDI5DIoUpZZdoqyZUe/BGoPUtCYSbo9PqLTb3C3BeR7tDcCTqd7alKxrUQDwXDYIDrs8uNJN20S1hS64IeVCp+pBMALAR7AZnHDTP0bD/8xNSh1svaKsrmzIMGs896x3cTRQMaC7JXawuyJWFVOHlL47l/aBArlzLw4PgjQ12CgMrPuon5Ad0TSr1D9bH8SuTXRXOngyAuxMfMsXSP3ZX3/x0kAGCNs/MsttfyygC4vcDn6kpfUswlv5qOzaVfJ/71TLTMdnio1+pxMnbRRxndEf5FQEvTmP0NmDBUjXncSDG6fBkJur19FyyFC0ltMpZ6Lf8gAfiz+6zyfxALuLpMFGcCrqj64iG29hLY/1RA7DzjOocokHlnM4ZxnWpTnhjGaMjdyzkUaClN4Q0vmc0mRUPTiAJUNyi5cYUr8yowS+Djv3MtT27tRiAqGsJdGqueTuKm5knhl9D8H9bYtGsUsNZHYoILxZRWySEz5W67gABKZWpcXE3GJTKTHJ7uyTjM6iGVDDBmz3fE8phZdFfoL9uL/gq50zsWbbiHGKnOTLA0qhgKMWqcAi7IykQ7/Cr1D4mvBrGFEX0Wjm2VFNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(6486002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(6916009)(2906002)(44832011)(8936002)(41300700001)(186003)(33716001)(83380400001)(478600001)(9686003)(6512007)(5660300002)(6506007)(38100700002)(6666004)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qzpz2mHIWUiPDy30pmOsN/GQhYc4/B2Zz7gI4czwgElK1PdxcDOYfSPi8Z5Z?=
 =?us-ascii?Q?ifULMX4o3y899x2GPI321fr7X2tVskKcN3odv5T/yc83vg1B7KQeU4aK6rKo?=
 =?us-ascii?Q?z+eCjFgGMBKX3CvRgtvizwfih9ruQc4jpyIX0qEz/kR4liXel3Q6PrbBrnuP?=
 =?us-ascii?Q?SD2NAuMdSeLNxuRybb/iYniJJ6ADz/ejOO8GVbK45ZVdDuGzqePxNr8TOtg2?=
 =?us-ascii?Q?9ZWaDdKuHEWXyfh3dyOdGLmqJgS3s0PZeqFQCky21IiIPK6gUUw1ckr80Wfv?=
 =?us-ascii?Q?CerAaOzmlr8Uh0ms+PAeRDBb+3pr3iTxQkDhLOLKX5ePws6zzeuyeMovQoeH?=
 =?us-ascii?Q?EOI76KnUPVikiaMRVdE62LRJfFXBvcn+Z3bOxQghEQXqJVSL0V0ttu6zxHV8?=
 =?us-ascii?Q?LraEwWCZdxQ0JP0los3gAhSl6fGNoKmij+WGRVCS8RBBZlI6wIdqtoiFzWmj?=
 =?us-ascii?Q?osC1DPaTXiqW1ggFNQUwFj4FH1bk1zHzXn///aSrLh2EXhL+WKxAl69EbyzS?=
 =?us-ascii?Q?P0RGxqqt77YYe6RFG44qUnDOeLJmvKB7nXd7Kt6fjp+48v8wWzCmxwdTE1pm?=
 =?us-ascii?Q?TOwyiLPBS0vjQ1fQhFeQKp0U7+DuiL6CEEdebkRHJi7qCQBqaaDvBorYEO89?=
 =?us-ascii?Q?GCd7Bkb2+mD7bBUzrIFisFD+ITaIoeznGbnNpGxi7hYETPtZyml0XuftQpN2?=
 =?us-ascii?Q?lOW5Ve+YW+hLgId11OcMbEbcisahA6IpbIgeA4Yn2ENkK4BjI6E+aUXrtRmB?=
 =?us-ascii?Q?4+Q5BSyKpcDP1E29yqmuvZKh/jGTUAMAqWvJhCR80lNYM50I7qoGWsDzWLlM?=
 =?us-ascii?Q?9Vyo0XPgzWrYpcu5PG8MVUfIwMjELw2UU3EocASMXN8BlmpMHV1dT5OKxCGj?=
 =?us-ascii?Q?Yjr/Uk2zRFp72plMMigyZMmmgQcEnz09olgRFJ3825k5MWWkl8yF4zpOGdww?=
 =?us-ascii?Q?HhWIN2D/IvaK12ITGYKj5fDc2VAijVFQR79waXy6aozySTRh2vEfOE4VrKHE?=
 =?us-ascii?Q?kKpe8Us0zvHyoGpnIls2z6gpwI4BABAg0IjzCrzKo1siNhJCC6D+GawJJquh?=
 =?us-ascii?Q?BZoOnkzP6IGSoNL9jJj1yBBrdgPetH6FzEMev0S26rJqn3gF7DYRn2J/2pKV?=
 =?us-ascii?Q?AEAYmFK2jZOO95ibAzWpPb5uGxv+E6GtTDVI7T2KvgI8CzIDHCjyDLZN8lem?=
 =?us-ascii?Q?btnKTfildVdzmmo01l4/VrGgzkjGPcPj9RdJoWSV7JHrXSm59q/CBp8+G4cC?=
 =?us-ascii?Q?AH3h2SlXnCtPWVLmKo1GCa2BUv3d2MKEalh/LjsFFjvki+u+1S5MNX5p2fSP?=
 =?us-ascii?Q?yznBVtAzFqFkMmFy7ZpB2HtITvOeNFP97y7ZesfBePaCjzk65kQdp/LPGPWi?=
 =?us-ascii?Q?cq7QEtL/DhKBKOln7qvQqCAx9camADDs4O+/iulBYQEMGia6sm13iesSSKj1?=
 =?us-ascii?Q?CBuGGxevSSwT/+eI/a6NSWhGVV0mjQPaYR1drDI6O3xEhUTxZaWWsqnupwmE?=
 =?us-ascii?Q?sOY3U65MoReKkrIwsbtiOKfA/20TuX+UrsgBwUB1fYt6EI2n98vkB+82UTvE?=
 =?us-ascii?Q?R3Ecu6WzVYI+3ZLFmkuhZ+DH6CCFuRnLyArbsXaIbQSSmrOeJedO1orGdqFz?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03249bef-d628-4eae-4de6-08da9d7356b0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:53:12.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QF/plfhTxnznPzh+BcNsSyPp/QCcBD8bBNdXipnYNtoVPqPesmHWzz7vIwSIzy+YhWKYNPKHx0D+uPf0CeWPgpqV6fNQ/fR2lWvaebLDgpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=759 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230097
X-Proofpoint-GUID: ZIa_2Vw1XK3Xw40xUkN3SQq43v_kUILl
X-Proofpoint-ORIG-GUID: ZIa_2Vw1XK3Xw40xUkN3SQq43v_kUILl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Stefan Roesch,

The patch 8bf465b1c880: "btrfs: enable nowait async buffered writes"
from Sep 12, 2022, leads to the following Smatch static checker
warning:

	fs/btrfs/file.c:2113 btrfs_do_write_iter()
	warn: refcount leak 'inode->sync_writers.counter': lines='2113'

fs/btrfs/file.c
    2092 ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
    2093                             const struct btrfs_ioctl_encoded_io_args *encoded)
    2094 {
    2095         struct file *file = iocb->ki_filp;
    2096         struct btrfs_inode *inode = BTRFS_I(file_inode(file));
    2097         ssize_t num_written, num_sync;
    2098         const bool sync = iocb_is_dsync(iocb);
    2099 
    2100         /*
    2101          * If the fs flips readonly due to some impossible error, although we
    2102          * have opened a file as writable, we have to stop this write operation
    2103          * to ensure consistency.
    2104          */
    2105         if (BTRFS_FS_ERROR(inode->root->fs_info))
    2106                 return -EROFS;
    2107 
    2108         if (sync)
    2109                 atomic_inc(&inode->sync_writers);
    2110 
    2111         if (encoded) {
    2112                 if (iocb->ki_flags & IOCB_NOWAIT)
--> 2113                         return -EOPNOTSUPP;

This check used to happen before the atomic_inc(&inode->sync_writers);

    2114 
    2115                 num_written = btrfs_encoded_write(iocb, from, encoded);
    2116                 num_sync = encoded->len;
    2117         } else if (iocb->ki_flags & IOCB_DIRECT) {
    2118                 num_written = btrfs_direct_write(iocb, from);
    2119                 num_sync = num_written;
    2120         } else {
    2121                 num_written = btrfs_buffered_write(iocb, from);
    2122                 num_sync = num_written;
    2123         }
    2124 
    2125         btrfs_set_inode_last_sub_trans(inode);
    2126 
    2127         if (num_sync > 0) {
    2128                 num_sync = generic_write_sync(iocb, num_sync);
    2129                 if (num_sync < 0)
    2130                         num_written = num_sync;
    2131         }
    2132 
    2133         if (sync)
    2134                 atomic_dec(&inode->sync_writers);
    2135 
    2136         current->backing_dev_info = NULL;
    2137         return num_written;
    2138 }

regards,
dan carpenter
