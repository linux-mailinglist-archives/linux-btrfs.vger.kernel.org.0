Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2CA4EE589
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 02:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243613AbiDABBD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 21:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiDABBD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 21:01:03 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5F21B2C4B
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 17:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1648774752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNjD223UCH9JEYo5aHS/UukBNYkQmQux2iCP2mKxbus=;
        b=Hmqerszzz1CmtzN9MVSZCPc2tGqDgQ6YuhGDQTqqWO2dNo9+5mex4ahDKl/ofmdvVwq6e8
        iMdS7N0FexAPobEdrNh5lKl+jtTFCJ2/3Am4l9ysGUfmwkDYOWAR4AcjgFsnCot/68fjp3
        FBoiqskzYk443DTKIsX/hAAveqYZZd0=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-rfJBrkyFPgaE4FsqqGGtTQ-1; Fri, 01 Apr 2022 02:59:10 +0200
X-MC-Unique: rfJBrkyFPgaE4FsqqGGtTQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvypumZxB7qxz9dzmdOuzMZLPRQOTTaYPxfanp4dW2urTYkeBms4ERjfP1EQIeilzEa0Nny8F4pGR6MafoR5q20nQQ5sQKYYDOt2dv9pw5TskFO0zrpKAyMCGfSlglfqjqzk1tNspKdos1kDoDM1JxTT2X43310RGSYD2T7u/Ud7MR6U/ILH1aSrrHK4AIZwaSaIWKf7ZXvmbdgGextOTjbfWgcgCCqmZqMGXtnqJZWCsNJMOkrzAwVbEuRCotNyexsM7bxHEPxBVU7GGmhJxMyVKDZOfP0CZVDaB+jq8N03UNijmHoD7qoY3W79v6xUrx5BZviIdDz6xA2FLzkBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNjD223UCH9JEYo5aHS/UukBNYkQmQux2iCP2mKxbus=;
 b=f/5jowt8uVSQ9YOnXnxe+DBzkiGLk7patCBElOaYpMHgPWE4Ii/qAZBLkcWfipJIFQepAx05UglTI3pnhi0Sp9hp1ApFuxrf3ralFB5EgNDmMjufvPiJxyVYzVOJZS1S34FDp15whzPr7w+THNYy2BPvBub0VBmM9y9poJE4rEEIH8X4BqHejBWpFGQonmOY9aDgyGp2XMRMr8NF07swD5Y1eVflR1J4qgEIKNYPeYiOhbzm8W39jg4CeV7sNN1ic7Z2TnzO7zvlTz8qgiuhi8wbngGIM2L1kEwKTfZkSfurS4TdeNj9FAeb++pvBiu5albPXS1jIqp0SUTMSJM4QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DB9PR04MB8202.eurprd04.prod.outlook.com (2603:10a6:10:24f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 00:59:09 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::f9ba:fd9e:bcbe:d883]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::f9ba:fd9e:bcbe:d883%7]) with mapi id 15.20.5123.016; Fri, 1 Apr 2022
 00:59:09 +0000
Message-ID: <bfa7ae69-6a2b-af93-cfae-9b7c929d115b@suse.com>
Date:   Fri, 1 Apr 2022 08:59:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: btrfs volume can't see files in folder
Content-Language: en-US
To:     Rosen Penev <rosenp@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAKxU2N-FKf-RsbA4S7hrYJXHUe7wJUrRyHGKjzKGgBmNcE1sCA@mail.gmail.com>
 <562b797f-49b6-80a0-4a1e-7dafa1975e86@gmx.com>
 <CAKxU2N9bzKpt94i53vzKgYKaDEGZ7tAj_nE-KFm-71qK3yXDjw@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAKxU2N9bzKpt94i53vzKgYKaDEGZ7tAj_nE-KFm-71qK3yXDjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0058.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::35) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55ae65fe-690d-4e36-ae08-08da137ad404
