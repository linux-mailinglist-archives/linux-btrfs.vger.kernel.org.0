Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036F976A11B
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 21:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjGaTWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjGaTWo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 15:22:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC8B1708
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 12:22:24 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 36VHWYPD027839;
        Mon, 31 Jul 2023 12:22:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=p8Um/eVOujgEYdMJV/lo0S9cbOTR1QvrOfvNpFWJ3E0=;
 b=j91jGG04CFm3xw5b202pwijceGv5cQoYkC2ILFTHBh3jrT4wyMzE1jeStlTieUiMOa1c
 IBi61L03gvJFXIh8BtpvWRf0nzfxEcnOHDvEIsE+pWL7bLeLm3QsLVyHgdWTZ9DnGq24
 M442RHXzvjww5izWfGeSZx9rSoF0guwySJ2QpYwOasQz9FJcmO7QIvpbUawnGC6OXAOq
 bWpyricGXqDAG46z0aN75IilDN2M85aAlDVUEzAFes9hYQhBjrS8S0UHROiSDsSIzXar
 lRphfxNRd63975+xQkawGgNVHsgf0HQjL836l40gSiyPnyQ7oyYms9kShZFdNn8vT/CL Fw== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by m0089730.ppops.net (PPS) with ESMTPS id 3s4x9bjbut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 12:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjOp0l0fBbJKm4WXluyqMHzdDDeqQaZSRU7NOnzkde7Zff0n/KJOFEa9i+sH690sIbnXeNYO27P/WEXJsvCX1ZOCq/uso5e08IvV/0HLlJjH8DCVW1Sbbbm+U+tW7qQLuQolq/LDWd6cFrN62cgj5CKNwmQAEjdseK8sF7pKfYE1jMMU7jC7PnTvQPEGgrolkial8VdYqkr4Fsh5H+SFkoc/ige4dJ7LGaTlXvmH1Zg7xuXjmYISfMjqDm+GLzIoPPjLn1II4WGSCePOl/lwnWoAUb3FE1wKlZOm0R3vcAUTWb9vKKgZoebazXv66AC+YCaaBpmF3h7biNROevozQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8Um/eVOujgEYdMJV/lo0S9cbOTR1QvrOfvNpFWJ3E0=;
 b=at9zZT6kvE/gWpk0P0U3m8yYbgpTiWf1OUaIFZD8hIlf9CayGrhyOVXdcggMHfwFlPA2Mp7a061tXSaWQWuCbmaPuZmaL9HCWNbtUMbG/qfw2lXVs36sfR2a7AXQiANV+5DnRHWlCU5h/cpspmPVHMN34tFu7zr26XzqaOtkdqF4YaFPRf6P0Ocmc9xO3KDC7iKidZBPs/uWpAItJntjcB676q2Ddt954xa6+Ye8DCAwDr6gft6XY/mzpUKyaIWe8Mt8ba8EfU+kH7f7rQ6M4hL4/uDUVrOXZzcD2mipg3fBdDZ1h1X9k6+yapCMU6HSh1UVS7kNscq6OPR5TDPbXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by MW3PR15MB4012.namprd15.prod.outlook.com (2603:10b6:303:47::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 19:22:15 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::63a9:9663:f1f:fb80]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::63a9:9663:f1f:fb80%5]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 19:22:15 +0000
