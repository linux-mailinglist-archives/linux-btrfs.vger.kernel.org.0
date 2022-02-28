Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03214C653A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 10:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiB1JDW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 04:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiB1JC4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 04:02:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2339866638
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 01:02:15 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21S6sMJZ025481;
        Mon, 28 Feb 2022 09:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=O7Yyqp/zJpHOBebTcXqNj8fV5p0wSMNBnLMKwC4zohc=;
 b=SBXv4qeMopGBz8J1C2sXOefIHv3juCKbb26AbnxwZwt8sWc+C/fc6wJGHx/H6neJVaKz
 ar6Wp0Cbz9DonFXzHUE23b6wlzQm0quE/aPyrxmC3ERMfR/EOcvTxPwuBizdEVUU+jwV
 XZ1Eja7sFKpKsDAYAMMsEIwaaIFxVm6czPYSiM97i+C6OJxNjdaPG9CQJw17yutb/foF
 Oad0HLgEwVDNDkCihxUxrhFp6hdMfbDjP9vmOqIi153UGUbtNg/r35pbJ0O/F1gisyUw
 UT7DiTgCpJRG1KZQIt3cQ2z1KQHmj1xUbs0V/05dGhTbelLjI4OI13qb+LXuQ7p8PxoW pA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efcrtberh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 09:02:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S8tt4k069726;
        Mon, 28 Feb 2022 09:02:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by userp3030.oracle.com with ESMTP id 3ef9av4e5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 09:02:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJm8S87NrJmsFKkK9c+VunIHFgRnJHu/iDFRtWf9NghQC1y47qjAgGvLSziVSog+DOlLTzrCmqw8jnCF4XyUPSMrcDAJHd4BWmZ809Vle+ZSoxYyoEEBfVyRepJjWF0i6wv3Kg7zkkl4qPbDzeSrZwSA+PGuSd08C4auvyaFcoZO6lUtgX4lNRBEWoUS+DgT7MQjYLkBMGIa33AiKJ6uVkIuMPegrv8tyOxdLeVQ/l9GN1NK4QrUVjRP4m9Zi0Hx1vTxecZGm0GB+oQsumPWvgCPkXR/yQMZn5MpZzoQubbfRK+lnp39m6er+fTR3pIrYFf3hYKI/43a+/bBjB5lvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7Yyqp/zJpHOBebTcXqNj8fV5p0wSMNBnLMKwC4zohc=;
 b=Z3gF6Y8LWUfoieetzUAgfjQskKrkXLF/CPCTBG9WGNtXZONSBdIFGK9/tIA3DGp3yPVSNG+ZMR6BkAk6yc2TZ1SbOJGz5f9GddCR6pHWY8fL+z78+WOAXDXpnZaRxptPipnJ/yZiFuXCZZYFmd3yNkSFRDHPcnYyl+iPD1lKsrPpCx1dWn3Y49rPeEXb5RYsacyDrHsej+53amKSrQFjR3D2iphqVOHanGc2ziCm0BB3jQJges+3usoa444UHjBYBCLe3/ZabResv0lpKkYu59OXFkxhQFt/brEZAUiZfNnT8c6LdxbkQxAsWKWduu5peDH/fDodyIVZdfR0devr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7Yyqp/zJpHOBebTcXqNj8fV5p0wSMNBnLMKwC4zohc=;
 b=OMwS4lenGx5nCPqKLBmxIz5XpA8H9aNK/7xBdax4uoZbrXVoc78XhsL7QyDFxyiNC+H8a7crOvAM5Dgr6totXcR45UHA+I1uK7GQfw07sjIjaDhFr2IxZ9ujlD8rXlHmHLx2A1h9PriNYAzfCX2VKBM8y2bfNanJ54/BmMRwJr8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4862.namprd10.prod.outlook.com (2603:10b6:5:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 09:02:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%5]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 09:02:02 +0000
Message-ID: <82df81f6-74a1-b77d-c4e9-48d20ab1bd68@oracle.com>
Date:   Mon, 28 Feb 2022 17:01:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] btrfs: repair super block num_devices automatically
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>
References: <732d0a86c3624bc96df3cca05512edac40efc75d.1646031785.git.wqu@suse.com>
 <ebdb0e67-0e9e-4ca6-1d2e-4dd2a7a7c103@oracle.com>
 <a6923955-00f9-d739-c70a-3beace0b85e1@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a6923955-00f9-d739-c70a-3beace0b85e1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c33f5dd3-3cdb-4451-06d1-08d9fa98fc35
