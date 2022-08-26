Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902955A25B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Aug 2022 12:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245461AbiHZKSb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Aug 2022 06:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245454AbiHZKS3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Aug 2022 06:18:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D94C7FA6
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Aug 2022 03:18:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q7XZiT024432;
        Fri, 26 Aug 2022 10:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Frh/ht1oAZXDbP66uBpbPsvKQeuGk/xxwo3yiT95fRU=;
 b=0IfED6v3jz9nJ8wL8tL8SXQTuMAQeenJ9kQDpsZF9xU81KWZ8ZTPLvNVzTsoSGO23Hfn
 Itou+0PkLuNrSwXAA3CyP1HyY4Mkz3iGtOQgtVXqgRa2s9kr6zR3jqh/ob8GfvgPbVe1
 1WcBp6C4zp9EG13nTIQCjAUKsa09IzWOmdmI80LOt8Eq8+VVtq9yvoK6+DJto5HfQTUr
 AM0V4TEUSupCLn29ucShserANtTbuEc1V/l7JSz6lt9T3L5Dn4xDpRuKRka6eqaIL1ey
 qtYKg+BRy5RoF2M+Box6IChR78Mpww9xgpGGos8YphvjlfFvKSDFKxBPKOl+hy7WBcnm Rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5awvpxjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 10:18:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q8Powj007074;
        Fri, 26 Aug 2022 10:18:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n58tpv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 10:18:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNNubIRiYmJHk15KwMAWHTlL29rltoeRedXjsTCjX9FZKuT5XY8Zw0LDXLJhB0BrP5FfqvqslY62gQKG0pEIeNghpC9Pmcyat/u++Lmk6S+esMrteETso1PzHRQ379Xu0jA/Po1K/YgzenpyDptJysfZwQUTl86UvEQ+3TSsWBpsJdPWOhH/+b/qKl2cVBqFq+3x2dtYEBE55+yg66aoyGGz4M2awXdN8uUUA8BEzJ45pV4eMqjRrP+cQDzY+yoUBzW3A7P0Qh8jq7ga20WCfFJ3hx7w1/iFm7zE6xsHJ18mDqUJf2vrf3LA0bKf6Nd5iZuF6V4gU3Fjd4D1bKG7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Frh/ht1oAZXDbP66uBpbPsvKQeuGk/xxwo3yiT95fRU=;
 b=MBTstgREg5ZwhRW5UbZOqGoT41MWhxyyYzZF2MJRVKcErnyR7iDL4pGKvZswMh+pyqan1ftJXIT7ADL4gWwwgAHK0tqj5+hCKbiCvJ6c8xc00jdUtVffZ1SwvbaVrmZs7JOVCtk8g7CNaq5boGmErELHZANJ0kXZ+MmeRJT09yUsRdwdUGqw7coLnqYaILKaQxnWNrN9gqj2XYeivJBWtrfIDbh4OZ3kSxivNRJ86n4CZ7aWZwvUiBwAF6Oe+YyRg6+w0CUGhRaqSLKhOqnTmnOPB5dTGTSyrUp6jX0C7qKiCcpHsnHblPpyLAHuBgtDaAzcm+SxVugYTPhxMArrIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Frh/ht1oAZXDbP66uBpbPsvKQeuGk/xxwo3yiT95fRU=;
 b=wftC+/ohhoJOp3cnXJtqwuEnVSgnRddERI5weWBMTm83pl7p3/ZUwYsq/CVHRzgx/9tVJV4BCPEzXgCeFf4zPhScE09hYQW9NL6ELysdK8Js6krBSb8T1iAUaOxnCZ24P8mpZaMkCMqyOHksE8CBsQC4OCA8m2cqP71/NPhn5ww=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4334.namprd10.prod.outlook.com (2603:10b6:208:1d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 10:18:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::f164:f811:6e47:b7cd]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::f164:f811:6e47:b7cd%2]) with mapi id 15.20.5566.014; Fri, 26 Aug 2022
 10:18:18 +0000
