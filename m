Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F777D8F24
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 09:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345327AbjJ0HDO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 03:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345189AbjJ0HDN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 03:03:13 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7246F1AA;
        Fri, 27 Oct 2023 00:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLvrL7hT9S2o/21eLMIh5hhOKSo0B/c3pnObhlKaaOYIfqOvDxwCm/Hpbh9qtkYHFBS71hnMB87nHF1WgIBgATT51V5H2l/AfmjbQtGYB+s542bIBm0FpC4k2kLbAMkH3xo3/vKSdChVrjniwyxHUVsPymWU9ECSOojMIqHUhyhYcs+kHeqYX7uSEk4Et1t8E2WG2Jn23fA6g65wW2YisNjQ9uzr17ELOOtc7G1UVY6/hCFZb8DnHjKIBf7RMFZht4YH/5YAcb7BHbRrHFDlf3eipa85vglzfOJX8uXCd17Ll5U1TKBcmrSGj5zyi9VNCHDCaAwwy3JYoWDG89FEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95dSDKqbo16+Bqdn3Fy0kCrtvFObgFphk9w04q2yB1U=;
 b=hjUP+p6ER75rN22NEjfLYjRs0yqawseD92uvZEf/4Y2Iap7tzaNSKnaoVb8bQiTvTQbGdmzcf6zvL2QT9aZlK8LnwG01Nsi3axK6OmCSuY4sMOnFGOhV34sUhC9tzGJaM0H35xFK2QaYmtnKVDXE4cNYS1pFHbRC+gZ8z45fSaZtkuvJCppK9aC8kulP4+wYInNRMU/KqrSPegrUBzj9qkyzPmsnQDjfw7GoFN/I7jxHhEEdbfFwd7AhMdJjfBa/rRbwBvqfsDA6DSYpxP2vz0mD3Jt14mrjbsQrzO3yNLTOGtuGcWNCDzj3SoDLhZ27b9UQHiMM2KZycPZbtsnWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95dSDKqbo16+Bqdn3Fy0kCrtvFObgFphk9w04q2yB1U=;
 b=2/NAZIlRPNTRs4rH5sUtQtae26X5xdq7HB/h++Mn3QmA+ommW5BKer68K4lgptCBOXz/Hz3yNfphkVnVwdHOtN6giIQpNvpFl9Vi3Kf++CjkRCqmQFSyeerFVCB6DSSwO9R5gASw5hhIs+9ys5IEw7ySBxdvjudexTkF8jdNy30lKkLmQFZBhlBxwD3OEU9/g9oxdJe5Cyy6Bpwk7c1hhesw4HlERYU9IgnQJbcKPrmnw4VSqu1nEjtFasJtgBMMVIMXyywTEJ10fbLZJDfk03btrWmS6hkGsG0PUZ+dHL/U6qSJtO6r64t4YeeNO37fNQroF0SUbgBpi8+Pbb/YUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB8941.eurprd04.prod.outlook.com (2603:10a6:102:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Fri, 27 Oct
 2023 07:03:06 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::46d9:6544:503:c37e]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::46d9:6544:503:c37e%4]) with mapi id 15.20.6954.011; Fri, 27 Oct 2023
 07:03:06 +0000
