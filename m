Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB66C3088
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCULkY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCULkX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:40:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF64993D1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:40:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32L8HbMA006667;
        Tue, 21 Mar 2023 11:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=iLNA6b8iIJIensAXYKmvbCDBorBGWO/t8Rl6StHVTB4R7MHKj1B1wY3Y1zJFJqLg9bpL
 RbMIkQzco2eVg0c5qQZjbNXj+Px3eepsStWRPFk/DAlwHN2zJeWC3jFe5pGsC6RvZ+gb
 Ta49yN+Km/1tLVAdWx2GSvUiaMitGfHZk+G4IAUxk0ePvXIBEBOyU79n4kBf/fzAim5s
 CqpTFbgYKaw66SVbnUY7XMERsEBGgATSM9LMOodGnFrwGGbsVw1XJ+fHCweESsoJBB2Q
 jeunlXLirDN0YKyyjS4zTt1GXMYD8FL1ZU/aYVUivvQrvfHtZZ+KrVeGYqyb471kB2Zb hA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56awvnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 11:40:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32L9uvbo036958;
        Tue, 21 Mar 2023 11:40:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3peg5pmnae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 11:40:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8hwe3UPJEPqxkdRXAffRhOF+HH6dWlyEPddaVGDyp87KYoqWv9kccXi+Fc9KBNH5aKWNTD44nL/J3dvE1b4sRSteifbX8qRgybwIQD1vqVtmf+NyI7XDgXhMV6a4zsSuYefcFrZi3Vd7TKFXiLKI6Ucj5BA8n6IBR7HXN5q5reymFqEHjYfucEutusssC9TPByRex+evUhg2VbR8kpHXharaQRVY9GyY3j3v7tOxXz+0aj1HOllO6Zh9CQckFyLi5MwfvYV2jjCeW6OxgrW1hLitabyHWEUCY/Wdbg2yBnW1giFrKq/jPFEh5Ogu6nxUgSprANpZbJgSYVVXlKm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=axV2alKUADvy6tIRsuAqPaPt2gZy694PHP8pmR03VfCRE3FQ0eXWnmOHozlUHxSelGUmeZKIpBrrZMtckJXHVrQm7oE74Jp0LSQb4or3sNk0X84Ui2ycgtEtcISqz8E1Louwj8GCOiS+D1Figgmft4OU9Tb+57thGpr4Lt/VJCSy8EcYMVAwS/z7ou9EQcTVT8dClA3c/fd/5cyUKd06BWO0Amny8rrzjXZPFHRUbIHrE4WRUdeF2FD7cB5fQs4L7xVkroYWwB9BH6RU1PU3Lhuk/FU0e2OnO8bJcE2mQ0NuEVvY5XE4RC/iaNETnuf+pVXWZ+5uFyge7WWkz4C5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=a3KNX3bzDEHyBSfL8SNx6Jft8LdLE1OxDpzfh+mxPGjpxRs0y01jy3zre//79ORXIKYOyiV2bTJKNRNw6f+FpYvT4hYsipPC5bGwvHErwUQrCQu/dE1tLxjJfnWFFdU6gwWT0sHTr1Nv25g/QWSNRxeIv7mYdz/B9zH8AFrEhFU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6025.namprd10.prod.outlook.com (2603:10b6:208:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 11:40:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 11:40:08 +0000
