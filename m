Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6EB78193A
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Aug 2023 13:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjHSLRC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Aug 2023 07:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjHSLRB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Aug 2023 07:17:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4501A2A8
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Aug 2023 04:14:59 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37J4k3KA014699;
        Sat, 19 Aug 2023 11:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tUoM0uP4kbPR9XLTUlKpX0mq0nRa+88wRs5HWHpCXKw=;
 b=lUWQsO1Q0A/Mt9kWm9CuZqAfeiA1d2TM2UyuOMSl4zqqrJMEQsI8l1abXfWxQKJNtZOX
 +Antn/c470H0lh8JxsXvux//1YqRsMKCUGzxjeV/yQ/ZKGgNk+VxyUJ6VOr2RWkvrfe1
 m4VtpDuFTl1RO8KaYAOFX0hqGUoDPVh2TO+O316+kiN7LcIkLdm9kwKRPeUeDgLp6kXE
 pRbi7LeLpv+w7/kwqsPm7VP5rl9pqraTd5h+JkLqRTllpc8ZhJ7cj2hcVSbvCR13wkkC
 CA2oJmijrgcM8SVSF1LpKXeELJcl2MhlDE7Lfo0ah3h5SwLa2pnTUWULPpDBwRT5O62O Kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnsc8d2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Aug 2023 11:14:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37J790Y0018789;
        Sat, 19 Aug 2023 11:14:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm62a784-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Aug 2023 11:14:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvSUiz/vTUT7IePumsBCDgBBU8J474lJ1d4mN5fm0g7y7J8C4O1aHW2+3cYzNcn2z34gfwny2vco40VBabAKFNHe0b1DHqlthJ4JnPdsTj3F9L9ptbvhW0OI6caCuhLcauWCtjcrGeBBQIRLQ+NcUacvNzgN00e70XBRSH6x1Aih8JpupRYvIX522+HcTOGuaGlyCQkhglDuQ9CWtjaU5URqoDJwRfTULZ3H2ns+XVzGOCDSbAtb38uK5JRwCTvTr9qwg1inzWQnR/ZGWBQ/2HT+pQXzc/kcW+1981BFOsAIyJKOUbzaVXYPxeklgGicjykcFk1K6wkUg6GnCbkUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUoM0uP4kbPR9XLTUlKpX0mq0nRa+88wRs5HWHpCXKw=;
 b=WMUmZ2ZMSGTkHTXUEY+GKeY/xMl+LyM0o8oL16JxxcWhIAyNV7aTDjpgUopO5Jj6hdtrjA9yQwObKvzbadIPRrrcYWWJnmuWUqtUrF2uOmGGu9Ue5J44tSV0CJl6DGMRV6qtvVZGLC+dvVIXSNNT9jVRXJktHcfxV7qOxxMtNaGsEMrGO81l6jX8MsledGx+FDqflKQDeouOm/9yjLKxsCyo0fvpp6hjI7rQVSxlVQnWFlXz1p9l6gGgrYYo1wwgNw3GT3HScAj5+/URB9isPwNfgH+wMtAc5uitNGt1lKXsq/9bLsHMS+kFPMt0JbnzEnF8aZGJ4KrQsxBLaowqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUoM0uP4kbPR9XLTUlKpX0mq0nRa+88wRs5HWHpCXKw=;
 b=o1mLkiQcm9eT+kGnZ7ICMuY18YwpmvBLdIciINcRH9CAlaNMjoWLCavruCEwtNgunG7C1uSYabfp1bmEHwErt7eaeR9/R0ljzeSWgCnejZkj1RnmGKo5mWEtQvwpbufcW5ViL5KqneiIXCftG4w390u86XlsyWw3ohQj33kspCE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 11:14:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 11:14:48 +0000
Message-ID: <df569834-1949-5c1e-dd99-8da105a10b38@oracle.com>
Date:   Sat, 19 Aug 2023 19:14:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH RFC] btrfs-progs: btrfstune -m|M remove 2-stage commit
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
References: <12b53ab9683c805873d26a4881308137e0bd324e.1692097274.git.anand.jain@oracle.com>
 <20230817115229.GJ2420@twin.jikos.cz>
 <161c8ab2-2f8c-ce87-783d-f7f0993074af@oracle.com>
 <ef88fc2a-b845-4637-b006-43ecc511d9fd@suse.com>