Message-ID: <9fded0b3-bd96-4583-99ce-c2f8c5f24214@suse.com>
Date:   Fri, 27 Oct 2023 17:32:54 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 211/285] btrfs: scrub: fix grouping of read IO
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Sam James <sam@gentoo.org>, gregkh@linuxfoundation.org
Cc:     dsterba@suse.com, patches@lists.linux.dev, stable@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <87fs1x1p93.fsf@gentoo.org>
 <02e8fca0-43bd-ad60-6aec-6bcc74d594ee@applied-asynchrony.com>
 <740c38b1-60eb-41da-93e0-7d7671f0b3fc@suse.com>
 <f5299d83-cff0-df11-9775-f3d0adc5d998@applied-asynchrony.com>
 <b3cbb9a5-20d2-442d-82be-e5c129f4cf12@gmx.com>
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
In-Reply-To: <b3cbb9a5-20d2-442d-82be-e5c129f4cf12@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MEWP282CA0035.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1dc::6) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7edb6f-9d7b-4c3a-1350-08dbd6bac4e6
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dif0xbKtSMj8vuklCAuJuzFaOS25vzVfXWhCP0BWrJweZ1PSK0Tapu1xEKAjEgPjVImNpKyAaaGwQj23bLRYISfb0UuRAdeO88+mdXxdImQyeBB/EDCdXm+RR/WB9tjkJ60rpmd2MS2gaowF5iAx39xI/tm6YbDzoC3KYYeVJZUVHPJ2F7noMvCJJD99hGyWJ3NOyK5EpvK86G19EKFKFBW+d0a5dUoG9w7TvO0UMLJqCzZvkwQG/7orHnwQCSY2/CiXo8Jz6pOKqbI564RvhapsPbvYaPqalAbZu57Q7PwuRIZWLUkrPCv8H9/66btBIcY4bLskmwCt0PdVKnvbL/2hkzV+kc4MLxcypV5F/4QULY4V/72DgMgAcOlhDGVuwHQwW76JABjwQcjywDxBYAbdeHLXh0YKN9VPhtXo4s6Q4oDWyvJAjx/M33lnV1oxOktHU7IPcdcN5X7OCk5/ShLXUDJos/je7BZBthjO9o2QaV1mkf0bOv+cLEbQoQTIIvPivOGQpEdGDh8UE8SmfA62P7X76UXKSupcq3MjRZ5PJr1l1l3q7okcbzvHuM1A/JG/3l0BO9GDfZh00+bz2SOGmE9IrVYvQT9pPbtUwg/tpOz2j0BW6mqtgO8kEhXbH/4zsWe+KixjQ+to/B6Xj3lxEFFFQ982QmiNoOsayevZwjMvkeU7jBgkEVhvvPwH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31696002)(5660300002)(86362001)(41300700001)(316002)(66556008)(66476007)(110136005)(8936002)(8676002)(4326008)(66946007)(4001150100001)(36756003)(2906002)(83380400001)(38100700002)(26005)(66574015)(2616005)(31686004)(478600001)(6486002)(6512007)(6666004)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVpCbTBDMFF4UEl4Q28yOXdSUWdsSmdackZuRFIyQWQ0eDZVSFA0cEVXQTRV?=
 =?utf-8?B?RHBDMTVrODlKaFcwMm9SSVNtazUzbjNmK2MzN3hPWlkvS3dWd0pJNjgvb3Vh?=
 =?utf-8?B?Um81bTBjL3lXbHBldmlhTmR0UTNwWmg5T0YyMGc0L2hhL0ZUK0RJY094UEVh?=
 =?utf-8?B?SjRhdjAvNll5dzFQc3pzM0ZRdWtIOVRCZUtkYWFaWTlIVm5wVXBkU21wMUVU?=
 =?utf-8?B?YVFkZjgzUGRiUjJzUkhmWUhtRDRGdGdlb2J6eFhnSTAzUG5ZY1pSWklJQjJB?=
 =?utf-8?B?WUlYRkhhek9xbEJEUTFRU3p1TzYrRGFBT3FhTnh1c3dyQ1FUdWpyTnJMSjN4?=
 =?utf-8?B?VUMxRi9DZnpTdzBPZlJxTmxLSjBDTEdRbGxaalYrUWZuV2ZYWHcrcGt2K1hT?=
 =?utf-8?B?NEtaQjBsQ3hUUy9kbXlUTC9YRHAxUm9VVGFxb3dKNjRoT0gwNHVoR0dTQ0l1?=
 =?utf-8?B?L0FIVVpLbVRNaEdNVG1FYlVVaThjaUlUNUtkOGljTWVJYSt3ZysyT2RHL1g0?=
 =?utf-8?B?NXdZbWw3dnR5WW1iSGVmajZheG5LYlpYSWJJY3dtN3ovTk1lU0xSMVlma2Vx?=
 =?utf-8?B?TWdxcXh2Yk11TTdaYTZHMjl4N0hPVXhOaGJOd0ZHV0VzQWh0OXlxNmVmNVdZ?=
 =?utf-8?B?Z1lYb1JaYkp0cnJyem5tQWV1c0NHVmZTekNuUUoxT3NSS0taM3h3Z2xxZ2xl?=
 =?utf-8?B?U1hRbXJyU3VPaHNOQUdJZDBja05kUVYyd2JJRzNER2k2bXdlbEFta3duMmU1?=
 =?utf-8?B?UVArK3NoMXpJZUIrQ2JyUlVwUzFkVkVLWXI2VXRlVkdjN0R2YXhUMDdZZW5W?=
 =?utf-8?B?WGJKdmlVL3hNNFNSeW9VRWhzTmdBOU5Hc0N0ZnA5d1doZ3hQVjZuTGc2bGFr?=
 =?utf-8?B?VmxlVUQ4OHIveEp0cm91dUdmMVUrYWpOa1dyR3pFL2dKd1VpWXZ4R1FnajVF?=
 =?utf-8?B?MkFydG96cnlFMHQyZDBKYlY0RXlodkdqV2lHZEl0dUpmbnUrYW9xZzh4OWtx?=
 =?utf-8?B?SzY0U3p3b04wQUZYSDBEM0FUOFFmQzlzT2NYUkF5Z2VJQkU2TzVBYVR5R1Yv?=
 =?utf-8?B?NXJTdVZweVJzbzcxVHBNVERpNHhpM1g2UDFDZ3FNek4vM0Fzb0pzVGcrSnpV?=
 =?utf-8?B?WStGdjY1TU9DWi9sM2pub0hZWSs2c0x3TnM3VmNKTVJJVEllYmo4MndDL1Q5?=
 =?utf-8?B?aHpDbkx6TjBicGFmMzdBKzZWeDVySktSY1RLQlo3cmRFUXRGdFFMMU1oV1RL?=
 =?utf-8?B?djBIYXdjWU82VHJwbERRSjVXeFVZQkJVc0JvUExJUVB4RmJzRkZETjE0THJK?=
 =?utf-8?B?OTFna0JJQWN5cW9yNWsreG8xNFBMaytLd3Z5VCtaSStmR3hSUHpvN2dyalhU?=
 =?utf-8?B?dkdBT1U2SHpMS3UwdTRwUkRYQnkyRzl2VitDK0EvdGtaNVJBUDh1SmlpN0dB?=
 =?utf-8?B?UzBzd3M4aDFVOVRSZzU5NFJndk9vRGFuRWs2ckU5NGtjUWlvOXFscEswemhL?=
 =?utf-8?B?ZEFFY1ZzT1RvYkpxNEpISVY2WWMraEdTbEJyUzBaWU1WWFlBUTkxcHY3dU1N?=
 =?utf-8?B?ejhaYTZQbm1hYnZqaVNiWGFJRExGRlFoOXJFNXpSY0xOcVNNTmFSUWNNN2NK?=
 =?utf-8?B?eUwxRzRiMkhMd0ZuWG51K0xzMzdSeEdManhDUVAybVRvbWxiWTBCR0paMzZ4?=
 =?utf-8?B?K3JFSzJJa3VhQytmYy94OU5FUm5DRStpWVFseXJrRHhPSFRNV1c4clhXSGVp?=
 =?utf-8?B?NUg5ell1WEUvVHhjK2NxRWl0a3k5MWRuN3Q0YnJlemNEZmFzVlhSbjYwYUh0?=
 =?utf-8?B?Q2hTUzAyTkVMTS9pWHJ1WGJxVmhmRk9QV3ZaVU96OHprSzFTNVlFSk5JdW4z?=
 =?utf-8?B?MEFUendhSFpLbGt1YUxVNHNPSVBrZTkrc0l1VVJFMi9WbkhwOVIybFRZMjVG?=
 =?utf-8?B?ekpLbmJoaE52UnU4VlZzNXRSdGhBUWYwOGIzYVVnaElqclcxWkV3clpnUmVt?=
 =?utf-8?B?a0tNTFlCL0xtRjdBRmtKYndYb1lLMWNiaUFQUDg5ZnNPYlF4RUtraFBWb1Nu?=
 =?utf-8?B?UkY0R1p1RGdwNjhyRnZ3UFlvUTVvcFJnaitMWUlqQVgxbnVsRWZIM3JzQU9C?=
 =?utf-8?Q?Mdcg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7edb6f-9d7b-4c3a-1350-08dbd6bac4e6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:03:06.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QoGOi335Vg06pDhCxtxfTDDXm2/rHjz0Yyr18gjW3KsVYiD7vyZQz66+h8MScmD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8941
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/27 17:30, Qu Wenruo wrote:
> 
> 
> On 2023/10/27 17:25, Holger Hoffstätte wrote:
>> On 2023-10-26 23:01, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/10/27 00:30, Holger Hoffstätte wrote:
>>>> On 2023-10-26 15:31, Sam James wrote:
>>>>> 'btrfs: scrub: fix grouping of read IO' seems to intorduce a
>>>>> -Wmaybe-uninitialized warning (which becomes fatal with the kernel's
>>>>> passed -Werror=...) with 6.5.9:
>>>>>
>>>>> ```
>>>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c: In function ‘scrub_simple_mirror.isra’:
>>>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2075:29: error: ‘found_logical’ may be used uninitialized [-Werror=maybe-uninitialized[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized]]
>>>>>   2075 |                 cur_logical = found_logical +
>>>>> BTRFS_STRIPE_LEN;
>>>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2040:21: note: ‘found_logical’ was declared here
>>>>>   2040 |                 u64 found_logical;
>>>>>        |                     ^~~~~~~~~~~~~
>>>>> ```
>>>>
>>>> Good find! found_logical is passed by reference to
>>>> queue_scrub_stripe(..) (inlined)
>>>> where it is used without ever being set:
>>>>
>>>> ...
>>>>      /* Either >0 as no more extents or <0 for error. */
>>>>      if (ret)
>>>>          return ret;
>>>>      if (found_logical_ret)
>>>>          *found_logical_ret = stripe->logical;
>>>>      sctx->cur_stripe++;
>>>> ...
>>>>
>>>> Something is missing here, and somehow I don't think it's just the
>>>> top-level
>>>> initialisation of found_logical.
>>>
>>> This looks like a false alert for me.
>>>
>>> @found_logical is intentionally uninitialized to catch any
>>> uninitialized usage by compiler.
>>>
>>> It would be set by queue_scrub_stripe() when there is any stripe found.
>>
>> Can you show me where the reference is set before the quoted if block?
> 
> Sure.
> 
> Firstly inside queue_scrub_stripe():
> 
> ```
>          ret = scrub_find_fill_first_stripe(bg, &sctx->extent_path,
>                                             &sctx->csum_path, dev, 
> physical,
>                                             mirror_num, logical, length,
> stripe);
>          /* Either >0 as no more extents or <0 for error. */
>          if (ret)
>                  return ret;
>          if (found_logical_ret)
>                  *found_logical_ret = stripe->logical;
> ```
> 
> In this case, we would only set @found_logical_ret to the found stripe's
> logical.
> 
> Either we got ret > 0, meaning no more extent in the chunk, or we got
> some critical error.

Sorry, missing the latter part of the sentence:

   In either case, the caller would handle it.

> 
> Then back to scrub_simple_mirrors():
> 
> ```
>                  ret = queue_scrub_stripe(sctx, bg, device, mirror_num,
>                                           cur_logical, logical_end -
> cur_logical,
>                                           cur_physical, &found_logical);
>                  if (ret > 0) {
>                          /* No more extent, just update the accounting */
>                          sctx->stat.last_physical = physical +
> logical_length;
>                          ret = 0;
>                          break;
>                  }
>                  if (ret < 0)
>                          break;
> 
>                  cur_logical = found_logical + BTRFS_STRIPE_LEN;
> ```
> 
> We got to the if block I mentioned.
> 
> Either we got ret != 0, then we would break out the whole loop of
> scrub_simple_mirror().
> Or we got ret == 0, which would initialize @found_logical.
> 
> Thanks,
> Qu
> 
> 
>> The warning happens because according to the compiler this is exactly
>> not what's
>> happening, and I did not see any initializing write either.
>>
>> thanks,
>> Holger
