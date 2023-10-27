Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB4E7D906B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 09:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjJ0H50 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 03:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0H5Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 03:57:24 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2041.outbound.protection.outlook.com [40.107.13.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4691D196;
        Fri, 27 Oct 2023 00:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA90YyHtagMW48HGIFjlhPJ9Zi9u0AZbovqlMG/FueVG9NHJBIJX0jtbv6sCbSqWZuN2LEeMThtn9+E7t/Fro2gglxMBF0niSOzkQfWySVm8l/74UHn9SEaDvkLHvMmA9xvWCBVsRSXsHFpisLIKQ7Qcx+YQyKYYggx/yIBIqw5PJfhCjM2iMzggNHChlFX30wHywFEL9Z9yWQw72GQgG5TvxwluZmow7b71x3H/3Aw5jIyk5Np2DuMMJyBveX1peKYSweHddF/Qlfm4lHoCj5aCpGWckHt03g6W3F8PfpfE0B6irpgU5RLuUfpmKLXpGXkHXgFhdt+Ezj+w65VIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb8YfTuLi4+oJa5TkpctWjAE5Eg1Z8C8pOQnatM+DxE=;
 b=JC8WeJg7tr7nRmZ0iLyztk21jsx2kFdzUKU2wRflbBLD0Sl7MR9GOTItukze/mGWuiqhWXIClSxqDXGDL3CCXbK7V5nwTv1uuO40ucKd+dst7f+fWqgwVgxrBN9tJqd19/VY8sMl/rnVPfkFwA+M6gDwEHUUzm18rSgT3dvcXigLd745BlbdODCu+c9ZPCb5DGGb/82vjTdPMR3zEfA5skXamRrw8FhieTMfDSnI+xytLW6QiTA1dbvhXCX4pQ9EVRcuM8aKt/gliTNAAam9iscBhZJqHgnVrnIXsiJ0hIMGLBF0lSka208MNJ99p8RxDilQwo6wj7x0rbHixWbZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb8YfTuLi4+oJa5TkpctWjAE5Eg1Z8C8pOQnatM+DxE=;
 b=Oq6dzKvnw8dIgbjF7hMOavI+sirQmrtFWtAZHIIfH4qnFG2DBvgYA3+yOibXssxJ/yrkpFt1zl64hr8K8Md5zk1EFEZzz1rq282hWOe5ARRK/hlnK80IgtZWLDsCsVcN2gNdx06HHf8njhQfLxwhTW8/wFyMQI32XZ564T+E65vNXihS1loXOhj/X2zM8gucirA7cusi+PB/j9V7ohdSb4KVgLWHRBVdpQ7tpCAb6PMtnhbbRENCISQ1wB4GqOjc4k94rpcpa1GiBs8MP6JcZcItYPyo0my6qX4kKESBNtaTapFI31mui+4eYpAz4y7ddud1dSYSZdmWYxX2XKGZZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB8PR04MB6859.eurprd04.prod.outlook.com (2603:10a6:10:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Fri, 27 Oct
 2023 07:57:17 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::46d9:6544:503:c37e]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::46d9:6544:503:c37e%4]) with mapi id 15.20.6954.011; Fri, 27 Oct 2023
 07:57:16 +0000
Message-ID: <00a883fa-bee2-4671-8d1e-4e1a7c8ad105@suse.com>
Date:   Fri, 27 Oct 2023 18:27:06 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 211/285] btrfs: scrub: fix grouping of read IO
Content-Language: en-US
To:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Sam James <sam@gentoo.org>,
        gregkh@linuxfoundation.org
