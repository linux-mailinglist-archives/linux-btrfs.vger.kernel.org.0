Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A38474BBEA
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jul 2023 07:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjGHFIZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Jul 2023 01:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHFIX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Jul 2023 01:08:23 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525C9DB
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 22:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHH46w21oVo5KLQ2Sf5GQgOCNKdJNROi+JaW45B0vO4QVAYLYhtY30C7dSpUXkp7a1FLilxQrgIwwAi5AJssj2OB7QuBhtmrMH+tNPFcep1FLs2Alo3KvCGy8iVp0KSUXwjwtkEGQTY3u9ODmn/35eAScGkNPbmCI5rpy9bc1pvuhvm9jUs3HyHr1xM5gwjkaMoPcu2FmLRgDfCR4DtrsWpanAN5Ky8bpgDj1deJWxfB3s1keCmFQBAKEtyku5sIEveXIbUPFhs0NCcjo6y9y/oK5m5QoD3/vYBlpVe8+/ngqw7YJ65x2Kr5v7mJ5IBTSZ3Qo+vMzciDmc04H2tbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUb1NEd/g6O1KNqlj2EyGwnR3JLQEpLWOJx7iqvuc0E=;
 b=ZNOnGcX+jnXAUC7nVA+bsrcpneO+FsXteYiEgs9BSmNm3CUqoyQNh4u3ZjY7hWV1dJOzM6ZdG3fk60d6iXY2y+b6zN7R+n2+C6VWuhcePERV1oglpatrFw/mDxrkYANy9sQrgrG6JV9dGL2EejdmOBeQOAv0b8tVtBO4Qx8Ae1vO7lBllXNU7yoeemrNEI3f1Y15EcENjSSXAmLcwmStQWZkr2O49seCcPIFvHwwOh6NAuA8vaDCvamLLSCsu3v+ZQgvMcdc9fgayM4c6oJDoglRHK9neUV13qFSd4OTMD4FdI8cPSmqRkCBhHxjcUhv5/pdVkzOr3+6tulFtivCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUb1NEd/g6O1KNqlj2EyGwnR3JLQEpLWOJx7iqvuc0E=;
 b=bHA6FGQXN7l/ZXsPQcCfI83dsyPAqPYH1CGJF3KM5WI3/fQJwT51qgR5nre+DNYI/BYyCykOzajaZOJx+wtS3CqIcG/RbWwKyNiuOUTN7l06zQYB5YmDomzmrD52Mej2l0HAb3p3y/ZuowflYNwGpw0aGE14rf1vRf9QFL0N1dsHcL4+rRw6ZOerN4fk5Kq1Xd7NzzIHKjrpVUmbmOtro9vp9dSRVw55DnSH3WCMwyF1SNc4s3F30uB6YCkFgw4dw6A3IZ6pXIFfE/mLlyLLZ8U1z2lHawUoBWaATn3JvDIk5Ejja6w4iwd7nyfJKGJZ6/Cr7B279v4cTNCvK6jFiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB8175.eurprd04.prod.outlook.com (2603:10a6:102:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 05:08:18 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 05:08:18 +0000
Message-ID: <6732859d-55b9-82cd-c50d-33f5455b054b@suse.com>
Date:   Sat, 8 Jul 2023 13:08:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: question to btrfs scrub
Content-Language: en-US
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
 <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <80136f6f-0575-58e8-ea8d-7053c8af4db0@suse.com>
 <PR3PR04MB734063CF2AEA3709D3AFD9A5D62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <743f92ee-19e8-ba45-0426-795a91fc0e0b@georgianit.com>
 <00c1ea17-680f-18a0-d40a-f36bcdb9101d@gmx.com>
 <PR3PR04MB7340C4687924686D4C7ABD8AD62DA@PR3PR04MB7340.eurprd04.prod.outlook.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <PR3PR04MB7340C4687924686D4C7ABD8AD62DA@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 715b5fe5-742e-4943-4a16-08db7f715764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+Wo352gB8MXXbrNi+p4SvdPNCsO7UVW8Qwt9OsC95X3TLR9wOiFUOeKeIdMDYS4DNeBDAxC5wc+55PxG4B1+6CglEMJYWkbExJv4Hwgh6IFGxlLsxTyMi0RxF6bpm4UJr4B99XKBwaiVZhDcFt1r2hb3g8avDVdeEnaIejsABJsighSF7yxPmKT5tthQRo0VtBqLswGjA6ma98oaOHSizeNfVN0eI/e+12U/iwM3C6NVLvNyxFo4rfU3qc+WNB0W/ggJgvNdRaKlXKG1By0Gkw5eTNMXmJc8L+qyex69KrD+A6qcqxCYEQNRiLIsc5HogR17NYpIvH1gsF14/HtqFlxVXAe+I1PzXNkQ0AoU2bRI8u917rrvarhAvjxg+Jy4xeui18WReg2QfDURI/0u+AOSlOTPgQyjH5mi5naMXXC2CdwbsZbC7+EZ7r/JKfXwjyUXE6pzOYCEod1UNLNk2EQohP3S1FqtUk8YPsjoa0+c1hb7MSl3b7pK1jnomCZ6prdvaXdRbn/FNb7lYSA4KkFYffQHkXBE8t3KP8/1nQywyYVELwMG3+yEdDUOhZPXuyIINbDO/uId/hceOig8+ZYAfwQ5VSrsdxSlgaiQFG6IT5QAj8WHLlfjzThimWwHfJYXGWbm4/DBXhTnpNeyT0T3jH15teiXqNsfFSW1CU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199021)(31686004)(6666004)(6486002)(478600001)(110136005)(66574015)(2616005)(83380400001)(36756003)(31696002)(86362001)(3480700007)(2906002)(186003)(53546011)(6506007)(966005)(6512007)(38100700002)(66556008)(66476007)(66946007)(41300700001)(316002)(8936002)(8676002)(5660300002)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW85aGRwa21IdWpJakd2WnZHanBqQmpxRXppL3FiYW5oQ2JYK3k1UXFOZTJZ?=
 =?utf-8?B?VkJlTVh5Vlp6UzVzZ0FiQUg0ZFpaQzVXcUZYcmpSakFZbDdGVWJWQlBGMU1k?=
 =?utf-8?B?ZGMxbkxSa2NjMjFKdzc5R0tSeGlwUEg0U3hSWEFzQzVBS0xFbHZEUDFIVi9s?=
 =?utf-8?B?SUQxVTVCWnJtNzBnNEVJcURFTWFhVlJFbTBNRDZ5aXpaTndpWjArVUtyZkdx?=
 =?utf-8?B?K0JEVC9NRXFMZ0lKUWlBQ3JURElkVWpOMVBoT2NEWEhaaTU1bTFVTElwLzVW?=
 =?utf-8?B?a05JQlZ3R1MzOVdQVTV0NEZKdTRkemNyOHQ2U2ltVlUrTmllMCt1aDBCTy83?=
 =?utf-8?B?ZzIrU3R2eXBud1FGVTR1VHZyZFJDbGtoU2ZvSTNTN2daQUh1MVkxQVZRdDRv?=
 =?utf-8?B?eXpia2dlZjRFTHRwVEFFb3FNRkxYRnpvaTVRR0RNOElad2lxODNhY3I5TklD?=
 =?utf-8?B?NUZ5dC9pWGRnYXlzcGtLWnNTTm4yclpyOTgzakVJb1JxelFOc2hwcmY5Y055?=
 =?utf-8?B?R3pBSmZPOEwwanBQRDBFUTA0WFVOTmFnUGd3Kys3cmVRRC8yUEg3clpQSmRD?=
 =?utf-8?B?OTJEY25Vd3FEOVFtRnVQYnBTQW5jb0Y4SGpHZzEwTWhjNzBDM3NsOS94R0dX?=
 =?utf-8?B?TkhwKzFGb1NvMGlFNVN2YW10UEpLMnU5VVBJTDhSWDZwK205SUdwWFFhckhP?=
 =?utf-8?B?anozdFNwOFVHL2JaQVpGQ0tKRi9HOUxsTHBaNVFNdGh2ai93NE8vaStNMUVR?=
 =?utf-8?B?MHhnUi9Ga3pGYWVpVGtKQnZRNzR2UENtVHhCbk1FbDlubU82WkdmT3JKVUVK?=
 =?utf-8?B?QUpoNDNlU2VQV3g5SWRnN1J5amEydEVPSnhxVUlicUVpZ3RYZlFZMlpTUENQ?=
 =?utf-8?B?Z1pOQXVacGdOeFhYdU55TU95dVZLeWxhbGtUWkhIY0FyRWllUVY2SzUxdTJC?=
 =?utf-8?B?cE10cktpdFhiTm9keDV4cUNBTFViby9XMW43dk1KZHUzUTZqak44cVlERERO?=
 =?utf-8?B?cE9RekppeVM4dzduVW8zekc0Nkw3T1lsU2tnUDNSSkFVTWg3RU52Qkcxb1pP?=
 =?utf-8?B?M3Vib01yZjRFMnBudTUrdjdCM2F4cS9YMjJRYndzRjJxRjRZcDhobTc2elZL?=
 =?utf-8?B?am5FTGIvRTYyZkVaaS9nTU91TnZPQ1pFb2hpR1g2dUVnRjY2di9yeUMvdDJF?=
 =?utf-8?B?QkNITWxRWDl5WVdNejI1OXN0eVN4Z25qNnd3VGc5cGdGSVRxWWtydGdQN3o1?=
 =?utf-8?B?QVY1MGpSbVpxYWtqQ0FhWUFnK2p6dFlJYjlnT3llKzJJeVhsZkZYamZ4N3pU?=
 =?utf-8?B?bTVJZG0ySFgxanV3VHVEd20zakdEWmR1dys2OXRqK0N3RTA2NUwweHZUbGNO?=
 =?utf-8?B?YUl1L2VzWHllT0ZWRHJ1dllwc3A5c2xhTGtNR3MxZm9sM2JrUjBSVG1XeHdT?=
 =?utf-8?B?M3N2K0JZbHJGc2lBQkV0M3Jsa3BQK1VLOHVvSm5NMXVlakVydlFzUWJHcmxx?=
 =?utf-8?B?Z3lVR0k0RWNWcU9HdGFpV2ZLOWhJc0U1Sms4eHhHODJyU0ZQb2xhdXZLYlRr?=
 =?utf-8?B?TUtzQkVDbUdITGhDTlpiMS9aTkwvQXFldmlFbFliaGJFRFA1UGljUkUxVUZl?=
 =?utf-8?B?bUozN1dJV0Rvbnl6cm9BT2puemJvNjZWamYrOGRSRmdZREQyRTVMZkxWYVFv?=
 =?utf-8?B?azhUbjV6aWJiOFE0YkY1ZUptTDdDemFRSnlRMmJMY1lHSEZkcDV6QitxM0Vu?=
 =?utf-8?B?SmtNeGhXWlVTRE9xbGIxdGFJL1FpTVJIZmxHYnJBenNiUDlIeWFuVWllUjhZ?=
 =?utf-8?B?eDR5QlNVc1FRS3pER3R1SncwcEJxVjFVdEZlZFFxSjcrZGlTRzlWcGtTWnNu?=
 =?utf-8?B?enlyNURTNHE5V1BvR0FRRUhmQ0VvbTZXcEprZGRrY3g0NTBHNldlUGRhWkFz?=
 =?utf-8?B?Q1k3UjlHWHVrbVFzOWwyRnJ2K2NhN1hhOTNYdnVVMllTMXZsRzBpUVlNTkc2?=
 =?utf-8?B?TWlGR2hXQ2ZrNTNiR2NTOUhQeWo3RmxLMGJRdkpVYjhNQVJCSUFmOU9aSlBD?=
 =?utf-8?B?NmZnU3IzRlFrYjdocTZXeXZnT3pnVjBHaEg3dkl2NGsyLzM2Mm93YWt1L1di?=
 =?utf-8?Q?BLtQaIhV5v+w+uqZxV/Y2o0AZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715b5fe5-742e-4943-4a16-08db7f715764
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 05:08:18.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9rdcEuJ5Scw7YzJCed7w5hIXdmtygHWczx9lEvQ69BngqkpiLZNhc5AL/KUcXwv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8175
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/8 04:54, Bernd Lentes wrote:
>> -----Original Message-----
>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Sent: Thursday, July 6, 2023 8:23 AM
>> To: Remi Gauvin <remi@georgianit.com>; Bernd Lentes
>> <bernd.lentes@helmholtz-muenchen.de>; Qu Wenruo <wqu@suse.com>;
>> linux-btrfs <linux-btrfs@vger.kernel.org>
>> Subject: Re: question to btrfs scrub
> 
> 
>> I hate to point my finger to btrfs itself, but I still remember in the old days
>> some workload can lead to such false alerts.
>> But I can not recall which commit is causing and which one is fixing the
>> problem.
>>
>> Another concern is, the report is using SINGLE for data, which is completely
>> fine, but it doesn't help us to determine if it's really a hardware data
>> corruption or btrfs bugs.
>>
>> If the report is using RAID1, and those corruption are all repairable, then we're
>> pretty sure it's data corruption on disk.
>> Or if all mirrors are corrupted in a RAID1* config, then we know it's definitely
>> btrfs causing the problem.
>>
>> But with SINGLE profile, it's really hard to say.
> 
> The server we are talking about is still in testing, not in production.
> That means we can change the config.
> Should we take RAID1 into account ?

Personally speaking, with your hardware I already believe it's not 
hardware causing the corruption.

But it can be extra safe if you go RAID1 for data, and re-test the workload.

If the corruption still happens, it's almost sure it's btrfs to blame.

Thanks,
Qu
> We have enough disk space.
> 
> Bernd
> 
> Helmholtz Zentrum München – Deutsches Forschungszentrum für Gesundheit und Umwelt (GmbH)
> Ingolstädter Landstraße 1, D-85764 Neuherberg, https://www.helmholtz-munich.de
> Geschäftsführung: Prof. Dr. med. Dr. h.c. Matthias Tschöp, Daniela Sommer (komm.) | Aufsichtsratsvorsitzende: MinDir’in Prof. Dr. Veronika von Messling
> Registergericht: Amtsgericht München HRB 6466 | USt-IdNr. DE 129521671
