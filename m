Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC04852459B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 May 2022 08:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350276AbiELGXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 May 2022 02:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350199AbiELGXI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 May 2022 02:23:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6CD57128
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 23:23:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24C40127023694;
        Thu, 12 May 2022 06:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=32A5fT8643ui++j2em/pMxBVbELLguPla3DVop5O3vU=;
 b=WgzApItuGhFSRnJWCd9GVlqvIdbjH2+VCnzJPVZLRsER7qjYKTUPDybesWS2OaI0/brU
 dcBzQocwbRH5b/Bo2Mga/AvhbpneVj5RCgJggI9lw+qYkds3L904DMZ9cjH7bZ00sde2
 A56B6gP6SuUtoxSp0+rbyh0yeYVzwfbszqjUKEkwH8nHNFgW7dJIQWJv5upmqv/wOUb2
 7Yh+tTPYDtJvoLqACd7zUC1B5gz/QNzDqhOPfDDsxgyFNbN9/iEa0sp6OiB8zhTv8L/v
 +KRmUeMNBzbZGfThk3msxwHqS6yamblzQvqj2RRpot/kK+bZ1FPylBwrxHE2Y6RvgmyX iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatku3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 06:22:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24C6LiOa015542;
        Thu, 12 May 2022 06:22:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf7576wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 06:22:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX5bxAfWpVE3R2BA9k+PTkGwZj0oFfvmwjfQInQtuB1TD8Fs5eAtObWVPYJVcvobW+ZZGk9Exx1AijNlvgghyrdQDhYBT87aCf7RqvTConmZPdYvuzY0hANKxfvKdy9BrlDCRt+SghMrZXaNJfyMC/WXAkeqWjNtIGrui68d/8gU+uVgq7Zmdl6gCGBoRzU7tRZmYjWtQevJ/G4ShOmv7NYhnswMsGbXaXG5rimaT6PJs32V9Cyobsl9WklmNuo/0EtqMCjmueLkmyv2F3OmCJJap3xAOog7duSVo04pSwpGIpdqPv1vdLwdEBqRtN8VJFgYKSPW5c7+0n7mX1QDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32A5fT8643ui++j2em/pMxBVbELLguPla3DVop5O3vU=;
 b=B8EBI5vw1xRlPuANx2HvaiZW6f08YupL2XbRTSk9jf3jLxhYIFhAy1CUvgpqItZ3tAcJ3dr3rSgQbtE1pbITzushQFVEmzGTqjKthPajS4xFWaFNbzzuape9aiyYOy4zBgZkiGS43xcoGnfGPDg40BFjOQNMEjlVMbRpVsMpvUVokqhjuIF9G7KcwT6x4TQi8UnTccKW9oklH+x4tw3tbBXOihxUSlt3xOXqzdu3abzOxw2JndJLGHNzJDm7jvb6jN+phP3HVCj7bgUu1p5m/tP0P7H8qk6NtIHgSvFEwQIR9GC4a6xcQEAA1UJlkhlONRv9Uvw3SGQ1WadqYDj8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32A5fT8643ui++j2em/pMxBVbELLguPla3DVop5O3vU=;
 b=HuTrc9XVAOcL4MEuMZ5/tt0O7w9x1yy8q0gcU8S1eAVCM9K9dv4Cws5pRX9E1+GLvNuAtDB1odNuB3cKnUuAF4yqWHkvv9G1bmMM6Nuz+ynWD6iBA32ysqmz0Rc/mL7Al4efwjwnmBSBF1wr0mp00Jlau4idhidFj+WSLe9WeD4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 06:22:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%8]) with mapi id 15.20.5227.018; Thu, 12 May 2022
 06:22:54 +0000
