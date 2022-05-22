Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5153002F
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 03:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbiEVBOG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 May 2022 21:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiEVBOF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 May 2022 21:14:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354652C67F;
        Sat, 21 May 2022 18:14:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24LFYR6g004684;
        Sun, 22 May 2022 01:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Y3f/sRV8LSS47x0yrd8AXTCq9Ns8zSk71aoxUFWT2kc=;
 b=vhTDj46lzWrgoHS+0QfPSsyO1R8SSKkA83wFFPS2bhAqICG5ZtuEkyPmWE88FMxfJ40+
 yfSJ/dplaJCE/q6I5MqpHcT/Q/Hi2Zwr6ouVgLMfnfjchiLislY1MOryIC3NwWwwEwvQ
 +NHobOf7EPofd0UT1FSeYcqFW+XybEb0IfQ+vlKTNDwxzZxcrsykrc0aUC6dR0NoZbUw
 a1vRjrwa1SLdt8TaeWJEqLACsXb7AozGmV1ReVDPu3+ltDe9MBNcsHcjOszradGtqAiT
 ilupDsGnd6ACSR3jrVtIununo0xWHmaUr66Tap5xvTvPzXyXJ0UH08R7e9IoRP9zvgf9 Zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pgbh09y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 May 2022 01:13:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24M1ACBI031423;
        Sun, 22 May 2022 01:13:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph0jvhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 May 2022 01:13:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD7S8tTcEgjRenD6xa+WlcFNtqF3WW3Vvvn6ulgXz7wSU3jI1LM/QPC/yQ2oOkwPu423m7McbtAFjMslswYMDfvVrjYHQg7A2wTqnsmnNa+H2IjQiXms2BkQgePthFGcqaYf8zq4Hub8zEDRLqd18uLWtUcfrVhNCZjD9F2KAXcsSYSRZEWiRTW3Ec5T6jaTIJ1xE78qPiMcKntvVDFvEkT1autQyJ/smylte/Bds/dGohiH57a/h4JVwns8u0dEVM1/Q998USdD6G0AAr4/xMFnz5t+vpniZxSF0EwWpTjCg5GgKnzNROPLAakSKR/qgGy4J1+ej2KgCPe9h8u/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3f/sRV8LSS47x0yrd8AXTCq9Ns8zSk71aoxUFWT2kc=;
 b=hGYyZAFchbQ5Dcum39f7D687H8LAJjQVtRwqGtHwLBGpww3Ep2nNIrGJNlCSrVDmiSN3sfxCMOQIYsnpr1ZiB3gE7qSgsTOPkGdoSUaIEtO/w5jYs1IdWvXAA6bRDSRbXBUxwfcxsjNsYlafM7eUb3SwNsy57P7ioZx+fv5OycvGmG7nNuZ0lDXwvegGpS41zFnKdMEVNUT6A/soOmWhMumxKTA7NgaqyR/EBWiY4jxS1rRrMCLu4ntF06jHG+9P/BceOrnFX30WcB6Bes10BxJnh8muPZI3eK9OVPyUkdsC+OBa1tpJ/FNV8lJ9yLOeXoHV72eScYuTB4ePOPcD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3f/sRV8LSS47x0yrd8AXTCq9Ns8zSk71aoxUFWT2kc=;
 b=x9diHnCZly27GjTUt9DqWsngm8WcDTzQX4gdxciInrK5pA9/uUl8jh2Oo32glaA74RayCUf9g/QmTAjnQN8NQcvLXUI0RR5SAGjfHgHdmkpJsb4+5rCZ0JREplUlRDRzk84RbPv8UNfbdfgje9cCs5kLHHCqzqZ4LeQSdZfwPAo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6136.namprd10.prod.outlook.com (2603:10b6:8:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Sun, 22 May
 2022 01:13:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b981:1ec3:a3a5:f3b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b981:1ec3:a3a5:f3b%5]) with mapi id 15.20.5273.021; Sun, 22 May 2022
 01:13:56 +0000
