Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF085F8520
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Oct 2022 13:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJHLvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Oct 2022 07:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJHLvd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Oct 2022 07:51:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C30E52E6F
        for <linux-btrfs@vger.kernel.org>; Sat,  8 Oct 2022 04:51:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 298931UL021832;
        Sat, 8 Oct 2022 11:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lWqjRMBDZRF3aGhGrpwlf57hHOgwDaCaSXl3o/OhK9g=;
 b=DZNASjFjMWEVufMPgv63rvQZ+9JWDYsi7mQ5CQco02yDp5TwzSwPVW4fqgxbatSbErY8
 E6mVPyNrOkMIwTpesmIrT6XVt8cAktZWcZ3Bx3jOu4CyP+r48FSF8kUSm3GZD2lTBJia
 Soyo6egztgtgRT4SRwlSpkbCPYyI39bl/9fxZKhtFi6QRZnvLp4GMk+kQ7ppkcQUZJbV
 yz26IKAuX2pcRgNEiFNtV2AF2oY5AplsutK8RdWHLa5WSAOo/0yGC6R8tma0YBcfSdoJ
 ayjFTRfOnOPKLDo5dGUzarD0Z//u/ia/q/C2qQ8i4tcxW4yR7NkGUyP1pMtLMXGIgs+C QA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k30tt0ec0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Oct 2022 11:51:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2989Mgtu017187;
        Sat, 8 Oct 2022 11:51:28 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn7ybpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Oct 2022 11:51:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX53X/TOUTCCiTHlsK9q8oLz33BV9LvgYoVJ5bwpq4mGnzaksNHzvmWLuvSBXNkTYvkXCCDgLB9l6hFwz5h+0zR0TrImWYkOEMq2j+4oWbIMCZrYtHCRVlQiwyuw7v+WAajpg6iiOGY2n+j738Iqp8sATRlEiPU1zqITnjIimjKNlEbHKaUJFi+p7ytqhN1gke3kT0rkhdmGp3G5i8s08K3cULHkFCLaK9mJ32V9Q0WtdBYpN4ccsW1p1Txr/2bfxwzu3BUKAUgDOzOlrGFRcqHi2fX4lTkixykb0Dc4DCtKOuzRuJ6tRAtvYVwQdY1HLAbj7xOyKIpJ+4B9zOgcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWqjRMBDZRF3aGhGrpwlf57hHOgwDaCaSXl3o/OhK9g=;
 b=SgEMygIMvet2dyAAG9zUSshQ16U2apUgdCiGHYdBiRIVw31CxJrlnVOxpV5K2aarHfqIcwItHuWKplP4h7NqtyyCYxCKNODFExmtGlsHg0KWHOP8ZRqK5cO+xm/QT++d93IA4HyETolt7PtjUHaSQ62p2b+JbJsvGM/h8pnZW1vGO09FKvTcfJuF5O5/1ELiiwYeaAtALdShFD4Gp9jw7xR+iyXxRXuI89m3C1sAcIK/MgAXWw7EM8+Ef9I46ruWEHvOZ8MIcUh7vwZyaoeBoQD9lcgx3vICtmnncnoLH8YRkI6WP6a+A5z922Ubx0aCbPHt86PJy59FhPe4x1GEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWqjRMBDZRF3aGhGrpwlf57hHOgwDaCaSXl3o/OhK9g=;
 b=pIdiHJ7xYKZ89xW3pUwTUlQ0Mt8hS0tHdYpIiVgEKEPxCSqnx+/tAUPa3X0qpXEKBWvScKIQNISLXeTwB7jFDpIf4NY8s/Xmjj7y0IhRyk1HU4+r6ibhEktJ481VixER6/beRBrESun/XS1vQ8cjBSaH6lLOIQYGtTL/nJrDozw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ1PR10MB5955.namprd10.prod.outlook.com (2603:10b6:a03:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 8 Oct
 2022 11:51:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7%6]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 11:51:24 +0000
