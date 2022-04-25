Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1435850E4A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 17:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbiDYPpn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 11:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiDYPpm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 11:45:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D29338BFB
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 08:42:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PFUfI7031660;
        Mon, 25 Apr 2022 15:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aRdZWE5HPWatoPli94jVbE1DvtC6SwjjuxHZsghgH4A=;
 b=i2d27RkD7Npjh7i8Up5hzBJvwX/uBb7nXBXUvs1XuHp627P5hEAv3aY5KLGcohmCcOeK
 jIrLKf1bXzuLEISKOVKrBTFaqHJq7uqGOU4YRZPEpdAx0U3jKiFfBVOtQEaqxZGCivZe
 T9BZ2sKUO50YqkeS0/Qwb6W1hktnlt44Lu7HHeXL5BYr2x3tc2i5TlqK1M3vKLPZfVOq
 7UjY3EVpwija5qroL1tqkfcvgC2/RLAkHtjiuxaxxt9FCGDQRjudwQHf6suMdTZmv3X9
 c3VyzKV6afY8X0/rMfXu96+v7sIByQUYHf7Y0sdYq5fpeR3PBB0BRLudLWeX8BT3XXBk Ng== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jund0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 15:42:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PFePsN028101;
        Mon, 25 Apr 2022 15:42:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w1u27h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 15:42:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmBAvWuZ+Kj+14WOB9szMEdU0bR6lxPY/SzyFpVrUzqxaozcY/M5LjBw5ue1h9vswDxFzEEEQvHCxMVg+nWb+wjGyX3MxpKRuP7J8CHxaI6YJAFIS/gkVvApLB2JB+F/SrhKU2dQpaSrfENFxKVFc/kwgOKqzW/vbtBfFNkVXODj8nPgg40Iotg/FRbrcOc/cb4LPCnecW2jzQklGOF30T0pjB11fC2pViXOU+K/THAylUIUrMeI0ZsBMpOPn5ycDOaE2WehcsobmryHKGI4HWB222eX2xwpDO7nrKc5xXiMiPvrBRx0Ezxsl+csi2SG/4Z7+1YgXCwtTmBkVIE1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRdZWE5HPWatoPli94jVbE1DvtC6SwjjuxHZsghgH4A=;
 b=lHSz6It01rEV+E1bHmnHOdam5307iKQOCpD5gR2j0yVS4vkkVvZW7uFgphgnfgKoX1GQW1nNW3TM6J9/nAQTli1A2UMl8DlSmo3xR2uZtupZ7Gw4vGzWQWYVXC7ezQRUxA4M8u932TawjQJX9g2QP+JHKZ2mo2DS3VKMuDfyukP096hEwLMnUw7/jEw2/FMb/4tAyAEACUMOlOt2bwNpg9pRf6tfO2EIfD6n/MC3NHlzwmoIic2nJ75IB1PSk4N8714zUbzUk9mI0fvrOQj2Xqs9OQVBcNP2TPbMVVIZoLpUCesbMiw4C5ZBMvg/y5kb3koQOIs2+b2aYCvnZ5oIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRdZWE5HPWatoPli94jVbE1DvtC6SwjjuxHZsghgH4A=;
 b=bi7wQsMVSWYZqXDUq/grpJ+z4+qkPF/WaNz4IZRD89xUj8ElOsVGNnLXYfLblNrfWDV2vGYMBUdFhT23rc6QzcMU/OJ0wyhNn+e6FrdI0SAnmeIKwdwQJvBrUfwvouqj8a37f3KZJvq/utldDrMRv1zqPddpsrrzSX1ujbGUtaM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 15:42:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 15:42:30 +0000