Message-ID: <791e365d-eb41-9073-80b7-40ee9a42d659@oracle.com>
Date:   Sun, 22 May 2022 06:43:46 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] btrfs: test repair with corrupted sectors interleaved
 over multiple mirrors
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220520164743.4023665-1-hch@lst.de>
 <20220520164743.4023665-3-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220520164743.4023665-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dede4975-bb01-461f-2e89-08da3b9057fd
X-MS-TrafficTypeDiagnostic: DM4PR10MB6136:EE_
X-Microsoft-Antispam-PRVS: <DM4PR10MB61362BA3CEE28155BBF7DFDAE5D59@DM4PR10MB6136.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbRjE2yk2AdWyBH5SH2mqDBBH+g2Aaa5Ko4Nu5WC0wfTiwnNOew52T5QRZBRQY3Ud87y6dlNrIesL0FllBILg6BnKtJMbkDtUdCradaVhi41GNVJb7iuWveORy5zbyhuD1chHlGl6/UEr6BecDDw0p9gA8W+yfz1FF83x06M/7qdjrJcYFu4Jnb1yQGL2795yYXvm69BHKAML8XcJQUpzR04H1NMku1GshXvp3WHbkBRDsPKtYGSNRmm1B2qEUmlfD7f60RY7ADhOmJXwLsZQRagC9lm+DfWRxegV9s9LxCdw5ZdF2Ja0x32KgcgWNrDb+356sUTMs8c+VWIex4TIIjcg1etZOqcOxFbi7FmvlpK4FQanmYwvocQvM1u3BuVPqRADcqTxzSSGlG5PlUsdguJKUtS2yvRad7FRcdK/c7lS6InuB8TFLyrnUqFe7L5or4xOxEnZ41bObGHoYoAOg2Jrw7XP/PlNERppbHrymbDoDWX4NC106qfJyl/cB2mhmydPXqv5bc7eKD5Kg9JRwXRk80NO2VdNsUiy8YJr3ZjEVieLs7ygHURLGQhCQJ8gYBhNHuMM/BRGf4fT4ZvjDw09mVafBAy8OjD4aOgaV9GkRocJRNEVwPd0xg4onwjOkCM5dazAxwVnLWLbY0BjWgxMyvEfdbetPsd4Htxsl7B9IOITRwMN7DfFazQAxwNZ6OzRQ8O3y2L7Xsi/IyzMmo+GXikK3EzspHg0LbdNaZRg/MCxgNhq9yYwR2szT2WkzZLeGN/n4/i05M2CD9Kvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6486002)(30864003)(36756003)(31696002)(8936002)(5660300002)(508600001)(31686004)(38100700002)(86362001)(2906002)(2616005)(66556008)(186003)(4326008)(8676002)(6506007)(66476007)(66946007)(53546011)(83380400001)(44832011)(316002)(6666004)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJtdHBuK3poVUZIdVlUOEpTZk5qOGwyM3l2UW0rM04xOGs4YzN1VTBWS1lX?=
 =?utf-8?B?ekgybnAxcFZReUZmaW5EaFo4T1ZpVDYrSHlqK0svZzJXZy81TDhGb0I0c3RB?=
 =?utf-8?B?a2pmOGwrSUxZbUpPTXlpR3ZSZGVObG4ySDRRVWFDQ0VEdVNtcVBpNHdFTitp?=
 =?utf-8?B?RlVuWnU2VUtHZXB2Ym9Ua1dHakFKQzVENGkya0xWTnVRT0YzR3dHL2ZobnNW?=
 =?utf-8?B?eFQxWUdzZFBOSkxIRUV2U0VLdFlQb1d6dzZFMWR1RitlMnhaQ1drNmNweXpz?=
 =?utf-8?B?cUl2a2hkQ3RtUFBCaDExRjRDM3FvQ08zUVR3M1VtS2pXc1d2Z1Z6eDIyR0Jz?=
 =?utf-8?B?UFlndXlJL2RLYTBvRjJHS0lleDZFMGxoODA5R0Q2ODdEMnRxOXZoL3NWcy9Y?=
 =?utf-8?B?UmhtTS9VREVhb0pCSGFWZ0JZNUFYSmpTTDE3elJDeGx2UVpPM3V1bTQwbVFp?=
 =?utf-8?B?S294ZlMydmJTalNIYjhCUS9qeklwOUh1dWN3dmhRRTZPcWp5YnhHUGJvbjJn?=
 =?utf-8?B?Z2ZobktSSFRrckhVZWFPNlRoc0hDdXRwVnF0blNIMWZHUERBYWlhQlJaenVY?=
 =?utf-8?B?UGpKK0xPbkVyZlJiM3I2N1JFZzBOUWVFeVVHOTl4akMrb296dU9WajBwRFh2?=
 =?utf-8?B?M2VKTDdUdW16Smk3Z1ZZNXZJT0d1RlhOZE9uUnAzUDN0UkRYNEU4d3drU2Fy?=
 =?utf-8?B?czN3bG9mWkV6ZFlYMEJMK3JhT0ttOHY4bFlrTEFma1dzK21EeFBpSDRUcHph?=
 =?utf-8?B?TEJXdmJYaUhONHpmWi9mMWNwMmxxMHdwS0ZyeHVsdVN6cmtyRjVxYktvUEJE?=
 =?utf-8?B?RzdKNlpSNlZpUk5VeEEySys1cTh1NVcyVzRzVUhkbnMvSUMzbjEvNEQ1RXVN?=
 =?utf-8?B?OWZ2WmtHdjgrY28wdm5HNWtBRTk5THN6TlRQY3psaEVERHpPSWlNUUtZTTdE?=
 =?utf-8?B?MmNpNG92RGw1ZlNLcDhWTTVNcEJSbExJSGpXdDFyRzFxRWtibzlxMWt1ekYx?=
 =?utf-8?B?YVRuaGF0ZWoyMHJPcWduVC9pQUhicE40Umt0dzZPekp1NzJMVENEUzlubUdE?=
 =?utf-8?B?MGlTajZGczVYaXQ4SmIrY05YSVhubjBNTXZNZnVrenpsR0QxNDlweWE2N3Yx?=
 =?utf-8?B?V09kWFBEYnc2ME9VZDJ2Vmd0cHpvd1RHWHU0YVptek1xN2IvYWtRQjRrSzVk?=
 =?utf-8?B?U3pmVk5hTXhOeEoxK28rMEcvSFdTcDM5cTY1NC9TQVlDRDVWdktEZ3p5NXQr?=
 =?utf-8?B?b0p3Y2hSZUlEZlJ2YmpTUXB4OTd6Z2dLU0tSbk02ZG55ZjhJcFJmcno2aUov?=
 =?utf-8?B?YkRUQ2NvdDlkejNpOE5nVVFMWjBzMWpBcmppWUI4cnkxRlNYRlpoMDlQazda?=
 =?utf-8?B?QVp5cHdiMi9qdzR2TUdVWmdpM0p6ZlVVVDRBajRNME5HdUZFQnZXSGxtdkZx?=
 =?utf-8?B?MGdDeWQ1WlNwRVNPRDVrTzNUR3RQUFJXdVhsL09sTGx1Vkd4aTJLK0FnZmVI?=
 =?utf-8?B?Vk9DRTR3YzZzWWd6VGNZV2FrTG1RcWJ6N2pFVUtJb0d5WndMRHh0YXYrUmY0?=
 =?utf-8?B?Z0FXdUk5RUpaTHczbE92U25RR1NiMjFsTnUzdHBXUldpWUM5MEg5TUFNZito?=
 =?utf-8?B?SzR4amtGdkxxTERSelhDQlBoV1NmV1F4dlIwaHBBbUJxS3hlZVAvU1ZXenZw?=
 =?utf-8?B?L2IyTWJJTkdtUy8ra0h0WVgwcTZlU2MwTnUwa3l1TzNqakNzcXVGT3BmUUJT?=
 =?utf-8?B?cHVCUGUxVTI2NCtmcC9NQ2ZoNmo2WHl3M3IvVUwrRXI5eVhCRFAzdkxTSTFa?=
 =?utf-8?B?ZExvTGJ6dUZxcGk2Z0lvOWNNWlN5VWdpTWpLN3crTlZlZHZTckNOUGkzRXNI?=
 =?utf-8?B?NjNvU09BVlB5Tno4c3V2dmpMUk4rSUJqYnVncG1ERFdMS1JyaStsQ2hSNjh2?=
 =?utf-8?B?MzdOeTBEM1l2NXp6L3k1cEJsU1VzQVZZQ3VtNVlrY29UVnFuQ2xWYXcvMExx?=
 =?utf-8?B?Q29RUlpsaVkxYlpld2VMTGhDdFIxajFaOGhMZ1ZzQXFSeUlta2JidWsrMXV3?=
 =?utf-8?B?RlFrK2ROQUlMNnQ3K2lLTUR5MGlHMlJycHpBQ0NwZDJGdjdpdmFTSGFIb1RT?=
 =?utf-8?B?UnZ5bnVCT1kzWjc4ckgrSmZGYmNXMHJJODdvUGJJbk5XdytiaGFHS0tEcldo?=
 =?utf-8?B?ejVNeVFaY0Jqd0ZudEQ3Y0ZabzNoY09VdndtdGtwSVpPUXBXejIybkxQZGJu?=
 =?utf-8?B?VXJnREFmZFYrQXZiSFNlbDVicVA0dFVoZmYyNWZqRmZuSXd4a1Jxc3BadnJu?=
 =?utf-8?B?Rlp3NlZQYjA4cFo2VmxoeG5ZTlR3WlpneGsxVWZ1aFlGMVRVTURQR2ZIVTJt?=
 =?utf-8?Q?SBSL2M8M7YgdZFIw8FuQwfgY3VmnJBaYQn4p1n7c1UhUs?=
