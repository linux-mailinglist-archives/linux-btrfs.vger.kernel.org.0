Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99F55474D5
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jun 2022 15:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiFKNbA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jun 2022 09:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiFKNa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jun 2022 09:30:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3E5B8
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jun 2022 06:30:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25B3vw60029675;
        Sat, 11 Jun 2022 13:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gS1+CpxHu/MhaAL4poUhB4nmafWgHVpoYc7DcN2iyDg=;
 b=lRZG9fg18iByeIJ29YfBnyIEBjPrvwXVoHZUYFXjOovaZ5dpcHmj4Y2NHo7GguPCj4Hv
 Y7pCDl+FGYdcB+6ROTNMOF4nu1SSrDYYroRCTlf2NGT1jBAzp2J2MyDkRxRlJ9f6IOHm
 wC9C9/dugz0i+ErphhQKRRul0iXZqZj1YMRrLp0+s09syibGNx7pK0Si+JowRzAiRL6U
 +3ckHtKqtf+60t6afLI6qxJ5OTo6verkf4/ZLyEFzCr0ZUQ06lSVpeSri6IbAAPAVsWX
 c+vh9+jvzSMP8fN7t6EFZ8CazcqCrD6ICXYYwlIvtTj7STWEIvwGaR36FKl3lGFPBe3L pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkkt8ejp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 13:30:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25BDA18p023565;
        Sat, 11 Jun 2022 13:30:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gmhg7a531-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 13:30:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqoE7APbn4xMAT466GcmX5lEZtbuJrvM7WyoQBbhfVLhSs0RcJgp6NAyqM+nkmT7wnceulVYMQQsyWayIrDgRnr+WQ+bl0YLNQkYbXIWo1rvMt9rzX2AHeeDYv4bmnp013dlNsrfO+cGKhrCTiWP2PFqIybcmAUecleaAdw/xekVIOejMYF331GNHieD2lZ+JzmxQel048NfgfQ1FY2ss0sbTkmqaoXs4nJOH1QXLys94iiuX9gOFeo1NJk8q4O7i/HUEJWKBZJlatN8SocjCWMJNavXzi6/xga4emCrF/p45+KYHO8cI+pnlnHWYb7VcwiT7AREhvXB2Ytmueh88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS1+CpxHu/MhaAL4poUhB4nmafWgHVpoYc7DcN2iyDg=;
 b=EdcbRpZdeJBfuU8rKNIsIB6f0zn1pmKbcs2OVAkX2nhipwI2vgSDISn6fK+60ZA08aUTWXWT+tcXRIyA2JK44n7GTYElOgcKfoHm747MOgkM7hfXni9tRBEZMLcp0ATR0nTwvD7Oy7KRBW0LjNfFLLM9oxzf1PbSqV1Lgsu1fMDVAm58ycqIcEf2Qle6yJwWc26/9+gbn+pN9tLmZRApzd0iE5vji65wBzCYgsiPwmmZu/UB8+FqsIDRkykdc9K6Zbbng14lHZ4Lj3En+/g51znDC+0bdRNkpEDk4hRmYAD14/DqUgUtuiZi/gJgHsRXqF/AGoVLGpAoeCHa0Bl4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS1+CpxHu/MhaAL4poUhB4nmafWgHVpoYc7DcN2iyDg=;
 b=TgYY3hTM6XDKLKnDVv08ZDLuj7FfZZSD1+vuBI+ClltFTaL54K17Ub1k+EWlTAHca1UCUGeyRMGpJUXMnfi+f/FIriLSMUlOie8BqGZoxJfL0H7jrozpumxGUhdwUNHnGEAw6RMnntXo7ZbJUjUeg1rt80UK2UeAWXUzue21oKs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Sat, 11 Jun
 2022 13:30:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf%3]) with mapi id 15.20.5314.013; Sat, 11 Jun 2022
 13:30:36 +0000
