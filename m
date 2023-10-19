Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE8A7CED98
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 03:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjJSBdR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Oct 2023 21:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSBdP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Oct 2023 21:33:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4338C9F
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Oct 2023 18:33:14 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIn0OZ011264;
        Thu, 19 Oct 2023 01:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WRH9Vdgy9KCQJF3S9O4FaRasAKL8a+frcjcYP145mLY=;
 b=iPwa39XhA7VFDLW3Q2Y6/8TRsFHDA0IEg69td/7FVobLYDu2zkDBwkg3D1MxhCmnm4ok
 GpLnyQEA119bRB1nNos78g1rQgzKblMmFjFO9ePw5ctoVZDW4xr86xsk1rF0t6/GT95B
 OCPxNyI7f5CNGmD5r4xaT4WzvOw/OmNYbBAvw/5WnlA6rpLy0AoGxTUZbK97pi3PCDqU
 QaBVKCYqeaQPvNzzA3Im4B58frlaGNQdQHqJRxGuLRfypIMz6uMLNNTpfDP86EUs8xeb
 5j6xlymHAZ553lPtvA6APBiMWASH+XQvOsPwAb5wv9jInaUudq/swYpa8eUs3N09m7rn RQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1ch91f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 01:33:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IN0qpa028197;
        Thu, 19 Oct 2023 01:32:59 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trfy5tnup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 01:32:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3pt+Fv4ldJFhGRdxGvE6ObcbSRQnAMwPMYeKTso33Jg0RnFJaidlFolLyCU+J1MFAhCFky5Cshvf9SATbRiMvNP3C1m2FPU74JOxHFn1IZF9oTRudYfvA07JPznILraskkjWDxOKi8oMqbX3VLrvQ/FAt6OJa6g10V680M9tyH3sb2bcZXL7z9OPNL6nAQ6JCA7TkEbKb8A38JbYbw6zj9Nb9EAC4QAupPu1QxU2BQIwz8AzXyqFSuJvoXDfyKp2gYNi7EcOo3WqGAXdODL1Mbzzc84WdWVhpvqPg9GrJD6W9P+ubnbafuOPX/+v3ZhUngvznbl4/T++18C/Cp0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRH9Vdgy9KCQJF3S9O4FaRasAKL8a+frcjcYP145mLY=;
 b=BGatWyZ4+tSZ155watQuSpRWJ5XbRlugj02z82LVkwy6Peb9qkNsW17uTLw0QKK73/FLx+aB/CCkCcfKBCz30eJOyC2Q8eD1Zrw49BijRloz6944mvSmtVtT9doQiGXaDEUwp1dUlz2IjL3Wt77Oqc6rnFhfnOBSAhIEVGupIzmOp9RlZr8MLM41wrPcj3Ul+QpugkE2JGacO7Lt0Y8OyjlY7TNtTk0aZfJhYjqfkWDAyylnXkIg/ebmBbtDxy0XtHraZ/vBPp4dEoxuK0I8zlhtx+i6oU8pjo3b63XX+hN3Ow1ia7oRlFTTx0kVHK9ACBsbZMbUeETAr52O0FthMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRH9Vdgy9KCQJF3S9O4FaRasAKL8a+frcjcYP145mLY=;
 b=KaIq3QWy4rPu/Zy8QIFmWI4dbjzJpCZBsNEq7CBug2sq/AdefxrFdz16RAuLiGGAjPqX2a+lcGJOBiA7EgggKm3DLIrWs7L3K4z4yXLKlrEIO7n1HpxRfd2MSN33eDVAlk4OWPaXFoI2khpics3U9VnjxWmIHekX23ak8BhSHQg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7091.namprd10.prod.outlook.com (2603:10b6:8:14d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 01:32:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 01:32:56 +0000
Message-ID: <59f12862-f48a-4117-af58-cd6cd66bd308@oracle.com>
Date:   Thu, 19 Oct 2023 07:02:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2 v2] btrfs-progs: mkfs: testing cloned-device
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, gpiccoli@igalia.com
References: <cover.1696304038.git.anand.jain@oracle.com>
 <20231017234945.GB26353@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231017234945.GB26353@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 795d7f92-4711-43fe-3f50-08dbd043524e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJ8+3ZIU+a5zfZmVER4UgHB6kUN8imnK/hpx8aNzOFNocJr78udEq0QF4OvK2vhw9EZ37cKcu8C9eX2e74hSXSTiU1M0hLrg6dhH9o7z4iWYUdKblEg0njTE+6OEJcmSVKlPzNJlbKkfVrN7JS/zsTi+o4xhw768jDwLQS8pYMFoI9z3uVLKH4hwxf7w47MgbJ4W3hcgZDVgcuQvhrki3+O137xFt0aifY6qmHSD4wm14pCkPQG4x87bF7tKCY9/TFq7jfapbOrRxDuddrJPQdL+9Q8cekqPZgQoVVUZ1kPmi1Z1EuKVlZMVeQssFY3fFKTk7qymOHwfVm0+Q06GahBTFkqw+RLeXkvw5leV4F5CV1A5oL6YQtb0W252Haf2lue9rXAvHyK0Su261cU47mQc6Yyr6/aBvdaMrtwyhfhrz9Wk/D5Fd8RTrhO7jxi/1FMzArpwbMtknhCu5YdvIsoFqiTUA4HiNfaDa7TIrGJu8qBMlTicH53tGyKZwa42ANKqkibbQ3XSNVzmIwOHAthMzCgsxXxiueUthq0Y8xbYNgzWLZujd0lutIi3o+5R3kSvjn54ZN5vfEkUeeg1wqEPLBTRdqvZouJWd/WXVgoPGJvdaYqVfETjqtJC4Zs15ojAY3oohLzqoHoazOnb6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(31686004)(38100700002)(36756003)(44832011)(5660300002)(86362001)(2906002)(31696002)(4326008)(4744005)(6512007)(53546011)(6506007)(2616005)(41300700001)(6486002)(6666004)(478600001)(8676002)(66946007)(66476007)(316002)(6916009)(8936002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjJ2NHM3aGY0TnRJSWdDaU4yb1dCRDAyazJITDZvUys0Vk1FUUpiWnV4MUdS?=
 =?utf-8?B?cCsyTkV1ZW0zdFJQUDg3TUxuWENuTW1KL0hZaFlUUi9adkxpMUl5K2wwTmxs?=
 =?utf-8?B?Q2N5bnljYmhaUHVUYXJuN09zQ2FtNzRpT3RXZUFVTUtBUkRpNXlIemtRVkND?=
 =?utf-8?B?TDM3cUNuSGJocElLbWtzeGxBWUwvaWY2YlhOdEdENzdRZXJnZ29HRDBXWktv?=
 =?utf-8?B?TFEveU5jWnFZZVQ0S29pYnJiQ0kreEJrd3g0VHQyMFVXcDJBM2kwQWpwY1Y3?=
 =?utf-8?B?aUptQXJmcHRvVURBODRzNDBuOC95THJjUVU2d1BIMkhMWElQR3RlaDVFMGNP?=
 =?utf-8?B?WEV5WFpramhiK3pLTWgxT3crVmUxWTdSNzgyOURYNVlWd21qb2Jpbjc3UVFO?=
 =?utf-8?B?Q0MweGlyeUJiWXdpeU5LaG1xZ2I0cWpsTGlmVERuUmZTZjlKUVViUFRxY1hj?=
 =?utf-8?B?cVFENDlwelFmK2p0VXpXRjgwNVdYQ1BrSzdJY1AxbUxHcHIvSVowNk0zWVJI?=
 =?utf-8?B?Mkc4MHBTSWpZcGJQWTN6YXdpcEg2SWlGQ3ZBRnFvTnp6NVA4YWwxTzVNL2lj?=
 =?utf-8?B?ZXdLRzhtYXJVcWlRSmorcmFldXRFU1NVN2Rid3YvUDRWeERlTVdNQU96UTM3?=
 =?utf-8?B?N3hPLzBRZDUyWmtreWRuc3lTRkZDUGdjWW4zUTlVc2VoNG5lQk94Tm52S3Qv?=
 =?utf-8?B?elJNT1hBMWIyazRhTHNhZTgwTGlrb2dZUFMzdE92Tm8yMDROak1tSk9yYSsw?=
 =?utf-8?B?LysySnU5V2h0QThzZHdQcms1cW5xSmU3UThzMFRjTnVSOGpVdUE0VVg0K2xX?=
 =?utf-8?B?WDRxR3ZzRElRb3MxR3pScFc5REYzYzEzbUI2U0hRVUdvUkdRZUNjR212UVpU?=
 =?utf-8?B?dGNUWEh0SGVwMGI1WnJGVjR2Zi9Ma0hIYVgxRVVZQlpBcytSMUE0d2dadm5p?=
 =?utf-8?B?bzRIVVhUck8wMjRCSzgzZ2pXeENXK2Y4NnFxKzA4aCtvYy9vM1NGWHZXZlhU?=
 =?utf-8?B?eU9McGVKNmhMQXZ5b0diMUl1Wm5vREorWG9tWWRSMWFBSjlTaDFIL1dDbTJK?=
 =?utf-8?B?RWU5ZkRrSzRKeGdObVRZbTlSQXB0TzkzMUpOYTNZSlovbnhwcUdFSVFZQ2d6?=
 =?utf-8?B?ZzF3YzExMS9TbkRlRWlFMkRqWjE4QjloZ3gweWZCR0hoSS9XdW54MW13dTlm?=
 =?utf-8?B?MFV5dWo0ckN4Y0JFUEVDemtJVG1iczU1K2JiM1NNRDR4QU9PL2VwMVRwTHFQ?=
 =?utf-8?B?NVF2Z3hqUFpSblErU1hsa3RCVDlZempwNVFRU01DRTFVdTFjTG9SdkxndkJv?=
 =?utf-8?B?RzhQOE1HaWNBOVlPb1JPeVN0RTlreVc2ckRGQW5CdmltSW1FRGVTb0hxcnNZ?=
 =?utf-8?B?R0ZWQjYvQ0xybThBZjlXaU04cE1KSnFlOGhwVU9Uc2cybTllVTdKQ2RVeHB3?=
 =?utf-8?B?aUJOOS9xODFzZ3RSQkJSM0ZVbnd3dW5KMHFVZEtYV1lrVWxZdmVZTEwrYzB4?=
 =?utf-8?B?blczeHBZNWFYV0FxQUZBSloxcW16Rm1GU05XVjMzOFArK3U2cjloS202ZXFK?=
 =?utf-8?B?cUo4TzFWVTRDVDlUMFJaa2lLdnE1Y1F4Y21ZV2xVaFAwRnF2cjhjYzZIWU90?=
 =?utf-8?B?OEIwSjhqUEQwZXhZL0RWODFlSE81R1RtazRsUnJGeS9UK1pFY0NpZFFGZzdZ?=
 =?utf-8?B?YktMMC9ycTAvUExvUW5LOWh6R1FpeGNlZktJeFloaU1nVCtscDJqZVBXR3hL?=
 =?utf-8?B?dzFnN0ZreHVLQ1g4a1BITG1EaDZpdnpxYjREM2ZGa1ZoQjM1NnhycUZvNm5j?=
 =?utf-8?B?WjZEaVZNYUROUkdaYWJJZGl3TjRNQXRFMi85amE1L0d4NlIxWUNOR2lqdmZ6?=
 =?utf-8?B?clMxNDdYMlVqVGc2WVhlVDhQaE0ya0pLcEsxaVVVbkJ4dTJ2aURCaXhOb2ls?=
 =?utf-8?B?TGRDT2tYL1lRbnUzbzhQaUE5ZTJZMkVOUElwbTd5dUVlVHdRNFZta1JITEZB?=
 =?utf-8?B?ZUg2N2M3UjFVRU1ONjNuek0zL0JqamdKdHArOG5ETzVaVTc2cmlQeUJxenh5?=
 =?utf-8?B?UExlaFlPZUNvQ2NKaW1HVWxQRHdLZlYveXpRUXpDOFFva2dyL1UyZHJ5TSta?=
 =?utf-8?B?Q3JBd09OakVFWEhRREgwMnZQeXo3dkhpaW9qSUp3VUVBekloUXBrcTdSODA4?=
 =?utf-8?Q?YTAsqiD8ti5dBFRxodKO/L0aS3GY6R2xPvzV0lDrGUtE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u+vfhNito7Wvgkk/N41xy5NMzLLANw557W/CHp1RIDQrJ9kNDRUhbksyidugVVw+HXcI0A6AFZKJ8SbC4YK7XBbPrSKc7JzLT0R5lcceftY91AvnJsgeiOgN70yGbcEDdYkKakp1DAdrfphQJFILUZ7hJ4HSLQ7d7phu1l94OmAZ55rdw9Y5QnrPHC9eK7E2eXRTzY3Wn3ZcWiR42T5M8cslv4uIHXRUnWwiQX6+FWgMrOTwVm1QAlQOE0oj2FZ8N/yu0KrQCLbLiBU//B6QBh8aA7mohuYB7sLDYaXmQq3gxG9scbxEqvLZhkjhIpIrSuxb2hOVzJzhC4zc+oBq2+YP36R+W2hE1X+Yom8wOq/NB46iBoPhffI4xPX9CjTRPg4C/Qem2hbnWuQ4B+mlsR/Enj3IbjTMoK1Eh8Dt0/RglG3BAmYA3uE9QZcz7dmrub6Lo2eul2eow8A+Le7JT/9m0L/bB34bF/aGWp5WjwN57t0awTsrcbZdTKGF7k7PQ4cSUdMlNcBmZfihWOUXgs2EojwiTI5AgqoCejh0uQR1FYZ2Kmd1JqJjDezgp3mnpvDPFraHeeioo6R4dvJ/TSPa7BC1IwZk545EWAg2VZ9UiamTV1ggRfR54LW29hHtIPALJIQwt5gKGYw5M43en1O6DWx3lLH7hw1++MMz8dNiLYR1rtKSoB4PM+5m2TkqUlhUCTRuHQ/I8uNkPdIYon+jiEwqc72DaJvJG6N5wPbs6PVVJBWIwQ71wY+IJR7A16dRR031UGUJ+HOzYbfXlt1ZBQtC9QpV2FN8mTpec5h6m7z2ETzFQRaSxbNa2u0pa1KjShUppSE9cIfo8nYuxg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795d7f92-4711-43fe-3f50-08dbd043524e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 01:32:56.8933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIHgAZNlkq0dSk+aM4YX4wjqbr7oZ2pR9GE34lDD91BVi+yB6zzKEl3VqU0eNjtU2+h9I9SqqHAaqAG+xcA6Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_01,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190010
X-Proofpoint-ORIG-GUID: qZRl7XqI96jgffg0TYvuxXpIRUiDgOLq
X-Proofpoint-GUID: qZRl7XqI96jgffg0TYvuxXpIRUiDgOLq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/18/23 05:19, David Sterba wrote:
> On Tue, Oct 03, 2023 at 11:46:12AM +0800, Anand Jain wrote:
>> v2:
>> Worked on review comments from David.
>>
>> --- v1 ---
>> This patchset adds support for testing cloned-device in mkfs.
>> So using mkfs.btrfs both option -U and -P a new device can be created
>> to match the FSID and UUID of an existing device. This is useful for
>> testing cloned-device.
>>
>> Anand Jain (2):
>>    btrfs-progs: document allowing duplicate fsid



+        must not already exist on any currently present filesystem.


There is a white-space error at the end of the line mentioned above in 
the devel branch.

>>    btrfs-progs: add mkfs option for dev_uuid
> 
> Added to devel, thanks. I did some fixups, the device uuid is printed in
> the summary and validation of the device uuid.

Looks good. Thanks.

- Anand
