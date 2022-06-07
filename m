Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD28753FAFC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 12:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbiFGKPw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 06:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240710AbiFGKPq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 06:15:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE2EC966B
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 03:15:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2579ejfP027046;
        Tue, 7 Jun 2022 10:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6/kUxSfmPcPVOnmkwnQhCzdH3bvk6exOJZw1pbnRw1M=;
 b=gUpyeNDKsLhkbo2OrT3sk/8VSqC2l7yqM7zBf0NyIuPlP2l4rhOn+WfMtmjjdwGN/sIA
 Gp6p6E+3BRpWIFxXYJrIl8yvpbvjEenR6JtXIBniJ4TNZmS6uZPYPEOo2ub8ls9gP2zl
 qDT+MKFE8mPt0Tc1FIg/V8iHJIMH74q2YhvbfLZloHbYUYL3Eap7GmWN0yYG//nPv17y
 sqGGHGQt/9WXvSFr6e72QIPLNQy4Qlp1+dhqfUoAoBbKgIrxZ24+YkUxREnp5ubsEdD7
 wINOTSq4CuA2hKBNmvjiFtmxCfTvfZpyNdVgLWg+9pO6DE/59sShoPI26fhaOi0BkL5q jQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfydqnc5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 10:15:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 257AAMDs024904;
        Tue, 7 Jun 2022 10:15:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu2w5ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 10:15:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksfjdiGnyMn9GpFvtu3eZN6bi8irpnprEEo0QGrtnvu7tjyuRdqY0zA0CcSUxFAMESZKKhY8xddXR2P54pwd7XRganKd8jQfryrwN5qSWslT/53wlGy16I+zVvL9oidgyrXQC3a/epPv9YpbEL7A5s8yosdbqYowJgjEen5BpqCx2CcSsnLT1eyWdObiZ+pbwdGAc00TsN6//5B0ok4uhQRh0iJrB4TLku4+9pgPb05RZQNHTdhH6byjJkfzE44WUgBxrgMVaoYJCfJSAn/DSBBoi9zVKBdErOjObj/A7jppGGDYmUUWGYM+yQ2YJ8ARlzK6Vldo/OTj6RSJy5o/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/kUxSfmPcPVOnmkwnQhCzdH3bvk6exOJZw1pbnRw1M=;
 b=QugwYfwBMI9+g0H+3E72JFBi0SbDvVhtrDhyVj0T9rZ7ckDoC55rtcl/q2GY1FEUlOZVfNtj4OixCtytXuKffOCuu0MCiZB7PONbmzuEA84B5Y4LqBNOfPIMbujbVX4SBYBEdB1/5LO9dTueb3CntEtH+V7rPMFo0YHW1SbXF9pO9xl+MXrxBsLhtgCAEPYR3WCE6JCJG1ScprZ4ez5ieXFtsNkbgZNUo4+Tvwa1jB9XHgDBlh3dfjHbBhN99H4Znnebpqb5JVpmu0bOzDprHJ07mTRugKiZdUoWygirq5Mcj316HOpDIhlpFTpkv7ki2YZ91q7M4nHWJgsNzC0GSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/kUxSfmPcPVOnmkwnQhCzdH3bvk6exOJZw1pbnRw1M=;
 b=gQ7jp0BsOmcJwg0tvMLHg/hNA+IDmflMgbj+XqwJWiwyhiEkwyYtYLUNvgwkU7WzN3qRsdb9QDx/lKrK57yU1Z6zxPZ0eSXPmNOr7aMQKVN1X3LUmz2fVWWBF8K1ZvNGdvAZqKkIIHnXg8Sa1cbpnaqLPI+HjSoRkrL0czjQPps=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4690.namprd10.prod.outlook.com (2603:10b6:303:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 10:15:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf%3]) with mapi id 15.20.5314.013; Tue, 7 Jun 2022
 10:15:42 +0000
Message-ID: <95980806-b198-d75e-d50c-0c18486da9a6@oracle.com>
Date:   Tue, 7 Jun 2022 15:45:31 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RESEND PATCH 1/3] btrfs: wrap rdonly check into
 btrfs_fs_is_rdonly
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1654216941.git.anand.jain@oracle.com>
 <0bd3d3777e34a5322fb4d3ec315df4090ee43399.1654216941.git.anand.jain@oracle.com>
 <PH0PR04MB7416C47B4A55666510F7FDAA9BA19@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <PH0PR04MB7416C47B4A55666510F7FDAA9BA19@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85385d05-0397-4071-b904-08da486ead7a
