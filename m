Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492966F4032
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 11:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjEBJbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjEBJbH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 05:31:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DD949FD
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 02:31:01 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3429Mwx6015497;
        Tue, 2 May 2023 09:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Qbvgujz4Hs96PsBjVq4FM68VqFYboKXURtsxNZYvsP4=;
 b=a6Lb89OWyOGKXkLTmyJQLDTnUgKAuI03USBsqpvcMNNQvmIDTr96I3qZLSMVv7kF/m29
 iz3DN4Oiws9AgCfz/b5qABh+BYKpEsjNg67/D0ObqA8jixiP28bqF+F9jvi+pTIViiRk
 Hk2zWgSaEzWMlMSV5vhZWCPS/j/9N6PLi+gNhz9TAOjJuog/yA/nPbOKa+CzFKE9VibL
 5PgjgMHT2nn3XGFfgO3Dw1Y5TV39Z9pvrxotWQgbKW7R5L6BCAPup7ssaYDXnfJ12w/V
 TCSBPRswJhvZ6BSLnk5+slscLvMUVR+qc5Dr44Y+fZekiFZD9FnHpuBInbMZu9/l70g8 aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9cv9yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 09:30:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3428gBjw027515;
        Tue, 2 May 2023 09:30:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spbr7te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 09:30:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+ysaHub/tBGU5lpsr5wNP1izUUbEtCIID7Snb7qkh3hC7PchBw6Q8eyguTirhHKGhzmxrhZtVhXLMgqtSUVehZFaC0anivQRK0XMMIRZLjc6tdA0iYD6R8FGNKbnNjf/YmDYbfCjP0EkrHgvwfJ6kUdL0dJjOmYFBvHK6I07RsintG4XQ2xiQ2BFfEpvDJ9t5jr5ckts8UTH1B6yYvHxm64Y9+DkcZF5nPGCnpkLHgbbGnWLXfchouIrNF/alVji+oG4HwfOWhftJgLlWrB7C90KiwHzpOVVltdDThfohJ8empQvedQk2Zz3PysJ99uZMzWrNGoudSZ1XW34B9T9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qbvgujz4Hs96PsBjVq4FM68VqFYboKXURtsxNZYvsP4=;
 b=NK/LGm0K5zU0DWZHUatnGbsrsgJ1czDOv38CxWb/x7hFwOrFu8fdvrez5VE5zV7YzQ8A1DpWSkPx6FxklKgizspoVOhC12lNDKplJb7r7LIXT0JahLdFWkGe1mlmeReFitGMzbsgqnyhumVV8m3lgkxI6ZHdGjiF6/MSrQ8NTdvbq48EAj2993vBACcn5CqjJ5zaeGomgQtQP7O4k+cFL/3nSZBdEjrE1tBgHj3rT/Edx06wko5GUa09xyXoiMNeM/h60NPn4GuY4LHsTjvJTqncc5k1VfVAWZGG42KEg8D5Rl7lk2z6aL7fwVIgRlqkuyVT6opKy4WMXETPtt+tog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qbvgujz4Hs96PsBjVq4FM68VqFYboKXURtsxNZYvsP4=;
 b=WhcE6XCkkyGGyuMkY9id4ZheIelmypZXQMNG1qLx+u0QwYfBZVDjPA9/ROFipJFX7YJUSed48UoV3Bv1NDEflu/naaaqq3hm4JsZzmheKO8tMxdHiu7ZlF1Ks5r8TzNRVmZQBXeFgX8IkNQSi8ZFNC9SF63tk3KzQQQUIboG2DA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6132.namprd10.prod.outlook.com (2603:10b6:510:1f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 09:30:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 09:30:56 +0000
Message-ID: <300315d5-9970-5a2c-6bcc-0ab0fbf552a4@oracle.com>
Date:   Tue, 2 May 2023 17:30:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs-progs: enable -Wmissing-prototypes for debug builds
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <8cf9b5f14a52067bec9c4bb9f2d2c13821e0d7b6.1682990969.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <8cf9b5f14a52067bec9c4bb9f2d2c13821e0d7b6.1682990969.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c6d1f0-a395-469e-3653-08db4aefee21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzfn2Wt1l4Jyr58Dw0sB9DqrOA8R28GPkb4lkNDX/v3fVy14f68G2cn0OYNeN0Dfqm2IVXLFehmD1k1pyj4JQ4ZAAePyYSSOQWb05awKP95NwozDmJYrOpELC/jsFDiBUFYmeKoqyYWXBtRAc8NZpj9+yV/4cztXEjmD4WtoxdyJ0XKTaEKTAcJDIdvX0a0I0WPGVjHUkVt5VWxUQeUIRM0R14ToxLf34jMW0/GHkUsDDLXCM5k65RTVWA2ckynbYPfMNv9zNw2FCsQVV1CYJupKpEN70FJvLIoKhkgS8sB2L9F540WNK/YUh29GrDaahptLo75kPwJvYf3OqNuAssysW3IMoo6PZp0aEXbML+MOud8btFDa/STxoYeLNoAPoQ1j7RkNx5i+g6nG6wO7OIH9puUSwJlN3CNTVFjDiGPPAqYxbaqIJDiWvKXmOTJGAE/qR+YMpsasHq5nU+gRnJzev2ovRKq1CGKPEnFF3qLpESwBziTjUwy5db/A1F5jpvzmxULhwjDaZLln0WuBiihcExKZo6EYf5RzCaX4ycIS5WMHCyK2oLWUgqYUXefP3bKqBDzr+MNeEqKA/EQLqbq1oeGKu5xXRSX+cWMmU7Bj/jtDgmreqtumZiuh9sq29+T+Y4SBk99B1Nb6/DicCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(53546011)(478600001)(83380400001)(6666004)(6486002)(86362001)(31696002)(31686004)(2906002)(66476007)(66946007)(66556008)(36756003)(2616005)(5660300002)(186003)(8676002)(8936002)(316002)(41300700001)(6506007)(6512007)(44832011)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cys3Y0M3VVN1QVd5UDZqbEF1UEdscjI4OS9sOHR2NkxSMXl2aE5YMUxPMUoz?=
 =?utf-8?B?c2ZhWXNjZEgvM3hYZHhWMS8zWW5ObzRHWkZjaVJNcjI1YnpKMVV5RDd1N1JG?=
 =?utf-8?B?SHpCZDFZUDFQWW9SS1dkTzNEWTdUSk0rYVJwV2JsdzhuWVBlZnpuNGh1R0ZM?=
 =?utf-8?B?OUdQZ0F5VFNEUi85ckw5OW8rMDJ5S1VSVFBhaEhNWXhCcGZoVjFMWHdWSlJq?=
 =?utf-8?B?RHNXblZwZkRYeHFRcTZFajFrb0RtcVM4eDM1RlRScmJoNGFZdU5YdkFZQSt4?=
 =?utf-8?B?L3Q0aEs1VlRKOEpRd0hOcEhuZUZkay9EYXN4S1ZuSFQzK2JCTjlscDNyclJ3?=
 =?utf-8?B?cTdERzJVelhLUUVkYklnS1ZJM2FUa2RFaGQ4QytsY2ludkNEU3hXSzhTZW52?=
 =?utf-8?B?eE9jNEVsY3BpakZyelVyWFFTb2s5M0FadmhIK1hqdWNrdW1tTlBlMTcvRVdp?=
 =?utf-8?B?endyb09ORnBBY0FITThNYjE1NUV2ejVQOFk3Wmk2VmtXUngycVIydm9qVG5E?=
 =?utf-8?B?a0JGRWR4WFZTUWJzRHdOL2x5d2ZWRms3djhJV2FsSExRWmhETkxhM2lhUGtY?=
 =?utf-8?B?aVBXWFFOcC83Ym9adTZxL2R6TWJ4aUlMNHRIS0UyQVNJWlU4TzUwM0FWaGoy?=
 =?utf-8?B?TXlkdmtObUNCRFJJTUZpWm0ydFBDWm14YUQzRnFCazE5RmdCRFRjdU9jM0k5?=
 =?utf-8?B?TXc1OHVmbGYrZ25RcHVzUDdCSVhyMHUxc1hRcTZNT1FONUFzQTRYS2xLWm1G?=
 =?utf-8?B?SFdXZU94MlBwZFlMV1RNSWxRTkxyc0liY2trZXc2SkJrRW41OTh6STNiVjVP?=
 =?utf-8?B?aW5yUGZOYTJVdEI3cVg1MlJmZ3ltLzdEaUNNcmVhWFdWdGNqN0lTVzdVQzlT?=
 =?utf-8?B?SUppL3lkenlydGVoYndNWXJKNWlsNW9YVjRWRUgzVC9ZNUdMNGc2QUgyMmNO?=
 =?utf-8?B?RnpsSVhzcDdmNlJxK3ZhSWpGcE0wM2tWck52YUlweVdYQUc1bjVOOCtlSE12?=
 =?utf-8?B?R0dOWG5pWDdxL1NYUVFzaERIbHpNcXpaQ1lvbGZQUUJaeXcraCtiWURUNk53?=
 =?utf-8?B?cEY0aTBVYk45RnQvcURLL2U1OTI3b0hpOGpZekYzQ1EyK2lXcmI0aEEwRU04?=
 =?utf-8?B?cWM1SHltMlpWK1BoMGIzNm9QbEVDODRtZ3V0VUdVVVlCcUp3WTJ2V0d5VHZp?=
 =?utf-8?B?N0FRUWhjQWRpNTV0ODdKcWlHbmxvSDRmY3JhWXF6MTdqT0FOT1FLYkwvSVV3?=
 =?utf-8?B?c0lZcGlLSDRtUldsUXFBSjRaa1grTFdzQ0tOTUx0R0doM2JlV2tkcGpFNk1H?=
 =?utf-8?B?bFBaa1lReXM1ZXRxZHFLYTgzcmFpcjBsKzJMZjJrdWtSMU1TQWlabnhwSnBV?=
 =?utf-8?B?by9jazF3ZDBxSVUrM09nUWpWeXVjaTVpZjFFV01iK1BFUFRQdmhIb0tpaC9p?=
 =?utf-8?B?MlkveTFRMkgzVC9sZTVlbXhCdnJ5VUlYTWs5OElSa0s2ZkEwcXliUitKL1FR?=
 =?utf-8?B?YUk1SC9jMGMvZmpiWTVwY0o3bExpLzV1M240dlB0cWRXUWp2RkNLRHE1aUVB?=
 =?utf-8?B?RVVCQllYRVFvZm9RRFRlbHlSZDNtaTBpN3F0OUU3TndKME9ZMkFEVVRKUG9Y?=
 =?utf-8?B?K1MxN0JyQUE0UE4vQnJrNUw5UDdRRmVqVGdYREZkamJxWlBKdDRwS3JUMCt6?=
 =?utf-8?B?OEVVdXdtOXdsZ0Jya1VVcXNTU2dxbUdHTktSTWdRYzM3elllcmxOVjE4d2Z3?=
 =?utf-8?B?UnFxeXhnZmppQTNlR21qY0xMdEtJRk5XTE93UG4wU3Z1Wmd2YzJmbWRUczJx?=
 =?utf-8?B?dnhINWV2bTArZHZUemw2S0ptM0U4c0NJQWorNnB0dzJCWkhtSThxbUVPYjV3?=
 =?utf-8?B?V2hzQ0xadkNSWFhxWHBjbXd6R0F0NEJNdDNqMHhSYkc2M21iTVFmZEE5anBL?=
 =?utf-8?B?KzliUTcxdk5rdXFUM3lyaWlSeFNrN3hkeDErZ0tzMmVPRkFaR1paUHkxWEZj?=
 =?utf-8?B?bGJtRnVVS3diUDJlNzdFUmdBcUFjdHQ3aHZFanFIcU9FMWk1U2xva2VCdTNm?=
 =?utf-8?B?dDV5Q3J1Z3dJN0JaVWpCdVplUVZic25ZbldhWUlVT1VsWUF0WXZDZVF4NFIr?=
 =?utf-8?Q?mzv6t/AJ8kfoewXHn0plklDc7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: saOql39Ze4WLI6HVk2J5krQXfRSDQoTEYXVQBtUVIyHxj2F/C1duFoD14V7VaYsq0jSbvZwY85aRegYKyzAnv+wyQCT7EZTPSkgTP3MmXWxjlrMp6Nncc9gbX3oQr0ZCbUk7pOlEXxe2Rp5lWcSNolt5lEd2En3FGEyCaf7VXKFYkB01ycWD+IXZla9f0DB7Mh26xbqQ2NOkfdwAf++QfFkVXM5mQS8tTKAWqUflVnKvq0pe+wxIoFDX1uhC0Rht4598q71sVERWLyWbIfr3ZoTMs2TOjsL+aACHslWppL+4bkdpmv/emy7ZT+UQNZ3xWOGNQ+LJ4RPIEZ0iaqgN8HhFI90mnFJXVzvf+6Kn5NHFALd/S3SRoLYcCeud6r9S5TAuvQyQKP3B52xoxwykvNJ2F7oEURoaY/GMwX2sZ/lcD1kRITTTf+8voZmW7pwv3tKF+pnTxVJvZ1DSHUm+4orOmoaneGJo7vKo3INpkmhI/YOvWNiIH9CmXl5NpFWbA9q9Dye2Ia0cNF8mBT1Vgv4Xifk1qblhuO2uNJelPbn7S3g2Ojx8zq4WInCkX/pdlNg4vf/BfgDVFBIjyr1bZoUtxc+CAujGEGzsH1pSLcx+n3GqsPL7ocL+tzr4jdHeHqGfP0sEA3FPHDvfgoelpX1eIJ50SVFf0pl3YsaduAx6w5PsWUP89vwK396Kv1Sd/VXbk6UjrYRmxAiPeLtssNJPMB9LyKZWSh0waGHaKPAmSWHF6Q9rF4TMSPXB7z5OCW5l/bpTfqm+fct9VHDEoxnGfHj1N1MAz4kz0TtZL8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c6d1f0-a395-469e-3653-08db4aefee21
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 09:30:56.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIM5FcPgQz1KDk2X8oI7nAB5Q/ZAIoOSNAtmLWZUR8taxlTLCbZLnQM9JowGeeEFrREB6LY/dSF+iHhD6ZMQKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_05,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020082
X-Proofpoint-GUID: lBIhwAfG8YFJFi6OAoV8VVDKUiIB7BTV
X-Proofpoint-ORIG-GUID: lBIhwAfG8YFJFi6OAoV8VVDKUiIB7BTV
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/05/2023 09:29, Qu Wenruo wrote:
> During development I'm a little surpirsed we don't have
> -Wmissing-prototypes enabled even for debug builds.
> 
> Thus quite some obvious problems are not exposed.
> 
> This patch would fix these all.
> 
> Some are questionable, mostly from crypto:
> 
> - Add blake2 hardware optimized definitions
> - Add sha hardware optimized definitions
>    I have added such definitions unconditionally. They should still be
>    safe on platforms without such optimization.
> 
> Others are pure safe fixes:
> 
> - Unexport print_path_column()
> - Unexport parse_reflink_range()
> - Unexport btrfs_list_setup_print_column()
> - Unexport device_get_partition_size_sysfs()
> - Unexport read_path()
> - Unexport ulist_release()
> - Unexport max_zone_append_size()
> - Unexport subvol_uuid_search_add()
> - Delete blake2()
> - Delete btrfs_check_allocatable_zones()
> - Delete subvol_uuid_search_finit()
> - Add needed headers
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


