Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC85BCBDB
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 14:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiISMeG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 08:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiISMdw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 08:33:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092872D1CF
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 05:33:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBx4cq020073;
        Mon, 19 Sep 2022 12:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OVMGLPwa0sS+7Ws5WXv/Zr8TqugPuHV84OKEPWx7Ihk=;
 b=ztk0IntEkPVchcfVPqNlFVGbQbSdmIokuzahVcnn+rrQdfhUHnhIko+ly+ms+X4ENNk8
 ZvCFuZtwlBs1aFJIX0qydn5KJj31xnxsvSH+rOTvL3VoduGHJuYaHKzhvhHn+tTA60H3
 kjp7DgxYwEWu9PoH/rLzEaKjegYHCYnWRTtnJK7in/fq+btnO1HvzRR0GOabRJnamqsc
 B0Hi6E9m43vTEsQE6gxYnnhOLADQaoNa1Ui3PH4GWVv8fFna869MvrBCT1lrFlNeX1z1
 77OwoUShB0X9uSfSQ8SLa3TDvPbsXPHwHc+77LcoKBCx0bj3Tw0uhqhlIkVpxWPY1dan MQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rbnxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:33:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBGnP0016657;
        Mon, 19 Sep 2022 12:33:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3ckupkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:33:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dD2oBP3c4SkUn6U6P3JABXu7qPAWp4t6SyybpStbUDCVzWyj/ZCfSdk138GUFJrBU6Atb7cYVLUr4PxjQqhldNIfK7T4Ggk9JkirrVrkOJXmoKY6p71pdylOcgZALezv6CW3hx0niOirc/IRaKakkDFr34Dt6AMguhYZDZo2D93hNOp4ELpFYrA3tCNyxVQNOTIoxxodnqqgFE+TE9JedYNzDd+qCEJQFLszXrHFsHqeAjwNvA8suEWEjYOEfZBtvgdX/Z69FriRpfps/Ht8G+Yd8gC8tZvE6DK5yPOxhT1d03C8QmgCpVgsLXNL6R/h2j6grRk4VIRaUpRFu0cizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVMGLPwa0sS+7Ws5WXv/Zr8TqugPuHV84OKEPWx7Ihk=;
 b=OAJeBzFtn86P9VR+bBBGuuj5WusRPIygUGbMOxTBb28KGlLfbIxyvzD/U4gef8M9p2k/ZTsdVv6aNVem537la6auU8gZIALtWTVXLSucBPIzxIdCLu5o9mfyQis409bSPuMDq3TXeP0Bdntn/G6H2tOS+zIy/kkLEnl7X9eVZxSzlBM2u1ZB6LOstphZGNef9QwPpKOQm3Mije2SXQ+uRpyftk4uiDNJTKHCApFQentkpDpiuIHBN3GcSoj2If6RrJzqtyReC/JHuZwHRXIRx7Ji4WiaVa/j0VXwR2pvGr5MA45jrW/41yH9WWjNz6yFMMtXlbqxAEVi4ph2bgv0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVMGLPwa0sS+7Ws5WXv/Zr8TqugPuHV84OKEPWx7Ihk=;
 b=Pti1cuxL1NwUtO0chDTd0zZU2CKYnWXRTQY5b/Q+xIEXNBmt4punEbQ5MI9xi76sTFNi1IIUhBjCgp43h750tT+qKYiXsALt3oBRMjMcc98Q6PVJfljnmCkGvQV/p8n9Al7EAJznI9rAz2ZowhaQzJo2zjT7dKmGMK3I4LTmxDA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4799.namprd10.prod.outlook.com (2603:10b6:a03:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 12:33:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 12:33:41 +0000
Message-ID: <802daacd-3fea-c239-c002-2914a25e3127@oracle.com>
Date:   Mon, 19 Sep 2022 20:33:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 11/16] btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
From:   Anand Jain <anand.jain@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <14fb62f9388bc8f8a129a74f82abe5e7978d41fe.1663175597.git.josef@toxicpanda.com>
 <a374a77e-a3cd-4eab-808f-ffbe0579a283@oracle.com>
