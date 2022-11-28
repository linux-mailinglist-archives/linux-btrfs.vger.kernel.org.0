Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929C463A2AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 09:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiK1IT6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 03:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiK1ITy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 03:19:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0998BDE96
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 00:19:49 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AS713rr015044;
        Mon, 28 Nov 2022 08:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DbUkGp3SW0qZCANMPaGCFOc7I8QKIUVwk5UXDhV6is4=;
 b=XTQN2v5Wdjk9/Tq3IMAqMKlBpjrKcJuv3dosgv+9EFhKcHryr6qsBAVbx1kfgugT2GkU
 oERfyKXxBI3qx5QykUEmzbl5cqmYKaz9r4WpRADlfPPYDcVDf7JplBiQ6iI/r4XeLmbK
 E1BLjg6A0PRCQeFoMm7pv6nIgTySBf75EgL3YEYEOVoPB+1SHzclbXX+79fhXTGdKqr6
 5D1/yPqDxNpf6Fm/hVI0PE0iQAsOM+wgodUgP0KPXLOXbupJx9+ota1nTkt0xWDypVQX
 568eNd1/KNVLRtIw632j7M1OcS5MCvuwxKUeWsDVinG/Y8vrpdorVnydpg5RDr/EeAw3 DQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3shnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 08:19:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AS6FTAC010010;
        Mon, 28 Nov 2022 08:19:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m4a2ee8sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 08:19:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gANehXyaFEV6q1Lj3jwDVP7mCvPWj2B0V2VuTmhlT1a1kVcHVF0DWufbg6E3DYLa6ttdFN6lvtKmOzVSectzLxWIq/5GxwfZBBDbUEMu6dKXgj+S/3pN4lWxdA74bQQTXte4i+fuMV7hV+2HCWA4T3N9lnXTA+JWrUBAOqHaIB1cGZY8S2hufHX7DcwT3+vH+MNIhfeu+FMWSdwsAwOaI0P9q4FYf1NNTSSDR5XmOiid1U7h7GZz6Fo/Hjx8gVTqFhDSr++ymWzCVWOACNZx0PYqBbOiv1ez9KBlqAzUITI7sZDYksLpcR1gkgH4t8SkKQ3vwi2l6VlWuvbcx6YyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbUkGp3SW0qZCANMPaGCFOc7I8QKIUVwk5UXDhV6is4=;
 b=NfVCvfiHpxhEMPCHRUlFz61S1OtqfoUehYiz86OGK1k34u0IFU3Fr0J2EcYGVimjKUgHkqtA4Z1MKw7DFPUMjO9aA79GFOjnf0sUGCDwQOQ6IbJE/R/dWUtDPluTerWL71MdYlhTQoy+ahDSM2cnkXcyNQXIVF2558HXgD5IXwGN8xjE/JId1wtdeyPEUkF98LZaDrwaHZ/DrKeBX1Tvf3pZXa7WXXJQJ0qWHBHcD7d1ZI4PhXeRRB7T3hnIvG55jhdsRn4+NWxwyyfecHzrsZGBuvbk9SV5hEK3ucZGSKjeqfORdOpbQTKC7yRBg/4a4K8zCmPtER6vwz5Dr54mpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbUkGp3SW0qZCANMPaGCFOc7I8QKIUVwk5UXDhV6is4=;
 b=SeF4YtwpUliQJqW867dI1GLkadDcUe4/+6dbNY5YRGOa/HoDhgES3nRDfezsJmIwxJvcolIZAuJN4VeaaEZht0vcmnuzm/6djJ3SU46lCLW31uqTueU5rlMCinbaEBDlu3lAxq7DLqQRFwWt3ZYeRCOB7rcTdykbsFj9Azri+BY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Mon, 28 Nov
 2022 08:19:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%8]) with mapi id 15.20.5857.019; Mon, 28 Nov 2022
 08:19:45 +0000
Message-ID: <e88cbf8f-7f98-9642-d9b8-44ec1d4f9e2c@oracle.com>
Date:   Mon, 28 Nov 2022 13:49:36 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v3 04/29] btrfs-progs: use -std=gnu11
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <cover.1669242804.git.josef@toxicpanda.com>
 <d14df29fe513f2ee0cd0290407da381824af239e.1669242804.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     kernel-team@fb.com
