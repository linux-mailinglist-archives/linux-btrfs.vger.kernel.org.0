Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C032A5F9A5C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 09:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiJJHrw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 03:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiJJHrc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 03:47:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3A36335
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 00:44:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A4TJYF019045;
        Mon, 10 Oct 2022 07:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LjmgGh+sgvj5BLnp3mUxQZvb5hwFCCJSzV4dIrME11U=;
 b=lnnnWS+UI5D/Me0yHdhTy1mnlXs+DJF+CX9t+DJJaKkmkkS7N1ffWnhrOlXEA2aJT3q+
 /EwAeWqdlJx3GhX2R36q4/CCyh4CXlbZfnedlSihO0rD31sd/lLiCdl7LxDRQhLRRz/d
 mbZoCaiHdBzFJq0P7WC+rab+IvKgzYhcBBq+L/krXrUtADAAEBC0RADtxWBaQXpaJiCb
 RuFUhBxtbnDte03e+IKzEYwzKsaPbelPhw7KjUadM+GN5acN+bTjX1Qz88ClhxZdXoYR
 16oZmr1TjyjYKKFp1N16DpCBIxJTRXVfKk0d1F4pCpn65g1lZH1f1aKMOy6xHRo1Mioo RA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k2yt1avjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 07:44:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29A4K97k039458;
        Mon, 10 Oct 2022 07:44:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn2dn9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 07:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeffUIYshKJz+JFM/xbh44uyRZo73bWnnLwueu4C+ya+BTsUpdqjrgr/YPoEvERWuo9yF0yC2PSjPDPHK8fo9PkPigwLK/4/ewUKqRmMuFNPyo84b8dFb/4XmJrBfSEFLShHNWKtp0SWlec14gH2IjZ2R4aqhQXhsr5SYWiUOfRlREg6h0jIvK8YXKWoBcPdUDG98sMAQIXs/uT9Ybdzpkr00p6EsP9KemyTUZ/b5fSLGcAlxBFiLR+GfPC/FGlfwoYv+Andnu/uCxQNL+AVIVjp3t6wYTbitERYTTh/fKNzeKL/0/GdpKFhjSEBIRcVfNaWxvHXavAH+VYBzJ/aEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjmgGh+sgvj5BLnp3mUxQZvb5hwFCCJSzV4dIrME11U=;
 b=AyF6GQpXaF+GaCYAyOIgV2lblneHsQaSetQiUmt9bWC3A9wthWYgef/8EsO0zH0Ad06PztL+5bghdFIelDw8gwGnmCDQOojBrfjIXN/zQ5qjhUnNwCtGDmT44+BQ9RNjTIxq6NEYn+ZUApsLsjLsdgDtz64RolHNp7Ard9O4aS2XjPw0kNxCVeH3T9ChM94hVc4iQ8SAHCGxyAKinvhy+lIpTyN3dy5BMWM5v7BOm5eXwA/s057bqMjQSphfsoqvfpt5pAO5ovVVvzQSrQDmNZRg774UlTIXcEFaTSmngCTx0+Vf9VSFbDWWnqyu0VygFxJMR1U99g1QJKj9HvBkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjmgGh+sgvj5BLnp3mUxQZvb5hwFCCJSzV4dIrME11U=;
 b=sS9dwzkNuHEnl3al6rn++H5zdKdqGrxO8ufn6w2i6PJUWyAMthCD5a1bHfZFZJXXbyN6cZY69l4vJ84CdIOfjBUhYOqfvGPAzohWVp0snMNOlRH7u2CAdjcLP11uOaKIBUSvxQqYQ2t+kYcfsQrnf3i/85jjgu3OPq61qwPuJiA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6626.namprd10.prod.outlook.com (2603:10b6:510:209::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 10 Oct
 2022 07:43:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7%6]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 07:43:59 +0000
Message-ID: <af541998-3980-85c3-e3c3-dd0cf09f52cf@oracle.com>
Date:   Mon, 10 Oct 2022 15:43:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs-progs: add extent-tree-v2 support to dump-super
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <78ebe492ca09e716ca5ca2b6fabec0934aaa0370.1665219233.git.anand.jain@oracle.com>
 <764d5754-62bf-232a-a6c2-67724111a72b@gmx.com>
