Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35A54B0365
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 03:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiBJCe0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 21:34:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiBJCeZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 21:34:25 -0500
X-Greylist: delayed 3612 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 18:34:26 PST
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975A2237D4
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 18:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644460464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjn9gqbSXXPMenGayZdGZ6koAVaWFWriRbMWxZjiftQ=;
        b=CBWZl4OEd3/lncKkkT5s1QOSmGK/FcI1Jwe37/FwpgvRHOtNMBaNRvK3Kk7uMyO7WDDD71
        Gy/Kh1KNeTpoD53y7rUHCfTrK/uVwxLjwnMi7oztjfUb2LE+7a8rHjclWLD/t5g07o03Xa
        TPsDPbn4ktweqs8JcKmCMfvoueaCl8c=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-e0w_lJzbO82F9OK-er6f5w-1; Thu, 10 Feb 2022 01:33:16 +0100
X-MC-Unique: e0w_lJzbO82F9OK-er6f5w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEBBPvrjzO7GovoVj1SUH8w6m6JN7iLKX9wRi7MTx0DwOE2vGOudJj5g/SHwPz50OYApRTaJxCWnw6SbxVZZr+N6LWhHv95lMlCaEbQ1zRDxV7n8urtd4SpreW3ey05WezHul53oKCO+Q40zVYDpLVe4Qvxd13DfAKk3ydEgui8+ymozMKV16u6iNc3Wq8nsWPF7kmWxmGFukX+KBYs9UT2EGeeFt/wCgOIAkSCuTmnKiiP2JjhcTWBqPMYIaMyK6qPH109tvhwowacmCnrikeL6PYQTFhcdRrm+r/oJAtSIvPjhoR0NarRxzkG9BY2xbwgzgrN4/KGkymk91viiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjn9gqbSXXPMenGayZdGZ6koAVaWFWriRbMWxZjiftQ=;
 b=F/6YnZ5Rk/sHwoBC/0s3usC92ptfKfdpo8r2oQvJHp931Ha1HJgZfe2iDEdquYyWPCdfRlkHiAEbuvDse8EZexAFfgADMzO6qft93SKN9An7Dp3d/z3oIL4nz1dfhAKDhyVpad+8HebB4fbeCdROannOWa8YrK6Ial23xKrv9gj5Nsn5kZKAWSe6d1R7RKdvsDDktCnlxv6BCJIMIslE3V3Niq1G7T5QMYsx3XDMWPzZ39B1nadDGOBF0MmwVV/e7ojrdWk3i/wFmKcbNeHMS/SrdH+m/iQB4h+IWOyoWb/L734hRc5xZqnovLdDujXU8Z8K8L4m3mtTg7mTu/7q0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PAXPR04MB9423.eurprd04.prod.outlook.com (2603:10a6:102:2b3::7)
 by AM6PR04MB5735.eurprd04.prod.outlook.com (2603:10a6:20b:a4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 00:33:14 +0000
Received: from PAXPR04MB9423.eurprd04.prod.outlook.com
 ([fe80::40c0:e02b:d880:bd2b]) by PAXPR04MB9423.eurprd04.prod.outlook.com
 ([fe80::40c0:e02b:d880:bd2b%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 00:33:14 +0000
Message-ID: <38abf10b-cca3-0c75-fb18-a90c658541a4@suse.com>
Date:   Thu, 10 Feb 2022 08:33:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 0/5] btrfs: defrag: don't waste CPU time on non-target
 extent
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1644039494.git.wqu@suse.com>
 <20220208220923.GH12643@twin.jikos.cz>
 <b50e1856-f03e-8570-6283-54e5f673a040@gmx.com>
 <20220209151921.GK12643@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220209151921.GK12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::27) To PAXPR04MB9423.eurprd04.prod.outlook.com
 (2603:10a6:102:2b3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 527f4116-462c-4246-f14f-08d9ec2cecb1
X-MS-TrafficTypeDiagnostic: AM6PR04MB5735:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5735E066932C04F064AAC813D62F9@AM6PR04MB5735.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wCop9AON+5UTmwYC7EkSWpN6WALt4qlPAHhZHxCZOCl76y5BM1lKtcFJD4pVKGUEwVKDJ5367BlE9Ghd8g9ZbGGt6HEi6kig8KxKGTL2/WIeCNSeBjfcnmWFTEAwiZYUMRMIYO1why4kgWzUJzCy9Yvv7pvEpBcUxtzlvYlJLUCAf8wUbWfkGpnen0goiVb/xJQPGynFYJw+zu/qT61WX/i5KX7948TN4YRVOQRFODnh/je9KWUJwW8RCfQYE9QXG5le70g5DdR1YHttdlzCiOV5GOgLYKEw9pk89AvwgffSK2KqMbmm0yzyAQE0wNiQGcIyhviWADmFhTrLb/YNN3V+ApBjtZezqimDMQN00SGONRLjiDxevpwj2MfyQ8ywMGZPPu6VjhYSnmeCjpfV8Cdcwc6uKBT/SJ3DhmId2sosTTAIUaPf3bFoKDeQI4wMNOPsNMmHde7YZ8xhr0ssEoRkbbd/c+xGf5q2fvF28lFHsEpTUipG66cqtSe9arfs54N6C6k7ePtQfLWO+b+LvVhBlmSKA5A4eK4WQfhu0VWxbfNVAa7IhMavCl4HU1o7HFVAoY9NJfPDcU4JHpsfBj5O1Yme/V4YrTFXAsJYWX4hwdt3pYArQGm7uz8D7S4uI95wgX7VWVRQNmLjBL4mSPGvxABUum1vv1smY6SbZZaKLn4pf5QWhTSBtti0clBem7ZEnyqpSVSFo/zSrHV0yBxfCtXE1DdC84u7cpYRU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9423.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(31686004)(36756003)(2616005)(316002)(6512007)(2906002)(6666004)(8936002)(66476007)(38100700002)(66946007)(66556008)(86362001)(8676002)(6506007)(508600001)(6486002)(31696002)(26005)(186003)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QStQQkoyQWZ4aVJyZEJ1d0xRV2E2NndORjFTQTZ5M2pnYk1ISEVzSlVFQmc5?=
 =?utf-8?B?eXdFbmxhUFNYNG9zMzNQWkJOV3FzajFxeUdRT05CbVVkRjdrZzd4TTZ3c09k?=
 =?utf-8?B?ZjREZDV0SDNHYy9BWnoxV3ZpT2lFM1BXTUdwbmZ4cDE4ZVNhRmN3UmR6WE5l?=
 =?utf-8?B?ZmNoM3d3WDdkQURXeTRSVGhtTTlVNEg0RnlLcko3aVB5N3h6M0lpNkI5dzVk?=
 =?utf-8?B?UW9aT05VR21pQWtDTEN3M2VDNDBLYkFQc2dpOVp0N3RRNXp6VFVWVXV2QXA0?=
 =?utf-8?B?YUZVZ2NOcnptZFFGV09HbjhCTG9kSzdySkJ1K0FzSFYzcFhCczFGRmprQWw1?=
 =?utf-8?B?WVczQkZSNmYxQ001czYxd1F4aGRBMDJvMDFldTFaMmQxRVRUK1Boc1ZWbFlm?=
 =?utf-8?B?cW5PbDZYK1pRVWVxUmtEcW5yL0MwNFlDQmhTVDZoRUY3RE1GVi9HRzVsbFl3?=
 =?utf-8?B?S1IrWkZUSmxXZ1IyNHhtMUlUNEpZcXo3VWdKSElwaGFsbE03ZDZ1bzUrcU4w?=
 =?utf-8?B?TFRiOEFWMDB5eVRFT0ZwMHlobjJTdTN4akFnd3JOSEFvZEV0dS8va3FwZ0lr?=
 =?utf-8?B?K3NHM0hRMGhDRDZObm52SExvUllBdE1oMzNJNC9UbUdSQ1grZURjTmMrcDd1?=
 =?utf-8?B?QmdjdStMWDdHMVIxV3RKSCs3MkxkTDBVenhzSGhOazlBWVoxQ2VwVEk4R0Q3?=
 =?utf-8?B?dDNER3dXd2NGeWF5WndsRWhYdWpuajFmeUxMQitmNVVKUkozRXZqbHJ1Y3VX?=
 =?utf-8?B?K2gyb3hHV3krTTBxZGkxNHNSZzlaaUp0blI4QTlnT1JFSE5ZbU5MYVFWS2hs?=
 =?utf-8?B?Rzkrdmh1WWdhQ2IwS2N6RDJ2MjR2Y1lkN005WFNKblJZZm1XZUIzYjNmb2Rp?=
 =?utf-8?B?RStQK0hkcUFiaVNZUjR0S3dGV1ZKMUZaRklNVytFRGg2TE1NZ21URy9pdzcr?=
 =?utf-8?B?NVIyWllzQUtnbUZESjBHaExtUDAwNXRPRS91WiswbXplUGs5VllVR29CTEdp?=
 =?utf-8?B?bEhtQ2swQW1aQmxMKzB0VEV4dW1XNDRRUWRhaHdsTzEzQy8vVENpVkV5QnRP?=
 =?utf-8?B?YVp6U21McVUwRzl3RTJId3ozc3dXVTJiZVgyaXp3OXNBbVBXclJLSUc4dms1?=
 =?utf-8?B?MEI1c2V3ZVZaNU5FTFk3MHVwSzFUb244VUZjWkFHakNsSlB4ZlprQTVJYTlx?=
 =?utf-8?B?dGsvbmFETXRmVDZkMnNoc2FIR2hTQWw4VEphdDY4NnZCVjA4eHhIOVc0RWlZ?=
 =?utf-8?B?aGNUVXZ4WjlKSll0T1RyZThFVCs4VjFoRWducm8rKyttRDN5M0hpUUJjNXVB?=
 =?utf-8?B?bUZ3cVp3N09vQnRKOVFjZU1USXkyYXFtYnYwdGtCUzhyTjRaZlUrdFIrQ1NH?=
 =?utf-8?B?R3NtNUVNVXdxRlNHYnN6NEZrZWhjSVAzazVJUThTY3Zjak1TeWtyby9ISVVB?=
 =?utf-8?B?UnBkSnRTOFhSdWFXRFNUN2F3RU9mWWxKVjhaL1F2Q1RIU2hySXZYV0VmY05q?=
 =?utf-8?B?Rm5ZNC9RRjdrQU1rdXdRWXBkdEhZay9YT09BcWZmZnpDd3B2M1JLWVFhZU5k?=
 =?utf-8?B?QXhoakNNNENyL2JGc1BJenVtdlJzR3Q1L0lCVUFLeFd6SlBYWnhIS29qcHlP?=
 =?utf-8?B?SEQ2ZzFWQ3lGblR1bW8vSkNNWXZ1OXlYVHlRTlFMVlNrWTlscWhhcnErUnlM?=
 =?utf-8?B?bndWWXRUSUVmdjg4OHVTZEtndnA5NmJEdzNISUpBS2tuUFFGc1RjM29vSzQz?=
 =?utf-8?B?NGd0NERhL1dFOVV2TTJOWjcyeDZabTJOVUd2Nkg0NmxkU01YZm1nMzQxNDR5?=
 =?utf-8?B?cTZqQS9KcnlMZE0waFJJWWJvbUg1dWI0M1VLcGRxeFdPK0F4OXdvc1BSQlEw?=
 =?utf-8?B?NU43Q0d5WHBkdVc2b2dscjN6eFk2bXNicnYwWkR2VitNZmlLK0xzRU8yanU1?=
 =?utf-8?B?U0YrY0hnUXJoREtKOGJQYlNNbk9wcmRmTlVlU3djZHlRbFFBeTVsMVFxUUpK?=
 =?utf-8?B?bEs5eGp4L2U0cXhWcERZK3R3YU9nb29haDMwcUVjN3ZMa1k2ZG14SVhFamtW?=
 =?utf-8?B?dmFNK1VWbHJOYU44YWhnbzBhZ0dmUUQ1MzNGenJjK05MeVN5SnRjMDRHR1E3?=
 =?utf-8?Q?+eJo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527f4116-462c-4246-f14f-08d9ec2cecb1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9423.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 00:33:14.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0d05BVMXu9Q2N0wJWck7sNSmddoK3SDMkAmTGInrnd9bwnW1Pwh5/5Yi8PhCEtR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5735
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/9 23:19, David Sterba wrote:
> On Wed, Feb 09, 2022 at 08:17:27AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/2/9 06:09, David Sterba wrote:
>>> On Sat, Feb 05, 2022 at 01:41:01PM +0800, Qu Wenruo wrote:
>>>> In the rework of btrfs_defrag_file() one core idea is to defrag cluster
>>>> by cluster, thus we can have a better layered code structure, just like
>>>> what we have now:
>>>>
>>>> btrfs_defrag_file()
>>>> |- defrag_one_cluster()
>>>>      |- defrag_one_range()
>>>>         |- defrag_one_locked_range()
>>>>
>>>> But there is a catch, btrfs_defrag_file() just moves the cluster to the
>>>> next cluster, never considering cases like the current extent is already
>>>> too large, we can skip to its end directly.
>>>>
>>>> This increases CPU usage on very large but not fragmented files.
>>>>
>>>> Fix the behavior in defrag_one_cluster() that, defrag_collect_targets()
>>>> will reports where next search should start from.
>>>>
>>>> If the current extent is not a target at all, then we can jump to the
>>>> end of that non-target extent to save time.
>>>>
>>>> To get the missing optimization, also introduce a new structure,
>>>> btrfs_defrag_ctrl, so we don't need to pass things like @newer_than and
>>>> @max_to_defrag around.
>>>
>>> Is this patchset supposed to be in 5.16 as fix for some defrag problem?
>>> If yes, the patch switching to the control structure should be avoided
>>> and done as a post cleanup as some other patches depend on it.
>>
>> I can backport it manually to v5.16 without the ctrl refactor.
> 
> That's not great if we have to do two versions, and more fixes to defrag
> are still expected so a cleanup patch makes any backporting harder. That
> we can send a manually ported version to stable is there for cases when
> the changes are not possible. In this case the cleanup is not necessary,
> but I understand it makes the code cleaner. Given that we need to fix a
> released kernel it's the preference.
> 
Unfortunately, it looks like without this cleanup, all later patches 
either needs extra parameters passing down the call chain, or have very 
"creative" way to pass info around, and can causing more problem in the 
long run.

I'm wondering if it's some policy in the stable tree preventing such 
cleanup patches being merged or something else?

Thanks,
Qu

