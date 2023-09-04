Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585B9790FE8
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Sep 2023 04:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245672AbjIDCIK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Sep 2023 22:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjIDCIK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Sep 2023 22:08:10 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80062BF
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Sep 2023 19:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZNFAttzHU0pADac9KLy1ps4BViplnLVdldufX6PV8T8YU78kp0aNqFiZM/ohYa5NFJbTrynTAxUS6Xe++v8AiqNbFoBwppN7c9nZJyp87GYtddsd2C37XWyGlOvdNytEVdDNGe0cS1bWMRpdyh5fKGdtvRlvfqEobtHQcsonBoUwQqHjPpPfpodwOsF8cAXKzBdMZWotPLqfC2cxPIPed5je7CjaT2Bx8E5qvZL3YK1yfW00YEeP4FYSNb+hMmbXDQ7MLvHLxaBEeSSvY0hd5nh28PiuaYVp6fQ4Vr7khiSvXimre7Km1SgGbpWEv1ceKXt1kdcCUmWwc8UUzFwfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxw8CyAL/3Wpi6OdKz+SVa1b8jlewK+9mByvndJlGG0=;
 b=EFnX8fc1mZtcO/K3NroT3Rdr+K42m0/vyuebdkPubSDyxSYjW4LU3zZOPr12g/aOYJzh2Z6us9j4AgqQMw7xU+dII9fh6TtkthDaJ+eNMA8t3PcVEN5FxCszTTk+uEycZ5QMPPmRG1ESx61G4zVj4B4NAiUgtSHCZzlmAOpjnlpnsEzhAVge8nv0bBXTs+qnjNqedsJQXvOBH1KU5WBy4CJdyOu7e3GnW3BgDW+ZkkWb1mAhNoNZAA1c6snxseGZh6tyl0q6T6cYP2gcZK0oudbkl6iZC19edHNR3s1GJFtHJ6a2wIIL8CYIleLoSEqDprzO6Oj9HUhPvm+7cjbR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxw8CyAL/3Wpi6OdKz+SVa1b8jlewK+9mByvndJlGG0=;
 b=abUE75btf7Cm2810KSnyfLBvPeHHQe0c1ccp4x49IeJK3a/JYPuNMsrenR4dyZfmn/dD3CzvnZBsIQPRJsuCjMHcl1BqANw7BCN7GcuTUbE3ZxhtvOM9jLkLYmG5i5ZxHjUgGrZrfjKWiboKfyvvXieaVu0yOr6R84JFqVGsJeeZeShsa8Ys5kgxZ5BdrfrTf+eAPPDgRt3jem0gk+58GdwLA8c++TvseB3VVIfMorNZUAJhKUisdviXyvhNR3tS67SFamweswimNuOAtCpxubc4AgQJbht8R4wgrCyl+FnyVUMHolWaMvvGBMxl7WFaPckeqtfLCCuVW3TQF467lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 02:08:00 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 02:08:00 +0000
