Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD35B9905
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 12:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiIOKou (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 06:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIOKot (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 06:44:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA18DEB7
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 03:44:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F8sdGn014976;
        Thu, 15 Sep 2022 10:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OWKF4XbxHPd4hcxZ1KknQJXc9PwNjKAhAlGejl6qI58=;
 b=YZ+q2bGUI0KiTUh+ZU8Bwq3RBPoTYbS3ciLuvIAFcVV1O2MJMRPrYquTQ7VLc9Ozh+mN
 +voXxD2IhJdhA03nh+I0xGkY9lcRQrbDgknMSixDoKvDuTglhqPCRxdzAhsIvibMOO/7
 WArruenGjpaPD4hC+Ib+MsIRdL3F7uhPTRONnVq/bxbQhGYtGNn64Npl5sJPBiPEYBiE
 LnfwRZ/wPmDaPhgraK5EyRFg4sO2E8guMgOp9gVEyvHLD3Bj/PrhiqF84wo2XvGTkTB8
 sa5xHQcoD0qgndg6T2nZgajCexP9M4zJuShmMT02RquWuyDFS+Tnvd0dloGoYswVkfFG Jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyr51us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 10:44:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7qTC6001255;
        Thu, 15 Sep 2022 10:44:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy2c9swn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 10:44:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTJtYH8XwDYmrU9quimFsNRT9OZeZXNovrcGVsHyn8x4Bvwv412wL/U15UfSEbGm+QizvGkbxxwddBDSjrroyTSOe7HVG5yoNosn+QMWjyAvhnkCTgoD4aEWjmz1MTNnP9t6Ern/zPPLYAkNOTyQHTW3fmTzvgVHGHqvQzcWYI6VOfkqpto5mF1jMx6cotINE1q8tpwQfom1aA3uYt2WH+XZfFujtJF6myg5JGIJ/WWQb2J4veD/z/n4AqsIOMUGYzTaC3GgUCZJq9KNoLHrtlK0ReQcvJGnkdCsL13VmBpxtEKSTQ01TVQdB68r2A3+f8/oVJhppo1aLYRdjSthEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWKF4XbxHPd4hcxZ1KknQJXc9PwNjKAhAlGejl6qI58=;
 b=ZUJy0EX/Je/WAIoPbyflOHzAiJFP5HLsgwU523qRW6Wzilw8S7T7itl8eJwEckoXH7a5bEFKecMcpfprsjc1CCrUhh1ss8/tV3YKdAWRAbCd/BTgXrjax51ryLYjf7aGu6UPBbWiIfMrZYHRZ+e6qecOwO5cTdqmlGiOJFY+VqEjZ4AI0dvKjrZlZohisFU+8RT6hegwTutQCpF9PCy6MhqliuiAEnGra+suejULu6j7i+ysfEcAY+uB3kKr4lPvEAWb1a7hsBo5jjduQeerTBH3dqheODgfWL1hEywCxe0OMxPdzksTfU6/bQvtAOgn6PC1wnQGlWwZ9HuzICx5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWKF4XbxHPd4hcxZ1KknQJXc9PwNjKAhAlGejl6qI58=;
 b=lZ41WXDBktViV6ak9JrDy0IS5Dc3G6mGhkLf18TdDfGUL1bb10g6Hzlcllil9FDXcgcMkQYpHpuyGyMPzejSk8jSpdLbx99pDDGO+DWZGeBdWlFh9IVbaXQsan4/8ENdbJXs9ZIiqgLQO1y+pNh08SY4tkc0m2Z+ddlBTJ69UaE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4491.namprd10.prod.outlook.com (2603:10b6:806:f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 10:44:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 10:44:41 +0000
Message-ID: <8a8eb616-6ada-47fa-5a1a-e793dc1f5f29@oracle.com>
Date:   Thu, 15 Sep 2022 18:44:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 07/15] btrfs: move btrfs_swapfile_pin into volumes.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <be6105cf39b5ff328622fb4b7003beac385f4f28.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <be6105cf39b5ff328622fb4b7003beac385f4f28.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae11157-0557-448a-7c59-08da97074b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESbt8c5vWhCEYlcKDSFMYm5cONVMI14AUwwIlEFBuHPFQS3tv/23/tTk0HkWVads+y/et/AjM07ABctwsMxpAI5dPm+2auE2CbGQ6TFs0JVLaUP7Kgt9lfxnKbuErzm5ZMyoh/iGOaLChI0TTOHZE8731TzVvA392VKMVcT2gjkuRYR7f1sWn+xFafx6OEkiI6SoLG+VD7MADEfsl0JhQv92nrE0ENoBnibJhQmRcjPVH3kVjtv0MbWB0/zCLTEy5buoNzrDhK8dJznojSxV8SVA8lpKHuZAnJ+rvaCgtsx8yUzQSy44PUScwkUP3MTVNz0FEUfWNjRcz3vA2dvNmOr2AG9A+JewX3l9QPFfJtm51d6yQpLRmrC45l+6sa7QtEv+XIbQDQB0TZRmfysbtlcEslrQ93ZAn/NTgq9MMTVDAUpB/8bhEzLpDtb+AWiaylNO6+2UiHaN6CWoPsPRqFqhBDU7t7ULezSH/XqdT7m8feJQQ6cHiU6haVcucisuvOPigHZ8h7C+utiQrE6YEjZXNhKFJbLNhKctMGRiGzlk+h1SkHnfFSn8brjKh6BcTgEN8rhlWHQxqFLWkmlBFgv791+lUmSQ5gOLBhWvzDA+0uLD1IN1qsfTUSDg2SsUt8nrsmrQrbsTgT59Po31rs9b50A/Jo3kzvARoAD6O0V5QHkE447mGiYAfKgg521Wri0VAUf5UeWTUChUFX10R6R397xiRr6GZZ740mFBcipEN902TQM8O76G4Tkw8UnnRFok3MWVAA+KZGLqDp7dLSJxP2GeexTcQ1g3Ro7GEG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199015)(44832011)(2906002)(86362001)(31696002)(38100700002)(6666004)(316002)(6506007)(41300700001)(53546011)(26005)(2616005)(6512007)(6486002)(478600001)(186003)(8676002)(66946007)(5660300002)(66556008)(66476007)(4744005)(8936002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUFEREF1aDA0KytOdDVwSGhxa1hiclJyZmM0TGlHbFZ2MDFuZWFiQUtTeHUw?=
 =?utf-8?B?YVRlSUYvUzhpVDVrSytPRTVMd2ZCQjM3bFlYeE5BUGZsaVd5K2ZkbTdocENH?=
 =?utf-8?B?UzN2SUlHZGR2TW9zSDFRbCtSek1IZlVzT0ppQ3h5WUhqbXczSnBDWCsvYUM1?=
 =?utf-8?B?cWhxNnZGcU9WNHppWXV2aHp5RUpiSTBIemp0VjRQRGVMRVVDVFJmVWV1Mjg5?=
 =?utf-8?B?WHdOb0VyK0c3WDN5dGlqcU83QzZ4eGNKMThUNHdkOEdzNGkycDZtc2ZuYTZT?=
 =?utf-8?B?RG5abm1hTXJyVGovb2k2dVdKblJHM3I5VHNzRzRtY2cvbUJ2V3ViazNzTlFW?=
 =?utf-8?B?QUVSZDJUL1FXSDNoVGtheWxJYlZHbjNLTW5XTGZ5TGNvZWE2MlJtVzJsL3J5?=
 =?utf-8?B?Z1lIQVhydVIrQTZOV3ZrMEZ4aTMxcmx0UzBpSlVoYTU4bnZSdCthcVdSZy9G?=
 =?utf-8?B?OXg2dE9ZS3p3SkcxdTRET0tFc2RZWlFnSW1laEVxN3N4NWpVanYxekZXUWJm?=
 =?utf-8?B?by9QYk1WZnh4WjJ1MzIzeU40bHBqYWtmOFBqSStINFFkUUpBMVJRMDViOWxI?=
 =?utf-8?B?SHpVTGpvM1ZnblVIOXE2SUVBSUZzZGJjTjNjZ3JrZXBYeHFQWExEaFd5L3Jq?=
 =?utf-8?B?Sy80Uy9IKzdMcGJ0N2FheFh2TENTWmdjZ3hsR2hSOTVFRkQ1OUVucCtzYTlI?=
 =?utf-8?B?dy9EZkM2RnBpZFd5RWtUMnZoLzRJTnJ5dCtrbnQ4MzVRZ2w1RjBodGU5YkVq?=
 =?utf-8?B?eVhQRTE0c0dNT2tBbWhsa0thQ2hxQzZkWHAyZVRnZWorYjlYci9ydENiano1?=
 =?utf-8?B?bHI2UDlzaUE1SlpQQkQvYkN4bndYVklZRnl6cXZNNHdxQ1ZVaC85dE9XUWlD?=
 =?utf-8?B?emh6STZOMlFTY3ptWXptd2pqQnJKbmJXREtQQlZ1YUh5bkVwMzJSTmJGNHhO?=
 =?utf-8?B?bmhmcUppZGpkQnYxSC9OWUM4S29wY0VYb082WGwvcU5TWXhNOGh6bFU5Y2oy?=
 =?utf-8?B?WXR3STdTb3JJZ0RMSXJuRE9rNytjT2lqdzd1NDJUbWJIZEVnNWF2VkFrTjk3?=
 =?utf-8?B?MlM0OUFab1l4RnlVejhlNlBZR21ZdkJMakRNNkdYeUhKL2I4N2ZraEc1cC8y?=
 =?utf-8?B?UWpVVUxJbXpFR2JnY201ZHlVaTJ5R0p6SmFxOFFXcVlpaENxak5vbldMampG?=
 =?utf-8?B?YUhnd0Y2c0trcklPWXlabHBNczNVUDNuTTZXeWRtdlRGd3M0Y1UzK3p4ajFu?=
 =?utf-8?B?U3hVZ0svTGdUYTc4T0RNSlVxUG1mS01US1h5OVA3SEsyOWhVUG1SdCtEenVi?=
 =?utf-8?B?TkFmREE2UU1NUUpJNmJjSElXZUtpdTU2bnZoNlBsdWgzcjhDekxHUHp6bnZ3?=
 =?utf-8?B?OWdielNvL1V5VWkwWXRJcnUvcnRpVC80SU9tSDhITWxJeDFiK2pZZ2RiVEhu?=
 =?utf-8?B?anFoMzRDc2s0T3VuekdSdFhYdmk1ODBwOCtTVDVhVjJUQXhLUzRId3NSdFha?=
 =?utf-8?B?N1VFTG5hcDhmRm43QVV4SzdvclhLaWp0dFJPN01uU2twbVdUaUsrNkQvMjVr?=
 =?utf-8?B?bGZYV3ZEYUVxOXBOMGZOZDZIMk5UZWJMVWNkejJjeGFwTzNtZWh0NWVldmlt?=
 =?utf-8?B?ajhQNjcrMnJjdjNRZCtsRnZGOW1JL0srMFVycEUwdURaTjFhOFM5L2VGcXps?=
 =?utf-8?B?dUdGeWdYeXRxNTVJaFk1ZE1KVWJBbWRlWi9odWdIUlUybVNQcGdUT2ZKWXp5?=
 =?utf-8?B?N2JlcENNWmI2WWZNQnU2cEMzYkE2MUhrRjBVcFliaGhaMlppY0x6NUZlS05X?=
 =?utf-8?B?ODBibHB0OEkxak8xSmNuYWJyWndMcDdkSkNlcFBKL0I3bm9CT2ZHMS9YQTFx?=
 =?utf-8?B?ZkR1RlFEOCthRlliS2grU1NNMzkrbUFHUHNmQktPYkFiVDRsRVhMajVMNkZI?=
 =?utf-8?B?aGVmWmxzWTR5cjlBamRGdG5qY1dlTjlYWmN2eUFlL0tZK3NPVUJKTi9KUjZm?=
 =?utf-8?B?OUFqdVRHRUxtZjBlSkh6SUZzdUVtbm9JSm1jYWZYMzVsT2pHcTRrRE5kNGc0?=
 =?utf-8?B?dm5YNTRmRnhxeFh3ZWx5V1d6b2wrbXNldm56VXBZSDB6R0FzSWFhWldDOWFR?=
 =?utf-8?Q?iDtlq92tfudu/4JA1OAcUAgr4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae11157-0557-448a-7c59-08da97074b18
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 10:44:41.0245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHRUCg03yeG+NfdiaJPXeJqnlz/ZfhfDRs3Lqv36VVttbeh7phw4OvlliFxzKQZeX1b/h2Ki0PSDnSv5RkiYwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150059
X-Proofpoint-GUID: kIud2BGyoSigeVIhie1ZvbPldcYKtjZE
X-Proofpoint-ORIG-GUID: kIud2BGyoSigeVIhie1ZvbPldcYKtjZE
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 07:04, Josef Bacik wrote:
> This isn't a great spot for this, but one of the swapfile helper
> functions is in volumes.c, so move the struct to volumes.h.  In the
> future when we have better separation of code there will be a more
> natural spot for this.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