Message-ID: <d7cdc315-05b3-742b-83b0-ebfa7edeabe8@oracle.com>
Date:   Mon, 25 Apr 2022 21:12:13 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] btrfs: skip compression property for anything other than
 files and dirs
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <bbb363e71d966670d8938898803dac2b8a581c7c.1650535137.git.fdmanana@suse.com>
 <970520d8-74eb-a4c6-53e4-53363ee963f9@oracle.com>
 <CAL3q7H5APJ0p4NFECgmvUV8ahTdELyXF6Hsjhd0Q6StgNJ-0vA@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H5APJ0p4NFECgmvUV8ahTdELyXF6Hsjhd0Q6StgNJ-0vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::28) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51811148-f50e-47d7-6c1a-08da26d23538
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5109841BD32CACA52168F06FE5F89@BN0PR10MB5109.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxfRYi10n6XOY2BYxBVeyYt3TIpIvRaY3Ly+fi/oiSdtd3HAevFdNnbvDBRa2tbFRw8ME+Q8gyWzqAdHLFBJ5vfU2LMttNz5Z85P5R+yQ7AJi0WsVxBNEdsVKVLjPemoDDGku+lumz2LrpPdy3tQM6hIysiAGlXFyJp7Hh25isrI8+gOCiC5OXjcr3Y8q49xMvB8JtU7Eh7yTATzPi7kHVhWw/4gWdGaJ7V0sDibkM83rN4vc41wqi2dO9VE/aGPD2UL3gB6XaO7Wk1P+Q7lbJ3kF3bphrh8cPDNf6Vvq5oHPdFButP3AaKPlbS9AkpgQQM2CrETMYu7SgmAnDi6MwiKSBNYcPcfPHG7x30GrGuINai38jGDSCkK5RaTUh5rW1PUSbKItTGDKfacMWLEuXggFn1YEzwgGjPJDE77at6nezU3D2wznYRlaW3SezZvnMQ9YmSMGsLBsxdNYTQw1W9Vu1aMHGnKYCp+CfoEEoAQHMResMwEF6W4c+xo4R7a5u2nVHMRe40WWKITtKHwNwkJWV0+VnBFb4JTlUZVO9X0M9qhSarjcLydYnDz8aYsE+H91A9Fs/fsTkgqxR3eDudMvqCIZtlvflBhWr6E+uEMfvs9hNsIZ/wY0WjME+FhJS3xlzGJsHwtE2FeH+d8VXxfQtZXUtaBC5qcWCytvRHPg4a0AAkHwCtnMts4NTQNA56GXGTwb1egj7FGsQCS4khO0d88U4HFygndSXeax6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(36756003)(83380400001)(53546011)(31696002)(4326008)(6506007)(186003)(2906002)(44832011)(31686004)(66476007)(2616005)(8676002)(6486002)(316002)(38100700002)(86362001)(508600001)(66556008)(66946007)(6666004)(6916009)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDJQZEwrdnRwVkJQaCthREFvaGNGL1oxSW8zVVNMZU54UWkybm1DUE5PYStU?=
 =?utf-8?B?QWlBSFlsSUgzYlZ2VC9saW5ud2syU1RFYU00aU5WYWJuNTBQVjdhTGp2MVln?=
 =?utf-8?B?VS9OMXJLay9EdWMxTW9jQWZjMHp4SStGU1I1TkZ6SmRNamhYM2VyVTJtR3hB?=
 =?utf-8?B?K1JrZVU0bnQ0ZFBLbE16MHN3Ri9JS0dRQ0RrdEFjeFpSQ3ZBbnJ0cG50TnpN?=
 =?utf-8?B?dUh5dXJjNjNjeXBid0xhMlNnTUpwaVRFZHlpVm9jWHU4a2V0UUJTMHQ4SjBO?=
 =?utf-8?B?SUwvcTNqa3RNT1U1bFNLa1NLcjZzd0xlM3FhWkhpZFRKMll6dS9raVQ3ZGJK?=
 =?utf-8?B?dDJXbWk1eUpka1BVVDlsS1VKV3FHalI1NVpsczFlV01nUEdjQTJ5T2N6aUNM?=
 =?utf-8?B?VlJPa1ZLbm9nbStJSFlnL3Q2MEpBNTZ2c09Ec3RUaU4xbEQ4eWppZ1dseS9l?=
 =?utf-8?B?V1F0YjBNWlVZcHFER1J5aUVONmt6QUpVRjJPQjFDQW5OZFNCR2Q4VXJWU0lM?=
 =?utf-8?B?VGFlTUNUT2FqbklIQWVMd3JKNXFtTlA4R2hzaDh6emc0dVdEWEtETEZkZTJj?=
 =?utf-8?B?aXp6SU8rUDgxQ21rY2t2Y2RMQm9uOTgyU25TYXBwd2pxVnFNK3RiekRDQmF5?=
 =?utf-8?B?RCsraG9QblNNZWVNQkx0OFBaaWZaM0xmdXBuT0lZcHJ3V2R1OHdIMlJ1ejgy?=
 =?utf-8?B?alJiWW03bG9QSjJaWmk1SGt4UktGQWNOK3IxN1FobTMwTytDdm44eTRleUVY?=
 =?utf-8?B?cEJxTmd3WkRZWitqZ2tzbWdHTzF1clhkeDdocVpoTGNaT3hqVlZ4ME1xUmxq?=
 =?utf-8?B?KzNUUXoveXVNRFNhb0N1U2hCMmJVZmZ4N3VKYWY0c3ZVMTErUnlnVUwreCtx?=
 =?utf-8?B?VkNDOGQvR1hYRkNRQTJnU3ROOU15clJhbDY1cmhLdTgvOFdha29HTDk5dEYw?=
 =?utf-8?B?eXg0YlhDVFRnVE84TTk3dkxaU3ZTWGM5cWhBRGNpNERNQm5vTkorY3ZwWHFv?=
 =?utf-8?B?RXFIeW5OWXhyVm5LcmIvOG9JRVFIN2lyc2JUWGY1UzhZeG1NcHdralBRcU5p?=
 =?utf-8?B?NzJYUHNQSkU5cUNrVGVZNlVnVy91WS9oaHN2aVNTVE5jakIwZEg5RHNDeWxG?=
 =?utf-8?B?MUpuMnR0cURMQ3JkRE1pcVpTbTNDQVRubjN6Uld2TmlwWnJwSGZNYzdkQmZ3?=
 =?utf-8?B?bmw0VFhwMUFkQnUyNUlQY3hhNFN4TDc2T3F1MjNCVmdTNzFIV3R3OTUzZ0Rx?=
 =?utf-8?B?M21scDBXbjlyOGNROVYvL1lOdHZyV3duTVlHdjdBVGlBdnptMEx4V3g1d1hY?=
 =?utf-8?B?bS9FdDhzbDBvdUIreFdYdlhKL3pvZTN1YTMxTUxUcndVRUJJazRuMWJRTU8w?=
 =?utf-8?B?NHV6SjM1UkZOQjlGU0c5UWJIdTFmbTVuSnZ2ZXhVZEJOK1pSUUF2aUdabTk1?=
 =?utf-8?B?ak1KcnRWWkpJM0gvS00zMzNZQzJrQ3gxREZyU05nNVJOTWFuRm5mTjJHZTNa?=
 =?utf-8?B?SkltcWdLZUQ4dnEwZlY4UWlia2dEb1BTUmM1SU1DZVlhU0ZxWEdPSStrdjRT?=
 =?utf-8?B?Z1Z0RUU2Mmd2OEZTQ0RURzBjSU45bHJkczYwMThwRkp1TUdkSGpMbC8wL0Zr?=
 =?utf-8?B?eERoM000cWJrV1NwRG5mSUw4ZDN0cWRqa3RsRjJwU3BYYnBYMDZnNHgwTWI4?=
 =?utf-8?B?cFZ1bzFuWDhkdGtrUEtTbkRFUGc5T0R3T1FkQ25tZ21rRHpHQVluSmQ1WjdC?=
 =?utf-8?B?NTVKZTJ5cEVZc0VXQWp4bFhyK0xrOTI1Y0tPdG8zWUhzWGUrNE5oYjdZcDRB?=
 =?utf-8?B?QW5EUzZqUFNjMHVEZlBQTUtMckpxcTYzSzFleDM3djljYTR3dGgwUjU0YzZG?=
 =?utf-8?B?WDEzTi91cktDR0tvdDZxR3l0bnpwZ1FiL1FRUlJCQmZLTlNQN3B5bVVudlJ6?=
 =?utf-8?B?bTZVMG5tWmpBc2pDQTZSTlVVY0hLVlRhbGxRNHYzMDkyRjZDK0ZYM3lpdjdL?=
 =?utf-8?B?R2llR3d1OEFmcklpWXkyZHNDZ3FSVnc5NkJBczJ3MzRGbm1NdWp6dE1aNXp2?=
 =?utf-8?B?WEUxWDZ4VmN6ZUhEbSswQjRIVEhyQjNZNVFWeUEvbjdmdFora3BZMFFmYy9P?=
 =?utf-8?B?VjNOajBJc1pYN3dRL3hvY1ZPU1BQUFNaWnFiRmtvRCs5UnBjVHp0RUxjdzRs?=
 =?utf-8?B?MWpvdkQxWFJSMDVKbmkzS0lYem9OVGxBTHdjcUc2T2lVTTFvbWJLakI4NjMr?=
 =?utf-8?B?cUtsbWp6cHBYeS9qT1RIZC9GRDFtOWdNcUFOMzBVVm5JZStGYXRFa3g1TkFU?=
 =?utf-8?B?L1hNN2FjNG84YWo1Zzg5NXRMSzJMcm5lOU9UVjVuRi82QVVsNUpKRnNlZHRt?=
 =?utf-8?Q?QDgWw0oUJRlLDoBcstn5nEsAZWBM9YMdV9oKO/ua11AtO?=