In-Reply-To: <764d5754-62bf-232a-a6c2-67724111a72b@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 498208e8-8d5e-496a-18c1-08daaa933115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SETS+APJFrNdgy3BLM5cZV7WagxkDsDUiOw+Tu/J8xYyeYKfttzmDOjHSgjMPc127o4IFNtZWIEOTHD8RsF5D89aqmxNwcRYjn/eVb5fycIIk8rt6q26itFpkHg7Qj9z7NF91njD35dKuXPY6T+MrjUamH+trukp+pPosOt+UNjw6rkkxTdQ7dSIQAU21G9HilaDexSUcckjsA+GlzLpB8uJa8IYzBee54ChcYHRCrVOd9/1ocH/p8Knae19RcgFZIdFIZs8Ou22UKHf2qIqMjmcOcgfg/9UnSCCGAmSJNDWvqXTX9kF86Mg0gi8tHQTCqpgD8I2Im4DanmGC3x3ychVVSdNH27iepoVV0A/J091/PEARJ8MyqgWWhG06f6sgrU0zuZY8jTJIL1BvMA7jSAvQt6RFYOy0Sol+0W1HS6hLphomWnhnaPvRJtBNkHRzrVznLQ9MyZ6I7GPEFFZy3WLa7zlejYcDD0PNBQVoHIH7rw1hnBrtac4orYrnYeQHVFMNHr6NcedSVoboiGj5Elz0ctoFqpOtj1SIHiDsiOzhRuoOAN6tEGap7m/DR4YAwT0HYyw/qq4QL7tEikhRjTLbS6kBdcXb6i2f7+OPlN2uDG71wP9zQ18TK1NO46tB/Sbvds0/p+oaPvrdtTaE3v1OsRVaNZ9ob6t4Jz/8AX70cdUVfyGZ/AQ1SPsUmc6Se1sktIVSlT9k3dbqIVGd/Dctm9YdD596hWqHwzS9VbW+4iJLAk6/3chXRg+O9l2LAUxdvGf1mEWuZrVvO6Muh2oxA9+1ohtVdACs6F9oVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(66946007)(2906002)(26005)(5660300002)(6666004)(53546011)(41300700001)(31696002)(8936002)(44832011)(36756003)(6506007)(86362001)(6512007)(38100700002)(186003)(2616005)(31686004)(316002)(110136005)(8676002)(6486002)(478600001)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWVrQjNrSUNhdjdOVEhFem9TaVdiYUNseWpIdlhGbGo2Mng4aGdwbGNicVh6?=
 =?utf-8?B?MHhCaFBEUGRVQXpmRm9lMVhlOVpDZHF1OWg3d3YvTVJ5d0toZkJZZlZUNTFX?=
 =?utf-8?B?YUpLQm8vODZldkJpU0E4Ny9nQjl4bXdzSjAvTVVJNXRpVnIxam11dGxwN3lT?=
 =?utf-8?B?MXA0RW1ReHo0VmlQQ1ExWGE4QUgwdUFWdlY3ODFjcEpkbzBicVpRcHA4R2w0?=
 =?utf-8?B?dlNwemk2SElGOWVEdFhScjRJRHVpalVzZ3NHREdLTzRKam5OblFWbzlhYURh?=
 =?utf-8?B?cmFNSjNPdEZublJMKzE1b1VJMkQ2eEJiS2Y3bG1udVErZ2dIa2pmY05IUnox?=
 =?utf-8?B?SWIrZ0pUc2VuaW9Qd3hkVTAwVTF4b01raHpSMkl0N0F4U2duUyszak85S0dk?=
 =?utf-8?B?Q3JLQmp2RVZ1MWlKVFNDcE1lOFhNT0xzZ2QzMUovcVErbXUrcy9MYU9Xd2ta?=
 =?utf-8?B?aUZaQUpmcFM0TWRLOWtBR2U5OTZWYjUxQkV5cGdzS3ZodEpzSVB5czc3S1NL?=
 =?utf-8?B?TlJIZFRHYkVGM1BTLy9kcXJxSWNTc2llUERXZHdwaXRmZWtvTVVMMVJYMk9I?=
 =?utf-8?B?QlNiVW5Namp3RFBDeUVVdlRGMEYrSnhiRHErMHdNckVRLzRkTEo0ZFBFelpR?=
 =?utf-8?B?cTRMWjVWOTJGUWRXaFdyc1NKR25na3lZa21rU3R1UlBNd0M2STZtSEJaVCtS?=
 =?utf-8?B?RGh6bVdWQ1hBOG50WWgyZm1pY25jemg3cnA0VW1sRFZORlIwa3N1ajRjOFhF?=
 =?utf-8?B?WVROMDFwbTR1TW5BTmd4WDZUbHlBcVRoZkFIM1FQcmUwYnlmNFZpaXE4Yjgy?=
 =?utf-8?B?OFlLaUxmRVBuMnlhZm85b2xGaWgyUW1OV2srUUI3R1cyWUtYZWdKTzZSOEFW?=
 =?utf-8?B?S3VNdVBIRzNGNFNtaGRuVXFjUjVTSm1vd0FQOFZQYkd4cm5VMm9Ja3oyL3lt?=
 =?utf-8?B?RGxPT09rZ1dQaGxkNlhGRXRoVlBEZituSGhQc1hZMHl4MjNFWGYyZ05zNkxr?=
 =?utf-8?B?eUp5NnRhOU8zNXVUVHNzWVZ0TldWMnRzNkk4b3k3emtxTHZkUStWSUFSUzJj?=
 =?utf-8?B?NEVtR3p4MXpXaDIyQU50c3JJS0JrNzVmeGZRUzVuOEZmZ004SnhYdFFlQ1VX?=
 =?utf-8?B?bTI1ZHFIaWRrejFtY1FySXhJdFM4a3kvbUhPbWV0Z0NSaytucUhnUDJDdUhK?=
 =?utf-8?B?VjZvR3pDZk9GNE1hWnpuL3hlU0FRYTdqUjJYMGJuREIrQklMRHRlNWR1d0JO?=
 =?utf-8?B?ZncwT3VhLzRQUWhVT3BIcjJnNHFVQXAvY2FnNlphN2JNK1ZOS2kyZU5sa0lW?=
 =?utf-8?B?TGF4V2l6SFE4NWJGeUhSMWI0SEdIVHVIWVdpQkNsVXMrSGtFTTd0SXJzUFhu?=
 =?utf-8?B?emZnei84RmZSN0hKa3ErRVFVUUhtdzcrMkZqbnZWdkRlR2ZrTDJiUGQxYjhY?=
 =?utf-8?B?dG00RWRnVmhXR3pYUHpsVFBhNlBSVlRDMHJneUt4aFNNZStFZElocGZ3eEt0?=
 =?utf-8?B?VGlOWUZSdDJYZ1pPUmNyOHFQQ3BzT3BhRWJUbG00TCs2bFBWMnM2cTlaLzlJ?=
 =?utf-8?B?OEdMMkpJVThPMHVwdVZDVGJSTEcyOGcwYnFBdks3a1BNd1I2SklrT1ZPNHNx?=
 =?utf-8?B?cVBVMm9tdXZ0WG9rcmN4dm95cDZjNGwyNm9FWFB6Z0FjdFBleHZHbUlYYWRu?=
 =?utf-8?B?ejZzTnorOGQ5Ty8rK2ZMbG9LZms4TmhMUDJqWVZXZnZGWTBNVTFTUEYwSCsr?=
 =?utf-8?B?Y1FUdUFQYWJ2N1FXSWFpQnV0Q21wTVFGSjNEWHVJQldVUGdqSUh6UUpUUmhR?=
 =?utf-8?B?Ti9GNkVOY2ltR0pmdUJvZnB2QzRTM0taeVRrUCtFQzQ1L29wT05HcjZKR1lo?=
 =?utf-8?B?bFhkejlRU1FTaHFnK0EvbFpmYWswZUVPTEpDWVRPY0NUbW8yb1BRM0JkaDd5?=
 =?utf-8?B?SnBsQm0zYXZkaEJnUWV1N0JveXJRdXJtM2NwaWFlWExVRCsvNjlwakF1N0g4?=
 =?utf-8?B?bytoOUhqNXhRa1dXeVQ2K1RHME13QXJMLzgwTVI1UzdBUmJpS2RnNUVKQ3pE?=
 =?utf-8?B?V0VFN1RTMXFhbWc1eXl4WE5VYStGd0NCeVZLZEhNL0VrSlJncXZZcXFiaEpG?=
 =?utf-8?Q?dDvcT79rngXA1gpoKQsrvtOyl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498208e8-8d5e-496a-18c1-08daaa933115
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 07:43:59.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGo55VbFJ5mrM4wOPjOwCXsOD4nPtBE5CS5ZrmLqg39OkQAptkglClR7XjgP00eP4MyJ4ukTvWtslJdlMRxanw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100046
X-Proofpoint-GUID: 2u8IVXHSF-ltZWKb5oOraEdrwFC4unqN
X-Proofpoint-ORIG-GUID: 2u8IVXHSF-ltZWKb5oOraEdrwFC4unqN
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/9/22 07:13, Qu Wenruo wrote:
> 
> 
> On 2022/10/8 17:02, Anand Jain wrote:
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   kernel-shared/print-tree.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
>> index 5c3d14298b58..6b5fd37ab2bc 100644
>> --- a/kernel-shared/print-tree.c
>> +++ b/kernel-shared/print-tree.c
>> @@ -1689,6 +1689,9 @@ static struct readable_flag_entry 
>> incompat_flags_array[] = {
>>       DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
>>       DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
>>       DEF_INCOMPAT_FLAG_ENTRY(ZONED),
>> +#if EXPERIMENTAL
>> +    DEF_INCOMPAT_FLAG_ENTRY(EXTENT_TREE_V2),
>> +#endif
> 
> That's in fact one solution I want to go.
> 
> But later I found that, we can enhance __print_readable_flag() to
> iterate the incompat_flags_array[] with extra check on @supported_flags,
> so we can skip the EXPERIMENTAL macro inside the array.
> 
> By that, we can reduce the number of EXPERIMENTAL macros, which I
> believe is already causing burdens for testing.

Yeah, possible. However, it is a cleanup; I wouldn't mix that in the bug 
fix, here.

Thanks, Anand

> 
> Thanks,
> Qu
>>   };
>>   static const int incompat_flags_num = sizeof(incompat_flags_array) /
>>                         sizeof(struct readable_flag_entry);