X-MS-TrafficTypeDiagnostic: DB9PR04MB8202:EE_
X-Microsoft-Antispam-PRVS: <DB9PR04MB8202217ECEA2CF8D3E46A942D6E09@DB9PR04MB8202.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BgSox4WXXW8OECCiD091IxwAqtTRZFaMl2V/ODh6HljcqMaeb6xWNAvQSixTWLFrAmRNuLeLhIXHXvZi4ta4V8rw5gPjpbp3fi+R+Yzadz9nkG9MXzts1LaU/FnQQwAy0Y7oqyXh0+OV4Zsn1G25Hh7sWO5hqLFs+jrOtFh9timAy+QOOa6c1rDAK1n9JEXMXJHHm7al1Kgc/llo0xxWyNBuYBYeMj63ic1oaXIgb2ZCWmXPhlOqBVejsXNlrjcWC7feVKWFfVwmgosRi5rNF/Lh7A4sDgEtmLXaVZ2lRZy3ozyrXIqLlBWG9rN09nbccBMxluLVTXjNRJiBHGEyaSIfPdlI4mJJlc3q0S3EDtmQP5/6YhpixJmH44HUwA1XEoGv/DmuPQvcidiBcPzoNgBDj6G7SLaf7pPt99nZDDxidhfApFrmU0XaFUQtXrpIfmGuLUy6yi5poLe8UJ6Ly+2sUdIgBBmY3AZONvxLS0pMidDM48ur62Qu4vGbp6HQCWrWeuknkCxDIQUWHl3evTtOEK8VN/5W32gszDJiKJi2PHDRFslTNjHq7tizdRHLY1+GP6Ov7+2ANfIPo5LPouOOlNP5fgocsZ19fKLvdxdbz2mCO0CqeXMJ5b39Cpf82pFe/45OX/6XG0GA30vANGx23WgCD2Nriv1e5WIaMUicb4Lg56zFHqOPgumWk5IOwc24x9i+2oGYYOdNd0ep1kBvW0SrQHKyXZPdZUPRIZaKO8cmM8gFT2xTlNJgT2Zp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(316002)(110136005)(26005)(6666004)(6506007)(6512007)(2616005)(66476007)(66946007)(66556008)(38100700002)(53546011)(4326008)(8676002)(2906002)(36756003)(86362001)(31696002)(6486002)(31686004)(5660300002)(8936002)(508600001)(83380400001)(518174003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3h2anI3MlJGQVlvRi9May9ZV3JJSE9YbHUzTkVuOFhSU090VHJreXZkQkNL?=
 =?utf-8?B?bEk3RGt5ZCswQkNwYmNGdVhzdUNwUDNacVdrTEJxdGdmeWdEcjl2YTVxcFpX?=
 =?utf-8?B?T2wwUlg3aTQwZG9ka2kxSk9jSUhDMDJoeGh6ckwxRnJaK2xUaUFheFRNY1d6?=
 =?utf-8?B?NzJCbEFocml0YXB6RVJXLzYrWVJyWFAzUVE2Si9nZUNNY21pS1k1RzFiUkUw?=
 =?utf-8?B?dkgwaGU5QS9FRHZGbDJPSkJBTkkyVkVVSHVTZWdGVDJsNHFKQ0RyUUJJVFNi?=
 =?utf-8?B?eVVVOGZ6R3ZIcHd4eC83cFV3ZStQTjNrVVN1MHpBcUlRbndRR0RrMzNUOENX?=
 =?utf-8?B?RnhWZUFDMFpsYmVFeGF6SnNIeHg5MHBUaHFIa0xIWndraGE0L1dSdjZpMlln?=
 =?utf-8?B?d0c1NW9sMnBkdDkyd3MyaVdQTnpjMzVYTk5Jb01XeEVvWS9ZektmcFBaMmQ1?=
 =?utf-8?B?RlhVeU1Yb0JWa2JLWXBVMUFmcGVFV3JTNTY0UFFLQngwV09rL2ZIU2plV3Fw?=
 =?utf-8?B?bFVBVENXTzYvN0JySTNPRm1MWjEyaEtXUVk3TUJYWmxhQXgveEwvekw4TWF6?=
 =?utf-8?B?a3BubG8zOWxWcWZMVHB4amJMVCs3Q3BXMEtVTWsxWmY1WDdTVVRyamRBTHlT?=
 =?utf-8?B?aUtrWmppSERZWGdFemNHaXEzUG5pQmVUanJ5ckRGTXA4TnVoMjVaSDQwY1dR?=
 =?utf-8?B?TlRLMXBCcllwMmVydisreVk3TExwUkROQVQ3WFduZjJrM3cxMk9MOXkvZUFE?=
 =?utf-8?B?MXJybCt1NjQ4c2NEZWNxSlR5aStmYWtjWCtGNWtwVEc1aWl6bTV2ejJpaG1C?=
 =?utf-8?B?ckJ6QitKaGF6VDcyWE5OQ2NpSXRLTWx5ZnVlM2pwcitTb0UyRWNUaU9NaURP?=
 =?utf-8?B?ejdSSTZFVUdkTXp0ZjRvME9zZGRQbk1KR3dVU0laK3JIZFRIbmxFQU5iVGhJ?=
 =?utf-8?B?UXhVaVlQRTFoU3ZsNWRnRUx3ald3enFNRnNFRTZMUTZsdGhaNUNabkJadzNn?=
 =?utf-8?B?eEo0UzJLRHNDMXN1dlU1cTEyZm1nSnNlQUxNZ1IxQk5oaFRTenJYQ3BndzFv?=
 =?utf-8?B?UnpubGpUdTgxSlc3THZpaWpWSkxEbEVtOGF6U2swRGlUbm4xQjNOUnNXbXR4?=
 =?utf-8?B?YWdHVkMveThiajIwNGdjTkk3N3hOSFNNTmJqV3RMWmd2MnlKSXQvdi8wSzRG?=
 =?utf-8?B?b0JBZzhYQTFSV3YvT1c0WjQyZFNGWDl6cDNFRXAwZU1Hb2RpWHdadDVYa3Jq?=
 =?utf-8?B?SG1NaUMvWDJPNkgvbVZ2cmlzTHhRQm5rMGJWdmZ6Mi9seHgxYlBwYlAzNzBV?=
 =?utf-8?B?K2xJaVhjUFJnZTcvTEdhMWVWUy9VR0UrMzZtbDVPQ2tycUhwY3RHWUxuTmxo?=
 =?utf-8?B?WjNWdkZUSGJSanpydjRBUjZrL2ZPaGZFM3FnU0lVbFVKU0k4VDJNdHF3K2xa?=
 =?utf-8?B?VWFDTDNSc0pqV3NTWXJtSlVuempnZzVidDVpd216UzdJQXZVQWtVL09tNStU?=
 =?utf-8?B?Z0p3bzNNSktubi93Mng0Z01jZjE2QkRLYzZoS0diS0JCYk85eWJtWW05Tys4?=
 =?utf-8?B?TmY2Sk4vMExHUC9Yemo2cXEzVThWY3BzVjVFYWxFbGtQN3hjUDY3Y24vck9v?=
 =?utf-8?B?a3MxUHd1VzgzbE8yYlU1T3YrbW56TmFhTWJwQjdDenpWMXd1OGZIdUJyZzFR?=
 =?utf-8?B?QXVDR1B2THgxU1BNbVVhRmdWeGhSSlRROUMzLzJVcEJRbmloQjhCbFI0ZHhw?=
 =?utf-8?B?czZOcU1oWUprM2V1UjRNUTFZc0poaUJ3eUFXV1dYK1R3Q090OUJrOWZzZjBR?=
 =?utf-8?B?R3dNQ1h2b3Y4bTJ0Q1JHSzVTVkpQYzBxdXFJZ2ZtS1VTRWZwZDdKNFBIRzhE?=
 =?utf-8?B?SFdBcjBybXhHT0l1bFEwNW5TQ3lmZlVxamNOV0xMcFRDNDd3UGlBcWRQOWtW?=
 =?utf-8?B?aW93NzdOaUlJcndPbWJ1akpBdEhSOUdETit5aXgwTThtS0h6NE5SZlBKWUk3?=
 =?utf-8?B?dmIvZVBSbWtUZTVvc1A1Mzl3T2d0WnVlZzNONTAvdjFWQ3VSM0t3MnNqQU1T?=
 =?utf-8?B?MlJYVlhOWFhVeUl0TTBObHNVNEVOMzhpWXlmM1JQZXZKYnFBNmFodUlxVUVz?=
 =?utf-8?B?dXhVZTFKNWZVNXlwbDFqY0ZSQVgzQ1MrRlBPaHY2VnBEZXpYNUdiaDVXdXcx?=
 =?utf-8?B?RmJ3N3VZMExkQWdLc3B3Wld1VnNFczg2M1BTL1hseitCT1pwSWVySWsvaGhp?=
 =?utf-8?B?VXN1Zlludnl0MDBnT1RmUWdYdW9CSy9LWE15NW9mMGxrcklHeGJjYktuL0cz?=
 =?utf-8?Q?kfYcdBhZbKjmyrMFQ5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ae65fe-690d-4e36-ae08-08da137ad404
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 00:59:09.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsuuIZiuoJQpp70Vf1bo/2rJUQvAgZWlW+wN1g5bNP71EeaYKRYvzFMikjd99B8c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/1 08:24, Rosen Penev wrote:
> On Thu, Mar 31, 2022 at 4:40 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2022/4/1 03:29, Rosen Penev wrote:
>>> A specific folder has files in it. Directly accessing the path works
>>> but ls in the directory returns empty.
>>>
>>> Any way to fix this issue? I believe it happened after a btrfs
>>> replace(failed drive in RAID5) + btrfs balance.
>>
>> Btrfs check please.
> btrfs check --force /dev/sda

Force is not recommended unless it's your root fs and you don't really 
want to run btrfs check on an liveCD.

As sometimes it can report false positive if the fs is not mounted 
read-only.

> Opening filesystem to check...
> Checking filesystem on /dev/sda
> UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> btrfs: space cache generation (1084391) does not match inode (1084389)
> failed to load free space cache for block group 139616845824
> btrfs: space cache generation (1084391) does not match inode (1084389)
> failed to load free space cache for block group 146059296768
> btrfs: space cache generation (1084391) does not match inode (1084389)
> failed to load free space cache for block group 3183842689024
> btrfs: space cache generation (1084391) does not match inode (1084389)
> failed to load free space cache for block group 3184916430848
> btrfs: space cache generation (1084391) does not match inode (1084389)
> failed to load free space cache for block group 3185990172672
> btrfs: space cache generation (1084391) does not match inode (1084389)
> failed to load free space cache for block group 3187063914496
> btrfs: space cache generation (1084391) does not match inode (1084389)
> failed to load free space cache for block group 3190318694400
> block group 4885757034496 has wrong amount of free space, free space
> cache has 286720 block group has 290816
> failed to load free space cache for block group 4885757034496
> block group 4898641936384 has wrong amount of free space, free space
> cache has 36864 block group has 53248
> failed to load free space cache for block group 4898641936384
> block group 4953402769408 has wrong amount of free space, free space
> cache has 262144 block group has 274432
> failed to load free space cache for block group 4953402769408
> block group 5478462521344 has wrong amount of free space, free space
> cache has 716800 block group has 729088
> failed to load free space cache for block group 5478462521344
> block group 5484904972288 has wrong amount of free space, free space
> cache has 811008 block group has 819200
> failed to load free space cache for block group 5484904972288
> [4/7] checking fs roots
> 
> It's currently stuck on that last one.

If the fs is pretty large, it can take quite some time.

Thanks,
Qu

> 
>>
>> It looks like an DIR_ITEM/DIR_INDEX corruption.
>>
>> Thanks,
>> Qu
> 

