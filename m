Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30574F543C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357084AbiDFEpd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1845373AbiDFByX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 21:54:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3116E23E3F0
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 16:27:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235JGpod005378;
        Tue, 5 Apr 2022 23:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+dQ8+Imye8xaHHbaypw4RQmpyUESOcE0RRrX3cNKjBY=;
 b=BXq7Yy0MQIgd1R0hACzb5BPrOp4naYwNZjI2sa0ge61Oywi8vAoMVajW9tDI0Mj0dXMW
 zKpEk26+A48lNi6GWOpt5vmD0zddDbMHycTGGgsBXKqvsesqyILAvhbixvotirU4Zt29
 re/jgn9QsW52nLvV3392muNhesJc7K8Aie3+IRCc3f8GmbYoI9rivHyl1L/EQy31ouBn
 8Xqy136m10FPnO24qn3qemgbFaiSa70WoMTcs1ajCX7NLYC8wR4nZm9z/9SVOhE/ighS
 Eh1RHnOkVTQ/fkh3TeMtk5Rh12MM6MR9hMZsTLSJyu5ZKTTlOmX3IXsqS6ShNDUrQgu+ Kw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92yef6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 23:27:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 235NPekq031320;
        Tue, 5 Apr 2022 23:27:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx462sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 23:27:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDgmWlHviFasqttSsVwvgUHFBKUXQyN8DZJOrkPODgg4SP2orWq2EByJTuw5pq36rFpMpgB98IeDPw2tIBiChm9xklaHpILXh8ahcnwZpaB4yzW9r8qXYyAgagN7vX21fnsW1Doyj79hKs2gpGwsoLfo2qKMIuIwsjGcIi7PVBX8sOtlrAJaQKd5TLnWHRZ7IAcLf1hGkRXYpiUhJzuCxM01jO6BVm20a2QR9UdHvyVDcXDsuZAIF87LLRTV6R8+Qw2Bgh4oQvkeVCosMjr7uC4doL4CQoTzVsOD1dI7szCL7dlW37ldjdkFr+fTXWMUpyBDQ62pike84mnwIXBhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dQ8+Imye8xaHHbaypw4RQmpyUESOcE0RRrX3cNKjBY=;
 b=fkAMBNy18SHsaq3uC1msgUCt3YZz4DT+u6GjTIujLiLvX9tBSce2qUFWzxGAa8w9Fr4ZEPMmyC30UuljPmYh2W7f+4LiLlkiKM8bz+pKY8B3CGxS07aidveVCOrZqvBm/EWgVGRdSHXC4mkAvYW2Q/orfUbyIuHE2oq13iRp3ilSul4Y57K/lfYraWvdmGa+c4xknJ1Ey/zRnmNyhsjDq4J4i27AW+j6Vga6+5d6Z8u0LQdhU/pREDICIz+IN2zEcdkYYcj2Tool68P1ADN5XTefbrO/8X73lQ6wlJyotJRG6l11ONe60zu5dFuoC82TuWviympijiCHVthgsIt0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dQ8+Imye8xaHHbaypw4RQmpyUESOcE0RRrX3cNKjBY=;
 b=gBkglrPxQxzGF3zQaGYAJ7aggUmB/vYBlofcgNNYG5Kjq4dwYzYIIE1iyzLKfHKKss0EDeYQu3o/xuYX2fIk+Xyhs/zLRlzhNbYqRwtuYI6C8BCDfEbfmIXtEcZ41nCvJA3kIsHud/S5EhfxIbMLHP37Pott9/8vwIRL4GlESLY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY4PR10MB1733.namprd10.prod.outlook.com (2603:10b6:910:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 23:27:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::54da:72:aa08:9a8e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::54da:72:aa08:9a8e%9]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 23:27:13 +0000