Message-ID: <27a7a857-7845-438f-a1e7-733423385252@oracle.com>
Date:   Sat, 11 Jun 2022 19:00:25 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     willy@infradead.org, nborisov@suse.com
References: <20220609164629.30316-1-dsterba@suse.com>
In-Reply-To: <20220609164629.30316-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c99f9d9e-82fb-49e2-9e0d-08da4bae9131
X-MS-TrafficTypeDiagnostic: SN6PR10MB2688:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2688FD45453BE234AAB77ED7E5A99@SN6PR10MB2688.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imTYZJVbQnMRbIUMcHSeXA43TyNpCeba7v4to6nhxgoLFojdoPVXDjXDP/BsUGSZAqPDgbzUyHomMCUzb/wBmkDltRCiAA0agBQ2gMeIO06+12SuYyBxFMljYd/zZp9slR7YA56DfiJVtRYqS0/4x4qrzLJYuj7hHPqtjftmSPyXMlvV4N1HL4CbeW2puC2KN7+LVK5YTfsSraboX5Zjwlw02Mg6aS/UbwhBWcT41k2tz5mLYfY3Nzd4YZlDeCs2mPHrSOAoyC/iEWZRH1YSh5M6P89AsPkbKN+ZxUZpzzpnfwHSfn8MwzDTs1LMGjQulYggGmoYZT65rOIVn4F9W7v23TDpg1yaxkFoHluHBm6ncTRDqplt9ziO9iUtFcH95KawQx11swiAEbCZGhg408OX3GGjonjXOnCeneaLxi4SKQcROu/McupExkbPt6Ui7UImp7k14HHCgD5qAeErAHTyXPuzrMEXjbLDdu4YSBrqYJ7uSJw94U4gTYZQTS7ueoNyCowGyjSSaqplYBJ0IUH7ZzIK9TfJgA4cojzxsmfes+SnRjF49dIm+zaBon2w53MQde+b7jHSHemh+vnnCdIDMxO+2PsBT6/9L9Qnk/iQOgKXX8ezRgVjrXdTYaQ0jzrWtheR2h90i5Chu4AKIFqgBOByidxskbdaoLYFfQ8DM+zpd97VI7qcB0Mprr6tALz3GNLIbBQRfngPnscoFdF4PXuYDVFGEfCMfd5igag9YDxWSP8CH0TgYDvIoOGrXm6YNDIC2bOQUmECJEVRJStqkrnDl8gxSLquu+hmQPeGL/d3cTw0MknvhvERbwwFgmFdcarP2XdYfkWfZarqCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8676002)(38100700002)(4326008)(66476007)(66946007)(66556008)(53546011)(6666004)(2616005)(6512007)(31696002)(86362001)(44832011)(8936002)(2906002)(5660300002)(508600001)(6486002)(186003)(83380400001)(966005)(316002)(6506007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWtWYy8vT2pRTStyTTB0MDVGQWdvdmc0aGFyVFpzZXZQK1Qra2dUa251QkNI?=
 =?utf-8?B?d2I3ejJNdmsyUGZDOW9xdVYvdWtDQnNwY1VscUNmMUltWHZmbTc0ZHhTQ2NT?=
 =?utf-8?B?V3AyY1hzaG9zbTFUQnJFTGJlZnROcUo0R0lNbG1ydTlhR0JUM1ZzK05XYU81?=
 =?utf-8?B?cWdNVWYwM29od1pSNzh2c2ZCbm9maWVWSjdBeU5KRS9lTDU4MDRpbW0rQnEx?=
 =?utf-8?B?eDVBWUVLbjlmaW5Ed2x5cjh2a0tZOUY0U0c1VzJyUTZ0VXhPWXhIWHNMUVhT?=
 =?utf-8?B?OFRNMThNMWE2OTFVaG5CMUhDUjNEalY4TnZ2dWE0ZktPNS9KTmFtaVBLZDlY?=
 =?utf-8?B?cUE3b1FPUjJmYWVaTjZrcTZPQWNWbDJVYVBoYmsrOXl0R0dlSUhqL3AwemxI?=
 =?utf-8?B?Tk5uMFl4a1VZY1hoVGFPYzZ1dWJ4WXQyc2ZrNzhDUkJicUZIMG5NTFVRd2VF?=
 =?utf-8?B?aGhNNG5GRE1HWHp6cHNTTFJjUE43ZVp6K2ZQVWl0TGF6dTN1NzRlYkRrSnNU?=
 =?utf-8?B?V3ArM0JKNFV0WGMvUlFnNEV1b3ZCSEkyUGVCU3c0eXRudDdlZkxWbmtpQ2Nq?=
 =?utf-8?B?NzE3Uk5KbVlnTUN6V0NQZlN3ei8rL2tuUmk3eGhLMk4wRUJOd2ZGK3dSditW?=
 =?utf-8?B?ck1Hek9DYTR0ZUsvcVREK1hYWkpEVWZmWE5VWTQ4TWpBby9OWE5kQyt1cEp4?=
 =?utf-8?B?VnlKS1VydjZZb1lwcndvQkhFQUw3YlFmemNUOE5Xa0ZhdTFUZ083MG1yQldq?=
 =?utf-8?B?RjNpbEQ4dW1SeEV2b2hVd2J6RHFaR0diM0hFa2lKOU9zTVdzUUM0Q3JwMDRz?=
 =?utf-8?B?Qkl3dmRVTzU5NXNrL01XTzduOFcwSDNDWDZBalBqOVBBWlZkUkxnUFBIRFB4?=
 =?utf-8?B?QkN3UWlRUHFuSlRtbDU5Vk5BZXgza3NVN3hTQ2Fwemw0bUpDb3M3SnN1UTZ2?=
 =?utf-8?B?eHhqb1ZQNldEQlBrZFpXNDhjeHpGSXZvRXczdmZialVqVW8yZ1FVaUY1eDBL?=
 =?utf-8?B?eTk2ZWdPSFREM0J3T2E3L05UL05CbVRvQndDdUlxL0lUbHN2S1FMdlZmL2RL?=
 =?utf-8?B?N0ZkSWRpNElLUVJmN0p3YUk0Q2NtdW92akwrNXNSNDVVTGc0RFpFTmlERERB?=
 =?utf-8?B?aHA3NFZUOXRoN0REK0RwNTEzQTBTWThINjJQNFQ0bWFQU3laQlE0QWVQa01u?=
 =?utf-8?B?NlQ5Vlk0YktMblduQjM0a25MSHlTd21XRGJ6Z2RqbVU5RnRmamVPcUdsZ2wr?=
 =?utf-8?B?dFRTdzBOZU1rcjF3eDdETmxzYzNTZTZqdHpTZTZCTjdNQzZZN1BVTFZNRVJF?=
 =?utf-8?B?NCtmUVgzWWdSTTNaODZzTTlaWFBCNDlURVJBU0tYQmFwL2ZEZVNTVnJpRWp5?=
 =?utf-8?B?Z1pJeDdNbGJkWEt0OWpPM0dSN0ljaitkRzNKNGZrVEdOMjNVK0xFa2YyMXBV?=
 =?utf-8?B?b3M3WlIzOEpsYXNnNHFTU3lKUXlJdWF6MjJLNzU3cmNwU2RuY0l4VCtVODZq?=
 =?utf-8?B?djlQcDFzamdnMisxdUpQZ1J0bHZwaTNOTmE4Mzc1dFFCK2l1bG9iTnZsdWJq?=
 =?utf-8?B?QlFIU3p3ZzJ2d2JCY3JUOHRCbWYyQUdKZzlSTlJWbzcxTmRnWEJrVmI3Z1dW?=
 =?utf-8?B?bU1qa2pVNXlXd2FhVXd3Y1A4Y3A5clJNQnAxS0h6S0Y2Q012TUZjMEs2cll4?=
 =?utf-8?B?RTM0OXdlV1U4L1d0UkUxNy9PejhFQUFnWkh2enA5Ny9BYjRZVThqeTd5YmFR?=
 =?utf-8?B?c0g4bUxrbUpiaEVIb2lVOG5JY05KSE9tN0ZqLy9yNHVMOFplOS9kSVI2VDdJ?=
 =?utf-8?B?OU56b1FwRitxUFNndnBBNGdDbWxKOHhadFpSRElLeWdxQjl1MWJPdytXNlVz?=
 =?utf-8?B?QUtrdGd4Q2piL2VCWFZYaXlOSWFQaGxJWGtiTmRJWlpvTWRiL0tiK0pUQnp5?=
 =?utf-8?B?b1A5bTA1NmhBNTVYSmlkRDR5ZzdDYW9YdUxBQTdsNktxQUg2a2xwYzY0S0tG?=
 =?utf-8?B?ZzNmTzViMEhFSXNXbE9zREhRTldkck42QjZCeG9yQmRrWXVEVHZRQVBPUS9H?=
 =?utf-8?B?VVBjSUFTeGFuVjlRZ01VRG1Cd0JlWnJoTTkwWEtQekFRWnM2a0VJNXdtYzdW?=
 =?utf-8?B?WWE1dE9zK2xvL1YxMjZTWWtJTmRld0ZTdmRZWHJqOGg5bmY5RWp2Z3VDdXFV?=
 =?utf-8?B?bG9qVXVpRVlRMGVjL1NISXVRendRTlFCTGtrcGhDNEIxRFdsdDBjY05QQmJn?=
 =?utf-8?B?QkFYRGNiMUJGR1JEMjV4YWpxVHJXODNVY0JOVDU2ck5qS0psT1FxSmJTbzVP?=
 =?utf-8?B?Tk5mOCtiQjByWjFkUjg4M284SytNRWs3TmVmZEQ1elNKTTgrYmxQKzdPSW9S?=
 =?utf-8?Q?QLdOcyrCmS39ml/l9dMPzJ53wlRidI9v3VAHumWX//h4T?=
X-MS-Exchange-AntiSpam-MessageData-1: B4v0ceIplbtHT1y6cNmRBw7BpsoShkkXT00=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99f9d9e-82fb-49e2-9e0d-08da4bae9131
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 13:30:36.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ykf93s5MVX/ALk1NXOrAnAgm/oS+MR8A3+pauswaYvUql929LCZ5zOBDGdh80cRLogSvYZRoxw+L9lXRi2keYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-11_05:2022-06-09,2022-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206110056
X-Proofpoint-GUID: eCn0fOwqCWj511m1hJpJG_RPRxoTbdun
X-Proofpoint-ORIG-GUID: eCn0fOwqCWj511m1hJpJG_RPRxoTbdun
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/9/22 22:16, David Sterba wrote:
> Currently the super block page is from the mapping of the block device,
> this is result of direct conversion from the previous buffer_head to bio

> API.  We don't use the page cache or the mapping anywhere else, the page
> is a temporary space for the associated bio.


We use mapping for SB reading.

btrfs_read_dev_one_super(...)
::
  page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);

  So isn't find_or_create_page() re-using the same page?