Cc:     dsterba@suse.com, patches@lists.linux.dev, stable@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <87fs1x1p93.fsf@gentoo.org>
 <02e8fca0-43bd-ad60-6aec-6bcc74d594ee@applied-asynchrony.com>
 <740c38b1-60eb-41da-93e0-7d7671f0b3fc@suse.com>
 <f5299d83-cff0-df11-9775-f3d0adc5d998@applied-asynchrony.com>
 <b3cbb9a5-20d2-442d-82be-e5c129f4cf12@gmx.com>
 <8b80b5bc-d782-1f56-8ba2-89b33a5dbfec@applied-asynchrony.com>
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
In-Reply-To: <8b80b5bc-d782-1f56-8ba2-89b33a5dbfec@applied-asynchrony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ME3P282CA0061.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:f3::12) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB8PR04MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e66deb3-b9e2-4a69-7123-08dbd6c2567d
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11ETLgtEpMql/toQM6r06LrinPZLCXyE08Yh5y+74WztGgKSIU9f6tFJpWD6I9+YznP6e5I+Y2DSsye/BIKQ56NG5lDrqcm8jd24MK3pKtjM65BXWjkAcIk0XN391C2gmcr3RYKgHkU+c71oToZ2A43KrSjMAGa+QO4uMkEbSw94i2nU1h1VhIbvDWTioTuwLgh6Ft8GFvHFMo1U/Bn3wVM7EP3Es0QpyNl8PYr91nnHJU6NLNxoXm3BProlfbbDtvU1wJZGyOLBhHbCaCDjmRnEZto17xktsof2D/8EvWxy7ArErW7hQrXsUZijc05Q+JWjGJlyxAeMOYUKfoVlQlp+caYUsRRxBY6UlTRV+cz/skhCuxv50YkFDHtcg271+xYM6nw8qxXD/KWt4YgP4bjzCHWzS49JlJiZFAAYD2peDR+WjGuelb2d057mFvYsYfHZLSPV3yb0wcLfBnR61QzjTtZ+Q/okI7vtyKIkATjdT1X31Dufs7gKz7ULar0CjAJljbEejDhYSeOFm+tFzQ9v8GiOc4RR/M6K58nDJv6h6w2Ci7Pn8ISFah8Ljk/nF8435TjtnLpVi+3yzQroMkbW3FIm8CsDw1oLXDS+LFkM69QffetDYNkiyJA1Jy9ilV7gxKIukujPg5CJQTVxey1f7OMZF7pv6wP9B1svsq/AA+a64zTlUXm1wgbHNz+l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(26005)(31686004)(4001150100001)(41300700001)(86362001)(2906002)(38100700002)(5660300002)(36756003)(31696002)(2616005)(4326008)(8676002)(8936002)(478600001)(110136005)(6666004)(6506007)(66574015)(66946007)(66476007)(316002)(66556008)(83380400001)(6512007)(6486002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFFOZjBoUExSTVFhdVdva0hacklyZjhiTi9wQ2V5bkkxVE1xc1ZwZENpcEFl?=
 =?utf-8?B?M3djeTBrS3ZQRXp3NE9ZL1FIUk9RdFZYMUpFT2pNZVRIbmxyVng5RGRON1FJ?=
 =?utf-8?B?RWF1U1FMc0xjN1JvS3cvZW5YTzdlK1VRVGhMVTlqaHBWRVV2UDNHRUFJN1Rr?=
 =?utf-8?B?OUYvVVRmTDlKWWhDZjZQckMxTHVIOUI3aE1PT0VZaEZ2b1I2dzR4WS8yWHIx?=
 =?utf-8?B?RWlyUlpKU04vY3drTDh0UTBURXdJMEpub3ZRMHM2aURUejNlaEVOcXNDZGRY?=
 =?utf-8?B?amp5eDBOa2lNeDBrY09MRW9sZk1CeW1rcVgyc3FYMWh3OXlOL1JNbXJmeVZH?=
 =?utf-8?B?cDVKLytWeGtjdWYyaFU2VzllUUJ0M2hFdFI1ZkR0S29LVmFjSjdZSjNmSU9Z?=
 =?utf-8?B?ZHRwcmh0L2d2U2pHMlo5S3g0SkhkRUVoazdCbFdEd3pOU0hIWGtoQVY4NzQv?=
 =?utf-8?B?WXZKbjk5YnNObVUrUk82eE11N085V2prWlhDQmdnVk84bFhVQzZzUzZsZ2J4?=
 =?utf-8?B?YkZkT2VyaDlJdUI2MDJVWUpnUG5VMkNlUlVqSmJGa2hPemVFWWFBQkdHWXlK?=
 =?utf-8?B?RjdHakhTUXNEM0Y3NUllWmJ4MWRJbzZKcGkwRm5zWWxhZzcrMXRjcGQyL2tk?=
 =?utf-8?B?bjhQU2wzQjlRYkVVM0xDelRNamhoRVNESEdFN1F4L24wZjF6NzFRaW1vQnJF?=
 =?utf-8?B?LzE1M0RXNUREMTBMMWVOVXpldXJycWMvY1crWG9BTS9FaEVlT1l6MVlpdTlK?=
 =?utf-8?B?SzZ3K3FvRDdhbVowVDg0eHhWNFBYRU5mWWorRDJNMTJMUFpISjl3Z0FaeDMz?=
 =?utf-8?B?c2RJdU85ZzFTWmxvVm5aTWI5NTBaTUFWQms5TlU3SXpLUS9wZjRqYmYvZGpz?=
 =?utf-8?B?NHp3VGNmKzdRbXVBeXVNa0hEdVFvV09jWjZlcW13WGloaEpZakZ4UkpHaFQz?=
 =?utf-8?B?QlVxSXcrWHVFd0hPQ2tlUG56dzd5bDI2MU1aaDNZSUdoVlp5SFZkV1hjVnRi?=
 =?utf-8?B?cWhRclA4ZXV5MHlIQ1FGNnkrRmhMZ0Ixb1pHeGIvdHAvSE9maEhWSkc1L1JY?=
 =?utf-8?B?TEVXK0w0a01TQlVWYldEaFZ4cGtBMTFuUXBKSEMvalhtMk9kMFpMZUFmeG9p?=
 =?utf-8?B?VGYxeVdvaE9qVGtERUlqY3JMb3RSdENJSlJGZkR0UGxTUjdhMmp6L1FPTkZ0?=
 =?utf-8?B?OE10Tk9WQ0dQTGwvSTcwd2ZuMHpteEI5OFJvMFdhUzNDNnltZHU2RStBWVFN?=
 =?utf-8?B?NlVmdDdOTVFhWFM0a1U3MEgzNnBMSmVQeEpHM0JiMUpFcG4zRUVIWDVoNmx3?=
 =?utf-8?B?U3BJNjArTXhSMXppaDNteTRxVENkanB1MnFENmhJazd2S2RpUGJ2cUkyQzdW?=
 =?utf-8?B?eStseWlTbnlLRnpYRlYvcTJJeW5zVFVnTUpvQ0s1SWlCdUdONS9BQjJ4OFZl?=
 =?utf-8?B?S21xcHlMR3R5ZFYzcXp5MEkzVnA1VGNKc09Oa2V0bzB5UzZmZzFGTDRudTA0?=
 =?utf-8?B?NjRTbUFIR2FiQm1OSlM2ajFQc2lmN0JpRVdBV3pnTE1TRnhwWlBsdHpwaXda?=
 =?utf-8?B?SDR5d1NxQ3kvWW42eDJERmxjVXVDcjFkaDRpWkxRRldWTnZlM1NDV0g5ZFBD?=
 =?utf-8?B?NW51bTYrZ0xORXR5b3A4T2lCaHZWZFlDWnNHRnRPUzVVUGJjZUxIcGdGTzk5?=
 =?utf-8?B?QkxrMmlpTldIMjU1L1lRaGRvT0V3TWs1M01weUNsU1lKL1JPUU1pVGJNWUxN?=
 =?utf-8?B?M2NlekxwL1pUN09aT2tGYVJWZ0FDTnNic2NEUXdXSnNwcHIxbzJBNzNPMlg4?=
 =?utf-8?B?cFF5dFAwQVpVYjJzTWx3L09Hd3F2M2ZLTWk2L0kzV1greFE5TkliZmkvUmhL?=
 =?utf-8?B?VzFuK0NjQThCOUhIN20zRGtyNVNQVEN5c3puZDIxa0lWcmNGZ1pOS1FkUkIx?=
 =?utf-8?B?WXFtRlpSczgxVithVk1qdGdQNENmd2hieTF4N1ppN1ZHcWlidTdGSytzYjRh?=
 =?utf-8?B?OTU2d2VZNXdESlR2dWpHU2M3cC9sUytyT0RRY0NpQjJwTWVZNGpWZ29ROEs2?=
 =?utf-8?B?QVg0OFA3c1BLWXZGaDVzZ09JenUvTUQxQTFRVzFXb2VvOUl3bjQ4ZGhVR1lU?=
 =?utf-8?Q?8Xj8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e66deb3-b9e2-4a69-7123-08dbd6c2567d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:57:16.8362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFbcOSoQrGErCFm8pp6H9L96ev8dRo5WmVelYTRa65x0eUvGP7iJIjriF+sr0the
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6859
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/27 18:22, Holger Hoffstätte wrote:
> On 2023-10-27 09:00, Qu Wenruo wrote:
>>
>>
>> On 2023/10/27 17:25, Holger Hoffstätte wrote:
>>> On 2023-10-26 23:01, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2023/10/27 00:30, Holger Hoffstätte wrote:
>>>>> On 2023-10-26 15:31, Sam James wrote:
>>>>>> 'btrfs: scrub: fix grouping of read IO' seems to intorduce a
>>>>>> -Wmaybe-uninitialized warning (which becomes fatal with the kernel's
>>>>>> passed -Werror=...) with 6.5.9:
>>>>>>
>>>>>> ```
>>>>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c: In function ‘scrub_simple_mirror.isra’:
>>>>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2075:29: error: ‘found_logical’ may be used uninitialized [-Werror=maybe-uninitialized[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized]]
>>>>>>   2075 |                 cur_logical = found_logical +
>>>>>> BTRFS_STRIPE_LEN;
>>>>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2040:21: note: ‘found_logical’ was declared here
>>>>>>   2040 |                 u64 found_logical;
>>>>>>        |                     ^~~~~~~~~~~~~
>>>>>> ```
>>>>>
>>>>> Good find! found_logical is passed by reference to
>>>>> queue_scrub_stripe(..) (inlined)
>>>>> where it is used without ever being set:
>>>>>
>>>>> ...
>>>>>      /* Either >0 as no more extents or <0 for error. */
>>>>>      if (ret)
>>>>>          return ret;
>>>>>      if (found_logical_ret)
>>>>>          *found_logical_ret = stripe->logical;
>>>>>      sctx->cur_stripe++;
>>>>> ...
>>>>>
>>>>> Something is missing here, and somehow I don't think it's just the
>>>>> top-level
>>>>> initialisation of found_logical.
>>>>
>>>> This looks like a false alert for me.
>>>>
>>>> @found_logical is intentionally uninitialized to catch any
>>>> uninitialized usage by compiler.
>>>>
>>>> It would be set by queue_scrub_stripe() when there is any stripe found.
>>>
>>> Can you show me where the reference is set before the quoted if block?
>>
>> Sure.
>>
>> Firstly inside queue_scrub_stripe():
>>
>> ```
>>          ret = scrub_find_fill_first_stripe(bg, &sctx->extent_path,
>>                                             &sctx->csum_path, dev, 
>> physical,
>>                                             mirror_num, logical, length,
>> stripe);
>>          /* Either >0 as no more extents or <0 for error. */
>>          if (ret)
>>                  return ret;
>>          if (found_logical_ret)
>>                  *found_logical_ret = stripe->logical;
>> ```
>>
>> In this case, we would only set @found_logical_ret to the found stripe's
>> logical.
>>
>> Either we got ret > 0, meaning no more extent in the chunk, or we got
>> some critical error.
>>
>> Then back to scrub_simple_mirrors():
> 
> I think I now understand the comment. This is a terrible foot gun, and 
> in fact
> shows that this is not a false alert at all.
> 
> Within queue_scrub_stripe() you are "possibly" using (checking) a 
> reference that
> has not been initialized, neither in the caller nor within 
> queue_scrub_stripe().
> To the compiler this reference may not exist yet (even if we know that 
> it is on
> the stack..) and point to la-la land. The fact that the logic depends on 
> ret
> always being != 0 is not visible to the compiler, so the warning is 
> completely
> correct: 0 is a valid possible value for ret, so this potentially allows 
> the
> uninitialized read to happen.
> 
> What happens after that is not the point. You cannot safely check an 
> uninitialized
> reference, even when the control flow "cannot happen" due to a data 
> dependency.
> 
> It seems to me the safest way forward is to simply initialize 
> found_logical in the
> parent and remove the "if (found_logical_ret)" check, since it does 
> nothing useful.
> Would that work?
> 

Sure, that sounds pretty reasonable.

The "if (found_logical_ret)" is totally duplicated, if following the 
regular btrfs way, I'd convert it to an "ASSERT(found_logical_ret);" at 
the beginning of the function queue_scrub_stripe().

In that case, I'm totally fine to submit a patch to fix this warning.

Thanks for the report,
Qu

> thanks,
> Holger
