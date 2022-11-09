Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEC76226CA
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 10:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKIJWv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 04:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKIJWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 04:22:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8903A1F626
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 01:22:41 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A99DlcG028236;
        Wed, 9 Nov 2022 09:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mUu6vqQ0rbW6C0x+MoIyoE/7W3tIh+6EqvopY6zkOwI=;
 b=EBcJx+frfknOyfvnSbCfYCkgGhyQ/7GaWCx4GfI96N/t0Rgl0eGoRQNBxsXISSBT+rMb
 l9H3TYC/DAUZ0waoGgwm7TDLAdhM8nsvOmTYTxt9Eetip16nmm5rwNOBYYh1OTphrN1w
 0ULexCicS9d7Oiy1v5rxnqjpGFSGQOx24AKiuLBKPFdcnLj+bvZ+oKCjuMTwHUjk1eqH
 nkw3O8Qomg2i5iG5lht+j5KHVIo831FITHL2pN/SgGd4z1LTVMgJgDxvYbgdWfoE1/b6
 niWIEyVqBzUB8Hl9pjjE7Kudlv1+gVUU9uFHIqwz4XEIwDJTbRas6CP1pM2QRMZQNOQs IA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kr9cn816w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 09:22:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A97rvxX000353;
        Wed, 9 Nov 2022 09:21:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcseq4gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 09:21:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyGu7ZozX8eqH50fKOqwGSFCnxn0FztpU/nT388o/W+0+tv/2Cq7RKRvcCFu0RGtMpOouWHpEZI9JhTcqI8hnrda+WZF/q8wgP0i0Dh0jHJghY3N7TFJQkHbVQyXiFiNNOiUQKNqrZZCj/cMxcmhc3xMqN0poxtNouQLeJB2/gT4aBr6MwavVwM2V/ipDr8h491XwPQNZKCL5OULsmhB0TCc8YhLXxw7SfTgGZPuMik8/LYfqMxivvDTz1UkkhfUQPjOdDnC+RzH2rAc87j7KbFj8qPHXR6dPnTGWn+TvERc+CFRBk0PfajHZx5KLcLP2sPx/XL6cQcz0NrQ4dgA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUu6vqQ0rbW6C0x+MoIyoE/7W3tIh+6EqvopY6zkOwI=;
 b=QFFEGaJEsDyjnC40m1VIw17oHUF5igVI4cCsiojT0zU+TmhpE+ztrX3N4AYNRSOj0KD+J+H7Xw2x57wqi4LL1yZnJmeXUEPAQ89oi1K2H5YbHgICYJw6DzMN7GlzEqrG2DVBNZlxOM/Z8h9dGNgy3O0joVPs21pWWmmyd3Wj8h4jAX2y7RNBUlLlQT7SQyo8I1eeI92mEQgsYWzVDwy9pqHhG9XpDgU1XC5Zh3niXySWe9cmZnRxRk4/+KcwZN6WpZ90to3bqD4zdkrPFuR+AISWOKiHXk+mnhT8xwSAnFH93SZYu+Dd71jFJ14W2+RT/IOjbtnbwZOwNuqUyOO6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUu6vqQ0rbW6C0x+MoIyoE/7W3tIh+6EqvopY6zkOwI=;
 b=ePygLVcckcaKRqA+IlaauzqkXpeLehS2gJ0hP0kFjeN5zDU4tXBkyWCAFIgL5hXWDpOBgmo0fMJRU1REg2aNybBSxVScQF2TTf/xAs9FXrcVZJtPQOcAJ6tTUA7Cwdy9kDujAXqXyQ0dpymeInZw5zSbID1UwkdJgtx3oQDhaNs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4727.namprd10.prod.outlook.com (2603:10b6:510:3f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 09:21:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56%4]) with mapi id 15.20.5791.022; Wed, 9 Nov 2022
 09:21:22 +0000
Message-ID: <6af7ebaf-4dca-31ad-7854-df73772dacbf@oracle.com>
Date:   Wed, 9 Nov 2022 17:21:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: move device->name rcu alloc and assign to
 btrfs_alloc_device()
To:     kernel test robot <lkp@intel.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
References: <558d3ae7ad53788c05810ae452cece7036316fb2.1667831845.git.anand.jain@oracle.com>
 <202211091331.YNFqkpxV-lkp@intel.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <202211091331.YNFqkpxV-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0117.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4727:EE_
