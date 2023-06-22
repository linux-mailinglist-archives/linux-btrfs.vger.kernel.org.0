Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0027673990C
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 10:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjFVILq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 04:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFVILp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 04:11:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E73A10DB
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 01:11:42 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7plXa015253;
        Thu, 22 Jun 2023 08:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=D8xX2DQrsNqbxuXAjaIjhoFeZWLQ3rxmfQf1D6CgVd8=;
 b=tTbYTMW1KkcsBgdJwhWsH/wCjdRvEI1Lb6hgNAIffW2YvURqEK7HqRc76wXA3nA8Y6Gi
 fNbXwjRaJjrASgIoR7TYbzh0IncRaUiFYjtMH/XYHRyKh47b1P8IOdK6jGJJaPAKyLO6
 1d0ts9s9kSwh0NS7f+IqHLG5dVwP26kdhVwB7QvjpLb8zaMxobIZQmCBWjiLA9fg6q4Z
 cUNVmCVucRw7xsfhi5/rwoeLbRjCx+nOr8iJ3OBjXkWOucA0M/6QWVwIuuhmO+pdLss7
 eH8hZwpZhu5nuVpqAC2xvBU6AaGb8PntQkB1sDBoi1U/1w2w6ghO0d4l92DEhswVrxLM pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbsa0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 08:11:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35M6KGRl005799;
        Thu, 22 Jun 2023 08:11:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9396yg1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 08:11:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mH42dx4FR8HKWe6EZz7GAG2FlZeW9doV+CDoKWKJvw3l4W37IgG9ycB81salQd2jpDbN66IVqSV4SJEBU93y/HZbaAC1GcfpzwfoYSCLBeTKrNqPkmrWrea2Tb/nt7sCOrVQKom9WPSSkr5sar6yuQM5y+7fVOaocgnXZgO2rV159uf9t2UEt6Em6LPrFXf1sz3f/aX7B7ZwNu2V5c8aiQwnck8SuDESPAbpKOut3JfmXE4X/zMJxCR0dFpOuuboBFCaJmo4QPFwKEtpR7kww05+mA7ek0uGCSo9AryuMlTJ5UvJvJaWcSDa8UZ4dFRm6UcuCsQBN7fuPTl6GUrbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8xX2DQrsNqbxuXAjaIjhoFeZWLQ3rxmfQf1D6CgVd8=;
 b=AI4nTo3juL1A7O2uglPj+QLqZ1I513ARSZAKrOkUu5oE4c9+8sdoOKlMgyAzrBjYR0NG7g2hHNQUD2NKtTU4q6Dhj764pMJHlq1RRBzZamxykN5zVk2YJgdzpRtZpkPL+VmG7BLMyDM2l9J3RdZzOyGov4uyg7A1j2PGTEQogQS76NIhLN/Yu+CP8i8E5Fz8gwRUAgK2hGfRt7yryzqcOovgW7DchWTlPoHwI2dIWwIAwivb94rZ+3rDzTPV4Ijj+c4vlW2g9TnSQE4BpeOiIy2+ZoKDjNbS4qLcJAMlW1QQJiF6Ok5EFbWnGM8vyORTCbDUkG5Q6Bmj+7eEh9Pr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8xX2DQrsNqbxuXAjaIjhoFeZWLQ3rxmfQf1D6CgVd8=;
 b=OEBTLBkC+MrOLNVN2Xh1zEuZq5j5Gp+W9AeRnZM/h9iv4T+oQvK/mgTvpTvYzdvywgSsytoo+pVdKpK3CYHumLTWBizdYzJ0xf6c30BvreJRutanQAQAQ5wcWP2PgfL35sb5ZM8bGAjHNcPnLIeLVmOW8P5uROc03gWEbZ9taxg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4958.namprd10.prod.outlook.com (2603:10b6:5:3a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 22 Jun
 2023 08:11:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 08:11:36 +0000
Message-ID: <7037b0d5-7665-138e-d6e3-36c247e0b84a@oracle.com>
Date:   Thu, 22 Jun 2023 16:11:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] btrfs-progs: tests: add helper check_prereq_btrfsacl
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1687242517.git.anand.jain@oracle.com>
 <6ace53b5d32b7814cf4770bcb5bb1d2f4287d490.1687242517.git.anand.jain@oracle.com>
 <20230621145658.GQ16168@twin.jikos.cz>