X-MS-Exchange-AntiSpam-MessageData-1: rkfB/hCjK6iCtjKK/FlxcTtF5BDFXoePvhY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51811148-f50e-47d7-6c1a-08da26d23538
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 15:42:30.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EitKxygw9C3Xs55dQgkuqt7N8IkptTtyHRvD7akpQ1NQJ6weeOh98WiXRyCjdaAoKzD9sx5nCMTVFEkzxXrkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5109
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_06:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250069
X-Proofpoint-GUID: eXvVCNsQClZ42Hr2erQyqrWdUKeoIz6X
X-Proofpoint-ORIG-GUID: eXvVCNsQClZ42Hr2erQyqrWdUKeoIz6X
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4/21/22 21:51, Filipe Manana wrote:
> On Thu, Apr 21, 2022 at 2:42 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> On 21/04/2022 18:01, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> The compression property only has effect on regular files and directories
>>> (so that it's propagated to files and subdirectories created inside a
>>> directory). For any other inode type (symlink, fifo, device, socket),
>>> it's pointless to set the compression property because it does nothing
>>
>> Hm. symlink propagates the compression xattrs to the target file/dir.
>>
>>    A symlink to a directory
>>
>>    $ /btrfs$ ls -la | grep test-029
>> drwxr-xr-x.  1 root root    0 Apr 12 13:07 test-029
>> lrwxrwxrwx.  1 root root   10 Apr 21 20:00 test-029-link -> ./test-029
>>
>>
>>    $ btrfs prop get ./test-029 compression
>>    $ btrfs prop get ./test-029-link compression
>>
>>    Set xattr compression to the symlink
>>
>>    $ btrfs prop set ./test-029-link compression lzo
>>
>>    The target directory also gets it.
>>
>>    $ btrfs prop get ./test-029 compression
>> compression=lzo
>>    $ btrfs prop get ./test-029 compression
>> compression=lzo
>>
>>    This patch affects the change in semantics. No?
> 
> In your examples you are setting/getting the property not to/from the
> symlink inode itself but to/from the inode it points at.
> 
> "btrfs property set/get" follows symlinks.
> That's why in my example I used setfattr with -h (don't follow symlinks).

