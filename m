Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA917BC672
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Oct 2023 11:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbjJGJbg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Oct 2023 05:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjJGJbf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Oct 2023 05:31:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CED6BC
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Oct 2023 02:31:34 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3973MeZM007785;
        Sat, 7 Oct 2023 09:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CppS1w8vhqU7Q5ZesMowPdurEjyov6KJIRXmL5thQIo=;
 b=IZcDI13VO5HgIDPrBwtdoGL4VZtQp6e2S/R82Al5RpnflxcFOv2RatUr/DSYeOKfSDR0
 QCKQXwGinsh82YIecFYepz5Lk9nWQqy7NtRssyF821g1+rv6CMbQSIOoJpeyNhnjo83H
 EB9CRQdN+7uGcQ3TDhRXyQjnNXjl2XvLGugNvBydsJuXOtC4zTMO39cKO6C1hwahiwr1
 gvz5rUVe+YsuiprSFL+5xTEch+OdFBI7i4FiuAZt+2KMfaKaDJuLFR0sdKpZ7J6ipDl5
 nvUbfgpQMZb08r+O1nILsi0SkZveypdJ4ect8P7BoBDddm1fiYsL2LLM5oO1JP9ajdVS +g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdgcaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 09:31:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3976VhTA016304;
        Sat, 7 Oct 2023 09:31:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws31stc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 09:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmNizaqNcZXn1mKGbTMoYsXrRVIla4klGpP76DUSJZQ1joCI+nRkg40ykvTlmx78qzydvBfGTU7K97Cjb9IaVBe0B30dJy/vANFm+vCv7a3yZPkCZdyvvgdP+Xd7wYF2oWgNM61u1UEUUS0OAXevwf/GzOlCO97ydMXrnkgLvpZd29wavCWO2G1mSKfVpqJMmM5JwqBlbb0hn2zO3S2a+xLRkMjnxOaw3XW+9aAEVaBLKSyX7UtfhI1iW6WLaD/aLG/Wuh5XlBpH2eotsrrBduwoFyd8yWThbdmBamA8iLPBKMBgjIIfnkh7Ybk38jPVgJ9uh120Rz0DirxXsWKkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CppS1w8vhqU7Q5ZesMowPdurEjyov6KJIRXmL5thQIo=;
 b=j9jWKQGTCULBvgwxi0C62FddblMATQ8tbSCIY4g4n0R/bip5GwtAE40Eju0fxsLvnB1jl3uvh864FE34eGy99YZd3MweWz29p89TgdToL3eFq3SWW/a3CmZuIBCjbCh8n7QuGKXDjn/TCLinaBU1U6eEpo8v31DnFpeZGuw/862yoE5hUtUxpNkB/tWAhR2W7HSgLikNdk7IRnusNH03juIKCAK16rtv1uH39f2CDmG0R3rQnmH4nybJjBgByJwPfJSyoIsMEmDKFfPX9yH3vmgM696yFQHxap/nET/6317HBSuf6QUCZ+a1BRjBu+eTakpP+GQIApUyKFVAGGDBug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CppS1w8vhqU7Q5ZesMowPdurEjyov6KJIRXmL5thQIo=;
 b=knOXGya0cclE0cfcMMxOFTXFcv9/3RkKvHRNzcUV1U0UniiuZExdwrfIr+9gkR504LBqy7H8e87uCbqnYkqytYjH6RvungfjJwdybrAAfv4/eili2IufwMs/VMujW11ZbccaJnyTPWH4wu5gM28sEfMYfMxQRauyUPiXyc/GAws=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 09:31:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 09:31:18 +0000
Message-ID: <ba5ffc5e-c23b-4728-84aa-be968ce98418@oracle.com>
Date:   Sat, 7 Oct 2023 15:01:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: show temp_fsid feature in sysfs
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, gpiccoli@igalia.com
References: <cover.1696431315.git.anand.jain@oracle.com>
 <9fca0011d2ac24f7b84990db1c4af5eaa60da876.1696431315.git.anand.jain@oracle.com>
 <20231006145550.GG28758@twin.jikos.cz>
 <b658ef3f-9fd0-45a1-8950-c86f4f1b450c@oracle.com>