Message-ID: <542d49e9-0c9b-80e2-726d-f31a15da9280@oracle.com>
Date:   Tue, 21 Mar 2023 19:40:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 01/24] btrfs: pass a bool to btrfs_block_rsv_migrate() at
 evict_refill_and_join()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <e0732832e3c238485454b0a46f0d6da983a5daa5.1679326429.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e0732832e3c238485454b0a46f0d6da983a5daa5.1679326429.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0192.apcprd04.prod.outlook.com
 (2603:1096:4:14::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: f660e12a-a1bf-43bd-317e-08db2a0105b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mniAHkOemDGMiKgm105t6KbsGhp15OV3QldYxgXTpP3F3KIiNGTViQX5j0+W9W8NNuvgpg7rrnVsg2pNEevoBlm06ptxK7vqyH5fxwiH28cMywmS9IPf5nDG30V3RQNYwAsCqut7rI2z1psy7Y82y4fAhiL154t79JhK9tZSI/v7z/RVpUzqCccMiwkcr0Dc6EXE5mcak3CZg7h3WcXWeNRWRcL/QlWqbUTkpHBDz9vnwrqQ3sDxjHC4WEMfgf5ec89jBPy2dIsXJ2UmTfn/5gJi7akqCCXvSdj45bnq4wUZpIBJ1g3xT8pjV6MVDi+uw0Znt8/nEGK61gHiKrW5m5AOA9SZCFghoByWTuo0q6rBmcoeeidHcsuBg+dHwHYXYSvhnVTh8eXwA741PgP5d0G4YUgKtWhAU5SzOoK5y/nkntPIeY20mTMa/9kvFEhtM/HfZSXPZvChAJp5OIHUYYkqlhRpBrhhp5kV9Iy12/Tjc2GQ21UN963PKUFpDMkdeWTHbJ43bsSYn3yKT8WJB+ot21w+Awi4VF00prBEh8yMKuZ5DkmH4t77vNovGeHY2KQjrRZ7NpN3mB1K0cPSCNBsPrrRi+fLDMCEuoqf7zbdoAUd0WayEnivLMUOsP34i2ZGgZWyU6k6TTOU9Fps3HwVHpn4SG843DfFRNtrmZfAwfT9FkUjEVtiAvyT5s2dtQjWLEBL1v/WygnkCUsYNzQs1uVZwFX9/I5qpM7FbJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199018)(41300700001)(44832011)(6666004)(8936002)(6486002)(5660300002)(19618925003)(2906002)(186003)(2616005)(478600001)(4270600006)(558084003)(38100700002)(66556008)(316002)(31686004)(6506007)(6512007)(26005)(86362001)(36756003)(31696002)(66476007)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1Jvck1wUFRZTXRkb203anZTOW9WYUkzaTgrMURoclZDYmhRQnAyVmU1aUU3?=
 =?utf-8?B?WlIwdEhIWUF0enVnL1pXQUV1U004R2ZvMU83eEFmZ0VQSW5uV203S0RhTXlD?=
 =?utf-8?B?eWVhT0txZnJWWElYT3NHN1h1NDR0cHJMM2VqTzhyZFVQZXdvQWtzcXFmSzds?=
 =?utf-8?B?T0EzUVBMWDBQandVcWNsem1PVkVGWDVxUGJDQkFsVEkzeUlsSHh2bElUckxh?=
 =?utf-8?B?YzF6Ylp6TTF2ak05eHFtTlJNam9sRGJ0d1lCclFhYTZKenJhOFNLbkdhNE9C?=
 =?utf-8?B?bXZ1WHErTG8zNXZoSTJqdXFCVUxOYVVlbHE5YTJzU1JweVdWdks2cnZDUVc2?=
 =?utf-8?B?NFdSQjcyRE0rSkpBbm9XQk5vUDYxV2hid1QyaXpBdTlVYVM2UzZxeVR3eVlF?=
 =?utf-8?B?RFB1Mkl5NDhPVjVMSjkvcmk5R2JPVHdNdWcvOXdZNE9NSG9FeVYxdy94a3ds?=
 =?utf-8?B?ZnJNS0MwK0VWdlkxWmhYMXdXU0VBbkFVekxzVmZERzVNOVBSMlI1RlE0UG9z?=
 =?utf-8?B?VGEyb2s0aEhqdU9wbnJ3QURYdnYrb1lGOHNaWUF3dmF2ajBuc3VNZUNvU3du?=
 =?utf-8?B?dWtkRUNiZDAzOHIrem9mb0hRQWd2dzZPRCswUU8zaExXWFpybE9ZNWN0clRn?=
 =?utf-8?B?NGxkZzZBc1MwYmZ1Z3VqQmlzdGI0RXd3YXcySW9TdW96VytibzllaFBCeENM?=
 =?utf-8?B?YWczTFZEam84ejd5NVBGcVFDSFliOXdwSXZPV0JlVDdZRFdpUGI1RUV3QUFL?=
 =?utf-8?B?dGdpaEJUSHNqaitNRDJ2Mm9LeFhObk5nTUJacU9DYUg1bW5ZN3BJVGpZR21E?=
 =?utf-8?B?R25JN05tcjZtQkwzODcrVWN1dDVMbjlnWnB3a3EzNS9iclVDSFpWOHcyOWQy?=
 =?utf-8?B?alh4d0s2SFJWYWozZVBLamlBdm0zc200WlQveWY4RjJ6QnBPYjhXS0EyZjRo?=
 =?utf-8?B?QnVnZ1FmS0J6YlVWTkh4RjZVZW9iTzN5d05BUGkxa1pRTmhndTUwSmIrbVgy?=
 =?utf-8?B?M0xDTkxKZC9nVmJTRCtmMnphNEV3TFd5cDFXTGVKL3B0dFdGNGxpWHViSmo4?=
 =?utf-8?B?ZUYreW9tMGsvTHhyV2xVb0ZUamxBOEs4V3p5YUZQV0FpOG9mYkZOTU9WMVJt?=
 =?utf-8?B?OXhsNzkyNHRpUmNqQTM3aWRNQW5vTkpOWXJyNFFkRFJLaVZ1QWVMSi9iWDcz?=
 =?utf-8?B?aWxsQzQvOEpwbXo3eWpySWQzU2dBdDRiTTlzZ0tScW94anJLMjZjdERQNlND?=
 =?utf-8?B?cXhWWldUVDFlVGdqYTgwaUJIMzRlUUUxWHdWMEdHNVhnTUNPTm5UTXlMcC83?=
 =?utf-8?B?NGxJT0h5UkRybmV5T3JOODNxNkhCVHFmWVFlbkExMnhWQUd4dktZcUJDNE5h?=
 =?utf-8?B?TVJwWkxLRk5sNHRUUG1DcGFma0lTQ0dZUVhucFBhdzRhckRqdzIyMXNZNU1z?=
 =?utf-8?B?VjZDcmxSQlV2QVArWG1ZMXUyanhkNk5iSVZzSENMck5TNThvMEpCM1JKeGRo?=
 =?utf-8?B?U2JBR0JDWUVMNFR2NWdGUEZ4NkRKaVNOTEJxMkxUS1JWbzkwZUZ5aEYrS1Na?=
 =?utf-8?B?bDU5eWNKczVpQit6YmJjTDhaOXJuVnd1Zm1ETHkrN2NFczRQN21heDd5cjVD?=
 =?utf-8?B?blkwUDVuTkIxRTh3NVl1LzFOSllpK0R1eUtzOGVBRWkrYWtCa2tNV3V3bGx3?=
 =?utf-8?B?bEUxT3lvaHg1VDNNVVk2c2thWXZ3NkJOelYvSTUwRWhSekZtc0JsZjRraG8r?=
 =?utf-8?B?ZDBHN3ZLVmJPdlFEcXZTTS8xdFpsMWtjQThmOXFSUlFtZ1cxcnVvUWRkLysx?=
 =?utf-8?B?eTl3REovOU1wd0x3WGlBbjVYdTM5Mk1uVmdNb3dYek1raVc3YjdGR3dhSkIv?=
 =?utf-8?B?ZThQSEF1NFMxSU1Tc3pXS2s3SkN5R1pNdldkU1YvUkxzbWpuSUR5bHkwRnFh?=
 =?utf-8?B?cnlRU3VUcXBBRExXQzJwVjdSc0wwYjRaako4NWlaamgvS3VlQVM0QlZLdUdO?=
 =?utf-8?B?RFZrR3ZUV3FOZVdPSGNtT0xlazVxTFhiNjVvMjJuTG1nSXZTb2d1cW9TT3cx?=
 =?utf-8?B?akgrdXg0OGdWd2ZzVE9MMUo3aEw1V1lGRzZPVTFhck5YUEhaMTR6ZjlDYnZ0?=
 =?utf-8?Q?eVW2l8ncbHW4YTIenGMSAjZRb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kvvCLJa9DbCQif5SNKw7+va6uh+w9N6ONlNna22qbdH6rOt3hZHA7L20nrai6mF9i4iEen1C/q++OdL644V8OljEwAuCVh6SHrEFAtU/IUCGTaXc8UzPnZf0cJwTgBlzP9m5ZJKjMESr8k6rDTzW6CrjexhRJCGC54GCdd1NGcVnw15J+eea6X5J88kJn8a1o0EhuD3VP+iOYUWFdXHpiCd6pyV+IfaZh99QV+uAqCUKUEvvywS8vMDKe9YjK5zz02xknMZRyD+KWcmVKhJI+ubPmLF2M5n98GZOcbfejzG7MDSSLrrvjn+FOMjGg3KmVNIXMOHTxNuQSdx03X6gUam3ckS7TEM/baDbMuXgbZFHxqLwXo1DSKnE1qHx/Ie9aiN/V4YgenJ3NXBmiSZyvHWu6QBygzHpLXoPicc72cj1mJtVV+PZqX3i7tII3eewvBDp5nsPDIUJ6fPEyMgXwOfN58DKhl/b+A5DCxVCwikzlesFrO5WX7+78upG6XSkVfPls4pLm0F+LjFAiglC6pQpT+Y92Y+9fZ1+4SS9TGQrVyhSalnyAlnxE4OZoOoJYOPCTi2ijEeP9VFVRzQIUNxevCe7AsyYaP0aMSJqw6ZP48F+QpVlPiV46phndvSjxaaUG/x2l9uORV3udjAaFZNE580gnfh9yCJwqVSkCGTURaovTm7y9n4VjHcwxRssy5u6B5CaGqsJNq2SnaIl7SeD5PnpIfC2oANyiardawp92dO83jd0RubavqFc6etzwQ4yDlAf2Bdwcy+gttqLv1tIKsoQuP6OW1+TS8qwYxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f660e12a-a1bf-43bd-317e-08db2a0105b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 11:40:08.7279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: om4EYFarE+KG3hCDB0H0MIdapnqVmgTlM3NnqmhnPhzWCV3eN1uFiwUHkvEXZwYjeNIYsn28RVQmCXF9w2Rzcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210091
X-Proofpoint-ORIG-GUID: JYRxu0LLH9rjIbQCfEujnwjiqnqNnNjl
X-Proofpoint-GUID: JYRxu0LLH9rjIbQCfEujnwjiqnqNnNjl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
