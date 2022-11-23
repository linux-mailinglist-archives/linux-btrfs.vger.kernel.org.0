Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454E4636C88
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 22:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiKWVob (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 16:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbiKWVo2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 16:44:28 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130055.outbound.protection.outlook.com [40.107.13.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E964C9A83
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 13:44:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ky0OZMwnBAmMscP8F1gfKt92JjwJYDSyeCO7VduwqD/XbZgS1m6F84mfAYU1rEDWNq6vAo77FH1F3FOidydfNaz7d8gmdvxmk9w9QKQzjwEpTIF12/cfq1laiH80zm153zdfabfMf34Vsb8anKTjIlPOQhvddOtOsC/OzUbGRkCawMZR41M46i6kHqkCLfVG2FX7A9GdryhWlM1NhgDudNukwmthHAstzUJqbpNbDGhxKJk4GEwS5fSXtIuKaIqK1Kar4uLQHgNYz0Xjc6NQ/c1ghPfID6RmN+6VztBDtJuP1vIcAx0iUugYORtBtYZ8JyizShOvyKpDLwe8GSoddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QpaN/uCpow8Nzb+YDmdnmfdqeqQAbEyRJ4AvIEoOC0=;
 b=D25O2APBcK+Iv2SY+ETjH0Fp3Rg358b88Wkvf4UalGO52KO/cJiC8B1/isLArAPhk95e2So4C6srJGjlTQOT5ggR9zVMkAS/G2if4mIoiQpA2fNDbpKUy4ap850hpE4aq2fNWzUIhvWDo8ciGVX9uB3nn/G5buDzLxmagyGqirChBMIeuNbmOFIx2HoDiv2FgJoFhgPFqlr9eTzA3TTfc6L5wKy2CrcoFhIZB9tCKvuNVfdxm1kHlVvrh2M8yBBrh7tq4vjN4zgHJjPYcv8+5BKPpP1GUKekXHLswqtrZMprwPXRwBlVeamTn24nWHsU5O9knmgX8FbDAVNDBkIjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QpaN/uCpow8Nzb+YDmdnmfdqeqQAbEyRJ4AvIEoOC0=;
 b=MJkBYTZsk838L7YWmEM4Sl3PK+Y5LdFotG3TfdEwjyKFVuBXiBQ6gwQS1NMPuDbFcF8b5wuFgQHQlNIrtZbJMLAequbiN+Wab8VASdEn7HT7xaZNHclOh1pjcHs/2LoPDivf4vIl9zcdnMLF+rWQmjfV3QpiUN4MJPyRY+nQZ28GNfEzHoS5RR6x9Odx4TzPuR9Pi6tbAu9PyYDbqoFv6tlz5jTtr9afEgn6Pc2HwPmzsrmK4+PmS41mg3/O3BQVjmzq4pOajPqicZsNq7zFHwmeQZSxPNWA2d0riUBkWy6POUvpscBhEisJBzRIfZ2cgVWqhVZtXMHI15DFBlfvTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB8140.eurprd04.prod.outlook.com (2603:10a6:10:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Wed, 23 Nov
 2022 21:44:24 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::b69e:7eea:21cc:54ab]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::b69e:7eea:21cc:54ab%9]) with mapi id 15.20.5857.019; Wed, 23 Nov 2022
 21:44:23 +0000
