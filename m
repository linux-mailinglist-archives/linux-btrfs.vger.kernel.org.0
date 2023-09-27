Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C7F7B0F24
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 00:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjI0W4g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 18:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0W4f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 18:56:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC1FAF
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 15:56:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL6IaF029467;
        Wed, 27 Sep 2023 22:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : references : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5ShZkPb4juPSCk8I8KDHDMsrj36aZ8i/TkzCM8ED+Kw=;
 b=3wMXc9WtzBylqAWqLdD1Vo3gQcopEvlF/QlpVC5KGE9bouN1Le/tLeYLcXJ/2ThzQmep
 6mnoNMMi4BuWCI0tsePQYTuXZ0j0aOAdfOXxd7v0WULsd4Qc7gzpj+ZWrfGxRYnaic3e
 XrE0dD3Y/hvBjkXM2xNopka1/2imGiBBH38W//0DYJubI/nN8xWiyxrFCCaxndFe2GYO
 jGgoOc9w+1E2dtv0aBytcIw3wBNjwoWn/25sHqr6t/o/oKmoAu7eEkokIFh8j6kxasnr
 RYyHVe/xu2TIq1/MKhtBkUSR/kE1M/U9BlsiV87h1HpdhPy+fak678Zu9G35R4PbAf/J fw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbjs6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 22:56:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RMdlE9003211;
        Wed, 27 Sep 2023 22:56:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf91ea8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 22:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTkCSbgdCMdf9fo0HpA3e70Tg+xDUSLGJ8062rqYITV2zCa90m5mhOs68JXgyu+X47tAbLAvvSSOKMBFbL/20db2XqR0Fa69CCJceveUl+yhdAT10fIDbbxMGIxMHRhGFrt+rrC9T6nJhE7mD9f8cik8P9IkIxmha90G14OMmoO3Btn0QIoK/Y0Jvhc5iABb7kW8l3Anp2JSzf5OWizyS/TwDPdqPJ2wxrkKarzsACMAH+mo9OSvGoOemi47kQmxT1weMEWQPCmEl6by6vgpbdiHY2B714yYQ5cndd2Nijw6fys+EMxtEmY5AFbX6YbGbxfc6wjFY+k+mpOXiJrdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ShZkPb4juPSCk8I8KDHDMsrj36aZ8i/TkzCM8ED+Kw=;
 b=gl8uyHoEVEScK0Ae/DYqZogC9PDXEK1JRxOJzfnX5zDQd6Ip5E5W/0WS9Gl7TgXOuBQd40bMalwiCF7onSTALBuYK5J0+ZhwRiTNZnzwf+Ppgt40dJX8mPvrXidzPG0JCQE1njerOLizGKzyoXjelJiQzkvWmX7dP5IkXdoIUcks84gsbtgzq9j1qjaD1f9E6T7QcIMqcc6jfG8H2gQnUQZrk8MQnPBcsuOAC6PoEey/qLkEQzj0G5+ttnEoHvKP2xO6veghJDq61tewLA+Mu0havX0Esx6ESwocMfh1SPKoFtMGt6pxZIblf/VotU9V9ahzRMLSPllVFSkkYUmrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ShZkPb4juPSCk8I8KDHDMsrj36aZ8i/TkzCM8ED+Kw=;
 b=EMmWLovblOMLtVBmevJC77O1JRS3ywjcPi3aaupHMydHA3HL/CyAziHX681CvxDf76Wwr8pdwWuO4nneLvTj+fUMRGbDp+lo/7l3DZLkUC3iq69SnMpYKXA8rgruMwZOOrdQCSTR3wIpjvwdRpFsxkW/0k7gVlQv4ZnnzWmmQG4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB7913.namprd10.prod.outlook.com (2603:10b6:408:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 27 Sep
 2023 22:56:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 22:56:24 +0000
Message-ID: <8b92ecee-e018-6570-880c-878919260e31@oracle.com>
Date:   Thu, 28 Sep 2023 06:56:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs: reject unknown mount options early
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <5c33940976b7f970836d8c796f92330e5072ffdc.1695777187.git.wqu@suse.com>
Content-Language: en-US
Cc:     David Sterba <dsterba@suse.cz>
In-Reply-To: <5c33940976b7f970836d8c796f92330e5072ffdc.1695777187.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 064754f9-4ced-40d3-b26c-08dbbfacf941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+S5VHnstufdMqGfsGAMLHPTjOJic1yWkw0D9m0DX9tVsxDOnNsaBomYk6eWI5mSyL9S5DRzmR1OC7OFmHJO8gvHZLHEH88EmoZJdTzkWeEWu/cTi2Rd1+q7s+T0D2YsaJCQ1JSeJuLeAYZjKI/475ypRpx/37NN4rh+cEb9/Aa0UOBMjBDI1V8S7Iy8CMy0UOpxVzgrTWPHtjlGAvHaZiPnYqk+7OgcEUsc3va/GWP68yddObApsapqUq7kvzG+jZwLfcl6X0Jp33AmxIVoBhNxfd4pR0Dsk/bFWhMXu8c0L/JoQ3ilVik8My52CJLEQPmQxj14KuCcYFNpI8Ptu0rczZK4uWK6XqAs8o7ebUTX4fiokoE6zhxJvxgFdoaaJOvFwI6qcAVtBVj2WfA7J/S0S74GjV3+eckAq7qKVl6XfAQeigrah3/b3yT3H1UPcYjI7ma/LU4QTNOwsWbTSJ2+XpDsUv6v3DrC4IVDyUpSDEhjD+n4A/orBxUczRKnppgMmNa6MkLN5IPK4+lg6W5A6oNyaZt4ESN0Ba3OXfhZI1SoKUndMeakoXd3Xx3KFgf0NAKHPBp7PpRyl81aFDEdvhOsur/75CKt9VnNT8pXW2Ww4cxaoEtzQMV1+1YXo+vbACQ5mBaRyb9W5nuKfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66556008)(5660300002)(31696002)(66476007)(6666004)(31686004)(86362001)(44832011)(316002)(36756003)(66946007)(38100700002)(41300700001)(2906002)(6486002)(53546011)(478600001)(4326008)(6506007)(8936002)(6512007)(8676002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzhRZjU0MWpoaExPODFISCthdlRQZFBodDdreFRGZVZMbkVpdnNlMExyaElj?=
 =?utf-8?B?OGRGQ2w5YTNKeEN6VGkvTE1rM3hXT0g5Mm5jN3hCNXZjdFVkOXlOVUNUMUd5?=
 =?utf-8?B?dEpTR016UVV5ZUl1SHp4Wi9Fa2N0YXdkVk9STFdkWWl1ejhZZHI1b29ZVDdQ?=
 =?utf-8?B?dGRvQkptZy9saDZQcW96c3JqOTduK0pjOWlXc3dIZjMxWW1INWdaUCtQYjVq?=
 =?utf-8?B?NC9saDlhWldYRWFOYzR6UGxlQmlmRDRyKzJBU3ZWbHRUUWxLNmJ2bFFobzEy?=
 =?utf-8?B?cGlGaXpiM1VSN3pmMFYvOXlsUEtZcjVDb3NLRlorWlBWQjVsSURIdHA2TmVp?=
 =?utf-8?B?RlBFZUFIWTlSd2ZXbFZXWDM4eDloVkxsMVRDSFIvUHlFOWRwRFZSOHVxbVFJ?=
 =?utf-8?B?V1pqU2hnYkh6cnZaYjZsYktLcGEzWW9NbzZDRHZFTWlzc1JrMkJ1MmRzQzA0?=
 =?utf-8?B?ajJjRE4zL2VNR0xjZEoxNzNEV2Jabmg4RjVxWWIvdkhUajBZVnMyblVJNUNm?=
 =?utf-8?B?YWFjb2J1ZXg2SHpkYTlOdkFmN2drei9sdWhaSVVCTzJLMzJlcVZveURYeVBW?=
 =?utf-8?B?OGFvSDRVUWdjeURHL0VvVFJuYjRHRFlvaGpqUXN0RHlVbXFBUTA0RlpISGNL?=
 =?utf-8?B?MTF1VGYxZXpYeXhHQ01sam1vbi9BaStnVDZsRFBHODZ1L3JidlVYVTNvL2d6?=
 =?utf-8?B?WVMxbmFjaDRWQnpONnNtWXF1RmVmdWVmd0hEbWNxbDQrYlV4U1lucmhxcTRo?=
 =?utf-8?B?VndrYkJVVjQ5TmgwZ0M3QWROdDNLWnZac2RYbVJ4cWRsN1o2SjU2RXg1YnZa?=
 =?utf-8?B?VXJFWUhQdTY4ZUc2bnIxenV6Q2xSM3hodVdKZXBSdXdaQ0IyU2E0TzltSWJP?=
 =?utf-8?B?VG9JQlhudlRJMXVBUk5pN0tHNGxEVHMwTjYwcmNTdEZkSkZLVFIxUFpaL1Er?=
 =?utf-8?B?clo5LytWb2p5NWpkZE9QTjBPWGFpT1gzejV6Z0Z2YXhxUXVZcXZOeGlSeDFC?=
 =?utf-8?B?dGxMQjdlaG9KM3NLdDVpQTFHVjV2VjQ1OFA4QWF0c2I2cHJuRkZFSHg5M1Fy?=
 =?utf-8?B?QWFodHdZSHpuZ3QzT09nMytIZlpZbzArRjc2NzBiMXFTN3ZqZHFNaFJKT0xX?=
 =?utf-8?B?blEwY0JtdnNaN2NnVXEwclJlcUhKdG5yaXVjN1hkT0RKcFdZUUNMd0o4YjFp?=
 =?utf-8?B?WUFJV3lBTXN2SDdrYklFMnRBUjlJRGRySlZsL25CRkRPWEsvTWhpcWVjMzcv?=
 =?utf-8?B?RTNYZDkyNkdoRHJLNENZS0h4d1orekFNb3g4MGFjeGx5RjVBUzAxemxVTGlQ?=
 =?utf-8?B?ckhtZ2hncmdoZ1k3M04rODJuV3ovOG5EL05EeHZ1YWZYSFVkOURIR3EyTmFW?=
 =?utf-8?B?VkltM0phN3hHMElYUmF1cW11RHZQSzVZSlQreXoxRTBZa1BZMjNYRm1jc2hW?=
 =?utf-8?B?SzRzVXByZUJiTW5xRXdEaTJ5RXdjMi92Y3JSYnBKU3ZGdGJibmJjTEJUcWNZ?=
 =?utf-8?B?N2F3WGQyTys0M29KaDRBY3VPNzlZL1FLYUVReUFKVG5ZNUgxLzZnQ1VLRk1S?=
 =?utf-8?B?TUV3UDcxS0dza2RubHA5NjBPR1V4a01oL0xRUHRaTVpoU29hbkMvM0x5Y1lZ?=
 =?utf-8?B?Vk5pbk5GM3F6WXpHenRDajc1WFVvU3gzRnVZQVFoY3pEQmtGM25aVjgzTUgy?=
 =?utf-8?B?K3hUVFZ6ZEZBYTFZdktxQ0taWVY3MWRtMWczSGRyV2l1NE9xWFVlTzZLcXpz?=
 =?utf-8?B?M3E3dUUxOEN1RVlmTEZML01QMURzMUgrTk43MnJvVE5PSXp2RUx3U3p1d0NU?=
 =?utf-8?B?dXA5aGRGNVBsUktUYUhleStpNjQ0RU95M0lNUzlBQXdjdDU2YWVRT0h2QVU2?=
 =?utf-8?B?SjZ6ZXJkUEk1VmIra0hnamk3aGlhWHA4alhEOEp3NXBhalNqeU1iSE15Q3ZR?=
 =?utf-8?B?UUw5b0J0RXFXaUY4MTRWbG1va2dWTFcrV0c3YjZtMEFmcG9ucFBHR3lvWCt3?=
 =?utf-8?B?R2xmYVM1UXNiRDRkdzk3QWd4Z0ZHY2VRd2lYOGxHUWJFQWl0by93cVJIMVpG?=
 =?utf-8?B?c0RrK1FLSFA0MTVqZ2loZXFxMzJubTY4aFo5UzU3NmNUWm1uMU4zd1JYWWdk?=
 =?utf-8?Q?WWpHnri4C81K/FwqMJKSNdG6d?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MpkMIYir3Ix0rFxSGseUIGw4jnrMnQeVwiSwKAnPuSmGwEum5bJTuz8DQWeUz+70kr5ckp6hD82EbHuhaT8f3Jid2velLaA/qGxQ4G5gd8OYprboj7D6F+1+l7vmXWqHdBuceEHqMTqDFPzIHm4Ak6zE8f0J7SQ740ymsepP/I6VgDKsgKWLq8cBGtjR+09g5KSJ3eUeNBKm5vucPQtVa6GLOBeciirGcDS1CL9iMiWMMaiF2HDlDHBHGXFj4DG403M73KqmBSnFepp/UG7bq6g8qcZ93ofBDMxPFwnOrTdh3t2KQcjOGrIyUA9625a4qfcO9H8lbz3EozKwfUJsgy5lDqQ/M5YU/vDpqPuET48lHGl/5UytNGeMl9xLVE3h7v4d6Wvo/A5Iwk1wktTQz/+HKDcafpFHqNewUdVn58bXbp8ApbcW44dUPjJVjmEbAb7GgDXqenur0AdJ8FGQ2/3+anKyvO3k76mh3yAup61IVUom2xSGIsXxUm92kLaxR8x6uzoBsPQ9UrZKz3jO1RmPX48daAGujHBdwRd1q/vSXMSlwuH3MKXHyIGZ8bCNeNWUWWdvKSvrbapUuWMMkZYB+UWahSi+tqc3ik2x9KivBB54D1IA/L7lJuqEm7ucZNYZ6G646VJTO7Qk2rVc1nuiiWX79sBqOwtv4kG2bbEhwH3kO/q+QAvumI0nZeTtkCbOdFlWzdS1BZdiLAGuPUxfdF7kTDpFJy6UDCIMRue8AtCR4WLk0Ll2aodrnOHmIwb258JtbJDOSqydzDMqqJAPAlSIh3d34Vp0PizZ6qlSIVhlCxCDKneR5DNUUTRo
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064754f9-4ced-40d3-b26c-08dbbfacf941
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 22:56:24.3183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/jWseAge32kz9C/19uwbM7TXQovbxPluJI25xYC231lCyTrPyja98EG8jJCVjWWh2G0DNIbgSXT9zMtw0esyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_15,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270197
X-Proofpoint-GUID: yELJ4QdGQ8DJqd1qluCr34M9XlRxLGK8
X-Proofpoint-ORIG-GUID: yELJ4QdGQ8DJqd1qluCr34M9XlRxLGK8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




On 27/09/2023 09:13, Qu Wenruo wrote:
> [BUG]
> The following script would allow invalid mount options to be specified
> (although such invalid options would just be ignored):
> 
>   # mkfs.btrfs -f $dev
>   # mount $dev $mnt1		<<< Successful mount expected
>   # mount $dev $mnt2 -o junk	<<< Failed mount expected
>   # echo $?
>   0
> 
> [CAUSE]
> For the 2nd mount, since the fs is already mounted, we won't go through
> open_ctree() thus no btrfs_parse_options(), but only through
> btrfs_parse_subvol_options().
> 
> However we do not treat unrecognized options from valid but irrelevant
> options, thus those invalid options would just be ignored by
> btrfs_parse_subvol_options().
> 
> [FIX]
> Add the handling for Opt_error to handle invalid options and error out,
> while still ignore other valid options inside
> btrfs_parse_subvol_options().

As discussed, the purpose of my report was to determine whether we still
need to return success when the 'junk' option is passed in the second
mount. I don't recall precisely if this is intentional, perhaps to
allow future features to remain compatible with the KAPI when
backported to an older kernel version, or if it may not be relevant in
this kernel version.

Thanks, Anand


> 
> Reported-by: Anand Jain <anand.jain@oracle.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/super.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 5c6054f0552b..574fcff0822f 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -911,6 +911,10 @@ static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
>   
>   			*subvol_objectid = subvolid;
>   			break;
> +		case Opt_err:
> +			btrfs_err(NULL, "unrecognized mount option '%s'", p);
> +			error = -EINVAL;
> +			goto out;
>   		default:
>   			break;
>   		}
