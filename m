Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C23844262B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 04:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhKBDwU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Nov 2021 23:52:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39498 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhKBDwT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Nov 2021 23:52:19 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A21IGgf031906;
        Tue, 2 Nov 2021 03:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bJXiZoKUZ2JWFANimFgAR4HSEpd05OUOUKYIYIkygyg=;
 b=Jo1WI80UQYDvwXXxn0DKwdngHJJ/mmCkeK16jZQAF1eixXMOH9dFOfSkXyK0NP416HeG
 LxZAEFG+KpJ6+dexQ3QPGDV95HF6wmU1gHUJqlzUxMlhiQ+g2qoh7nDz0qSgtsgViEUR
 D7vimgOeU4LF6nN8HztXE6R96v+GTrWKykYNPdwT7Ek/lKJsDqJV3KAe0ZF8OgH2Peh+
 1GRhFzpSgE4qsnwN3XDH9h32i+lpA3l3cMbCW3Y40iG9AZgoYt5/NApfDgnOcSTSx7yv
 i2YUBBXl5Vq+IhjAHOqrf350ITkkKyNV7JTa66shP8nYBn5XoaRsV5DwypG+LwcqeEuB KQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c2aa3cu40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 03:49:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A23jZCS064793;
        Tue, 2 Nov 2021 03:49:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3030.oracle.com with ESMTP id 3c0v3d3y6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 03:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkER6xq102mf1Rzh+HwHdzmibDKi/hzqix/o2CGVaGke4fCdM4iviuHOzLeTkncYXuXF/khD4SSRYUMh3hGhmPouEk+OMieAM/PKy9Gpi8MTNMKRY2yKYOPL3MtIDfsEufUeCNvqih5D2xQT2yVaq67j8kl3xsg4i1meocUb1mt761W8wLcYHmt/dIVsXPQVHrp02bQL5isqcFNFp5cjskS33TGeDHj6xN6TibPnbbMw6pEKImKU3LECkC6T807zx2DuhV77uTDs7L116m7OJpwN94WeTXdVGTdQEVCCRmMyAE4oEfEHAfd/0OPbjiQtkBkIOCXANK1hM7lBRCnDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJXiZoKUZ2JWFANimFgAR4HSEpd05OUOUKYIYIkygyg=;
 b=aHM+PSCWC2O+8gKDYa5oVTmLh1xQlGLB4FgxI/SSWiUeXhUEq79I8MF9ORiQ18OScyJux6COUysv2FCHXrWfMfzAJoPsLTvaotwOkgm3wGD1Emc+L5Qo1w58HV69OmvgyxPbacSuvs3b5WEw0Q79rnq1ZlvYYnb5MoIbxFNrKWR4KTDq6kORkrabel3s9JFCiHBYXI5ebT40ehdfVkLmgMOjqO+xIHcPWoLC7jx/AdNrdQmRoW5vfTY38+tvoIUOPvJz6nAt8Wie40NeZ5DMa45yWsrYx/8nGzZx/NqtTQvoriW7GpnXNXAX7mXQHQSeTVHG6D9DTupZCJYNTyoaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJXiZoKUZ2JWFANimFgAR4HSEpd05OUOUKYIYIkygyg=;
 b=AHy0iPm/xFcfVBmDYZFYK+sAx0XNWFkksFOYPfhxpdeP5RIHp9v8GZ1S4ZNvGQECdERvLdj2kk1nSzSUqVBF6CjEWzfhObiEmZ2+ryD5LPjTMCNTH9P3LKJV/ySMBAta2DOpR11ulwOMA/j0WdB0MtTCuN678IyFXVXYBSgZEdY=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3966.namprd10.prod.outlook.com (2603:10b6:208:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 03:49:38 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 03:49:38 +0000
Message-ID: <20e058ff-5a53-8301-720f-693d7746d50d@oracle.com>
Date:   Tue, 2 Nov 2021 11:49:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] btrfs: Test proper interaction between skip_balance
 and paused balance
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org
References: <20211101115404.374180-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211101115404.374180-1-nborisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 03:49:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f15af8d3-d851-4f2f-0680-08d99db3cb26
X-MS-TrafficTypeDiagnostic: MN2PR10MB3966:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3966FB188324EF5B555A3144E58B9@MN2PR10MB3966.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZvQ3eqYb2xFghkYCmEuBkCW2S60vqiHph3EHB+0D2/MhhGCFR+dy9gKBfbZ2oJY4Yr/rD5/543qfnQWpBgwjc5elHAGKqW/2kuADWQimgP4WPJJgDFhi+e/I7ER5vXnqQdkwlSOTZB4qWDAceK1vvsiYuDj8+rUIcNsfrMhYewn4bEhwFO5531pEUMfPz/86fdn1pPLs8zDS1YqG5bJqGB122zcIm9zm7maOcz2Mgj+r8UJsv/hDqU41P1qiC1768ECDLt5Kbsn4x3cy6kSWXEBi65ty6jPKQSMkQLsNOAWVe3LrXHnixf5ffqsVLf4Teu5JJFDsrQw0qqa3/Ii3jjGwozv9x+WfaHmwbcNO93vQiMpX9WbrnZMVaNRBDDP3hLR8fd+HBSnEzmRo8IxJbUBM3ESxzHdhqT/I7Bqiy8/mdkJzNITpQXk5vupKmug1kk2y9Z+hMVTi23W0beNminLW+5PTkpcWHd3bpfONiFmhZPnME97jdDQujJEldp9U2lBUQ+6j1rnALZDRbBEl6ITdxUOg/lgFlBNGUELLhRLz+ST2CR5uMgkRYFAWvs0FStMH2bCes5y1BpLifvS5yINx/hTtHRyDBz5pqnnwwB4wU1r3M4/nrvMOoASrw4sTCCN4G2P1g0VVFtfWgMzSubBEdnBCuD6Xg79fGv9fQlDIuj6LAq2CVZxxzDjlidBcuA4f9bwEM+vG9LebeaQlAneQvKXej1+pF28ZMpw1z4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(2616005)(956004)(86362001)(5660300002)(6486002)(83380400001)(316002)(4326008)(2906002)(16576012)(186003)(8936002)(31696002)(36756003)(8676002)(6666004)(38100700002)(66476007)(66556008)(31686004)(44832011)(66946007)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1lJeXFnbkxLaERWbWlzbmd6VktTcnBiYnpIN3lwNldnbDB0RVRmdnBwbUlk?=
 =?utf-8?B?cnVuVE5YS2xXQVIwYmFicWtjcGs2TjFicTJrdnF4YkI2MHZySlJXaWtDWi84?=
 =?utf-8?B?cDc1VjlxTTNaeEN0L2N1cVJDdjl2L0xnMDdUTElhYjlCUXZzUlFPYVluTDJO?=
 =?utf-8?B?R0ZvVGZTY0FkNWVYSnhBeXNBSkdRckY4SUUzbXhKUE1NbTdVZVpwWGVGOHhL?=
 =?utf-8?B?NVdUbmNUUTc1TUQ5VS9od0lUaWhDdEpTWFdRdk4yVThwMlhaWW1yVWI5VEJD?=
 =?utf-8?B?SnV5Y3lMUkkzNjdKZTJEeEFtMlhQWm5zZzRLaWZLUHN1M2srWEc3R2ZqeVBY?=
 =?utf-8?B?aGhBa2srSTIxKy9LQ0hTSDV3TnlKbzJMQWNTR042VGVoZWVPRXg4R3RvRkda?=
 =?utf-8?B?aDVPTEl6QmhxSEg1ZWhjS052VUtaa01JVTMrdFZabWVXWk5Xd2NNWXNzdHBL?=
 =?utf-8?B?TklqbjEwcytTdU9HZFpHWmtFaDc3OVdWdndzSTIzYWM2a0U1ay9FK2crUHc1?=
 =?utf-8?B?cFZYbHFmck9CMWhldTFOTXlvcWRiakd5WHBQc0RGUm0yOGZzVDZYQzB2eHJK?=
 =?utf-8?B?aitVeWJnREJVaHE0Q0g3b096OTRqUzRQbnVzbHJ1OWErUlBLT3NMeEpiWHpu?=
 =?utf-8?B?UjlndWNta1JTdThNbXJVNW82TDRRbVRmSEE2bGd1dzdNK1JaOEZCQk1kVUp2?=
 =?utf-8?B?Y2pvYnpZVDhsZHYxV2tFTEI5MDdzT2RxZlhrcS9HbVFlOFhqR0U2ZzVlWVpI?=
 =?utf-8?B?ZGhFTkY3S2tEK2kySW9HeXR1RlBWK055VGROenBBVjBaTVB5clVpVnFZdndD?=
 =?utf-8?B?YmhoZEJBTUkyUGpmYWhYa3c2M2FaY1NEQ25oQVB4NWdTemxySmcrNmJFaXB4?=
 =?utf-8?B?SnpoWHdBU1VXYXR5V1FBbWp3WGRPQS9HYzhDVGROTm1hMVFRRHZ6VXVVUk1N?=
 =?utf-8?B?WTZHM1dVRTNNcTRuUG5PeFdhWHU5L3hSLzZFT1YycUl0ZmlGNVhpdDFDTXJP?=
 =?utf-8?B?MWJDSitqNHB4RjNBYWVSUmhwMW5SOThmOWQ3aFlnWmpKNUdQbEt0bWFjOEM1?=
 =?utf-8?B?TjB3dEl6WmI0UnhDdEhtVUhWamF1b3NmS0UwdENodHAvbUM2aXJxVnFyVk5F?=
 =?utf-8?B?UWlJVXJLQnhac25UNkdqTXYrRS9KNUZvRnNXa1ROKzRoMWRtcXNHVFRwM1NU?=
 =?utf-8?B?RC9aV2NhMzJrUlU1ZXh3UitqL1RoYkRYYnVoYmxCT1dSbVhlZnpGQkhxSUdq?=
 =?utf-8?B?blFaZTFJaC9rTGVhdVUvU0loNzdkdDVCZHFLQlhLcWg3QlRNRjZBeStQRkNx?=
 =?utf-8?B?UXAyMDZJRDFEbVZsdTB5eTUvcnlZb1pQRnRaZUVRWkxNS254Q1d3azJmcXFP?=
 =?utf-8?B?bWNsS0J4MDNVd3haMklQOXdsRHVvQTlib2VHTHhjZUtqR3RLQ2F4czVPWHZl?=
 =?utf-8?B?UllpaEVHWlB0MXFJaEdEbkdOVi9OWlZqZUVNNzBmWU04Q3BVV2U5T3RpeTNO?=
 =?utf-8?B?KzYwY3lQd1lMYS9wQ2EySUJ4aE9qWWx0U0d0MjBzUnFlZ3Z3RVQyZGpibjJT?=
 =?utf-8?B?UGo3V1hlWnU2Y2pOb2E2a28vQmY5V0RyaHZsMCtWRjd5TndyVUx1bHgzakdu?=
 =?utf-8?B?WHQwbk5ENkpuZGErNWZJY1BGNzIzZXBiQ2FqNjJrS1pleFplbW9JN3lGdEth?=
 =?utf-8?B?L1dWT0U5T1dmMXpnU3JPcFVFR1o2Nzc2emM5SXhrcVNIUzNIQnpqMU5iS2U0?=
 =?utf-8?B?SFR6cjJ2MnZOZ21yMnRZOEVUbFFvUW94bVpYeU1QVlAwRms4azZxWGZOYWho?=
 =?utf-8?B?ek1wUmN6MEh6dXFqY0J2d2gxc3I5Y3d4Q1N2M2FMUUlZZytuWVRZTG0xMzEr?=
 =?utf-8?B?TVdMc3R5MDI4OUxKblFtS0R2SDFtc0FFaWtnSUtrb2tpdGdlS1liWmFDNTFs?=
 =?utf-8?B?eGxQUllwbjdQNG1oNkNabkpRczNHdUEyMWdGTlJwZTZxdTlocWNheFY4NG5i?=
 =?utf-8?B?QXJLNWF3azdHcWpzdGhlZjlSSUJMRFg5TnVZQ2d5TVNLU2h4bm9BdDE0cVR5?=
 =?utf-8?B?SVNQcWpwUVBETnpPUU1LMHFPaDNLMmZJMGloTVNzMHRJMklFaExrNmFwTklP?=
 =?utf-8?B?cHJ4bkh1RXZ0dXloN2hqRnB5dEJwT3RGT3hXNnROWldqTElibUVLR2dPZjh5?=
 =?utf-8?Q?6+0FCiuzLiJ5vVZNfoW4wmo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15af8d3-d851-4f2f-0680-08d99db3cb26
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 03:49:38.5964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhU5+FRS+suGTU0zeqn+NeXRui8R02fOT3xjV9/jAozn1XdjUj6EPpvgBDivlGjm8RAcSxpliPTfiFZaHjKVPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3966
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10155 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020018
X-Proofpoint-GUID: J_1-Le6Ff-APmLO6VeGFRPXAMWj0TT1L
X-Proofpoint-ORIG-GUID: J_1-Le6Ff-APmLO6VeGFRPXAMWj0TT1L
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>   * Extended the test to ensure all exclusive ops are forbidden apart from device
>   add. >   * Also ensures exclusive ops are still forbidden following device add


