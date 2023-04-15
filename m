Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA766E2F68
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Apr 2023 09:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjDOHO5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Apr 2023 03:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDOHO4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Apr 2023 03:14:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC0F5243
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 00:14:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33F77gk7006556;
        Sat, 15 Apr 2023 07:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ILIA0XOIiYZ578U6P58EIy9RzqF5Jvh2nMZ2vHp7DlY=;
 b=TUsOxLrLslD7Mrcw33w5rP1XZZnPCVTuyCd4t09iVqEzU/nTx0FYkCM8l6GKAJuS+THz
 HT+1n2sfXjMFPav3WlgEUfs+A+FunxSWYJIgcMdnPhahw4X+bH+cqk3KPfmbQHXXqdGI
 PuAzsZGOxmqrmMUxMp9WiSYcUkZ7XLqglKdH5N3eNSTU8kIfmsQBkYXgJu6HyDRihQj5
 l0eCECQJ872IPk0YQaJ4/+7nv2rf3AIHiKLdfI5v18Go6f4nM6s1eockPbOp7cit036J
 IwH/YjK3voJxcHVerZs0xaV8UNSDwEf2hpcnGGipVZt2N/bUAf0Mcz9AAMLl37Glo2IY Uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyktag5d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 07:14:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33F3DHCS027765;
        Sat, 15 Apr 2023 07:14:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc8d7rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 07:14:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDt24Ho7raWBZR20obP8gOnibmrSXoy2/e5Es1JATZ7Mc6p453vUg28/+H869B7+tqZlKMnSzs32r0GeDuBhFzHxSsVWDkDVzo+Z4fMSrf6fvyJwVYQ6K1QwVeJ3SFehzfyWpkphaCbC+yTxa9S8yzVdUDpfIWOCiturVX3kxiAPjcGQrt6dC+IJEqMiuM7rIpW1moEtUl5CXJOKlORy6w2qYRu2BeaUYKGG2HwJ5Yhtd0wfSkun4etlXiwT1GAl0t3oGymG6tOhpHGRlK0vZSluCr7PtuKZ+14Z+kOKCmnhrk7Enz731Gj3pcl5oI3gD2BaH7lMJ3kt2hPnDuaQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILIA0XOIiYZ578U6P58EIy9RzqF5Jvh2nMZ2vHp7DlY=;
 b=meEMgQjBi5VUuCdfeOpOZF/7BT/R0jN0LlqxPaJAj5ZI0QtllBCoaepFQW6qHsrZUPbB5yVDlVHXJoqaiRWajH2D6AM5tN/XVcSiexpH07YrckJ2BmtQq7gDu8BQhc9J5rZMo49bQg+XtODRaniPzOuvaDP8NAm308jkb/zEflsE2SpOTC7pNX/5JrhQx8q3G54rM5oj1/RxRqdptE2ct2fldRkMYmj4nYjcz/TKyu8mC8PU4Q7E4ZxrxXvvo7hnUMX5U6fSzX+sfsKxipebj51oVzd+j7+b4eq2HTJGoZSc+ZvPBlONP0PuuBvlMZvWX1VdkiSUi6YcbYVFHZyGQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILIA0XOIiYZ578U6P58EIy9RzqF5Jvh2nMZ2vHp7DlY=;
 b=amEcM9Ps5PO44T2pk04FsSTg8nAX4tSzfTYeCv6OJutH7s/s23aAmz4EalzAdkczb4KGaAfZvrEszFUKdyWpMgFsZ8xFYurpzWDPUins20JuAT7DC9nrX/vRgHEtDVVkmH4vyquoxXgYiS6lq6CgW7morRJlCnKmg7SpcXkQYtI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Sat, 15 Apr
 2023 07:14:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%6]) with mapi id 15.20.6277.038; Sat, 15 Apr 2023
 07:14:38 +0000
