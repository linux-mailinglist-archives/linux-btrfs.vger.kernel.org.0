Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61577BD126
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 01:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344922AbjJHX0U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Oct 2023 19:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHX0T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Oct 2023 19:26:19 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2084.outbound.protection.outlook.com [40.107.13.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1ACA2
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Oct 2023 16:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Myzf8J7+hI4HZzs3OY7MAMyuqq/SIb948Rvh7ukWZTQCXO/MNwwZeGeE6oe4qHRYUJbqUi3KbhxszAqFpfYKc7yrE97mjcFT33ELgYVn4k63UfMHNIJF8IZQ6NnN9BX8Gv1pUlyk33reBnoGqXLNLxnk4hbdip5GiiXlLjlYyeDjfBUbBfLFszYJFpjdQeYyxyE7nie4h7dNxlLIHnu3IDMesU34xYD78/Mc5ktM+iH4qgvbTbUaqPoCNczeJtGsUPHwyTU4k5tbgtSxJMiGKGT0PF1mlsnllaeSPdHaOvfXwz42/que/OplV454rjQ7knCS/AvR/J+XWvTcC0649Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpImpuRlRfOrOZNxke0d7Kc9HVLGVcPU9VNFTfNHick=;
 b=Kui2pspYzO4mDS1XRXH48q6uGYu3WvbyW2eBel80HR0gk3g8rnbO36pNCW1xvbyXcJr3fft9vgcgbxU8km4r7uEnmHB7nk04ybFXM1VaXwuz+ZBebi76SL+vRDwXIOfQyPJCm7fmvRXeZ9pSBrEbuQeaDhJhDCbUmMEH8DapiGgFnnk6cSLTRoPqtJvptGXX/NUjcbVWlKSTsTPeFi8kR7oUIra9Ous9QzVQmef149QZKP6ulvYRMp+5DtrnBswsm4lwm0C8I85B/MPWUw9NYDoXLUu9wSfkJDECuQd8cKWyidrdbM+qAa8h2KfX4RVG5ub2hKuonPvaZTIM2KefZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpImpuRlRfOrOZNxke0d7Kc9HVLGVcPU9VNFTfNHick=;
 b=ei6bNRUeoYTUF4WgPK3FbJvtRx6fQ3JKWlx4r0fZ6KLgGjjdN8UP49E6My/9PSoOrxJKcRIsFpJUaNvXvJRpVz10KcP/RoC8GrzHnr/tlxn9donCZugosp0epAy0VIsaKNOC1pP3Zl2ckg2xyii68n9Hmwol+8b05hkMkzTRnVhtD7ldaPW+9Id1DMrbkecsqYgKxHRFjA3xwmCQzqbk0K6sGTtWaueqfmoGuVg8MSINThERbRHaN3jBDQzYlbutcf29qTT+up8nO+Zc8qUWl+2iEYMHjMJK/oRmJEuNAdXmZgCeO6Wu+oo/sH8I6hYTXK6gcbbXpJXhs5TxZnDf9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM7PR04MB6933.eurprd04.prod.outlook.com (2603:10a6:20b:10d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Sun, 8 Oct
 2023 23:26:13 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b%6]) with mapi id 15.20.6838.033; Sun, 8 Oct 2023
 23:26:13 +0000
