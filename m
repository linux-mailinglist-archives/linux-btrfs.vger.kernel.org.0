Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1543772E002
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbjFMKr3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239623AbjFMKr1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:47:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E3F1AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:47:26 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65nwH030564
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=aMoLBn6w2s9RoNzcllqFF2a+P/SrLCYSDT8to/MxEck=;
 b=TupC3cQh/mk40TxI1vqjT61IFJ1yAqiwCqo1aCPIPn5DoaUfj70DiJ5nBs3p4218wPXV
 DkJQeFm6iMWew3o9qV3YosMUmRXHKYY08c+TKeJO/Tv0ZpmYR66r2W4u6YKEBffMq0Ck
 NTdCjGhNDrzACnUMJrgDN4SBwob76l+E7Je2ODVfO8daiN7wqwA6FVm8q96NMXiElfIB
 iaWl1PFpx3IMBBxqlzluszC9HNJmQARiF3HwC3SLfyaaMCzkYlUuJJNjzTHdWQq0+LaI
 a4gSTlmurHthUlMIuEoRvWronfBkRFtb3yMCi5UPcwQrmklpHhPoRn7vCaonukAnbTiQ HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1w0n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35D8bXmJ008281
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fma8j5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwctA0YbBs2E3gLUADAFjVKERH4TKMPKLTMrQ8IYpSNY0gDim2p066nZGMp2ygGkk0WgrFmU75AITH9NQwGfFOkzf5aPed95d+zfk+qCQm03WSrgWbCbg0U3C8VBmH/YT5XBKAW7BCBRMooGDsqmELG0FARs5DcIIEaP9/LOX1vpHdGD30bJLr0KQjaIEOBJhnHyh4O1yaDNO8w+aOzxiQNuuQf0/opziMt3tHf8XrqBbM8TzTNDTCRS+9PKkVCGt9sI/yK+NEn0eFN+c/u6x7yGI5bgY9AgUZMFVZkds0Vah8YmVi4JQmaaTSQIrYps6FwphvCXfRyB6NtkeZwrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMoLBn6w2s9RoNzcllqFF2a+P/SrLCYSDT8to/MxEck=;
 b=eG5OmLbiB6NXy4/y4VxH/s7YpsXYrikgW42PYB79fN/lihRXZ1KQrnWuSVwrGZKmg2sWdnd8BQyfEbYoLS8Nsm5Gx0CMSDg/W23mqQSo62bQ7NR9srNmOvFi1hJ4GrlGOz4QKXNHknXhHOVhANZeJ35noYl1uCfHdLlx/rmZD0QqrDhO9NpJUBD8LRs45ggbY1GHRrGbSttsf3vZ1nWEiL6F8aAADyi8vonH8rGOkMHHEryogQmDT5NGNdr6rMjt2U6AoeqxAwPYYc+jPHKtBC9dNxMP0HVecmHtpUNRvGbUTPBokXcdap/LZwOdHWhQbeqwd7hes2oUIj37uZJGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMoLBn6w2s9RoNzcllqFF2a+P/SrLCYSDT8to/MxEck=;
 b=G1/NTgrqfgU/tnL90rX7Tlyr9ZVXFBSKqagPJ4kE6qZcRZ+Fte4boktYSIUxeXK0CxCONbcfxAs0bEGjD39hmFwdwTan3obMoiLHb3zjQkRQdWRq01zzFpt9+GtXrGp+/aoxww0ka9UHwLFaauvF62b9sCLtJzXF4ZMmkBbVhLM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5012.namprd10.prod.outlook.com (2603:10b6:208:334::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 10:47:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:47:22 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: tune: add --device and --noscan option
Date:   Tue, 13 Jun 2023 18:47:10 +0800
Message-Id: <cover.1686484243.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: f02c4012-d82d-4b11-1dca-08db6bfb913b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jyhQMIGWSW3c2ZxB/iRoGRUt838MOD3bi8OUGoFxw9u2fbhWmnMjEEboQCsV8m9c2ExiqvExTdz2gBk6oiUpwVpX1yLCZE2YjAR9+SvbKj7Qp3ptlulc7a0bJmP+SGKNMO7XIIfSNZRETOqfdadyA4bDoVDFltc+8k52haZsgtv69CD6obmMC9RrbnttsnrZlxD97Z678duh6wzeytIOU18n+9bxslSAVbfJ+bAGv35z8cS9G2m3lwptkeZFde9coa7/Iy3LPYUV85Nm6V/JtBLNbWrOT3xVXmc4x3TGzaLHPVowUljj4/4saQhb+z/BNCgHzwxQU0pyvv5YBId2JAWG948dTt4jb/OBYOcce8VusFa7X4hJeGAjmyx6ZCS1DzhgRFONjjv5FsgRxZHEkoVwymzmyTQVypAfgkmzOC39TeZXzkpZ1M0dC56GJdVb0B90u1l/PxhdtZ0eiXDEMvAgJmABn+mNfHUlGtWnW0Zk4oNysTKAy5KbBtx3UWFjZZxXbnR771NwtsZr858wStof0l1YXz4HLzx8FpfCcMeKtDITDwE4c+NZYURZ/hOI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(66946007)(66476007)(66556008)(478600001)(8676002)(5660300002)(8936002)(36756003)(6916009)(6666004)(316002)(41300700001)(6486002)(38100700002)(83380400001)(186003)(6506007)(86362001)(44832011)(2906002)(26005)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9R25hUY1tyK3yN/obNcwyApzl385X7Yoogt9UrHyfbek5Bd8EuoVC8mv1tkl?=
 =?us-ascii?Q?tu5ftlMe6giIACbRJZoPrwnkaSCoL0Ppu4Q10JfRjvTEIOc8BEGZX/iRYWbv?=
 =?us-ascii?Q?cGbG2k/S14XWf8++Qtrz3xKpN1xV2UE0SMl5+RO9/8ClBoCAa97Md0Tfos0i?=
 =?us-ascii?Q?Mdn57zIt8Vo57mUx0BLh6CFRbM6ELAvJrOELvE8ub3uzCU+h8APObaROsqjk?=
 =?us-ascii?Q?t880bT3tDYrvhPx1dAdkcVq/apajSxy9IVqjwPHDiAH3n0Q4RDq0SzEVNiFD?=
 =?us-ascii?Q?EbUdLPhS8xyjIMVR/6uLIWw3fPQB0ChRcg6/GFNPhsAKRdWrsYukWxNEh/2x?=
 =?us-ascii?Q?8SZCNuV/hBvxEtoajsBsf4h6+fTeEQtMlW8yPAQRWWLlPSoo+aA68HFA/N1u?=
 =?us-ascii?Q?v2Lr3vHzSgV3xbSZhIcVYpe46pjQYRzkaq5bb9EENYMbMuGV3cyMrWTuEFHC?=
 =?us-ascii?Q?mP618ica4wKOMKXhAkAIitJdjagT0BL9aI0oXUhn3D5bKMsb/ne/D/EJyzSM?=
 =?us-ascii?Q?rfCNE9CJMMFC/FY0sXvZmweKozY5CFK7CWfp8NGBgeqDfYPFlp4D2jPbnhYS?=
 =?us-ascii?Q?DnEwMb0RPXgFJjGDAI0+q0m+kEO71IN74STdbvdpqYwIdXPZgaa5gEdmiKGo?=
 =?us-ascii?Q?kosCPYHjvatSIStYgUf+cJWEKkkI7da63v5E1pnKPsAYXj78u9q6GSy5qKPX?=
 =?us-ascii?Q?BeFMdTlxE7x7W1dsg/tOJChS9Qhbm0VOvZqVeOdPyw5RfoBy9/rZ6wUzz9N7?=
 =?us-ascii?Q?DvEbrhDLGBQUisbEDr0uwrg81pnfaRwVhOQH+1rvVlZ+s2Fn72NG+T37E40+?=
 =?us-ascii?Q?0jBBR3PxUBlquPRhXT10iGDyIYHypkY5o05KmnARCq1/uN3+vVfEI+DkAscX?=
 =?us-ascii?Q?4dX1eCpHqxk8zejUkfd2Irv1e6Enf+7KaHLX/vQCrINVD8+HUPNA3R/72rX0?=
 =?us-ascii?Q?Z0rAs0wTkqBLs14AcCVdkOl6OsmzvhrYSKsZn9PXfujry4gnwYfP80Inc07X?=
 =?us-ascii?Q?3J1309+AerwyNmg4yg6S+xwGyFtMnHn6zOhUI9OJyHn0nPtI7xDZBTu3qnbL?=
 =?us-ascii?Q?njrpaR+bNs95p8NDv619Ra2vyBkudl3K3j0jp2JhGx56k4rnuTqVuchcrqmO?=
 =?us-ascii?Q?giL48DCaMQxVTIMQsvENUO3XrBb+f451+yXpkiTQYO5m2jXX6OFPn6JMRo70?=
 =?us-ascii?Q?S0HeOTROVtQF6HuCfJitvErvVn/NWaZV9JrK/+v29351yBYLYT3rrVV8FEeb?=
 =?us-ascii?Q?v9KVkbjYTxA3oCE7ISaZBAXTsqexE7yBK2ri6wtxG/vO8/4iPDxEH8sK82kJ?=
 =?us-ascii?Q?QLCpRbaI+YnF5vjFBJBwT+WOCrZudyHM2L6No6ozKCYhN0x05jg/KqTKb0bL?=
 =?us-ascii?Q?Qm7vnEWwNfIenA2Av3ZxZyi0Tccu889wZWxN963a0WubgfDiD0W/8cqpn4NH?=
 =?us-ascii?Q?WuA0ckduE26Pys4CaMbJAjZ9ieKHLjxdkjIYwHaXEfa+OX0Jb5jjgVRE/aGL?=
 =?us-ascii?Q?PgsOtpDRW/YxuEG3aaaQrBCnydyZCVuf7JYNBPZBdIF6l4AsZK2DBKxcrUgh?=
 =?us-ascii?Q?4GhGnh44+uFyHmi/2A0G8VNr43BDYVs+s6KIGQW6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nDwusoTwwBHBOxW9+WYDJFgcZVgWh0h+lxrQC3n+7VB1mhKY+4LfIJEX5DgEC/lL4J2ZqD92taMLdZe3t8lx9uFMXIaiFdqF3h9X6QhiTRmLssS8SIfWYvsnMF4WUViwpzgYI4rz9UeBv7MCym+dTieT8uiERQYcpwctxRB3uBw417l4cvKbvR6JVoRCIWGHb8BSXYfjp6QD05W1NlgQgichqp+9VUTNkYSjHrpDgurWrEIHu15h3q0qSj7McUXbaATsWtv7GeM8Bn5xsYj1xtYbk13K1KBbOkai37aWgs6JCs5uWogsR94Vv1OIkYu9fH1jVdaKBM7C6sEOStKPq8ocMGWpYNWkLFSdhQ7jMgMWKkMa/tWx46yZVy2TQP0LPErJlaubsySw5PAhSuMhERrZB3ggOQQ8g8sseQzX57hkqVL6Wy8yM88BZKeVeNXtr7SWcCnhMjvVP4SjNx7mipyN+J5gG2bmlnWqiE/JxyfXKqDDux84wPJkKsY7Pyn4vr3xzr2FREbVwFDsvgrt1gbQNCOeHaHZs+ept6NrqgYxQgp16HKy9tLzQNjGCexv2UOXK2R5G3aJN5ev7cVmTG/kCPv2kaOOPTXrBn+waY0M+wXEsrhmnJBx3Rtv1J6sXuJWQW+OA13uEJbZrvxFiddE6xvNR9y6q4y+lveNzb7cWd/xI+yPdefFkOqXSDeTKC/KKdMsO63VxCx6xdKcUZIb8rfNzuUI45tcUZ9d0/+yKqM+wPR++rQ67s38gDkJS3Legg7r4SiAjlAahQ/GpA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02c4012-d82d-4b11-1dca-08db6bfb913b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:47:22.3454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrYBbSoicvBfYJDeIqvA2vprQE1YGGJEL1Hmvvlt8YirIrosWx1BdPbay+8FW0b6FjuPsNYgwF8N0e0IS5C2Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=674 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130095
X-Proofpoint-GUID: o7mV-McUunU94s3dB5XoFK2257j_fqZC
X-Proofpoint-ORIG-GUID: o7mV-McUunU94s3dB5XoFK2257j_fqZC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Separated out from the preparatory patch set. Depends on the preparatory
patch set: ("btrfs-progs: cleanup and preparatory around device scan").
This set (along with its preparatory patch) has passed the btrfs-progs
test suite.

By default, btrfstune scans all the block devices in the system.

To scan regular files without mapping them to a loop device, add the
--device option.

The option arguments follow the same pattern as in the "mkfs.btrfs -O"
option.

To indicate not to scan the system for other devices, add the --noscan
option.

For example:

  The command below will scan both regular files and the devices
  provided in the --device option, along with the system block devices.

	btrfstune -m --device /tdev/td1,/tdev/td2 /tdev/td3
  or
	btrfstune -m --device /tdev/td1 --device /tdev/td2 /tdev/td3

  In some cases, if you need to avoid the default system scan for the
  block device, you can use the --noscan option.

	btrfstune -m --noscan --device /tdev/td1,/tdev/td2 /tdev/td3

Anand Jain (5):
  btrfs-progs: tune: consolidate return goto free-out
  btrfs-progs: tune: introduce --device option
  btrfs-progs: docs: update btrfstune --device option
  btrfs-progs: tune: introduce --noscan option
  btrfs-progs: docs: update btrfstune --noscan option

 Documentation/btrfstune.rst |   7 +++
 tune/main.c                 | 103 ++++++++++++++++++++++++++++++------
 2 files changed, 95 insertions(+), 15 deletions(-)

-- 
2.38.1

