Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02835BCC1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 14:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiISMq4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 08:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiISMqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 08:46:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37F52A95D
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 05:46:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBxDF3032749;
        Mon, 19 Sep 2022 12:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4JoP+NfefGsnqnxJhtR3/oN1ZvEq12mjAF14oVGNe6E=;
 b=Il7deEaFp1yq2Qb+8m6Ww7YeK4QUDaiDYpVU/wbfquh6+JtxTKvUFD3ZAX9Eiv/eQY8M
 gT4n/Mu5EmUkgtvtxq5/M95443bn0KPTttyhAQZ70qtoXh3nC7CngHhAzjCDMCbj+b1q
 rTDSRd+wpS7CSKovYnz7/5BM5YSrshUaWAcPHbXoTvEzKdBlScmakGRUhl+kGCPPzSyY
 30b/A49sXPjj0DzfyPT1KAnarVyE125fA5PipvwTEqCD1DCAdPEDJhQTTSHPNwfqLZN6
 6OWa/zyrUlHu/qThJzVL+P5I082rLvKxEJQef6Lw/pv7EbiFI5VEGG7v8o/m8KQEkq38 FQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6f0bmna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:46:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBMgDc009584;
        Mon, 19 Sep 2022 12:46:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3c7ktua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7EU3ySAHatgw+LukoNHb1lR0yZi7YbSFQBFDPieIg+9ygUT8tZM9OfyX9iBfgGOawtInXRHTgnXSwBY7HnS4zlTe8F3e1J0RU8DYpqDPPjNM1trRincWI5Jox5x/r8OZQLr5Fud/AsmguXi1kyUklWFVSY8kbDRgf8lKTr2j+0HBFHRlcdWUTlkTcbrOVcgt1fBFvQwnbNNY9+/Va8DLIhyQBRXjphPiS26IgEfDQCHylq+pu8O2LCYogQDC4itWEUj5RznT0PIcZXuH47STMc9WQc++HL/Bn3vdKb99mA1IWD11JHvFWSp2rqTJwilj1HQWrpZ1K9z7DETZHnmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JoP+NfefGsnqnxJhtR3/oN1ZvEq12mjAF14oVGNe6E=;
 b=Z0U+yeRL8/JtifhNKRjz4NXwuNJxDFbu5z9QZQfM1owAVtZLh/jaijgE/mKCNYCwFSM70Wl6xiV3IUKGNivQPtussc57vrrnJli3C1VlRbCcHo1ikBRPrr6TEx9b5gWaJIo/4TJW8R66/rtlqltTkcCspB1adGb/LqUY+JiH5E6Vp3k9Ho8Jp81YzKnuCljQEe3qW5f16h9vidMTP17m4ar7LKcfuDJllu4KTHtsg6Gl6uv1HgSwt+VOuN5Gpj3JSclBj9LTQ3jqBpAtZYgFMb3rpMHqOXwcxpLQoRv92ytXNemlcjqCA3Yphn5tjDXyJruxuIhoPBVu7gnrIy1vjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JoP+NfefGsnqnxJhtR3/oN1ZvEq12mjAF14oVGNe6E=;
 b=ued2toE13pe/3bgkfTJceYS4Ma8GrRwlSXpumeSHj4mZm6oz6CiVO1RpFTSMyTtwsN34UBXNikLp2uWUF8NPCY+75n4UBEXKflTSWiAam6IT5KN5PwG2ezvq8Y9Cob9XJQ2lJapKS0hhKWNElOMkqEW9iGoi0U3oeWQ/2oUOKtg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5631.namprd10.prod.outlook.com (2603:10b6:a03:3e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Mon, 19 Sep
 2022 12:46:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 12:46:46 +0000
Message-ID: <dd277a8a-67ea-9b06-29fa-babeb964832f@oracle.com>
Date:   Mon, 19 Sep 2022 20:46:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 14/16] btrfs: rename struct-funcs.c -> item-accessors.c
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <3f6da9cb8ecff030e1a3a4c9815d5d8604f1cd19.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <3f6da9cb8ecff030e1a3a4c9815d5d8604f1cd19.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f4e9c2-2895-45a2-869b-08da9a3d032e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QoHQqiCPZHx2tKcImbQNwaq3ayEJpXdxD7cOGzagqcfntDd/hzH+LvHYKLE0pmSHxN7uyxUnILcT/fvBsnI2Klf//N9rjvlNG0wLN1n15Buzqdp8z36In4mCsaDQqV5QqaoS2GCTtGDhZiHjXpCDHdOvbYSWsvlSy+7J7i6PT/IbjPjEnFF8nzj8yNkIURzrzkpdguJi6+XCoNLEqZXdplq6E3DouKMujUlMDI0Bfd19ljaw8AoZOS0WZUyf4yNRScoX5zHseP6leo4dlBr6ljKOqAH3wyMSTON4/sPMOduMdhqHYg/T7kvdm+PeokyQ39J8fGECTw6D/ZEQIvv1kzKLn3F01/8dxJfYtmvtyBXaDOeUZJbi4G9xfrUq2Y2DUaO0v/gJxqL1HSytsKEyBCLGrEh4uapN4Ru8oh+Vz/waSbTv8TsvTdVb96h/HD3JZaqBvs5/FCz96Wvu+iynMmVDB3CwaUHf7h5DTwp2tZEiq2pQcDhVSgvlqN35CenQdnOiN3CIfYFxj3Yv7hVvzkkv7SQQOdhDCb2XTPHsIRojmj1PrSEEgbW9cTGzObT8X+ZbwqEJSGLFJdoWNiRvETvVMRdi2U/GszD9cO0TCWxlJQc6bAV6WUxOOvKtcrCJTDDpH/lUjF1FuQAKYo+JQLHCKp7AWAGhuXLm9fyjY386G6BN/Nv8F7hpjwkYaC/RR5aEMz60N8fOSk47uM3ig1+dggkLJju2eU+ZvCH9U1+D80MSm1WQC0ogupB5rlUK+RzgFnopa4zbsnMFKQ4e5/JO5XgSruHw0FlZpCjqH8pxSFYIH5Lu79oZYO5z9mrc3CTMQ5KOMdLl9eyJg/x6MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199015)(6666004)(31686004)(8676002)(41300700001)(2616005)(66946007)(86362001)(6512007)(4744005)(31696002)(53546011)(83380400001)(5660300002)(66476007)(38100700002)(186003)(36756003)(6486002)(2906002)(66556008)(316002)(8936002)(44832011)(26005)(478600001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGx0em5iNXZTckxZTkROSFVXTWFxOVV3UkF0SGJMWElXaEVHUEFNTklnbU44?=
 =?utf-8?B?cm1FbjRxYkxmckphZFBkY1JYL0RoZERVL2FzUThrRmxEQlpkRTlLUjJZZHVs?=
 =?utf-8?B?ZTFlT2g5VS8wNERYdzBOUnJ2bFd1WTVDSDlaMFFmdEpUc3RaVjhjY1RzYW96?=
 =?utf-8?B?OWJTd2pLaVdIaDdZUHVaRm56Vml4MDg1N3BkRENNSVArYTdFTWpGRUlyOG0x?=
 =?utf-8?B?QXNsZDE2R2NIUi8vNTAzVWJoRFVsQ2tQVS8zUHk2RGVlME5keWJRMWNsVDVr?=
 =?utf-8?B?NjdxbFRlVDhBVW03SFJURU9yWVArejQwazdkMW1zbG4xUjIzQ0dsOENzbkpB?=
 =?utf-8?B?cDdmM2t5dXIzUlhTakREM1FyUncxSm55SFR5MWlJYnJwRXFtbTVNWThnR0s3?=
 =?utf-8?B?dUlhamFRTmcwcEJuMGVMUW1VVnJxVW1WNUJLS2Y0RVh3TmVGVHVoTGFIMU5m?=
 =?utf-8?B?TDdMbUNrd3k1U0d2Zkl4QWhRODlJZWljMDFDMjNQbzFza0ZZaFE4bDZQQTFv?=
 =?utf-8?B?cE0zNkZXVGl0emZNN0xtanBKOXFqYnI0eHJvQkVzQXVScG1BQlNiNFlSaTRt?=
 =?utf-8?B?akZNc1l4MStvMFl6dTZoUUVGcDNCbHQwUVJncUpDcis0cEpEeDhySkZsMEI0?=
 =?utf-8?B?ZGF0TWFyTmJrVUtpYWhjSzMvSkdPQkpPd2VsMHdndENqSGhmNyt6SHJOZFoz?=
 =?utf-8?B?cnl6ZVY1bFZWS2V1SXlqMUNRYkJTY1VUb1JkYnJGNXhSbG5XY002aFJubTI5?=
 =?utf-8?B?OWNKbGxUemx1REVNZHN2ZGpQaFJBZDUzWm80U3BKOGxSSU5MeG5OY3Vkd0pZ?=
 =?utf-8?B?alh6aElnNDZHUlhhUUh0anNOaWNPcjJQMDRpcFdmTndUOERyMXRZMzFwMjhs?=
 =?utf-8?B?Q1VmcG5rZ3UrWUZ5d0Z5eFl6TUtsbCtqeUNqMjQ1c0dWTGpKNjR3TDhlb3do?=
 =?utf-8?B?eDVYL3FHekppWTZhRnlDUVFtRzJ6TSszeWdWSFNLR3laV1FnWi9uMm9KOE4z?=
 =?utf-8?B?dDJCMmZMRGNnN1ZDYlppQWRKbnhkYU1BeGFLVUtxdHZna2ozbDhIS0xMa29E?=
 =?utf-8?B?OHZYWnljckFsUi8vdWNuSW5SSDVHay93OXRDcytnWG9mcDcwZFB1RllhV080?=
 =?utf-8?B?SnMrb2p3Ylc2VkcrRVc4M3lEZGdiaXBRdXh1amF3M042enlzbmVTLzlpSnlr?=
 =?utf-8?B?a09Hcjh5SThZWTc5SytsL0YzMHRraUlCcld5Q2htb1h4dlR1aFY4dTdSU2VN?=
 =?utf-8?B?SEJCZTA5cGpjT1ZOL2JGdWIzOG9rWXVFOFpiUE9RYm5HZWdLajZOdkJaV2Y1?=
 =?utf-8?B?U0dBZmtOWjZCTHFnRllsYVM3RURGVXRnVHFwZjlUdXZ2UnFmbG1RUDdxTmFI?=
 =?utf-8?B?NEhpZ0lkRWVWTkhYVENhSnJtVmNSMUs2Q3BMV1F1V002NGNWVC9hMEVrTk1B?=
 =?utf-8?B?cTNsT2V1Vk1MSGJ1cEJGblZramNvcUxlY0ZEenhFbG5ZYVFzU1p5QXkxS0xn?=
 =?utf-8?B?WExQSHR4SnE2d1d2VmdPSXhTcmlJRVpZOW5FOVhtMzcwK212UFdrOTNZSWFz?=
 =?utf-8?B?NW1saWFjUGc3d1FEQklyRTFwbE9HNmNEM0VZeTNVeS9ORUE2cFBDdklSNi81?=
 =?utf-8?B?RWJVaE1jc0YvdjM1U2ZvaHJiLy9NUnY0RGQxYWVaT3ZzTDMxQ3hYd2FWdmh2?=
 =?utf-8?B?NVp0ZzhhSXVoOVBmOUFrNTBjUHBvcjFrdnAvMmJDZ0NBWlhmMXgreTdwZTlM?=
 =?utf-8?B?QmFmczF3WE1sZkc5R2FrbWdzT01UVE01UXZET2N6cWp0YTJSbklocDNKVE5l?=
 =?utf-8?B?OHZNLytySDcyeFU5NnNCZVdZR1RSck5jRW9NZ01tdDR0dnNNcElJeU1naVdD?=
 =?utf-8?B?TWc0Q1FGc1FqOTU0bFZRd0lXQ2ZXYkF0Z3VWaTNQWDRKL1hRcUljQWlZSUJK?=
 =?utf-8?B?ZnVYMFVuNnBqTlo4OG5PZFhzMW5JdzcydFFwWjR4WTgvNG42dGdrWWo1c1Fq?=
 =?utf-8?B?RzBNbXZ6NjEra0JQaUtqU29rQTJKeHgwWWRZRVJTSHZEUnFKa1Z3SnJkMUpO?=
 =?utf-8?B?WTVqQmp4T2pGNnhFcFBPYWI1bDFkdkNvNDBQc24xM01FY2VCVVNsblcxZjMr?=
 =?utf-8?Q?sbDTSlWCz0Db9jG/aUwMJ5TnT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f4e9c2-2895-45a2-869b-08da9a3d032e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:46:46.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBgDUREYi55bdgCAwetRqw4TqquoEDex91nVJELijwTpNJE0lVufrFPJOqpFa8Q1rMOZXxbFZjYDPKSgIsfoig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190086
X-Proofpoint-GUID: 9rOfX-3D0AgZC8I0FYWq4e32nYJiYd-8
X-Proofpoint-ORIG-GUID: 9rOfX-3D0AgZC8I0FYWq4e32nYJiYd-8
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
> Rename struct-funcs.c to item-accessors.c so we can move the item
> accessors out of ctree.h.  item-accessors.c is a better description of
> the code that is contained in these files.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>