Message-ID: <9b8ff079-2c97-8293-a253-913110d64e4c@oracle.com>
Date:   Sat, 8 Oct 2022 19:51:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 1/2] btrfs-progs: mkfs: fix a crash when enabling
 extent-tree-v2
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1665143843.git.wqu@suse.com>
 <265f9914e5f66686647a716a7a038de81bb09aec.1665143843.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <265f9914e5f66686647a716a7a038de81bb09aec.1665143843.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0090.apcprd02.prod.outlook.com
 (2603:1096:4:90::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ1PR10MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d40784-1c5d-462a-5b70-08daa9236c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oc+W9/byyjIhk5Edx7z+aanZ2G8Q/pLvO4cl2dkMGSoc/iSqUWb0hJTu0uXtZ+TkePgHSID2DR2a+TsaV4HpMk746hXvS9ifBRiKxpzQoUgUFA7F2EUUnJj1GwFXdCSiMKFsR/CXAOrhTcNVgZSlg9jq1/HeYsXt/F1iepABB7Cot9H3cvrtODBOEgxyS5/a9e/+HCIdoU4RIbn5Vn8H69nv7nhbdAE7fMx+Lc0xWFnH9w7Cx3pzNjf7KXO0+R1ojfFnvp3yNY+DDuUdGZMqyNUhtdULZQBIby2uStbxwMY3Js3b/+l/GwcexEGlrhpwD6FlrmZrHUkydfZiUIrGTy/9kPISSUQYAgNJnnUOvwN50sZfq22A5RRX4YNP2zJjAGLdYnqE63uAO/07GlYQHhAtMxg+8eCRXB2rZiBlzL/4Y6fmKtada6Y5qnb3cCs1ZJxS2z0MV2DAhyRmC9mG9Koi6UtDT5NQLrusuMHYLyM5cjn4kQefEpVjvGs/bTI6g5g36egFkJQm6QxTlST6K7dqVpCurfdyBHamnqfOWGGbUVf42qDtEzC5gCaqARuD3SP5i8pEuZCfzIIRnHBRl4lWOFP4fj7EM+/zkoSGS1iPV+rICYfpMbnDJsIRF1Mj3raRv312ip0a3Lb3YCpduIy88riEuGf3Vf4IjCbqUL4IMml8v34mnY74S4o4rF57nnqivaegRyyxX/Gg/rZ566DP5x0YP28ERBIjAXH7mUTluNCTyOuqfQiBDHxqGVJnwVXnG1JHNV5fqBXZSVVguHKWPzQfDy2SF7g8lgP2xM3+ee3JkMaB1uEH7WC/OYHE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(83380400001)(2906002)(186003)(2616005)(86362001)(31696002)(36756003)(38100700002)(478600001)(316002)(31686004)(8936002)(26005)(6512007)(53546011)(44832011)(5660300002)(966005)(6486002)(6666004)(66476007)(66946007)(66556008)(8676002)(41300700001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnRrK1o2THEyemFhZjIybUJRcHlEZ0pBbkExTytCdTN6bHh2c3RHc0RVK013?=
 =?utf-8?B?amxGUWZzTXZyZ2UzNlFwMW9GTVNEVFU2eSs0ZVV5SjhNNmdMN0NuTEZGYnpa?=
 =?utf-8?B?K0pCQU1jeE80OHJTTVhESjUyek1va1hSMjVvQ1l1aGliYTJsOGRLU0c2WTZ1?=
 =?utf-8?B?Q1c5aGpkMEdTU3E5SkVlL01kQjBJcVh3QXkvR2M4K1RtazNZN0tLQStaZGZE?=
 =?utf-8?B?eHhzaDhvMFlCUERhMTNSV2k2eTdmMlFRODhTY0x4dS92TVZjdWdjbk9zZk8z?=
 =?utf-8?B?RWFXeWdZbjkrVndDZ0YyTXZub1VXRHZ5VnFEWFJYeG9Yc1JRd1RQZS9qNm5S?=
 =?utf-8?B?Nm5BNnhHbFE0b3RBaUFGRFhUZVJPaEs0UXU5RXhDU3R6V05nTUJvT3FhWkM5?=
 =?utf-8?B?d0FjYnJsN1VVbDlpaVc4QXBjSWVaL0dEeDI5ZnpPS2FmL0h5TDJrM1NmdUZj?=
 =?utf-8?B?akN5OFpSd1hHNW9NRmovM3lacUljbytXTll6NUMyV25Qb1IyK0xhMEMzTE1s?=
 =?utf-8?B?ZGROaFVxdDRBU2hOUk9aeGI3TzF0ZUp4TFBsZEE2UmdueGdtVDkxY0FGaGp5?=
 =?utf-8?B?SnlhWC9rSGwxdzJZd2xPZEdxbFdoZU94NWNnYzF0YlliOEdVdXYvNVQzSW5E?=
 =?utf-8?B?Mms3eXZRMEFUWTN3TWM0M1BCc3NvQ0FZcFlKYTBYTjRqdVJ2VmFrOUk1cGlP?=
 =?utf-8?B?bXB2cm1WNmtPUHRnN3lVNE5SNnZCdFVlaVdBdTZDL3haUE1HUUw5R1Q1ajQy?=
 =?utf-8?B?MUd4RzRiTHcza09nZWxxTmVIMFUyeFVTajNWR3dxbS9oZ3V2YXA1ZUNwdGs3?=
 =?utf-8?B?d21hOHArZTN3MEFxVytCZWdremxEaTYyZENKakl6ZnM5aHVZdy9rTDZPMzhs?=
 =?utf-8?B?T2lybmwvUGJPNElsT3hySXVaS3VicnN4RGNpMjJkam1ZZmowSEdLbk1mSmYy?=
 =?utf-8?B?UDNWMHE2K0ZwWVB6RWhsYmVleXg2SVEwQ2FsVGt1RS9MZnNLZG4vZStMRnRv?=
 =?utf-8?B?TWdXWHlNOVNRdnVEd2IzZGh1UmJtTFVmSVVqMVBkNXZkZ082NDZwTzFBQWJm?=
 =?utf-8?B?eEYyUksvWjBIRkFkMk5KS24vYTBoVnNLdW96V1ZXNXI5WFFqTWtHZDd5ZVVB?=
 =?utf-8?B?R01IanhJM3JuQjFoY3Y5SDd2RGRoMWRuK1d5citqditucGViOHlFTm1BK1Vt?=
 =?utf-8?B?YnRaV28yaC9sQU9pbzd4REdwdExUNXJiVld2YTBIWnlpSUI4bUViWCtCM3Ew?=
 =?utf-8?B?ZXd6YnJqdEpNUGlZemtHZlU3aWgwYno2b3NQQmdMQzlacVpZOFN6TU4reWl2?=
 =?utf-8?B?WlMyQ1JESkd2Y0ZuTkJlVUxreGJ1TFJaWEZTQWkvYU1LQk9ITUpod2p5bGM5?=
 =?utf-8?B?NUtabXk2WnNnOXYrbEJaSERmZkZuMzJVM3NrdU01S0piSGwvK1ozOGZWQkpZ?=
 =?utf-8?B?QnkzbUQxei95b2xMSDU5UXd5Q051SldEM2I0elJZbkJib2crSkNEYmZMaVdw?=
 =?utf-8?B?WFJQalJPb2V1bk9jSUlBM3VyRzlhRy9WMm5HRGhTUEdDUlpIT1JkSTlldjdJ?=
 =?utf-8?B?TlpuL2NOcVRydExiT1JxNllOY2dTME1ycDdSQTJWbWZDNDZvU3RNYVdJRTh3?=
 =?utf-8?B?Z1p2UlpTS29TWXQwZ1ZvWmNJOVhZcEJXZnkwT1gxQWt6ekpUYXRQbXVncUxs?=
 =?utf-8?B?MWsxcmZ6ZUFoVXd5TVEwNm5aKzlhczZLN21MeVFZN2h0VFhtRkdIQVphYUp3?=
 =?utf-8?B?M3NiejQxS1dTRWVzZ2xjNmNFQ0ZhQTQvcUQ2MTJtZVBPT0d0TW5mQ00wZlNr?=
 =?utf-8?B?SVRPdlhoOWI3bkxZWDhnY3l4Zzdwejc3RUdxa0pWSXp0aVRwRFMxQ1F5NGMv?=
 =?utf-8?B?WWpCRUZCRUYrT0VOdGJ0cHZtaGRHTkNxQzh5YURXSWpJTFpxekI5dmFXZGx4?=
 =?utf-8?B?NzhhRTdCVFNtWUZrRnlIcUJud3NhbkJQL1AyTXpxZ05FbElTcVM2cHVSY1VM?=
 =?utf-8?B?QlFkTEo2dDVwL3N5SlQzeWpXWENhdVdQbGx0U1hNTTRpV1pMdWFVd0VnV2lN?=
 =?utf-8?B?TmFabkRkcWJ1VFNNL05zdFpIKzFiOGEzV0VrRUpvTFpEUWx3Rk9HZWVFNTN4?=
 =?utf-8?Q?yNxDzmF1zzsAtePbDUAVDxdY8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d40784-1c5d-462a-5b70-08daa9236c9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2022 11:51:24.2209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0dPE1sZPp4ByOrmdvcWNy2SkRBTp9EXYvPuggOqf65DIlBiw4WlsENHsmeeUp9JHJLLDlv2+4HdKXpVr4J+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210080074
X-Proofpoint-GUID: _2V1e_4vwIbXl72PeN6o8eCb4JBwZ4g2
X-Proofpoint-ORIG-GUID: _2V1e_4vwIbXl72PeN6o8eCb4JBwZ4g2
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/7/22 20:03, Qu Wenruo wrote:
> [BUG]
> When enabling extent-tree-v2 feature at mkfs time (need to enable
> experimental features), mkfs.btrfs will crash:
> 
>    # ./mkfs.btrfs  -f -O extent-tree-v2 ~/test.img
>    btrfs-progs v5.19.1
>    See http://btrfs.wiki.kernel.org for more information.
> 
>    ERROR: superblock magic doesn't match
>    NOTE: several default settings have changed in version 5.15, please make sure
>          this does not affect your deployments:
>          - DUP for metadata (-m dup)
>          - enabled no-holes (-O no-holes)
>          - enabled free-space-tree (-R free-space-tree)
> 
>    Segmentation fault (core dumped)
> 
> [CAUSE]
> The block group tree looks like this after make_btrfs() call:
> 
>    (gdb) call btrfs_print_tree(root->fs_info->block_group_root->node, 0)
>    leaf 1163264 items 1 free space 16234 generation 1 owner BLOCK_GROUP_TREE
>    leaf 1163264 flags 0x0() backref revision 1
>    checksum stored f137c1ac
>    checksum calced f137c1ac
>    fs uuid 450d4b15-4954-4574-9801-8c6d248aaec6
>    chunk uuid 4c4cc54d-f240-4aa4-b88b-bd487db43444
> 	item 0 key (1048576 BLOCK_GROUP_ITEM 4194304) itemoff 16259 itemsize 24
> 		block group used 131072 chunk_objectid 256 flags SYSTEM|single
> 						       ^^^
> 
> This looks completely sane, but notice that chunk_objectid 256.
> That 256 value is the expected one for regular non-extent-tree-v2 btrfs,
> but for extent-tree-v2, chunk_objectid is reused as the global id of
> extent tree where the block group belongs to.
> 
> With the old 256 value as chunk_objectid, btrfs will not find an extent
> tree root for the block group, and return NULL for btrfs_extent_root()
> call, and trigger segfault.
> 
> This is a regression caused by commit 1430b41427b5 ("btrfs-progs:
> separate block group tree from extent tree v2"), which doesn't take
> extent-tree-v2 on-disk format into consideration.
> 
> [FIX]
> For the initial btrfs created by make_btrfs(), all block group items
> will be in extent-tree global id 0, thus we can reset chunk_objectid to
> 0, if and only if extent-tree-v2 is enabled.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Tested-by: Anand Jain <anand.jain@oracle.com>

