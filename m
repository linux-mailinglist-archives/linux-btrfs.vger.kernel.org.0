Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7026B5548ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 14:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbiFVIqj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 04:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiFVIqi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 04:46:38 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559D39690
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 01:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsi/sZeGZWOj8BimsBSwIKY0+VyPv9YCYEFjjeD+nci58L/+9+vdVdb9+iKYR2Mjjl61kykk38eKa6iC8EXD03Ng102Ubxdw1fhspBYmOFrZQ+dSyiFphLfwjiHCCy2L4xGO3TdfRVE9CNamjt3YscpJJcjrfD/vHz1It3BrGM/QlTjDdK1Dw7snxf65UoXNuqHQeUfhVoUxil7dyBvJ+A5wwcsGpvVJinnUtqNF/1pqarxHeIonaf9UnTPEEzY+qSl4BuMOg6EERZQWQqvKanWBWk+wujqjPsYklA97RAvx2f9QZZJjDeP9+VPR3e5ZzkvkhbBOpexIVFmUHsnTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=209TYicaGIuLZhcLa1kiAfbQyVwoif6L7KYO4rxolAQ=;
 b=IY8LcbUyLDOhVuitOia9KWV5G41NaEOSZektht6TsPgxhUOolAiVJh4mEanFekckhzV+yxXgsulKyHO6vziLAtxTdzrjBSMdDHBVKLPynE+Uo9/ZVMioXb3oQ9EOPlfw+nNJwgwbOG4PEYHwMqT63puBVdL9wDP1XqrlqKU8cmUpuTCFA7PU27fxcCZgP152qgmNwLBlPnuS0yAHWt3L1rQ/Fz/aYP11rbt0BFNJtJVlNPC1GxNu8zcLMVzBNcqieDuVppJnAsKeYoOViOVryd1GGbxzEFWujUdYNM62LNFjY2YOTTTnoWETlAUf6CrcECIWNLCXfecbisZ/Zkqzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=209TYicaGIuLZhcLa1kiAfbQyVwoif6L7KYO4rxolAQ=;
 b=uTiCB7/v7wySMp+taSN/4nBQOMT9Gqb/b/270imBOEcu3PVfeIoZ3lQrp1N4J4IbOMs20lJyvugj5xxnOKZFiRFrnUCjwqJVf88EasdI8vv5yWXgZxnnskLagnZBWtW89MUF1In+iui9l725Rp7l1uTIvE/TeCjNryl8AZozyRRFz5H9MEZXWuSzedFWIQXAQkp5EtlOZ7MKVESbgdujETuHt+04Glc53yID2Ciu8TCMNL1B7UKw40lZvhGqqJfEm3jAEoEhn3zutfTTA52DS6pXR4PxVKf1+NyKx8AtzeRuGFD2R1YohUBj6zjueDRCOOk2jMrQu4T45cga6yNJkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8478.eurprd04.prod.outlook.com (2603:10a6:10:2c4::13)
 by VI1PR0402MB3680.eurprd04.prod.outlook.com (2603:10a6:803:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Wed, 22 Jun
 2022 08:46:32 +0000
Received: from DB9PR04MB8478.eurprd04.prod.outlook.com
 ([fe80::2830:eebd:dab4:241e]) by DB9PR04MB8478.eurprd04.prod.outlook.com
 ([fe80::2830:eebd:dab4:241e%8]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 08:46:32 +0000
Message-ID: <6ee19563-2345-efcb-14be-ea3fd083999a@suse.com>
Date:   Wed, 22 Jun 2022 16:46:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: repair all bad mirrors
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20220619082821.2151052-1-hch@lst.de>
 <6490bdce-d5f6-9e59-ba04-41f0fdf8bbff@gmx.com>
 <20220622050658.GA22104@lst.de>
 <baeb9e98-fba4-8af9-9fd5-da6e1bd8ee34@gmx.com>
 <20220622074719.GA24601@lst.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220622074719.GA24601@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0156.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::11) To DB9PR04MB8478.eurprd04.prod.outlook.com
 (2603:10a6:10:2c4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c8b2a19-c4fd-4259-cb49-08da542bb4ba
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3680:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3680FE4CC94F8AA8C9B66880D6B29@VI1PR0402MB3680.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQ2MS2VFTKqqouSg83OWir/PFyairS/kXFeiX9uU4wrz2FdX8yBtdFfm8u0Dld+2jWgZe3kXyfHICQrOcT78OIJwSWQT5V4Rw+XIi1hdg9o5Ie/mq+rr+Mwzr0/XWBjd+IlxiebWiCXtGUyR+Fh2SQAYI273n0dfYjZJOlo/6pTGk3k1slUrYAaMXgCWiR/RzjS1VpWv+dkXnN9kbFG8SncMo0YX1VgYueahcG5sM5lix1i/aW7EB3hAE6UGWh4HPbe8S49/hSjqk5+DeRcQYrWD2zl5QBwdj4pZLPbdAMTfzoqkEWGzLXhGTK67HdPHXokrG/CRja13ZnXmNvs8sK9aCdBzH0EfvycZjKf6RjwG8PKr383ZTWf5LRe/pNLoY6Axx8AHi546SQbwpi89TqdzVqDnGnCwovTksDdMcE+MPQ3pzPwcZVrarOnAGuygBO4NyV6R1OGxVfOu/F71SatX0JrLgfzb+8lhZVsK/k/Pm6j1ntvJhWT8ME2GwDzZPz6ulTGosKJhNUKkaaiE4shYWqwve3N+9XN4mYqUnh3N9/sLnHgVic3pFrALlGH9dGJ6Jz31TCVs0Jv3DJPxNtXrGo3V+Is7frFT3Qjzs8Oa15KC2SM1vjKKm0z0DxBjHcwQZFohvBsywSVBiPek+nImpdJNL1o0Ujb7OwMiHkhu7niKGN7fFkC/MHQFqokP7IlqdcSRa7nkrNHlvAevH5FA5wEWmsT/4C/c3/smNewfVSeKH1pVV7EyOcmTbL+Hd+2e2GKqNlta/IcMK3aotQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8478.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(366004)(346002)(396003)(86362001)(8676002)(31696002)(110136005)(83380400001)(5660300002)(186003)(2906002)(66946007)(6486002)(66556008)(6666004)(6512007)(4326008)(66476007)(8936002)(6506007)(38100700002)(53546011)(41300700001)(36756003)(2616005)(478600001)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qi82V0VORlcyWFplbkFsS2xOSWhUMUI5aFRmd3kvRXI1a2d4dWs2S09laExE?=
 =?utf-8?B?OEVKaGR1YUlSN1loL3ZLUE5kTHp1V1F2ZWJWTmZHZnpaM0FOQ256RzYxTnFr?=
 =?utf-8?B?Z3Rsc3R0bmJOWHNESHZ2TWlIWTFpTWNTQjkyeFd2T0hMVkVEUFdEVXE3c1Ju?=
 =?utf-8?B?NmJSZ0NYeXMvWmovc0twVkRPQjZDeXpBN0NOcHdhWVFxWXlwL2NwS1pRSElY?=
 =?utf-8?B?MFM4VVdFUXI3a1l6RkJYUmw3VmJnWG1kZTJOUGJHOGNERkdjTkUyZjVJNzha?=
 =?utf-8?B?TjF3U0ZTMjNLcW5KL0Nxclg1VWpLQThRVWNkNG84M1FwaWpRWjJ5WDkwTTlB?=
 =?utf-8?B?eE4vTzhsRVV4V3Z6MTcya0xOU2E4ZjZSTnUranBIejRFVHBIRnNYNGpHQzRl?=
 =?utf-8?B?aHpJWDY5MzFNYkRLTTZNVEh5VjNUSTB3STBpQVZEM0RDRmhIZG8rT29JNlNH?=
 =?utf-8?B?WDJoWnZiWXlqSVlOaWJmVElZR05EalY5VGxDeTFxWHFweWJwV2drUTVvdndi?=
 =?utf-8?B?dGlsNGdWZm9vYjBOcDhSVFpVREJ1S0JJc2VDMEEva1U3amdsS1UvZlUzR2p3?=
 =?utf-8?B?Rmg0ZWFOSzI2RzhSbW9XaSt1c2dmMmVlVElpaW05M0hHOG1QRUJFYVlCM3NP?=
 =?utf-8?B?Nlh5T3pPUXNVNkRLVjlSaCtkeDBadDRNKzdzbmdBU1JEdXBrbktlYVExSzZ3?=
 =?utf-8?B?eElTYmQyQlVwVjFKbmNHQ1puYjdaamZxNUtnQmtMQkNadUxERXc1eWVuaytZ?=
 =?utf-8?B?aEw2WjFDWTRvKzZoMDRtYmhxYkEvb2VPYjNMMnZOamUxL2JBREp5MWRCdEVw?=
 =?utf-8?B?a3ZySnl4MHROTFlWNzA2OS80WFJWWlE4ZHcyd05qc1NoZ0YrRStsNk15ZVhS?=
 =?utf-8?B?aUxiU3JiaThWQ3lTbDhkM1cwTkprZVE1VmtndDhTSmNFam55a3JjL2pRNG9s?=
 =?utf-8?B?dldUSlFINHo4L3JnT1l5eTNrSEhRNjdZb1R5VkdSUFpQYlhBTC9tZ0YwN2lF?=
 =?utf-8?B?RXZ1VXVXZDVnQlJQR1FRUnd6RDM4WDh5SUQ2czk1R2N5c2Zhd2o1S2JxcjVs?=
 =?utf-8?B?SlBXK0EyRDZEMUtlRUw4YnBBbXhzQjBXa0RveU1HOXB4aGZjTkxEaC91UVd3?=
 =?utf-8?B?aG9UdUFvS0NSTXAyTEV3UmVCMWZDVTNZVmVJdEVkU2RxT1pnSEhwVzkycURu?=
 =?utf-8?B?a21kcG1iRHAzNC9WSWEySi84a0oxMUluK3Bnb0sxVWJYN1RWc2pOc2lrUHNK?=
 =?utf-8?B?c0VmNmx1cTU5Wk0xTkVnMUtZQ0R3b2xETTd1TnRhbEdoOHlta2FDMjBRTlR1?=
 =?utf-8?B?SGRVK1p5SmJ2bWQ0VzlLTmZwMklnTENYUWdCR1FJbFczcFB6dzVHVnNDUnc3?=
 =?utf-8?B?Y2hTcitzeTdNSU41YTQ2TkVLdnFid0VzWjZDM2lnTGFlZitDOFdOMUJMdFV4?=
 =?utf-8?B?bFVXTmtpdCtnZEgxQnlKRm9IS0Q1YTlWanRsaElPQ1NCM3ZNTkNMeG5lNDZQ?=
 =?utf-8?B?bXIrMHJta001UXhnNk9Dbjc2Y0R2MnNsU0svTXpFamJPa0xoUkJESFBscTc3?=
 =?utf-8?B?VWlTZnY1eWJuZkZZNktJT1htTkd0ZUowMFBGb3F2TGpmMWlZQ1hUU1RLL3ZL?=
 =?utf-8?B?bVRzdzZJQm5PMjFDQ29pdFhuWU4rVEJCVzh4VmY4VTJ2QkhUM3lYT0xac25Q?=
 =?utf-8?B?TnZsZVBJcTNvcUl6V0xnM2Z5N2hhdTAraXlmRnZpVjMvNDh4eGRSUmtDcnpK?=
 =?utf-8?B?YWhSOXFNeVBUZXpielJ6R0wxZHdXaW02WlhWMEthY0RzVUpVaU9vdVlWY2FN?=
 =?utf-8?B?K0dOK1paUzgxbEVIMzVDY01FTWYyeUZET2FoZHQ3WWFOSzhFaUNmQWpFWFhk?=
 =?utf-8?B?MmJwbERqNHVkY3BPMkYvRlRKa05LK29IV1FEdG9mNVdFWDJWVWVZUncvOFRN?=
 =?utf-8?B?Ykk4cVhFODRERmtzYW5EZnJ5S3Y2S1FQNlpwU3NzQUoyU090Yk9XWEFlR2FI?=
 =?utf-8?B?cFJUckVVRlJGTUNmVHdJKzlwYTVBVjByR0xVOWZrZW01UG4waFRqR29lZHpn?=
 =?utf-8?B?TlovaTA0eGtTWlpHa1ppR3JVYklyT0xuU0JIcGxFdWlPaGVKQUovZlBSV3A2?=
 =?utf-8?B?TnprSU9RNlRTQkp5dVB0OGtwSGppM2NzdWhVd1d0OEZBbEJvWFc0OTl4dXZx?=
 =?utf-8?B?SWp5eWJhYzU2K09LWFlrRUlTRWNsNmgySDhoZDBKTldBeXlPTnIvdnhFMS9U?=
 =?utf-8?B?WjJ2d0RZNnp6djdpQ2lsTlU5TUJoTGJEMnVIdFBzYjdVR1lFUjJpRmYxVGo5?=
 =?utf-8?B?UG1rUW12anhDKzJ0MEgzcEdDSlRGMUxQZUk3VHVBUmNaVFRsczZBVHNCY3VP?=
 =?utf-8?Q?IgQoi4VCFfokhFQQ+W7gaVSN/ew1ynfetuqDz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8b2a19-c4fd-4259-cb49-08da542bb4ba
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8478.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 08:46:32.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhliEMXpbq/aOIO9RzTk67IB0b8tjN4s3fWBy0qw0D/zbZvdF7xf4f0I7z5LzMd3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3680
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/22 15:47, Christoph Hellwig wrote:
> On Wed, Jun 22, 2022 at 01:14:30PM +0800, Qu Wenruo wrote:
>>> We need to record at least one failed mirror to be able to repair it, and
>>> with the design in this patch we can trivially walk back from the first
>>> good mirror to the first bad one.
>>
>> Then in that case, I guess we can also just submit the good copy to all
>> mirrors instead, no matter if it's corrupted or not?
> 
> Why would we submit it to a known good mirror?

If we didn't read from that mirror, it can be a bad one (at least 
unknown one).

> 
>> But considering repair_io_failure() is still synchronous submission,
>> it's definitely going to be slower for RAID1C3/C4.
> 
> Yes, two or in the worst case three repair writes are going to be slower
> than a single one.  But I think that is worth it for the improved
> reliability.
> 
>> Just a small nitpick related to the failrec.
>> Isn't the whole failrec facility going to be removed after the read
>> repair code rework?
> 
> Yes.
> 
>> So I guess this patch itself is just to solve the test case failure, but
>> will still be replaced by the new read repair rework?
> 
> I've shifted plans for repair a bit and plan to do more gradual work.
> Eventually the failrec should go away in this form, though.

Sounds pretty good.

Thanks,
Qu
