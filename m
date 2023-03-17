Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFF46BE011
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Mar 2023 05:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCQEO7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Mar 2023 00:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCQEOv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Mar 2023 00:14:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A20B0485;
        Thu, 16 Mar 2023 21:14:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H1tscB016566;
        Fri, 17 Mar 2023 04:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=24mIcWvrxrGsAxsB2euqWtmzrMAKuqC3fLKFjd6N2/g=;
 b=QOJKasKpKKT7MXl5BuFvChtGIyflMg1cEC8rYKhbg60J6DbDPXmin0n4lwFUEBCbQEU3
 UN76ayAAXiow3aSqSwD7GGytxdkrQvV8WUSMiSNiMizOI9kjsvptjFOdZAPDmjgo3Em2
 0iTLR51FkQekkh4ngvUSuVdNdABAKbZnldOYRFaRohCtZBSoE6LcWTk7n+pfGAtLgLke
 DtSDNT07DS8Eavkuvh07HDxbyh+76zYvBJqV1naiwaddCtkXN8o6gvlOW62RkB2HU44x
 dILuLKXk4ztyVR175CGlMPAotpz09PEfWvACaoTr6yAIGbeYTJdDUtV7WX4TWw7nE9// Bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs262y6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 04:14:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32H4DguB026680;
        Fri, 17 Mar 2023 04:14:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pch07g0fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 04:14:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyzpVauLl3riPZExUX4+T4Co1EDk98hKf/VuZbtzGfbzrtGIqvIq/NUkPw9gavwBQzkxD+e0/yuQJRjr+pAeM6HkZjNj2HRhyue2RpvaQLN5vcaAYO6n/I+rNVsCTrQ08K0GWWm4VKj7dn+r8Jgyu8EF2YW1/jUbPqpsw8tR3sPZJo4MLzGJxPVnFG4yreb1+5UN6GtVcaNn6HKIoQk4XKS1V8woRjyB+jrE5hS+JNr/ePjSfcTCzMQC0fxvQfVNOTyyiucHrfOOf6S3nTX1FI0f2BSGaIDkUzhHP9LaE8fMqHn8JrclIlkRRXWsYB4e+gSr1H8U+qbPRA/78sGsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24mIcWvrxrGsAxsB2euqWtmzrMAKuqC3fLKFjd6N2/g=;
 b=WzG4k6suXNBL6x2JCpMjbQE0G4sOzJpET8KJt/s9oQEhmus2KhL9jaqc5bgN7d0gGXQ9AM4ZWsdbqdXtZ/szgV0YnAkC/dK1ZktRH5YUAh/DW5byT8n8g6y9WJQN9P+ZJVD1nZvaa4IhBLRi0QBkoykCyntlHhUvwlkHgTBIE8jMYq+gWyxumGL27AfXxH5/p4802IwGSuAlmGGImEDvg10Q5JrbzRVrcRqPyLMzGZdNbJIWT/t6WpoGLSQaEvvETn05rRsJRzTJug/OaTEnFFh+Tg6ynIm9yGFcFWYKOqf4LB1d8Z89HZSv+1912HkG14AIky+ZZUpp64q3joJuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24mIcWvrxrGsAxsB2euqWtmzrMAKuqC3fLKFjd6N2/g=;
 b=pnwuJycFGdgoQLEikbE5SyhdUEoJRdM08gmb/UXpIqGmiXjusykOubmD/WDm++noe1ClxqpgfzzuH7RAA+CfhLPymcXWbbosIjjtTCnh6rFdMTKOQQrbuuhi3poBiykv4YgHpfeVb8oNKX345aaoNo1YWLGTWqS5Nrs2PKS+qYg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5995.namprd10.prod.outlook.com (2603:10b6:208:3ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 04:14:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6178.029; Fri, 17 Mar 2023
 04:14:29 +0000
Message-ID: <1c807f47-70d4-14b3-7a20-8f595edbd99e@oracle.com>
Date:   Fri, 17 Mar 2023 12:14:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [linus:master] [btrfs] 5f58d783fd: xfstests.btrfs.172.fail
To:     kernel test rboot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Daan De Meyer <daandemeyer@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <202303170839.fdf23068-oliver.sang@intel.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <202303170839.fdf23068-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: d418646c-ff31-464e-fd36-08db269e1a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3PHY7lDRmCYDf25gtTJ5PgG7Nf1P+iApQ1Ru7F0lBZunVZzw4rFaE0YpUxt2O1WzIpV88BuojSdk/Bg9kN5G/K9cyzmZmd9rFGLAYrm9fArs5e+LTgC8XmC1/mrZSaSrFvJ8Cv0Aweo7UmsS6mLpTEKYQtkGAhkOJ+dGtQPddKBnu1j4Q/NvpEYqerhHzlwSxAoGQgOJMkiXm5LraZh20ZvLkkU7la3gXyeJWilSDeuln6QEz/qQoZIYX/kx3Fo28xVHorxOPDYK7Tlod4XGvbzirJhiwtuEjCyslrPtMsne9rMrjub2MuhKzTv3s4jQ0uKg6YeN2fqFBOtJrkci1HfIMYGAhdnipBuFPQdm6EDkTcjai7bZUQCxr8/ex5nL4Fq4Xa2aPDyRIQmq9oUJ8+ThMd16XQSjvOx4Wcw4OUQW6JQEGxXv0gElZ6JS1huUueDCfzi9h3NsjWx8ZmWw/hnWx+7M/U9fRLglVBwvN4FhWNTWvsJZLlZQOlZdzy+kErnB7Q1Ec31iB8gSe/mr9/RWUyhC0mFKAwaEITIqqP+/Wo8khNffhFa14HTZwAlykey3hRs22gW5nKruDD8+6UVyCweqoOvcMlsoAbznkxk4Xv5rZGrOJ3sasPpxhpFWau1+U5GgvDPQcErtFCCZBJJ9x1bN0zUdaLsFB3B06bPrLX+Qro1QxiqWaZyOvoJXYPyOToOZsjAK4lmJ8aC6u60hZ0/xwDO27C/WBPClliknmEFKg9NPpTDMn4S20wTcJtjSlqfukuuqP1Becowm6Q3sfeVW3eJbcip+0u8hDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199018)(2906002)(2616005)(5660300002)(44832011)(36756003)(31696002)(86362001)(38100700002)(83380400001)(54906003)(316002)(6486002)(6916009)(4326008)(66946007)(66556008)(66476007)(8676002)(6666004)(478600001)(966005)(31686004)(8936002)(53546011)(6506007)(6512007)(26005)(41300700001)(186003)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFpsSTlNSTdGdzRQVlNrakcxcVE2OFVnR2Z6YjFUVFlkZTBUNjI2SGlCbkZj?=
 =?utf-8?B?WjBtYVl6MFM1WjgydUVKK1pjYnJkZzZOYUhHSC9uWXFHVWtHSDVWWGVuRDEx?=
 =?utf-8?B?NVRmbnhwTXJDR1RQZXcwUHM1TnlBU0l3NWhHdzdVYkNoTWxCYXZRMFBJUGlV?=
 =?utf-8?B?WDFTTE9qY3pPZmdPSHRid3VYSURMb3F2K0NtdWp2aStDTXRsS0dMM3VDWjFs?=
 =?utf-8?B?YzUwKzlmcHU0QkVwSE1WbTN5Z1FCN2w2Tk1NS0ZRTnczVVJvWkFnTElCcitv?=
 =?utf-8?B?Q0JSOUxRSGV0UmsvZ1h5d1l6K0lGSHZjamRRNzZmM2NrMUlYYkJwVFFuSzBi?=
 =?utf-8?B?UGhWM1kxVk5uWUJMZ2RDVnJwMm1GZmhJay90dFpXNllIdlkwNDl4eXVhSGha?=
 =?utf-8?B?V0tTT2wyVHQ3SXVZNWJmOUVGRWg1emJ3WjdwbHlLT0R1R0ViVTY2ZER2cEN6?=
 =?utf-8?B?N2FNV0hCRlIrOUxlVzBoZGRqNkhFQWgxNDJDbGROTm5ZN0p4NjZVTlZmaDUx?=
 =?utf-8?B?dHFyWU4wWm5DZTFMVzI1MjIzZGJ4MWQrazk0NzNNZFlHREovaW9OL1ArK0w0?=
 =?utf-8?B?aFVXWWZUY0RaSURuckV2UDF0TkpocXJKK1ZFU0wrTTVpZE4yTTRRSFNXWkcy?=
 =?utf-8?B?RXkvdXdGVDhLZTVKc3hDYmRMYzQraG8yM2g3WUc1MlREYmc4VGhhdFY0TzhY?=
 =?utf-8?B?RjRKYW91elpVQVJXb2ZNZE9STXpuK0pSckhsSVFDdUw3K2dGRlluMXFlYkRj?=
 =?utf-8?B?dXhXT20vaEU2eW9YVWFVb0lhVnJIakcwaVpjM0FOQ1ZsUTVTOGRUUzNnNWo3?=
 =?utf-8?B?VFdIUE9RK0wwRFljSU9MNFhQejE1NkRtbkhxVjMveHhKK2tQd3M3am96byt3?=
 =?utf-8?B?aW5xKzFYa0U0RzM4a2lqWkkvYlRsMmpacXJibFI4c0FnQmU3MXA5S2FEa1Av?=
 =?utf-8?B?RzhteVAxbXA0Q3QwUUZPeFNMTC9Xc1VlNmhYTVpkWGxmQk1ka2NiaUFuNEhG?=
 =?utf-8?B?RkdTM21BNHExa2JVRzFISmMxZ2JPdXZPNDdacGpKOFQ3dUk2b0xnL25RK0NR?=
 =?utf-8?B?d3UwcUQxSExjRGwyLzR2eUx6SmxLQUJienBtUlFoMGt6QVlWMnNpcXZvdG5I?=
 =?utf-8?B?dGpPVW5keGdtMEVSaVB6SU0zWjNjWEsvMnRrdUhFTTFxN2NkV0ZzSlAvYXVP?=
 =?utf-8?B?Uml1cEMyb0FmbTVZNEQzTXRrSlF6eDdWUmNJckdrWnVMVFBxOUV0T3d1UFky?=
 =?utf-8?B?cGhoSDg5V2lhcitianJ5dUVaT3lqcVIwVFVzcVM1NG4rc2dxSk1ySEdTOXpK?=
 =?utf-8?B?OHJkSTRVd3F2ZFZEQXhyNGI0Nkd3Qk9DeW9OUFZXWEJmcWQ0Ni80SGtjY1Zl?=
 =?utf-8?B?YmhTOWVXNk5lY1VXVjhOdWpZdUw2UExvUzZBTUxXd01aak13RHFGTElZRlRG?=
 =?utf-8?B?KzNhaGova3ltOW0vN1ZiTUdmSzIzazdnNzJ5YUUrbGR4WW5GYlBYT0duK2l5?=
 =?utf-8?B?YzNBNGo5aVpaNXJhMDNEeTRhQ29MRXF3Mk9lZ0pJTWVFU2JjNjFEQStsQkNt?=
 =?utf-8?B?TngvK0lTSzdOZXhCZ2l5ZXhjQ1VEOEhacDJQakdBdjE0b0N0bERjNUVRcDFp?=
 =?utf-8?B?bEJ0MVFIMG5kTzVlckxwak1wZHF3cmVWMTdvU1ZXcDhScFQ5R01ySnUxaFF4?=
 =?utf-8?B?UWt4b1hlZjhObTZBaVZLbVlDRTFiK2tEbkNWL3FBd0FSSmFHdmhoUXhCYXFx?=
 =?utf-8?B?allHS3JaQWZ6NFdRNXhoa1FKZERQUXBPTVpDRHNWTG9sNWRlcHZ4S3dLOFZp?=
 =?utf-8?B?clF2Y0xZbEsrZllSR2FqdVJxV2pwdTVtK3FtWThnRFRBRXBVd3RnNDFDQTQw?=
 =?utf-8?B?WStrejMzL0IwUWd6WmFzWkdqUTRhcmtad2NXRVQyVWVzSFE2UXJtUmNRRXZ0?=
 =?utf-8?B?Q1hNOXJhNGR1UjY4em5QSEw0YTUxOGlPOVhVemh0WlNiMzVyTGpLUmJQN3ls?=
 =?utf-8?B?V0R2UjZoN1R5VXRacXcwOWtqOTNJVEhvRWl6M050TkxOVm1kQTJqS2lZZGpK?=
 =?utf-8?B?NEdycG81NFBKcHJvTktsYVNTZE5zcVd5NjZsMHkyNW0rbE4vMGRFUDdDakF2?=
 =?utf-8?Q?a1a0n4rVXHLGfpRQtMio2Zpex?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NQC4NMttRVCRpNFKF7z/p4aRsovxVdg7iNpiKB0T2W8dOt6t3r1gucEW5szjNL4WnP0t/0DbTL0nlG4DSdYbr0lBTIAGzJgy30eNVAVBnI7qjVJWS/mLoFqiG5HjdqYcNQU0IL9lFHKBk4Hizsr1Be2nkINJXJsLl9UalEA4pFME6w0cqYTOwJ3bDtskni2wEvbfd3Xh13GaSEhAQU7HHZsgnxnd/bq1P5cgkPu55NMzSwhFouWAxXY6LK6uRz2H8H3DuR/zt4xBpWX3Kt70dw1BWqvQINiSk8JVgih4FodUF1/z8uQaM60rP0ABWk1od8mKSmLuH0oy018DpolAHbIZyD0WkgprriPyxydGgxrxWxjr2j+HSqZixudRyWiCkaBRbeq4e2j35tynTsynCbbdA46RsZCD+zI6fhhZbJWwaLbTxxI+7Awqap0uNy+lwkoyBOKpTOIrwj7T8JjWuKnI9d/dYdWVtR6aA51UmZNVelEV0hZxMlh7M+F3fksk9m0drBrJbp+vX7Z0KQM6KZzB1ZW7VTaSJCholUKXbvs+SvLUUnSwLskJbWZpG50/XsvBAytqhpGN1d3TnFQwHEUSMY/PKZFs9uPdCFHnMkxi0m1HbTMBk8J0OyFpsKwI2wK+efq9QNQzNLHgRzZw3SfV198rxnjUpFA7+TkAvhkGXkWcSANmDKM2TGvMG4kVtJx6h+AMAhLl30k+jmoJcUm2symjm95iSHQsmjPXlZF9Vkyoj5TojRJNH3ndWpDu19xd4WNa6Jk4q5DMUQ97sgTyqPVgpCH07lS1bJuS3/O5yVfMHBTlsC+soh+2Ig5GLDces0fWOzvY+en4o73zzZuczXwzkcXALpBt/dkv4z8iqoph8/2OhCftImv0rICabtpThw14Tj9wZGKTiqXQIsD5KLomTbh8tF6jgO2cTKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d418646c-ff31-464e-fd36-08db269e1a70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 04:14:29.7901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTszzKnhmZcuHWzKaBqXfgd8qKH5i3JloOkMpw+SvNgrUCcUtRlcdmfKsOqo/Ml358Qpi+7UlOvAfllbs7tFOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_01,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170025