Message-ID: <8935f5ee-4b6d-4813-b13e-b19424214e42@suse.com>
Date:   Mon, 4 Sep 2023 10:07:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Troubleshooting - Extent errors in check
Content-Language: en-US
To:     COCK MAN <cockmanp5@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAKoLycDQax+Cr51mHb4gMBfqWgrhKhyyObOKC01thq50q9+3Qg@mail.gmail.com>
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
In-Reply-To: <CAKoLycDQax+Cr51mHb4gMBfqWgrhKhyyObOKC01thq50q9+3Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 948b9c65-dab1-49ae-d2bc-08dbacebc3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6w6iYCthoUzDsIWssYk4CaMIYmZiA6edH07gk3pZ+82m33epsWKKeiRIwaBFg4OXhfQs5fefAEDndXK7NrQpeUOaNxLmOkmBtbia44k9Em/t9Qk5YOSqdUCPmDBf71qosqQONZeh0e4t/cZjXdMZefOIvbyqlIeXbIaJ8YPndY+ixZIy1Zc50f99u36gEkRwxPHL66fujCYJpAQaaf75qpJ7zP2XM7nhMuWxHBX89EZm8/aDehSLw3sbh9wUMgyeaUSUE4CHoRHFfDmhViPc2/HoGDxeX2UjWW2hvKqlK14G6ucEHuTQeqDqlxHTfUh/iQZER0DufxDlMYnYOICeBqlw+jSZAUMb4Ii904KKgbaIkS4JdGci7dPrClbumWHNAeaq2wy6we4sh2bXWl2mHrZ0iLvIqjJ0kE4lHExjWJPAIxeanmhDTVAMUl2GmZz+JIsUNqymJu4aWDrFcPYSAGS9quqPrFumXP9j+lljz+C2FGW4Hx+/cT8awGx2bBA4yID8VMcLPskaGu5DTlgoHU8jy8B85630CiAWj5JKgdTH4Ru6pPI8CJ5HqIufQKPMp6LhimTq+zuPfdMbxODUB/8+3XCbLgFUsZ6vRBgtDnC3gB357kCo68gOuA+XtHmuV0fOLk4qDsgpmMcDj7EqjsBn1nEcSmOHdV7xShpybEBQauNe1DUxaUQklzLNF//
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199024)(1800799009)(186009)(4744005)(8936002)(41300700001)(83380400001)(478600001)(6666004)(2906002)(66946007)(5660300002)(8676002)(31686004)(66476007)(66556008)(316002)(6512007)(53546011)(2616005)(6506007)(6486002)(36756003)(38100700002)(31696002)(86362001)(43740500002)(45980500001)(55214018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzJnSmdXMC91UTRFT2pxMlZBcFRBYVlRYU1oV0svNHMwWjhoa0p2UVBxYmI4?=
 =?utf-8?B?aHIyc1ZzRDRjZ1pQRDZ6czNCVnBqcmJNQTZHbTNoOTVvYlFwT20yZG1MaGd6?=
 =?utf-8?B?SjFtUE1YRkQvc3hyZFNtcElRNTVRR3c0MzJqSVpVdC9ZWjdmbGx2VmJaRWFI?=
 =?utf-8?B?WGRDV1BsRmozcVhCR0haZTdDZHFxd2FhWlAwQVpuRU4reVoxV2cvMWVYa3JX?=
 =?utf-8?B?UGhtcnBkeEhXR1RldDFxZDZmOFBmeWM0Q1A5eXd3UUhpM2NhYldVRmdDR3Qy?=
 =?utf-8?B?RXc2cWlHUjRaKzBBeTdQTWhIUDlhODAwMG1rSysrak5pMVVzQ00wWjErdGtN?=
 =?utf-8?B?TGhBenJBb1d3MkdHMHVwSG96ckIvUXlQbUV4enc3WEkxUHk1Y1FueVc4cGtX?=
 =?utf-8?B?c3JnODFIZFQ0VmhTeDJ1NVFSODMvUXlrbU5vYnJ0a21ueHJGRGxQUnFaSVI2?=
 =?utf-8?B?VU9hR2xGQjNLMDJRalhaM1JTQ2JFcXZnUVJkRWNNdldCSmk5T1prbGdKNDF6?=
 =?utf-8?B?OVN5NE1wZEdLcmFZM1RYRlZIb0h2aGJUWi9QeFNaeVhKeVViL1JSWnNSOWJV?=
 =?utf-8?B?RXRRWDIwRHNDakREYUlyYUdvQ2gvZkJKVFJ0OUlHM1pKVjBWL1NQSVdxazc0?=
 =?utf-8?B?d0lCUXRKc3M2YXRyWFdIR3FicktITTd5Sm1zekR4ZllnenRCTFlhdHlXVi92?=
 =?utf-8?B?Y01TRUdRYVEzOHJJUVo3NzF4b1lFRlQ0WEV3ZlE5T3FacEhCbUVZbXZUMmRO?=
 =?utf-8?B?YkYwWUhuWW4zYk5qT2RVbkJXZmsvaGJvb0dTWmxtWURSTXdFa1phdzZPbUdT?=
 =?utf-8?B?VWY1NFd6NjVYamNiN1VZclhWNTBRVCtPbGRycmFjMDdoZU1vbGNwSjROOVpN?=
 =?utf-8?B?V1pOeFJxUkIzeWt3ZGFYRHd3WXp0bjB4cEZUMGFhRkl1TkJSbkh2WTBWRVF3?=
 =?utf-8?B?d0FzKzhJelE3bmY2ZFdUeVpKR3FtOWw4NEo5UFRUS3VYZWlieDZiYjRIeFo4?=
 =?utf-8?B?Sks0VmE4elBJOGNrajdWS3BFUGM3YXl6Y2wvVkd3bVk0TjQrOFM2NFlCSU5s?=
 =?utf-8?B?Ynkwb1l1aTR6clVkRGlVelN0NlN6aFRMWGN5MGVtQS9UOE55M0Jqajk0bEpC?=
 =?utf-8?B?R05ZQUtlNDYrOE12N0Q4V2F1K3pyVXlQWExiSjF6SEZyRytYdnhZYmZXaDdE?=
 =?utf-8?B?eUlyOG00S3d6QTR3a0lMZG42eHlmMmNEVllDZWdFRFJEYnlmejY5Q08wcVBF?=
 =?utf-8?B?cWt1K0U5TDY0aGQ3czJnT21oTlExOUcwNHdoSTNpSHVMclYxc2s2WGx4Z1Z1?=
 =?utf-8?B?anJYN2dtZ2dSbDkrV01UZW9MTVFDOThxZXRGa1Jyd2x0K1hCOU9CNFM4MWdW?=
 =?utf-8?B?MXluQmpFeXNiMnkzNXFNMkZwc1hTeGloaTdNUWEyaHF5SHNvYy9nUFAxdTgz?=
 =?utf-8?B?RFNuMEZCR21rN2tncEtvT2Yvd1RhY3VicSszNUwvaXJZYVJobS9SNUJMNDVR?=
 =?utf-8?B?MXpERmRlNmQrZFloc1I0Y2ljdDV2cUZscjBuNzlkUUlHUEVZZDRMR1puVTVH?=
 =?utf-8?B?TFRCOVRnNHVxNm5iUWo0S1J6Qkg3emxBSEh5YTRQbTcxSE03V1NhL0RYNEFW?=
 =?utf-8?B?RC9QRSs2RnFrODU2emVZbWRPZlJpNVQzaGU5RnhMM2kxd1l5MmU2bi8reTFX?=
 =?utf-8?B?LzBaKzZadllOK09yRGpLSWV5Vm9kSi81TGwvY256REtvSlF5T05tUEZYaytl?=
 =?utf-8?B?czZaK1hLemdMUWVSWmliVUxQOUV1STdwS0Z1YlBxQVBBWDVBNGFMY2tuS2pP?=
 =?utf-8?B?K1hFOU1zd2lhREpNSm11M2l6VVV3cWtUMm1EUTZUcjhkVG1UbHBjSzRmT3BO?=
 =?utf-8?B?UmtSUVRGNG9Jb3VyeUNiTHBrL1pRVFRJNDZwSlVob2NBdHYyY0dzVnFkTzBC?=
 =?utf-8?B?RnBEYjMwOGtMRCtwbTd2b054NEtPbnN1TFBMdnROQ1grUWM1MGttRVIzNWIx?=
 =?utf-8?B?NTVyeEFHbWF3enphUHVMNDhWSXNSZXNDNWF6cEtOWHdyOXRaLzJ2RXk4NXRh?=
 =?utf-8?B?bURXaEFHTFFpb0F5aGJpaWNIczlDUHpkbXdKVTkrMU4zOWM5a0pOQUl3ZFRh?=
 =?utf-8?Q?EyQxvyhyggIuf4aG8v8kiEPtJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948b9c65-dab1-49ae-d2bc-08dbacebc3a1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 02:08:00.3797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcQZmzv7EgHs+fBYwFnBIZ9b9RprTO/yHBIOnwECu4Yu4cCzQWRWxrqSLAIUiAdl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/2 20:34, COCK MAN wrote:
> My hard drive out of nowhere has been going read only after a bit of
> write activity, and I'm unsure what to do next. I've attached a file
> containing the outputs of "uname -a", "btrfs --version", "btrfs fi df"
> on my drive, and the results of "btrfs check" (unmounted, no repair).
> Let me know if anything else is required (dmesg, for example, which
> would've taken me over the size limit).

The check output is showing that a lot (most) of block groups are having 
more used space than it should.
This is mostly fine, except some space may be wasted.

I assume btrfs check --repair can repair it, but I strongly recommend to 
backup your data first, before trying --repair.

The main concern is, there are too many block groups need to be 
repaired, this itself can be a problem.

Thanks,
Qu
