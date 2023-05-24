Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C29670ED75
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 07:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjEXF6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 01:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjEXF6B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 01:58:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4218AE5E
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 22:57:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O5t60t019718;
        Wed, 24 May 2023 05:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8L/WE1HhBDhxryfihcz6OA3BEEcGrMR/oUJkkRMkn24=;
 b=mMeBqk+BKQjov6vleChpGNfieDlCMG9rM/8Oh/tJL1mCeLXpqBRgtffFpjePLVGgvRVH
 ERqjey2OfTSKM3BLlKXrvuOE9loQjGGrvZL6KMLhrO/TQguaLLcUimvdoGXJiABQMRZE
 rdcUqq7j9p568DWHHOAlw1Zk/8NAT0vuA72f0bOhH6VKcT05tCmbRv09IhXfjvtEOMeL
 R2O+L/RO6hR+1NOhA841dRhn2lBPHO2oD0IWfbYelFfB8/YGuSP66bNVsy3eWB3A3Xy0
 1RXAn/+op+VChb32ehErRiI3n5A5OV4psDelZh+HA+Iv5/gcqVah3azPJJKS/IKI+FXJ KQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qscupg04e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 05:57:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34O48vrI029093;
        Wed, 24 May 2023 05:57:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2bsgpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 05:57:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/vcJWFRD+VPEWrbZxWbT6gP7oRPEybl4FsYIUZW3iQFzDRlcIKjah2G5brQNLW8OtnYyNzq9hJK2TqplcRmA2Kd9E1btXzFHg2NUTRXbA6x7HP+KZkWpbPYvwHPcduDlIINiHr17RVH432JqGhGTXHmcRZa9bwB7JlOuDwTabkO5jtulEAhqoh5Y1zWsufVXQAGkQ5V/YWBadw45vFe3eFMSQ0tE4Eik56lgUbpplenw7WjHS1K+Wncpfvx42D/p1DMXOcc6ugbMmWTzBBXnl7dh8I9apkah4j4KBaWOXKP6K7iYAvSGR8z7Sa9JBG5FeqiZfCEnAlHqUsPOihU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8L/WE1HhBDhxryfihcz6OA3BEEcGrMR/oUJkkRMkn24=;
 b=aNSM5YWLkDV/+CIwN45I9lvxQqj6DteXDN+hHc371S5GqL5DNZxFAPp520AvKi6+YtlNw7ilcNGButAxRuDPnrI9OuhDhCmsJmSQ2T01NTILSSo3TwErVDjKZgIqvX7j1inTtpxctRrH0UBAwUnUFB4NwcPlAGwzIA8/DIQ52pfD/vmtHHWZpncm2DowrTpVdq1llhS8KjL8OP6GfqpDnVvQ7FKxv7j8ohiFCbFy3b0ZXHuVUFRO+yICPnQErdRg/ByDqqr4qOwkEHzjfKYsLKQnxN/MF0OmNdtmP+sKHzMG8eV8Peq555I/jow2m7fSBR7NsFRZKzATDZ92BzA5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8L/WE1HhBDhxryfihcz6OA3BEEcGrMR/oUJkkRMkn24=;
 b=jm0NcgOPaTGAr3Xu6sXFW4+Om4R+7bENOEm5emby/ZmvcQf/5WU8bigBrFGQjIMDn/sp+TjN9TRXR+bIUIBTbgQskS4hxYu1aHUeYAzW2OwAib1kDJSjUNPpbWKt0wZvgo2gNPMxy88QZr6BlE5KDA14n+5NJjDWj3o1jQKzgFQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5855.namprd10.prod.outlook.com (2603:10b6:510:13f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 05:57:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 05:57:40 +0000
Message-ID: <8e717d9a-318c-30fa-0d19-bc52fd30ec30@oracle.com>
Date:   Wed, 24 May 2023 13:57:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 9/9] btrfs: fix source code style in find_fsid
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1684826246.git.anand.jain@oracle.com>
 <cf801647e5f9dde29711a97453ff73641adec787.1684826247.git.anand.jain@oracle.com>
 <20230523212909.GE32559@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230523212909.GE32559@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c19f3f2-e039-4c2b-94ea-08db5c1bc888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmpocQw8uZ8t8MlxhfVzhVuXzBXfZ+XZ+T39Weze8Rtd0MYweQbRoT/66RUumIm1tggYGyzzrpfk+aLCxENgIP0993uV6hV+XNrDHjdOu+aL/7p458cUI4W/N2czHYiCxspRItuvRQXeaJBwmzzKZaK71rAVKtuAgiV94mV7PP/Avplb3iTJexL+LL97yu98j+pndL2weCHrwl95f3ZKgyjjP+uxkm+AGn7BfkJ9YuB3bnmZi9Ma+VcnpsmlJ+xqJS5aU7BoLQwD7+mgvI9jOGCBxg3NI4JvThduTwSorrH4Yd/MiIb7Zumcjj33l79kJ/WemMuA1ePZdqMTFmyr6QaurhqVTkXasnA9DxC/FcceBOjGlEYpOCwhLS6+wweQomV/8omoTrhEw/VDME6XLPyNrZMSQvhX3cucEWAUjxCdpcRUcO69axz6EIbcgsOMAiyOja9gAf6ThUFE6qJUX6qqExbbIaPilGyd5uHgdsOYjmQcvcChfNA8OqwHVYwLPLnU5Y8sVx2X9VGlujBYGcGGVi4rcIYpb6sxQYt725cHMk2wGIXMTAkSeVb/GAStw2qD6h4gxMj1cW7WY8XIJMPfgB2H2bOpOltBHnhBWkj9clx6E9aaK1Xc2RIBn2LM/U3fjjZusTdrDIpKXfN6kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(6666004)(478600001)(83380400001)(2616005)(38100700002)(86362001)(31696002)(6506007)(6512007)(26005)(36756003)(53546011)(186003)(41300700001)(8936002)(316002)(31686004)(6486002)(8676002)(5660300002)(2906002)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXU5SVlTenk2aGQySlFuMVVZb3NMQm1aSUZNYnhXYjdFZHJ4dDdoTHc0WjVn?=
 =?utf-8?B?Mm1oRXVvd1I4cDZ4SGRwN2J6U1BVUFhhZVcydDBnMExOaEVQQ0lEWVZnVTNX?=
 =?utf-8?B?YjF2SWxhUzZXTFBaZzNVY1JqUUdubWMycHpMT2ZqQ0w4QllUQThQTjEwQTZz?=
 =?utf-8?B?aHBXNUZ1aGhlNWtXVU40MXVDcTN3ZlhrWXVnTDdyWUZySldFaGFYQTQ0dUFq?=
 =?utf-8?B?Vzd3RHhwRG9PMzBQUDFEdHFwL1pOZGRpVnNiMGx0d0dZUjZuVm1mWFRNeWV5?=
 =?utf-8?B?RXV5Z1Q2dFVqVDA1QXIyTGhHOWkyUThLOGt5MHpTeFlrS3Njc3phUGp0Sloz?=
 =?utf-8?B?Yld1Sis5Mi9lVFVYK2cvaGNCN01MWDUxZDVzdURlanlWaklLekhNTk9zVWlq?=
 =?utf-8?B?S2M1UGQ3Q0h1dFFlWHhJYWdqT0w5MmlVNkNURk5MdkFGbjk2dHVabnphZElk?=
 =?utf-8?B?V0l0Z2Rzb2JiZmNZK2YyM3VRNmdMUy8xQzRnYlZyd3VydjR6N1BVTFlLckls?=
 =?utf-8?B?dHB6Z21iY1BqQ1c4aVArUE8ySFpiMGhNQVhZV2FoaWZWVXhoNmM2VVR3enMz?=
 =?utf-8?B?ME5PWk44MklvWVcrdzA1aE1PeWlpT1pwWW85d3QySTdFamxzTXlySWZtMlda?=
 =?utf-8?B?blFXRVJhUEhtSysxQUZKeEZsMEZJdVMzVzBmOHpYQVJwOGZpQTJ4VFBkSzVZ?=
 =?utf-8?B?dit3RDl6MUJFd0g4YU15eEtKWi9DWXMzb2p6dThtb3NhQ2lCOXRhRHZaQVRq?=
 =?utf-8?B?bXVqQ3Y5My9YNlFaenJoS203TEpZaEp3OExlbTloaVllRk15MU9DVHZYY21r?=
 =?utf-8?B?WDVULy9jWG5FUkM0OWgrK0JKQ3NWR3hON1ZxUzBHZlUwdTdlTis4ZHpBNkpn?=
 =?utf-8?B?djBhYnNKRWFOaHlKenZrYkhzK0xRT3dEY0dDZnBhejluU3B4cDU1dm01Rkd3?=
 =?utf-8?B?eGlXd1hEeEo1Z3hLWVMwOXd4U0hodnZ6U2dUaUdYVmtxRjZHRzlwQWdFMjhP?=
 =?utf-8?B?RDltRkU2UUtDUTNybG54OHpweUtwc3JVZjdSN3lDZmgvWXNtYWxoQ0UvL0dw?=
 =?utf-8?B?ak9zMmgrd3lxaVlseStLMVk3eC9VcmFLNG9vRHprWHBLc0t1RThsTmgvWklY?=
 =?utf-8?B?NWRMRUJNQmxsRU5QTVU4d2tEMlg2dVBsR0RoVFFjZ2RzRlNoa2hTYlI5NVFv?=
 =?utf-8?B?VXhBaklrZHIrOGdiWWYrVVhldDJudkFEYS9ySTl6SkFIbnpOaU8yOHhjU0pT?=
 =?utf-8?B?ckRjUE5nbGJlMU02SEZya0ZwVjlnbUc5Z3ZCRXdEa2tDb0dZa0xBL3FvdGFD?=
 =?utf-8?B?dnhkZ25NUUQ2RjFabTJ0S2xXSWxUZkJCUUNya2w0eG5UcWd6bDVJRnNzNzhJ?=
 =?utf-8?B?YWUxZFIzZ2pCWnRMb0l0ajNBdlF3ZVRObkUzbncvbCtDQ2p1MDZVWHB3MVRV?=
 =?utf-8?B?YWZxNEY1TXhjdEIrL0lNcHNwSTBvamRLWll6cDZMQWQ3a2x4VVpaOXdNK2tq?=
 =?utf-8?B?ZEF4RlJ3TTBYeVBtSkkxKy83NXAvZWsyWFdoS1I3dExMOW5IbEozR3d4WlhP?=
 =?utf-8?B?OS9DKzZ4MEdlbE55M29sWW82TXhWdXpFTFdvSUNSL0FwU1ZwNGNSSkgyaXhE?=
 =?utf-8?B?aU9WVm04ckN6Vi9Ncm8rOStPY2pjU2xaemZYTjJVUnJHKytNWFNpb2VUdklR?=
 =?utf-8?B?Z2NzQ1l6UVlIV2V4QXNUakRLOTFHcnBSRTc5VDZUUnQ0dXRtUXRuc3ludUJ0?=
 =?utf-8?B?eFVFWU5MUXdZV2Erc2M2eEtVeUhqQlVwQTh3V2tiYUlCWFVyQU9icGNOVXYw?=
 =?utf-8?B?OU5sQXoreXFmek1TSU9jdUR6V3J6MkRYaVBFL2VRK1dHUGRKSDFESVh2Tkds?=
 =?utf-8?B?bkdLNWNrenQvVzlWR1V6dnp0SndkV1pqU3FFRUVNcTR3MzVrUXQ3Z2lOVGlB?=
 =?utf-8?B?L2Z1Qm5qYmhKOUM2N0NYMzVDMkd0UWxoOVZuUFJlZi9wb1VYTUUwYVdYNGdl?=
 =?utf-8?B?eXE3NmF1VDBTdG1ZcDVrQVZacmRaZTEyUEgyLzVwdmJGdTFDajdMelV1QTEz?=
 =?utf-8?B?ZE0rM1NvSUZ1aGVoWmRlbnFHYW10eUFaWXozZVI1UWtXcFRlcTRhc1JPV1V6?=
 =?utf-8?Q?/AF1fHRUx0KajQvnxU1P7myrW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g7e6R4BUeR8WMzaSe3M81kRlLjl5uEHy3pypuK70GMhFujzv0HMM7HfBs4mK+p7zagU/fRNONINQyZ/0Bz988rMjyUB1nd/9eZjaOfZW7LEVU770Q7ArLJmuO8wLmalGHXE4/UpaRqq/qB/m1yptaXSOB7cC03KsE5J1mV/ZjmUSCsGTePQpFkvSykM9ovQyaUnYglwxiUH0gb1XqWQoDOAE0WBfotkBYj+KnKVNkkY2/aTvwxQuaxwcbsRlO2rTx2HxF5+0dPuEaHQYnzfljcF2s9ZMbUTtziGlaX7dJWdKSyLN+2bFgQsXte06GcqMTNud45jSMSorMHTwHQIaHtHykeah9RI9d87H7/V6DVxrR7qPJ5oprcG0+bAqXfZYd69KsfxIbVccXHrudPENOA+XwSCh0f0dZyDwzHfm5iCHo4tOj/9qvVLlcjPT985b6E01MFi56I2bHuYmXO77P3SADlcjCphM+X4A7QIBv9e2P9655h0eRLqgVBtZRDJsoP+0r9aD9CTGAHqBWWX2sSCSbW5PqEaVHGIu2Bw8DPY0fu8sCjFSYzsPIwiWMk4NVS6B8pBEeHpZ5e607ZF7c/qSlGZ0YAA2ayaPYCB2MkgteJFESAPjj3/r56Adb72wuLp3UZkRYOX9o/ghqCaxBB9EDlqNfymWnCged7sbq27Qd+yU4a8c+1mdIkhi8ue2MDEhsu4nvGOpo+0YI/g0uCWLbkzdsI0OmzGtH76/233Y4MaUX16vEYHCUMjZR7TLXwuhksc3G0SsBdMXv1FIbXIxD3qbY9ADnpA1wzXSl6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c19f3f2-e039-4c2b-94ea-08db5c1bc888
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 05:57:40.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DST9ynz2JYfeBmM55SxanItZy5BaOK7X3S8d8//5smWgaKKBBRzE1hU3dwWgdT1Z5wk+8lQYBQy+cV4k49kEcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_02,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240049
X-Proofpoint-ORIG-GUID: KPeMlWQbFa9rC17KIT1GFCv-jdwMNUk2
X-Proofpoint-GUID: KPeMlWQbFa9rC17KIT1GFCv-jdwMNUk2
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/5/23 05:29, David Sterba wrote:
> On Tue, May 23, 2023 at 06:03:25PM +0800, Anand Jain wrote:
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 730fc723524e..db46df2f8fb2 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -443,8 +443,8 @@ static bool memcmp_fsid_fs_devices(struct btrfs_fs_devices *fs_devices,
>>   	return true;
>>   }
>>   
>> -static noinline struct btrfs_fs_devices *find_fsid(
>> -		const u8 *fsid, const u8 *metadata_fsid)
>> +static noinline struct btrfs_fs_devices *find_fsid(const u8 *fsid,
>> +						   const u8 *metadata_fsid)
> 
> We have lots of mixed coding styles, patches that change just one place
> are not so useful, it's better to fix coding style when the code is
> changed. If there's some consistent anti-pattern it might be worth
> fixing separately but function argument indentation is in the category
> of harmless but unfortunately vastly inconsistent.

Yeah, I agree. I'll drop this patch in v2.

Thanks, Anand
