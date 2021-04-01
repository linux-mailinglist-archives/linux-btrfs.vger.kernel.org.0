Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564C03522C9
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Apr 2021 00:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhDAWco (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 18:32:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47682 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhDAWcn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Apr 2021 18:32:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131MUKdd125381;
        Thu, 1 Apr 2021 22:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=deaROsGp1u3iyTQPxOVKkS4VrPIoB2Ufxv4hv5i7qyA=;
 b=jmVuMucmRLOH1UmanjS2025kXT+CnnOLKIfsw+xP+zkiAa43kd9Kd63j8KnF5jRf1+3u
 pwzrvJ1+b8XLNAGW8NnrLLPBgVShYcFa2ZJULJXoAgsfdy9DU3KYbM1dr02dS8Xg72d8
 3u+EiZ0dXqBoIU2AeXyK1wRMt6dqr/OlzmGlRY6aDmFq2wxtW1x/wIswmZZ/D6CZaJWK
 csijFoOmEWhbPbBKoZdnsv9hdoczy/oyyGoswQLl8n9sc2tZGq3T2nFAgwc7c3bFra8W
 uRs/0LNrSbpqTKC2JFGlxKze8esLVrD4org1YtCjlEmj7HRC2VxRo8A1tQWGKX0eDa/0 MA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37n2akkbr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 22:32:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131MTiPK175310;
        Thu, 1 Apr 2021 22:32:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 37n2asummf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 22:32:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMJ04hgh0ytdtk3x0Kg+o3U30xqyv0rJhIUGbD7FJ8QGZM4Wfd2RsNd8+J+xLACBN8lB/ZJYRKU7F3UoOQfp/2Losk0Y6WC0qYw19yIE7biUGlKyPU5xjkPaCDlq8ThkPfBZxmRQcVf90JBj9lPRviA1rW4UbPE1vEckQaU3MjQSD66c/Oc4ChNsDjDdv2cCPw5Ju7Y34hJTDn3YA2I/KKWjK3WIn5a6WEeLSbkLwwIQAL4TWJSJ5A3bXqs66CiagMU9FMJnzB3GQF51ClCj1M/H5NsIjWnxg1jWCpvplIK+s2eJKc3nAA4cHUfOp6/AzTrwQVbkWl7v/Oy2evYS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deaROsGp1u3iyTQPxOVKkS4VrPIoB2Ufxv4hv5i7qyA=;
 b=c3hyfHi6ra5dOa3QTtMxSNoBb/nvqxDSEHHn/XqfnEuZ+lbRiAVWtMs4Qr6lsFNJhEPTj2AYR+OsGmhcS5BOT9d+qayPCSivuPhWi3zuY2DryECavDE4/tDrqrzmVf/6V1HbIE75NWCLoIgujaX9ibXgQASath+bXxKRCbP+EBYAazLf91SPzPfl1M19etJ/dMK2XTtiwCORwsP8KJNi8twdj5lFteUCbPaMt7EtARnNCKX6Hmk64Nt9wNztcWAyq46ASs5XkXSAK8hhAzr46ZaPsbUNxwCAf77RnJMkd1QOjFsTiehYnziXU7hiaC6lePCDd8bb5Mo2PrseG1HO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deaROsGp1u3iyTQPxOVKkS4VrPIoB2Ufxv4hv5i7qyA=;
 b=yhovz5Avq45lGglfTfsVT8g70L6LaFf2lkeNq3l2bXAXzllwBbAOq3BXItsFbxgXxQkuUKAEVTn3f2oxXhF1XnvxEsRCTSuBtyVsS24gL0q1jfHn1KEH2MncU9whBsSSVhAB86IUFxK7D2HoP2TfwVjMOnnKD0b8cNM+lnNRdqc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4303.namprd10.prod.outlook.com (2603:10b6:208:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 1 Apr
 2021 22:32:34 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 22:32:34 +0000
Subject: Re: [PATCH v3 01/13] btrfs: add sysfs interface for supported
 sectorsize
To:     dsterba@suse.cz, Anand Jain <anandsuveer@gmail.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210325071445.90896-2-wqu@suse.com>
 <b1a7aaf1-80ea-afa6-5bc3-a348ee0149a2@oracle.com>
 <20210329182031.GP7604@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <bf50e6c9-ae35-c6e2-dc84-dc2409616cb2@oracle.com>
Date:   Fri, 2 Apr 2021 06:32:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210329182031.GP7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:d47a:f48:c77a:6201]
X-ClientProxiedBy: SG2PR0601CA0008.apcprd06.prod.outlook.com (2603:1096:3::18)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:d47a:f48:c77a:6201] (2406:3003:2006:2288:d47a:f48:c77a:6201) by SG2PR0601CA0008.apcprd06.prod.outlook.com (2603:1096:3::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Thu, 1 Apr 2021 22:32:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10998710-ed51-45b6-9f3a-08d8f55e0b13
X-MS-TrafficTypeDiagnostic: MN2PR10MB4303:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4303E7C434406A0D4E7B400EE57B9@MN2PR10MB4303.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /r+9qWnEA2kZ1m+cO7GUxcAjBeS/ggyejwgQsSXoVlctCsvLICJHD3Wm5bHiwl5OAV+tyz9lO8vjhGYm5ZGsZ5g7PrXopHBYWmIpTORL9gD3HeaQsahddJhz8egXapY1E5w0l8A9WD27v+ckfliij87vm5q60AXAe7tN3xLaf0jzfTl1dDVASUwEJoX1WAzA5C2OGVz2OZAg3W0QoY4EsubLdEWJWVV5g4PKN5tZt1ZtFOkYnQTZv8ivLZ8qM1laabA9F3WS/ITRD1SwEs1V+LSXinz+FEED7cGUoJ2QSQFsTqm+TirKiC0NPj4I+29WgOGKni1kRyQEprIMD3jYlHwdlOd3MoPftS2348PuhOId2TedLwxexf1Unj/7RkyiPxT8IJ7/ZIYqZ7t8lYxPmloN6ojDcG+yGSIPlsw9Bf9Tw23cCBQpHgsl/HzPoXO+Dvn2yKsNtNyZNDXS/4DVYKY2qY0lglcJrOcOvkHMbgGkPQZr0EpUalM3MZYjqnOmvqPgn6tG4FXHfjLjOCdeZJbBoeob/7PiMMeLDAmwKBx/cLwV2z96GrdHKJkd0ArOyFJoJWbE6o4EAryDIrsJF8ScRTdbthblFgzqd9x8xYACMlZbnK5fzB1jRO/DXBGm7xJuK8aBWF1RzU1jZJzy8N4YX0GVY2WGqS2a022QhleKO2vhkN7OyCxzGuOH24tK1L7kLCjLzfzAsQQTg2+5yUZeMhENI4ConGq+bDEvbJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(396003)(376002)(346002)(31686004)(478600001)(8936002)(53546011)(38100700001)(66476007)(66556008)(316002)(4744005)(6666004)(186003)(36756003)(86362001)(5660300002)(2616005)(110136005)(2906002)(6486002)(16526019)(66946007)(8676002)(31696002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TzdMZENiWW9KcFVxNlBwejE0Unh1VlF5bkIyOWRXODRRSiswbStSZ0FkZzVG?=
 =?utf-8?B?TmNvTzhjZEFEdTRYZm95TTVhNzQzUS8zb1RzSmFTUFJlNCtjcUp3ZFc4bm1O?=
 =?utf-8?B?cW1adzNEWnZ6MTNwNTlXOGhNc2IrTTk2a2ZaYTg1dHJPdnJPbWJjcHdpYnRj?=
 =?utf-8?B?TjhNOUc0VHN2ekZCbWhuN3NzN0VEN2pYU1JqZlh6M0s3TzRTNXlzQk51Ym01?=
 =?utf-8?B?akhRSjRiN1NMMEZxR21WKzZEM2NLMHlVeUxxVzIrOHdJU2JPK3ZrYnhla1Zs?=
 =?utf-8?B?aERodHJpODI3TVNvYzc2ekJKc1BmeU1jUERzVk1iQzd5aDlNalpKMmY5QkxQ?=
 =?utf-8?B?K2x6MWVzNFFIak5zRTliM3JSb05VOVZvRGRoaEJzcm1McmVDU3Q1UzFaakVL?=
 =?utf-8?B?S2IyR0Z3TXBuR1hlSjRvQ1FiWTBxTyswcUZ1VnVHcVU2Nm0zc3duNGNwMjhI?=
 =?utf-8?B?bnd6bm11dXZKb29mN1ZnSjhFNkpOUTg1V0ZLQXJiamhKTTB0aDVIMklzYkE3?=
 =?utf-8?B?Y2Z1OUxSQlBTa21EN2hLVWdLOFJJV2sreS92V25zandvSllNQmNGYVp1Tlg2?=
 =?utf-8?B?Nm56T0Z1UW42NUx5RUI3bXlqNjd0Y0l4cFlhVlFUcnd6c3VIVGhQOEh1cUZR?=
 =?utf-8?B?THhaRUpjeTh6czhva00zNk5kUTRub1R6UHdxNndMWkZaYWtlWVBBcW93WGhp?=
 =?utf-8?B?a3o4Tktmd0FLMXN1aW9MTWpvM2hxZEVpVU5jT1J2VURHZzZWbTFFVzhVdW9E?=
 =?utf-8?B?R3M0VXpjWVVuOUlyWXdLam5JdWRwa2xVaVlBZDFsVWdORU1tWnU5MXJKR0ZS?=
 =?utf-8?B?N3B1dzBwNEQ1TitORnVYMDNmUFd6UUhHUkw1QlpKMXI5bFA4ZWFVS1E3SDhH?=
 =?utf-8?B?K3pkZHJOUzI1WHBkZVlkcVZTWWgrZjhRMW1tRVloT2drbzV4dm1GT0loRDFM?=
 =?utf-8?B?WnVQUC9yLzJVcXp3azFyUi9tSFFrVzhVcVM3MGJWOXlNSWQzNnRoTkdFL25P?=
 =?utf-8?B?N2JnUHc3SnFiaVl3NFlSV1RFZDVpRDkyZWJBL3FEaHVtbHhjSmxUaXI5ZzZ4?=
 =?utf-8?B?QTFmREJEWUNtWVNhU2d2T0xMRjlLazMxTXcxeW92MVBHQnBYRStyZDVoand3?=
 =?utf-8?B?ckdhSWhXbDZwakE5UUFmUmZtYkdUVUYxMVhidEFvS3psRWhGZnpKcFNxRWJ5?=
 =?utf-8?B?ZnRvOGFTMnU3ZHJ1TDVmSFpPYVZrL2NReFpVYkxnNHhDNFlHcUVET2gvWDR0?=
 =?utf-8?B?bVFWRUc1bk1pejVxUmJpN0Q0QmZhSUJJTDFkTnJFS09lWWJlVERGUTZEdmYr?=
 =?utf-8?B?Y3Q4YjJ3b3J1SGlBWmorRlA1bHd5Vm5mdXBDQ1duWGNGTzZJZFY5SCsvZlJ0?=
 =?utf-8?B?NXUvNTZaRzF1cWw2aENkaHkxYUVRTm5vWUVjalpzQm4vMFNsZnpBaUhCSmxD?=
 =?utf-8?B?LzhOOEk1cWIwTGJYU1B3aUJpTG84WnRuQi9mKzZRbk54bjNtVDdJOTV2Lzk3?=
 =?utf-8?B?czIrUjB4M25hNS9Sd1didy8xYStPaCtWY3NTeHE5NXBJaGlhTW9jb0psU0tR?=
 =?utf-8?B?YUFlbkJzRXBnTndFWGV4ZVZJdE0zRzA3bFlUTkZxeDd6dVVBSU14UGtyUlFw?=
 =?utf-8?B?aW4zRElQNDZiN1pmMlZtRXlINHlPSVRiZi95NU9qeEx5cGhzbnBIaTZBTmFi?=
 =?utf-8?B?UGUzbWp4VmZSNEN4TlBGNW44ZjNnN05NSFVJb0pkSzVkWURicDZsaXNWcXd6?=
 =?utf-8?B?UzcwZFlNcXpHNzR3K2VtS0F3Z21pb2pEdTE3M2JUQmdQYWNlek54a2crODFx?=
 =?utf-8?B?WFRtWmo3ajY3RlA0SXJSZ3JqcmozL055S1pCZmtPWUhYcjhSWTFYU1VlUTV5?=
 =?utf-8?Q?jBfK4hK9lt5Ga?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10998710-ed51-45b6-9f3a-08d8f55e0b13
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 22:32:34.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5SLlwWOxtpz6DafDyXD2YM92QqfcZTqFGNJfGf0GG72lGrZCSX9y1aCdpiRAFaodYLlNGqLr10VGxWHspTjmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4303
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010143
X-Proofpoint-ORIG-GUID: F9ND97CqJ8x959SZIQEwvTEUCWpQK3Fp
X-Proofpoint-GUID: F9ND97CqJ8x959SZIQEwvTEUCWpQK3Fp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010143
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/03/2021 02:20, David Sterba wrote:
> On Thu, Mar 25, 2021 at 10:41:43PM +0800, Anand Jain wrote:
>> On 25/03/2021 15:14, Qu Wenruo wrote:
>>> +static ssize_t supported_sectorsizes_show(struct kobject *kobj,
>>> +					  struct kobj_attribute *a,
>>> +					  char *buf)
>>> +{
>>> +	ssize_t ret = 0;
>>> +
>>> +	/* Only support sectorsize == PAGE_SIZE yet */
>>> +	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%lu\n",
>>> +			 PAGE_SIZE);
>>> +	return ret;
>>> +}
>>
>>     ret can be removed completely here.
> 
> You mean to do 'return scnprintf(...)' ?

yes.

> For now it's just a single
> value returned but with further support there will be a pattern like is
> eg. in supported_checksums_show, so it's ok as a preparatory work.
  Ok.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