X-MS-TrafficTypeDiagnostic: CO1PR10MB4690:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB469040AD539C6BDA2CD70D43E5A59@CO1PR10MB4690.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i94xo31DURIxa5qDg6dzMiwjq1HUbIu6AUf7TLr3FI6VeHOWjPvl5bqc8JIBaziPjFHhaytLpCOmhYgaE2iq2fx3ssCKAeC/inzTs4OWqmqCL7lr52yXzPJJ3jpxobGgou35YnXurJi7dWo9ZuWlKIMhWzFJs7nLFRThfCJ51va+VbYb6O/ffKKqkJzhevR231jLjXRQlCOoEFExKPDBB5SEXa89Csn82Cu55T/G+7BAP6efGg0grsJmK9kH16h16bkSbmgoNFDLf64ILrgaA70QmUFDqf2nHFkOtbQrEifMXZM9Knz04CQqzTn8lQQrG2Oazd5ECj8JR+z8+oflFIxSlPm9s8ByVF3mDsYSy0LFFn/VAsBzcMm6yJQUTDkL844yHnunQzLUcK8N/yeO55oJsJXpxEWcB3FAcTiUfXFwjaSXJEtx65Y2OiNuZtbk2Uc4vyRjhn1e6HjOkFNPj+pJa1DIalBfzDkSWbFu0eHLog7CCzf1lD0yAT0oZsp6m8VcF9jeGrJeIJmSGpKkDMClxqOImADVza+Xq9j3jSNlvZgc7fQIR+Ov82WOpNWfHmGfO1XuGK2u0r8NfwQBClloyIxjQFc2gBn+8dnpygQWvPZmhNoMW5RQJCUgzMso1CHcDagstQO6kNbwfeyf3KEXUb+YeDzHzk1HyyRKUYeIwqx5UaYvtzboaEoN3d9iAI8Gf2JS/6Qu+zQZpWv1q0GzPbTa/kRw+DeaaQhJvl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(6486002)(31686004)(6512007)(6666004)(36756003)(186003)(110136005)(86362001)(83380400001)(66946007)(31696002)(53546011)(8676002)(2616005)(5660300002)(8936002)(66476007)(66556008)(6506007)(2906002)(44832011)(4744005)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmk2bC9SUkVMbDNNWFJmUGorc1VzVENUaDBhZ3krZmlxbnIrSWZjK25aYmRk?=
 =?utf-8?B?T1Q4Z1d0QllwNk5MelorTFFGL2w3WFp4dXAzODNxOFdaU0hoUWlIcXFES2xF?=
 =?utf-8?B?dUJYOFEzUFNIYzNnUGtlbC9OQ04zbXROM0FKY2IwMG9EcTBhZjVLMHFMTE1S?=
 =?utf-8?B?SW84QWJEQkVuWWlnTEVxbG1sWDAzVCt3VXJ6eUtmRVVSUHhaTWlIN1VhSjZv?=
 =?utf-8?B?MzdjMnNlWWlrN0xUcDFLKzIvRXo4eXZNMGU5L3pHbWxqYmdKeW9HbEo1bVR5?=
 =?utf-8?B?Y0YzNEhXc3czdTFZM0lSWkZSd3AxRngweWZXME44d1pEeVpETmtDMXNqL28w?=
 =?utf-8?B?dDUxMnk2V1Y4T3JHSG5BYktxRjNmbENXUFZlaW41Q3VLUUV4SEhvYlRDcmZr?=
 =?utf-8?B?UERETHRXV3N4OFRvOWU3MksrUkpXSlZ0U1FwWFdVZEdkTFRGZXRLSkFSc1Rj?=
 =?utf-8?B?dml1akVmUWlCTWZaTUYxRzJtdlpFaW9CQ2xZdDhZTlRXRU1RdGFSOWwzNGNZ?=
 =?utf-8?B?NmkzaEU0aGEzVEs4VWNNdEpFZUhnQmE2WERFRDRNTDJIaGsrUHBSSkUydVZi?=
 =?utf-8?B?SHdNNGE0SXpwTEJla3VIZkY3YkJSWHB0N3JVb1RsWHZ1TDl5WTJzRXhHQ0l4?=
 =?utf-8?B?d3BpMzBNSGxIWThhdFhQcko1SjVRMUtjQ252aUl1WVlFb2cvRklTMGFuTDRt?=
 =?utf-8?B?ZU9rRldyRjlKS3pSdExoaHQ2YzJMUzNkT1BLN0pxVENqZEhmRnB3TlVyN0sw?=
 =?utf-8?B?OVg1T2VnZktLaU1yZUM3dzNvYU9ZMWxMY3pVamlBWHVjd2d5US9IaFN0WGlL?=
 =?utf-8?B?YndzK0QvK3dmRWhkRVhPZFpSdFNGWWxXNk95dDVySW5jM1I0Q1FON3JtTkpp?=
 =?utf-8?B?ZHNKQ25ZbDJaQXVycEQ1VjNFM2U1VEMzOHRWakNxM1pKWGRGRmRKVWN0QU9X?=
 =?utf-8?B?N3U0dVFYa0lyMkVMZDZ2OEQwZVR3Ly9QbEd2YXpBcldnM0RERUlKMUxGbmdO?=
 =?utf-8?B?djVzbHJOYStyZ2l3c2ZhN1krTkFxalZ3U0wrNTRJd0paNGg4TmlvSmNma3RM?=
 =?utf-8?B?aXV6U29ycXMxek91Q2ExcGVjT05reHRBRmdOeXJBOFE3ejFZNHdraytWYWQv?=
 =?utf-8?B?QUpmako2MktjRjBmb21zU3Zmb0hXTnFaNFRRM0xXakRuTEFzNldzMzhUeVY0?=
 =?utf-8?B?Tmt1Q3J2dDh3bzZCaEUvMTVzNDJLa1dtQlh5ZCszT2xIZVg1VUdkdXBYaC9n?=
 =?utf-8?B?UVVHNUZBL2VlWUltZ1NzUUpYbk92NjE4R1p4d2M5ZFZLb09IZ1ZteHRsMFg2?=
 =?utf-8?B?cktaNmY2VVV2SjBFZVUxWjl6T0Z1Y3N2KzJHSjczeE16WVp0dzBsbGdEd2pu?=
 =?utf-8?B?WXdCOVU2RnltSnRlcUVHTFhVNUdTK0ZRaHR4UnNRbklCU0xJZkh1TEVra0Fp?=
 =?utf-8?B?emljTkZoNmNkRGRKejNJMXlSK05zejZnSWt1YjlTNHBvR2NJMy9MNGVvOHpS?=
 =?utf-8?B?aUtqVXVYbXYrK2YyT1ZvSThFN3lCUmM5azV2NUZQZHFpZW5rMWUwOG4rNzkr?=
 =?utf-8?B?QXo0ODh1NUtYU1pVVHlNbzYveUVsbGpmZEtoV1N1MjdEcUw2TUlFTlR0bTFK?=
 =?utf-8?B?ZmpaTlc1dFZkRXUzdXBMdU5GdFhrN0xSMXUyVWdOVy9JS3MvRHVKRW9rVUJI?=
 =?utf-8?B?SUlMNFpzckM0SVkzQm1sTkNhdXptcnRSckd1c1U3cVBaZE9GcXhjODNzSnRG?=
 =?utf-8?B?cngxY1JpcG9JRWk1NmFaa3lWM0RnSEJwRzd3RG00bGJvQklJSzFtVFN4eVEw?=
 =?utf-8?B?bVdaMzJhdHNySmNVZmcxanZtcHQrUXhmdUZZYnJrMU1GVmhDblNNdVhDYThR?=
 =?utf-8?B?MVNXUk9UWFpRKzNXbFdiSitMZ0ZBVkM0cGhqMlRHdk1uV1dEMzVma1phdk1o?=
 =?utf-8?B?SUxOa29kZXgzMW4xVld1MlAycHJtbUUrOU1zQmVpQ3JzeXdYKzBmSk00WVll?=
 =?utf-8?B?OWwvMVA5a29nTXBiWDN4ZXJBcnR1ODJMbTRtQU1mY0xzMG03OXlicU1JZVU5?=
 =?utf-8?B?eDlaYzBaaVQwRmRxZGwxYjRycFNERFdvdEJEeUd5eFd2dGEyMDN0YVc2UW1k?=
 =?utf-8?B?c1ZrVlB3dzVqN2JIZlhmN2ZIVGhXbGErZHppZWcrOHF5c0cyTC8zcHh5Rzlk?=
 =?utf-8?B?VXVncXo2VTF6U1M5RkhMMHVydThIVzJIQ05WNFI4cUs0K2wxbUxBNTEvQXJ3?=
 =?utf-8?B?ajErT2lNOUdTUTZmcWFsdks4cS8wSUpKSFovdEgvTGZUZ0dsSjFWZzhIVE5w?=
 =?utf-8?B?RVhXR0UwNDVZTTJEUlRZSkVCd0QwMjdVcVFNY3VBd0dNVjQzVHhUK2Rnbngw?=
 =?utf-8?Q?sxfTprCrpHWWat2D/a/3tFt92OGIxvrLWRG+zlKc8TVmw?=
