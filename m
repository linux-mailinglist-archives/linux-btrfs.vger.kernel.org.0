Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A233F7348
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 12:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbhHYKaZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 06:30:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64316 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237979AbhHYKaX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 06:30:23 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P93DbR015014
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Aug 2021 10:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=JQx/aU1VbWIwQouIf07fYwmWMTCqly1J7ozxsmo8HtU=;
 b=juaLHuGW7dYGPojm9whH0CafBRnBw/OeyF2js5EiSPSn1+5P1TyxB8EfCyqCuRw0aoZG
 4NfYeazpHDqn0NweLPbwd/mNXhOBWgbN5xFGJPL5BJxYWnaEfgAAXNzZeuMZ+ryBNNzq
 prvhBBUH71KtLiY1QRnKp6UrjqOLnLe8LapNAXlYSuOtw2d4MOZ2sjdA1C3+ozRZd9Om
 juEalLJJ9eDm45EiT6g7Mohm967GAv5o4tthm+J3eoVZLJKT9ZDwRCN48rG8EdW3rH4S
 286I1WZatZBITZoEBCeAbY1u3eBs5SfahNI+FDRFxh+R79s+OiF8kuDJFAYoh+7tsU+3 HA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=JQx/aU1VbWIwQouIf07fYwmWMTCqly1J7ozxsmo8HtU=;
 b=wh7DKLswHrWu7zKC2/x+bxUaQac/V2HfKx8va6K9EJNFyRFKPeEX3Ikl38Kjd87tKw4x
 gzB86qgs+DS5GnWi83FTCIkUCN4ISez+2RDP/fZRUyD7A35H1H4e7CXoDCL6ud1rsyhz
 oU24tBfTZD3V+2Cmxhm5xOFBHjFDadm/A0kFPIzYfWhQE47QfyZ0HjXDrQBfzMKI3oHa
 xb7oWk25Joge9DqU4vG2qv6K3nB4ARO1x8avUvbDYXCEW6zjbbafWhK5+hWJupOkbVrJ
 REmts5+SBKRvzdpQVIqeNC/TzFOK4ek1NxKb1NebfNBEf9pQW1Wi4H50xQ/xaHZ9Dr14 zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwh6k38a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Aug 2021 10:29:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17PAPIk0125961
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Aug 2021 10:29:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3020.oracle.com with ESMTP id 3ajsa72dt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Aug 2021 10:29:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljb/wAlOKwsrvXZB3grn4tiolUL1Sz154telmhFwxFUUE8pCmQas26wYHrTPEXFfA+n/xCT8w9/Ls2vsmoEZQSCrSGKI+H/viO46FyC8sq0sO8Cna07SkJceyQfH9YSnf9U4FITfGxFb5XiaRYASI2qBB5gWh839Zn7ey0Ejw/Gr32zKRqt7fSgj9r6p1x8mrgcwHMhfzH8MZSUqY8vkINTxpCPea7EHavrut0K1gam4CDq4Jgio1ZHTaUS+TiDZdLFF5tmjndrHd5iZgt6Ysber5IVLxbmMM1w56ps/kHexH7i1sl08vZlmVpnxr55Rb88tUb9DWrobFzC9mdUFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQx/aU1VbWIwQouIf07fYwmWMTCqly1J7ozxsmo8HtU=;
 b=e4fyC/yfyDhrvnsm9FgSFTdGruqb7IXhIZS0FDdJVgkFVLlQCg+vJxcSQQfDnJ7TnY4tK7H5rgX0PP6arp3E1NAh3O9ckGwxQO8s+/jU44DH4Sd+ZOI1cwSsRQWVo1NPlZg+SfSN4e/iXzQvjhmkfA2m21oiYkK9Rosfwkd/Qq6LaorLaxHosCz1whQWpfLdcY7imggFs7VgcpzER3tVLwuJw+M4WYUcrgA/GZdScRpnE4smkK0ICAcUmI6RMM30ZrZ/brGJ6ELBN1DpEDKuIHOTneb7JoAARpPp/wtz6fGypcJSjB/jelQ+qIKEW7feaVWp/G3GSh+UCNleekSNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQx/aU1VbWIwQouIf07fYwmWMTCqly1J7ozxsmo8HtU=;
 b=UMISiAqVabXutezBf+LrUuuZWGgQNKUpgWgSmuTQPO2sijqGEDmMRhT/oiO28FPgG0OEoEi5fXkVNkiKQDC79+YzdKrx+4WfHXRTsNqiPmUyZnirc8eoV2lChFfAVgjazHayb++1UqsoU1c5JQCYxjXuwd53kfWUf9t6O+fvkc0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4707.namprd10.prod.outlook.com
 (2603:10b6:303:92::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Wed, 25 Aug
 2021 10:29:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 10:29:34 +0000
Date:   Wed, 25 Aug 2021 13:29:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: qgroup: update qgroup in memory at the same time
 when we update it in btree.
Message-ID: <20210825102917.GA2486@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AM0PR10CA0124.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::41) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (2a02:6900:8208:1848::11d1) by AM0PR10CA0124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Wed, 25 Aug 2021 10:29:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad9f9965-8020-4c25-e46d-08d967b33b3a
X-MS-TrafficTypeDiagnostic: CO1PR10MB4707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB470704677FA1B465C2DD2C5B8EC69@CO1PR10MB4707.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZ1APz5BKeNzRID/M4v6hMs6cPds7FYPMD+DDBhz7X+Ex8tS9jBBDfO4Td+WHcgdvq3XSRl0ZhhvYtJ4nKLKkozNL7T+A+cCsET44GMm7vP6QdTnIZQNhPduHRhLzy6rvhR+MEbCOeYmjFgviaeLJb/cF09q5+/7LckEJoZTQfQUyzYOrMauKA6+re+GgO03L6oQVVncn4+XfEp/JoU0S/X+4yovDxelqcOFphPtKiY0qaccHh+Jsj0yQOzkgfP+RYlYNSS4HrZJUW74uY4c4qfkyBwUIbSQHx45dPeNFNNQ1RJwTwSVQMW5uRfbiuYzNLIWJfYyqGE96H6mOd/Y0arewVDe12v72gvdlWVx//bJCfOr836uMzp06gNVQdlcoH5QWw0VJkMef6Evpz6PGEW2n4ku1HXCt9eEJz8z4TMVfTYVoJ7iLdoOhdYmrGJfhS6nC3dAV1SQukcnU7s8GhERRWca83UYHOfp4h+RTgdd3d7IGavSBljdbSDNLfDC9G6uiE5R4ZyIZAvna3M1HscWD72/zthHk6R1rAwlY8uGKettfh0snZ3QxlLupgU4ZSaYi1pUiFqw3mD1qZ3Mtt8ZMnQkswbTZ8oWDRW1hMK30r9c6xJc4BJs2oXq1kL8P1baLsOir2/2Q3frtkJgyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(366004)(136003)(66946007)(478600001)(186003)(34290500002)(86362001)(5660300002)(6666004)(66556008)(38100700002)(9686003)(15650500001)(55016002)(33656002)(52116002)(9576002)(8936002)(1076003)(316002)(8676002)(6916009)(66476007)(33716001)(6496006)(44832011)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aja77FpdOJIW9KUceBM3Jo1kxcycPGBKD/hc0KGSthGVqHVr6pk2TQgMRe7/?=
 =?us-ascii?Q?wXFzFz3zSJceHKCVU1Xhhw1omdcYTuuJYE5QlvDGkfiRNW5JHmymlsrsTFk5?=
 =?us-ascii?Q?hu7TjBTUgGYrVMTKFtZIi3nl0rNVBJiCULPEm+UgQvbmgjgZIE0Z9oY5YZw4?=
 =?us-ascii?Q?/px2pwdGJN8piwN9VwpjZ8gsW+S02fDcA4KKU3EAt7Q+wqWSi/YgxgNeceVm?=
 =?us-ascii?Q?im/cvUskMB4uTKbnj6wWmrcN3B0qpSk3LJLMtrQdMDIn04IBEmHCd91oZZ8H?=
 =?us-ascii?Q?PFwHQseQSiQZsaggVV2nUA9exWeZCu6uPHZ704mfzTeuytzt8c0QlVdELMt3?=
 =?us-ascii?Q?G0ZuStcvf4E8008La9vaIEqrANsyHqT7JDWkl8XGAH24yTJ2QwsLldlAR1dK?=
 =?us-ascii?Q?LqBa3+zDmFT6mpxvqTcuDjHhGL7xjAfmuzvYZtDp6Y0d/yF3NBIVwqjH+Bxm?=
 =?us-ascii?Q?sHJxtiZLqYF5xzouri/2sdeWIK/iRLBENJ3vjvcmtjvQrs63G578iM/DQI53?=
 =?us-ascii?Q?uulHFO8rs73Jyxh5mBIRnYRY8P+BUZeZUo827JTPagP0/+uT2IC+rVjVKHQc?=
 =?us-ascii?Q?dDYlAwDzbxpgTbK/5QQc+kti7eHCJNHfdNJV7nSFBN76xhKLAONMcbx6Clin?=
 =?us-ascii?Q?RFk8YJN5iwCCZU6C+K3bdosU/yZOkSygqSFp1Gb2TyWcx4DIZd7ejWvqgABh?=
 =?us-ascii?Q?j8Nv7altGcUP/P5jff426W+b0koGoBLVhIu4HcH6RU/utoUG3Ave2Z9Qwa64?=
 =?us-ascii?Q?rcEp1y3d84LmOk6i3TsuIuDNKdIUWq7P1+VGXBdVs6LLp3TCm7rOk7dEdVs2?=
 =?us-ascii?Q?yWL0WbKbMFTD8lIZclSu3ssSlLE6Cz6spJGtFR6Kvp9A9GAIDBa+IhPU7uXS?=
 =?us-ascii?Q?eXN8zfIY4tbrnT8nruYG3kVNXPu3lzUgLabLeaZx75dw7sAdxLQy7CeDyDLs?=
 =?us-ascii?Q?MEqcO5ZprwrA4f6/93jw1Z5paPNNH7WFa9bYqXjmIweM7ptBoQAE7/YDv+6k?=
 =?us-ascii?Q?TUyeGDizk4l+NxRL5ocH4x4/WHaOUT8prtQus2sywsHbdjjW0AkYgaJ0zAHm?=
 =?us-ascii?Q?YnQGAGGmPaeQoZEXYGKWWKj3ZC8pquScr8NI+UMoYjY5Hp9j8/H2EvJ4GtU9?=
 =?us-ascii?Q?82wUEazWECmrbQiQ0+kZ7FHnxmnJvzNmaq80nM94B0HLp5wm1hv4DYveTOuk?=
 =?us-ascii?Q?V2UoJqK594UDPIpHPMa14WImo5O5knhMrX/rLG6GkEb9CMVgqaEeo3MjbN8K?=
 =?us-ascii?Q?8QrP9SC/JwuD9tF94Vmv7MBQ69lvWbTRhkbmy2S5n4F6pH87673zCAnAN/PH?=
 =?us-ascii?Q?j/YjGocWNZK3Eb/CbmqbK/1jwlIzoZ1J9XH7715asRejta0zzQ3lxXVvJrbi?=
 =?us-ascii?Q?AsZqFr0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9f9965-8020-4c25-e46d-08d967b33b3a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 10:29:34.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VY9AW12d/+4MbBCzuMK6notEkYgcZyh9U/X1jflG+zP66OzM+qhiOWKSJAdh1ZDdOmtR5tdy9TMRbgrlJxCngQy7DjGVHuPnSoZb9pdkXJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=561 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250061