(my vacation in between; sorry for the delay).

Yep. I got it.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> 
>>
>> Thanks, Anand
>>
>>
>>> and ends up unnecessarily wasting leaf space due to the pointless xattr
>>> (75 or 76 bytes, depending on the compression value). Symlinks in
>>> particular are very common (for example, I have almost 10k symlinks under
>>> /etc, /usr and /var alone) and therefore it's worth to avoid wasting
>>> leaf space with the compression xattr.
>>>
>>> For example, the compression property can end up on a symlink or character
>>> device implicitly, through inheritance from a parent directory
>>>
>>>     $ mkdir /mnt/testdir
>>>     $ btrfs property set /mnt/testdir compression lzo
>>>
>>>     $ ln -s yadayada /mnt/testdir/lnk
>>>     $ mknod /mnt/testdir/dev c 0 0
>>>
>>> Or explicitly like this:
>>>
>>>     $ ln -s yadayda /mnt/lnk
>>>     $ setfattr -h -n btrfs.compression -v lzo /mnt/lnk
>>>
>>> So skip the compression property on inodes that are neither a regular
>>> file nor a directory.
>>
>>
>>
>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/props.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>>>    fs/btrfs/props.h |  1 +
>>>    fs/btrfs/xattr.c |  3 +++
>>>    3 files changed, 47 insertions(+)
>>>
>>> diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
>>> index f5565c296898..7a0038797015 100644
>>> --- a/fs/btrfs/props.c
>>> +++ b/fs/btrfs/props.c
>>> @@ -20,6 +20,7 @@ struct prop_handler {
>>>        int (*validate)(const char *value, size_t len);
>>>        int (*apply)(struct inode *inode, const char *value, size_t len);
>>>        const char *(*extract)(struct inode *inode);
>>> +     bool (*ignore)(const struct btrfs_inode *inode);
>>>        int inheritable;
>>>    };
>>>
>>> @@ -72,6 +73,28 @@ int btrfs_validate_prop(const char *name, const char *value, size_t value_len)
>>>        return handler->validate(value, value_len);
>>>    }
>>>
>>> +/*
>>> + * Check if a property should be ignored (not set) for an inode.
>>> + *
>>> + * @inode:     The target inode.
>>> + * @name:      The property's name.
>>> + *
>>> + * The caller must be sure the given property name is valid, for example by
>>> + * having previously called btrfs_validate_prop().
>>> + *
>>> + * Returns:    true if the property should be ignored for the given inode
>>> + *             false if the property must not be ignored for the given inode
>>> + */
>>> +bool btrfs_ignore_prop(const struct btrfs_inode *inode, const char *name)
>>> +{
>>> +     const struct prop_handler *handler;
>>> +
>>> +     handler = find_prop_handler(name, NULL);
>>> +     ASSERT(handler != NULL);
>>> +
>>> +     return handler->ignore(inode);
>>> +}
>>> +
>>>    int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
>>>                   const char *name, const char *value, size_t value_len,
>>>                   int flags)
>>> @@ -310,6 +333,22 @@ static int prop_compression_apply(struct inode *inode, const char *value,
>>>        return 0;
>>>    }
>>>
>>> +static bool prop_compression_ignore(const struct btrfs_inode *inode)
>>> +{
>>> +     /*
>>> +      * Compression only has effect for regular files, and for directories
>>> +      * we set it just to propagate it to new files created inside them.
>>> +      * Everything else (symlinks, devices, sockets, fifos) is pointless as
>>> +      * it will do nothing, so don't waste metadata space on a compression
>>> +      * xattr for anything that is neither a file nor a directory.
>>> +      */
>>> +     if (!S_ISREG(inode->vfs_inode.i_mode) &&
>>> +         !S_ISDIR(inode->vfs_inode.i_mode))
>>> +             return true;
>>> +
>>> +     return false;
>>> +}
>>> +
>>>    static const char *prop_compression_extract(struct inode *inode)
>>>    {
>>>        switch (BTRFS_I(inode)->prop_compress) {
>>> @@ -330,6 +369,7 @@ static struct prop_handler prop_handlers[] = {
>>>                .validate = prop_compression_validate,
>>>                .apply = prop_compression_apply,
>>>                .extract = prop_compression_extract,
>>> +             .ignore = prop_compression_ignore,
>>>                .inheritable = 1
>>>        },
>>>    };
>>> @@ -355,6 +395,9 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
>>>                if (!h->inheritable)
>>>                        continue;
>>>
>>> +             if (h->ignore(BTRFS_I(inode)))
>>> +                     continue;
>>> +
>>>                value = h->extract(parent);
>>>                if (!value)
>>>                        continue;
>>> diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
>>> index 1dcd5daa3b22..09bf1702bb34 100644
>>> --- a/fs/btrfs/props.h
>>> +++ b/fs/btrfs/props.h
>>> @@ -14,6 +14,7 @@ int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
>>>                   const char *name, const char *value, size_t value_len,
>>>                   int flags);
>>>    int btrfs_validate_prop(const char *name, const char *value, size_t value_len);
>>> +bool btrfs_ignore_prop(const struct btrfs_inode *inode, const char *name);
>>>
>>>    int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path);
>>>
>>> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
>>> index b96ffd775b41..f9d22ff3567f 100644
>>> --- a/fs/btrfs/xattr.c
>>> +++ b/fs/btrfs/xattr.c
>>> @@ -389,6 +389,9 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
>>>        if (ret)
>>>                return ret;
>>>
>>> +     if (btrfs_ignore_prop(BTRFS_I(inode), name))
>>> +             return 0;
>>> +
>>>        trans = btrfs_start_transaction(root, 2);
>>>        if (IS_ERR(trans))
>>>                return PTR_ERR(trans);
>>
