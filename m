Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE4F58952B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 02:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbiHDANT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 20:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbiHDANR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 20:13:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B514D15D
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 17:13:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273Mw5f1012872;
        Thu, 4 Aug 2022 00:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/HjxjkM85PHkN8a2jnIcLf+uR+WvZ+F9f9Moyg6DqdY=;
 b=zhzJzKWVWACUeYXHruQhRXlKmzxqnHBwXAqGBebnWDWTuG8pCdiiVSRuHN/eGwjRwHAh
 FIQksBvf3hnZeg9Wd4dsZXtqaYGDHKv6F8GVmfBsbjN+6hYTefRWOi0kH2QSQecUd73j
 KoYIkPOic4ldZuCM9+ntK/EmfA/9bas7OPI7G/EKqAJXVugB0EZREknvuC9GxhuSfqzp
 IVplHCEeESV8LhBcCTrGVzu0dtGJLGhIAUMIrv7BI7XqmuVx/GZ1ltN50SlVeNQPx4Qb
 YdVHESi+nCXrllDkc0iJsmzS7aepBtrpbJRKYn7CvMrwTiBdcA6Xv6V5wtf3YWKyeQiq yA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6tkf6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 00:13:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 273LHRup000972;
        Thu, 4 Aug 2022 00:13:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57snvfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 00:13:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW3RAxKkBBqAJ1LKrTsRutparZ3AmW5ROQAw2uvTrFzrPFFeKGwP98McPltfTtiEUiZR71+54zacSNO8hG2rb0QRG61z4KdEMNkx4pP74mD3+MdSuF0uw35J5Y0617fpKW5lV17gFiTISZ5q0b1wNOK6vBUb9BG/DMWEHrlGOLnLaDmVdeHeqq8vxs6tm+F7utbNlJJPJx/W2jCrCD9epBIRqRDWLz8q/N/SyMvfqhYxXAvV+RBp7Dor4pEnJUllRSj+eexvz0FyX+mgncHwjVXmXlkaE6drt3QcQTidb0FucfKhbofBquWg6YLTKFOImBBGbmvX3UqDeAbHkB0zbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HjxjkM85PHkN8a2jnIcLf+uR+WvZ+F9f9Moyg6DqdY=;
 b=iiQcPpBNwz0ENyI4iIoyaN6Ocu9lY9UPwrfNxJtlgb8EvEHL1eqoqRoRy+kTercRtEcDb9IoK2GvqRR9b3BUB4AnmlB3cN1jaRlmO/d88HzcPuH/eVYo7xvtnsN2fe0xqqjDsINCTr/Ujq/eJ5Kq/CWaggaY53UiwKdIPOOeGWc9EU2QZU3G6wDrlv6GUv+FREBxfy/ohSC0F56WdiPDeC1T6LnpAW3OAajHsCMSUGOOeN4kmrKoi4E+rLEBPWZ9jvtKX2oroU5KJP4EAE5UPcvQXJ99qNEY7y8l6rQ0NikN6a1qjF+yxETg6z7ZSzluEZoyg+jhTln/kSjWNDwPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HjxjkM85PHkN8a2jnIcLf+uR+WvZ+F9f9Moyg6DqdY=;
 b=wqNTpbno71lHsmAdYSY94rJMJVLvweK811lSG3GAlkzTZX50LWNKX3uyckMxg6lENuwhweiI7MeIO/DOtN7dl0kbVXuA7fOLSThAFC+CKkN6R/BRxKKrL8yh+vZHpFn/vq8gwN5TolJ+qAg9T/ThvdNMOQ9Uty9X29ciNu+nLHA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB3451.namprd10.prod.outlook.com (2603:10b6:5:61::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 00:13:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 00:13:03 +0000
Message-ID: <efab50e3-dcd5-5886-e65e-a4b88d7fe5e6@oracle.com>
Date:   Thu, 4 Aug 2022 08:12:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs: sysfs: use sysfs_streq for string matching
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220802134628.3464-1-dsterba@suse.com>
 <1e1a6e01-da6c-a82f-1606-6e548451884c@oracle.com>
 <20220803131529.GD13489@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220803131529.GD13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03e64a23-d609-4c49-0c5c-08da75ae194c
X-MS-TrafficTypeDiagnostic: DM6PR10MB3451:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tl5mLDp/9vsV1UOoOELo6a2fqNNFh/BSHMM2LSBWq/3Ku0mvJ757FcRFJ5hSqsguCbnZ42pxhgvoM6Fcf8gU9wwgnX+qyO9qBXP/FMY+VtHLwzHijdxuRvU5VXx4ajaXBg5qX1YVy643orDTflbzFtZk7TJZFIa9wOBUuIFWeHUsVlHAaiZC5qsZ4loAKGnXR4oeUv5yv0wW5FAJMbCL2ZAR1BmMEP5OhMW9oFl1eOm3+/ZU6/4rQ0wFjZTZsf+KxhTndTU+l/uA7q+zXVHN5LVL/POU+1TON3/Zkge35y3KLv47tNXvzgxTIP5qAYJzs9aCXzRNztgdyo0Lr+C0xlUjZQxVJZ0uir5wjfl78JAXKct2PF+TXyvfjtkauw7pj08OMrsMiNc9QkjWRXUzpyIp8/eTK3Ex1BskWxtB/9nfA3BOe3ydGgqfHjnU7XljXpRHAhg4ordNJmdFtP+ZdCo414NB2BaenFsHGynm8BGIfWVHkTCFgj7cndpFgLXm+oCuznmbQnb3zWb8kYrKReWkCY6UCNOnr2LiSSAZIUL/uc1lfx43Cj53L7BNKF8ohZOmlR6Q1farjXutnRoX+qrImwXRIiB5/flIikFDKM7wabIA1ydqAIhl+AFmud1cX3xXuBAihYLGao8WFvr+cloTRgyv2T7xFZFqY/JdtKrN/GFIlblpdSuxWlSh47aB39pXvQSRycAmPLguv1qpgL11v6fnEempBPrz4gkFTBjOfq0iqqKoi1kiVLNu62v/07HHPDlFeeyLGN2Am+fflQ4AvCLAZSB7tTMNFpDexDA0Eu6JDfH4LTL2DbRCdPsdv/7ajm0Ors/v1GeWUuZ1Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(366004)(136003)(39860400002)(66476007)(8936002)(5660300002)(36756003)(2906002)(6486002)(8676002)(31686004)(66946007)(316002)(478600001)(86362001)(38100700002)(53546011)(26005)(6512007)(6666004)(66556008)(186003)(41300700001)(6506007)(31696002)(44832011)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk1WRURMUFFic0p4Y2pHa2NJbTRaRjUvU0J1enVlZ2FOZVI5d2g5Ym9ES2lF?=
 =?utf-8?B?NTZzN3BjcUNZTVcxZ0k5K2JuWXFURjFEK1hSWUx5aWJpRys5RzdWbjdtMEx2?=
 =?utf-8?B?ZkptRUk2bmlMakNQdVJGWUYzQWhORUVhd2FGdXd6c2xGL3VqYTRsZWNYaDE5?=
 =?utf-8?B?TkdGTFVycUZzb1ZvS3FNRStOYjFRbm9MOS9wTXlDWmJoeWJxSjdYRUgwVmtz?=
 =?utf-8?B?cDYwV0craHdueUJwWlI2VTlhRXExdk0xT1JvVUtIZUFFOSs2SFpmMFQ5WFk4?=
 =?utf-8?B?TENjQkVCek9palZ1ekNYZWdRaDM1Tk1OQXdPWnhsZmUwNXZVK2NyY1lvNHow?=
 =?utf-8?B?MTZTSzVBajZnL0FEeVFvREhzeGFjQWkxN3d4NnNzZmZGSGNGZ3cyWU5YSmNY?=
 =?utf-8?B?eXYvaks5RDBuREthZEY0R2Y5akdmL1NiMHFNYXRUam5QbFpDV25odjNRV1k3?=
 =?utf-8?B?eWYzSGJLY3UyZlJDRjRFWjRhMmpNUWthNVVwbjI3dWN0T1o5cjZZL3ZqSG5x?=
 =?utf-8?B?Wjh5SGtzVm9WSVFqK1Q3VzJ3WFQzaHVVQndFOExzMkhlOXRmdkdFWVJZNTl1?=
 =?utf-8?B?d08wUjk1RmlleW4wcGViYmRxa2tNSG9JcmplR1FpZkxRTmRtVTVQWWgzSjFU?=
 =?utf-8?B?bDNITTlTMDdaUkFRVUMrdEFFVllVcUFrSjBEV2xaempNNXBiaTZ3aDR6YVY3?=
 =?utf-8?B?Z2FrNlR5eVhjcGZ0SzhpdU9iV0FRWE1Va25mZkk4Sk5xaENVWDNaRFhOcCtE?=
 =?utf-8?B?ck9kVjFJVmdiVHArbEkxNFc1eTZMYWxvSm5DdnRVbUdoT2pzQmhnc0NtTVY1?=
 =?utf-8?B?UWZKcXhCdUN1aVdRTzF0YzFETmxWazRHUVhPVVYrVGdncWVjL1B0aW5HNXhH?=
 =?utf-8?B?U0NpUEJSNk1WbzVuaGQ3dmFLKzhQeFdxakZ3K3VrR05mZlZsdk9hOC9aNXdB?=
 =?utf-8?B?eXdsY3lBdTlZU2JSNi9TdU5xMDRsbEJCMHJvRmdudkptZ2JFT09NNHVTbWIv?=
 =?utf-8?B?YnFwUzlOL3A4bXRmTGJPcHFGenBmMkI0S3pxZmxVOWNEcWtELyt5ZDJSSlpY?=
 =?utf-8?B?SFNjR1NDdXVOVHY5RmhoazJ5aDFFSmIzQVRkNW14L3pwaEV1OW1RMmF3dkcv?=
 =?utf-8?B?SGdxZURYOTRrOGVScDBYNXNIaHZyT2liVnFWLzY4bDBRL1NBRC9WRmVXeGtp?=
 =?utf-8?B?bnNyZnFabjRXelQzS1EwMkMvUjdEWCs3Z2M1NUVJbHZreWZRTU9CSnJyZVVM?=
 =?utf-8?B?a0hxTkc3OTR5eWFIRXo4VUN2bFRWL3IzRklBVEtiMy8xZ0d2bXo5dnJ3aktW?=
 =?utf-8?B?WXBpWElneWxwOEUxb2lNQW1ST1RrTXBBazdpSVhubXpuSHBFeVpyUGJtcTg5?=
 =?utf-8?B?NHJqeVpDRnRGa0gzQUxYa1lwYTlWWlBwSnFUOVVpb1I2cHl3dGd3dXptdFh6?=
 =?utf-8?B?dHVmZzRwY01YN3RWT2s0L3AvY1pWVmJ6SlVOMTNCUXZ2ZjFmSXNJNlpmL2RB?=
 =?utf-8?B?UVJPK2VKekN4eCtFS1BWaXh4TzdISUZJRysxeWhMdjVmT0ZOQ0p1QXBtU2tE?=
 =?utf-8?B?SzQycTJNbXdaWGNHckFyMUdCVUkxTlBoRkQzK2krZ29VdW96V3JkcDJQQ3By?=
 =?utf-8?B?RzRsRWlnTTlJNjJmUC8rZVdndHJHclNaNCsva2lOVnhoaWJMMS9ZaHZPZnNF?=
 =?utf-8?B?SXBmTUJCQlJKZ3Bxem51Y3BmZmxVZlJ4alJCbkJGOHR6STEvRUFCRUNyYkVt?=
 =?utf-8?B?K0IwMzFtYjBMOW4xNmJDSVNCL1dIN012R0JDSCtCUjI5VGRBZHVpNThaOS9C?=
 =?utf-8?B?bkYvWG4rbEkxUG84NjY1SC9WWkZ1c3d5K2lYV29GWEFoOVZKNjRzczlMcDh2?=
 =?utf-8?B?Mm1UZnIwM3A4Y1lrQ1RrZ1RPeDNYL0RZV1ZNM3luZnFzSlNXUUM1L0o2SStl?=
 =?utf-8?B?RTMwanNtWGdjQ1FmZzNoclRwREtGL1o5T3hMaVVkaSttU2JJcnhnTXVzQlox?=
 =?utf-8?B?OGlCa1lDVDMvNGd1V3FHSk9iQlVZTjdwRnJWMTNsQ0k5UXBBNmp4U1ZoLzdM?=
 =?utf-8?B?Q0hXM1V0MGNxVzlNZTUwMWFVVmMrcktmVTh4VWpaUlVDQ0NDUTZaRXFZeUpL?=
 =?utf-8?Q?aUBcTbXuHIjK1518gWSd/It2A?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e64a23-d609-4c49-0c5c-08da75ae194c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 00:13:03.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hgn6Ifjx/0AjMSRVYTeQaz21bZgdgPmcstZUWBKGDb1waOjW7iPl2tFS78+VU43+Zw8JBxTKeyakCpSm9Y5iKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3451
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_07,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=906
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208030103
X-Proofpoint-GUID: ZSDHvfvFoylxMz899jVAu6iQ5GuqNrzk
X-Proofpoint-ORIG-GUID: ZSDHvfvFoylxMz899jVAu6iQ5GuqNrzk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 03/08/2022 21:15, David Sterba wrote:
> On Wed, Aug 03, 2022 at 04:01:23PM +0800, Anand Jain wrote:
>>
>> David,
>>
>>    We have user API breakage. Are you ok with that?
> 
> So technically it's change of behaviour, OTOH allowing initial/trailing
> whitespace in the values is not common for other sysfs values. What is
> accepted is trailing "\n" and that's what the helper provides. I'm not
> sure why we allowed the extende format for the read policy. It should be
> safe to do the change now as there are no other values so nobody was
> writing to the file anyway.
> 
>>
>>    Before:
>>     $ echo " pid" > ./read_policy
>>
>>    After:
>>     $ echo " pid" > ./read_policy
>>       -bash: echo: write error: Invalid argument
>>     $ echo "pid " > ./read_policy
>>       -bash: echo: write error: Invalid argument
> 
> Yeah, do you have a usecase where the " " must be accepted?

Nope.

> It may break
> tests but I'd rather make it slightly more strict and cosistent.

It is fine with me. The use of sysfs_streq() makes the interface 
consistent across other sysfs knobs.

