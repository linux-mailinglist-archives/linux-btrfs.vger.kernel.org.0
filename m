Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F8A67C65F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 09:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbjAZI4Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 03:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjAZI4Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 03:56:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BE81A5;
        Thu, 26 Jan 2023 00:56:22 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q8PAhk015668;
        Thu, 26 Jan 2023 08:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nvoOCQ1DUn8n4qJAR5zHAgVNUCa/hbHdNObgczXYOS0=;
 b=dpsAtr0ON03PgG5XiW8F0LHUf1Wvu47k46XrzIxDmTNR0NZCWZa7FFzBIMuXDltb68/X
 RlvJusWIco/AFpi7rtjBrkjXh9Pwh9woRv+iUekWiI11FyH0A7KYf73UfLG20zV/34L0
 vV8bT5izBM7iNCMfrq5dn9ZIe+i5Ly0ETH7qET5EYotymAGHKsNTaSdnU+OrYZVIqI/M
 VsU+3RvVGh0EkvcVoaMXjEIa8lDCJe4xNIl6/jYm6c98EuhDZcT8cHhfaC8+PbnJI0wR
 Yed/ArvZyF5mHHiojpkYYEd+enzEzgz+abfAPi2uNGh9wJxykp1Ui3O9o/suhdJ2Ctqo +A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86u31vsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 08:56:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30Q6ennb034236;
        Thu, 26 Jan 2023 08:56:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g7n2g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 08:56:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ei+za4uVwPooV/M/aevIB3OpBJW7DtVNou1VIA0urqT3gHPSh4r8CgjNNMXMhGA125Y3kM3sN6JVs/7OgltZQCy8emTY55uQFYy9aAaCmKuS+fyclwGLxnc26L+WpHHFagJ0X9pjYvvpUpjCnp3PYXzKmdJJYv/oxahunhBrkIRojy/zgxLOLwxXVm3QfIIYTY0caOYpoDN6Kis9RfL/9utoD4C0Ugy9HmhFQu0nYL1Wor6qGuPg4ccLbVoUNARStjx2nzhWD3YvwFJVG5ewD135nO9gByTT/QEonUe7P6JKqqnGGp0ZaXAvsmUxDghnxOR4eo0a9frjIk5/+5s5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvoOCQ1DUn8n4qJAR5zHAgVNUCa/hbHdNObgczXYOS0=;
 b=ZiwHOhItv68VVOYPP9vKrreKJU/dSV/DtFe10V6rfi+WzBXz9EgpHjiXAaJks2piHmD5s/zZ8qQI8Cw7Wj8d6EbjShmNYvH8rBsofcnXhm8eL9uK1aWvgFDEZ+fVhc6KFfB1+pO1/X4vOdydE2beES/XhER0bM0zxiFBSWJjeToe2GdDMqqL9C0D0BYlUlzVHAWkC9bJOmCdH/Mn2YYwrsUXP9F1Q1LWvnI0VRFwO8hZyJwQKFYiZi4oj9s+K9wfsOzjPOM3gpSGwixy5kdIqGzSv5+CA6ZO+BxcU2qVfQ2r9lvkJJHBlcWiIx113DWdUbfky5coOjjb24vISICqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvoOCQ1DUn8n4qJAR5zHAgVNUCa/hbHdNObgczXYOS0=;
 b=h+V/rJxlBBFruR7HMiz3r19zQJdtdxl5qE42ePCkCeRJkr2AklsWDSVcWgroTUNmvamgxVpGz5p5DMcBN+Ib0NMO2Yx5bAQjfhme/cfGXMKEQye9Bb9CHVy2oV1RIRIy6dY409H0b+LjplHzkyPuVwy/NZNfgQ7ibLSVj6zkr6c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4596.namprd10.prod.outlook.com (2603:10b6:303:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 08:56:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6043.009; Thu, 26 Jan 2023
 08:56:14 +0000
Message-ID: <76463f9b-2b12-5282-7f9c-3478562265ab@oracle.com>
Date:   Thu, 26 Jan 2023 16:56:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] btrfs: test block group size class loading logic
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <4ea6df6e4f96b6e6101a16a1c94fc967d54558c7.1674686506.git.boris@bur.io>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4ea6df6e4f96b6e6101a16a1c94fc967d54558c7.1674686506.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0186.apcprd04.prod.outlook.com
 (2603:1096:4:14::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4596:EE_
X-MS-Office365-Filtering-Correlation-Id: a05ff57a-6960-4685-255d-08daff7b2df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5DI3F8fb1FSbxp4NqdTWpDGeE0yA9Tv+ER3NrBIOftWFrERcHccxsyike8VVXqjjlfaW8vThgi2BR5wkwD2thYhwE694wYP/KnN4WjIsdKm6l3BX3xcYBKXonw36DPdlM3kVuAYVsKfdYENsUoRJsUca4VmCQjHR3UgyNjBP8nQnsegIxdOFLWAsQ73Ev93ApBoKHQjQOEVaccZk2zdTWx1legMKkGKCZvpFBwulH0xWHpe04FswDXyn+3ObTU05TdgZtUfK9QryhwKrC6Baro0w7jKOnf+y8By4caqzdKUO7OjC0lGcy1Ie9wce8uLSBzQz7gsFT/2qyT1fY9zriw00bZKdcEVqgXa7/bKG3Uc5w5H4FVbq86HG6dVK/x+uUiHfRKUplUqXCti86y/qw1fyAnS7GhfCFj/w9/kGz5tVeRHz1kucnyhw7LE8HIcfT4Tc1NSNzcovLUEYLKWtfi3LuOk7qPdpzUSpJ3ggerEVSI/kxiqlq3dKF71ulruAhXtx6RnNyb7utZtMGNS79+XTzrsHYbhozaxMeXYjndJuODbGdyXR5BpMYzMH6T8vrlLOjCt480XDXVVOty4EePYo2WO78Xh8Nt315qcjDoRtOqd6f4CMUem1P/f903dyH/Ou+jh1hR7OyYI7o2RzsOxgS+p1Mt0RafmzBJPgFgE2TjAQ6Nw3Livbosj+Ei22/rAY+ARnR/kkNjOdk/W4AceUWODOTuqbYcHyhO5xF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199018)(83380400001)(31686004)(66476007)(66556008)(8676002)(66946007)(2616005)(41300700001)(38100700002)(6512007)(53546011)(6506007)(6666004)(26005)(8936002)(186003)(478600001)(31696002)(6486002)(316002)(44832011)(36756003)(5660300002)(2906002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW1LNHNNL2ZNLzFPN29rSG1McEJ4VlN5TlVpSlVGUUd5ek51T2JKdzZuS29D?=
 =?utf-8?B?SHdFVlE3N0hka3owajJjKzdZWkhTVGtpVkxxa01WZDNmRG5MbTJZSHRVcXFO?=
 =?utf-8?B?OE9MRmlVR0cyeUo3bFRzdXdlUlRETHpIYXVUSGg2eUZWZVVRUUthOEVJaGdE?=
 =?utf-8?B?Z0pxekpJR3llNU13Z1M0aC9hVUFnRzlsRTNESFFqZy8vWEJjQ3R3UFBVQ2Zy?=
 =?utf-8?B?VHFjUXRXN2lmcjcxTFZNcjFzYXZvMlhnczFCRlYxOG5ManV4Ynd1Z2lPaGll?=
 =?utf-8?B?dkpsQWFreS9GUHRsM1ZwNzN0Y250MGVHSlBBQjR0ZXIwR0pldGdDTTZlM08w?=
 =?utf-8?B?cXNrTE1FeGtISnNleDdhRkpSQ0JjR1lCSHBzZHFpOFJmUCt2aTRqNXVaUG5o?=
 =?utf-8?B?cXVEOVMzSkp3bERaZnJlWHlLVTF0aVFQc3NzRWRnd2kvN0RLQW1yTVFTRHQv?=
 =?utf-8?B?VTZZN1BVQS85Ny9XQTlxZXhtenVFWDZ4NVdKV0lneWN6d2FQa3lWYWsrVWJu?=
 =?utf-8?B?eEVGc200MEZwUDFTZVNta0ljQzJYYjRYQ2lFQTdTYWQ4T2hiNE05WlZaNExv?=
 =?utf-8?B?L1FNb2pkY1RQVFNKQUhRaTJvQjFIS212YVZKbEFUTHh6YWxIMUJzNDFsOWlD?=
 =?utf-8?B?YjkwQXN6SU9pMlcyZFdzK2RaeGd0cTM1akdCQ3NISkptdzlMcFBUNlA0MjBB?=
 =?utf-8?B?MkMvVnhVcGN2c24zVnhyV1A3dUxoNnRDbHFXQzdzMC9oZVppM3BrSnZlNG1T?=
 =?utf-8?B?THorSGlQUGRENmc4Y2dzZW9wOHI4aXl2d1daLzN2VHZwQ3hTdXZ0a2dTOGFP?=
 =?utf-8?B?N20yempMRjYxSnk0RVlLQ3huWTRVS3NqVEFJZlRFaERvNFFFM2ZhU3p6TGF1?=
 =?utf-8?B?YmRCUzJOUnUrU2I5T0twcmR4ZTAxRkFwVklWVUZOQjRzajBVR2VmejlOY2wv?=
 =?utf-8?B?dzJuMUIvczUvWDdCUW5wOVFSTUpIdnpBVXArMWtRa2VWOVdOcjUvSitsa3dI?=
 =?utf-8?B?SWVub2pDc1ZtZ1NzVit4enRKSXVJZ2JjYkdyOG9Ta1E2eit1OXNBOW1RUmRL?=
 =?utf-8?B?VDcwdlFkQVhTbVdPdlVPdnljTnZZM3VZZ0xqQkNvYzl0dlhMV3NFbEpIRTJM?=
 =?utf-8?B?d3ZlOUdwV1NXbTJlamtYYkRQSjcyM3UzMm5ETXZjLzNxQVkrZ1NtUTRVUjhU?=
 =?utf-8?B?UnFKN1JoM1ByUTMwdDQvd0RMeEd6RGpIRG02aGtvdGNaRHBRTUk2ckhYLy9U?=
 =?utf-8?B?cTZpVytCZVR1YjN0UGpLMXRaYzBjSVJrNEtNejFBbm1IZFhLb0lMeDFCQlpB?=
 =?utf-8?B?NzVmRlE2d2pWMkN0S2dYK0FKMzhFc1lDWGxjMEo2NGNRcDQ2U1RxejVhbXQy?=
 =?utf-8?B?ZVJRdVhEUEl3enhzbG54REtkRmV1QVE4M2x5SlMyQ3VQSkxqclE1YVBCQ0ZS?=
 =?utf-8?B?K3NNTXdSQnppMEVGb1hYUDRQREpSMlBVS25VY1dIc3ZlZU1MMENTVUw5T08z?=
 =?utf-8?B?c2NqYjErS0RvZzNRTVdMODhGbG01U1d0SEtNeFhTbGRXM2xLYVFtTVBNanR0?=
 =?utf-8?B?R1hXS04xMyt0TUFiOTBUelBtVEh4UE4yYk1XNEtqcnhZcjZ6TlJLTGJPc3U3?=
 =?utf-8?B?YkZRaFBHVVR3ZVQ0NGZmS2hKbXkrTkZHbG50WURWUWQyL2tUVmpyL2pORjRj?=
 =?utf-8?B?V2VLU1F2TDFwY1h5RXZTb0lwTVMzSmI3TkM2ZHlRc2FCSzZOTDJpNzRyYnBz?=
 =?utf-8?B?c2RRckVUd1hEdmJqdjVCRTlCY2gxN1V5N0w0MnEvemJxQmlUT2wzcE5qVXor?=
 =?utf-8?B?c0VMb2VMYmkxSHZldzNrcFhCazJLUlUxTFRwVDJuRVFYemI0VmZ6SFdQSTda?=
 =?utf-8?B?dk40Q1BtVVNITTN0ZXFOMXNaK2huaTFjWDdaZHBtQnFwODRoRVBja3kyWGZv?=
 =?utf-8?B?OFpBVWN1N2hlWUR4NXNvQWRnMGRqaE9RTi9ENE1MYUZha2NYN05maVlXSmV2?=
 =?utf-8?B?YlA5U3oxaUN2VDdFdXNIOFEycU9FTmphMEVvcDR1d2ZnWXRxNHJuQU5zVjRZ?=
 =?utf-8?B?cWQrNTZ0bHE0R295bHc5QiswdytsYVFSckJsdFQyZklkZmtwbEtNSHZ4aExC?=
 =?utf-8?B?ditxT0dLcG9JcUF3dEowVDNHckQrRy9IckdKNDBVMTlTYjBrSllPTk4xcE5n?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S1GaeRb3nHmZayfuZ/MKu7ZT7Y9t0gw9PoJJ+DqnyUE+ncqKT6BSz+Qsr8Ct0B4vwDIHoNteVIdaxi0HSGbXQj+Vp0TA2TtkFFAHtaAuIyPnqaCKiGLwg7l1OBHV1bccKfp2cX3ksGfRazVvWcmv3z42dQxJL02TxFZPbKTyMp7s+Tr84ZYkNwO8zU85UakVRwU/lDZUDjE7KlCqVcEfdpz9EdhN0MrLi8UO1jKd/p6XBo4aMi7PIDjqEA1VHqZs+WW1gJOWCfXIHHhsFdEPWYZLWhEmqdB3eUxlY8R/0kHNsMHqfGITg6TDH3TMKg5Up1ZBo09/p2F0gt5Ct7D6rvVzhugXwleZNBMsU5yiFeIwfq4m11pCHV94Ae7p17ebOraWJBAfe2W3sof0Btc9I6KdtacgNXsZIrljwpQxix8rFZ76iEMzyZZpAR+77KcUrtL7lxtEEXWQXlOON97vyYaO+48O2ts0uEypr/sc5CxcRxMOXKPUa+/vLx1GH3vzD/mZMgd+8OcuNo7k7L0k9lChjvSo3Xf83c1bHbYJYGOb7Jh7gz0RpS4Ci3Nlx1S63o1w392tWJFJ8NZ3ogUKwpmcaF3EYgiZDliry/uucGTKWip7TfI6i1KUB4r/76cBNO6bB4FlcNfBxLvXW9p+pWvRvQf8oGK2PrNoicJEfF8i2QT2DO5xUN/ynu+u4X1HVcvUghXOBImAOXPkgOhRjpIvXoOE3mfHIWqzBlz4oJwcuU5Q7h2HGlsr3c/7q8lMeNCOiOM1fWb+b3gutawX0aYWmNf1EQNvxzlWJ6GqWEE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05ff57a-6960-4685-255d-08daff7b2df8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 08:56:14.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwrxCmcvWY78QLPTD2FyV71cNRBbY6+tSenKhR6Fgmw7+mZpC2xOQyu+IlskJ7fh/EaQG6YSZ41ijWSAFDDNXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_02,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260084
X-Proofpoint-GUID: tf-dfS6CXTl6OQTjqrYy3VPmppyEBR86
X-Proofpoint-ORIG-GUID: tf-dfS6CXTl6OQTjqrYy3VPmppyEBR86
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/01/2023 06:43, Boris Burkov wrote:
> Add a new test which checks that size classes in freshly loaded block
> groups after a cycle mount match size classes before going down
> 
> Depends on the kernel patch:
> btrfs: add size class stats to sysfs
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> v2: drop the fixed_by_kernel_commit since the fix is not out past the
> btrfs development tree, so the fix is getting rolled in to the original
> broken commit. Modified the commit message to note the dependency on the
> new sysfs counters.

You can add it as below, it will be helpful to some extent.
Depending on the status of the kernel patch at a later point,
we can update the fixed_by_kernel_commit.

fixed_by_kernel_commit xxxxxxxx "btrfs: add size class stats to sysfs".


> 
>   tests/btrfs/283     | 49 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/283.out |  2 ++
>   2 files changed, 51 insertions(+)
>   create mode 100755 tests/btrfs/283
>   create mode 100644 tests/btrfs/283.out
> 
> diff --git a/tests/btrfs/283 b/tests/btrfs/283
> new file mode 100755
> index 00000000..b3614786
> --- /dev/null
> +++ b/tests/btrfs/283
> @@ -0,0 +1,49 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 283
> +#
> +# Test that mounting a btrfs filesystem properly loads block group size classes.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount
> +
> +sysfs_size_classes() {
> +	local uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
> +	cat "/sys/fs/btrfs/$uuid/allocation/data/size_classes"

The kernels without the sysfs patch must fail with not_run.
  _require_fs_sysfs() will help here.

Thx.

