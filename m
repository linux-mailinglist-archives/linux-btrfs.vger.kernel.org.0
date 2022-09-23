Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC3B5E7DB0
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 16:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiIWOzf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 10:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiIWOzd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 10:55:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A24F97D74
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 07:55:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NCxD4L032690;
        Fri, 23 Sep 2022 14:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=JEyHZQVaKtc4RoXKRtApxTNaF3mYV0+sR+HCCPc05RU=;
 b=niBfZW0gP/2FgQZhTVbGnaZ+TESpfZStF+eTc+ra0LzO0kcrcsK7IEIfEZglVd409MjG
 9wRlKSYEO9lxQCDmqXCS3dv05JSXt0utouzWUPvpZvPxWkqGKXz16VV35IgQ1dMT2dYm
 syaPPQWkHrPiUNuRBKf14+EfsdE9szMkgxH/qkwUJHrALlSisXzi8JW6kClmaf/XH7tz
 62jtCYSlf5DU1PUwceClK24cy0oDQrfTttAqOpgrklvmBiv2Za/noNZ792Gv6rryTglN
 On2mzs1uAlSVGH8vfTwU4MA+Tt8S76XbjR96XgF3UC4ZvVePtYAzatKSPnM93tFbifNx Ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68mgws8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 14:55:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28ND00LY001960;
        Fri, 23 Sep 2022 14:55:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39typtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 14:55:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkrCL3IFnT9JjUE9kJvq7o1WKMRPs2r4/8NC3rbaxdZuMkkt8VJrrUEsj1nOrHi7dQuCShq+PuuOzijJwIHuzY87AZwPNMeDKjuYO8tEahv6ZZh5TKG2O3VNb7oXAACocdJae0l9UgZ6CrXmvbQy3cIB66XpmYac5ExlwGVjUyTY9WFkOV1ixZWnlz7sXChUd9qqMev+mVxit2khKxVAO4U+NDNVsdSM8K+YVYB26sk+TnxUXWWIFXR9HMLQH1xyCiNZDqH4tr6a5etMSd4QyKDaO8g0dZBHg0VaEYXCwOsr8iGU6Yc7OmLI2G2NnoSZWvJenzBt0beywqld+M8kOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEyHZQVaKtc4RoXKRtApxTNaF3mYV0+sR+HCCPc05RU=;
 b=Xdndn2psAKpEzG7xDMmQP1AmqSUQs0pyrbC7eazygCzsUjKyAPTqoCNjCRf5fDfSeT8kuhu1dVtMNapuMuAMKgpeeH0DIpiFlbeLVuE4O0jI4Cp3m73tTsUrB2pGV55tMKR7BT5dCDzyaDaPltcQ7IvdNUo397Ya+kOFlOw/PSe3DsmugXqIFFmezzG/xuu+AjQGJIaUubo+5THjXjkTA4hkQ80qmROi6GleIWVO11LPWK+d2+wVlVM/LJFQ2bDAMMv0EiocCYhCpR2PEO11Ehc/aB/LklmozBlWUnw68CN+7km7/X+anRiel2BR7k7860OiJlYhjd6Fdxra987uDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEyHZQVaKtc4RoXKRtApxTNaF3mYV0+sR+HCCPc05RU=;
 b=IBxz52XGGf0UOKnIsX41X4Gk88k5eTjz2rqoxkfESwX0bFw4xo7C+DPFvG3mX9/y7PMp+4qucaITYL6n/qk5Ge7noXzdBrkDRQ1tcKxXSQnJbNL2i/ksq1jIWUX4ZCC5T/ZELkQzmgWU6g7hZEQXBbCj9OVXzZNvJWt8x93cKi0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5097.namprd10.prod.outlook.com
 (2603:10b6:610:c2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 14:55:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5654.019; Fri, 23 Sep 2022
 14:55:27 +0000
Date:   Fri, 23 Sep 2022 17:55:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     josef@toxicpanda.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: make can_nocow_extent nowait compatible
Message-ID: <Yy3I2J2MxTZQQNjs@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::27) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CH0PR10MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf343b5-de4c-40e1-570c-08da9d73a667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnQ8ADI3TCSq0TC97+Vd7kbkfKDIGRkXjijQPGCdSYlsr6EV9QRsHkDkQSiCrs7V8Zeh7G4ESWs8GnR+rNE5ZjHptvKK5enyzXZKiOYrpmUDMUEXibZ33/5KGA2IDeP4klTjvLxz9kjoqLa4uGi353Q/sdH9KKJkTyrsTHcv4E7cbKw8Qn5cimUV5yP9aFs/YlrJ7ka4edGoFIhMfXlx37lU1UAETnAITnl6/hjqWt8JPgdX/4LAS3HsV0nAKkgTj3xwHkfayeDByhssNe7ZQ0YFLDxejjqUJuT2hvbxQ+0I3i/uOQOA9/geab9ORxl0ulYfFynnF6SrgVEW4y1K6Uo0pPkwBLXO+PhGn+wbTJ9XkoG32/s/iZgH4gSiM0OXv8nOs/Zzl7h8CTyq82XEi7VaIs2jl1X6DwMdyeg4jhJ8LWvHYhj4Lo/EanyREhai3I622Tfv4q446F3Pvp9DyIliv/N+93Zo6vyAVWKLbmrZqXgu2IN32KbT5axiDmVtX0bMl8IADdYSSbg/EAMGJNBptva/nPxxLKb/iikikFm1uP2/l7KSDi3Y6q10YnQapkSDTwrvVSfCiLqXmhV5IQ8Q6bRb1HbnaYwH6P5nNKa8naNIsDVmnGenpR883mZ4J8UOephkFEDa1EdJ/eCcL3R4c20Uykqh4l3pyq7JGiZA5ZfzCoEirVnxXcRH338Ukmix+fe6en5r/y8dHMTVneIv/5vn9vguS8X7LDayPwicM5JjZeiL+ITqnY+UR085
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(33716001)(6666004)(26005)(6512007)(9686003)(186003)(83380400001)(6506007)(66556008)(86362001)(6916009)(44832011)(2906002)(8936002)(6486002)(66476007)(8676002)(4326008)(5660300002)(66946007)(38100700002)(478600001)(41300700001)(316002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nDmdLbZ+LEVaDAGSP5OFnazy8LhZ9GMI0ebOdGttqfoyTRSLQ4AkeG3jYGTG?=
 =?us-ascii?Q?kQd5Ekr4C+DlDOUzwB9XigMNoN8Xzz/JGO3fzcJ1/5S85qGklAdV571YDGKX?=
 =?us-ascii?Q?Hr9uPhUqGDjCvvLFHV4gHLZjuRYZDwCu5h7GCwYJL56RQpiixPtiMfFEbowG?=
 =?us-ascii?Q?hiNesfTjtWJ89AspoFPtkfBuu6xDjGpOSASE58GO2ziGF7Lz0vuahyoBsqXl?=
 =?us-ascii?Q?RmPeFBJtw6PmRW+M6xnsTPRvzdvAiBiPI3rZruLQGaeFu08+BM0GLf5ax68X?=
 =?us-ascii?Q?xklH3Z9ADEg/ppDChiVi+2odn//lQXE1OIzb7YG29LWfb1KeZrXSN1z90l/2?=
 =?us-ascii?Q?RZwRpLdIMOB96UFeC6JLdsTP4qBidmJ6aF5miDRWTxwgdexlQGRCELQFrFSz?=
 =?us-ascii?Q?oUvHVtdzAJRhwdZyAzN9bv9WQsxewYnIKLhfvj04Qpon9EP3ZFofTuaFbdfH?=
 =?us-ascii?Q?z1rV5z+usW1Wdf72nF3v3XD6+YmRbnwsn/ABYuTlquQ2HqSdvQBDTK8IkxG4?=
 =?us-ascii?Q?WVwiD+McSvKgU9TBxSMAs/zc3X1yii6gMTjIcFyiXIwJY9ae3WXoWqJp03al?=
 =?us-ascii?Q?8ck6bae1qDVrU/Ssc0tluh/a1+0N9PFSYds5jFkxCuW1XPmO9WiiE6hLPI2d?=
 =?us-ascii?Q?d1hzDiTGsRVtgrIbD7maQNMu91zMAxzpVtoxY1CK2rGPnH3JIBreV1q9vDjk?=
 =?us-ascii?Q?Sv8EWbHXRfZ+UFC3wS9KBhETjYHwYMqQdjhjOqZkVQ5PfTRIzCyZ0WGKXfeD?=
 =?us-ascii?Q?iDUPa6hJXF5mZN6cxj/L6jMznF4oyKfLh1fT3y12ZL/N+/NtM8VBIE1rDjFP?=
 =?us-ascii?Q?TFD8tS6da7hfoglWry7Z6LtLb7zQ2ARoZTYANpFztVMf8nC9jeynUzzzMry9?=
 =?us-ascii?Q?2DiAhboGBb4Cs6GPKKL2ncHMiUnMpuE6CnJxN9VTt+70/oAYfkqyF1YNpPGe?=
 =?us-ascii?Q?MahkCcEE4xPVk0PB8Ov5RTcYdAIR7Vl6RiUoroeFyX215btZjw6Qk+RHaLL0?=
 =?us-ascii?Q?N6ii6Z6pja/LKYmlc9yVmi+NGDz4CCplPumVBFFdL2V5MFZIc88SwjlSXG8J?=
 =?us-ascii?Q?93s2cOU6odU5+kFT2Wp3NlP8ZVufSCbUeSgY+mCnrJLaoIU+D10It3XwqS6O?=
 =?us-ascii?Q?p76Db6sigUSQHy9bc70yaLfCmwqWVmDJ4cySB10w8hEglPWKHX7aS00eSWft?=
 =?us-ascii?Q?gwRhLDWEAqy9aa7IVirsNO+8RnmMZFE/MZUsx3+zXWzDTJ1juYXImXRWUrLy?=
 =?us-ascii?Q?4i1I6UFdaM35aGnLjKkJunwVsZyVNcyCDERdtsLISM0kD9gfKmy8ZC6cwR+L?=
 =?us-ascii?Q?6NJPO8G4km9D7QyoUrsCH5QwOYcPrMEdjONXLGgu0aPGvZCTcLUM9phRfwSj?=
 =?us-ascii?Q?uF2K+FGiPCEsnHeCtPVRAJrMmpMxlgkMJRmpi7+PCz9kJjCTq87bNbKypFTt?=
 =?us-ascii?Q?IcfH8MeyAC4JEm6775d17Rr8QKt3QJ2PIsxlaKfLEK+LGjw57IeacHOX50O8?=
 =?us-ascii?Q?weRpILx1bozgCR82DvIHiBSIwIv994Hy+wPILpCtLhres1f6mGoAy1jf191U?=
 =?us-ascii?Q?/xVWPC62IQI21pNFbXQH2ZsJiWDbT2VQOKRYwRtRtP3L0r0SVoMeyF+gXcQp?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf343b5-de4c-40e1-570c-08da9d73a667
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:55:27.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkE8TG69NgffrsXrZHBCu05P6k0CeQ5aljiig3TyDD4qEJfNF8cLcuxijJrsIfC00qy3eXT4R8L203Sl6il7tk9gzb3gYOraHAsL+ZhTyQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=997 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230097
X-Proofpoint-ORIG-GUID: d7gFkoaKbGUPqndE51L6ZGc1zX0x5zbM
X-Proofpoint-GUID: d7gFkoaKbGUPqndE51L6ZGc1zX0x5zbM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Josef Bacik,

The patch 9ec9594f6de7: "btrfs: make can_nocow_extent nowait
compatible" from Sep 12, 2022, leads to the following Smatch static
checker warning:

	fs/btrfs/extent-tree.c:2225 check_delayed_ref()
	warn: refcount leak 'cur_trans->use_count.refs.counter': lines='2225'

fs/btrfs/extent-tree.c
    2193 static noinline int check_delayed_ref(struct btrfs_root *root,
    2194                                       struct btrfs_path *path,
    2195                                       u64 objectid, u64 offset, u64 bytenr)
    2196 {
    2197         struct btrfs_delayed_ref_head *head;
    2198         struct btrfs_delayed_ref_node *ref;
    2199         struct btrfs_delayed_data_ref *data_ref;
    2200         struct btrfs_delayed_ref_root *delayed_refs;
    2201         struct btrfs_transaction *cur_trans;
    2202         struct rb_node *node;
    2203         int ret = 0;
    2204 
    2205         spin_lock(&root->fs_info->trans_lock);
    2206         cur_trans = root->fs_info->running_transaction;
    2207         if (cur_trans)
    2208                 refcount_inc(&cur_trans->use_count);
    2209         spin_unlock(&root->fs_info->trans_lock);
    2210         if (!cur_trans)
    2211                 return 0;
    2212 
    2213         delayed_refs = &cur_trans->delayed_refs;
    2214         spin_lock(&delayed_refs->lock);
    2215         head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
    2216         if (!head) {
    2217                 spin_unlock(&delayed_refs->lock);
    2218                 btrfs_put_transaction(cur_trans);
    2219                 return 0;
    2220         }
    2221 
    2222         if (!mutex_trylock(&head->mutex)) {
    2223                 if (path->nowait) {
    2224                         spin_unlock(&delayed_refs->lock);
--> 2225                         return -EAGAIN;

Call btrfs_put_transaction(cur_trans); before returning?

    2226                 }
    2227 
    2228                 refcount_inc(&head->refs);
    2229                 spin_unlock(&delayed_refs->lock);
    2230 
    2231                 btrfs_release_path(path);
    2232 
    2233                 /*
    2234                  * Mutex was contended, block until it's released and let
    2235                  * caller try again
    2236                  */
    2237                 mutex_lock(&head->mutex);
    2238                 mutex_unlock(&head->mutex);
    2239                 btrfs_put_delayed_ref_head(head);
    2240                 btrfs_put_transaction(cur_trans);
    2241                 return -EAGAIN;
    2242         }
    2243         spin_unlock(&delayed_refs->lock);
    2244 
    2245         spin_lock(&head->lock);
    2246         /*
    2247          * XXX: We should replace this with a proper search function in the
    2248          * future.
    2249          */
    2250         for (node = rb_first_cached(&head->ref_tree); node;
    2251              node = rb_next(node)) {
    2252                 ref = rb_entry(node, struct btrfs_delayed_ref_node, ref_node);
    2253                 /* If it's a shared ref we know a cross reference exists */
    2254                 if (ref->type != BTRFS_EXTENT_DATA_REF_KEY) {
    2255                         ret = 1;
    2256                         break;
    2257                 }
    2258 
    2259                 data_ref = btrfs_delayed_node_to_data_ref(ref);
    2260 
    2261                 /*
    2262                  * If our ref doesn't match the one we're currently looking at
    2263                  * then we have a cross reference.
    2264                  */
    2265                 if (data_ref->root != root->root_key.objectid ||
    2266                     data_ref->objectid != objectid ||
    2267                     data_ref->offset != offset) {
    2268                         ret = 1;
    2269                         break;
    2270                 }
    2271         }
    2272         spin_unlock(&head->lock);
    2273         mutex_unlock(&head->mutex);
    2274         btrfs_put_transaction(cur_trans);
    2275         return ret;
    2276 }

regards,
dan carpenter
