Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD316D8EBA
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 07:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjDFFQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 01:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjDFFQP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 01:16:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D008A7A
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 22:16:14 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335Icwue008083;
        Thu, 6 Apr 2023 05:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Zj7N+Ll+jA3hPTnrUhON9x9uG97jQjojEPprm7mifto=;
 b=j9cSz5IwuD9CoqLRhvY1j977FRvOknktJiGcqHK0u0lQm1ccRlZ/EMrm+iVuvSqup6LC
 MRCKt6UJQzfhUtV+0UYGn+KzfUYGyidYy70PTExSHUd6I4F902AboFSMUKTLHYzth7cq
 DibMmYpsSuMm+jTJYQJBuUPvGPuKq6KuBSJz/EmJSTVfVMcwPlEq12D1XOFHCygNXMcE
 dLGJqTG7qwKywa4YhJbckBiCPPa6eLqHyBPGRok20BUnGAQg5t1Zm9tfjupYsz496yoA
 vVD4PwnBMz/lNoG7TtgZQ095sAzDTFvQJl8N1az7nZiEYxFPL8dIB+Ilo3HymvTJUdBY Ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb71t47r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 05:16:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3363KCUQ037384;
        Thu, 6 Apr 2023 05:16:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjup8xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 05:16:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOBxzXvxZ048eea9VZakfY31wVDM7Ikf2wg67rnI2234VcSW+ki6Wc/g9k5owXE8sktrfkSQ9vfuPXkmUeuPiZll049AP5No1iGi44II03Hx4395bluS5yWFJJ8VoOOOcaGWmXR2C3imvxGk/07hEuNDlxcqDUgTn3AoLqeBpFIXIXAVS/XD7a1BlMhG+CcQSHF4TYRUEsKGxfJwREB8K/uDfhLbeBKiQ9+rrm+HpXg5Al8vfwnf7DjbSpA2uIyd8YHxRk3RyRd10o+I6GiULJ6k6YdvTrFPFI/mqDZHi5i0L3z7YfiK9vbHZQwIKwCCrxe3HMB4SmnZEbzF89zMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj7N+Ll+jA3hPTnrUhON9x9uG97jQjojEPprm7mifto=;
 b=fQor8L9t/t6gQ6kxnA7TgCbkDOHGsLqfyxwxaGfARBySR1EAYj+UvmUQ2wLMl/DwdxEiJCQ0VXtPHVnB0cXCj2gNu/hDmRs3+jtKol/GkGFBaDaPQHlOjwTN5ybSTbx/Mq6YT2dBrAGgHQlY99SevUdqHqyXnLlcWiWkbEjzJprSdncClLAcaKFZs+3pS2YIZD7iix9iSKoyUPkpfo5mbaX8DI6A6Gx5VhoAORCuAwVg7tN4bMjFvcJsmrTCS4os/V5kxzKO9ew38IaxDYP7/j0SaEj4uLExqKi3c79QRV603OfCVhTj1AdlmSn6hk9NmKD/I35w0Ofcscif2BDXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj7N+Ll+jA3hPTnrUhON9x9uG97jQjojEPprm7mifto=;
 b=ziU0IyMGD0vqgQCFFM5G6ME4uixvWOJdR/su0rlhdbs9PCzxMrSa9PPoGcPwZkxp/8cXxWIpla3sqMrQ/214qEt4wEwp+7YmxW3vhY7udYmYHMwuKEGykLXF/7MXpdngOFaomkXkaB7d3LcMYsgJA1Ym7MnFvaNlvDFmEXH67XY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6682.namprd10.prod.outlook.com (2603:10b6:930:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 05:16:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 05:16:07 +0000
Message-ID: <21aa8548-7131-f175-d004-dd9969edfef6@oracle.com>
Date:   Thu, 6 Apr 2023 13:15:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 1/2] btrfs: warn for any missed cleanup at
 btrfs_close_one_device
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1680619177.git.anand.jain@oracle.com>
 <584322021db1e182838b5dc9d90459850e5fcf36.1680619177.git.anand.jain@oracle.com>
 <20230405173726.GM19619@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230405173726.GM19619@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: d48aaabd-f4ae-42ce-1e08-08db365e0697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKVQKt7wLHw/610BROgNkxE9SUjpYUAuzfSdC8BVv9h5Z7e531MjY+fF7OdaPo15WyJXld4THakiHQlyh+4/M42xUDJA3SQF0FRz+Cj4w/7mx3e2o/c5gA5RG1ae/nd5Ip3ri50HRhmNHFpX0wrkdFFlirPCpU6mUNO+CktgMAgEkM31z/g27Zbo4DrNsjsYvXGCszCdRi4VQSrAJtSZajhA3c1fMkEc5sGRAAcyJLMxf/h5F/nHZqySAQJFJ/UWEnon44UhyamnxSalFHBWcXDxNjpJ6TvDbf+l/EeZ3r3D4yaQidjH5y6Cg0+7x+d+ZzC13TwtOyFiD6QCK/+t0FkmVB0kWAiv6W3BBzyV8+4KVuwkUcQSghxB0Oy9Upu6hgRNUW1SkxJV4jyTMBX4YsSfMm8HRGHibTJ0R7xUc52Ts/3Tb2ScCCFyW4rBXPEChCTo8K2/DqFFtLiWiSrgo5r02be/ryaj/ijQHkgYHVv8YHcfHFbnL6gZ5R27G5JuDQLIzqZWnrjNsOwE6vyW4kcfMycUMLd7XzZ1HLzQQ50aSJINcDTCmx1lFdcdLiBQKW5sNcv1853sAdWfPaC3oFNqgrLdyChPoG1/3CuKn8Kii+otE0G5i1SegZ/+kMvOJwPaHw8m4ME9zVhcv2JnUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(31686004)(38100700002)(5660300002)(2906002)(4326008)(36756003)(6916009)(44832011)(66946007)(66556008)(66476007)(41300700001)(8936002)(8676002)(86362001)(31696002)(2616005)(6512007)(83380400001)(186003)(26005)(6486002)(6506007)(53546011)(6666004)(316002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW5tQWZQSGRzRXpkbm5UeGdMdUkyY1doUDhQUzkyY2tUdGFrZHUydWwzdkx2?=
 =?utf-8?B?eHRBeGMveVBFVEpBWVZhK2owS1VhaXpIUFRVRkFEb3lSQVk0R0xxeWNCL1Uy?=
 =?utf-8?B?ajUwd0ZEdFNZQUhyemhjRHJWbEdIYjQ4OWZMdGpSeE1zOHJIY1FSUlBiWEpp?=
 =?utf-8?B?R1JVNHhUcVpNTHFrbnpab0VtNEsyRUxaRFRoMUNETVkvbHNRWFZIdDgxbDQw?=
 =?utf-8?B?THJKU2lUVGh2bjV2Q2lIekQ3THI2bGZNTklDNlZwdmtqMVltSk9pbXB2M0wr?=
 =?utf-8?B?Ryt0TjZLemYrSmtaWENwRXhES0ZLcWZLaTI1Z0JxRXFROGRHS2lick1WUnFk?=
 =?utf-8?B?VjJQb2I5Z25hV2JRSUZKTnFvNmNzOEFiSHdMWXdHV1JQLzB2OGpDRy9ZU1ls?=
 =?utf-8?B?M2VQRUhOZ3JSZHoyamFxTFpHcENMMm5Jd3c3aW14eS9QeCtHYnZacUgvWkFB?=
 =?utf-8?B?TVhSOERhTVhTdzdSeG1nR3ZwUWVNSXRacmFHenVxUUxhVUhiKy9JWWlNRTg4?=
 =?utf-8?B?QjIwUW9XZENMWVE0YlhmYjFBbWFBMUlKREh3NmNVQlJpZ1EvVUd2dk9PeWJz?=
 =?utf-8?B?ZSs0K1NIOU9nWXVtd0o5T2pMQVZyRXkvNFZ5dzVsQ0RldzVUY010NU83WFJP?=
 =?utf-8?B?REsyejhOd3kvK0FpYWU3RVZGQS8vODV2Q09UVnZxdGdIanN4UjRmS012eVZj?=
 =?utf-8?B?TUtqaWIyZ1B2MXZVcSs0WjlYcWRLWW5PaExqOVJIdUt5YTNmRG0ybHRKTmNZ?=
 =?utf-8?B?TGZOSmRNdEpVSTFudURUdG1XdmJWeVhhMi9HVXJzWE9XMCtSd051Ym8wa2VC?=
 =?utf-8?B?ZllEM2xsazVmMzVNMCtPMnRZaFRzc2J2REQvWSsrTCtCeDdoUTE0T2N5dW9H?=
 =?utf-8?B?YWRTWGtNcWRUb0ZRb3hYcGlDUU9nMGVDZVNrUEwzeks4K2FVMTBBeUFCVFI5?=
 =?utf-8?B?SngzQlFWTlNjRlZyTWM5ekhWeHM4ME5nTE5Xc0xERXgrTVQwbmorL00vK21F?=
 =?utf-8?B?RC9aanpyV1kzUS9YNndnd25qUUd2MjJtUC8zT2RZTEViY1ZSdTl4ZHNnRVFH?=
 =?utf-8?B?MkdGMmgvdmJZbjRSS1FPS0RHVkhQdGNHZk5nNU14Y0NLYXhIU1FCbXlldzNx?=
 =?utf-8?B?T1NrSllkaWlONmtPbjFEZU5oZmtLRks1TWJQUzBScVUwS2g0a05LajY0cVJD?=
 =?utf-8?B?Y01mbVlONlA5R1RrWDN3NS9VdXF1d2hBTVlIKzhvakVIZjgzVVlHNTAyRkZ0?=
 =?utf-8?B?aGJSTDMxMyt3TFpNWVdjVmkyS3ZoelVDVHNDUEY0RHYzbnBIOGk2SnAxbUNx?=
 =?utf-8?B?cng2dHJyd3ZSbXphOHBlMUlIVlVWVldxc1UzM1VCOEZlSnRXWnBjSmg2S3NT?=
 =?utf-8?B?dG1COVpUM2kwTG5waUJBUHZDOUg2dCt5SHFjaXdPdHpuV1cyRGN4WEN2MGxy?=
 =?utf-8?B?QUpKRWxOMzFhZVROVk93UWtWSDNHblpZMlNBTmtBT2VzbGI4cUMzMnBqOUpq?=
 =?utf-8?B?SzRGcUZpQXJuT3JpMlZwMDhXVzl2bkM3ck10R1FRa1MvbkQvNlFvZFYyV1hM?=
 =?utf-8?B?K215VVZrQkpSSk1abHBoNFFnQUFxNlNoRzFBZTNHZG9zd0IyQnJXN1A3cHBm?=
 =?utf-8?B?REcxbXl3Y0N4TkhTQVN4VlM0L1N1eHh3M1lHQWVuUU1qaGlGaXNwczMzN1Zl?=
 =?utf-8?B?TmUrcEpZUUQ5emtTRDZqVjJ2RDR4bEZ6SHFtNGprdkw1cWQvQUhVZnQ4Vkdw?=
 =?utf-8?B?SHdJTzZMdzZKdjRyRFlDRW52ZXlsT1RFbGtZZzIybEIwVXk0bGFHeUdEQ1FE?=
 =?utf-8?B?TElxL3UxRTEzekh2NUxPUnkxZzJaV1BQMVRDQVRqT0o5UjRxMFY4QjJ3ejdI?=
 =?utf-8?B?Zm1RZmc1SnEwcVFXdWtXZUpyN2RzREVzUkFaM3NXSG9DMDZ5aWg3MEhwYjU2?=
 =?utf-8?B?SFk2RUZvQ3JTZlJNeDRnTU5YVkV3WlErS1JDTVU4RDZ6R2k4NndNWlllOE5u?=
 =?utf-8?B?WVJnZEVNQ1p4dWhLTmJwTWpRZjNqYnJONlA5WkhaNWlhVUF6RHJXa2lVY0g2?=
 =?utf-8?B?SW1IZ0JDQUw3ZHdxMFdMZjBLKzg1ZW55bWpoZzFLVnE0d0d5N3NuZG5DenZF?=
 =?utf-8?Q?6ob/4zEBEKbeWf7Z5Qad0TDUI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RNQJPNS211RTJlv3QbsLxVbr7ebtn6XFwYT3bA0JWPzNdO/5OHqbAQqS9iiKCqE0sjMi+82KemQ6qLGBpIGIfQ/8+ZDcuk87eqaGZfwO8YqquXQit88TScfWT3tsUni5wFVOTShG5TZFlcV8M2RNy26xh7fS33ozQIST5Z0IrEeH5/uDMDczXUsZmScIF77PZql9yERXuYW2g4/Jcjt7LW7TdWICo7625ubReTE9PvZcjZdc25sVzHi7zj0PMNy7VCXw9OdcFhmbccN5w4+F4gDyaAV/r5WikbRoQuZFoi+lDTZ4wOLf5k31zzniXcmBBJ3YY6uRl71QTQXe1XKUzSqr4WAeUs8fS+FxfHEhJxl7W3tzNZ0FfDHdYubgWOiNWExGcKvk1UV5yoInBfORrC37xZtWvW0hptRLGmAfJ6EbmDfL8ZSNalg+i/hr6brAuiTaZB/M4t3Bk2v7igN4h7ETz8biILx11zC+cwwu3dFT/TOg34MV1+Rmt4Zcvc9UnR4QvzYMytlslIQEz6zKiVv2YzgREdhm2my69yYtD4iLoMlkeHyX2TFURB7dd4rmtjlbZwA/0EOgpF6zrgTYvKjnu6PI/eaH+6FQYo/5Q/OxagZpprcoJ9i8Sk9jYq2epae1nUQwHi9HoZgI5PJG8JWUjJQf/+TEfBgoZXS5sDXC2CIR4KBQYWxw1xB5Bz8IjobefzRk1Oa+jJsDsrXCaM9UcH9nfdVTedSW+W4JRlePZz3wdyDQHyWLdtY2FoYoAKCkbvwh7Ul/6scmgWFDbw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48aaabd-f4ae-42ce-1e08-08db365e0697
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 05:16:07.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isUmpW0f9tel6MaXD8jJS3DN/TIMDzSYM4hxx6XvioYSZ9od+JpXH3mGEG93AtHJHlDzatZQn/mo0i/yf7rv8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_01,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060045
X-Proofpoint-ORIG-GUID: Xc5jh_2kapkIWD5_tB7MHoPO8LBeZTZq
X-Proofpoint-GUID: Xc5jh_2kapkIWD5_tB7MHoPO8LBeZTZq
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4/6/23 01:37, David Sterba wrote:
> On Tue, Apr 04, 2023 at 10:55:11PM +0800, Anand Jain wrote:
>> During my recent search for the root cause of a reported bug, I realized
>> that it's a good idea to issue a warning for missed cleanup instead of
>> using debug-only assertions. Since most installations run with debug off,
>> missed cleanups and premature calls to close could go unnoticed. However,
>> these issues are serious enough to warrant reporting and fixing.
> 
> There are other WARN_ONs checking for device state so it should be ok to
> add some more.
> 
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index eead4a1f53b7..0e3677650a78 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1150,10 +1150,10 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>>   	device->last_flush_error = 0;
>>   
>>   	/* Verify the device is back in a pristine state  */
>> -	ASSERT(!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
>> -	ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
>> -	ASSERT(list_empty(&device->dev_alloc_list));
>> -	ASSERT(list_empty(&device->post_commit_list));
>> +	WARN_ON(test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
>> +	WARN_ON(test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
>> +	WARN_ON(!list_empty(&device->dev_alloc_list));
>> +	WARN_ON(!list_empty(&device->post_commit_list));
> 
> I'm thinking if we can reset some of the values to a safe state too, not
> keeping it until the next time the device is opened, because not
> everything is reset at device open time.

Good idea. We need some cleanup around these code lines. I will send 
patches.

Thanks, Anand