Content-Language: en-US
In-Reply-To: <ef88fc2a-b845-4637-b006-43ecc511d9fd@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4944:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d4c37e-805a-4bbe-ecb5-08dba0a57fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1jQyeJB35wAH1OHfYArmF5wFNtNlt08dRMxQBpA1ITm1z781pjjo9qszBY5oBzbWxPRQ31ken2MmU1xLBr49IlpnZPhtoyD4WCbIXAIH/zy5SAbmEu0BGCDepxeqxbm1vC8Y784K9cTDjNE7CU57KWj3GT1oJjqdHtTB4g8OXfI00lMfHKRHbO2sHlqd8BTqBkGFcfXhkB/rUlOGVs2uAjUuBzAPua7UIVDrCbDBHt27N2ABsjVwv0hqFHAkygOOCHvXWgbA/XjLNT8Zdcwa8Gq/wwBCtQngjsy5qA8MRXHj77HVxOWHZ3b+L4MpUIttUYzJjaDv3DkBhLWaHu1bQ2IwEsQZgoO+xjcNePUgmsZAEMlrEwSl/8UHlcwdEl5M3rlOQdYkJZyxRCfdh1fv0+1lZfd444BZdsVtp42M/ZYAuEqc4+VaLyf/VtGMpv3tjOsjqOmVp4vDiTNh1xlPPrwQp2IHkLHIv7t+Eve+DkPFT19FTUtg8Wj53NW0D9F1s6qcVkoYn5p3BIA1xma9bf28IgDrPFsBf5dDCtaKrMlw1vMdxD/kxs/DKOcUih+EtpZgNx5M8wCZDIrIGFYVw+PEZenWPk3nDqUZ4RdBRc0HzcuAJwVOdwFW7iF2Vg3i3IvzcHSsFiMd/6LAhnpTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199024)(1800799009)(186009)(86362001)(44832011)(5660300002)(2616005)(41300700001)(316002)(2906002)(66946007)(6916009)(66556008)(66476007)(31686004)(8936002)(4326008)(8676002)(478600001)(31696002)(6666004)(6486002)(53546011)(38100700002)(6506007)(6512007)(26005)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2ZhZGxiVjh2UlBWb3E5a09aUDFacFhIbUU2dCtGOUhENFJPZzY1UU9Cb09E?=
 =?utf-8?B?em10WTR3a1RXRHFGUFd1UENCU2NCd2FwSUpvRXVuSFg3QUU5b0FZbWRIK0o3?=
 =?utf-8?B?WUtDV3hWelVGVk9CVjRiNm85eFhxNXpVbTFOSENlNEZSbzduTlE2WlRqVThz?=
 =?utf-8?B?NXNEMTdQUnR0ZXExb3hYTEFKRzNOYXVUNTZMRXEyTXNNVHhsTy9FNXo1RWdt?=
 =?utf-8?B?Z1Nmbm1ISUxxOC94MDh0SWtVclJON1h4S3pqK05telhVTmF4Q1RkaGl4bkNT?=
 =?utf-8?B?ZTdWcHlweXVucm05NFJmSDQvTnVpN3Q1d3k0ekUrV1ROVUJJRzhCWkF3cUZ2?=
 =?utf-8?B?dWJpNWNQb0M2TXNTSCtkYUN2SGZSM1BLa0JkYzZLK2xvdGRQZHZWa3A0VFBU?=
 =?utf-8?B?ckNSYkV2cEpmTVBLdTVyWjBWRlprMTlSeUZwVFB1UUtKZVZOZmEzdWNmMTFk?=
 =?utf-8?B?dmNrVko4aDJtZXF0cWVLYUpiMXJvam1TbXNUZDg2eUhMbE94U3pSS1dkYWdh?=
 =?utf-8?B?K3FRdWhxRnhNOVNLb0FFQURFQzhEMitTYU92T1VkdVE4QW82Rkt6aldwVmxV?=
 =?utf-8?B?ZFQwWjlVUVBDa3hvZUZOZ2cyUHM0R0treXVYUzlHczROU3EyRUQzWWZHTk5v?=
 =?utf-8?B?RHMzK3hhMjlxaU5acDN4QVZVZ3VBQVBPYklXQzlKUUZWL0RZSkJDTVI3NUpN?=
 =?utf-8?B?dGMxTDVRM2ZFRXprb3hpbm1wcCtWY016QmpGTDZCaTNOdmFQMENoQ0FnV2RC?=
 =?utf-8?B?alhxdTloTXFDbDQwWmNjZWdpa01JZ3h4VjBHSGhNSEtQSGFvVEhUNC9Kb1g5?=
 =?utf-8?B?Zm1BQklmSW5Bdm5NMUlPM1hkWDlERTFPbEZnUUZjZ2VmK3FvYlhONzVkR1FH?=
 =?utf-8?B?YWl0TXhXY3U3N21ZNUxsOHpMKzYwVmNMRlhWNEtmdnZQWmVRY2VFeUsrcllk?=
 =?utf-8?B?RHppSXJhdXVLMnBTbDJOQjFKbWRkQXdUMXJNRGRWNjdQVnowN0JNcGFqNzFk?=
 =?utf-8?B?U1ZDVlZ2TXl2SURTeWwzYVlDSUVtRTJCYXIrcUt0a0JpUFQvdTJlSi82bG1Y?=
 =?utf-8?B?TmFJZ2kxM1pUdUlSNkJNVXhxSVhJam9vV3o4UFZIYnk0K0ZBVy9nTjltUWNx?=
 =?utf-8?B?T1ZBajhORHNMM0crc1hIOFA2ZWQ5OEdKNHc3WUh5ZlpkTm84VU80YWlZU3Mz?=
 =?utf-8?B?Ky9CZzg2eGVSU0hzaEhaSnkydXRtWEZOTGNqRWJFTTlNV1pOay9tVGx4RHhM?=
 =?utf-8?B?YkFod3lvTy9qdnhpZDB5TlhDb256YnhQcjlycWhYR0EydzJ6UEhsakhHL1FY?=
 =?utf-8?B?MG9ySlNIVFdpOVMwMmlNenF1ZG1IaXB2VGxLNyt0V3dZWnE0WUwyNjNjSGty?=
 =?utf-8?B?UGkyN1UzTTRrd1ZOdlVWWVE2V2ltL0l5QnhUUTBWNXpOMzJOcXhPQjhUOTdi?=
 =?utf-8?B?bW9mRnRrUlV1UGczWEhabEgvbEVGTWt1bUo0cmduL042ZXlGWWlPZXdDNUdi?=
 =?utf-8?B?NXhVZTdCTUxuUGpmZHFycEpveDk5ZGJ3WUhvZ29RN0FZSWxJYkFGdnQzNm1J?=
 =?utf-8?B?Rm91Z2Z2emlIMDM2Tk1vK2VaRW9UeTllNzQ4UWFFS3V0UFVuTEJHRU1ONWVl?=
 =?utf-8?B?TWl1L0dTZTRBb2RXcG9UZm82a2gwNmV1STBZVVBwUmYrVzJINUgxcDR6eHpR?=
 =?utf-8?B?eTZCalc1RWZzM0l4QXBqaTVYaFNmTVRZUHJLM0g3WFpvTytMVXh6bHNsVjE5?=
 =?utf-8?B?eXZXZDVzYzAxRUdlWTFsc1JZQ2dpSGl2Q1gybnNsZXNRTnpiUjhSeG9FdStB?=
 =?utf-8?B?MFFvKysxcmFoV3l3dUpPbGFEdXJsV2t2OFVBa3ZoVVJ6UldwNjVmUlg0QjRw?=
 =?utf-8?B?Y2tMU1ZQei8vV2dpSmNTenFkYWN0ZW0xT2grVnMxOGVhcmMwMXlkM1lUT0pU?=
 =?utf-8?B?dzIxTk5abkFRcDNXWFJQL2lVMmtJdk12OFAyRFBNZ2I0cVJHVmtoZnBmYmhj?=
 =?utf-8?B?NmUreVBnZTRMbFhWdFdJTW14azBQcU9jbEZuNkw0MFkwcG10UU8zdFREL1lx?=
 =?utf-8?B?ZHpmS3JQcVlPaC9xMWJIeFhRWlkzZ0xsM2I2dmVaVTdKeU5FdWhpcXR6alRD?=
 =?utf-8?Q?6lNeHYDTFkbR/L5JdyZQ0L0Fa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9ST5n528+/ZgIZf+nBsYUItD6tFnCrPvBCTpOn7VaN0uTeKWPNwBFIYhDWP/ywgKzh0teFBnphdaQkfDJ4HDn5scoXmwbkYT5pM4yMjjTR9lWKJA3eCZxm9BvutZXeU2WX3UBhfG9S+MQVrcP3jf3IVQLspftKH5RWyAvcZwQENWasJ+I+LYpE+UwnwC+a6H/L8NYwC+PEB/OMjufWGZBmrF+hHQ9o6xlUk9uOX14cxuUKo6DEhKA2as/YDspIdFNHD+skCg6LxAJnStRXXpmPUjyVs0onW6/nETh5vm8aZcJYSqJhANrnW7+bVoKguip1lTS2l3w7V6GjpFYLV5+rwrR/TbwqBOHVo81jicy54988lpJz89bC0FO7wgd/o6gq/tIRfW9o6cZTPbj0cCTj/TBXy69jBvZ/02J++U/cjHDXbBWjYlkJP0pWw3sDBL3/ncDE1OlJgSot5KPMUkUnMmCreHTNIrBZNnrO3DO3/HjP8KWaZ5szp386OqJmqvL14GfSUMB5C+ooZMbSoYvFB4w7DnvlZf7zWGi33LcqhlBU6sbfzo1zPHvUUF4ow685XN4t5VGFHXc6jWtUFGeQPetpAkm1lZUU9w0+v7W9nr40LA+rE7+26Z/py6d0fMuam1RVZHULmvrQAqxATDaE02g5KRNIeMUJTo+lvGem0gJ2+Co7EokzKJmp372EL+Tn8qMa8hzwh3YABoMlQCF5ljpw4zrPh6yUYknmwZkdoVAAfRfboH6OMIF5lhMvFS+dQB2hufhJMehBHbz5c/rDY4Vc/OY1w5RTAk/r1m+tbML1VoH4AAZmac1GCE8bBA
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d4c37e-805a-4bbe-ecb5-08dba0a57fad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 11:14:47.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeN2XCmHY6IpInDgHyXl7S6M0VURUGov1HlWkZorA9QE638CAEretQ9pq+DXZBQwmyBSIfHxh9NQ3TW0Nz5g0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4944
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-19_11,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308190107
X-Proofpoint-GUID: pIYP_zSxgS1fb4KSHtMbtaILeskg2slz
X-Proofpoint-ORIG-GUID: pIYP_zSxgS1fb4KSHtMbtaILeskg2slz
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18/08/2023 17:27, Qu Wenruo wrote:
> 
> 
> On 2023/8/18 17:21, Anand Jain wrote:
>> On 17/08/2023 19:52, David Sterba wrote:
>>> On Tue, Aug 15, 2023 at 08:53:24PM +0800, Anand Jain wrote:
>>>> The btrfstune -m|M operation changes the fsid and preserves the 
>>>> original
>>>> fsid in the metadata_uuid.
>>>>
>>>> Changing the fsid happens in two commits in the function
>>>> set_metadata_uuid()
>>>> - Stage 1 commits the superblock with the CHANGING_FSID_V2 flag.
>>>> - Stage 2 updates the fsid in fs_info->super_copy (local memory),
>>>>    resets the CHANGING_FSID_V2 flag (local memory),
>>>>    and then calls commit.
>>>>
>>>> The two-stage operation with the CHANGING_FSID flag makes sense for
>>>> btrfstune -u|U, where the fsid is changed on each and every tree block,
>>>> involving many commits. The CHANGING_FSID flag helps to identify the
>>>> transient incomplete operation.
>>>>
>>>> However, for btrfstune -m|M, we don't need the CHANGING_FSID_V2 
>>>> flag, and
>>>> a single commit would have been sufficient. The original git commit 
>>>> that
>>>> added it, 493dfc9d1fc4 ("btrfs-progs: btrfstune: Add support for 
>>>> changing
>>>> the metadata uuid"), provides no reasoning or did I miss something?
>>>> (So marking this patch as RFC).
>>>
>>> I remember discussions with Nikolay about the corner cases that could
>>> happen due to interrupted conversion and there was a document explaining
>>> that. Part of that ended up in kernel in the logic to detect partially
>>> enabled metadata_uuid.  So there was reason to do it in two phases but
>>> I'd have to look it up in mails or if I still have a link or copy of the
>>> document.
>>
>>
>> On 18/08/2023 08:21, Qu Wenruo wrote:
>>
>>  > Oh, my memory comes back, the original design for the two stage
>>  > commitment is to avoid split brain cases when one device is committed
>>  > with the new flag, while the remaining one doesn't.
>>  >
>>  > With the extra stage, even if at stage 1 or 2 the transaction is
>>  > interrupted and only one device got the new flag, it can help us to
>>  > locate the stage and recover.
>>
>> It is useful for `btrfstune -u`
>> when there are many transaction commits to write. It uses the
>> `CHANGING_FSID` flag for this purpose. Any device with the
>> `CHANGING_FSID` flag fails to mount, and `btrfstune` should be called
>> again to continue rewrite the new FSID. This is a fair process.
>>
>>
>> However, in the case of `CHANGING_FSID_V2`, which the `btrfstune -m` 
>> command uses, only one transaction is required. How does this help?
>>
>>                  Disk1              Disk2
>>
>> Commit1     CHANGING_FSID_V2   CHANGING_FSID_V2
>> Commit2     new-fsid           new-fsid
>>
>>
>>
> 
> Instead if there is only one transaction to enable metadata_uuid 
> feature, we can have the following situation where for the single 
> transaction we only committed on disk 1:
> 
>      Disk 1        Disk 2
>      Meta uuid    Regular UUID
> 
> Then how do kernel/progs proper recover from this situation?
> 
> Although I'd say, it's still possible to recover, but significantly more 
> difficult, as we need to properly handle different generations of super 
> blocks.
> 
> For the two stage one, it's a little simpler but I'm not sure if we have 
> the extra handling. E.g. if commit 1 failed partially:
> 
>      Disk 1            Disk 2
>      Changing_fsid_v2    no changing_fsid_v2
> 
> In this case, we can detects we're trying to start fsid change using 
> metadata uuid.
> 
> The same thing for the 2nd commit.



The changing_fsid_v2 flag an unnecessary overhead, right? As it could be 
something like:

  . Write new-fsid and Verify. Revert if needed and verify.


------
Summarizing the overall patches:

Patchset [1] is a port of kernel changing_fsid_v2 recovery automation 
functions to the progs. So, hosts with older progs and can't upgrade to 
find a tmp host with the newer progs to fix the disks?

   [1] [PATCH 00/16] btrfs-progs: recover from failed metadata_uuid


Automation in progs/kernel cannot fix all possible scenarios; we still 
need user intervention to reunite, as in patchset [2]. It adds --device 
and --noscan options to reunite. (Needs comments, so that I can rebase).

   [2] [PATCH 00/10] btrfs-progs: check and tune: add device and noscan 
options


Patchset [3] removes the changing_fsid_v2 recovery code from the kernel, 
as pointed out- recovery code is robust in general, except in corner 
cases. So, after this, similar to changing_fsid, disks with 
changing_fsid_v2 are rejected.
But when progs can recover the failed situation and could remove the use 
of the changing_fsid_v2 flag (patch [4]), we don't actually need the 
recovery in the kernel.

   [3] [PATCH] btrfs: reject device with CHANGING_FSID_V2

   [4] [PATCH RFC] btrfs-progs: btrfstune -m|M remove 2-stage commit
-------

Thanks,
Anand
