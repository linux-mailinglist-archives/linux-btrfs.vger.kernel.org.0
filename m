Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6D479F573
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 01:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjIMXZQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 19:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjIMXZP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 19:25:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D351BCB;
        Wed, 13 Sep 2023 16:25:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DMagId013708;
        Wed, 13 Sep 2023 23:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HkT5tqMassq3vW0PIqTJ0W/lH1nDiglHEdwxo9Rcnww=;
 b=1hiW9oEIOJAIUTN6Tb/nROOmX4qRSXEEggPoeS5J5YnAXo8bQn7Jt4x4hkcD1rT+89rT
 L/Hz75SKXNtOtYE/4Xoei5ku/3nYcjoI+p9zUNi2N5MmRojKLForDLKcF7boGtCF0Shm
 dZMhLcCD3g+XmEZaFWALAeQREDOdlUjROt4ivJpMeObltkrOU1MJ38dj03jNzOVsYy4j
 25HcvShH5EbWyLNjmwpTa75wbqmxT7jHHgXgACW461NZ0kt0lVidaFK+XGVBD/mAFvw7
 hCKzjVxTtEgVbdk0zrOvjKx1dfUhP5q0YI6uxl5OUGZPiZZeqWCFk4t7MAWMECVGc0Xm WA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kkck8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 23:25:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DN0cRa002614;
        Wed, 13 Sep 2023 23:25:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5e6wtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 23:25:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYbJkwLPFqT9d8wLRRJghesr4e25B3WaBzX9ies9MA+L2gJit5pJQwj6ePZO5iQ2zWduduOj0pzyHljqEslMDmidtVN1OHW2OXGyvcTc4CTTN0ynraZhQirVWy8FD218NXUTX95eAbwo7h8zmv7wlcg65wrSKcVlcq1bo0hxkYw1bfokCKyFdN6spolQLiFOXzy6RcotgAEUnVKBvuRER8LfewgCAmhievX5ATiy7orXNDwJM6RfJNY99A9esJ7xKtXi33XaynycJq9JS9dR+tUPg98600OOi4O/S0/LdbgSvZBfRmLWpRUyq0MoaKB2ysQIIx0xlpgY/XCdrUOxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkT5tqMassq3vW0PIqTJ0W/lH1nDiglHEdwxo9Rcnww=;
 b=huWHS4V8XbylBkvbGXPxEKQL1uuMs/Lx0mJE7tr565Su7FaIEqLxx5e+3HBIRI2i0UC2efuXzq558wTGT3GioSkIlIP2OxFHhRZe2m5472prUfpFs7pKu74rGBimq+zm5/j+Kk7yvIl3cUAgQoLJM0SHcHQvVaRYJCon3oPz4oNu7HYLnIaHNdJwDITGaNS9Jg7iXhRfU6t08gClmQhSJGWsEsClvBs6ZeXQ6Ok4TmgMhtjE1VbLocP80+zJwdE7aq4kEYB6uU4dZjuH2IyLLLosLd09qv0KeueK+QeQfpPD3/hESQwUk3YX4ddkovH9u/XxDUmayI/xd172Ln4ycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkT5tqMassq3vW0PIqTJ0W/lH1nDiglHEdwxo9Rcnww=;
 b=puab+0/PpsgIZY759EcnH5PK3MLjg0EyAvLl3tGR0XUO2bakhmt90wu8IhG5boVUjOEwE6s3HRqrGmw0eXGFpTBtAArEBROjJCgPZLO1mHbfFKaeMy+vMNT2lCskIOvKWwVs/TdgMfcdij1driTs4sjAIMnQEMwtotCfY4p/ndU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6191.namprd10.prod.outlook.com (2603:10b6:930:31::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Wed, 13 Sep
 2023 23:25:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 23:25:06 +0000
Message-ID: <56bb2f94-d29e-f27e-8209-bb61c8dabbd6@oracle.com>
Date:   Thu, 14 Sep 2023 07:24:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] fstests: btrfs add more tests into the scrub group
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <2fc42b09cdc710cc2ac83e3a1726b5f7b1d0af62.1693312237.git.anand.jain@oracle.com>
 <20230913163356.ngsh2ewut7wcevsw@zlang-mailbox>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230913163356.ngsh2ewut7wcevsw@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 73be1d97-8645-4360-2179-08dbb4b0a9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LaHPCDon7vjjJhAk1KeiVwIF06cjrGoNqXFCSFQwiyvEap8tmhPuZOTHvvkv3P/is7S881tvYTUoUZbkXRn9WaPTSNRuo/rc6ZyWiJxfMmEcndshu86L4oV4SSJKw7hkBCKBOuGgWqufLrx037P8FVazfHz41jnv7kXENGJUBNV+i0+qrgChxKR2F+EpZgIqJRixB989JudP4beotOmblKG2feFjU79Pgdt2oso6dzPJcDmmrxfhA5lTDqKqXveKpsGCVTuMUCuiAWveSWfqtsh9Fq3kBcMyntg2N0tUiRUmyjfJV7RVO/vcfsaJoRgl/m6D7jf9HGQOPhQAOkAMRDcqQbhnz8+4QCfskU1RVARPS3bdBdiPGPc0xQg81ioP+c0YX5eTdRw5Wms2h5O2tFwSS+OrA0S952rhuTh1StPxGDUid7CeD84E9gaPG8kvu/TogaFAUiAp2wWegKQ3NED6zJlnhCmHK+YbFB42behC6aYIrKd068StDxeCP2hf5x4iehTZEYawrQQatrXmT7eTMk/6aGkrIyeMniJFPk4DhUrA02G2uMZeiA7Ovm/e6bpNWikMra7aINU1Wvb3ePnoqXLCf2tp8V6SDlYNtCGXzAeE0oAWD07UC1exc4ffpR7+Zs3lgwTSvLmPb2EdQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199024)(186009)(1800799009)(478600001)(6666004)(53546011)(6512007)(6486002)(6506007)(38100700002)(36756003)(316002)(66476007)(66946007)(66556008)(6916009)(41300700001)(31686004)(2616005)(83380400001)(26005)(44832011)(5660300002)(8936002)(4326008)(8676002)(31696002)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkVBWVFWNER6SXBhK1B0VTl4cFJMUTMrdWVSVkZMdksrS0l4clliNHg4VHYy?=
 =?utf-8?B?dkt2cDF5VnYraXFMWlNGUXVodVJZMWV5UnZiU2hqVG9CT2xNRVA0b1FpcjlW?=
 =?utf-8?B?VHpGWld5S0s5MXdheFIxdUsrS0hDbExER1hVWnN5UGcrOGFTajFaRytPeXlS?=
 =?utf-8?B?RzNSR0FWcDV3aXIyQkFNUUJ3bXNaZytBMkVxZUYrdmg5SVNuYUo0VFBXNnhn?=
 =?utf-8?B?MWd0cXIyTHEvSGFGamJzbWYwQmtPbmRoNVdwOGpvQXVNVWxuaUpwRjlXcjN2?=
 =?utf-8?B?U2hqMG9DRGM4bHdjbmxCSEhlVXdjRHFVMlRveDhpWHhuODl4aUVtTThXNkpx?=
 =?utf-8?B?VXdCUnNUYlBkYXp2MXE0UW8xRnNOajhCVXFjTlplWGttTjFvdWNWQnBXcGVv?=
 =?utf-8?B?Q2tQR25NMWhMaGI1Y3lHMmI2R00xQzJSdVB1UjJHcnkwcnZOaG8zMjJ1TnU3?=
 =?utf-8?B?MWxnNTdiZDF0dk1idjRzSEtydFc4NWgzQ2ZCZ1IybUxvWGJFd0FpU1B1eWtI?=
 =?utf-8?B?a3RwV0YvWlNLS0FaUjI1K0hRSnhBQTgyV2pjYnB6cGJmNGtwaXN6cTl5QzJS?=
 =?utf-8?B?Ym5RSlVaZUljT2cyY25zV2gzSjAwZjgvdEltWnNrUWs4TldMeElEQ2x5d3Ri?=
 =?utf-8?B?S0lwYlB3eHk0bllKclFjaUpadnB0WTFyZkRGTE9QR3p0dFRhK2g3U0M3TXM2?=
 =?utf-8?B?MGtYemZrRDNIVHU1VzF1Nm9mTFNoMUgrTE1DaEV5TUUvUU84eHFjbXNsMGJZ?=
 =?utf-8?B?WUNiVmcxYVR3UmRzQnowa1l0YWJvY3hzOUhGSFArU3Z2MEVtSmZCdnRoSW84?=
 =?utf-8?B?TE95SGhJNFJMUmFSV1pUTUZwb0hIN0pJc1ptcmw0dVh2NU9FTEljRDJVZzRT?=
 =?utf-8?B?dUhYUWZpNEJoV0JIek5kYkQrZjFRZkdxSjdDNm5RQUlrS3BYVjRXNi9TTFdG?=
 =?utf-8?B?QnpwOEZUckVuclhzSTRrZzJVdXdpZC9VVUk4b2VnOXU3YUVEVVI2dlU2Rnhi?=
 =?utf-8?B?TEdVWmlONzdjM3RLbzhadG9jWmtBdGNaMlRqUXdhMGpmYmVJNnowWmFPV2cz?=
 =?utf-8?B?Q3dsOUZZVTVheFpwQnlIYUdyU3FuU3BnV0pNNHFjUjl3VlVMUTkyRWhKUm44?=
 =?utf-8?B?R1ZWM0NnSWhOVi93czdGZWFnMTFYT01VZXphcW5haWRKNkZQOWdNTnNGQ3Nn?=
 =?utf-8?B?MHBOOGtjeTFYNVVLRE9nMDRTQ3R1ZWJsUXBHVXhGa1JodTVQRklVNzl4T3Zh?=
 =?utf-8?B?R2dERTRoNjJkeUVjR3R6cjlxMXZRcHMxZ25kbzRwY2NxU3dWOUdNMGZmd00x?=
 =?utf-8?B?RnNrRFQxY2JCbHZIZ0liTE4zYkFpMUlLWmp6R05rVHhWTEJvK2NSVXdRU2hr?=
 =?utf-8?B?bUszdXdGd0xWc2RLcXRYcHNvbTRpWG1PWk5HWTJ1UmFkbE5sYUdaSHVIVEZE?=
 =?utf-8?B?STVrU0RPWWltajBLY1pIS2NRZUN3MmxXMHp3NlltdTZEcEd2SmxIbXJ5UXE4?=
 =?utf-8?B?MVNHbkZrUkxPK2sraGZSL3h5M0NpZXVRNjBpQk85czNRTjBxVmFGSU1GSi82?=
 =?utf-8?B?OFdOWFFqTUJqTjQwYy9RWjF2QUtyczVTOWJWZ1ZxRktKemRlTU55cVJmNzUw?=
 =?utf-8?B?Wnc0VzlwR3kvalN4cS9JbHUzODlJRmxJVC9Vb09JajMwaU9RNUQrSjNOVHNF?=
 =?utf-8?B?c3RidDNrYS9QVUNMbmZjUi9IZmtrK21PZm1ERDBGcmFwS0lzRjRmUVRURjZn?=
 =?utf-8?B?YjhhVlVUS1JId3ZMQ1d0SUhoMTQrT3p2dmQwUkJDWU9JVmREWjQ4UnY1UExN?=
 =?utf-8?B?RU02K09wWmx2Z1NUYTdQaWZmRFJYczdoUGR6M25TM1h6eEtpOVZtRWVHMW5X?=
 =?utf-8?B?QzNqWS9CNVd6MldvcVA5SHlEd0ZBbm84b2N1VElMeHMxMDNJOU02SE5TTC84?=
 =?utf-8?B?T0pQYzhoam9TcTJOd1I2R0NaYXRUYksySW9EVjJPWHJhQVZyU3UyWStsL0l0?=
 =?utf-8?B?UC9iRTR1MXZCZ3E5K0oyb0RGZjRnUmgwUmRPZGFlZWdNUUUwcVdsVGIxQ1RO?=
 =?utf-8?B?QmNmaEJ6b1VMbWhaeHFoMW5ZNEdBWXlKempXVC9VZ1hNUkE3dmtzZ05wKzdt?=
 =?utf-8?Q?zjSBrPniWEpMBaIzw39YrbzXT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8icEZauZXQG3PLcKky/Br++LhIncTPFykHMD+PyKsTPierTZibxadFFZGLAj1ueJf/Y/jZNnSx/sEy295DDZ0fF2vNXdNRT9vfk7hwf1b5PvaFpUlwgIDys5K3CEm2t33YUYUv8i+i4XCLeTStJoEb7EU+iWqS2GwuJXA4kEW2D4DTNM50z42St/Ho3+qSLYTQdWfwGw+CFvFmYEyOY409KDgyL8Th25dEP8okUlYcTAjpQLY7Kfx4p1nWphpbrkQUKRioSK06IM9Bib7+kdtEiz/l3chb2YYfBTBruo01ddRP6BHPBgERMh5niGSCivAp3Q6e6NWD9XgKfWCP+rObrIqBmkUNHEcdSzxQk1EaLqJvlAN6KBeRyDPAb3emmfMh4wXI5Ta3YwLD3dW50aIktfCHJxJuP2UWdCC17LjJyvpmopMGbLBNzcfPxj8CyMTK/rhMJM9fSoUr4pJbjmALGq5yKdxJgDKW8kjHoOzbWZ59rw6KehJaQP16Lp1HXOt+oWgF29RukegQNOSIrEEb4FkXE8ScI++6Z6hpu6857R/Pquv907RqV7u1gkyJjjrxWahDvZggCLUjHHknbF14eJG9fP/JH22+9644Gxe5BkdU47kTiWlBYJYf6iR73nMxn970lfkIPCL+n/Urh3vYeMdVQ/7rXsf4f513LqVo7rWuMTD5yrGqCUmV03XXgZf0P3ILVdPJNffgHy+6PEuNNIj1K8v7X3UXlitzmpiZAPywp+tNoHxymbjNekgS/I73y/NFq8917kiyn2VX4O1uBqEybUmszHpjEpjstobtA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73be1d97-8645-4360-2179-08dbb4b0a9f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 23:25:06.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOpFBiaZzmSpGnt+G2tF3wog39+wbtc0nPVYKMVBA3iJX1bZWzPJk7I4jCTshvci4QDnInO8cV/VtdDlgoyH0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_18,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130194