In-Reply-To: <a374a77e-a3cd-4eab-808f-ffbe0579a283@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: a68844f2-b795-4458-5794-08da9a3b2f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2kBAY9iFWbwLwOu80lY+h5fILsBp2I/EWaOfckXIVw0JY6MlRk+zBVeQYF6BeO3EE26hFmebQuGHgBvTPETBw1OkNW0wqk7tZjiDHhGAPS444nrMnJQ1Qi/Clopm0FOGktASIHVbns2NvpqiJ4Gvt2uG5RzGO/ynvcGHGTawudmEDpLO/k3reJ3PP6njST5ip8s5Q6oU/K+xGuXtsvp/Tib0IbBEhXIlhRh+9CleL1qoF5QLSRRWS3OzrPizyLKBgQae/xqJzEsuYBnzFcHaIL3Ur1fCJ5fyE9zx7y5lYnsgBJABzwi74OwSSgZlHWcojiuFDMr2/J2RwxWrD2vf1Ry0yVlNgXKy3PX6WCSl2RGib1v5VBnc+HUd4icI4nKwdLbnzTeTCMgF7nVTBezVIUjO1RzjaOQ96L5B+/iXnHNoByhICGT//Inj9zicZmvXpu60Tau8YoBzgxvULc0ISCDCyar2zOmdY5N43DdADnllFowxjJrn6/AL2NpdjODZu+ck5GCHVZChYtOXG2wm22kSQlLp8bDOOxN2osvlYd94XqsVA1dfZALHj4+TIor1dtmxHKYGbczNdP8YgIFxQUuJBS2VE8pYbvL2yPKYpufOLsTedvmCsa4i1+7Zw2A0wOU6zeGq54EYPhmxetk65ot+jptn3MmwM7YBk1GMxSB3I2y/y7xV0vPjVfO9s+B6ajtlCEIntMGFQ2OZ5gpA5nxnAmiSGzOCOjrmT3qUF8PDYno3kbXwDd7HxFL6yaA7rtqXvAH9VzDbVRCXFgphKpsB5bKwY66+1stvXIE/6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(66946007)(8676002)(66556008)(5660300002)(66476007)(31696002)(86362001)(8936002)(316002)(38100700002)(6666004)(41300700001)(6486002)(6506007)(53546011)(478600001)(2616005)(186003)(26005)(6512007)(31686004)(44832011)(2906002)(36756003)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blQzTnVpSXNnV3EvS0duU2pVajJvVEQ4ellDMVZHUUpFODJ2M1B4VmU1OC9q?=
 =?utf-8?B?dDNPbDRhVmh1cEpmNVJGVlhPanAzeG5yKzZSSGY3azlXUmlVWlZSZ1JBUGhI?=
 =?utf-8?B?WWxUdDZPZ29SazJvdmFpRkcxQjlBQUovQ3hJSmp1T21lZENrZXk2SlROSmJt?=
 =?utf-8?B?cld6TlJqTTh4aDFmaVRwakVMZG9UK0ZMZ2FsTFdIazRiNnk0VEtDQi9Ydm5U?=
 =?utf-8?B?K2ZCZ3UxN040RlBRcWV2T0N0VEhJYkdpMEpJOUxYcmdaN2dKWXQwbHB0WmFY?=
 =?utf-8?B?aC8zKzlrSVFjVWVTUlJUQmpFZU9ZbWIrVzlRS1ptWm5wVmorSUhmZlZuUlVR?=
 =?utf-8?B?VGw5QW9ETGQwenlQS0hOeVRPRnVPRGV1bjBHVzhVWllDdGpTYjNxZGxpZGZT?=
 =?utf-8?B?YXgra2hnbDhCeXpnYjhROXB4R1pCMG40dkYvb1Nic283b2ZxcWlyeW92N1lC?=
 =?utf-8?B?ZmY1dUl3YndIdVhDRzgzaStMZWFhNFd3akw3bEQ5WFVEQTZmc3JRa21ZTkNR?=
 =?utf-8?B?K3lUemdjZDUzVlVOdU4xNTlNallYZm1ndFNXUXdSUGVuV2RYUUFCWE9kODJs?=
 =?utf-8?B?b2phemFjV2VIQ0l5eXhINGd2N2dsWGgrb2oycG9SWXNCMkl5VHZxT3hJaWFF?=
 =?utf-8?B?bHdaR21VbXZGSmxLRWE3b01BUVdkdXRVdXVHcjNrRlIzRkdUWWN2STB3RElu?=
 =?utf-8?B?RmNlajNXRFR5amJOU0lMWWVoRDJkamFJWE9PMDNrOVZvU1B1YWo0YXQzUE5q?=
 =?utf-8?B?V1F2WGcwWTNreWZaTGp2UmhPSVMrT3dVWkd5RWQzVWtwTXg5Q2VNaGFuMFFq?=
 =?utf-8?B?WXdZU1BiOTN2WFc4a3FBWisreDZJakduWDVQcTYwQWV6WGRRamx3clprMWM5?=
 =?utf-8?B?L014Vmt5ZitidTd0MjRsWjd4NGFUVmg5dmRwbFpxdXJaaHhKY0JBdFgvTVNK?=
 =?utf-8?B?Nm5uRExYVWMxbHhXUWdtKzVsZlFyUityZ3JjRk40QmVxUHd4TXFaeG5WaU1G?=
 =?utf-8?B?a2Q3aG9kbjl3VVZ4MHhQTk1kSkVOaWljclFjVEhKMDlnQjZqdVNZMjRkcUVQ?=
 =?utf-8?B?TUlZUE82L1FqSnVCdjEzQStHVW5WZmlaWmFRR1A0VWtYUnNqRVBHVm1ReHph?=
 =?utf-8?B?N3F6a0ZINk1hSTViQk5nTmJ6ZjVuVkd2OTBJTU9UWG5hZWJNUWpOVGpKSTIv?=
 =?utf-8?B?TmtOM1VUc28zRUJJK3p6Z2RGcy9SQzJtdnhFRkdqMk8vVjh1U1pWU1N3VGRz?=
 =?utf-8?B?YzlXQUFmc3pnaGlxZkxNajl4ZkdUdWxXWmRYWmE2YnJPbXA5Nkk1bmpLOW8w?=
 =?utf-8?B?Z2Z5eXJJRThqaG5XQm9MUFpLbzZsL2ZJQlZyZ3VEcm9Jei9oaldHL0h1RjF2?=
 =?utf-8?B?ZjZqMXIwT28rR3l5emo1Q2hsdU4yWXg1anNGWkZzYjliUGNZb3hxWW5yYUJ5?=
 =?utf-8?B?cXgrcHJGUmNMTnhMVmNlbjNydTlNOWkwOUdBZG0xcWt5WHFGaGd5RDgva2V1?=
 =?utf-8?B?Zldya2I1TDVFMC9vVE4vdXdMTGxTTWZTVmpMWVVtWVhFM3FBWEZXK2szbnht?=
 =?utf-8?B?dys2YjQ4UzFZNUdxWFVBMWV6N0k5bWxEWnNRUkxPMDZtMDlNYmNpUDJBbGFJ?=
 =?utf-8?B?cEl0clhlbWNmQVlScktZSGkwQVlZcVZveXZsTlZiZitiK0hxdFpZOFI2NXNp?=
 =?utf-8?B?amN4dTcrU3N3ZU9qdkZ5OVdVdW5jMm0vZXFwajUvZG9oRzlITHhkMWtYUysw?=
 =?utf-8?B?bUdPejU5QjdSMWQvaHdUc1BVSlJlREJjZHhueUxKeE1mYUcvSHVWb1dXZkh4?=
 =?utf-8?B?N3dCU0VJWHdFVmxOY1pubWVvcTNlWnpaUjhTeHVBU3F5MXI3amkrNkFta2N4?=
 =?utf-8?B?UStuaGxZejAxbFp0aHMxMDhEbmJjZHZQRms4VUdOdUozenNsWVMyTjFBU2Zn?=
 =?utf-8?B?amY2a2tldHJObEIxc1g4YzNHUU5nSy8wM3JZVG0zYVJQVVBxNThMeE0zM2tw?=
 =?utf-8?B?ckJIZ0Z2SDZpVWdzZkZWZm1yZ2Fya0VaeEZsb3FTUE5nZjBOQVBTMnR4cURO?=
 =?utf-8?B?eGFBY0s1R1N1UGJDY2g0RVFWd2FRelB3V1I1VDMyMk55dHlLWFJlSUtWb2Ux?=
 =?utf-8?Q?aUzwXA+OojetS4QEmpHCFC0vz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68844f2-b795-4458-5794-08da9a3b2f18
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:33:41.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEPtANyK7aj5IaDz4IVC56zPeljX1q6g49m6NYmCB45ZZl904tRMX47t9uPRdKLgnPLwbQMKLMlYB0XCZ7MWYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190084
X-Proofpoint-GUID: 0uw_MXnvap6Y-ypsb7GX8gvgOD_v9q_w
X-Proofpoint-ORIG-GUID: 0uw_MXnvap6Y-ypsb7GX8gvgOD_v9q_w
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9/19/22 20:30, Anand Jain wrote:
> On 9/15/22 01:18, Josef Bacik wrote:
>> Currently we are only using fs_info->pending_changes to indicate that we
>> need a transaction commit.  The original users for this were removed
>> years ago, so this is the only remaining reason to have this field.  Add
>> a flag so we can remove this code.
>>
> 
> The following #defines are unused. Why not remove them?
> 
> #define btrfs_test_pending(info, opt)  \
>         test_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)
> #define btrfs_set_pending(info, opt)   \
>         set_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)
> #define btrfs_clear_pending(info, opt) \
>         clear_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)


Patch 12/16 did it.

> 
> 
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