Message-ID: <6a31bf7f-5109-4b72-a2ca-a915f3ca5732@suse.com>
Date:   Mon, 9 Oct 2023 09:55:58 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: properly reserve metadata space for bgt
 conversion
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <6c556ce0456303fb8ec23a454c3b5e18b874ae91.1696291742.git.wqu@suse.com>
 <20231006153540.GK28758@twin.jikos.cz>
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
In-Reply-To: <20231006153540.GK28758@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0165.ausprd01.prod.outlook.com
 (2603:10c6:220:1d9::13) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM7PR04MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: aeab8936-33c3-45d3-ff44-08dbc855f4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Gq4N/+gd9pBmSLWBn6MXyWNm6oENh4ZFVWlFnNiHiZ56wRj1iYrm1Ksd/Q2vpb1HD3n7vQ7x9JPJLjo0qC7ZJ1dRzY2LjCkniCZHY9eXxtrdrIkDVRcA9tJHmuBkxey5+dA0A09BIzF5BuoEJGd80CYYwjD7Axdk4JxAMuhWcxKvG+mZJU9FZIxeVxKAUTNEA/v82p1orNqMCMC5FBDtA17jWJIdISWYjYxorjTzFqDEmWRIxKkASZySpIBW+J3IdnNld2F+X303dPC2mYEo3vh3xq5M5TLK21Ns64JefgkSpPwDIve68NlJqGgON0msuHIfwtXeZKedLaQOsR9Wy7n2TxNmDR5QXAkDtxqjELPtz5gYW0/qgBFrif+WIK1G8G9tMhnkAZYxzr4B0qPGgG07gsRjmCxg2i1FbSBXvdV1GWzSFHQSIzpdXbD2SNpp+sU0HkP0vfTlFEzZZuQCdngjvqVy2eohqZGE/O18OCp6E4uv7gzG17h/iKfI/QiO4/MTua+v1wxK3aLacLEmi4VmmrjHFcecl4kTVn/A39TWl39BBn9VzUr+FSflQMuAlsfHCph1hfVSPMRhxaihlk3zIfLLbKzk9ir68SJuu0EsByXWmftDK79ZEkZ1mbfompbAF9YRXSwn0ypmjuhMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39850400004)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(31686004)(4326008)(8936002)(8676002)(316002)(6916009)(66556008)(66476007)(41300700001)(66946007)(5660300002)(2906002)(83380400001)(38100700002)(31696002)(53546011)(6486002)(86362001)(26005)(2616005)(6512007)(6506007)(478600001)(966005)(6666004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1SeUtoQTdKNzVOZmhjMWJFVUQ0NnZtWnR5SjhUZ3h3dFhjZzdEN0ZGYlRX?=
 =?utf-8?B?eExyZ3NJRERxU0lvRDVTcGdzT0FxMFJlczRKUjRBSkxYVGZVR1gxNnlRR2JS?=
 =?utf-8?B?Wnk5VkNwMHNFdy9KeU5NWFhOVi94eWRsZm5nWjJKUEVNc3Y3SXd5R3ZveGlE?=
 =?utf-8?B?Nnp4U0xDQ1JpbnVpZUNuQ3pNNTdLSUJVWnlvVkkxcWxaK0t5MmpHa1JaajFl?=
 =?utf-8?B?aDBnVXhIL0tXZ0JscFRSOEpCWkpFTTBzYWd1d3ZOeCtBSDlacXVBMyt5UVFv?=
 =?utf-8?B?WnEvbi8vNFNndjJOR0ZqclJGVjRDM21ldCsrd1ZLRmxJamREK0tMMEFEM2VN?=
 =?utf-8?B?RnY3MTdFZE9JVDFFZ09WdEZMNFVNRHBES1RRdGNrNW5KbUd0T0N1K21qcyt0?=
 =?utf-8?B?ZzJBU1g1djN5alYrZ1c5KzRUTVZDckd6SmZOd0t1WUg0UkdqTk1zVUhOWncr?=
 =?utf-8?B?cU1MWHNta3AvOThRbjhCZDdJMEgveTU1Q3l3akVDS2szRVJsQ01RK2VDa2Mv?=
 =?utf-8?B?RjcxbHEzSy83Yk82VnppUFV1eGd1ZTlrQk8wTHU5UGVZLzBPUm1OZ3RmWmJC?=
 =?utf-8?B?UVg0UzFsV3hMdC9VcUZadkpTVlE4SzU2YWI5UkJnalVkYjJybTJVWitLME1y?=
 =?utf-8?B?SEgrR0EyaHA5UUFKQ1pHUmFqTFIvV0tPMHA0SDE4Tnc4VEU2bWtnR2gra2FU?=
 =?utf-8?B?ZGpZcUUvTGgxMjBKTlNwQkR3VnM1ZXFKc2dveEdEbk02NGJZVmtQNFYxZDRn?=
 =?utf-8?B?WjJKUzFPQlRnUXVFU1ErK3BzSE9IRTN3ZUhLeXFqZlhQUlI2MHVqd01hLzZ0?=
 =?utf-8?B?Yml3M3o3OXRyMlMyN3haSm96OUdmMjEva3lpYU1ta09tNGdFd0QxbFloay84?=
 =?utf-8?B?ZnZkZytzNVRtOXFhK1FEa3NuVDZkbkdVQkFydXpuQ0JjbU5SeCtKZXRYS0hZ?=
 =?utf-8?B?VFZSQ2xJaDFJRUx5ME50V3VqcmdBMjBOTGczWHAvbU5ja1RTS3R2Q1NSNlZ0?=
 =?utf-8?B?MnpNTTJ3VDA3K1YyNEtNQ29RSWlQYkR2NGZMaDJtVmpvaGQ1UTQ5STRKUktL?=
 =?utf-8?B?bEtLRUdTc0tLMk5na21IV3JoampWaXFNZFVoV3VzN0pldVlSbk1pNk14NmdE?=
 =?utf-8?B?Tks0VnMvZ3I2ZllQVXFZMkR6MmNCWFhhR3pmeDBHTUQ5aDd5Q3gvZXZsY3RZ?=
 =?utf-8?B?RW9ldVRKZUErbmwydzd6YlRxQXB2alE5SmFra0Q2ZjRQdU9HcVRXVmVtWG10?=
 =?utf-8?B?T3dhL3c0NS9qVnIzVVU2bVRlS3pTeXhoYWU2QytxcG9zN3JkSGlndFI1QkVW?=
 =?utf-8?B?dlQ1UGFRMjN6eTgrTmppZ29haVd2M3dURnF0VkFlaS9nTXh0anJNSFpmL0RG?=
 =?utf-8?B?STdYblU0NHJvQlYvc0xtNWZZNTlxWE02d1k0cFdQY3dFRzFydWRBYTlaT2hC?=
 =?utf-8?B?ODJCLzZ4V3pFM2VYTGRTajB3a09JQ3NibG9ScmZVODRJcXJhSE13NldzTWNr?=
 =?utf-8?B?R1JCSkZtTHFvTjdwaC9kZWdvTmxmcU1RWWZVeStocEJFV0pNS2ticGJIcmow?=
 =?utf-8?B?Y2EwYndjemZZa3BjRFI2S1NnbzQ5NXl1YU9JY1BodlN2cEI5VmxqcEs0TkFP?=
 =?utf-8?B?azhXSjFjOVNYM0x3ZlNWZUUyUGFRL0F0dmNBdTBoK0gwQ0JITjR0eXNHYjNM?=
 =?utf-8?B?Nm9QRkdta3FQVVBpNThBSW82RHBqeEZEUjVweXNxME9KTm5Kd2NiOTl5NVl2?=
 =?utf-8?B?Y1ZPb1I2S3FCNXh3dXcxSjl4UXhoc1BpNXRPWDNMSUR6Z1VVYTJ3aUlNdGdl?=
 =?utf-8?B?Y1l6NWNuSjRORWl4NjNDV3krUGd4dEJ1VGZObDVkZDhlR3ZNMFpZUjI5N0FI?=
 =?utf-8?B?U0NCV3pRNW1ZQ0FtbkhNNFNRTlVrWmlodnRQTVpPTzJoRjZTQVJQdC9GcFhH?=
 =?utf-8?B?L3hwYTZHVHlzMmFMVkJOUzRONEpWNlVtV0N3QkZUcFZ5Q3c4a0dhenFaSFdP?=
 =?utf-8?B?RXIzajZMTStDNGxYZnpPVXZKUUt0Rldqc3dVcXNVaUsxaEFKQm4zUVFxTlh5?=
 =?utf-8?B?bHlkZkhWc1dpc3hIbHVZTnc0eEVKNmJGYmZNL0gxNSs2SnhsczQ0cGhFQVNu?=
 =?utf-8?Q?amfQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeab8936-33c3-45d3-ff44-08dbc855f4ba
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 23:26:13.0150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LAz0ys7gvcCMcM3wFvxgVESRj5nIW3DuzKuCA+zIX9NGyPxWmBd7c1H9f7EKRmc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/7 02:05, David Sterba wrote:
> On Tue, Oct 03, 2023 at 10:39:18AM +1030, Qu Wenruo wrote:
>> There is a bug report that btrfstune failed to convert to block group
>> tree.
>> The bug report shows some very weird call trace, mostly fail at free
>> space tree code.
> 
> If you mention a bug report please either add a link or describe the key
> details of the report.

Here it is:

https://lore.kernel.org/linux-btrfs/3c93d0b5-a8cb-ebe3-f8d6-76ea6340f23e@gmail.com/

I didn't put it in the first place is, it's really just an inspiration, 
not a concrete bug report.

But for sure, in the future I can also put those inspirational reports 
into "Link:" tag.
> 
>> One of the concern is the failed conversion may be caused by exhausted
>> metadata space.
>> In that case, we're doing quite some metadata operations (one
>> transaction to convert 64 block groups in one go).
>>
>> But for each transaction we have only reserved the metadata for one
>> block group conversion (1 block for extent tree and 1 block for block
>> group tree, this excludes free space and extent tree operations, as they
>> should go global rsv).
>>
>> Although we're not 100% sure about the failed conversion, at least we
>> should handle the metadata reservation correctly, by properly reserve
>> the needed space for the batch, and reduce the batch size just in case
>> there isn't much metadata space left.
> 
> This is probably reasonable.

The change itself is reasonable, but don't be surprised that, 
btrfs-progs has no metadata reservation at all.

It really goes allocate-as-we-can method, until it crashes at some 
critical path, and make the fs unable to be mounted/used by kernel due 
to -ENOSPC.

The extra safenet for a simple metadata rsv check is introduced in this 
patch:

https://lore.kernel.org/linux-btrfs/6081e57fe6f43b3ab44c883814c6a197513c66c0.1696489737.git.wqu@suse.com/

Thanks,
Qu
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Added to devel, thanks.
