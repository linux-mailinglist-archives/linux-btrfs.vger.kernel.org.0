Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE473469908
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 15:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344507AbhLFOgD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 09:36:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33304 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343717AbhLFOgC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Dec 2021 09:36:02 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6D40U3006632;
        Mon, 6 Dec 2021 14:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UU4ah5L6kWwLQosNlZhCvYmO75J5/+8dyQBME9V6OkY=;
 b=QnQEAf7xVjJMwDK+w05+mmGHgbCnZAlLBdyLC9sUNrM/iERLrcfHknKkzTAql2x62vxC
 RVLfPqFB4Ng+HzO4VczmAHiQ6jRoRUsJX9bOeS1nL2HcCbCq2DjGKKkqwMAs6UwGaqaZ
 TQeeTJ6RilXhnsKwPhh3DEnp6YCOkk9HegmhYp6OfY4coAHLsl6TtxLXIVskfW3v95nF
 R00Th9+vaHdZDdttqehvHBFeRzwBK8EwVzOnAAj64vvist9zhwxNeM90oy7RtsY6UfCr
 UlJzq2aQ8NO4YpboFuuUoL7Di1+sNto1L+0bAiIzWIANCfHNqLj2gY4z5SnyiUXC1xQy QQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csc72aayu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 14:32:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6EW3Uu116464;
        Mon, 6 Dec 2021 14:32:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 3cr053g8qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 14:32:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMLRv7XMwST2q9wS1al7Z/o+HIj0uh67d6NHjB91Eo4jJhrhR75zb5NY1upvnKllQbdNb8gkP4UpuaPFPBRcfqdFLm25MRzkFEOtx1jYV3WfGoSDEUVd3P97lfhaooZpq5u40oMfV/OGUbcFIaE3Jqws3DGOmG11DzYMv6b147ABXMZpDYhDJZiD8Ao5VKFIEbiUI9WPZ/exwARW/Vw64OHzC+iCEouMAvJ6Ml7Df4IQRN52QH4lvfg12xiQgbNCI8CN6JxJ7DgkkEJiEwJlSNpIxtix/jIdns8kyDXVUxT10TsPF+wdeVX7j21I2sP+FsJp68979PO+TCk0MvezjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UU4ah5L6kWwLQosNlZhCvYmO75J5/+8dyQBME9V6OkY=;
 b=jjk1ULMa7cCONDZBcGxGDkK4lL53ZimoGssGoFe2G7JyxeDTJguDrQZvIR4A9aP+89Zz/qsz7OYyI6xnkxQywsebVNX1u24iU+fSRvwc4/RH1BhvavQ8ZwidkoGHTg35J1k6E/bijld0eUVOMW4eYMUJ0yx8W43PJHYSt1eVG9z0Pknl5uDJDfgYHyXGkPpyUYS6FGt9MhKrAoofmxrPOyiVuoGdaN5M/NYh81S6uwXEwOMmIvRS8U8aQNfKu1FwgQcVS8jmje7hFGYnvvs+SVoGlWP+YFbdnL0rhB8Lo+7bRpYh1TiG++eWQFTfRuc676eczFHZzOb7RrRKlRayzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UU4ah5L6kWwLQosNlZhCvYmO75J5/+8dyQBME9V6OkY=;
 b=wc23bVY5cBE04vCPAfwObAXwprDpAZvGlghsMFR10ZwGw/5KgFmqQ8KSYC2SUo71JUBF1F0eDfzDPjew94S34qpib7i7FokrUQZylMVgwxX1bwa6uh6JbtuPoz9ZXwKlFMMhZyc/+r6etql76rYIvq7o1tpjSaAMderOS/cWKuU=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5172.namprd10.prod.outlook.com (2603:10b6:208:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 14:32:16 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 14:32:16 +0000
Message-ID: <3e1ca8f0-e817-6314-90eb-84b10e03ee77@oracle.com>
Date:   Mon, 6 Dec 2021 22:32:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] btrfs: free device if we fail to open it
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <7cfd63a1232900565abf487e82b7aa4af5fbca29.1638393521.git.josef@toxicpanda.com>
 <fdd4a2c9-00dd-430c-0537-d43734337845@oracle.com>
 <YajuCbMN4H0Ap76V@localhost.localdomain>
 <b25ba451-18f3-073f-0691-c99b10fd8c9a@oracle.com>
 <Yaoy2Ib85CZ/QJXs@localhost.localdomain>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <Yaoy2Ib85CZ/QJXs@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR01CA0003.apcprd01.prod.exchangelabs.com (2603:1096:4:191::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Mon, 6 Dec 2021 14:32:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25096bb5-462d-4a1a-d120-08d9b8c5335f
X-MS-TrafficTypeDiagnostic: BLAPR10MB5172:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB517262D6139C124E3380ADC6E56D9@BLAPR10MB5172.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/NLsUTG15fYty8LuR5PG0JWeCoqnU/HsxMnkejpKR3nFC9JmFKauTAjaaWWbZpcTm0Ul7YB34urG1pq5Ytl3xSVPlFx8CqUIb83vuAB/9D8sC+DVOiTj9OjDYG4KKtxIAvRGKwekbaW72fYIRAU5/iFfaxDj+tlkYJQNo+prHBL0LGCY+4+vjrPqHSf+hURM1pZS24+HD0AAa5+6vjjGFG7bs2h+58iLgTvTss/VcuwkqgJ8pyh39kBk3L1oNA4IyYcMEU+A0RUn8o34mjbcFKdbuX8iWGiAusbhULsomV05wQ6+RYroLNP2eWIzkD4VSszmVRAkwaSGgupRoTYDufGY8qgnGFOpENYgAfmIKkGcET/4ku5CGrAf7iJjie/EZtetKPmyILnhJ/UxxsvTpfp0/8GzmHx5v+tx2lcaLcGLoIPvDM0r6RHxAE/1nmzs+8MzFTUr+KI5ZVpv5nfTPQ5+38gLHpmoTVkiwCrKplaVzeSOLstVfSTR6G3UdSc02P3yh1Pp0cJK9U8QjNZ/jhkYI9buAMGOEJu+89AMzTsFNlr4gYReG0NP0zB0aSdI4eqO6MZZpCEg4zAQRbZ7Y5zhrFM72RvZ/2B3nBHXy+O4EXxalNuq4avvNFiou2FR4QgBCYns3O+fxh/2joLfxHLOJfYKBg8rrLj9EWKPeushMj82jVUpwgiYRzOHqmycoWUFG5VOAvxKNLhITYiwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66946007)(66556008)(26005)(66476007)(6916009)(186003)(508600001)(38100700002)(36756003)(44832011)(31696002)(956004)(2616005)(5660300002)(83380400001)(86362001)(6666004)(4326008)(8676002)(2906002)(8936002)(31686004)(316002)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXNTV05ES3dIeXNDTDlXMk9wYkNRby9rYU5UVFl0OFArNnBLTWUvMHJCVWxV?=
 =?utf-8?B?YTVRM0hjeFAzY0k0RlRaWlh0T3hRU2dMVk1JTG9vaXBGVXIwWU9qSFdNTE1U?=
 =?utf-8?B?bkxBdHhSMUUxakgzU2kyMXptWlJuQ2diWFdHZ0k0UktXZ2l0Q21Qc1Rlbk1C?=
 =?utf-8?B?WERGM1BXMTc3MVF3VHhlVGx6SC9wTnQ1eWQxUDMxY3YrSnV2VHdvZ3RzNjBj?=
 =?utf-8?B?SlRaODNyQlNpT0lYenFPZ0EwU0QydnpvMm0xT0NSNE5LTkhpbjFDRzlwTXZT?=
 =?utf-8?B?cjR5dTJXOUZsT2ZnNGhkMTY4bVlUWjduOGlQa0hrNlQ0aWkxTm40czZLQS9h?=
 =?utf-8?B?RitRL2JET1lXZVRkeEk2cWIxWmJmbzN0dkJUTytsQTk4MytDQ2VNYUpKNTZx?=
 =?utf-8?B?SEZwOUU2RllNT1pCNVVRYkFMc2xOZE9IL1I5YnhnNkxjZEhlVTlMUjJZbjNH?=
 =?utf-8?B?R0g0a2RDTmVKcVpOWEQ0SlhkL21SeWtYL1h3d0NTSzd5clIvdmhLU0huSkFz?=
 =?utf-8?B?aExRMXN6ZHFFYnBUY3ZoYWtIaGhwL3JKbXU2SFU4a1k3ZGE5bTVZMFJZZHlu?=
 =?utf-8?B?U0t2ZUVacWUzaS9zNTFWbnpIU3ZDM2pRQUpHU2oxRVNUbUZtZ0pxSW85OUNV?=
 =?utf-8?B?TjZoK1ErNmFwWjE1Qkg3RjdsT3UyUCtYb25HaHdmcTBCSEo2UUdkYjJvTkZW?=
 =?utf-8?B?cU5ZWjhaR050WDU0b3Y3ZDhjR09mM0R6NGJMUkY3Vm1ENk53R0N0WlpHRlZG?=
 =?utf-8?B?TVZBODlOYnhrd0hSY2RITEJrSTJDWGNOa2g5VndIMW02S0QyUHVmNldkTTZD?=
 =?utf-8?B?S1kweVNBY1lYTHBMR0tXWFBnR3hoWjJGZksrcjB2anlIem01bHF1a1UvQUwr?=
 =?utf-8?B?eWUvaS9IUVo2bHdzK3JUYWVXejZMRzBwYk5KNXlHUHRzVmNwL1h3ajRYWkxE?=
 =?utf-8?B?YkMwQ040Sk9SaFJ1WWRnRmJnZTlRQ3kzSStIWjMxaWQ1S21taW13KzVFWTQ1?=
 =?utf-8?B?OXozMDhZUWwxL1o0a3dBTDFCZlVWMk5vVlgxbkt6Yy9wYk5UcXRjUTBRYWw1?=
 =?utf-8?B?Njhjb0VVTy9ZMHRDUnR0Qk5tdWtSYjlWSWlyZDNTUnBJTnJLaTBlbEQ1cnR0?=
 =?utf-8?B?dUZFUEVYK2NxOXNXa2h3OTltSk02KzZrKzB3TFNGNkNtUyt4Y0VPWHhKVDFv?=
 =?utf-8?B?TERIM1AzSVBmbXN4aFZnZVVOY1lCMFBtR3NLQ3ZOMG00Q3oyL0dVOW5rYVo4?=
 =?utf-8?B?QUtZMWQvbHZ3K2p3TDU1WTdZYkl0QWFKSmlDaE9nYk1DbjUxcC9WMG92elpk?=
 =?utf-8?B?cWs3cWtaMlZGK1NCZ2VHbms3YUZVRXJ4Q0JpRGFGY0g0cThYYkxYc3hwcUhn?=
 =?utf-8?B?MkZyZnZwM0JuNmZvMHhaUUlqNkxDZjUrZExKR0JuMXVYNUtac3lBSWlETHlC?=
 =?utf-8?B?V0FSRW9BR3B5NnUxbllNbWxIWkxhWHVXbGQvcXNHK2Z3cURVK0Z4VmhlL1B0?=
 =?utf-8?B?eElkUUNmbFNBTEp4UTZWVlE4YkVGU28xbU8rWWJ6NjlOdnU2VGlFNW0yLzho?=
 =?utf-8?B?aUhVR21Rcyszenp3QThTYUNzcmtieHlBeldlc0o3TVBETlprYzBHMlJSYkxD?=
 =?utf-8?B?V3BKNHpyOU9JVUdvR1NjaHdnZ3lpTzgyNlh0OWFoZnI2a2dOUFZVR3BMMHJF?=
 =?utf-8?B?T011cWFqVkpoMW5jVTh1Y1pIVDlsNzBLR0tOZWtTRkd4N2tjREdXZUZDamlq?=
 =?utf-8?B?OTYvM2tFMzFCUzJOdDVUby9Yb0dna2JodGxUaTFzOWRUalgxSStvUHlrbGk2?=
 =?utf-8?B?U3JkaS9MRkNUd1BUN3VqamQrOFVsYjNZOVNCRFBubnVZZjR1WU1iOEhkKytH?=
 =?utf-8?B?bVRYdnBvTjJUaU9iQ0lxMnhvVFJWNVBDMFlzQmYzWEhOU1Jrb2o5c09pNU1G?=
 =?utf-8?B?anZiL2dadGJIaVY1M0dBRVVqaGV0d0lQQkg5NFBkWFo2K0wwL25OVi95d2Rr?=
 =?utf-8?B?SzdvN3ZjcWplMHE5blNHcDNKQjhEdTdGVTYvWlN1dTg2d3VieDljQTlzZlR3?=
 =?utf-8?B?eGp5eStPaWlDRFB2UlR1STExeGFQSmdOTlBOeXJpUkJDOGFtcnRPZVU5cERu?=
 =?utf-8?B?SmtiNDFoUFNFSlczM2tLMHJHSVU2RUpVWmxFalhuUExkK0NUNHBpMFhmQk1D?=
 =?utf-8?Q?f3l3iIRt2tY70Cr3LOmeDT0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25096bb5-462d-4a1a-d120-08d9b8c5335f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 14:32:16.2745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26J1/CsOGkTzGk/Pe20GaPfqJhibbRwj9WmL8N4/msS+lvJVbjzG7arCSLE4KhB4AOWCW+5Hv6WYe3BlFcJAmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5172
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060091
X-Proofpoint-ORIG-GUID: jGNYUuHBPfRjfqZq_PSmL8Su9ssq4Gyd
X-Proofpoint-GUID: jGNYUuHBPfRjfqZq_PSmL8Su9ssq4Gyd
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