In-Reply-To: <b658ef3f-9fd0-45a1-8950-c86f4f1b450c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: c94db669-5c8b-450b-8e07-08dbc71828f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYV7iBP3VsBIYQparj6Y2zb2F+NIUeac6NvnNlwZhwyXld0gwGewpo0H3yOniBHbsvywbNOPrmgRL7w19CK6rYkUntYMooXX9Z71pRh2x/0JrCh8MvYBrtf7kXB+lBIXcYqsc4EVRWflcGEmIBOWgvN7xihMMaF8dfvZxSsLyQj6L1B+bkBo1uPJBQrMdFL/awWSolOLdHKjL3K3ZQbkyRHfDlHdXMbSMx1RGMv9uvn4SALzqhL+x8QllxzFdQcXNnSBMfXuw3TvvNzNzBkzRIxvyjRJTuleo7fpcFOqPeIG1hwxb8tZnvpG7jMb0xMo1dUrhCfmCHvANXehwwt4y9+Kg1DgYhdl32L1xZvtl2Xcopq9LHyn3ae9ubO1SEDYUmBNijZTGVOEzm/6qDZIlXAS0fh0gUAK0Yd+HGxCwFfzM6mHa+vRLw7qMequxTSINmh3rOO6YHp5BA76GI0DzpDy7l4LcuYreebO5RgjllVUZ09BUI/PU1xrkIKcHDEm5H0fHj5wVK0TY+drOwCznBsOlnYHC+MAzDTxZ0aWt6STnrzGgHurz3JtwrLXpmZLh5Zii3xAQC0OFygJHvzW0UO5Oz7mYsEJbQMl/hdbjedE7/JYnN3WdNLMVADY7mfJ/coH4vzuvdUoV8NlxYo+NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(31686004)(6486002)(6506007)(53546011)(6666004)(478600001)(6512007)(38100700002)(36756003)(86362001)(31696002)(2906002)(316002)(2616005)(66946007)(6916009)(5660300002)(44832011)(41300700001)(66556008)(66476007)(4326008)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWovTzY3ODB2dUNreEJlZFJTZkx2dW9Xank1SG1YL1JFLzVvaXpZQmFqZTJC?=
 =?utf-8?B?a1dyVUl6cGxSc1Q2SENWRDZZQ2FyVkpVbjdvQ1RrcllJanBzZytCNW5GUkJw?=
 =?utf-8?B?Smpzd0tjc0JxWlJJSjk2SGdxTHFGb0FYNWhWRU9NWXVaYm5JNTIzY0UxRDF5?=
 =?utf-8?B?MmxSaDRVbEc3eGkrV3hLc0Z4VW00enZONWFsOFFUVUFSNEx5bko5NmVTZExl?=
 =?utf-8?B?ZXIzSGpEQ1c1LzhzMXd3RjFXY3hKQlJvNkM3WmxWZFNTa3JUdWUyZFU3K09W?=
 =?utf-8?B?c29ueDgyTE9jTHd6WVNtWkU5YzJVUEczNndLMUtYMzVtbmQyRDF3Rjk3Vkdt?=
 =?utf-8?B?c1BkaUJXemdiaE1hVFhSdXdsQnNzRktCMXNrbmF1c1UwRzREL2RDMlBHN3FC?=
 =?utf-8?B?ejFoeEFuMXNTRnFPaEVtRTNUbGNWTkxJY0prbGkwZTBNT2ozN09aMEc3cTMx?=
 =?utf-8?B?RlEvTmVQSkJVY3ErNVFEZmV5NWRwWWFCSUdMWU1lU0o3MzY4SXRFQ2pzcUxa?=
 =?utf-8?B?VGV5R2hpcTJpQkRGaWNjUWlVTEg0eklXbnhTK0xhOEc3MndqY3oyNVhQVzFZ?=
 =?utf-8?B?VFhWVjU2YkozaDAxb0ttMUUydU9FVVhyRDhtUHZXSCtWTEp5ejBLMWlGR0hp?=
 =?utf-8?B?Tm96T3gwc09QUFBqbm5PNFNudzQwTXpoRmNES1ZneVVMRGhMbWkwbE5KRUdn?=
 =?utf-8?B?TnVTakJjS2dqY3M1ZmxLZFJ6QlVSSFAvWk1sbXAzZTZ4a1JjUXZ3ZUJhMGdu?=
 =?utf-8?B?SlBVcVptR2twZ2h1TlBsMFluNzBPaFd5LzlLTmlMcXVxRGRaMkhZamZ6bXFi?=
 =?utf-8?B?RXo3ajNLVTZqNDFrcW90dHNiUmRua0pvMVRBU1BDMUFsbWtHbXFvSktyMlN1?=
 =?utf-8?B?YmpmN29HaEk4aFdrMFJXOFhEMk51WTFOZTZZY3k0eHQwM2R6NHhpaTNXNWhZ?=
 =?utf-8?B?QW1HVXZ3RVViVVM0eENTZFE4aFBLaG43OXVId2NJeFFtUjdCMk9aak1UNnRj?=
 =?utf-8?B?OFUyV1BPdWY4U2VRUDFyMWp0MVlkd0VNRGVPaVFXL1V1am5nalh6d202ZjBF?=
 =?utf-8?B?N0FYd1c5VnI5K1QvdVZSL1FtUXVkQjRRbE9GR1hBcFBEamFGTjk4RVlRc3Nw?=
 =?utf-8?B?RmZocFBKZlhvNzVpRkpTbGsrUmd3Tkc4L0pIdmFnQTFFcmNvVmdhT2tFaUFh?=
 =?utf-8?B?dERqWVlLQ3pPbThjUWJVSVFaOThOMTZLOHNmZm45MFlpYzN4ei9VbXA3RlFP?=
 =?utf-8?B?azJrL2dJcDhxZFBza0MzQ1kzSDVTMDdkRVVyOEF1QlViR2MwR1BnelVNVk0z?=
 =?utf-8?B?N2dUa29rUlk1ZnZ0anFIb2JxYjRBU1V1eTZ0NTJwZ056K0xQb2YyWS9ZYVB0?=
 =?utf-8?B?dk4vK3dITHpIS3ZYd0kyNXRPSmlLY0gxVmJNMjRaM2xsT25EWnQzNnRkeVZC?=
 =?utf-8?B?NU5BaDVieXQvUW1WakhseE5zOHF0M2xGblRwS09wREswTEF0cDRySFFVZjRm?=
 =?utf-8?B?Rm1DWWJ1eGpKM0I5RW9Ya1lpYWtaNjhwUXhlRDliT0hjSjlTdzFCWnQvdXp4?=
 =?utf-8?B?SEtSdGpYRlNjSE4zOFAwK3RGNHZzTmozMUMwZjhyVVd2dXgzekVtVFRsZ1l2?=
 =?utf-8?B?MTBURmhKSzNuTFEycEJab3M1RU95OGVuQW96QUN4Ym5VUGo2UVFxNUY4cXY3?=
 =?utf-8?B?WFVoTm5JV01FSTVhQVNtUE00V0RLY2pCWk1DdTQ5VmYxcHBteXpDc1BxdnEr?=
 =?utf-8?B?QVpvVm5zTjFKd1k1SWNpM09BZlgyeVhFR1NLclNpRDdrK0lVQUVzaU5Pb1p1?=
 =?utf-8?B?TUEzekd2L1lQbW95bTFIYTMxUStuWlZpQUxjZHJNUUx3ZlpEZkpjTmdCWG8r?=
 =?utf-8?B?Mk5sQ3pXaVFmakJDYzdZSWJLVGVxTU1uYktaUW1uREl5NWlIZmVrSVlRSDU5?=
 =?utf-8?B?ZUNma1JIVHdxbTQxSGZkOHpueEYva0N3NFVKbENJZmxGNkhIWWVpWlhxUjQw?=
 =?utf-8?B?TGhNTkNDZEdRbWhDUFk0Z2JzbVNOblRVaHBBK3hORFAvam1KeHB5RUd2Y09X?=
 =?utf-8?B?RWduMmJqd0VqcHJYZDl5ZSt3eTVRUjk4ODVFZGVuNU53S2pUWFg2Y0pnN0NY?=
 =?utf-8?B?RnBkY2hOZUFQcXNTcWpKT2ZWWWhmTDZma0hUOTAybkpLNDR0QklhQ1B5N0Rt?=
 =?utf-8?Q?EVW5SSQ+pC9chmxCZaE3AgGmrN8KYIQqqjzr1HI4wdHy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /ES/Y92gJz+8fSF2Hy7QGPZ4t23JU5YU9VCGd9hcvj6AI15F1dhjzkTRUWjzDmE39hGCPKXvbZ35pfwwi+G2AFfL0tKbcnjzn3UlL/h0DXuYpwxpBtWAxaoOCNw5rOmrHzP07y0xODLgsBgLSV80JIvM0oeLARtitu3PKAyGNLRiGtV7paj+g2+7joxkfq2GRbyp1PwVBO47syndjh3SF8Wdpo7JIQQYYa1mfAiGA3tyjyp6cAz0tTpkaxC5KfW/iugEo3j6sXkBfzxEQCGdHOgupEOcrC5JKYrmwzRFOTN72bDYS28atKveeve4JgnrACmgYW/CD2c0DYbrxz2LokHOT2n6VeroKjaH2XdaFTdh6RzH7fbrOfb51dAz8ch5GEU4upKeETLL5bPFe/6nqGKvwupq82NAi7a2DFoWFX6w7lRcIYH1GG2wQ0jfDY74FF1XijI3aQDH8IsZstbi6mpCUDnlgG6wQf5fKHcCp4AegoeBlWyLzZGanQ4cFD2Qb7/ch7q9fIpCWqsF2KaWMH+ZSmvEtqWIwBOjtFO/3tmVUFesuYU4wVfb7NWlSOd7ktqp+xMD2hMdJKdCJt+NrV4bS3dcZY0ht8jmb/Wt4TAyWF/dPl5NqPanM1tK3m9e8suGMR7y5enovl1hW/dKVNCMONb/nbJY8pW/iVCtB1C/BpM5dj8BW2VIvH2rrzQkGLs/dE618s3RMX7iEYN1AeE6WLWVf9WF5BbEa6/ub4kiJO8NbggSkPkIZSkfrLWxttVjrZTJUogBZrjRBjlL+L4igYKf0h30YDgDn1vjtngSebW0Dx9gXY/hSUVXzz9s6xMurSkuNfhrqjXzdaiUCA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94db669-5c8b-450b-8e07-08dbc71828f5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 09:31:18.7127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ff5HYFszJNmbIQ86x+Qjx95Zy64+mqwX1AXjcGMLmHsIszGrrfqXolAUdqPBJRQeOIvjE3UjsMBpMzqal+2LUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_06,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=773 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310070083