Message-ID: <9abb518b-6665-b183-3322-bf8119db64e6@oracle.com>
Date:   Wed, 6 Apr 2022 07:27:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: rename BTRFS_FS_OPEN add comment
Content-Language: en-US
To:     dsterba@suse.cz
References: <67a23a46711e1e479332622728d035af0b21bc16.1648120624.git.anand.jain@oracle.com>
 <20220328152100.GP2237@twin.jikos.cz>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com, boris@bur.io
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220328152100.GP2237@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f70afe8-39a3-46b0-b685-08da175bd019
X-MS-TrafficTypeDiagnostic: CY4PR10MB1733:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1733C911F86047CDD881F192E5E49@CY4PR10MB1733.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEhQew83SZ0LLi3HyursKmf9Tcmgquot0OHVjMiie6/NEyzietH15brufYq4Iu2dqb8aMSIVBiZNnvoZTIlvc8KtdDiODV6eaoEDaYtt3YyIz3PNAhXQdWEOBvLPIoIlzXape+VF1xicNyJMTVRX6Oe8xlD0tSlUBxG61WbbIVfPVxLQVWbQQkNJO5qQB1pcLEpR+NE/IH8BMSIKFnlTHdswY82BE/fWwSYKZPDVWmanUQBjjj93Lpcl9QZXhgPhBcDfW8n5LrWycrBODDKYESBUPdTYS81xR9xkw8BRsRTt5xUjeEcAA0A9Uqy4QAz7P7FEuh3Xcx3mERzyGg/mJ/Ds1SUfvOl53Bw3vdoog9UdKzr8x2RXfqbESF2V7weZcR0XZu2hGrn4j6gcUn4WQMFD+nqWzvutrm+FYVwqo/ZJup50Dkq3EtiKlwAcPxbA9ecuruzMIIOUeuWvS4KMv2VukvxkwtM9OMwpxrJGoAOLex7KBFPfkkRrt4WG9l3ozjfBZXeDqlIXbW9/hyk02twJiCA5jU03bNFmP3FBQERllXiekDZfCVt+WXtdUSmour89qwQaZHyjAzrXPAG6iJUkvevU25gWWQ27df7QWTlUReUHuqUgjUQoe6Tj8I9IaL4qqyEwPM7HBDiM3Dp0qNzF/1OMhnqgVdROspJywGGzetIUz0rboi0PUy0VVQo/L4/KZIHfwxZ6HrDwg8Kt3pNqA5kEBjGScogZBNd/pVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(4326008)(8676002)(66556008)(66946007)(6666004)(26005)(508600001)(44832011)(66476007)(6486002)(5660300002)(6512007)(2616005)(38100700002)(36756003)(53546011)(31686004)(2906002)(316002)(83380400001)(6916009)(31696002)(86362001)(8936002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3V6YXFFWXVzQlg4OXlRRnN1OTloRU8rdUJ4cnNJTzk0QlFzNStOM3h1WEY2?=
 =?utf-8?B?aEVxZ1FEbnlCZUJlT1FnS25RV2l5b0lYMVNPa0VjTTNaWjV3RUszZzk3Rnk3?=
 =?utf-8?B?R0VnVlk0TWNTVDN6cEw1MkVmeVVEZXhRa2Q1YmM3bXM1MnFVT1h4SGVKNy96?=
 =?utf-8?B?bFE0QlRoRkFLclhkUlRKZXNPVTh4NFNBS0cvN1hUWitHRVFJYVpsb0lLbVB1?=
 =?utf-8?B?bDBJQXJPUjdOelpvbm1vdXRXZDV3L0dRK2NwTUYzdWc1YnhMR0NJbnFMdkJY?=
 =?utf-8?B?QS9FSzBLRDhDQ0h2NmRObGxkQzlLUXdNdU1yS0hPcThGcGxKS3BZa3QyNlo5?=
 =?utf-8?B?a3lGaUVDdGdOcTBPUXpTb3h4cDlYRERVYVdSclhyTGFzNmIwTnRiTVZMRDJw?=
 =?utf-8?B?VGtXRjBxNkNxYS9HNEliUm13VFRidnh1LzY4ckpYNmcxc0toaTVSU1RGdjNs?=
 =?utf-8?B?R3lZV2Mvc1pveUc5YXBoWm1rbENHNHNBOFMyT0JFc2tJN1M4Mmc5WGZJS1M5?=
 =?utf-8?B?Umx6eDF3QUFtUGlucTEwVGRnRGNoT0gyaFZlbU9LRnlLZ0tBS1ZpS2pndFYx?=
 =?utf-8?B?QWZqdkNHTHdkNnRCdEFZVUdlb3VzL2FlNTdORWJRMWt0VGplMkdIYjJ6Z29n?=
 =?utf-8?B?Z1hKakdBRXBZSHhMT3pIN2E3MUhxZzZySU1qcGd6aTlHWjgzaFRFRWhlblFz?=
 =?utf-8?B?SnBrWFVaS2xpakdxaXNUVFprV0pPNVZUanpReEEwcXdFV0g1dkpaMkV0ZnZL?=
 =?utf-8?B?WlkyMjE2MVRpbm5hSHB5cjhibTVXQ2JGa0JhYXFiZ3BJT0tMdTBDdER5MUx5?=
 =?utf-8?B?L0dNYVExUE5Pb1l4aS9oZUEzYUhIeXl2REZmZStaZ2NuOG52Z2hpSGVCTVRn?=
 =?utf-8?B?eUdTbElKVnBaajY3STRGc2Q0MXgvd3RucmtyZjN2dzh5MW8rNnBodVdRVkNL?=
 =?utf-8?B?bkYyQjNKRUpyVG13NzJ2N2xsbmVMSWJMbDlGYXpWNER1WWVTUmlVeHkwQ2NM?=
 =?utf-8?B?RHlNS2FhclpZN1RNNHJrZWdYUDhnM240SUdGYTNTSUpScGJOQ3dCQS9WY05X?=
 =?utf-8?B?RWhJa2JpVjg0VFJWcnBrdmJrM3M4RTZ1b2t1NDZ1TFN0UUhIZGR1RERSM28x?=
 =?utf-8?B?QlRrcjZhRk1LZGxUbVVnQi8vYW5pMEljSkxyWWw1bVpLM0pmOWhSSXlrQ3RT?=
 =?utf-8?B?cnV3V1RkcWZpMlB2OVByMjJDUmRpMktvcUI1Y0RIRHE1RmRBSS91S1E5TEtD?=
 =?utf-8?B?TkpxWGdmQjVkTHhkaklhanpMVm4zd2wva2QzM0d3bUFwZHFxOTRrSTkvTlV1?=
 =?utf-8?B?TkFtUkpqeHFhZmEyWGFEdGlYN1R1N2pNNjRZNEhBWDdET05SSnp6VmplaGl0?=
 =?utf-8?B?dGhkbDVZRDNUcGl0TE4wUnVsckdDUDQxN1UrMWp0Zk0ybm54cjl6TmhCK21m?=
 =?utf-8?B?K29rK1k3MGRuT2JLRjhOWWZnUVdHV1J6TGRjZktVM2Y1VG4yL29leGdBc2dP?=
 =?utf-8?B?d09mb0Y2RUp0T29rRnVDZis5dTNaaE8xQ3hUbitFRGZnWUFDRStWZ0Zodm5D?=
 =?utf-8?B?REMyN1dYUDRUd1FRWDY4ekJjM1V3bWV4UU04bUIxcXpvY04yRGp0eGdzL3Zz?=
 =?utf-8?B?K1A4bldNQU5BR1NrM1FuajVUZnh4bWQrWjRkSGh1TnFXY1FlRlhDcTZ3dWRF?=
 =?utf-8?B?d2NoUVNXZlZxUXU2dzgvRUMxTkNjditHR0JKeTNoVGRVWjNwUncvZVFyZXJ6?=
 =?utf-8?B?OG1VU001NnRwVWpsdVVOVHpBQTlic3VmZnZDcFFjNW5lT3FaYVN1cU1ScjdG?=
 =?utf-8?B?Y3BXd2piWlR4MGpnN0RiTm9RTXR2dklkcjN0dzlOSzdFM0xYNkFTdXVLSXRl?=
 =?utf-8?B?Mk00MkwzTWtwMzVEbDJ2bzNXWGJHS1VuRElUQ0RLZnBpRGNGZC9XMEpGU20r?=
 =?utf-8?B?MW5HN1habDJhZnBqSHVNTlExczE2ZVlzVlhZeEdiRnN2bWpNaXUxWkRLRUxK?=
 =?utf-8?B?TGdKS25welV4REZlUWUxcDI4MUpMOS8xaytuLzNIeXA3MmhDTzVhSjU0V3pk?=
 =?utf-8?B?OVMzYVl2akg4dTVlVG1UcHV6ckdTZTA3MXo2eUVka1VFSFNmSVZ0Um1TblV1?=
 =?utf-8?B?VVpnSUlwNlhmUjZZYnZIZHFZUlk1NnhMZStTMjkrOEkxcHVuVFhVUXVEVG1R?=
 =?utf-8?B?SmVrMXhLaEYzeHVUNUxmaHgyeXRud1JRRDdIeUp2SXhTd1VKYm16Wk1JdFRY?=
 =?utf-8?B?Tm1uZ0hSMFprUGt1bW0wYVhjRnI1bVBQSFZRU2ZrdFJCcEMreFk0c1A2Myts?=
 =?utf-8?B?dVo4dWltakErWkhMVmFUS3VlVTBaTFJ1dzllR3FIdGpyWEErSUZHdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f70afe8-39a3-46b0-b685-08da175bd019
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 23:27:13.0123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9YsYx0VyCfymctszHagMJzZKgErKvj15AR97DWGz+2nWjPQH/FojfDuFDPULoD74KQattY4qSCCwYzhgGgKYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1733
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_08:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204050126
X-Proofpoint-ORIG-GUID: N9LiZn9yu2IgXwrtyk2afsVsp9GPIxHc
X-Proofpoint-GUID: N9LiZn9yu2IgXwrtyk2afsVsp9GPIxHc
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28/03/2022 23:21, David Sterba wrote:
> On Thu, Mar 24, 2022 at 07:29:51PM +0800, Anand Jain wrote:
>> The in-memory flag BTRFS_FS_OPEN in fs_info->flags indicate the status of
>> the open_ctree() if it has completed for the read-write. The mount -o ro
>> or the seed device don't get this flag set because they aren't RW
>> mounted.
>>
>> The threads like delete_unused_bgs(), reclaim_bgs_work() and
>> cleaner_kthread() test this flag and if false they return without executing
>> the functionality in it.
>>
>> This patch renames BTRFS_FS_OPEN to BTRFS_FS_OPENED_RW to make it more
>> intuitive. Also, add a comment.
> 
> I thought that that the open bit is set once the filesystem is set up
> during the mount phase enough to run threads but yeah it really is only
> when it's writable.


> However, there's a filesystem state bit
> BTRFS_FS_STATE_RO, in a different variable, can we unify that somehow?

Yep.

Check for rdonly is inconsistent. At most of the places we use
sb_rdonly(fs_info->sb) however in btrfs_need_cleaner_sleep() it
used the test_bit(BTRFS_FS_STATE_RO....).

As per the comment of btrfs_need_cleaner_sleep(), it needs to use
BTRFS_FS_STATE_RO state for the atomic purpose. So we can not drop
BTRFS_FS_STATE_RO.

Further, BTRFS_FS_OPEN flag is true if the filesystem open is complete 
and read-write-able (not rdonly).

So we have rdonly checks 3different ways.



To fix this inconsistency, I have patches under test which do:

create a wrapper

     bool btrfs_fs_is_rdonly(const struct btrfs_fs_info *fs_info)
     {
            return test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
     }

Replace all sb_rdonly(fs_info->sb) to use btrfs_fs_is_rdonly().



create a wrapper

     bool btrfs_fs_state_is_open_rw(const struct btrfs_fs_info *fs_info)
     {
            return test_bit(BTRFS_FS_OPEN, &fs_info->flags) &&
                            !btrfs_fs_is_rdonly(fs_info);
     }

And make test_bit(BTRFS_FS_OPEN, ..) is true for both rw and rdonly mounts.


Does it sound reasonable?

Thanks, Anand

