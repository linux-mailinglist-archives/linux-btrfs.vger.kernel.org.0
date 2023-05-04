Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919E66F67B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 10:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjEDIrV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 04:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjEDIrM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 04:47:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C94420B
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 01:46:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34445Jfh005132;
        Thu, 4 May 2023 08:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Nx19XzOyvixbH1qGBxskJe04GHQqV0/I5XUE1JMC/XI=;
 b=gUruxEBGeBAwiM1x57k06osXszWQ0CuM5lT71tC0wKVfjbAMjl1KDB1VXWXZvWKXUIa9
 d46dJjuPoAha1s9oeMH1Suas/o8atR3uDyYfVhfW3wT/koj8zUBRO1ELppT/vKceftHc
 qIHNu6UI3ODlq1EdB4h57W4oIgRwJ/wXQbkpYj/bObH34D/yuUfGcY2gfS2d8+aGPM/W
 ydLr1sTtEjjGOU/3Sy4fD/ZlX2BQ2Vie41KyQFHcA3b5AhjDAOGEhxsc2YxRv7N6FG78
 Qa3LjvJjO5/WXcDKEiXP5ISsnD4kubl+UZoQhOSRkIKgYjmCs2iFTDGZkCIreePom13Q CQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1sae9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 08:46:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3448datp040441;
        Thu, 4 May 2023 08:46:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp88086-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 08:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUHMpWQFc43O3e8ww1l219v0DZkElhImyTosmh2jWDifLBVHtByPIpyfMTScoo6MdeGL4AW8Rpzw/I10zPwM7iQHOCTgoKD8iKrHVpJH1Ghg9x97RBSkulGS2RgjzLqW3p+NIFaFpmkmDfKdLZyBRDjCKemLs92AFdy9izncQp9XSiW3K+0Z+eYyreHlZhVwffcdRxnv3HhW0MQTcvx3la8Iv3eX+Vym1ub2miuFMhntaNR+4oyp33Hi1Q32fuQ5jDDLjnHKGgVpciH7KSN1H5dx0asp00MmFREVXDT4UHJHUfxDCxC015gjnzwyiUlebHIUzUlOnZ7BC1vp/MkCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx19XzOyvixbH1qGBxskJe04GHQqV0/I5XUE1JMC/XI=;
 b=i6OzjLfvYA9QMuUatrtjS1KyxnrJmynFga2pbkerSxluD7yR7q7xCRJW6C+cH6QNtqQjE+IZMiqJ1SnY3BY9EY0YI+xBJzDSCmFWCI+EMHD/Z0kYlzTjYJ6jMfL/ozByjiIERF3S+tnre4oexDAG6q2i5wz6P9ieYdb64Rh9/VhMPMAtep5/ZHySGBR5tfTpIVJ/9qUeVmTeFJK2CiXOfCgMfokUD+lN8+Owm95a+BVJoKADKFIxPzwkYIRu/Q0gFcn1Qv2+4h8cfrT1rEPqGh0wHVByuR2BDiAQRH7mQwiLfpUEoWCYVm06RfwhF8dyWTjS/lRSnATeeR7BYRhcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx19XzOyvixbH1qGBxskJe04GHQqV0/I5XUE1JMC/XI=;
 b=pLz97aQu5/7WBBeuNjxHrins6WPgAwlcBa2VtIaf6niLesgP2ngL9ka4CCsKAVl+wtWK30z0zc46RyhSXHgwHPy2r+NzWuFbj5e5wa1atyz6L78DYapVzf/Ff48wm4m2p5tR0N+LK6nfsGT952uCo/tCwF8qH8a3H20VYcoLnh0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4140.namprd10.prod.outlook.com (2603:10b6:5:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 08:46:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 08:46:47 +0000
Message-ID: <bb3057aa-d3bf-9733-b366-b17479da2a2d@oracle.com>
Date:   Thu, 4 May 2023 16:46:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/7] btrfs-progs: remove function
 btrfs_check_allocatable_zones()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1683093416.git.wqu@suse.com>
 <8358b7a43c479769bf32c1ccac24284442ceb567.1683093416.git.wqu@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <8358b7a43c479769bf32c1ccac24284442ceb567.1683093416.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 513d626d-3a2e-4ad2-cb22-08db4c7c181b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFgg0OxEpiNhIbv2kWSYnmdY0ev/uiskQ6Nicxr+LVmhOd6ygpp70QyB+/67Asey11trozZ+pLUltXl70nzR4GPJ/UTZzV4yT/OP5Lxe0U/Vzvdq6zuamuzeUw8vdXzJcAVx6flzFMWQCZ5pHS+hwgGejwAhCQ4qMyTVDWxEhETt295WBRFbLTl4EHQrloUoXAuKx4VK+WpRIPiHL8NCAAphisHKhsTHKDuMDfFZp3M5XGPb/GdpeLzg9/0skZgwO/YS6V8AU3PyHzbBXVWPpkHUn9BDW4loHorwLRyfowNvabuwR2n4MldDJ6rt7t3cG6HKIDYF0gle5D7PX35EvurMWofvdKfWBxbVpnuliwaZDMk1cRuj8jo3bSq0zuAgjO5qMNbc0aO+eFNdE6i4GsJLdDtHzXgslishXS5gPDwDDcrTnw7GNaJJBD9P8L4QbXKJBAI1TnvCWR0WK3i1VoLyptxeRaYbDXua3RSyHHRZyt4AuORfsbHRCiPwZbiwhw0ctzq6F4Ytyu/drYCs3ozAIkRLYrq2YW+979acdUcHxcMbv1v9wC6FQbjIZ0j+RHNpRfE+D5ZC2AbOmmpd2k1YwTjobCsKxVL0KqbggAZwPzUg1WCPQ177vtNYOpAyBwf3zJ78LZOwUPso+2Kk6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(41300700001)(2906002)(4744005)(316002)(5660300002)(478600001)(66476007)(86362001)(38100700002)(31696002)(44832011)(6486002)(66556008)(36756003)(6666004)(186003)(26005)(6506007)(6512007)(31686004)(53546011)(2616005)(8936002)(66946007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGZoY05kWWFzbnA5LzArdlpzNFozcmxhVTNCbUFSMmE5Y2VjOEljVDhsNnRm?=
 =?utf-8?B?TlVIU2FtOVVtaHhDREtBWXN6TmZMUGdmVFpMcE9YWmlDMVUxQUFwWVdvSTZp?=
 =?utf-8?B?cERaZWRSKzlkbE12TXhmMkd0amhxRDlSVmY5LzNUTEF2WlNhSlhBS0ZHQzRk?=
 =?utf-8?B?aXBTdXlrbFZWK0hhV2ZnenF4K05IMmtia2tWdEVkd1R1RTB3MGtmN0NJVzNM?=
 =?utf-8?B?dWFJRXFZZnZOaEVhQ3RiYnUrTFRGRlpMWHFxbUQ0RjVWRERXVHFtK2huYlZB?=
 =?utf-8?B?UVpaNlNMUm5xbkJqTXVKYzQ2VHVleExrYThYbmJiQ1dMSzFuR08zenpHcTBQ?=
 =?utf-8?B?dVhZdjcrM3VKK2NURHJWMUVXV0pka3B6NDlpek9pTnlJRFJqZGZHcHhGVC9s?=
 =?utf-8?B?b1B5ZnlGTnFERkJiaVpvTUNYbjV2OUtoalNTVUJxMjdxUFZyaVZtVks0VkJO?=
 =?utf-8?B?K1dycEozSWJ3cVJUL2Fia3l4K3phWTZPWFI1b2QyVG01bzBoU2tRVjVzaEZX?=
 =?utf-8?B?endtNHVPL0ZJT2FCNWtwek1UV3FRaW82RXRMcWNrZ29kYlpEa2djZnF4ZEV2?=
 =?utf-8?B?NVNONlVyN1QwL0p5RXQ0Ulp2Tjg4SDYyL2xsVkJQMDZEa1pnVXVSSWs0ZVR2?=
 =?utf-8?B?NHZ3WEU3b0NsdkxIMmpKUmZMdWlZMmJDRVZKMWsySUsvaHlVQ2diWGk0NmNr?=
 =?utf-8?B?UHpobEpSZk85ZDdhU3pBTlpLL081djZ1SGN3REgxZDNibVNYdEVMVlNvMzc4?=
 =?utf-8?B?M0xGbUpDMys4cXN3cHNXb2hJaEJEUnhPRUttaXBzK1FSU2p3cEF6TUpYZ1Zz?=
 =?utf-8?B?R1JKMUhRS2pNSVY1KzJTakxYN2NNdWJyUlk3TndPd3lldDZ2RkoxR3lWZy9J?=
 =?utf-8?B?Z2h2STJMRG9OazQ2UTFBR3dkeEs2UkJQN3NQZ3FLRXVCOGYzU3NDb3dlbTJV?=
 =?utf-8?B?bGxCLzZFK0VoMUFYenE4OStRKytEcVFPcUdpL1FLK1FPUmtMV1R5a3diSkxJ?=
 =?utf-8?B?Tzh3LzB3dVMxMDBscmxHTlNXL2FjUVhMSjRUU0ZpdTRZVW5YSmNPUTVINE44?=
 =?utf-8?B?OEkybFc5RksyaWd6dXdwTW5uUTFFaDJRRUIrUFVLaHNSa0hLVHRuR1l6OEVO?=
 =?utf-8?B?QXU3d29sUHBueUpzMGYxOW5NajJ3U3MvRGcwdEdKOEVWUGMvcm1lc1BVT3Vh?=
 =?utf-8?B?dnYyQWJtSWk1QXNJMmpucXdWcGR0OHVIMElHVlZYTzB0a0M1dU03ZkJ2ZWkz?=
 =?utf-8?B?SGV2NWFzZHduRWVXc0NaQjBXeFI2TG1CbGdoeXZpRk9ESkUvemxGMldOWFRL?=
 =?utf-8?B?T2tjOGo2bkZFSVhONTMvVThndDdOWVY1WERUK2JnbnpiVW1wUnF5RUhFekl5?=
 =?utf-8?B?UTlFeldVVWswWkl0VWdIUE52N3g0eWMwYW55WVlsNS9SUE5lakIyREd6QzE3?=
 =?utf-8?B?Q0tIamJpMmxFczE5M0xPQ0h2K1A3SWxBN0V3QWdpTm1lQlAvWGRDUkRXZEtL?=
 =?utf-8?B?TDZOMVZwUFVGRTNla0hQOFRJVGdLN3Bqb3VPYlJiWWdERXhDSDFSc3gvUm84?=
 =?utf-8?B?UU00Ly81eWFDUy9mYmkxQjFEZEhyWHFIVFVjZkYvTUpjbDdoS05BdCtPZDZ3?=
 =?utf-8?B?SDNlaFFjOVFDeExaYkc1WStTN2dIeEZHVGZzc1ZxMVg5RnY1Z0w1ZHo1dHND?=
 =?utf-8?B?eWxlM1JLalZXa3dlMkg4c2xyQWt3R0N2ZFAwTlRma3ZEcG5OdHNUWmMvTG9i?=
 =?utf-8?B?OE5YKzlrRFBWNWJzeVVsSlhDK1JlY1drc1RlTE1IYVQ3Tm5YU0ZxNzNRRjhl?=
 =?utf-8?B?Sk9scnZnbmJnOGFESElDWVZ6cFZycFZEZzVXNDc4LzZqdEhaM00ydS9XdGI4?=
 =?utf-8?B?bjRoNXA0Nmt6azUzY3BZajZaWTU0U2RIMjlKUU8wK3dIY0U5VkhQdWhzZmth?=
 =?utf-8?B?Qko2MGdxTS9MTG1VZEkwZzU1a1VwYmh5VnBqSHdSaEUzdzZNbzV6RjNIelpn?=
 =?utf-8?B?N0FJTnhrWnFlcHhZWm84WEpPa2Z3aTNHTVBVZGRmMm5QNXhXMXdCVDc2RFpo?=
 =?utf-8?B?RkdNZXNndzh1N1pyWUVFUnZKdm1yVStXdDY3dlBFS0hzNlYvYWV4NVRlTlFx?=
 =?utf-8?Q?TVuG0MADdGVV1B1HV51jf5JUQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y8d0zbvDj509YHGEPySQSY1K45LPjThky5KDWYoudMNKODoGCWulUbajOdXU+kt7hnbLKXSJHB31U5bdAJlvdKVhOaFVr7A/DtdLUqRJz02wojOxI4DpSWHc8SoFDJYPadUGC4nUKQwLhP5uqkFCinwDmyxADVE7gknCa+1q9+hBE1arueknjCd5yyuSHjRtl8WOH5ZZlEgKHxZlrhEL1iUqGHFu1fdiqoQWm5+5b9bgZnvfOq7DhuvqTjxP8F6K1tqTmdu/tto0Q/3gmZI2tlp0HkeY4ghGdQzPIgA1HHLodptm6M4hAHPBb7Wa948W6gtX3OEKEkmiPjUk5EC6g6+4cY/jhGX7Ok1E7WLoO46zoQ8qfodd9ZAefbjNGRiKu+MWS+1IZJJZL+tW55FzMZdJoXqrCu6ZlnZkvSMcBeg/2VQM7Ad6W1pHvU44YMwP8KqRL+qeY2iB2xsAPs06gqvOulVXV99DI4DzqaEAltt6GiiBdRU3M3Lh8zMDATAk/BSkZQ+1XkQby/1tnEgiQlnDD9UMsXOy97SdCtgtOCSEjj7nnA/MwAD9N0WRrb7kdJzoEKUOquIkgZ4ds2arecPaDKaCM47CEQj44oxEQKwZMWpJBkL8ZUp6vAaRtBR5xxDUgkaP/+JumAyh649YJ5BORhLsiUfYidRmcs5M803ynNVnK3JOeAZ6bEzJMBNV4feSc9QotciidSZxU1J6b+o8NG+M9UgimzBxrV8kxjmXqLwpTYXamM2tM+QKp4jrSqbY4thp693pt0d6x0inIHYWI3m5jY5nxEx5FVmO1RY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513d626d-3a2e-4ad2-cb22-08db4c7c181b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 08:46:47.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oI0iqDVJzFpVMMXoSojsfnX06zzrO36rm/HjklJ/K7t6oFwNek5+/rBXaDkk+ii//ZOF+TRJm/K7USbC3qe1Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_05,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040070
X-Proofpoint-GUID: DYq9JAEY_XDTlvbJfd28acoIlwW_uS23
X-Proofpoint-ORIG-GUID: DYq9JAEY_XDTlvbJfd28acoIlwW_uS23
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/05/2023 14:03, Qu Wenruo wrote:
> This function is introduced by commit b031fe84fda8 ("btrfs-progs: zoned:
> implement zoned chunk allocator") but it never got called since then.
> 
> Furthermore in the kernel zoned code, there is no such function from the
> very beginning, and everything is handled by
> btrfs_find_allocatable_zones().
> 
> Thus we can safely remove the function.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

