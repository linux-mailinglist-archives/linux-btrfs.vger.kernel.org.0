Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088D449A755
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 03:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiAYChW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 21:37:22 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:26242 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2370899AbiAYAGd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 19:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1643069188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PHVImHyMGOUVDEXFzMi7uyS8DQjaNqxySgPxsJb/PK4=;
        b=VWWIvXT387PrI80z6WFKIx0rXPzDCKdIvfUHPG+Z34Tf2bqbHUWcWUTIpqS2I58pOfGJok
        vbcpJu69ctJCLLN0OwhlrVAU3LF6LHryGZn1eHmit8wPg6K3OqCUj+vh2ZdQrVwqXEBXI5
        8geX+FJRZXqhFq7oNttGO64t4ZtJXkw=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-ettgblwJNUeNg2lzxnz1Nw-1; Tue, 25 Jan 2022 01:06:26 +0100
X-MC-Unique: ettgblwJNUeNg2lzxnz1Nw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsUy3oWfkTNfN7rv1470kSqzNJf8GqQu4Fddxlv/kQvkgqmcy4OtmB7MwWL9e9z4IyzyfTOgY+vpQ4hTPf1AoBnvVtNrTzlMIi2R6lEbgWEqVVG6yOIjy5yGWn1j27LWdGztG6bRRp5GeVqP9NCnR2ISy73mxLMucJUKTt6d6yjaGU/MlKTOBU/ACHxu/ycHLOHx8dQvZmJeanKUp1gAtGQlEmp5/6cPLBX2GF0IW790fNujmmE5Z05rmLEbeXEXcmtb66IC83VA2NvXZ3x2BD68aLRjX4YN+eeN1F4iq4H/t3eRMv3iClJnvYxmQi08aDymofx66X2WZxvlACdSNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHVImHyMGOUVDEXFzMi7uyS8DQjaNqxySgPxsJb/PK4=;
 b=BAtGPIWERSFlsPXt2Z7zWiSBJz9Pf65929gYurt9h1hQJYl2XX7evQwkN3LaoDd6AFdeI5kEKFNTHqJCtY/tdo7g28vjXf/Qci8RI5kplrw1JuGHu9xHQZI3uDqZZocHw/Z3o0w5GRuTWcGXz3CxL+YizB/BhDggePQXdGBACbPdaWoMW3CpLJly9bh5dpXQcFGNNQ8Xc2U846iqe6DSJgDBpUpZXp+EVV3gegEAK7S2+n17E/212/IC452vO4nvmdJgmr5Z7HQtzvMZL4vGCE93fexC67bgsvD1oh4vW/nauH3/U2TDGHUrdunwXB14yNzKTCzrwdSoe9hWEq+Shg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by VI1PR04MB4655.eurprd04.prod.outlook.com (2603:10a6:803:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Tue, 25 Jan
 2022 00:06:23 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e%5]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 00:06:23 +0000
Message-ID: <232987f4-b64f-913d-c3f1-fe4e2b3c4750@suse.com>
Date:   Tue, 25 Jan 2022 08:06:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] btrfs: refactor scrub entrances for each profile
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20220107023430.28288-1-wqu@suse.com>
 <12e31a86-79b6-d806-f232-51e9bb0a7e07@suse.com>
 <20220124202411.GJ14046@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220124202411.GJ14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b10c7a84-2670-4a2d-3348-08d9df96858f
