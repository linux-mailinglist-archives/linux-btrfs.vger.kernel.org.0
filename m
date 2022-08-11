Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6D358F5E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Aug 2022 04:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiHKCbe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 22:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiHKCbd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 22:31:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FA288DF2
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 19:31:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B0iUwW024897;
        Thu, 11 Aug 2022 02:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vlG4UcEWO5JxysBt7kIr8oTxAggh901UydffIX5cbGQ=;
 b=iDqyX9WDla4GbGSjw/fdoPnuCiX7kdWSGIB3F6CgyAfv0rXaA5Y64sRU2zDyYq365NtS
 /5k0UivppLx6CLpjCx7gt52reoZ7tZ2fDz5Q9E9v2qzsP9CR5sN1gmHUxYtxBoFO1TEV
 ZvgZRcM65E+Yx4AFSOaiLPNL00r5fUshmKeCVfSzLm2R4V73aIqVPS5BdptIEAtBhGns
 cBEgso8mGJNlS7ZtU3sWOxoqpxDGS5RI94NfpkowxwmR6jwrdeNyPBAl18CnhMQoF31d
 gNbyspyxndo8QpIyk/P4T7GWdm/GdzpclKji/X/DLr7mBQvD24A1dN9AUhWi9TvNF/wM KA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq93nm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 02:31:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27B0ie4A040799;
        Thu, 11 Aug 2022 02:31:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqgemfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 02:31:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEttfUIN4OhYs0iS2tdARTdMYHwLrn0WRQY1OWXIX2kK1RLWNjvUdQHhoOXKiL6MBBeEbeCfknF+MniOPqTql4sQjXa0kbgtHstLn0OUAVXWI3vi5d0BHdDOwZXpy6HXqeXgJTN/MaHycyz66GTExt6wJDFgRXoqoTPjzQwoUyw9RnDWuBI9I7WkPkSLdJY1xtRZAI23DDmWjigBCYrGZuifq28p37EAEP7Al5F2OA/K8hsaeNDEZgsIz46tH/UR2N/WhcupOhedRUF0heUkHxtz4/qrlVHx3odFAnZN0Fv3SVOqR0Kd3huOP5W3+ulzTanGJmrQ8ZVmuB6avhIZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlG4UcEWO5JxysBt7kIr8oTxAggh901UydffIX5cbGQ=;
 b=bpUFjRjbt+x+4M2WDmXl89jBuet1H4yRnP2KaA4jyd0n0JhE0ZYvW1TLSoD7c1JcHIqlBCBgDZcFgcZNenwxTSmc+3sqPDJzOtAZbG4egTTWMMAimkEHNEMptDWUb8MXjHYSo5uhWRsjy9GGlLs9MVHSwe+g6ge1xAY2DgFqji3+IdY2Wnmnwtnsh4Evv8itVeWaZWluKTdfgMe3INiPgYOzcthzfu5PYxNzPwvIXK72de+1/r/+wk6T2Qn2Bl2NBC+hOhGfnUfT2ygNMTuq4am1CuHAv+pZTqFO9r+QVwaE98sgQtIUb5P+/bGi1rymcN8VZAZnnlLuvQMdn/e3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlG4UcEWO5JxysBt7kIr8oTxAggh901UydffIX5cbGQ=;
 b=Y9MOAkXNl1p7kGV4Yo0755t0JPoy/qRAikbHpDtP6j0IOhtBPwWex/6oEugcGO/f7inMIZqfdLQGuXgsO0dO0fMBmmYXunHEd5g66agcCVr7CbqH9/qedZMJZBY115c85o+NQjkX/K+ALAwH+TKbuVpPmaF3s4EBwBF2v2kZuNc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB3632.namprd10.prod.outlook.com (2603:10b6:208:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 02:31:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5504.021; Thu, 11 Aug 2022
 02:31:19 +0000
Message-ID: <d294e143-1715-4cdc-4687-92c3f8f4f2ef@oracle.com>
Date:   Thu, 11 Aug 2022 10:31:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: btrfs replace interrupted + corruptes fs
To:     Samuel Greiner <samuel@balkonien.org>, linux-btrfs@vger.kernel.org
References: <b4f62b10-b295-26ea-71f9-9a5c9299d42c@balkonien.org>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <b4f62b10-b295-26ea-71f9-9a5c9299d42c@balkonien.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::25)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 771b6dcd-7c24-4274-ebdb-08da7b4192a8
X-MS-TrafficTypeDiagnostic: MN2PR10MB3632:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3SQRIYo3Ujf9x/LRmvecDM+CagB5QGXvvOdnuJt2N4or2KLrO8mMLA+mFPJP0/qFf0Fb/DPNXIeikVil7S8WoXaoR9y8E1wGXuS4UAm3RzdXLW2zV3Z1X+JM8F1mp71bLwCxzUeWXUQBGpP8Jv1u5bBl7sBZvnavNBXU6fI1/uVEtGHnU98GG2fgrl26KngsSRcEkiwhbuuUMx9ltZthJmGJ4rDgKTyjwYXUzQZJqWMosmEximXgp/B9NF2uFTA3epYdchqeWBP04WmqlpeNrXqtsb0ALGjVkULvpKrdg/4N5T4f717x1S3aGYIJNTASyVIKL651c4yscbrR3W+NPXY95sAL5W7aZ+elNCBflW5t44W3nZ2Zf7fFbdIQiMZjGa95qA7zLex81fP/0nF3zvxn6Gf4/kZDvVCFtNQ40GGktlV1ICy8h/LG4XlP27rvCsBmlTlmC9JC9P64feis3G698JryQDqCK3qxXZ9QcA17NLJfQ4AhVOp6+JrM2SwOhWLSlN5UOJAUp03gi5lbPGLYR8KOFIUHP/fzFsgG+5Vez/YFaOuAQIXs3WDNEQXnrnkll1Ea81KSeFU9swJ1XLRbeE1FBsKo3OZO8kzRRwpHWSH+rP2697RVU0Jt8GVRYyeSFyTJLEITWVdsWT2ckbYmzp7iWfRLRkGKXKQwvJuavwRAfr/VdO+rvK1Hs5otwbKsgxCKmt5g8RPgClIpbCa6pUSWUkxnOXaBUPo0VoTeZX8qarDZAwLcqrm4avzABulGHjIuI67uyuflZxNw7PPZiHKmD06qwr3wYc3+2nZucnNIaDakl2y/oLJNjriNKOYSvAsUPWVMPCvmyArfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(396003)(366004)(376002)(2616005)(186003)(83380400001)(86362001)(31696002)(38100700002)(6486002)(478600001)(2906002)(8676002)(31686004)(316002)(8936002)(36756003)(44832011)(5660300002)(6506007)(6512007)(26005)(53546011)(66946007)(41300700001)(66556008)(66476007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjArdm1RQ1FpZHA0UWF5cGM2TGx3QkRmbDZDQXBlVFBaSUdtZXZMYnBTT05O?=
 =?utf-8?B?UHJEVUdUUGtGejhrdFR6RVFaaFNjeU1rSkxuYjZUTnhGZDM3VCsvNlp4NGlQ?=
 =?utf-8?B?QlBqcnc1MXNpVmZJNXFZbGYyTWtmdHNDOVhPcldBYjRDOTdIYmJYRm14TzFz?=
 =?utf-8?B?K0ZsSTM1REk4UEhCY0tmdm1la1dqWWROS0JSY2M0cTh3ODJxYzdvVzFlcXdB?=
 =?utf-8?B?bDg3R01rUjlEOW41ODNpSHdHeUkrYmpSeW8vQytnc3NlSnBQRVpoWDhjYUV3?=
 =?utf-8?B?UGNudzVrUmVCMGFLUlkzNHI5bFMrQkFiR1dKK0w1bEpMSkwwc2ZWbTFLYnNp?=
 =?utf-8?B?MUt4NWkvMEg5RytvL0NGZWpmTFBkT3psUVFVL2RKZXJkeVN1TzVCZ05UMXpJ?=
 =?utf-8?B?ZFVDSE9uNWYxK1dPM3BpdHFrNFhnUm5pc1RneUlEUHU0d3dUMFFsbnZQRnVl?=
 =?utf-8?B?Q0ZNYkJTSHpiRUdLaU5pZCtEbUhJSC9qM29ZK1VTNjJ5c0Y3Wm5IS1IvN294?=
 =?utf-8?B?Uk1YRTZZRlFxdnV5bXh5MWNmdzN0d29oYVVGTldETSs5aEFHRFRybnBXOU96?=
 =?utf-8?B?NllOSmY5TDhVYUIvVHdnWWovZjZlczRCbXZsNVlxNElmRE80YTd6YlJWNisz?=
 =?utf-8?B?OEZCTVMrVE0zeWRXZGQ0VlM3RXpiakhaTVVWVUNnY0NKTDRzRTV5V0RRQVVv?=
 =?utf-8?B?dGZYQlZ0cnBXUmxMc3BGQ2JRQS84MUJQRlpUZHlZNWhSMEdBQTZxb2xTSWN1?=
 =?utf-8?B?cmhrS2lCSGgwblp3eWdEbzBVUlB2VFl6d1RMNzk3WmJ2QzI0aVhlT1JoaFFa?=
 =?utf-8?B?STlaVlJiRlNKSkp1VXBZQTh6UWZDakwrQzlyM1Y5djdFZ2VqeHZQNTdUM0Fi?=
 =?utf-8?B?RytMOWtGUDBxVTFEd3loWDg4NGhqaTV1UUUyc2NSSy9MOGpVOU9OUS8vUFlZ?=
 =?utf-8?B?YVFHZEJONzNFMDNldlZsZWlrcVozMUtBbVl0aldQdnVhaStXaU9sRkp2MjdB?=
 =?utf-8?B?b1pnZFF6bDlzUlgvZFdjTHNEN1ZJbEhOTjZraGZWRTVHdW9NcVVwUFN3WDVR?=
 =?utf-8?B?VFNocm5Ja2hLUk9JVmlzVVl0Vm0zRHVKd2NJdXhZckJUY0phUlJpWmY3Tktk?=
 =?utf-8?B?a21sMC9adno4dUV2MW1qZHg0VWsrd2NKelQrOHhVeDU3OG14UnNaQU8xWElx?=
 =?utf-8?B?bWZPcWNkejdIOFVwdGMrTXJ2MGpubFEvQlVwVkRkTkZQdit3c2V3S3lPeDcx?=
 =?utf-8?B?cXA2NFRhSjFhRGVoU1AyUHMzRzE1cnQ4bm1FMXBDYTV3UDBweERvOC9BMndU?=
 =?utf-8?B?RWpnTUVOcFlERmdBc2krTUJqNGV3T2R4OFh6QVd3aUExSmZ5eHlKT1ZMczQr?=
 =?utf-8?B?YWsrNnhkT01FSDFqU01Sa1BheVY3Y1psa0pRMnErQktPb2xoZEVYeWF1NFlx?=
 =?utf-8?B?Qk5Vd1ZacTVXZXRqZmQvMlhLcHFWQnFueVpNZzN4VXdLOGFEbDlLOFdLYTNZ?=
 =?utf-8?B?Vy8rOE1uWE05VFRJRVIvNzZOaWhUeG1kYTdvMnJaMTN5cENma1JQZS9HZEdw?=
 =?utf-8?B?NjVYblV2WXBXdzhkL1o2SDVpTHljNWFmMjBYOG9zeHRQWlN2ZzJqVzFjbDNT?=
 =?utf-8?B?N1F1Tm53ZWZJeVQzOHNvSEVURUZzWkh5WUlRSm81WEZUNjFXVml1NStEUW50?=
 =?utf-8?B?Z1E0dExKNXFzcWduUDNiaVZpdkdVOEI1WFBRdWRjZEI0NGdmZzF3UGEwVElV?=
 =?utf-8?B?MHphalVCQjlNYnJ4Z1JUTWdzclhraWNCWG8yVnVpUUFOUVdRcFlxenJVcTJM?=
 =?utf-8?B?dzduczgwd1U3MitBUFcyUUh4TnlVeXRhM0FMQmN1WmpIejRjMVZpdWx5UlNq?=
 =?utf-8?B?UjhIbXRwM3dPK2k2TllkZDRha0dGNWMrL3JCNkZmUko1dTJuazJrSEQ4b2tE?=
 =?utf-8?B?YXlYRE50TGYyS3R5aUR3WjRlYjVpakhEVGhqOU9ZNmlVOFVqU2U3VDVFRGlt?=
 =?utf-8?B?ck9WNFRXQ3lSMkpDWjVGRUkrRFZvNTVqdDRiTTZSa1pFT0NtTkdjSVVVVU9m?=
 =?utf-8?B?NUZ2UVpreHNrV3lIVjdvcEJRSWlBTmgxVXU4OUk0cHpsdGhzbGNSVEkzZEgz?=
 =?utf-8?Q?zMqAuD/rXH5zXBlGVx61GOcMt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771b6dcd-7c24-4274-ebdb-08da7b4192a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 02:31:19.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnSsmqsCOjKmFdoc7ZVgIvMNhe2KxVkA1KciX3GhknN4sMXAuCwBR8ZVhG/9G2py0tLqbw56TOsKBmfo74Toew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_01,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208110005
X-Proofpoint-GUID: LoKCVLmGw1GlJB6MVttBhOzX-NmbDMeI
X-Proofpoint-ORIG-GUID: LoKCVLmGw1GlJB6MVttBhOzX-NmbDMeI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/08/2022 05:48, Samuel Greiner wrote:
> Dear folks,
> 
> I have the feeling of being in trouble.
> 
> I have a btrfs fs upon 4 HDs. 1 HD should be replaced.
> 
> 1. I issued the btrfs replace command, but got the message, that the 
> target HD is mounted (it was not, it did not appear in the mount output).
> 
> 2. I did a system reboot in hope to do a successfull replace. The system 
> did not start but said, that it could not mount the btrfs fs because of 
> a missing device.
> 
> 3. I booted GParted Live to investigate further.
> 
> 3.1 A mount -o degraded,rescue=usebackuproot,ro failed.
> In dmesg I get the following errors
> 
> flagging fs with big metadata feature
> allowing degraded mounts
> trying to use backup root at mount time
> disk space caching is enabled
> has skinny extents
> bdev /dev/sda errs: wr 755, rd 0, flush 0, corrupt 0, gen 0
> bdev /dev/sdd1 errs: wr 7601141, rd  3801840, flush 12, corrupt 3755, 
> gen 245

> replace devid present without n active replace item

It appears that replace-device already got the superblock but failed to
update metadata which is good. Could you try physically removing the
replace-target device and reboot and mount -o degraded.

And most importantly, before reusing this replace-target device again,
please run a wipefs -a. If there is a matching fsid and devid=0, it gets
scanned into the kernel, which makes it appear to have mounted.

HTH

Thanks, Anand


> failed to init dev_replace -117
> open_ctree failed
> 
> 4. btrfs check runs through without error
> 
> -> I guess even if i was prompted the message, that the target device of 
> the btrfs replace was mounted the replace was started. Due to the reboot 
> now there seems to be errors in the filesystem additional to an replace 
> which i cannot stop, because i can't mount the filesystem.
> 
> Right now I have a btrfs check --check-data-csum running in hope to get 
> the errors fixed.
> 
> But actionally I really don't know how to deal with that situation.
> 
> Do you have any recommondations?
> 
> 
> Thank you very much!
> Samuel
> 
> 
> Additional info:
> 
> I'm on an recent debian bullseye. But I can't run uname -r because right 
> now I'm on the GParted (1.4.0-5) Live-System.
> 
> btrfs fi show /dev/sdd1
> Label: 'Data' uuid:
>      Total devices 4 FS bytes used 6.59 TiB
>      devid 1 size 3.65 TiB used 3.39 TiB path /dev/sdd1
>      devid 2 size 2.73 TiB used 2.49 TiB path /dev/sdb1
>      devid 3 size 5.46 TiB used 2.11 TiB path /dev/sdc1
>      devid 1 size 5.46 TiB used 5.21 TiB path /dev/sdd1

