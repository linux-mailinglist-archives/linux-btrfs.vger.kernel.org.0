Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477354E7E64
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Mar 2022 02:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiCZBRK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 21:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiCZBRI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 21:17:08 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AF518A3D3
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 18:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1648257331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jobRvsX7LyzFSWjVMR6SDlb8uYGnq4AjqQjAeqWqSiU=;
        b=PkNxGuBQMhDOxCuZ07YA7PKd6YTtG0yqytZFSKJ3oqGS0MF/pubWk6Q2SqD4K5Q1kDn5QQ
        SR3ichpNYnvqTBa+q0vuEPmSoXfzIe2HyFLCP3khH3xNUTmAWL4gL020qILFoDiBKYsFje
        sr15dfgWdPNbAL5T7Uky5G0UZmNcz5o=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-h-eexhFBNV2EiC6QUW4qjg-1; Sat, 26 Mar 2022 02:15:30 +0100
X-MC-Unique: h-eexhFBNV2EiC6QUW4qjg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6unec7vSHeG50xvAhdIu9q2zcYsbdRQkgPliZ+TddK97OdKTgJsmhkuwzaBdHKBt2btOJ/eAkOqaQYFbk9YLzd3KteaDTMY4pkCN7Qukxv3P70DsulGe28/br5Zp4vowkouxuHBH83C38NfNK0BjRd6lLH2noWtEPjxGVt8AiGaBFiu4Ue2eY7ldPif6PP4tVQD5SDfA/YDUDkd2ro0uh4xm3BRFkGMv6FLj8WnXyf4ustTwHKXsXS3rrEyWeEG7SM/oqh9cKw1lrOz0BarbtPI0X5GK06IulchD+aYd8F4K9fu7Fhb4eLdAFQcN7BfkgVjG/vh+6nmLHEc3MUmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jobRvsX7LyzFSWjVMR6SDlb8uYGnq4AjqQjAeqWqSiU=;
 b=LpOO5ot44ayxyY9GdZIFFyVPVC2bVMyeSVU3g2oRQaTZGlfiB1D9g+AKHKoOx4kuJysd9aB9Texdd450gNrBvA6Gn7EIotTMloIKH3kziPOt9HL/QHgTKGLnKsFCwNnp7zHtVvGCwVhdXhwBXIlKXUlqDlFNUUL0B8H3vkwf21C/XWydAZ9OPP6Vt8FOeMXoQuAj35yCW3wPIF4JxkuieD4hR3sVZHtHF1Hg9Zk8yivdJ+79naIcTsoyZTSnju48YgGequo0G1fNqG3/fmGsjjo7TgYcoqvGMIeodHZ8D4M4cL7YXLcbo4sfzsFoc84Xk9DXxmtswgphMmyKEuSNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by VI1PR04MB6304.eurprd04.prod.outlook.com (2603:10a6:803:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Sat, 26 Mar
 2022 01:15:28 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::39f2:9041:54c:eecc]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::39f2:9041:54c:eecc%8]) with mapi id 15.20.5102.016; Sat, 26 Mar 2022
 01:15:28 +0000