X-MS-Office365-Filtering-Correlation-Id: 385235d4-d87a-456f-67e8-08dac233c3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +O8CLojZQu3nw+ozZUpUqQHbc0VPB05Y0kTYfYD3OWXfRqt4SMuj8SFYkbXwoK7WuKZtivI/xzdRr4snn8Ktgjas2NoKzLlIQaITVI7A7+0M1Zp+eQmUHKf20OakYChCCE3ok3vw07AY+Q+sS9NpduJL08ss+n9DOyC7GZjmVt2TdQYe2I74fDsfUiRVI6K/FK9mET2kXrpBcZTNQ3PaoG9VQKRVs3FFIgRVFGcgTaOj37dxBiQ3MFA6RHp6fhK0czzPNjBexIsNzejzFXqNjBLCx06bhv33SkTkLSq88dOJiwGQeuI2CPkJzKQmz9sKl6u96Wu3HTU6fwJfbxfi/Kvdy/HSCWx2ygYi5xthHyHlcLKMNKYwvec0R9LApnuoY3IQJhnyFr0LDdzODbmUQiN2l9krBM2iOvYls4jzg3Wrj/eErVL8phogp+Si8y7Dv0W64psvq3oqSChIrf87iSR5qwfkFQuLFhUJooMFfYxkRa9EtSddcDPtazUmhI+5OzitRIAopKfub6GNg3KtFF5hYe0YdwBJHtrKHrxlePbKR0vCbk0h7seqUF+Pf+rBlyUdRc7kzgRSGx+5zOSBUDmyXokM+cA0W/gx4BiK4KVfOGQgs1h6Z6qIR3Vx5+TZ/3bYsFenwXIYqmDCfkDti5zOysXEpWNJKbGQp9KvBWUtWptOekNSQ6gFOy6VGTfNEEYdxDdC57RoQD3hvKg/lYqb6COKZ8JFz62VeXPPlwfpkJv5497kKpSY9oxbZqkN5FS3qmSzpTSrOlmyNr9RzlZeDzKeLwuSpbksCwsDtDcQKf4fnu7Lo1EzN3bQRedSWtmGHcWsMO8CxwxIQilSAJRCAr++OqrySTeMivAvaD1fASKsoITvoicBmhPrHCOr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199015)(86362001)(31696002)(36756003)(2616005)(2906002)(5660300002)(44832011)(6506007)(6512007)(26005)(186003)(83380400001)(53546011)(38100700002)(66946007)(66556008)(316002)(966005)(6486002)(478600001)(110136005)(4326008)(8936002)(66476007)(41300700001)(8676002)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azRrc08wMHJPdHFaT05NZ3ViOWR6YzlheEFBUHF2Z2V0RDJVbGVoTS9aSzFJ?=
 =?utf-8?B?Z1pwUkY3Nmhaa1MzbjY4T0UzMEZTTzRvd0t6bWFBNno5TTc4Zkw0SytXdUE0?=
 =?utf-8?B?Ty9CNDJlQWlTSlFqV2ZXUWRNcFVyQ2QzK1FCQURaNWpHaHRIT21UWWhrQ3Uy?=
 =?utf-8?B?OEFNL2FNZ1RZaU9iQWZIenAyUVA0Vk1tNHpESmRJMHhabm5zOVpoN0QxWWNI?=
 =?utf-8?B?VFg2NGd1ckJJYngzSnRaUzFKdlNrWkZpMlNWK2lnZ0kybGppU0ZuUmo3V2t6?=
 =?utf-8?B?WmVGQ2MrMnRaUStWOWZzRUl1UHFWS2xhMUMxK3dOd1JJME9HZkpGS3IzemFi?=
 =?utf-8?B?SWNoTlBoOVprUGtBTndSc0lpWW5MRjlkZVdPZWVWWlMyc1B0SjdXcmVRdklL?=
 =?utf-8?B?bUNLdFN2SjZHYmxkTEROWEU4OFlyTjhLTnNoYWo4VGU4VXV5SGFnZGlXNnY3?=
 =?utf-8?B?T0djWVNJc3RKQ0k2VXdTVDhrMWlxeFU3QktQYktxdlJKN3hrZFFocWNrc0hr?=
 =?utf-8?B?ZWZTWTlrQ2I0T0kybzZ6TkxIQmFmaitJMk5mZENwRTg5MmxId3JTQmx6SzZo?=
 =?utf-8?B?VE9hUEpqait0Ui9JclVUMU1jUkMzL0hiTVI3YVYwdXU4MHU2dzZQRHhZMTF3?=
 =?utf-8?B?ZGFiaEwyeWNzKzM1d3RqckQ4YUF5TjVaM3AvRHcwOEcrclJRV3dwQzZVNXli?=
 =?utf-8?B?L08yZ2lqVDNsd2ptRjVwUFZtR1U0WEZaWEgySjhpa0t1ZjRjTUd2dlRRTTV5?=
 =?utf-8?B?dG85YUhKWktlOTNLcXdRb3NLQi9IZENBNUlZa29UNkdralg4VzU3clRGcnJ2?=
 =?utf-8?B?dnJINWowM1pCTUtlVEZHcE5nZWQvUlZ2N0syYWg1NG0zVXVwdDllR1ZmSXly?=
 =?utf-8?B?WUVzV1dLU2trSnpuTFdpbU5XZlN5SnRhT2F5cmxCWnUxeE1yaHM3YU85NEN0?=
 =?utf-8?B?MURPSkxWZ29sOEhnVk9xdUVDa05INlRMN2pyTXV6Vy92QXBQbnBBNkp5OU50?=
 =?utf-8?B?c0xtbGU5YVBEdDg4V3hiN1I5UlNtS2xGV2ViV3A2eDJxTkhZNEJOQW16em5J?=
 =?utf-8?B?M2phSkc5VElHaXdOaDZwYUlGRlNwTklmZXhQS3c0bWNUcW5nNXptSHcyMVRH?=
 =?utf-8?B?UXpQYmpoTVdiNEdhNGpvNmZLMlZ5NkJlTk1TOHdzeG54Q3VTbHhlaExwNUlF?=
 =?utf-8?B?NVlBcWpYQzh4V01LYkFxdS9TaEZubStuRHNaNWVUbzJZVkVJcjlhVHZhUm85?=
 =?utf-8?B?blZZZ1pJRnBoQTFmQXV2Y1ZUYkdSaEFpbHo3RWZBZGRDRjJMSkhUVUtZNk9H?=
 =?utf-8?B?ZDQ4UXN3aXdia2JHeGZKY1NuUXM2SFBHU1BEUGlCd0VDa0ErVkRkZDl6NDRk?=
 =?utf-8?B?LzNhcWM4RlVVNjNjQ3djdnM2VERLcFlHWEJzYTdBUXRBYkZBdElVNXd3a0NR?=
 =?utf-8?B?RVlGMTY2S2V5TWw4bmVrbDlod1FLRHp1aUhYVFpvSG1VbU9wd3UxazhvbUE5?=
 =?utf-8?B?UDROY1BwSFRpcTJnTVJBdkhGUzJHZVgzK2hPNiszejhJY1Rwd05reEhwZUY4?=
 =?utf-8?B?R1F1SytzeGtSTXlyUGJPaVgzeGlhQ2llM0RkZnhnYTNmOW90Zzd4WHVXeEhy?=
 =?utf-8?B?Y2pqRlRvT2x2NEoveVJIdEo3UHNRUVJoTXZaT1dSQjFZRGgyVFZaa2ljQnZM?=
 =?utf-8?B?aEcyU0VFRWVMU2tFVUhpTW5JR3RHR09GZ095eHM4czdNYWY2WUxnZHlOMTRE?=
 =?utf-8?B?eTk5M2dZRnYyZTlweTJDWGtDRXBDaDVNL3gxUXNKZWNXajI2MCtabllFUTNC?=
 =?utf-8?B?NHNuSE1DbDBhUk5zYWk3R2ZCN3RIU1hsNVVrV1ppMkhoOVBWdlU0MWJGM1Jq?=
 =?utf-8?B?V2l6RDRQcTljOER4OWtla21vTnVvWUhGYjZBTXJ2UXBVbmtsdENKcUxQRVFw?=
 =?utf-8?B?OWpta3EzUnZ1M0lzZTZ2c3FzMUs5SnZOWlhxRTFqZDJOMnNoRzViT3JhQ2wr?=
 =?utf-8?B?ajJEanBsMjM0cUtDckMxSXQ4Vy9ObUg0cy9kM05TUEh4K0dhdkRBdDU1dVlk?=
 =?utf-8?B?TFZZMWhPSzFNNVA3bXhmTjdrTnNJRjVhbjUvNzZBeHV5b1Z0cDR0ZGNIdzZI?=
 =?utf-8?Q?gFfJFNjG5dymNllkSz7tbWpm1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385235d4-d87a-456f-67e8-08dac233c3e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 09:21:22.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48kGk6v8mEGc3OtXwDlbNWcHMNUOQ+cA/d9ZvU5B3xE3VSAYUaDhYZMxsNehYIE8cXYRBp4B5WDQVuAqNzG12w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_03,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090071
