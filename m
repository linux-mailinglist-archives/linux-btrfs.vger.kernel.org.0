Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F927545E5
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 03:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjGOBCT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 21:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGOBCS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 21:02:18 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95281727
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 18:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNr7f0NZWM6u82dMtXUROkMHjR5CO6uvG8RZUbPm5e1UnfNIs3Xmo6swMTONHo6nSitzmmIURjCDPTx5KDzuLutUEXesAr6QGjLW1nnrfWU2zaZXMfV/jum7GO99VMNY8wz2pA0tJ406QN9/Vr3i+jM/NzXLonP9qPE8Y8HdepH3XDzjj59uPGth3biNXX7GooWjfKeSJE5pWJ0k1jhWIr/MDwFk/TLGe4f+BhFUhOhc6u9oj6s/j5Y7bwUHJRxZAzPWIPSB8fEA43tR4OrmQBHUdjU7HapJldtfMbOFww8Xuy9AzTRvYP+kBtwlylB3Qwfe0p380TXgAwQBOrhO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0W9gQbdLfE6HJEIr/o5knTNjz4xJxCRQHBdQiDBNXU=;
 b=aI6GzfOlZYBxPhJ10RoqW8THdodOJBpgU2WGMO7r8WUJW3CSVamCmzYAo0LOHKGx47mrVby+nNUdg1CG5490fh+w0THffSrglfdcaeuatuVJkfa8LkUGVV5vKKsqo2jYjXoottGaVH1pyTLqQCAo5XnzHTBcgLQ8WOYaBt6HvPJV20gs7o1zRXBUosjJJB8STR0z9Vij7B4FJ553Gfw52bkKW8IlnhFrfXu71gvQnYY5B1HT9HPFQSq4KAHRkzYFSCZQft/tzVnpHxYDMU47QmyAYkLPpm4Y9B9fh1gGZHS87x1Qt0gCDuVI4hvDybUl0ExM1FvIEyE2V2LNrCBlyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0W9gQbdLfE6HJEIr/o5knTNjz4xJxCRQHBdQiDBNXU=;
 b=JlQ0aae+1M1EYOknNEkC6jWEVv48bP4x41agvHogWNoadRGjHAowsIuvoZR0MO2g7sfj9DVd796I+CiCOvbquRchS1RR39hsgb5BhPipC3lxM8KdzAkYXbEaB60CTCt/l44xeiT7bRlCMbQoXtER0ptqRc1yJJgVeULo+bQgKZcebPoFDuNQyP9JcbfAmTq6ciMYSlI0+jEtjgVqDMdLPps/ijGdSGlR1sANGEB59NVN5di9AFla059XpGWsvJk4xtZlKO4sXIbMdNfZkvLoDexMpSPE4pYGq+y48RlVtDQLX9Fhcc4K0fX2hqeG1eFxKqCr6rMjHxqCYM4wRWbjlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM9PR04MB8129.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 01:02:13 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 01:02:13 +0000