Message-ID: <0375397a-dd5c-4b3b-53b7-1d2da33ef845@meta.com>
Date:   Mon, 31 Jul 2023 15:22:13 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH RFC] Btrfs: only subtract from len_to_oe_boundary when it
 is tracking an extent
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, josef@toxicpanda.com, hch@lst.de
References: <20230730190226.4001117-1-clm@fb.com>
 <d83bd29b-9744-cf48-c5a5-24668a6ec4f5@dorminy.me>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <d83bd29b-9744-cf48-c5a5-24668a6ec4f5@dorminy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:208:256::15) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|MW3PR15MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: 598d500a-8107-4d13-69f9-08db91fb72e4
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZ5YfvDXjfv0QwBIri7LTi4GmqGT530/yw+yz4FGab9+86bFvi1reJaW1qcJI33MqMWknPjexg/qIbkI7GBOkiXtp89DDEwC0D3rZzQOack+Ek7wMhTxkEYXduMIhVQzwb9BuQY1tS3NQcUl1X5G668tbH9MA9GG2AjieOQwhrsVpkY9rGwfvmWJIi78FWXjWlRl25aN0cyxov+kkMl9pSzZBCR8QNUA5YBTEHh+BI4JmM14uBJOee1gakTzPEEHhkF8ZEAz5tAm3O993NBTypJaHzEa4AlxvpyDCOJFhl7Brt0iulYpG9HkowfkSwTagnrPzk8g8RCfnLK8K5dzp9T3HoGMHhSUKIg7qXw2FfrGsfV4goOfqz3Q9siEat9Rus8iYf+Pz/N/beMP3iesh3c4WDk9muLXCb9GmKAZ+I67XpTQdQFglhVDz0QgpEzuZ5jB2PIb0RWglBxFls45N9sRPPtop0w+Om9mOG90ULUjN+pZsvlpFmaTI8Mghvd6P+IyKUTceyG3RO8h70fBB7VSHKGgfTPq+m2Qt8R5UrG0GJ1brsU6VzY5rQPummeWLguUzDXn9AfeVayFQ5Synp4hDEvrweXP8fPgGf89k5xhPzKhfv7Flexm7coTxGZMV+uCY8O2SJLWwZJG//zx0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(5660300002)(31686004)(478600001)(110136005)(38100700002)(41300700001)(6512007)(8676002)(8936002)(53546011)(6506007)(2906002)(6486002)(66556008)(66946007)(66476007)(316002)(86362001)(31696002)(186003)(2616005)(83380400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk11TWd2aEpxZTE5dkRVMWgySlNUcnhRUzkyeldlTklUOTVhNXRlcXNqcEsz?=
 =?utf-8?B?UWFVL09tZGRVTGxJZWtWR0lPcWVvdlYwNFZiVG9waUpoKzBrZjFmMWZ6LzZw?=
 =?utf-8?B?ZXZJVmFkdGZDSkgweC9uUEpHQU9mMjlCK3VNalJPMXJKNWJONkJuV2t3SVhY?=
 =?utf-8?B?eWVWVW9YUU1EditOakVVRDBrdHJTOEwyTE4zSG5FSmpqbkxrclFhVXpDT243?=
 =?utf-8?B?MzdEdE9LR1dvS1B5alBGMnVDUk5aRWJHSHREeHBwRkhQdkc2RkYrNDBFYytp?=
 =?utf-8?B?UzY3TmZzWDNxdVVDVmxCS3JqZ3I4cWxrdGdINFI3clQzTGdCbzdUM2JUQ1hC?=
 =?utf-8?B?VXVTdG5jNTBnR1FvSHhpYmNHb2tGVEN6WFFpUjZPQk5QNmhNdjVBMnA3K1pX?=
 =?utf-8?B?RU5KcFlUNXhIU093ZXNxbEtrWGMwbEJjdzcvTitRckVadVFyMHhwbnR3ZVVO?=
 =?utf-8?B?NjBOdVpwSTZYNXNPL0N2cDhCcCtKWDN5eWtNVHh5eFFwSVM0YjIralBtT0NX?=
 =?utf-8?B?dk1ubkRwYkpkTjZHK1hvbVo2R2lLelpka3c3aTBlUXlranJPK2NMYzNUaG0r?=
 =?utf-8?B?WHpqK3ZiRHd0L2htWm43bzM1cml2T1QzWVlHSGVpY0JyTitTZTdyTW9lTTBZ?=
 =?utf-8?B?V0x3VlZUdnhHZVp2cVNIZ1M0UjJUcUFWRE9GbTgyRG5mbU5HSkVrOG5UOVd0?=
 =?utf-8?B?bzY4U3Nra2dNN0l6cEYwWmgrUVZCdko2R0U3S0N3VklsZTlyL2dPbjlpMGti?=
 =?utf-8?B?RERmb2hmT1h4Q1JsRVBnWm5ocFdqZ2N3Z2x2eU5JUnJQS1dUV2htb25sVFBa?=
 =?utf-8?B?SUNRTVVxQW1WbU0yVzJUd1JaQ09aK1ByVjBlQ2VtVnQySEtvcWVucWR4MStv?=
 =?utf-8?B?SmlGeUVyUmxrdzFZaGFGMjB4WmxoaUhLMTQxUXBHbkdRRURORTkzdDZESXhC?=
 =?utf-8?B?Y0lpZXJTVUp2YWdGTDlhUlUwMHp5eHBpayszQlp1R29qZlUvL0dBaVRTNFpI?=
 =?utf-8?B?V1NhNDJVR2luZVVvOGJ4aFFkaUI4WVRmZG4rb0ZSbHNaM0N4Y2xZUHZNb3o3?=
 =?utf-8?B?TWxwbHpqcm9BK3AyUHBSV3V6TmFJc0RrekRYenp0aVFQd010MThLYzFJdE9C?=
 =?utf-8?B?dFNuUmEyUHVwVWlKZVpaaTk1NzJZWVoveThvZVdmc1gzeFF5SFVmR3pPanF4?=
 =?utf-8?B?QldYRzZOVEZ6Q011K0RxOGs4VmdvWmhSVWFQRFVUamRrVC9hclZMcVpmMG81?=
 =?utf-8?B?ajZwZHBxVFhaMldVZU4yTWNUQWpyMmRzNTA3SldLZlZjek9YRHVnVjlzTkM5?=
 =?utf-8?B?aTUyalhOOEJQcmpLdm9Nd3RsNGhNOVFvZDJOZlBhUXdUbHcxUS9MTVFoVCsv?=
 =?utf-8?B?aTV6ZGdWNWtEZkwvaDRHSFlSY2FsVHZBL2VrNllzSmdneVJ2LzdWbUxSRmk2?=
 =?utf-8?B?NnUvUCtPNTZyNytoNHVvblJpSkUyTVJiRmQwMndUdzBqQUhzbS9UQ2RSSFFU?=
 =?utf-8?B?bEFzMlB1cTFRdTBzWUVkdFBlcEthRUxkUytWaHprNlNqYWN5T3RSVmltVDFq?=
 =?utf-8?B?TGxrVWtZSGtGSHFta1ozcE5BWFRFeEVoMW9GWU56RVN3c2w4TnZBUWFrVkdk?=
 =?utf-8?B?N0M3WEhkek1MUXIzNEQwdkZOWnl1RUliUmlvTHByT2pZOUhsdHQzbDl3aTd0?=
 =?utf-8?B?R000RWRFNEVOemE4ZS9SQjduaHlJL3lHWjh3Z3dORmVKZjJsMktKWjhTTWkz?=
 =?utf-8?B?SWFtOFBYclM4QWZpRnlIT0J3bEphMG9JWTd3aEtadWVQREI4WlZYbGQyK2tS?=
 =?utf-8?B?VnhtUmVWR01TUWt4ZUExNFhPNysxQmRWd0MxbGdmeWIrdTZlaGFNYXhaV2Fi?=
 =?utf-8?B?SnR4bG1rUlNmMFZYWURkRTBUNVlmSmhwbXdTOXRsWDQ3V0ltWlFGOCtEbkl5?=
 =?utf-8?B?UzQ1OVl5RjRra2NqcU1HRkQ3aGh0OVdseGpNbGIveis0cVdwWnkvMjl4UEJR?=
 =?utf-8?B?TnQ5RWVkVytlbS9BUHBkTTVhVjdwV2tnQU9CN2UrWTZwZkZGK3N4eGJxU0N2?=
 =?utf-8?B?OXZSNEQwbUlYbWpTeUxMY29BQzBOaERTWEkrSWNpeFdmd1dKdjdscTB2S0tu?=
 =?utf-8?B?OEMvV0tEY1k0T3pTZjBoN2ZnT0FsRW82eFRLb3hoemJXMmpUVURaM1NhM2Jn?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598d500a-8107-4d13-69f9-08db91fb72e4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 19:22:15.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3FPAtGseJz9F20yxrz3b9x9pELqdgnCyGMrhnShgwUR9lFE+41g/rEVJUryFBdV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4012
