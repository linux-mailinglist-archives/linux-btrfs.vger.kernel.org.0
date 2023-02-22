Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F2869ED63
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 04:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjBVDR3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 22:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjBVDRX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 22:17:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350F134025
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 19:17:02 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LMiLTF027234;
        Wed, 22 Feb 2023 03:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pidIPSE5MpSo6AjkctPUf3eoGvSKshyLKeg78cqBYys=;
 b=PyHHjomNCOlOfCdQ+P3T4By0KTATCmxl00EJ7V27ginAdyQVB7wmirxn9vEeOzAKkrRb
 MnnbyVZdUSz7tfSACLn3ShCr1Opym12zBmGNqvJCeIC57035s4ANmDCcLbGvMn4ThY3F
 Z0lFlcn0RAbNStPE3mlw0cK1Go0uq/R3XDt3DX3FDV1jiPvbHlKcGdh8RwxlZVR0WNVP
 sZpDyPwa2Qx7FxXuutlq8dXQdOWxMsV6MeCX4jUmQhxQrUNVvP76GevsdyUwDZCoIa6l
 4JPFtayP1uvKqs/w/giY0NoqNMqsCxUdYQCX9d35DK9vITjsmOYhjcXxUnzT9ip0/6ma zQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbpuhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 03:16:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31M30ekv012997;
        Wed, 22 Feb 2023 03:16:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4db5c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 03:16:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHJr4BFW3kUc2Lt0e7HyjvgoKdMeJwBN92xR/FU9A8lCgBjKfZI5GPr7xTAPGEpxypgEsb8fyecnp4HmUF3DoGlvOLB5AD+0we3g0IUKumZdRssGtuCtiva2ld68rvSbePoqS7q3cAdLnEyY9DuitNmbjwcrcsDZ3FoO4HQ7KKPW+ySLU03hnLNuMaDsqF/2nGtbic+79Tk/ahMYhz5joSbyHc9HIRi2UgHMnMEZdO1NedCX1cThB1cE/bt4k/SpVDKMNm6SaNd4LoG70QxmjVAIBEKSl4cYDpJaPCfNzXriH47LWgS9s6RVIhURfNoc5sGa7MftAHRbhssLiS2tAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pidIPSE5MpSo6AjkctPUf3eoGvSKshyLKeg78cqBYys=;
 b=fz8jPb9vCgb9WDKRjzsreZGmBcR71WJvWyyJIdsSuRxheumd/nhTn14HTk6O1AmV40aib31crlF8dFD1qdpaQCp75Cj0fpol1FGzzw2QW/NUiunN+P4ei30AWJeAqrCyyQHZfxbZa+G7B9+7GPfNZPWiP/mNp6Qr+OL0BjQDxud15/EL4arnBTElKTUOgaVY3zyHQEZtdL5UxChnGpS2DCgoJwAVCb4F82tqfvLH23bLbwalaMe3Q6l0e/CgKwFBQWB70wptSdD3we8H2GLkjbENVxlQGgxWILZkFXcJaJv4dfM3zrWl3NmgW6V7i++W/OofPtLCsIGQjf/6+/NdqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pidIPSE5MpSo6AjkctPUf3eoGvSKshyLKeg78cqBYys=;
 b=Dri9Ulz8IPVvoVafEFJYlRRP5nf9M3AHS8hls2z67LRHG2dYfRjkXDH+EgP8Xp6DL4HVexEOmhMkYr2leXxY+cp9f1QVesnkt4riJ3yo9Q269i9qov5md3Y+Xf0Av9TKhoIisukhrPICvnRbt2YlXKvdQAob2oBhTBNgSHM522c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4819.namprd10.prod.outlook.com (2603:10b6:208:307::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 03:16:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6134.015; Wed, 22 Feb 2023
 03:16:53 +0000
Message-ID: <5634087b-9665-eb7c-e7a1-2be4404809e7@oracle.com>
Date:   Wed, 22 Feb 2023 11:16:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/2] btrfs-progs: read device fsid from the sysfs
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com
References: <cover.1676124188.git.anand.jain@oracle.com>
 <20230221213915.GO10580@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230221213915.GO10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0088.apcprd03.prod.outlook.com
 (2603:1096:4:7c::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4819:EE_
X-MS-Office365-Filtering-Correlation-Id: 680883d8-84ee-4cc6-f800-08db14833ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4uf7WhWDaOpjFkmPfzjCtPx3hFOCnlbTmHe0hJmKbOCqzimzVD9mcpA1E5HFg5QmAj0wlyE2ylleuOggoI/XAUsrSepeb+X/ZPyzI+/YzxjTV3cEZ00gbiStQPlUto+/X8BfNnujkxQtGIfn0OqbwecQYESNZKK17Kqol3hrV8QtHDjpJzkeRmQgGVYroYjcj1kBnBhuIjGmfDRAvzldTxbzmbwf0ptCYr47wF5siiC90nCuLAWsNqfGnNwnIMcVCq2oZVajQhbj9qfllvhMwzv3fPRWNrPsqHxKJrnpNbxj2NAt29ehQ9MvdPZYEKemcfzrMykLey784/G8tZQVb798OMjLOlggiWfrYVowUfMHf4DTX4YtzzIFvSlgCoN1LQbmbqxDQgM7mlCpdGtzAvnIJ3bGjdIpOE28GhlNcp4EomYQX/hjm2pq2e/Xh3oLrPd/7rKqXwwOcQ2fsxH8QZhwyaqA1UC+D4I2PlJ0Zh2HiC1MFrwDOvTnxM4akIRMlUqIV/yvGNODIvKsuCP9oxT4aAw5OF3FWKuJKVOlylBeaxZdeqBGCV0/nreVlehwh9xszMggB4ZUAMVniPRxCHSXRyeT4EGwCOImYNoCZSlzkjYh5DbKHYseNwJFxScx0SOp7TUzP3+VdHpdCtAF97ZicmKULcCrSNRPsE4Jc1odT86KO+gXsbtrBI+9AenjFmQ5/tnte9oJy+fJqDBpIQgHoJp8ertHyoiQuprcFBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(44832011)(5660300002)(8936002)(41300700001)(2906002)(2616005)(53546011)(6486002)(478600001)(316002)(6916009)(4326008)(66476007)(66556008)(8676002)(26005)(66946007)(6666004)(6512007)(186003)(6506007)(38100700002)(31696002)(86362001)(36756003)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnR0d3BLTWlRT0NvNm8xVkRWaXo4MmZTTXZxZXRRT25tSTlSZ0dyVW13K3ps?=
 =?utf-8?B?b1VOM1kvQ24zR2V0ek5DL0ZuY21hNnlWWVB5WkszRG9qaTJPQUJ4Um1BYis0?=
 =?utf-8?B?aDh2NUtUelNlS2Y3SmxWVkRYMTljdFB6MmJxcVZoUGhNQ0VuaDAzRHlaM0Jq?=
 =?utf-8?B?SlBmelI4ZEdzU0FQN3dCYzNtWG94N2NKL0RZUnR4K1pYUTZraEhQRnN4ZFZD?=
 =?utf-8?B?MjBBR0k5SVhack5LdDhoTm1YSk50WlBrT2dRZUMrZjFzTjIyUTBpUmJQdHZi?=
 =?utf-8?B?Nm1oNWZxZGYyVEFueG12Zml5RTRXemlneWRGaHUwaFhVaHRXWnRmblNab1Va?=
 =?utf-8?B?b1hHRzlSaC9kMVFwbENNcitCbzlQMjFkMDM5WVVWTWtQOGtFYzlMMzRMYllr?=
 =?utf-8?B?SlZBSmpxcUhid0g4RncweklaQ0hoakVGK0VVUDVwU2xOUDUwcW83ZWg4dEcz?=
 =?utf-8?B?ZGRVbTV5amlPT3pxY1pFaXF4aHowRk1HSFFDSTlzSzUzSDd6RUJCTjdpd25N?=
 =?utf-8?B?a3hQSlc5a1hpM1drN0J5ay84Q0diSktMYWViUXdZd2NGYU8xRVpvdDBmbnF4?=
 =?utf-8?B?WnR6dnU1V2Q0eWhua1RHdiszaUlvOFhxZTZ5bitJQTYxWmdnbzYrOFlPU2hF?=
 =?utf-8?B?Y3R2NXp0cUYrQnhXcURSWFNVaVQ0OE1jaTFaenA5WXF2QytEemZDbnZSZXJC?=
 =?utf-8?B?Z1pVaVRpNUJjdEw3K0N2WjArV2VCbXVNQlpsMWV1aSsxMitVdDJHOGFDRFd6?=
 =?utf-8?B?YSs5Wk9xL3c0QStoc3Izb3hBMFZmWEVzVVIyeCtZLzE5YU95NFU4S1haRzFz?=
 =?utf-8?B?OHorclhDVlJOcFB0cWJnMjFPeVZScmhLbUsyazVkUjdzYkpETzMzV21OQW9H?=
 =?utf-8?B?c0xBSm5pZ1lhdjJEbHpiT3VaWm1NM3RlUy9UbFN1TnAvbkZKWU0wY2UxdnEv?=
 =?utf-8?B?MUhrUjZkdDRCMDQ3a0pnMGJGbnljR3paVUx2Rm8xKzVCakcvbm5XWWFDUHJJ?=
 =?utf-8?B?NGRRdHRSc1J0dzBtUERaMU9XT05qTS9WcnFsWEZwaU90TElnWWVUVzNVZmRB?=
 =?utf-8?B?cE9tRGNvS0tqWDN2L21JMDBYNzNnOG1OZTJZQlJuTDVBL1F1K2dPM1N1Q3E0?=
 =?utf-8?B?aDhNWG1aWkxBQVlVMzZNZTRjRm1MTHlSMFVqQVBtd0NIK3pGVzJ4ZUU1SDRz?=
 =?utf-8?B?bWJkT3lzbGxRVTEvdEtxayttMERta3N5cCtaWENwdDdVc0NCTFZHdUFaSUM3?=
 =?utf-8?B?NjM5NDBxdENvVFBXYWJWa2lVZmtYOG50d3RJWS8reFZNdmd5WGt5VDE0OTdK?=
 =?utf-8?B?NzBMV3RJUXh2ZWdpTFVhQzJWTU4rVDZKSlVEdnVmMU1jcWpvL0RBSTdlQXBj?=
 =?utf-8?B?RUp4OEh6V09OOStzTkZoVmJWSTF6aElEbFRTeXFkYm90WkV5YlpCRENCYlVC?=
 =?utf-8?B?NVlXMkc2cXJucG83ZjZaSHNBcjN0cFVGWjlDdTg2alRZeHFZOVNrdEhSSFUv?=
 =?utf-8?B?MU9hdm1QWTNiUWJiQ0RkUW9Kb3RhNzRIa0FSVmI3a1I3SGRpdTNCMG9nL3lx?=
 =?utf-8?B?bGZxK2V3WUhvazQ0YVNTYml5L2FJemh6NzQ2Q3ZQSU4rNDhRZDR3Nzh0U2tl?=
 =?utf-8?B?VG01Mzdabzd4bmRsRExvSHZaTHhrT3lWQVkyT0hNdjRXS1E3L1dYZUhjSVp3?=
 =?utf-8?B?bHZpSjQ3R2pyZGcwUUtFcTF0OEZ4Q0JKQVUxem5Ybzd1SFlWczk2Vmp6MEla?=
 =?utf-8?B?QnM2SFlaNEZlUkpQdHJtbGZpRWRESG0yOVV4U1FOYkM5eU1HRlpRNUdMams2?=
 =?utf-8?B?eFZucXB5Z3plZFRrRUpSZGk2RjZQQnlKd2F0WkQ1QjhKMDN1SERqOEdpY3Aw?=
 =?utf-8?B?ZlRKaElkWGE1WGVuYVJhbk9wZGx2YVdYSzJJY3QyOFM1TnNqR2x3SFdscmJo?=
 =?utf-8?B?dEFjcEdsN0tYTTVkRDFON1IxY2lKWTVwN1JrUVFnb2FZcTRmS3YzNVB2SWhw?=
 =?utf-8?B?RDFGY1huNWR4dDhPckJvRlZLZDRJV0xsekRMUTlEQW1maXhFejlUaFBsVzNT?=
 =?utf-8?B?YUh6eTZMdWtLbjhEdlhoUVBUanBodzV5K3VEbzNpVCtoek5YWWdRQ2o1OFJN?=
 =?utf-8?Q?RkZli9OkF0vArRMOsz+dCtPyR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fikJbeRAdZQ6yHA4i1+mwJPH7fwDmZM/8sVcCuCs6NGJCQn9utZXzBqpPHTEW3X1icf0afyXsRd0wEC8S/PRNtfjNUDfrTvH78xW/aNfvT7cFGsPVjQv5z/ALOeoZrfxqbf8PcZuZF5d2ilQOYcSIyimNNKRXD/4dN9rmQkjl5GmNwARQyI7xqdnPTpWDw8QqvW80iDlq3xQqM5w6Wmwtn6olgd82ZUOC4Q1J58OCTwy5I54GlQRs8/pwNK7JegL0oC4jXsFEtDeL1Og0ZR3D0m9L7Goi07GF99v+5qgodAQtvvvL9mKisyX+38vYu5bFhunvt+cYoQmPDhgSxB+cgtU2OpXabVnqAiE084onIN19zPOLb/OW0QImeFWLPVFqzgOt52RLw/+VdKM6D8INQgrYbkIOC1IS4fGuK/5vb74NlOoiKJm9oHJin2pAZp5RlWYTaqoLNBLpSo6fQ1+N1Qv5xaxhidcqAK5MoL2tuRTVsFo5ODvqMEQeqkgBduEntNBQJKuoE9UsIb9+xLDurRDUvKNpb64hsEa8iqL/HyzgrZlvmmE9wh9r/Cu6iVaTGHl1AmSJe/K3yoye3aXCetK43tMst2NRozcYCxAf75gSp1vaY4GQRnZL7VjVplmxELR8Mk0xfEy5hh1P1C547Nkwqq5ZnL/gliEVXV/tpfPX+ShKIItJ6G8beEj8SYfShW8EwuTdrXLa8chptrwQ76RU+uAqDQTnr7oPLOPmcfZ7DIiu96JDgQzNwHTERhWBw47CihsyZbp4yfKZNNXjOEfPwy1nITXga1JUgyRFxAOgJ9M9SK0EvCo0AdtXbMa
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680883d8-84ee-4cc6-f800-08db14833ed4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 03:16:53.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2qIfyoxMG72ylLBrx2An2eY1MURfvK75g2BSstJmhwCvLfACd4196RklMw2P4laW6t4JLuB3m6y4kEfdtfK9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_14,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220023
X-Proofpoint-GUID: E_iI1jLpw4aWh2otEOK4nZsLXUy7C92v
X-Proofpoint-ORIG-GUID: E_iI1jLpw4aWh2otEOK4nZsLXUy7C92v
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/02/2023 05:39, David Sterba wrote:
> On Mon, Feb 13, 2023 at 05:37:40PM +0800, Anand Jain wrote:
>> v2:
>>   Almost a resend; no code was altered, except for the change log.
>>
>> The following test scenario (as in fstests btrfs/249) shows an issue
>> where the "usage" subcommand fails to retrieve the fsid from the
>> superblock for a missing device.
>>
>> Create a raid1 seed device while one of its device missing.
>>     $ mkfs.btrfs -f -draid1 -mraid1 $DEV1 $DEV2
>>     $ btrfstune -S 1 $DEV1
>>     $ wipefs -a $DEV2
>>
>> Mount the seed device
>>     $ btrfs device scan --forget
>>     $ mount -o degraded $DEV1 /btrfs
>>
>> Add a sprout device
>>     $ btrfs device add $DEV3 /btrfs -f
>>
>> The usage subommand fails because we try to read superblock for the missing
>> device
>>     $ btrfs filesystem usage /btrfs
>>       ERROR: unexpected number of devices: 1 >= 1
>>       ERROR: if seed device is used, try running this command as root
>>
>> The commit a26d60dedf9a ("btrfs: sysfs: add devinfo/fsid to retrieve
>> actual fsid from the device") introduced a sysfs interface for
>> retrieving the fsid of a device. This change allows for the reading of the
>> device fsid through the sysfs interface in the kernel, while retaining the
>> old method of reading the superblock from the disk for backward
>> compatibility during normal, non-missing device conditions.
>>
>> Anand Jain (2):
>>    btrfs-progs: prepare helper device_is_seed
>>    btrfs-progs: read fsid from the sysfs in device_is_seed
> 
> Added to devel with some fixups, thanks.

Fixups look good in the devel branch.

Thanks, Anand

