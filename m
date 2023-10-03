Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E57C7B5E7E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 03:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbjJCBOO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 21:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbjJCBON (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 21:14:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD37E1
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 18:14:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930i8iI005450;
        Tue, 3 Oct 2023 01:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gurviR7wZKfkRLtuuBtO1lmXXeHsSKUovBDIr1iKufE=;
 b=veze47Oot8C7t+blIVo1zRAX+CwkFzPOimomw9Bj56sCksDHhnzdJnArxm2XxUpksWsu
 cdcT7zmH3Lux/4HzGECzVeVUb55OE2j/U7m7HMBr9b8nnyPoXwNozRkkWJjAQGtqYASd
 p+Bqei0WzSUBLXnf9Yi0Eqs6++Omu93/LVpEpel+R4YelW3kfT1FvP5XGq/STj37os5L
 GUieK1g+OPgwMzNNHgp9HokGKrncXuuIO1BcCbwKr/HBy6s5atG+PMnLjXQH5in8jvQE
 ilL+jQILgGoEA5zWd5uZrsGht8YqMbAHJBoaC9VZKtgW927yMduWD85z+S32TFdOFMNx 7w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqdunnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 01:13:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 392NPCAM008713;
        Tue, 3 Oct 2023 01:13:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45t0pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 01:13:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOvpiOAXOJQb/ALx/fSWNLkeR1qmWi25ZsjZtqkk4o+QbUTTM64pftRWyhpREMKk3Sh22NchP0elHSv40oYgCpysHVxt4p0aCCrnb0oEnKPX+ZvRzZxQ+LtCYBAlGFGNp/OsOSAvwGNgzX2LyLjnDoVt0D42VohxusCPU8OJ/kAjCn5MtDRtVC3WviLdeXloyrHlS711z9GmGNDoGhouXqPNFI+Hig9vbdLUZ2rjbjPqmJ+iM92K8SaXoBYPo0UJhsLkzGDAhCAwA6KAiy5hxNxlJinaZYPBNTOfv5QdtR4NJ+hxkokyTaFsuprgoku1DRiC+pQV0+diveuYSJIi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gurviR7wZKfkRLtuuBtO1lmXXeHsSKUovBDIr1iKufE=;
 b=Z/coUM9pLk4ixskZ3PL4uv61g5IHV36yrIoJRSr7O+e5Nl4LeMYAT00IU7hJxIoA9je6sTiliianeI2LiITIdJwQ7AU4J9/qb00PH5lUOwEK2Zd73D2DNFZ2+UfdrAXW2WVTWhm4Jb9RCHjGekQ/rdwZ5CdwITHwn6bW1u18GsH7Fnlemc5aUtRev7PyYpwEiCuhiY1pVMkXvShd6WSJJNxaj0wwUsTsrKm4oPVz0kiIMy8Es8lBDZGqo0X6MgkL4x/L3TdbZemCWf4ijpCNrdrLItIONv0Iuqle/jJFVTmWvApDVpnm5cufbMX4vMfe2/ErnuQ6FskR+5MgtDTwVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gurviR7wZKfkRLtuuBtO1lmXXeHsSKUovBDIr1iKufE=;
 b=mUUMpm+As0aOyeR2HUIQf+/eY90Ezuca+oh5E1H+D2VSPbIDRPCCcRH+XPkkUe8sxB85UWnUp3iQcMiBsif504upIPUT6TuAdrZe8v1SCU+ZGwifTL1wNHLYo2u9JNnQ+ttyGbO/0tCETcAn6SwZGrfuzrXWhRhGUQk1hdps+/M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 01:13:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 01:13:48 +0000
Message-ID: <c96b0c14-9624-c080-3290-214824df1bea@oracle.com>
Date:   Tue, 3 Oct 2023 09:13:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2] btrfs: support cloned-device mount capability
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        David Sterba <dsterba@suse.com>,
        Filipe Manana <fdmanana@kernel.org>