X-MS-TrafficTypeDiagnostic: DS7PR10MB4862:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB4862C10B5936FE9816513D47E5019@DS7PR10MB4862.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AIv2PIbHGDlEDOxlLBT9aDTwQYK4yTklGfTs0ted29Wu4QWyx3klK3zyk/cKN3I8sHqsmBHd3hgO+JjrcXD+EW8APoZ2Dp5JUH9afID7mZveAtWXiiP/BMAWC1O4vIufWaNJefybQMT+MByMwzhwNKQH5Z7ojXNSQfQgvbLTySgwEimbzVjBpEFiPUNREXwhMbTqt5+HKtGdOP6GehAB71+D/xrzKOCHLFEXKMHUnaHYIYRtQCmynflhZNucAekDNA8OVy57sDWTewrMDG/8BkhjopHTiiGxiMftMgfUMdv2AHa11cnL7mX2n7CFlZwx+v1iAA1hTgjuCgnhkcvJjMUvNRpcmZUa3Ax87swMtrTPBg/UE1NALxqyGmZK8wOseVto3LZu0PLnxi7y2TJS2lt2+sGENh1oj/GqxpA3jyfz0UXljk6/AWK7CXzRCQtBY0AT7Uhdf644Z8rfGQLgKqsbht7JxUUNDOJuNKyCygM7ssdy+pOKo0uK2LdKbtQFEGOGv+czkmP2S1odBPg/GiqSXzrPlBxKF9IK3ED63r2fF3XZQJjj3/jMF64XmWRqvVZ4wqAoUFI/kKlunma3xO7IFGgpYgZ8USQzPGn1M/iJUPU9hM7SaPhCRfLL1IxbjSTO3MgrARnTM8dVO5WQOKriPSU7UnnfwJRwS/ua5DzOVs4aKYA/Fmcb6aTOKTWEGqL6lP9o2njJmfiKAyN0W6RsUPiZBx9X59Q9M92kJmaF3nF+HCX2d+khMCsTt31aqB9FkIOZhH+ve+CMy+qFdcL6Eb1eqqtNDAMym5Kxe28SlUOlyODrsgTPUYRepsD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(83380400001)(8936002)(31696002)(36756003)(966005)(31686004)(6486002)(66574015)(316002)(508600001)(44832011)(4326008)(2906002)(2616005)(66556008)(8676002)(6506007)(53546011)(66946007)(86362001)(26005)(6666004)(186003)(38100700002)(5660300002)(6512007)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDg5WlhXZUhEaFZ1T3FGOGVuOVNtQjBFcXU5MUdpNFB2dlpncTRTYXVRRkNj?=
 =?utf-8?B?SU9sNklJVnJpRVQybDFmam1TcytaREZiRk5hU1hTTHNXUGgyTzVwM2UxNGcy?=
 =?utf-8?B?RUc0R0dzWFNINnJsaWpKdy9sS0Q0eXBpR3N0aSsxQ3hReUFpRFBIUEY1bE5m?=
 =?utf-8?B?WVpwQ2FwcS9lV1hMVm1XS1NoVzhMRUlmS1JSa1lHYTJ0SVpIK3RJeXRXNlQ5?=
 =?utf-8?B?eWhSNnJ2Mk01eU1BU1dKY2Z5MnVYVDAzbVZZeVFaZ1VQVDdSN3BpeFk4R2Rs?=
 =?utf-8?B?Z1dQRzBia3FoekZ0NTA2dWpMRVNIcWtwTGlHdWgrOU44M0QvYUlJUVppbyt3?=
 =?utf-8?B?dUR1UTBzNzFLREoxY2FFNGdqTU9VOGtsa1ZSMnlSdHNHMmlTL1V4N2ZLaHNl?=
 =?utf-8?B?RkJNdmZEWXBPVWlkU09kSFdvVW5Qa1l4eDhiMUt1OHFSQXVETWhSSUR0SENa?=
 =?utf-8?B?Ukd1cm13QndCYUhyTmxlTnRiZjJkUHUvZjFjWXBHZ3Q1MVFzSDFPcndqNDNM?=
 =?utf-8?B?aGJMUHBYZExxTWJmWVZidHErV2hHdkkwQXVwYUJubVAzV3RYS3BQdnBpK0VL?=
 =?utf-8?B?V0NvejdJL3FvTXZEVDVtSWtqY3NOa25FREVMa0IrSXhuZFJtZGNCdTIzSVQ2?=
 =?utf-8?B?Sno2aE9EdWM5THdnSWlhaWs2c0plQVQweUFncnk5Z1ZuME9KUkZpNVFKbDhu?=
 =?utf-8?B?bXRpWEQrdXpGQUM5SEZvcXVzQ1VQWjVPQk92TFllYUMwZnl2Z2I2NWZGSHI5?=
 =?utf-8?B?QVYrQ2YxdDZSeHZwVlpEdlp4NXBrRW5rUzNUdk1OdXhIVHhuaUN1WVZBZjlS?=
 =?utf-8?B?cnBlSmFtd1g4MTQ3TkdwVCt0TU1sNWtxN0FMbzRmYWNzbGF5ZWxkcFpoRy9C?=
 =?utf-8?B?K1Q0SjVKYjlOYnozVlVVUkFEV3dDdlJKdVNYU2dwVXYxS21oOEF2Vkp3VVFU?=
 =?utf-8?B?ZWI5T0FQdGk4US8rRy9nUllEYWhUQVlNWXNEVll4NWh1VGdsVGJOaUlHbEw2?=
 =?utf-8?B?L0lQQ3cwbzd3ZkgwTHl3K0ljYVNzZzE4SExxVUl3Yll3SnNvLzc2MWRPeVM5?=
 =?utf-8?B?eVp1ZHRqODVxbDdreEFwMWhub0k0STJFTnJ4VHNtNG1wL1ZZeFdOZFhMVDFj?=
 =?utf-8?B?MVhUYnFhZUFmNXdmZkZtNWRlakMyVzNaMnB1MDNpWTFwcUlaTVA0QUlYYXhE?=
 =?utf-8?B?NGprdzdvbWwvNzgyNnA3T3NxWElqdzQyRlJyZDZ5ZUM1TVJ1U0gyMFgyOWhJ?=
 =?utf-8?B?TDI5bUNINEs3alo2UHp5bFBHbjZueUU5NWFhRDVuNm9DcHR4WjhmUzd3YS8r?=
 =?utf-8?B?NENhREh0U3dMVHB5ZXZwTG1kTng5TTZ0K28rZUw1Wkd0Q1NYbHVrSGFkeG80?=
 =?utf-8?B?VE0zbWtNcjVNYVZ0czFoTGpzRUcrTFBQQ2c0NHByZE1hWTY0ZWdnbGthVFVy?=
 =?utf-8?B?ZWxiMzBReElLSlE1WmRPWEpkaWx5U1Q4MWViUzNpeFI5MVVUNXl0RDBrUVlv?=
 =?utf-8?B?MUIvUURqL0xGbGhnL3V6VUVxUmo2dGg1Wit6QnB6SG9pWFdkZi9WdThnYW16?=
 =?utf-8?B?cjgrQXArdU9xWFRjVGMxK3U2ZGJ5NkQzYlE0L2l4TENxZ29BWFYvT25qaTFR?=
 =?utf-8?B?UDh4b1R2dElHcXl0RHJuUkZQZ1hyMEFNRXArU3VwZlp3bVlmandmUVp5dG5u?=
 =?utf-8?B?SlFkT1Qzc0tKN3g4UWY1ekZnbVJtcVpMMWJ5V3pFcmNFYmhBY3loeHpqMHBr?=
 =?utf-8?B?QmxMUEJ4a05BaG5LUmZGZCt6eDhYT0ZhdG1YbnFlWVc5ZmFIaWEwTjNDWWJs?=
 =?utf-8?B?a2ptazdOanlUcVZzQmxoNmVJYmpaVlBnS1NiQXcvYTRnRFI5NFJtSTI3SStN?=
 =?utf-8?B?VmlMdjQ0aW5QMWZJd2h0eTZ2eVdLRURnemcxMS9aSWpuMllXQ1pnWE0rRFY2?=
 =?utf-8?B?Z2tTck5tQlcyRFJHd0RNdFVzeXNxTWZ1dHYzeThFSzJWd3B6RStzL3VTVmlR?=
 =?utf-8?B?dWkzYXB1MnFiejVWb2U0UzRIcFVmd0V2NG1PczkrNzg0Y05mWUxPOHp3TkN5?=
 =?utf-8?B?V0Jham8xRFF5TEVSZW9jOUZlQ3h0VlhvemUyc0pPcmpGMnR0T0dkbUpQSVk3?=
 =?utf-8?B?OTEzMThYcXdGZHNKZEhyUEZHWi9GMmVjaHpqL1RpSHFiUlBtMDhnU3Q0cDg4?=
 =?utf-8?Q?iP3rs9xFDlXsbWHBDVK4WrQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33f5dd3-3cdb-4451-06d1-08d9fa98fc35
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 09:02:02.9191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGbVyiNLw1yVdBYrc6qXSQT0amPo0U8cC/i8auA2Nkd3QIaV+yNuIB4gQlyUXlT2FrFE40xRrUQO0VFUr3Qglg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4862
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280050
X-Proofpoint-GUID: Rm9P4tDXVnG5s_r1cnYDP1wlPea5R39Q
X-Proofpoint-ORIG-GUID: Rm9P4tDXVnG5s_r1cnYDP1wlPea5R39Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/02/2022 16:54, Qu Wenruo wrote:
> 
> 
> On 2022/2/28 16:00, Anand Jain wrote:
>> On 28/02/2022 15:05, Qu Wenruo wrote:
>>> [BUG]
>>> There is a report that a btrfs has a bad super block num devices.
>>>
>>> This makes btrfs to reject the fs completely.
>>>
>>>    BTRFS error (device sdd3): super_num_devices 3 mismatch with
>>> num_devices 2 found here
>>>    BTRFS error (device sdd3): failed to read chunk tree: -22
>>>    BTRFS error (device sdd3): open_ctree failed
>>>
>>> [CAUSE]
>>> During btrfs device removal, chunk tree and super block num devs are
>>> updated in two different transactions:
>>>
>>>    btrfs_rm_device()
>>>    |- btrfs_rm_dev_item(device)
>>>    |  |- trans = btrfs_start_transaction()
>>>    |  |  Now we got transaction X
>>>    |  |
>>>    |  |- btrfs_del_item()
>>>    |  |  Now device item is removed from chunk tree
>>>    |  |
>>>    |  |- btrfs_commit_transaction()
>>>    |     Transaction X got committed, super num devs untouched,
>>>    |     but device item removed from chunk tree.
>>>    |     (AKA, super num devs is already incorrect)
>>>    |
>>>    |- cur_devices->num_devices--;
>>>    |- cur_devices->total_devices--;
>>>    |- btrfs_set_super_num_devices()
>>>       All those operations are not in transaction X, thus it will
>>>       only be written back to disk in next transaction.
>>>
>>> So after the transaction X in btrfs_rm_dev_item() committed, but before
>>> transaction X+1 (which can be minutes away), a power loss happen, then
>>> we got the super num mismatch.
>>>
>>


