Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3646C29C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 06:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCUFXN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 01:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCUFWt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 01:22:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BA239283
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 22:22:47 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KM4gda026261;
        Tue, 21 Mar 2023 05:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+hiCRuGaszvD3zHEoGWrPn6PTMgvJDKwWxRAyBTfmk4=;
 b=AP3iXogOeaQghh+IL+dF+uoqMqBJxB4s7dmV2h4h/gQTiPseStPoVjsqLNmHvh3wfWVh
 6eppIeB2n4cETdvlCJPTue/UKwqaCR5B6mrsaGFnNGxhlrbohvNMxeQ8YD+Lwnvyhz0V
 g6mssZK9aBmXpfl41IIRbv26JYnwp96B/cNKUe4pXqisV/0KxNCf7WQqd/TJVWB3vik+
 nJUbVbxIv1qho+82y7YAd8vXgnyLIwFrwcSLYrLnmeCZ2D5F39JXjRVPKHcic2PGvW1j
 7sYvr3CXVi0HkEt+WBBDqa1Neam1/bwEK6TPrxg5haa9gha9NwOeHeEEFwf9r6V4wLIk Ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd47tn9as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 05:22:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32L51T9k037210;
        Tue, 21 Mar 2023 05:22:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3peg5p8mbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 05:22:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E88WDwf/utBChXySMXNkFdlMlHw5MObjTQv++JQV9M2Nx+UG1EHPaqxTMPz30Ia4qjiLfX6hVfGN9utdQ6eUD1p+mjesNmxA0HxTjYbdjMQcZ4ExqJJRGqlzwsyXUim0KkHbGV3aGHhXNkePmFDbnQIZc8YtoCUy7LKBXZgSgSAJaK/XBXuUbte4HCEKe2UfgakYwGyXxNwf44Cz0MfSV2JpRNThN802hijbNOyH0F3lQKWSNcrc1P8k1C638VX/7EMc5mqyPntwQJXqcOeY9oUITF6zXFKelZoaprRckOZ7N7+9mFbX8iSDB2xBL1tx8bqtI3GWCpLWE7r732KRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hiCRuGaszvD3zHEoGWrPn6PTMgvJDKwWxRAyBTfmk4=;
 b=Q+wpcBeB3R+YpqSQhzuZF6Dacolf6QFp9lhfyxawZevIjec/KshRlGTbZ5eN3q7jpVSLrQ0JhO39ggw3EfgEkF66GCgeYAhjEmFMvdb6E4PqNJ/OGXQ/7/Ios9DxujaZb3tIbg4gyPEkdoV9y1GVmzcjNReLFcEN+lT4UHZinadOH3XHA5W6TRHEWjrKDcjEq9kTzi4+Z/3+NSefwKaSKTpaOgaLSgDvDiySCLVYr3KaO6brE+f8eZF95Q1GaSfGR+eG88JlBiiD7IOPnuFxqnWHnRY4Z3Nt+lkcDQrp1yp/59izzk7DrTolEdiFsxa0fRMTByRIkDVNm2oJjRVP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hiCRuGaszvD3zHEoGWrPn6PTMgvJDKwWxRAyBTfmk4=;
 b=Ur+Vj1ge2Mk2zRTQkqUFQirUHiuAAwE6gBoC/qGRADVBy4wh9sCiP9xiIOUxfUyOt8fsLk3EJJMiePmOBN3YPku+WnHDO/c/hxXE1+Vto52pGv/k8waL/ZNEHSX4DPChlIaivmiPODYaWAVCZH2tVgUZIt1RZOK7pijUCrq5ql4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6217.namprd10.prod.outlook.com (2603:10b6:208:3a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:22:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 05:22:41 +0000
Message-ID: <a70957b6-e9df-c50f-0b76-8524a56f64a1@oracle.com>
Date:   Tue, 21 Mar 2023 13:22:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 01/12] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1679278088.git.wqu@suse.com>
 <94803d18b1c4ce208b6a93e37998718e61ea37d5.1679278088.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <94803d18b1c4ce208b6a93e37998718e61ea37d5.1679278088.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc47aef-b905-478b-778c-08db29cc4adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phHmWxZ0N7J2JSGdV68eLzhLtTrh2vPdrgz63uDXQhSPw5z8Qj6qZM0OYoepBuUjDNMLUzDM3CfZ1P1nNzXI5puVUXTIub1p7MYbjoz48+USNboywSRBif7ZibPK5ruOrGiUqXYAZPPTxfHITc+4aM8gytU5c2ZuAA6OOAuRN6j+SCKQHP4b04xbV4Z/PNcN8XcAGiNBDj9PcN7rRp5WZNF7gA8eGUOt6VsqK6SUEVi5a3ZM0zK/o5Od+RCf7K0Y9tbLLCDGuOH9j7R2VlAp4+c/2CZtU5xsCIOKZySMnn2VGA7QJPEyDSM8xuthBJCv85E/NZJIa4VeHl+/8vv65xxExY8PUIhB8I1FlAvQ95NQT9zNnph28+fLpHlmCoO+ep5hhx+ErbteOq4DV3V3G1FQ1PKc+W5FYXNmLy6ViBaIrZGJXTZ6WYPQw2J8infRIltKOqrHSbiqpL0XdgsJ3I9BXXJL9sgLw3jF1byHlb2gxoJO42ceuIQLDeF3MhOBaLP6FAvXu7Qi6pIZQrEP9mXHSv1Plhwb+BuIRLg1niYedzGBZ4RwOo4HjVpKME2jSur79dFIMSuhbbwkSS9qqX6SrJ39fl8uV4cBczIO/O2GCi23ruLrN02JYBgdKnOedL50J8DSrcoquGDvntSkjUawvdR+Gdr72flUIN2DLJ2iu9SnV9msZKwBY2EJEMF9YR4QTjbY5e+j9CCdjO1aghnlDApsANt94bm4Y9BKZ/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199018)(44832011)(36756003)(8936002)(5660300002)(83380400001)(2616005)(2906002)(478600001)(6486002)(316002)(31686004)(31696002)(86362001)(38100700002)(41300700001)(53546011)(26005)(6506007)(6512007)(66556008)(66946007)(66476007)(8676002)(186003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU9MY2oweGk0WDVsQ1ZFYzVOdHRFS3FMeXl4aUI1MDVQUk0zamdHOERhVndn?=
 =?utf-8?B?LzNRbTErUTlJcXppZFBEUFQxQTRSRTV1K2dkOXJ2cXdSRVJVcXFaNFkyUFI3?=
 =?utf-8?B?RXRib0FGY2FEQjRCNTdSSGRaRGFPNlRsUDNZd29VNE5wOXhvMzZYamV6YnJh?=
 =?utf-8?B?dWRqdW9qenhQb2RldGFwTWk4WXBPUDJWMFNTZHdtU2V3YTIzV1NjeW54dC9M?=
 =?utf-8?B?UTFwY00rdlEzbmdBZ05ET0k0M2tIbitCdFVkNFYyZFZ5SERYNlREMXA2b1VZ?=
 =?utf-8?B?SVVORFU5c0VwOXpESnlYWnJTdldtdFdCZlduMjZjKzNpOVdUWTZBMWlPaDN6?=
 =?utf-8?B?UjhZeUx4SVI5REwvZ0dGUyt4a3NoOFlRYnQ2ZjdkeXhDbjE4TDVVRzVBdTV5?=
 =?utf-8?B?R3hodllpUWN0TmlSWmpmeHZaNXhkSEErcDMvZzBqN1JWY1RubjMrTlNJVkk5?=
 =?utf-8?B?ak1BRndOYXlEeFhCRTdVWU9MMTg3KzlFc1dEWExZQ3JUdEJCbzJoWjd5ekFy?=
 =?utf-8?B?NVJDL1ZoT0Q4cW5mQXFPWmJJN1RDQzVteVRLdE5CMXRZRUpCcWo0NEdsV2xE?=
 =?utf-8?B?aDN6WStLS2N4aDRrY1hUMFJHQjlQR2F0Z2dLMW90dWpibVltZk1LV2RKc29L?=
 =?utf-8?B?VzA1WjkyeXB6d3p4ZFNTYnNpK1BiTXdJREJZRGFWZlQ2ekoxblFJUTJibUpG?=
 =?utf-8?B?RExkYjJtUHdPT0xYWUJrZllPUWJEQVZPQytCTW96clN5c1ZwRGhuZFN5Wi95?=
 =?utf-8?B?QmxidkRZUGI1N1VCTUdTdHZtSVRxeEF3VGwxUi9SQUdnV01UVlJuZDJlUkV0?=
 =?utf-8?B?VnRsVXBkTU5udlB0a1FOK3RsZ2ZFNFFrcWJURGRpVFU0ZnA0eVhyc2F0QlBR?=
 =?utf-8?B?RyswZGtWTVhUaGhXSUtaZUlKYjVxTjlhOWdwSHNZdzBuZUEwZGk0ZzlhOHRT?=
 =?utf-8?B?YWFjd055MmJsT200S2NzUTNyNEg1RlduYndaN2owYzZDTXQ5cnY1VERMak5H?=
 =?utf-8?B?WVpmTXZqa1lSU2tvUS9LMUUyMk5Zc3lPaWNQWnlWUk9HQnAxelYyVWdJejNN?=
 =?utf-8?B?WHlZVXBvK0lTbTkzMDZhVXdLS091N3J0dWFQeGU1NlpYRXNmRGdubTB0QXdp?=
 =?utf-8?B?d0ZaZmZOWlh3TmZyTFRlOElWa2t5VTA0M0FpY1MzZ0JWdHk3OTQrN2F3UUsr?=
 =?utf-8?B?Ym1XYU01VTlPUVhnUGF2QzhoSTNVb3creThaRnNab3JoUzFWc3RJSTk4eU9k?=
 =?utf-8?B?V0JZaHVTV25ESU43N0dJNFJic2ZWalZkc3ZadURUa0R1WUNlRFdFOVU4Y05p?=
 =?utf-8?B?TE5mYko5dHArdjZVTUdEWi9mU0lrL25oai9LRWU3YmpQcmVvS25TMmJWM0JF?=
 =?utf-8?B?Y2pUSUhQWDh5NkN2cmdwTzFSbnZObDF5VU5GNUk2UkZKaVVheWFmZk9rNHh5?=
 =?utf-8?B?dDJqd0xlNVFTMnJxS01XbTVxYXlBMWE3RFhUK3hPR2NnVUo1dHZTZURzZlVU?=
 =?utf-8?B?S2g2UW10L2U4QkxoRWhmOGtlV28vZVBydFBBNGVDRDRWZGVYeXhaVU42QjNH?=
 =?utf-8?B?dzRBWFlBN0hDNnJSdFI5Si9DUGRxVEIwVjJYQURwZ2VORGVXSGU5MW9iS0p0?=
 =?utf-8?B?Q21xaXFORnlXbDNYTFBMTk1HWE4wQnk3SHlIRGl0TUgxc0lHb1ZLMUxoM3FP?=
 =?utf-8?B?c2lBY1lmL1VpczFnbXBvNzVtWGZlU1J4SXFISzZXM2FhcE1EMTdNZ0JzUDQv?=
 =?utf-8?B?TWV6dnM0cGt2c3BJem1HMDlxQ2ltN3Q2OGdlb0cwVC9IZUVaRHpqRTZBaTYx?=
 =?utf-8?B?aTg1TnF4aFFXTUNlR0ZVenZRLzJJR1FKblZCN3d6TEM0d01sVVliYnMxeEJB?=
 =?utf-8?B?ZU1MWmpVYXQxU2RJNkFQZzRHd3dLcGxwR3REUFByd2wxMU0zQkJsb0tnM3B1?=
 =?utf-8?B?cnVUcGdYLzdwV3liUXVaWnhhcTlRSnFMRWFJYVRjZjRlTVZ3RWtSbkJTQ1Q4?=
 =?utf-8?B?Q2Z0NU5vcy9tM0lXQjArZUl4NFN5K0U4ZE9yUGt1MlVEeG1nckhZYm9HNjJW?=
 =?utf-8?B?WHRPMlFpN3J0UzRnemJrQW9hTUNuVjAwR2E5YVRCUytoN3VCM2cydnJNWC91?=
 =?utf-8?Q?pp4eF/l+0z6lC6ubiPjackvmd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L2xmcXzCoIvXmrinzNZqPyBpB4sGoam9/aVSIGLEjaARxm09781zVzE9dLf+5QUFehsEIgrKVEc3j35SbJGgVQwxiCSaa/nkBoDXd4xYD06EIlz8iPdft3EBryVR8hdtUAtxjAXvcbhdw2V5YXHfJCEUrwfk/8rCw4blPHTQL+u1OdQzgh+YQqZc3jH9ewMUdnCtnLGl5Y7cu2W2oJFKtfFuYT0Zfupt/AIW0e1uLiaN8LUOCj8jXj6V88IVsEHrTaYU+M5HW/g6mixDm+8UIKH2xTEwLtaiBZ4uAyiXCAVKi9c47XOIs2hss00abl9HMYi3cl0APy8YYX9XK78stevjd0uL7bVNC67eEuG7oTYrDLRyWRudAbr4kb5rsrUglCqE+nnN4dRMQ3CKGYn48TL1PDaJnrr41vTU8kE+B2GKUjcbdkmpxMQsbzLEy398033hbmChBdV2xbNv9gpQtdnSaafb66dO1TVW9VzGIL9BPmVZb5a3l2VjKp6UbYYQ+Jfb2ix7Y9Y3Ayfkcb8XJHmYKKHldysjfy2Z/DrPi0a3y87B6XVbbwz9TXzAt7TVO3Eodt603DgODKftOEjQKh7QDYp9bu1abmoKruExdele6kD1JI7CXSIjMBBIJllBSz3RJ1eXJqw6CSRc+Iba+EsgesvaOjDti0m/tbgcqttAclx10Y5bCLq4ecuDFZhj414mugXCjTJdz2LJ/5TpU9ZRHSNz4EH/IaApyvlYh8fb8LQ4BYwhN7Nc8pBdyru938rptUmJLcDSD78BauG0LGTZGWmPaxwQl7AAwBpSroU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc47aef-b905-478b-778c-08db29cc4adc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:22:41.3304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sd96AayvzrUxOc76CwbOgxiJ009GrE1LJ3duhP0f8KIoOpsuZGhQso7XPFJs8E9zJkEdoclMq64WNJWW2LCa5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_02,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210041
X-Proofpoint-GUID: yUL2vc1Vda_-OlI8EVkbsOnq0_JLxSoU
X-Proofpoint-ORIG-GUID: yUL2vc1Vda_-OlI8EVkbsOnq0_JLxSoU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/03/2023 10:12, Qu Wenruo wrote:
> There is really no need to go through the super complex scrub_sectors()
> to just handle super blocks.
> 
> This patch will introduce a dedicated function (less than 50 lines) to
> handle super block scrubing.
> 
> This new function will introduce a behavior change, instead of using the
> complex but concurrent scrub_bio system, here we just go
> submit-and-wait.
> 
> There is really not much sense to care the performance of super block
> scrubbing. It only has 3 super blocks at most, and they are all scattered
> around the devices already.
> 

Looks good

> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

nits below:

> ---
>   fs/btrfs/scrub.c | 54 +++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 3cdf73277e7e..e765eb8b8bcf 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -4243,18 +4243,59 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>   	return ret;
>   }
>   
> +static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
> +			   struct page *page, u64 physical, u64 generation)
> +{
> +	struct btrfs_fs_info *fs_info = sctx->fs_info; > +	struct bio_vec bvec;
> +	struct bio bio;
> +	struct btrfs_super_block *sb = page_address(page);
> +	int ret;
> +
> +	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
> +	bio.bi_iter.bi_sector = physical >> SECTOR_SHIFT;
> +	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
> +	ret = submit_bio_wait(&bio);
> +	bio_uninit(&bio);
> +
> +	if (ret < 0)
> +		return ret;
> +	ret = btrfs_check_super_csum(fs_info, sb);
> +	if (ret != 0) {
> +		btrfs_err_rl(fs_info,
> +			"super block at physical %llu devid %llu has bad csum",
> +			physical, dev->devid);
> +		return -EIO;
> +	}
> +	if (btrfs_super_generation(sb) != generation) {
> +		btrfs_err_rl(fs_info,
> +"super block at physical %llu devid %llu has bad generation, has %llu expect %llu",
> +			     physical, dev->devid,
> +			     btrfs_super_generation(sb), generation);
> +		return -EUCLEAN;
> +	}
> +
> +	ret = btrfs_validate_super(fs_info, sb, -1);
> +	return ret;
> +}
> +
>   static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>   					   struct btrfs_device *scrub_dev)
>   {

  scrub_supers() no longer requires struct scrub_ctx * as a parameter,
  but this should modify from scrub_supers().

  A separate patch submitted.

>   	int	i;
>   	u64	bytenr;
>   	u64	gen;
> -	int	ret;
> +	int	ret = 0;
> +	struct page *page;
>   	struct btrfs_fs_info *fs_info = sctx->fs_info;
>   
>   	if (BTRFS_FS_ERROR(fs_info))
>   		return -EROFS;
>   
> +	page = alloc_page(GFP_KERNEL);
> +	if (!page)
> +		return -ENOMEM;
> +

  Over allocation for PAGESIZE>4K is unoptimized for SB, which is
  acceptable. Add a comment to clarify.

Thanks, Anand

>   	/* Seed devices of a new filesystem has their own generation. */
>   	if (scrub_dev->fs_devices != fs_info->fs_devices)
>   		gen = scrub_dev->generation;
> @@ -4269,15 +4310,12 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>   		if (!btrfs_check_super_location(scrub_dev, bytenr))
>   			continue;
>   
> -		ret = scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
> -				    scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
> -				    NULL, bytenr);
> +		ret = scrub_one_super(sctx, scrub_dev, page, bytenr, gen);
>   		if (ret)
> -			return ret;
> +			break;
>   	}

> -	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);

  Nice.  :-)

Thanks, Anand

> -
> -	return 0;
> +	__free_page(page);
> +	return ret;
>   }
>   
>   static void scrub_workers_put(struct btrfs_fs_info *fs_info)

