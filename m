Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253D85BCBC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 14:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiISMZ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 08:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiISMZ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 08:25:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30871DEB0
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 05:25:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBx9BE008668;
        Mon, 19 Sep 2022 12:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BsKqZM4ueYauP7EcQTebAjmbsitJ/cXZO8ZW7UDLSDg=;
 b=qrEXe5zyJH+LsYzrFIT7vCHg600eGXugpa3JwGwzJDX+f6ZzldYvTq9SUXeACPNsUdEE
 NwvYx5srS7HOZaBR5VaJ0NRBCUq/qRhVSejfXm2geMYhc6Tc8d/KVRxbCEVBjA6jUEfw
 PvFrgA0SRkJjdsHesoovkI4o8fkwklH9IdnKf+h7mj2Yg+8C7A9gVwSMt2ZVUld9wUdX
 i3DFKQ0gVFMD4Je7Q05ICr7R4MgRRR3UQ1xTjHoY/1wG3+ciwmFpVLxUknasb3Uqu3AI
 /4Rd2x7sKpcR6TGLqBWWjrgnDw3/sgtFYtU7IQr8OTMhrff7Atgl9mRIpexm82zC5LvI qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kkm9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:25:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JB5646036149;
        Mon, 19 Sep 2022 12:25:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39hube0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:25:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezirEB94T8PAzjp4hG7SEAvIQ4IEp6r9kRfZGPuLUf1ohSZzUoQ7/ReS1CU2rMRVAQzHISRwL5HKC/jD4lSe2v8O8dwaZt06v2zW/SRXyQB7DF26OLa/2ls904kMQN4sl0VAL5bHFSxywyFL7wzsE4F1QSkCOtt0VWWhofigLVXzJ6gZgz4OIKtDYJQidF1WRaLnsVIxH4zTrouv7T7drYQXqAODdC+PDu61oHJshLtnyW6tjtLgmsJXDYQY3wTqMZsbsE/DVmoZatMVByiekFqNmWp0/Hkix0nT8XbOBoteNyAjgNAEhr6Ponn4SffUnpDYV3Y2VR81GmshQsSdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsKqZM4ueYauP7EcQTebAjmbsitJ/cXZO8ZW7UDLSDg=;
 b=DQPtpDpnaZyEJZR7RS7gGogxlYBdE2ZODn1U6P+pBnfazvpe1AO7wbi98IAbQBtpD/OrKchiTxNmINdjYhjF88WJnud1EHv0Zu1jJA/NxGOxjT0pKEkzFQqgC+mHyyHV14Xg1dd1JI8CNHxtzPGjBtUi47m626TZNGql/4xTDhhjGa0I5Kbv6ovceH0Y7b/P/h9FAvedtwsNzQxtf8xj4hrBSrTWZw7eOE361aXxDB1hqbns+7vIimhuOv6VOUcigQw8+b3jAaeiv0EkQajbSmBbhOFEEBJWjologFElhi3ENfGufHdLQxQ1xihSa18QwLi1XA8jKh2yaena4zo0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsKqZM4ueYauP7EcQTebAjmbsitJ/cXZO8ZW7UDLSDg=;
 b=0ACCzfECpIbYUSSr+Ll89FBGhJVsQZJQdaf3CcJls/P6coM201nf7oEqHe7KCaFRe0ro/Eb+gC9sZAMah3RKEne5O1t3kZUeySfi6EqSuj4b4UKiA6UIUmVdwYy4brwksaKEleURniqZzPZww44WNOWYHLtbAls3c7nIj50Utxo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5731.namprd10.prod.outlook.com (2603:10b6:510:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 12:25:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 12:25:53 +0000
Message-ID: <473de518-e8f2-c543-5591-f1087253c2f3@oracle.com>
Date:   Mon, 19 Sep 2022 20:25:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 07/16] btrfs: move BTRFS_FS_STATE* defs and helpers to
 fs.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <5118fc3da0a134f1ebfc68825fb65e38b16f98e4.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5118fc3da0a134f1ebfc68825fb65e38b16f98e4.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ae3e00-3313-4a2f-637e-08da9a3a1803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sANHUDAH/0LVS+p885KDutxq6tDdswBaOw9otLxpKC+BaXP5NhKR89d+lHqWwqbxSPYFzUxV5nN2D/w9TUqwbwPuMascHeRAIMQ243UPocumVWrNMh1uvtVWQytEUlM4ZOdOGnlwm/uF4HDOJNIlsKrEZJgZCd13AjJboJZ1exZnl8pKhMaW6gLMIWzqbIkawpB9/0zNDxcLgvrTwmFsRF4t8HobCYe50sPugTN7dtKruw5JV3aYRtvtTvSubmMeF031py6XfvuaFPv7iVzailjGL1ttxBN3fTih2Ao8I/T4WDYs8F9kA5x9G2YlWkJcbr7peVWmHYf4rd/MuEVozRZc4chQygDzUY2bvIWfGIt4QwbI1ocEqJ5pHNlJNp/31aIUBDP+bx1AAfsRz/RT0fFMvfeR+tCf4nP6WIMVaCz4QwyAbbOXVmua7V9tWlcTZLqAwcZRUJURoyt1qY5H3y3QBbbwpu8z/N0AbpOzslCd9J9MLKsJyxOFEM/HzEtlQUo37DBRIhQPH5W1S+hBETmNIDO3z4Z3NQqngl0xCeZUaAIEpVc9ghGrCeLwQUegVaaxMoE3pjfSLNd5SzMy+SVM8qEKiZVmvAdHR5xWJ0CQHSPpxL0b67Vw3GxaalA65f+d1hZv9VaEoNfV08cazuc77hmfAXC9GQyFYgeSa/RYz7O3pX72B2DJLl83pdXUu00+9eeaYYDygNgYITQIab0DoiBPZMRdNwhhcFCpdJshSqPkTC37Hkpe05cC2lqeDCd0+DWHu0gz9Bmes/dSL08R/joEFcn5Qvnhxq+B1js=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(36756003)(316002)(38100700002)(2906002)(8676002)(53546011)(66556008)(66476007)(66946007)(2616005)(186003)(31696002)(478600001)(86362001)(6486002)(6512007)(6666004)(83380400001)(26005)(6506007)(5660300002)(41300700001)(31686004)(8936002)(4744005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnVWYlNJZkI0RS9MZzVvVHVwSU9HWjR4QXFZd3JvLzlVbmpHUmJxTytvUURm?=
 =?utf-8?B?RDFRUDBHRkloZHNkUE9HMEtRRVJBYnVsdmVSNjF4cG9YY3lsVFlpeVBVaG02?=
 =?utf-8?B?UkM1TGcyWXV4dDV0OTg4QU50WHBmM2xtbmJ1bHVuZFhQeXhyNHpzQjZDbDlD?=
 =?utf-8?B?UlUvenhxNHg4UWtHdldrellNME5UZjliZzk5aE05ejlGN2xwK2UyMXpRYzF6?=
 =?utf-8?B?bmtJejhXUWhPRGhRR0RoUHkwRG01aXcyMy9FcjU0WlhZVm9JVjhNRG1xQVcy?=
 =?utf-8?B?K2taSEt3N05lUTZWMlYrSEN3d0FIemYrL2VEZm1PUG9rMlhDVzdQVFlQeENS?=
 =?utf-8?B?WDFDaFhFc0lBWWZlNE5SQk9VQ3NHeE1CWEEvRDJGYlpVeUdXR2FWWGRxSkZk?=
 =?utf-8?B?dXE2MkFNNUszcDJxNkNSckEyNXp0TmZxNXFncXo3L3ZrOVhTVmI5ZUlnZXNj?=
 =?utf-8?B?dndkd21GYmpyMmlRSEFUTk9vbVNVWkF3bEYwN2g3ZXNYcXhRSDZJaVBsSkhH?=
 =?utf-8?B?aXNPYnhMaU1JSVV1ekUvNVNrWkpLcmN0TnNJNGRzRTRzckYxMG5QMWxSN3JW?=
 =?utf-8?B?SE9KMy9SS21EbmluNlh3MDkyWkYrNFRkVk4zOWt3eFFoaG5MS0dzR1VSRkFp?=
 =?utf-8?B?TDlzSW1vMExwSHFDNWYrbXRYdDBkMjNQR3JFbm9HblpqdmFtelFRcTB6R2J1?=
 =?utf-8?B?a29iRlZjUnpXL2ZQNkhRTmcrbXZWcFRhY2NvQU9EQU8zc04rSW1RUFNKaWZ1?=
 =?utf-8?B?OXg0UWpYN3NNMExXcTBaN3B2cllZN0tCaXc5ajhaY1ZhU0NneEFrcGN0Y0RW?=
 =?utf-8?B?WEJaNXhhNzJKTnUrLzFPckpZNGtDV3JacWFGd1dJV25VdGVCZTlxdk54T0Nq?=
 =?utf-8?B?cHNweTNHRFNOTVVOZHF4dE9YdzE3QkYzbzQ1dGxDdk9kcnBhYVhVUmg4N2di?=
 =?utf-8?B?VEhhcXIzMkRScDRPbGN4bmhua01LWkVSeUhCMERIUEQzOUtZQVl4OUZRSzk4?=
 =?utf-8?B?SjBNOGR3Rm9LRkR5bVQwVVU2T24wdjM3bmlKNk1ISlJBeTBFVTNUcDNmRUpV?=
 =?utf-8?B?dmM0Ym5qZ3JTZHVIeHV5aUdpK3krOEg2RDhKS0EzTXlKTXJCbEdNd0JKcmRj?=
 =?utf-8?B?SmtDZ3RVRmdQSXlQWHZ1Vmo1akRlZEdIck9nWGNXeUoyMGN3N3dVUzkzVHFh?=
 =?utf-8?B?R0tmMnNFNjlITTJveVozSlZ1ajZPMjNXQmxPOUZ2Zm9PLytwSkdrclg3d0hQ?=
 =?utf-8?B?VjhZTy9xS2NaTWJ5d25lcUkxTTIrbU9sWE1JeXQ4MFdJbUQwNEVrSWxUelg4?=
 =?utf-8?B?TVdEZmdvSS9VYTFid2szT3l2VmFWRURwZGp2VHZydGxrMGVLMmxLYk1JMmZ6?=
 =?utf-8?B?a290TkZnZTNJVDV4eVNSNUYvOHBQV3FNamZBeXoybEZLUWR3ZG1MSXlKY0VT?=
 =?utf-8?B?VmY5bVhETFV1UDRGVzYvellSY0pZc3BOSDlQdDVVblNUblVyYVdUZnl4MDFh?=
 =?utf-8?B?Z1p5VTZQNzNBc20zOFFjdHJaKzlSQ1VkR0daWDM2RkJzM1BzTFhtT2FzSEpa?=
 =?utf-8?B?YlRNVzZqVnp1VFFndG16ZGJVTEJYZVFUK2JxamM2VVlFT1c2amI5aE53MTBT?=
 =?utf-8?B?aUlQVWlRTDRHd1dlZGVIUlNJYlVGS3piUDNtajJjVWRLRDVOU0UyejRBa25z?=
 =?utf-8?B?K2lmczE3bG13VFpTOHZWR1VqaVluTGZpZmhEMnFiYUlkWjBUd2JpOUI3ZVNo?=
 =?utf-8?B?ZGZNQ3RTMkhqWG5WT1lMN2szMXBjbWN2QmZCWFpVWTJ2My9BdDJZKzF3ZjZu?=
 =?utf-8?B?ZzIxS25VTDBzWEN3YldCV0RNR3pSNDQrdHh1cUpNbXQ1ZlRYRXIvYTJONmZt?=
 =?utf-8?B?czRid3dqbUVkWFVtQnZMSVM4WGZuOWpFM0pWaGJoQ1VlYUVSSmg5aG53WWU3?=
 =?utf-8?B?K0pjR0EyeU5mV3dHdlpHYjlqUTJWZG5sYUZqU214dzM0RDBrVVJoR1hETUl5?=
 =?utf-8?B?UnpBMEcwNmxZZ0NGR25jUk9qM1F2UVNEN29oN1pVR2l5ejd2UXl2ejhIN0Nr?=
 =?utf-8?B?bnJxYmUyVTZyd0ZsUk5MVjhDdlkyZnF3RDE2ZmFHVXM0OTh0QUJuOHRuTW9r?=
 =?utf-8?Q?X08y8HhsTnLwsrbYxaQhWIUVi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ae3e00-3313-4a2f-637e-08da9a3a1803
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:25:53.1451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfERlCpYrfpYclxs1TZMbw0nWzOzlEAYvGf9rL2nKK7ejWMIQylAA/r/uyvCb/PoMznE242F0gfcPVgW2leODQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190083
X-Proofpoint-ORIG-GUID: llWCKTPSirvHV94YOnH8fh_6ucBRaIGt
X-Proofpoint-GUID: llWCKTPSirvHV94YOnH8fh_6ucBRaIGt
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/15/22 01:18, Josef Bacik wrote:
> We're going to use fs.h to hold fs wide related helpers and definitions,
> move the FS_STATE enum and related helpers to fs.h, and then update all
> files that need these definitions to include fs.h.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