>> The cause part is much better now. So why not also update the super
>> num_devices in the same transaction?
> 
> A lot of other things like total_rw_bytes.
> 
> Not to mention, even we got a fix, it will be another patch.
> 
> Since the handling of such mismatch is needed to handle older kernels
> anyway.

  Ok.


>>> [FIX]
>>> Make the super_num_devices check less strict, converting it from a hard
>>> error to a warning, and reset the value to a correct one for the current
>>> or next transaction commitment.
>>
>> So that we can leave the part where we identify and report num_devices
>> miss-match as it is.
> 
> I didn't get your point.
> What do you want to get from this patch?
> 
> Isn't this already the behavior of this patch?

  Let me clarify - we don't need this patch if we fix the actual bug as 
above. IMO.

>>
>> Thanks, Anand
>>
>>
>>> Reported-by: Luca Béla Palkovics <luca.bela.palkovics@gmail.com>
>>> Link:
>>> https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/ 
>>>
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Add a proper reason on why this mismatch can happen
>>>    No code change.
>>> ---
>>>   fs/btrfs/volumes.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 74c8024d8f96..d0ba3ff21920 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info
>>> *fs_info)
>>>        * do another round of validation checks.
>>>        */
>>>       if (total_dev != fs_info->fs_devices->total_devices) {
>>> -        btrfs_err(fs_info,
>>> -       "super_num_devices %llu mismatch with num_devices %llu found
>>> here",
>>> +        btrfs_warn(fs_info,
>>> +       "super_num_devices %llu mismatch with num_devices %llu found
>>> here, will be repaired on next transaction commitment",
>>>                 btrfs_super_num_devices(fs_info->super_copy),
>>>                 total_dev);
>>> -        ret = -EINVAL;
>>> -        goto error;
>>> +        fs_info->fs_devices->total_devices = total_dev;
>>> +        btrfs_set_super_num_devices(fs_info->super_copy, total_dev);
>>>       }
>>>       if (btrfs_super_total_bytes(fs_info->super_copy) <
>>>           fs_info->fs_devices->total_rw_bytes) {
>>

