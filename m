Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E2D717657
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 07:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjEaFqs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 01:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjEaFqr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 01:46:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9BE11C
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 22:46:46 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UNOE7t020620;
        Wed, 31 May 2023 05:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rcBEZOwhlfNxzWdpxr6f09IlgU+6ugEJs/vWF82Ou/c=;
 b=nApeRaJu+4t7v0a5PL96zevAHodCK2uiLjpk7CACnJzGMMF/EOcXULULLNJ7hCVCk5o2
 eIJVoYrKngHpZzZ4EgGNDyewzCjqd/q6Nk/4/bASQHlIQ2CHU8y49IAiNCzM2weIp6a/
 iLqNVVNHjnbcnxdP5kw1laPoGCxVOp0iUi39UJcWzESrSxKXxzB5DgrDKIXgTHq72KZS
 68kImesDYvLr4jSm2ryKOanGyedhQO7NQN57wBjO5umy5tYUNT41mFLG3HLGFLR+Cmc4
 DXUrGeqmcsRIOo0h5yP5lKIuQFVPnPginkdQ9RJ417OGenRrXAr1w0Dw+crbRKUrJ01+ bQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9vuq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 05:46:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34V4GMcJ014599;
        Wed, 31 May 2023 05:46:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a4yy7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 05:46:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPv2VaNcZ1YImqINUDFAcYLtU2M3pYu25SXPSoNOl7iAUrVYI5IqJDBpTb+hF6rTtnN5PYJHktD27/xVhPBU0vxJjoS4qeq6wW6/TcJtZzV1JqWgn5rKBNqayCQOVBM3dhnRT6NmAug03rjiT3nSorpWIJx4nji7P394YQ2bZ/DNXRbomvP4vLg9CvcRggQ5fo1a8TXBnC6WDK+zai9ThHyFqeCmShgGhvTkrO69sxwRRdZeOuO1GLfw9acDW1kFNui0tUMq5bTUdCStXJ878B7laHTzWIe30sK1TK5yqjBPAf2loXhxYqdYtId4pvQZq7ffY1q1ZC0PHFpKWAydUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcBEZOwhlfNxzWdpxr6f09IlgU+6ugEJs/vWF82Ou/c=;
 b=l4V2rsWEXak7xwZ/3LTSXX8teVzSxzKIgabu3spSkXaiZAGCF4+DA47/fjM8ZMNp/r3FHXhpfPrIh4PsCWtcl/7bzoiZA/Pyn4INWtJsco1IvaygpfjWJq4RQm96C9M6I3OHsI1X5A7sFsNB9/DkHXH/4e1oUyB962js0ep6uO2/BSiFnljfrgwVs0/bcXxwqpEDvW94nnwLrj22BsCoYIFBOnYw7r/YXeEUzW8QKE3kHzRwZ7gnjIh5P5Wn4DE1kUMITGMSBsUu0ZM2PLrOnXKpmLmBPfEWVqM8SfEaqRsxkEoakjMM1PGXKTA/+/VJbdyHsCaTIXIWLeJfQuTKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcBEZOwhlfNxzWdpxr6f09IlgU+6ugEJs/vWF82Ou/c=;
 b=TBolgQMR35FZmshpFieUvJFVx+yLui/2tBB0BOBjy73eSne7yRfA2qJ+vEw43MklIjkFu2xQ7CiwTnnSwAoIlLjyrm81jpsYlia+o0l9zvUc6SmFGbiloZ5EmyKZhH95NGZbzOU8lGs/VUvhmqxYRT2fevxyx8skQCofp4DODyc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7228.namprd10.prod.outlook.com (2603:10b6:8:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 05:46:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 05:46:38 +0000
Message-ID: <feebdbb8-d7d8-c51a-6ed7-95f18def2827@oracle.com>
Date:   Wed, 31 May 2023 13:46:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] btrfs-progs: add CHANGING_FSID_V2 to print-tree
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <8e152cd504552e92680290cd34bf30bfef0cc1aa.1685440589.git.anand.jain@oracle.com>
 <20230530123710.GM575@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230530123710.GM575@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:3:17::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: b7678ac1-7df7-4a88-43d8-08db619a66ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Bz8ke08kMp8aNI52Z1G1nElnfOVAd40+sqZf6xpmYURX2D+lZRoyzZ7kmdHagmd5MECcTrm9gF9H0cPZNRxsJA5g0dRsHDORO5GamarlLTd/SHpqRHjGbYuEl4CNRG4QmeP4MMilITi5gRUloFSjcJh7E6hGn29WcvIGX9otiC0araAmlLZzAbjYRMN48b2JDvs60SH+zlH4gO0W9aa7HU5s1UY0sA5Zlp2zgChkvt2O4ALkxXpx34giWNtyO/G0kyH9Pl8Wy51eiSWuF5LZqTPKEZj3ifQU/Tmw6/XVChrJIBepgGigJ6jf8wvr2Le+nAQ69dFZywdmJ8oYjqkAIYorrORm2z7IMp/qCB5Rkq1V5nOj/yLe68mrfqr5ZyLZ+B7B2HYctqRnBOSFtW2VzKguAld/QCBtmdIBdBNvl4beef067iV9Qm2kyqGC3DJ+z+BCqZnBLDhoeyQCJCxQkKTZ1dg0DZ7Y4PIU2/SnlKbdmh+/GPFassCfZvY2om9vmLYo88EgGV96jlIeGUT+l6dosP6s561sFantiaQ6Wol4AeblwwO3WDIjs6XHCXj8e8sEElYr9ULrYIodhenYCm+rqGXN9xnn9wBj5/dimyvro56nnQJCPR9F9sa18KtU7iOP9KkIL/86bjOxA7Iag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(31686004)(38100700002)(41300700001)(316002)(6512007)(6666004)(31696002)(6916009)(4326008)(86362001)(2906002)(8936002)(6486002)(8676002)(2616005)(66946007)(66476007)(66556008)(36756003)(53546011)(44832011)(6506007)(26005)(83380400001)(478600001)(5660300002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ektLdFdKa0NGK2Z0TGNpMzFJcCswYUFTUnFhaE54cml1OFdJTEtnb0t1cUEz?=
 =?utf-8?B?bERqYkRjM29uNWFLcGlWZEgvS0tqVkF4WWY4OXpzbXM3Vk9jRXhHUWZKZnpF?=
 =?utf-8?B?Mnk0a1gxQTE1TFlLaGdscnlKT3g1RjVDZnVtOGVFWVhMMTJTK2l1N0FyQjhq?=
 =?utf-8?B?cnhaM1l0dFBiUG9KeWMwK3hWcmlTTkRRTTMwRE5hNEZRSVhMNHE5RktRNWFu?=
 =?utf-8?B?WGtuKzJmc0VBMlZxUFZCc2JFMXRWNzNHbi9xYUFZVzFDOTNyeStSVXNyZUFI?=
 =?utf-8?B?V1hTODBXbFY1aEJIL0VvOWxCNFVIdlVjY2dQVXIvaCtmcDM4bXV6R29ZWHRG?=
 =?utf-8?B?Z1cwY2VRNFhienUrTHJzaGNyTkxaeCtiVzJqRnhGeUxlV2Fuc0VFaFowckRD?=
 =?utf-8?B?bkQzaDZwaWRBdjBSRUYvdXlSU1Z3a1RtZVBlam5XN0IzYWRvNzliMWFwcS85?=
 =?utf-8?B?a0R2bWhkK0ZQbmM1cWw2QWtBVmphZHcyRStiTzA0TFdaZFFqK2phYW1VdVlB?=
 =?utf-8?B?QWMwWFBRcDFiVXpmSHlmK2F0RG1rMHpJRUNTRTJrcUNLVmNNKzZaWHhyaGFC?=
 =?utf-8?B?KzNBaUtjVjFEZkNSa04reXRiK2NnMUZoM1puNnlhN2dJdS9zU0RocDBldkRF?=
 =?utf-8?B?dVJ6aWF2S2xFUWJCRm85THl4NHNOK2QzZjBBK091clcrdzUreGluNUZoZUFQ?=
 =?utf-8?B?MjlJQlJHTnRtSkpCRDRpWFdwYmNKRWUyRng3SHg2QnRrL1FzcVM4QWZCejRu?=
 =?utf-8?B?UzBaVDZKY3dlSDM4ZEovbmVGTW4yeHdZUnF4Si9mdCtWSzJWZ00wZFIvU0Fx?=
 =?utf-8?B?bkFTNFpOcFlFU2xRbS9mdDdvN0lEZ3ZWUlAvdHo1Sy9zWEFBQUlKY0xJNHNS?=
 =?utf-8?B?L3pJVnI4czllMkxrVE5pVzdZZ1hJT21rVUdPT2dJZkVtaTBvVDNxU0lJWVRH?=
 =?utf-8?B?Y01iUGNlM1U3Qm1lcnRIQm9YQkp4SkF5ckhxejUybjBHNmpGVkdlSTN5MllU?=
 =?utf-8?B?ZmY3cGNnRmR1LzkzVmNYVmZMdVRaYVVOVjBDbEdkaENlek5vdGpmSFY3a0lE?=
 =?utf-8?B?UlgxdXcrdHdhOEpuQkh3T0F1ZWtIRnpyRkJFZ2JqbEZoR1VQclRVeUlsUito?=
 =?utf-8?B?R0o2VjlocXNjWVpaZndqdTZiengvNWF2RzdhaUlmbVBKT2NseGMvYjBKZGQy?=
 =?utf-8?B?NHdnRG1PeTVLY1FKaXYvQ1NZVTUzdmxiVHFOOTBCVFZiVk05NVVkcUE5ODhv?=
 =?utf-8?B?eXpXUXNEY28waDA1amx1ZlJHQ0twZUFQUFRrNjRBM2xtVElKU0pTajByRG16?=
 =?utf-8?B?RmlrT1M5WFN1cWlyMVRsb1kzUnYwRHFENHQ0LzFBUUJMblRoMzBObzBoQ3g0?=
 =?utf-8?B?ZjZ5VVdwbEVxNnowVjRXMUgyTVluODdaZWNyUmk4NHFTMUFyVkJuQ0JUZU01?=
 =?utf-8?B?OXZDRzJFc254WnhTRDlTUzQ4dFIwOXpoS1FVS0MwbEs5RnAyWGtyelU0bTVX?=
 =?utf-8?B?VWllYmgvOVhVSTZEckJVbHZsUVBFMmZSS2FITVpJZElYV214SWVmMUpzdDZE?=
 =?utf-8?B?K2VEanFVemJNQ1YrbGExRmtPbk1oKzYyV3FDTnFzVGNDR0FjSjZEbysxYkpF?=
 =?utf-8?B?UUVwTzVoZ1VKc3E3N1U3U0NteEc2NFV4QWY5MlBRVHRCbE0wNmd6dTdqRG1G?=
 =?utf-8?B?emRmdDBZbkYvUWFSNElSQ0RRNzVsdlZnU045MERyMWJVN3F5YlNPVWp5ekRx?=
 =?utf-8?B?V3Rna2VpZHFjOWJEOVB3bjBBakRmNUxSbFhZcENNSW53dFgvTStlcHRuQjdX?=
 =?utf-8?B?ODZQTEg3TGxXV1hzUzcwMUVDTE1rdE1uUWROQ0dKWnAydXl2VDdEMXVaNzFD?=
 =?utf-8?B?MVVZbFdoZi8wb2l2Z3lxeFdwejZMY2hqL3l5TVJjQ2lyM3V1eXpOMHF6clVS?=
 =?utf-8?B?UlFDeVhBR2dNU3k5bUZvRkgxa09LMHFqRHgzRG1sVkV1anF3U3NyL3lqd1E2?=
 =?utf-8?B?elVQMGNlajIrRnVDQzJFdDhOQjZRdGNKemZhY0tlTnRkL2RUQnczZTlxbmdN?=
 =?utf-8?B?QmJCcTdaUEZJQW1PcHRwNW9MbUU0N1I5RnRlTUF3U2RYNlYyaTZrT0VGcS9I?=
 =?utf-8?Q?i/pSVHqmqgpZmpy34xSfILDup?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZWsYWVRwy9uQJvwEQ7Nhp7Gr934EtNiOv2lpXDQGkyUCKuPJ+t1x55A/YeSI7TbZlXtWtUsmUzKD0E2yunSl19wn4v59S7Fy5r9xh2CVY2cZnuO0Hzg0HZREJ2icbSP+NSkzbHPBvHUzpUtVk9n5Gv9jLgeE0tnkSlxDBCDmV/yQpCyTTl0nB8vpqjnq0jRklbZFwAFtcSQCH/HJiX6X7WDcGzard0eESuP5cYUbpcl/RUNLVHcQ5G0t+LD2+/guHzfy7bmXc8tB0ESt9CzgWRuqq3zOfDrZal0RpMnPhK/UrrFSZxpFzvcli+4mmSaUIFtTGnbAXlShBFEzjAy0Eb8P7CliV6Q47TZd76CqgMMC8cCXVTsUBOnCLnQezSi7DrLmsUiXYqszpbEV1MRmHd9lDeJOv+Q9MiDSfalsQBNHUnJVaDJxzMEXXEmG3/9MtvaQn0CdUhoxa3wZrQMENrH36dg50Z3zOxa+b7MvVmCwEiSdOSNAwkYhuVqSWfQPtzvlVdYTIPOgQOEvvwBjD+b4okdjCJvCzYFRS4wX+CKGEQ4MKGuvROpq7199Jiu5XBN7rRFKIyAYsHU5+skWY3sLfUGfT6tNgJLJ9MqrYOqHVhomigjuV7mw1C+q9TNIFSygP5mooOv0LehInSA2wAjRLSq5lpcdnkxa+qm95vrKFgTS/xs6+2qOtleIdy83kJMQh257Bsn1qNti45SGvb+z+PkLz9r5hjJmp0Xeh8aS/SqBX9UhF4gRAsgKCGN5XFCKCzyE1zEXHlcn5ZYs7Edj1rHTlmxCzDjwUjhEyUE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7678ac1-7df7-4a88-43d8-08db619a66ee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 05:46:38.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0INVEpbqzRVVx+HoedLtrrdsLNTvPIBfDWU+CznMCRso9DEEnWSCu54vO8CT47CdGwmGuJis4eoCtly2EKCg5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_02,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310049
X-Proofpoint-GUID: tx1VV3XmANYvgMXGV67rvYMSAnKziCc_
X-Proofpoint-ORIG-GUID: tx1VV3XmANYvgMXGV67rvYMSAnKziCc_
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/05/2023 20:37, David Sterba wrote:
> On Tue, May 30, 2023 at 06:15:11PM +0800, Anand Jain wrote:
>> Add the DEF_SUPER_FLAG_ENTRY for CHANGING_FSID_V2 to our btrfs-progs'
>> print-tree.c, as it is currently missing in the dump-super output, which
>> was too confusing.
>>
>> Before:
>> flags			0x1000000001
>> 			( WRITTEN )
>>
>> After:
>> flags			0x1000000001
>> 			( WRITTEN |
>> 			  CHANGING_FSID_V2 )
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   kernel-shared/print-tree.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
>> index aaaf58ae2e0f..623f192aaefc 100644
>> --- a/kernel-shared/print-tree.c
>> +++ b/kernel-shared/print-tree.c
>> @@ -1721,6 +1721,7 @@ static struct readable_flag_entry super_flags_array[] = {
>>   	DEF_HEADER_FLAG_ENTRY(WRITTEN),
>>   	DEF_HEADER_FLAG_ENTRY(RELOC),
>>   	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID),
>> +	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID_V2),
> 
> Should the flag be also added to BTRFS_SUPER_FLAG_SUPP? Currently all
> the other SUPER_FLAGs are there.

I have the patch locally and need to confirm a few things before sending
it, which can be a separate patch.

Thanks, Anand


> 
>>   	DEF_SUPER_FLAG_ENTRY(SEEDING),
>>   	DEF_SUPER_FLAG_ENTRY(METADUMP),
>>   	DEF_SUPER_FLAG_ENTRY(METADUMP_V2)
>> -- 
>> 2.31.1