References: <cover.1695826320.git.anand.jain@oracle.com>
 <20231002130040.GO13697@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231002130040.GO13697@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a3512b-953f-4ea5-a326-08dbc3adf37b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwZOQmlu1fOTbsTjgwQXOcgZFmQ4j8Uo5Hh3MfskpIaz4qL4Df1o40sUmgz/WxaTMTWGGDHasrDPPfiGie57Yg0IBWW5cVjvQTI7IjxxKjM/PfLpd7H9Qr41YzOajF15EK1b1N/QRkEzBXRLumypCMoMth1D0kpvZnj/FoQpzYmk1V7zyG0IjOUS6WIn0xY5UzYMwwZeJm6onUx34xoC6/s5lSYO2UDpS5wqz2AqTIwPvG7NRTegW4mraAHvgcOJ0zka0k4hX6POVDcrWIi9yD4nzvDHI64B9BCRuLfRxtkpANA/hRhVhROoLPHn13r0aZeUnNurpU3jDg6JdSa6YdmOPZOqY+eomuA5X4lP8E8ZfENraN2GPagm0XMwefo1LrdvSbEjD1QibNGYob0LOgTOeFvhyVIOu6B2RnpGoTDz1d8SCtpa8afUFAwKRPT2r0dMncTfXS+Z3xdgG0VCoxUtDPJNlMqDcWr58L2pM+wOXaw7IxVoJ+Ay9OnlbMfuEe3UW/MdeCCUuXwzNWezjTxUkTXQb+JjiD7b8ldHOH45EnCMUKGl541jaBXVz8MZGDlzkoQ0zJ13WSK1a3ZtqXjdw5MFG47tluV0QF4ZL2pB5/o7CpGGmPlzmr0Z7dvG80UU9ve2An5O/nLGM6yB5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(316002)(66476007)(66946007)(66556008)(6916009)(54906003)(8676002)(8936002)(26005)(41300700001)(2616005)(36756003)(478600001)(966005)(83380400001)(53546011)(6666004)(6486002)(6506007)(86362001)(6512007)(38100700002)(31696002)(2906002)(31686004)(5660300002)(4326008)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNYNlI1a2JNYkNvWUp2RWRlMnVvU2hCSWNJWHVOeC9rOTkrc2VpMnFwN2p3?=
 =?utf-8?B?TkErK0IvSkpUSHpEQ2Q4MjF5bjVTOFBWaXhKOFhVVUpIa254ZUFmbUM4MVp3?=
 =?utf-8?B?UExvQTVVWGhRNDBGbE1ETHBxakpkTUo5Z3hvVGlDS3BiUEszUTRHbHgyKzRM?=
 =?utf-8?B?eVpnaWIvUkxNdkx5SXdrMnBIYVA0UUFHQXRYK3BFczZyWG9xakVZTHh2TUwv?=
 =?utf-8?B?OWpjTWJlUFFSbXltbTZMSHp0QjcwL05zeEQrb0VaQ3JtTXlPRVRsMS9iTHo5?=
 =?utf-8?B?U0NEeTArSzk4RzRsMng1YnRtV1FtWE9Deks4U01FeXI5RjRmNkNMSUZ3bzl1?=
 =?utf-8?B?Rk9GemF4eWV1RWZhY0dRVDBiWjA2N3VOMUlSaGlTdUZ1K2pSN1FMVWdLRkh1?=
 =?utf-8?B?L2RtbmlGV0R1OFJEZVNvZDNjTlRMQlE2Ujd2NmpDNHJSUzBmMXdkSHFOVEJW?=
 =?utf-8?B?azZsZmZvSUJTeDMrSUdnMFpHdVNnem9pV0V2bUtBTnBYUkRBQ3EvOWgvb3pt?=
 =?utf-8?B?NEdMZFB0dDN2bGc3YUREOWRDYVU1OHVpcys3QzNXb2xiM3NVRkNwdU1LMC9M?=
 =?utf-8?B?QjBGOHFtcm1XYXlKV3BnTW5BVVJhNnFRQjJocGNseDlQNlVOSjdrSFEwa05W?=
 =?utf-8?B?bU5uTkNuRUVsSmFyc3JlNmV3MGhGb3ZiRDNPVVo5YUt6LzFCMmozWDllWE10?=
 =?utf-8?B?YUJFY1RZYkgyOXhoS2l5ckx5a3k4TEFXOGxMWDJSM0M1OUF5Q2orKzBNK0xC?=
 =?utf-8?B?RUozUERtV3JwSmt5Y2hjcGhBdWJCR3pzcitCTXZ3YkRCek1mS2pseGhlZXZ2?=
 =?utf-8?B?YmlwVFpUWFpBK3c2WUJuVk5BWjJDTmJZeklQbzQvVllmVzg0UzdteXlXVzky?=
 =?utf-8?B?REhFM09peHFaRU5EZ3BVTGE2V1dnTUxya295enpXbWVKN1k0bm5TZGJPYURw?=
 =?utf-8?B?WXZiUll4QXV0R3BCVE5iU0ZyL1g3WWhnMjJwdGxNTnRjWlovV0Ivb3A3Q2t6?=
 =?utf-8?B?Uko5UzZRL3ZjL1c5OS9lcXpEdFV3RHF2d1FxeVVRN1R6enVOZ3dTQmpEYzVJ?=
 =?utf-8?B?MEQ2aVc4U3FaV1RheXJiV3ZlbC8zTUVqSjcyV1Qwd2hqeU8vSkJCWFF0Q3JY?=
 =?utf-8?B?UDR3c04yTnBKWUs1dkt1ZzByR0k4NlFCNEp1aFY1Sy9nMUZwTEcyczBHQmE1?=
 =?utf-8?B?eWx4MjZjMDkrdFJoNUpiZldTME1WUDVWQmRnenRmSVB0ajBjUTh0eTlFQWJz?=
 =?utf-8?B?enRpcGZiRGVBNzAyWkJWS3RXT0xMRjNnc2hnME4vR3FYWHh0dUJXU0hjWjEx?=
 =?utf-8?B?bHc2NVZrdXE5Yng0MXNDZXJNT0hhT29EOENuRGlsNmg5NENJNEtkdnpHMDFa?=
 =?utf-8?B?RmtuL3EwcnFZOGIwZlo1Q3l2UE9QZVh4NUdRNzh1QUdFWWpZM21rbFFsY1Fn?=
 =?utf-8?B?NmJkZThxMG5LUXFkdk9Qc0kyOG5iVU5BKzVoeDl5SElKQVFldlN1eDBjNG1B?=
 =?utf-8?B?T3FtUW9jQ1JnNVZDaWt6K3l2NWZNZ2RDUjNWYUJKajF0ZWJvRi8xZVlHSjZI?=
 =?utf-8?B?dWJvVUhQQW1wcFdXOUo0Q09zTFlKa0cxUGgwbHd4bTBEMnVWV1QxTUxvdWw0?=
 =?utf-8?B?UCtmRUIvMTdLVXM4YTNoSDdMSWZUK2Z2NXpzQnRLbFBzZFUrUUVocVpoeGpl?=
 =?utf-8?B?T2tuQlc3Um50Sys2UGNlSVY5Tm5UYTk5Q3ZEdyszdkltdFFtMGFvcDNxQ0Rz?=
 =?utf-8?B?blNJaHJ5NEI5dnZUNWNJZXVLVXNkNnZpamhYU2VOSnA4S0Z3SFMzd3FVUjlx?=
 =?utf-8?B?UEg0YmVaRVNRSDUwanBFOTFZdEljOUxwRElGN3VGaXY1K20yQjVqaDNYZmcx?=
 =?utf-8?B?bHBTeDVHZkdhNVRLQks5bnBpSnJyUFpBclM5eEE5UlpXay93Qjg0c1JwSzlh?=
 =?utf-8?B?ekF6d2JnTXFCeUY3VjU2QlU5Y0RJbTY4TVpNUnJVSEk0Tk5CV2txblZzbENy?=
 =?utf-8?B?N0hqUHE5R1lmLyt5NnZad1JUUmROYldLaE5sdUUwNDZHekdEMVhuVHJvbXAv?=
 =?utf-8?B?MW5UV3JTR0NvaE1FNGljUC93eUhyYXgxVHc3N3FodkJ1Zkc4alpPL1JPdWZn?=
 =?utf-8?Q?f8jAwgSxTwsNFK/WnDmiXP47+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nKZvLhIuLUTXf0929OV9x1CvJLveTpqqaegcyTnU3Y9kX6V9q3MzbfLRjJ6a38Jxu9vhcYozh2+98E7LAP/jglSoCTsSIIGK3WH0C0FJ5XWzbMM/ey8oI4ArwjulLWQg5QFbteih7banAqcGcddg85nbvm4VP61b7kMZX+po3heSG4KCItalXOdD3unJfX5/TpBuxjvytJGs5eSuZtbzyBaT64NhENt7HVs8W+gqIa2CVGbkQLldmZoEWdbDBPenFoC9YBwDWsL+bKmnpuqjbbI5reTnmOSp6fPN/lc4aG6rGjJKpr27nKmr97kHq7Rs5xh31oRamdPjgjuSYfzAsWDEkP7nSORdtWFFwNEvr4XZ5QVu6H7ink9AlQSS/ZEdyEzypw+KBb56C1OKvWX7zVpgMlC5XWdj5DeV2uqg7B6w1VwQ6Ppg/dD5OsraR5P6Buwih2WH6T7rn9K4VHbG3Sb9AxnZ28ZqgYG7lMQi+6fQC5bVJtxpBmHNIeAHVDwYDXP+mu643hLI1FhyCmac4FS8KgyD6HVSiHQj2UEck0hWuxTglPX4yOx/q/n5tASyUMvgZKra9sZmNV421xtgDUOkMIDrXQAMCsGsW6gTJOTMxZ9z+u9ffl7lAZoHooQ1Xi7TELlKXpepL5ZvFfOOZ8SHsxIPYl5Z3+ycEPWo9G+PBRyCuROgkvJ30iJ8huVToZ89hU7qw7tWmSWOA7e+ElIXb+Y+uzQFApTk7XPf6nw2rZG1PoeuqlO/Z5yZoHqXSZZJCFLeoT1kVvgun4bidBI/ZMGKrlgEIdYFGX3oy//wd9tlZLH5FXCWhMxP/fRln0z0JKjKvEWiZcQdLDu9qLBA/uQTsUt3P05vYrogVbQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a3512b-953f-4ea5-a326-08dbc3adf37b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 01:13:28.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmDMHaqHUL8NzFCsJ5vgIZtcFjZIB9nFZsc6VBPXjDD4UDUo9b3v4pA3l1fPWpxxgqIM41BE7yyJgO5Aoa3sQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030008
