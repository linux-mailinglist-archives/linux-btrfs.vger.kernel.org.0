Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB6D73B231
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 09:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjFWH75 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jun 2023 03:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjFWH7z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 03:59:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA0A1BCC
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 00:59:54 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N6aO3f029179
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YkdHGW5ne5U5etBpFbpU1nBl0T4qYt01IGB/gOFysr4=;
 b=VcR7A7G1wj1A+HZD4rkjGvbjDByAC73Yd4Hvkt8ILoCwXGeMaHEJclIx0sImfBuxtpj/
 tea4Dejfz8y4RwN1GMK/m5G01vQYUBZkAMXm6SsFCeaGnsgY7ZlQZx1MfC31fwDhUz1Q
 KhKKpsFclk8bd8txSeIPG1Lk/x0VacVBNWww4Nn5vuKa464FjZEihLKNtyU6ZX20fC+/
 t0FWCey9psKaxDufWsq0szWVXuCAPIXQpg2AfWAVdhicgFglH83+aGffrm1yNPWV5peY
 M19mOmlMzHcUJCR7JsjfM3RkGq3AWjmUG4rtFbbPBHYOfXeexyT0foHdbxD5LPSMfabS 5w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbugss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35N79GvQ028897
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939epkwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PihNdLyoH1Z+7dHAZ4qRjNJE/KLixbnWK2EoLnc0Cywvn/uzL+o4w3iBZjYjo5lLZyOXSLb1K/eGHzZ8fXZm0mCCKqzOyMJUxD9Byv77xV5vXVx79+M1b44THl8ZvMl7mppCLPXXjNLqpsv8AFX2Q+JGD9nSPAonRwwIcwVXLUhxQmpbe5FHRVVfXpZK7KwBYJythuW0ZiANCwL6CQsm5t/rw5CxdfKhUITacLRkwHt53UUJNXxl21YKBET0NyMHtUbwRLlUJNs8vzIluG2AWx8QJwenWhIUPNg28XAyhnEU+kMmgDuFZE/UmsN/MX9zFqSIJpOrjvDp9glCju4krA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkdHGW5ne5U5etBpFbpU1nBl0T4qYt01IGB/gOFysr4=;
 b=ewU0Ghs8RU/bYUg+DvWUIezn3KevhPRA01nOlw2ZoQIUCf/3yX8d2g3KQoOrrfo5D9ZCTZtJcAP/ZBIkeT23D128Y5o0Krh4a0/a2gVSUE3c8iJ7aHYeI+wkwr3bAu6N0MAlwLqbouxF2gBFCjff/5/raMwmJy26WVJckU6R6hZEMgIGvAwEAUHs9M2LVXOCXItPuVXKsZqjHmHJ6nPAAiEevdd60USIvboB33GQSlJsj/0JpaLy2QZ0JpfxKWUus+TNsCOAL7OXW7TO2TiQOvBYa6wA0qqXcZCp3wnzkGI8HcteetVLmerLGALlNDuJsheZHM+ijdGO0duXkoIrQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkdHGW5ne5U5etBpFbpU1nBl0T4qYt01IGB/gOFysr4=;
 b=Uy75ITvsoFAdsBTvjxZ06/SQyQhbixtVIU4k/AXIBAZ/7+7zv5MeXLLAmjndRPkg5fRMvuctGePZbzdrs/5I0KOUzSVTtDGRATjqrGVE5ku+FJR1Tjl7ZnfgFn+8eMWjhhxr92tWq5BmO/JtCszQX6t0c9HCDOIcYW8ObPZsi0U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6523.namprd10.prod.outlook.com (2603:10b6:806:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Fri, 23 Jun
 2023 07:59:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:59:51 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs-progs: tests/fsstress.c: move do_fallocate under HAVE_LINUX_FALLOC_H
Date:   Fri, 23 Jun 2023 15:59:01 +0800
Message-Id: <7ad5a1e75bb3008bb3fae67dba7ec9318301e418.1687485959.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687485959.git.anand.jain@oracle.com>
References: <cover.1687485959.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d388f6-b226-452a-d70f-08db73bfd267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNtHwI9ej2C7JZM7/WzqFFkGWYzcX3XzTO183o+kEI7fEoFhz7l6ye1s1GtGTo6wjDAQ0EfHLAUS5qI5FBPUSpIQ//g2gHfzaMZLIwjwPA1uYkDCCB7jDunlxiXTng9TVGdVIBy+vG0EMZY17OH0wFBSNd2Mzt2E5yMnVp3ea4ILYz5956iZ/X0YPBiVr3JpuERw20szatwwM3hthnJewNlfXy7lML2V1Mh5yZPQWmR2sXZ/knxRjXY3fCh/fAhbz061b+/IFbpnUpdAAutWZOIb9d4iWCaUqxYglehIuL+d9Q2GkFPTlUmHNBRJP2HPBMrocbsH0R4LiKy3Pi9I7Mz4511uKEfdoOAksj834duz0pWYcboPpZqiyjvqz5XddsQAzLq0FMqoBsKO9+d6spuT3YLEBUSHRWkF8UOqNkfjnbzN0+B8OBmrczuPrjPof1QfJAMOBWLUl5ntOCQd924DbpwFYirmyeD0Lcy7SESe4MqwsfiIu6QQM/+33O7MwMTXa3MrHcNx6v6n3wFCLDOlkcRk/AnvB54lQHk6d2nb/avh58AuIrHoAd4B6Cns
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(2906002)(44832011)(8676002)(5660300002)(8936002)(36756003)(41300700001)(86362001)(6666004)(6486002)(478600001)(83380400001)(186003)(2616005)(6512007)(26005)(6506007)(316002)(38100700002)(6916009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3pCYnVqWERvb1lzcTF6SEZKa2tCWEN4cUtsdENqSFVCUHg2NnRaZVZmRWJ3?=
 =?utf-8?B?cjFvUGY2V0tYRnlQa0xWcWt6alByclZ3SlIvY0dCVm9XVm94bXNHZ0xuYWc3?=
 =?utf-8?B?eVNlMXpXY2JxdnhwZG1FWkI4S09PTFVFaG1EaVVkQm9Ea2ZVT0t5NVZCTnh0?=
 =?utf-8?B?cmc2WHJUc25DcGJKR2JST1Fqd2k4M0dCN2o1M0JKMDNBQUljVXlnVUJ2c1pP?=
 =?utf-8?B?Ym04KzhEWDZ4R1pSQVhzQThsalY2T2RaQjA1SWNzRnlLdEgybGhGRzlhcnd5?=
 =?utf-8?B?YnFTUElvSjRJclpYMk1GSlZVNDVZZlNJNGtHUmpha2JMY1FvTTVOTTVsVDUr?=
 =?utf-8?B?M0tPOXgzRzcxemdyd2F2RFRUMlhkd1ZxbDhpRmhqM1BmK2ZPbW9wdDhSR29P?=
 =?utf-8?B?UFdYTzI1djVoRHUvR3ZpekxteWpOMEZZQjI0ZXFjT0ViOW1yU0lFcjhGZU55?=
 =?utf-8?B?ZFE5YVZ0NE83dDVEdDQ1djA1SDVQV1UwSnhUZkVNL0NWakV3bktFb1hTZS9p?=
 =?utf-8?B?OC9OZDlIbEt2M1RTYTdEY3pnRVUra2xTN1dqcGNoSnU5VHExbm1Cem5QTGhH?=
 =?utf-8?B?K0ZqcE44N2pGYXp4WHNpbEVicDNraS9vb0VxTVkydHZVN3NxT1lCWm9Ya0JU?=
 =?utf-8?B?dDRiS0VsVFZucFVEaEovaXJ2Ri96eVpSNmJ2cjBjN3ExR1hEUFhKZ2VsUFdo?=
 =?utf-8?B?MWZteFVhdVV1WGtaMkw4OEdENTQ2Vk12WmZ6VDZzRnJlYktoOUhCWFBYZDVE?=
 =?utf-8?B?bnFseUlWdTZXbjdMUmN5dnV1SWI4V0hGNEhFMDJMQ1pPM2o0ZlZBSGZrR0Z4?=
 =?utf-8?B?NUNFOVJtR0RkNjV4ZGd3THg4OFFNNm94UGpLSkFMaTVGcElwYkhNZWpNYzF0?=
 =?utf-8?B?ZStsbS9ibERXWGlRMitxY3FzcWxaYUpkZFVyNmRVMTc0SzVBTUZWeW5ma1dB?=
 =?utf-8?B?OUJzLzlESDh6Sm9paEtEVExlUGhKNU5KL1RmSFgvZVd6WitSRXlUS0NJOFJt?=
 =?utf-8?B?M3RKakFQZ1ZvbkJaQlhZMHhDMGxzQnF6T3RtR2FqRElCN0VGenVadVFXYXJy?=
 =?utf-8?B?RjJFL3Z2M3UvaEVyZ3daUHNNdFpGL2E3eUVjeGY1QWNPTGMzN3hwS2FGSENx?=
 =?utf-8?B?SXl1a3NSdDQxaGVPalJOb2xJakhyalZvblRYQzRJM1A2Z3VpekRXbEpBSUdi?=
 =?utf-8?B?b3FBQnFZSnlsSXNlV01rR09UV2xyUkY5bEFSOGkzMVlVNitpZ0pzUjJTZTNC?=
 =?utf-8?B?alJBcldCZTRNUWFzcDJCZGxyN04xSW8zT1lnYTlVdGRNV0M1eTl1MGlRbDNW?=
 =?utf-8?B?V2t3TDNoUzl2c1I4QmwyMGFhUVY0OGJCMzgvMmgrQ3hFWlAyVjNtYWNXQytm?=
 =?utf-8?B?Y1RPRE42SEc3RTBURzZhNDMrOTg4VDl2N3JqRGlacmtBM1VIRjdLRm1xaSt1?=
 =?utf-8?B?aU04ckxpYmUvdVdpcDVQbTNwdjc4dkxMQ25hOEdNS0s2T2p1OXpQS0krQ1RY?=
 =?utf-8?B?Syt1ZXV3RmJIa2s5U0FDUk5RTHdMNE0rUGRqcVcyYXA2VC9MMUhWc3p3Y2pP?=
 =?utf-8?B?RlBWbTdNNTIvUlA0VUQ1UExRbjRIa1UwM1g3VnNTWkJiOGF5bnU2dzA3VEsv?=
 =?utf-8?B?eWo4TUVYMW9vL05DL3FFN3VNL09INEo5R2JOUnA2VFZPdWlIQzVPTm8xUWNy?=
 =?utf-8?B?YmMvcUVCRFU4dmJJdmsxOEVjWWdkdGJaYjA3dHBwMjcwaVpwbWlpdEdFcVpR?=
 =?utf-8?B?WDNpUU5LMnZRenUwZjhTVGZ1dGV3dUIvbUxKdVcxdy90M09QcU4ydUp0WXBm?=
 =?utf-8?B?KzR4UXhBOUROeWZKai8xK09nczh3bGZHQkF3dllQcUFUV1orM0dhb1UrRVJk?=
 =?utf-8?B?Ums4c2VRRStQcGhJTFh2QklpdlNzaEdPbXlqN0VTSkhQSkpYTUxWVWxKdE1Z?=
 =?utf-8?B?KytJajBzWEFtTW83c3RDam9uSmVCZHREaS9oY0JMWEpVZm8zakdpVW9Vcy9y?=
 =?utf-8?B?SnJhU3FYQ3pBQ1hYZTBPT0crbUFneWYwZ2NKL0s4bTVteEZSMUdSWG5HRHpv?=
 =?utf-8?B?cWdRUGVabE5ycHJvSGdKd0VBKy9nZkRoWXdvVTRHZmNiSTNvSTNwaGJhcEZo?=
 =?utf-8?Q?GnSxhahyQjq85WdYNX70RlEqL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mbZlhgu/FiE7oshXX7/pZARG8HbTJzH86cPNqtOuEwNhloiaRY8yk5nPpp5hK2yLP1VgeT2e8vT/3ms+Jbjy20rbXYWk1fArgmndk175TqHy0bU2m0KsVYintE1wZNHGlggZG9FBl9Gkz3qJiW90qbudpxlufasZgb6UIBnFKmESDDYyBdv3SL2WQ6cQ++tZCIR7/9NhLgmHH30ZHkbNOlEPV8iOy56AyFVhz6fHDNXccay3cuN989p4EWhKd5/Hq6QpOHGXg/o8btlRyLYGTFESQqsVGSi6cstpsDI3yDXMrDQDRUSt67e3zKbhvSsJEpZ2IsoqhCYf1cjV6Jb3hQppHbpbbMdPNN4VEe26I3SnoHaBU/+SWYyKwqFWolCj0erZbIze5JYWuG5cbHhOkW5LmT8klpaLT2VqY0rKaPxW/ko9TK/R3jw8irQXujvvAre6ymsVPZdJz8nOdPnjy1yQBizgxxEnJUvV2T2xBMGC4x1jhunrwlXEr/677SlwHjk6w/rdiNLHovs1nG8nPebhyNgBc07Btz13ysNyUdjzAALHXBr0J5UlbDzCf8jA48n843dyc//62aigwsWNIV/jhbDPynXTB9VTx8syYjSR4SfXT4L6CsOf98tO/6WBkjHMNqFLD91GXIHbXSU46cYmtGIfj2VF+ZGbNyUMAvTwI4Kv2u7xmRV0jkLTkubuvxW/GBWxvjt0WfEEdPV/18WADKdte5+6a2Tdw3ZqIRmkxen8avS3cOu5+vv9WZwhw62XpX614+jhjKKY8QEwlg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d388f6-b226-452a-d70f-08db73bfd267
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:59:51.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BHSyA/Su5ODm5iF0dsgd4ng8Am8F5NJAZWkgbDOQX3fYb8SCnbaaFpdrO6nro/BYhjvKG+1EP1ga/ZLH04GuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230071
X-Proofpoint-ORIG-GUID: 4i4vTgw8J7giyBYLFFUE5Go8dlIEZOHK
X-Proofpoint-GUID: 4i4vTgw8J7giyBYLFFUE5Go8dlIEZOHK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move the entire 'do_fallocate' function under the 'HAVE_LINUX_FALLOC_H'
define and fix the following warnings. This function is called only when
'HAVE_LINUX_FALLOC_H' is defined.

tests/fsstress.c:3814:1: warning: ‘do_fallocate’ defined but not used [-Wunused-function]
 3814 | do_fallocate(opnum_t opno, long r, int mode)

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/fsstress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/fsstress.c b/tests/fsstress.c
index 692d7cfacaf4..5fd347ccf1d4 100644
--- a/tests/fsstress.c
+++ b/tests/fsstress.c
@@ -3810,10 +3810,10 @@ struct print_flags falloc_flags [] = {
 	({translate_flags(mode, "|", falloc_flags);})
 #endif
 
+#ifdef HAVE_LINUX_FALLOC_H
 static void
 do_fallocate(opnum_t opno, long r, int mode)
 {
-#ifdef HAVE_LINUX_FALLOC_H
 	int		e;
 	pathname_t	f;
 	int		fd;
@@ -3870,8 +3870,8 @@ do_fallocate(opnum_t opno, long r, int mode)
 		       f.path, st, (long long)off, (long long)len, e);
 	free_pathname(&f);
 	close(fd);
-#endif
 }
+#endif
 
 void
 fallocate_f(opnum_t opno, long r)
-- 
2.39.2