X-Proofpoint-GUID: _tvGQLwPu0UE9pm-sR27o8I9PWphDMhu
X-Proofpoint-ORIG-GUID: _tvGQLwPu0UE9pm-sR27o8I9PWphDMhu
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9/14/23 00:33, Zorro Lang wrote:
> On Tue, Aug 29, 2023 at 08:32:40PM +0800, Anand Jain wrote:
>> I wanted to verify tests using the command "btrfs scrub start" and
>> found that there are many more test cases using "btrfs scrub start"
>> than what is listed in the group.list file. So, get them to the scrub
>> group.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/011 | 2 +-
>>   tests/btrfs/027 | 2 +-
>>   tests/btrfs/060 | 2 +-
>>   tests/btrfs/062 | 2 +-
>>   tests/btrfs/063 | 2 +-
>>   tests/btrfs/064 | 2 +-
>>   tests/btrfs/065 | 2 +-
>>   tests/btrfs/067 | 2 +-
>>   tests/btrfs/068 | 2 +-
>>   tests/btrfs/069 | 2 +-
>>   tests/btrfs/070 | 2 +-
>>   tests/btrfs/071 | 2 +-
>>   tests/btrfs/074 | 2 +-
>>   tests/btrfs/148 | 2 +-
>>   tests/btrfs/195 | 2 +-
>>   tests/btrfs/261 | 2 +-
>>   16 files changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/tests/btrfs/011 b/tests/btrfs/011
>> index 852742ee8396..ff52ada94a17 100755
>> --- a/tests/btrfs/011
>> +++ b/tests/btrfs/011
>> @@ -20,7 +20,7 @@
>>   # performed, a btrfsck run, and finally the filesystem is remounted.
>>   #
>>   . ./common/preamble
>> -_begin_fstest auto replace volume
>> +_begin_fstest auto replace volume scrub
>>   
>>   noise_pid=0
> 
> [snip]
> 
>>   # Import common functions.
>>   . ./common/filter
>> diff --git a/tests/btrfs/069 b/tests/btrfs/069
>> index 6e798a2e5061..824ca3c3110b 100755
>> --- a/tests/btrfs/069
>> +++ b/tests/btrfs/069
>> @@ -8,7 +8,7 @@
>>   # running in background.
>>   #
>>   . ./common/preamble
>> -_begin_fstest auto replace scrub volume
>> +_begin_fstest auto replace scrub volume scrub
> 
> The btrfs/069 has been in "scrub" group, others looks good to me.
> 

Oh no! Would you please remove this line and merge it?
Or, I can fix it in the upcoming PR. Or, I can reroll this
patch.
Thank you!
