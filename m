Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A0859A9C4
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Aug 2022 02:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbiHSX4e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 19:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiHSX4d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 19:56:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192FD1152DF
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 16:56:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JNsdW4030787;
        Fri, 19 Aug 2022 23:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/8qFtDe3RDWNqtv5UO2WQ6r6j26PLR/VevYq7XdDC8c=;
 b=EBJaYbLyEQoQGL9Px0FWMPfIoYVmhmZJsTuAGaj8nU4K9IycowM5HDW2nGkKaBHU/Dcc
 p6ta2MZnJRNE+ztcS92DVjgiyGZwTSMMNeF28KHqmdZ4FFn+tPtEK+r6CP4P+8ZIWCxv
 dcqEdufvd+NEWpylLpDyS5EjB71sIKe4ZrMTwBpPFbd96oYwel6z7YBSxt984RtvMcwk
 f3HQiUb+A7q+LUAa9+kJX2JuxTcfSXRJ9WUxOzVQpkEDQh5bHwuibv5CJ8IeYB4rfXXK
 tzwJfg2cxgE4iSp2kkSlkd/4f2Gt3GfQ5bNHpahZOhCBjH2NRay0HeIWCLau5n+CIWzR Fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2mkp801d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 23:56:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27JKB3DR023845;
        Fri, 19 Aug 2022 23:56:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c4a7tmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 23:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSXcU1PnATN3u8tNB4d0VyPQgYVhreOvfR+Jv4cIMblI6VsRcv6WZbJAWSb/8sPaLubf8UvL+wbT2EXcLubbQDZPvSRlD+1CsLokjGyaIu63+h6+HRdbU7DOhIO11u0MXx0DI1ufpGtcmj/nl6Zkaoiud/N091KkVSpXadEZ5qbxsG/oLeb5Fu4Lf6Oj3Of9xcI5mmTy07KwtHdsOABj7nD7uTmWjFC1+ZqFSd9Fe2OO+LATcyLWICFILKfg0e08VwZCEDmxETtWBLTq2YQg2RAUPGrXODqtKjYwAf9RY1A7VKW3zSNrzowdS6tXs+pHN+U7rtGs3sZ8VaW4qx22Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8qFtDe3RDWNqtv5UO2WQ6r6j26PLR/VevYq7XdDC8c=;
 b=NU5q/3WnCN452E9nCCnExjKw165x7v81Pp7zuPOtfnZ5fd57z2bmKxi6+rg/dOIWcSosaX5fkeNQ1x2uwF9nKR5SRaF4NWni5wUBqpLBI8GjO5Ea13znaZa8CSewVdt0rB9GDyWUcGkw2Gs38cSBEKwZ+VXM/upurV7zgchXXLGsPFO3wDF+Wl+FQJPcET1IeTprQOLkEimRh9k2/HwY8WcUsyqltpQSnTsTfZxuenRiplHtet4UC0IqECme4qqA1RmqP4e82SJh0nQ9lpXtp2hiG+5MtjmG9PW6PED8/flLDHdAJxfxhK9QgbQ10PTmZBAMM5issM1xzfWzoLcn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8qFtDe3RDWNqtv5UO2WQ6r6j26PLR/VevYq7XdDC8c=;
 b=S8+Z8I9T0SUyCCzVwKW5CekJDXvQmcFwGQs+yEM0B8blBUg2G7bLjHaUGfLH2hJWIszjJiuIDVVCWnJq2GHEbhbT4jJ4f+/Mmb0Ak6+lX4xb185NgmsUmdni8Eg7Z4bsuXbTZNCnKq7unZBv1rrtn4sYyotPGF0xsqeX5AFkRBA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6166.namprd10.prod.outlook.com (2603:10b6:930:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 23:56:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 23:56:22 +0000
Message-ID: <d082ed7c-5a93-8ec3-d104-4b7b314ce023@oracle.com>
Date:   Sat, 20 Aug 2022 07:56:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 08/11] btrfs: split submit_stripe_bio
From:   Anand Jain <anand.jain@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20220806080330.3823644-1-hch@lst.de>
 <20220806080330.3823644-9-hch@lst.de>
 <5fc0a3d8-d9e4-8b06-0544-c7e4a90d775b@oracle.com>
