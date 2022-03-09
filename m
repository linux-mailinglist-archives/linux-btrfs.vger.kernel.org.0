Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646364D2798
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 05:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiCICN5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 21:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiCICN4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 21:13:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1B2B2D
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 18:12:59 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228M8nCa021322;
        Wed, 9 Mar 2022 02:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YqpSa3krbWudrEVspLpqYdhiJJSC3PWo8KOvItGdHpo=;
 b=hPL/PeIeWjgntH/jehRG1vDoJgtXRIJ5Nz20ifLmjxiYEG4AGE/8OI4S2AFmKYZ1WPjl
 MgpbggXr7uqyLduVVCEOkwXWTRl4m738uZ9nG0kbPusT2FAek5o2yp9dTkOWVzOSoS2c
 WEVOeCF10UEM1S9OyGc2xCxJttSx+y4vxFXaU611smCblYM0K7MNpmOwY0RtLWk44jKo
 xzb9Ie6lIZsGe7tuzx3oISLPBg9JKzQ10pNa3R9fDwP/pOHYPWiykE5E10nGS3rSgVnn
 0imM3Y/QZaJaQXUn3xsFiSzrzEhMBAi2YgLKWG1MnS7YJwcXj3peqzdZNipaDgKyBKtS WA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyfsgp6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 02:12:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2292AUWD136457;
        Wed, 9 Mar 2022 02:12:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 3ekvyvemmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 02:12:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpMW2LpXX7DHh1cX9skgYLWsCnFAX/lP3Pm13OTmwomyAOELrUi2uioLcTCdNrwWThYay8i+TLf2AYhMeejjnpj1xFJvErkRD5MI/LI61paSWPzIdAKjGqBJJ2RhNbA1BeNoF+BTXBj19nc613kfO8HiID0eyXqaRXyNd/w5NnbwnaXmIg1w9VwNk+cCfsu/h1SE+zxCnkDPyJ6Ddfq3KCjnUo3asBjdUT3aa3SaBh96AyT3L9JZ/a6h0Lo3lj6np0+toNob/6EWHIrvoQ7CtW1ngWHnMDwRbaAdGRESzRFyMQp1EUmy0YOAaR8WFqxUPXChAeX4JGWxm6r2in7DkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqpSa3krbWudrEVspLpqYdhiJJSC3PWo8KOvItGdHpo=;
 b=oDSZjGzp+hn85/PUO3R1XEMC+HfsJo0xhkVMQEnfW/y6sCSs25ibqmjm8wKcElAQAvJYPaz0PbvuWKur0iUB3n6LG5hrrpMA/ujkKJXBYTGtvqqkcDIp8blb6pfbALhvgzXHKuXg2tNvl9y56b29+g3LTE+SucN9MaOnARIkYHxpqQTZtp1CvLfsLRoGEKGviG/rqVO0ZGp1O/SulRcg/xI1LdBzOR9y8rPFmKA74RlHIw6RA9QDJnIk8RtyzXN6UkJOJWssfSKsXuj8kqh9Jg2J+LJ3sV69zWHmw9cX7GTFJJrmtjGwPBRe0jC+GX7OOJnFTg6f5K8pJlz5eRhr3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqpSa3krbWudrEVspLpqYdhiJJSC3PWo8KOvItGdHpo=;
 b=KUqiBGfrluF4IrK1FAVJjJo/farya+M20aeM8eTSIVd0xM07K3ke3R4Lsy1WcNSD5wrJjwei6CjEUZoPQaRMHIQvZa51dUnr8lEEB7iRLtjCrQRVzapKgU7UfvEX8D/SPtEywTGqos76AqkxMWMJodgr/55ZltLGfjnStu83LBY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB3786.namprd10.prod.outlook.com (2603:10b6:5:1fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 02:12:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 02:12:51 +0000
Message-ID: <760da013-f15b-805f-ceaa-c8be838eb9ff@oracle.com>
Date:   Wed, 9 Mar 2022 10:12:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] btrfs: make device item removal and super block num
 devices update happen in the same transaction
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>
References: <b86647c31a09ccc44447367865ecac8d5b358b7c.1646717720.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <b86647c31a09ccc44447367865ecac8d5b358b7c.1646717720.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36ceb743-95ac-47ba-d751-08da01724ff4
X-MS-TrafficTypeDiagnostic: DM6PR10MB3786:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB37865879FC7B44F6A13D58ACE50A9@DM6PR10MB3786.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2UT9IRtbLQQOy3zO0xAm6LgsExVSoik28DCD5zetCy9d5hD4B+1koBlPCaQZe1zAacGwFrJPJGgL1wj8kM0PRYGgdowPjK/TL/P40XjgJxyhykzHdn30uzfkobZl+sE9EQUje14z2+ZukFTx+K1LzHYFi9KKIQyswujTVct0EePU7OE4owt4syU50vn5OZ4/o1x1e1/7cYbE+7nZRE8RHyOTEh42X0W4hD22l+jGi4GzRZDiSYHcjUqy7N0qml79EvcVbGri+f+szZF1MPoRhtegpLj6sCY50hLifLuyMjP32LOU+Bqse7lIED3hKmUVw48Nd0n1n7hjLs7X2bYknsED3hN8fzOuwAw6tT2Hl+9EIz8BISKVMfE58v9nGJa++wAY/jq2zl9gOQnWq6QtsWobn8XJfQDOddmCkO8NIwmjX0G3FMR9ZL9IGLfOn6YN9VkUW5IztaHrF9UfGZZIhbd3nfmgOuts6sZzjX7HxsjyLlv9u2opI2OC3yZ9OxaB3YgXHu0x+ajceUqilMBwQdXKv6JOpema+5y9Whgqwbjh+v4fS2f0PfOrSnPG29hNfhhYLfBv9pQF+eBH0OFaFdk6vHtFgE0joOAwEntQ61/FhhsGQDh4WF8r5JgteLx6bbERtmZMQAl1l5Vbohvy8J8E5axTGS6E2SO/qLnnmoIf54qbxBn0nF0dw4UsV5tmNAsfN2RaDE5I1o2ZPh+zXc/PnRaWU9XHdrlCn0TNm+QiYTGYDztCqXOe19j0y2dj5WqQwy3RnNt8jzkP6pfV2g/P2eIRwR0MEZ8DejYQDtfzzLWBQvr//X8zfID9XY1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(316002)(6506007)(44832011)(15650500001)(86362001)(31696002)(966005)(6666004)(2616005)(36756003)(186003)(26005)(83380400001)(31686004)(66574015)(6512007)(53546011)(66556008)(4326008)(66946007)(66476007)(38100700002)(8676002)(2906002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0dta081ZzJGMG1ya1ExZi9ndzZUeWwvRGhsRUtSaWNmRUhkTnczbEJsTHg0?=
 =?utf-8?B?b0g1ays1b2pWUUFuSGZYM3prSDdWa0hrYnFhNXI3aUF2OWV6VitUVGhGMm5I?=
 =?utf-8?B?SGxXWC9yd3BwQVQ4VnNLOG50TnJlTmxsRE1kSmRwRUxvU251cWREbGtLVlZM?=
 =?utf-8?B?SDFxb1BqaWxqcUk5Ny81MlpPZkdTS1NXdEowVzBDVGxybVJPVFl1WTdoYjEw?=
 =?utf-8?B?enI4WGRhb0lOQXk2QlovMFdtZzI0K0orL3dGZ0RWaWpsaDN4RzNrU0ZBT25P?=
 =?utf-8?B?Z0xMQ1dQZ1p1RUtBM1FOeWJBc1JhVGVGaHQ1UTUwamR6UGQ3NFRnbnpxd1dF?=
 =?utf-8?B?NmJYTXd2VW5ZekNhbFMycnkvejVDRXJ6Snp4V3lDcExJRnN5ZXpRY2FsRVVU?=
 =?utf-8?B?T2dIVVBXNEZxcmc5ZWxCRFAyUnpRc056WE5NRlU4R013WFowdnNLaHFmcnZP?=
 =?utf-8?B?OUZUVGVlQzd6NHVuZjVBWVBzYlAvdXJTcCs3Y09qYklFVWltLzFFemVlSTNt?=
 =?utf-8?B?dTdZZkRhUGZtZ3dSOXNIY05IQ1hJcDh3SHRjbHFxbWFDckxCOVVoZ1YzTkFQ?=
 =?utf-8?B?OUhMM1hNQjRiNXQvQnQxanJEd1piY3MvZENXR2VmbnFtcVZiREllTWNKOUpi?=
 =?utf-8?B?a3ZpT2daVVppeGRtWS8rUi9qRkg1aURPbnliRlVCL0FTWms2WVBUMExCTWhG?=
 =?utf-8?B?eUNqSVdSbHFIVXBHeWIwOThKcDVrcnJQaE5KdThHZHJNVE1pZWNFSUlwY1h2?=
 =?utf-8?B?YlpYUGtHWkZrbU9xS3dFY29lT3ZHS1VTTEFnUGlQcmF6bXU5VElBYnhLU284?=
 =?utf-8?B?T3c3dVVNWTZsWTlpYlludXJxZ2ZvYVFtRmxuS29SWFhPNm5nc2QzZ0JIZFhD?=
 =?utf-8?B?c0NzNUY3S3JMU21XTmFMREZhTGhNYll1SkgyRHg1aXVCb0lqOVRQS2Q3Mndh?=
 =?utf-8?B?TXlJR0dxV1dkUFRaT0dwN3c3MGcyVE5OZytqM01HRnZJYkdaOUF0b2wrQ3pw?=
 =?utf-8?B?dlE0WE43YmdhL3gvcGd6ajNqeCtTajZ4bmNoT05BNE9NQlVRbzJSaWgxREgz?=
 =?utf-8?B?dkluQlVqOCtONy9KVlEzVzBjM0JSN0JKUDZ6ZWU2YjcwTTNTMlhrdlpJdlFi?=
 =?utf-8?B?cUtpY2d3ajN3MFpybHRQalZRY1FCOWljbm9Ud0hidFFid3hFUitOL3BSeXoy?=
 =?utf-8?B?bVVYbkRQMitZZkU2ZnR4cEs4a1RJSHVZYjRKUXUvd29IbVVkZDltYUZqRy9u?=
 =?utf-8?B?K0NHalFoY0w2Z1NLb0dmOEx4T3lEZnZNSmo5QWhaSllLY0dVeFBLbkF1aEs4?=
 =?utf-8?B?SXN2MCtGZCsyNWJoOTB1Rit1cTNsa0JpeGpzYkRldzBsYjIybkJMTTZKTHZL?=
 =?utf-8?B?Wm9GK2tUeWN6bHFuYnloenZRcFZBTXcwYkdQUkRxR0JrZFZXMnVLTXlCTnpM?=
 =?utf-8?B?ODNHSVM1WGdmTjNBQm0vcTIwdms4eTEySkZlSzMxWG1uSXhiamVTVjZuYW44?=
 =?utf-8?B?KzdHOWIzV2lPL0s0QTlHWEtWT0pkVEJoY1JpWjVzdFI4ZEtQTjF5aFp1ZWJi?=
 =?utf-8?B?NGdlQzN6clJ5NE1HWTQ1eEZxMlJQNE54VHBEenZlOW5XQ2hac25oSFUyUkVQ?=
 =?utf-8?B?c2pYdWg5YmN6eEVkYmVmSkxNdVdiN0U0a0Y3SE5mZUJkSDBEcnc1Mk5LKzAx?=
 =?utf-8?B?b09FRXVXd1hHVEE0SnlYTHA4VE5TNHArUmpCN3daTEVROHprbVZrV3loN3pD?=
 =?utf-8?B?MVc0SUpJVnhMak90TGhkVTEzeWlDQ3dmcVhUek9lQytTak41bFVWejFPak8w?=
 =?utf-8?B?czNzZ2gzd2hqMzA1T2w1Z3NjS3BJeG4rLzhsbThOYjRzQnY3NjRnSHY3R2xL?=
 =?utf-8?B?MDJEMUV0cHVrSGhtR2tFVDZkMlBpazlrbVlWb0tDbnRqellYa0hnamUxTloy?=
 =?utf-8?B?aUJKUktsaW9BbFhXRGZTTERxZFFWZnVsWHBLSUtFVUtVUlJuejVRdGw2Ungr?=
 =?utf-8?B?QnpWY3owQ3pFN1oxaExsZzkzSDNoK3hxTldFaElnaW9SY3RKLyt0Q0x0ZGpE?=
 =?utf-8?B?bDV5L1ZzVm9tNUZMVHVvWWtqSFVMZlNtV0p3ZEhWM1c4bnVGQTg4K2tDSy80?=
 =?utf-8?B?NWE1Rnd5N1ZGbCszd0J4eUhXakVmUUxNRi9OUWNkUkk0TDlUTHRnYSsvaGhF?=
 =?utf-8?Q?YWVpYa+p9cJQj/bndMLNWJ8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ceb743-95ac-47ba-d751-08da01724ff4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 02:12:51.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suHVKoD1H3WfVh9jVFgiWdlceHEDRyG2Vwv/Gj4ECe9ehwc/k/CC1CxZGs6mYSvVyfC7DsxyDVoy73aTxcalbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3786
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090010
X-Proofpoint-GUID: xumgzPV2IPpN2ikyAfGVqJh04zVBwP7q
X-Proofpoint-ORIG-GUID: xumgzPV2IPpN2ikyAfGVqJh04zVBwP7q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/03/2022 13:36, Qu Wenruo wrote:
> [BUG]
> There is a report that a btrfs has a bad super block num devices.
> 
> This makes btrfs to reject the fs completely.
> 
>    BTRFS error (device sdd3): super_num_devices 3 mismatch with num_devices 2 found here
>    BTRFS error (device sdd3): failed to read chunk tree: -22
>    BTRFS error (device sdd3): open_ctree failed
> 
> [CAUSE]
> During btrfs device removal, chunk tree and super block num devs are
> updated in two different transactions:
> 
>    btrfs_rm_device()
>    |- btrfs_rm_dev_item(device)
>    |  |- trans = btrfs_start_transaction()
>    |  |  Now we got transaction X
>    |  |
>    |  |- btrfs_del_item()
>    |  |  Now device item is removed from chunk tree
>    |  |
>    |  |- btrfs_commit_transaction()
>    |     Transaction X got committed, super num devs untouched,
>    |     but device item removed from chunk tree.
>    |     (AKA, super num devs is already incorrect)
>    |
>    |- cur_devices->num_devices--;
>    |- cur_devices->total_devices--;
>    |- btrfs_set_super_num_devices()
>       All those operations are not in transaction X, thus it will
>       only be written back to disk in next transaction.
> 
> So after the transaction X in btrfs_rm_dev_item() committed, but before
> transaction X+1 (which can be minutes away), a power loss happen, then
> we got the super num mismatch.
> 
> [FIX]
> Instead of starting and committing a transaction inside
> btrfs_rm_dev_item(), start a transaction in side btrfs_rm_device() and
> pass it to btrfs_rm_dev_item().
> 
> And only commit the transaction after everything is done.
>  > Reported-by: Luca Béla Palkovics <luca.bela.palkovics@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/volumes.c | 65 ++++++++++++++++++++--------------------------
>   1 file changed, 28 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 57a754b33f10..6115c302f4ae 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1896,23 +1896,18 @@ static void update_dev_time(const char *device_path)
>   	path_put(&path);
>   }
>   
> -static int btrfs_rm_dev_item(struct btrfs_device *device)
> +static int btrfs_rm_dev_item(struct btrfs_trans_handle *trans,
> +			     struct btrfs_device *device)
>   {
>   	struct btrfs_root *root = device->fs_info->chunk_root;
>   	int ret;
>   	struct btrfs_path *path;
>   	struct btrfs_key key;
> -	struct btrfs_trans_handle *trans;
>   
>   	path = btrfs_alloc_path();
>   	if (!path)
>   		return -ENOMEM;
>   
> -	trans = btrfs_start_transaction(root, 0);
> -	if (IS_ERR(trans)) {
> -		btrfs_free_path(path);
> -		return PTR_ERR(trans);
> -	}
>   	key.objectid = BTRFS_DEV_ITEMS_OBJECTID;
>   	key.type = BTRFS_DEV_ITEM_KEY;
>   	key.offset = device->devid;
> @@ -1923,21 +1918,12 @@ static int btrfs_rm_dev_item(struct btrfs_device *device)
>   	if (ret) {
>   		if (ret > 0)
>   			ret = -ENOENT;
> -		btrfs_abort_transaction(trans, ret);
> -		btrfs_end_transaction(trans);
>   		goto out;
>   	}
>   
>   	ret = btrfs_del_item(trans, root, path);
> -	if (ret) {
> -		btrfs_abort_transaction(trans, ret);
> -		btrfs_end_transaction(trans);
> -	}
> -
>   out:
>   	btrfs_free_path(path);
> -	if (!ret)
> -		ret = btrfs_commit_transaction(trans);
>   	return ret;
>   }
>   
> @@ -2078,6 +2064,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>   		    struct btrfs_dev_lookup_args *args,
>   		    struct block_device **bdev, fmode_t *mode)
>   {
> +	struct btrfs_trans_handle *trans;
>   	struct btrfs_device *device;
>   	struct btrfs_fs_devices *cur_devices;
>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> @@ -2098,7 +2085,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>   
>   	ret = btrfs_check_raid_min_devices(fs_info, num_devices - 1);
>   	if (ret)
> -		goto out;
> +		return ret;
>   
>   	device = btrfs_find_device(fs_info->fs_devices, args);
>   	if (!device) {
> @@ -2106,27 +2093,22 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>   			ret = BTRFS_ERROR_DEV_MISSING_NOT_FOUND;
>   		else
>   			ret = -ENOENT;
> -		goto out;
> +		return ret;
>   	}
>   
>   	if (btrfs_pinned_by_swapfile(fs_info, device)) {
>   		btrfs_warn_in_rcu(fs_info,
>   		  "cannot remove device %s (devid %llu) due to active swapfile",
>   				  rcu_str_deref(device->name), device->devid);
> -		ret = -ETXTBSY;
> -		goto out;
> +		return -ETXTBSY;
>   	}
>   
> -	if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
> -		ret = BTRFS_ERROR_DEV_TGT_REPLACE;
> -		goto out;
> -	}
> +	if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
> +		return BTRFS_ERROR_DEV_TGT_REPLACE;
>   
>   	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
> -	    fs_info->fs_devices->rw_devices == 1) {
> -		ret = BTRFS_ERROR_DEV_ONLY_WRITABLE;
> -		goto out;
> -	}
> +	    fs_info->fs_devices->rw_devices == 1)
> +		return BTRFS_ERROR_DEV_ONLY_WRITABLE;
>   
>   	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>   		mutex_lock(&fs_info->chunk_mutex);
> @@ -2139,14 +2121,22 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>   	if (ret)
>   		goto error_undo;
>   
> -	/*
> -	 * TODO: the superblock still includes this device in its num_devices
> -	 * counter although write_all_supers() is not locked out. This
> -	 * could give a filesystem state which requires a degraded mount.
> -	 */
> -	ret = btrfs_rm_dev_item(device);
> -	if (ret)
> +	trans = btrfs_start_transaction(fs_info->chunk_root, 0);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
>   		goto error_undo;
> +	}
> +
> +	ret = btrfs_rm_dev_item(trans, device);
> +	if (ret) {
> +		/* Any error in dev item removal is critical */
> +		btrfs_crit(fs_info,
> +			   "failed to remove device item for devid %llu: %d",
> +			   device->devid, ret);
> +		btrfs_abort_transaction(trans, ret);
> +		btrfs_end_transaction(trans);
> +		return ret;

  Missed error_undo part of the undo here.

Thanks, Anand

> +	}
>   
>   	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>   	btrfs_scrub_cancel_dev(device);
> @@ -2229,7 +2219,8 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>   		free_fs_devices(cur_devices);
>   	}
>   
> -out:
> +	ret = btrfs_commit_transaction(trans);
> +
>   	return ret;
>   
>   error_undo:
> @@ -2240,7 +2231,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>   		device->fs_devices->rw_devices++;
>   		mutex_unlock(&fs_info->chunk_mutex);
>   	}
> -	goto out;
> +	return ret;
>   }
>   
>   void btrfs_rm_dev_replace_remove_srcdev(struct btrfs_device *srcdev)