X-Proofpoint-ORIG-GUID: rI0IZRF5Esu6BSTLL57pdeB0tALGJFyv
X-Proofpoint-GUID: rI0IZRF5Esu6BSTLL57pdeB0tALGJFyv
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[ Ancient code - dan]

The patch e8c8541ac379: "btrfs: qgroup: update qgroup in memory at
the same time when we update it in btree." from Nov 20, 2014, leads
to the following Smatch static checker warning:

	fs/btrfs/qgroup.c:2850 btrfs_qgroup_inherit()
	warn: sleeping in atomic context

fs/btrfs/qgroup.c
    2817         if (inherit) {
    2818                 i_qgroups = (u64 *)(inherit + 1);
    2819                 for (i = 0; i < inherit->num_qgroups; ++i, ++i_qgroups) {
    2820                         if (*i_qgroups == 0)
    2821                                 continue;
    2822                         ret = add_qgroup_relation_item(trans, objectid,
    2823                                                        *i_qgroups);
    2824                         if (ret && ret != -EEXIST)
    2825                                 goto out;
    2826                         ret = add_qgroup_relation_item(trans, *i_qgroups,
    2827                                                        objectid);
    2828                         if (ret && ret != -EEXIST)
    2829                                 goto out;
    2830                 }
    2831                 ret = 0;
    2832         }
    2833 
    2834 
    2835         spin_lock(&fs_info->qgroup_lock);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Holding a lock.

    2836 
    2837         dstgroup = add_qgroup_rb(fs_info, objectid);
    2838         if (IS_ERR(dstgroup)) {
    2839                 ret = PTR_ERR(dstgroup);
    2840                 goto unlock;
    2841         }
    2842 
    2843         if (inherit && inherit->flags & BTRFS_QGROUP_INHERIT_SET_LIMITS) {
    2844                 dstgroup->lim_flags = inherit->lim.flags;
    2845                 dstgroup->max_rfer = inherit->lim.max_rfer;
    2846                 dstgroup->max_excl = inherit->lim.max_excl;
    2847                 dstgroup->rsv_rfer = inherit->lim.rsv_rfer;
    2848                 dstgroup->rsv_excl = inherit->lim.rsv_excl;
    2849 
--> 2850                 ret = update_qgroup_limit_item(trans, dstgroup);
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This function calls btrfs_alloc_path() which sleeps.

    2851                 if (ret) {
    2852                         fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
    2853                         btrfs_info(fs_info,
    2854                                    "unable to update quota limit for %llu",
    2855                                    dstgroup->qgroupid);
    2856                         goto unlock;
    2857                 }
    2858         }

regards,
dan carpenter
