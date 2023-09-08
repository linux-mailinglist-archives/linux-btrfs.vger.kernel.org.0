Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDD6798A74
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 18:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244904AbjIHQHt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 12:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244206AbjIHQHs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 12:07:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF30D1FDC
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 09:07:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388G4vL8010010;
        Fri, 8 Sep 2023 16:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wyyz2/uQQ5scl64tb4YZXlt2+eEjHxlssGSnqIEFnII=;
 b=eKO+OSvim1nAOGYU3L1IbgjYIcslSGZVrYJQDHTxzOnD7I/A0aLltidx3WHTY+23uTaG
 Evy0YsZ1Cb/dumfWe+2Je++P1oUX8BysSHS0bfOTgqqZ3vhqJywNV6F6qcwDCyQDfdPh
 Oe+g82y66iA8PsYEfV7PsWrCGyWaZxk0LmrOS3FN13+PkCC0I2OYbXVXpuOvp66RuCJD
 srABqMRFtp482Lyn78j8i8ChniTc5y7L3CoANlwNNsPgZdcO0GWy4clto8QF6CuTBwLy
 psnDcbuXed4HbivYlAoQcVJLNwdgXwZpZdiSZo/zA3DYVToo2BTpUKPuoKYItX9abSuk GQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t06tk006e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 16:07:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388EdAUb025340;
        Fri, 8 Sep 2023 16:07:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug9bbre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 16:07:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfOXbSfEwpPyj+LljIcP0EM6VPLs1EYRSfJWU9v4hzTsp+RxlPteYckP++H1vbr00i/+btwmGOBJ9BqP5mKeJ/Rf2Smm8UwDHCrkckykTGPmZMdbYwLxpdVY3idDpMSSP6OmEIwFodxeO0KRE4o6h9A4Ngb2kWGI+Ptlsk4gVLHTBaFxtqdziaE6QDqejoVeiIbkfwurF75XkCuD6v9v/1acjf8qytwkwfnu/N8WmUpYlvw2+D5u/eurE0/+oHHAhOnI4IUbt06sHYKVjkxBfC0P5/AXYUngNXKODtH+41jnGKkt23yHpkebK4YJZZmPqfzi+E+5W7DIdYl3FgMF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyyz2/uQQ5scl64tb4YZXlt2+eEjHxlssGSnqIEFnII=;
 b=ZVM+aGUmFayOsUe8xDxGMJ2mUomDxysQOze5F6TX0hDWXqe3jixzVY5wY5M3z7bQJuDdCHTaEK9miUX+bx4eCRv3TktjnQ8CoWUBfMQ640KghPzb+Fol8i+gso9x78b+iwgoOW0RnQkuimu6UmhM6XyeXVRnEp9LvYOb40MGG/oXbFn/lEFpcltDJ5TJOfdZXPyZ3G/USnLoy9vJYjlKZNR0z6wg3nBc0eyP8ZDyoVsMNeR2b/eqeaJUGwx0DfMr1doHAlL8xjIU5FLcZ71GN7DTpgibvQvpmGVIMeCpaioGXFEqsq9Sw2bgrbDteMO4WBsu9d31p+Dd4wJifP37Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyyz2/uQQ5scl64tb4YZXlt2+eEjHxlssGSnqIEFnII=;
 b=y5mRKTDo6tckGDEp+KECaox/hd8shoZLcvv4FDxJw6PPKgYPmXW6u1TU1DxrEjLC42cx49E919FPwpNggbX3k0A4YhKTfbZKeULmZ8dD0yvrpwugFcmBld1E1FJ2aV72k83m/XETJ3xNjhM5uSiPjof62qdfpUoY0edH84aIYDE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7833.namprd10.prod.outlook.com (2603:10b6:610:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 16:07:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 16:07:34 +0000
Message-ID: <ab1921f1-3005-3aca-dd60-caa8daa4ce23@oracle.com>
Date:   Sat, 9 Sep 2023 00:07:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: pseudo device-scan for single-device filesystems
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <b0e0240254557461c137cd9b943f00b0d5048083.1693959204.git.anand.jain@oracle.com>
 <20230907143658.GQ3159@twin.jikos.cz>
 <3a5c3d54-2e34-fe47-1ed0-12c765a928b9@oracle.com>
 <20230907211015.GR3159@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230907211015.GR3159@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd60122-9fab-4a40-5e6e-08dbb085b636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHfBtnmFZHqQSatk/cEaOxwuOwxA5me2rIBvv7C7q2q/3blrSbusC7ctN/72UT0+gOI8WaMlFqm4vSZS75DN2UkjE/p6zICYcBZ3g//hb5dpg57ff1J8P9N8TzTv+gYv7mEjTmyOVyrKwS3QSrAq2gmtfiYZZ6JriCfcV957qtUwpx9D9kIDKUbqzyOlJ7Fx1D+ALAOrZpyOY+nCZcD0xqQTnQivrKfRgNjkX+X7MRn80dSRXtFRrEdS+2TfRdqjNKkJC9/ZmDwWVQZfX7BRgvT2YR08zba9DbziwAWMNqQHe4933qQH5mbFXFAwMRvBOT7wU6UcVyxFaZVSjG2CcooflbYenXgg70+VANvM8pmaM52SXoMxF8C0ZnMdvoyZlkIy+24arnwjqCtQrH0tSXSf4dQ+Ol6IVF44YKyEmXkTsfLdrCofBEngaXFNVa5h52q2EES4+L3ix/l9gIcbYlKCmd6TtZmP6S3D+gTdzL4iFIu7JP7UzYYPnFggmQoSu7K35gpeG80NYZHI0DwvhrZGMCY4EvC4+EX+zUt0G+5FaxjZPMkBhSRnAaR+GSFwOOfYJYr1gfS/IiC73f1SjvewvNsJuUSQ6jED0ptxUoYu1uqm+snMTGo5RosX1gnvKMepL+jvAM+VHVRym5ovuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(1800799009)(186009)(451199024)(31686004)(53546011)(6486002)(6506007)(6666004)(31696002)(478600001)(38100700002)(36756003)(86362001)(2616005)(2906002)(26005)(6512007)(83380400001)(66476007)(41300700001)(8936002)(5660300002)(4326008)(8676002)(66556008)(6916009)(316002)(66946007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnlTWGpKbEc3ZWlpSFo2WlRtVHlVLzZDVk5raG4wbUsyZ0JnQ2hQQkZOTVNx?=
 =?utf-8?B?Qit5QU9sNjY4dnlEYXc4ODZ6c2Z6b2krYmNHZGdxZGM3MXkrTFVWVmMwRVBi?=
 =?utf-8?B?Zkpsa3hwWW9DLzdCS0V1TzdscmpTYURxbUh3dDNGZEVFaUNpWENNUFVSSUJl?=
 =?utf-8?B?cDlTVTNuTjBMWStMRVNaY2xkbStlc2E0cW5YYVJnVTdRdlZsbHhXSjhjM240?=
 =?utf-8?B?YzE5U1QvN1dKUnpxdXRmOTVNeHk0NGl4OWh6RUIwb203eExrK2V3bVk1YnJ1?=
 =?utf-8?B?Sms4elh6VU5TbEtCWHQrTzMvL2NESTZzVE1IVGltcmhiQWNibkd0NDdvVW03?=
 =?utf-8?B?LzJod1RZOWxnbzY5c3kySU50aGEyb2ZRTXpvVU4vWVRlbjE4TGJyT29TNlhQ?=
 =?utf-8?B?S3FpbTFWY3l2WEl5MEw0M2o1enNBa1VnR2p4NllxaVNoR0hFaFRYaU0xNW4x?=
 =?utf-8?B?dDdoZXVYcGFzWm80ajNaclpySm5iMXdPNXViLzBteUxINmpKaDNVaDQwOUVJ?=
 =?utf-8?B?YjZyZXJodFVISVFieFVjRUJ4ZVdMekQ4aVI0RnFBT3MxbmE2MDJQM2hDUzRx?=
 =?utf-8?B?RHBUUnFmTXhYNkhOeDFPTW5nWkZSNE5OUDhqaW9RR3BJenF0d1JadFpoRFFM?=
 =?utf-8?B?TUNZWHA0d0dQbjVqV2s1a3lOeUd2eEZBeDBHeGdWZnJSdWR1cGR2ZG04SWVQ?=
 =?utf-8?B?YWVZUmdPYzVLRlBHaWh5dXk3MGNXcXBoSU81UXFnclZONkdCc0RaR05kZytF?=
 =?utf-8?B?YmNwQ01uTUczN1pSNkxyRVNVakNiL0RueXJEQWhjcndsaHBHaWkyWHdwTTdM?=
 =?utf-8?B?V29NSU5TYytWYlVyY0RmbG9zRjFtK3dIM0JCbVdjU1c4bVJ2TGVHN1NSM2pq?=
 =?utf-8?B?ZG5VZDZrTnFSYllVbkxGTDJTaFcwcEpqTmtidWx2OFZscnh1TXdVelduNjFW?=
 =?utf-8?B?c1FJU2NlZjNKaFBPMkVMdTYwWVlsREhUUTdyeThOMGlUaHlIYUtOVm5BSndO?=
 =?utf-8?B?R004QkhRUmZhVkRyR0F0cGR2ZE5VUnFxZ1lOc0FTS1h1RVY5NUxjWW44M1Nt?=
 =?utf-8?B?NGNsdm5ObnpPNHJETkZFOGRkNElSTzlxSHNMZGY3K0RXSmYwZ1REeFd3L2lp?=
 =?utf-8?B?ZG1iVnMzNzZlMjRjMHIrZ1dGd0RLWisvUS9BbGw2RDZZbG02Uk1aeXRuUnYr?=
 =?utf-8?B?MUZPQkd2VWFGdTFocjhQbFpsT3psUzJwbCtEOEZlZ1RNV3k5M0tHZU85bEYr?=
 =?utf-8?B?dXR0alpjZzdtYXVPV0s0NnROTkFTTGV3VTd2TG56cjRxMDd5Q1BLRllBcVhu?=
 =?utf-8?B?bDVicTdydGlaaXNIUWVaR2J2TTBjdUxmQjFyYkVZU3lINjJ6cEtPN21zejVF?=
 =?utf-8?B?RS96R2E3V2thMWpWWVBGV2lIWEFuZjJwbXNzMWlrUEtGamU1WW4xU0dac2tL?=
 =?utf-8?B?OGdySXV5TU43V0hUdTEweTllcmVlRWxFc3BqUUtaTVpXVURTQm5nU1BGaXlI?=
 =?utf-8?B?NWZubWNkaWIrWS9UQWNsODBVSUsxYmhRQ1Izbm5hYlNVSnoxNWxabk5YQnBP?=
 =?utf-8?B?MC8zN2lpMDhUS0QwQUFHVkF5cUN5dGZzVytxVVBuRHREMzFPelZCK1hNMWNQ?=
 =?utf-8?B?OW1KTEozWmdCeExZTWx0TG5TNEN5SDR5dmpwSDY1OE1WMTV4SnIydEVvaHlL?=
 =?utf-8?B?dW9zTFNpUFFQcEVTODlXenlCakhRangvSUl3Q0pYMHZpdzlWbjNKemJPZHgy?=
 =?utf-8?B?d0o4STVOdndNSFhEdStGbW9pRmY5blNMQjdQVGxMUmdyL09hZnkwSFVid01P?=
 =?utf-8?B?MTlQYlRLZ2N6M0ZRYjFIekpFazY3c0JocEZYbFpUUkh2VW82b09KbStwSmNY?=
 =?utf-8?B?SmlhNkZrSWFVUWpHNmVSd1BKdkpiNTJFS2Q2bWIrb1NYWHlBTEVCNitRK01B?=
 =?utf-8?B?Y0RSVlhDZzNBcURMdWRDZlFrOUhJYUh5Q3VHSUxWTktJYkhFZXFveXlYZDdC?=
 =?utf-8?B?T3Y3ZXdhY0xHMXE4dVJnblRCOW1EeFJLRlMzTFI4MFBvR053a3hUTVZLQXRL?=
 =?utf-8?B?RkZKQkxnWityTkFYUFozcGorS0ppZDh2RXIwNURSQ2xzSm1MQUtDTlI5eTJk?=
 =?utf-8?Q?qfWxRNe4LBMzon4sSop40xaiK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hcYIvlhnjhUD4lpcsHC2KXF49HKl8Bi66+hdP/hsZv5M1syC7xt6y8HXcimizIJGriSFLsMspsqKT8oo4H21tK7TIrWbhXG47B7z5JSYaPWqE/YP3Ra7UbZckoWuEnibb4AXr7tXCf1ebU3xZXJMvyi31Bgq+xO6ko0boeXiaTPajHrjtn14YHHygNWS2IiNDVK/J2og62BswyrQj5UrIFuKY+8HwTRvpH99MyEwKT8EACcwcC/7iA/Cccru6oWc4jwOl3QItfRXlmOH5Z9Dt7bWGHIhsX/DXUcnAgoyrNCIALGyEJTMQQyYdXztA9iBsWDfhJGwdXiYOkf40u1m2PaccX28yKMwFYZLxSOaXbZkowVJeSNk4A9IS7mmw3bn9slfib6hfuakobC8SuAzRwyn1Rj0j/0dnNHR39rU7WZFbPAfQzq9Oyh3RyWLJNsgTLz/9nAqyJqvHUzv4PDkDG5eMssq4vSm6z4PcKzjj0OVAyyzejGegUPEJjZssi9t7hG8u3ha9ihEFubDLLU53xxcDeNinBrdfZSQoxidZ6mNXqaR27a+lPH/04j/8LQhc4K3ulvyr0LMK+V+48xMO2JIMFpT3eKp8pQb796j94s8ilGJ1vc5jJ/gqstsMkUWkhlOAmrjwi/1X/rTx34t5BiqOryGwTIA9ZTdvG7oELPZC5HrxkF6d6ZuDsDIpqw152dY4PKE6+sDvSDb1KdleMxg8aYhbTxAlNQb03jnSMqqxAsEi342eOx8uzyWY2iHw8UyeohNQr+5IjYEZvL6kw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd60122-9fab-4a40-5e6e-08dbb085b636
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:07:34.0536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rE5ZZLd06T9o5eAF2gVNmmyS63E9eEMzFssz8/DpQuiGkf4ChqlcXSWKPdZEJbfdnXhFXBiFYXpT4XgDwbk4pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080148
X-Proofpoint-ORIG-GUID: MHWe87B5I7NEzDw0CBoHh0TLaMCHbJuS
X-Proofpoint-GUID: MHWe87B5I7NEzDw0CBoHh0TLaMCHbJuS
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 08/09/2023 05:10, David Sterba wrote:
> On Fri, Sep 08, 2023 at 12:48:04AM +0800, Anand Jain wrote:
>> Right. btrfs_read_disk_super() called during scan, performs sanity
>> checks on the superblock.
>>
>>>> The seed device must remain in the kernel memory to allow the sprout
>>>> device to mount without the need to specify the seed device explicitly.
>>>
>>> And in case the seeding status of the already scanned and registered
>>> device is changed another scan will happen by udev due to openning for
>>> write. So I guess it's safe.
>>
>> Changed? I think you meant converting the seed device back to a normal
>> device.
>>
>> With the current code, the stale fs_devices will remain until the
>> changed device is mounted, as its udev scan will return success without
>> calling the device_list_add() function.
>>
>> However, there are two things we can do to fix it:
>>
>> In the kernel, call btrfs_free_stale_devices() before the pseudo scan's
>> return.
>>
>> In the btrfs-progs, 'btrfstune -S 0 <dev-seed>' thread to call 'scan
>> --forget <dev-seed> ioctl'.
> 
> This should work without involvement of userspace regarding the single
> devices, while adding an explicit 'device scan --forget' to the scan
> command would make sure that our tools do the right thing in case
> somebody copies that.
> 
> The device scanning is quite specific but systemd/udevd has own utility
> that scans devices so it could be updated (depends when) and if kernel
> does it right regardless of the systemd scan then we can cover more
> cases.

Kernel fix added in v2.

> 
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -1218,7 +1218,8 @@ int btrfs_forget_devices(dev_t devt)
>>>>     * and we are not allowed to call set_blocksize during the scan. The superblock
>>>>     * is read via pagecache
>>>>     */
>>>> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
>>>> +struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>> +					   bool mount_arg_dev)
>>>>    {
>>>>    	struct btrfs_super_block *disk_super;
>>>>    	bool new_device_added = false;
>>>> @@ -1263,10 +1264,19 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
>>>>    		goto error_bdev_put;
>>>>    	}
>>>>    
>>>> +	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>>>> +	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
>>>> +		pr_info("skip registering single non seed device path %s\n",
>>>> +			path);
>>>
>>> Wouldn't this be too noisy in the logs? With the scanning and
>>> registration repeated scans of a device there will be only the first
>>> message, but on a system with potentially many single-dev devices each
>>> time udev would want to scan it and it'd get logged.
>>
>> Ah. I used it for debugging; it should be removed.
> 
> You can turn it to pr_debug if you found it useful, for testing setups
> we don't mind more messages.

Converted it to pr_debug() in v2.

Thanks, Anand