Message-ID: <dfdec676-66fb-c746-7fbb-d9133cb29377@oracle.com>
Date:   Thu, 12 May 2022 11:52:44 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: cleanup btrfs bio handling, part 2 v3
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220504122524.558088-1-hch@lst.de>
 <a6952ff4-1e4e-5650-7d57-8fd442e9d5aa@gmx.com>
 <20220505151128.GE19810@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220505151128.GE19810@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e91acc51-4c65-456a-e8ce-08da33dfd954
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB33668D4E3E8FDAB8BF1C74D8E5CB9@BYAPR10MB3366.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6MIlkJ/iGPIOgVPdOaLy8lFI8CQfF8/iwlQmG2ESEU+sxY6xmmgUy43EI5qS48pJMoAo3549LbvkIKcwyM3vobSfSy6bLKZiT8f2jx3BSwKBBr45nV/gXpeCB8iLqT8kqxyUdRP3H6L6kcV3z2E1T3tkXuLqFK+mSuB1NyE+lsxGct4bN/v2MDXRvOTQK+aeNjYeKgSG7kn9SH1O/Mno9o7QBSDPVN7Ck7sWwtOD7T18464yVTlXjpINvde26GdEGZsnjG1j4Lo5J9hYfXNUuk93ovTZLNr6qINMRPSYxVLZakfiXZb91w5cuv4UBVGmMuLfIyfU9Ej7ZjudAtrgeCP2xzqMMEmsRnQabVMw3ePQ5ROAsLvDFlSk+p+2PomoaJsqDvqEB9JNv5/+9gXDw8rkyHHd6o/cuD2f9MyIv9uvz+3kEFAtg+KTMhq5jxt/INkrKC5gcj5T6wfu9VIEWQfkqrcH6Unzv7mTVpb2z8RL52h/DKSoUuDO8qG45Cplh9X2MCM6lSm1AcMNlbf4Kyb9D4Qkt6gWPfft6aPBK3h5Af7q0NSlBtbrNKrI5HDiDTGvMed0W2TL2toKiHB7InZ8eOpaVcftDynz7peEgv/kSNyFQkq8WrhaU2FHqw7KDrgWiH66Uo0VwSa7qFF4EKk5ElQuFZffVMj1TiGC9OIto7VbCKXXweIadBOevxxf4rR2UJMqJdiVQUbu1evfBNoTEGHvpqFcH6HuPjsvuQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(38100700002)(508600001)(31696002)(31686004)(5660300002)(8936002)(6486002)(53546011)(6506007)(316002)(54906003)(66946007)(66476007)(66556008)(8676002)(4326008)(110136005)(6666004)(186003)(36756003)(2616005)(44832011)(6512007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzFuVVdKRWVnUnZnNjJyYk0zQ2piSGJ4TnBteThzcUhGS2MrSkZxdXByZEg1?=
 =?utf-8?B?Qis0dENqS0F2OHdTNFg4MUlNYUxNZDR0TGJMZXUzTkN6OXdCZ2tYZGlPSGpq?=
 =?utf-8?B?Y2prcTNtRE5ocVgvNzY5c05lK1haYlJkcFZLOCtWWWZNcXV2ejFRK1pUZzh1?=
 =?utf-8?B?Z2J1d1UyRkxsOWp5V01vMVJNZDIzUis0RDJrY2FqeFVjMVZMYTZFM2poa1BV?=
 =?utf-8?B?Z1lSNHQ4VStBVEtYU0pEUlczQTdHdXpjVmwvVkVpeENiMnVCZnVqZUp4SmVC?=
 =?utf-8?B?N2lONUk5SUZrTDdWa29FcGQzM1Y3VkFmZnE3MzRSSHc5VGFKVWVJaktzeGFX?=
 =?utf-8?B?SnBRSzNYclNZZkppSVZGaWM0SDEvQzRpWFlMWDZKK1Y3STV6bU01c1UyRDR4?=
 =?utf-8?B?WTJVdnZZV1JRTjJWeUlKYmJJUVY0ZmxnNDBoanFuaHFab1BYZHF2WXREamdz?=
 =?utf-8?B?R3M2TGIyN2xWMUkvYnFmbGg3V3hYeGkvdTlYYmRTZ1VUNm9RNjluWHBmc0xD?=
 =?utf-8?B?MGJUcDdBYk9uajZXOUJTenU0RmlCNVF6eGh5ZmRvY1c2a1VKVTJVc0NYbGFz?=
 =?utf-8?B?Z1pLOFNrL3dONmd4UUQ2b1dBZmxZZUFNYjhQNkNLTzJxVmpSRVdwNG1nakdr?=
 =?utf-8?B?eU9mUWFtOWs2YzBFL0hHb2RwOGxDWVZ0d3VWQWpaYmQ0bDRPRy9PRmVJRnpV?=
 =?utf-8?B?S3dILytxL0RaTnVhTFdrTmNNTzJRWXdYQnF4YTBydkRLMEdUWWcyTnk0Sk45?=
 =?utf-8?B?WWhZdEZsR05VWUlZQlNNL1JmZUw5TkZzMUM2cTdDb2xvYkI4ZE5nOVNNcW56?=
 =?utf-8?B?OEpaak1EaW9Ld3EzTmRacDVva3lseDdJTUt3WVRwOHV1a0pFN1FIZFQ2dmZr?=
 =?utf-8?B?bWtGNjZzZzBYbmNuall2OFU5aEt6U1d5Ulp5WEhBcCtDU3F3Sms1WUc0VXUz?=
 =?utf-8?B?TmxIT2dZakJsU3MvWVBpeHVvdHMwME1ob2E5dkp3Rm96UjU0SzgySzNyMHd3?=
 =?utf-8?B?bzY4b1VtaFVHekZ1WWo1a0hPZ3VIR0FScWd2K2ZHTEhBRU9JaTd3eWdtTkVO?=
 =?utf-8?B?Mm5ONVN1UFpMenV2Snk2TXhaUmJseG5GdklRM0paTTBISFFOUU45QWl3Q2Q4?=
 =?utf-8?B?QWxrbkRFN1RwRXh2ejNTM3RCbEY1VnBVMWo5VFM2eXRIaFI2V1NleStuRWti?=
 =?utf-8?B?WWpWU3VLTUdYUnVHeDF6RkxTWldtQWRJUEZtbXU4YURGMHpFR3RsM1RWaDc3?=
 =?utf-8?B?M2hvaVdHUUxMSWFzWVN5bGZtbDEwc3hBbVY3aEc4SFhMSTBwODVuelhGNnpz?=
 =?utf-8?B?L1FsbXdkQkkxMlczNjIrWUNFdlQwSTZJSTRtMlF3blowRS9jKzloR2lLcXZp?=
 =?utf-8?B?akhBNDVIRGZZc2RKanFwRUFBQVJUaUQ0NU5VTjhuaHNkOUlwT1JkT3c2RVc3?=
 =?utf-8?B?WURua2JmVjc2VFJFSC9XWVZXNjZ2dTR2cjNpV1RNbnhtcVczemxUNjA5T3cy?=
 =?utf-8?B?RzdFSzV5alFDalJmNmdUNHU2Tkt3YW5CT2VYaCt4YzYvMU5sQ1lwbHAvVWdW?=
 =?utf-8?B?czhGZElTWC9HV21NK0h4TDN0dkdpWEtlN1BZeGowMzExZVJqNXMzQ2tBeHpO?=
 =?utf-8?B?UE10Ujg0MjBtWUEzeFYyUDFGbW9UYW53YXNlaGVpRm9VTU0wY1JxQnJhRWNT?=
 =?utf-8?B?R3BSUmI2aGhUQk96RTFVbjA5NXA3UGYvU0lWMDB6L1FrQ3dxcEZ2RU52UWwv?=
 =?utf-8?B?QnNZdkFDZ3o4bVovem9aYVc0U3hIaFFoZkRRTlRZZS9JcENRa1NYMVJuTmdV?=
 =?utf-8?B?cU0yWVJrOHZwNkFyNWlBU3gwOWt5LzZyYUREZGtJcm9HSHc3aXpTaTIrUEgr?=
 =?utf-8?B?Y015YXRGMlBVRFpveGJKUU5aejY1L3ZHbldJOCtzR1JVZFBWbkRkN3k5Y0tm?=
 =?utf-8?B?QTB5bmRjcHdtZU5XNGZmZ0tSeDRSVkN0N0tGWGN3SmJXcVVmSmxWazF4SVlT?=
 =?utf-8?B?WDVnalNMUXpTNUlhblg5dFRxVThaY0RZOHMxWFZhSFIzUUlpL0M0N0lPb2Zt?=
 =?utf-8?B?OTM5TlkyZFdmdDZndTNIL0xaY2JEbzV3VVVIbW5VdDNxMjFuWk1rSFRTRm9Y?=
 =?utf-8?B?UmV5TDN0bDhpUytmVDdxdWpzaW1aOEttcE5UQ01WQ1BJb2wwWDltNUwzcms3?=
 =?utf-8?B?T04weTAwQ25jQmUrblFlWUJsYWdYc1ZRQUdpUUlIL3ZqRXBlYjBOWGlqNzRi?=
 =?utf-8?B?d2JIUnRoZ2szRWFQWTVTU3lTSFpKQzd6M2xnNDA1N2p2V3NUQUFWck92VElp?=
 =?utf-8?B?bHlGekRIVHZqT2hteHZJUlh3eWp6YzFnZ2g2TXB1TEFxV1NTRmlCK2dVM3Ev?=
 =?utf-8?Q?n4ZbNeoRKVGV4nJ39siuA6vvg0apfOAnVwLTeJPI+6ctZ?=
X-MS-Exchange-AntiSpam-MessageData-1: N8cVgIyvx1CFq3NMpFnxddYGTSVCMr7mQtg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91acc51-4c65-456a-e8ce-08da33dfd954
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 06:22:54.6727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sso9DIhU/OqRoZhwOcRZ62AJStrY29UFN+9AuXgZwx0UdmLdpmX/r7YXtdzYAou07SYWeQ2sMpk8h4KlA1mDUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3366
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_01:2022-05-12,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=849 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120029
X-Proofpoint-GUID: QAAfUfx11fEhf_eGAmIoVK3_pPqOR4Cg
X-Proofpoint-ORIG-GUID: QAAfUfx11fEhf_eGAmIoVK3_pPqOR4Cg
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/5/22 20:41, Christoph Hellwig wrote:
> On Thu, May 05, 2022 at 02:56:49PM +0800, Qu Wenruo wrote:
>> So do you mind to do some basic benchmark for read and write and see how
>> the throughput and latency changed?


> I'm not actually seeing any meaningful differences at all.  I think this
> will help btrfs to better behave under memory pressure, though.
This patch got me curious a couple of days back while I was tracing a
dio read performance issue on nvme.

Yep. No meaningful difference. I am sharing the results as below. [1].

[1]
Before:
  4971MB/s 4474GB iocounts: nvme3n1 545220968 nvme0n1 547007640 
single_d2/5.18.0-rc5+_misc-next_1

After:
  4968MB/s 4471GB iocounts: nvme3n1 544207371 nvme1n1 547458037 
single_d2/5.18.0-rc5+_dio_cleanup_hch_1

  readstat /btrfs fio --eta=auto --output=$CMDLOG \
--name fiotest --directory=/btrfs --rw=randread \
--bs=4k --size=4G --ioengine=libaio --iodepth=16 --direct=1 \
--time_based=1 --runtime=900 --randrepeat=1 --gtod_reduce=1 \
--group_reporting=1 --numjobs=64