X-Proofpoint-ORIG-GUID: loPnDcyb-09oiDaM7klMvWiPrw9wmHaN
X-Proofpoint-GUID: loPnDcyb-09oiDaM7klMvWiPrw9wmHaN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/9/22 13:25, kernel test robot wrote:
> Hi Anand,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on kdave/for-next]
> [also build test WARNING on linus/master v6.1-rc4]
> [cannot apply to next-20221108]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Jain/btrfs-move-device-name-rcu-alloc-and-assign-to-btrfs_alloc_device/20221107-230806
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> patch link:    https://lore.kernel.org/r/558d3ae7ad53788c05810ae452cece7036316fb2.1667831845.git.anand.jain%40oracle.com
> patch subject: [PATCH] btrfs: move device->name rcu alloc and assign to btrfs_alloc_device()
> config: riscv-randconfig-s043-20221108
> compiler: riscv64-linux-gcc (GCC) 12.1.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.4-39-gce1a6720-dirty
>          # https://github.com/intel-lab-lkp/linux/commit/084f70deaf67118927d4f0494ff5b3988eb77146
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Anand-Jain/btrfs-move-device-name-rcu-alloc-and-assign-to-btrfs_alloc_device/20221107-230806
>          git checkout 084f70deaf67118927d4f0494ff5b3988eb77146
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash fs/btrfs/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> sparse warnings: (new ones prefixed by >>)
>     WARNING: invalid argument to '-march': '_zihintpause'
>     fs/btrfs/volumes.c:409:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcu_string *str @@     got struct rcu_string [noderef] __rcu *name @@
>     fs/btrfs/volumes.c:409:31: sparse:     expected struct rcu_string *str
>     fs/btrfs/volumes.c:409:31: sparse:     got struct rcu_string [noderef] __rcu *name
>     fs/btrfs/volumes.c:617:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
>     fs/btrfs/volumes.c:617:43: sparse:     expected char const *device_path
>     fs/btrfs/volumes.c:617:43: sparse:     got char [noderef] __rcu *
>     fs/btrfs/volumes.c:884:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const * @@     got char [noderef] __rcu * @@
>     fs/btrfs/volumes.c:884:50: sparse:     expected char const *
>     fs/btrfs/volumes.c:884:50: sparse:     got char [noderef] __rcu *
>     fs/btrfs/volumes.c:954:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcu_string *str @@     got struct rcu_string [noderef] __rcu *name @@
>     fs/btrfs/volumes.c:954:39: sparse:     expected struct rcu_string *str
>     fs/btrfs/volumes.c:954:39: sparse:     got struct rcu_string [noderef] __rcu *name
>>> fs/btrfs/volumes.c:1000:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const *dev_path @@     got char [noderef] __rcu * @@
>     fs/btrfs/volumes.c:1000:34: sparse:     expected char const *dev_path
>     fs/btrfs/volumes.c:1000:34: sparse:     got char [noderef] __rcu *
>     fs/btrfs/volumes.c:2182:49: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
>     fs/btrfs/volumes.c:2182:49: sparse:     expected char const *device_path
>     fs/btrfs/volumes.c:2182:49: sparse:     got char [noderef] __rcu *
>     fs/btrfs/volumes.c:2297:41: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
>     fs/btrfs/volumes.c:2297:41: sparse:     expected char const *device_path
>     fs/btrfs/volumes.c:2297:41: sparse:     got char [noderef] __rcu *
> 
> vim +1000 fs/btrfs/volumes.c
> 
>     980	
>     981	static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>     982	{
>     983		struct btrfs_fs_devices *fs_devices;
>     984		struct btrfs_device *device;
>     985		struct btrfs_device *orig_dev;
>     986		int ret = 0;
>     987	
>     988		lockdep_assert_held(&uuid_mutex);
>     989	
>     990		fs_devices = alloc_fs_devices(orig->fsid, NULL);
>     991		if (IS_ERR(fs_devices))
>     992			return fs_devices;
>     993	
>     994		fs_devices->total_devices = orig->total_devices;
>     995	
>     996		list_for_each_entry(orig_dev, &orig->devices, dev_list) {
>     997			const char *dev_path = NULL;
>     998	
>     999			if (orig_dev->name)
>> 1000				dev_path = orig_dev->name->str;


David,

Access like orig_dev->name->str isn't introduced in this patch.
We have to restore the original comment about it.

                 /*
                  * This is ok to do without rcu read locked because we 
hold the
                  * uuid mutex so nothing we touch in here is going to 
disappear.
                  */



Thanks, Anand


>    1001	
>    1002			device = btrfs_alloc_device(NULL, &orig_dev->devid,
>    1003						    orig_dev->uuid, dev_path);
>    1004			if (IS_ERR(device)) {
>    1005				ret = PTR_ERR(device);
>    1006				goto error;
>    1007			}
>    1008	
>    1009			list_add(&device->dev_list, &fs_devices->devices);
>    1010			device->fs_devices = fs_devices;
>    1011			fs_devices->num_devices++;
>    1012		}
>    1013		return fs_devices;
>    1014	error:
>    1015		free_fs_devices(fs_devices);
>    1016		return ERR_PTR(ret);
>    1017	}
>    1018	
> 

