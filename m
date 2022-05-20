Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F1D52F5BD
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 May 2022 00:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350346AbiETWg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 18:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiETWg0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 18:36:26 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD5D13DCD
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1653086182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qu5sBBluEHoloWQYoM/4ryX3fZ7fp2bXtthYzFChrV4=;
        b=dyQz14FKaUAqX9oAcYDxoXoRksbVrL7e8RBsGBYvcBAG5XdNaXHHdy0lM5TYnjkJnXomjl
        TfLAjYpJ791BU2MTv4hgTZPRvUsYYFyIlKqB8/SJBGhjR92EYw5lPP+fwd5X5rKv5j6t4w
        y3MQOUJzWDKv8j6NwKXo6AIa6JiOOdw=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-VM98DOioOMWNM9ebDsFyeQ-1; Sat, 21 May 2022 00:36:21 +0200
X-MC-Unique: VM98DOioOMWNM9ebDsFyeQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw7z2a49bcjXZh83IKfiy/wPfwW7NOMqH1BtPO8xmUihjMR4MtyXFbmVxtTOBQQLBOOypvgrj11QUvoqIg32uOAQdyY6tOlp3bYYQm+wESbrP9TKf3sZ9UBfd6zfl5kQl+kX4BG11y2+rHcE3Hem3NjWEPFWdAJ+f0X6ONy0J+VjJ5bEL8WSDoQKycYS7qTDjJ0sYn0g8jdKxZxjVRN2MrvbP1kOhbuCOd5+z5hNpkJv00/n6x+NceGtbLi5GjW6b0w61ruATEMB2duxSWgg6jJ4DLXqErTuYBV8pZUOiqT3q2tWXJ4HjSnuL454nibPGJ4nu55D9vb8lb2m0FCJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qu5sBBluEHoloWQYoM/4ryX3fZ7fp2bXtthYzFChrV4=;
 b=Jl2K9WKCSzv7tWu2d/puhxuv8WfxVKzUkAY8Hg48ZeWdR59TuFp1HFp51TQzPUh2liQpODpIzoRjgqXrniidmV7+kFgxhUGx/9hdWrBHyySaeClAIMlGcZBrh56KFuH507inb5hYso2pS6nTZBSsXIap40avzCoMCm6AMtUJ2+Rm8YhYCIRckKDpThKeCyg+FQ86oyVkq/JemckP4UNxcxTZbEIPSJiBpRy9C/0DGGtkSm7qzLcRs07kJQ61/9Mm2ojDIVZMXojbTU1lJd+RCRkSOl9HHDjJUIqjyGSth8pZNTKPydc8cYVjCW8Z7sWJOGy3ROPZb4fg7J7pWuF54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by HE1PR0401MB2426.eurprd04.prod.outlook.com (2603:10a6:3:1f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 22:36:17 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf%7]) with mapi id 15.20.5273.019; Fri, 20 May 2022
 22:36:17 +0000
