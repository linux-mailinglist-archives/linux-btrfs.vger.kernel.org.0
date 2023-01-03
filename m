Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B3D65BC2B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 09:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjACIZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 03:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbjACIZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 03:25:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58BC9FD0
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 00:25:14 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302NR2Rt000536;
        Tue, 3 Jan 2023 08:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UVHCY8VEMJTKJ5jSblN5Bc1rDld0HFQlUj30zVFOqUI=;
 b=WkTahpDh9irPLTm4wgYjECkA0a5yX2IjwI5yHyzyA6rE7WaVuzET4xFTf9SQnwMhAAQr
 oufJmUDGVihcPqPQg8JCaujZep3gcGJBBvtWUffLQ3QT7jrfsH/7hzL6c3oMXN/CJLVT
 fjV/W1aDPMuQqmPqkD8uLkDjvNFJ/TUcb+34SOGgOSSxdLbcZS+87ElI7xmy5+c771Lj
 FvUqjGoqg8vH756Zn7HjSuos1mWXH1zNi4W2wLqBykO9n3eeN8jQaj44taFPjCFHYJeJ
 ZR7QiwZGyh5kL2al3TVF16fQFEPsASlY16v1iLT8vpZ72bmFfHx7FKSaEQLLLF0q8oAP Tg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya3b6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 08:25:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3037oJpC033856;
        Tue, 3 Jan 2023 08:25:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbh4h7ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 08:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPw5ZBiV9g15OBVDcNAk8kSUpHYJHpbp1uYMliOrQf0f5rVgw1TSH/3AGm0B0E38MSeZK6MX3CrMC/beEVCaCihCHvhP12WnrL59gAsjD9uS6UqkuYglfkgRwmJjF0RaneOKoB7QkkwQlPKT4YGZvqHe7zZF3TewS04BVr1bmGOymzO/8KNE93+bOPmsGYPvnj1B0TU25xY2B1ZIKhBvFFLzmkX5wrb7uRRX8bRuqocU0v/2GFwsVu1kiWcx6flvk+KRdwVDjDtZ2uNe1AaQN9zApJwSlcQkOnOkC61PdbERDsaJEUAYA1a8AGW40CoBJ5EieqjGrEowxzTFipK/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVHCY8VEMJTKJ5jSblN5Bc1rDld0HFQlUj30zVFOqUI=;
 b=C52pLzh9Lpl+24IokVkH42FeL9ikeXj9asibwP2j3BbLG523hbBaMMb9OORFznneWHefUQoQhI9rxgT6fnGfhvsOj81iaYJ359T73gW4elcOtKgrpq17FbmX81T+kQg5lAKrvwCUIhbbKDPJjD3T+MAvGWLfjbbwUx0yS+VHzGprYr8yP/VngmXjfRAcFnIOA+f/JXZUVYJE9Iz7YOZ4bPrd/09KNmv5RLDOOoeV1a+1ZZhO7gM8OdgKW4InJlrSD1owqmaxK3w/sU4DvPGc38q44Vp02v0YnlpfmzFm1txw7ZX+O4m9+mlcs4GjTpx5hKACFpDUzEGreDgka20BFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVHCY8VEMJTKJ5jSblN5Bc1rDld0HFQlUj30zVFOqUI=;
 b=WZB/OrQYPI/HqyX03xFasFwL04ekMGbfsUmOF4Owxu6bSl56YCpyzjgJOSOT9GVDUReXYWme36Qi9rc3RckrkLLd2x/hKUr035aQV9b9agZgHYtbYvkPsdZRPX1qDkYgI/nxcyUNXzcG7iOnZG/YWY/Hp3RrqC/bBlXLVNe3+zY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5852.namprd10.prod.outlook.com (2603:10b6:303:19c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 08:24:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 08:24:57 +0000
Message-ID: <b0b2222e-137b-48b3-030b-2b2468e09eb5@oracle.com>
Date:   Tue, 3 Jan 2023 16:24:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: don't trigger BUG_ON() when repair happens with
 dev-replace
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <e6bd27828dfa486ff27e39db13b662e06d71ec74.1672534935.git.wqu@suse.com>
 <20230102112600.8869.409509F4@e16-tech.com>
 <8fcf8963-7077-21dd-2b87-976014533c7c@gmx.com>
 <20230102145424.GD11562@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230102145424.GD11562@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdec7cf-7843-4aad-cd74-08daed63ffb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/VDhwcyP520zpIFHNBU81nKEYsNn2RrTw2fAlVMqxvcfjRP5qVD7GXs74DcbGLdRSVBDuDvrbmKXLCUJgkBj4ysbYHP5/+f9LTI3Rnsr2Dlgqu6/4PVe+SDbvNMhAn8EJYzvTc9gjivJCiB6UMtXSZY1xXf3Po/CsGkugMHhER3A0rlfTqQbUbw4yys8ypRkDZTx+oRbVqZHwVLXKuOMHqxxOAc235SJnAHtiA1yUuW5nqrGNwBjAFqYpfkhJCwyYEktlu2nfjdsk33dYVyhy+oU4EAXcEdWVAZZj8G4okyN3cfjJgICnAVpkcNh3FIkUMtDmQi1Oy/r185/yi3OWdZR+MRjWgotUwr1Z2hJBj2E3/CkbM0Dyj/YauFkvgCuXuHCInZNQK3ria7ghhgLPeWKd/1+0tLqqra0bqW1Y1chAEzXExXiKHXiYrlhmP24PWu7IlLwL9JBNm7qAClSSvDbUqKN7lnSwX6QLAybERjVaeAXk4g2OrXSuQjyZ21HsQ8j22cT9r/c1vXSuNzyXdwBVDfuoAfTjC2FMltQBnhnDhmge4Tn/fI6A9eP+JLbx3m6m60Bz0Q0cCWrAqi9wjukhHNqKER23NnxKryJaGgl067O5JzodPU6PwtTIi/JOEdySW2E3+2J3mH/Ia6bL7FsYAskURG4OoO+lHBtLTglax+aeXdqzc4G9vJ/tFnqJnjiG6Jv0lMUNL8t09kJBCGz0tUWTru3MorvsU06paSeH9GFLv2qn4JSCNlSW5c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(31696002)(66946007)(66476007)(66556008)(86362001)(4326008)(8676002)(54906003)(6916009)(6506007)(36756003)(316002)(53546011)(6486002)(478600001)(38100700002)(2616005)(8936002)(44832011)(6666004)(41300700001)(5660300002)(186003)(83380400001)(6512007)(31686004)(26005)(2906002)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFIrSm0zUm8vS21adHB4eWZleUJuSFVHUDNXSExZdjlOL2p0TFUvaHR5WEg2?=
 =?utf-8?B?QVdsdFB5RVNKYnlwWlVMcm1ickZyT3lRR0t4SjFSbWYzellmOHFqVlpaa1Ji?=
 =?utf-8?B?NnZxdFpaZWxOYUVNM2ljR3NFUGEzNzYzVW0vVHU3d1dyVC9TV2NMNHhrb3dk?=
 =?utf-8?B?OU0rbzVZRk9UL1BZWWxNNm1vZjE2NFA5aTd6bWtuNmgvSjJxbWo0ZGhsVVlq?=
 =?utf-8?B?SjJpbnFSNkQyVERKR2FYbDJUMTVJa2s5ZHJkWDBzOVB3aWZ5Z0MyY0JUeXJo?=
 =?utf-8?B?TFJyMnBhVzN3ZmJaUmJ6MjlBZHI5S0NvRWhVR0ZuRzlsTVQ5SHFxM0JrVGZV?=
 =?utf-8?B?aW41UmdDUGFGMGZFcFh1dTNGRUx2VFNqMi9JcEFTdEFjcFlYSFV2c1JuL1Rq?=
 =?utf-8?B?ZjJVTW16MjdTcEdIL3JadlZHdUZJem9nTm50bnhoMkZ4S1ViR0h1SkFZcmIz?=
 =?utf-8?B?MStWTkl1VjFhL2ZVTTA2VjA1ZDFNdVRCUitHWjhNNktLZGdLTThrNWxxOXEz?=
 =?utf-8?B?eUNUekhuSFo4TjRwRWRRc2s0YkFZRUlHS1VMUzRiRWZzZS9jd0k3WTdOWFQ0?=
 =?utf-8?B?L1hRa21wM1BHNkdlcFZNN3p4Si9QbzNCNHo1Y1YxRWo2V1JTZC92SVdxcUdF?=
 =?utf-8?B?UWoxRmdmOUpaY21RMXFxdGxxemVLSHZ1YWtVaGw1a2hVSHpjNXBCR3h6T3BC?=
 =?utf-8?B?eTlCdEN1U2ZEdmk4UkZ6eHRYRlhpMlhMRVQ2THlIQmphL0REYVViQ2x0RFNn?=
 =?utf-8?B?SkRSd1FqT3hxaGNKeHZUK0FFV3UwMlVJU0xsZ3VRL0Nuck9jTzcxcGoyc1JE?=
 =?utf-8?B?QjlIektoWEprU25Vclg2YWt5MzY3NXZXaUpQaHI1dnFjR3pramJBQVdhMkFX?=
 =?utf-8?B?R2QyN0NxakE2ZGZtTEhiT3h5VTZvZHFsYmpEUnYwTFhWVGlPRlFPTitrQVJZ?=
 =?utf-8?B?NHdrcVJUYTVCa05JYlVWSTVOdjJyRTlVMUtlNlVBcnNiK2pDSlZ3ZCsrTkJo?=
 =?utf-8?B?U2psNHdjZHY0VS9ZRnVmVFo3U1ovUk9FR2VyS2NnZHdFbGtUMXRXaUk4ZlBT?=
 =?utf-8?B?QWJyYTdvanUzaDVUenYwVlhpQnErc0tmYU0vQzJZOU5UOFc1ZVFjSG9pSVh6?=
 =?utf-8?B?Vy9tSDBLZkRPS2QvdlNqbFE1VWNoRHNvbS9yeHFscVpSeEZ3dVQyWUVxWjEz?=
 =?utf-8?B?WTdOQ1lPc0FyYUZkWEF6UnF6NWFFQmpHckxHeHA1ajA5VFlCOXlVTDBtdnNk?=
 =?utf-8?B?VzhWeC9qYmVYVFhicGpMWEFPaXZQZ2Ywc3QvNEVxTFpUaEJkWk11WWd4OWNH?=
 =?utf-8?B?eUcveUliSjZNaHJWS3YvYysyQzJiR3U5dnJIUmtQUmN3dkp4YlgzeUFGaTBN?=
 =?utf-8?B?ekRQWXVuN24vczBiSHUyMEFPN0VEMEpIdHFvWDJMT01zV1VzOWM2UW0ySjVH?=
 =?utf-8?B?UXh1M2FOamhuNHpIN2d6UWwrbGZ6bnlCeEkxN1Zqa21ST0RkZlAyM25XZWwx?=
 =?utf-8?B?VUhUMGM1TVlmWHpDTVkyU0NlY0lnalVqa3JTSllyKzh3SUJiRUhwREJlSUo2?=
 =?utf-8?B?NUhWVytKdzg3OSs0YTBETm1NbG1FUld2WXpzNWN3Vlk2M1lqOGdDaGdZYjJL?=
 =?utf-8?B?QUlERDV5c1RINFN2WHp3Ky9pVk1sZ2lvdGcxZlcyVTgzTzZ2WXRMcVRCSzBv?=
 =?utf-8?B?d2JwNjlDWDFQdEhQd3FHa2VlLzdhZDh5MWhiZGg2YVljNVBlS0d4d0Jtc1Mx?=
 =?utf-8?B?clBmcGxjbEY3eStqWC9CdXEvMS9xU01Hdm50YUEydW9TLzhnS095WW05QVJz?=
 =?utf-8?B?d1VraDVObEdmQTk4M0VUSGVEY0NUVkNxMWROMUhERzNiaTRQbG1ZSlhyYmt0?=
 =?utf-8?B?VDVpNHdpRUJkMnVkcS9NRUJqMWk5dDhmbHlvVHpaRysrQ0dwL3dJeEdzbnpW?=
 =?utf-8?B?d0FIV0c1R3M1dW1PNTYzQmhQR2pSUFRzamg1VzlNRFBIdVdQTlNXTVdpc1p3?=
 =?utf-8?B?VUxLMGRhVDl0TzlUT0JlY2tRMzJWNXFnY0RrOVNZVlBlcVJhQUFCbVo5azZH?=
 =?utf-8?B?d2R1UnQraWg4T0x4a3BjZG9zQmdBOU91d0l3NG1JeEdsTUJ5bjJKa2hDZlpI?=
 =?utf-8?B?Y2FObWJvaDVuemVScTVIUjE2Qlg2c0l3S1lXQXZoMFVDLzRGcSs2dnRlcGRn?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P2c6cpoJk35ZyqWaXJ/4o2dLZ69fBeUN5pKfZHl+bwrji3df4RyvW6adps0BzcL6yvQ89stB5hu6CjYniufXbZflKMLqOi4IXzgeOFmvNf/AgAnIyWfjeyUEeu8mE9V6RvkiA0XNpVF4pjuV5lzzS1weDFmaFSHK9nyulhSEWfxNXFCH1qLx4ijJlugSylMRx20L6zRlfV2+IcsAdPgvdTStAR8aXPU6llwYwp0ZNAQtHTJsBclfHSwumONgNsR95KHXit7H5j/ZkA/7FtQrAdr6zPE32TGlPyzBPtvzsG1m30m8HrdQJggx9HkhkoSix4irHSh0q3OBWoDKQ0PGMI1tdWvCHWxcDWoEfbt/LUisaOig/FFwLrFaQAs3pX24G4+eAMPDrbu/7Ly/578rRSSbI6Z6vr8RTdKKekrntHaCT+mfM10LrUEELyZKgxXAWbxTROOn3TY1Vw7FxtLAojZp75J9JqShNN+TlDQgKZbpG63fYzI2sU0B8Pp4xJVMRneUHCKDvG6APO/Ga7KeupdMK0k1mzyvtXQeCGIEfFUtGeNu8OSER3ZZuwk9zqAbLlkYQNLkfVaoIcVm1rLmK71RjcQygXEDP9Ng4REFXJFOKk4pfUS7L2uC+uEqoOD1AHeUjtExoFBWt/wRheQPYpkttJqJly38F3L2nm/8TEvwWytYduk6LFO5HT8EDjtmzKW/3UW2yQSZQq2UQcrLB40hHX4LJlhptnKyhBFoRuPNAkj0lwdZv38qUCwhyieh+w1TVR72MfU/PXeV/Ib9sdiOrmAjZiztbpwTIwA0AjC/4drwgbKp66UHJ9Ja2Q82eyghGubCJ1ItDDChUxVfIzseMkzeMp+h+1bKa4tGh6g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdec7cf-7843-4aad-cd74-08daed63ffb4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 08:24:57.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhBu62YEiyoKwRRD3R059f4vqhUaVeRl3z3O3gXOCjEM8E2EH5vlsqOCfwCSLaMGG23lubuesy98QUuijXAikg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030074
X-Proofpoint-ORIG-GUID: 54jUZuCShSVQwTnKw-6pPs6avL1FA22E
X-Proofpoint-GUID: 54jUZuCShSVQwTnKw-6pPs6avL1FA22E
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/2/23 22:54, David Sterba wrote:
> On Mon, Jan 02, 2023 at 12:08:01PM +0800, Qu Wenruo wrote:
>> On 2023/1/2 11:26, Wang Yugui wrote:
>>>> [BUG]
>>>> There is a bug report that a BUG_ON() in btrfs_repair_io_failure()
>>>> (originally repair_io_failure() in v6.0 kernel) got triggered when
>>>> replacing a unreliable disk:
>>>
>>> It seems a good test case that we could add to fstests.
>>>
>>> Is there any reproducer already?
>>> corrence of scrub and dev-replace ? still fail to reproduce it here.
>>
>> It's not that simple, and you need to understand the workflow before
>> crafting a script.
>>
>> It needs several things to happen at the same time:
>>
>> - The corruption happens at the last mirror.
>>     This can be done manually, but I doubt if it's reliable for a test
>>     case.
>>
>>     As the new data chunks can easily switch their devices:
>>
>>     	item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15751
>> itemsize 112
>> 		length 1073741824 owner 2 stripe_len 65536 type DATA|RAID1
>> 		io_align 65536 io_width 65536 sector_size 4096
>> 		num_stripes 2 sub_stripes 1
>> 			stripe 0 devid 1 offset 298844160
>> 			dev_uuid b31e1749-24d3-41f0-89fb-5d07630938c7
>> 			stripe 1 devid 2 offset 277872640
>> 			dev_uuid 29c2b4a0-4417-4a3c-b312-c0ac226d35cf
>> 	item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 1372585984) itemoff 15639
>> itemsize 112
>> 		length 1073741824 owner 2 stripe_len 65536 type DATA|RAID1
>> 		io_align 65536 io_width 65536 sector_size 4096
>> 		num_stripes 2 sub_stripes 1
>> 			stripe 0 devid 2 offset 1351614464
>> 			dev_uuid 29c2b4a0-4417-4a3c-b312-c0ac226d35cf
>> 			stripe 1 devid 1 offset 1372585984
>> 			dev_uuid b31e1749-24d3-41f0-89fb-5d07630938c7
>>
>>
>> - The corrupted device still needs to be recognized
>>
>> - Dev-replace must be running, and has not yet reach the corrupted
>>     mirror
>>
>> - A read on that corrupted mirror happened
>>
>> The last two conditions are already very hard to trigger.
>>
>>>
>>> local reproducer:
>>> dev1=/dev/sdb2
>>> dev2=/dev/sdb3
>>> dev3=/dev/sdb4
>>>
>>> mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2
>>> mount $dev1 /mnt/scratch/
>>> dd if=/dev/urandom bs=1M count=2K of=/mnt/scratch/r.txt
>>
>> This would create extra data stripes, but it won't ensure that devid 1
>> is going to mirror 2.
>>
>> It may or may not depending on the chunk layout, and I'd say it's a
>> little random.
> 
> Right it's hard to reproduce and not possible to be done reliably but
> could we do a series of the case with different timeouts or sleeps
> in between? This could catch some cases, we have various testing setups
> so I think it would pop up eventually. Once a problem like this is hit
> it's not hard to find the reason and fix.


I faced a similar problem. I used the read policy type 'devid' that can 
read from the specified device. I also sent a patch to allocate the 
chunks in orders other than free space, such as 'devid'. These two 
patches should be in the ML and may help with this issue.

Thanks, Anand