Content-Language: en-GB
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230621145658.GQ16168@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e8ae77-adbc-4d08-c199-08db72f84c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5BE9RFb9IscPTdkjDGQgv9Z/chhbsgtOSf58yG7TEB4Lu1+2P2Bb8qdQorb2lFq4T4R8NDvnWzKxQXdYiXFxOkbXB95WSPes+DdoTSmItYpNY15cHgoUIbjAVrfzcSzKBl7x+jtPz9c8EZMACUsBWqmkpmTLjskvqN4yYdfTNRwAkH5SDyiB7zeD4nbXneKlnoHdFQBT+qwsxXCGm3EonKL4E2YxZxKvvaKOmiHetObPl4kj52pwRidH2Qdh9u3vmIkasri6RDzPwYfjxyMBesNFcMn/rVRx9dxD71JLdNfrBsD3VqtByzHbSv0zEFxlcdPZqgy3GjVgUSaFZGunk3lK7telmGwxtRGe0k0UvdQhMost5lDE4hTdzGEEBq6BWQyL7SiiSms9pApenTqHGAFd/fMKuL/60MvohA11EkkJPy9hjyR6oE+dG6x/6oddgLGeJs1JVVV6so/bJVVnW6pf1J/xi2S6C0bAYOq/WJ5QQ9iYlaS/pYGvoEkbfJfglInHZ97Z5vkIf6FCgF8ZWW48NVs+YKmDSRlsLrJa1GuqsFEOzakt3GH+Mo/8Aia61IAwBYMekcFoBorTgBGrBlR0sqQfcXKg/mPDADHuczWadyTHdTsfePDUxZ2VaGxIf2Om816OGPnl3j+19gANQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199021)(316002)(83380400001)(41300700001)(44832011)(5660300002)(2906002)(8936002)(8676002)(36756003)(38100700002)(6506007)(6512007)(6666004)(186003)(6486002)(31686004)(66476007)(6916009)(4326008)(66556008)(66946007)(478600001)(31696002)(86362001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9UamdxeFhydmY3aHluOWxHaGZVdlJrOEJEaDdua05yOGxGTnI4bFNiUjIy?=
 =?utf-8?B?VlhSUndzY0QzWkl1Nno1bU85aUQ1RkUyWDBxdjNFWDV1WFNPcVNIQzhJSjlz?=
 =?utf-8?B?NlpHT2tBaDZwL216TmNucFBLQkM0Wk1Od2szSFUwbEhXUzhxN0FZeG9CQWdP?=
 =?utf-8?B?TE5LT0dWcmJKQnpJeTBHWFYrUkdPRmRuVmpHeFpnUnB2MU1ld3E4OGxoZTlw?=
 =?utf-8?B?VDkrN3ZocGpMYWFMNitRRjVvSGJrYTcyYWlydUFZWmtEV1d2UzBTY2FoNWo3?=
 =?utf-8?B?V1phK0JJclpsbGZKbWFZb3l2RTVLRHhHbUsrWXI5R01uYzVGODhIb3hnVlJV?=
 =?utf-8?B?S2cwNmtyZW5scllzK1JaWTlkTTJQdEp6a0FVdlNnQ2xxUVBHN0NMZ1ZMRXBL?=
 =?utf-8?B?aTdCenl0dVBMbGpxSGE1cHhkNzVEMGhtVDhlelBFT25OVmVkQ3R1RUtUd3lh?=
 =?utf-8?B?UmNMYXl0NXVqVURBcDRDRi9PRnFLazNrUkJZd1ppQnlhNzZFRmdFNUZsN3py?=
 =?utf-8?B?OUFoVE55VkZucm1WOXZyZXpCejBEcmtXTVdLZUVXU2lneGJmVFZydVl6TEhS?=
 =?utf-8?B?MnMrZHUvNURDRUpFd2hKNllzU2YxcWtUaWcydEN0eFhqQnVveTJncmlxeS96?=
 =?utf-8?B?NG9rTnd4QzhiK3B3VmV2WDRlK003WU1ZVEswRURWRk5aSUdrMkNDUzkzN2FX?=
 =?utf-8?B?VEhDb0hEWmlQYURxOGh2cE85Wmd0TU84ZDB0MW1TbUl1U29KLzNuSGhIb1dO?=
 =?utf-8?B?eFgxWVg5V3hTRUpaRVVIZ0ZUNVdFNW5JcmhxdlU4TVRrbmtTakpsNFNvbVBV?=
 =?utf-8?B?NUhpalpMcW40c1BhRTVKc1RINS9YT28yNGxnNUFOSU92RzNBTmVadUpZZ3ho?=
 =?utf-8?B?S2lOVHBmUFVBTEd1cndWLzZBTlJrNnBwYkxWTFFJcncwaFZTNEQ1N0tTUEhr?=
 =?utf-8?B?UFBrb1FnUWlnVXMzdTdueFY2dDlCR1lmSXhmbHBuVW1TSVQreXY4cCtUVmxQ?=
 =?utf-8?B?THBORWxUZjY0dEc3UGVhM1YvK2RnM3V5YmV5MzBmbkhRbk5aeHZVTkVXU21H?=
 =?utf-8?B?MkJja2hNdGJKb1FqbWg4UkJkUHBUbEhvU1JGdmJrYkVzcWxrVFU3T3loZTNi?=
 =?utf-8?B?NDAwa0N4emhnYXVDMHo4NW1wajk0ZGNXRCtDL3dFT202eGJPc2pqWFQyT29X?=
 =?utf-8?B?YStQd0pObThaQmg1WGd6bG9vM1pUMXdVajBkaE9XTHJWaVQwR1dFcERjYzFI?=
 =?utf-8?B?MGh3RkhBSVJPZzJuRk43bXdHZEpVWGgvQ2lLYWsvQ2lxdkdyZEdBejMwdlVB?=
 =?utf-8?B?dVdRUFdnbUNpOUwzYXpFditqRkEwZGU4RVBpZnBOaWFrOWtLMkNORFlVZnp3?=
 =?utf-8?B?SEQ1Mm5DOGlCMXlvK21BZ2FMaHkrZEQ1M2Z0RjhQNUNHZXVMeUx1eVVpdXBO?=
 =?utf-8?B?alRmU1E5VEZpeEJZYjlqd1NBUXp0OGkyWmFMeEZUeENyM3JnQ295ZzZnUDB6?=
 =?utf-8?B?enM5SEg5bmxJMU9Yb0J2eSt1ZVFJRlRSSHhMV0hkK0R0UllMblcwSCtvRUtU?=
 =?utf-8?B?STN1RVJnYUJPUDJhaHZUbEphdUJEZGo3QjYwN25aUkdZUHBnQ3J2Q2pPaDdS?=
 =?utf-8?B?SFlkN1VoVmxTM2luRkhUVjd0djc4SU5FSnFWcjBDM0FLa01IanNrc1VQa1hF?=
 =?utf-8?B?Sjk2cjRKVWZ2cW14eGZwVU1TSjlnTEZTcWMraXVJbHdvb1EzdXNMcG52UmNO?=
 =?utf-8?B?RzhKYUQrcms3eU9yWndLK0d5WlVzanc0dW1hMTRyOU96QXlMSCtmVWtDekRN?=
 =?utf-8?B?Q3Y0Tzd3ZmhuTFVod0VVd1BRendxQ1JDZUNocWg3VjNjalZXY240Q0JDQlhq?=
 =?utf-8?B?bHFoSEp4MFdaRFhJQ1B5VU1PWWhHR3ZSZVBycDZGOGVqOEQ3bUJxdzVqZ3VL?=
 =?utf-8?B?MXlEOWpnS3p5SHA1OGRMNVl6R2dBUURBTU9sSWJPVXczZi9Jb0pIdHlFUy94?=
 =?utf-8?B?a0w1WjFYK1lrYXo0MldVZFBJT0FjQXp3MUdrRjVRSmR0WjNuYXlveTN3UmYw?=
 =?utf-8?B?U1pDcEc3VmRaYTAyUThPUXpZNzgwaDMwcUpQNzlpRFlSMTdyaUpDakJnQVZI?=
 =?utf-8?B?eEsrTHhhTnBxS3dXYVRyR3ZzeWZ6bHQ0S2FGb3UrTHBReFdZMkpBS2kyWkM0?=
 =?utf-8?Q?7Jcp3uqbqxNzrb6HWYKbyeQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7eYbwTx62wIQtqiagnwDE9aCc2075dzvNxrak+4783jPSz8IpxYlmvEYkJQx00EF5GV1/1l9bQ/sSbEjNXZSRvQzlLMX6KCGWRYNcnKlwhjt8bnDN2eRlSOA1Vsxi24GVcMJ5QKEpbZZsIRN/Q1Iq/9/NUN2Ig1xrweWT0OGiOteitgcUhuynXdNqFZEElyRkWEfv/DXwSd2Acdi0sBOWJ/Rjw/riPSeJeP/I5M9I8scxwz+YFvqvQNEsDhpIif6fEHwoI8M+dG6wdJ9aGNX/hv3NcWYMLpr/wIyk2xhLBQQNYNKpv1wKqND/5L8BOpo9Lw/sY7hdKo+AEOL6/STtTPijyapu4qI1GOpEhDN8bbP8OSzZRi471DMUFkP4QsxgsA3ObteL877lzlPHk1pUYrc2EzAJfdA8ncor9UwjSFL+YZwDL0/icNwqqRyBom41AeLlN2ChqMTW/1sAYqJ70KHyyq16epmyriwPCY50h9f047ycEicq9UVICuGNG5EpnvnCWeahhaEtbpbF13/nHw+BiDHzXh4Kifqp3bMRpnlD3Q6bR4jcStU959bfP9LDryYbzN4DNCS/oAPSxw8he5pHvZUgD7n8NZC8/tRCS1ZkQFN+4tZOeDT0E1XnY84pvINLwfynQzxEUjIMDrVfcMcjuz7q0VQGhY3jEcNvGbHvlb+W01ZhvqF5LK2u9rFluhPPkd9owy2lCR4pDcRXA49FqSjBndUaXbzRoCESE7QWaatEZCB0hGgNVY1hTb5Lp6TRH70T4tLgGOfapeJidZQi4fjJvUa1nQiED7E4Gc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e8ae77-adbc-4d08-c199-08db72f84c83
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 08:11:36.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvnqtxAUMzZeOdiXJiKFIhnVzXv3AlX6icac4J5YY3+jIIONk/fRuNWwnqwtxzRGNPn/yQEBQXhpFez2mE99dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220067
X-Proofpoint-ORIG-GUID: 0uO-k0nfQvlRX4NUavSOJOv0MppWeYey
X-Proofpoint-GUID: 0uO-k0nfQvlRX4NUavSOJOv0MppWeYey
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> +# Check if btrfs is compiled with CONFIG_BTRFS_FS_POSIX_ACL, requires TEST_DEV.
>> +check_prereq_btrfsacl()
> 
> The _prereq_ helpers are supposed to check utilities or modules, the
> kernel features are named like check_kernel_support_FEATURE.

Ah. That's a clean thumb rule. I will fix it.

> 
>> +{
>> +	run_check_mkfs_test_dev
>> +	run_check_mount_test_dev
>> +
>> +	if grep "$TEST_MNT" /proc/self/mounts | grep -q noacl; then
> 
> So this relies on the fact that if ACLs are not compiled in a mounted
> filesystem will add noacl to the mount options. This works though
> requires a mount.

Yep.

>Another option is to grep /proc/config.gz, or

/proc/config.gz is optional file as well, so we can check ACL
support first in /proc/config.gz and then fallback to the other
methods. Will add it.

> eventually rely on the sysfs export.

Yes.

> That it needs mount can be problematic on kernels with unsupported
> features built by default, like eventually block-group-tree. This would
> be rare but also would fail the testsuite. The CI environments do not
> always have most up-to-date kernels while part of the test suite can
> still run.
> 
> We can do the mkfs/mount check with some caution, though I don't like it
> much.

There isn't much choice; using the mkfs/mount to confirm ACL support
should be the last method IMO, and hopefully, in the long run, the
sysfs method will make other methods redundant.



Thanks for the comments.
Anand