X-Proofpoint-ORIG-GUID: 572MLLtFbcLEGNV9-uMeLxerKlN_HdAi
X-Proofpoint-GUID: 572MLLtFbcLEGNV9-uMeLxerKlN_HdAi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/17/23 09:17, kernel test rboot wrote:
> 
> Greeting,
> 
> FYI, we noticed xfstests.btrfs.172.fail due to commit (built with gcc-11):
> 
> commit: 5f58d783fd7823b2c2d5954d1126e702f94bfc4c ("btrfs: free device in btrfs_close_devices for a single device filesystem")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: xfstests
> version: xfstests-i386-5a5e419-1_20220926
> with following parameters:
> 
> 	disk: 6HDD
> 	fs: btrfs
> 	test: btrfs-logwrites
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> we did this test on i386 and we found the issue doesn't always happen,
> on both this commit and v6.3-rc2, it failed in about half of tests.
> however, always clean on parent commit 519b7e13b5ae8dd3.
> 
> 519b7e13b5ae8dd3 5f58d783fd7823b2c2d5954d112                    v6.3-rc2
> ---------------- --------------------------- ---------------------------
>         fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>             |             |             |             |             |
>             :14          23%           7:13          33%          10:19    xfstests.btrfs.172.fail
>           14:14         -27%           6:13         -17%           9:19    xfstests.btrfs.172.pass
> 
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202303170839.fdf23068-oliver.sang@intel.com
> 
> 2023-03-08 04:47:50 export TEST_DIR=/fs/sdb1
> 2023-03-08 04:47:50 export TEST_DEV=/dev/sdb1
> 2023-03-08 04:47:50 export FSTYP=btrfs
> 2023-03-08 04:47:50 export SCRATCH_MNT=/fs/scratch
> 2023-03-08 04:47:50 mkdir /fs/scratch -p
> 2023-03-08 04:47:50 export SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
> 2023-03-08 04:47:50 export LOGWRITES_DEV=/dev/sdb2
> 2023-03-08 04:47:50 export SCRATCH_DEV=/dev/sdb6
> 2023-03-08 04:47:50 unset SCRATCH_DEV_POOL
> 2023-03-08 04:47:50 sed "s:^:btrfs/:" //lkp/benchmarks/xfstests/tests/btrfs-logwrites
> 2023-03-08 04:47:50 ./check btrfs/291 btrfs/206 btrfs/196 btrfs/192 btrfs/190 btrfs/172
> FSTYP         -- btrfs
> PLATFORM      -- Linux/i686 lkp-hsw-d01 6.1.0-rc8-00284-g5f58d783fd78 #1 SMP Wed Mar  8 11:05:36 CST 2023
> MKFS_OPTIONS  -- /dev/sdb6
> MOUNT_OPTIONS -- /dev/sdb6 /fs/scratch
> 
> btrfs/172       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/172.out.bad)
>      --- tests/btrfs/172.out	2022-09-26 09:38:15.000000000 +0000
>      +++ /lkp/benchmarks/xfstests/results//btrfs/172.out.bad	2023-03-08 04:47:54.134026209 +0000
>      @@ -1,3 +1,5 @@
>       QA output created by 172
>       wrote 5242880/5242880 bytes at offset 0
>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

>      +_check_btrfs_filesystem: filesystem on /dev/sdb6 is inconsistent


Thank you for reporting it. I am currently looking into it. It appears
that the device is being freed after it's closed, which could indicate
that we overlooked something at close, just a hypothesis at this point.

-Anand


>      +(see /lkp/benchmarks/xfstests/results//btrfs/172.full for details)
>      ...
>      (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/172.out /lkp/benchmarks/xfstests/results//btrfs/172.out.bad'  to see the entire diff)
> btrfs/190        15s
> btrfs/192        101s
> btrfs/196        163s
> btrfs/206        4s
> btrfs/291       [not run] kernel btrfs isn't configured with verity support
> Ran: btrfs/172 btrfs/190 btrfs/192 btrfs/196 btrfs/206 btrfs/291
> Not run: btrfs/291
> Failures: btrfs/172
> Failed 1 of 6 tests
> 
> 
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