X-MS-Exchange-AntiSpam-MessageData-1: S2hjKtg9W+JVtQZP8dWSNhtfC8/Y7dP/oaU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85385d05-0397-4071-b904-08da486ead7a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 10:15:42.4355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo+jXtoVLqQG29on4iDBJc6YA7ToOQx5ReYQObWMUL1/Tlru+72BvedDYjHIvOr5ZMBDQkfHCla515ggJL30fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4690
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-07_03:2022-06-07,2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206070043
X-Proofpoint-GUID: 3u0BtmfDTVyRxapOfpp0jX2HR1sfRa37
X-Proofpoint-ORIG-GUID: 3u0BtmfDTVyRxapOfpp0jX2HR1sfRa37
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/3/22 14:13, Johannes Thumshirn wrote:
> On 03.06.22 04:04, Anand Jain wrote:
>> +static inline bool btrfs_fs_is_rdonly(const struct btrfs_fs_info *fs_info)
>> +{
>> +	bool rdonly = sb_rdonly(fs_info->sb);
>> +	bool fs_rdonly = test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
>> +
>> +	BUG_ON(rdonly != fs_rdonly);
>> +
>> +	return rdonly;
>> +}
> 
> 
> Do we really need a BUG_ON() here or can we make it an ASSERT()?


These two rdonly verification methods should match, but we have never 
verified them. When this is through a few revisions, we can just remove 
it instead. I suggest we keep BUG_ON() a couple of revisions.

Thanks, Anand

> 
> Apart from that
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

