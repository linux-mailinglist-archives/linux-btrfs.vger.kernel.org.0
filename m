Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD3177E73B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Aug 2023 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345056AbjHPREx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Aug 2023 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345105AbjHPREi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Aug 2023 13:04:38 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2085.outbound.protection.outlook.com [40.107.14.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE9C13E;
        Wed, 16 Aug 2023 10:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqkceR9kjUXN1SxUMTiCHDP/ZYiIlERphALtx/VD40+rIx9oBbkW+yyFuOQi7zKLCIQDbJ00vHjotGRvYrch5YGeSsV53YnyyFxHeVmA4WdyC3qudmsZuSoMJTOJNBMltlJwALgTbNEPD4ou7nO8aszSkSHaEozYDOvEPWT7n4VGM2euvx+4F5WoANr5Vs6UDoHiSI3gJUYY7KCnuz7Lp2cLYds2ndr4x6Rytnio2hBdXZ2B/dJLplpHnEUysQ9V+OlQ0whI6VztnAA6GpCMmBB2a/Dw5u7u66JNn0ckvaIsvEoaNclyCItwyJnjMuyGuDJac17bA9EtCDqmv/9C9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWBRWRN0eMEhTHW8GL9astE/HEqL2Qmnu1wjQ6Ll5cI=;
 b=M+/xf2Z0ZY8Nuq+xCp74z0sq1C2L4EqBvuTnHDL+e1TGgAiMPvqBSra4w3CHeVcaU1wpWEjYMv6hv/g5hSXE982vpkr1RwOZBQQKLM9BxnqO4f+q2GWNv9hXwBlcyVc3My7XR31bB9r/CVp62Ds+GPJnXwlk7A1Nfk27HyOUo1F31PwR4C9mnI8muWtk8XQwPHtMZWSCnz+/aBthlSHPfEbOW0K7A9ubxgYAisaW/y1L8F5nuYDG6yeP0oHZTM4gL5LlriYsoscgGQQB6lyisWQF2mN7w/83B9QwCs0ph9XtWOlj5OR+e9X6u3x7E41ZuCJHUrU02f9sVDC8UpdEnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWBRWRN0eMEhTHW8GL9astE/HEqL2Qmnu1wjQ6Ll5cI=;
 b=RAJEtKqMRUMrFhG/5zW8r8r0w/gOXxghfjE+BYbjHFFBJuSxsEE3znSu1wvXRwZdyhhe9Tl/PhZxt//UKBfAqGDydYjuE0YmWZCzDlIsplThx8qekLvhM9663eqQg6Y09uFQNM+XKQ3MH2a5SQkWJvkh2OU+BHN1225tjVsu4IKVetvUEVqvumJJrkD1AweRRtNcDkzQ4sA8G3tqR5xDlip6VPOYQE3X0HN7W6jpl9xZxiNF5IfYMZOQzCWa0Ay91DuTFDyAFnaZtRBv6AxlBi5Tnzmh0WeiEnNLSE7Sek3LQ2YVzizzvdKYXpL+Os+tKWVJdbO09VLJ4FWql0rbRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PA4PR04MB7503.eurprd04.prod.outlook.com (2603:10a6:102:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 17:04:31 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 17:04:31 +0000
Message-ID: <c64912d4-c735-0a6d-af93-caa3854e7517@suse.com>
Date:   Wed, 16 Aug 2023 20:04:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [GIT PULL] Btrfs fixes for 6.5-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1691865526.git.dsterba@suse.com>
 <CAHk-=whBQ2dEE2Dsq6XOxsxnSPEiV8jjx7HxaTHKP59dd+9JHA@mail.gmail.com>
Content-Language: en-US
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <CAHk-=whBQ2dEE2Dsq6XOxsxnSPEiV8jjx7HxaTHKP59dd+9JHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR02CA0066.eurprd02.prod.outlook.com
 (2603:10a6:802:14::37) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PA4PR04MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d79f361-df9c-4bd2-47be-08db9e7adb97
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYLx/zF0radNJLgOctDyDy7qb4FNY2vY7qo6nNbV6Z4pHQ7Vox5I9oNKS3/o0Kfh/MKuijo+dtKKh2y5tf2yU+N8y7IeccHS5oAv67aDNGVceeVqLeIOFJRuuuEwLDlRhMKSNCVNZD2lgJP0ZE6WlL8qM+Vd+KwE+iwD30OsXRoN/jbBI5v2wF10APkw7Y8u7aWNQAQqCz82eWUFdHtavPMWhL+UxyZ4y93napOzydp8XlOE6dylLBPLTSP6+vnJ12pqR3DLdrSKLsppkkUlon8pA2K6/8DdrlC9/xO6xP5c+orRQAxoImX5C+sHH6AahJyRpIJ/9YjWgPov4pEkTFIYUTXmNUPzTmIJQPByklyTQD9EAyfxWnEEyDRFpyIwppi8N8WycRe+EadYXEIBD0tUNKYBDCerBawtXn7tgVYVXtM1fCnh8QegSOV4gKMmLwlUk4NVGkvhQV+t5ZcYDMCxe7btzqFPU+d/e+CSLXq6eCRTLNm17cT+SQVMEwzKHQuDSiTPg1VpIqiCFbDWa0fC328U9rKADlvJ1lWtQfrpVFv1HItbpNwi2VlKB/1BkmXYY1p0rzUBRycJY3ZJU8GSeIAkxsNpuRtjeVfDSZpI5xsdu14JuQF8SwaV6Pj9s5TPi6AE4qARtCP/BpeaCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6636002)(66946007)(110136005)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(4744005)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG5WdWEzTCtsK3g1d1FQbzlyWVh0ZmxPT1BCWlRUMWpGaHk0N3VxNXFDc0tu?=
 =?utf-8?B?K0xORjVqVEVGQTQ2VzlOSFo1K1pRWksrMkM3ajkrdnZhMkdMTFRkQXcrdFZK?=
 =?utf-8?B?NWhTS0ovTStVSGRwN2FSeURyVUZoQWs4YlloSTdqY0tqZnR2ZEcwL1FsYi82?=
 =?utf-8?B?YUxLaVFWL0RCdFcyWlluSS9UV2FKTVZLSkhpVkFRZWJ3UnZ1SFZkdzFIMEJX?=
 =?utf-8?B?dEpGbGVQdmtyNGozbmhBYk1iUVh1RWd2bTRGbWVWbDk2QXl0NWxCcCtpWElF?=
 =?utf-8?B?cFdPQk1PNHFleTRUdlhXU0tla0VuU0FZellBZ2Vwd3VuOTlWZzVwdUxSQjR2?=
 =?utf-8?B?Ykh2Wk9Xa3A0WXNmTmt1WFIrb1F1M0R4V0xsYktWTUVjRTFWdTlyODJ3Y0xt?=
 =?utf-8?B?eG42YjhNKzZyZ2NEV0RzcThUZUdya09RTXp5dWdMelRoNUtvVENtVGwzZVBu?=
 =?utf-8?B?QmVoRGJZck4zUldoeEZuNFdrdFVLVm1lUFJRQVc5ZlNaMllQelA2VDJPd3JD?=
 =?utf-8?B?ejFaR2FyR2tMRWs4RGxkZE5XWkpBY2cyb3dQckVObEM3QWcyQ3BEa0Y2cS8y?=
 =?utf-8?B?T2R2aHRNQTUyME80MmJ4NjBGN2ZJQ2Q0THpyb3RPeVA1Y2JBVFlNOFR5Q29Y?=
 =?utf-8?B?Yjh4dE5WOFlOaGw2aE1tVXgvR0M0cFNsZVVQY3ViVHloUVZpS1Fzb2xJdzZE?=
 =?utf-8?B?WnZNNkdsL3BEMzQxWjU2ZDRkUnB3a0x2NkE5dEgvVlBXcDMyaWR4Z3JXZlZt?=
 =?utf-8?B?TEU1eWhsQVNCcnFSenhOYVlhei8rT0kzMEhLZm9MZzNyNnVxd0w1SytSeEVP?=
 =?utf-8?B?TnJuekFJNWNpVUlDYWJwM0c4QUR4OTE1R1ljM25qU0x6SUh1OStuUGxGZGF6?=
 =?utf-8?B?OXh3OExMTDZYYjBnaVdOaDhhemRtdGVzaVVYaWlmcGpNS21JaTk1YU1DamhZ?=
 =?utf-8?B?UFJPeUV5aTZTOVo3OHRWZis0Z3JWS09KeTJlN2U4ZFd0aHh3dTUyZUYrbkRt?=
 =?utf-8?B?ZExVTzhaUWpvRmM1dG9JQVB2ZnUvZ1BlMjh3NzNkWG5pSS9yQmZOQXl5U1Z3?=
 =?utf-8?B?NXo5eVMxM0diWnViNFBaeHJhNjcwR0N4VHMreDRBb2ZyUUdoWHpXNnRwL1Ns?=
 =?utf-8?B?NzZQZVBOanFPYWVpUWQ0SjArWlZRSFcxWUVMTnlyRDR0MWJMOVFCc003SVZG?=
 =?utf-8?B?SVFGc0xXbUh6UytBZlZPNHlBeGxVVy91WjlwQzBtN2hkWlo5NmYwTStuL2Nw?=
 =?utf-8?B?VXpDUGJOK2NjRGIveUxLMjM1eCtuZml3M2lIUExaT3pJOEtyTVgvbE9FS2oz?=
 =?utf-8?B?L0RENXdKTlFCVXlmUTI5djZkb0tYSUM0aDAzUHRCRXpOOFpQcDVHczVNeDUw?=
 =?utf-8?B?OCtjVXpkNXpFUFRYdmJkYTFQUDZkdk1CRzV1cXZtKzNuYk9TdmVIS1JJOVhz?=
 =?utf-8?B?NWpxWm9Sd0gyMkQvd3NNWVlWWkFTQ3NIV3VwOUtXWmJTREU4cUlaU1V1U3lz?=
 =?utf-8?B?dUdwc1FIY09RS3NGM2pqMXhtKzNOM1pqazB5ZEVrTmJzMWhJV2ZBejg3bFpw?=
 =?utf-8?B?RlpwcEtGdTBZekx2Y2xTaGdHMTFSUGtwcVc2bTVwalc4VW1yalFkUmJ5WFBR?=
 =?utf-8?B?eVlnc3BVSGpJNUxGc1RKT0JxendaeEM4Q01abmpCa3FBcVRoUEJNZFJtZVlo?=
 =?utf-8?B?QWZ2WnVnaHlNRnliclVSVGxWVDZ6bWdwWS92WDlmWjhaeVRrVEhoRWRFb1gr?=
 =?utf-8?B?R0N0UTZweHMxeFoya3VJeG9KSTg5TzBoZDZHZUNWblBhRGdSNXdhOWRNdC9S?=
 =?utf-8?B?dzZNTUlVbVlKWW0vMVcxMHVraTdyVzdFaEZNK3p5b2szMVBpOTh2bzBMcTFP?=
 =?utf-8?B?ZHZURnJONjNITms3MGVqRTVIa29CT2svWDlOWWhmeVhKQk0zcVZ1UVd3V2ow?=
 =?utf-8?B?S3RmcWp6SHpHR3FaQ3BZbUl2UTFTZGtPYTM1eWprRDJNeHRMWm9ydHRnVElk?=
 =?utf-8?B?NVkrTmdrWEpDVjBzbEFmSlVDY0l5Yk00RWFlcENtM0lEWEtwNUhxd3dMWkNH?=
 =?utf-8?B?MnRraE1DQ09QUUZDR2dlZkNwUUZVNjV1T0RJaTlGVUpuSTZsZE1SWlgvOGwx?=
 =?utf-8?Q?s1NxxUd/JnweRQF4yCebGu5KP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d79f361-df9c-4bd2-47be-08db9e7adb97
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:04:31.2046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hA/W1CJMYYDNevlx+C59oMqCtmV4ax71ofq+PLPxBbFfxZZ5B1/zMkFp09BilfGNEBgXTi0uC1kcpd8nzGSovw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7503
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.08.23 г. 23:36 ч., Linus Torvalds wrote:
> On Sat, 12 Aug 2023 at 12:20, David Sterba <dsterba@suse.com> wrote:
>>
>> - space caching hangs fixes to progress stracking, found by test
>>    generic/475
> 
> I can not parse that sentence. Part of it seems to be just a typo
> "stracking", but even with that fixed it just doesn't parse to me.
> 
> I tried to make sense of the commit and edited the message to be at
> least a bit more legible. Maybe.
> 
>                Linus

FWIW :

"space caching" is the name of a btrfs feature, 'hangs fixes' implies 
fixes to multiple hang issues in the "space caching" feature.