Message-ID: <12e3a9f4-8a7e-e46b-0055-5b5999a1fbf3@oracle.com>
Date:   Sat, 15 Apr 2023 15:14:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] btrfs: unexport btrfs_prev_leaf()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1681295111.git.fdmanana@suse.com>
 <87089d229e731ab99a0f830ebbfe923dff06e2c3.1681295111.git.fdmanana@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <87089d229e731ab99a0f830ebbfe923dff06e2c3.1681295111.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: daf3c06d-13fe-4257-b154-08db3d811275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhjB8gAAfLoeC8NenNpCpLxiR2/+5VU5J6dvb/cYyUAiY6xtMb6SbYsgbr4IS2vDYocCJC9lxtjo4LSBBpIw+0yUjfMFcJbXfhwp2gjAj3q830O+Xg/S952ItkyPXq6Wg7oOy/AKZZgerQs3N4HGcqs6jOFgqOqZiJFHKuqvfdGFrHMCAsOz+9r8CF4WzIDQvhcn8MD4xiATrZUzLAyHHvcDNN04VoErLK21MbaD8egOvSaYaIejErKmvio+it/WaIq4B27DFEAqygLJghf2vscyC9uPSIc6eq5S+XEIF8aWTAiCDFzW7qAK8W1+KiWfVEpM8UAbBa4R12Ly3MuUP9kaGH/rYiDatRyVsnCT/1qUB77g7EW5Xx6st/ky/zQEU+24T7wu1GGz9slcOU1TfwC9Ni9i87MKf0v12FD+6g7Fc/pcHT5OZbTlUgvfGaxGuFyfxKrS0zSR/k/HBHBYj4lPRFggbH/FxoaQaXeEPB0toVIKJOWFEklJDvPgdjs016cTfDB/R5yyfgnyJUrbOJrI9EuYN7EN6UpUG8fGjFEW4zEG6JKM0s+rpyWvz723S243ZsII2iK1e7ves1gZh/1ogvThgtZgI/EVn9N5jhw0jkcpokQ1KHyDemoth/yTNXWjHue+KfkslmdO4m9r5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(31686004)(478600001)(36756003)(31696002)(38100700002)(86362001)(2616005)(66476007)(2906002)(5660300002)(6666004)(66556008)(6506007)(6512007)(44832011)(6486002)(53546011)(186003)(316002)(4744005)(41300700001)(8676002)(8936002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2FiR28zQWJaelZaWXo5Uk85YURPZmtkMTMzcURiTEF2MG1KQjhjamVqNXdz?=
 =?utf-8?B?ZXRESTZ4eEVZM1RoWjRRWnJ2ejR3aFBjZERRYWxYeUFFOUpWZnhUYVlXSTVV?=
 =?utf-8?B?Q3hvclBGeWQvNVRvbWQ5NENNRTNVRVN5aGxFcDhMNTFkaUZVaDlZY0RjOUVx?=
 =?utf-8?B?SVpsYnQ3eHZjMElUY1lYYVlTWkZvTmtobDR5RnNDU29JcVpvSS9xbHFoMmNk?=
 =?utf-8?B?V3p2QmdWekt5UEMzYnliUitoRCtlMmJ5N1BGQzdEWEQvNnFIYVFqdEd2RGs1?=
 =?utf-8?B?OG9RS2M0QWUzcWU2S1ZDY25sK3BjWERYMEQ5YktEaDhpSG5MQmJNUHZvY1di?=
 =?utf-8?B?ZnBybUV0eHdsVzlLZ3pOcUZ6Ykh3LzZqUHdhOUtSUU1SOWhmNWxLTnBrN2cx?=
 =?utf-8?B?T3MzQjhZVXplbDVpbng2M3pKZFJZQ01KaFd6bEtOSmM1S3pVSktoVUZHVVFz?=
 =?utf-8?B?QXNhK1pVNnhGYzNLb2NKcEdvOXBERzNPWTgyYUFmVXozRzR3NUlQMVFpT0Ri?=
 =?utf-8?B?bFRPMzg3ZFN0RVFRSUppZWtoMElTOExMckFRZk96dDY1bjVvRUFmVmRhTVJP?=
 =?utf-8?B?cmQra3plS0FVcTFSelhhUHd2YlBUNjMvREhKS2MyRVZFZWVyb0M5bUZmOWU2?=
 =?utf-8?B?WFk0UThtNkEvK0c2ZlN3bDRTWlB5djlKT1BGZGpzZThHdnV6Vk82QllyOS9T?=
 =?utf-8?B?S3Z3SmFhckZUUmNYT3oyM25hMDJKMlpucm5FL1ZYVVkrVmlFY0lWdFdHY0JF?=
 =?utf-8?B?OXpoT243K0d2a2JzQWJLd0d2TkNSUS93QUtVdDd6ZGM5MU1CVDFCWW5hTXBH?=
 =?utf-8?B?K0oyTmFNK2xFOWZDck5NeElnVlNYYzlCOVVJMnpZNW4zTXZwT240NnN0bkFR?=
 =?utf-8?B?WTJUNGpaeTRld2d5YXN6NUtKMlFoa1BqWlR4V0kxSG1uMUZGQjZYVS9zMGY1?=
 =?utf-8?B?Q3ZjK1JZc1Nja2w4cWRnZllrZW9zU1Jac3FHMTc1eXcwYTk0RC92UVlVcGtt?=
 =?utf-8?B?QWh2UDZ2aW9Wa2dJNmZibmlTNC82dnpsdktKUnVDem5KeDk3ejh5OEVLeURl?=
 =?utf-8?B?d0RzY09xVHRBa1crTHhBOEdPMlBEbCtYQlIvUjNLbi9lOGgzNGhUSFJma1Jz?=
 =?utf-8?B?UUxBZFdVcFRNOWtDbmQ5NlZqZUVib0ZUU1VQUHJxUGlOTzh6WEkzNklTR0Ez?=
 =?utf-8?B?Z2ZPOFQ5L3FiNHpKSmUxNDFGOWxLQW4yeUJEc1hqam1SVlMyNjhuSitrWXZR?=
 =?utf-8?B?aGZFa3kzc1R3VUFtamo2V3JCNmlsZWJoNWpuWkFYTEN2TU91ZzA1eVBwMC9z?=
 =?utf-8?B?UFFNd2FhajFTUnl3MzFEcUhNcVFqYnlRZjZhNjF2aUdlSWY4L2hlYTZURnps?=
 =?utf-8?B?aHlyUzR0TDJocUd4M3pEeFI2Q1k1YUE5b2tKSTBuYm44M21zZ0VKejJEUUpk?=
 =?utf-8?B?Uk9wWUtWU0pCWXVFSXZnR3lJMU1aNGt1NDFsZDUySjVpSWVXZkVCclJJRkZY?=
 =?utf-8?B?Vk1aSHh6UkNvZFZ3U05FVVhkRVpueSt0clhyeEplUlBmV1dzSU5GTGw2ZmlY?=
 =?utf-8?B?TmZqZlkrdW91V1lPRlZTZS9YRTRRVENPR0ZDRmlEMlRkamdvdytoZTRJUVpl?=
 =?utf-8?B?eDFjdUlGaTE3MGNDR3J3dlJmMkVTbGM2VWdwOTNaT2RDQk1jeGVIV2NMMFlZ?=
 =?utf-8?B?ekhWUlNURmVQaU1vNUV2ZnNHa2IvSlFUZEZMWXFzVTZtY21rRmdpYy9YTExi?=
 =?utf-8?B?VjA4Z05yL1drTHhZclArRjFGczNuMm50S2JGYUdOdG4rYWlvR1d0R1BOVmI5?=
 =?utf-8?B?YmVmbWFEUTc3cXBzSGdqTE5IUnhDeGNIQjRsYW5hd3dLM3BmejVmdzFxZnY2?=
 =?utf-8?B?OC9Cbm9RTm9TVlRRY3luK3pOQ1hCSTMyRVpCNUdFV1IyQm1TUjBhMkNuOWVo?=
 =?utf-8?B?VW4za2NTYkZhZ1J6V0lmc0VnNTgwaVdQTWlXaHp1cVRPNHJJNytxS1lYZHJE?=
 =?utf-8?B?L1g0SGJ1ZkFHcUgrZ1VlczVpRjcyaXdIMFNWNi9ZTG5XdmRGQmh4M0NJSExj?=
 =?utf-8?B?bFgybmV2WnhVaFVicEZjWFlzNHJ0citISnNNZXMrWkNFR2R5cDJSU1FnZUZq?=
 =?utf-8?B?emliSlhJcTJzK2lIalhvOXFkc3htUWdQUTltQURnNzdCY01wS1FKK1E5ejZC?=
 =?utf-8?Q?I5J5YGyEgGofoEEAH3oeL7figPuKNNVI3nS6SH8qN/g7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nfqwdk4pIDJqRyew3HMhtG1Ov1oiH5TCWb3/3k81eGazIGEyWy0dBO2LSR4SiFsPgjXTtA/HlPYpBO8giOf4oA+rTDFA4zW7aINGGWlnBtGiG3kLmSy56SCKfvtBCulp0j0SPSNpL3VsW8kxm9M24AVbQW8JigNDbtwKdsFhWvvf1i+6vrP98IbNbxM65wROnszC0wFzIas5zUb96iC94xmw1vAY+kzsN6e20r1sLjNFYzVculLKsOUSCrfZMMQMhYfj6zRKs5q/WNDb13SolIxkpp3xiYkp8YILaebzLNLMZXJ+k3f2H5sO5OiSVIDuxbWCFIn99r8jkX3Wp82qpej1z/09x/rVp7HKD+frtYhzHxGMa7DXo7m7re4jMJORUy9dhEpAqaKcqeS06RXY9/kgNpbDEhpTZyStqeKsfSANyO0JPvrIHTVC8oQcVPs4x+2NCbtdiI/elPnq72YV7sMbDwm3KKonOFOMXSNUiDBLiFpLinIIr1YJe+SwGyQDSXJFsn5NfMMBCvPjFNCYoVT4D0Dy3S5UW1su9Zd38svDS1C68nIG7IQNsLGOcoIe1ueAzTjxM4OCI09lMxsW/dBlJwGbhjyq96uNinqvuVhfxvhSdpAN3hgI8Lgf57+5nUKEGpS8q3erQf4PCjR6aUt7HzzRPtS0QYWcSx/Bzrqjjtw7e90h1W9T0ex9ea3BKxdD8ZjZpFfdF3PJLo2dhb3ESBuNcCWtSS8dfU58xR6ZSdQs7mM3owjXWeeH8j/kmwIuspIlGuK3O7+S2Fa1mU5FQj99P5qhCTHR+2VDGSY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf3c06d-13fe-4257-b154-08db3d811275
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2023 07:14:37.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB5nKaL9BLYXklAC5zOjoN3PJ1OPM2OgI42SR88LxvI32revqIiIdLpYV9neBpl6+SS6CrBRQey3XLEF1lq5vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304150064
X-Proofpoint-ORIG-GUID: 46dYPTySdREssf3trdMkRkJlLRkSvfE-
X-Proofpoint-GUID: 46dYPTySdREssf3trdMkRkJlLRkSvfE-
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/4/23 18:33, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs_prev_leaf() is not used outside ctree.c, so there's no need to
> export it at ctree.h - just make it static at ctree.c and move its
> definition above btrfs_search_slot_for_read(), since that function
> calls it.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>


