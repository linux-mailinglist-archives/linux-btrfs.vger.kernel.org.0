Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB86A9395
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 10:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCCJSX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 04:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCCJSV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 04:18:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33597DBD2
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 01:18:21 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3233iS5o005835;
        Fri, 3 Mar 2023 09:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rxHc5qwB9tEt5BrddbI5Lxc8pXxC3jk9GSx0vcI0sb0=;
 b=dFwT4R7CwtnpSQ1KTHriQWVVo7V97K/tTKlEVxDbR6AY0N6thfpZqhy8Nvoq9XTx2rYd
 1FLQz9jQiQ5fzYZpMjaR4Esui2z4EHGuXSqrO/IN21BTWk2cixaAJODxDfyLq0TvE1Sc
 SGy9mdr8HW7ERWsi6qmBvTo8EfdCnXRc7cTVnDIIQbpXAT3zyqhiRKi7uEGgdQSm1Lh7
 2mv0WVNI6imWRbJo7gkZRlu5egOpBc1Ed14qSgnymveefc+u6j7nYfskzb+9SEE6Hy8+
 UlbiBth43A+BLzES7hFTv0Sgti+r3cSq1D/eaQkQs8jgQWWZ7hR97EOo984c/3NvoIld dw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72npj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:16:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32375M14005178;
        Fri, 3 Mar 2023 09:16:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sbjdcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxDgde95Z6wCwF0izX8GbDdPk4OAGpNkQCkIEIhelVKgr8awtis3Qm+76YCJv6bS0x6yloRFgR5UWBbMxfkrQhM4jq6nsVy1ckDojNEmNxdaFHCxbXaVPFbUDSbNzUZW64naX8afIQ8nfrbpFtSPPkmTZRjI3qOPVIg0qN9rANddWgyw2yZsybHnucPJ8MYE5teezdnC9RNX3AaZnPxk7z3/cjlwThqnVq9aqxiay9f69P1zmJP7hTltEHkxRvByFUGa9Os+qm1WQKZG79grd1Xbx0i/xz5MvIIvvFhzka44QS4dkUwvZy1VrM5n5t1rHXA5u18gBvBKOzVJPw5Dzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxHc5qwB9tEt5BrddbI5Lxc8pXxC3jk9GSx0vcI0sb0=;
 b=Uwflv4NomMatNO+/BpxsEnkYMp9cvDCLgA2p4nq/qyUXVU/fCrKXMQrRwJzzWoXC0bWdTwUzPE167HPGdULli1Nam3eqBmwUyQg5Q/GvtEkF8zeUqmAujcjaiplicOsJTmH7QPYpSjs1Yw+Zpk8DNQq4UUzIevDz+rbPudaSP35l24qkPsNvxywlE9XjBLcsj2LZ2sZheXADQOZ8g4WfSjXRBHl9Hylhwyei+IuGzH+4Jql0tQLuAHC/iBKtTOw58zodjiB6+oS4LLnbZW1PmmcLR4tROp3ZsgFzP+NcBv0eKWxIPVTTd2OIMTr4172eZGvSS/AdTbSV3mUT/+uaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxHc5qwB9tEt5BrddbI5Lxc8pXxC3jk9GSx0vcI0sb0=;
 b=JlqfLNPvRI1bQ+ifntbTc/TuUkXDEYwdU6a6LlOtptUSYzlawTyn/a/8RmYHnZpeGBcJCsM39FrWdRWnIkALMBbOvkBoTHQVIlFUnpsUePvi4OL8tuCp5AtZ/gYDtX6+Bg2DzNKjnKMWZXyPuzQ5sjsKQEqBl11BcRdGJcSmyWg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4524.namprd10.prod.outlook.com (2603:10b6:806:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20; Fri, 3 Mar
 2023 09:16:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Fri, 3 Mar 2023
 09:16:10 +0000
Message-ID: <2f7e7010-70a2-706a-a91d-915ca28e9a73@oracle.com>
Date:   Fri, 3 Mar 2023 17:16:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 06/10] btrfs: store a pointer to the original btrfs_bio in
 struct compressed_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-7-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230301134244.1378533-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f44134c-ee23-4c91-6549-08db1bc7ed8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKj8mp82WfncyBsxIiCguvn57t4oY2iejnfah3EnFlbn0KxKHlkLyMsaBcMBpUQRER/ws37nIaHZvdP/GxiVxch3P3hmxXgZAifEZAl8wHLgEfC4WaqMXFiZHkW1HnRoj+ovW4goObhFOaivxP+hW9ItMaOHgHzzLRI0dtd+u9KLRsk+WajCGNHfLcmtrEfMWHRt0d2xXpsdBecT2dFNxJ14f9FXZo5C+M7YDn/UxTMXPUGhjlYVuRd+c8PTPgsMMTtRczFcTA4hbkhwZtwPGI7tT59fexeceo+gfcKkY/ppiS68YVAXiKx8RDmKtfeayG7f/P7w6aCM2W70/o9nFK15o9MYROkEzoPj95wlE5Ug29S7z/YMR42L9uwUFlcExWnD4J4OkFofGZsVCNzSvRVOkZmm/yUeDEdwfIslM/Pio3hsaXZ2W0RE60QE03CRff8bloutPMFggVeNmwOtCf/SJ6t2xlW4R9HRUwIjLuNremQLtEyU/3HPhHhIIywqyLYWMefx1I+dxYM2YPpWCNrRWqkB9JXR0d+UKx/2Ux0Yia/TOjT4hsy+7ibv/oLKFHer2DnwA2ChCEx/pGc45xFRWFqMnjyZGbfS8J6Mq2tZTS89eXUfVp+kOUbhXjF/CU8v4TiZUVBOANqG/VLV39ikfhDwHTIcx2AgONkSJabRxoF9HmULJAVoQ2ZYzCJ2PugUrflx7oQOR1zhXXS4uTBrinsGYfQzixqYrFKgY9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199018)(36756003)(6512007)(6666004)(53546011)(26005)(6506007)(6486002)(2616005)(186003)(41300700001)(4326008)(110136005)(316002)(66946007)(44832011)(2906002)(8676002)(478600001)(5660300002)(31696002)(38100700002)(8936002)(86362001)(558084003)(66476007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0JYTUdDYzRkMVZqNm1VTGZ1UHlsZ0xWWDg5RHQ2cXoxQzJZM2QreUZMdjZN?=
 =?utf-8?B?SEVSYkVFbkpHaVhvRjZZZytkdDBXV3NiY3F4YUxRaXRJdVhWVlBNTkc3Wm9x?=
 =?utf-8?B?UkdVZlc2QW1xWnRmcE9Jc3RveGp6VGNCT3YxSktxUjQvQU5XZ2JleVEwT2E2?=
 =?utf-8?B?MlhWbGU5WHR6Q05GaUhYc1padWhUdm4vaDBpTkR4TVBIR1ZJbk5TZVlBVDNJ?=
 =?utf-8?B?Q3AvekRTd1RLRnd0aThJL1pqeWNBMXZOd005dmYvUHRMaWh1S2JVS1daaVZs?=
 =?utf-8?B?dFBPd2gvMzdqRXJQOGJDL2RDRGNsYWJZdnVQY0ZuN0NJTTFUUnlCQmo0U2dl?=
 =?utf-8?B?WG1TQ1l3VmdYWDRkSWUxeDdISHJhYVdLTlkyZDM3QWhxRGE1WFJ3d2h2NlhV?=
 =?utf-8?B?bXZvTGpFTjZITm13a04xbndiT3NrNEdiSG9PREtKYU1wZjJPRzYwejM1aDJn?=
 =?utf-8?B?WUtWcGJmZS9veXpKTVVLY2hOaU5DeW52Y2ZGOHFodkg2NHROYU44SW1tcG5r?=
 =?utf-8?B?TjBWUVp1d09iSmRVUnRkWmFPSlhiTW5WNHBHRTRyU09PK3BMdmsyY1RZeEY5?=
 =?utf-8?B?alFTZFJ4cFRDRWhrMXVEWnM5bE4xdkttOWJTU3lzMTFxTlNldmhTU3hYTmZV?=
 =?utf-8?B?SmNsMS91bVBYQmlqL0dvUnV2NmROcG42VHJsMzgxZjZJVEZRaXFiMThDYzFn?=
 =?utf-8?B?NUNEOUVtRHpobkJJOS9yMDg3MzYrcitvOCs2L0dRR1JqSVVNTzA1S0Fjbmdu?=
 =?utf-8?B?UjVxL0g4Ky8vY2JjZHY3dURuMGlUekplNGZzblJ2OVhsdzdjbmVUMDJpcUxk?=
 =?utf-8?B?bkR2cExxMXdndHVUVWxoVnpZOGczaTF2SnRlSGQwTFhqeWwySEgrZ1Q1Qlh2?=
 =?utf-8?B?MUFRUEJjUk9HWUY0d3FhZ1Z4VmozUWJwM3dtK0ZEdWNCdlR2WUpGdEZLSnBQ?=
 =?utf-8?B?UmxsUlF1NkEzc21zM2pWT25ySDVKUkZNaGVMYVQ3UFVhbUx3RkN6K1VQTC84?=
 =?utf-8?B?bDVvQ1VrMnlPQWd1dWFwZ2VsOEUvUzNxMUp6Wm1HRDBuZi9FT0ErV0xLMjJT?=
 =?utf-8?B?YWxTLzdxdDJMNEZVc1MwdGd3MFBCbWJIR2FFK2xuV25zS2FQSWV2WGhBRmJQ?=
 =?utf-8?B?eVpURW5vK1FSVDQ4ekJFTXphTDVZalUzbEpLM3d3NVBEMEFENUhPdWpKZ05i?=
 =?utf-8?B?WE4zOW9Zc1ZQMnlMUVYxNzVGVG8yTjhTaXVSQUFCalFjcHUyczliL2Nsdmw3?=
 =?utf-8?B?VXE5QTRFa0ZsdzdXT1lMRTBQT0V4Z2tsZ0Z4anZNVG9iUUJsSVBSaXpBM1VH?=
 =?utf-8?B?L3hGVjdvN2xFNHlOTHJ3Mnpla0ZLZ296MGNXM2JJL2RmTnI0cnFJWWhPWEg3?=
 =?utf-8?B?c25pZ01Uck0venZwNDJiMjVrVWxZL2xsWnNacEUxME5QbnVITDEzYTVnWkp1?=
 =?utf-8?B?cHV6Y09tZWp5MGhYZ25Kd1ArZnJQMENZbU1IT0tSck5JK1ZHNU10THdSUnhC?=
 =?utf-8?B?RWxHMzRwY244T2NvUWc0WVlCbEQxZEJOazh1ekNsSzN3VFBaTzdISHFkOHg3?=
 =?utf-8?B?VzFDUnpTTzdlaXJTZUViTUExMlRHMXplLy90bVJId05oZFBIYXdSQ3d1ajBi?=
 =?utf-8?B?QytQOGs5MVlJK0FDM2RZTC9NN0RPUkJKbkR0NWJFWGlYdFNnZUJoV3lqenRU?=
 =?utf-8?B?S0ZFTHJoQ2xXK00xM25sQzdNbER0YzVnQkxUQkk2dUVtczg5eFE0U1RlYm5I?=
 =?utf-8?B?QjZlbDMwWGM0SDVhcExET1kyOFpCVVptd2NucEJsbFlRLzkzSkVyTFRhZU9P?=
 =?utf-8?B?NDFHaytGbTMrOUtaaFlKbkRjS2FiUVkzb0ZZSlJNYXRuYVBqWEM5Zy9TLy9S?=
 =?utf-8?B?WWR2cU4yRGc2OEF6MjVERzRLOWpXQTNKcFNjMEE5Nkhmajd5ZENtVDZnNTdM?=
 =?utf-8?B?aHJ4bEhjb2pKL0s2UG1kOWJRcm5pMlRORUUzdlFXdUx5TXJtWXE0TE53WmRm?=
 =?utf-8?B?Z24wYktwaUdmZW1rM1NUSk93V21oOG15amJkL09nVkJNSVM4ODdxblFIbkt1?=
 =?utf-8?B?UE9TTW92QnExTjdCUndDbWk2ODB1UkZSdEFpTWVha0hRTDFFQUVhQWFRVHBF?=
 =?utf-8?Q?6vBEtiRylAeudxkngV93lAyVA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7GDGPvFQMLLotZqCucUV24+wHTnh4TmIREzPdDrvyoTA2ajvsLhZ4eynZySNCL4ojyiRodGy1Lor0ianSRXBnLaVziR6cbFJttoNbIxH+dU0YAqs4/uoGTkktVIWhFC0FkjJWK0/QJvnr7jQiALesRT5pz3gV/bOKGRDwL465FQvqEvJj32hygyqaPf9yilDhnFs0980ybCp1Wl+Aj+aJOoWG32C9fwRJ811D+nF4kOFr2bk4qtEXSc3TwElfQNx3h49dpWC5i6tAkYcdAkxC7+ZDYd37B9Op0PI+iyygqsPVz/EF0DGpcckBBU5Z060bWAc/gt+Eg4TH51VDcoaCtFADjckpuxGi0hVhmATCs8mFyr2m/QjZzaj6XfKKoUfhaVy3cwKwVhj74J0/8ybeYvtB9gFa/cucrXbFaerHaQZNgQrHMYgnAWVr5ybBsrxke5CUVp5/PWz07R8m2sijY+kXiU5sUHNuIsOgbyCriBl3792mZrMOSCL8J8xOmMox7yfy93MBwEJh93yooCyHIc+p6/SYRDIDtKa3RxRJxHjQaRQDLUo0BGsZPMCLbUCgJSJq7qdLfLqfjZqaY7NblNCvB30fLwDxGBFgLii8qGv4GLAMoUU5sZziIyupIZ2XDConcD2K692DT8V6GHo9/0giNMEDl2ZDOB85QsJEKSihDSQ3UUJXZQETnrKlotnV9zYZdYO/f5n1CuQeXw91dziVQFElNDFJ3ViosukvxjgumwndxDmjoQ8YPrvRE0OBLsi54YbFnvfk2SqAC92rQ9KPA0DaeOso06O6AmyattMFUdJ6eTEJ90i47gSlj0LxPpRoTd1CMt2TGyKEe61ng3QVSPQwhgumzWQ4Uw/HZk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f44134c-ee23-4c91-6549-08db1bc7ed8a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 09:16:10.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMFrt0hCwCUXPOGm4EmX7MzAPMBfQbuv269R10LyXUPmc4IYc3uuJq+4m1FS5Nx5Jom76BD1fOb62ovxcdtZxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030082
X-Proofpoint-ORIG-GUID: TfRwJKtKxQgzMIKsYpW_efA41NyqQ9xJ
X-Proofpoint-GUID: TfRwJKtKxQgzMIKsYpW_efA41NyqQ9xJ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/03/2023 21:42, Christoph Hellwig wrote:
> The original bio must be a btrfs_bio, so store a pointer to the
> btrfs_bio for better type checking.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

