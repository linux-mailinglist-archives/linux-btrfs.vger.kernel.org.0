Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9661773B405
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 11:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjFWJq6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jun 2023 05:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjFWJq5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 05:46:57 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A173AC6
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 02:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ5MsA3EmzwKjh3U9qa6b5um4sl4mhO0CDRej8CVBre78vQq+3Plu6kEo0VXrGxPOgsi+H+Ld2wGBZuFZe7kyB/XUYds3A6CsAuePTPDV71cTAqnQeHARmcydrjiLUu3OTTHEzF8Riz5MNJvrUN8Qybl3erqQuYQwQ4xWYwz5X/sHzUMGD4LT4Dce/3ECKHGX3gq3EBLiisSHWI324fouPD3ixpT1eybt6y+97EytoEcx5I12tY7nrGfIlqugtbOIt6Vi58qtOhCqRzGj+giyZ2btGm66aUfFMvn/yJczVMbD8gYMhJoLWd4RcPqyY404vsKRCgVCPctPATqmjH7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vrETdF3xRRcoYJU5l7t/IaneYuaXccw943vd8Rx9mM=;
 b=aadgec9ITSxoPg9USd98umO8doV5h5X8QxrA2SY9CYD7bKRTQCJaocQAcfqsdCFrUDDLdHCfsnGM5DPHf9yvu8/MbFw9VQSIRJ8PPUYD0toXLWXM6FvA1klLORFGrXn5U/RWlR60NCEtixsyl/GxAhNJYbTmUoqbvQtkNjlgogJ9TNLqVIa9WxyvNQjFRlUkalzkXQs4dC9Raw1rV2x4MI1auxz44O5L+736pcPCCajIFJi3FtntBzUHEP5KwZyQVCkBUYsHPtHfmieNZ51xeBdjZXWOVa7iZlU3WAk45h5eR8vbFPeMkUGcumVY/b6yer+OfoAQQNQyt0GYPRGXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vrETdF3xRRcoYJU5l7t/IaneYuaXccw943vd8Rx9mM=;
 b=iLf9GGopQLhIbeYmp1OZAfE0Z3MpLG2pZ1vFMcBqhJpGmrMrrZFuuF4TXOHKBvvfLIPZSvzDjfAWS6Zi9ruHEKz2Z2WFnfm6uY2vk6G9H+JiLba3Az1Ay3xQvoAAawX3Z034AD3mPlzgnBuO94jshOQQvM867ir89kChTNVykte6WIVroymwLFPI6H2GsFXXniGYm5+ADP2Bm/KZ4qNj5lNMxpkZbHbAbpmbr07bTVZgWTsxmwtxhbZPrz3NyjbCz3+UKH9zOIpF0ur0v2xZZoZv3n/UE654luUqgfUdlQBiQc5KDEZA8woUqi+NMvQHhPlUcpRa50cCn1Vd0mVnVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB8672.eurprd04.prod.outlook.com (2603:10a6:102:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 09:46:41 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 09:46:41 +0000
Message-ID: <124f60c9-4df1-20d0-1884-3d868329608d@suse.com>
Date:   Fri, 23 Jun 2023 17:46:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Stefan N <stefannnau@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com>
 <1ee0e330-1226-7abf-44bc-033decbe43e0@gmx.com>
 <CA+W5K0ow+95pWnzam8N6=c5Ff61ZeHyv7_yDK0LG6ujU48=yBA@mail.gmail.com>
 <40ecba88-9de2-7315-4ac5-e3eb892aac39@gmx.com>
 <CA+W5K0qLN3SaqQ242Jerp_fiyBw407e2h_BEA9rQ45HU-TfaZA@mail.gmail.com>
 <SYCPR01MB46856D101B81641A6CE21FB99E55A@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <CA+W5K0oKO2Vxu3D2jOLET1RrM=wOxTEH2a_uH1w44H2x9kT2tQ@mail.gmail.com>
 <16ab1898-1714-a927-b8df-4a20eb39b8cd@gmx.com>
 <CA+W5K0pm+Aum0vQGeRfUCsH_4x8+L3O+baUfRJM-iWdh+tDwNA@mail.gmail.com>
 <403c9e19-e58e-8857-bee8-dd9f9d8fc34f@suse.com>
 <CA+W5K0qzk0Adt2a_Xp5qh=JYyO02mh5YK3c1wgvQEyS3mHSR_w@mail.gmail.com>
 <e559f54f-c5b8-0132-b420-22b6db5539f3@gmx.com>
 <CA+W5K0r3jpw-zN1y9=essSUUwCRrsGveV1qHSFsKfmrM40OgJQ@mail.gmail.com>
 <1d920a8b-efd8-468b-3abe-f998f0b0966a@gmx.com>
 <CA+W5K0o-aVROdCH+qWacW_96oAVXGpWSXqSSsM=1R024WhLgXQ@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: Out of space loop: skip_balance not working
In-Reply-To: <CA+W5K0o-aVROdCH+qWacW_96oAVXGpWSXqSSsM=1R024WhLgXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::17) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB8672:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff2689d-9358-4631-d4d2-08db73cebf46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXb6Hfp/6AfxcZbasS8knnYifZk5k6osQ4izDfpi2wXt1pBK8acYUoCObi/mEuh/obXEJfOXjLJl4xvT/M8hX/ZkijakfBJpHTXH4vxp680dTAnmQRapozb5KNdahLIlCBn/SQt+7qkqh8DSpm3Ru+A1Q5OdrcXH8XXHiT/vEYcvVlOU6wX+6mEyp0QhOe/3jLnm/mB+j20+fbpn5I9QuaGIIlkbtmma2Ug6yn6dM1qBXBsiDhO3AhounuezygM4ZuCQicacw+Yv9zDdDlNURXHCZGWily8ROAE1EAkVJ3O+IUeJQj4mKIdROelKXzlAOJxKoqJ4eQn1dlhKo6RcW/9vyKzvXw/GLx7PDLhvXrqmZAJlyPwLZNLuWkBwqod6BUf6qoa8of1xP58m0pPfFz95FlW8cZ9Wz60Tve44Rq0qOAs+AMoDCuPPVRl3jXdlk6OrLdku0BvgbVK8IBi2nciOAYrV3wbnc8ANcCMLcT59x3A5BghTM8I+SvIS9JcB8KEFhLrpC0yQIHTPiH1JQuOwrwyyQkx8Ik2/vuer4T9tL2cyTEzf7TVlFoZG61CXihOYZ7LM8puAt3wwCS1psdSisYnwQBjN6HhAgIV7+I3/EhhRRxlhM+YUsFWMZE9bGtjTaUdpyyjgZ+siFqnjPH3CzvvQT48pk01GeZFeRgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(186003)(8676002)(41300700001)(53546011)(6506007)(2906002)(6512007)(36756003)(66946007)(110136005)(66476007)(86362001)(66556008)(4326008)(316002)(31696002)(6486002)(6666004)(45080400002)(478600001)(38100700002)(83380400001)(2616005)(966005)(31686004)(30864003)(5660300002)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWpMSGhucEJ6N0haakk1WndqRDY1L0dqcnl3cVJPWEZkTWVxck0vaGxzWSs4?=
 =?utf-8?B?aHpxSDV0cnhDU0pnOTFoSk1kUURZa3hxWklqaHZDcHFPQVBvZWovK00vK3pq?=
 =?utf-8?B?MHZhT3h3MGYwVlVJZnJ3RkRUODU2cDcwT3lpZFBBTFBrU1htUHU2ckhQdTlZ?=
 =?utf-8?B?VDdVcFlHRUpKYURyT2hVay9vNDBQd3BDSHhLOURwZGNxS0xZNFd1c2oxNEpr?=
 =?utf-8?B?NUtFTGJjVGw2ZytjbytTekRZYU9sUmhiaG9rVGJ0cXo1MW9sWGJoeGh4QUo1?=
 =?utf-8?B?RTFmaExEalRRNTZMV0ZqT3NVR3ozWWJpZC90SXFBbnNScDM4ZlNSZ2tHODho?=
 =?utf-8?B?ZnRJdzVyelBtSjNGVXdhbVNSYXozZ1BmUVVjcjVrUVpZeTFJR3ZiaU5FZk5J?=
 =?utf-8?B?VXFpTlBHK3Vremc2Vjg3UnpFVUlXdDRVVy9iMUthdVJjK2tJYnN3NSt3N294?=
 =?utf-8?B?OUlRV3A3VWZqT0p0Q2JzOUlrS3BkalRjWFZpUUgxbmVvV0RVdTQvVyttM08z?=
 =?utf-8?B?WWE2YVUreDlTMW9WS00yMVByR0NPOGlRMDNSbDZBTk9ISXg4UDN4am9NTmx0?=
 =?utf-8?B?NmpaRURKbTBEeVptL1hXdEpIc1VFWWtiYVhmcXRta2ZCUG94SWhVN0pUL0RT?=
 =?utf-8?B?VG5BdVI5aGF5N2wyR2tMK1NGajhYTW5LbFFyMGdzcnlVS0VxdGttRXhGOElv?=
 =?utf-8?B?YndtNGRoTjRucHh4WG4zcU9SUkU0bG94Z2p2ZVcvcm1RRmVaM01sT3loRThn?=
 =?utf-8?B?azkyMFliVTRtYWJDZzlaU2N2UExNa0VqbUMrNnJLcVQyWHpYMko3a0NzbDJS?=
 =?utf-8?B?K2hJV3ZLTXdRYlFCakJxNnpvWHRPbVZqSVVFdzNMMjRWRzhqOEVUUWpESHlB?=
 =?utf-8?B?ajZ3OG9rY1k1NkkwbHZQcy9zWkJWYkdwSGVJL0pTd1JJNi8wMTdKOGprc0Iz?=
 =?utf-8?B?b0EyNGhpZjVVNmJRcUlsaElmMmYzSXJoWXdUZGxVWVNkdEtuSEE2WHlWbjhP?=
 =?utf-8?B?SEpDVEF0cWRGbFF2QS9UbkdsM3BxSWlRaDBydjNMY3cxMjhmeUVqdHBndjd0?=
 =?utf-8?B?cmtLS3Q3MkwyWG8wQW5kbXFjZWEzVDNsbFBrQWFMMVBFOHRTOUR0Si9yS2Jq?=
 =?utf-8?B?MmxURmpWbEw4TzhlQWFkYnB2WGJnOHQvUG0rTEloM1RCMmltb0QrVDJaTnBZ?=
 =?utf-8?B?cGgxTURTajUzRHpDbFdlMHlwaGdyWHg3ZDVaYVRmRlVmUDQvNWcxQnFXM2JN?=
 =?utf-8?B?SE1pQkxMbHNkWERzQXBzUXlrREZZQmErZ1h1VnpJT1JQTEs3NUtBUC9GMjVX?=
 =?utf-8?B?alFFQTlPaWhuK3VjdlFwVjZqQ2FwOFJUb2JZcGhTeGpWb3FpOHR1ZjZCRHVk?=
 =?utf-8?B?dnhCMXdlVHJoajZ2a0RLQkRPRGwzcXlVQ0ZuT2ZwMnpVbGFMakJDdWV4VkF6?=
 =?utf-8?B?NzhWMWVrYzUxTHlLK0RzbEdpWFlMMm9iR0pOSXMrYTBzM0NMUm96R2xOM0M0?=
 =?utf-8?B?a2h1cExzSFNRRFJTU0gxUmI5OXdNcXFWcnVTdFFBak9oZDhuNXFWL09QRzU5?=
 =?utf-8?B?WkNDY201aFpnL3BFcUxTYmV1aUlMbGxMY1hIbUY2bUxiRVBQZzUzTGREK0lO?=
 =?utf-8?B?eUlzelVxbDBvTitxZS9PQlFkbXVvaWNNMGZUYUVLK0E1d3JNR1pPRVJiS044?=
 =?utf-8?B?QnJCZXpNV2dDK0VybjZsTUwrQUh6SXZzY3hwaytHQ0RNYW9QVVhIL3pBdzRN?=
 =?utf-8?B?Z2ZOZlJza1dyeEV4Qmlja3F4T3hRaFZlM1padG11QlcvRmtKWEx5QXU2dmRr?=
 =?utf-8?B?MTlLWHBjeG9aWjl6Nk4yNXJycDkxeHVtZ1F4em90WUdNRUFwZld3eS9HZGU3?=
 =?utf-8?B?N25xbVdlVlBWZU1TaDFSMHVFU0ZrbnRRNlJ5Z3BsUUh5YitZQkpFOVpZTVBQ?=
 =?utf-8?B?YzVMYkZqdjUwSXFxcFFtMFV1MFpZSVUrV2t4RkRqVENILzRvLy9PZThTRlFK?=
 =?utf-8?B?SzRrdGZCRk00eUpJWnZNZDFoVDdhbUVwSEN1eHlFQmNhYlVlOU9yMjNKaXc4?=
 =?utf-8?B?NjN3OERIZGlPck11TmRQczRNSE1VOXpNOWFYRjA5MjZ3T1k5WmZaV2kxRURK?=
 =?utf-8?Q?VaJrb++00qFbB8oJsLPDwwjuU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff2689d-9358-4631-d4d2-08db73cebf46
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 09:46:41.6748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpPnK/z5j3spn/H85j3qIL3/QvPyoXBOpxDKcPzKQYvNxSsrVJc3N8ihlh9JYO0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8672
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/23 17:00, Stefan N wrote:
> Apologies, I thought I included the log output too, though I can't see
> any additional output
> 
>  From a fresh run, still using the same kernel
> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
> dev add -f /dev/sdl /dev/sdm /dev/sdn /dev/sdo /mnt/data ; sudo btrfs
> fi sync /mnt/data
> ERROR: error adding device '/dev/sdl': Input/output error
> ERROR: error adding device '/dev/sdm': Read-only file system
> ERROR: error adding device '/dev/sdn': Read-only file system
> ERROR: error adding device '/dev/sdo': Read-only file system
> ERROR: Could not sync filesystem: Read-only file system
> $
> 
> Output from kern.log, syslog or dmesg -k
> 
[...]