X-Proofpoint-GUID: S6skif8drczLVxgD4piJVECDqWIHsk7o
X-Proofpoint-ORIG-GUID: S6skif8drczLVxgD4piJVECDqWIHsk7o
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 02/10/2023 21:00, David Sterba wrote:
> On Thu, Sep 28, 2023 at 09:09:45AM +0800, Anand Jain wrote:
>> Guilherme's previous work [1] aimed at the mounting of cloned devices
>> using a superblock flag SINGLE_DEV during mkfs.
>>   [1] https://lore.kernel.org/linux-btrfs/20230831001544.3379273-1-gpiccoli@igalia.com/
>>
>> Building upon this work, here is in-memory only approach. As it mounts
>> we determine if the same fsid is already mounted if then we generate a
>> random temp fsid which shall be used the mount, in-memory only not
>> written to the disk. We distinguish device by devt.
>>
>> Mount option / superblock flag:
>> -------------------------------
>>   These patches show we don't have to limit the single-device / temp_fsid
>> capability with a mount option or a superblock flag from the btrfs
>> internals pov. However, if necessary from the user's perspective,
>> we can add them later on top of this patch. I've prepared a mount option
>> -o temp_fsid patch, but I'm not included at this time. As most of the
>> tests was without it.
>>
>> Compatible with other features that may be affected:
>> ----------------------------------------------------
>>   Multi device:
>>      A btrfs filesytem on a single device can be copied using dd and
>>      mounted simlutaneously. However, a multi device btrfs copied using
>>      dd and trying to mount simlutaneously is forced to fail:
>>
>>        mount: /btrfs1: mount(2) system call failed: File exists.
>>