Message-ID: <4ad5f566-8d80-e090-ddae-c409786dcf2d@suse.com>
Date:   Sat, 26 Mar 2022 09:15:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <Yj3v+MnFOXeeAU9d@infradead.org>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <Yj3v+MnFOXeeAU9d@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:510:5::15) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c35b9fa7-78be-43f7-8b36-08da0ec61ce0
X-MS-TrafficTypeDiagnostic: VI1PR04MB6304:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6304494C6F80FF3DD9EB58B0D61B9@VI1PR04MB6304.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrkxBL3tijMA5lMr8HbhFR0ZBbs5jiL/AcxStRve4wli+r9dsy5frPqRSMeApffj5gqxBSlioddXb5aAb1O9JNE+pJohO7YlAQOkv40cLr7wKax957rtvuJtd6OAOZKKHfYdm7EbvrlFo9ogEMlMFsd0or39DNKp3zIDjAgZexBWZQo+PsK16ut+M4GAf6s/y2FymXb3G1oaiyf3Pvb39pWD0ChHUwVk7+GTnbZ5qnrw4coH1BSe9gTAr2DzjJeKiel4Gzvx2ZJ05WSpyEjFk8PGNxt0uwP2tIbckpf3o2xvG44Dcfjp4WR89gJP6yDjxp2pLxMoL/+NQoPS5WFI4sSMF1o532Wt6+/L9biIvKbt4KpA5qGf8lkknFhRrvH8+lKLie2BEknbiuRo85EPBGlNzCatUmf33/RI5SFGZi/g2QvCsMJjiKLDt4WmbeOocfiTIXoKrEVpnSRGFhZCsWxxZMLUit9dIc6X4A3Hksxrcsz32Kprly34NycLP/bVIv1xV/x+6cQWeki2+cnANQ6qGE+ceUBo/5Lfk6pH6CpUqsB9G6u2TAEyadrbknR8GVkYnbCWSlBsSqqBt69KR1vSFTGDhHttS1P2h6ShrZBiSimtm9UN3cHhYK0vokTAkV5q2Fcsvne5lRXHXnm6gN37N6e8iissSqQ83o8llJrVMBfiTDSIA4pu6uGhiaJ4C4/dZqF2aJaAHs4N9UFF7ZEv9W8GQen7BL0YbDxuDuQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(2616005)(31696002)(86362001)(6506007)(6666004)(53546011)(2906002)(508600001)(8936002)(6486002)(5660300002)(6512007)(31686004)(26005)(186003)(6916009)(38100700002)(316002)(36756003)(66476007)(66556008)(8676002)(4326008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkR6ZTMvVGZkajRobngrbWdJL0w5dCtWcnVsUzJiMHZVYlN6S1R1TDAwNVZI?=
 =?utf-8?B?ZnlkWW1acWhMSFVVK3N5eE8wdlBxVkxWOGtOMDRoUHJsZmg0T3hYUzBSeWsv?=
 =?utf-8?B?RmZSd0RwSlRBcUZabGx6a0lHZzlPZDErZUtVK0hJbGZmTnFQa1FoVXliS3ZP?=
 =?utf-8?B?ZFlzR0RjZC9RSDhIY2FkU0hzVEFDSk1kYXJvS00xNVZVVkV5SEQwOEI4enp0?=
 =?utf-8?B?TXo1Q2p2K2VSS0cyQXpBWVF2VHNMS0lMYmZNdWQ2Q0JFUFlQTkk5NjFsRzJz?=
 =?utf-8?B?ZVdTR2xOU05kY0Y3clBhQ3RETWhNMHFsT09EbDM5bHBVYURmeGhGVDRyQTFT?=
 =?utf-8?B?ODY3QXZoT1dKSGw4R3dNb2hwNHNRSlpUR0lveTF2YVJOeWxabk9SNUprQXFG?=
 =?utf-8?B?WGFYNXZkaEVHRnJaYmN6WFhhNEpUNUhaYmFPM2hnWm1BM0NsMUdndDVsUzgr?=
 =?utf-8?B?OE1CV1BJOVk0Q2dzcHNzbzJDblhQWUJESmFKNFVkbHpnSDc3V1h3UnNRM0gy?=
 =?utf-8?B?VWk3TjBYb2QwcFNEK1FZVDMzKzBhMEcvYnkrQkpwVWhjeXJHUEtmUlNOUTVK?=
 =?utf-8?B?Zm9sc2htMXloN0x3cEdxcHRtckJ1MzBsNExZNVNsSmdTOHc2OGFONWdLekJu?=
 =?utf-8?B?SjFCcTA1RHZwMm5reGdjS1kxK0Q2NTBNaXVFOU94SG5IeVR4WCt4Qkw1enl6?=
 =?utf-8?B?WTU0aTRCYnhxcE5BOHFTUDlTdmswa1lDREVkUDA0cWpmYW1YQ0J4T2huRW0v?=
 =?utf-8?B?cnF1ZzBWaXpUYk1TUUI3YWwwMldIQ0ZFVXdXQjJoMmZWRldKT0tDM0Q5aVVO?=
 =?utf-8?B?YjRBL2tjRGtINDQrWkY4OVcvRVdVVTBLQ3pjcGFjaDVEeldFRG1tSGJKNlRn?=
 =?utf-8?B?bzlyN0VXMjNUUVBJbHIyWFZDeCtSVXRzRzBxZm5UOWlkdlZla2M1TUZreUxY?=
 =?utf-8?B?bXV5VDJZL3FSUUxKWWVRdEdoZk1SczdrNVpLeVYvSzQySkw2WG1NQVdqdElP?=
 =?utf-8?B?Ym9idktjcHdXNS9PNFhPdytXVFZwL3k0WWY5WFNmYTc2Y2lZbFhaczkyRWhi?=
 =?utf-8?B?dzdzdTVpOC9IYldLTDVoNVlVUjlNb0lWR09INFd3YU5uZkxCamJVOVo0NFl0?=
 =?utf-8?B?RWY1ZnE0TTRQRk52T25vcWRTSnRVNUxBK1lrNnJDVVRzUDlTVEJVOWw0UUtK?=
 =?utf-8?B?NVZNSkFyYzg3aUpnYzdXT3BPNkNrRkZ5ZHBkK0VsanJ5MEZub050TWNkdEd0?=
 =?utf-8?B?Rjhhbk4ySGhpR2dIbGFyczBSbW1mT2dQclBFWHFGNXIwb0N2MEVMblFQYWVF?=
 =?utf-8?B?TUFITkVnNzRsZFJxdDBPNzhKa1JSR0l3Vk53MENDSjJwdDZ1bkxkdUwzbzZG?=
 =?utf-8?B?aEh2VlFwU3VlZGJRblBuNGF0U0IxMmNKdmtWR1dvNmpYS0dxS1R2UVFBZEFY?=
 =?utf-8?B?emZqcGIvc2dTK2laampjRVBLdEp2QjdjSkEwWHQ2amRBeUZZQmtBWWVBUzVr?=
 =?utf-8?B?YkNac3M0a3VaSWNMclVkMlJjZ29jRlpudWFnQkRIU29FRUxJTzVnMjhoZlVQ?=
 =?utf-8?B?VExVOFBsT3MySVlHUWhkOXZ5UUhMdmtHOE9YZUhudHZUYTMzYXlpKzdidzlS?=
 =?utf-8?B?UXYzRko1d3F3dDdoK1VhOUQrekJLckV3QzJZK3F1SEZOS3cybWpMQzN2ZXdC?=
 =?utf-8?B?QVFMT25pb0FVbmx3bld5S1ZWWDdiRC9rd2JYOEtZRHJMUVNSYXdJTFpxaDkw?=
 =?utf-8?B?MFoybjduYlVXNXZkaFRnT0NDOE0yYTgzMHJiYmFzd01PSG5ZbW1QZCs3aEtH?=
 =?utf-8?B?SmNnUVpKWE92WlJDQ2RzZDltOVY2STNWT2l3UHN2RWRkSHc0UlFNTUtBMHZx?=
 =?utf-8?B?cjNYbnRYSEo4VkxJNlhETTdlTW5CS1VkeU5McTllSFA1RGFBYjFPVGRabzRM?=
 =?utf-8?B?YWQ0eXowMTNQV2dISlN3ZkRDQVZZL0szQk04SlpsQW04U0dodS9Ga3pxVmlz?=
 =?utf-8?B?LzZTVE9mMFV6aSt2eXVUUG1BVHgvd1ZEamJEK2hZbmE0UWRxSkVqTlF0aW5S?=
 =?utf-8?B?bFpyWElFWnJoL0pQd3lDTWVKaXpQZHIvUEtYaEc3dVQvWFV3TWRTOEZ1bUdx?=
 =?utf-8?B?djRmeUpzVy8rZUxpRXNQMyt6akJTUHBMT09tc3Zrb1ZKbk9lRVMyWUFhNEhz?=
 =?utf-8?B?RFJTaWJwK01lU0RhZU00YUtRSUdsZmNyMjhUWVZiQWNMUE9UaktvL0JtVHJ6?=
 =?utf-8?B?VEtFMWtIUVpXR1NZUDQvaU5sOXV3VUlmWHVZMlN6WlhpOWNYWXV5YUlwSEpn?=
 =?utf-8?Q?826FcmMjJLZD6TQ3k1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35b9fa7-78be-43f7-8b36-08da0ec61ce0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 01:15:27.9965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6yu2sY7K9ayKYkfgnt3SXKCNlo/TS2cvGMwofIyBGv/+3H3XqL7vgqdRIt5PISq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6304
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/26 00:38, Christoph Hellwig wrote:
> On Fri, Mar 25, 2022 at 05:37:59PM +0800, Qu Wenruo wrote:
>> -	u32 len = fs_info->sectorsize;
>> +	const u32 len = fs_info->sectorsize;
> 
> Why the spurious and rather pointless const annotation that is unrelated
> to the rest of the patch?

Because we prefer const for constant variables in btrfs code.

As we have experienced some bugs in the past related to reusing some 
variables.

> 
>>   					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
>> -	memset(kaddr + pgoff, 1, len);
>> +	memzero_page(page, pgoff, len);
>>   	flush_dcache_page(page);
> 
> memzero_page already takes care of the flush_dcache_page.
> 

Oh, indeed.

Thanks,
Qu