X-MS-Exchange-AntiSpam-MessageData-1: PRjokCk1QtBxPlvJ/MqbqiVkOJIWUPa+5NM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dede4975-bb01-461f-2e89-08da3b9057fd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 01:13:56.4667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuHsHSmJKDPg/pxAhnTm/JKW+RyjFAzaKiciKf80bKNghDJC4PX5O7fXd5QreqLnrqvJg7cM7tf3QaFNTnYk1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6136
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-21_08:2022-05-20,2022-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205220006
X-Proofpoint-ORIG-GUID: PFtJQfnZrSnxwiuTdoLcu0fSLQIvFoov
X-Proofpoint-GUID: PFtJQfnZrSnxwiuTdoLcu0fSLQIvFoov
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/20/22 22:17, Christoph Hellwig wrote:
> Test that repair handles the case where it needs to read from more than
> a single mirror on the raid1c3 profile and needs to take turns over the
> mirrors to recover data for the whole read.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   tests/btrfs/266     | 145 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/266.out | 109 +++++++++++++++++++++++++++++++++
>   2 files changed, 254 insertions(+)
>   create mode 100755 tests/btrfs/266
>   create mode 100644 tests/btrfs/266.out
> 
> diff --git a/tests/btrfs/266 b/tests/btrfs/266
> new file mode 100755
> index 00000000..24c2b5fd
> --- /dev/null
> +++ b/tests/btrfs/266
> @@ -0,0 +1,145 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
> +# Copyright (c) 2022 Christoph Hellwig.
> +#
> +# FS QA Test 266
> +#
> +# Test that btrfs raid repair on a raid1c3 profile can repair interleaving
> +# errors on all mirrors.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick read_repair
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +
> +BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
> +
> +_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
> +_require_command "$FILEFRAG_PROG" filefrag
> +_require_odirect
> +# Overwriting data is forbidden on a zoned block device
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
> +get_physical()
> +{
> +	local logical=$1
> +	local stripe=$2
> +
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV >> $seqres.full 2>&1
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> +		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$6 }"
> +}
> +			
> +get_device_path()
> +{
> +	local logical=$1
> +	local stripe=$2
> +
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> +		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$8 }"
> +}
> +