X-Proofpoint-ORIG-GUID: kfE1p7AqmFbRGcCDioSDr5Dlc4lZnycn
X-Proofpoint-GUID: kfE1p7AqmFbRGcCDioSDr5Dlc4lZnycn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_13,2023-07-31_02,2023-05-22_02
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/30/23 4:27 PM, Sweet Tea Dorminy wrote:
> 
>> +        /*
>> +         * len_to_oe_boundary defaults to U32_MAX, which isn't page or
>> +         * sector aligned.  So, we don't really want to do math on
>> +         * len_to_oe_boundary unless it has been intentionally set by
>> +         * alloc_new_bio().  If we decrement here, we'll potentially
>> +         * end up sending down an unaligned bio once we get close to
>> +         * zero.
>> +         */
> 
> As I understand it, the important part is: nothing should use
> len_to_oe_boundary unless there's an actual oe boundary, U32_MAX is just
> a placeholder to convey the information that there's no oe boundary.
> 
> So maybe:
> /*
>  * len_to_oe_boundary being U32_MAX indicates that no ordered extent was
>  * found by alloc_new_bio(), so there's no boundary.
>  */
> 
> I think talking about doing math on U32_MAX here obscures the main point.
> 

Jens wasn't surprised by the idea of a bio almost U32_MAX bytes long,
but I needed a printk to convince myself it was really happening.
Talking about alignment and seeing bios in the wild of these sizes helps
anyone changing the code keep these corner cases in mind.

+/- the part where Christoph is deleting len_to_oe_boundary completely,
and he'll drive this code up to a nice farm in the country where it can
retire in the sunshine.

-chris
