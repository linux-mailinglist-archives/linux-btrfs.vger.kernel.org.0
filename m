Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102B26141F7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 00:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJaXuV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 19:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaXuT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 19:50:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E1C5FDA
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 16:50:18 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VNhjdY013958;
        Mon, 31 Oct 2022 23:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rx/PdjcjiGVM7sn9vzCTVAJ9K81onGXc4LxeGc++7GA=;
 b=nftx1mf2ZJDAS2QLWWHsOEnA1EjX3XHhEkR8d6UBmc3vIUDViADGgu5Ip9Jn5XPLJGkk
 cTmfa15KjIxgoHweNIFNtU8jt69YHF6CqTr2oy04zQSSCHqzryVfMei0IJXGl13BhOAm
 /D4Bq/M0BIWy69dVXckQMlhH4/O501CIlwEqr5+nGowNt8oM8JLCJDSToivs2KXTKfds
 aOqVLHxeeTVJrlLyv7ub3ODJxYNOrCCFGFnj622wQYB+MPA2rgRai/xCOKD9eBp5Xszp
 a8t84LbFns95Ge61hhBYLgcJRzZeXsBI/+p8ImB1s5ytzlHeUML2SnSRdFAXhv6BKDS0 Fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkd561a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 23:50:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VNBHwr025892;
        Mon, 31 Oct 2022 23:50:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtma3gpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 23:50:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD+6t4uKZRS8Dm4HlVFteoo7ovSBcf24cfTXyZ9xTcWl5cZ1MsWTeeM8a9C3scaJUYD/NJll6Ap6B8aoQMd2G4yRcauPuqSkycKE6yPceUjGjqu1lUUKLoB0dfh6rLFrq83kNwWEPgBtW7E7pMyqR3v/+Mi1n7/kdxOJhFCzPX/bJZ0d4k4229GQZ+QZJh0OUWZOV+S2KOG+q8A/1ukxA4IuofZixHYDaVq4faO4Xn3pR6j+jonBVDQ5gEYFBjw7y4fUORFfp7RwkXM1nb7VFNkxT/6jKJx9t9xgQlC3Wl59zqxxhC6sVSRtjEfKJd+G+eKgfN9PQDH/CbFsN/mD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rx/PdjcjiGVM7sn9vzCTVAJ9K81onGXc4LxeGc++7GA=;
 b=iXWQcrhEJ1/nT3BxCJEdutlZzabcT8VFtiY2m9sAJXfqNnvU/5XD9nUQksE6cWkjHJgY+ZAvrZt+pbbKhoZgc6EGcviM7w5yeBt4U+GzUP4ZKizUcy554AGqoteebekTvswjnrLTVN0oWbox3RXLuDVabVZiOalO3FMCdd8TRsvrvlPhbjMYE5OQ4JEhLeDecN7fJH40JVCg1mYYszaLBFpt81qPBDY023ZwKLZyGzBClGMJvAyLWssRj3a/4WYfFbQMmmfuy3GgYKIW16h6lihjDBsX/hCNS2SbuzGqKbwGxIU/Ea1zLZns+OqrvDT52B8fKDxucGCNfgwHOb/JHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx/PdjcjiGVM7sn9vzCTVAJ9K81onGXc4LxeGc++7GA=;
 b=Y4JwhQ8CBjZJqmGulP2lMy4P50xgJRHnBCM/OQuiCljLE1Jt1gzU38NpRtUoLqZUvqNxRlMFcinaO5enLmk1zUZC4wr6Sfh/913OXcWlJmA4gGGdkoGRz1+QE1vAuLCsB9QE+j9DRy8eoIyZiKbSisgu3eC3o2pwpXRd9WmV98A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 23:50:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b%4]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 23:50:12 +0000