Thanks, Anand




> Allocate pages for all super block copies at device allocation time,
> also to avoid any later allocation problems when writing the super
> block. This simplifies the page reference tracking, but the page lock is
> still used as waiting mechanism for the write and write error is tracked
> in the page.
> 
> As there is a separate page for each super block copy all can be
> submitted in parallel, as before.
> 
> This was inspired by Matthew's question
> https://lore.kernel.org/all/Yn%2FtxWbij5voeGOB@casper.infradead.org/
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> v2:
> 
> - allocate 3 pages per device to keep parallelism, otherwise the
>    submission would be serialized on the page lock
> 
> fs/btrfs/disk-io.c | 42 +++++++++++-------------------------------
>   fs/btrfs/volumes.c | 12 ++++++++++++
>   fs/btrfs/volumes.h |  3 +++
>   3 files changed, 26 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 800ad3a9c68e..8a9c7a868727 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3887,7 +3887,6 @@ static void btrfs_end_super_write(struct bio *bio)
>   			SetPageUptodate(page);
>   		}
>   
> -		put_page(page);
>   		unlock_page(page);
>   	}
>   
> @@ -3974,7 +3973,6 @@ static int write_dev_supers(struct btrfs_device *device,
>   			    struct btrfs_super_block *sb, int max_mirrors)
>   {
>   	struct btrfs_fs_info *fs_info = device->fs_info;
> -	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>   	int i;
>   	int errors = 0;
> @@ -3989,7 +3987,6 @@ static int write_dev_supers(struct btrfs_device *device,
>   	for (i = 0; i < max_mirrors; i++) {
>   		struct page *page;
>   		struct bio *bio;
> -		struct btrfs_super_block *disk_super;
>   
>   		bytenr_orig = btrfs_sb_offset(i);
>   		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
> @@ -4012,21 +4009,17 @@ static int write_dev_supers(struct btrfs_device *device,
>   				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
>   				    sb->csum);
>   
> -		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
> -					   GFP_NOFS);
> -		if (!page) {
> -			btrfs_err(device->fs_info,
> -			    "couldn't get super block page for bytenr %llu",
> -			    bytenr);
> -			errors++;
> -			continue;
> -		}
> -
> -		/* Bump the refcount for wait_dev_supers() */
> -		get_page(page);
> +		/*
> +		 * Super block is copied to a temporary page, which is locked
> +		 * and submitted for write. Page is unlocked after IO finishes.
> +		 * No page references are needed, write error is returned as
> +		 * page Error bit.
> +		 */
> +		page = device->sb_write_page[i];
> +		ClearPageError(page);
> +		lock_page(page);
>   
> -		disk_super = page_address(page);
> -		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
> +		memcpy(page_address(page), sb, BTRFS_SUPER_INFO_SIZE);
>   
>   		/*
>   		 * Directly use bios here instead of relying on the page cache
> @@ -4093,14 +4086,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
>   		    device->commit_total_bytes)
>   			break;
>   
> -		page = find_get_page(device->bdev->bd_inode->i_mapping,
> -				     bytenr >> PAGE_SHIFT);
> -		if (!page) {
> -			errors++;
> -			if (i == 0)
> -				primary_failed = true;
> -			continue;
> -		}
> +		page = device->sb_write_page[i];
>   		/* Page is submitted locked and unlocked once the IO completes */
>   		wait_on_page_locked(page);
>   		if (PageError(page)) {
> @@ -4108,12 +4094,6 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
>   			if (i == 0)
>   				primary_failed = true;
>   		}
> -
> -		/* Drop our reference */
> -		put_page(page);
> -
> -		/* Drop the reference from the writing run */
> -		put_page(page);
>   	}
>   
>   	/* log error, force error return */
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 12a6150ee19d..a00546d2c7ea 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -394,6 +394,8 @@ void btrfs_free_device(struct btrfs_device *device)
>   	rcu_string_free(device->name);
>   	extent_io_tree_release(&device->alloc_state);
>   	btrfs_destroy_dev_zone_info(device);
> +	for (int i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++)
> +		__free_page(device->sb_write_page[i]);
>   	kfree(device);
>   }
>   
> @@ -6898,6 +6900,16 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
>   	if (!dev)
>   		return ERR_PTR(-ENOMEM);
>   
> +	for (int i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> +		dev->sb_write_page[i] = alloc_page(GFP_KERNEL);
> +		if (!dev->sb_write_page[i]) {
> +			while (--i >= 0)
> +				__free_page(dev->sb_write_page[i]);
> +			kfree(dev);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
>   	INIT_LIST_HEAD(&dev->dev_list);
>   	INIT_LIST_HEAD(&dev->dev_alloc_list);
>   	INIT_LIST_HEAD(&dev->post_commit_list);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 588367c76c46..516709e1d9f8 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -10,6 +10,7 @@
>   #include <linux/sort.h>
>   #include <linux/btrfs.h>
>   #include "async-thread.h"
> +#include "disk-io.h"
>   
>   #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
>   
> @@ -158,6 +159,8 @@ struct btrfs_device {
>   	/* Bio used for flushing device barriers */
>   	struct bio flush_bio;
>   	struct completion flush_wait;
> +	/* Temporary pages for writing the super block copies */
> +	struct page *sb_write_page[BTRFS_SUPER_MIRROR_MAX];
>   
>   	/* per-device scrub information */
>   	struct scrub_ctx *scrub_ctx;