Message-ID: <2cdbfab5-53e2-a922-5f3d-d2d255ce2f94@suse.com>
Date:   Sat, 15 Jul 2023 09:02:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1689143654.git.wqu@suse.com>
 <20230713120935.GU30916@twin.jikos.cz> <20230713163908.GW30916@twin.jikos.cz>
 <9251d155-2e2e-a126-579e-2765e98a4a9d@gmx.com>
 <20230713220311.GC20457@suse.cz>
 <6c7b397a-8552-e150-a6fd-95ae73390509@gmx.com>
 <20230714002605.GD20457@suse.cz>
 <1bab3588-9b53-c212-3b45-91ee61f5b820@gmx.com>
 <20230714100349.GF20457@suse.cz>
 <3414dd0b-7b69-28d4-28c4-3405e9b8139f@gmx.com>
 <20230714104117.GG20457@suse.cz>
 <c98d4a3b-c43b-a867-ee07-cb8f1c149252@gmx.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <c98d4a3b-c43b-a867-ee07-cb8f1c149252@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM9PR04MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad37137-56ad-410d-2c0f-08db84cf1fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDgbsVcSN5h69VtQ60BKU848YQNUnQMAr6e5Iru++yOglXVvvn9+g0AtbEL8j4BEyfmldrAqn8MDwOB3iu7CQ3/fqBrqlEAyWXw502qf0D84kZ3tTHQE5ShJKG1AO+xi4zbzPqfeFbnS7b2y6Fjb/iEpKhFOo/Dx1nndgpxotjsY2vTAwvRZyCbDVaCqLZtZBhSvz9PL46db8krK7955ekcwBUPeU1YRYV+pA9zJuhX/9F0n2gMBOkJRHSljJW/ME23K9YZgDqDr2y9R+A81542qxCBGNHJiseFIJqJHX6CiCulevfrJqA3W4HuUfYm2TFHodq+zy9+6ayj34HbhmAkfGjgGw7Q7k6R8yjGoXCe1pxQ2Z8sqvcTLFFc9cdNZ1WNRNOJDAuoVx7c7o81lbbeBm00cyxHJQ9+QZrlJ1U03dgat7qnXmm9X/N+Hnac+aigRdIyyXuUn2CU+iUmu0L3/YFWNrqqivgzTrO2NfzIz4dDVPH9//mkCxBrcNKhjnHFELktOsQlszt6o4IrbAgrLWsryZB4VgICu6HE0ZO3xFwCu+zQjnGw19u1tKeKXOgKgAk1w3MsSj9Rkay9xiaxv0Q6BsSPLC82jMsDhcp4PvylnU8RJO6PVJw45kq3HsdXjfFUIm11lUqtk+cp4Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(2616005)(66574015)(83380400001)(4326008)(41300700001)(316002)(31696002)(6486002)(86362001)(6512007)(53546011)(6506007)(31686004)(6666004)(186003)(8676002)(8936002)(478600001)(66476007)(66556008)(66946007)(38100700002)(5660300002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3YyTXNwM21WMkVGV25MQ1k3VjJLd2FYZkh3NWgzYnkwVFFnL05KVjFZdXpt?=
 =?utf-8?B?TlpodXBqbXljUlBOQ3BLeTRFSWY5bFlHZ1hzcG80K0o4QnBUT0tySzAxUGtP?=
 =?utf-8?B?NDFUcUZrbXVSSlE4NU9iZ2o2SUNPTWd0VVEvNEVkMEY1RjUyWGYyeVFydEJx?=
 =?utf-8?B?MnhQZUhuMEg1SWJnd05kMkJXcmJLMVRobHYyZmE2S2R0Qzh4MS82aGpzRy9x?=
 =?utf-8?B?Y1JzZDRCSGw4ZW5JTG5nRW4wY0ZOMGl0b1YwMUN4ck9MNmdGbDQwL2lHZHp5?=
 =?utf-8?B?eHF2eUJLcWg4ZkZuY2FZbitWc2VMVGJ6bXY3VWZvbzVvWXdPNW9XQ0I4c0hP?=
 =?utf-8?B?T01GYlVHWWJMalkxaFVEME5Rd1dxUUtrSk1NU1BPTHAyeHNuVmJWck1uS0Iw?=
 =?utf-8?B?QWRSMjBvMUtoTmxlTVFvZzFJNlQ3YnR0Z2dSWS9YdXVSVTB0cFQ4TnZHTlFC?=
 =?utf-8?B?TlRtZWpTSFdPaUFneE94R1phcm1RSXQ0L3lDclF2ZS9sRHU4NG1Ddjc0anRN?=
 =?utf-8?B?djhra3MralZjajZiYlNZSDlZTHFkOHJWd2NSZWNJdHRXQlZValNWQy9OdzZB?=
 =?utf-8?B?WDhvOWk3TGswRm52eGl5RGZ2b05nemM4NGNGdEFhY2FSVStwMDg4TUxrZFhZ?=
 =?utf-8?B?V0RrUmp3WFJBTFE2RUZGYWs4WHNrRFpocHp3VERVY1BUdlNUSTB3T2JjazVH?=
 =?utf-8?B?Sjhpd2lGdmlVUGY3WEZ5OUpxeVhqdWdpclFqOEdoZlkvQjVjV1p4ZmMvZ1JE?=
 =?utf-8?B?UmhVbkJ1VE5xNHdtS3VGdG0xMTNqSjQrVy9JMGxRd2x1SDhOK0FENy9aazRC?=
 =?utf-8?B?ZFZVWmhJLzJMMEpZOWxyRTNyaDU5ZStDRTFWT3hWN1lBYU1qU09xa3FoOE83?=
 =?utf-8?B?TzRpWTgrcXBGRnZtMTIyQ1lNYmxaS2tkRUlsMkRFN2QzR2pYOSt5RDErMXNq?=
 =?utf-8?B?dE9jL3FJWDRWYW5FUnVRTkNrL2FPQVdnV3BqKzRabXNJTDNGOUVzclI2RStq?=
 =?utf-8?B?OFVweXBXbkNSc2lCM2g1a2ZtS1ZKUWJvVW1jMllWWmxFV3YrTGF1UFdnajYr?=
 =?utf-8?B?bnhMaWRIYXBrVjg3emVheG0zTGtQN3dqN3N1MEtLR29JZFRlQnJTUDF0NFAx?=
 =?utf-8?B?VEhWakNrK3h4eWpwcnoyWHlSbzZ6NmFpd2RGV3NnUXB6cnN5dklpYzhJMmxl?=
 =?utf-8?B?endieGRZSTQrS3dvd3l6UkJ4REhxWFg0SnNvUW0xRU95ekNKdkQ1VUNrRkY0?=
 =?utf-8?B?VlNpWWxZU08rVERQQVJZVnZGMFFWcklCMTQ5R0wwSHdhSDVMeVE5Zk5teGoz?=
 =?utf-8?B?Rjd5bEJaZDgra3NSQ1IzZmJqdkIyZU5GdzZyTklvRW1va3o2K3RQY0tubnpt?=
 =?utf-8?B?UHUraEw3dWQ4bVNnUTAzREVIbHVzZkwyb3NaeUNROS9JejBTMC9adXNFUHIw?=
 =?utf-8?B?eFUrNE5NdCtSZ25MUDZtVkxxeVNHbW9jODRTZFVaWW5sd3dCRnFhcFRuZWJj?=
 =?utf-8?B?RlBORmxueEhhUC9UTmIrYnhHSW5DNDBBUUFFTnlwR0psN0V0aU1rZk5hZ2t4?=
 =?utf-8?B?T3FRUEVUbVk0WFRTaWFqYStsQXppbTVlYXVMNjhzL1NRRlFHMTgyc0pid1JE?=
 =?utf-8?B?V3dlaHB3YUd0cjJKbGNCNDhiaTI5OFlBT3dveHdEYk0wM0x2Wk16bC9ScHQ0?=
 =?utf-8?B?SGNmeHVlaFhSV1RmOGZmNkhQWGJsZnBlVTljVGhYUllSSndCNUJZRDdiRVFl?=
 =?utf-8?B?b0srdWc2QUNMSzhzcUcybENWUG4yZVprRERuWXNKUUg5VlFNYnA0cDNGWXl1?=
 =?utf-8?B?QjhqaHZSNjdaKzVUU2xiNFhzVDhGRkVnYnpocXhEZFlhMzVlSGhGUGltVW9F?=
 =?utf-8?B?K1VYT0lUVU1nZHBsUjhaWkEvblU4NGYvd1lVRUdZblA4UkVoOFBjWnhKOWdS?=
 =?utf-8?B?a2pDdWwwcUdybEhBR3J6cDBiUTBVNU5qbG1EL0ovbFQxQlZ0Q0g2YWk2QU0z?=
 =?utf-8?B?bnVHaTNFaG11aTdjYVNOWHh5eUU4RitHNkk5ZU5jbW9pTmVHbGdOZ3FRMWRO?=
 =?utf-8?B?UTQwNG56d3R1d2FCME9TbmV5WEJqdStNcjRHVXRWeVFpY01mSzVmTEw1VmF0?=
 =?utf-8?Q?UpN4PtDnneqLSPXgHSv4PrGk2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad37137-56ad-410d-2c0f-08db84cf1fe8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 01:02:13.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45F3A7WYUpcn1IeV9HDN6qL4ISoLaUdYfytS9drmr0WDZDd3sjlv/0BLBDa7jVQ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8129
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/15 08:39, Qu Wenruo wrote:
> 
> 
> On 2023/7/14 18:41, David Sterba wrote:
>> On Fri, Jul 14, 2023 at 06:32:27PM +0800, Qu Wenruo wrote:
>>>>> Already running the auto group with that branch, and no explosion 
>>>>> so far
>>>>> (btrfs/004 failed to mount with -o atime though).
>>>>>
>>>>> Any extra setup needed to trigger the failure?
>>>>
>>>> I'm not aware of anything different than usual. Patches applied to git,
>>>> built, updated VM and started. I had another branch built and tested 
>>>> and
>>>> it finished the fstests. I can at least bisect which patch does it.
>>>
>>> A bisection would be very appreciated.
>>>
>>> Although I guess it should be the memcpy_extent_buffer() patch, I didn't
>>> see something obvious right now...
>>
>> 5ebf7593abb81ec1993f31e90a7573b75aff4db4 is the first bad commit
>> btrfs: refactor main loop in memcpy_extent_buffer()
> 
> Anything special on the system that you can reproduce the bug?
> 
> I checked the overall code, it's a little different than the original
> behavior.
> 
> The original behavior has double limits on the cross-page case, while
> the new code only handles the cross-page on the source, and let
> write_extent_buffer() to handle the cross-page situation on the 
> destination.

