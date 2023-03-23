Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36FC6C5DD5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 05:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjCWEPa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 00:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjCWEP2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 00:15:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB6A131;
        Wed, 22 Mar 2023 21:15:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MJJ5V0012868;
        Thu, 23 Mar 2023 04:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gF9w4nOveA6VSvDyJ9Psfb3QHGTx5bOFK8qBgFuKb78=;
 b=aibyMDwEDkP5SOriStip2+cK8kleeTXzaowmAnGzJ5IYkX+OPBoMVGYrKo+H5ElFPINY
 eiUT2jzhf/gkjezLxOp55+vjRS5FBOgxhZY8deRoB2SQgVBLSITpsGvatKVzxlGrOHfK
 +qcKy/plWWBbe7H1qB1yLLAwtMgIBK7jZDJxDxLw1MHUCJFuThwF5cNuZsH1bIyQzTrF
 92ElYEt++WNHlF+6tgrRBh6+LoLo7hXRonyQfK+h+uvzqRJ1/Y0nwYo9h9k6OSu5XLOE
 9cFmdPHoyZ3qiIIP3Ba9hZeHhRBDW6bPEitcPOhXgQgtZ9ENu/mk36fkHSA+DKxVYH4C 1A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5uujmfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 04:15:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N3ndc6005809;
        Thu, 23 Mar 2023 04:15:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgf71gmbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 04:15:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d10tTQZdafaYRf4eYzK5JXuRZ8XAhHXwzXBMrCwMCEWLNl+6eBdMj9L6WzYJzAm+TQivD/IFXZnMKbrDLZfFfXwtkH1AKbDamwIi+syoC3Bnsg1ufn6FTqudVEB7w6g9xK/trOQIs7VNJfkI8k78gi7UMKDZJVVb3Tin/irQ3qszZIVcElN04Z1Arqjl09b2FpzdGKfTurqg4AoDZL38NMpe+tmhzrLspSM3SnGWZV4A0QjYK/2WbQ89PQk/ok2uQmFNWXp/AkeG/uR9hzSfqLPO4aZm8KKvlzhgH0Clmt/1zEJ49NFHY5myXsCy8xV0Fr4UH6dDKo99DF+krheEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gF9w4nOveA6VSvDyJ9Psfb3QHGTx5bOFK8qBgFuKb78=;
 b=H/5v1PF2BD5g7rYHNwcUjrv2ZhbOzmIa71O2jlqX77vqVpYj8V03H4OykBreZayjUkH1XRTj1hdJLBpm63V57f4q+F34+OkiOH0Q7NbCiPXqGx1/zZAMhh71c0unZH8Z7zKaVFOF4pPIczy8gvX1M/zKOfxzT3pTc+BcY1dBjAFVbyNqiHV/Cfl+pjfd0R1MaJMNvlZwPHJPuiMz+BLhInCsHr6DHmZhMPAZZrVBvtYcS7BrtxkzQhK2tgrg02UqfICG477zEYvu6j6Kpffb8dZjW+RbsrFgPC/UDJD/nlyPl+FKaLcbHysmcarpQTC+9pn5+RrEbOtJd2LHD0nOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF9w4nOveA6VSvDyJ9Psfb3QHGTx5bOFK8qBgFuKb78=;
 b=tVzO5GTuI2XUCFcDoUSNl+8fk539ppFhTdEJJEhn6gdioNEqdE6E0QYTw7uZSvQuyvsarxxWE/vLPved1AcQgGx1DGvyuZ8Is9GhWK91iUYuUhFThFCc3CWIjC8zVOl6xdPy6+rxxQlWWUHqrePdmSW6BbuWhMzwTQjt+2AWbx0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB7517.namprd10.prod.outlook.com (2603:10b6:208:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 04:12:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 04:12:21 +0000
Message-ID: <41c459a3-81c2-b1bb-8299-d3a581b40d88@oracle.com>
Date:   Thu, 23 Mar 2023 12:12:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [linus:master] [btrfs] 5f58d783fd: xfstests.btrfs.172.fail
Content-Language: en-US
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Daan De Meyer <daandemeyer@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <202303170839.fdf23068-oliver.sang@intel.com>
 <1c807f47-70d4-14b3-7a20-8f595edbd99e@oracle.com>
 <acee1a74-d554-1bd4-8b77-2dd48c839237@oracle.com>
 <ZBvQe18irieSNw07@xsang-OptiPlex-9020>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ZBvQe18irieSNw07@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: c610e37f-5b7c-48bc-b9b4-08db2b54cc4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hb80hvFk6VSfhVce+sL/pvbtDaiEhMJdSaGZuGHJxYjZLlMqWrDySMtAhbGp04E8vr89iF6YY8KvDAXfeENshdFOrsWeM/CfJ6GSfeqe5nXhHlJpKiJMcV2v5XzaX92t9Yz7kG0bLgxvuVLjxL2767eZ2097TvnWTjUXJZ0pNye+GD69AwfsPzIbaVCEMoB/D62Wn/Ht8y0G5ESDqd2hkCdETlcVOhcRIuIaQKaVRs1MJ1CIq2uOpf8Z/iJsAnVRPr/4uz/zzvfKJsMPJi6c+3KhxSrZJ0gi0RxCj8Er+Zqzh0/RTIZdDg2wb8YNzN4gorr+erHtZ34umZMqHoPCQk7088dQTxZKcNAjU5PcUUtmV03+sIgpcZOlh4hINGlJNQErdMBOw5xJYIDaP/5bnrg3gRyBIJo4ml1wqQaJunxBY/mdKtd3nC5BO6m+BKaH+1bPvPy4lQCVm36m60f0QPhE6mYm0zmrPhX+VdIxV92mgyyqtrwTmtNvvxVd8XjjlZeY3MXs3e9oWVwFSJkUgXA8NUhvGpU2UI/ZLyeFuPdAqI/syJKepsSjxLBS56ntebAVTIZNbgnGU3QvxlHYcsi8/hoSi+RYYnuj/436H8KOC1mRe1wK4kpngeVj4xOHTvMZ+U13e8xvWLwsPbVZ/qVjXCBet/GTYBQFRkqB3cxgsPTy2XKA3l/ScFlSl4eaQebYbAkBP9qFJZ+AXCLwzKoMwXzf9UD8FT8EfFMUP4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199018)(41300700001)(44832011)(5660300002)(8936002)(38100700002)(86362001)(36756003)(31696002)(2906002)(4326008)(6916009)(6486002)(478600001)(83380400001)(6506007)(2616005)(6666004)(186003)(316002)(31686004)(53546011)(66476007)(54906003)(8676002)(66556008)(66946007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1VFbVdSS3VYYWwvZHZSQlA1bDZhektOaWF6MzdiSndvclhkN3FCWFdRd2h2?=
 =?utf-8?B?TlI1UzQyeUlJZGJESUFnV3ZoZUxGWlVpWUVhb0d3VmhFcHBIL0Fselhudjlr?=
 =?utf-8?B?a0ZnQkduQ0szYlk1RlAwL2hPTEk1YWc1RFNnVkVLMFJmL1V3S21ESWdTTDlq?=
 =?utf-8?B?SENac1MxTGNrZzBKbEkrRG5nb3pxZENWbkRlR1hWaGtGTHJab0h1L0pCRDZ4?=
 =?utf-8?B?U2c4OTJEYnBGaDc0VC9HR3lnMHk3UkovamF0TjdxYkFSbTNKUlprM3M5cHpL?=
 =?utf-8?B?OURGY21sZ3JaNzBJaVNFc2RCUkhCMFh6VlJleEJOMlNaUG1nVWMrRGhkTHRk?=
 =?utf-8?B?SlZwU3E4cTV2L1NhNUdZMHJoZEs2d0w4US9haVhtc3YvdVNRaHdnR05vMGQz?=
 =?utf-8?B?VnNXMWNLZXMreUVWT1dZeENLQjQxSmI5NTA2T1Z0bkRrRGxTaWRnZW1UdDdt?=
 =?utf-8?B?SlA2YWRmVkpWVW1vWVpvTnROZzJMSDdROEJsamVNcFY4QWFmUGYzbFRrVk1K?=
 =?utf-8?B?eThoenJwd0pNTVBiUlZaTkxzajdaSmFVMGFrc3FnU1M1SFVvRTV6MHlFaUFW?=
 =?utf-8?B?ZUYzd01kUkhSb3ZUYTVNMTlGaWRJSDR6RDQzamtsK0FmaktMY3ZtNDBmMm9X?=
 =?utf-8?B?cXk3MUNhREJkMFhwZ1RDTjF5ZkFQWnpORERZcTlKQ0xuYjFGSE9JSGlZb0Z5?=
 =?utf-8?B?bEJqdmMyQzNGdXlWVVBGTW8walFzNHdkbEpxQXZobWZJa2hjZFdVU3JnNWZy?=
 =?utf-8?B?S0ZTa3pET3AxR2FnSko4Zjl2Mm5BRXFYeTdONnJKQkZmUDNIVDZxMkRVcGhK?=
 =?utf-8?B?cmJMOXpyaVcvLzhTN2dMVFIvUmNIS090RUJZZjVMaVBQYnJTZVBXckdGQlpr?=
 =?utf-8?B?OWZZdWt0eFJwTFM3ZHI2T0x0L0xoNlhHY28xQ21ZUUhBR2ZwNnlkNFJkUmpu?=
 =?utf-8?B?N1JHV0FacUptMStFeFdieHFDa3dNSTBzRzdIaW5UQTFNTnMwNUVNbXc0aFNh?=
 =?utf-8?B?ZVBGSWZxU0p3YTBrbXBzaU1vQUU1UVoyWmtlRm5Rc0pqeWVkemJLR2xaR3FC?=
 =?utf-8?B?YlhvTFhobTI0dHVQUUc3OTc3VkN5Q0dHQVRKbStDdnA0ZVVCek5KaElYU3dZ?=
 =?utf-8?B?YjRFT3laNTZPYnZBSGU2R094WEZIVmdOWWpERW1BamRyWk9kZlZFdFlHcG1u?=
 =?utf-8?B?YUwwOHNPQVh2cVpqWXZ6RXVhUllINlZJNk1YeSsyOHZmai8zSW81aWUyaW9l?=
 =?utf-8?B?Q0liN0pTbDdnMFpRQ3ZtUDB6UTN6NTYrei92UWF6NU90YnZpVU9kYjhmRG5R?=
 =?utf-8?B?WEdCaVJIS1BEa3NFU3NxaktnU1BYbk5QWkdONkdWOEdkVTZFT1JnMU5Sa0F2?=
 =?utf-8?B?Z1dsanBVK1Y1TSs5MVo0ME9XS2IvVENncTZ4OEVmUzZTRDZVMUhNZnpzNXl3?=
 =?utf-8?B?WXBSOEhYNEZXeDdra0R0aXJLL28xS05qQ09UUnJvdEZlYlJTTm5iZFRXaGYz?=
 =?utf-8?B?eE56cSthMVdKK0VyR2YzdTdwbTRnQnphNm82cElyanJid0lzWDlDeXY0UUx5?=
 =?utf-8?B?cGNzRkpnanV5VzlXV0hEajZpR2VDZk5PakZ5TkRaakhCZHVJRFc0K2FrTXha?=
 =?utf-8?B?WFA4WUh5QTdxRnI3OTR4SU1tUTFTMURaajBYYzhXWHJINHFTZm9wV0dFeFN2?=
 =?utf-8?B?cCtKQTNncXlsaVdhNHVsRXp0dXhsMEVLK0I0aldQTUFqVW5SN1VvWEd6cFEx?=
 =?utf-8?B?OGJBQklTazdMR1BUbHkwL0htd3dZaU1Jc09xL205a1laT1VjV3RKL0pDY1VB?=
 =?utf-8?B?N3g5SmQydGhRSkNDelBWMk1lYWFxWXFhTlhYUzlrcWR2bDFiSEJwZjFvT2F0?=
 =?utf-8?B?eTNkN0pLMk5aNWU3VWh0MzRUalBKRFBXbzI5QVJGQlFKOXdHU2EyTkxqeHNq?=
 =?utf-8?B?UXhGYmRJamZpS0FlUnBFb1NTV1JBSDQ1T1NCM3h1eDhkS3VSL0IrUCsrcThx?=
 =?utf-8?B?cnRwVFpEd2FjWHNUa1NKczBObWFxRTZCblB0dTJVQW1wWndkQjFLT3d4bTE2?=
 =?utf-8?B?YWU1Y05OMzhBVVAxeHhvNW9NS0RLSGNBV0xpZjN0bUZVbk5pRmk1bEVQbE1R?=
 =?utf-8?B?aW1TKzNHdTdzRStjVHRrZ3duYXlLVlZrRkNiTDN5aUFrUVJtcEdtZnNhWmEz?=
 =?utf-8?Q?HwHnsmVZ7KK/jIjlTe9cApw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ga5PBqQh0BOFlYWI9jWvbXWDj+JBfY/Zz4+RqKFcxplPTHpdKf7TqnUh+GRn/0urb1GjeZAoSP2ZBeWzzzZhwwdouhTiFe/QvR6ZaCL+XgK8t7yrEb/C8dVIlf3wkbgDnXXdmWFf/Esh8Xgc49HFI03/EsB+gMQkYYBjzhOLbZDpC83CyHUfmdSyY+Cz74PGmG/FqlibDBa+N5g/ZIvjgLsguze3srhHCtGMWacFZG0EsF2JYB4u/IMyrdX+OcxN2cVMk4MbOdn0Imt5dhR87OhJnKoYpQQ0FGd+x+efnmF2oH+v1JdwEjlbULCeITjBmpT5ccbJ8KYBkvSmPxrK0jFTazTtetGtkQptYd8GVt+nz3xz6ar8cK2Qs2SpYslmklBW5Uy12a04IIO/HviNts9qfpAOiajVfurNrOraZ9Cx5gMhCAdY0DG1nD3MVo+/JIPHYrU++QzotsA6jyfJBeQf2FxVQMEnTFVqzWUuCW3UBZm9C9UJGSmatqCvMS7rxkdXLlvMFcig9KM0hniDoKBAy4JHQTk9qd7zqMjgtCJCH7gXKWvwPIpYNYYc5NGQuntgoqYE1gnQzBg/00Doj63HjT57+kwWu1xqlnPrxEllnCv/FZyxmQ+AMVp9FaKjZefm50PXZp0lamsHj6rrE7eawYjUBHtSuQoQCvTyYYxVO6zoqMor/YCl4IoqtkEIPuHwbmHU75qphsJGKyzh75+cGW73BZzp5tfG0EBo8xL4fGVYoj452S1WmztQLJAzM2NticlGnIWF30POod/lUI3RkWYJzRLAr6rrBVkQxuK+Uo0Wm2fWYyFZpt0FQRGe6AYmXdagUevIeLqxWsY5qNXcz/TbAKqT57yUvrkPUtvCxsjd29JrIgdPk6pDiEnaoLs6aFpbLIumAY7oajLiP5tHuJTM967GjBB1CXeYgoI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c610e37f-5b7c-48bc-b9b4-08db2b54cc4a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 04:12:20.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGbz/ERGFzeHISSUC6SvS7N75850DBiI/fhembVRK6GrnkilkWVrqm/HfLTQh1cCRJiTOMECYnU7TvoCPKV2jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7517
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230032
X-Proofpoint-GUID: XEwXHiJhm9Pws6E6z2eYS4V0WbscohaO
X-Proofpoint-ORIG-GUID: XEwXHiJhm9Pws6E6z2eYS4V0WbscohaO
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23/03/2023 12:07, Oliver Sang wrote:
> hi, Anand,
> 
> On Thu, Mar 23, 2023 at 07:49:27AM +0800, Anand Jain wrote:
>> On 17/03/2023 12:14, Anand Jain wrote:
>>>
>>>
>>> Thank you for reporting it. I am currently looking into it. It appears
>>> that the device is being freed after it's closed, which could indicate
>>> that we overlooked something at close, just a hypothesis at this point.
>>>
>>> -Anand
>>>
>>>
>>
>>
>>>>       +(see /lkp/benchmarks/xfstests/results//btrfs/172.full for details)
>>
>>
>> Hmm, I'm unable to reproduce the issue. However, it's possible that the
>> O_EXCL open for the 'btrfs check' command failed because 'systemd-udev'
>> was scanning the btrfs device at the same time. I noticed from the dmesg
>> that the 'systemd-udevd' thread was running [1] at some point. I'm not
>> entirely sure if it raced with the 'btrfs check' command to successfully
>> acquire the O_EXCL lock. If you could send me the 'testcase.full' and
>> 'testcase.out.bad' logs from the system, I could verify the issue.
>>
>> [1]
>> [  337.769932][ T6408] BTRFS: device fsid
>> 8dcaa8fb-b317-4e13-9e04-e9b63fe91948 devid 1 transid 6 /dev/sdb6 scanned by
>> systemd-udevd (6408)
>>
>>
>> Could you please also attach the full log and out.bad file for
>> the test case in the report as shown below?
>>
>>   /lkp/benchmarks/xfstests/results/btrfs/<test-case-number>.full
>>   and
>>   /lkp/benchmarks/xfstests/results/btrfs/<test-case-number>.out.bad
>>
> 
> as attached. Thanks!


Thanks.

My assumption about the reason for fsck failure was correct, it failed 
due to device busy.

*** fsck.btrfs output ***
ERROR: cannot open device '/dev/sdb6': Device or resource busy
ERROR: cannot open file system
Opening filesystem to check...
*** end fsck.btrfs output

I am testing a fix, I will send it.

Anand
