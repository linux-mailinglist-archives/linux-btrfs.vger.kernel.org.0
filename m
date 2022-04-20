Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32769508529
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 11:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243155AbiDTJsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 05:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237711AbiDTJse (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 05:48:34 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AE937AB0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 02:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650447946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q5hjoyIVko0KW25ANMxZmTeCwSEFrnU7KKPY9n468oI=;
        b=CLljAn0XFACe+7iFTEZ40hZv80QcOcTS7KRKs9Fw+llWAbkk/MKqJsHVrsyZtR9Se6+O1s
        4pjfJ1miKbMg+6dumrxYV5VeXRtidBvUqYkixB/dLwJwsiHj59CWfYrw2vDAOSnnlMsmpr
        zhLszcm1rJbEbICXcYBk95AqnFcYCGQ=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-bA8QaU3XOCitRHRNF0oFbA-1; Wed, 20 Apr 2022 11:45:46 +0200
X-MC-Unique: bA8QaU3XOCitRHRNF0oFbA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCrc1cDfBQy6wS1x47Z4nsXpuTFPGY6dwFINbLjrctwOwdJ3aCzI5zXmNQmbjetpmHVhxd98ZJbJiwtVJbEHqXzYwfEKoFpni74ySHsM+bQn88B4sagp7dWL73EJFFaCc1wnEwhOArA8ciQ32oGGkfDIVEr+IvsaUp0DdcjnfjEqgTHVK+TKw7fF+OZe0fu9StvpJHI9TA76Juh+HYh72gXtHYkLhuvU4IVyxSi8okmfb9KPUUjg7nr4aW/a5UL216V+HMclFPK7fvHuFwxVM4CkCGiSCfHC/y4rFVkq5AG5E+32b0jLVYEz6h0rZ/4jBNtzZkU+sZViyTSRvIACCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5hjoyIVko0KW25ANMxZmTeCwSEFrnU7KKPY9n468oI=;
 b=i+WO9YLXnvewFZez3JftO+oa37oKSbemMcsVZg4RDk3ZJi9mXitINGDSCeF7Umr7w8gFv4t45MSJu/0r5gtK+GT7GoizG1pbPswlTwt4cPP5N81aAyC7dBlfgEdke63xBCM7yCZcdsiaqKvGh0scbUtLQau0JEe4vhnw9pAMl9IzKhW0prcV9Gv5IpntEpigg9tMOgxy7lCvKcTYV65RrWuBhWGbanS+CksVqnAdmUYPmA53QojelLzxh3eE/ZKPoTYZfhwkvpn6N1+DfrRDlXfFWudB5DwFrRf/J7+OAaTYFDVOdzn9Ph+iBwFj/wQPd27HekUQ0dlcm4ZqkBFcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by VI1PR0402MB3343.eurprd04.prod.outlook.com (2603:10a6:803:8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 09:45:40 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::21fb:190b:867a:67d2]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::21fb:190b:867a:67d2%4]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 09:45:40 +0000
