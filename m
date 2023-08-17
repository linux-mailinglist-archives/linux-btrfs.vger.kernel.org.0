Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15278017D
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 01:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351393AbjHQXJK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 19:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353356AbjHQXI4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 19:08:56 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2059.outbound.protection.outlook.com [40.107.6.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA5C2D68
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 16:08:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTjZKW9RyOLnRwCAD2dQk8U055Ji2OgH3C9DiuOya9mCY41yZK9LZsSMMX54Ggve4evD/PYmP3i8SunSvcS+sivjNHVqju+97pDxINDlpjms8csdm1vExlFNcyu1JsHYA2SbnG1Yy4S11y+175S3Bihs+OPeftOkz+/9oZl8D6zbbjK+xU3GleKYSo+BxtH9wYD2ni+ersncL8gVnllvy79+M+lvw7ovFPD1z/9Nw3TnJnSMJp0tYs7jKKXAYWVK1h+It8Nbt/2GT/wMufztcZVDSAMqK1MPIEEarkFdpnIGvlPZVLH+URRjWoE5PiohWqEIraFtoKrg2Gv3za9/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=690B0aitmk5m6NaFcqCx6lSb4DcpZmlrF0XgMFtkU2o=;
 b=e2T73XgPPVTD6ujDzxxYukmDFsHS6s/d4Splk6TdRcyvUotUHCmCyoDT18zUlwS5xDZ2aYXMz0OpQYl/XuT1wr1/rpXceiMMbkNT9W+UKbOk700f2DqGdf1mzWlJZEjNQhe5PcNpkOm1oQQx/ZRYYCHM4kxYNscNE9tbk5xzhlAIhK/N7knG0SaE0TNZuxbvssE/UFYdvcJZwEyNxEWLYRZUqLsgvj5DL4QF8Q6xgFwwXmvYik/xrNpQkz/QiHA40nL3KZ4XoYl9NsHqbkKbahrXk4dvrxWdITIvA9RmN92xPgS7ms+pn7CVlL/1RyGRyrxJiJlh5HaGg407+1HPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=690B0aitmk5m6NaFcqCx6lSb4DcpZmlrF0XgMFtkU2o=;
 b=YgoXZCAPDTxIo2aDL6tORA+b77LKYEBpQj4Wm/1967xtGmyKfZwr2T+rzvFnAvt3K4rIRzp0kx5VQtAr233RsUl64nSePHi/OeSKrJeWFrYg6d4TEgS1hRdugCP2cQjbvg5WOPzYIQcLw6VxDVdCUhJceK4Yth00nnDuziU0T/6qiEgXqwilgf6bOO+dSVWnd9awFWvkBlrnsxVe6xy29+r50mBpS95REWu5veHeCDzM/PgvYIZYel9Vnxfg9W6h/nlI4Gh2k6gnxwkYAveR5x15S/L5ljElqa0jorD9R8ZARUWpjLqyGmhLLQM3Rx21nMhhR1ULU+5xEOnVRQEuNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAWPR04MB9957.eurprd04.prod.outlook.com (2603:10a6:102:385::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 23:08:52 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 23:08:51 +0000
Message-ID: <a2c464a4-68cc-4e3d-a5f1-07f7727ef983@suse.com>
Date:   Fri, 18 Aug 2023 07:08:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: scrub: avoid unnecessary extent tree search for
 striped profiles
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <c21b78ee8bcf22f373beeefb8ee47ee92dfe8f03.1692097289.git.wqu@suse.com>
 <20230817114747.GI2420@twin.jikos.cz>
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
In-Reply-To: <20230817114747.GI2420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAWPR04MB9957:EE_
X-MS-Office365-Filtering-Correlation-Id: 0731c992-de04-4234-9e0a-08db9f76eb6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXmuRaZJiK8XK1YmGZAnu6aeIRBsEcbhnCXSkIjERBGHL3f9h7cWGblOnalbvW/xZxV/alQE2u3pCHmCzENRo3cl9CcsNedTR8NEvCmW6yYNbAVJIkWwf75AT2Mo9uAQGlGRmf/FHubUvweRYxcPZw/s83gIrMB8ELBAT4SkHUaRmZha/wSUcqxWgXKSmOhGxzD2jeWXSHhlB9EfGljLvR/oxNDaUmW7v69NYvAajxaF/Gmkw7bbMOAiOBIr3EfEVtgKR4y6qdpJiimh/Ih7LNfpjhCDuB10zBjeuyES2AC27f9m66FxbOoD8mODcKrmLCM1Cu1xRypOPGfacWTyA5xuUURhyVNgIcYkj67rWCR9LRlTxMa1oTq3i40M9bfJiDXGRz8ba89/sM7ctypdL/kpx0zhXWOHRkQSl6kIYgPTDC0hnWOTdijiZQt2aGgkWpqWFlXR0MDHcCZYdojByGEOiqCXwBg8i5q6tT6WykxBMFsYkHGU0tKcgDUOZ4+Xfr4wfn/z6hK3wzbO2IoMCxTXJ8Jx1a7fNtO9Xy7tOb/d9sD/QssMYRHyhha0RpO95R+w1GertzcN1U65fV7JchdVgN8wcaYJpudha8OTYvQqc3BIqK+zbToFTck7MqedxpE8KyWAyJiLYB+82V+h6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199024)(1800799009)(186009)(83380400001)(478600001)(6506007)(6486002)(2616005)(41300700001)(31686004)(38100700002)(6512007)(6916009)(316002)(53546011)(66946007)(66476007)(66556008)(5660300002)(8936002)(4326008)(8676002)(31696002)(86362001)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUphNHBNbWl2Y2t5ZGdBWEpVdTBPUGMyUmVNQVJkY0xmRmpWS3RQZzRyTVdK?=
 =?utf-8?B?aVFnS1ZjRVN5aWVUS255N1I4dCs2VWNTMm45LzI3b0YyV0FpMFlBazJqUVpa?=
 =?utf-8?B?SFRpMjBMT09TdDBseUtqdkRXMXd5OHlsWkJ3VlUwT1NwaWt3dS82QWxYNTRK?=
 =?utf-8?B?QitpV21IeTZsSjhUdzR4bEtpRlFaMVFOM1BPRDMrTGxsM29EMHh2bzkxdEl0?=
 =?utf-8?B?ZU9ibUNHZDM2cmpIdmRlSTZDU0MrellNemtZQkh1cU55ejdIRU9yOFczaGYy?=
 =?utf-8?B?bFNxbXVCbUpXVEJKeGVDSEs3U2owemtnR2dlTWZkd3FVdWlqbE5KT252ZlBT?=
 =?utf-8?B?ZlR3N1I4SFgwUjYyTEZnWjVMZElobWZQdXJXcDkvakVLMnk1TG9mT2toQ3Yz?=
 =?utf-8?B?anp2Mk16ODZtTEl3ditPeFpkU1pKMWdZWEpmSnpXd1AvNjJUNktwejNtUWpV?=
 =?utf-8?B?SUpkL3pKUEFyUmJxdk9uRkxNbEYvS0dmSEFoZndkOUlvNjFwM3FBSlpHWWkz?=
 =?utf-8?B?UTVTU2FIZldBak1TN1pGMkxvelJaR29uak56VUQ1eHNXMGEzNWNKNmVoZjZJ?=
 =?utf-8?B?cXllLzV3RDZpZlovOGs1dS9WWW1TWGQ4UUNjaEJDRkIzMFJUNFBGbnY0d3ow?=
 =?utf-8?B?TzExbVpBSmNjQnBGdW9YaTQxYWI5UkszdFBnaHNyQlVtaTVGeWZaY002bDBI?=
 =?utf-8?B?Y2tmQXlsVGVxTkVHMk5WTWJnU05Tb20yd1I2c2FIZUxzbVJPRHVDcUJkOEdB?=
 =?utf-8?B?TTljQ0JmRTl1L09xcGUxTGk4UFlkZEZON0dWSzNISXE5UmpyWTQ0LzRoUW85?=
 =?utf-8?B?MnhJdGd5U0NoeW9TVU95SnVNZTBDODJZbG91aUJHMGw2dUpyS0c1VXdrbGhO?=
 =?utf-8?B?ZDF1cXE3M1JPVmVnWnREcHRLdUZNTi9ldTVXbXpCdDRmZnFTcTkyMFJMUnB4?=
 =?utf-8?B?TVhKaXdkZUJWd3dmaWJvLzkweWdpZmlpajZ2cnBEdCtrbHQyV3J0MnlPZ3pO?=
 =?utf-8?B?T3BSNjdRL3dSZUVSdW1QZjA4ZkM5RUhrdUdQNmNGRjFFbldZRWFTc3VPQ1Bi?=
 =?utf-8?B?UHBpM0dIWk5KSGZLWDZycXFualhDQU9SVlp2WFRUMDl1Unk0VkFCaVNlbjAx?=
 =?utf-8?B?eWZER1N1UVJQS25yTTNaMys5SDNwUFU1QURvVVJsWDB2UE43VHpnZitQdGFj?=
 =?utf-8?B?dzFWQmVSWks2SW1YVGFFMEtTU1FMWmlyMUxtZ1lBQVZuaGRIaEtvSFI0Q05N?=
 =?utf-8?B?VTY0b1E1U2dqcUJURUJUU3JaelNUc3k4Uk9aUEMvWDl0TzNoWHF0QTdiK3A0?=
 =?utf-8?B?MlJBMWFxWmowMjJZYTczQVI2QkUyeGNkZ1JCV1RwcUVHb1pLMlMvRktQYThO?=
 =?utf-8?B?VU1aajVzRWdJN3JTYUNlRjZ0Q2VqN1JOWThqbE8yQmtlbmVWU0l4M2dYNlAy?=
 =?utf-8?B?MVlGNkVhZXN0SThCc1pIY3A0dmJPSG15OG1iVDhQY0pCa1VxMkEvaWJhRTA2?=
 =?utf-8?B?SEZCSWxGQlJsRzRqbmsxRk1ZT2hMd2xGWXJDN2ZOUmFhSEVWbzcvWnVlRnF5?=
 =?utf-8?B?RjFnd3UvU3NCSzFmNXcxRkxRYWFKc2FNK0t5MUs2K2pYSW1IT0pQNy9adVVv?=
 =?utf-8?B?YVprVzBrcFJhd3hvR2R5Q3QxMDdUYWlCd1NuMUJna2xLMWtoWm1zOHJCYlpL?=
 =?utf-8?B?bGtaV3B0UlNsNW82T2VsWHdDSExvQWNlakRBc2RYcVFrS1pUbkJ3clBFajdh?=
 =?utf-8?B?UVNlRUlUZTJ2ZkNyc3lPUTdDSDUzMzNOTVYwSGNJUmV2YUprLzR2bXh3MXpN?=
 =?utf-8?B?b1kvaXZSWUEwbHFFM2pLOHRGcUJySG0rT0tQRHkwenhoNTdpOFpxa1lIdWJS?=
 =?utf-8?B?T0Y1Y05SMjRpUE1lMjFaSEFwbE0zcmhGZVc5VnN0VWdNbytwVDNWRm1WMDRi?=
 =?utf-8?B?N2lQWnZFOUFDMEp5Q0Q3R2xjclZ6NTBiVTZZeFMxaklUZHBOSHg2RUl2U2Yr?=
 =?utf-8?B?VVo3UVplL1g2dVJ1dlNBOGpFV0dqT283VjA4TXhsUzZ6bUlXQWxpa29xZUt1?=
 =?utf-8?B?eU13STNIRkNnU1RDK21VN1ZYN0RUUXZjMUYwWjYxUGNkaXJOWS9mK1FhQys2?=
 =?utf-8?Q?lXA9NMxYsVg0jpC0F1r6fgKEQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0731c992-de04-4234-9e0a-08db9f76eb6d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 23:08:51.6516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDcnuw8zcbPU0zJhl3QRNVuMj34rQXH5GLFbCty0vcWEjvb+fwti4YJJRrcQAcHr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/17 19:47, David Sterba wrote:
> On Tue, Aug 15, 2023 at 07:07:19PM +0800, Qu Wenruo wrote:
>> [PROBLEM]
>> Since commit 8557635ed2b0 ("btrfs: scrub: introduce dedicated helper to
>> scrub simple-stripe based range"), the scrub speed of striped profiles
>> (RAID0/RAID10/RAID5/RAID6) are degraded, if the block group is mostly
>> empty or fragmented.
>>
>> [CAUSE]
>> In scrub_simple_stripe(), which is the responsible for RAID0/RAID10
>> profiles, we just call scrub_simple_mirror() and increase our
>> @cur_logical and @cur_physical.
>>
>> The problem is, if there are no more extents inside the block group, or
>> the next extent is far away from our current logical, we would call
>> scrub_simple_mirror() for the empty ranges again and again, until we
>> reach the next next.
>>
>> This is completely a waste of CPU time, thus it greatly degrade the
>> scrub performance for stripped profiles.
>>
>> This is also affecting RAID56, as we rely on scrub_simple_mirror() for
>> data stripes of RAID56.
>>
>> [FIX]
>> - Introduce scrub_ctx::found_next to record the next extent we found
>>    This member would be updated by find_first_extent_item() calls inside
>>    scrub_find_fill_first_stripe().
>>
>> - Skip to the next stripe directly in scrub_simple_stripe()
>>    If we detect sctx->found_next is beyond our current stripe, we just
>>    skip to the full stripe which covers the target bytenr.
>>
>> - Skip to the next full stripe covering sctx->found_next
>>    Unlike RAID0/RAID10, we can not easily skip to the next stripe due to
>>    rotation.
>>    But we can still skip to the next full stripe, which can still save us
>>    a lot of time.
>>
>> Fixes: 8557635ed2b0 ("btrfs: scrub: introduce dedicated helper to scrub simple-stripe based range")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Fix a u64/u32 division not using the div_u64() helper
>>
>> - Slightly change the advancement of logical/physical for RAID0 and
>>    RAID56
>>    Now logical/physical is always increased first, this removes one
>>    if () branch.
>>
>> This patch is based on the scrub_testing branch (which is misc-next +
>> scrub performance fixes).
>>
>> Thus there would be quite some conflicts for stable branches and would
>> need manual backport.
> 
> Added to misc-next, thanks.

BTW, did you hit any compiling errors on 32bits systems?

Some bots reported linkage error due to div_u64(), but I see the same 
div_u64() calls inside scrub.c thus I'm not sure what's really going on 
here.

Thanks,
Qu