X-Proofpoint-ORIG-GUID: m9sBnXmjySUwyTNkYcLv9Agkw_B8JfJb
X-Proofpoint-GUID: m9sBnXmjySUwyTNkYcLv9Agkw_B8JfJb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/7/23 17:12, Anand Jain wrote:
> 
> 
> On 10/6/23 22:55, David Sterba wrote:
>> On Wed, Oct 04, 2023 at 11:00:27PM +0800, Anand Jain wrote:
>>> This adds sysfs objects to indicate temp_fsid feature support and
>>> its status.
>>>
>>>    /sys/fs/btrfs/features/temp_fsid
>>>    /sys/fs/btrfs/<UUID>/temp_fsid
>>>
>>>    For example:
>>>
>>>       Consider two cloned and mounted devices.
>>>
>>>     $ blkid /dev/sdc[1-2]
>>>     /dev/sdc1: UUID="509ad44b-ad2a-4a8a-bc8d-fe69db7220d5" ..
>>>     /dev/sdc2: UUID="509ad44b-ad2a-4a8a-bc8d-fe69db7220d5" ..
>>>
>>>       One gets actual fsid, and the other gets the temp_fsid when
>>>       mounted.
>>>
>>>     $ btrfs filesystem show -m
>>>     Label: none  uuid: 509ad44b-ad2a-4a8a-bc8d-fe69db7220d5
>>>         Total devices 1 FS bytes used 54.14MiB
>>>         devid    1 size 300.00MiB used 144.00MiB path /dev/sdc1
>>>
>>>     Label: none  uuid: 33bad74e-c91b-43a5-aef8-b3cab97ae63a
>>>         Total devices 1 FS bytes used 54.14MiB
>>>         devid    1 size 300.00MiB used 144.00MiB path /dev/sdc2
>>>
>>>       Their sysfs as below.
>>>
>>>     $ cat /sys/fs/btrfs/features/temp_fsid
>>>     0
>>>
>>>     $ cat /sys/fs/btrfs/509ad44b-ad2a-4a8a-bc8d-fe69db7220d5/temp_fsid
>>>     0
>>>
>>>     $ cat /sys/fs/btrfs/33bad74e-c91b-43a5-aef8-b3cab97ae63a/temp_fsid
>>>     1
>>
>> So the fsid used for the directory is always the new one, is there a way
>> to read which is the original filesystem's fsid? In this case it would
>> be the 509ad44b-... We could print it in that file instead of '1',
>> though it could be confusing that it's not the temp_fsid but the
>> original one, file name mismatches the contents on first look.
> 
> Instead, can we emit 'fsid' in another kobject altogether?
> Furthermore, we also have a 'metadata_uuid' kobject. Here
> is how they relate.
> 
> 
> 1. normally:
> 
>   $ cat /sys/fs/btrfs/<meta-fsid>/fsid
>   <meta-fsid>
>   $ cat /sys/fs/btrfs/<meta-fsid>/metadata_uuid
>   <meta-fsid>
> 
> 
> 2. metadata-uuid flag is set:
> 
>   $ cat /sys/fs/btrfs/<sb-fsid>/fsid
>   <sb-fsid>
>   $ cat /sys/fs/btrfs/<sb-fsid>/metadata_uuid
>   <meta-fsid>
> 
> 
> 3. normal + temp-fsid:
> 
>   $ cat /sys/fs/btrfs/<temp-fsid>/fsid
>   <meta-fsid>
>   $ cat /sys/fs/btrfs/<temp-fsid>/metadata_uuid
>   <meta-fsid>
> 
> 
> 4. metadata-uuid flag is set + temp-fsid:
> 
>   $ cat /sys/fs/btrfs/<temp-fsid>/fsid
>   <sb-fsid>
>   $ cat /sys/fs/btrfs/<temp-fsid>/metadata_uuid
>   <meta-fsid>



Let's consider this thought:

The proposal above implies that /sys/fs/btrfs/<temp-fsid>/temp_fsid
will continue to function as described in this patch. Otherwise,
determining whether temp_fsid is enabled becomes challenging.

As part of the temp-fsid feature, we plan to introduce two additional
kobjects. However, if this results in an excessive number of kobjects,
then...

We have the option to rename /sys/fs/btrfs/<temp-fsid>/temp_fsid
to /sys/fs/btrfs/<temp-fsid>/temp-fsid_enabled_super_fsid to display
the actual sb::fsid.

Thanks, Anand
