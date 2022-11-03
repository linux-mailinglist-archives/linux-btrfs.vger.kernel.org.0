Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80060617FDF
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 15:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiKCOpb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiKCOp3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 10:45:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFAB186E2
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 07:45:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3ESinT005721;
        Thu, 3 Nov 2022 14:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rCXFon56Ute94J7DegfSbnKzTZ8MREHGgHEJxn2ToR8=;
 b=BJX66AQ/72I3EysmMiaJVCpcuaEX5T3sQjYmuY+cRjQhq/PgMrvqavPRHMjRoIKb62zv
 JoDFTIebhgXGm3xvNtTaLU/oKGTO6hdwtxSdjNsOQRoP7bBd1YJiLHWz2TOwQ1ABRZDV
 3Krk2PUj2UNIEQdmY4aKkltFsdp9mgqrHSQ2ODfkyQLMUjvsxaDK87GutPfvmQxBgS1i
 9LR3mrTnRws22RgtDH+HJFHfr+3f60PpRfvhNRRr8Hw+qKIUMXO7U2CoA+HhnnnOOM2o
 ohfE7skbys2g8Vw4Yy+cNAllNWqf5QQx6/ah9n/sp9qh8OxUBHARz9PqxK6vHqi3PHIs aQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgussw1ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 14:45:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3EbVX4009688;
        Thu, 3 Nov 2022 14:45:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmcshrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 14:45:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR97TXjWJa9OfaTfEq80QNUIP1ffuXIpAJplieLOp/MUQTXPDDbvdwhhttjLPWwgf+CKzBvH+9QxqSC1P8fyItvg06r/gx9xi/wrUmqCoYfZTZSJ/NbT+rvRoNgx5feNTDYyMUmKrwZTMvF6HDr7ip8nSrbqXP3seEdXeW5rCMHPAONwNLYNFd+DrdEtNB7JjlFZxW6axutCXYzAO+H4SH4pT4zvFbqek0/z3SpaYkOrwQOeDfZvVK3PHb4BlifGEOLla6KO28bKHpXdiL1eL3xEhalAlYNcow4Mc53AZnNCiaoR15gIUlOKCA0TU5jDKiW9y9UKO6JIAzT2gQSsUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCXFon56Ute94J7DegfSbnKzTZ8MREHGgHEJxn2ToR8=;
 b=Kp8K7qRloKI/M+e/wRJJ6O7hKRKSK9fox9buh6XhNjpfkRd1IXhljvMa3ek/OumkcoPYcHI32wSFrQB+xnB2u8coqEcnP5eeKXHaWtFPnecNuFbEewlPyhxomf3UCNfcRJTBEpAhOaTIwm9kMD+NKX5v+XvQGXhApGS0icKX3OK9I4bscjIiWQHFNgqaTnLsftVrg51ZcQjnqo4qNdxW544Pyc/SkeClns8U8vuyUC3We5/wBx71upN2JeCyvPVBRVPqHR06abi3xI+AV1M0FG044zYmFLxTStPeAo4SLqTpWrH2ts2PSY5yrmOi3lQWnaqA7sFq2ggzNPbjU4rJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCXFon56Ute94J7DegfSbnKzTZ8MREHGgHEJxn2ToR8=;
 b=S0MLF07zJO3LIEPGzsTzo2xx8BGd/bbvD2PHWXl62w8B2F9R66+HnjarhcGTu/TpzTNBLe6dZTRqZuGXVO8a7u4teZ+kDrKWehCAlmah3dnUdVnGSNxMMctAv3QI8j2ItZJuR435n72j5gL8sgppfgfnCyMNanp2/DISOExveSA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Thu, 3 Nov
 2022 14:45:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56%4]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 14:45:22 +0000
