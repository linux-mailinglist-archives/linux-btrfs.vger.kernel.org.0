Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C17B2F51
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 11:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjI2Jhk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 05:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjI2Jhg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 05:37:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80501A5;
        Fri, 29 Sep 2023 02:37:34 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9a0c023082;
        Fri, 29 Sep 2023 09:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Psetn9SxHQgGDbFLHa2g5TQJAxzIkjdGjtXAr969Bl8=;
 b=JZktfCbSzmJm9hqQOB+hIkjNdFEm3GQdbbxm71SwF+iX2ZU3rvRw7Lpw9jaRxRXEEs2L
 b8bc3F6X02+vH4B6raPONjp+JLvhJz5FQGBDH0rCerpMMb2/yQELZnkOrOZWkftS/bcZ
 6eVbqQFUxXqcYSD6V4U7DCgcYm27Mbfdpzzq/k+d7Qjhla8k5GXf6NN3zOAXPXsx7o7V
 U8E/bhYwmDy7jGh4CbhKLD292+RD1YuE8FVHU+O/IYRYOAS9gh7XNh625ggCTO+z4h0T
 CC7iDAiU8DxX/6d/2UuzTpY/5mDWihZOaSr5V+QwTf6KKP8BYZYwpNxpK8rFJxnikyoB ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc6gy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:37:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T80r4Y025271;
        Fri, 29 Sep 2023 09:37:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh1p1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:37:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npimF7c3KiQlKPuXkqoEZQHcQrpVQRVSFnMaowKPlVP2S4ngXnkCOeitD74yNX0YuIBXM4FZYUrHRP9jxv3tcFUF4ibkKZ2Rj//MIHf2qczS8V68mZTBRIkJMiNLgZVYBaaBwT5MZTR9kHwR08HOoDHjfTDaGnCsKX3aOFVOTn9Ii3NPK3tQFf5auOcLjukkf8m3eZCHwla2Byi9HoN2i9P0THQdC3pWl4CRdNZKtd2xBHHu4J99KnqiU3+1YdumWbmS03fZtoLrQW+ETu4kXYiQbXKlU86mS3UMJaCrW5vz2GzsQ5cMAp7u2NCWKhqNv44FobC2ufkbEgZohVKrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Psetn9SxHQgGDbFLHa2g5TQJAxzIkjdGjtXAr969Bl8=;
 b=F7/M1o0aP3A0/8J8saSXVu2nBC9rSorYOsdbwmij8s2xsnGS8mZjr+I54ZD92ZtcyE5II/6Xd/Gak63Y8wmDcoZN/UiIevmyWcyE7Dc2e2v9vdFDaBocCZqFnf9iu37DMMF1BWwCbsL4h/YwreSbsYQdFcCVJf7c6HTGIiTv2QgAm/DU9YvWFsreaO2QlXIFJQTFCP6Meui4Wqcd6xKOYt+XT67TUcqXKJSjVQUPuRKnshOKj4p4CthgRw+ymJwIPUk9gW9TWs9AQBUcE7zGHxS1yWvRp1svrlG51IVwNZ5aWfxy0BXUS9lZSxIvi8wLJ4tWGmVMdzzMWQaueSR2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Psetn9SxHQgGDbFLHa2g5TQJAxzIkjdGjtXAr969Bl8=;
 b=iQTVOLSo9ct4MB5NpCFy8lHCVbR6J6CeLEZ8RL/19X/ln7NNuP8QGR4gabzdrzW6f8m8vQ7QsMjhrP4bfB1srICVPsCtZl/mjFfQBKap4hsRQNsmt+IiH6tDtskhu8bad1VwPeZlJhtAhJEg9MzZeve35rZ4oCerX70VNM/XP6U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB7982.namprd10.prod.outlook.com (2603:10b6:408:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 29 Sep
 2023 09:37:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 09:37:27 +0000
Message-ID: <ea2c732f-68be-74b1-f05e-218ebaa2b359@oracle.com>
Date:   Fri, 29 Sep 2023 17:37:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 6/6] btrfs: skip squota incompatible tests
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1695942727.git.boris@bur.io>
 <32ac4b162efb7356eb02398446f9cc082344436f.1695942727.git.boris@bur.io>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <32ac4b162efb7356eb02398446f9cc082344436f.1695942727.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc4fc63-4b68-49b9-9643-08dbc0cfb19b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wi7qNQFcGanUQyWPE3TjIY0INIuIuPQ54/ATGJUhSMLcob5PWCDb7MDuCx8E3oysBdcM7AQIZZqBvZXaMpgkZ7Q3xi1JjqIAe9El3cM00zMiZlfSlEl4GmSFwXJTYMMwM9zUpPCRfLJFcWaoN091WUTJf/HiEKs3vYxdbKpuh/AE8TMmW1ynQTkP7GgL15mcrMpu3xEYkkWLbDVY+WY+BjObfTlcBNPhB3liU5LbR7t8MtUmJa8vA6Hhyz7hnb0OESA6Bm89Ns3UE86y2sOH2jJ9nQR2QUPXlndxmX+ViKdcDDUEKp8T77ODraAULUPAynHxuf5XerkQnRGTKGtdVMJlYuoDJbnVsGvkzeP+A5ANhqQOjkDD0AGbL9naATZs5wBqReUsXjQD+v1J7tSlEYVB2IOMPQXM5GFew9zvs+1nfpIpqAyGr/qeio5gKdqF3T8d1Cr7jJ4aiAoXUy+y9PJuGiDTEfYZB2q/HweB2O6G0/TdsS/99rKRDSy2AELo/S2figbnBe1ffPGSY67sZgyN0cLZGn7CvGs/8dzezSM1qUINiGgJmDajhhS+OhbWWyngIhWgMQnQ3W8LGGMAALNNVsJqLWyMBgnhdawBrSnUPuQuv48ITNYfqIWsX7lfoccrflv4BwepS+va3r4CVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(6512007)(6486002)(6506007)(6666004)(86362001)(83380400001)(31696002)(36756003)(2616005)(2906002)(31686004)(66476007)(66946007)(66556008)(316002)(44832011)(41300700001)(4744005)(478600001)(38100700002)(5660300002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzFBSVNHNVU5QjRObHRqWXdML3N0VVdkbmVUbFMyNzFBa1dka1pOOWovNG1E?=
 =?utf-8?B?dnRiWW1kamxuNUJvN3FFUzJVdXQ5VlRDeThkMmY0OGkrdVA3bWxYUkRSajJS?=
 =?utf-8?B?bTZLQkdyVjM2NlVGUFZhblBZNkN6THFHcTRNanA0a0s1U3FIbURCb3NOVktE?=
 =?utf-8?B?cWNuUmdCeHBYSU5OWWk5eW9tQmttbWhJUzJKSVUwQ1kxallZTGRqSU5EUFFz?=
 =?utf-8?B?M0dUTTIwQ0cwKzd0ZkphNEpmZVdHSEtleVo5N042YXU1RjZmQ21QWU5mYVF1?=
 =?utf-8?B?TW80U3NTMGk1YjJVVm94YmdDZEhvc3RweU5CSGlxcDF5VGV4RE9WYzFQN1M4?=
 =?utf-8?B?eGxDcnI2amVsbUN6K1JRY3VSMXVvdkdmYzNET0JqQWtGQVhOR0JldzQzenlT?=
 =?utf-8?B?SHQwdm5relBvMGFjaE15K0pweDRNWEdFLy93ZEtKN0JwaXk3Qk5wc3ZMOHVP?=
 =?utf-8?B?YTBvTTkwWWN1MGwxQjN5YXp4RXlxeGw1Wi9JSjRpWjR6ejVwejdIb3F5T0xI?=
 =?utf-8?B?Rm5iMTQ0SWJqenRFQnAvb2kybWM0NzZKdzA5cnhIU3M3eFU2SHZZMXpuTUVl?=
 =?utf-8?B?UXRUZSs3UXdja2hyOEdhSW1lSkdFY2R6YnlqS2tERENqM01vZnJWQW05YkN4?=
 =?utf-8?B?ZXBadDRtNzJZYzYrUDNQUTExeWZzSjRncUNZaG1ROFQ2VnJQWnkxa2dHaFZT?=
 =?utf-8?B?azhLSy9wR2M1bVBKMVVRb3cvbzE2S1BHZjVzc2xvNWhMSGg4cFJveG1wTHAv?=
 =?utf-8?B?QXRPTWxpS0szbDdjeWNQVXJDTFF0RlBRaE14RjdKOThrT3FTZ3BoNUlUNzMr?=
 =?utf-8?B?N3Y3UGN6czR5d1NmQnBnRDZGSFBFVm9taTRzdFZCZ1RIeW1ZelBtUEdjamlY?=
 =?utf-8?B?dE1ra3JlWDVnRVdWYk0weUIrK01vOU5QUXRzd3hNcWN0SGdRaFJWZm5pY3lG?=
 =?utf-8?B?cktSYnZ3a1hCNTZuNko3blhLbWJDeVBUSUtxbHdicUhCTXZzRFAvYXhCcW1n?=
 =?utf-8?B?c2lSbjIxOWVyK0tUNW5KZ3V0MTFudzJZRTgzdWpzbWZteWo5TEZENStMUkdh?=
 =?utf-8?B?dDdCUXBTeDFGRTN1SVUzRXpia0JMZTRtVncwRGtvQUdMMnVGdk8rRlB1V1BK?=
 =?utf-8?B?SElnbTRrR3loT3JsNFpUNm9meFJRWXUxMFVJcWFnUDZubTJ6VHBZQUtNa0Yz?=
 =?utf-8?B?UDA4dzdwaERrbXpMaHFMa05EcWdoZmVmczhSc0dzTkhaRkpHNjhLaTYzL1RD?=
 =?utf-8?B?S3JYdHFXTkNNYlhsRWRBRzRHN0RnZ2NYalFOTE5UcG5JdG55Q1FtRHFSblhG?=
 =?utf-8?B?bVhhUjFDc3NiTVhNUFppcmFNZzNFenBsVjFvaVVnSHlBdnFLUUdZeHJmWm9X?=
 =?utf-8?B?Mkk1cVY0V09qZEZuVmJVdFQzeGVWYm52NWVoQVYvRUZRUFV0T294M1JEU0VX?=
 =?utf-8?B?bkdDbGFOOWdyYm1DdCtZaFkzMUpGQ21IaVFydk0zQkg4YVhMc3R0L1FOdnU0?=
 =?utf-8?B?N1F0NTFNT2tDelVvOEVxbFRYMDh6WkNtVHNFME10TlBXZ2drSGFOWHRudzdR?=
 =?utf-8?B?NER3dGkxaHNuMWUvNDc1S3BGU2pxZ1JGeFU4aUFFdVR6L1BTd3ptamUwbFhl?=
 =?utf-8?B?L1NwbGp3ZXE0SGY4NUdXSis5MWpuV2xrQ0ZmaTdrSDArUmJHM2xHdUJpQmRH?=
 =?utf-8?B?VUNHUGxLWndNdDNNSkg2T2JQcFFxLzh1M3lrRklHUi9PMmpGL2NCWGNISGJI?=
 =?utf-8?B?Vk9RNGRvQk9PdmV1QnJzNEEvaXpiNzlMcEhpUHY0S256MHdlWFFNUDQ3eXF1?=
 =?utf-8?B?UmpoSUQvZVI0S3pzTExLSmpiR08rbXZUeElPYVJWNFUybjc2bW1yQjZTN3Rw?=
 =?utf-8?B?L25UK3p6emxHNk5pNStTdFZOd0htdGdWZGl5NlVwUTZVNHU3L29IQ0VtVFlV?=
 =?utf-8?B?TUNmaDUxVTMxUFhMaGpxbXpHT0c1dzZnV3ErNWIwSFlKTHp3UitVaEQxV2xH?=
 =?utf-8?B?Y096Mm5oUkJ2Z1VxZFdlT1Q4QVhHS09DdElYeDFsMmJINmRGQUl2VDZ4SEtG?=
 =?utf-8?B?ckRrYjI2VzBNV3FiWC9KaVVRQUY5azV6V0wrTy9FNEhTb2JKa0FLSVJ4dXd3?=
 =?utf-8?B?L3Q1WmI5TW5GeGd6MVFpNU9NYnBmN21lWjN4SGlmV1FZZ1lUZGJuQndyNnFJ?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BzdiJUgOZhinxVrYozA4YMzf1y/opz0WTSRcPkEWoXlwRuOXFb7rV/QoduzyjgGQ8K7UVW+bJGLmqEhQpc4wsbawE+UoQAueTBeNic61dVEaTl/XghzeCo+dwU3jHZUZzNbbGaA0QjGdepPCRdXtyNqQh8BKhXiO5lVFbLl54mQP21kyFViZo91iWCZHpBDGddSAuC+T8HVmFR9gIVm6XA7hY3DFCWHwQEJ60yJtKd3ibmRfXZDwxZccfLyBNUVdCEgQjvck1USQP9RHDbzZPpvggylKgwSWw9UorPqfKIJ2TDalblM9xdpUuSSEdUYIjxJ4YC33DKMS1OsQvLW+pVMTp4uxUMCLq35xG3T+ynzQz31EGxDZ7T3h6J3Lbu1pH2eIll896U7Px3zVCH5Esur9wYr7AQiyTZLBm3Rc3Gfo23lsOa9fPIHrvzmz4xrTH10pe4CfKyCsJaL/8t6F6CeWVNpPe4cpoksO5aijVxzhF1U2MO5+sdC8fEedw7UfoqZx0ZTpmGTZqwlfkJOAsvolQKD/V+3EWHZ0n3mqqDxUQ5/kfg2CIZfVag+a6S1eKvY5Wirl+70zHpkaFU1nuZ2r6GSydvgMwO16l4rHHb7AK8xfuOSL/pdTY6qDirnxJvz2zXYwoKUA7bUj8OWaVpbhjpl/NWHCvG+J//6GgfMXlyQ8nz7z9wQJHDR6+Hy3jfIqDsELMPUgM81teQjXIBvO3qxiGYkh6CVhgPktRjcNME5X2aav+7Gl+7Tdfew8YNlHH0l0wgpONfVSK8cbmi/qWtV/yDnkRarByrj9eAI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc4fc63-4b68-49b9-9643-08dbc0cfb19b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:37:27.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipIiHzRUOqxg9gNGfxbuj1AqXSrJ6cou2IbO3/Z85/+hHa8o3rcfLRz8buJOWwB54Dgt6kmm7b+/f2bwHkE72g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290082
X-Proofpoint-GUID: XhMI_z5Qmk64fbans4l1DX67CEp_I8PM
X-Proofpoint-ORIG-GUID: XhMI_z5Qmk64fbans4l1DX67CEp_I8PM
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> diff --git a/tests/btrfs/057 b/tests/btrfs/057
> index 782d854a0..e932a6572 100755
> --- a/tests/btrfs/057
> +++ b/tests/btrfs/057
> @@ -15,6 +15,7 @@ _begin_fstest auto quick
>   # real QA test starts here
>   _supported_fs btrfs
>   _require_scratch
> +_require_qgroup_rescan
>   
>   _scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
>   

It appears that there is an issue with rescan's stdout and stderr , 
causing the failure. Please consider sending a fixup which apply
on top of this.


btrfs/057 4s ... - output mismatch (see 
/xfstests-dev/results//btrfs/057.out.bad)
     --- tests/btrfs/057.out	2023-02-20 12:32:31.399005973 +0800
     +++ /xfstests-dev/results//btrfs/057.out.bad	2023-09-29 
17:31:24.462334654 +0800
     @@ -1,2 +1,3 @@
      QA output created by 057
     +quota rescan started
      Silence is golden
     ...
     (Run 'diff -u /xfstests-dev/tests/btrfs/057.out 
/xfstests-dev/results//btrfs/057.out.bad'  to see the entire diff)

Thanks, Anand
