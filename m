Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B92543167F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 12:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhJRKyC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 06:54:02 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:58539 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhJRKyC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 06:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634554310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4t61RqxfxqESJrRRRZ/onPeFLABphm7K4c76nFPJig=;
        b=AWSjFiNbSKQUDXney5lArNhVzuaLcHq1wiK8415EdWJ2h7NB9GVrHM4isFjd3uziiQ3bQA
        67EzOM2U6qWtTPT7Lvr8owFm/i2xeyzcRUVqMKoDb0GUBoUREON5RL5ne2ZmQXbK6c9sey
        a5Sc+oDMd8xwS2UlTGt6NPpfSshshXY=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-8-UI8u31tlMISRxvGjDXOOZg-1;
 Mon, 18 Oct 2021 12:51:48 +0200
X-MC-Unique: UI8u31tlMISRxvGjDXOOZg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4Hd/j2upL2GscB3WoxmCpNtJS2anQi4gUho3y0HU8XrKOzsb52PjoUWrt2QUlOD5t/UKx1pOFjIF5zpPqCZBghSB1u6dys5VhDnDmPabV1Fb4T/5X4guU+3mxgvP8xBiNV+Cu/4UXRAzotWNnLYcZFlfSPkRsxW2kw6a9FbBbGQlsziCg8Sqh+R1SeBFh1HrN8mlUmUnAkG5sZkGKQaWTIZOUfK0qIzPJOoRB3IKHxb8tz6hUpLIFWu6QwkftGD173/taxa73m/N/fl6/Z+HeMdcZQpwqji6Gkr+kwh1dD8OxEEqh1Q+m81dodsU6UTkyzCiCCMaOi1I60KqksTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4t61RqxfxqESJrRRRZ/onPeFLABphm7K4c76nFPJig=;
 b=I5bTF2+dgH3GX8q/i4F94xL297U04UDzZhYAfEFb+0IB8YFtsFhDpXowWZ4RTZac2pjeI4rh4E+KTrlKHsMNHjMkzVE+cF+82pQOizDb/wy8M1ZtbUL+boWoE8epgCk7HxK3ijs//+2u6ykxVUBZvlUeflBJxqQOoXspvOnekPH1EPOStlJq9FU6loOM4uNJ4O2GamqeZSQ8y/nn2njXQwdmjyRPQv8rn2VtIKSnlMNKJ8E33BCqWgrTFTy03oE9rCQeQ28Y1sF5Mo6hukC/2PXwbOIiOIcvu0uY98G49p8865GXkrbLBdaduwGCsZCok6lmRbpqJYuY4WWyJzIerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3445.eurprd04.prod.outlook.com (2603:10a6:209:7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 10:51:47 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%5]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 10:51:47 +0000
Message-ID: <9009dbe8-46a3-bdc0-48f2-5e78881d6a97@suse.com>
Date:   Mon, 18 Oct 2021 18:51:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] fs/btrfs: Make extent item iteration to handle gaps
Content-Language: en-US
To:     David Disseldorp <ddiss@suse.de>,
        The development of GNU GRUB <Grub-devel@gnu.org>