Message-ID: <ae82f677-42dc-fe00-d7f9-0b9a71ebb16e@oracle.com>
Date:   Fri, 26 Aug 2022 18:18:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/2] btrfs-progs: read device fsid from the sysfs
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <4a7ddf8e-f283-a2e8-3c96-c67ae4b3bf5b@suse.com>
 <5f0ab29e-c557-d67c-06a6-9dcb7d850cb9@oracle.com>
 <20220826081444.A633.409509F4@e16-tech.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220826081444.A633.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 480718b5-9a22-4090-5833-08da874c4b82
X-MS-TrafficTypeDiagnostic: MN2PR10MB4334:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7R/UYPH0vBhNqJZphuyQWZILGJ3NZ0z+uYBEeyx6FXSt/M4IaSjYeSaBmNoobU+L/8x4f7fvQdNFRCiZv+jrCeA11Xo5VycTlCDVwn2tlFkP81PvvYtLbT6ifjSMSAc9BH7SqbB7sXWUgbwXKMA+BagdnsWyo3VBiPpOGM/CZjauAl3xfXM4xygXv6wkJPyEqzPWw255Hbdkm80iqapxH8Vzif+UOBAhH/EqoE0tFNGuWwHUdLo3PR8CWc0z5oi/yMQoVpFu0LCVs+7F12enHzy1W8PnWmKhsPX2MHXkCbDVK6XeuisUuI7DvsmoQjLS+vG9+J+mJPhxJ9iJ+c+aEfI6xZoA+/GkHlx9IW66EycKVe69LmBkQNMo0+pYD+KjVdcRAgTzvBFYu6vfp6t0F4fYOGZeDUBxmyahBixbHqKuuMsvbpZv4wawNEb1EMV68bOOhRXF6OxoLktiq2d5rAEKHjl0LuUDY4F1uIhi3kE2qG25OKRWtOlBKnXnHUKpOaPsjCZwzp/ju8LaNWju1/ReSVapbgjgBmqo0GOy4w2RJL0HFQO7i+xJpe0ItTlR9CMt83mtNgiKct214RfbQGhAcSB8nHCiyqgT8Yc1oUN6vFsPLbQOdLor1l5xjtjhxXR7y0giSts34lM1XQt2dlXIcgh3BsI4PJVWjSNd8Etbp8QE36KE8Scuqh+yzNhRBMilSFdSsHAamzEWFZfjGq7lbPniggEus7n32qyK5gRIV+RVlBiF3M89NCeJZTs/9twLIYLhs8JLoN6fc/yfFYVY76mA6U4JBm1B/P3eJnI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(136003)(396003)(376002)(2616005)(83380400001)(5660300002)(2906002)(8936002)(44832011)(66476007)(66556008)(66946007)(8676002)(4326008)(6512007)(36756003)(31686004)(6666004)(6506007)(478600001)(186003)(26005)(6486002)(41300700001)(31696002)(86362001)(6916009)(54906003)(38100700002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEhCdzFMbEZQeGd3b0Jza1V6TFZiM3VxOU5RaXdFVjFreEdwMzk2eFJiYmZS?=
 =?utf-8?B?dlZqVVRnOUJNYnRQdTV0SjdPaWZNckVEamdIZk1FWUMyQ3hybDJZMVU5NXhE?=
 =?utf-8?B?bjhIYUtZUVZLVHd3b3JCczVYMDdaT2t5dUZFWXZoRmovandvazJCNndVdHRB?=
 =?utf-8?B?QndsMmgrTW9lcmR3REJtblZ1T2dXckVrR2JLVERWbzlsNGE3Z2RPWEZsOEs1?=
 =?utf-8?B?SVZualhUa2pBNVdSKzFqc0ZJUEtnOHhJOXM5dmRXY1lVejlmNmpNWVVnOWto?=
 =?utf-8?B?YXFjdzBzUFk4RkxXNy9keUlvWlR4OWM0cHJ2OWR3cTFtblNzRGZXSnNWRVFM?=
 =?utf-8?B?OXZsMjJicEdNNG9FaUkxZU4xOGdQN0REcHdHM0ZsWmtXd1hFdEJPQWVZMitm?=
 =?utf-8?B?MWJkRm5kU0F6eUY0Uld2ZlhjdEtGRUozQkMzMW14L0hGeGtPMkprTkU5OTFt?=
 =?utf-8?B?K0dOSy94R0lVYnVKeEI3STZEYURQa1BOdWJoQWtuMk03V1lGbnhLUGwzVnlF?=
 =?utf-8?B?Rk5JRm4rVU1ialJFbkFtRHRkcTMwbmFrSXBHMnJwSGx6S2NPMS9SOEt3WWJx?=
 =?utf-8?B?RTZtR3hneFMxTllTcm1YZzNQcFFmckJhWUthKzF6U3FMSm15YXptdWRURS9F?=
 =?utf-8?B?c3BhdlF0Sks1S0dNSlI4cEJRbnFXWmRhL1ZPMFhSY3BHZFRkZE4yZnpCcXBP?=
 =?utf-8?B?ZzBBc3NOWnB0MHdoVnlDZ0xWOEt4UEFqUGw0UVhJYzIwc0ZOeTVLY3oxVEJj?=
 =?utf-8?B?alI4VzJqTUc5azI1Z01DanlrdEIzaENhOWdKNEhOOXQ1cVVqVEtJNVk0U3JS?=
 =?utf-8?B?Z0tIUTJCNVdRbnNMYy91c0hWLzRyMXdmZm1VVDFSYmV4dFVpR2NVVDdmZ29H?=
 =?utf-8?B?V3pkbjNIa3lkUUV3L25sUmtaTkpEWWpGL0tUMWFPakt5ek13SGxVT0pJc0VM?=
 =?utf-8?B?Z09sMnUybW9QWTFPbm9lTEJzWjYzRWU2aFVwaFZkZWwzNnNiQWdSTEpMU2Rr?=
 =?utf-8?B?M0dXNUl6c1l4V3hhWHFNWjZ2Vks1Q2tFR3FEbEhVV25QRksxSmRDUTArK1VR?=
 =?utf-8?B?QWYyYyt5L3llUmVpRzhZck5aNGFkUFFYK3dGYWpML3dMM1ovNU5KaVNBdTA5?=
 =?utf-8?B?NGllOUt5WC9mdHJCMzg0M0lVRXNITWp0dWVtUVg5aUNPK0x6bUdBczhacjBJ?=
 =?utf-8?B?MG05RUtOZzJiUGxWbTFvdHRzL2hUSVJaSlFHNDRBMkp5SHI3U2tKS1BBald6?=
 =?utf-8?B?bitOamZ4RGVrU2V6bGtDYlQ0dDZzcGJQRWphckI5K2VNdHBhaE0zWmR1Y1V5?=
 =?utf-8?B?WlRLMGpQdlhISXQ2SDluWm1RUjlKb3dUWFVjR1Q5dlo5VjhNVlFaeGEyMXFD?=
 =?utf-8?B?dU9HbVJOT0ZIbDVxUVBjVGZzNmRkVWwwbDEyd0NMNmx6RVpRSTQ0di9Lc2d0?=
 =?utf-8?B?QW5xblVpNHBONzFtVGNMVG1QemNDUHp6My9vZlF4d0d3NTR2YmhvaURJbXkr?=
 =?utf-8?B?TUlzTzNGSnRLVE9Jdlk4dnByamxib1ZWaFBDSHVob2luVkt1akRHM1YxRkw0?=
 =?utf-8?B?MUhUTlVnOG5VUVpwcVRzQnk5SFpXbStSR0tHZmtjejlZVVZVWGUyR0VpRlA0?=
 =?utf-8?B?VE5qSW9iQ1hiZXN4S3ptbm5Oc1ZFRVVyZUlzaWtMMElOV1ZJclo4ZFlMaisz?=
 =?utf-8?B?ZCt4UGJJckxndVdKTHpvS1NLWDZCZ0NPRkNzaDk1MDNnRURna01xYWZmL1A2?=
 =?utf-8?B?aTltd2x4QUVtNXl1M2lMKzU1eEljaUlQVlA5bGlZTW5Gc2tnRDE5UmFWQk5O?=
 =?utf-8?B?SUc0U1A4UGk3UE4vMThLZnlxYU5iaTM4M2Q4Y2FWektRNVVyRUhtRVlSVVJT?=
 =?utf-8?B?cG9DcHZJYVMwS043RGxkY2U4Qm9JLzI2NjdveDZnaXkvUWpaS2VFeHJrYWlj?=
 =?utf-8?B?ZkcxQUlzdGVBWjZKTUs4RDdxMDgyVHdqUS9GcHBuNUNxa2hpeVBzRDk2ZzNj?=
 =?utf-8?B?dC9yWTJDQUZ3UFk0Sm1SbmJBRHZHdlFxdXNEU1lESFo1SEhYeFFwMEVMZUd6?=
 =?utf-8?B?QUpNd1VRdmE5QW81MGJWUCtrRTVMemlXTEw2dDlKd3FVR3lVNEdmeEZwbjZj?=
 =?utf-8?Q?tur6sbUT5iQC/zzknp4BC/8Cg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480718b5-9a22-4090-5833-08da874c4b82
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 10:18:18.4193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cgv24zbkvwVAFGZBBIKIH8yLRbMCPjxVTgLIx5TJmS1fMtcXP/+uDNeNPoPpsoywtbMX+ve4Xg7N1vRald0KCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_04,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260042
X-Proofpoint-ORIG-GUID: cQyHvKctpWDPTo1zYwgzjxVOAmywm8zf
X-Proofpoint-GUID: cQyHvKctpWDPTo1zYwgzjxVOAmywm8zf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It worked on my end. I am on 6.0.0-rc1+.

Without the btrfs-progs patch mentioned in the test case:

----------------
btrfs/249       [failed, exit status 1]- output mismatch (see 
/xfstests-dev/results//btrfs/249.out.bad)
     --- tests/btrfs/249.out	2022-03-19 20:34:36.307019541 +0800
     +++ /xfstests-dev/results//btrfs/249.out.bad	2022-08-26 
17:23:53.912993906 +0800
     @@ -1,2 +1,5 @@
      QA output created by 249
     -Silence is golden
     +ERROR: unexpected number of devices: 1 >= 1
     +ERROR: if seed device is used, try running this command as root
     +FAILED: btrfs filesystem usage, ret 1. Check btrfs.ko and 
btrfs-progs version.
     +(see /xfstests-dev/results//btrfs/249.full for details)
     ...
     (Run 'diff -u /xfstests-dev/tests/btrfs/249.out 
/xfstests-dev/results//btrfs/249.out.bad'  to see the entire diff)
Ran: btrfs/249
Failures: btrfs/249
Failed 1 of 1 tests
----------------


With the btrfs-progs patch mentioned in the test case:

----------------
btrfs/249        1s
Ran: btrfs/249
Passed all 1 tests
----------------


> [ 1064.768430] BTRFS: device fsid 00ebd666-e838-4377-b9b6-aa69449297af devid 1 transid 6 /dev/sdb2 scanned by systemd-udevd (3602)
> [ 1064.781504] BTRFS: device fsid 00ebd666-e838-4377-b9b6-aa69449297af devid 2 transid 6 /dev/sdb3 scanned by systemd-udevd (3605)
> [ 1065.065938] BTRFS: device fsid 00ebd666-e838-4377-b9b6-aa69449297af devid 2 transid 7 /dev/sdb3 scanned by systemd-udevd (3602)

Two processes 3605 and 3602 are scanning the same device /dev/sdb3.
One finds transid 6, and the other 7.

You may want to re-test on a clean machine again.

Thanks, Anand

