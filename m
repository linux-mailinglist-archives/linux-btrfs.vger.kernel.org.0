Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C6178BFA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 09:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjH2HvM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 03:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjH2Hur (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 03:50:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D68C1AD;
        Tue, 29 Aug 2023 00:50:35 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T6iSaV003147;
        Tue, 29 Aug 2023 07:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YpR8A292h+07ByL1UocIRS0zHs8gQ8YRUjQ+bQnqEF0=;
 b=uwjRmJAs/hVMJ71QXqoRzmsKFX9OXwfBqkn43e1TC/fRxI7vz3epR2jmjN7uU6q7OXjw
 RLD2wMQ8sUq67gtIVX89QEjH00Lx0VNmTsHM/+NfLZ7TgFwarzDSGdRrBPv+kfY3qY5c
 JemaNeI3lsOpZIUyxP2fGiHS60+tYGQ77m5gdH0zYVFMaIMx7m5LlQyHt9XlCprvP36m
 8RilVRXmxnT+8j3KVKzpFd8goLCgtpZBK/rdM6WC/RAydlQNIB75U1pujlnnIKbeMeTM
 m7orlvt2Xmt4XsvXDhukVbT2GvCIkwv3piaLMhUlaWBiew0jODEyEH7Mr4SXoIVmyYBt cA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9j4cd3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 07:50:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37T6i5CH032935;
        Tue, 29 Aug 2023 07:50:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dn85q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 07:50:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leIMLtuywIghPxwjzE9lsLrmxbm+ew+5n5IewpbWCxKSDkfbd3ezvGUsRJCpzoH2Wi/Xzf95IzEQmoUImQnWFNlbvjFVtCcd48IHY2TgwFgmXXAnWAi9vWhQQnCJ4Sq5JYzF7SZHVzqkkmb0EGdUNIXyW1miQWDU00B88C8KAdwreankeNbEW/rJmy6EmniIcvxns2sBe8hI2GB8zJJv9jD1PqD1q/xZsR5dIWcPNg9dcDiVEAfnRDDARDoseNIWsqAn7AhosADkFsrrExQU7VeDbjkQezXa7p/Y99aNWkQfpFG8lGjKVDQsd4Y5eQ/DojHRDWjo9PZ7C7UlwbyjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpR8A292h+07ByL1UocIRS0zHs8gQ8YRUjQ+bQnqEF0=;
 b=ApXw0S5JLV2hv1W6TlD3q6GUFxb4BOEsWDPtoCm/4LBWPrmkKDDX/RpuktsM+VQqb5Q3hHPLoHfCCnrTdCpR6JWncSIMyeLjdyr8233YC1COYVYYtDE+by4DjX/vtMv0ZdRiw4fiOmyTzM8h7KSteQ1+/WoTs41URi3HPe9ntitiSK7d6O7OD1xPl36tUtI6qCp1/5zIiTtBnx9kDvbMaAJWtrO5sC23YyrkJggC++jogghMatE42gsXc5G7+jC2WOUR3d8htsRWsfZhJxFARx/Fwka3UJr1+xxw6CmQXJX1VEF3JwViKHh+ZkGmr+WNLvlSptd5pMRqpQ2oflsSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpR8A292h+07ByL1UocIRS0zHs8gQ8YRUjQ+bQnqEF0=;
 b=daHeoCQ9e+fTk+VklIdGeTdS8z6qerx3TylE0fAU3Ulf78pt2BCaYhep+0K8NJwBVAgvQXpDYST9fO3TNU/QGFPrRvYH3HZXgBDcCzgUJ4wkmrGg84BIMduDifEBuBJuo3/4aUBtFp3cIaNU5J8ZBM04iyymurWhSRnNUbazja4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4728.namprd10.prod.outlook.com (2603:10b6:510:3b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 07:50:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 07:50:18 +0000
Message-ID: <62240534-27e1-a40e-49a3-7198be83b8b3@oracle.com>
Date:   Tue, 29 Aug 2023 15:50:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs/282: skip test if /var/lib/btrfs isnt writable
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@suse.com
References: <20230824234714.GA17900@frogsfrogsfrogs>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230824234714.GA17900@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4728:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d22d6a-2361-44b7-3176-08dba86496b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCk79Pjc5P96LQxDwgmAfpRwVImw50si2Etn3ZsLWTNjeeFTkq8l/1waKp9pI+5JruwgBn0zA5sseC6uXDa2UhizAGaNdzaM+OOA8Dx3+b5VuwkUixNpb9rckiCKAXykjtveKecS8gTMvMadA8JomjggvPDxIsFk2MiqS05+3hgwcWLq6HKHzv4TlC6YfHkOzFp6Oq2zeQVdCigiC3jvR0cHonZscL5UQqu0zBGiu4W2yOxW5otCItD73e9nIHkmDF13twEoX5AcUPiX+n8jY9Ulu+tXJO8//1DVuW1Gj4sCDEeezK38jokd3oQX+e602D+YJVL70dLyqDoAFZWZagyIGgsmf1FbYR7I+pht0EjBT8DAkM79EQv8EoyCD7fySU9zb8dwtL9eIfVi90Mx0QT9OwEHJjmATh44NF343e9gFSCWU6T/imboyA7hI269ZyZccf4Wit8pd9PE3lwD7NdFkZNluKQcXN8gbsoxFE4wKrFRY9wamJTGQxkYRhfPXsEEfHkgBYo8P/TS9hlmjrrh2yypspduzVcY4aFN6jO3LAUvLpyr7EbMJNeQ29FYiXQhZdY35VhpNIlA0RINGJxIByhZ1xHRQ5P7mXINhHSdUKnKRoDZc46RQHr1SiAq/Z6F+wDH661ybo80fk3EQMFiFSmjH4OhMEZuWYcf2oY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(1800799009)(451199024)(186009)(6512007)(38100700002)(316002)(41300700001)(4326008)(2906002)(83380400001)(31696002)(86362001)(2616005)(36756003)(26005)(5660300002)(44832011)(8676002)(8936002)(6666004)(6506007)(6486002)(66556008)(66476007)(53546011)(110136005)(66946007)(478600001)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZtall1cUVQRGMxdUVjeUtUSnUvS1d1ellIOGQzRENiNklDNitXYlFKdDYr?=
 =?utf-8?B?RE5MQzYyWHl4WndRSkdwMXlESzl6UHRjOHRFeUdzYk8rNDliMzVudFIzOUFu?=
 =?utf-8?B?ZGs5dmhrUGVNVWJROFNTYkJ4UlhOemtIYVBodUZqdjJ6eXl2VHdnbUd5ajZE?=
 =?utf-8?B?Ky9JcmFoZTVMbG8zcEZ1WHFWY1Q1Ym9hUkZvSmp5NGY3YlZpWjNnVTFocUF4?=
 =?utf-8?B?WjF2d2UxM1F1SkZDQXRUL2NEMEN2YTEwK2xmNGxQVmZnWVNESHBFSHorNFFZ?=
 =?utf-8?B?bWtlMFRCdEQwUmlvd2cyM1Zod1IvWjc2QnkzK1dKdzVTVkhXa3pxcGczR1lh?=
 =?utf-8?B?S0xuVnpIcURKMldRbVVURUVSc2VpMkRydWFNM2RMQnpQZHR3eVYwY29uZUlY?=
 =?utf-8?B?VWlpOS9ZN2ZWYU5PRHhhb24xNncra0dGL1pqZGJXUUFsVHhrMytFcXczSWVq?=
 =?utf-8?B?aThwdkV0cWxOODBNZldFV1BuS1U3NmlnM0YxQWRXN0NNTERVbWhydWtzMlBK?=
 =?utf-8?B?Um1qejlaSFBXNWRpcnorNlZyODFWdmQzT2NMbHlBRnQzaGIvV09JejE1Y3Qx?=
 =?utf-8?B?cEgwUnNVVTZQdTNCWGthckc2Z1p4Q3ljeFFFb3dBVThDNmJxZWUrd2ZxQks1?=
 =?utf-8?B?V3hVVmh0cTFTbUNwSFFiTFZtL1NkZHZJWEVlYzQwREpiajdkY0Jka3MwZHNH?=
 =?utf-8?B?MWVOeXErTFdnVDJVbUpmN2J4V2R6dDBIUGxSN3Q3U1F2aE5Md2RvcmVoZytN?=
 =?utf-8?B?anRqdURxNmxDY2w1WCtSdjlGeGlVL3BtRURXR21vZUpxL0VuL2F4SGxkMXR2?=
 =?utf-8?B?SkdJRVRDSzhDWEhudjhJVlBYc2o5SHB3VFlZbVRzV0VnbVFueDJyZXZxTFkr?=
 =?utf-8?B?OUNqMGZTYVp6eUJEQ0QxOUt4OHhua3FDUm9vM1VSTWQzWjRHMnN0Vzk3ZHVQ?=
 =?utf-8?B?Y3dYczY2MDZMUVZzZ0dZVzRBaEg4TnBHNk1iMWJDM05KTDdqSm8xOEliTkFp?=
 =?utf-8?B?Qy9QU2wrRnhmNDd2b3VvRFk0OVZDT3Bqd3VTZkI3T1FIaFNhMHV2cFFyNWgr?=
 =?utf-8?B?QXphaVExWFByMGtYMWs1Tjh6KzBKK3dVbWxTK0ZiVFBPM1NvTG9VUCtrLzdw?=
 =?utf-8?B?R3FmcTBnWThUd25uYWJWL0RQaXdsZEV6UVBURWdVNGQ3eVZjNEJDSWpNMDNu?=
 =?utf-8?B?MDJTZkU4U1JLWmVTY3dzTXJmbXEzV2VlZmR6eHpuWTYwZzdPemoyYWk0aFlO?=
 =?utf-8?B?dUM5RWhwT2o5czZyNkFFbWdFT2grVm5NZis4WWFSZUFZYWlhQXlCMmhGQ2Fi?=
 =?utf-8?B?SzRIZ2pjaWhOdkx5RnJqZnROOFpIZU9SeElyMmxYVnpIR3hncnh6K2dMRGsz?=
 =?utf-8?B?R0pid0hBNFVTZE4xcFNZRjB6L2NYUHhuVnNjbVVyWWFiSWs1Y1VXQTNlNVAx?=
 =?utf-8?B?V0Y5U1c1cVdZTVZ5RVgvRUNNSnRuVG5jUVZjU1BJbGUySnBXWnJxTzdGdlEx?=
 =?utf-8?B?bDFraDNtMVluc3J1b2x6UmFXWjRsQVh4VWl3TTNsanRiL3N5TFFFbkNhTlV6?=
 =?utf-8?B?Y1Nwbjh3OGNzMG1LNlFoVzBvOUdnb0x1UXBpZzZ5cnJ2VENXZWIrTWhZTFFL?=
 =?utf-8?B?MWlqdFRRcFFCV0ZaVlRxUjY1ZVZhbTh4em0rTmNidTAvTXRFbllQMlliSm9E?=
 =?utf-8?B?NFhKR0dIQVF5S3BVNnZvVDU0cTdaTFJtL1l4aVhJeDhHUXhLbGpVb2lacy9U?=
 =?utf-8?B?UW9TK0QyaVFxTjRDWTJyNForMWpEcnFjckxVT0JlZ3dxcDltYStxeStabkRZ?=
 =?utf-8?B?WFVVb2ZtazdmMm5nNUN5MktZTnZqb1ErT3FzUnVRRGM2a2E3ZSs4VG1JSjI5?=
 =?utf-8?B?TmNrS3NkL2lTNUNDcGhrTEpYemFXNnpoUnRSeDdHZW53eWZzSFlyVExNcDVz?=
 =?utf-8?B?dHQ1V3NydW4zWnIyRkZTN3Q5L3ZLYWxvNnZPRXRrY01XcmxmZ0NCL2pValRw?=
 =?utf-8?B?ZVVWMTRDRWNBbnZhVm4vQllwR2t2aUtFV3pBSUlNV3RBbXZHNGkwdkZpOTBU?=
 =?utf-8?B?Yk1vcURaUGN1a1VZKzAwSGttRzFYOXR2WHRwand2UlpHRnVTRzVxVkw2Y2Ji?=
 =?utf-8?Q?KP+M4n8CtLMMx5xln5Y7laIka?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RJ5cORkqczKdCSCoakJmCQwIjlc1rlSlgt9YJIRxRN7+kcZf6GU3r99ZqXVzyBLOXFOVT6+o51moXI43MGkRD6SW3YH8ZVzqTvuKCshXlCAQyocTQ3SVxD6c9ScZTxXI2a0/DsiXYHDuU9oI9vYz0WulZ+Uz/9n5c1uYQeY+B450Mjp+A6NnYf8eETQ3an21Z9tc0/xtE6hUuAaF+fs5r77YYH5/aNr6d2HwvUosQmuL+EyatXpi9SDwwC1zk4mgquf3GvFvErhqMyE9GLYm4AyUwJtVsraCMlM5nPMkXQakEWGr/C3Yhj5Y+GevU9JzzV1eIzpXPpu54n/y+4b98yKsUi1DkKmlH9qe/OFzKdRBNNdSmOME70JCZJCH27EYYdUEVMUHeSxyOEM4Ucb6z5AS0BChA/IJX64i7qPRsGKvQ9bJGxK+UDCDH2NvWvx+nwk8hNYU+c9G0ONoAcyAFQYVssO3NvdqYAaPIXVFBfe0VI5M0YpuIeyKGeWHqpAK5AZ6gfRHSUz41UKJRwVbMWk+zG0toXhto7hBfmoYF+utBjc9fYVEHfjPlTQ6PiO+sefAx9n8DGDMr2jjcqXuOUJJ7FI+yKkuSoUnBLzJA49/0BzLs7MWLmQkY/VHJQokeL3/1ZVQClTfCinOfEbjNJUhCXSkGobejc8UzmN9gljQBTs4gPM29VpjKlpQq0EB7h9RKRHDILpwZF53mmXwk5Mnpfim1TETH5IKPsKm/ZeJs3vvGBFdthkRXm1+Jhxz64nQSlhW0H9HsiuaqDLHrPjrH22jaKAX0MyR8FE8jD/AGrMstk78lUb5kcMla8qP/YVhhseomZ7g3eRYYLoIMA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d22d6a-2361-44b7-3176-08dba86496b1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 07:50:18.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilBNax1M+qxGSpgHcxiYY5u+mHHo+Xh6cJqamPIIBe5t+v+/xEGG6OYX2SjNAavA5n5U/0TxCJCEO385unNubQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_04,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290066
X-Proofpoint-GUID: CQnObet8P94JPzZnEgfClpgkQ0gWt5T1
X-Proofpoint-ORIG-GUID: CQnObet8P94JPzZnEgfClpgkQ0gWt5T1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/08/2023 07:47, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> I run fstests in a readonly container, and accidentally uninstalled the
> btrfsprogs package.  When I did, this test started faililng:
> 


> --- btrfs/282.out
> +++ btrfs/282.out.bad
> @@ -1,3 +1,7 @@

git am is getting confused and starts applying from here.

>   QA output created by 282
>   wrote 2147483648/2147483648 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +WARNING: cannot create scrub data file, mkdir /var/lib/btrfs failed: Read-only file system. Status recording disabled
> +WARNING: failed to open the progress status socket at /var/lib/btrfs/scrub.progress.3e1cf8c6-8f8f-4b51-982c-d6783b8b8825: No such file or directory. Progress cannot be queried
> +WARNING: cannot create scrub data file, mkdir /var/lib/btrfs failed: Read-only file system. Status recording disabled
> +WARNING: failed to open the progress status socket at /var/lib/btrfs/scrub.progress.3e1cf8c6-8f8f-4b51-982c-d6783b8b8825: No such file or directory. Progress cannot be queried
> 
> Skip the test if /var/lib/btrfs isn't writable, or if /var/lib isn't
> writable, which means we cannot create /var/lib/btrfs.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>   tests/btrfs/282 |    7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tests/btrfs/282 b/tests/btrfs/282
> index 980262dcab..395e0626da 100755
> --- a/tests/btrfs/282
> +++ b/tests/btrfs/282
> @@ -19,6 +19,13 @@ _wants_kernel_commit eb3b50536642 \
>   # We want at least 5G for the scratch device.
>   _require_scratch_size $(( 5 * 1024 * 1024))
>   
> +# Make sure we can create scrub progress data file
> +if [ -e /var/lib/btrfs ]; then
> +	test -w /var/lib/btrfs || _notrun '/var/lib/btrfs is not writable'
> +else
> +	test -w /var/lib || _notrun '/var/lib/btrfs cannot be created'
> +fi
> +

We need to enhance this to  a common helper, as there are many test
cases with the scrub command in them. I'll enhance it.

However, for now, this patch is fine has been applied locally with
commit log changes.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


>   _scratch_mkfs >> $seqres.full 2>&1
>   _scratch_mount
>   