In-Reply-To: <d14df29fe513f2ee0cd0290407da381824af239e.1669242804.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d6e98e-2af9-466e-211b-08dad1194e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INIhn7SUcX6kDX66HbIe7uK+tIAqzYsLdWAN+FYSCwcnPhXBTlbUCIxf25YtbDSo5d7m1TrnwYzoMfyo6BFzFTCwI3er2nEn9AHBOlvF0Mqz7lNrB9PWy48/1F0I9MeuFKXkyuYdXZRekaPwaGlA3Z0ZhRcs2f24GvnnJ289tasdwqCWB5QSHyjpmbdRmhEAd7Cu3Kbu9XYVNw6fJtrFobUalXMgbAKq+/QE+tKnxwrm7aU+r9nj/qafhAOaF7vTT02yTWFvSf7HtBgWLDO9URpCxDVy6GpLpXhAgiGic9ldFYAAeujjrBOg+CWDNRArxXSAKBMCJUNBdNlJKGxNLYkIvkkL4Bb+qqhrMBf1SZ7Xee8ANfKHyX6MSFV0DnwH8b1EVLUxRiSHvrPlyM8NUc3ksxIsWAcXIrpcboDtcz32iU6IEGEFxacO9OFqFT65TrwO4DFhOuEbuSmWS13a9G5bps7xsdtNN+wiu/tPmpIopB/1kOjM62+/w1PqelyfXALnxfKdDgCHvHLlZHmpg8oBt2UYJhzFwgL58QibHVUWLY/o6Lku+9fBGbodOsWyUYK1DWpk4cK44szupk+BMiSv/XyQMD7GamiTSjp/kU/H6hc4Fwnzv7+bdqNoGRGH8ifukX9Yx4e80NKOcm0qjrDTWuECs3MbKqoSl9TI+NUE/UhvRV+VtQO9e7Vc6zBr3boA7h3xcZMqtXQaK0kw75/lwuEnZQNoaXmvXn0PV/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(186003)(2616005)(6506007)(41300700001)(2906002)(6486002)(53546011)(38100700002)(36756003)(8936002)(83380400001)(86362001)(6666004)(44832011)(31696002)(4744005)(316002)(31686004)(6512007)(8676002)(66946007)(66476007)(66556008)(478600001)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MENMaUlianRsbWE5SHJUU3ExR3VzNFJRNmU3MHRoQmZic202NVpicmRpNmUx?=
 =?utf-8?B?ZkxhUDdaQTl0QS9saHFBN0hLWlVZUVpKekhiT2FRWU9sOXRXbXVhYm1tSldu?=
 =?utf-8?B?cTZBYy95b1pDQjBHTnQxWHJMV2t6Qlg2cXZiWms3T0NVaUNoRGdpUzM4VGQ3?=
 =?utf-8?B?V3h4bUk3RHE0Z0dldlJrVHQzcXJkazFacDQ3VnVoVC9LQVhmVmtHMDZxNEk2?=
 =?utf-8?B?MWR6U1liOHVXdFdGTGxMNnozVGxadXR0bkFoK2p1VTNtTXM3TDNUNkNYZ0Mr?=
 =?utf-8?B?aFVPcTVlUjMxbmFoTGF5OTFTaVBtT0lTZWphZ2hoVXdvSjlYcWJpMHV2QmdV?=
 =?utf-8?B?QXovS3hXSDdZd1k2QUdpaHUvRk5qY29ycVovY2dkckZkUHg0UTNoaVh4bHB5?=
 =?utf-8?B?YW8zQzJrc1pzanVmbFZFZ2M5cmg2V3U4bzFBTDBWVmo5QmVSU3lLek9SaUV4?=
 =?utf-8?B?ZmcwM1hjUVVLTnF3bldWY2gxc1ZnUGhFUlM2TXZiUVhKakZUejI1NXBZSHha?=
 =?utf-8?B?VDRtOE5JeTE4NGpVS1BqZXN4SGd2NHdsK3FPaXY4djE2ZW5UK09pZG9RL1NM?=
 =?utf-8?B?S1djRW5rRE85NkxaQjN2MEx1YjNPMnh1Ly9GaGNzNngwNjJGOEJhbWJ3YXNV?=
 =?utf-8?B?ZnhyYnpMV3IyTDJ4cWcrSUc3enhma0ZTNDNkek9hTEJlZFJKNEM3TVVsV3VB?=
 =?utf-8?B?aElVVFZxaHJ5RUl0bkpPd3dUYTNhbFd2dE1RTk9OWjd3bHExU3lSSldqZmRj?=
 =?utf-8?B?WndFRWU4TU5xRXhQM3lqYjgyMlJWenVCb0F1WUxvckg1Tjh6OWt1enlvbmho?=
 =?utf-8?B?Z1VGWkZ3NjM1QnRvOG43K0VEZGNOUVBzcXUrbFJ5dHF5TkRRQnEzdU1TMVg2?=
 =?utf-8?B?VlZLN0dXZGVSTWJvLzhBd1pDRWdSa3kwMVYxZzVrcDhGNGlkaEk0QlJOdzRs?=
 =?utf-8?B?T2RreGIvK2lRNmdjK3hxZUFoT3hESXBDN3E5UVFObVpkazJnNnRpOVVpVW5E?=
 =?utf-8?B?Ui83VS9jNEg3MWU3QUM3R2JKRGpqcXhhQUw3OWJqekJaRmo1T2RjYkE3L3B5?=
 =?utf-8?B?cDU1bzdWUENvczk2SlE5bUVPLzdOdmV2SlA1eWpmb3JzZ0ltQVNNc241NFQ0?=
 =?utf-8?B?WldXSVJPUVQwc2NoRm4yYUJQQ2ptTmJXQmhucnN0VlMvK2J6OGxoOE5iUWVK?=
 =?utf-8?B?QXdKcS9RZEUwaU93TmQvZ3MwV1IzcnoyZjgreDhDdW1WTDFjcjhIRmhvRHQr?=
 =?utf-8?B?RFJtYXlVSHAyNDdoRHJvY1JST3BtVFpZK3E5N1AzZTdTbWI2QnloK1JQR0lS?=
 =?utf-8?B?TDZYRjdpb0pnNlNJQys1S3dQOXNwTVZXaWd0UzBSbDArZ0NCZWlqeEluYStZ?=
 =?utf-8?B?MVZ3VDVhTDJtTWRYaWJpYkVFM3diSGgxcm91Y3lNTGg1TlBqQWl5ZHh0SmZD?=
 =?utf-8?B?d3JVMk9SM1FWeDQ3cU0weXFRdGg1ZWFCT2RUc2NOUzVGUUNQSEN3b2M5c25u?=
 =?utf-8?B?SE1aeGEwTjJZSXhYalRSSkhReDFQT1FJMmtaeTJwSnJwTEhYcEZWdWgvekl0?=
 =?utf-8?B?UzcrWHAxU016QVREKzh5eS9SZmt3bWdGOXd1bEZHVkc5Q1hWb0I2N0JBS3ZE?=
 =?utf-8?B?aEVTVmxqR1EwRy9UZnNmWHJSRFJKNGRscC9SS0tlQ3F0cFgyVDdqalJaMXdE?=
 =?utf-8?B?VldCdzI0VXRBOCtFVFBlSm5WYW02eld3NU9DeXMzc3FhUVdra1lnc3VaRWIw?=
 =?utf-8?B?TXg3aUx0RG1aZWNUc2loanNUZE1sU0lYbGJxUnlLeFJQZU9BbzkyRmEzUTRt?=
 =?utf-8?B?OHZVZTE3aHNPWVhkVTlqWnoySUw2QXZyMFRSOUNxTXpFdEZoeVJ2VzVkUWJS?=
 =?utf-8?B?bEV5QTdoMk1ZSEpnc3pZS3NhZDFQSGFlNzRNcHVQaEtmaklYVFZ2ZlptTHVs?=
 =?utf-8?B?M3BsaW9hV09aaExPa2x2bUsxSGUwRmxwS3dXU2VTdVJsTHQ2bE1nZVE5VHZB?=
 =?utf-8?B?WlRjd0xXUm91eU8rNU9FUGQ5ejNKT1prQUhHMmZKcUxqdFQ4MndYM0VrZ2sv?=
 =?utf-8?B?Q3JJWW12WDNuelFCdFgvSDB3Z3dYaWdpSTgvaEh5cXU3NmtkMk1KU3hlTktP?=
 =?utf-8?B?UFE5aXRINjNwMm1ndUFYSUJ3OU5UM2xuVFdNTkVlYnRVd0xjTi9IeFdadWRM?=
 =?utf-8?B?SFNPSUhrcW4wUHBvaExFa2EwQ0xFTGZjRkNTeVdQUXVCTHlnWVNyMXFZMEVL?=
 =?utf-8?B?WWFiNmh5SmZ2b0hrMW1VUzhvMmlRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UgWgG9OYS624qk6R9bXBqP6d76Jp+3381M/o9Ag4DK5Bo8KYeko5g9ildQVcPPpDUJBauq/nY4MTiBDGJ5dZQz13CeK0lUdqXkANqBDmYZ/Ez77BXP5wvZaPQYWnQITpywD4Utxoypg3ohV2jSElroxdoDiyMTmTjBLFcyfo05aeu6BXa9VEfe911ChMqVNcYmYwqos2+XqJknej5aNw596LB5klLbfC11mR9RaRxbY69DTNsOvKX2jkBJLUok3zYTHEp/UDTM7f0F3zSpm3c5/iLY2nspQhr2bB7CnPYXStg/Ti5XgkG0T/sfb8lquqzAex/m3nsE8IkYgmOGPeNWFZci+yE471aHEb/aJxsTvzMp/q3fxJl9rtotSSXMBdFAR8/rD3z/BDe8pbLELzvoof1keBofTy1CIcrEwDvSw5iA/lbQIU5rzmtN+1jCHNBlIVbYdGJg8o0ix7qWy0k9GYsHxV+kkOPQNZjBgWNaRsCceQUrWg3jyBVTzG0mdnEV34QhqeSeTYrwgmIMieaJo/VwxZfyWOWRlCQ0liObV0A4DpCKnowkMULaDnsgCRlNAP2733S/OYAUz20psfSFUfG/e2wDSwq4OWc4CTXzPN0Jj054v4ddQlglPXz9Vh7x4ltEdi4z8sIXq8ogMEp2jl/XZ3kqvTHhq6GKz1tC2JTY0EqvaDlQ5IDUaVzA0UrUxkaTqjju/0btLRxJnx5bKffXW3C3k+IEoaPLasHotZNnqkAoITYmrOLRja4IhVJxkxcTCP88xqDCxjXKt3Kk2acBOd4ySuDk0MLOnFCbh+mfnGWYuqZXwyJ6anLjUP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d6e98e-2af9-466e-211b-08dad1194e7d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 08:19:45.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hl6d1yKzsA/oiZoXIjmVjB0YIF/Op36RAY9Ncwm7ICi2MHr3wd25hZlk7KrADD/5akPv31qvNnAKaIztWQQebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_07,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280065
X-Proofpoint-GUID: 9xovIOBuEVhsVUMasRWqw047bommtXkr
X-Proofpoint-ORIG-GUID: 9xovIOBuEVhsVUMasRWqw047bommtXkr
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/24/22 04:07, Josef Bacik wrote:
> The kernel switched to this recently, switch btrfs-progs to this as well
> to avoid issues with syncing the kernel code.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 475754e2..aae7d66a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -401,7 +401,7 @@ ifdef C
>   			grep -v __SIZE_TYPE__ > $(check_defs))
>   	check = $(CHECKER)
>   	check_echo = echo


> -	CSTD = -std=gnu89
> +	CSTD = -std=gnu11

We have one btrfs-progs source code compiling for kernels 4.x, 5.x and 
6.x; I am not yet sure if this will remain compatible, any idea?

Thanks, Anand

>   else
>   	check = true
>   	check_echo = true