Message-ID: <dbfa11a7-426e-40eb-eb9c-d62c430ddc58@suse.com>
Date:   Sat, 21 May 2022 06:36:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 02/15] btrfs: quit early if the fs has no RAID56 support
 for raid56 related checks
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-3-hch@lst.de>
 <3c8da817-963c-224b-f99e-faeacb1e2ce2@suse.com>
 <20220520162547.GB25490@lst.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220520162547.GB25490@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:510:e::22) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c7d1b9d-96a8-4954-5bdb-08da3ab12707
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2426:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <HE1PR0401MB24268D6722BCFB52A304009FD6D39@HE1PR0401MB2426.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+t87D0vvKhOBuVWqgTu3FuxIsPtw12fSErW1U8EhbzHZ6zr4ZgP30F11Ap6Yemln+hxBLF+RVOqC/4euhhBgM00qR7JdHrQSC/Y17BEFtKH4rTcgM6VlscLc8JSvbTs7f7DwDrwZUNiafVy3MK7xDwyCZbO2WbcDtyZ0D9WJETSOtxl3SQn9xgL6CRClSrGTdG4NgNlIPbBtD2Bc/mqScvFpNXbiCg6sK2Sgo3cpQbNVq2drUVm5rP6kC3JmHe5tE48CGy+NUZgIKnlMWuVGhsKfpnTF53PqoBESdjfsHg2n4blDHIkA7o2aeJ+iI9cu3ySjuEAwf0mGmuUUhRni6rCm+8gTH2ldrleuHIzim6bJIMCZYzgXWBLQ/clrq5j+GpR40Y5TPfRBcP1iiS48N0DSynLby9tanUcmxT5OK6YnjwSaZ8V3CA9zXrUd7z59tfUVdtMxppaLCfa9Uo9g+aWskgmPmDlqANRRpkD6ZPu/9uHqMvpq1G4+CjHw8GNONWDOv+UurC4cS+mA7foP7Ut2t+iXk78lMJlKT2VNknt1j2XZ2oc7c7SkJ1uSUM8V3FKealz31AXefJNPN3LrGAOGOsSvBIR699xSXa5qH5D0i1ccx3/OvW1HlSupQXRVWCvNqsErF6l+oD/FChu+mdG9aPDhM7U5Xv3SY5q6VQAlnL5NI1UcghJwfsy1P+jSaADbESRJS8qc2esH1O2vHOp5J3sguOngR6lLhloAdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(38100700002)(2906002)(4744005)(8936002)(53546011)(6506007)(186003)(2616005)(6666004)(36756003)(5660300002)(31686004)(54906003)(316002)(66946007)(66556008)(66476007)(110136005)(6486002)(6512007)(86362001)(6636002)(31696002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmtUV0JpeERvWHNWVEhiUWU5MUIxcEYxWGdHYU1adUFBS0VlQ2pSbE9pckRm?=
 =?utf-8?B?Sy81SlBTNm9RUGVHa2p4S3pzMkZEZENPMnhaRjRmNXFvU2IzeWpTUTlrNVZM?=
 =?utf-8?B?ZVJvTnNlcUJKWTB2OEpmT3J6cjQ4RjNnS244U3VLMkF1WWhiSW9CTi84U1o1?=
 =?utf-8?B?eDAxQkc1cDFpOXdYNVVpVzdncnVpOXc5Q3l6WEhCa0Zwb3RXWUxhZjMydG9y?=
 =?utf-8?B?QkRxRFJFd0daRlpac3F2cTNuWjZseTRMamlNU0IrVFdDdkNzT0RsNDV0bkEw?=
 =?utf-8?B?U2FQQzIvTDZaSFFkbkwxLytHV0VTUFVVcmtsMDhrUGJiSHNad0pya1FTb0JU?=
 =?utf-8?B?bThXZmRkOFRqZGVyc21vbzhIQmlEVFkvTjE2SkJFbFFzd1dUdUFkTHhMMTRk?=
 =?utf-8?B?czM4SUV1d3lKbUd0Y0FUUTNKVXhjM0luY1F6TUFOOW9FMFk5MTJaOGI4eUZC?=
 =?utf-8?B?NERvRmN0MzZPelVKWWs3aCtjSkkvdEpPY3A4R3lCTkJCMFE1b21Vc0g1QjRP?=
 =?utf-8?B?YllFa1laR1hBbXNuRUVYYW9DbnJKZ2JZdVdHc1dkTWtXam14dG9BTXlxNmlT?=
 =?utf-8?B?cDZaUUFLbTNSalk1Si8wSjJaeTRpVTVOT1dwOHJVRStLNE9OSkcrQU1wQ1Vw?=
 =?utf-8?B?Y1pZR3IvbGM0bVphd0hNY3dlNng5T1F5d2FESHhmcUloWXo4Ym1SZ1kyeUIr?=
 =?utf-8?B?TEZXVmhpS2tMbFpCZnVJYzB6K2V5WGRocllYcHZ0YUdhL2xNQ2xtRDY0citZ?=
 =?utf-8?B?M2N4clpvamROUWtLWkQyZzhnWTdsbTU5NXdYTzM5VldTTE5Yckl4bUdrQnFv?=
 =?utf-8?B?c3pTc3dId2ZiSlRXcnFNbUFMbE9mVnJ4RmZJZlNSTmRqRlZHSWI4QnJmdDhx?=
 =?utf-8?B?dEhjRjdja0FjL1RUL0hJQjBmSGdlR2dhRFpNTE9GZ09veGtuUFJpOWlZczFw?=
 =?utf-8?B?OXBOV3d4THNLV0lrZzk1RjRJc1ZPbmtySS9lQm4zdHhVeUlZZm10a1FPVFI5?=
 =?utf-8?B?Vkc4ZHpzTmFTaGNqQ3laODZxSDRIQ3VrczgzUGVrQS9BN2NCaG11dlNQRUVt?=
 =?utf-8?B?MDRLdzFLUDNRWVAvbnZkZjRBTnQ0RmtXL1BOc1BZcWJFbUN0TnJXcU0vdVcr?=
 =?utf-8?B?dUJJOWJ3azNzcGhheWdrcHZIdXM2amRtN2NQZVVPd0Y5TE5iQ25kNGNmM1JD?=
 =?utf-8?B?VmxNMG5wOElSeldQYUR0WmNya2Q5QlBrQ0hLMlJ3dmhqbk9NcDhuZHI5d1J4?=
 =?utf-8?B?bFFBcmJjZDhKY0FWbThMQ2xtRmhtc2F0Q3ROMmN5NW5CNVRuQXpNcS9MRkhh?=
 =?utf-8?B?VTkrU3ZOTHZ3d0phWUtiMStIbUhLb3F0ZXcwQ0pCbXNqSUYyV2NmWkRZVVZ5?=
 =?utf-8?B?a1ducE1NN0ZWZDVEVy9FaE14MjNJZC81R09WM1VyaDZjRmZVVXEydFZJQTlF?=
 =?utf-8?B?akd2NEhkeUE4SFlpTGtCbGdLNnRGdlFRajVkcXliM1o3TXNMbnQ4eXg3UFVO?=
 =?utf-8?B?Z2N1NHRXUHFPZUdiaXlRZFZrZE8yMGpKNTdqTTlMNGhZK25veitPUUhJNFRO?=
 =?utf-8?B?SHFvd3ArdGVnbWZSSjZRVEpYRzdwWUNmbExTWU5SdTU5Z1hBUkp1NlpWamQz?=
 =?utf-8?B?SkxvRUNpNnFIa09sc0I3WDVQYkNyekZKZExmd21WcjF2MU1Md2ZqTURKdU1r?=
 =?utf-8?B?VW9zb3A2NDRSdW5xS1ZDVTFpUGpabkY1alBBU0NpNWhJbzVsNTJFS25lcU10?=
 =?utf-8?B?aXMyUzcyWWd4ZW45WksrbjRJd2FqdGxGcFEyRDV4YnhucWlxMjJWZG9VZmlV?=
 =?utf-8?B?VHZaWEpudWF3QkxqKzlzd0dOajJUYVFrY2Y1UHhTbkR5dGFmcnl0UVBLcy9O?=
 =?utf-8?B?c1V6cmdBSCtlSFdYS2JFcDhJcDZPeEloazVPcHRTZ0tESHN0NllsclVwNGFs?=
 =?utf-8?B?Z2VlQkVqVllLVEQ3aHg3QWh1WXg2S0RNbldRZzdSRzZyeWl4ODNxOHZsYlpN?=
 =?utf-8?B?L1Y1WnZGcDJlR3NmRFUrd2ZpVkZwWUpRbWo1U0JFN0dNb2FEQWJjQ0xxUmwz?=
 =?utf-8?B?STZEaVVET1J2RHhZNFFSRG9nYk9GS2hkTG44SFczY1ExVWJFNExKM01IdTZY?=
 =?utf-8?B?MGk2WEJ5UlZtRElMODZjejFnMFF1QkxPYTRXNFgwUmN5dnhMVytJbzVTdCtB?=
 =?utf-8?B?UE9FeldGNE5OZ3VBUkxJa3ZNRUNiV3pQNmxyd250akNPdEN1Vkk2VkZMSGo5?=
 =?utf-8?B?bDVPZEZ4dE0zSncrN093SG5ILzdLRkM4RUY5MXFLSTB4My83dktVSmRSR1FC?=
 =?utf-8?B?VjdVcDROSWNwYnF2V1kzYW15aXdESDhJd2pvNHpTUlJiZjR6OFk2K2ZIY2hI?=
 =?utf-8?Q?s21uzHZrbNk/FpAd72JkRFmtd4Urtqvy5smZg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7d1b9d-96a8-4954-5bdb-08da3ab12707
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 22:36:16.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N36V8UdX9L/fZkIGacHshkRTietOZrWlKEccB8g2VFBzm1o1WdQFhZ4rKkwAueZT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2426
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/21 00:25, Christoph Hellwig wrote:
> On Fri, May 20, 2022 at 11:47:31AM +0300, Nikolay Borisov wrote:
>> This seems rather unrelated to the rest of the series so it can go
>> independently and ideally should have been a separate patch of its own.
> 
> As far as I can tell it just speeds up functions used here, so yes.
> 
> Qu, do you want to send this out separately?
> 

I guess if needed, David can pick this up independently?

Thanks,
Qu

