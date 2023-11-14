Return-Path: <linux-btrfs+bounces-122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3D97EAB19
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 08:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9747FB20A2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 07:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34469125D6;
	Tue, 14 Nov 2023 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LVHu9AXg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3075F947E
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Nov 2023 07:55:17 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C5ADD
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 23:55:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mt3aaMDsrhiwaF92JMr2vPm1QnP1sKdjyrZBmptfG2UixI79QqLR2SRaPLmfnAedksVMApEfGCYBLb3VcmC7fPJ5vbR7nGgt5yIUJTqRtznrf1DvLhMtuCGEipfWEblnkGl1U54Zn+RJJTWL2W9lSiBxGJI/n1jmI1FO6I1/URh7XlLFvc8KfLMKHRg4wrsTSQo8K/gRm259HUQxLzgouxNaCQibCS+BafzOHQPohRFApJiSjgUfWvq7OFFHX2XeNF+X3R7ElL94b03sFZL1OFFoE/+yT/0GEcz1O9LdX7r7o94VsLfrZf1+7CYKwZsrCzcP1TSjmZdPgEL8kuPKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jXxvDcMEcv3pBmRYnEbaxo7nLLexk6RSBhbd3RUM9Q=;
 b=TaFdOdCbnOnIvY5zhsmodU924G0laR0Yg2BBSPy8vIqQ38lU6BG2N23t/Mgw312Ycw8dA0GvSaQEtvTUxHkAOxcp9sFFXjZaaqeY6+BF5WYn910fv2x92ZsOLlNVrMAMVI37SPoZsVnM6Rftmmq3MRC60GIZ1jsHQHVZ+PQr7teF9Cry8cIjUC43q4wuQrn+Gjdyi/8dRM1L52Zmu/jGph5OdaTbiWK6UAoF8jhWdsjugfdb5rmVG5wjygZjYcUKmbX1oGlmVwHpdF7Mm+k9ZiFTmYpWzc54IwQuOvMCGhfbQrSSZXLmMWE0fIRdBGH3+GTlNRWToegits7IF6hJeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jXxvDcMEcv3pBmRYnEbaxo7nLLexk6RSBhbd3RUM9Q=;
 b=LVHu9AXgy1sB8jRKSCvhHKGhnAPU3wUo0tJBD19+yq4ZTF8HH4LwLOsIBXQ6rTPb6ANKZk1LByzRrw9x01DsU2MgogGznRa9x/u3QZm61rErDQieENDqEAhcPKMtot/weNv/CODer8Rc4Yzo3QWTe7YFpkuFx+PHiZfeIPHGv8n9LlhcIicSpz0uo34JJVbo+C8Vs3r/6Rb4U2KgmI3LO8vboFNNJLFrZJIjcJJTBZeZYdlXUbZdnzXZMuEp+FaQLV9yiy1hS0gWIVvYmrF3M47UuZK2z74UcPQep4Cwxx2qB5YAXzgZ87DlgzXi02L/uG9kx++K8xzUdNZtrPUsqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8478.eurprd04.prod.outlook.com (2603:10a6:10:2c4::13)
 by DBAPR04MB7239.eurprd04.prod.outlook.com (2603:10a6:10:1a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 07:55:12 +0000
Received: from DB9PR04MB8478.eurprd04.prod.outlook.com
 ([fe80::c7:a650:9dc8:4972]) by DB9PR04MB8478.eurprd04.prod.outlook.com
 ([fe80::c7:a650:9dc8:4972%4]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 07:55:12 +0000
Message-ID: <79fd5ac9-5a06-4305-85d9-25481d621eb0@suse.com>
Date: Tue, 14 Nov 2023 18:25:03 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not abort transaction if there is already an
 existing qgroup
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
References: <b305a5b0228b40fc62923b0133957c72468600de.1699649085.git.wqu@suse.com>
 <64b1dc37-4286-4e42-8074-0be96315efcf@oracle.com>
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <64b1dc37-4286-4e42-8074-0be96315efcf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MEWP282CA0169.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1cd::14) To DB9PR04MB8478.eurprd04.prod.outlook.com
 (2603:10a6:10:2c4::13)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8478:EE_|DBAPR04MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a4ab98-c5f7-4ee6-942b-08dbe4e707c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	smJd281ngOQCbsnW6slUJZyp9MWlpE/oMFs/eyb3TYwbp3gyNHssAb437jVly6aCJCluMLlMNE+Q/Lb5ZO61Bu8ZeiskCAhcbEZAHyehKKstpvr4toMHtrYcSdmP9OqohgF9Dl0Pb7/sJhbFriFq4mcjGvjqJsO9I96AVyvwfKxh8NuhO7QzwSbpMkO0x8z1sDdSTmBMcEucgbJdCoMr2ssCM0ZgJzCmN+T7zq+dmMX2CrpWU4aKABdaxDIXkUCg+y7o2S4ha99qwerDapjIx+gcehXfEOOgrqmNwKjwREHqdTO+uEne3WulbtZUKtLyg2hsA+4xhfsOtLDbaNvt6mawXsnFdZ9//QYdzn0HTypib5D0HIQqWg9S/hqIt3xp02yjB9M+ccozLHqVAMS20P5cxCWNjq7VU8fw6uVHxP9hfYI1ZHjnZ5XeIL0TwK+TV8sKj1sehyocdjZWRz2zb9oPqBVsEWkxdj3nN8nGr8DDDDfmiMlG8kp6QM3Cu3L10YdlxBJgTTvDt7gME/pwc2UW94jmkJjEzc5N3W3xU3JDhuRG2cqaZW6MdOOSVKmqmgK7q42QSqiNwt8MO2D/aGOMbucxD0KsMwkJtG334gAVB/5btBzodsg/l7FBJ+YOh0qt3H4uGTbiV769MR6rqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8478.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(6506007)(53546011)(6666004)(2616005)(6512007)(83380400001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(2906002)(6486002)(478600001)(316002)(66476007)(66556008)(66946007)(31696002)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGljdlNDQ2t0Y1lFVnJubVgrV2Q5UWZySjRySW1LM1pLdEs3Rm1NOUFjODUy?=
 =?utf-8?B?OTZIMS9Qb3c1eHQyd2w5TXF6OUVzdWRMaTI0d0UydTY1ZzlMWjZQNFFoYk1C?=
 =?utf-8?B?OThpT0lnUXRaNHRzR21WdW1QRVIwdWs5Q0V5anNxSGFEemVIdnBlYTZPQ3p2?=
 =?utf-8?B?bDArSjA1bWlEM3ozajRZR3JMMlUwNkxpTTJ5alJPcDBUSEc0dDQ2RDdOZU4y?=
 =?utf-8?B?M2xqbUhMK0wwMUtEZFoxejlrdFA0QlN4N1F4bERtRThkUFdVOC9BZnVwc3lC?=
 =?utf-8?B?SWpKTm9pcmQxM1B2QVpBb2lSQU5MODZIRUtjUThmd3VRRlo5M0NxLzM0aVlI?=
 =?utf-8?B?ZTk1RlJIT05jejdicEZYUCticnNkRHd0WjZvUXc4Z0pmSnY2R3NJSlZ6bEFY?=
 =?utf-8?B?L3hhZjVPZGZzTmpOeEhNMk45NWN1M3dTQUwyaWlUQUlmQnRSYlVSc3hHc3Fi?=
 =?utf-8?B?QjVuTGN5bjJGM1krY3lhNGVEc1Izdm05WXJhZ1R6NXZmeVBlL3pmeTMvSzEz?=
 =?utf-8?B?TW81cGZZdXc0WHVyRlIwSmUrVW9UU3Avcmc2VjNKczFhdW0rbnFTbE9RWE1U?=
 =?utf-8?B?SXNPcUV1NGhSbmpUYVF6c3UwcmxJc2p0ME9xZFdJd1FiZGRrTTYyN1R4cXBP?=
 =?utf-8?B?ZnYrZ0Qzb3FESVZNT2VXTUJGVUoxV1dsVXVYZ1diQmlUNG5LRHc2UE9vaHM0?=
 =?utf-8?B?aWRlKzAxdE5mYWVOcUV1b1BmdzBzL0U5MVdSUmloT25ZSU5KLy9MN25YSVUy?=
 =?utf-8?B?SHQ0VDJXc1BPTm9PRnpFdVRmR3EyZ3RrNWZRaXNJeENKajRKTnhyaURyU0hK?=
 =?utf-8?B?VGladHMxTTdRc2ROZFZnZGlJcE1Kc3VKNC9QL0xCazg4WVowZ0dvMWNmdGs2?=
 =?utf-8?B?N3hOVDZFN0Z1UGlrRU5QV2wxTU12U2tvUUx3a3pKazJ3Ti9ERHdSR1lib3g0?=
 =?utf-8?B?L3hOOVJWUG14aDdZeUh5alBhbEx3Zi9STnJlTkRhRWdMVFhDQWZvTGJhUC80?=
 =?utf-8?B?WXArTFJBRFRkT2k5czdFNGVyR3pqemc2dEVyWFlpdmdRMmZGWmN6Yy9jTGhw?=
 =?utf-8?B?M1BsdkVMRkxrY3NGWENVTzNLbWFRanFRN09wQktrOHplWkt1Rmt1ZjhqMGxt?=
 =?utf-8?B?aUVkc2xrWlVibENkeWdEc1ZsTE5YTE51M3dPbXdHUjh6d3l4WG9HUzVWMEtv?=
 =?utf-8?B?Q29weERPSzlobU1pcDBjb2cxRXM4VU9LNTBydUdGaGp4RW9zdU9LcW13ei9J?=
 =?utf-8?B?RDlsaEl0NlRyak84cjdZYmlrUVRMSXh3SzcvNzRZcWZkaE8xTlpvVmgxemFZ?=
 =?utf-8?B?aHFXVUFJTE5tblFPaGtLZXdlalpTNnVQb0IvenJyU255OFJ0dXpoandwREVh?=
 =?utf-8?B?MzBJRjRTTW52RHJJZ2J6cFpvbEFneEJtR0NlS3I3SEdrUi8zd0JOYTM2a1VH?=
 =?utf-8?B?U25zUGdWOXBLSUFXV0kxcThmOUY4dXhJcUt1TnRRNXFVNW0zMzg0YnhVclY1?=
 =?utf-8?B?eVhZcGdsYmVRVXpzOUFVUlFPRjdsWjMyVmRRRjdDYThzT2tUMGl4b2lDUndr?=
 =?utf-8?B?STRVWFVtYkJpR3FWMVprdkk3YVQzTG9SQUF6NE12NCs4RDhqZHdrODhQWFdL?=
 =?utf-8?B?WEFzVVd4MHp4OTVaRUNRTFpRODhDVEJvU3p1NGNFL3VCSzNRK2lIMjhaTmFv?=
 =?utf-8?B?OUk3dklPT0FMZkVnSVk5ODlJSGwrbm1OYUpJakxyRmtmelhLaHRwK0NVdG1M?=
 =?utf-8?B?U09hYmVLWUx6ZmFjbklKK3hwajZQdFF1SW02QmJlZDBrU1loSm1BdTl2NDNr?=
 =?utf-8?B?S3Y2K1o3UWZoSnhsajlUWFdvWWN5RXIxbWc1UEJXNCs4aFZsRktWQ0RWZVpF?=
 =?utf-8?B?ODMrb29kK0R6Y2ZQWTJtOU5XaUNpamxkZVRpdDc4YUF5SDFrUHRQTFVzdGlm?=
 =?utf-8?B?Qm4zL2NaeDZOMlZ0Q0NXYU1yRDFQcytXb2U5UEg0ZlFQSE9UVzA2WU0wOVpI?=
 =?utf-8?B?L2l5MjMxMG9VSi9SWXJqTDllcmxOWFpPVHAySUNSWWdrbHRCczY4YnVFaVNp?=
 =?utf-8?B?WlEyV0dZYjVqR2JtVlhBTGpRS2RDdFFta3VqUHA1ZytNYWZ1L0NpRkw4TmJy?=
 =?utf-8?Q?yCrM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a4ab98-c5f7-4ee6-942b-08dbe4e707c3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8478.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 07:55:12.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgM6K7Cdmhbckox66Rq98q2pMHj/Hljaj3QRwZT7ujBsBIW8sCeOYyqmy0psJD3T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7239



On 2023/11/14 15:43, Anand Jain wrote:
> 
> 
>> [CAUSE]
>> The error number is -EEXIST, which can happen for qgroup if there is
>> already an existing qgroup and then we're trying to create a subvolume
>> for it.
>>
> 
> We were able to create a qgroup for which the snapshot ID did not exist.
> Shouldn't that have failed in the first place?

We allowed it from the very beginning, even had interfaces to allow end 
users to modify them directly.

But nowadays, you can no longer change the numbers out of the kernel, 
thus the newly created 0 level qgroups can only have 0 as their rfer/excl.

Thus it won't cause any problem, some may even consider it as a way to 
"preallocate" qgroups.

Thanks,
Qu
> 
> Thanks, Anand
> 
>> [FIX]
>> In that case, we can continue creating the subvolume, although it may
>> lead to qgroup inconsistency, it's not so critical to abort the current
>> transaction.
>>
>> So in this case, we can just ignore the non-critical errors, mostly 
>> -EEXIST
>> (there is already a qgroup).
>>
>> Reported-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
>> Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/transaction.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> index 9694a3ca1739..7af9665bebae 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -1774,7 +1774,7 @@ static noinline int 
>> create_pending_snapshot(struct btrfs_trans_handle *trans,
>>       btrfs_release_path(path);
>>       ret = btrfs_create_qgroup(trans, objectid);
>> -    if (ret) {
>> +    if (ret && ret != -EEXIST) {
>>           btrfs_abort_transaction(trans, ret);
>>           goto fail;
>>       }
> 