Message-ID: <83f9021b-df26-a725-e0bf-4f255dd2ddff@oracle.com>
Date:   Thu, 3 Nov 2022 22:45:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 00/40] Parameter and type changes to btrfs_inode
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1667331828.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9edc18-686a-4392-af90-08dabdaa08fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qafsMT3eqSDAJuSTcCzaM/cs+5aDqWSki/5+kdA4l8CBbuC1N3sl8qWgyiNLAqiEM0jMrDowYxIhpYyGKJwWvAq8R4HXYgf6ySmQLy+PMgoOnqFaWzspMkQXu1u/9bVWPEMS8oKB8zB6jPKGDKohXyK6INA6mO7draB4y8wHF4nRVVeIabjGHJKsu9LlFiosf9WnyxZrd3mBHFsBvDFv6tiBp64jWPoxehsC8A4U/BEIs8iBM5qryWmtQjqAbh9i+K3kwemwKIfljVSlTv4nYzXyvZQldtJ378jze0fNSZ7dmpA/KTkL1W4Z+Ov7+qkdgtixIvrzdrxnfzKRYvwRxfSJlj9Qs/0tPm3Stc/J/iD7gavdVWlm8eBI9L3njnOKk5AJgtMaROwfUgkfhZffK3ArFdDeejzmnfhg3nC4vFQPH2bubWu8nlj0CbTvaQPtqPuWqIkTb7mW7d8Y/ReGMUNzdItU9oqDu0ufEosmeFy4GE9i/i07o4hi+DKoHHyDubN9Ho/DIzlCDUJ/Q+Oihdc5szPvQC6vvdIjbGS0OjDJtuXFpS6oR7pcy2O440z1hFL9bl5DO1TlFoTnJqkWJn2elDoDzDy/Z8neS/iCKlDZUm8ZDFbi39MZSfNHkrK8udX6f2jzpdY3rdamC+D0Kga89mmFP3MgCKyVtmntmjyHDPZzppX/+HusyBEvV3BXRkpYLs1YNtN92w0quLdOR4ATB58ys93YfG+l+n3XwgUrqey4b6Y7jBgSQT0R3h7EUZEjk2MwrtA4EEyOOP0spFlhQBENlIkFj2jtzoosQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199015)(8676002)(6506007)(66476007)(83380400001)(6486002)(53546011)(31696002)(66556008)(478600001)(66946007)(31686004)(26005)(6512007)(186003)(5660300002)(86362001)(36756003)(2906002)(41300700001)(38100700002)(8936002)(2616005)(44832011)(6666004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NllkSkZSMmw3NVY2OG4waWIyZ2U3Ry80dmZHdDNwR1BZRU0zbGhadU9lQnI3?=
 =?utf-8?B?Ky9nT1JYNlcwZlpEOWpzelVOV3VIU2RiUzQ1d2k1UE9XNFNZTVBSQ3N6d1BE?=
 =?utf-8?B?STJRbDQwOWp4L2t4NzZwNzZXYW1pVUJjZ0JRNEdlMWh6ZFN0TFJ4RHdzTEdJ?=
 =?utf-8?B?RDErQmV4SUk0RnQ3dFJwS2o0d0wrSGlMUVFHYk01SEdJY3QySCtjOVBPd0Iw?=
 =?utf-8?B?VjZTd0ZNYlhRRm5jandmS1hRTWJhOHlwYTV1bzVsM1lEQmI1ZUZDcWZuQ3JB?=
 =?utf-8?B?MFQ0R0hQckxQMW1xLzBrSGlQRE1haGxNME9EVDl3VDhFcjBBaTZGU1REMSt3?=
 =?utf-8?B?VTNMTDIxaHVUcUEwRG5pWW0wOVV5bTlGS1Q5cWsxT3hrY0ZOYW5sV3d6OTFV?=
 =?utf-8?B?Q01xakgwOWpCdkZVeXVhc01waDk4WWZ0N0hCSnI4QXg3WHlsUWt4b1ZvQ2Vj?=
 =?utf-8?B?c0RRY3QyZCtXekMyYjVxRzhlOTZIeWI3bi9yZE40Z0M3NUxvYVY1R2d5d252?=
 =?utf-8?B?SDZQQTJSc3BkNW9aTjdWOGlkOWxZSjNsNmV1SjZQRFM2TVJNL2c2TGtpdlc5?=
 =?utf-8?B?eW9GUFJRUi82R2ZPTXlLd3NUbGhQVEpjZHJIYnZZQ0dTdUpnNWx5MEVVVXZz?=
 =?utf-8?B?MThCWGlvRGYwUlUvNlYwMjFjenBLZmpBWnpGNTAzcW5FNEgzTStpbXZSS01t?=
 =?utf-8?B?aHJsWW1Oc0MvdllZbW5BbFY4QStvdG5Hb3JIZ2UvKy9JSW9lWlBvL1c0bnFD?=
 =?utf-8?B?T2k2Y0cvNTVqK1hZRXFrUjVxNnRpVVRlbzBOS1c3UE55RjlDRnI4eDRnQTNa?=
 =?utf-8?B?RXJIL2RvZTBGb0FPb2ZheFhmU0FkWU1XZEJUUjBoTVRFVTIvMVdLbVhSU3VW?=
 =?utf-8?B?R3hKNGJCQjhRendrK0Rsb095blIvZVAyYUdDaEdpMmhocDJxRDZqRnBYM3R2?=
 =?utf-8?B?R2VZZzRsNzJSa0NHWHRZdkhPakE4Y0R3eGhsdnFFSkQ1cDhjUlRaTm9waFpG?=
 =?utf-8?B?ZVhQSTBmWm50c3V0ZTFIRmt1SXVyN0hSNFNjempVQzl3eE9lZ1hKY1FkbE51?=
 =?utf-8?B?ZXJZTmgybEhOZDdnZFQrWkFobE1IZzJRYkxXQ0JjU3c2b2hSZko3d2dFUS9t?=
 =?utf-8?B?S202VnFaVkw0TW5halcyNDVXd2JqaUNNMUZLcnJkZ25MSS9HY3JqQ1pMejFB?=
 =?utf-8?B?MGdESXlsZHFtTGg2VENmVkxSOVFjYW9wV29zYlp3R21GSXpqRjA3Mk01WXhR?=
 =?utf-8?B?UElyYUhoMGhjYWJUT0toMWFWaFBQNndCeVA2WnNxR2lkNXJ4bW1HMzJkd2hG?=
 =?utf-8?B?ekh3VXVaVEwrYjRkWDY2VEwvR1N4cjVveHo2RVhXUWFjaXFtclA1YURBSUNn?=
 =?utf-8?B?ZmdVU015ckkvOHRhV2w1NHFvc0orRmlkYVdIMkxYMmlEYjljRzVscmtsVTV3?=
 =?utf-8?B?WGhOeHBQS1k4Z1lrRmozN3EvUnByYXo1ZjlWWnVrTmgzZTFpTWR5RjY2b1VM?=
 =?utf-8?B?OTJXNGhpL01zYmxxUzZHNWJoZHJiNkxTSnB6ZHhxSk53NnRLMi9sSTNiY25s?=
 =?utf-8?B?YUk3OFdvcVhUODYzdEFKam5GbVhqUFRVa01oUC9GdzdqQzA5ekV3eHRnYTdR?=
 =?utf-8?B?VUo4YXNVc01yeVE4cDN6T3pkOFhKdWVIYWo3b0JDaXBmZ2VGOHppN3BHbHQw?=
 =?utf-8?B?RTFoeFd6N0tKR3pYUE9iZ3dIcktYZFRiVEgxdUtnZWxvZ25BMytHd0E0Y3JT?=
 =?utf-8?B?d3B5ZjZxR3dwVm5OWWRrbk5meWI5QmFJZS9Da013aGErMmRkUWhYeDM5aEFO?=
 =?utf-8?B?bmVLcU9td2lJZ2lObnhSb3JhYWFyZzlySTIvOUFINUMwbjg2dUZ5aXlQRjhy?=
 =?utf-8?B?eFhhRVFSUDNsTVpyOEtIcE5pM2hFTnNLaGltR3d6a0d4YzVic092ZlJERXpG?=
 =?utf-8?B?aFI0b3ppaUJxb21oT0R4bzVQWEkxT293cERUTG5zMmR3YXg2c2dFNnh1U3pU?=
 =?utf-8?B?bmR0RWtkTTZ5WVFLNWFrelZKeWNFRFZ2NWFoTytpbzFWcXBRRHQ0UEtSUldS?=
 =?utf-8?B?UE5ENGZuaWRVaUpQY3pwMHF1RSszSG8vMEtOd2NhWWZnbFo2ajBLTk1lYUFE?=
 =?utf-8?Q?iYt+psCs5EDcG+js1UwZYuFPl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9edc18-686a-4392-af90-08dabdaa08fa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 14:45:22.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHOX6ZNmdDWugNQmQvNlLCLpb6UZvWMiZfeYuzJq1n3ymU9GaXAZ8maF8cPG1S0d0XmOz7NyX81ntiRFD/tk1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030098
X-Proofpoint-ORIG-GUID: AXKReK7Gk75sJ0qElFLyphYew7gN2ML9
X-Proofpoint-GUID: AXKReK7Gk75sJ0qElFLyphYew7gN2ML9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/11/2022 04:11, David Sterba wrote:
> Many patches but also quite short, switching struct inode to struct
> btrfs_node for structures and related functions in the io path, removing
> some indirect function calls and typedefs.
> 
> David Sterba (40):
>    btrfs: change how repair action is passed to btrfs_repair_one_sector
>    btrfs: drop parameter compression_type from
>      btrfs_submit_dio_repair_bio
>    btrfs: change how submit bio callback is passed to btrfs_wq_submit_bio

[patch 04/40]
>    btrfs: simplify btree_submit_bio_start and btrfs_submit_bio_start
>      parameters

>    btrfs: switch async_submit_bio::inode to btrfs_inode
>    btrfs: pass btrfs_inode to btrfs_submit_bio_start
>    btrfs: pass btrfs_inode to btrfs_submit_bio_start_direct_io
>    btrfs: pass btrfs_inode to btrfs_wq_submit_bio
>    btrfs: pass btrfs_inode to btrfs_submit_metadata_bio
>    btrfs: pass btrfs_inode to btrfs_submit_data_write_bio
>    btrfs: pass btrfs_inode to btrfs_submit_data_read_bio
>    btrfs: pass btrfs_inode to btrfs_submit_dio_repair_bio
>    btrfs: pass btrfs_inode to submit_one_bio
>    btrfs: pass btrfs_inode to btrfs_repair_one_sector
>    btrfs: switch btrfs_dio_private::inode to btrfs_inode
>    btrfs: pass btrfs_inode to btrfs_submit_dio_bio
>    btrfs: pass btrfs_inode to btrfs_truncate
>    btrfs: pass btrfs_inode to btrfs_inode_lock
>    btrfs: pass btrfs_inode to btrfs_inode_unlock
>    btrfs: pass btrfs_inode to btrfs_dirty_inode
>    btrfs: pass btrfs_inode to btrfs_add_delalloc_inodes
>    btrfs: switch btrfs_writepage_fixup::inode to btrfs_inode
>    btrfs: pass btrfs_inode to btrfs_check_data_csum
>    btrfs: pass btrfs_inode to __unlink_start_trans
>    btrfs: pass btrfs_inode to btrfs_delete_subvolume
>    btrfs: drop private_data parameter from extent_io_tree_init
>    btrfs: switch extent_io_tree::private_data to btrfs_inode and rename
>    btrfs: pass btrfs_inode to btrfs_merge_delalloc_extent
>    btrfs: pass btrfs_inode to btrfs_set_delalloc_extent
>    btrfs: pass btrfs_inode to btrfs_split_delalloc_extent
>    btrfs: pass btrfs_inode to btrfs_clear_delalloc_extent
>    btrfs: pass btrfs_inode to btrfs_unlink_subvol
>    btrfs: pass btrfs_inode to btrfs_inode_by_name
>    btrfs: pass btrfs_inode to fixup_tree_root_location
>    btrfs: pass btrfs_inode to inode_tree_add
>    btrfs: pass btrfs_inode to btrfs_inherit_iflags
>    btrfs: switch async_chunk::inode to btrfs_inode
>    btrfs: use btrfs_inode inside compress_file_range
>    btrfs: use btrfs_inode inside btrfs_verify_data_csum
>    btrfs: pass btrfs_inode to btrfs_add_delayed_iput


  With patch 04/40 fixed.

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

  For the series.

  Just a note, the naming convention for the local variables... as inode
  represents struct btrfs_inode, we shouldn't use the same name for
  struct inode. Instead, vfs_inode is better. And binode is gone.

Thanks, Anand

>   fs/btrfs/btrfs_inode.h           |  29 +-
>   fs/btrfs/compression.c           |   6 +-
>   fs/btrfs/defrag.c                |  12 +-
>   fs/btrfs/delayed-inode.c         |   4 +-
>   fs/btrfs/disk-io.c               |  52 ++--
>   fs/btrfs/disk-io.h               |  15 +-
>   fs/btrfs/extent-io-tree.c        |  35 ++-
>   fs/btrfs/extent-io-tree.h        |   6 +-
>   fs/btrfs/extent_io.c             |  35 +--
>   fs/btrfs/extent_io.h             |  11 +-
>   fs/btrfs/file.c                  |  48 ++--
>   fs/btrfs/free-space-cache.c      |   4 +-
>   fs/btrfs/inode.c                 | 445 +++++++++++++++----------------
>   fs/btrfs/ioctl.c                 |  10 +-
>   fs/btrfs/ordered-data.c          |   2 +-
>   fs/btrfs/reflink.c               |   4 +-
>   fs/btrfs/relocation.c            |  11 +-
>   fs/btrfs/tests/btrfs-tests.c     |   2 +-
>   fs/btrfs/tests/extent-io-tests.c |   4 +-
>   fs/btrfs/transaction.c           |   4 +-
>   fs/btrfs/tree-log.c              |  24 +-
>   fs/btrfs/volumes.c               |   3 +-
>   include/trace/events/btrfs.h     |  27 +-
>   23 files changed, 393 insertions(+), 400 deletions(-)
> 