None of the newly added debug lines triggered, so there is something 
else causing the problem.

And furthermore the backtrace is not that helpful, it only shows it's 
some async metadata reclaim kthread causing the problem.

Although I guess the async metadata reclaim is triggered by the 
btrfs_start_transaction() call when adding a device.
So I updated my github branch to go btrfs_join_transaction() which would 
not flush any metadata, thus avoid the problem.

Would you please give it a try again?

> 
> However, now I started digging into logs to check I hadn't missed
> where the errors were being logged, I've found this from roughly a
> week before I started having issues, which I had not previously
> noticed

You don't need to bother most error messages after the fs flipped RO.
As it's known to have some false alerts.

Thanks,
Qu

> [ 1990.495861] BTRFS error (device sdh): failed to run delayed ref for
> logical 107988943355904 num_bytes 245760 type 184 action 2 ref_mod 1:
> -28
> [ 1990.518282] BTRFS error (device sdh): failed to run delayed ref for
> logical 107989043494912 num_bytes 245760 type 184 action 2 ref_mod 1:
> -28
> [  620.104065] BTRFS error (device sdk): failed to run delayed ref for
> logical 123187655077888 num_bytes 176128 type 184 action 2 ref_mod 1:
> -28
> [  620.126209] BTRFS error (device sdk): failed to run delayed ref for
> logical 123190279929856 num_bytes 134217728 type 184 action 2 ref_mod
> 1: -28
> [  620.126241] BTRFS error (device sdk): failed to run delayed ref for
> logical 123189970468864 num_bytes 134217728 type 184 action 2 ref_mod
> 1: -28
> [  620.126271] BTRFS error (device sdk): failed to run delayed ref for
> logical 123190414409728 num_bytes 134217728 type 184 action 2 ref_mod
> 1: -28
> [  476.565308] BTRFS error (device sdh): failed to run delayed ref for
> logical 101906434228224 num_bytes 651264 type 184 action 2 ref_mod 1:
> -28
> [  476.565932] BTRFS error (device sdh): failed to run delayed ref for
> logical 101906434031616 num_bytes 180224 type 184 action 2 ref_mod 1:
> -28
> [  447.371754] BTRFS error (device sdh): failed to run delayed ref for
> logical 101946151927808 num_bytes 262144 type 184 action 2 ref_mod 1:
> -28
> [  447.372362] BTRFS error (device sdh): failed to run delayed ref for
> logical 101946083725312 num_bytes 245760 type 184 action 2 ref_mod 1:
> -28
> [  439.839007] BTRFS error (device sdj): failed to run delayed ref for
> logical 101923102179328 num_bytes 192512 type 184 action 2 ref_mod 1:
> -28
> [  439.839578] BTRFS error (device sdj): failed to run delayed ref for
> logical 101923401629696 num_bytes 245760 type 184 action 2 ref_mod 1:
> -28
> [  466.393884] BTRFS error (device sdh): failed to run delayed ref for
> logical 101981116137472 num_bytes 245760 type 184 action 2 ref_mod 1:
> -28
> [  466.394451] BTRFS error (device sdh): failed to run delayed ref for
> logical 101981122854912 num_bytes 1720320 type 184 action 2 ref_mod 1:
> -28
> [  431.541367] BTRFS error (device sdh): failed to run delayed ref for
> logical 101876426952704 num_bytes 126976 type 184 action 2 ref_mod 1:
> -28
> [  431.542010] BTRFS error (device sdh): failed to run delayed ref for
> logical 101876427780096 num_bytes 126976 type 184 action 2 ref_mod 1:
> -28
> [  597.487948] BTRFS error (device sdj): failed to run delayed ref for
> logical 108127459409920 num_bytes 196608 type 184 action 2 ref_mod 1:
> -28
> [  597.488539] BTRFS error (device sdj): failed to run delayed ref for
> logical 108124677865472 num_bytes 126976 type 184 action 2 ref_mod 1:
> -28
> [  534.717509] BTRFS error (device sdh): failed to run delayed ref for
> logical 101958618710016 num_bytes 1597440 type 184 action 2 ref_mod 1:
> -28
> [  534.718494] BTRFS error (device sdh): failed to run delayed ref for
> logical 101958756335616 num_bytes 368640 type 184 action 2 ref_mod 1:
> -28
> [  508.089394] BTRFS error (device sdk): failed to run delayed ref for
> logical 101911627694080 num_bytes 126976 type 184 action 2 ref_mod 1:
> -28
> [  508.090007] BTRFS error (device sdk): failed to run delayed ref for
> logical 101911627415552 num_bytes 126976 type 184 action 2 ref_mod 1:
> -28
> [ 1632.112084] BTRFS error (device sdh): failed to run delayed ref for
> logical 102203759886336 num_bytes 229376 type 184 action 2 ref_mod 1:
> -28
> [ 1632.112885] BTRFS error (device sdh): failed to run delayed ref for
> logical 102203764379648 num_bytes 126976 type 184 action 2 ref_mod 1:
> -28
> 
> and today, when leaving the disks mounted read-only for a while, I
> found many occurances similar to:
> BTRFS error (device sdc: state EA): level verify failed on logical
> 201329754554368 mirror 1 wanted 2 found 0
> BTRFS error (device sdc: state EA): level verify failed on logical
> 201329754554368 mirror 2 wanted 2 found 0
> BTRFS error (device sdc: state EA): level verify failed on logical
> 201329754554368 mirror 3 wanted 2 found 0
> BTRFS error (device sdc: state EA): level verify failed on logical
> 201329754554368 mirror 4 wanted 2 found 0
> BTRFS error (device sdc: state EA): level verify failed on logical
> 201329754554368 mirror 1 wanted 2 found 0
> BTRFS error (device sdc: state EA): level verify failed on logical
> 201329754554368 mirror 2 wanted 2 found 0
> BTRFS error (device sdc: state EA): level verify failed on logical
> 201329754554368 mirror 3 wanted 2 found 0
> BTRFS error (device sdc: state EA): level verify failed on logical
> 201350830227456 mirror 4 wanted 2 found 0
> BTRFS error (device sdc: state EA): level verify failed on logical
> 201350830227456 mirror 1 wanted 2 found 0
> BTRFS error (device sdc: state EA): level verify failed on logical
> 201350830227456 mirror 2 wanted 2 found 0
> 
> On Fri, 23 Jun 2023 at 10:27, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2023/6/23 06:18, Stefan N wrote:
>>> Hi Qu,
>>>
>>> I got one new line this time, but it doesn't seem to match your commit
>>> ERROR: zoned: unable to stat /dev/loop/13
>>
>> Please provide the dmesg of that attempt, as all the extra debug info is
>> inside dmesg.
>>
>> With that info provided, we can determine what to do next.
>>
>> Thanks,
>> Qu
>>
>>>
>>> I tried it on the USB flash drives too and didn't get any extra line
>>>
>>> In context
>>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
>>> dev add -K -f /dev/loop12 /dev/loop/13 /dev/loop14 /dev/loop15
>>> /mnt/data ; sudo btrfs fi sync /mnt/data
>>> ERROR: error adding device '/dev/loop12': Input/output error
>>> ERROR: zoned: unable to stat /dev/loop/13
>>> ERROR: checking status of /dev/loop/13: No such file or directory
>>> ERROR: error adding device '/dev/loop14': Read-only file system
>>> ERROR: error adding device '/dev/loop15': Read-only file system
>>> ERROR: Could not sync filesystem: Read-only file system
>>> $
>>>
>>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
>>> dev add -f /dev/sdl /dev/sdm /dev/sdn /dev/sdo /mnt/data ; sudo btrfs
>>> fi sync /mnt/data
>>> ERROR: error adding device '/dev/sdl': Input/output error
>>> ERROR: error adding device '/dev/sdm': Read-only file system
>>> ERROR: error adding device '/dev/sdn': Read-only file system
>>> ERROR: error adding device '/dev/sdo': Read-only file system
>>> ERROR: Could not sync filesystem: Read-only file system
>>> $
>>>
>>> On Thu, 22 Jun 2023 at 18:48, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2023/6/22 16:33, Stefan N wrote:
>>>>> Hi Qu,
>>>>>
>>>>> Many thanks for the detailed instructions and your patience. I got it
>>>>> working combined with
>>>>> https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel on the main system
>>>>> OS instead, tagged +btrfix
>>>>> $ uname -vr
>>>>> 6.2.0-23-generic #23+btrfix SMP PREEMPT_DYNAMIC Thu Jun 22
>>>>>
>>>>> However, I've not had luck with the commands suggested, and would
>>>>> appreciate any further ideas.
>>>>>
>>>>> Outputs follow below, with /mnt/data as the btrfs mount point that
>>>>> currently contains 8x disks sd[a-j] with an additional 4x 64gb USB
>>>>> flash drives being added sd[l-o]
>>>>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
>>>>> dev add -f /dev/sdl /dev/sdm /dev/sdn /dev/sdo /mnt/data ; sudo btrfs
>>>>> fi sync /mnt/data
>>>>> ERROR: error adding device '/dev/sdl': Input/output error
>>>>> ERROR: error adding device '/dev/sdm': Read-only file system
>>>>> ERROR: error adding device '/dev/sdn': Read-only file system
>>>>> ERROR: error adding device '/dev/sdo': Read-only file system
>>>>> ERROR: Could not sync filesystem: Read-only file system
>>>>> $
>>>>>
>>>>> The same occurs if I try to add 4x 100mb loop devices (on a ssd so
>>>>> they're super quick to zero);
>>>>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
>>>>> dev add -K -f /dev/loop16 /dev/loop17 /dev/loop18 /dev/loop19
>>>>> /mnt/data ; sudo btrfs fi sync /mnt/data
>>>>> ERROR: error adding device '/dev/loop16': Input/output error
>>>>
>>>> This is the interesting part, this means we're erroring out due to -EIO
>>>> (not -ENOSPC) during the first device add.
>>>>
>>>> And by somehow, after the first device add, we already got the trans abort.
>>>>
>>>> Would you please try the following branch?
>>>>
>>>> https://github.com/adam900710/linux/tree/dev_add_no_commit
>>>>
>>>> It has not only the patch to skip the commit, but also extra debug
>>>> output for the situation.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> ERROR: error adding device '/dev/loop17': Read-only file system
>>>>> ERROR: error adding device '/dev/loop18': Read-only file system
>>>>> ERROR: error adding device '/dev/loop19': Read-only file system
>>>>> ERROR: Could not sync filesystem: Read-only file system
>>>>> $
>>>>>
>>>>> I confirmed before both these kernel builds that the replaced line was
>>>>> btrfs_end_transaction rather than btrfs_commit_transaction (anyone
>>>>> else following, I needed to remove the -n in the patch command
>>>>> earlier)
>>>>> $ grep -A3 -ri btrfs_sysfs_update_sprout */fs/btrfs/volumes.c*
>>>>> linux-6.2.0-dist/fs/btrfs/volumes.c:
>>>>> btrfs_sysfs_update_sprout_fsid(fs_devices);
>>>>> linux-6.2.0-dist/fs/btrfs/volumes.c-    }
>>>>> linux-6.2.0-dist/fs/btrfs/volumes.c-
>>>>> linux-6.2.0-dist/fs/btrfs/volumes.c-    ret = btrfs_commit_transaction(trans);
>>>>> --
>>>>> linux-6.2.0-v2/fs/btrfs/volumes.c:
>>>>> btrfs_sysfs_update_sprout_fsid(fs_devices);
>>>>> linux-6.2.0-v2/fs/btrfs/volumes.c-      }
>>>>> linux-6.2.0-v2/fs/btrfs/volumes.c-
>>>>> linux-6.2.0-v2/fs/btrfs/volumes.c-      ret = btrfs_end_transaction(trans);
>>>>> --
>>>>> linux-6.2.0-v3/fs/btrfs/volumes.c:
>>>>> btrfs_sysfs_update_sprout_fsid(fs_devices);
>>>>> linux-6.2.0-v3/fs/btrfs/volumes.c-      }
>>>>> linux-6.2.0-v3/fs/btrfs/volumes.c-
>>>>> linux-6.2.0-v3/fs/btrfs/volumes.c-      ret = btrfs_end_transaction(trans);
>>>>> $
>>>>>
>>>>> $ btrfs fi usage /mnt/data
>>>>> Overall:
>>>>>        Device size:                  87.31TiB
>>>>>        Device allocated:             87.31TiB
>>>>>        Device unallocated:            1.94GiB
>>>>>        Device missing:                  0.00B
>>>>>        Device slack:                    0.00B
>>>>>        Used:                         87.08TiB
>>>>>        Free (estimated):            173.29GiB      (min: 172.33GiB)
>>>>>        Free (statfs, df):           171.84GiB
>>>>>        Data ratio:                       1.34
>>>>>        Metadata ratio:                   4.00
>>>>>        Global reserve:              512.00MiB      (used: 371.25MiB)
>>>>>        Multiple profiles:                  no
>>>>>
>>>>> Data,RAID6: Size:64.76TiB, Used:64.59TiB (99.74%)
>>>>>       /dev/sdc       10.90TiB
>>>>>       /dev/sdf       10.90TiB
>>>>>       /dev/sda       10.86TiB
>>>>>       /dev/sdg       10.87TiB
>>>>>       /dev/sdh       10.86TiB
>>>>>       /dev/sdd       10.87TiB
>>>>>       /dev/sde       10.88TiB
>>>>>       /dev/sdb       10.88TiB
>>>>>
>>>>> Metadata,RAID1C4: Size:77.79GiB, Used:77.11GiB (99.12%)
>>>>>       /dev/sdc       15.33GiB
>>>>>       /dev/sdf       18.41GiB
>>>>>       /dev/sda       49.63GiB
>>>>>       /dev/sdg       49.50GiB
>>>>>       /dev/sdh       51.52GiB
>>>>>       /dev/sdd       48.70GiB
>>>>>       /dev/sde       39.09GiB
>>>>>       /dev/sdb       39.01GiB
>>>>>
>>>>> System,RAID1C4: Size:37.00MiB, Used:5.11MiB (13.81%)
>>>>>       /dev/sdc        1.00MiB
>>>>>       /dev/sda       37.00MiB
>>>>>       /dev/sdg       37.00MiB
>>>>>       /dev/sdh       36.00MiB
>>>>>       /dev/sdd       37.00MiB
>>>>>
>>>>> Unallocated:
>>>>>       /dev/sdc        1.00MiB
>>>>>       /dev/sdf        1.00MiB
>>>>>       /dev/sda        1.27GiB
>>>>>       /dev/sdg        1.00MiB
>>>>>       /dev/sdh        1.00MiB
>>>>>       /dev/sdd      687.00MiB
>>>>>       /dev/sde        1.00MiB
>>>>>       /dev/sdb        1.00MiB
>>>>> $
>>>>>
>>>>>
>>>>> This first attempt generated the following syslog output:
>>>>> kernel: [  868.435387] BTRFS info (device sde): using crc32c
>>>>> (crc32c-intel) checksum algorithm
>>>>> kernel: [  868.435407] BTRFS info (device sde): disk space caching is enabled
>>>>> kernel: [  874.477712] BTRFS info (device sde): bdev /dev/sdg errs: wr
>>>>> 0, rd 0, flush 0, corrupt 845, gen 0
>>>>> kernel: [  874.477727] BTRFS info (device sde): bdev /dev/sdc errs: wr
>>>>> 41089, rd 1556, flush 0, corrupt 0, gen 0
>>>>> kernel: [  874.477735] BTRFS info (device sde): bdev /dev/sdj errs: wr
>>>>> 3, rd 7, flush 0, corrupt 0, gen 0
>>>>> kernel: [  874.477740] BTRFS info (device sde): bdev /dev/sdf errs: wr
>>>>> 41, rd 0, flush 0, corrupt 0, gen 0
>>>>> kernel: [ 1082.645551] BTRFS info (device sde): balance: resume skipped
>>>>> kernel: [ 1082.645564] BTRFS info (device sde): checking UUID tree
>>>>> kernel: [ 1082.645551] BTRFS info (device sde): balance: resume skipped
>>>>> kernel: [ 1082.645564] BTRFS info (device sde): checking UUID tree
>>>>> kernel: [ 1267.280506] BTRFS: Transaction aborted (error -28)
>>>>> kernel: [ 1267.280553] BTRFS: error (device sde: state A) in
>>>>> do_free_extent_accounting:2847: errno=-28 No space left
>>>>> kernel: [ 1267.280604] BTRFS info (device sde: state EA): forced readonly
>>>>> kernel: [ 1267.280610] BTRFS error (device sde: state EA): failed to
>>>>> run delayed ref for logical 102255404044288 num_bytes 294912 type 184
>>>>> action 2 ref_mod 1: -28
>>>>> kernel: [ 1267.280584] WARNING: CPU: 3 PID: 14519 at
>>>>> fs/btrfs/extent-tree.c:2847 do_free_extent_accounting+0x21a/0x220
>>>>> [btrfs]
>>>>> kernel: [ 1267.280666] BTRFS: error (device sde: state EA) in
>>>>> btrfs_run_delayed_refs:2151: errno=-28 No space left
>>>>> kernel: [ 1267.280695] BTRFS warning (device sde: state EA):
>>>>> btrfs_uuid_scan_kthread failed -5
>>>>> kernel: [ 1267.280794] Modules linked in: xt_nat xt_tcpudp veth
>>>>> xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink
>>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo
>>>>> xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc
>>>>> ipmi_devintf ipmi_msghandler overlay iwlwifi_compat(O) binfmt_misc
>>>>> nls_iso8859_1 intel_rapl_msr intel_rapl_common edac_mce_amd
>>>>> snd_hda_codec_realtek kvm_amd snd_hda_codec_generic ledtrig_audio kvm
>>>>> snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi
>>>>> snd_hda_codec irqbypass snd_hda_core snd_hwdep rapl snd_pcm snd_timer
>>>>> wmi_bmof k10temp snd ccp soundcore input_leds mac_hid dm_multipath
>>>>> scsi_dh_rdac scsi_dh_emc scsi_dh_alua bonding tls efi_pstore msr nfsd
>>>>> auth_rpcgss nfs_acl lockd grace sunrpc dmi_sysfs ip_tables x_tables
>>>>> autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov
>>>>> async_memcpy async_pq async_xor async_txxor raid6_pq libcrc32c raid1
>>>>> raid0 multipath linear hid_generic usbhid hid amdgpu uas usb_storage
>>>>> kernel: [ 1267.280994] CPU: 3 PID: 14519 Comm: btrfs-transacti
>>>>> Tainted: G        W  O       6.2.0-23-generic #23+btrfix
>>>>> kernel: [ 1267.281005] RIP: 0010:do_free_extent_accounting+0x21a/0x220 [btrfs]
>>>>> kernel: [ 1267.281181]  __btrfs_free_extent+0x6bc/0xf50 [btrfs]
>>>>> kernel: [ 1267.281310]  run_delayed_data_ref+0x8b/0x180 [btrfs]
>>>>> kernel: [ 1267.281444]  btrfs_run_delayed_refs_for_head+0x196/0x520 [btrfs]
>>>>> kernel: [ 1267.281570]  __btrfs_run_delayed_refs+0xe6/0x1d0 [btrfs]
>>>>> kernel: [ 1267.281694]  btrfs_run_delayed_refs+0x6d/0x1f0 [btrfs]
>>>>> kernel: [ 1267.281818]  btrfs_start_dirty_block_groups+0x36b/0x530 [btrfs]
>>>>> kernel: [ 1267.281976]  btrfs_commit_transaction+0xb3/0xbc0 [btrfs]
>>>>> kernel: [ 1267.282110]  ? start_transaction+0xc8/0x600 [btrfs]
>>>>> kernel: [ 1267.282244]  transaction_kthread+0x14b/0x1c0 [btrfs]
>>>>> kernel: [ 1267.282375]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
>>>>> kernel: [ 1267.282548] BTRFS info (device sde: state EA): dumping space info:
>>>>> kernel: [ 1267.282552] BTRFS info (device sde: state EA): space_info
>>>>> DATA has 160777674752 free, is not full
>>>>> kernel: [ 1267.282558] BTRFS info (device sde: state EA): space_info
>>>>> total=71201958395904, used=71018191273984, pinned=22985908224,
>>>>> reserved=0, may_use=0, readonly=3538944 zone_unusable=0
>>>>> kernel: [ 1267.282566] BTRFS info (device sde: state EA): space_info
>>>>> METADATA has -124944384 free, is full
>>>>> kernel: [ 1267.282571] BTRFS info (device sde: state EA): space_info
>>>>> total=83530612736, used=82791497728, pinned=242745344,
>>>>> reserved=496369664, may_use=124944384, readonly=0 zone_unusable=0
>>>>> kernel: [ 1267.282577] BTRFS info (device sde: state EA): space_info
>>>>> SYSTEM has 33439744 free, is not full
>>>>> kernel: [ 1267.282582] BTRFS info (device sde: state EA): space_info
>>>>> total=38797312, used=5357568, pinned=0, reserved=0, may_use=0,
>>>>> readonly=0 zone_unusable=0
>>>>> kernel: [ 1267.282588] BTRFS info (device sde: state EA):
>>>>> global_block_rsv: size 536870912 reserved 124944384
>>>>> kernel: [ 1267.282592] BTRFS info (device sde: state EA):
>>>>> trans_block_rsv: size 0 reserved 0
>>>>> kernel: [ 1267.282595] BTRFS info (device sde: state EA):
>>>>> chunk_block_rsv: size 0 reserved 0
>>>>> kernel: [ 1267.282599] BTRFS info (device sde: state EA):
>>>>> delayed_block_rsv: size 0 reserved 0
>>>>> kernel: [ 1267.282602] BTRFS info (device sde: state EA):
>>>>> delayed_refs_rsv: size 251322957824 reserved 0
>>>>> kernel: [ 1267.282608] BTRFS: error (device sde: state EA) in
>>>>> do_free_extent_accounting:2847: errno=-28 No space left
>>>>> kernel: [ 1267.282653] BTRFS error (device sde: state EA): failed to
>>>>> run delayed ref for logical 102255401897984 num_bytes 126976 type 184
>>>>> action 2 ref_mod 1: -28
>>>>> kernel: [ 1267.282708] BTRFS: error (device sde: state EA) in
>>>>> btrfs_run_delayed_refs:2151: errno=-28 No space left
>>>>>
>>>>> A couple of kernel recompiles later, the second attempt on the SSD
>>>>> generated similar:
>>>>> kernel: [ 1472.203470] BTRFS info (device sdc): using crc32c
>>>>> (crc32c-intel) checksum algorithm
>>>>> kernel: [ 1472.203491] BTRFS info (device sdc): disk space caching is enabled
>>>>> kernel: [ 1478.155004] BTRFS info (device sdc): bdev /dev/sdf errs: wr
>>>>> 0, rd 0, flush 0, corrupt 845, gen 0
>>>>> kernel: [ 1478.155022] BTRFS info (device sdc): bdev /dev/sda errs: wr
>>>>> 41089, rd 1556, flush 0, corrupt 0, gen 0
>>>>> kernel: [ 1478.155034] BTRFS info (device sdc): bdev /dev/sdh errs: wr
>>>>> 3, rd 7, flush 0, corrupt 0, gen 0
>>>>> kernel: [ 1478.155041] BTRFS info (device sdc): bdev /dev/sdd errs: wr
>>>>> 41, rd 0, flush 0, corrupt 0, gen 0
>>>>> kernel: [ 1696.662526] BTRFS info (device sdc): balance: resume skipped
>>>>> kernel: [ 1696.662537] BTRFS info (device sdc): checking UUID tree
>>>>> kernel: [ 1919.452464] BTRFS: Transaction aborted (error -28)
>>>>> kernel: [ 1919.452534] WARNING: CPU: 1 PID: 161 at
>>>>> fs/btrfs/extent-tree.c:2847 do_free_extent_accounting+0x21a/0x220
>>>>> [btrfs]
>>>>> kernel: [ 1919.452655] Modules linked in: xt_nat xt_tcpudp veth
>>>>> xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink
>>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo
>>>>> xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc
>>>>> ipmi_devintf ipmi_msghandler overlay iwlwifi_compat(O) binfmt_misc
>>>>> nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_generic
>>>>> ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg
>>>>> snd_intel_sdw_acpi snd_hda_codec intel_rapl_msr snd_hda_core
>>>>> intel_rapl_common edac_mce_amd snd_hwdep kvm_amd snd_pcm snd_timer kvm
>>>>> irqbypass rapl wmi_bmof snd k10temp soundcore ccp input_leds mac_hid
>>>>> dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua bonding tls nfsd
>>>>> msr auth_rpcgss efi_pstore nfs_acl lockd grace sunrpc dmi_sysfs
>>>>> ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456
>>>>> async_raid6_recov async_memcpy async_pq async_xor async_tx xor
>>>>> raid6_pq libcrc32c raid1 raid0 multipath linear hid_generic usbhid
>>>>> amdgpu uas hid iommu_v2
>>>>> kernel: [ 1919.452839] Workqueue: events_unbound
>>>>> btrfs_async_reclaim_metadata_space [btrfs]
>>>>> kernel: [ 1919.452985] RIP: 0010:do_free_extent_accounting+0x21a/0x220 [btrfs]
>>>>> kernel: [ 1919.453141]  __btrfs_free_extent+0x6bc/0xf50 [btrfs]
>>>>> kernel: [ 1919.453256]  run_delayed_data_ref+0x8b/0x180 [btrfs]
>>>>> kernel: [ 1919.453368]  btrfs_run_delayed_refs_for_head+0x196/0x520 [btrfs]
>>>>> kernel: [ 1919.453480]  __btrfs_run_delayed_refs+0xe6/0x1d0 [btrfs]
>>>>> kernel: [ 1919.453592]  btrfs_run_delayed_refs+0x6d/0x1f0 [btrfs]
>>>>> kernel: [ 1919.453703]  flush_space+0x23c/0x2c0 [btrfs]
>>>>> kernel: [ 1919.453845]  btrfs_async_reclaim_metadata_space+0x19b/0x2b0 [btrfs]
>>>>> kernel: [ 1919.454034] BTRFS info (device sdc: state A): dumping space info:
>>>>> kernel: [ 1919.454038] BTRFS info (device sdc: state A): space_info
>>>>> DATA has 160778723328 free, is not full
>>>>> kernel: [ 1919.454043] BTRFS info (device sdc: state A): space_info
>>>>> total=71201958395904, used=71017442181120, pinned=23733952512,
>>>>> reserved=0, may_use=0, readonly=3538944 zone_unusable=0
>>>>> kernel: [ 1919.454050] BTRFS info (device sdc: state A): space_info
>>>>> METADATA has -147570688 free, is full
>>>>> kernel: [ 1919.454054] BTRFS info (device sdc: state A): space_info
>>>>> total=83530612736, used=82792185856, pinned=238059520,
>>>>> reserved=500367360, may_use=147570688, readonly=0 zone_unusable=0
>>>>> kernel: [ 1919.454060] BTRFS info (device sdc: state A): space_info
>>>>> SYSTEM has 33439744 free, is not full
>>>>> kernel: [ 1919.454064] BTRFS info (device sdc: state A): space_info
>>>>> total=38797312, used=5357568, pinned=0, reserved=0, may_use=0,
>>>>> readonly=0 zone_unusable=0
>>>>> kernel: [ 1919.454070] BTRFS info (device sdc: state A):
>>>>> global_block_rsv: size 536870912 reserved 147570688
>>>>> kernel: [ 1919.454074] BTRFS info (device sdc: state A):
>>>>> trans_block_rsv: size 0 reserved 0
>>>>> kernel: [ 1919.454077] BTRFS info (device sdc: state A):
>>>>> chunk_block_rsv: size 0 reserved 0
>>>>> kernel: [ 1919.454080] BTRFS info (device sdc: state A):
>>>>> delayed_block_rsv: size 0 reserved 0
>>>>> kernel: [ 1919.454083] BTRFS info (device sdc: state A):
>>>>> delayed_refs_rsv: size 254292787200 reserved 0
>>>>> kernel: [ 1919.454086] BTRFS: error (device sdc: state A) in
>>>>> do_free_extent_accounting:2847: errno=-28 No space left
>>>>> kernel: [ 1919.454123] BTRFS info (device sdc: state EA): forced readonly
>>>>> kernel: [ 1919.454127] BTRFS error (device sdc: state EA): failed to
>>>>> run delayed ref for logical 102538713931776 num_bytes 245760 type 184
>>>>> action 2 ref_mod 1: -28
>>>>> kernel: [ 1919.454176] BTRFS: error (device sdc: state EA) in
>>>>> btrfs_run_delayed_refs:2151: errno=-28 No space left
>>>>> kernel: [ 1919.454249] BTRFS warning (device sdc: state EA):
>>>>> btrfs_uuid_scan_kthread failed -5
>>>>> kernel: [ 1919.472381] BTRFS: error (device sdc: state EA) in
>>>>> __btrfs_free_extent:3077: errno=-28 No space left
>>>>> kernel: [ 1919.472417] BTRFS error (device sdc: state EA): failed to
>>>>> run delayed ref for logical 102538732191744 num_bytes 245760 type 184
>>>>> action 2 ref_mod 1: -28
>>>>> kernel: [ 1919.472442] BTRFS: error (device sdc: state EA) in
>>>>> btrfs_run_delayed_refs:2151: errno=-28 No space left
>>>>>
>>>>>
>>>>> On Sat, 17 Jun 2023 at 15:00, Qu Wenruo <wqu@suse.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2023/6/17 13:11, Stefan N wrote:
>>>>>>> Hi Qu,
>>>>>>>
>>>>>>> I believe I've got this environment ready, with the 6.2.0 kernel as
>>>>>>> before using the Ubuntu kernel, but can switch to vanilla if required.
>>>>>>>
>>>>>>> I've not done anything kernel modifications for a solid decade, so
>>>>>>> would be keen for a bit of guidance.
>>>>>>
>>>>>> Sure no problem.
>>>>>>
>>>>>> Please fetch the kernel source tar ball (6.2.x) first, decompress, then
>>>>>> apply the attached one-line patch by:
>>>>>>
>>>>>> $ tar czf linux*.tar.xz
>>>>>> $ cd linux*
>>>>>> $ patch -np1 -i <the patch file>
>>>>>>
>>>>>> Then use your running system kernel config if possible:
>>>>>>
>>>>>> $ cp /proc/config.gz .
>>>>>> $ gunzip config.gz
>>>>>> $ mv config .config
>>>>>> $ make olddefconfig
>>>>>>
>>>>>> Then you can start your kernel compiling, and considering you're using
>>>>>> your distro's default, it would include tons of drivers, thus would be
>>>>>> very slow. (Replace the number to something more suitable to your
>>>>>> system, using all CPU cores can be very hot)
>>>>>>
>>>>>> $ make -j12
>>>>>>
>>>>>> Finally you need to install the modules/kernel.
>>>>>>
>>>>>> Unfortunately this is distro specific, but if you're using Ubuntu, it
>>>>>> may be much easier:
>>>>>>
>>>>>> $ make bindeb-pkg
>>>>>>
>>>>>> Then install the generated dpkg I guess? I have never tried kernel
>>>>>> building using deb/rpm, but only manual installation, which is also
>>>>>> distro dependent in the initramfs generation part.
>>>>>>
>>>>>> # cp arch/x86/boot/bzImage /boot/vmlinuz-custom
>>>>>> # make modules_install
>>>>>> # mkinitcpio -k /boot/vmlinuz-custom -g /boot/initramfs-custom.img
>>>>>>
>>>>>>
>>>>>> The last step is to update your bootloader to add the new kernel, which
>>>>>> is not only distro dependent but also bootloader dependent.
>>>>>>
>>>>>> In my case, I go with systemd-boot with manually crafted entries.
>>>>>> But if you go Ubuntu I believe just installing the kernel dpkg would
>>>>>> have everything handled?
>>>>>>
>>>>>> Finally you can try reboot into the newer kernel, and try device add
>>>>>> (need to add 4 disks), then sync and see if things work as expected.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>> I will recover a 1tb SSD and partition it into 4 in a USB enclosure,
>>>>>>> but failing this will use 4x loop devices.
>>>>>>>
>>>>>>> On Tue, 13 Jun 2023 at 11:28, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>> In your particular case, since you're running RAID1C4 you need to add 4
>>>>>>>> devices in one transaction.
>>>>>>>>
>>>>>>>> I can easily craft a patch to avoid commit transaction, but still you'll
>>>>>>>> need to add at least 4 disks, and then sync to see if things would work.
>>>>>>>>
>>>>>>>> Furthermore this means you need a liveCD with full kernel compiling
>>>>>>>> environment.
>>>>>>>>
>>>>>>>> If you want to go this path, I can send you the patch when you've
>>>>>>>> prepared the needed environment.