<snip>


>>   I got it. It shouldn't be difficult to reproduce and, I could reproduce.
>> Without this patch.
>>
>>
>>   Below is a device with two different paths. dm and its mapper.
>>
>> ----------
>>   $ ls -bli /dev/mapper/vg-scratch1  /dev/dm-1
>>   561 brw-rw---- 1 root disk 252, 1 Dec  3 12:13 /dev/dm-1
>>   565 lrwxrwxrwx 1 root root      7 Dec  3 12:13 /dev/mapper/vg-scratch1 ->
>> ../dm-1
>> ----------
>>
>>   Clean the fs_devices.
>>
>> ----------
>>   $ btrfs dev scan --forget
>> ----------
>>
>>   Use the mapper to do mkfs.btrfs.
>>
>> ----------
>>   $ mkfs.btrfs -fq /dev/mapper/vg-scratch0
>>   $ mount /dev/mapper/vg-scratch0 /btrfs
>> ----------
>>
>>   Crete raid1 again using mapper path.
>>
>> ----------
>>   $ mkfs.btrfs -U $uuid -fq -draid1 -mraid1 /dev/mapper/vg-scratch1
>> /dev/mapper/vg-scratch2
>> ----------
>>
>>   Use dm path to add the device which belongs to another btrfs filesystem.
>>
>> ----------
>>   $ btrfs dev add -f /dev/dm-1 /btrfs
>> ----------
>>
>>   Now mount the above raid1 in degraded mode.
>>
>> ----------
>>   $ mount -o degraded /dev/mapper/vg-scratch2 /btrfs1
>> ----------
>>
> 
> Ahhh nice, I couldn't figure out a way to trigger it manually.  I wonder if we
> can figure out a way to do this in xfstests without needing to have your
> SCRATCH_DEV on lvm already?