X-MS-TrafficTypeDiagnostic: VI1PR04MB4655:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB465534E2F36031F3FB3A5AC7D65F9@VI1PR04MB4655.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tbo3By1WS2AjpcdnGLTWKN3psvQ6+AgegDWr+B4aAoi3X24kr3Y9tl2KJvYs0piMC6wO2HhUT2+5bbyXFmkuXXlLx8/FLTTaJhCUj4FuN/LowlMcjhXK5lTa87Ydl0YDKJJ9doS2fc4yecTAjqrFWxflOsOCXUYlny+GymTsgV6GvscHdwulegBKyvX8FQ+emE3Vm40Ix5qam4Wx87NAtJap2vrhzX97mH/xUHEDUQqs+sIXjgX04kvinyokPvWGbC8G/N+/uQ7UvownATWYDTQpKybA/BFghpy0ECkwaAyhuxKJ/GQYUsLKBixw20vnwGs7kjV/KWltlCK2JSe8mi5HR72PFP1mDMff1x+9M57kxRIkdSQEHia2rpWeCA/1zaXJUDXhLTA+WpJ/yfuAHGgd5yySFcXp4zqx/F6UydG+W6YosjBWft0AegR/QBIMURZPtnzIVT3MDgAgJhpxnfWRU7DDNYbcvVhLvzNJ3/FdD2qHWfccTu5j/sAceAS9Sa435S7uznAVajAOa6KkZAlBF4dDTBUap6ZpJuH7UA6Qs/RRY+tlK9kLRrjgtEgckgkb+taEaD0HH4hoo5FhR+hxKRojkdvZy0fZHQ6D+1jXQVRtPYSzQj1LRUeWwxgWr4Aq0TXheuwM0o80A9WuL4Yi+98ySo3W2awCKsUqlSVvD8E8isNTh4L8fBk2Z29D/j8vqFv+gJRBKtcSC+3NPRpLBmirwpaoBs7Sksweipg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(6506007)(38100700002)(6666004)(2616005)(53546011)(186003)(66946007)(31696002)(86362001)(31686004)(316002)(66556008)(2906002)(6512007)(508600001)(66476007)(8676002)(6486002)(8936002)(26005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZ6dUt5UUxyeFZ3SXUvMG5OZ0NVMmRkWUI3cWZvOFMxNGFHQlpLNkM0dFF2?=
 =?utf-8?B?TjUzMm00cE1rNjJJTVNPaEh6Uis1aEFraFN2Nmo0YVI3Y3MvK0dYdkRFN2pq?=
 =?utf-8?B?aU1PQnBRR1dHdTNLWENTSDJ3TksybGs4dVk4MXRpSmVoMzNWRkUwWUVhazFu?=
 =?utf-8?B?dzZIZWRNV3ZMV0hZMGh4d0ZqeEI3Q3pHTkcvZnpNaFJVb0VJV2doVGhBOWhO?=
 =?utf-8?B?OWlVYWNNbnE4T2pIL3lHb29YV3dpVFY4NklWeGw1V0F1K3JYNTJFNElVdzlN?=
 =?utf-8?B?Mzl6Ynp6VllwUENyUmdoUTBJZjlmWVdVbHFBN2tVWklzSGJpT0F0Wnk4S2hj?=
 =?utf-8?B?Ry9LMkpYZWdRcHJGdkZ2THkzMkdVUlQwTko4QXA2dEpzaUFNWVVVd2U1TWIw?=
 =?utf-8?B?SEdGUEZNckExalgzR2J2alZXd3U3S0Qwdmo2YkxzSUFiRkxzT3kzQ0ErWGRD?=
 =?utf-8?B?NnlMRmVLTlRNV0o2Mm1XL20yWnBhcXh0dUVIU09Kek5VdnhUS3ZUREhXZmJ5?=
 =?utf-8?B?TXQ0aTFOMDFyUWxiRG5OYnkreWhiV2RnTGYwVjhQMkxGYzVIWFVyK0RaaHcz?=
 =?utf-8?B?VHJJUm16OEU3d01oNEpWdmNLN0t2N3o2VHhlWVFJa05CUEVUR0R0Q1k1ZHhm?=
 =?utf-8?B?MFRuWUxGYTJHR1dWRE41ZEl2S1pSdUdreWxQQk9BWmlkaUZyMTFMVVUwTXVN?=
 =?utf-8?B?TE9PaHM1RkNGZ2FvWk1mREErUU1IdTlqTWRKbE9vejVyVkcrU0VsbTdHMnY0?=
 =?utf-8?B?TzJtQkFLZ3FBQURxZTkzNHZpdWpJTVdkWGI2dkZ2U3R6dTZlVDl5LzZQejJU?=
 =?utf-8?B?TGwxaThvUk1WR25KSlJWQmZKaVB3VnAwMUtJQlgvaEJwSG1WSVJEWlAzUldY?=
 =?utf-8?B?bG43eTlGVXFoa3B5OEdyK1VPRVozUHV6UjNhK0xmSWF6TnVER0tXcW9FdmlK?=
 =?utf-8?B?TkhlR093c3o5UXdWL0FEV3FZclFMOTNWTDdpOVpQejBnWTNIa21IM3BET2NL?=
 =?utf-8?B?WVVMd2hLMTVwZjBDdk5DRzg3dnRVWDBRY1VYZEd2bXNPNkcyWlVhSno4WXdz?=
 =?utf-8?B?ckNHbnRub0VZcGRoUllIT1c4SWxzTmFjRDJVZWxxQUlJQm1MMG1ycFpxQUtr?=
 =?utf-8?B?aGc0SFJlNFJDR1NmeXEzL0tvS0xpbkVaOWs3NGFKTjZIY21EN0xOTGthdlRJ?=
 =?utf-8?B?QjRmN2pERStOQmZ6T2JzK1ZYT0FsRGdDRGdtdDhIY3lCZ3I3SVRNQ090Rk1N?=
 =?utf-8?B?WUNzS3lyZ1FPVjNKMUtjWGMyUlp0TTlSSW4vV0E2Q25obG5STzlNS0h0UHFR?=
 =?utf-8?B?RVdpTUNwaXE0QzRhY2VmcVZYOTJGemltelphNTRERXB1dWd4ZUFNSFRaZ2gw?=
 =?utf-8?B?ZE5BRjkwTlhYbTAraVc2Y1NwRlkwNVlLRXJ0YjlYNmlpbnZ6aE5EcTRGSDlE?=
 =?utf-8?B?L0g0WmQvRVFNTkE1Q09JNGlmRDFVeExCckxqU1VWb01wRkNjR2pIU2pMOS92?=
 =?utf-8?B?Vnp3RjVDcURIZGxWejdlbVIwak12UlQ5NHd3Y1hRSUZWblI2elR4dnBWc2hT?=
 =?utf-8?B?dnJRSlpmUHVib1pucEtjclk0OVVRd1RET1BRREh3UjNreFNWUGlVUXZSa2Ny?=
 =?utf-8?B?V21VNnU5VlowN0FBdlYva05tUWt3MU9KdFNad1poYU9rMkFIZ3k4K2RRTHlO?=
 =?utf-8?B?T3V4YUJlS2hxQjcwWklGUndDS216ZFZrMU92SXpZanN3UTVOaFJjb2tldGVF?=
 =?utf-8?B?QzRzRVVmVjIyaGdRRGo5SERkTUNSRDlWUzFOYjMzN0UzNUhkYTY1WGtkdlh1?=
 =?utf-8?B?blVPeFVGc3ZmV1ZGSzRuK21oVzMxWHNJVGJsNld3ZkJTbjBWLzRiZVJZMjV3?=
 =?utf-8?B?S1VuZzdjanJRQWhlOXZPYk1vVGxWK3RXNlVaUnRhSTdUOHk1QXpoVWY1c056?=
 =?utf-8?B?S0pZZlBhanViV1F3ZmxCNWU2SUFhWTd6MFNFeW1GOHhNejk5eWErd3BacmtT?=
 =?utf-8?B?UWRCNzdnVlNVdXpib0Y5ajVIVUpLOFdLbnBDRzNXa3QzQVpiU2RKaitBMEdv?=
 =?utf-8?B?MzBKMUZpdVl6ampXUDZjenFVMU1LUG5WdlJSUGdvSkFDQ1o1NkhGZkFjWnpK?=
 =?utf-8?Q?VF9w=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10c7a84-2670-4a2d-3348-08d9df96858f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 00:06:23.1459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/+feJt2a05dJYJP7uUBwcF5tpUWE6Ko3vpE05iVPx1QZRI15QY2qJIztPVw0/9W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4655
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/25 04:24, David Sterba wrote:
> On Wed, Jan 19, 2022 at 01:52:25PM +0800, Qu Wenruo wrote:
>> Hi David,
>>
>> Any plan to merge this patchset?
>>
>> And if you need, I can merge all these refactors into one branch for you
>> to fetch.
>>
>> I know this sounds terrifying especially after the autodefrag "refactor"
>> disaster, but unlike autodefrag, scrub/replace has existing test case
>> coverage and this time it's really refactor, no behavior change (at
>> least no intentional one).
> 
> Well, exactly because of the same change pattern that was done in the
> defrag code I'm hesistant to merge it, even if there is test coverage.
> 
> Nevertheless, I will put it to for-next.

Feel free to do more tests.

And even this may sound like an excuse, the lack of defrag behavior 
definition and test coverage is contributing a lot to the defrag mess.

> 
>> I hope to get a stable base for the incoming scrub_page/scrub_bio
>> structure cleanup.
>>
>> As there is some plan to make scrub to use page::index for those
>> anonymous pages, so they don't need to rely on bi_private to get their
>> logical bytenr, and hopefully just one structure, scrub_range, to
>> replace the scrub_page/scrub_bio things.
> 
> I don't think there's any other potential use of the page::index member
> so feel free to use it.
> 
Thanks to the advice from Nik, I'm going to use page::private instead, 
which have some unexpected benefits, like allowing us to use just one 
64K page if the 64K extent is not page aligned.

Thanks,
Qu

