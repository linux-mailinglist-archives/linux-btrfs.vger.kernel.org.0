Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CB74D9AD0
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 13:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiCOMEj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 08:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiCOMEh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 08:04:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6483B02E
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 05:03:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FBS3tl021960;
        Tue, 15 Mar 2022 12:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WANz0iDNfGQhIACSMqrXKbl7cQ658HyI2WBYDuqSSx0=;
 b=1NqlUbx+Pk0kAsBUpikQaRqp7GvzDnEq+wHFiS+/7WZ2DIdrrJNwjJR1VrdBY5nlbPPR
 Bd+gdg82v7m+K1MWdkCztDyh+R+6YUAumpwvi/A53ico8+k0LP4Dw1rYcQzmORagniTq
 rbf9fj8xaKqQnrL6iQA8CjJH42V5gyny9pHppYY2C7sTHZoIAKvOkjVwQYLF5dG570EF
 1qFycEZjvHEtvJJ7ADK/cWm+JSNxHfqAIdvN0CqqDp1eu4yO9oRBX/REG/TeYTamLqBA
 YeG2MBTPLJKCgGyInxlTdxWDkyrbajEOPmVPbnunrI/mW9QYl6zaUfxvTIPk+zBTFytW wQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60raudv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 12:03:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FC0pbV089712;
        Tue, 15 Mar 2022 12:03:18 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by userp3030.oracle.com with ESMTP id 3et65pm96c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 12:03:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6+9xO++1/25s/rybycS0OWjp8cJtcIUxvt4Pd3tibqUUEqFheSLXgp4X0TNj6n1J1j32G7s/VHiCsBcsf2VvNx/NCmkWRwf2VRqnDzI8IRRHkZg7hNHce5JubXfl/lVn9bAdx3U8XI2YGl0dxDW9T/3ECTqpXxplg2FHFd6GUNd5PI2efrNkqNTaKkiIlQtFh/D/TqPyrGMFL7TsHRdqM1ZzfNkeFwcbxzlEi4+iCeSEk+EnYRtobuxGN/f/D5auPOI1tT6GFxDZPRmLspByoJoTo/hm83TrZT2O4JOCDLLjNGOGUKlqOtVlHQK911fQwPXVc00Cg2bzFDoL+ZKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WANz0iDNfGQhIACSMqrXKbl7cQ658HyI2WBYDuqSSx0=;
 b=jQK9yPq6ZAG/CIzGb24GritNISWVn9x00CCKO10U6keem1joTvx5o0Z7QYpuApEGGCBRRsXBytVN82/PMWwLyUwzZt0gUNZCn28diDH/PaGlft9o56JXb3ut8C2EgmerAVcqe4KnRPut7Y5iq3Du69/RfCCeYYOp65uM7OIBZztlf6KJFojiDrV0L7wLJHye8Mtoc1MAe2XX6q9MkkpddgAlYN0e5W4vncvgK7++YuymsCYRVS3l0apQ+lSza1M/Imo6BMehoCYv4kdL8DNbeTGB/d2Go13YDG3fNqmKEra72kJnWmwIduRPqxISzTd6gEHoN8GumYwEpzl6ZeZiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WANz0iDNfGQhIACSMqrXKbl7cQ658HyI2WBYDuqSSx0=;
 b=tmhLNTxJcec+UUrFnV3riHF9iK5uPW5tdakjpDFrr1LaHDdPk4rVJ9vF3zPKN8ajN/7Ivph9uzxZX9ejA9XCGsxeVIrrUkNAHYIj1lZprI9YgmWr3yurKol6zy+71+eyBAg2Uu8geleAe3N3MVdtOF34nYi+E+poxAwNMRvAuy8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5360.namprd10.prod.outlook.com (2603:10b6:5:3a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 12:03:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%5]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 12:03:16 +0000
Message-ID: <73de021b-15ff-01e6-ce2e-be17299cf1ee@oracle.com>
Date:   Tue, 15 Mar 2022 20:03:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: zoned: use alloc_list instead of rcu locked
 device_list
Content-Language: en-US
To:     dsterba@suse.cz, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
References: <f7108349f3a7d690166c88691c5dc1932cab3610.1647267391.git.johannes.thumshirn@wdc.com>
 <20220314185539.GM12643@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20220314185539.GM12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b985204-63aa-42c9-1df9-08da067bc9ab