> +_begin_fstest quick balance auto
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +
> +external_device=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $3}')

  Pls use _spare_dev_get().
  Because _scratch_dev_pool_get() can change devices it gets.

> +
> +_scratch_dev_pool_get 2
> +
> +_scratch_pool_mkfs >/dev/null
> +_scratch_mount
> +
> +check_exclusive_ops()
> +{
> +	$BTRFS_UTIL_PROG device remove 2 $SCRATCH_MNT &>/dev/null
> +	[ $? -ne 0 ] || _fail "Successfully removed device"
> +	$BTRFS_UTIL_PROG filesystem resize -5m $SCRATCH_MNT &> /dev/null
> +	[ $? -ne 0 ] || _fail "Successfully resized filesystem"
> +	$BTRFS_UTIL_PROG replace start -B 2 $external_device $SCRATCH_MNT &> /dev/null
> +	[ $? -ne 0 ] || _fail "Successfully replaced device"

  Also, add the exclusive ops swap activate.
  We had a couple of bugs with excl-ops with swap earlier.

> +}
> +
> +uuid=$(findmnt -n -o UUID $SCRATCH_MNT)
> +
> +# Create some files on the so that balance doesn't complete instantly
> +args=`_scale_fsstress_args -z \
> +	-f write=10 -f creat=10 \
> +	-n 1000 -p 2 -d $SCRATCH_MNT/stress_dir`
> +echo "Run fsstress $args" >>$seqres.full
> +$FSSTRESS_PROG $args >/dev/null 2>&1
> +
> +# Start and pause balance to ensure it will be restored on remount
> +echo "Start balance" >>$seqres.full
> +_run_btrfs_balance_start --bg "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG balance pause "$SCRATCH_MNT"

Here it depends on the synchronizations between the balance start and 
the pause.
Pls, use btrfs balance status to check if the pause is successful.
Then call _fail("Couldn't pause balance on this system") if it isn't. 
Which is better than letting the further of the commands to fail.

