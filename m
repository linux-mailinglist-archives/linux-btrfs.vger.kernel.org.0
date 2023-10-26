Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCA67D89F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Oct 2023 23:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjJZVCG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Oct 2023 17:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZVCE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Oct 2023 17:02:04 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66041A6;
        Thu, 26 Oct 2023 14:02:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QV5RzHOszi8t1lRec0N6nWGrmNiy3m2pGf3jOn1hfhF3VuCMQthbWNOMlsCuvMHO/YXQBcmAziUbqDfh8beMbq23AvlF7zVRLoFp/NFFIQ32/vpYePwU6LYJwDrteM6ZkZiNB9BHF5k2BXP8dZJmyHVkY+4Tjmloxo5vQSwBPklrGuKzHu7EdJGy1vfiJc4tMQv/Hih+7vTqNMamEBPjOyR1Vv1ghd+FhRuq3Kz9nq7bY/z1uLjKVGraznfeMYev5nROLI5t1EMyUQQOLl/PfMpZ6Nztvn6l7vu4WrTaFxW9SsKlwbWt7FCectjSYfkaHItgmZHNgIK1/oV//oT9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJzq/+QeKioGz6goUKHWYAPKhYBR6sOMSrqMqFOSkCo=;
 b=oSehuxfZv/kDQxgn44V/8Xez8VPeqpDtA/oVNc3DpPckUE3KeupT/ujvjKdmrG3xaN0QahjfxZYUU/Fpn64RMAGvagna5kORqogGNPoZvEbozAPs5LPMa714iFHtmRCTGQsn4UQrVT7IOHUa/vLaBWXYq0C3qwwNEwUkfZl1O28qUXPhDF2Np1yy5LyUy+/qVN35UJKwow4CR/SOnyLdWRysilWtGzEvxGIkyGKSPt9ZqZhCO+muRR8BbmHrH+BEVlJzDVFSsdI8mTDSRHzkw1eLEQg885tcKdENHjQZGPCSqO0upM6Fh+wkvBN4XYn+b+zqzBSfhFbgOYjI2X37Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJzq/+QeKioGz6goUKHWYAPKhYBR6sOMSrqMqFOSkCo=;
 b=S8SQIOOefmZpBgBjFMEnFty+uAlq3FvMtRAE4jqdZXjhvwi8HPED0TmvM4qpngAlL2F2d4wWN61y25IqiYnO+qDYMqYto47dyQKJTOVGM5FlxqigYjg0kEsOW3wj5O/IgLqsJgk3OXQEDanVQfcPHEHUbY/blHUqDpSB38HMPwt0sNjudI96lZK4Q5RgL7kuHxgqpKjnyPxec0usPSJyb0vzulGAGYqkKYYW603sx7KouCocmTZeMl90eceigonP8MEBFu2Zl4EeIopOQ4T9Eb3qtn4bl2rsNNh5C711xtbXH+F3jHtlJpepMdpUVFO040a0Kc/cpIpVkJUiQfoXpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM0PR04MB7186.eurprd04.prod.outlook.com (2603:10a6:208:193::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Thu, 26 Oct
 2023 21:01:58 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::46d9:6544:503:c37e]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::46d9:6544:503:c37e%4]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 21:01:58 +0000