Can wrap into a helper in common/btrfs.

> +_scratch_dev_pool_get 3
> +# step 1, create a raid1 btrfs which contains one 128k file.
> +echo "step 1......mkfs.btrfs"
> +
> +mkfs_opts="-d raid1c3 -b 1G"
> +_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
> +
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount $(_btrfs_no_v1_cache_opt)
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" \
> +	"$SCRATCH_MNT/foobar" | \
> +	_filter_xfs_io_offset
> +
> +# ensure btrfs-map-logical sees the tree updates
> +sync
> +
> +# step 2, corrupt 4k in each copy
> +echo "step 2......corrupt file extent"
> +
> +${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
> +logical=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
> +
> +physical1=$(get_physical ${logical} 1)
> +devpath1=$(get_device_path ${logical} 1)
> +
> +physical2=$(get_physical ${logical} 2)
> +devpath2=$(get_device_path ${logical} 2)
> +
> +physical3=$(get_physical ${logical} 3)
> +devpath3=$(get_device_path ${logical} 3)
> +
> +_scratch_unmount
> +



> +$XFS_IO_PROG -d -c "pwrite -S 0xbd -b 4K $physical3 4K" $devpath3 \
> +	> /dev/null
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xba -b 4K $physical1 8K" $devpath1 \
> +	> /dev/null
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 4K $((physical2 + 4096)) 8K" $devpath2 \
> +	> /dev/null
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 4K $((physical3 + (2 * 4096))) 8K"  \
> +	$devpath3 > /dev/null
> +

Could you please make this test case compatible with the 64K sectorsize 
configs too?




> +_scratch_mount
> +
> +# step 3, 128k dio read (this read can repair bad copy)
> +echo "step 3......repair the bad copy"
> +
> +# since raid1c3 consists of three copies, and the bad copy was put on stripe #1
> +# while the good copy lies the other stripes, the bad copy only gets accessed
> +# when the reader's pid % 3 is 1
> +while true; do
> +	echo 3 > /proc/sys/vm/drop_caches
> +	$XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null &
> +	pid=$!
> +	wait
> +	if [ $((pid % 3)) == 1 ]; then
> +	    break
> +	fi
> +done
> +while true; do
> +	echo 3 > /proc/sys/vm/drop_caches
> +	$XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null &
> +	pid=$!
> +	wait
> +	if [ $((pid % 3)) == 2 ]; then
> +	    break
> +	fi
> +done
> +while true; do
> +	echo 3 > /proc/sys/vm/drop_caches
> +	$XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null &
> +	pid=$!
> +	wait
> +	if [ $((pid % 3)) == 0 ]; then
> +	    break
> +	fi
> +done
> +

Same here. They can wrap into a helper.

Thanks, Anand

> +_scratch_unmount
> +
> +echo "step 4......check if the repair works"
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
> +	_filter_xfs_io_offset
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
> +	_filter_xfs_io_offset
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical3 512" $devpath3 |\
> +	_filter_xfs_io_offset
> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/266.out b/tests/btrfs/266.out
> new file mode 100644
> index 00000000..243d1e1d
> --- /dev/null
> +++ b/tests/btrfs/266.out
> @@ -0,0 +1,109 @@
> +QA output created by 266
> +step 1......mkfs.btrfs
> +wrote 131072/131072 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +step 2......corrupt file extent
> +step 3......repair the bad copy
> +step 4......check if the repair works
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

