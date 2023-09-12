Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC9079CADC
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 11:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjILJBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 05:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjILJAs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 05:00:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02F610E0;
        Tue, 12 Sep 2023 02:00:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C840mE021881;
        Tue, 12 Sep 2023 09:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=o4ujTW9QGIjhYUufmxkVIkDr55BUyWQfRvqztPc7Ffg=;
 b=ruuKJh4MlxsQdyFL2RN2nypVyeTYv2gXacpK5MWaOZ2ogmY+6HpYT9f02z1YSgieviEk
 s/APTlhEE8npyx/Sw5s0hd8fe+o/LIfjCz2/f1tTB96zkkHrYDnJzhibYkbWHBPM0T9Z
 +lV8jlo95tAYJghf7tczImJRXEZSx/sOqUY2RjBTze+SDODZmwxKEB2qpQoVa0DkCcEm
 muXn2tkxR3nYM3YZbqEvefn8Xa0rj5Fx0EIGSOVkEIsYZyS4ehZVZJ4KO6x+E6NsoVDz
 fGp8Z6Yz6YgG2puvmk9T0Wqla93gcUzhlG/OdY6Gs7NXHhgUEFD78g66+Epa3GdQOzQj RQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jwqueg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 09:00:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38C7Aeqt015028;
        Tue, 12 Sep 2023 09:00:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5bqd7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 09:00:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwMvlz19wujE8hTJvvUYD8V0L/cWHbeqjbg/7DVZlf7qmohtv6DY4ESFnDhzUi+TDJ5lLqkMS2IqQx2MHcRIhxErnG8FGgcpc2ytmgY9dgwq62v0063fkRg2IRDbJ6nHX57Blxf2D9VmSaLSC8svs7LeSxTZsuUPbGMR0SjF0cUCINi2axHY1BPl0OvI3oZy48LQ/WcYAjhywBVZPDCE0Lrz+m2mNK7FNG5uC1Nck0D6Fr55+SapRooUkipDINWQqcWnLPftAEzUDrTUD5ArNo+6WZn06AUlPxKfg5DpYqATGBheTs+Tj59lJVTQf6LKHlWyrgbMgN0e6C/P16D/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4ujTW9QGIjhYUufmxkVIkDr55BUyWQfRvqztPc7Ffg=;
 b=doPgNpK933Ny6Wy2s8n3UAFxfZoYxPcrSk1/7/0jm/blACGvk3NFUq3NUTWASU+IiG9r5F/a8RY9piQsztRf+m5UtckVTr69nyr012EVYw1dzmf+vBrmfMxqcl/Ap/VUhI7e7S2cp2+fV6P49GdVCrXEIp6jWi8Wt5JQQWcWuOGZkbdFkJ+4m+C4NXM4iYL6G+m7mz4/I+4t+p0aghAauT2/WJS5Z78RXytD80LDJtimKt1fh5YB6uw0dzJcGmFKYBRP5E9MuxhML2CciwdsK9Miouh1q4oeSAi5Ihro1bUun+8iksyV6t7ms+fF9mHvrNc0+WTQFrFDNCJPBt9bVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4ujTW9QGIjhYUufmxkVIkDr55BUyWQfRvqztPc7Ffg=;
 b=fNrZlKvgLao1XW95pdX0h0tk7Rse9R5EwwWXMZU4h7X+zzD+RNRnRciXhviG8FQgl92YtIKLn5khID/N6mj3GzFZ8XNW2MMpdMGtdXBtvrlmFNFDV3xNCNEX9KRMo6TONLYOApBrPAamXTU3b8gnkSOa0ed6s4jiSb7d0CLpvX0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6057.namprd10.prod.outlook.com (2603:10b6:510:1ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 09:00:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:00:26 +0000
Message-ID: <ef6237dc-b74e-457e-894b-c7c1c49c8600@oracle.com>
Date:   Tue, 12 Sep 2023 17:00:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] fstests: btrfs/185 update for single device pseudo
 device-scan
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <7558eed09a89d25fbd8083d45078cfe2e9601f45.1694017375.git.anand.jain@oracle.com>
 <20230911183542.GA1770246@zen>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230911183542.GA1770246@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dac1448-f64c-48b0-c286-08dbb36eb48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9E+lESJPm2T91GtT07k+4Hc/N32G3g7h0YouCXav+IiGIgO5Orcxfwzuo0Xsr2lIEsc07Jk+pYoaLX2RZa573zfErFW+S9eOZ8SPueQ6RIwgaa0Xjf5SnGDJOwQLRN5oGM/ZjzhnV72kxZBnnC79/4ZWQ8CFhzF1wkK5djHO8Uxnj76EvnFyeDv9SFKXb0Lofy8f2ASGvgLGmfHe4NhyHLe+KKpG2/67a0RuL+QE3DK2rzGV0SyQRKGniaf0pXcKGOdE3DGzr6x+z19CQwDNw0iFdl/GmGxVAyUFanwvOu5a2HTpbhztRk2TyOPu8LEpRGYbMao4OPMrU4c6MpNKDslR21DlVKgzxR7yo6fpZctCPMv1SRTIqOGyG8PplfkxMXgckwmaVoM1S4YbjXARHD8t6O2Q1oFDen6vrPNIVhL+iB9s7c76BzzzKWRN8W//eDl5qyh4l8LIOi6K2uOmDVGDMoxBcIq5qFYoBf7L4hhz4mFBkcUaaOuO1/x9yM/SUaWO9OuArNaaZdffshIjXJ8ofOynIRxLCC2oSfWWrT9XgFZ9MsbtvDiP3UoisXzKE7AgHWeZXUJ5JPZOEpOTaooQggRN9wc4ZPIJwSQaQjm8M0L924jTLIFRb15UkW9d4G+oPHEU83HgbV1yaEzs+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(1800799009)(186009)(451199024)(41300700001)(31686004)(6486002)(6506007)(53546011)(6666004)(86362001)(36756003)(31696002)(38100700002)(2616005)(2906002)(6512007)(83380400001)(5660300002)(15650500001)(8676002)(316002)(8936002)(4326008)(478600001)(26005)(44832011)(66556008)(6916009)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3RIemRYRWJ5YzUyMW45emtpMWxNSFBidHF2d2FSL1dJZERxanZCNHBuQ1VY?=
 =?utf-8?B?cG9qbEg4MlpPcTNnemp4eDE0T1dPcTQvdVdoWFg1MzJ6M1NNbzBPdDVlZGJ6?=
 =?utf-8?B?dlBEbkt0RkNmOC81L01rNEZsM0RwSkZqVXZNemVrRjlKUlFFYXljOTNQcm9j?=
 =?utf-8?B?SDd3cHVZVGlKQUFVVDV4dVZLcEd1VFMweHpnS01lRytxazE4dTlRNE1yL0M1?=
 =?utf-8?B?cEhEQUl4aWxEZTlaV3BSVEUwQU9ENjM3ZGxjbStNRE93OVRjZWxlanFkeWxt?=
 =?utf-8?B?OWJ2WWJtTHpCNkFFVU0zMkxoYnltbU9WUFdRUDJRajRHa3dIanIvVDBXL3BR?=
 =?utf-8?B?QWVJZWc3Q3hOV1YyZC9ZOXRDbnpVRE1sSnphOHpnNExWdVorSW9zVFNyM1dD?=
 =?utf-8?B?Q2x6RDhGWXcrWTNMYXNjUm9QSDF3cWVic2lEM3hQTy92dXU3L1Q4NDdYT3Nz?=
 =?utf-8?B?NTl0YmF0UXE1VlpCZDVtbFJ6QXdhdjFLdlYxNGxiZHZmdzZCNDNzQnFQM0xZ?=
 =?utf-8?B?di9UMGJoTk5EV2ZOYk5ZdFlHdnZWN3g4YUozWUdZZXN0UmZ6UzdRejRQWEF5?=
 =?utf-8?B?ay9OcklMUytiakJVWDhsRkFLN0tmYk4wTEtKZmljWXNwKzZ5NTlucXZMYm5T?=
 =?utf-8?B?RFgzMitQUEFJb3ZwK1BZZkJoVy9VSW1hMi9lUmpicU5HUG1YMUszTCs5QUY4?=
 =?utf-8?B?K0tjQ0MrQnQrMElJcVc0YzNmbk5aSTM4NzBkWU03N213SHlvTEtiKy9aQ2wx?=
 =?utf-8?B?TkxUdVBhTEQwbXpaVnZzM1gxMjJpbUJWdGpqRFQwL3hOeVBrWU9POEpxQ1ZD?=
 =?utf-8?B?Y1B2bVVVV2lXOWViYndhL1E4Vm9HQ05uVVJzcmVRL1BidjRtK3QzdEgxNHRo?=
 =?utf-8?B?ckMwV3lXL2FWdUxqVEU0cVFJbHdlbm1kTGN0dmo0alZuR3ZSSnpXc3YwSmVO?=
 =?utf-8?B?VDRTZC83cHlUOGIyTk1BWVp1RU41K05KeDY5dXdPR1Y5UnpFdEpnVmFHdEt1?=
 =?utf-8?B?aDhERGtrY3ZZWjF2VGo2dkVsMmRiMnl4SFpzZEo0VUNWcXM2SkttdDFtVzc0?=
 =?utf-8?B?ZElZL2FGNCtvYmhUY2VTbTROekRuT3BqUW9la0phY0MvMVNwWU1WakJabTY0?=
 =?utf-8?B?a1gvT3Q1ZXRNL1hoeGpVb3M1M0NieXRGUkhDd25kNHFOQUovVFJuemNpcDBZ?=
 =?utf-8?B?WHI3WWF1WSt2NVlDMklodFhzQlNTOVQxckpxRjM4aWNERTE0eVh0Z1JuSFFk?=
 =?utf-8?B?ZGVKZmNYdjJJMm82cTU0OGRyaXQ2c3c1MjVyNnJoc28xa2NTd2FNTHFYbmJO?=
 =?utf-8?B?Z3VkNUExbXJ2Q0xXcEJ4ZWx2Zm9nbW50RXdxYm13d1c3bkdmcHRGZ1JLUHRX?=
 =?utf-8?B?ZzFYU0xUalZMTzJWTDlvWXZrZmdEd2IrQTBXbm9NQmFyZXNlYmU4dWVvZVht?=
 =?utf-8?B?QUdHeHIwZGF0SXpDRUpYOTFnZHQxRlZnL2h4VXNlN3RpTkEyZzBCU1JjS2NZ?=
 =?utf-8?B?RVMvYjZjN1I2UDNobG1mL3Q1MHFSMmdBUlFuZWdQcGllMW5rdytrR2Vrd0l1?=
 =?utf-8?B?QVI5blFNSWUwbExoY0FINFBDL3Jhb0VJenoxTUxiYkUveGhzQ3FOS1pORE9m?=
 =?utf-8?B?MzVJRDhmaitSVXdVNUtlRXNob2xzc213K2lsSmJlVU93bW5aajR2clphNlUz?=
 =?utf-8?B?dFJVblVlNkhjRUxPSWtYMzgybXRDUmZJcHJhYndBaGZRaDVUVGNEbmNKQzJ1?=
 =?utf-8?B?MXlmejRzd0hoTHpKR2ozYzJINUZuQmRYc3M2YmlHY3FtRURhNVpJa0cvMDYv?=
 =?utf-8?B?aTg2Nm1PcmtuWE5YTTcrYlA1anI3MEIzVHhVMCtMUlZtUUdTTWZveTI3SFhS?=
 =?utf-8?B?cHNvWUJGWEZWZi9UcWxyQnI4YWwwRGhFUE4xd1FsMTRXRG52alpjT3hsazlI?=
 =?utf-8?B?VVdyS2VWTFBBV0NjS1VvRUIyM1FCa1JEL3ZjWEY2dnowcnN3T1ZIQXhOVUsy?=
 =?utf-8?B?b3lvOW10V0RMU3lpZUdHTTNoUGk3ZHIwTXJVa1g0TEQ5KzhoT2VlRVY5VWth?=
 =?utf-8?B?dU14d3pONUZJS0FINng5a2hZZWZtbVozMGtqNW1TVmFlT3ljZGFhUWU3R3ho?=
 =?utf-8?B?RHA1UU1DTkZDVEo4VlQyekpzekF3UVRTK2VHT3ZQZS9kL0Q0WWlRdDhxOTd5?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xwkFEcS/H8EBdBZPs6XmzlVWX+zh9xV0Vq+r+Wz8jo50Qyg3O3OZ33BAhBX36ZabWUTeLtuZAz5cgR8cJ41t/AGqG0kxVW3ethwCZg4/PHuRMHA4hqSMQDKh8Wya5/qnC1yMEuIRZO2Gq4v6nF7QNlitMuyDdUa/EzIyccZdishsl9JhNr04PxDb0615vNDa7rYaiKwcajDq8nVqItuXAayXJY9uwPe5M2nBOOWt9+NQ5RDuWmrmdikmLL1Y80UJ/3XcgUWBsr7WWMJ9c++25sLxqzaVT6u1j9eyJZvjn/1VFpwK/Xk647jL8m5Pmz7192LELvIuEIeDnuItrlQdhrDKWeqdNzol4wnVXgbA12oBugI6Ml93k8G2YEZDJi2fR/JTJb8XPD54oyJ6KvsSFmVk/PfxwEsWeXfpESYOa+orvIMPGbAdH6J+PI56QZvcswMOqjxn1rYDO6/ucxzWoaR7GHzDf1p070Pa9FXpNKqXANdSvvK+DOVUR3eVHrjMIuNdC0EkdR+fG9pQH8AGlF9o3xqniLmbp3LfmWfnyDVSd+XlGsMxJhc8420w/KpENCMH0kNGPYHqhHpeOg3LyQSVu8S/kJ7vZi46LcgFp5hcuBoqqkVaCm2tmLgNAxqiD7B/1nyB2rqyIYZF9P+ylpJO8K0rrwmNgMVcct6Ndq3mLSrJRwcu+8HCUf1FehnPyZ/dRJpl8a/LciwZ6b6hxCwIt0oADZqNsQBjVl+B8xIr/htotwQk2sdH80uphjZCV9rEXFR387TmWkTHiw7tBg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dac1448-f64c-48b0-c286-08dbb36eb48f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:00:26.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2o3uDS6VbKmeoagCQtul3os78K2vjjmExRqrc+FjBEGHDRe4FifvdyN+25/9Bf+MhqmQiqndaj3ZQJlQbk+fBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120076
