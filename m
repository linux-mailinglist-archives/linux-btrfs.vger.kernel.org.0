Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD6B59AD8B
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Aug 2022 13:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbiHTLes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Aug 2022 07:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345348AbiHTLer (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Aug 2022 07:34:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AAC89808
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Aug 2022 04:34:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KBEkgq001118;
        Sat, 20 Aug 2022 11:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KkQc6HPFVTclYHXInYquUcgWHHzBVEdX4augGsx6Z6Y=;
 b=S+lCyvZx7WjSL3Lc35/OEPnuVG+aYcjJZsHaUOLX2hqbCsod80+ZSmSKuHirp0BwADfu
 +Lqy+K1YmIGFeNA4uvmzWBdUflYjq5atRDu5wfeiO3Q70+jrC2kx0JFa2nU2BmYk2WlI
 eK2hyXscc/JRHFjBkimvVz7iBJH28+LbZjZrcVMRb1xIG2NH7i2PBYXFoXQjfqSe1ONo
 X4gBRcg9GaDfLW7vGqJ0RJ/MVBOjd5dLq8ZlZWlo4/6LvwSnGHQPnsyGjQ0s6+NvihKv
 HLwAktTKaIlbAqsvf1GwOQaGTLTXxKUyfe7dYWtDQkAScN2Xl99e4gTDlWSgfSprZSyF AQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2xjgg0dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Aug 2022 11:34:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27K98kdH035977;
        Sat, 20 Aug 2022 11:34:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j2p206x6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Aug 2022 11:34:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=durKs/PhOeIMPaWZzXX4aIxtzkEvKrz8ciz2PjP4DbXIWAYLPn7x1jKVCdbr9LcZCHk4piX5OHsE9/E8RPdkYUv6/hfnlH57VeQELubjdwSrN7Jrc7DajZNpS3icwDd9vahSP3Tg5WjyA+byup4lHbIL5icxJCGimQG0zhLE+sdBtuqPIt8n2rXqDxHYT9PaXdPJa+LxC9+hS98SBj3l+xOGzes8FSPRrxeEWqojFpFobKsE0iNpxJ2enqoE2FdL7GnUnZLbvV21DH9+Z8RLdpXPnAYwjgjgTA5rLVNp9w1L3ay7a9iyYLKb08X0jrp86yZAfupA8VZtZKFdTFJcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkQc6HPFVTclYHXInYquUcgWHHzBVEdX4augGsx6Z6Y=;
 b=n1hprsckZIUiccWLZ/CAXbOxJYD02gIUB88NHz9joPNY1MeL6vyy2vSCWsKIiLgYkiDamgWZFEoSawfhVVzGlY4KOdXtC4Tju8eeeSL5h6uPg6uHW5Na91I9tMnrZMndP/o5FIdL7zzCoRV1/z73rNcRZwkd7yvqqk0KriVJWIjY4RyGMTWYZjquHjdkbeCeIGhaHhJcFY8sIkrTWdzs28OUD0SWdScHr+xc5shxq2JniGZD5C6ZJTLSl0PJa8z3Cap3N2hgf7at3xtLXpbZo9dbH/iMdxAObQ39Wc25AMcd9i9lVf/uFwH5f62G6W1XbByHQuWVRETbzjwskCLBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkQc6HPFVTclYHXInYquUcgWHHzBVEdX4augGsx6Z6Y=;
 b=g/J5JYm3lt+p+UidGPmGEH04hMT4zPFoE8rQ+abKQgNzlWt9oYxyKsA2BrvGoBdxv2CmBolA9fGI6xGdB/QNLEhl+4zTA4scm8BPs9z4LyHgXO1TPzcCUIoTWr5uP8ZxhbvzCzWC60oxrPyeiN0VPS4jcNL3yxhMvLPx/ZiEVk4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB4921.namprd10.prod.outlook.com (2603:10b6:610:c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Sat, 20 Aug
 2022 11:34:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5546.016; Sat, 20 Aug 2022
 11:34:35 +0000
Message-ID: <fc891d20-6daf-4035-0737-e986eb95c3a9@oracle.com>
Date:   Sat, 20 Aug 2022 19:34:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 10/11] btrfs: make the btrfs_io_context allocation in
 __btrfs_map_block optional
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20220806080330.3823644-1-hch@lst.de>
 <20220806080330.3823644-11-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220806080330.3823644-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0d9ea51-f419-43ac-26f8-08da829ff4ff
X-MS-TrafficTypeDiagnostic: CH0PR10MB4921:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wu2eWUlVn+zP2A75H7lqRrrX0x+dIhyjhVEPLF18mRbn+0H0K7uIEV10PgLG3fJVct8GUPrxhoOJgWDW4OxK2eA1jftf0gKIHsnVJh20K4Xy4p90S+t9iy6Lg2uO591mQ2J7lSCJM0+tgXlyFEwSQnyYc1UYsJo780/XQu4IfkDd8OBbtBxJZmaqPkuBMislilkbtEddmxxkWU7nv+kjm2bFDAfW6zpufJ7x0dKJFu98M03xUa/56ul611J0lKQRAVuAXPpt78GnZ7RvJ/Oq26NyCvNK9RV/M257IzfEz+V/QVZAta7H4FjJhtKB5F9aF6wwC8Ks1qvHyap96u95baLNf87wF2CxHlKDXJFUcEMEuElg+gsoS2pEiPUWBSOeYpCWZNBh/MV2C/jLzY8rsbfMsR6y4LpybTgIf/xXG9+ZbjpCPThB5uzJrQcaPoHAvI/B8SfSgGVAO1qtuUCL/PlQ53i+XWAdeXg1C7JhmEsH4llSAYnefOu/LtlNBpfSsJCjetc5ZQTIZ1JH52ULEKCIaCRXwNNwTlQEmfNYXyIWgVbPa3WvwQIz+seBp+4bFCEFGxN1ou+PVHwOSiKxpBitufXF1nJ5KudHOrghHm58bZxWkiQNRkHJIaUTmbEsuiAHEyzyc1qA3/Wg9fb1Ux/Mk9V4+884cu6vZX+XH5O9ylQm9apvXGogcUBHdYZcfkuy+A6mP/YH2aYtOBd6bb5GzJp5oPduij9HpjPsiQ8WSAg3roVAlPsMxo7OuIgN5DYVtMDOJ3lcs8M6v81MwpoT8VttKL0VHErB8bjmtik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(396003)(136003)(376002)(186003)(2616005)(31696002)(86362001)(38100700002)(316002)(6916009)(54906003)(31686004)(2906002)(36756003)(5660300002)(66556008)(8936002)(44832011)(4326008)(66946007)(8676002)(66476007)(6506007)(53546011)(6666004)(6512007)(26005)(6486002)(478600001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0NQNzd5b0ZtVWM0MDRIcGtZVEF3QWpKNVYyeTdIY21IRmV1cno2aUNKWFcz?=
 =?utf-8?B?SVJqaXpjaXViQzlLSUYrTGF5OFlrbFRpTmsrdWsxY3lNbDR3NzVKZkM3UTRz?=
 =?utf-8?B?SGFQbCt5b1ZETkJ2Ykw3ZHQ2K2djNnZFdldQWVd3WEhTdnZYaWVSQWUvdmtL?=
 =?utf-8?B?ZG80V1JJaklxK1g3bkRFYkdwVTZRTGs0Z2tJN1EvcU4yRkxhc0F3d21qdlhk?=
 =?utf-8?B?WFpVTWtuOFJ1T2NGcFRsRit3SlVkNVdEOGJPL0Vla3RUQXh6OUk0NkZoVDBl?=
 =?utf-8?B?V2ZYY1MxbWlrcVlnN1REZFUxMlR5OXdkazQzekViQSsvVUE5OXcwbDdMQTJT?=
 =?utf-8?B?MitrWHJxNnk1bzA2amJuNWlldjJGR2tSKzJtMXZhNVFZMkwzVDIvSjlTWlBz?=
 =?utf-8?B?R1dVY3Q1NGR3ckdNS2E0Z0lnc0hjSENYbVJzaUFMR2RYckdMaitmVXl3V3dw?=
 =?utf-8?B?ZHFpSlZrR2FlM3pyREFEa3JmNTc5MUJGSmIvQ0JaN0lScHdQbkpWM1JYWlNW?=
 =?utf-8?B?eFArN3M0d01obGN6NGdKWkFMTjdzbk1QL1BKZEEvZlY5eG9QSDBPWU5Xbi9P?=
 =?utf-8?B?NmJzSXdEYWx1eWhZWFBKdWVTNzUwSmgyN0ZxTFYrMldhRzZiS2dpaG9IQkZo?=
 =?utf-8?B?U01KK2MrblBKRHVXcnpBaGorZ3ltK1QvSGFXYnlFbnVUdHVKWE9WN094b0NJ?=
 =?utf-8?B?OW1jTCtwZUdjMmgyUks2WDVEYVJva1NhYXVlQzJxMFNweE5mZ3FRQ3dBTHMx?=
 =?utf-8?B?aDhzMm9yOStQVEVBaUlxY3FhamM0SWNFSDd1WmV4SXdGOHl4eVZJRkd6MGZU?=
 =?utf-8?B?RzVFN3RydEdTNzNWRmRQMktORVdheFhLbENKK1p3b01kMDM1VUt5cVIwTGdq?=
 =?utf-8?B?TFNoMHEvOVp0TWxVN00wazkzKy9zbmNwV0tGeGRxbDh0VjI5M3l1NzRFWEdP?=
 =?utf-8?B?M3FZUXFNYTdoL3hJQ2srT0ZEQ0pRYWxuMUlHZTlkcmhBNjA2endPeXJGOWpy?=
 =?utf-8?B?Nm1Jam9rRTV0NHBVNkpxTXZoUmdBaWRGZWxGUmU2YWt5K3lXT2RVWE1TNnQr?=
 =?utf-8?B?TVROLzdXNkdxN0ZqU1RITFdTTHFZVllqVzVVUjNlaFovcXg5VkZoOHJWQlNJ?=
 =?utf-8?B?eXVXdUFZcnViMlBiSFRDaDR3ZWtBTVc4eng1YmYrM0xYWC9ETTB3TFhweWxG?=
 =?utf-8?B?eUErUkZ5elFzdzFCWi91eGsxd3AzVjlZcmJsOHFvakh4VE9PN0YweTFkRGlo?=
 =?utf-8?B?NTRhQ0JxbHI3bUJheFhING9aQTYvZWxiT1JTQy9HaUUvQ0NINVp3TnROZklp?=
 =?utf-8?B?b1llM3lhTGp4Y2taUWdscllLTDV1SHJaWjR5NTBaU1VUU25Nc0JnblByQ0hk?=
 =?utf-8?B?RmoyTDlYZjMrT1o3WURGbFpPaUFnc0pTenZOVlNUMmhrd0VtK0RncWYydVU4?=
 =?utf-8?B?UWdLOTFUeUxFdTI2b0lkOU94ZmxhUElLVzBCMFpyYWJOVzZ6YnRHQjh6czJy?=
 =?utf-8?B?THVleDB2UGFKaDFRb0hENGNJSHNRdlVYU2FVOEdnWC92YmIybjRWdzBoRFA4?=
 =?utf-8?B?cVVicklTZDNncGp3YWZ6WTZ0WEkvcHpaQUxmWlZ1YVpiRGFNRU5vaFl1V3lV?=
 =?utf-8?B?MHhtT0ZGaHJkL2NvR21vVER5Z09pVG44Wnp3a0pBVi9vTGt5bVEwUXYya0U2?=
 =?utf-8?B?ZWtXcTZ2M3U1czZWZ2RjTDlPSzgzTm1ORGY5UFpwVzdNT1lpMTUxQUpubDhv?=
 =?utf-8?B?OHFZZUxmdFFHU3U3aUcrcFBjMGJINFNmdDh1OU40R0hEZnhORDYvWGFKbDUw?=
 =?utf-8?B?ZE1pWmJhMTl3czhEdzNQTVd0U09Ma1kxaHBSdC9qclgyNmVMcVN4QU1mcytN?=
 =?utf-8?B?dUd2QUVWd2NvSHdhUlpuYUxObTlRL0k4aFlBSEJTa2ZVaElaTG1XemVydlhn?=
 =?utf-8?B?Y0I3NFJ2eFVSVmM2aW9tMlJyUHAwSThiVnVaakJFVjFMTDJuclRPQytsL1lw?=
 =?utf-8?B?QkpKNmRiT3Z0S3VlbEVJc1A4ajNCVEtOV25aeUYvaFNBbGpyT1lWa0JKSUJy?=
 =?utf-8?B?RlFZOEMwTG1QbXN4UythdFdoNy91VDNBQVhBZ05EcHdGYmg2K3lhZGg3SE1a?=
 =?utf-8?Q?AmshwlXCnhV6klqaUYG8wjhGE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d9ea51-f419-43ac-26f8-08da829ff4ff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2022 11:34:35.3275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFf74N953eljVYiVbMfYH3pNaH4RkBoWrD5dSZpA+Xb0oydXSCilKSo9xExuQ3fNVaXIgy/UUYvks7fyuFLaWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_06,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208200047
X-Proofpoint-GUID: d56TMFubovpLgT5REQtkJ8tFQESDAqRX
X-Proofpoint-ORIG-GUID: d56TMFubovpLgT5REQtkJ8tFQESDAqRX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/6/22 16:03, Christoph Hellwig wrote:
> There is no need for most of the btrfs_io_context when doing I/O to a
> single device.  To support such I/O without the extra btrfs_io_context
> allocation, turn the mirror_num argument into a pointer so that it can
> be used to output the selected mirror number, and add an optional
> argument that points to a btrfs_io_stripe structure, which will be
> filled with a single extent if provided by the caller.  In that case
> the btrfs_io_context allocation can be skipped as all information for
> the single device I/O is provided in the mirror_num argument and the
> on-stack btrfs_io_stripe.  A caller that makes use of this new
> argument will be added in the next commit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Nikolay Borisov <nborisov@suse.com>
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