Message-ID: <376af265-a7c4-6897-b6fe-834d225b150f@suse.com>
Date:   Thu, 24 Nov 2022 05:44:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Speed up mount time?
To:     Joakim <ahoj79@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAFka4xNPJby02JcK+immNU+AL6w-=iH7tNB4ZjULoYxnwG7U+Q@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAFka4xNPJby02JcK+immNU+AL6w-=iH7tNB4ZjULoYxnwG7U+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:a03:100::39) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a996ac2-4465-4f52-1de5-08dacd9be1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oe8T0Y2w3SW9csNfMbirfZzwzR+8Af4PaMR/uqWwdFCVX2YvAwZ4/9m9doBXRxI0MBQgeAvUP5wz3p9SqgdL7K3ObrVbJD3lhkg0B3ANo++2dobfIx5fYc+EBBk/4ZdA9qX7e/1E/9OrUmn8RntA+Afb4lDUEFi9TWiu0g3w5bZ0QiJT4YgtBq2fOaWKJRx9W0Vyqp+JNJJvV5sr3fGQe8j6tZWDejc6jcm+Kevr05FC/nwTMrE+ZxqZYN/c3gWibxL0TOAG2WX70JMof2dFINnXebF6XlZQZ8q6QyXW0JGJ4tTbzyPJIkLcyTa2R19iVd6+y9xI1Do+EulCjKn+2+XjC5OdDspYlXDPauNItsb7u6kJ4DBqcmVAGO61xBLPShy2LceRUuMksUo1oWYURiMCveZt1T8z8UBmbbGP+vij2sy1luvPf/OuWx0ovMx9M+l6go3wl0mht4xDWboEvM4oYYP46EihVOA+4CeOzf13r9j2oIzMDnZVIuLMtr5OusLXXN4tP/7H4VHMvlqujdFKjkdjPdHiVUGeL4cCJWczcGplJxbFPEB0vcc9v+6mWPrWpzxqq2hwLKy3VN6jS92EBFzKtlE3qyuwz3ESprVYx8TrVpBYJvzFFi/n09Q44p00CXq+V1jEP+mQwc6NC/jcaYSTE8TFMgamnbCnwDRFdSZyldb2yyRycBU3DBuC5y1cnzCHhww7nA1hHuNHhJYcC/hYoAlrXahHC/cCY4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(31696002)(6506007)(2906002)(83380400001)(6486002)(86362001)(36756003)(478600001)(3480700007)(6666004)(38100700002)(186003)(6512007)(53546011)(2616005)(8936002)(41300700001)(31686004)(316002)(8676002)(5660300002)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkF5b3ZFbmV2Yk9ZL2liZzZhbDNqcGthQ1NtRlQwNjAyNFp6VFFwMDdLa2VU?=
 =?utf-8?B?S29yeEZMMG1SVERSVksxM2paeFpnMGtXV0NGU05WYmJ6WEZFNGgzNXN3T1Fp?=
 =?utf-8?B?TUxBMVpPanpzSWRVTUpWU3pEZUg0Y05xaUYvSmdXLzRmcHo2dUQ4Z3AyNWFM?=
 =?utf-8?B?eUJGbFptbzlaOU1idExWMUliU2RsSEdvTzBPK3IwNEFYUDd5V2RGTTNPejNW?=
 =?utf-8?B?NmJ1ejhub2RVdGJndTJaSk1DdjBYaDIyNDI3MjNJNzBUeWdzeE0xakllWXJl?=
 =?utf-8?B?cjR6REEvSEpyRERvVVN2UGVHVERNcXVYNWxZT1l2L3NCZU9BTTAvNk4wOG5N?=
 =?utf-8?B?Wjl3NndaUzUrcGhsQkxoYWpLTTY3QWV0R1NaamRVdHhqc2QwTVBWRWRtbjNu?=
 =?utf-8?B?SFkzeWhOS2NyMjJuWFIvdW9KYjNOQjZqMmo3bEZrbW1jSXYrUFVyK1kyTk5G?=
 =?utf-8?B?N2lDMDFKQTRrTFJkcElvWmkxM3YxS0M3TTZ4WktLR2lsTzR0VFNFekM3VmhF?=
 =?utf-8?B?VTRpR0Nic2RUWEgvSFY1RkxrWnMrOXBjZ0dseDU3OWQvRHl5cW02aHdpWGgw?=
 =?utf-8?B?NTBLdS9uczBCbWx0Si8zOURkV0xOSjlUTWR5bTJOdUUvaXFSSEx5bjJRL0R1?=
 =?utf-8?B?SlRRLzFEanlqbXorUUJsczI4VkxtVUtsZXBlQjhNN3dvOFlUZmQwV1RlajND?=
 =?utf-8?B?SkliQk1kWmFQOER1a3RtNGMyZllrS29wZ3AzV3hOTHRwcUVPRTJaSStEVWVv?=
 =?utf-8?B?enAwTFFBamprNFFBc3BzR0ZibGhsNnJGSjJDOWd3cCtqdnlnQVZ4UlNWWWdx?=
 =?utf-8?B?Q2xZNlFRVlZ6WitZdXcxMkxEVm9yR3lHNUtQMGNpNTBkZDNqMFN0cm5YQmh5?=
 =?utf-8?B?QjBDRWxSdWU3Sk5TT1RLSmtBNlJud2QwRnRQSnFtcTFOdFpuTm9lcGZubTBW?=
 =?utf-8?B?cXJRZVhTSU9lWUo1UnNQY0RKOUdyNHIrMUNYWnJMWEsyY2d0TEhnZy9xc2Jn?=
 =?utf-8?B?SC9MV1JoWVhRZ25oQzFkaTdpMmZGSytiQ1BJanRVM2JPYzIwbmUwZm5WVTA4?=
 =?utf-8?B?djlsbS9ZcGw3c0EvVmJRWlhGc0JuWDI2SnVrOUd3eEk1ZFhZS0dmZnNndW1q?=
 =?utf-8?B?WjZ2eTdTdURWd0IvYVB5NmtNc2VjVENnYkhaRlc5VFRwc296V2ZxUUxrU0gz?=
 =?utf-8?B?RnNGeFJ5dlZUemN5S1c3bENwcFhDMDVIY3V4QlNTaGdwazl2MTRIdFlTang4?=
 =?utf-8?B?dDY2SXFtTUhDWG9VRWdnR0pDd2JtLzNDTlRWempFT0lUbFhBNjlubmJWZmdw?=
 =?utf-8?B?K3ZaWVpEYU1tSkFQelRrZ1VrMEVKNklKZTRreUtNZ3doeUs0YTVQUGR6amx5?=
 =?utf-8?B?WXlTNUd6V2FzN3lKQzU5SURteVZiMTRIa1Fha0prWWJWY1pRdlRIOVp1YXVt?=
 =?utf-8?B?bk9GKzhwMDZrSEdFUDIydXZ0M25DSWZLMXlHL0trTGZRUVBJV1pzdEE3bHhW?=
 =?utf-8?B?Nzg3Sm1qOURreHp6WDVLMGdyYU5nZVVRTi9vTU1zZGVzTlB0WmxRbWlUclMz?=
 =?utf-8?B?cVIxMlU0M3hmTmloT0U1SGpKSFpLU21SQTdPSEZ5TW01YjlwY1NRQzBVR1Az?=
 =?utf-8?B?NVJPWjcxSDBGa21MSFdoWlU0VkdpNkwyR2FOVHhvZlNlaS9JVEEyWjN2RVZG?=
 =?utf-8?B?ajltbzNVWmE1ZjZlR2Z3alg2UzA0NmlNQlFubUdUTXRyZGNoMlBQR1JEMDJE?=
 =?utf-8?B?bVJKT3NjZFhIaHR0STlRZzMxWTd1anZpeHE3Ty9MdXNPMjVVM01BbFRYQURL?=
 =?utf-8?B?c1ZCZkt6NjM2eVYyZVkyakdUMWM0bk9pbG1XUHlGZ0NLV0RzYnNGM3pOQm9v?=
 =?utf-8?B?WStOdmdPSHNBUWtWS3l4Tko5VjRWajlkWXZqUGNTTUJ5dExHZ0pxL0JzZkxG?=
 =?utf-8?B?ZVZyMjgxUnA0NVYwVGF2a3RIUVRGeDREM3RBQXpJZ3IxK09zY01KYU5EOGtv?=
 =?utf-8?B?cVg4YVYyL0dWTFJnRUU2SXBNejdUOC9zdTdsL0Z6MFB2NnR0RUxNMGZsejZ6?=
 =?utf-8?B?bDZnbjd0VXZuM0pzWjVNbmRTV1hBT05EWXZkMjdoRTRHcXFyVm1UTWozMzNJ?=
 =?utf-8?B?Smc1MEJhR0UrYmd3MXFMMTRyV243UG82UGlKVTFUK3ZDM2F4dDlhTWZsZE5L?=
 =?utf-8?Q?4bWNFJYxTZroVmCmbCQR1uA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a996ac2-4465-4f52-1de5-08dacd9be1b7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 21:44:23.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpOj3JmYt94u+3j8vdCTmKdG9o1Aa/iGEem6EpTmVNmas2jBn+CH2DBO4s5SCf5q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/23 20:33, Joakim wrote:
> I have a couple of machines (A and B) set up where each machine has a
> ~430 TB BTRFS subvolume, same data on both. Mounting these volumes
> with the following flags: noatime,compress=lzo,space_cache=v2
> 
> Initially mount times were quite long, about 10 minutes. But after i
> did run a defrag with -c option on machine B the mount time increased
> to over 30 minutes. This volume has a little over 100 TB stored.
> 
> How come the mount time increased by this?

In kernel 6.2 release, we will have block-group-tree feature, which 
should greatly reduce the mount time.

And we will provide btrfs-progs tool to do an offline convert, keeping 
the data and enable the new feature.

Thanks,
Qu
> 
> And is there any way to decrease the mount times? 10 minutes is long
> but acceptable, while 30 minutes is way too long.
> 
> Advice would be highly appreciated. :)
> 
> 
> 
> Linux sm07b 5.4.17-2136.311.6.1.el8uek.x86_64 #2 SMP Thu Sep 22
> 19:29:28 PDT 2022 x86_64 x86_64 x86_64 GNU/Linux
> btrfs-progs v5.15.1
> Label: 'Storage'  uuid: 6ecd172e-3ebd-478c-9515-68162a41590d
>          Total devices 1 FS bytes used 105.04TiB
>          devid    1 size 436.57TiB used 107.87TiB path /dev/sdb
> 
> Data, single: total=107.34TiB, used=104.82TiB
> System, DUP: total=40.00MiB, used=11.23MiB
> Metadata, DUP: total=269.00GiB, used=221.57GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> [   51.764445] BTRFS info (device sdb): flagging fs with big metadata feature
> [   51.764450] BTRFS info (device sdb): use lzo compression, level 0
> [   51.764454] BTRFS info (device sdb): using free space tree
> [   51.764455] BTRFS info (device sdb): has skinny extents