In-Reply-To: <5fc0a3d8-d9e4-8b06-0544-c7e4a90d775b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b940298c-e3aa-4fc0-5f2d-08da823e6ae0
X-MS-TrafficTypeDiagnostic: CY5PR10MB6166:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQzBtJeuveiyxnUb60DIcdoA/uyj96KUoCU1o3oXUN4dyFRCozY2bmVYnQZpRWlxaWqvWG67zHxCMZfPkmLfO0PUEZ37iFytzcYmlQMQCzj7TYIHuRcuwrruuoWJvKi8X9nGtu4d7y9hz7yG0biYyU66iRLEpTrXnnFfIfCxepd+QNqYmYEbSHvbDCN+x+y/5Ogr5LoZTYs0SXgHUKnyxPwOn3Kvq1QPx5pZLHbCcIedPz0BdMKeHLhR57lInTYPdf9emY8px/gpbCikrRIxGFpEiHO1P2jvGvRfeJMd4NO2rfYt+yZuHR0F6GiFI0D/zVLq6KT6lzz6N36Cis8ydDDFySe/uGYR9Qs2DM20JZgoAs3agtF2bKKjPobfzqYQpE3mG2v/aPmFa3pfrIEy/A8yR2KH3vqGHyOGfVTUnJD8wjgaUgIxb5gxn7AXUNJgAbT+bGmjk0gtdM5nCQ+U3Q0w4FhtKxw/kukyVnDrqs601UWup67A70wcmjyIDJZRYX2ZozRKH+zzGsB/p/Q7nf8tc7fqjR1Y9bw3rebgYtsq5Vlj7TeRAooShtciOFDKeHlyPStrAJuhbkaahtJb5aKIHNUuiVakvkRfgAhx0zFgjR3GQ5YQDtL+ddL3owy9vJ55uO5Qb8Iuh6OpJdZZ2eYHm4fRKdvD72OQEbWk5lTlA6VP9U0sE0Ft+vKNIumJkUsMMZOyFgHHZjaU4vkeOwrf5fMYeBR0SdygHoItkwjyLSbd6TRKAA1PIiDYVtcQKksGtKvYj005vSLQ/LLka/nisNPRxZHEq9fGItu918M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(346002)(376002)(39860400002)(8936002)(44832011)(5660300002)(4744005)(2616005)(186003)(54906003)(31696002)(26005)(2906002)(53546011)(6666004)(6512007)(6506007)(478600001)(316002)(6916009)(6486002)(36756003)(86362001)(66946007)(4326008)(66556008)(8676002)(31686004)(66476007)(38100700002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZ2bE13Qnc5enBSd3k5azd4dEJwMXlEdkZ4RkFvYUwrMWJ6OXZVSTJZL0ZR?=
 =?utf-8?B?Z1ZPdHpsT2VjWDljUWc2WkE0bHJiUzQySDBsVXZVMmlXSThjUE5zaHBtMnFE?=
 =?utf-8?B?WnFYQ09GdzBUNC9WNFBINmtpMTY3SnVXNmkvbnlqUytyd1VYTUJhZy94L21F?=
 =?utf-8?B?bzY5WlpYWTE0ZzZsSzlOMzBuY2w0eXRnOWt6dkx4c2tYWTdUR0N1Nk1aeEFH?=
 =?utf-8?B?bmxhdGpUYk85RzhxSU55dlU0NkVTVmlsa2REOUVWK2EzNzBQRHlISk90eU5u?=
 =?utf-8?B?M2FJZE53cEpwa2xDVDZJY2Q2dUdKbS8vZ3l1Y1BsK1BkNmFXdDdjb1FhSkxi?=
 =?utf-8?B?RkdNNS84YXdINFE2dWZLQnVWTnQ4VXFJRmhpNkRYZmZYWlVQUGpnTEdXNGdK?=
 =?utf-8?B?MEVqWk1ObnBKY0pxc3BoZldHcTJVY280ME82ZmtKZVhvT2JyeXN2M3BvTHRR?=
 =?utf-8?B?RjFmT01PeVBIY1I5OHVOK04vM0dXRXgwOXBPTFFiWXduZ2lWYkkyOW54VSt4?=
 =?utf-8?B?K21lY2FWTzBtMTZxLzE5UUZqeW5HTkxQRmpvZkVwQVgrV25YVDRqWmlZY1Bm?=
 =?utf-8?B?R2lnenBKUWJWV3FlY1Bnc1pkZEIzY2U5U1c5dUpYTkJKNkR1cGhmNHFhNFh3?=
 =?utf-8?B?ZTZnUUxVdzh4K0RKZmNZdE1Bc0svcllMZmg0TjllaHlNNUhYUVFLZkpqVkx1?=
 =?utf-8?B?ajZSOTlmWUlnWW1IUFBrRFArUWRSaW1CSDB2RGF2TnQrQVNhMGZ6Mys1RTdR?=
 =?utf-8?B?OU5aMlVQYVpjaDVueVNtNS9YODF2L0JWQWtHeWJxb0pxYlNGSG9PRjA1Vkhk?=
 =?utf-8?B?VityRlU0b1d4WGNDRFFLdDB5VHlhTHlCR28raUlZY1dDLzlxQjB4Um5kYkhE?=
 =?utf-8?B?eW9OMXB6aXlkUzZ5NmZ5OE95L0c1TDYzUWRiRDZtV3U3NlhtYVNQaytFY0JC?=
 =?utf-8?B?WXQ5TGV5ZXpBbWNsRXZtcDlQM24wUms5ZnJzaEF0WU53WUdVbjJmSk1rZ0s0?=
 =?utf-8?B?bC9FK0F3ajBTL1VOZnZOOTQ4Wm1sQUxqMmVkd254SDl5em1CTi9JSEI2UG5W?=
 =?utf-8?B?SHFhWW45c3hrUE8vY2ttMVBudzdvdW03NW9aRCtnOTJSWFMxS2ZicWJ1NENu?=
 =?utf-8?B?WEI4UEVuQ0haUkR5UzdqNEpiNGxKRmxDamZrM3JsaXh6Skh6anNBUkk2UjA5?=
 =?utf-8?B?N0dqZktTSldTS2RCaG1VZU9VRmRKNkN6MWY2c0IzWkdYUktTTlFla3VXRlkx?=
 =?utf-8?B?SHRsUCtvSE5QekY1NzBhajFia1I1dlZRRlZaa3I0ZzZGTVVCMHhQZU1NWFM0?=
 =?utf-8?B?eHpiVXB6eVNQV3kvbm1oTjhOOUIzM3RVY3A2em5JL2dQTW85N1Q2RUVQbGVp?=
 =?utf-8?B?dG84YklCNk9rd0V4UTg3NU1qdXV0dTdvN1M3bzB0TDVlcitHb3B1QVMyTTYy?=
 =?utf-8?B?MGJXSm1HaDlSOEdmeG0yTURHWVJwMmxQRWh1MEZ2MXlBN1dFeHRMTjJ1bEFz?=
 =?utf-8?B?RS9zcTBsUERyeXdaY2VucjZVUkVMTWlBUE9Cek5uNUhsb1RnNFRkT3FiY1Rh?=
 =?utf-8?B?bFE1VTQrd1Z2OGZHM3BlUE9MVEpTaVV0aU5Ebk5nR24zRmZ2MU8vMXB5SlRP?=
 =?utf-8?B?SllHVDJMTUh0RGxZcVpuN2tJdGNKYnZlZncxWlVTNTE0Q0RuR3VlcHVwcHhF?=
 =?utf-8?B?dGtBckNVNHBwWlhlcllDT25NdW1sdXBGT0lPYnZ1SFJQY0liMnJqaUk5VEox?=
 =?utf-8?B?ZXhPU0hWRHFOZlpId00vQ1VUS0xNVVVKUkc4ZDA1RDdadnVGOHk4SFBodW4z?=
 =?utf-8?B?aEEvWEJsWUZORi9OTkJISDRydTIvejlSbm4yVzg2UDkwb1N0Z1p5RkVNdnc5?=
 =?utf-8?B?NFlIcWltM1h3blhxRC9kelVVM3QxdkJZejkrU2h2L1NXZ2lFNXdDVWR6Y1pm?=
 =?utf-8?B?bGVUUU9nUVhTNEdkSU1VQmQ5SFRaNWhGQlU4cWFEdGZWQmVVMEpnNEhlZ05Z?=
 =?utf-8?B?OStWajJOWkJrSWFkYmxNN25MazBmNmtoM2xCR05HcG0vWVpGZmo0cUpNTDdT?=
 =?utf-8?B?VXVHaDFMeGlobHZXMVJ0L25kMFQydENaOFZxaHQ3czBSVk50Q3lIM0orcjU2?=
 =?utf-8?Q?OunN3qie6CqO0S4tm1TYfNBNa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b940298c-e3aa-4fc0-5f2d-08da823e6ae0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 23:56:22.1518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTcXBr6eo85TgOe0uDZ0zLT8T8ZLP9BubCQTBEDueNycNBmzljBP2EhSCs/s4d9sIKhXRT0grJJWx1NsOvBpsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_13,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190090
X-Proofpoint-GUID: nVAwNzmW28jSCVOZsY0-m1y5U2EEIhqk
X-Proofpoint-ORIG-GUID: nVAwNzmW28jSCVOZsY0-m1y5U2EEIhqk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8/20/22 07:37, Anand Jain wrote:
> On 8/6/22 16:03, Christoph Hellwig wrote:
>> Split out a low-level btrfs_submit_dev_bio helper that just submits
>> the bio without any cloning decisions or setting up the end I/O handler
>> for future reuse by a different caller.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
>> +static void submit_stripe_bio(struct btrfs_io_context *bioc,
>> +                  struct bio *orig_bio, int dev_nr, bool clone)
>> +{
>> +    struct bio *bio;
>> +
>> +    /* Reuse the bio embedded into the btrfs_bio for the last mirror */
>> +    if (!clone) {
> 
> Nit: Why not as in the original, as below?

Got it. Patch 9/11 reasons it.

> 
>      if (clone) {
>          bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
>          <snip>
>       } else {
>          <snip>
>      }
> 
