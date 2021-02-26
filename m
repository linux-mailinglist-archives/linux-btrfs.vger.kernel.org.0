Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05492325BD8
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 04:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhBZDLN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 22:11:13 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41890 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhBZDLK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 22:11:10 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11Q38n8L132715;
        Fri, 26 Feb 2021 03:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XiYt1oz6wCewX7u1AXmue4i1IdCFo8+H9OCeT3Rrsss=;
 b=c3KvAjk/vudLc+QYBKnzIC76KolFKo/qEPZeHx1yq5SZjpkIlCkBi4TUdAqs0BS5m0Dg
 CyDaA6j8UH2Vwtek7jqByStKMECmtPHX0wLOALSpextnZ/hgXk9EqWBk9Si7iBdDN2Qb
 Y6gORXtK5r26jxH+jsvgTZakQbg/490XT8FeH0f+M62fYO40izTb2jdVVC8Nrg+1GH5a
 1PbOLX3nZtyEXIwoFkhYAGu6Iz4qrRVkLUXFUBGztaedbGOfO4MdMg1Z7X3oywHRhjfr
 4zQ3mwbf6Coh6ngY/8xt+4dxpcUvnqiQ35y5R5VhxPvLqzFxQ7hTTBANFFKiKRRjzcwV Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36vr62axhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 03:10:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11Q2ufSP027553;
        Fri, 26 Feb 2021 03:10:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3030.oracle.com with ESMTP id 36v9m83ne1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 03:10:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSqCyZKvmvazXmN7VlCPL08Uip4jRlogb8dV4Bqs10T4DfGYakqsis9lWk6z6xVOPVB84dLiKi52nxrTXJ4DLIXs4XAA4rg7nNKCLNNaOU7AH+lodG9gQGi7QWQ8MqPpCRsrSkm1anoxYxoJSiZ0ShRzFFPw3u8/i3IQx72C/NADqvCCWYc6hAzoT/yGRJTBpHOcBweDvGafbcl1GXk5ckdhhxlRy5O2xPnX0KYuD8c6/hodl14AVn4exG2anyQw2loFWMUI5AOGCKb4nDiFBAN0A7BCNs4iEzN8qi5Runs4oYDhSWbdkPUVkXyy2t5tI4XE7RZL2/2fpHTcuHCjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiYt1oz6wCewX7u1AXmue4i1IdCFo8+H9OCeT3Rrsss=;
 b=VhHqPmDlPR923VZeJWVhdmx5hxva9VXFDOJ7W7n8i4+S3+WP6kFqOwSNcyqfbAJa4o4zDpPsyFjZEpKqOPpvAhwXSbrnQrBYdm/R6hOJttkDugG1lnhani28GWBxFZt4zR7Dsks0POJ+ACwPaRh+BHTfymIvbBNHVGKUJnPHc8pr2Cpn0vdqBXp4KFz4lXJIAOrPYjuEQ/mB1568NRsWryiwhniac5az3+9qI+dS5JuSNeS/Svn4oTkb8OB0w+ELfLs6Yl5MfjyvGAfYlCKaomNpwrwiZP6vHTuVYQ8RE/Bi1yCpRBGMaUIrM+v6p20e9k9c4UHfaHly/5gtqFWmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiYt1oz6wCewX7u1AXmue4i1IdCFo8+H9OCeT3Rrsss=;
 b=M+/RLqfN2u2xm/wDB0Mf/f/r9LuHyq0m22hSX4zZN9EewKn7KzSJKPHW+eyI6gI3cui/nLbozpIKF+OI9e13Cd5VHC9AnCLXiE3IvWQF2H29z/XQ0zbOwPplhtXzv6uugFeZ117u/MDJjsi8d+Jl3dA1NrgZPv/xuv0EobObSIU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 03:10:18 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3890.022; Fri, 26 Feb 2021
 03:10:17 +0000
Subject: Re: xfstests seems broken on btrfs with multi-dev TEST_DEV
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Eric Sandeen <sandeen@sandeen.net>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org
References: <3e8f846d-e248-52a3-9863-d188f031401e@sandeen.net>
 <5e133067-ec0c-f2c6-7fb6-84620e26881e@sandeen.net>
 <407b5343-4124-2e30-0202-13f42d612b7c@oracle.com>
 <68737772-deb2-6429-2ac6-572e15cffe57@sandeen.net>
 <b119f3a9-bf78-5b09-2054-09a2f583581c@gmx.com>
 <eb0d9c05-2818-fb57-4b2c-75b379d088a5@sandeen.net>
 <74ea7a30-fd25-7ac5-b3ae-98cf7b70e80f@gmx.com>
 <5fb6c496-dc53-662e-1970-9afb9a9dd62d@sandeen.net>
 <d7183517-95e5-7b75-3909-1b2d30db3a87@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <680adeb5-7ae5-12af-36be-25f72fe9efb5@oracle.com>
