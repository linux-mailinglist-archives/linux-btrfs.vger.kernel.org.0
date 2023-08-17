Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4605177FCE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 19:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbjHQRUJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 13:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353922AbjHQRTg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 13:19:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C801530C2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 10:19:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HFxF2k005205;
        Thu, 17 Aug 2023 17:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=elB//B81m/JAnupcIRr1mQeeCfYhA8EMWb2kl7oWIOg=;
 b=g+9Lo3SzJgRBXUn/P79Vows9DYrCL9cAm9Qinyx8qSQjW5/ktg7nrAPmGAQAGVlAxpnG
 bzTcyQDyYbvXR+n8tAPtZoqdSIwbdpE1t5Dt5PQovp9oK7Vnu+4I+W0fKnGEZxdEk1bF
 64pTRNumTmC7DTuqErRqT8rKP3Ummxs5M0yJiC/LBfhAO0Wqk4Y4vEnYGB0VzFg8zPI1
 quw12vEbuiPDh+lBb4kzsU5BLJYTpisy4L9fBfzmWSyIjpKbV3QCFuLy/f+riq0zGvgg
 DdeVBHh8QbQyDouGZv9Wj8X43iPO7ftcRr14F3XYTXK7fOIBENlKOS1vPc3siUMCHU6T Vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349j4bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 17:19:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HGvQFV019784;
        Thu, 17 Aug 2023 17:19:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3yd4au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 17:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjRdqG0+UktkKK5kB6/nHUlfBPC91w1nFR5BrsUgXc5zLeRBWqPzXJneQrnYRZdhHmO+56hNKzoxfbsf+1C6ioOw9dJj4zNyVvrb8uR0XCVxZMNBtPmHl2GP7ISKG8LnE6v3Hr80utaq4Jvp8Uv4RTMlIQ5JlupFthhD6ECmPY4eIuB4czWoFJFDEeL1csJhKatN/AKpwH0UiBhcKbaQSLCJuSN3+3hR3rC6a+C/0qhxYGO2vaz4qu7jr6lEae/s0Xi3GsJp5xTY+Eex9Dl51bmuL4Q7NCn7HZZ+48Tt1XJ7DBltYd1tHHBfjSLovXbERac+N4BWK0ahx3aHBfxrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elB//B81m/JAnupcIRr1mQeeCfYhA8EMWb2kl7oWIOg=;
 b=QsjJj5sa9u+lFGiX8paozrlsmmo5LYNNpmQJbMyKELzJzcaZD4vPBVEdIiCOmtYf21pl4cY6bUEycEQJiHNZThTSlrKSxM9ZPs4nzlPg6L5SEKvV2cILBNagkY/ncchC8AEpsk5zjt8SnPqsNBIOo9CC4K60ZWGgjOZ5x1nf7wt/NAWB10XHyVv1uho9FLPMFYdjKwCOIGy03Zh/HXiG1ZYufQUj9RcfR5w71QpYUD4IKiFhv8gqnyb2Dlv/1yluhKIIDQsIjrH8FvhXQB1iZsKCut/cHpW0SZRgS0BkAoNebDGeXc/lwFVIRc1cb0SFf+HB+btdKWFfsjv8mjuKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elB//B81m/JAnupcIRr1mQeeCfYhA8EMWb2kl7oWIOg=;
 b=Y5wuIqztQXc265wlFWGol8DC5vH7eD/zbYusUuEPi/MDrqiGOLOnibvqoG2N2+NnmlNGkwE6luk6XaIAE3WQ1ZWfsosCAQmcXYYfv0qsFSKLMX+8d51vAtMy9Z/crOX82qvGy7SD4xqfqJRUUtUfuk/272mtqMmhiAtyaXd4blg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4994.namprd10.prod.outlook.com (2603:10b6:208:30d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 17:19:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Thu, 17 Aug 2023
 17:19:28 +0000
Message-ID: <25703f72-c647-d8f7-a150-fb7c66842fc0@oracle.com>
Date:   Fri, 18 Aug 2023 01:19:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs: reject device with CHANGING_FSID_V2
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com>
 <20230817120424.GK2420@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230817120424.GK2420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: b50df4b4-0532-4bbb-eb9a-08db9f461c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpmR8qiSAOAD0ZqCckJjGozD81CTii0/C+LaDHtNxOsQi+rv2XIwZDqLYDrjBPBLpYyRxfd122XKMm70Ikjq+xLB/gxWkD9l5RCUItbUEpxB+jvn29DcGZn/ibLdy0AuWaMPapJzLnBP0CAH+p+dVJfzvpLeJqBCNU6qG3/xj+vO4a7jX4vuOPSckJt9gXMlp+SvKx6ktgzWsEw/6OvFThxUAl3V2U+sdgQyvcyYRuRzW+SEYWgHkNApzofmBp8GezNkOopmTWHJoyIIhYi3MGRVOshamKS3u6rlbnakVnp8cIxEIvLrT6NXFlc4hJIuI2tsRcDKysSF36G8kbw8HkA0Lrk/BOIVhLaQVq7dyK5myCBrzDqBK1+zK8GRpmH3w6Avbit8t0aJpQV6p1DITLvfElA3rATdnFOksEezTp1WGWGZkeGYQi9KkE09OXbKn2edrXiovjv5c4EIQo+R2SMs301vNA6xDjuuR1Wuhf8A+RlaZ2tJufK9TlagXim+pKYabOq2YpUWWdjhxlIQVNRcNE1FTCgiaqb2GQ/mycSVAH1qMxEyjW/uWroPVG8+WM9NzDKkiVgrc4/jQw6hRtMIgWsp40vZKcmsIY1NhdcH6i9NtpTU8j3Is6uRBjvNgaC/mO1vATknrsDqxLVSTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199024)(1800799009)(186009)(31686004)(86362001)(31696002)(36756003)(38100700002)(2616005)(5660300002)(44832011)(66556008)(478600001)(6506007)(66946007)(66476007)(53546011)(6666004)(6486002)(6916009)(316002)(26005)(6512007)(4326008)(8676002)(41300700001)(8936002)(66899024)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXVwUFVNT0JZbnZUU1hwU0tGME1tcVlSSkdyZ2F3T0NnaEFqTFJ1OHhtVkt6?=
 =?utf-8?B?M1BGWmlXSllrQnJKRWF0M0xRVUdxd2JsVWxMemFhOUQ1NDFZQUNFV2l4c3pi?=
 =?utf-8?B?cXgzOURSSlpWd0xwQmFTOG1wbWZoQlpZeVRXdWR0Q1ZIcWxtOVFWZmJheDA2?=
 =?utf-8?B?RlFCdnhRZU9ETmRraDJuOEZwenhmUGFELzB6M0JKUEhuSjRxV3RvODFKTG5l?=
 =?utf-8?B?Y2Z5akxlbmNVa09VcDE4YUdaSDNyNzljbUZOUGFJb1dxZkthakl6RTlqeWhJ?=
 =?utf-8?B?c1NYdUpRbThNdUx1eVZPakJsNDdUL0x3WjN2Mm5Xd2Vrd01ncEJLNXkrWGd1?=
 =?utf-8?B?eGxJMWNsRFNjckd5SDR4Q1BJMDNWaGhOUkxFM1dHcmhrK2ZDMXBlaWdOZnU2?=
 =?utf-8?B?V3pteTkxcG5xNkp3VGxRTnNEZElsUklEWTVXeHZVSWJWWWt3UTRMR1JWR3dq?=
 =?utf-8?B?WXBuWG1XVHJ6Q0hRQlVUenVtbnVZYjUrVVNpSytTWVg1ejg0U1JYRDJiVzFV?=
 =?utf-8?B?Y09Bc2x4TTI4NWN2NDF3Ly9XLzNPRWtNVzhMcUhhZ2pFYTVMVEVrQ2RZMkRp?=
 =?utf-8?B?TmZuNjZpQmM3dlk1YVdqbHEzVk1GWUYxV0JBU3RoYXdpWXZIWEpTeUt3ek4z?=
 =?utf-8?B?OW9xUkNKSlhsOE8vVmxNZEM1Ui9MdXAwS0Jjckx5OG1yenMycldLQTJ4a3Vy?=
 =?utf-8?B?ZXFrcVNqREFnNkZUUlFuODFOWFY4QSs0c2t4bkpBbGZxZ0duakljUmdFWGxw?=
 =?utf-8?B?azB4RFd4eTFvR3RoRFJHZU9YUnVveU1lZS9paktZRkI5Y3d4RXZpa1BvL0Z2?=
 =?utf-8?B?TW93UjZGSWUxMWJjN3JndzVxenRwZHdreVIxR3J5WEtYTTVnR2tsNEhGRURT?=
 =?utf-8?B?Z2RGTkpRRFVpZFdDcHFrbzZ3dE1SaWNyOHczUUJLcGlXb1hxOGxuNXdyWHRi?=
 =?utf-8?B?R1BIZFpIMEhtWTIrbkwwamNVT3RBTmJJaCt6N0VwNzhwUm5pVVhXTkVDcm9y?=
 =?utf-8?B?TG1LWWRFUFVMWndmLzhuOG1La2o5UVJEYjJXU0ZtelhFWEhzSzNST2l2eXpP?=
 =?utf-8?B?Zzl4Sk1TeFMyK28xUFRVbm01c0pwVEYvS0xXR0NVMTNINUVxQ25vUEhtbWJR?=
 =?utf-8?B?Mm9kVmVabE55WnpzYmRDbVNJa3c3Tlh4KzJPR1l6dUVZOS8xY0k5L2MzSkE0?=
 =?utf-8?B?b3UycWdrZHE3UVpBS05CeFBIVDFMQWFxelFzSW05VzNqVHJSVlFVS3VBYjdr?=
 =?utf-8?B?UGpNQU9TYTNzNTNGYVJkaFZSRXNpWWNOb0V2cWlKUGNVaDNXbXJIRVpPRGdC?=
 =?utf-8?B?SHpNQVozanlCdFV3dzdCdHhuSmxaZ2FiN0lidUttMXlmTCt5dldKTGVIK2oy?=
 =?utf-8?B?ZWg2enMzWGlzNWZOaE91UHloNHMrV1VoZUNQeUl0Q244NTdNRzRKT3BBOTVO?=
 =?utf-8?B?N1U5VUFjOWhnSWpqYXdHUGRnU09YU0N4V0cvd2hGVjNBQnhncmNQUXhsNGh2?=
 =?utf-8?B?b2lqL0c4VHg3N21GTjZCWDBCK0xKckczUUtFdTgramJIQ2FGSGN1djVvclNW?=
 =?utf-8?B?TTFqRlJRc1cyVjJSWWZxdlRqeUlzanlUZktBQURrcHY0dXowenllTjBGRzUz?=
 =?utf-8?B?azRyeUZNcUQvOXFpTkZFVjdDcWtSRm1aUEVOcTJ6d2lkMFdnUldYb2V1RCts?=
 =?utf-8?B?c3dGQzh4WkZaREhUSXorUTRxeHZnTUhjYTUzVXNLdUJ5RXRUN09QNVNhZ2lE?=
 =?utf-8?B?bWtIYnJQUm9pYWtNampNVm84VDRzV2pPVDdYL2FzSWJ2NkpSelJUU3VyVk5Y?=
 =?utf-8?B?K2lWeWM4MmZUVGdnQzIyVEZPVDVKY0tqMzFKSkJ0ZVd2WjIvbCt4L0tuSjgr?=
 =?utf-8?B?emhVUVFZUXc4Q1dxRnJZQ0tocytlbSs1NHppS0RSQ0IzS1drLzF5TXR1TkZY?=
 =?utf-8?B?WGE3U2U5ODhCNXhYNG9PSjFvWXpudUN1a0xlOUVTTENqNW9zTXJaSTFkS1BQ?=
 =?utf-8?B?MVZqdGtManVPZ0ExNzhrbklET1JUU0IrdmNnbVhBUzR0Nk1lNHdGSUc3TGFx?=
 =?utf-8?B?ZTB5dXgwaGRTVzdCRFlreUMvbnhPNlh4bld2RmNBVEFuTi83TFBLV1BoMHRP?=
 =?utf-8?B?TGVlNE51SS9UMDFvUC9SczdaeGl6cUMxR2lwUWFGQjl0VmdmQllJSTZDNkEv?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N42nLsi96lUAp5ak1swX6stYLm3fo9EvMCK4mOWtLoD+mlpP8wRSf5558l66/tcj4EhZzVS9H5bKxdWOGtCkNRY7OkDDTxC5M14lom/Hq68zASiOJGIKzVhQNNWBHMsoqElnoStdLXGm8bM0QuoLqkJiK1fBsgN/vFbeIWsevjODU+piUMHZ/Ypc280x++DvGVp2lwKF6P1eel7x06vkjgAGK9IPNeCpHv4BuNyiJ1LGIn2FXRrFVpVuwhme1BIx0MLf55p1as8XDxQJz9XT+nMIsnW9tZbj2+upQ13U4xddhkFUpqjG5r3c4Cn10+cw39fzXC4TKJUmSkqZbYTmtsec6y5DIqkylFa1vpUXfH8caMYhUu7nDxipfeXfQ1OTrVsTkiKFL3x+eI/b2gGMu85miwAAS0bzepabudcEnDiMo3QtgZ3T25yXi7B2cZInxG4djUzIJLIz1YgFvM+Yc9CM9U6oVlK/0qQWDkviGBE734QSAy7pD7QFKwqmBPaa1eU/gvSkfQwyI/50NH/2ucPTHHDRT9e+wQh0kSRWHGBPeOP/gngi/Sl5POUePN4LVmUeKnv82DV40QyUrTQWSPHHj0GcuQ87ltychHPjDDYjd+obq6+DlfrjXr2tGJhlVmeuM83I9KRz8T4OU11eSYU7uPekcRJmD74VF64Adqt/er/gjX7FAJFNrIXC+//+ucAYk6TPuxWcepbHCjh6EZCsboXaV8UyyT2m/IgDxj99BiVFW0y3L5LIefWh1XOq7aKZedfDWtIUcFpRq+7ejDFn1UKRQuW4l3k7+xwKoDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50df4b4-0532-4bbb-eb9a-08db9f461c91
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 17:19:28.2150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccV4bA4a16eH+i4kgf9R6d/xpL9JloNL1yNeCtz9FjX0q+gnZ4ihmw0rHsOK3CJu3u7eidBtKUIitlP05mijtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_12,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170155
X-Proofpoint-GUID: hVwZxd8QOYYSJnL25ab43FV0bKslossC
X-Proofpoint-ORIG-GUID: hVwZxd8QOYYSJnL25ab43FV0bKslossC
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17/8/23 20:04, David Sterba wrote:
> On Wed, Aug 16, 2023 at 08:30:40PM +0800, Anand Jain wrote:
>> The BTRFS_SUPER_FLAG_CHANGING_FSID_V2 flag indicates a transient state
>> where the device in the userspace btrfstune -m|-M operation failed to
>> complete changing the fsid.
>>
>> This flag makes the kernel to automatically determine the other
>> partner devices to which a given device can be associated, based on the
>> fsid, metadata_uuid and generation values.
>>
>> btrfstune -m|M feature is especially useful in virtual cloud setups, where
>> compute instances (disk images) are quickly copied, fsid changed, and
>> launched. Given numerous disk images with the same metadata_uuid but
>> different fsid, there's no clear way a device can be correctly assembled
>> with the proper partners when the CHANGING_FSID_V2 flag is set. So, the
>> disk could be assembled incorrectly, as in the example below:
>>
>> Before this patch:
>>
>> Consider the following two filesystems:
>>     /dev/loop[2-3] are raw copies of /dev/loop[0-1] and the btrsftune -m
>> operation fails.
>>
>> In this scenario, as the /dev/loop0's fsid change is interrupted, and the
>> CHANGING_FSID_V2 flag is set as shown below.
>>
>>    $ p="device|devid|^metadata_uuid|^fsid|^incom|^generation|^flags"
>>
>>    $ btrfs inspect dump-super /dev/loop0 | egrep '$p'
>>    superblock: bytenr=65536, device=/dev/loop0
>>    flags			0x1000000001
>>    fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>    metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>>    generation		9
>>    num_devices		2
>>    incompat_flags	0x741
>>    dev_item.devid	1
>>
>>    $ btrfs inspect dump-super /dev/loop1 | egrep '$p'
>>    superblock: bytenr=65536, device=/dev/loop1
>>    flags			0x1
>>    fsid			11d2af4d-1b71-45a9-83f6-f2100766939d
>>    metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>>    generation		10
>>    num_devices		2
>>    incompat_flags	0x741
>>    dev_item.devid	2
>>
>>    $ btrfs inspect dump-super /dev/loop2 | egrep '$p'
>>    superblock: bytenr=65536, device=/dev/loop2
>>    flags			0x1
>>    fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>    metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>>    generation		8
>>    num_devices		2
>>    incompat_flags	0x741
>>    dev_item.devid	1
>>
>>    $ btrfs inspect dump-super /dev/loop3 | egrep '$p'
>>    superblock: bytenr=65536, device=/dev/loop3
>>    flags			0x1
>>    fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>    metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>>    generation		8
>>    num_devices		2
>>    incompat_flags	0x741
>>    dev_item.devid	2
>>
>>
>> It is normal that some devices aren't instantly discovered during
>> system boot or iSCSI discovery. The controlled scan below demonstrates
>> this.
>>
>>    $ btrfs device scan --forget
>>    $ btrfs device scan /dev/loop0
>>    Scanning for btrfs filesystems on '/dev/loop0'
>>    $ mount /dev/loop3 /btrfs
>>    $ btrfs filesystem show -m
>>    Label: none  uuid: 7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>> 	Total devices 2 FS bytes used 144.00KiB
>> 	devid    1 size 300.00MiB used 48.00MiB path /dev/loop0
>> 	devid    2 size 300.00MiB used 40.00MiB path /dev/loop3
>>
>> /dev/loop0 and /dev/loop3 are incorrectly partnered.
>>
>> This kernel patch removes functions and code connected to the
>> CHANGING_FSID_V2 flag.
> 
> I didn't have a closer look but it seems you're removing all the logic
> to make the metadata uuid robust and usable in case of interrupted
> conversion, while finding another case where it does not work as you
> expect. With this it would be change in behaviour, we need to check
> the original use case. IIRC as the metadata uuid change is lightweight
> we want to try harder to deal with the easy errors instead of rejecting
> the filesystem mount.

Robust indeed. Silently assembling wrong devices-data loss risk?
Failing to assemble is still safe.

I think it is better to introduce a sub-command to clone btrfs
filesystem with a new device-uuid and same fsid (as it looks like
same fsid has some use case).

Thanks, Anand