References: <20211018124903.661dca99@suse.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20211018124903.661dca99@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0377.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::22) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0377.namprd03.prod.outlook.com (2603:10b6:a03:3a1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 10:51:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de9b6a16-238d-404e-fda6-08d992254800
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3445:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3445AD715FC8B729AC42C68FD6BC9@AM6PR0402MB3445.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfyZ97UeInfRE6sm9iDXR89/FwRBfJsjsNFyvqBqc8koQUf8SYYaZGHQuVsardgrsyj3+Se7IdNPWjMdeQSQ6OVbi1cKeiKaWYm5UgkQ78vLjoPOZA1Hc6CYoo2VGVLgUWzE1FsKl20ojwxShpBpNOvD0cN/Aa94+wu+3xxPVE7z7binD0dZo1IS16dfsqyp/cPBAHQ11NCKhQaRE6wENUi/KHhjmx4Iina/h9a7FYu5eASYIHUMyo97L5DdepiYptxLMjRH+W95HhQjxlA88nxf2LOOFs/JtsB0MQLvwUXkhRPJ9hUJObEK3O0aX25ezLAfJO+zjK4PW9fPx9uVdkPNg/cLG4T5X7eIwjBGVFi80fxQOpqVXO6Nc1Gu+fGTzorhr3CNo+LJACyq7gLy9ZLd+LFWk8PYaWpc9w0228MMeuJ/u5Q8le5NAyRX2AqcebI5C2PVZA49Xuxlm8jHevpPpk+xOlbdLeJ54XR5ee5ZplvdL10XGL7r52vhP+PGA2SBuqMcB6KUVCazK+0HK1frBmb5R33mxybA9tOBoIVE4mUBZf/bg2wqgtpQVlSeCHmVrDnuaqU5T331of43WnLfOWBeUGLoi5i5G2jf7MUJbplcTkNrfNGntBTR/iP4hA9/8tXV0Brgw9EMC4OKpikhRYRI9a01NK67fJxm1ryKkPBC8l6zJBfvf3p6tiH7aO/LATfpX5QMA1/HP3bFJpbyar6UUwUdUpgoE9YJGGm/J4mtUDzWOLV2+ybS16gOAMxlqEyNTkaj1d+UM1JabLq7WRtG+MzkixucXVWFYWgKMzoYoQsZXZNttGFSkyV8x//Dac1vbfgqf1v3ZkG8ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(31696002)(5660300002)(508600001)(2616005)(316002)(16576012)(956004)(6706004)(8936002)(110136005)(4326008)(83380400001)(36756003)(8676002)(2906002)(38100700002)(558084003)(966005)(53546011)(31686004)(6666004)(86362001)(6486002)(66556008)(66476007)(186003)(66946007)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHZtcTUxNHBtQUE3Vkk3K0hrdzhvQ1BpZWlpYzQvRFp4L2hpT2JOUmJxY2xQ?=
 =?utf-8?B?ckxodGEzV3Y0M05DZFJOUmZYV3Z1SkN6VVhTWEVNQ0l3Lzh1YWZMbUE0TWIx?=
 =?utf-8?B?ajNOSFAwRkl4L3FxU2docE9WaTEyU2VhdEpDNGZKN3RNNlZoRjAvUVpTOGRk?=
 =?utf-8?B?dmYyeEJRUUo2OGZNT01wQWxpWkxWai95M0ROZFR5QU5ic1U2ZVJCVjkxekNu?=
 =?utf-8?B?Q0c0RktHdU9SQ3FWZ3RXY25IMnBDMStHcHRrS1J3WUhNajEyd0RrQkpsU25N?=
 =?utf-8?B?SlZjMlNWK1hIYXMwNVhBY1pIM2laZUFiM0N2K2VqS25lbDkwUmFsZGNscm5p?=
 =?utf-8?B?Q003UTF1eUwwM3lYeVhNc1JSZlVSSXhGek5UVTBYSFB2V2FvKzBhZGhEWlZH?=
 =?utf-8?B?a1gwZ2FEYTdNemwvNnNFV2RuOUNrbC8xUDhnRWx3MVRPRWgwUWlPYng2NHQy?=
 =?utf-8?B?TUxDUG8xZitneEUvcm9oeWRnSjEyU1g0a050MGUzZmxVb0ppelY3aE9wNUtz?=
 =?utf-8?B?dXp4R2pYWjVoUUdQSU1SOWhUSlBZejVwN2ZVUzRoY21NMVpkV3ZBUXlKbmFq?=
 =?utf-8?B?bXVnbWFzKzAycU9PREUvVEpRanJwalNiSDR4SGNOVW1qaW1GL25iT0tsNWlI?=
 =?utf-8?B?S21qUmc3dXV1Rno5Q3BlR2JPTUpzSDBLMExRMGtpVERIRnBBbVdzdHVEbDJn?=
 =?utf-8?B?SXBuSmJZZ0FOcGU3Y0NMMkpNQmpYKzhtdUhGNWhVT1Q0a25oa2NtZDQvbVNs?=
 =?utf-8?B?R2hRQzRUb1FVd1k4V2diaTA5d2JaYzRMK1JZU2hOdnVMajl4S1VSalE5dVU4?=
 =?utf-8?B?c3BZVnByblNoZDhtQkR0bkg3Qys3cTl3M0plK08xNXUxcEFXK1lEWktDTXJh?=
 =?utf-8?B?VFZ5bDJhRUVjU05mOG5RT3d6cDNaejFZZzNxendybzRBSHljZ3FWSjV6dENr?=
 =?utf-8?B?dFZ6SnVUTHlLNWNvSTRTUE1wcTRqWlBiVXZvMngraUs2ZnA0RnlLdjdKaVpQ?=
 =?utf-8?B?VXI4eDJWZkk1Qmp3MTR6a0RsM0VIcWhZclZNV0MySlJRNXlqczdFUkFycXFN?=
 =?utf-8?B?aFdDODd1Tlo2Y3Rha2pPMUhnQSt0NW1nV1JGR2xZTzVvbG5wcmpsclhmdnhz?=
 =?utf-8?B?MytiSXpxUFlqQWxzNmdQSm9lOERCZ2taUUlXMjZZRkMwSGpsbWZ6YnJuVStL?=
 =?utf-8?B?VzlMWm5ISXI4bnVVUGkybHlqZ29TaWVna2pqbDZIVk8zZ0MwdzhISUp3UnA4?=
 =?utf-8?B?SGZQZllqMXZmY20wVTNqcFQyVWhIRE55L2VhZUxvc3lxdlpXOFBXV01IZUNT?=
 =?utf-8?B?cERNbDR3WHRmUjBZR2ROeVpjdFhza2RoWExxa2lUdWtwRFdXWFQ2eVdOVVhF?=
 =?utf-8?B?ZWZKdjNucFBSUjdGcFFVK0IrY2VlRjJOYWVWMkFIZnNnMmVSbytHUFhoeDlT?=
 =?utf-8?B?NnNGUk02TmlpVjA0cENNVmQ4b3d0cG53cFduN3JIc25PQWxKSzJFOVBkOVEr?=
 =?utf-8?B?WTVOTXQyekZESXhqMkRrbkpZQnVJUkkyUzFJS1JzVFVTdUtLSUdRWFVaOWlL?=
 =?utf-8?B?clI1YTVpZGQweXlIRGkyWExxZXRJdE5FYmp3WmoxWldpRmtsMFhiNVBqQThH?=
 =?utf-8?B?aVBXM1dVYTRGWWlVVHh1Wk84NjNSYjJXNy9EZlQ2enRNUFFWb2FTcjZLdzlr?=
 =?utf-8?B?Tmo4NXAzUXhvSGRIZGp4MnRsMzBCek5oRHY2SjJFdWlWY2ZTNVBHZ2lPRzdV?=
 =?utf-8?Q?9XuUAXeQStjxBg9Q1gfnFHZHTjrlQeXla4LhV49?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9b6a16-238d-404e-fda6-08d992254800
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 10:51:47.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMOBjzLN6R9HAvwAvqUQe3Ptco3eRD5HX4wqUgOM3X2WyJfYDAogl4rRhPrtAP4h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3445
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/18 18:49, David Disseldorp wrote:
> Tested-by: David Disseldorp <ddiss@suse.de>
> 
> This fixes the failures seen with the Dracut reflinked initramfs
> patchset at https://github.com/dracutdevs/dracut/pull/1531 .
> 
> Thanks, David
> 
Missing CC to grub mail list I guess?

Thanks,
Qu