OK, I got the cause.

It's indeed the memcpy_extent_buffer() rework.

memcpy() itself is not safe if the range is overlapping, and the old 
code is doing proper overlap checks for both memcpy and memmove through 
copy_pages() helper.

And unfortunately I didn't go that copy_pages() helper and triggered the 
problem.

Let me find a better solution for this case.

Thanks,
Qu
> 
> Considering memcpy() is called for memmove() case, it can explain the
> corrupted tree block we see in your report.
> 
> Although I can not see the obvious problem, I guess there may be some
> hidden corner cases that would be finally exposed if we move to
> folio/vmallocated memory eventually.
> 
> If I can reproduce it locally the turnover time can be reduced greatly.
> 
> Thanks,
> Qu
>>
>> $ git bisect log
>> # bad: [5c6c140622dd7107acb13da404f0c682f1f954a6] btrfs: copy all 
>> pages at once at the end of btrfs_clone_extent_buffer()
>> # good: [72c15cf7e64769ca9273a825fff8495d99975c9c] btrfs: deprecate 
>> integrity checker feature
>> git bisect start 'ext/qu-eb-page-clanups-updated-broken' 
>> '72c15cf7e64769ca9273a825fff8495d99975c9c'
>> # good: [85ab525a6a63c477b92099835d6b05eaebd4ad4b] btrfs: use 
>> write_extent_buffer() to implement write_extent_buffer_*id()
>> git bisect good 85ab525a6a63c477b92099835d6b05eaebd4ad4b
>> # bad: [cd6668ef43a224b3f8130b78f4e3b922a7175a05] btrfs: refactor main 
>> loop in copy_extent_buffer_full()
>> git bisect bad cd6668ef43a224b3f8130b78f4e3b922a7175a05
>> # bad: [5ebf7593abb81ec1993f31e90a7573b75aff4db4] btrfs: refactor main 
>> loop in memcpy_extent_buffer()
>> git bisect bad 5ebf7593abb81ec1993f31e90a7573b75aff4db4
>> # first bad commit: [5ebf7593abb81ec1993f31e90a7573b75aff4db4] btrfs: 
>> refactor main loop in memcpy_extent_buffer()