Message-ID: <1d1dcbd6-d9bb-ff2b-fc70-75bbd926ff78@suse.com>
Date:   Wed, 20 Apr 2022 17:45:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1650441750.git.wqu@suse.com>
 <beb111504cb32088bcf4fc6bc1ef36004d0761cb.1650441750.git.wqu@suse.com>
 <PH0PR04MB7416E7100B6C5EA70446C09F9BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e57d9b3e-94fc-a20f-ff92-ccf19c0b035b@gmx.com>
 <PH0PR04MB741682A87F86554F81F5AE839BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <PH0PR04MB741682A87F86554F81F5AE839BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::13) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 958cef85-cb96-40eb-3a20-08da22b287af
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3343:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB334355233E0B424C51DDEAAED6F59@VI1PR0402MB3343.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wN4/sNTlzY8sHLgNYaJicRSMrprvLTpfjRH67Ra7/Ds5M/yVHWSe5LXUvYDh5pQlz7R0z/QoP295K7Q/HSl7e+jCoCHRKkyhQ4QrpLtXDUnqhiPnpZcneBl3ELoFGcYHYofB6ueUKvGRtd4UQp6VPxgudqKBl9YltuoVn++/nIzRG3LwziFEwaPhexgdm2ixEwPz83BI1/0kwnYun+Ct4hYsJ3EI0WkoND2KpoVsI7aYKVWBuQ5jHk/n2+LeM0Bwm1INdTbxeeTIdFjK9aNPIs56kPXEK1kUt+vWQF+ClViKWl0cBLShg0wsfiGTlTUVqkL/VweUbPBFh0C77EcgdZhMv6ReCAADsmpKOo18Qll+0n7dlplh4CFT0xspEbaNzoCbFpnSe1HsXrKOhtWf/xf1C61/5KmpMjHE4QznY8dgPZBhFAhveNkE0jbRQ+vqLJGqUoa9ezUka4yhZlHa66XXmQQ7YcGwNpq0MpjW/zUh4r5u3HbBuuK/kneiow1/uX4avZ+vKkjLqIWStMx83OGhs4arSPlqMtXhTn6+yFoGUWYIJuJdEPr3TBkbN5UC9ljOJTcug+BbD8a7ZT9cmlb4fFXbjYiVZ5YthsE392SrcOZ18L8AAZHiSRApFM9WUGCCzWLdyJaBqixOxC5+/4DDpQjUbDRoytDlWoeABJo0vUwk3NVd1vF5/kvzR5Dkn1x83EXnmm5W9BgZx1C0aHzQIiuz9sw+LCFHXGHk3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(31696002)(2906002)(31686004)(26005)(66946007)(86362001)(66556008)(66476007)(6666004)(6506007)(5660300002)(8676002)(2616005)(186003)(36756003)(53546011)(8936002)(83380400001)(508600001)(316002)(6486002)(110136005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNXTXlrRjgwRXBVRUhXSlJBMkFqK0JZSWc3cmJDUTJneVNQdjVaa3J3TUdU?=
 =?utf-8?B?bzArdnR2L1prd3ZhTjB6R1A5d0FJZ1VaTVJJK2VydFB3Z29LR0Y3dG0zcDM4?=
 =?utf-8?B?OWIyUlQ4SDFGWTlmRlR5ekhWejRTTWxuSWt6TUhDL0F1UFFDRnZKUHZ1WmFC?=
 =?utf-8?B?amsrUFMyM2o4dUhYQ2ZMRHM0dVhhVHFwaS9TbkVoaUpiZ1FoeGZYMkc5YlJR?=
 =?utf-8?B?WXBhckx5bkppVkh3QjdqWTZTT2FTRVl4cUpzMlBmRVdMTFkybHE4L0lJa1F3?=
 =?utf-8?B?OHB2WHYxWjR0NkVzek16eTN2blhRdE5PdmJYL3c2eTdoUDdLM00yMDNiTWE0?=
 =?utf-8?B?SjdDdHR4WWFkRHo1Y01sSDNFc1ZBZElkbm9mcVRUZDdaQ21TZTRSeDBIb1Fs?=
 =?utf-8?B?SUZIV3JHT1JJNis2d2gyUWUvelVKRXg5RnJ4OHlGUzJ2VEdhdmlsTDlyZVlq?=
 =?utf-8?B?Z0dEUjcvOGlLcENjRmd2c21wV1pjUzgrVlpucyt6Y2pzYXJmYVRxaURzY0lE?=
 =?utf-8?B?cWRRWHV4cC84czJmQVJiOHRqSHRmWHo0VzNxcktuU2krYll2aUovc0MrRkxs?=
 =?utf-8?B?ZWF1QTNPWDdYVmZQOVdhd0QyazFQNkI0Z2tEa2NYaWJUZGpzODlIU0VxTU9j?=
 =?utf-8?B?ci9XazV3TzFkS2VrR1BsTHMxZmlQbStaMGQ2Z1MrejJjODd1WVBqdnU0NGV1?=
 =?utf-8?B?eDZqdjl3dmlEbU5COFhGMFNQczhFODZHRnIxVGVjeTBEdlBNby9jMmxHWlZW?=
 =?utf-8?B?YnEwK2Zvc3lZYjhWUWxTN1ppVktBMlM5Q0FybmZ6TjZucmt0ZXpMVVMvUlhn?=
 =?utf-8?B?V2xLMkhHVXdkSlVocFNaSDViS05rNDdVU0xQUzg3L053L1ZrWnhlS3BPc3hr?=
 =?utf-8?B?M1VrelFENjQzOFRxNXlEYy9mT2JiaGhGTEQrUlRHQkFUVnNqTzEvME41eDFV?=
 =?utf-8?B?b1NsTVhWMjdmNC8vVmg0NTJlUUFTdTlidkJadWpCTWNpQktCWE12cHlIci90?=
 =?utf-8?B?LzZWRzg3c2dnZjQzSkdiVWVHWTNXQThKc3ZrQUp0eFFJZ0hPbDFRTENTdkpC?=
 =?utf-8?B?ZmJjN3pIdjFRMlhaRlpWKytSTEpScityYWlPV2tjOXZzVmd4NCtaemF2RnlF?=
 =?utf-8?B?U3JvQWFXcHdua3JXV0VwNmlNcEx1cXN4Z2ZKQ2NZVnJYcy84QzNaNWRVd09h?=
 =?utf-8?B?c1NMM2Z4VjREL3JybGFiMVlCdmxVSXdyQTRDTDR1QnBGRTkwdjgyMUMwTVBx?=
 =?utf-8?B?S21iSlFJOG81UXI5VmxpUFU3aWV5b0I5Z3YxcXNHcnpHSkZhQVFpVC9ZZW81?=
 =?utf-8?B?NzRBRGZ0czRzU2FNOWczSlA4VUZlUHV2WDJEMWdEdUdIcHQ2RUtkc0Y1Mkho?=
 =?utf-8?B?dTkzOXVQSUlBTTNiRG9ZZDZURzZNcTVVZUdicm56WkkzTWVaYyt0SE11NW5m?=
 =?utf-8?B?MDRPN1Z4OCthLzRHN2wyKzh3c3RKOG04VFZ5Qk9VOUd5NHNoN2JtR252ckQ2?=
 =?utf-8?B?SnpMQnB6SklQZ2Y3MmY0bUZnd3J5NWl4WGVHcmFKc21pYzY1TWFlQVJDSDFk?=
 =?utf-8?B?QTI0dXFXTDFaV2RaNlQ5V2k2UUNmZWQwSFRVVnJOUm1VeUovdFlWdWV1cmo0?=
 =?utf-8?B?S0RzT1BJVytaYThqWktSNlhkZThoKzV0WVVEZC9aQS83Ym93Y0Y3M2oxbVpC?=
 =?utf-8?B?UDdZWFI5bStJazdBZ083M09QaG1TQThkYVAyZGxSZ0JneXFuaEZpWEo4dk93?=
 =?utf-8?B?Zkl1aTdYY1loQldDeDNWQzk3eCtneTIvNVBJZWllb2p0cnhNV2ZsanFvT0JH?=
 =?utf-8?B?OHdIUGQ0NWhCK3QyZFVCQUhrMUR5SDZyQ2VtUk1MVFNlQ2VIQnNob1ZWQ0cx?=
 =?utf-8?B?VDIxTlpDajNpQWdVNmpWeVNUcGVtdStVTitRWUZZYjAyWWRzbmg5Z2dZcW5U?=
 =?utf-8?B?SGRNdWNlNWN0Z2FnaUE1ZDd1RnpGa2puM24wbG55UDhCQzBWa05ydGlWUmdX?=
 =?utf-8?B?THlxc2h6ay9nbHpmVmtFdnZvTE9nZ1d2eEdIWldjQlBlOWljKzdIc3o5OVNu?=
 =?utf-8?B?aWdNR0NsaDdRUXhvL3QzZVBpNWxqWG9lTHBFTXdmbnlGVkVJWFFJUUErZ3hZ?=
 =?utf-8?B?U0dkblNxRm1mSjFpZ3dqV1V0YUFYcnFISEJET1ZCZW90dnp1NTM0Zy91TGF1?=
 =?utf-8?B?RUJDNU1DL3h1VE8rekdIMkNEa0tnZjJoc1VucFYxWXdzM1NKZXhMV04rZndy?=
 =?utf-8?B?SVp1WUc3SUVOakFGcFNid2lkQSs2SjFBZzVSZUhGbTRUTFVna2tLQStERnBk?=
 =?utf-8?Q?P4cRcmc9sYpo7wqBmO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958cef85-cb96-40eb-3a20-08da22b287af
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 09:45:40.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRTVOc0yvUhupDNGUST1Hie5kjmXzFaubvT9MPZRx+qnUJVHf9gES/lSiOmCJlkx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3343
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/20 16:41, Johannes Thumshirn wrote:
> On 20/04/2022 10:38, Qu Wenruo wrote:
>>
>>
>> On 2022/4/20 16:25, Johannes Thumshirn wrote:
>>> On 20/04/2022 10:09, Qu Wenruo wrote:
>>>> In function btrfs_bg_flags_to_raid_index(), we use quite some if () to
>>>> convert the BTRFS_BLOCK_GROUP_* bits to a index number.
>>>>
>>>> But the truth is, there is really no such need for so many branches at
>>>> all.
>>>> Since all BTRFS_BLOCK_GROUP_* flags are just one single bit set inside
>>>> BTRFS_BLOCK_GROUP_PROFILES_MASK, we can easily use ilog2() to calculate
>>>> their values.
>>>>
>>>> This calculation has an anchor point, the lowest PROFILE bit, which is
>>>> RAID0.
>>>>
>>>> Even it's fixed on-disk format and should never change, here I added
>>>> extra compile time checks to make it super safe:
>>>>
>>>> 1. Make sure RAID0 is always the lowest bit in PROFILE_MASK
>>>>      This is done by finding the first (least significant) bit set of
>>>>      RAID0 and PROFILE_MASK & ~RAID0.
>>>>
>>>> 2. Make sure RAID0 bit set beyond the highest bit of TYPE_MASK
>>>
>>> TBH I think this change obscures the code more than it improves it.
>>>
>> Right, that kinda makes sense.
>>
>> Will update the patchset to remove that line if needed.
> 
> I think the whole patch makes the code harder to follow. As of now you can
> just look it up, now you have to look how the calculation is done etc.

The problem is, why you need to look the index up?

The index is pretty straight forward, just a enum for each profile, one 
should not really bother whatever the value is.

> 
> If you want to get rid of the branches (which I still don't see a reason for)

The new code is just 5 asm commands on x86_64.

> have you considered creating a lookup table?

The index is used for the lookup table of btrfs_raid_type.

Thanks,
Qu