Message-ID: <a30f3693-fc8c-3a02-253c-03947bd8724f@oracle.com>
Date:   Tue, 1 Nov 2022 07:50:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 3/4] btrfs: convert btrfs_block_group::needs_free_space to
 runtime flag
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1667244567.git.dsterba@suse.com>
 <82d96ecea726e51be02a95afb6726faca47727dc.1667244568.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <82d96ecea726e51be02a95afb6726faca47727dc.1667244568.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: c1921a38-3bde-4aa3-7849-08dabb9aa688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GsBBATIig/8W5HBYKT413Z6SOl1Otclf1/wA354l3VzhYFtr54cFCnl8kv6fSxjTK8Km184ALNd/SmiepmUfkhVzUPCmbPlKw8UTD7q67SKlTiXtgDBsP2NTblN0AgPwnbk+kQFk6UeWs/VgSsljaJZOd+hdh0r7o56Fh49xlWW41jzkMhgR5fRu14bJJSmSpGNQVFTucArTnUKOX23Ttxcmkidsjo89S5uprStGz/l/wWCwAGOgzRYoUGJB4Nm/YnH8Xxae3yPIf1Vikib+7jnWR7pezBUa/ewb/RhmcRSVviTS5TzkePHeOVGx7alhQZ2LJW9qCb96GlYjEHGbDp8xgdGFT43mpyL8u7FbD0BExlY/CXEgCTY4a+PhA3Qd+2XJ+hXJARRK8Jboupt1fbztqvwQa82pgulxFHzzohHYBSiawWoVOZIdThPSSPOlzq77kanqBUrseanDZ9rCOLgkKO3AWoJkUtpX81dGm5c1sC1HeQgiB84J3m1EJpWMVsOwkzwNHh69uUKXA8YHOypo+EleiYe3drtBapPIuLYmMI0EfQ3/Uls6CoUWMv/hTWWH6BoN9aDA+/KbjIYXiXo2j6iSRq9j0ueQnwWRJhOvblyJhf2w8+CqscuRgRT7wAGWrqneZICqeYHVYrm0zlLHZrkznj0sLxNPpbWb/fVaBelv+hzHuUs0Ni20YuzRH4JmVJMP8HiiQyh1xU1hnsU2lv6j18OEyVqIQAc1JqCzxGPhc06CsiG6rFd2/WXpNazS6Vwq23GNuczNFLHyXmhenNnqW5p6omDwOxPo1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(83380400001)(2906002)(31686004)(86362001)(316002)(31696002)(53546011)(8676002)(6506007)(6512007)(36756003)(558084003)(26005)(41300700001)(6666004)(38100700002)(66476007)(186003)(2616005)(44832011)(66556008)(478600001)(66946007)(5660300002)(8936002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEpwMDZzOWIrblZLQXNueS9PKzFmelM1RjVzVmMvUVRveGcrSTI5QVFla2Ux?=
 =?utf-8?B?THZZd1gxNjMwVVpQVStmcEsyL0M0bEZRTERHeWJpYkF1VDZ4MElSSW5rbGlp?=
 =?utf-8?B?NVVJYTgyZnJvcmxOYkQ0T3paM01YNkwvUlA3ZUhMc2ZLUjJ1Rk9HSmNIRHU4?=
 =?utf-8?B?d0pnTTZWYTZyWVZwcmVUUzVDODNWSFR3WGJocHVqeGNOVGxtdDNSS3lpL0Nu?=
 =?utf-8?B?dmNndStkVTZJdEQ4MjUvUEd0K2lIVDFYSmt2VVplZDcyWnpjdFloZk00RGVq?=
 =?utf-8?B?ZGNyRzBsenRFSG1jV09NUVNELzJZeXZIWTFJMmExaVVhZU1OZC84UUVZbk9Z?=
 =?utf-8?B?STQ3aFhJZ0FDdkJ6Y0tpVFh0SnZrQzdndDViTUFnUEtPM080V0lNOVZ4OS9O?=
 =?utf-8?B?cUxPS0tUa2M5dWYwbG5yZjU3RGF2c1IrQ1FscWd2bXBZNFBLU3VwSzk4dUpY?=
 =?utf-8?B?MWZZUHk4ZnUxbHU2bXdyRlQ4K2lsSEMvUnZVdXhmaTkwb1pRUGE3L0FYY2to?=
 =?utf-8?B?MDAza3lwalFlZy93eE9MZ3VPWjhiOHhXU1h1UFNhR0dFcnNIaENOZTRoVi9C?=
 =?utf-8?B?dGs5TTh5bGlLWGJpZlQ1SG1DRXl4MjRuTzQ0d0FXRGhvUWZ1OWFtUEJ5cisz?=
 =?utf-8?B?UEk1S2VMaEY3ZWFmWmhtMDZNQ0FZZ3lqVUpoajlSaXgva1FBM1EvMitWeXF6?=
 =?utf-8?B?UG96OW5LaXVHRnh5eFJadERURklqTFlMRnI5K0htd00yeDVpN1FSZnVhMXBu?=
 =?utf-8?B?T2dOZHp6SW9VdDczYVg5UitzM2N2bnRyMWdLbE84Q0VieG1jb0NGRTF1eHJ0?=
 =?utf-8?B?VVg4aG81MG0rcVdQaytaTThmUXBWaWFqcU5SdlY2QUhpQ2YwSjd1SXZkWERh?=
 =?utf-8?B?VjJUakNQbmEraktPMXc1RGFqbVpvUGpqSEpjTGIyeUlhdDl4b2lucGVQeXpO?=
 =?utf-8?B?WE1SZkYzQmtwa0tUY05ucDlneWM1Znp1Q29sR250OWQycWU0MkdtYzBRWWR3?=
 =?utf-8?B?QzZxc1BCbTRTQVJIOFNqUDYxTFUwY2U5b1ZSNkd1S1UvVk8wSTV4NHJWeFlh?=
 =?utf-8?B?QXZzdzRIQnRNbjNwZGhCVUZmeDFGSUdFa1pmZXFZU2d3ZFVvYThnbjA2TmZQ?=
 =?utf-8?B?SGYzT1M4RENSWkhLVlpQV1BZSDA0M254bmtxQ0tnakVDVVJqa2ZrMHVZUU4r?=
 =?utf-8?B?TFBZbUlvSFQ3aWFlU2dHbFFiMXZhQ2JCTkZXcWU5a1VFeVkrdU95bnJvZ2Mw?=
 =?utf-8?B?M1hDRTlKMWFtWjk3aEgzVWxRdTAwWjEvZUx0STc2Y3hSOEhlcVpmUDNTOFlU?=
 =?utf-8?B?azg1RHpWam9IL0lVRGlTSG5KZE12Z1dBUkQvbEdjZThwbi9UWlFrUUVkdFdo?=
 =?utf-8?B?TmU0cVVXNzFPeHp4K29KV2JQQVVGZXhtZU9MTUFWVEFubHllRHJmWWMrNUlm?=
 =?utf-8?B?TWNtV3ZQNEhMWEQ0Q3lVNzh6eTd2dTZBVjYraUFlNEQzdnRHelloekZHaHFu?=
 =?utf-8?B?eVN4b1JNcGR4L1pvamVZUU9sNHREWnk0VmhabWtqVjJKNVB6ckVOSzY5MUVj?=
 =?utf-8?B?ek1YbXhadStwUjg0WmxOSzl2SjI1UXRBOEs0bXl1Mm1QVnM5emZwdnBPcTVI?=
 =?utf-8?B?QzF0V0JRQTF6OFNkVUVmNGwzM05wQUh4dlAzQXZCLzE1aXkzZXkyTkN1eElw?=
 =?utf-8?B?WmJCdHNxbXo3OHB2RUtGV093em42YW1NSXlCWk02Y1dPRFkwbTJpM3oyaGxJ?=
 =?utf-8?B?SDREOFZMSmpvaFhzRksxdWJqNkZ6VW9NcmJDNEltbzlENk5Vc0hIcytFSSsx?=
 =?utf-8?B?UUF6aE8vWXUvaWhKQllsQldYVnFLNjdZcHEzaGdsNXhyb015bEFHTm4rcmQ1?=
 =?utf-8?B?RjZxa1hMVXdiRHFaVkdJWHMyRlpSSzlqMzZBTzJVaVU1Q2N0Tk03S3psbnNT?=
 =?utf-8?B?R0hsNERGVzFOeFFYN2tTRi9aUGNxUEgycGJNeXVTRUN3cnBmQnRmNHBKd1RE?=
 =?utf-8?B?Q2YzdlVJditaK3d4ODJsWm9ZbVpMVmI2Kyt2K0ZqMFNvMzVhNlRHYUZabWM3?=
 =?utf-8?B?KzRqRmZGNjZHUk1SN0RTTWNacEw5cnpzbzU1SFZocDhXRjRRMjhXYUlYQWhh?=
 =?utf-8?Q?oZWxw72Pd5W2AC5METMfz96Me?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1921a38-3bde-4aa3-7849-08dabb9aa688
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 23:50:12.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tSa0ome6ndSJQKtd8sxnvwewkhpNBi8ZzZZd9cLxl0AeWiWkgY2Q3gTA9CZdyQEx9vng1fTW+mf96PAKKGgww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310149
X-Proofpoint-ORIG-GUID: eTsnPKX5Grs1DmHQVAZtBvbX5ljTuNhk
X-Proofpoint-GUID: eTsnPKX5Grs1DmHQVAZtBvbX5ljTuNhk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/11/2022 03:33, David Sterba wrote:
> We already have flags in block group to track various status bits,
> convert needs_free_space as well and reduce size of btrfs_block_group.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>



