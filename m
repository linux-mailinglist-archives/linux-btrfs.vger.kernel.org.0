Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581B865E980
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 12:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjAELEk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 06:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjAELEi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 06:04:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8E2568A4;
        Thu,  5 Jan 2023 03:04:36 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304ME1q2004538;
        Thu, 5 Jan 2023 11:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=279FpWmbe+YPaSzmzzpPfg/BJJOSN+Sot/mDjPZ0G5U=;
 b=UXNkmTpFifJ9S+hLOjZZKi6tdTs+UPVtKwCz47crd3D/lwnHkZoGFzrlBSPqBi61IMz7
 FqNZvlZQa3vqzwEknI6laKAoL9Iaxif5PvNNc85TjMOt+11bTks1ox3DrU8UW8YpYeOo
 b8RFUy26cYdKlxgrxsBUFWPkUHJ5e2YRYsBfcr8j7V82MtuEgsP3u1uN97DtWqMGYVxz
 YOPGVJhWh1sHeA67PLa8ychq8getep7H9pNMWdbnluV+/eUEd/cKoN6tWOu+n2E1pQPE
 SLfAclbYbdsTd3TQIb6nVohGARmJ/XktUysB6GNINCOvY8K93TfHvwlbJnuSciUZlOfJ 4g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c8p65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 11:04:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305ABBHN024254;
        Thu, 5 Jan 2023 11:04:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwevjbu05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 11:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiI9KZx9n9wTZbpo9PA6F6lxGxtrWohsMxwPo93zFX5RI9mSRfbsRSbgrRtWIOGp+Hc3LDzo0HJlFqQIbiuCL8UhlbQt/fDF5u9Fg887pQACkcDbesh0fFLN51lGhE0xzW4ZKGEuUV/ukWu5VSxxtlLfS38V+SkYxg8BKI36/LeynzhUnbeKfUl1yj+0Tat12yT9JvVDkULrEOdVmXoAc63Eg5X9/lINJ23dF4AHhynyN6sdOT04F0GZ+qSxUa01sRxXdg2YT0d2jLLMyGkiR3enyYzNEE2xH5QZjaSZuoj4jZuB7ayHyD6/995dhry8Uuf5m4jcavbpgyhUSxeteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=279FpWmbe+YPaSzmzzpPfg/BJJOSN+Sot/mDjPZ0G5U=;
 b=RdrWLjRqB/ty4tAS6haSggYc9TExRwPRYaYengqaVRBvaTZ6vOix1JlvV8r+9PwlsUfQ+tsZRVhrsA0ns6m3EEA92fKpCin5R6nGKMV8XE0dgu14ITKybgOyJwXx4GvcJF4gW5L3+0YwxmQnr4jN4Z+ysykf9FfIa2DJwK3xOXJW6NFWVs8GlDpjEdqW0AjDSWJLAUuS5vTIPuAdsqI4NqKqGajNuxLb27sGmBFgDHnkBMUqGhFG2c9TUUeoUNQPe9y6GkOXxKqAeVe5O9YDtDQlWvpiZOL5u7iaQrxBNWP0lsqVEnoR7ZvCMdbBARAoFo2QfswyBa9ujWa9zlcDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=279FpWmbe+YPaSzmzzpPfg/BJJOSN+Sot/mDjPZ0G5U=;
 b=u/eeLy9DLv3ML8cWOBIzeIY/Kla9b+1LPlmCjOQwl8LXxWbP8zM0RwD1t5BJe0LWU8vRfln1hiOLxEhj0dyG5oyn+2zuyYp6Pr06QQt8H5m9TYxwWdvAv5JMKx5tRcToZkexhLXD8uNv/SU/BeYsXFnm+hjN/tdGMxTjJG60Rz4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6518.namprd10.prod.outlook.com (2603:10b6:806:2b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 11:04:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 11:04:30 +0000
Message-ID: <0b132ac5-89dc-7f1a-9d7d-fff198ed4d90@oracle.com>
Date:   Thu, 5 Jan 2023 19:04:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: add a test case to verify scrub speed throttle
 works
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230105071819.44226-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230105071819.44226-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3090f9-9cfe-4121-ed39-08daef0c9e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oi2Y1r2XuxWXOTZ/RJwQcKjwM9VuLKuoWq1iF9YqVBDB+WfKMQBJo5lEcxnuI5+7owaSAX2iaIoBBlL7uEC6AM/+XqroDTVhobJ70lsdXCVy3NpHsvJoinS9pELX9IUJ9a5l2lzRjucaAzZJvsaeJPudrwG8vlLW8HGb3jMaC5Fb2idfGDdv5t8Hb5s8nDGNh0I/fFQTrXlQApoK4Nx77iaQ5kaWF6cUsumUqkp32q4LGsUzh2xNlqSCtpiwtTJWmtu5Eti3SMyidEyM1y/jKJl9+C9SxMJV+fq5gAMXyWlMHXC6l2ihwj53LReVGkjST0GLoWIeHnZ1iWaQeQOIvi2IaZWbqq3fPTV/FMO/gLxHSmaU8Z5kwvQJTS5pQzKpO2tMJbv7GNfdrY1Pj3u0DOR1d+id1amjIDy7oYQiFxYKxAXkUYJWgJTytkpvqOQt53155kuZDdlfUc7ptxaN7jZu4rGup3ocQr7P0s6YbylZH01r4MuUzn+EmhOknFTPKzqPihMt5AmGnvilm4pSKgnhK9DjxN09KFBcZXiU36pcRI6qEBrrKZXDFSen8Wl8w0C6GeaGUSysGaJyYjd/XD+nukPRnrXtMmQYSgkIO84xdOAeBKBQfsolJAnbmDPxbhrh9OrR8hxhJ7ZsTCp6b120smQI2EiKqy+HFc0keJZepHLWoZm3oVRVyxMF0B5euPiwBezoALgfzkzbneiD7Nt4tSD+/0uzUY8joTe93UTU0f535rRYgsopUZ3l+JyZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(316002)(66556008)(41300700001)(66476007)(66946007)(8676002)(44832011)(5660300002)(15650500001)(2906002)(6666004)(36756003)(53546011)(6506007)(31696002)(86362001)(83380400001)(478600001)(31686004)(6486002)(8936002)(26005)(38100700002)(2616005)(186003)(6512007)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHV4TUZkR05VV1VBYTFQbkJmU3FWVHgxb1JLTzV1TjllczRoVU1UUHZBTHRh?=
 =?utf-8?B?bG5sWXVtUmN2MW80Z1BxUEJFU01aN09ZTUlsK2V0aDJzaWdSZDVOSXhFR3pI?=
 =?utf-8?B?K0F6OXYyYW5ocDdJNnRqN1k1ZzlhaG9TN3FWbUtZdERoTXJRZEU1TWsvbGpM?=
 =?utf-8?B?K0tXQkhySWcxOXZudk1lREdvU3U2Zy9Wb0swN0NBSXdWb09TUGRwMjdxN0Jo?=
 =?utf-8?B?dHhaa28rVHQwYTNDVFVEWGNTZjNQSFNBeDJmNjE2R29UVUZoUitQcHNEK2pE?=
 =?utf-8?B?WThVTU90dFVFdVdiNnN0LzFoaUR4bVdscWpkM2xNU0lTWmg1a3o0WXY3SFFC?=
 =?utf-8?B?dzZ5NU15UkVubWVpNU9BMXZUUzh5MnlFY2EzRFBnOVlubnhYd0tmeGEzaWNZ?=
 =?utf-8?B?Y3p0eGtmMVVJcVpJV0hGZlk4RXN2SXkzYmI4TmJZWEhnbmZOWXlEVGtBL2Zs?=
 =?utf-8?B?V0Y0Nk52VldNZ2RRdUVmczQ1M3dqK1Q1TWRiSFJpYU42RWFyQ0JuZGt1N0VP?=
 =?utf-8?B?QzVCVUMxRm1ydTF2MFBJRjFUUm9XS3hHOE5CRUUrT3Z6RG5zWUY3dnpldGpn?=
 =?utf-8?B?MlJWNU95MkNMUVBEc1hHdlg5VjY2OXI1ZlNTeXJTeXpHUEdHYnpVM2tBVVJY?=
 =?utf-8?B?MU8wSDVGK0oxakF4RElZUHFqQTQwYU1lNG4vLzhMc3lvaVp4MWdYK2U3L3ZY?=
 =?utf-8?B?U0p5anFRcU9acnhTS1JLTXgxeXNoUFB0NWVvWWpWNEZZc2xYV1dSbjByZnNV?=
 =?utf-8?B?dGVTOG10OFUvN04rNGN2RXV3M1pNbXlsbHo2MENLNy9nWE81OXAwcW5sM0ln?=
 =?utf-8?B?Q0RqVGU1eE8xaUFJSk13R3ViSCtrUVF4VU9FaXl2TUgwTzY0M1I5NUhKZ1lj?=
 =?utf-8?B?YU5taUxBaFViZ2I4OXlaS1B1TkZwYVc2ZXhScklLUjJyWUcyK3FFSUYwa2tU?=
 =?utf-8?B?QU5hcHBGam9zczU5QmRVWHFUU1dTU010SXpPZ1dwdmY4MlhkUXgrOEppMDEz?=
 =?utf-8?B?OXE3TkNDMEx3NDVSU2VpTmswMVF4WWpNTEYwcHRaaEd0Z2s5RDU3MEk1TWZC?=
 =?utf-8?B?cEh2TXhTNXVTMEVOMjNkMWV6OGlrV1FyN1h4WmlGQ0lEYkxabTVReTg0ZWpI?=
 =?utf-8?B?QXdhei9UY045RmhFUllNUjg5VTFzNkZpbWVIZWwrTlJZT2JpWksxN3Irb2xW?=
 =?utf-8?B?ZVFBNkJkTmZSQkRxKzV1eEh5RlE1WUJacVF3QTlWSnUxWEVpcHA5cndoc1Jv?=
 =?utf-8?B?WkVrVm9lS3h0WTVxdU9Cek9BVmdaMjd0TGZJNDFPQlY1clpNQlpRYW5CdmxN?=
 =?utf-8?B?OEdjbDNzanQ2eUZaendWalhkOFVNQnBCaEFPMmFQa0lmMFdyRWtpSG45WERY?=
 =?utf-8?B?SEs4TnAxL3hLR1hJSDFMTzJkTjhHR1Zybzl6MG5LcFdvMWp6eXY4MHNCRytG?=
 =?utf-8?B?cDRqTUsyVTd1a2lDWGd0S01pQXNtOVoyYWUyZ1N4cy9DYTdLZ1Y4bDYyZ2F3?=
 =?utf-8?B?U3gvN0E5aDk1cjRCUXFYZ0dhYlFhRTM0TFdOLzNtVFJ4Q1Qwc05hTVpsVWVQ?=
 =?utf-8?B?NEw2SDVtSURUdFNXbkZNa3dPMm9sUFBnMlY3UU1RbTh4UERFZ25BWDJWUTJz?=
 =?utf-8?B?cnYzRUxESHM5STFML3ZLT1F3anpTamVWWEU2Z0xJWWhnTHoxenFnQUlZa0lG?=
 =?utf-8?B?VG5pRThaVTUvQVErM2MrSmQrWVhjK1dpeFMyTmErVTB2bEFnQVdDSWs4K01l?=
 =?utf-8?B?cUpaVThOcnF2MXN1WVpsaXBVVlp0d2NtNGs2VzNiYzNmMElLZ3FHNnFvWnNt?=
 =?utf-8?B?a3RWZElJakl3WHVYNUtUNzc4OG13ZTdlUTdmYkJXdDcrcWpIaHZpTGFNN284?=
 =?utf-8?B?MTBheGFxaUJFYmdDcm5PaldFVlUxdDhGMTFLM0w3TUpJMDNVb1M3b2xFamRL?=
 =?utf-8?B?Qi9hMTUxVnc5N244Vkc1dEE2Wk5DMXlxRUR0M3JiTzFaQmI1U0U4cWloTXU5?=
 =?utf-8?B?MVBPSDNUb24rU2w4bDdNRnJGUURLaktSMDh2d1JraENBY2srK1A5MUVYdldn?=
 =?utf-8?B?U3pYV05wcHEwNkVMaitXUmFFbjZRcFRCNnlRemVBdmtSeHpOS3VyZGRJdnBv?=
 =?utf-8?Q?SmZygtsdS5Y3H/acPyS/YnwuC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y5HMG7VwDhe1+Dk5s2bkPF9GFCu+1CwDnbpK0LSyMi35wDNMG4Qt+2rV/xnF5KGKRcrGhegyIdHLx35V2QkhH9D9ko9vS55tjhbZ8fEUEakhk+IUldOdM+mn6bQw8SytMOnLdnsNEIKxz2Pbr1kGy2UeL1NZm8UAV8/NFTBCpbu7jRkiRfwu5kMyebZh4ZP+RiDbcVvKoFjtZKhas+p1dl8u8Ie1ugNoM80NZHhxaQyFHdGs6Qp8wxPl9ia6wpMEUbmdMxwHUz/9Oh/17LKEC7E4BpHMjDsIkJzWohkDTPilvN2DPWYDNdNEJhTIzKlJXwVcKeNVgyvHQDcBhlwHAyT+XCa/NDAFFmqgOYJSW+0egMZeYUVFjsAERgNVwU3A4Q0wWxogI5h6w9QbWyW+DhAakwGTM12hkdRG0hVOJ+vEZ69w6NH/K/gwpONyBv32dOHtdWspACYkX35f4uitYqhcPQXTFJ4hLfg1++6esL+YpspKgdp0oteE43SaVFjZFDJ+abx9S7M5WASAGZp3EH57GeEsliEOYPLYBpok7G0sudleuoHRVIIehDkXRrT37dR5Hqsl79c+hqHlk62uvRH0hJf5oqnM1AXCS0eYKnU8bFVbM9PWPDrLUdw+kGxCVvdLJlkn7l1I7ZxircKogBeAkXBvViZSjwY40HIQiCwreVJuky3j2TKhAFEtzlLbe/nUS/35hZDYXSGsvzx9fsdyUEnLYRyWxusp27wPhCT8S4FfyGn44t1wQ+StNQp5IEaA1SYMRjrEthAg1rZsXyGvb6rkyxh5gC0GbAaPg8JZEVhtWh+7Ewgm/DcHdHXYm26+cQV9tIhGtF4dH5WJtw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3090f9-9cfe-4121-ed39-08daef0c9e7e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 11:04:30.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMiUBApk8APIfF1QjefEYueAqHWPtFRPO1+I7zK09kLXnecoztb0jrZGmct0l257CpbJyKmwXh0TVEnibA4ZFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050090
X-Proofpoint-GUID: n7PJlV3FejEXiwmSxv8iHUK3rwXDTZL2
X-Proofpoint-ORIG-GUID: n7PJlV3FejEXiwmSxv8iHUK3rwXDTZL2
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/5/23 15:18, Qu Wenruo wrote:
> We introduced scrub speed throttle in commit eb3b50536642 ("btrfs: scrub:
> per-device bandwidth control"),  but it is not that well documented
> (e.g. what's the unit of the sysfs interface), nor tested by any test
> case.
> 
> This patch will add a test case for this functionality.
> 
> The test case itself is pretty straightforward:
> 
> - Fill the fs with 2G file as scrub workload
> - Scrub without any throttle to grab the initial speed
> - Set the throttle to half of the initial speed
> - Scrub again and check the speed against the throttle
> 
> The test case has an assumption that we can exclusively use all the
> performance of the underlying disk.
> But for cloud environment it's not ensured 100%, thus the test case is
> not included in auto group to avoid false alerts.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

LGTM.

Reviewed-by: Anand Jain <anand.jain@oralce.com>

-

> ---
> Changelog:
> v2:
> - Instead of a hardcoded speed, run scrub to grab the performance and
>    set the throttle to half of the original speed
>    This reduced the test runtime from 60s to 30s on a SATA SSD.
> 
> - Use "btrfs scrub status" to grab raw scrub speed
>    The output of "btrfs scrub start -B" can not be switched to raw mode,
>    which makes later parsing harder.
> ---
>   tests/btrfs/282     | 92 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/282.out |  3 ++
>   2 files changed, 95 insertions(+)
>   create mode 100755 tests/btrfs/282
>   create mode 100644 tests/btrfs/282.out
> 
> diff --git a/tests/btrfs/282 b/tests/btrfs/282
> new file mode 100755
> index 00000000..78b56528
> --- /dev/null
> +++ b/tests/btrfs/282
> @@ -0,0 +1,92 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 282
> +#
> +# Make sure scrub speed limitation works as expected.
> +#
> +. ./common/preamble
> +_begin_fstest scrub
> +
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +# 	cd /
> +# 	rm -r -f $tmp.*
> +# }
> +
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_wants_kernel_commit eb3b50536642 \
> +	"btrfs: scrub: per-device bandwidth control"
> +
> +# We want at least 5G for the scratch device.
> +_require_scratch_size $(( 5 * 1024 * 1024))
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +uuid=$(findmnt -n -o UUID $SCRATCH_MNT)
> +
> +devinfo_dir="/sys/fs/btrfs/${uuid}/devinfo/1"
> +
> +# Check if we have the sysfs interface first.
> +if [ ! -f "${devinfo_dir}/scrub_speed_max" ]; then
> +	_notrun "No sysfs interface for scrub speed throttle"
> +fi
> +
> +# Create a 2G file for later scrub workload.
> +# The 2G size is chosen to fit even DUP on a 5G disk.
> +$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 2G" $SCRATCH_MNT/file | _filter_xfs_io
> +
> +# Writeback above data, as scrub only verify the committed data.
> +sync
> +
> +# The first scrub, mostly to grab the speed of the scrub.
> +$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full
> +
> +# We grab the rate from "scrub status" which supports raw bytes reporting
> +#
> +# The output looks like this:
> +# UUID:             62eaabc5-93e8-445f-b8a7-6f027934aea7
> +# Scrub started:    Thu Jan  5 14:59:12 2023
> +# Status:           finished
> +# Duration:         0:00:02
> +# Total to scrub:   1076166656
> +# Rate:             538083328/s
> +# Error summary:    no errors found
> +#
> +# What we care is that Rate line.
> +init_speed=$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT | grep "Rate:" |\
> +	     $AWK_PROG '{print $2}' | cut -f1 -d\/)
> +
> +# This can happen for older progs
> +if [ -z "$init_speed" ]; then
> +	_notrun "btrfs-progs doesn't support scrub rate reporting"
> +fi
> +
> +# Cycle mount to drop any possible cache.
> +_scratch_cycle_mount
> +
> +target_speed=$(( $init_speed / 2 ))
> +echo "$target_speed" > "${devinfo_dir}/scrub_speed_max"
> +
> +# The second scrub, to check the throttled speed.
> +$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full
> +speed=$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT | grep "Rate:" |\
> +	     $AWK_PROG '{print $2}' | cut -f1 -d\/)
> +
> +# We gave a +- 10% tolerance for the throttle
> +if [ "$speed" -gt "$(( $target_speed * 11 / 10 ))" -o \
> +     "$speed" -lt "$(( $target_speed * 9 / 10))" ]; then
> +	echo "scrub speed $speed Bytes/s is not properly throttled, target is $target_speed Bytes/s"
> +fi
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/282.out b/tests/btrfs/282.out
> new file mode 100644
> index 00000000..8d53e7eb
> --- /dev/null
> +++ b/tests/btrfs/282.out
> @@ -0,0 +1,3 @@
> +QA output created by 282
> +wrote 2147483648/2147483648 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

