Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8115FD475
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 08:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJMGF3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 02:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJMGDa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 02:03:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9441012C882
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 23:03:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29D4gtgK016764;
        Thu, 13 Oct 2022 06:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Iprnn899GK2by56RN+Zh2vFcTxnglzhOFYBZREcA/hI=;
 b=1ShcnhJr7QlH+tAIwCQrLnnPVbpBb2hFMxeTO1RjuB1CH9GMJ79inS+R/V8njvxqgC4S
 myCk7uDZ84hRW0AIRsgrRueg2AWvO+5LT0yoxIz5+xBKz3yGV6+gSokbThvuZHJRCai1
 H5ckh7svAtBDRYeFgI5QxX7tM93ZKG7Blmwh7i3f7x8fD3+tRNtHa0gs8Ib53ROd1r3T
 9MhvXggRM6ES9TzrnEr+QfjFIioAfSWWl/uzrgYRcw0A2cmp5ADfP37ZRXcA8GtLTiWZ
 N8iO0LcpMRsRsiKJzeit++HlbZM6mGhvcPAWq0Pgn0cn6shXlkQBvlTO+gTGP1KrST8T bA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k31rtm227-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 06:03:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29D1g5AK003016;
        Thu, 13 Oct 2022 06:03:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn59x01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 06:03:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzkQcBvQh6vwRDsllU1gYm8OsY+LQq83afIpG82pjZOjxtEQi9FhQskJWOTrS7bQBQIg5oRsdys34Q/tTRz7EO79oaglh6oKRmFZB6ka4YxcNdlnCtOjAEea9j5TXNL/6jGJKOVwpYB8KYOUYF6zNcIlIFX1frCP/5RbbEQWbkiSdZijwDtWepBluSjevEl5+Ete6sl2qRAQMcvDBPjmedgkVdxKN0ccyAY1FcXy/GnyZEuPwfNqPm4VtkXvoiT5wFHS1vC0tw4U4/1Z3EgXZRPK3LzPj0XrLS+85xKFxrEjlFTBmthy45ivtiw8wLbXA/M/mZ3idZdlzT9GMrxrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iprnn899GK2by56RN+Zh2vFcTxnglzhOFYBZREcA/hI=;
 b=eogv4YS7H+6eRN7qB5XV2F5UFfzGj/BnyxFrNGsna4U+urQdN8kSXfgOWzRnhvBK5mcX/KrIFW/JvdagyIQZyEzuv2Fgdm/hyt5IIBSlT55TecEmACuc2RHzimEtmiANFsWPV4CORIEjnJttRPUM8CsXBTnL3evOR2NNqKW0/Lt/Qs6WdiUIGzRng42p7PDwiNxTDZP0EOD95ROKnRyrz9E1ALKnV6NBdzNCTDdTXtGMW5NbmmdYNpgyZzCqy5f2YteZNNyR2LyOS+eTe3oufOV/DLvImTkU4WeqO+6N0OP0IF/tAdFsfNuS7KiM0mjTDJm4DmqMqbePQ1aTp9taRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iprnn899GK2by56RN+Zh2vFcTxnglzhOFYBZREcA/hI=;
 b=hGlRUvnpky30HWz1L8nymHtZq2WdFyMf0RhfXXPJfiY42MTcVb2+ZGN9oahfMOBHs8AFiXbPB/iNhALDnvvdIdeXLmXKK0vqGhdxtdB9x1Mt88paYYWCqFPF3tf558Dm+Tf7R2mMUA0CdtMJXTiU98lJRbNQG3rAsHix1lejpqQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6627.namprd10.prod.outlook.com (2603:10b6:510:20a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 06:03:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 06:03:19 +0000
Message-ID: <63038e02-81fc-92b7-4e33-0a2c6c356698@oracle.com>
Date:   Thu, 13 Oct 2022 14:03:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v2] btrfs: make btrfs module init/exit match their
 sequence
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0188.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 739c5182-2344-439d-d955-08daace0a0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ofpUzYm9vP2Oed86v7iR4BAZjA4LhuwDBfqlxndXTiW+1ceC3HxmH5CPFBtsDzGXcJaXhFfJQo9nUfJpIQ4M/YHLJnskMxLUrpCGYX5qqc5Tdegn2wfXi9fH/SnmGqWVR7keTQGekoIssbiZmmMxbSyuwrbO4Ntn29iE2igNvm/dMbXCMYymVAGwTFU7p+Dqtl8AFpz1w9PfrCS2/+c6lY7laJOcO3KXLqQ2k8S7D5sutAqNtNyzcKCjYZZT3sTIIu/TC17gl0oMq89PAKF8Oa1ddYBLXpwf0ILHcXBecOGdgIdxD+K6vzNZAQmh8KoH2GOVd1VGiag81o7qkYw2mrC5WYOtpl0iKOfJIdgrwS+LhGehNGO7WajxEZlKluNujYYBdKF9Fg7ihs3SJgLVOOwNgJlTnFxc9p9f5gxDUVmsN+htpGJhgHxsb9ny3tS7QfadCORVhYGBIgI+uzJviOpKSWW88iMx1/EwApnwe8wQJBcAOZ+xhtElmlNEQCLM9/uTHOmWeiyg+SJFXDb3h4A7jfLuHOYubUj72OcQs2IPbZ8YUme/lmF+S/xgdK87tnDShAthoNIQpgJ6kVelDiyFDMVMnVAOOeHUfRy1w1F4jDQdtSykhJVats4zDbIKaZzFlipjv6sjOPDvNyHadz//OtD62u9Tvoe+XChjyXRneli7i0pX25QABwl0I5PfEkMJNlHu5HyBwKOMjaJX8Yi44blzdfji7o3ECW3KkogY9kO70pL3uRWEn0QEI7kw7Gy1TDol3f3u38le1LJdqz849UmDlSOIuqsbGtiwMbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199015)(6666004)(316002)(2906002)(186003)(2616005)(36756003)(478600001)(38100700002)(6486002)(6506007)(41300700001)(66556008)(31686004)(26005)(6512007)(8936002)(83380400001)(4744005)(66476007)(86362001)(44832011)(8676002)(5660300002)(31696002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNiN3BsMTdvaHJGL0FMbklIQVhVZkRWRURaQVdPbTNRRFVnRGpGb3BaRkhO?=
 =?utf-8?B?MVVqZThmNE9NMEZITkpoV1hVRndCa2I2UUNnTG1TUVNaQm9ualRJbmJPazRZ?=
 =?utf-8?B?dXlqMjR4eWluaEVHVWk1KzBRbisvQTg0SXdTY0JBc1NiOFVqNTdOSUpXSzYz?=
 =?utf-8?B?N1Z4RktDMWw4ekdEZEFvS0ZabWFnTlhheXlnNUc0Vk1QclRYUCtiOGlYSytK?=
 =?utf-8?B?RjBvak0zNk1MdGtQQmJrL2VPVlY0cC9sOTAvSWFCcU1WTjh5VUpRMmk4RHhK?=
 =?utf-8?B?TThyUEJPemtpdXdhKy9rL3J4WG5qWGMwQk1relN2Z1JLeUQvaitDYy9iSjQw?=
 =?utf-8?B?YzlGdmo1bzcrWVNtU0RYT25lb0s0KzB6emI0cXQxRlVDbnNPaG03SUxCSTJ6?=
 =?utf-8?B?RHRaVDdhaktoMXB3aWxJRnJzQmNMRGV3eHlodWFUU0VHWjhMZDhBT3Mvc3Fr?=
 =?utf-8?B?Vi9iS0NzU2dlYzdCOGNJbkNieC9jL2ZVZ2Y1aGJWSzJpTFNuaVQ2eTNQdU9n?=
 =?utf-8?B?VlY3UVJIOVlSSFJFc2djeTZRMENhcm5YSXlmc3BlMEJZd1JqeS9MMjc0MW11?=
 =?utf-8?B?SjZMaFZPR2wvY3pmQWxJekVmNGNDdkdOYmM5Z05sdm9LNTdINCtjU1dlWVNy?=
 =?utf-8?B?dlViZHF5emlNOTYrc1hWT3NXRjZMaW1VeGgzNzZlakNadm5GMWh1dXcvNkQw?=
 =?utf-8?B?NmxUaUxHakpSL25aQlZmTXlCc2pvaEdSS2hOYm10VnZ1Ty9ybHNTcTJRdWQ4?=
 =?utf-8?B?cTZxNnByNGRtbmZRaFhwZGJtOUdkRDdoS2s4ajdvTGtQYTMzM3VWZmtJMmlT?=
 =?utf-8?B?TWcrU2dBSjA3WUQvQ210RXhIVWM2SHoxMS9vaHZrMnk4aTBYQi9HeFFkcTdJ?=
 =?utf-8?B?U3ArdGwvcXhxMnY4djVBQ09BQy9nN2xnQndjZkROZzZqWVIvbVlaK1piYm5Z?=
 =?utf-8?B?WFA0ZmcxcVVJd0kxakp5Y0wxL0VVbmxSa0VhTGh1YVJSSVRlOHZ5MUdZUlVW?=
 =?utf-8?B?eEpuY2xZK0NJNGxEblpjUFBLM1h1cW1mcDhvL0lGbGF4cUJPcGp1aEtlVUR2?=
 =?utf-8?B?VFkyR09QNDQ4KzFqMXRVOWliRC9WblF3ZFRiNjJKUFQvUHJrdm1uSS90QW5K?=
 =?utf-8?B?ajN3VW1QVTV5ay95N1pDOGFMWHRWUldGZ0Vhd2RENS8ySVp6YkJUeHpsclBu?=
 =?utf-8?B?ejRBZ2IxOUJ6L3paM2gyMDUydElzOWZzYVpLTi9MWHRscjlWWTh5QUNPYkZ3?=
 =?utf-8?B?Q3FXbldhVmhBZEgzdG5TWXpERTQ3dXVKZU4vNUJzT3JOdEpoai9zOWtNeHBv?=
 =?utf-8?B?alRSTUtUYm9kOEhiampWWlphNVM2Tmc5cGF0SmFMeWJVenE4dkZNYnhnQlhy?=
 =?utf-8?B?eGovQTJIVjFpZzloZ0dqZXg2a1l5SHIvbWxUdENRZkNkaW9ZMHVEdXYxS1VT?=
 =?utf-8?B?NDhRUG92eTZhOVAxaWxkVU9mcWtEQml3Z29mRkE2Y1VUYzIvK3MwSXc3dnNo?=
 =?utf-8?B?QVJDYW5MenFRcFlaQjdVRGZWejhEQ1BOUzM1bUZVK3MyajB2bFR6MDJnMWlm?=
 =?utf-8?B?Y3N4b1VXMzJjSVdWbDRKK1ljN0o1UDJpR0tnRktHVjNiT0JHUEZ6V3dncjJQ?=
 =?utf-8?B?b3J1b2lUV1N5Qmg4Rld6eWpXQkF5TDlwS1NqYlZCeUIvbHllM05ROVhmdDlw?=
 =?utf-8?B?N09wN2VBVEZmWVh1TWJHWWFmbFRXcitqMjJwLzVuL2JvRGUvWDl3aVdQS2Iz?=
 =?utf-8?B?RmRHRUsxb0UwN1paSUFmdUlTbHpad3hnSjFqQW9XaGVBRXRqWXVmckhtSjVW?=
 =?utf-8?B?L2NoUVNkamhVSDZuc2lUQmlQM2lCSXFLSnBFQXQ4U2QyUHNqc3BSTW9zRGJI?=
 =?utf-8?B?UHkzZTdKTklPTEMwZytaUE00bTUrSzR4YlQrWUw0eVFndGZQemZXRDl5RE16?=
 =?utf-8?B?c3V0enpWYUYrYk96ZzlZUk5qbGlVVmFSbjR3QTRhZ0h0SXA5VlFLL3UydW4w?=
 =?utf-8?B?elRIWStRYjVSRnlkdnZKam5BNTA2N3doTGZ6MEsrazBPSDdrQWpOekZvQi8r?=
 =?utf-8?B?eEthVnRYVUNOOVh4SDZLb3VDWHVWSnFaYkJuYXFCUEYreCtmZWVINmdsR1hm?=
 =?utf-8?Q?EvzYx8xyN/i1CHpNi6ES5FO2K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739c5182-2344-439d-d955-08daace0a0a2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 06:03:19.6837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbEb1qkf+MEwhs/wIAiLnKFZscd3CHKWmhmoy4ZZ0YtbbBWMhHu7AUUnHmEJm1ayZbDhjmejcTi875ZQYupfNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_04,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130036
X-Proofpoint-GUID: 9Nde9_-xz-cz5bpHkNXiytIuVxFyyA-B
X-Proofpoint-ORIG-GUID: 9Nde9_-xz-cz5bpHkNXiytIuVxFyyA-B
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> With this patch, init_btrfs_fs()/exit_btrfs_fs() will be much easier to
> expand and will always follow the strict order.
> 

Nice idea.


>   
> -	btrfs_print_mod_info();
::
>   
> -	err = btrfs_run_sanity_tests();

::

> +	}, {
> +		.init_func = btrfs_run_sanity_tests,
> +		.exit_func = NULL,
> +	}, {
> +		.init_func = btrfs_print_mod_info,
> +		.exit_func = NULL,
> +	}, {


  Is there any special reason to switch the order of calling for 
sanity_tests() and mod_info()?


> +static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];

  Why not move bool mod_init_result into the (non-const) struct 
init_sequence?

> +	/*
> +	 * If we call exit_btrfs_fs() it would cause section mismatch.
> +	 * As init_btrfs_fs() belongs to .init.text, while exit_btrfs_fs()
> +	 * belongs to .exit.text.
> +	 */
  Why not move it into a helper that can be called at both exit and init?

-Anand