X-MS-TrafficTypeDiagnostic: DS7PR10MB5360:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB53607050D824D6FA54299C7FE5109@DS7PR10MB5360.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NlWDWLNVF4VEY/zVP8h4F7Gf9suJgIbMegGoSx4EJRsKLOxXR1bBUx7794I3aTb9QdjEGJTtFEuoaYDSkU0LrvbIy/rXrtFFM9tC/INH8AsLoGw4t9IZO/QZp/VC30dhKvdVYkV33mg1PjyRyr/XOriU9CnDtksnPWOYLaOzYGGUIG8cyxQ9Bam8nvkRJc3rJ8HcJtwsrdFlJx38AyCnu5aA9AnlLgdUBiLDkA0Kz+wB66a/SUt6zL+c4p9MBm+NOn61P/ldt37FC8gLttvnc5pTyUACFzpwb5L/aAEongWAQQGTtPucLfI5NQ1SS6pOdMqdd91fNr5MnMCLdYFeydRuvr7TzuFmDUc8OKY6nuYsKbRtdc9ftO02YzpzmJH16Z9Ap97U0YSpeo2pyEJoZdKnsoV77W34qGUmMS9WIRPCDGLe6vtmXOro449dED1R5y6KkAdutQQhE0itM8RCQorcwTtL0yEmMYjzUozJrQeENLIpRo/BG01cZtPAOCOUpsCzTdFTrE4TE/7Ejolm9ZdafAUu+rRE6q9XzhblkMBK2zAlE4FLO3AuCc9LUqAEoet4hwQ06P4ve0iNgf3qZnfJI43wJdn7pa/XE+KN+Cgr/1sXJ8TiffA3K4RCws9GhK0EQWZafKftH/8SxbuFNZu+cESWBdMkntdgV4BFmMwXM04SeDAqHRU/xaobjnu3HDdFRE4f0K/9e1LuUM/8mY3EX74kEHi7FsgM0JGyBH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(2616005)(36756003)(44832011)(2906002)(4744005)(66946007)(8676002)(66476007)(4326008)(8936002)(66556008)(53546011)(26005)(6506007)(186003)(6512007)(6666004)(31686004)(508600001)(31696002)(86362001)(316002)(6486002)(38100700002)(110136005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTRkQW00K1F2bFU1OXIzbTRXYkpwUGNqek5HZE5KNC9kSGVVa0kzTVZKVWNw?=
 =?utf-8?B?UXhGQnpGK2tDaWdRR1JnaWZpSHl3bkwwcSt6Q2Rhc2JXTWpNb0dFUDd6VDJH?=
 =?utf-8?B?Y2lrWERVUE84ZGZxUUdwYmtodkFwek1vZVc1dVBad2xMUEN0OC9RS2hpSUFj?=
 =?utf-8?B?Ti95dkZaQlZCM0VBK0EyaVFnVzM0Zmp2SGFBaFlXZ0pERmRxRHZzU2MwNmRH?=
 =?utf-8?B?ZllJVFN5UWlhd0ROUVV3eG94WlkyYzZpS3QyclBVU203N0ZQK0xOMU5IdHk2?=
 =?utf-8?B?ZUorRmVPVE9lR1ZJdWxmbStXenVYRFVPYTRDKzI1aGF0VURLeHBWTjdJSGRq?=
 =?utf-8?B?SDhkUm9tWmRaOUE1RHRlTkprWnBRLzFib0ZQRE9HeDV3Q09SbXNDNlpIeUxO?=
 =?utf-8?B?amdrUGYwUE1HeHZ2RWtGWGhDVXNCaUxzOS9maDhXUWVtQjI5K0R0NFd2bERU?=
 =?utf-8?B?ZWdKY2tJYisxdUVTczhqdkRaeUFwUW5PZVlmTXNWdWhUa2M5cVkrRzNTRzd4?=
 =?utf-8?B?MUtZYU9ZREp5Vi9Tb0ttRXBCNjVkVnkvSm9kU2ovQUI4M09telA0SnlYelRW?=
 =?utf-8?B?MzZ2Wjg3Rk5NSmlyU0M5ZlNBdTQzVEdFVjRqcWlBT2NqNmJkaStNSVExSDVX?=
 =?utf-8?B?RysycG9keEpCSVFUS1lQdHRlalhIQXRQUXlFZ05xamdIN2RTUFJ6NEVNNFgw?=
 =?utf-8?B?T0J0MFdvQXI3SktsSXhWOGpoazZYUHhDQ0RTV0s0QkhiazVrWWd2YThibm1x?=
 =?utf-8?B?Qi9nYnU1bFpHTW5ITHZDK1Q1RlRITXlhR2taWnZoMWFzcXpOczhtNWgxa2JI?=
 =?utf-8?B?MHpkZlVHOVNqczl0SEpYUUV1dzI2L3VOcy9zc29aa0o0YXE4NGkwdXhlMlF6?=
 =?utf-8?B?eW1lS0dzWFVGTXZSd1BQTDhBVXl2R21IT0V0aTNKSG4rdmx5U0Nwd25JVFMz?=
 =?utf-8?B?c0lIN014LzRsMjkxWVBTQ2FnV0IwUGRBb2FxUEhmV0VqVWJIdDROZmJ1SVZ3?=
 =?utf-8?B?cmIxSWJzK1lxZzlybzJFSmxtVEpGTjZrN21BcjdmMHYvV0xNd3RyM1BhOVIv?=
 =?utf-8?B?S2JGUWtLby96RW1kL2VBbHUyRmRUNFhQMU1LbFo3c1VFUWJ5UlcwNjNlblZw?=
 =?utf-8?B?cXFqelVpT1dLYXNmZXlKNW9VSk1yRjF1ODhGOFJsTkIyOFVoZDd0STUweGty?=
 =?utf-8?B?eTVFckNDQXYzaGlqRnRyZWRhQVphamRKZFBEMXVBcFNzL1E1K0NSMTJVMldl?=
 =?utf-8?B?emFnbEF4ZXkwZGQwUHdHWnBxSk9VdTd0dEJaaDR0YjRyVC9aNHdpdk9ITVZH?=
 =?utf-8?B?STNDZVRLK2lvYTlCTVYzbHNxRWJvK3RacHlpQzhxaVhCS3lSUjl1aWZLSEhV?=
 =?utf-8?B?akFKdWlSV3VrNE1BSFNuM3h0d3Y4MC9UYjJrZW9CWGhjY2Q3VGlNQndOTGlQ?=
 =?utf-8?B?ZnJRWGhKOXlyWFNSUFU4VWVMdkJUUEZBenNQYWlTSGtHeWZWeUsvV2xScDA5?=
 =?utf-8?B?dDBUVWxDN1NmdmFyMXhiRVV2ZFJ2MHNST3g4ajNDdEtPRkJyRjVEYzIzQ2hy?=
 =?utf-8?B?VXhNSGxidDVFdFR3eC81UitjOTdjekN4b3p0clNXaEZjUnYvK2VYbE9YeFNz?=
 =?utf-8?B?NVRlQldla0RFZXZTYXB3ck94WGkyTDFTZ0JPbTIyZ0p2TTlxaWJHU1Y2Wlov?=
 =?utf-8?B?Nk5VZU14N0IvTGJyOUx2K3U3RzlSazlTc3dKRFoydnZXMllJb04rNDNLRnho?=
 =?utf-8?B?eFBWSk1IWmVVYjZOSWc0OHZMME1pSWhtN2xnUEdJbTJ2akRJUXZPRWxUbmJB?=
 =?utf-8?B?TGF1SEF2V0IrVGt2RjlaNlBJNWFxWFMrbDNyekxmMVpPVDhSVkRuYUQ4bmZY?=
 =?utf-8?B?ZklTWVR6TDRZNVhuRnAzZHB3RlN5M210eldYTDFaUFdwT25CSEJsamIrdXZw?=
 =?utf-8?Q?8wbsBkWUzuxbNmjFatcgY65ub74eVaRf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b985204-63aa-42c9-1df9-08da067bc9ab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 12:03:16.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/Gdn79LVbS0Wb83niCqh8+xNeXFiLdXHZgJ+YfiUFJVbiSiXHq5E+8fQdd3YQFHg7+8GVDv+4SAqBzZD3d3PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5360
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150079
X-Proofpoint-GUID: kbD4x0lW-la5E6EilAF8w8D0Nf1gcSgW
X-Proofpoint-ORIG-GUID: kbD4x0lW-la5E6EilAF8w8D0Nf1gcSgW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/03/2022 02:55, David Sterba wrote:
> On Mon, Mar 14, 2022 at 07:16:47AM -0700, Johannes Thumshirn wrote:
>> Anand pointed out, that instead of using the rcu locked version of
>> fs_devices->device_list we cab use fs_devices->alloc_list, prrotected by
>> the chunk_mutex to traverse the list of active deviices in
>> btrfs_can_activate_zone().
> 
> Why?

We are in the chunk allocation thread. The newer chunk allocation
happens from the devices in the fs_device->alloc_list protected by
the chunk_mutex.

  btrfs_create_chunk()
    lockdep_assert_held(&info->chunk_mutex);
    gather_device_info
     list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {

Also, a device reappeared after the mount won't join the alloc_list yet
and, it will be in the dev_list, which we don't want to consider in the
context of the chunk alloc.

Thanks, Anand