Yep. A dm linear on top of a raw device will help. I have a rough draft 
working. I could send it to xfstests if you want?

>>> Yeah I was a little fuzzy on this.  I think *any* failure should mean that we
>>> remove the device from the fs_devices tho right?  So that we show we're missing
>>> a device, since we can't actually access it?  I'm actually asking, because I
>>> think we can go either way, but to me I think any failure sure result in the
>>> removal of the device so we can re-scan the correct one.  Thanks,
>>>
>>
>> It is difficult to generalize, I guess. For example, consider the transient
>> errors during the boot-up and the errors due to slow to-ready devices or the
>> system-related errors such as ENOMEM/EACCES, all these does not call for
>> device-free. If we free the device for transient errors, any further attempt
>> to mount will fail unless it is device-scan again.
>>
>> Here the bug is about btrfs_free_stale_devices() which failed to identify
>> the same device when tricked by mixing the dm and mapper paths.
>> Can I check with you if there is another way to fix this by checking the
>> device major and min number or the serial number from the device inquiry
>> page?
> 

> I suppose I could just change it so that our verification proceses, like the
> MAGIC or FSID checks, return ENODATA and we only do it in those cases.  Does
> that seem reasonable?

The 'btrfs device add' calls btrfs_free_stale_devices(), however 
device_path_matched() fails to match the device by its path. So IMO, fix 
has to be in device_path_matched() but with a different parameter to 
match instead of device path.

Here is another manifestation of the same problem.

$ mkfs.btrfs -fq /dev/dm-0
$ cat /proc/fs/btrfs/devlist | grep device:
  device: /dev/dm-0

$ btrfs dev scan --forget /dev/dm-0
ERROR: cannot unregister device '/dev/mapper/tsdb': No such file or 
directory

Above, mkfs.btrfs does not sanitizes the input device path however, the 
forget command sanitizes the input device to /dev/mapper/tsdb and the 
device_path_matched() in btrfs_free_stale_devices() fails. So fix has to 
be in device_path_matched() and, why not replace strcmp() with compare 
major and minor device numbers?

Thanks, Anand