X-Proofpoint-ORIG-GUID: 3Xu7txlDDZrGL5NILXVij5qAFhKasBpk
X-Proofpoint-GUID: 3Xu7txlDDZrGL5NILXVij5qAFhKasBpk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/09/2023 02:35, Boris Burkov wrote:
> On Thu, Sep 07, 2023 at 12:24:43AM +0800, Anand Jain wrote:
>> As we are obliterating the need for the device scan for the single device,
>> which will return success if the basic superblock verification passes,
>> even for the duplicate device of the mounted filesystem, drop the check
>> for the return code in this testcase and continue to verify if the device
>> path of the mounted filesystem remains unaltered after the scan.
>>
>> Also, if the test fails, it leaves the local non-standard mount point
>> remained mounted, leading to further test cases failing. Call unmount
>> in _cleanup().
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/185 | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/btrfs/185 b/tests/btrfs/185
>> index ba0200617e69..c7b8d2d46951 100755
>> --- a/tests/btrfs/185
>> +++ b/tests/btrfs/185
>> @@ -15,6 +15,7 @@ mnt=$TEST_DIR/$seq.mnt
>>   # Override the default cleanup function.
>>   _cleanup()
>>   {
>> +	$UMOUNT_PROG $mnt > /dev/null 2>&1
>>   	rm -rf $mnt > /dev/null 2>&1
>>   	cd /
>>   	rm -f $tmp.*
> 
> Also, do we need to do the scratch_dev_pool_put on cleanup? Do we have
> to worry about having not actually called scratch_dev_pool_get?

No need, actually, the config gets called at the beginning of the test
cases, so SCRATCH_DEV_POOL gets overwritten.


> 
>> @@ -51,9 +52,9 @@ for sb_bytenr in 65536 67108864; do
>>   	echo ..:$? >> $seqres.full
>>   done
>>   
>> -# Original device is mounted, scan of its clone should fail
>> +# Original device is mounted, scan of its clone must not alter the
>> +# filesystem device path
>>   $BTRFS_UTIL_PROG device scan $device_2 >> $seqres.full 2>&1
>> -[[ $? != 1 ]] && _fail "cloned device scan should fail"
>>   
>>   [[ $(findmnt $mnt | grep -v TARGET | $AWK_PROG '{print $2}') != $device_1 ]] && \
>>   						_fail "mounted device changed"
>> -- 
>> 2.39.3
>>