>>   Send and receive:
>>      Quick tests shows send and receive between two single devices with
>>      the same fsid mounted on the _same_ host works!.
> 
> Does it depend if the filesystem remains mounted for the whole
> time? So if there's an unmount, mount again with a temp-fsid, will
> the receive still work?


Yes! Send-receive works even after a mount-recycle with the new 
temp-fsid, as shown below.

Cc-ing Filipe for any comments or send-receive scenario that might fail, 
if any?


---------------------
mkfs a test device whose uuid and fsid will be duplicated

  $ mkfs.btrfs -fq /dev/sdc1
  $ blkid /dev/sdc1
/dev/sdc1: UUID="99821bd4-322c-4a71-a88d-b9bb3e56223b" 
UUID_SUB="1881db58-1c2f-4639-bf87-5c0af24433d6" TYPE="btrfs" 
PARTUUID="a0de6580-01"
  $ mount /dev/sdc1 /btrfs


using the above uuid and fsid mkfs two more scratch device

  $ mkfs.btrfs -fq -U 99821bd4-322c-4a71-a88d-b9bb3e56223b -P 
1881db58-1c2f-4639-bf87-5c0af24433d6 /dev/sdc2
  $ mkfs.btrfs -fq -U 99821bd4-322c-4a71-a88d-b9bb3e56223b -P 
