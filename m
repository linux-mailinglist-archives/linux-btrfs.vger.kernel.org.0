Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE21C7ABAF2
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 23:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjIVVQv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 17:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjIVVQt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 17:16:49 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA91C1
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 14:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSVO7hldGejV2DqF9xZhXaG+XmyeFn8BZyF3kSHn5HGJbGgk5V+seQrgBNvKUW16HaNk9L2PbpbnuSdRRsYC3VdoKr4ZGD8iI3hG+C0ZTDV/r7j4ZJytbbOc/zGTY2XON5ccSHdEl3qmbSDfSC9mBEPcz+jg2zRtlcnBB5LNkvOHM0nWOW7yRgXkSs1YPjdjUWo8bCO5DL42XcAaR+DXu8CNaZhfRjImX1lHD9lnZlEBe4hCTWsQAI/KSdUbllGY16/dKRlHuUOuVNJeCu3QXuwWzZKNkOd0itcQcoyMjdTK/oc22vqUexGhHmEBrTcnVycdxro9xi2gFTc6IpdYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eU44eHJW51ga9dKJ+s5eJibOQuNgc/Ja3knZV33K0eo=;
 b=drSt/ztcEygpWb3EGr5HNQI+8ryS5HpstEwu2TIYHdoQ6M1JdCu50m/RuVxXcm93IDtskcBeVvPZMxKBpIbu8k0lxd53zwlVh3dvLb27mgnXIExDa+HOJdm6mltcGUEo+8m10Z9Luz4YiHujJN55grEGPaPfZXoQexI1+hSF2QNk2qTYcXooZ3DoxQWVxOG8NuEwZANjTlevsEwjo7H540k8Kd7WgPFAEXUmDWjEyn81ElwjHpan3qVhpRHsy9lJSbQs+aRvmELgr8uIcdmN3tvfCtcirruUzWEF9qiBdI4eJSEgeVBsgDWFHjaLhCDEK+Kw6FFsAjeKPSAN/iKzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU44eHJW51ga9dKJ+s5eJibOQuNgc/Ja3knZV33K0eo=;
 b=iYK+RjHKEfGvHTZmYm1uHVv8yk1RMzubtQMdjCrUP9qgt0YnDPD/qb9upzI1yMfu8qJS8/a1xmpC1WI/Rj71PFn+u+71t/vY0Ph+DCW+n4PP1L5lHJj+CTJihestfEdLycbErJcysoteCGktPSx0lnTM0qFgSodPxIUQkHLPeBXgTD97wuNOmfOOlaWOEJQawCIU73oWy0R2JAtB6oaIonlPdhjWM3uadiBSeqe0iRDYtJ+i2+6rRJHiOeTifh73o9N49yWi3az6euQ5piWGaD09kQ4y17jG1jaT5EsXVkKlB4MUZnw+/nrS3REct7rZqIPL0VRMQOz9S8JRqKu7yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB9518.eurprd04.prod.outlook.com (2603:10a6:102:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 21:16:40 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b%6]) with mapi id 15.20.6813.024; Fri, 22 Sep 2023
 21:16:39 +0000
Message-ID: <25c4f01f-a355-43b9-ab22-725353dc6380@suse.com>
Date:   Sat, 23 Sep 2023 06:46:26 +0930
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: introduce "abort=" groups for more strict
 error handling
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1695350405.git.wqu@suse.com>
 <20230922145513.GF13697@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20230922145513.GF13697@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEAPR01CA0046.ausprd01.prod.outlook.com (2603:10c6:201::34)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB9518:EE_