Date:   Fri, 26 Feb 2021 11:10:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <d7183517-95e5-7b75-3909-1b2d30db3a87@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR0401CA0001.apcprd04.prod.outlook.com
 (2603:1096:3:1::11) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.102] (39.109.186.25) by SG2PR0401CA0001.apcprd04.prod.outlook.com (2603:1096:3:1::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 03:10:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7a5c2ed-01ac-429f-e829-08d8da040b37
X-MS-TrafficTypeDiagnostic: MN2PR10MB4141:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4141C8710DAD3A8240F41E48E59D9@MN2PR10MB4141.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bSkxOLJD9jV2tU5R3v6Z/wGnzkFOSCmjMu741C15YKqHOpmbXczb/aKk5BDPby74s15k0kkLbHjEiF4/m2YEBLvL6VZDRfiGb0Lg+k7gAe5Y691qYlPn7Bj295h1J42bNY8c5dk2A5fRenlpJq0eSuFnQOFiGrpivFBPLMk8Zs3WTwaKDpFOLzuMcynuM/ngDME7xEtjV/dNJZ+HTC3hJKOpKsKLGG6cctSPGqA4Cm/k/vTCefjFyEcVFuPP7oInKWGtbPQAYPHmYwn9Aq2sTw6vVBDiXR8PV9XlSaNTpEw9DRYPaDkEVqrMnw08yXEX4+6EmQO8Y4m58eM+d1tLI6LyfOJD9sxuwCL1NyH9umYxOWDELyhm2DlIUAWFG9wnIdv3Frn3+49zDf6Wt2z6P2QTDeV7nUdqF09nx9Iu9eHlJoO4B19w3SSXAjIIDSrLN3eEBmIGHrFX+hjqScfNdWwoZutgUgx4kB3FRshxOIH6btTzPsfPC/8RI98FWnpP2IGDXUFq0Kf9KohV9hulyVEDBeP+Cb09K6luo5T4I/a/FeUgPDMi5fwXGFFoitRMJqS/hyzrJqpF8Y8q8DFFokbs9czEPZaK4ddK2/xcaCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(136003)(366004)(6666004)(16526019)(6486002)(186003)(36756003)(478600001)(2906002)(26005)(2616005)(86362001)(44832011)(956004)(110136005)(4326008)(31696002)(8676002)(5660300002)(8936002)(66476007)(66556008)(16576012)(31686004)(316002)(66946007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q2FzTVA2NW9ZTThPdmtqSGZyMytWNDJJd2VwNGhPdzhvbi95cjBLSnZLRzJV?=
 =?utf-8?B?VjQ4UEhzZEMwQWdra2lWY0JKOEFYcGlCaElqa1RlQlhIZ3pjTEd4YzJUQ2NW?=
 =?utf-8?B?cEFzcDNGWndZaFR1RzFyZEFJOThMUzVzSEJKdVN0WlZBOG12VFRFUFc0U1Vq?=
 =?utf-8?B?bDBoa2hYN3h4N25PTlJIQ2RjblFNckg5bEVwMytZQlJuekhMMmI4QVZuWGdC?=
 =?utf-8?B?MG9OM292SXFSbVBGUTJOK0hjWXBjdGFNbFlzM1RZemdIUndZZVdHVHU3bUtp?=
 =?utf-8?B?bDcxZFJDWHc1UFBNVmNMYkgxRnJyYUhQUUZnK1dJb0w2dEdzRXphY1FFZ2hx?=
 =?utf-8?B?a1Y4cWFac0JSeHlpS1NHVjlMeTFzalYyNXNJU1l4bkRYOStnd2JIOUhBcHVs?=
 =?utf-8?B?cUUzaEd3NDFXQ0djWk5tYkxMVkdkWlhpTU1DalZFQ2NsbDVYVUdvVEN1WXkz?=
 =?utf-8?B?ZTlPSzJzb1loemRoWmxjRTdZOEsyNTAwMlE0dzVWdExXbTdaTVRUMHBQcHFT?=
 =?utf-8?B?SW0rSUhDdlF2bmdxQVBnQW12cmFOWStxUjJpSytrMFkwR1M5UndYbzczYzdt?=
 =?utf-8?B?U3BiMThyeEU2bHBrRnFIQURRT0JuOVdSd2Ywb1Vrb0k4aFg3S1Y2TE5IS0ZX?=
 =?utf-8?B?V3BGWjh6KzhYb2Q4K3JEb1RjUmlaV01EUk9oNWFJd1FML2VjbVJxVGwwUEJw?=
 =?utf-8?B?MjV3Vmdpc3AzZE53UkVlZnB0OTI3Vmw4TklydDlLaGFpeTM4NzJCVGlIZi91?=
 =?utf-8?B?bjdub0Qyc1F4VzhJanNSd0hMY20vczBoVGVBdVRSZnl1d1o5UTB1VTg5Ym5q?=
 =?utf-8?B?SGlTU0d3bkFDOFBSbFRmK0ttci9FK04wOThRWTI2OExVQ3FXdzYxU3Q0Mkow?=
 =?utf-8?B?ZzVnVVhzM0tSMm9mdWVjbjZrSWNOWDZQMk00MzZwd2FSUi9hZVJ5QWtrUjNw?=
 =?utf-8?B?UDVMVVdXdm53blJmejhqc3BWSHgzQlBuOGd4UGpOd25VQVZEUjN5Kyttc1Iw?=
 =?utf-8?B?THk0ZDdIaVpveDI1dnZUTllJem5JbWpKeWlybzIyK3o5MjRBT2F6ak15dTI1?=
 =?utf-8?B?c1AxOXFiVjNrT3lhWFhyLzhSLzlhVGl5dWF4RWtWWVlrWHZwVTFGWGR2OERt?=
 =?utf-8?B?ZThXdGhvWGNaQWNUdlR1SGZFZlkxbGFwTThNL1FuR29ZYldCZ3ZpMU16aFV4?=
 =?utf-8?B?YlNUMkVPaE5IVGJWa2dxNDVUR01FNGZSM3g1Qk9kZEl1SHVEaEdvK0QvQjFT?=
 =?utf-8?B?cUM3UnF6eGJiaWtsTmdocjI2Z2VyaTNuNVlwbW1BbTdFaTFsS3pZdmF3NmQz?=
 =?utf-8?B?TEdBZjlxYWVwVEN1LzhjbVcvZTZZQW8yVDJIczRXUEo2MGpxY2ltOVFiQkZ2?=
 =?utf-8?B?dS9udVhrbFhpUGN1V0F3YmQzdG5GQVdjaHcra0t5Tmh6cHFEaWtGNVB0K0Z0?=
 =?utf-8?B?cWd6KzJTNXBwTjZNMDUyYWFRNWJrWHI3cXJvQXdpSW5HYTg3bVlLVnAyWkU0?=
 =?utf-8?B?alBXLzk0M0k3ZDdwN2RCWTRyWkIwYmMycU1CN2hQNFA1QTJjK09nd1lYSWdk?=
 =?utf-8?B?YUV6WVpzcHVOWmVjUVFYTHZINTRFaWNma1RhS2VxdWlkTG9QbWlsU0dyOFB6?=
 =?utf-8?B?aVhSRUNZcXJVNW5QWmVwd3NoczMrNHVSM3lnU3dKZmJaY1N6b20xSGkxUzVp?=
 =?utf-8?B?bE9OUTNaL1NZV3liazh4OGlhS0lMWlpsTjhvTldoOVcvLzNGcXo3RGptYjJl?=
 =?utf-8?Q?z9iJSa5RLAZTNBISLDmpnFBoBWfr6rkmwO2LxC7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a5c2ed-01ac-429f-e829-08d8da040b37
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 03:10:17.7416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZ1AQWAOg/yCbVJYV6SDYci6r8s6VgbFLnDuE2SLQmzOz6WR39t4pmdn8pK4KhxMQquhgq2x+BQEFWKDkwpHwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260023
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260024
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25/02/2021 11:18, Qu Wenruo wrote:
> 
> 
> On 2021/2/25 上午11:15, Eric Sandeen wrote:
>> On 2/24/21 9:13 PM, Qu Wenruo wrote:
>>
>>> Now this makes way more sense,
>>
>> Sorry for the earlier mistake.
>>
>>> as your previous comment on
>>> _btrfs_forget_or_module_reload is completely correct.
>>>
>>> _btrfs_forget_or_module_reload will really forget all devices, while
>>> what we really want is just excluding certain devices, and not to affect
>>> the other ones.
>>>
>>> The proper way to fix it is to only introduce _btrfs_forget to
>>> unregister involved devices, not all.
>>>
>>> I'll take a look into the fix, but I'm afraid that, for systems which
>>> don't support forget, they have to skip those tests and reduce the
>>> coverage for older kernel/progs.
>>
>> Can't you just rescan when the test is done?
> 
> Oh, that's way more simpler.
> 
> Thanks for the tip, I just over-engineered.....
> 

Yep agreed.

on kernels with forget-ioctl,
   btrfs dev scan --forget $SCRATCH_DEV_POOL
shall suffice.

However if we could define TEST_DEV_POOL="dev1 dev2 dev3" it will help 
both old/new kernels. IMO.
_btrfs_forget_or_module_reload()
{
::
       btrfs dev scan $TEST_DEV_POOL
}

Thanks, Anand


> Thanks,
> Qu
>>
>>> Thanks,
>>> Qu
>>>