1881db58-1c2f-4639-bf87-5c0af24433d6 /dev/sdc3

mount scratch devices; it will mount using temp-fsid

  $ mount /dev/sdc2 /btrfs1
  $ mount /dev/sdc3 /btrfs2
  $ btrfs filesystem show -m
  Label: none  uuid: 99821bd4-322c-4a71-a88d-b9bb3e56223b
	Total devices 1 FS bytes used 144.00KiB
	devid    1 size 10.00GiB used 536.00MiB path /dev/sdc1

  Label: none  uuid: d041437c-d12e-427c-b0c2-e2591b069feb
	Total devices 1 FS bytes used 144.00KiB
	devid    1 size 10.00GiB used 536.00MiB path /dev/sdc2

  Label: none  uuid: 91c7978f-342f-43d5-a88a-d131dd34962e
	Total devices 1 FS bytes used 144.00KiB
	devid    1 size 10.00GiB used 536.00MiB path /dev/sdc3


create first data and send-receive

  $ xfs_io -f -c 'pwrite -S 0x16 0 9000' /btrfs1/foo
  $ btrfs su snap -r /btrfs1 /btrfs1/snap1
  Create a readonly snapshot of '/btrfs1' in '/btrfs1/snap1'
  $ btrfs send /btrfs1/snap1 | btrfs receive /btrfs2
  At subvol /btrfs1/snap1
  At subvol snap1

  $ sha256sum /btrfs1/foo
  e856cd48942364eed9a205c64aa5e737ab52a73ba2800b07de9d4c331f88cb5b 
/btrfs1/foo
  $ sha256sum /btrfs2/snap1/foo
  e856cd48942364eed9a205c64aa5e737ab52a73ba2800b07de9d4c331f88cb5b 