X-MS-Office365-Filtering-Correlation-Id: 803b8b7b-d81d-427b-95ba-08dbbbb13620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gvKBpPSMan6DQzVsPc8aNgdXG9gTy320hybiW8bFP98jdhtScpVUV6EYZ2lx3sJ1dQUg6wyw6BCeN5XMNGjUog+CxujoLEfF+XH99Qaj9OuwZXu7mJT982dB/b3IPvW3x4syH0OIkC2RJMd/t3TzOwSpXjuegh0+kxyC2ZotO1gJU2kGrESqbgHNeI4QBAcmjYKsZ1dkyZBnC5t3Q+KCHgyZeNKrXHouvxkSTMCBxUW7nOwQOZuX8huZGYG6RbzkZWjx/thPahn3zuRI7Zve4w7RT56B3FatmjRZlSZ2HZmu6VyHUp9wZibJ3zFH3LWW0ywHyb91/CHPRjYhFpD7Ap07zDNwcoCTI4Hz+t5F2fVoloq3+nalE5ycS7YWh8FHPv91GG+SiYWelsLzxZ9QYdHgZ7Atswwz3/eV9rUDidOoX5K9s1X3ecH24sv7zD7jVEMy9lAYs8j8syAtSid/iETdBfuk4ebQTNeVhWqIrK5QMihI/UN10RdxG5Z34IZuBVhQgueGm/yGB2l+klLznI2rzQILHExT0Hc4tdogqieINXzsCMvzqPLM1Kl/2JJjgCGlzVt252dwv9EuTtDxBwybcdgtLOQAU0XHSc43O8D4ZWe5i/5YqG/81UdOISBeTMk+Gv8UNK55w2LIGrU7cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(86362001)(31686004)(2906002)(31696002)(5660300002)(8936002)(8676002)(36756003)(41300700001)(66476007)(316002)(66556008)(6916009)(66946007)(4326008)(83380400001)(38100700002)(478600001)(26005)(2616005)(6666004)(6512007)(6506007)(6486002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXFMSUhkYlZlZzAzc3hNRkk5OGZNWGhuU1dPLyt6c2F0dTROK2VoRkE2RTMy?=
 =?utf-8?B?MWw5am5UaGZZOTJ5ZVl0TFA1aW4wbmRSSTRUeC9oWW81UllMZ0Z0U3ptNUtI?=
 =?utf-8?B?ZEJZcDNKZ1NyUnRaWkU2bndocEprYmxjUkljY3NUSE5DMXI0UFJFc3Q3RXZh?=
 =?utf-8?B?OGdiRjd4bE04MWR3Nys1YitkbEpkY0VySmVVZEJGY29mdUtuaDhoYjBDQWpE?=
 =?utf-8?B?YVdXODN4eFdjY2dTdUtHSlhtNWE1eXBxNTZmYm5iaWZ3RmJPY21kVjJpZ0dB?=
 =?utf-8?B?RDdWOTZPQ1pSZS9mSTJpeFZ3K29sSml1ZEl3cG8rRjhKVXVHczBMMGttV0FL?=
 =?utf-8?B?a3hjOVpWNU5HRWpvdjliK2xyckVWeHppNnJqRm5QNXU0WjFRK3dFeWJmREYv?=
 =?utf-8?B?aHQxQnNlM2RLck5yMzExZkZqelQ2bm1DOGNMTVFGODdENlFFYVRvR2xMd1dO?=
 =?utf-8?B?Uk9sWXU2V2duaGVGN0JIZWpxdmJNSkxmS1hCdFRSRW11OGFJUTBzVTVJL2M5?=
 =?utf-8?B?QS9KbVUyOHdKQ2NmaXA0bHkvckVpTDdNYmdCMEp5SDdFWEtERzdYa2VnbnNS?=
 =?utf-8?B?U3FFVCtWV2RDYk5hT0Nid01sVWtkR2tTOHhkRjZmWHRRb3k1V3BqVXhVK0pr?=
 =?utf-8?B?bndRUDd3dHQvaUdTeHV0eWNnVGhqcVhrLzNuSmxDMVdNN0d6cnBCMks4RUND?=
 =?utf-8?B?bEJibC94ZUtjN2NLN0NzREU2WXkrTG8xSXZZTGE0aUQ0aVNTNk5vbFZkMEZp?=
 =?utf-8?B?a1BoYzQ1emJtWE5oTzRhWGVKL2ZCak11ODNvNGF3SW96aUQ3cXF4N0NaSmFL?=
 =?utf-8?B?dm9Qdy9rdTh6VkEzWGtHTVc3ZmFmcVhRVEk3RU83dDNKZFhZcVpPZjBpd1FM?=
 =?utf-8?B?cFNtYzQ4aHpBRCtuaCtpTG8wYUNHd2JIZ010QndPRzZ3SnBvUkdoOGF2TmRQ?=
 =?utf-8?B?UlJxckJRWTVucXBQcFRJZWVQRnNJNy9uT3dTR05NcG5UaG9Md0g2THNzcnB1?=
 =?utf-8?B?d3RWZTFmM2kzZjlLVnF2a0IvejNJdC9OdDduckQ5UXpUZHlRQ05DMnRoOUJr?=
 =?utf-8?B?bVZlZmhkTmtueDNZcis1L0FpcGV6Y2dFWlZJeUhXeVNrT0VaL1k1QTk3eWZ6?=
 =?utf-8?B?WGNMendVU3ZmY2pMeXJSUUNiOFk0VkxFbTlHQkhQdlVCamIzTjBSUDQ4SnN4?=
 =?utf-8?B?OC9BZSsyM21QeGVWVUhUMlJpNjBIdHVXMXIvdkVhb0ZpVnBtM09WbjU1dTBS?=
 =?utf-8?B?ZEVlbzAvTHliYStYVlI4YldOaG91UkloUlpudlQwYk9sNjhYZ3Qvc0g2L0ky?=
 =?utf-8?B?Q21UT2JDd1NnRUhDTjN6MitvY2d1V1Azbi9wb1cxS1ExWXhyeXZTdUIyNmFv?=
 =?utf-8?B?dG1EUHNzTEFzRlVaS0QwWU5SMTJ5WjliNkNxc3R1THl0R1BRWFdSUGxrUjIv?=
 =?utf-8?B?NzNnU015WjlGS2ZUU0hBNDMxTExjK0hWb3NSWnZJNitkeEpuM2tEWVI0TzJi?=
 =?utf-8?B?MEh5cjNSK3pPblFXU1dpOUJDeDNuT01pTEowci82ajBiYzI0a284aUoydkdt?=
 =?utf-8?B?K0hmbzU2MkJCVENlRkp2NkZuWkh0SDRVejRESzNWZHI4L1NrYVhEWVYyOFlJ?=
 =?utf-8?B?ZVc3R1VDNDlUK2RBYlZ4K3Jpd25YV2s2VmtQTzE0dXgvQlRJejkzMld5QXo4?=
 =?utf-8?B?YjJLRENGSVZhT0E0a1lUZk1IcFZSQnZNRTBNbktmVWdHbERzLyt4TTJXbGhY?=
 =?utf-8?B?aTRaZWcvczA1WCtjYmkrclhhNUZLdUY4OFNPQStMbzQxOURSNEQwMzFKUGFt?=
 =?utf-8?B?aGR3TFYwb3NhRENRdlZtYVBXNmVWdUVOUlJUTEQ2TVNvRm9QQVJhTWplMFVV?=
 =?utf-8?B?V3Bzdm5XWlFJSlJsZTIySTZLajNkdi8vMEJCSDluWk9iVkZ4MTRjWE9GRVIz?=
 =?utf-8?B?VFFVVzlOWUZxb0orVEtlRGdWZ284Y05DQzhFSVlLNDUwZEJxUHp3TlJJbzRU?=
 =?utf-8?B?QVBNQUFtU251SHVUTjZSblhiRFVaQWpsdm5oaWpEdVE2RTl5QXBqMGlPeUor?=
 =?utf-8?B?RGZ6R1VVRkVLLy9WanZjbmJwcERtMGdKeC9aVUxTSmN4OS9Kd1plWUtPT09o?=
 =?utf-8?Q?TAJg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803b8b7b-d81d-427b-95ba-08dbbbb13620
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 21:16:39.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMiM95cISmG4uDOIPRWCknbpig9rjyrNWrZGVO8wv7CPxgccCSx/xs1NaOgGc2gN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9518
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/23 00:25, David Sterba wrote:
> On Fri, Sep 22, 2023 at 12:25:18PM +0930, Qu Wenruo wrote:
>> During a very interesting (and weird) debugging session, it turns out
>> that btrfs will ignore a lot of write errors until we hit some critical
>> location, then btrfs started reacting, normally by aborting the
>> transaction.
>>
>> This can be problematic for two types of people:
>>
>> - Developers
>>    Sometimes we want to catch the earlies sign, continuing without any
>>    obvious errors (other than kernel error messages) can make debugging
>>    much harder.
>>
>> - Sysadmins who wants to catch problems early
>>    Dmesg is not really something users would check frequently, and even
>>    they check it, it may already be too late.
>>    Meanwhile if the fs flips read-only early it's not only noisy but also
>>    saves the context much better (more relevant dmesgs etc).
> 
> For sysadmins I think that the preferred way is to get events (like via
> the uevents interface) that can be monitored and then reacted to by some
> tools.

I think this is a future development idea, to have a generic way to do 
error reporting.

> 
>> On the other hand, I totally understand if just a single sector failed
>> to be write and we mark the whole fs read-only, it can be super
>> frustrating for regular end users, thus we can not make it the default
>> behavior.
> 
> I can't imagine a realistic scenario where a user would like this
> behaviour, one EIO takes down whole filesystem could make sense only for
> some testing environments.

I doubt, for some environment with expensive hardware, one may not even 
expect any -EIO for valid operations.
If that happens, it may mean bad firmware or bad hardware, neither is a 
good thing especially if they paid extra money for the fancy hardware or 
the support fee.

> 
>> So here we introduce a mount option group "abort=", and make the
>> following errors more noisy and abort early if specified by the user.
> 
> Default andswer for a new mount option is 'no', here we also have one
> that is probably doing the same, 'fatal_errors', so if you really want
> to do that by a mount option then please use this one.

Or I can go sysfs interface and put it under some debug directory.

> 
>> - Any super block write back failure
>>    Currently we're very loose on the super block writeback failure.
>>    The failure has to meet both conditions below:
>>    * The primary super block writeback failed
> 
> Doesn't this fail with flip to read-only?

Nope, just by itself is not enough to go read-only, as long as we have 
other devices.

If the primary super block writeback failed, it would only make 
write_dev_supers() to return error.
But inside write_all_supers(), error from write_dev_super() would only 
increase @total_errors, not directly erroring out.

> 
>>    * Total failed devices go beyond tolerance
>>      The tolerance is super high, num_devices - 1. To me this is
>>      too high, but I don't have a better idea yet.
> 
> Does this depend on the profile constraints?

Nope, it's profile independent.

The @max_errors inside write_all_supers() is purely determined by 
btrfs_super_num_devices() - 1.

> 
>>    This new "rescue=super" may be more frequently used considering how
>>    loose our existing tolerance is.
>>
>> - Any data writeback failure
>>    This is only for the data writeback at btrfs bio layer.
>>    This means, if a data sector is going to be written to a RAID1 chunk,
>>    and one mirror failed, we still consider the writeback succeeded.
>>
>> There would be another one for btrfs bio layer, but I have found
>> something weird in the code, thus it would only be introduced after I
>> solved the problem there, meanwhile we can discuss on the usefulness of
>> this patchset.
> 
> We can possibly enhance the error checking with additional knobs and
> checkpoints that will have to survive or detect specific testing, but as
> mount options it's not very flexible. We can possibly do it via sysfs or
> BPF but this may not be the proper interface anyway.

I think sysfs would be better, but not familiar enough with BPF to 
determine if it's any better or worse.

Thanks,
Qu