Message-ID: <740c38b1-60eb-41da-93e0-7d7671f0b3fc@suse.com>
Date:   Fri, 27 Oct 2023 07:31:42 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 211/285] btrfs: scrub: fix grouping of read IO
To:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Sam James <sam@gentoo.org>, gregkh@linuxfoundation.org
Cc:     dsterba@suse.com, patches@lists.linux.dev, stable@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <87fs1x1p93.fsf@gentoo.org>
 <02e8fca0-43bd-ad60-6aec-6bcc74d594ee@applied-asynchrony.com>
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
In-Reply-To: <02e8fca0-43bd-ad60-6aec-6bcc74d594ee@applied-asynchrony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MEWP282CA0139.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d5::19) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM0PR04MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: ddcd21bf-da40-4c63-e490-08dbd666cace
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u54PqfGiXmApkwXpWTVSA8ymlDkxGTxXXQIi2cFYvgPYzQy/2gplgtikjV3KDURDjccMrpwij4O8GB37uMvYJtP5Nz2bmubWZpTja+6IJHeVw0qoli+Q3QF2uJ+eaokN/hKbs9WgqoF9CcWowDmbK/auKD/glR7z2x/+ih4tBy/cWWvOwV0ZDErlKLZSXkEJlsjkMpVY+2tz8l8ZRfV4be+FZnaQk05ZzHHKNJpIz+9ehYgonFWIjRERzglIjY6o4VqFTPPEqPla2fhftWCjAF22ygD7XQfszfCu1Hs1PD1F3rbdfgC34WCZcSijzJttmdL9AUmBnYjVKb77xAFquhkg+SCy0+DObYS1pi9IzQpDicOtnH7JNWCFVD1oyW652Oqqs3haL2kZ/ZBtSr1GiANZYdPrGLWJgCOIeqSkv2DkNTqLsX+ex9qvJV4k0R6MDWn7xst/bYf2QmhAjRyveGKHONVQHpngqN2b6OJV1tnXu2qHe6hQavw7DYEA2fFkZ0Ow0tx721l2uBVynXi/5Mc7LXcQS7pXhGAXeRZZRkUtHo8Bp6MfH7D0qY8aYRDlKz9QUj4W1EHjrGlu4ZA+eyXovcParP/ZtfA9alZdQTtg96R3mmpgQs1XytcnEM21Qe+Yvl2hdp4uOa6l6ns6rf0D75HbspRCbvCvygs0V69eodaC47QOIpnOOgRmcH0v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(31696002)(86362001)(6486002)(6512007)(110136005)(41300700001)(66476007)(66946007)(66556008)(316002)(478600001)(6506007)(5660300002)(6666004)(4326008)(4001150100001)(8676002)(38100700002)(36756003)(53546011)(2906002)(8936002)(26005)(2616005)(66574015)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVVqSFAxTkVralppUk9wMmQ0OFNSZ3lsb0RSWnkxMjZCRExVZFVvc3pEcy96?=
 =?utf-8?B?R3JDb3prSXVjZThoSUNaem9rYUpNcVo2MVJpeUxoM3hwZ2drNFlHTnJEU1pn?=
 =?utf-8?B?WWxKdXlUeHJxREUrejF1ZkY2SXVvMFNjQks2RTZ2cVF3ckV4enRmN1hYMmU4?=
 =?utf-8?B?cEhNMDc2U1BpT2tEYWU4RGRCV3AyaWdNWG9Jd1ZkMlBNSzNRWnI0OGIyN3VU?=
 =?utf-8?B?K1JqdXNSSzB5Vk1qcjRVQ2l1RzhHaklmSDZlRTMwVFo0M054WVhvcnQva1Ux?=
 =?utf-8?B?MFZHdm1sWjZxcjVmTnRkdEpnVDRJenZEc0p2NkcvaFNsUUo4M2JudEExYmp2?=
 =?utf-8?B?dDJiZW5Ma1FuNVRpTTRMSitpL1ROYWRUSHVMTzZ4b0FZYWo2ZW0xQ0c0YkN2?=
 =?utf-8?B?RkZreVh1N2NpbnF0TUhrSHg4c0xrVStudGNuNDUrWWlJMU91RHhBTEZRUC9Y?=
 =?utf-8?B?eGpBRnV0RHlpc2YyWXlKZnk1Tk1mcWZZWVNxclgvcWtYREFGaStabXVTK3Nu?=
 =?utf-8?B?a0FqNytrREk4akkxb1pKK05yRFI4cFp6L09CQUh6RzFmSWtvdjJkME1QUFho?=
 =?utf-8?B?TjdzZ0dJdDdKRStlWkJnNk1MbGdyWm8reHhhbk5JYzdLYU14OGJ4ZCtjUG9J?=
 =?utf-8?B?V1hLSVhpR002MXl2ZUNRT29yeFBWOHk4TktTd0o1OVNEaUNML3B4ZllkM2FR?=
 =?utf-8?B?TkJUcFVjOFhrNSs0MGErWE5hYklVZVkzbWhiYkVUcVhHcnkra1dmTVBWTTQ2?=
 =?utf-8?B?c1M5N0ZzNWZjOEVlZStYWmh0T3YzdGhBNEtHVThuRE9BRDFQMURJZDh2L0E2?=
 =?utf-8?B?dG54bHIvRC9JK3FwdVdWc0xIQjY1S2VoTThoOE04akN1MnNyeUZrSkhZTVMx?=
 =?utf-8?B?UXE4akp6UVFEcTZmZkZFeVFmbHkrTHRrUjFocDlnZGwxRWtNM0Y2RTA0Sk56?=
 =?utf-8?B?ZTR2aEw1a01uQUo3bEVEcDNqQ3JvcElocjNwMjRoN1ZXcXZOSklYSk1KemZ0?=
 =?utf-8?B?UHBhVFZMelVra1BrQzhOdlhLVHE4TndTZXRsUEp0WFVuUThla0VSNC9qRjNQ?=
 =?utf-8?B?UU41eWtEN0FQbFM5NlBDNXpTRU5zY1liL2xsWjhjSXpSSU1QU2pENFZhSlYv?=
 =?utf-8?B?bG5xeE9rSHhod2RoY2xlak0vWFdTREhDYlZGUUQrNE84aG1ENFBHQk9hU1N0?=
 =?utf-8?B?OHRaU3NESVhuVUFIR0RYU20zV28yWHF4c1hRYjM3TmdsQmZqVTArYWJ4dWM3?=
 =?utf-8?B?bDA3b0NtWGFRUFZaSDZlSG1tNWtrZkw2YXZIdjAyT0ZucmpHTERUWFFlWmtX?=
 =?utf-8?B?eEgzOGZvOCthMFRIdHVpV1JGM1lFWkpJTlNVUjZ4bjU1TFozUHdhWjdmMlg4?=
 =?utf-8?B?eE5LWTJla2o5eUlnRnNjQTl1UHU5bFhmSnFoSHc2QnJDZjcvWHhmaElOdlVm?=
 =?utf-8?B?Q0dTd3prZGRUWUNJV01ZcllQVDV4cDczbzZoUDhXclozVkhWaHhFdVVQZnZM?=
 =?utf-8?B?bW9OdkJwVFRoYnhTT2g2RTFYSndUdVkxb2tqRXlHTGhGNXF5alRDajV3a01X?=
 =?utf-8?B?UDRXaHQvaWtWNU85SkdpeVJ0UW1VQVA3ZjBpZ0c3RUtHT2l5M0o5MTdOcjZK?=
 =?utf-8?B?OWEvNHR6L2d2N3lxcGdGTzNNN2Y5ZDY3OG5OK0w5V0ovMWkrVmhmZVR3aTUw?=
 =?utf-8?B?VkNReHBacGpWdWlGQm9ockkyeHJMVTZseVBpUHQraU5nRzNnWmpGcEJTR3pV?=
 =?utf-8?B?UEZtTDRLQk1JYjFWajF0eGtUd1JVUXdTdjZoZnhlSFhsbHZUT1Iwek9rWUE0?=
 =?utf-8?B?ZmxRdHg1NzNEalJDOFE4YmQzQld2M1dnanFoOEhrclVGbUgrckF3VGVleTNV?=
 =?utf-8?B?SzhWTGVsSVNMYnhGUWRIaWpqZE8rd2pMK0NqbVRNSEdvbFpqMjlFdS9LVE5C?=
 =?utf-8?B?Umw2T2lzK0tkbGx5azdlRW1XdzgyemZ1NzlOR0tVVGkvaDNMQVgzWUJPeHVT?=
 =?utf-8?B?cGRSalhRTXV1ZENGeVk3VC9VSll4YTBDaEpoYnlvVjVkL3gxV0Z4TUdQZTQ2?=
 =?utf-8?B?bXJEa0hLZVpYWXFpcTNRc09lVkRhTHRPUUp3cmJFb0N1Y09YVnRnaXlvbjN6?=
 =?utf-8?Q?385Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcd21bf-da40-4c63-e490-08dbd666cace
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 21:01:58.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1syBj6ISOidVON07+4Z5R61v5eNB7JorN5PMWPAOMuLcMb+HwyDWEZAXas0JURKI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/27 00:30, Holger Hoffstätte wrote:
> On 2023-10-26 15:31, Sam James wrote:
>> 'btrfs: scrub: fix grouping of read IO' seems to intorduce a
>> -Wmaybe-uninitialized warning (which becomes fatal with the kernel's
>> passed -Werror=...) with 6.5.9:
>>
>> ```
>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c: In function ‘scrub_simple_mirror.isra’:
>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2075:29: error: ‘found_logical’ may be used uninitialized [-Werror=maybe-uninitialized[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized]]
>>   2075 |                 cur_logical = found_logical + BTRFS_STRIPE_LEN;
>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2040:21: note: ‘found_logical’ was declared here
>>   2040 |                 u64 found_logical;
>>        |                     ^~~~~~~~~~~~~
>> ```
> 
> Good find! found_logical is passed by reference to 
> queue_scrub_stripe(..) (inlined)
> where it is used without ever being set:
> 
> ...
>      /* Either >0 as no more extents or <0 for error. */
>      if (ret)
>          return ret;
>      if (found_logical_ret)
>          *found_logical_ret = stripe->logical;
>      sctx->cur_stripe++;
> ...
> 
> Something is missing here, and somehow I don't think it's just the 
> top-level
> initialisation of found_logical.

This looks like a false alert for me.

@found_logical is intentionally uninitialized to catch any uninitialized 
usage by compiler.

It would be set by queue_scrub_stripe() when there is any stripe found.

If there is no stripe found, queue_scrub_stripe() would return >0, then 
we know there is no more extent and break the loop.
If there is any error, we error out too, thus no problem with that.

So to me this looks like a false alert.

Mind to share the compiler and its version?

Thanks,
Qu
> 
> -h