/btrfs2/snap1/foo


mount recycle so that we have new temp-fsid

  $ umount /btrfs2
  $ umount /btrfs1
  $ mount /dev/sdc2 /btrfs1
  $ mount /dev/sdc3 /btrfs2
  $ btrfs filesystem show -m
  Label: none  uuid: 99821bd4-322c-4a71-a88d-b9bb3e56223b
	Total devices 1 FS bytes used 144.00KiB
	devid    1 size 10.00GiB used 536.00MiB path /dev/sdc1

  Label: none  uuid: 34549411-c9cf-4118-8e42-58dbfd5c4964
	Total devices 1 FS bytes used 172.00KiB
	devid    1 size 10.00GiB used 536.00MiB path /dev/sdc2

  Label: none  uuid: a9ec3b45-f809-49ad-bcb2-bd4b65b130d8
	Total devices 1 FS bytes used 172.00KiB
	devid    1 size 10.00GiB used 536.00MiB path /dev/sdc3


modify foo and send-receive

  $ xfs_io -f -c 'pwrite -S 0xdb 0 9000' /btrfs1/foo
  $ btrfs su snap -r /btrfs1 /btrfs1/snap2
  Create a readonly snapshot of '/btrfs1' in '/btrfs1/snap2'
  $ btrfs send -p /btrfs1/snap1 /btrfs1/snap2 | btrfs receive /btrfs2
  At snapshot snap2
  At subvol /btrfs1/snap2

  $ sha256sum /btrfs1/foo
  5a97ea23517b5f1255161345715f5831b59cbcd62f1fd57e40329980faa7dbd8 
/btrfs1/foo
  $ sha256sum /btrfs2/snap2/foo
  5a97ea23517b5f1255161345715f5831b59cbcd62f1fd57e40329980faa7dbd8 
/btrfs2/snap2/foo
-----------------------------------------------------


> 
>>      (Also, the receive-mnt can receive from multiple senders as long as
>>      conflits are managed externally. ;-).)
>>

I mean multiple senders on temp-fsid mount as long as they have the same 
superblock::fsid.


Thanks, Anand



>>   Replace:
>>       Works fine.
>>
>> btrfs-progs:
>> ------------
>>   btrfs-progs needs to be updated to support the commands such as
>>
>> 	btrfs filesystem show
>>
>>   when devices are not mounted. So the device list is not based on
>>   the fisd any more.
>>
>> Testing:
>> -------
>>   This patch has been under testing for some time. The challenge is to get
>>   the fstests to test this reasonably well.
>>
>>   As of now, this patch runs fine on a large set of fstests test cases
>>   using a custom-built mkfs.btrfs with the -U option and a new -P option
>>   to copy the device FSID and UUID from the TEST_DEV to the SCRATCH_DEV
>>   at the scratch_mkfs time. For example:
>>
>>    Config file:
>>
>>       config_fsid=$(btrfs in dump-super $TEST_DEV | grep -E ^fsid | \
>> 							awk '{print $2}')
>>       config_uuid=$(btrfs in dump-super $TEST_DEV | \
>> 				grep -E ^dev_item.uuid | awk '{print $2}')
>>       MKFS_OPTIONS="-U $config_fsid -P $config_uuid"
>>
>>   This configuration option ensures that both TEST_DEV and SCRATCH_DEV will
>>   have the same FSID and device UUID while still applying test-specific
>>   scratch mkfs options.
>>
>> Mkfs.btrfs:
>> -----------
>>   mkfs.btrfs needs to be updated to support the -P option for testing only.
>>
>>     btrfs-progs: allow duplicate fsid for single device
>>     btrfs-progs: add mkfs -P option for dev_uuid
>>
>> Anand Jain (2):
>>    btrfs: add helper function find_fsid_by_disk
>>    btrfs: support cloned-device mount capability
> 
> Added to misc-next, thanks.
