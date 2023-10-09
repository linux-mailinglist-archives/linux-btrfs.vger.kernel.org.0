Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC417BD4DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 10:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345460AbjJIIIO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 04:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345456AbjJIIIM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 04:08:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBEF8F
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 01:08:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 398LE8nA004878;
        Mon, 9 Oct 2023 08:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=apX76mK2f3EKZ/2dzZs550JzbeQQB9BW44FadlTfq5Y=;
 b=o89KMOE44d2ckA4K6PmSiCW3FsOIgJG2LoSkHr35mvXwzRn86O8Q77RVvnGV6pGredqq
 A5XSp89xDlm8rCtjUiR/U7G4Y2OGkf6862YotVIIR4JBudDTSRRKMB7Fr5YjWY9sbdhX
 FgVT6nhbtbv+mx/amdbhzd/ZumOFiTLhe/w9g8k8aOGcHxd+zCENtNItjROb5G0GmaEW
 vg5aLwvcudfVrNSyZroXnh1UXCO/vs9TFpkagPfuqID77D8fBlIY/rDvY8ApcbCvu+0S
 vO3YWx4daqjE0CjKL7C2QV6p79gQEjkKF9Cm5ZCRUaqDS2wherNbjqKC3dbfBN1q++E3 IA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvuj5bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 08:07:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39971kg2004790;
        Mon, 9 Oct 2023 08:07:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws4es9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 08:07:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKGB5pDl5QXMFmeBfb7hZv7HVVk5xYXSl9AnsQw/3ZFbp82sVQsMK4r1LHBUIE1sWoojRHlZLFFPxUsLMMnMlgPxxOY2NTKY12mZr+J5to1Vqu1oa3VoZFQsvath1bAackb7pxFE99xlfkBti9X+H8tkq/8+rU0oIYsHjGamFYqykYpLG2M9MQHT7gWHUUlO/L0Lhth4B6hrS/o+8ZNPk/iTqDxUjHBTrfGLIQVwu4vYXsqRHDy34gK9x0gKZ/s9HxgNnxmHEAa1VbsKm9tHNHhNu7bMlFMOegwWFGvouh44L0iatQwzieEqwM/jmVHB3On6CtCWmJD7vTKugtfcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apX76mK2f3EKZ/2dzZs550JzbeQQB9BW44FadlTfq5Y=;
 b=Y/1NRRoLGT4MIAzadhiq8Qm2oo8Jb79wKWwd7+gXbEOi2B/CJGRT/xKa/OSyY7lFi9yTjX3dbJOZnWH0bQrEIq7sq/h6sIXyvJGDxXx3IS6tTv3iiLm9s+UHddMLHiiAleWgmD67/InRxJuxHyIfPd6/k6vZROQyOHmJle4ZFBlhidLmk6Q29tOD1GT33is7dQspmy+WwztMRPNwMOpwk28Bym3RS+BBl+emFztTMJnEz5j9gDc1Dg2K4b+wayl/7m04ry7y2z1sMkzdfzN2pjFn9JGBzdbmX7uBPBHv5YLSDFqsw1/+O0wXL8d3h6/G6PyxEjZuQKEFlfKJ/wHY5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apX76mK2f3EKZ/2dzZs550JzbeQQB9BW44FadlTfq5Y=;
 b=q+jweOHI9LDu7HuGqn7JYahhLxfsEpPv049Isqs8G1o0h0tP7Tavb2NXzt8II0QM/o5Wvd1CEfZbrjnWpLTRf98vkabAzafT9Z0erlqw8OZKXzQSo9fyBAHVKp3hws0NB1cmTTkyOQHqaRyjOCy9tpUjGNcRKXpXHaDzuYX8bvE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5108.namprd10.prod.outlook.com (2603:10b6:208:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 08:07:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 08:07:53 +0000
Message-ID: <a17167c2-fea3-4f48-b381-d72585b35845@oracle.com>
Date:   Mon, 9 Oct 2023 13:37:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: sysfs and unsupported temp-fsid features for
 clones
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1696431315.git.anand.jain@oracle.com>
 <20231006150755.GH28758@twin.jikos.cz>
 <9cfb8122-4956-4032-b9ab-2eea8bb19415@oracle.com>
 <dfb5e1fd-6eb3-b0bd-d5c6-0f5f9179eec4@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <dfb5e1fd-6eb3-b0bd-d5c6-0f5f9179eec4@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: a7aa33d2-4b8c-4ff9-4a0a-08dbc89ecab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bBz51p/xYmRLinjLbGYI9wokZKrlXT0cdefHie6/tBjj67q1252SXUZA9x6wqRoPJbhzEpLSa6DxDHOxX9xc/FgDCL/YEkiwKbAjU6DuhSrTRIVqkOXYXx3PNIn1Xw3TR1LXpfHoBU3YhiL151fJBRGeE5REVkvRbk9iXOSDnD6+YQ1BlcdLIZGcl0aReTTtWJAdcySobCHRU/Y5A3sTs9+rpuR9soYd+Zmf0p9y4vkk3QNEU4DJZaBNj/TbcZ/g9EG7LZ3N4BueX5+ZER8jnzO/MP6uEDiGTwTgQYmilXjpOlgihK/50J5wYjLXhaCMaj7KOpcW6LJzGJZ0WSF0boLvDO9HsQvqtcJ28LHAP2JsTkqSQmJ4EABwrVoXN99g743DhicVLqll8FBO6BwUJ1GoXm5Q32ay4ynFQGXhoFcuSixgCr40jYNY8SDUtL2AnCY0Wmtg9wSCgzH7yPw0SjAvlHJHZpWSN3pkGDyW1joi8aRnLzWdFeMTWQJhbtAcwYtrnHHRdqxE6NlVtnLBWvto4wx9BfUX75hb46NcnY1vxF8l8o1s9ZlYQc5MFLuxGy165p18BSz0/P7q7iIHwxSPKna80Ye30ext7sUM/JHz75Si6uI52BTjkWgQspVSO/5pNIcLdu5J/gFeyPfXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(6506007)(2616005)(478600001)(6486002)(6666004)(41300700001)(83380400001)(4744005)(2906002)(44832011)(5660300002)(66476007)(66556008)(66946007)(4326008)(8676002)(316002)(8936002)(38100700002)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjZYUkU2V05URE9wUUZWVTlUaEtvTXp6Tk9xT1AwTm5HU3JzeXBYOXVTTmhE?=
 =?utf-8?B?bUN6SFZvb1dUbUJ6OXJ1dkRSSC9pTlV3MkY5TWZaQ3EzUWpNVHRUbGZheHVR?=
 =?utf-8?B?NjJwczJrMUNPcWs2djY4NG9TRGxGZTdXWHJIcE1Kcy8vOGtRVXQrem9IeEJx?=
 =?utf-8?B?c3p4ZnY1Zmc1UmVXc2xOT21QNEpCSWRDUmRFanNyb2hsRTFrano1cHRxUW5v?=
 =?utf-8?B?TEc1SzRzaExtenRtUWtaMXdodGJlMnVKTE9CYXdPWlUzT0tyNFhMMzB0YnEv?=
 =?utf-8?B?ZC8xUTZJT0pFZDRHeFV4ZUZUUEdhM2YxWW0ra1pjS1p3dm9raDZoeldmemZS?=
 =?utf-8?B?RkQ5M1pacHFVcWt3ZFR6WHk2UUZ6bHZPbERDbXdyMU1abkUzK0xBb0xjMW9N?=
 =?utf-8?B?RVdSK1FvSkJaK2ViZzN5Yi9iOTRkZFMxT1orMkJDc0dpOWFlVDNuclgyUG16?=
 =?utf-8?B?aWQ2TUdmQjNGaUpXVlVZVjdvWnczNDhZSlNlYVF6NXp1L3FrTzFyYW10K2Yx?=
 =?utf-8?B?Uy8xdXNJSEZCVjRLWEQxbmtYR0VoQkNETVI5bmFLcUkxUkdEVUljaHVCTHBv?=
 =?utf-8?B?c1p1QXlIUDNKNzdNZnBnSXNxS3IvckFQVCtrWG16S2NNSEZFWHFXNXdyc1FW?=
 =?utf-8?B?dUdha21sbjYrUWx3ZFJLUzVVMlJDaUZWTXdhK0FXZklsQWdBZS8zUHNGMk9Y?=
 =?utf-8?B?UDUvdFdrMkx0bm5vYjJmZllnZHJwb0c2RHllOG1GTE1wT0l5ZW56MlZBemtX?=
 =?utf-8?B?VGdGS2NmOGpsSGZIYW5kYldMa2tyRWQzVXFmQkRJVGlPRllnd254cnh0QmtB?=
 =?utf-8?B?UTdlQzJUaTdTZC9ETkRLRjB3YVN1ZjlJZTNTTEc5elZSZ1B5SFM4QktiQXFk?=
 =?utf-8?B?ZlEyOEJyV0YyRHE1YlVlY0h4V3dQMFBoYnBzQjBzRTM1bHZtb3YraEtxeEZK?=
 =?utf-8?B?MlZiOGxMZU5PUU5KdmJWQkpDMmlqcGVrVHYvME9TaEJGcVlyVFY0MWhMYmQ5?=
 =?utf-8?B?MC9CWXdyYSt0R25KUjk1NlJoKy9pTy9iejNIY2UzQWVOSG1aQVRuN1Rabmw2?=
 =?utf-8?B?Tkl3b3IwdU1WVVZ3S3ZKSlVsTlJSQVI4OWF3Ky8zYmJFMXBMSXpWRmZEQ2Q0?=
 =?utf-8?B?TDJYbGtraTZtM0RUN0dub1BWQzhZMzZQc2hWa1YwYWtiYWVibkMxU29nRFdn?=
 =?utf-8?B?YlFwRUpiNTBJRXFUZXNOUHk1QmNrYkxDbmgxR1JrelFvdVV1TVhhYm1nWCs1?=
 =?utf-8?B?eHBMOExFK1ozeWV4N3pIUUJwMzE4T3JVL0hEL1g0b1hkZ2d5bEs3OUw3bDZB?=
 =?utf-8?B?dzkvcStDQllxVEFpdC9aWWRDZHFkOXZQbFJWNDdCWXBMekJNSXV2eXk2aEpa?=
 =?utf-8?B?TnIvdjBYK0ZtbEljZHQzc2JWa3VoR2d3emEwdjFqSjNueE0vWWFDcDUrdEI2?=
 =?utf-8?B?R0xyZUE3SktyNnAwY0NDaWpaajlnVEt6aVBsaTJscGZFS1cwVFJKZExGWEVH?=
 =?utf-8?B?OENnZC9tc3dXamdvdmk5ZEFjQnk2RVYzNXhSaVhOLzJuWHQxdHFXN3ZnRmdu?=
 =?utf-8?B?Ny8vYlFEY3RBRXpYNHdrTXdwSzE0M01VaG1BVlNBSzd0ajlyRnI0UFBHVjIw?=
 =?utf-8?B?a2NLRjBpcXUxdGFPWjl6ZVpxVHAyRjNxbzBIVlJTSVI2alU1YTRDdEtoeUhR?=
 =?utf-8?B?eGhSSGFIRWNMdmpoTWhCTXBYVFpqelAwY1VhNnZtbW1qWFV2Nk9xQ2crUjFp?=
 =?utf-8?B?KzFxV0FQbnRSUUh1QXdwWFd3eVkxRVNGNHZyeWxZeUxLSjd5Y2hMOWlYVjls?=
 =?utf-8?B?M0FVV240MkRCeDZ0KzFUUDhFaUl2dlU5SVZxZnJtdnc5Uk53YUY3cEZ6dFVo?=
 =?utf-8?B?WmtKMEtTTmpQWStNY2dobE5kZmZkVXVtd0J1WlRzbms5NVNadnVvYldjQ3ZW?=
 =?utf-8?B?Z29pK2ZGY0YrVzNTQXdjZDE4UFBLdTAveDUxMldjRGdLazJPQmlHVHEzdXdX?=
 =?utf-8?B?Rlhvc201QS9iUzVuS002N2pDVFJ3MFZnY3E4WmhTSlJ0bGtNRFpZQldGYytJ?=
 =?utf-8?B?WVNGQ3U2ZGJYVEJOTlorWHlVQ0tpNFpIbjJ3MXAweS83R3czYlA2bGNmUGxF?=
 =?utf-8?B?MWFvbVFXY0hEbm9vVGxyTzhGUkZFWERCd3RzNWl2V25BWllBNzZPd0dVdTJX?=
 =?utf-8?Q?mpUkweZZCjY5QmkBfEKNNaOji20TFM1dQ/hmSQqQTUVc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7EKk3r2x+hQpo82xVVxt5UuqKiVTuPmAgASj0Bh/6tSzbPIbB5U9Laz17r6LYJVa6Lw5Cf4Df56Zy1ueWqx2xGZkHhrR+rZDt0Wg2Da3K56PjvwGi8YhgrDJA0MTeVDQH/uquhJaCHC0Nv8K6Raua3+9/bgz4CUKoqT2Y5KP1X6AmAIDNvSQshYudc62Jgx36UM7iUJSEZkFyINSIQ+XrIHNWC1ji6Sieot5Xap6qjSVANdAsdfjrFrWmtaQUEiC14TQ2U4TpWOSYmXs6fxSbeZ+DBxj+mual3HYBABrNak07dimYYWJTZ9PovBT4Qphd78OeFvCO5Sy24dJuAy8YqmMhp/x68R4uy/6Lkl3eOSs6tO0b2mDq0YAUUWZL7JabXYqmp33BLPv7aT3S/qaoZGo5UwXJIuOb5n8t4i/v6Lm/AMzGQrMoBM8Xe5VolUrHY2OqSSwh7nBvh3sRXzfxSSf02StYB3EKTDnVg4mjra/Lz1s6GH71dd5JPeZvA4Zi1aRlR8CBPwEGeDReVmG5DGu/DeG04DTSd/Wc3yQ9Z4WFxnN1UxyULzLkNw6vAUVfjaX3pBcEhrWs8s4A5BN7yxAYadbyqjslMUtL5wRLxskmdRDkbJU5yDByb9QOdhgXpObzAx0WWupFcDQHkw8PKBpcILCF7tK6QBaKbisi6rdEtABM2qHqNZktlRAftPqpbsVahRXTkBB1KhZECIy1uNcZuPK3tJkjBmLRQL0o8aQ5r3oh6A7K89LyxUlXrG2NkZbVW2vZ404QlCLxKN7ms3YYyaRnLE3/kqOQsbp5UyYc4OScbjHqgMUDoX/TYdx3ZZoseNCpGkxUUl5E9EauA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7aa33d2-4b8c-4ff9-4a0a-08dbc89ecab2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 08:07:33.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7ugx66vDWNjamkB2oQt2GZXI5N6CepeyQ7lmUizEoU8nYIqE5q3WsuOqsGnRjMbujJbR4SOg/qZ5mYHjwmn3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_07,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090068
X-Proofpoint-ORIG-GUID: mIO10vWHWYPJmXph0XIIFYwFPCdrv5Nz
X-Proofpoint-GUID: mIO10vWHWYPJmXph0XIIFYwFPCdrv5Nz
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org





>> Can Guilherme send an RFC patch for feedback from others and
>> copy suggested-by. Because, I haven't found a compelling reason
>> for the restriction, except to improve the user experience.

My comments about the superblock flag are above.

User experiences are subjective, so we need others to comment;
an RFC will help.


> Thanks Anand and David. The first thing I need to do, is to build
> misc-next and test it if if works with my setup, to double-check Anand's
> approach fits the use-case (it seems to, so far). Then, I guess we'll
> need to see if there's a missing piece on that - in the other thread
> Anand mentioned maybe the superblock flag would be useful after all, so
> if that's necessary, I can send it of course.
>  > Finally, this week I'm away from my regular system and cannot provide
> the test results,


> next week I can do that for sure.

That's great; much appreciated.

Thanks, Anand
